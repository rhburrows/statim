# statim - A quick and easy almost-wiki

statim is a shell script for generating static websites with wiki-like
links from a source directory. Statim is designed so that it has minimal
dependencies at runtime.

## Why another static site generator?

I wanted a super simple site generator that could be set up to
generate my site every time I push to a git repository. In this can I
can set up a hook that will run whenever the repository updates that
will process the content directory and put it in my publicly served
directory.

I also wanted it to run with *very* minimal dependencies. I don't want
to have to worry about if Ruby or Perl are installed, and which
versions of which libraries are available. I just want things to work.

Finally, I did it because it was simple and fun.

## How it works

Put the `statim.sh` script in the a directory that also holds a
`content` directory with the source of the website to generate. Then
run it.

    statim.sh $DIST_DIR

This will copy the files from `content` over to `$DIST_DIR`. It will
also convert any markdown files (identified by files ending in `.md`
or `.markdown` to html and add *some* wiki-style links.

The links are only generated between files in the same sub
directory. Statim will look at each file, convert its name from an
underscored version (i.e. `some_file_name`) to a camel cased version
(i.e. `SomeFileName`) and then switch any occurences of that string
within the same directory to a link to the generated HTML file. This
happens both on markdown files that have been converted to HTML, and
to HTML files that you add to content yourself. Be careful not to add
links yourself that might cause statim to double-generate them (its
not that smart yet).

## Development

Statim doesn't follow the same policy on dependencies when it comes to
development. There are rake tasks that (obviously) require ruby and
the `:autotest` task currently requires `filewatcher` and `growl`.

### TODO

- Remove the hardcoded markdown command and search multiple options to
  make the dependency list more forgiving.
- Test on a system other than a Mac.
