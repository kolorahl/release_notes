# Release Notes

I wrote a small Ruby script that generates simple release notes from a pair
of git commits. All it does is spit out a list of git commit summaries sorted
by author and a complete list of all files that have been added, modified, or
deleted between the two versions.

## Using it

Pretty simple.

    ruby release_notes.rb commit1 commit2

Note that `commit1` and `commit2` can be any git-recognized commit identifier,
meaning you can use branch names, raw commit hashes, tags, and so on.

## Contirbuting

I could see this becoming a little more complex in the future. Right now it's
just a script but it could eventually become a gem. I could see it potentially
allowing for custom templates where the main power lay just in parsing various
git output into friendly Ruby data structures for manipulation.

But that's all future-thinking for now.
