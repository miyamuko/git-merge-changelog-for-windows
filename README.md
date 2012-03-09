# git-merge-changelog for Windows

## DOWNLOAD

<https://github.com/downloads/miyamuko/git-merge-changelog-for-windows/git-merge-changelog.exe>


## USAGE

  1. Add following entry to your ~/.gitconfig.

        [merge "merge-changelog"]
                name = GNU-style ChangeLog merge driver
                driver = /path/to/git-merge-changelog.exe %O %A %B

  2. Set [merge strategies](http://progit.org/book/ch7-2.html#merge_strategies)
     for each changelog files.

         ChangeLog      merge=merge-changelog
         ChangeLog.txt  merge=merge-changelog


## BUILD

  1. Install MinGW/msys
  2. Try:

         git clone https://github.com/miyamuko/git-merge-changelog-for-windows.git
         cd git-merge-changelog-for-windows
         sh build-git-merge-changelog-exe.sh
