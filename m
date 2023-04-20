Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAD96E9C63
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 21:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjDTTTX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 15:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjDTTTU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 15:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3F32719;
        Thu, 20 Apr 2023 12:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3704648E6;
        Thu, 20 Apr 2023 19:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BCEC433EF;
        Thu, 20 Apr 2023 19:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682018335;
        bh=A3iNLEAwuUSgID59L/NZFfMC7ShgNOqMGzRT+MXX/Dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sFe7U24bS++H8vxhQ6xbNjBxDL6+CGr3md0H99Drz3MnnQvEB6vIVXdoOTCz7yz5Q
         ccXZCjpLL1NDoSkcR7gAkiWaevvVOW20n2/ehEighxi/+TNnH9KiXM+Ty9BvEUqse+
         1ExhD+qh6Ctwk/5RysiGjWtzVA+fO/4my7bSs7jEJ0SCsI/vdWBsZc237XeWYdFszU
         7vz/3VToRm0i661mgdAi3WxKH0ky67zOyy8mNLp11LfpzTMaA+DvxKlt6lflXCrTIy
         9K4kG0eoK1qDO4XxYfz5QjR/koxF0UnxBfPhzsPiJ0Od2Om6dKUy/9nag3JTFGtr51
         UuFjP0wXn2WyQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E4FC403C5; Thu, 20 Apr 2023 16:18:52 -0300 (-03)
Date:   Thu, 20 Apr 2023 16:18:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin@isovalent.com>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        David Miller <davem@davemloft.net>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
Message-ID: <ZEGQHAMwtvv3AVnm@kernel.org>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <87leiw11yz.fsf@toke.dk>
 <ZD/IcBvVxtFtOhUC@syu-laptop.lan>
 <CAEf4BzbxfvR4Ji1q4wJCFHOxQgFzHr8t7TMK1VJj9sJ+a0srVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbxfvR4Ji1q4wJCFHOxQgFzHr8t7TMK1VJj9sJ+a0srVQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Apr 19, 2023 at 12:42:39PM -0700, Andrii Nakryiko escreveu:
> On Wed, Apr 19, 2023 at 3:55 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > Thanks for sharing! I though I'd expands on what you said to draw a clearer
> > picture of the challenges.
> >
> > On Thu, Apr 13, 2023 at 01:00:20PM +0200, Toke Høiland-Jørgensen wrote:
> > > Shung-Hsi Yu <shung-hsi.yu@suse.com> writes:
> > >
> > > > A side note: if we want all userspace visible libbpf to have a coherent
> > > > version, perf needs to use the shared libbpf library as well (either
> > > > autodetected or forced with LIBBPF_DYNAMIC=1 like Fedora[4]). But having to
> > > > backport patches to kernel source to keep up with userspace package (libbpf)
> > > > changes could be a pain.
> >
> > Here some more context for completeness. Kernel source changes are published
> > at a much slower pace than userspace. When an application in the kernel
> > source (e.g. perf) depends on the userspace library, it's kind of like
> > trying to catchup a car on a bike, which is doable, as evident by the

That is why perf is continuously (at least) build tested against lots of
distros, see the last test output:

[perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.86.10/perf/perf-6.3.0-rc1.tar.xz
[perfbuilder@five ~]$ time dm
   1   151.45 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-16) , clang version 14.0.6 (Red Hat 14.0.6-1.module_el8.7.0+3277+b822483f)
   2   150.54 almalinux:9                   : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 14.0.6 (Red Hat 14.0.6-4.el9_1)
   3   159.04 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
   4   153.81 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
   5   137.88 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7
   6   139.32 alpine:edge                   : Ok   gcc (Alpine 12.2.1_git20220924-r9) 12.2.1 20220924 , Alpine clang version 16.0.0
   7   109.51 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
   8   104.99 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
   9    85.35 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 12.1.1 20220518 (ALT Sisyphus 12.1.1-alt2) , ALT Linux Team clang version 13.0.1
  10   111.22 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  11   127.05 amazonlinux:2023              : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2)
  12   126.56 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2)
  13   154.76 archlinux:base                : Ok   gcc (GCC) 12.2.0 , clang version 14.0.6
  14   135.39 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-18) , clang version 15.0.7 (Red Hat 15.0.7-1.module_el8.8.0+1258+af79b238)
  15    40.01 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 12.2.1 20230412 releases/gcc-12.2.0-699-g43ab94d20e
  16    95.89 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
  17   121.95 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  18   136.49 debian:experimental           : Ok   gcc (Debian 12.2.0-14) 12.2.0 , Debian clang version 14.0.6
  19    29.78 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0
  20    22.96 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0
  21     3.37 debian:experimental-x-mips64  : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
  22    11.29 debian:experimental-x-mipsel  : FAIL gcc version 12.2.0 (Debian 12.2.0-14)
  23    33.28 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  24    33.29 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  25    29.77 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)
  26    32.27 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)
  27    34.18 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2)
  28   139.98 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  29   119.93 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  30   123.87 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  31   188.77 fedora:34                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  32    22.44 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  33    20.33 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  34   172.51 fedora:35                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-3) , clang version 13.0.1 (Fedora 13.0.1-1.fc35)
  35   138.29 fedora:36                     : Ok   gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4) , clang version 14.0.5 (Fedora 14.0.5-2.fc36)
  36   139.99 fedora:37                     : Ok   gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4) , clang version 15.0.7 (Fedora 15.0.7-1.fc37)
  37   144.73 fedora:38                     : Ok   gcc (GCC) 13.0.1 20230401 (Red Hat 13.0.1-0) , clang version 16.0.0 (Fedora 16.0.0-2.fc38)
  38   191.37 fedora:39                     : Ok   gcc (GCC) 13.0.1 20230404 (Red Hat 13.0.1-0) , clang version 16.0.1 (Fedora 16.0.1-1.fc39)
  39   187.13 fedora:rawhide                : Ok   gcc (GCC) 13.0.1 20230404 (Red Hat 13.0.1-0) , clang version 16.0.1 (Fedora 16.0.1-1.fc39)
  40    13.08 gentoo:stage3                 : FAIL gcc version 12.2.1 20230121 (Gentoo 12.2.1_p20230121-r1 p10)
  41   152.25 manjaro:base                  : Ok   gcc (GCC) 12.2.1 20230201 , clang version 15.0.7
  42   148.30 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 13.0.1
  43   152.82 opensuse:15.5                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 15.0.7
  44   187.75 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 12.2.1 20221020 [revision 0aaef83351473e8f4eb774f8f999bbe87a4866d7] , clang version 15.0.6
  45   133.67 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-16.0.2) , clang version 14.0.6 (Red Hat 14.0.6-1.0.1.module+el8.7.0+20823+214a699d)
  46   132.26 oraclelinux:9                 : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2.1.0.2) , clang version 14.0.6 (Red Hat 14.0.6-4.0.1.el9_1)
  47   150.02 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-16) , clang version 14.0.6 (Red Hat 14.0.6-1.module+el8.7.0+1080+d88dc670)
  48   133.78 rockylinux:9                  : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 14.0.6 (Red Hat 14.0.6-4.el9_1)
  49    28.97 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  50    25.06 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  51    25.06 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  52    20.54 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  53    24.56 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  54    26.07 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  55    26.46 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  56   113.72 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  57    22.55 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  58    24.35 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  59    22.54 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  60    31.87 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
  61   179.64 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0 , Ubuntu clang version 14.0.0-1ubuntu1
  62     1.26 ubuntu:22.04-x-riscv64        : FAIL gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04)
  63    87.25 ubuntu:22.10                  : Ok   gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0 , Ubuntu clang version 15.0.7
  64    86.96 ubuntu:23.04                  : Ok   gcc (Ubuntu 12.2.0-17ubuntu1) 12.2.0 , Ubuntu clang version 15.0.7
BUILD_TARBALL_HEAD=f8b04f975d2c3d7c8e8cb53155744c20a41813ac
65 6011.52

real	101m23.391s
user	0m51.216s
sys	0m40.407s
[perfbuilder@five ~]$

> > plethora of userspace libraries perf already depends on. While I don't
> > having experience maintaining perf, judging by tools/perf/Makefile.config
> > that does not seem like an easy feat.

Not that bad having the tests we have in place :-)

> > For perf to use libbpf in kernel would mean that it's just depending on
> > something that moves at the same pace.

More tests to check build both with the in-kernel libbpf and with the
one in the distro:

⬢[acme@toolbox perf-tools-next]$ grep LIBBPF_DYNAMIC tools/perf/tests/make
make_libbpf_dynamic := LIBBPF_DYNAMIC=1
⬢[acme@toolbox perf-tools-next]$


> > That said, maybe perf won't need additional backport to keep up with libbpf
> > as long as we keep it within that same major version (and disable
> > deprecation warning)? @Andrii
> >
> > Now that We've got pass libbpf 1.0 it seems like a good time to reconsider.
> 
> I'm not sure what the proposal is, but I'll delegate to Arnaldo.
 
> > > So basically, this here is the reason we're building libbpf from the
> > > kernel tree for the RHEL package: If we use the github version we'd need
> > > to juggle two different versions of libbpf, one for the in-kernel-tree
> > > users (perf as you mention, but also the BPF selftests), and one for the

Have you tried with LIBBPF_DYNAMIC=1?

> > > userspace packages. Also, having libbpf in the kernel tree means we can
> > > just backport patches to it along with the BPF-related kernel patches
> > > (we do quite extensive BPF backports for each RHEL version).
> >
> > > Finally, building from the kernel tree means we can use the existing
> > > kernel-related procedures for any out of order hotfixes (since AFAIK none
> > > of the github repositories have any concept of stable branches that
> > > receive fixes).
> >
> > +1
> >
> > Got something similar in place as well and being able to stick with existing
> > procedure is appealing.
> >
> > > YMMV of course, but figured I'd share our reasoning. To be clear,
> > > building from the kernel tree is not without its own pain points (mostly
> > > related to how the build scripts are structured for our kernel builds).
> > > We've discussed moving to the github version of libbpf multiple times,
> > > but every time we've concluded that it would be more, not less, painful
> > > than having the kernel tree be the single source of truth.
> >
> > We package maintainer are certainly quite hard to please :)
> >
> > Just having an individual package easy to work with is not enough, we want
> > it to be easier for most packages before jumping on the bandwagon, which is
> > why this email ended up talking about perf despite it started as a
> > discussion on packaging libbpf and bpftool.
> >
> > I suppose the mileage depends on the build system & scripts in use and how
> > much backporting is done; the more kernel backporting (along with more
> > established processes in place), the more painful it'd be to move to the
> > GitHub version. My gut feeling is that SLES do less backporting compared to
> > RHEL when it comes to BPF, and that probably placed us closer to the middle
> > ground.
> 
> Even though libbpf source is developed in kernel repo, it's not tied
> to specific kernel. So any kernel backports have no relevance to
> libbpf itself. It's yet another reason to switch to Github mirror.
> Github is merging libbpf-related fixes from both bpf and bpf-next
> trees during sync, and is meant to always be the latest and best
> version with all fixes included.
> 
> I won't claim anything for perf, maybe Arnaldo can clarify, but I
> suspect that perf is also meant to be relatively independent from
> specific kernel and work on wide variety of kernels.
> 
> As for stable branches. For libbpf, we don't have it because we didn't
> need it yet. We did have bug fix patch releases that seem to be
> working out fine, though.
> 
> >
> > Thanks,
> > Shung-Hsi
> >
> > > -Toke
> > >

-- 

- Arnaldo
