#!/usr/bin/python
import sys
import re

def load_file(filename):
  file = open(filename)
  text = file.read()
  file.close()
  return text

def save_to_file (pass_flag):
  if pass_flag:
    f = open('pass.txt', 'w')
  else:
    f = open('fail.txt', 'w')
  f.close

def passed_test (text):
  criteria_list = re.findall ('.*Per base sequence quality.*|.*Per sequence quality scores.*|.*Overrepresented sequences.*', text)
  if len(criteria_list) > 0:
    fail_match = re.search ('FAIL', '_'.join(criteria_list))
    if fail_match:
      return False
    else:
      return True
  else:
    return False

def main():
  args = sys.argv[1:]

  if not args:
    print 'usage: File'
    sys.exit(1)

  text = load_file (args[0])
  if passed_test (text):
    save_to_file (True)
  else:
    save_to_file (False)


if __name__ == '__main__':
  main()
