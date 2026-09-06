Setup

- bundle install
- bundle exec jekyll serve
- copy jasper-pages to github pages

version issues with plugins?
- delete the gemfile

bundle issues?
- bundle update --bundler

analytics account under ramzi@bytebytebyte.com
- analytics can be changed under config.xml


Adding a post

go to _posts in jasper_master and create a new post

add any images to assets/images/postname

bundle exec jekyll serve
copy jasper-pages to master


Docker

The jasper-master site uses an old Jekyll/Ruby stack that no longer installs
cleanly on modern machines, so a Dockerfile is provided to build/serve it in
a container instead.

Build the image:
- docker build -t wizardofwhimsy-jekyll .

Generate the site (writes into ./_site):
- docker run --rm -v "$(pwd)/_site:/site/_site" wizardofwhimsy-jekyll

Serve it locally with live reload at http://localhost:4000 (also mount the
source so edits to jasper-master/_posts are picked up):
- docker run --rm -p 4000:4000 -v "$(pwd)/jasper-master:/site" wizardofwhimsy-jekyll bundle exec jekyll serve --host 0.0.0.0 --destination /site/_site

