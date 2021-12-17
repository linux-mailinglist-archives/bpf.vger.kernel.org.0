Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B174794A2
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 20:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhLQTMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 14:12:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45828 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240588AbhLQTMP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Dec 2021 14:12:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AEEC62384;
        Fri, 17 Dec 2021 19:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F30BC36AE2;
        Fri, 17 Dec 2021 19:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639768334;
        bh=SOOVbUhP4h272D7VGTusCnUo4jcab+85YDFYNjdJ2lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EuhGuv57ieGlfugFXuclOConO6Yi7aq5Wjt/sugl8vYfx+hfYa5qWa5x+JWuJ+9mt
         L5H2U/EIicbeJgzGVcNKXWAuVelzL7tDr07RDuZJQbsYNWDJAL/wqikAbLwnFdOfJj
         YDtoM23OtrM2G1buLJF377i673lNubMlrPndHZE5B7/soolegIDC/X2IvzdDNaYSR4
         nU/fbhQ7fddipF4lj8nbe5tLo4B3aT1kDLRVEMnEOCCrd4sJP3eu4rloIhBRmL27tb
         A6QJRQFUAlhPpMOAYj1uJYYmQq0oPX+IaGWOOGmzRWl5GBK8cqq+gk3zNW9liGtmd8
         Fii1jl6TRpeow==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9134C40B92; Fri, 17 Dec 2021 16:12:11 -0300 (-03)
Date:   Fri, 17 Dec 2021 16:12:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Yonghong Song <yhs@fb.com>,
        Douglas RAILLARD <douglas.raillard@arm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Matteo Croce <mcroce@microsoft.com>
Subject: Re: ANNOUNCE: pahole v1.23 (BTF tags and alignment inference)
Message-ID: <YbzhCwlbArsS4b0d@kernel.org>
References: <YSQSZQnnlIWAQ06v@kernel.org>
 <YbC5MC+h+PkDZten@kernel.org>
 <YbkTAPn3EEu6BUYR@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbkTAPn3EEu6BUYR@archlinux-ax161>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Dec 14, 2021 at 02:56:16PM -0700, Nathan Chancellor escreveu:
> Hi Arnaldo,
> 
> On Wed, Dec 08, 2021 at 10:54:56AM -0300, Arnaldo Carvalho de Melo wrote:
> > - Initial support for DW_TAG_skeleton_unit, so far just suggest looking up a
> >   matching .dwo file to be used instead. Automagically doing this is in the
> >   plans for a future release.
> 
> This change [1] appears to break building on older distributions for me,
> which I use in containers for access to older versions of GCC. I see the
> error with Debian Stretch and Ubuntu Xenial, which have an older
> libelf-dev.  Is this expected? I don't mind sticking with 1.22 for
> those, I just want to be sure!
> 
> /tmp/dwarves-1.23/dwarf_loader.c: In function 'die__process':
> /tmp/dwarves-1.23/dwarf_loader.c:2529:13: error: 'DW_TAG_skeleton_unit' undeclared (first use in this function)
>   if (tag == DW_TAG_skeleton_unit) {
>              ^
> 
> [1]: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=0135ccd632796ab3aff65b7c99b374c4682c2bcf
> 

with the following patch:

commit 2f7d61b2bfb59427926867c886595ff28dd50607
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri Dec 17 15:50:17 2021 -0300

    core: Define DW_TAG_skeleton_unit if not available on current dwarf.h
    
    We use this in both the dwarf_loader.c and in fprintf.c, so define it in
    dwarves.h that is included in both.
    
    Reported-by: Nathan Chancellor <nathan@kernel.org>
    Link: https://lore.kernel.org/all/YbkTAPn3EEu6BUYR@archlinux-ax161
    Cc: Domenico Andreoli <domenico.andreoli@linux.com>
    Cc: Douglas RAILLARD <douglas.raillard@arm.com>
    Cc: Ilya Leoshkevich <iii@linux.ibm.com>
    Cc: Jan Engelhardt <jengelh@inai.de>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Matteo Croce <mcroce@microsoft.com>
    Cc: Matthias Schwarzott <zzam@gentoo.org>
    Cc: Yonghong Song <yhs@fb.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/dwarves.h b/dwarves.h
index 52d162d67456bf12..2132da0ef02b78fd 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1390,4 +1390,8 @@ extern bool no_bitfield_type_recode;
 
 extern const char tabs[];
 
+#ifndef DW_TAG_skeleton_unit
+#define DW_TAG_skeleton_unit 0x4a
+#endif
+
 #endif /* _DWARVES_H_ */


And using the perf build containers to build with both gcc and clang
only a few older distros are failing, I'll make buildcmd.sh, that is in
the dwarves repo, to build using the system libbpf-devel (or equivalent)
package and have this running after processing patches as I did for 1.22
but forgot to do for 1.23 :-/

- Arnaldo

[perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.100.2/pahole/dwarves-1.24.tar.xz
[perfbuilder@five ~]$ export BUILD_CMD=buildcmd.sh
[perfbuilder@five ~]$ time dm -X
   1     3.67 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2     0.96 alpine:3.4                    : FAIL gcc version 5.3.0 (Alpine 5.3.0)

   3     0.96 alpine:3.5                    : FAIL gcc version 6.2.1 20160822 (Alpine 6.2.1)

   4     1.06 alpine:3.6                    : FAIL gcc version 6.3.0 (Alpine 6.3.0)

   5     1.06 alpine:3.7                    : FAIL gcc version 6.4.0 (Alpine 6.4.0)

   6     0.96 alpine:3.8                    : FAIL gcc version 6.4.0 (Alpine 6.4.0)

   7     0.86 alpine:3.9                    : FAIL gcc version 8.3.0 (Alpine 8.3.0)

   8     1.06 alpine:3.10                   : FAIL gcc version 8.3.0 (Alpine 8.3.0)

   9     0.76 alpine:3.11                   : FAIL gcc version 9.3.0 (Alpine 9.3.0)

  10     4.47 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  11     4.87 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1
  12     4.87 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13     4.77 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
  14     5.07 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20211128) 11.2.1 20211128 , Alpine clang version 12.0.1
  15     3.27 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  16     3.66 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
  17     3.57 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
  18     3.66 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20210911 (ALT Sisyphus 11.2.1-alt1) , ALT Linux Team clang version 12.0.1
  19     3.16 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  20     3.26 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  21     3.46 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  22     3.46 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3) , clang version 12.0.1 (Red Hat 12.0.1-2.module_el8.6.0+937+1cafe22c)
  23     3.57 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20211208 releases/gcc-11.2.0-562-gbd918acae2 , clang version 11.1.0
  24     3.77 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  25     3.67 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  26     3.67 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  27     3.87 debian:experimental           : Ok   gcc (Debian 11.2.0-12) 11.2.0 , Debian clang version 13.0.0-9+b1
  28     3.16 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  29     3.46 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  30     3.47 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  31     3.48 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  32     3.67 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  33     3.46 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  34     3.87 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  35     3.87 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  36     3.67 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  37     3.56 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  38     3.76 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  39     3.57 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  40     3.67 fedora:34                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  41     3.87 fedora:35                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
  42     3.87 fedora:rawhide                : Ok   gcc (GCC) 11.2.1 20211203 (Red Hat 11.2.1-7) , clang version 13.0.0 (Fedora 13.0.0-5.fc36)
  43     3.97 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
  44     3.37 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  45     3.97 mageia:7                      : Ok   gcc (Mageia 8.4.0-1.mga7) 8.4.0 , clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  46     4.67 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC)

  47     3.97 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  48     3.57 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  49     3.46 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1
  50     3.36 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  51     3.97 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20210816 [revision 056e324ce46a7924b5cf10f61010cf9dd2ca10e9] , clang version 13.0.0
  52     3.57 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
  53     3.67 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module+el8.5.0+715+58f51d49)
  54     3.47 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  55     3.67 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  56     3.97 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0 , clang version 10.0.0-4ubuntu1
  57     3.87 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
  58     3.57 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
  59     3.66 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
60 199.605

real	4m55.822s
user	1m16.561s
sys	0m17.551s
[perfbuilder@five ~]$


