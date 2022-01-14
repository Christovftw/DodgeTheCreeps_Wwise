set filetype=.gdns
git lfs untrack *%filetype%
git rm --cached *%filetype%
git add *%filetype%
git commit -m "restore %filetype% to git from lfs"
git push