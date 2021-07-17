Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A73B3CC3FF
	for <lists+bpf@lfdr.de>; Sat, 17 Jul 2021 17:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhGQPNC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Jul 2021 11:13:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42458 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhGQPNC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Jul 2021 11:13:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EC8D01FF21;
        Sat, 17 Jul 2021 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626534604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXFeXmmOw+6iQpHhaFjGZ7DUWosQOHFxaOEz1bv6zew=;
        b=OygK1d9oWX1i69DTytZCMIWb2pCHF+hBAw78Y5ONIbcVPvwPmVuLoLo1XxcOEzSet5PutC
        X5hu39H0SgvTvPlbBYs9sLwyF4l5Af9ftc+AVKM0I2vAbFey2gyk55sDakonfxK8oAjVnj
        CbPcdVKZurvIITl6+P65PE+/P3H+jR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626534604;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXFeXmmOw+6iQpHhaFjGZ7DUWosQOHFxaOEz1bv6zew=;
        b=v9RXsyRk4xZNAfraz5fRESoJHQpZizIDCAIT8tm04Pw8xfa+DRbbBbq9Qlk1ZGDqoPv1Ei
        2aeZdpy4cI2QLqDw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D1D5DA3B81;
        Sat, 17 Jul 2021 15:10:04 +0000 (UTC)
Date:   Sat, 17 Jul 2021 17:10:03 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFT] Testing 1.22
Message-ID: <20210717151003.GM24916@kitsune.suse.cz>
References: <YK+41f972j25Z1QQ@kernel.org>
 <20210715213120.GJ24916@kitsune.suse.cz>
 <YPGIxJao9SrsiG9X@kernel.org>
 <484bd96c1ae52516d54a5a45f2be108ee838f77a.camel@debian.org>
 <22b863ce92fb0f90006eee9a2a1bf82a7352cf1b.camel@debian.org>
 <20210716201248.GL24916@kitsune.suse.cz>
 <f699a04791efbb6936ef19a8dbfc99f6e77e7136.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f699a04791efbb6936ef19a8dbfc99f6e77e7136.camel@debian.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Sat, Jul 17, 2021 at 03:35:03PM +0100, Luca Boccassi wrote:
> On Fri, 2021-07-16 at 22:12 +0200, Michal Suchánek wrote:
> > On Fri, Jul 16, 2021 at 08:08:27PM +0100, Luca Boccassi wrote:
> > > On Fri, 2021-07-16 at 14:35 +0100, Luca Boccassi wrote:
> > > > On Fri, 2021-07-16 at 10:25 -0300, Arnaldo Carvalho de Melo wrote:
> > > > > Em Thu, Jul 15, 2021 at 11:31:20PM +0200, Michal Suchánek escreveu:
> > > > > > Hello,
> > > > > > 
> > > > > > when building with system libbpf I get:
> > > > > > 
> > > > > > [   40s] make[1]: Nothing to be done for 'preinstall'.
> > > > > > [   40s] make[1]: Leaving directory '/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build'
> > > > > > [   40s] Install the project...
> > > > > > [   40s] /usr/bin/cmake -P cmake_install.cmake
> > > > > > [   40s] -- Install configuration: "RelWithDebInfo"
> > > > > > [   40s] -- Installing: /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+git175.1ef87b2-15.1.ppc64le/usr/bin/codiff
> > > > > > [   40s] CMake Error at cmake_install.cmake:63 (file):
> > > > > > [   40s]   file RPATH_CHANGE could not write new RPATH:
> > > > > > [   40s] 
> > > > > > [   40s]     
> > > > > > [   40s] 
> > > > > > [   40s]   to the file:
> > > > > > [   40s] 
> > > > > > [   40s]     /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+git175.1ef87b2-15.1.ppc64le/usr/bin/codiff
> > > > > > [   40s] 
> > > > > > [   40s]   The current RUNPATH is:
> > > > > > [   40s] 
> > > > > > [   40s]     /home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build:
> > > > > > [   40s] 
> > > > > > [   40s]   which does not contain:
> > > > > > [   40s] 
> > > > > > [   40s]     /usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build:
> > > > > > [   40s] 
> > > > > > [   40s]   as was expected.
> > > > > > [   40s] 
> > > > > > [   40s] 
> > > > > > [   40s] make: *** [Makefile:74: install] Error 1
> > > > > > [   40s] make: Leaving directory '/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build'
> > > > > > [   40s] error: Bad exit status from /var/tmp/rpm-tmp.OaGNX4 (%install)
> > > > > > 
> > > > > > This is not a problem with embedded libbpf.
> > > > > > 
> > > > > > Using system libbpf seems to be new in 1.22
> > > > > 
> > > > > Lucca, can you take a look at this?
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > - Arnaldo
> > > > 
> > > > Hi,
> > > > 
> > > > Michal, what is the CMake configuration command line you are using?
> > > 
> > > Latest tmp.master builds fine here with libbpf 0.4.0. To reproduce it
> > > would be good to know build env and command line used, otherwise I
> > > can't really tell.
> > 
> > Indeed, there is non-trivial rpm macro expanded when invoking cmake.
> > 
> > Attaching log.
> > 
> > Thanks
> > 
> > Michal
> 
> So, this took some spelunking. TL;DR: openSUSE's libbpf.pc from libbpf-
> devel is broken, it lists -L/usr/local/lib64 in Libs even though it
> doesn't install anything in that prefix. Fix it to list the right path
> and the problem goes away.
> 
> Longer version: CMake is complaining that the rpath in the binary is
> not what it expected it to be when stripping it. Of course the first
> question is, why does that matter since it's removing it? Just remove
> it, no? Another CMake weirdness to add the the list, I guess.
> 
> [   20s]   file RPATH_CHANGE could not write new RPATH:
> [   20s] 
> [   20s]     
> [   20s] 
> [   20s]   to the file:
> [   20s] 
> [   20s]     /home/abuild/rpmbuild/BUILDROOT/dwarves-
> 1.21+git175.1ef87b2-21.1.x86_64/usr/bin/codiff
> [   20s] 
> [   20s]   The current RUNPATH is:
> [   20s] 
> [   20s]     /home/abuild/rpmbuild/BUILD/dwarves-
> 1.21+git175.1ef87b2/build:
> [   20s] 
> [   20s]   which does not contain:
> [   20s] 
> [   20s]     /usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-
> 1.21+git175.1ef87b2/build:
> [   20s] 
> [   20s]   as was expected.
> 
> This is the linking step where the rpath is set:
> 
> [   19s] /usr/bin/cc -O2 -Wall -D_FORTIFY_SOURCE=2 -fstack-protector-
> strong -funwind-tables -fasynchronous-unwind-tables -fstack-clash-
> protection -Werror=return-type -flto=auto -g -DNDEBUG
> -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -g -DNDEBUG -flto=auto
> -Wl,--as-needed -Wl,--no-undefined -Wl,-z,now -rdynamic
> CMakeFiles/codiff.dir/codiff.c.o -o codiff   -L/usr/local/lib64  -Wl,-
> rpath,/usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-
> 1.21+git175.1ef87b2/build: libdwarves.so.1.0.0 -ldw -lelf -lz -lbpf 
> 
> On a build without -DLIBBPF_EMBEDDED=off, this is the linking step for
> the same binary:
> 
> [   64s] /usr/bin/cc -O2 -Wall -D_FORTIFY_SOURCE=2 -fstack-protector-
> strong -funwind-tables -fasynchronous-unwind-tables -fstack-clash-
> protection -Werror=return-type -flto=auto -g -DNDEBUG
> -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -g -DNDEBUG -flto=auto
> -Wl,--as-needed -Wl,--no-undefined -Wl,-z,now -rdynamic
> CMakeFiles/codiff.dir/codiff.c.o -o codiff  -Wl,-
> rpath,/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build:
> libdwarves.so.1.0.0 -ldw -lelf -lz
> 
> /usr/local/lib64 is not in the rpath. Why? The hint is that
> -L/usr/local/lib64 is not passed either, too much of a coincidence to
> be unrelated.
> 
> Where is it coming from? Well, when using the system's libbpf we are
> using the pkgconfig file from the package. It is common to list linker
> flags in there, although this one shouldn't be in it. Sure enough,
> downloading libbpf-devel from 
> https://build.opensuse.org/package/binaries/openSUSE:Factory/libbpf/standard
> and extracting the pc file:
> 
> $ cat /tmp/libbpf.pc 
> # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> 
> prefix=/usr/local
> libdir=/usr/local/lib64
> includedir=${prefix}/include
> 
> Name: libbpf
> Description: BPF library
> Version: 0.3.0
> Libs: -L${libdir} -lbpf
> Requires.private: libelf zlib
> Cflags: -I${includedir}
> 
> There it is. Nothing is installed in that path, so it shouldn't be
> there in the first place.
> 
> $ rpm -qlp /tmp/libbpf0-5.12.4-2.7.x86_64.rpm 
> warning: /tmp/libbpf0-5.12.4-2.7.x86_64.rpm: Header V3 RSA/SHA256
> Signature, key ID 3dbdc284: NOKEY
> /usr/lib64/libbpf.so.0
> /usr/lib64/libbpf.so.0.3.0

Thanks for the investigation

So this libbpf comes from the kernel, and there is a separate github
repository for libbpf.

Should the kernel ship its own copy of the library?

Seeing that the one in the kernel is 0.3.0 and the required one for
dwarves is 0.4.0 maybe the one in the kernel needs updating if it needs
to be shipped there?

I wil file a bug to build the libbpf from the git repo instead of the
kernel to make the openSUSE libbpf less baroque.

Thanks

Michal
