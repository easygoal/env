#!/bin/sh - 
# run python from users path \
"exec" "python" "$0" "$@"

import os.path
import re

class Node(object):

    def __init__(self, name):
        self._name = name
        self._children = {}

    def add_child(self, name, node):
        self._children[name] = node

    def get_child(self, name):
        try:
            c = self._children[name]
        except KeyError:
            print self._children
            print name
            exit(0)
        else:
            return c

    def myname(self):
        return self._name

class VerilogFilelist(Node):

    def __init__(self, path):
        self._pwd  = self._normalize_pwd(path)
        self._path = self._normalize_path(path)
        self.parsed_contents = []

        super(VerilogFilelist, self).__init__(path)       

        self._parse()

    def _parse(self):

        print "Parsing: %s" % self._pwd

        # Read File list
        try:
            flist_FR = open(self._path, 'r')
        except IOError:
            raise Exception(
                    """
                    File list <%s> is unreadable.
                    Nested file list found in [%s]
                    """ % (self._path, self.myname())
                )
        else:
            filelist_contents = flist_FR.readlines()

        # Parse contents
        for line in filelist_contents:
            # Expand env variables
            line = os.path.expandvars(line)

            if re.match(r'\s*\/\/', line):
                self.parsed_contents.append(line)

            elif re.match(r'\s*-f\s+.+?\.f', line):

                path = re.match(r'\s*-f\s+(.+?\.f)', line).group(1)

                print "Found %s" % path

                path = self._normalize_path(path)

                child_flist = VerilogFilelist(path)

                self.add_child(child_flist.myname(), child_flist)

                marker = self._get_marker(path)

                self.parsed_contents.append(marker)

            else:
                self.parsed_contents.append(line)

    def _normalize_path(self, path):

       # Expand env variables
       expanded_path = os.path.expandvars(path)
       # Expand symbolic links
       expanded_path = os.path.realpath(expanded_path)

       return expanded_path
    
    def _normalize_pwd(self, path):
        abspath = os.path.abspath(path)
        expanded_pwd = os.path.dirname(abspath)
        return expanded_pwd

    def _get_marker(self, path):
       return "// FLIST %s//" % path

    def flatten(self):
        flattened_content = []

        # Check if any filelists nested else return the list of all file list lines
        if not re.search(r"// FLIST", "".join(self.parsed_contents), re.DOTALL):
            return self.parsed_contents

        # Search lines for file lists, this is done
        # linewise as to keep the order in which the 
        # filelist is specified.
        for line in self.parsed_contents:

            # Search for flist
            match = re.match(r"// FLIST (.+?)//", line)

            if match:
                # Get flist path
                flist = match.group(1)

                # Get flist contents and add it to parent flist
                for line in self.get_child(flist).flatten():
                    # Add lines to content
                    flattened_content.append(line)

            else:
                flattened_content.append(line)

        return flattened_content

    def get_content(self, hide_dupe, only_src_files, priority_regex, expand_paths):

        # Get content
        content_list = self.flatten()

        # Hide filelist options 
        if only_src_files:
            content_list = self._get_paths(
                content_list=content_list
            )

        # give priority to paths
        if only_src_files and priority_regex:
            content_list = self._give_priority(
                content_list=content_list,
                priority_regex=priority_regex
            )
        elif priority_regex:
            print "Priority can be given only when --only_src_files option is given."

        # remove duplicate module references
        if only_src_files and hide_dupe:
            content_list = self._remove_duplicates(
                content_list=content_list
            )
        elif hide_dupe:
            print "Duplicates can be hid only when --only_src_files option is given."

        # give priority to paths
        #if only_src_files and expand_paths:
        if expand_paths:
            content_list = self._expand_paths(
                content_list=content_list
            )
        elif expand_paths:
            print "Path expansion can be performed only when --only_src_files option is given."

        return "".join(content_list)

    def generate_output(self, hide_dupe=False, only_src_files=False, priority_regex=[], expand_paths=False, outfile=None):

        if not outfile:
            #outfile = "flat_%s" % self._path
            outfile = "%s/proj.f" % self._pwd

        content = self.get_content(hide_dupe, only_src_files, priority_regex, expand_paths)

        try:
            output_filelist = open('proj.f', 'w')
        except IOError:
            print "Error writing out file."
        else:
            output_filelist.write(content)
            print "Successfuly wrote out file %s" % outfile
            output_filelist.close()

    def _get_paths(self, content_list):

        expected_path_options = {
                'v_lib'      : r'\s*-v\s+(.+\.v)',
                'sv_lib'     : r'\s*-v\s+(.+\.sv)',
                'v_src'      : r'\s*(.+\.v)',
                'sv_src'     : r'\s*(.+\.sv)',
                'define_str' : r'\s*+define+($.+)',
                'incdir_str' : r'\s*+incdir+($.+)',
        }

        path_list = []

        for line in content_list:
            
            for match_type in ('v_lib', 'sv_lib', 'v_src', 'sv_src' ):

                path_re = expected_path_options[match_type]
                
                if not re.match(r'\s*\/\/', line) and re.match(path_re, line):

                    path = re.sub(path_re, r'\1', line)

                    path_list.append(path)
                    break

        return path_list          
            
    def _remove_duplicates(self, content_list):

        uniq_list = []
        module_names = []
        
        modified_content_list = [re.sub(r'\${(\w+)}', r'$\1', l) for l in content_list]


        for line in modified_content_list:

            if ((line in uniq_list) or (os.path.basename(line) in module_names)) and not re.match(r'\s*\n\s*', line):
                #uniq_list.append("//DUPE//%s" % line)
                print 'Found duplicate: %s' % line.rstrip()
            else:
                uniq_list.append(line)
                module_names.append(os.path.basename(line))

        return uniq_list

    def _give_priority(self, content_list, priority_regex):

        priority_file_list = []

        for p_re in priority_regex:
            priority_file_list += [f for f in content_list if re.search(re.escape(p_re), f)]

        priority_file_names = [os.path.basename(f) for f in priority_file_list]

        modified_list = []

        for line in content_list:

            if (os.path.basename(line) in priority_file_names) and (line not in priority_file_list):
                print 'Found duplicate: %s' % line.rstrip()
            else:
                modified_list.append(line)

        return modified_list   

    def _expand_paths(self, content_list):

        local_content_list = []

        for line in content_list:

            # Expand env variables. 
            line = os.path.expandvars(line)
            # Substitute symbolic links
            line = os.path.realpath(line)

            local_content_list.append(line)

        return local_content_list


if __name__ == '__main__':
    import sys
    import argparse 

    class Extender(argparse.Action):
        def __call__(self,parser,namespace,values,option_strings=None):
            #Need None here incase `argparse.SUPPRESS` was supplied for `dest`
            dest = getattr(namespace,self.dest,None) 
            #print dest,self.default,values,option_strings
            if(not hasattr(dest,'extend') or dest == self.default):
                dest = []
                setattr(namespace,self.dest,dest)
                #if default isn't set to None, this method might be called
                # with the default as `values` for other arguements which
                # share this destination.
                parser.set_defaults(**{self.dest:None}) 
    
            try:
                dest.extend(values)
            except ValueError:
                dest.append(values)

    parser = argparse.ArgumentParser(description='Flatten Verilog Filelist.')
    parser.add_argument("--infile", help="Flatten filelist at specified path.")
    parser.add_argument("--outfile", help="Generate filelist at output path.")
    parser.add_argument("--hide_dupe", help="Remove duplicate paths.", action="store_true")
    parser.add_argument("--only_src_files", help="Remove file list options.", action="store_true")
    parser.add_argument("--priority_regex", help="Give priority to duplicate modules.", nargs='*', action=Extender)
    parser.add_argument("--expand_paths", help="Expand env variables and symbolic links.", action="store_true")
    
    args = parser.parse_args()

    if (len(sys.argv) == 1):
        print """
            Please enter the filelist path as argument.
            Use "-h" for help.
            Usage: %s [-h] <filelist path>
        """ % sys.argv[0]
        sys.exit(1)

    VF = VerilogFilelist(args.infile)
    VF.generate_output(
            hide_dupe=args.hide_dupe,
            only_src_files=args.only_src_files,
            priority_regex=args.priority_regex,
            expand_paths=args.expand_paths,
            outfile=args.outfile
    )

