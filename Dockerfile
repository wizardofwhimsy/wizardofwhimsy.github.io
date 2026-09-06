# Builds the Jekyll blog (jasper-master) with the old Ruby/Jekyll stack
# it was originally written against, so post generation works without
# fighting modern Ruby/toolchain incompatibilities on the host machine.
FROM ruby:2.3.8

# Debian stretch is EOL and moved to the archive; repoint apt there.
RUN sed -i -e 's/deb.debian.org/archive.debian.org/g' \
           -e 's/httpredir.debian.org/archive.debian.org/g' \
           -e '/security.debian.org/d' \
           -e '/-updates/d' \
           /etc/apt/sources.list

# python2 provides `pygmentize`, needed by the pygments.rb gem at build time.
# --allow-unauthenticated: the archive's signing key has expired.
RUN apt-get update -o Acquire::Check-Valid-Until=false && \
    apt-get install -y --no-install-recommends --allow-unauthenticated python2.7 python-pip && \
    ln -sf /usr/bin/python2.7 /usr/bin/python && \
    pip install Pygments==2.5.2 && \
    rm -rf /var/lib/apt/lists/*

# The rubygems/bundler shipped with this ruby image are old enough that
# `bundle install` can misresolve transitive deps; upgrading both keeps
# dependency resolution well-behaved.
RUN gem update --system 2.7.10 && gem install bundler -v 1.17.3

WORKDIR /site

COPY jasper-master/Gemfile ./
RUN bundle install

COPY jasper-master/ ./

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "build", "--destination", "/site/_site"]
