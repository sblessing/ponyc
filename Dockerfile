FROM ponylang/ponyc-ci-docker-image-base:20191006

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys "47E4F8DEE04F0923" \
 && add-apt-repository "deb https://dl.bintray.com/pony-language/ponylang-debian  $(lsb_release -cs) main" \
 && apt-get update \
 && apt-get install -y pony-stable

WORKDIR /src/ponyc
COPY .git /src/ponyc/.git
COPY .gitmodules /src/ponyc/
COPY Makefile Makefile-ponyc Makefile-lib-llvm LICENSE VERSION /src/ponyc/
COPY benchmark /src/ponyc/benchmark
COPY src      /src/ponyc/src
COPY lib      /src/ponyc/lib
COPY test     /src/ponyc/test
COPY packages /src/ponyc/packages

RUN make arch=x86-64 tune=intel default_pic=true -f Makefile-lib-llvm use=llvm_link_static -j3 \
 && make -f Makefile-lib-llvm install \
 && rm -rf /src/ponyc

WORKDIR /src/main

CMD ponyc
