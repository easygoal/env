-
# run python from users path  \
"exec" "python" "$0" "$@"

#----------------------------------------------------------------------------
# Purpose: Scans the a vc file and replaces any ${xxx} variables with their
#          -           current values and modifies relative paths to make them relative
#          -           to the current location.
#          -
#
#----------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Module imports
#-------------------------------------------------------------------------------

# From the standard library
from sys import path as pypath
from sys import exit, argv, version_info, platform
from types import ModuleType
from re import match, sub, search
from time import localtime, sleep, time
from datetime import date
from glob import glob
from optparse import OptionParser
from copy import copy, deepcopy
import os, sys, traceback

def hier_vc(vcfilepath):
  vc_dir = os.path.expandvars(vcfilepath)
  vc_dir = os.path.dirname(vc_dir)
  if (vc_dir == ""):
    vc_dir = "."

  plain_vcfilepath = vcfilepath
  print("[INFO]: Expand commands from -f %s\n" % (plain_vcfilepath))
  out_file.write("// Expand commands from -f %s\n" % (plain_vcfilepath))

  vcfilepath = os.path.expandvars(vcfilepath)
  ## remove unused spaces
  #vcfilepath = vcfilepath.strip()

  # Open in input file.
  try:
    vcin_file = open(vcfilepath, 'r')
  except Exception:
    print("[ERROR]: Failed to open the vc file '%s'" % (vcfilepath))
    exit(1)

  for line in vcin_file:
    # # remove leading and trailing spaces
    # line = line.strip()

    if (options.relative == True):
      line = replace_line(vc_dir, line)

    m = match(r"^\s*\-f\s+(.*)", line.strip())
    if m is not None:
      hier_vc(m.group(1))
    else:
      line = replace_line("", line.lstrip())
      out_file.write(line)

  out_file.write("// End of commands from -f %s\n\n" % (plain_vcfilepath))
  print("[INFO]: End of commands from -f %s\n\n" % (plain_vcfilepath))

def replace_line(path, line):
  result = line

  # Preserve spacing in the file.
  m = match(r"^\s*$", line)
  if m is not None:
    return result

  # Replace every instance of ${xxx} with the current setting
  line = os.path.expandvars(line)

  # Check that the line doesn't start with a / (absolute path or comment).
  m = match(r"^\s*(\/\/|\+define\+|\+libext\+)", line)
  if m is None:
    m = match(r"^((\+incdir\+|-y\s+|-v\s+|-f\s+))?(\S*)\s*$", line)
    if m is not None:
      prefix = m.group(2)
      file = m.group(3)

      if prefix is None:
        prefix = ""

      m = match(r"^[^\/~\$]\S*", file)
      if m is not None:
        file = "%s/%s" % (path, file)
      file = os.path.realpath(file)

      if file is not None:
        result = "%s%s\n" % (prefix, file)
      else:
        result = "\n"
  else:
    result = line

  return result

#-------------------------------------------------------------------------------
# Main body of code
#-------------------------------------------------------------------------------
if __name__ == "__main__":

  exit_code = 0

  # Create the parser.
  parser = OptionParser(version="%prog 1.0")

  # Setup the options/arguements than can be passed in to the script.
  parser.add_option("-i", "--infile",
                    action="store", dest="infile",
                    help="the input vc file")
  parser.add_option("-o", "--outfile",
                    action="store", dest="outfile",
                    help="the output vc file")
  parser.add_option("--debug",
                    action="store_true", dest="debug", default=False,
                    help="display debugging information")
  parser.add_option("--relative",
                    action="store_true", dest="relative", default=False,
                    help="use relatvie path in input")

  (options, args) = parser.parse_args()

  # Make file required.
  if (options.infile == None):
    parser.error("Input filename is required.")

  if (options.outfile == None):
    parser.error("Output filename is required.")

  # Open in input file.
  try:
    in_file = open(options.infile, 'r')
  except Exception:
    print("[ERROR]: Failed to open the file '%s'" % (options.infile))
    exit(1)

  # Open the output file.
  try:
    out_file = open(options.outfile, 'w')
  except Exception:
    print("[ERROR]: Failed to open the file '%s'" % (options.outfile))
    exit(1)

  # Get directory part of the input file.
  in_dir = os.path.dirname(options.infile)
  if (in_dir == ""):
    in_dir = "."

  # Go through each line in the input file.
  for line in in_file:
    if (options.relative == True):
      line = replace_line(in_dir, line)

    m = match(r"^\s*\-f\s+(.*)", line)
    if m is not None:
      hier_vc(m.group(1))
    else:
      line=os.path.expandvars(line)
      out_file.write(line)

  in_file.close()
  out_file.close()

  # Remove duplicate lines
  f = open(options.outfile, 'r')
  ListOfLine = f.read().splitlines()
  l2 = sorted(set(ListOfLine), key=ListOfLine.index)
  f.close()
  f = open(options.outfile, 'w')
  f.write('\n'.join(l2))
  f.close()

