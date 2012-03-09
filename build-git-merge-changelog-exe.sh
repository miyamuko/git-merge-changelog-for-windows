./gnulib-tool --create-testdir --dir=build git-merge-changelog
cd build
./configure && make
cd ..
cp build/gllib/git-merge-changelog.exe .
strip git-merge-changelog.exe
