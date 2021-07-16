Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1EB3CB7D7
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 15:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbhGPN2W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Jul 2021 09:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239391AbhGPN2V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Jul 2021 09:28:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D326261396;
        Fri, 16 Jul 2021 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626441927;
        bh=MOW7BsMiF5jM/td8y/cstPXJ4nf50uDRNN1L/tvZLGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iYMRTe+xZPOC2PKV37p/JK5UbdCcVIMKf0BZQ3ZZI2ca1w97GKGGkXo/hAcpb368s
         dVg7anxpzlBxzJBSSt8l2BzhN+sSNLD+DmN16Qhv24Xw2b/6c7porEHDd5q9It3Sz8
         W7jeThC18EacOAy9UD217puPfnUUeBnMGBGDy6KkGS85QeX/tqwGbT+JmAnLqlgJWJ
         uW7d76Ewo5IrqgytpOnr72fKMEV12S/UV/E8lG6tFfK+WrmcWaDIknqmvF6+2tW3xw
         E/zZZimROCTp7LVNM2EtMKO3jlVITV9t4VhO2w5dJOfs6Pej4WY2tp5DlD3gXeAgZh
         X3IyWazYRCixA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7FD25403F2; Fri, 16 Jul 2021 10:25:24 -0300 (-03)
Date:   Fri, 16 Jul 2021 10:25:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFT] Testing 1.22
Message-ID: <YPGIxJao9SrsiG9X@kernel.org>
References: <YK+41f972j25Z1QQ@kernel.org>
 <20210715213120.GJ24916@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210715213120.GJ24916@kitsune.suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jul 15, 2021 at 11:31:20PM +0200, Michal Suchánek escreveu:
> Hello,
> 
> when building with system libbpf I get:
> 
> [   40s] make[1]: Nothing to be done for 'preinstall'.
> [   40s] make[1]: Leaving directory '/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build'
> [   40s] Install the project...
> [   40s] /usr/bin/cmake -P cmake_install.cmake
> [   40s] -- Install configuration: "RelWithDebInfo"
> [   40s] -- Installing: /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+git175.1ef87b2-15.1.ppc64le/usr/bin/codiff
> [   40s] CMake Error at cmake_install.cmake:63 (file):
> [   40s]   file RPATH_CHANGE could not write new RPATH:
> [   40s] 
> [   40s]     
> [   40s] 
> [   40s]   to the file:
> [   40s] 
> [   40s]     /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+git175.1ef87b2-15.1.ppc64le/usr/bin/codiff
> [   40s] 
> [   40s]   The current RUNPATH is:
> [   40s] 
> [   40s]     /home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build:
> [   40s] 
> [   40s]   which does not contain:
> [   40s] 
> [   40s]     /usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build:
> [   40s] 
> [   40s]   as was expected.
> [   40s] 
> [   40s] 
> [   40s] make: *** [Makefile:74: install] Error 1
> [   40s] make: Leaving directory '/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build'
> [   40s] error: Bad exit status from /var/tmp/rpm-tmp.OaGNX4 (%install)
> 
> This is not a problem with embedded libbpf.
> 
> Using system libbpf seems to be new in 1.22

Lucca, can you take a look at this?

Thanks,

- Arnaldo
 
> On Thu, May 27, 2021 at 12:20:53PM -0300, Arnaldo Carvalho de Melo wrote:
> > Hi guys,
> > 
> > 	Its important to have 1.22 out of the door ASAP, so please clone
> > what is in tmp.master and report your results.
> > 
> > 	To make it super easy:
> > 
> > [acme@quaco pahole]$ cd /tmp
> > [acme@quaco tmp]$ git clone git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> > Cloning into 'pahole'...
> > remote: Enumerating objects: 6510, done.
> > remote: Total 6510 (delta 0), reused 0 (delta 0), pack-reused 6510
> > Receiving objects: 100% (6510/6510), 1.63 MiB | 296.00 KiB/s, done.
> > Resolving deltas: 100% (4550/4550), done.
> > [acme@quaco tmp]$ cd pahole/
> > [acme@quaco pahole]$ git checkout origin/tmp.master
> > Note: switching to 'origin/tmp.master'.
> > 
> > You are in 'detached HEAD' state. You can look around, make experimental
> > changes and commit them, and you can discard any commits you make in this
> > state without impacting any branches by switching back to a branch.
> > 
> > If you want to create a new branch to retain commits you create, you may
> > do so (now or later) by using -c with the switch command. Example:
> > 
> >   git switch -c <new-branch-name>
> > 
> > Or undo this operation with:
> > 
> >   git switch -
> > 
> > Turn off this advice by setting config variable advice.detachedHead to false
> > 
> > HEAD is now at 0d17503db0580a66 btf_encoder: fix and complete filtering out zero-sized per-CPU variables
> > [acme@quaco pahole]$ git log --oneline -5
> > 0d17503db0580a66 (HEAD, origin/tmp.master) btf_encoder: fix and complete filtering out zero-sized per-CPU variables
> > fb418f9d8384d3a9 dwarves: Make handling of NULL by destructos consistent
> > f049fe9ebf7aa9c2 dutil: Make handling of NULL by destructos consistent
> > 1512ab8ab6fe76a9 pahole: Make handling of NULL by destructos consistent
> > 1105b7dad2d0978b elf_symtab: Use zfree() where applicable
> > [acme@quaco pahole]$ mkdir build
> > [acme@quaco pahole]$ cd build
> > [acme@quaco build]$ cmake ..
> > <SNIP>
> > -- Build files have been written to: /tmp/pahole/build
> > [acme@quaco build]$ cd ..
> > [acme@quaco pahole]$ make -j8 -C build
> > make: Entering directory '/tmp/pahole/build'
> > <SNIP>
> > [100%] Built target pahole
> > make[1]: Leaving directory '/tmp/pahole/build'
> > make: Leaving directory '/tmp/pahole/build'
> > [acme@quaco pahole]$
> > 
> > Then make sure build/pahole is in your path and try your workloads.
> > 
> > Jiri, Michael, if you could run your tests with this, that would be awesome,
> > 
> > Thanks in advance!
> > 
> > - Arnaldo

-- 

- Arnaldo
