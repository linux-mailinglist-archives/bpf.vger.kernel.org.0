Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75752487D96
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 21:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiAGUSz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 15:18:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37584 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiAGUSy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 15:18:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46339B82717;
        Fri,  7 Jan 2022 20:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6C4C36AE0;
        Fri,  7 Jan 2022 20:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641586732;
        bh=v/Tg4aq50apQyvZdr+2K2Qm4SbltNs4WO8DPGZ1/iig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJTrzqnsnRSU45B3q/IewaKfqxWfpTbB6H/8S18YbiLoGTSlSVGiuIJl9ywu8STQS
         f88vuOD3E6o0O3Md7iSBPQvwHSCthj/zhkjivuuU6YVy5R1TuoPs84OLTlVwJlBt+W
         CMC8PJQWiqCL+1loghFJ9BLkkPKzo3eiUysQltGXvZZ2ufVvuMilB963urJr1kLTR8
         TwD4suGgMLVFr+WEnEON9pLBZlF9R8DEmNfduU+3VQODt1XEjPrmHHfDAUvpmAYVeK
         Wb9036gEsJ0eXqPns29zIj+lCbyL3IX9PGuy7kOytQGjbBYri5bv09mckgCNaFIyuy
         2ctDsgNLZV5Vg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1809C40B92; Fri,  7 Jan 2022 17:18:49 -0300 (-03)
Date:   Fri, 7 Jan 2022 17:18:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: perf build broken seemingly due to libbpf changes, checking...
Message-ID: <YdigKX55J1y5xUiZ@kernel.org>
References: <YddEVgNKBJiqcV6Y@kernel.org>
 <YddGjjmlMZzxUZbN@kernel.org>
 <YddHmYhvtVvgqZb/@kernel.org>
 <CAP-5=fU2QAr9BMHqm9i6uDKPaUFsY2EAqt+oO1AO8ovBXCh5xQ@mail.gmail.com>
 <CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=hq657buqe2_yRKxaK-A@mail.gmail.com>
 <CAP-5=fUN+XqrSmwqab9DyGtvpZ7iZkfnUNwBfK1CDA_iX+aF0Q@mail.gmail.com>
 <CAP-5=fVE5eo9TSX3rrGb-=DETeYvXtG0AqhpGwjnP6nr8pKrqg@mail.gmail.com>
 <YdiHSF6CGBoswQ1G@kernel.org>
 <CAP-5=fX4-kmkm+qn9m22O_4A2_8j=uAm=vcXh9x2RqqDKEdnBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX4-kmkm+qn9m22O_4A2_8j=uAm=vcXh9x2RqqDKEdnBg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jan 07, 2022 at 11:26:50AM -0800, Ian Rogers escreveu:
> On Fri, Jan 7, 2022 at 10:32 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Thu, Jan 06, 2022 at 07:30:34PM -0800, Ian Rogers escreveu:
> > > On Thu, Jan 6, 2022 at 2:04 PM Ian Rogers <irogers@google.com> wrote:
> > > > On Thu, Jan 6, 2022 at 1:44 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > > On Thu, Jan 6, 2022 at 1:42 PM Ian Rogers <irogers@google.com> wrote:
> > > So tools/lib also provides subcmd, symbol and api. These will need
> > > Makefiles to allow an install and likely the header file structure
> > > altering. This seems like too big a fix for the next 5.16rc, wdyt?

> > Right, I think the best thing is to revert the patch Jiri pointed out,
> > right?
 
> Your call. There is a latent bug that with LIBTRACEEVENT_DYNAMIC we
> are using tools/lib/traceevent header files. Reverting the change
> means we don't break because of this, but it means that people
> building with LIBTRACEEVENT_DYNAMIC and newer libtraceevent (at least
> my employer :-) ) lose logging. I can carry the change locally, so not
> a big loss :-)

Just for a while, we should get this fixed for v5.17, for v5.16 a revert
is required :-\

> There are a few issues stemming from this:
> 1) we've identified the current build is wrong for xxx_DYNAMIC options
> as tools/lib versions headers always override

yeap

> 2) to address this we should make the tools/lib things proper
> libraries like libbpf, libtraceevent, etc.

yeap

> 3) once we have proper libraries, we need to update the perf build to
> build non-dynamic libraries then depend on the built/installed header
> files

yeap
 
> I expect at least some of this is going to break when testing on many
> distributions as that just seems to be what always happens, and
> changing the build in this significant way is going to have
> implications. Doing this means that the code base is in better shape
> and logging works.

Right, its nice that I have a mechanism to test build in 80+ distro
versions/cross-build environments. :-)

> To counter some of the many distribution pain, do
> you have a way to reproduce your testing? My OpenSuSE recipe is:

So I'm adding this:

[perfbuilder@five tumbleweed]$ git diff rx_and_build.sh
diff --git a/opensuse/tumbleweed/rx_and_build.sh b/opensuse/tumbleweed/rx_and_build.sh
index fbc8845..0510ef1 100755
--- a/opensuse/tumbleweed/rx_and_build.sh
+++ b/opensuse/tumbleweed/rx_and_build.sh
@@ -11,11 +11,19 @@ build_perf_gcc() {
        make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" NO_LIBELF=1 -C tools/perf O=/tmp/build/perf || exit 1
        rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
        make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" NO_LIBBPF=1 -C tools/perf O=/tmp/build/perf || exit 1
+       [ -d /usr/include/traceevent/ ] && \
+       make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" LIBTRACEEVENT_DYNAMIC=1 -C tools/perf O=/tmp/build/perf || exit 1
        set +o xtrace
 }

 build_perf_clang() {
        set -o xtrace
+
+       if [ ! $NO_BUILD_BPF_SKEL ] ; then
+               rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
+               make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" BUILD_BPF_SKEL=1 -C tools/perf O=/tmp/build/perf || exit 1
+       fi
+
        rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
        make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" -C tools/perf O=/tmp/build/perf CC=clang || exit 1
        rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
@@ -26,6 +34,8 @@ build_perf_clang() {
        make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" LIBCLANGLLVM=1 -C tools/perf O=/tmp/build/perf CC=clang || exit 1
        rm -rf /tmp/build/perf ; mkdir /tmp/build/perf
        make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" LIBCLANGLLVM=1 -C tools/perf O=/tmp/build/perf || exit 1
+       [ -d /usr/include/traceevent/ ] && \
+       make $EXTRA_MAKE_ARGS ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE EXTRA_CFLAGS="$EXTRA_CFLAGS" LIBTRACEEVENT_DYNAMIC=1 -C tools/perf O=/tmp/build/perf || exit 1
        set +o xtrace
 }

@@ -48,6 +58,7 @@ TARBALL=`basename $TARBALL_URL`
 xzcat $TARBALL | tar xvf -
 SRCDIR=`echo $TARBALL | sed -r 's/(.*).tar\..*/\1/g'`
 cd /git/$SRCDIR
+echo -n BUILD_TARBALL_HEAD=
 cat HEAD

 # print the version for dm to harvest and put in the status line
[perfbuilder@five tumbleweed]$

And I'll add this to 'make -C tools/perf build-test' too, what I have in
rx_and_build.sh is a limited set of 'build-test', building with it in
all containers take more time, it is possible if one does:

[perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.16.0-rc8.tar.xz
[perfbuilder@five ~]$ export BUILD_CMD='make -C tools/perf build-cmd'
[perfbuilder@five ~]$ dm

Then it will do it for gcc and for clang, takes a while...

My Dockerfile for tumbleweed, btw, is:

[perfbuilder@five tumbleweed]$ cat Dockerfile
# acmel/linux-perf-tools-build-opensuse:tumbleweed
FROM docker.io/opensuse/tumbleweed
MAINTAINER Arnaldo Carvalho de Melo <acme@kernel.org>
# shadow for groupadd
RUN zypper -n update && \
    zypper -n install shadow \
	make gcc gcc-c++ flex bison cpio \
	bc file findutils clang llvm curl tar xz \
	libunwind-devel openssl-devel slang-devel python-devel \
	systemtap-sdt-devel gtk2-devel xz-devel binutils-devel \
	libelf-devel libdw-devel audit-devel libzstd-devel \
	java-1_8_0-openjdk-headless libcap-devel \
	clang-devel llvm-devel perl libnuma-devel \
	libbpf-devel libtraceevent-devel \
	babeltrace-devel OpenCSD-devel cmake xmlto asciidoc && \
    zypper clean --all && \
    mkdir -m 777 -p /git /tmp/build/perf /tmp/build/objtool /tmp/build/linux && \
    groupadd -r perfbuilder && \
    useradd -m -r -g perfbuilder perfbuilder && \
    chown -R perfbuilder.perfbuilder /tmp/build/ /git/
USER perfbuilder
COPY rx_and_build.sh /
COPY .bash_profile /home/perfbuilder/
ENTRYPOINT ["/rx_and_build.sh"]
[perfbuilder@five tumbleweed]$
 
> ```
> # Get the image
> docker pull opensuse/tumbleweed
> # Start it with an interactive bash shell and mounting the current
> directory as /kernel-src
> sudo docker run --privileged -it --net=host --env="DISPLAY" --mount
> type=bind,source="$(pwd)",target=/kernel-src opensuse/tumbleweed
> /bin/bash
> # Install missing rpms
> zypper install make gcc diffutils flex bison kernel-devel findutils
> libelf-devel python3 kernel-kvmsmall-devel glibc-devel
> # Go to /kernel-src and build into /tmp, etc.
> ```
> But finding every distribution, every rpm, etc. is quite laborious.

Yeah, but I did it already for quite a few distros :-)

[perfbuilder@five linux-perf-tools-build]$ find . -name Dockerfile | nl
     1	./alpine/3.10/Dockerfile
     2	./alpine/3.11/Dockerfile
     3	./alpine/3.12/Dockerfile
     4	./alpine/3.13/Dockerfile
     5	./alpine/3.5/Dockerfile
     6	./alpine/3.6/Dockerfile
     7	./alpine/3.7/Dockerfile
     8	./alpine/3.8/Dockerfile
     9	./alpine/3.9/Dockerfile
    10	./alpine/edge/Dockerfile
    11	./alpine/3.14/Dockerfile
    12	./alpine/3.4/Dockerfile
    13	./alpine/3.15/Dockerfile
    14	./alt/p8/Dockerfile
    15	./alt/p9/Dockerfile
    16	./alt/sisyphus/Dockerfile
    17	./alt/p10/Dockerfile
    18	./amazonlinux/1/Dockerfile
    19	./amazonlinux/2/Dockerfile
    20	./android/end-of-life/r22b/arm/Dockerfile
    21	./android/end-of-life/r12b/arm/Dockerfile
    22	./android/end-of-life/r15c/arm/Dockerfile
    23	./archlinux/base/Dockerfile
    24	./centos/8/Dockerfile
    25	./centos/end-of-life/5/Dockerfile
    26	./centos/end-of-life/6/Dockerfile
    27	./centos/end-of-life/7/Dockerfile
    28	./centos/stream/Dockerfile
    29	./clearlinux/latest/Dockerfile
    30	./debian/10/Dockerfile
    31	./debian/9/Dockerfile
    32	./debian/end-of-life/7/Dockerfile
    33	./debian/end-of-life/8/Dockerfile
    34	./debian/experimental/x-arm64/Dockerfile
    35	./debian/experimental/x-mips/Dockerfile
    36	./debian/experimental/x-mips64/Dockerfile
    37	./debian/experimental/x-mipsel/Dockerfile
    38	./debian/experimental/Dockerfile
    39	./debian/11/Dockerfile
    40	./fedora/22/Dockerfile
    41	./fedora/23/Dockerfile
    42	./fedora/24/x-ARC-uClibc/Dockerfile
    43	./fedora/24/Dockerfile
    44	./fedora/25/Dockerfile
    45	./fedora/26/Dockerfile
    46	./fedora/27/Dockerfile
    47	./fedora/28/Dockerfile
    48	./fedora/29/Dockerfile
    49	./fedora/30/Dockerfile
    50	./fedora/31/Dockerfile
    51	./fedora/32/Dockerfile
    52	./fedora/33/Dockerfile
    53	./fedora/34/x-ARC-glibc/Dockerfile
    54	./fedora/34/x-ARC-uClibc/Dockerfile
    55	./fedora/34/Dockerfile
    56	./fedora/end-of-life/21/Dockerfile
    57	./fedora/end-of-life/20/Dockerfile
    58	./fedora/rawhide/Dockerfile
    59	./fedora/35/Dockerfile
    60	./gentoo/end-of-life/stage3-amd64/Dockerfile
    61	./gentoo/stage3/Dockerfile
    62	./mageia/5/Dockerfile
    63	./mageia/6/Dockerfile
    64	./mageia/7/Dockerfile
    65	./mageia/8/Dockerfile
    66	./manjaro/base/Dockerfile
    67	./openmandriva/cooker/Dockerfile
    68	./opensuse/15.0/Dockerfile
    69	./opensuse/15.1/Dockerfile
    70	./opensuse/15.2/Dockerfile
    71	./opensuse/15.3/Dockerfile
    72	./opensuse/end-of-life/13.2/Dockerfile
    73	./opensuse/end-of-life/42.1/Dockerfile
    74	./opensuse/end-of-life/42.2/Dockerfile
    75	./opensuse/end-of-life/42.3/Dockerfile
    76	./opensuse/tumbleweed/Dockerfile
    77	./opensuse/15.4/Dockerfile
    78	./oraclelinux/8/Dockerfile
    79	./oraclelinux/end-of-life/6/Dockerfile
    80	./oraclelinux/end-of-life/7/Dockerfile
    81	./rhel7/Dockerfile
    82	./ubuntu/16.04/x-arm/Dockerfile
    83	./ubuntu/16.04/x-arm64/Dockerfile
    84	./ubuntu/16.04/x-powerpc/Dockerfile
    85	./ubuntu/16.04/x-powerpc64/Dockerfile
    86	./ubuntu/16.04/x-powerpc64el/Dockerfile
    87	./ubuntu/16.04/x-s390/Dockerfile
    88	./ubuntu/16.04/Dockerfile
    89	./ubuntu/18.04/x-arm/Dockerfile
    90	./ubuntu/18.04/x-arm64/Dockerfile
    91	./ubuntu/18.04/x-m68k/Dockerfile
    92	./ubuntu/18.04/x-powerpc/Dockerfile
    93	./ubuntu/18.04/x-powerpc64/Dockerfile
    94	./ubuntu/18.04/x-powerpc64el/Dockerfile
    95	./ubuntu/18.04/x-riscv64/Dockerfile
    96	./ubuntu/18.04/x-s390/Dockerfile
    97	./ubuntu/18.04/x-sh4/Dockerfile
    98	./ubuntu/18.04/x-sparc64/Dockerfile
    99	./ubuntu/18.04/Dockerfile
   100	./ubuntu/20.04/x-powerpc64el/Dockerfile
   101	./ubuntu/20.04/x-s390/Dockerfile
   102	./ubuntu/20.04/Dockerfile
   103	./ubuntu/20.04/x-arm/Dockerfile
   104	./ubuntu/20.10/Dockerfile
   105	./ubuntu/21.04/Dockerfile
   106	./ubuntu/21.04/end-of-life/x-mips/Dockerfile
   107	./ubuntu/21.04/end-of-life/x-mips64/Dockerfile
   108	./ubuntu/end-of-life/15.04/Dockerfile
   109	./ubuntu/end-of-life/15.10/Dockerfile
   110	./ubuntu/end-of-life/16.10/Dockerfile
   111	./ubuntu/end-of-life/17.04/Dockerfile
   112	./ubuntu/end-of-life/17.10/Dockerfile
   113	./ubuntu/end-of-life/18.10/Dockerfile
   114	./ubuntu/end-of-life/19.04/Dockerfile
   115	./ubuntu/end-of-life/19.10/Dockerfile
   116	./ubuntu/end-of-life/19.10/x-alpha/Dockerfile
   117	./ubuntu/end-of-life/19.10/x-arm64/Dockerfile
   118	./ubuntu/end-of-life/19.10/x-hppa/Dockerfile
   119	./ubuntu/end-of-life/12.04/Dockerfile
   120	./ubuntu/end-of-life/14.04/end-of-life/x-linaro-arm64/Dockerfile
   121	./ubuntu/end-of-life/14.04/Dockerfile
   122	./ubuntu/21.10/Dockerfile
   123	./ubuntu/22.04/Dockerfile
   124	./almalinux/8/Dockerfile
   125	./rockylinux/8/Dockerfile
   126	./ubi8/Dockerfile
[perfbuilder@five linux-perf-tools-build]$
