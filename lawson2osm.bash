#/bin/bash

# 
cat tenpomaster-20130814.csv| nkf |awk -F, '{cmd="echo "$11"|sed -e s/ー/-/g -e s/　*$//g -e s/・/\\ /g| nkf -eZ|kakasi -Ha"; cmd | getline t; close(cmd); cmd2="echo "$17"|sed s/^0/+81-/g"; cmd2|getline p; close(cmd2);printf("%s,%s,%s\n", $0,t,p);}'
