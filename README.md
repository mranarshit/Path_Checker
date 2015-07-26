# Path_Checker
Path checker ultrafast with fork and with a great idea to check existince of file 

TOOL DISCRIPTION
===============
```
Search files or dirs on websites!
Features : 
 * Ultra fast using Parallel::ForkManager module
 * 3 method of check file 
 * Saving result 
 * Single check 
Method : 
Check existing of path using 3 steps : 
 1. By response code = 200
 2. Comparing length of source page of 2 url first which contain the path and second a notfound path 
 3. Using a Keyward exist in notfound page if the keyward not exist in the real path so path is true 
```

TO RUN THE SCRIPT
----
```
LWP::UserAgent              Any Version
Parallel::ForkManager       Enabled
  * install : install parallel::forkmanager module sudo apt-get install libparallel-forkmanager-perl
  * or cpan Parallel::ForkManager
 Command to use [Usage] : 
  * perl name_tool.pl -u site.com -f path.txt -w keyward -t 3
  --u : the url to test 
  --f : file of paths
  --w : keyward in notfound page 
  --t : number of fork (for fast check)
```

ABOUT DEVELOPER
----
```
Author            Mr_AnarShi-T (M-A)
Email             w-98@live.com
Home              Janissaries.org
Pastebin          http://pastebin.com/u/m-a
Github            https://github.com/mranarshit/
```

Screenshot
----
![images](https://lh3.googleusercontent.com/-DlWW_Yy_qEM/VbKpfwUB07I/AAAAAAAAAQA/nwaF5Kqm7E8/s912-Ic42/ccccc.jpg)
