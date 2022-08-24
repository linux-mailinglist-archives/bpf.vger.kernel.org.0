Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051755A00C9
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 19:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbiHXRzS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 13:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiHXRzM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 13:55:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E64BE09;
        Wed, 24 Aug 2022 10:55:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E38CB82619;
        Wed, 24 Aug 2022 17:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AC7C433D6;
        Wed, 24 Aug 2022 17:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661363706;
        bh=m9iiQG1GlHiJ9EAtUJBgeMMhreojHIkPRSsYjz7pVHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGcXp9/NrWR8V7VYaRXy/y0/qtUgm57XjWFTBsWxwu1OSkAmNYaTQR7r1T4l+uggy
         9bNWqo9MKpgrS+JtH/7hUlvgbcFe+DCyrOHBXCXoj0a8b8tNQo52ttvOOoaTt4Rj2M
         hshlRI36wj2EKCVOZ5w1UL4pW3UucN9KJnE3xyxxZyjVJhS9dizEuLL7ThbmMQkCbr
         VUFh12mms7Zc1jRMITECib8GUarsX4xnDeTVnciDvTm06GBouYEeBHlGzJZK6yiKeE
         VUKBq/bv5v52RXzYI3PjSNoKjn+VGqjpcldjIjQExsoi5Y1XVD27qzOMsWMfRlagrO
         o6ceXoH7ipx6A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 87ED9404A1; Wed, 24 Aug 2022 14:55:03 -0300 (-03)
Date:   Wed, 24 Aug 2022 14:55:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alibek Omarov <a1ba.omarov@gmail.com>,
        Kornilios Kourtis <kornilios@isovalent.com>,
        Kui-Feng Lee <kuifeng@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: ANNOUNCE: pahole v1.24 (Faster BTF encoding, 64-bit BTF enum
 entries)
Message-ID: <YwZl9xaRplsFkWXb@kernel.org>
References: <YwQRKkmWqsf/Du6A@kernel.org>
 <YwZQ0UkLsoa+6VyY@dev-arch.thelio-3990X>
 <YwZcuCj49wMkr18W@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwZcuCj49wMkr18W@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Aug 24, 2022 at 02:15:36PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Aug 24, 2022 at 09:24:49AM -0700, Nathan Chancellor escreveu:
> > Hi Arnaldo,
> > 
> > On Mon, Aug 22, 2022 at 08:28:42PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Hi,
> > >   
> > > 	The v1.24 release of pahole and its friends is out, with faster
> > > BTF generation by parallelizing the encoding part in addition to the
> > > previoulsy parallelized DWARF loading, support for 64-bit BTF enumeration
> > > entries, signed BTF encoding of 'char', exclude/select DWARF loading
> > > based on the language that generated the objects, etc.
> > 
> > <snip>
> > 
> > > - Introduce --lang and --lang_exclude to specify the language the
> > >   DWARF compile units were originated from to use or filter.
> > 
> > This appears to break building pahole with older versions of libdw (?).
> > I build container images with older versions of compilers for easy
> > matrix testing and my gcc-5 and gcc-6 images (based off Ubuntu Xenial
> > and Debian Stretch respectively) fail to build.
> 
> I do it for perf, should have done it for pahole :-\
> 
> So I'll have to come up with a patch that checks if those are defined
> and if not, define it :-\ Ooops, its an enumeration :-\ I'll have to
> check how to fix this, thanks for the report!
> 
> Will rebuild it with the containers I have to see if there are other
> cases.

Yeah, recent enough distros are all building ok, I'll try and add some
fallback for old distros.

[perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.86.14/pahole/dwarves-1.24.tar.xz
[perfbuilder@five ~]$ export BUILD_CMD=buildcmd.sh
[perfbuilder@five ~]$ time dm
   1     3.86 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2     3.97 almalinux:9                   : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
   3     1.06 alpine:3.9                    : FAIL gcc version 8.3.0 (Alpine 8.3.0)
   4     0.96 alpine:3.10                   : FAIL gcc version 8.3.0 (Alpine 8.3.0)
   5     0.86 alpine:3.11                   : FAIL gcc version 9.3.0 (Alpine 9.3.0)
   6     4.77 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
   7     5.47 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1
   8     5.57 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
   9     5.37 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
  10     5.67 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
  11     5.67 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 14.0.6
  12     2.96 alt:p8                        : FAIL gcc version 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) (GCC)
    /git/dwarves-1.24/dwarves.c: In function 'lang__str2int':
    /git/dwarves-1.24/dwarves.c:2093:3: error: 'DW_LANG_BLISS' undeclared (first use in this function)
      [DW_LANG_BLISS]   = "bliss",
       ^
    /git/dwarves-1.24/dwarves.c:2093:3: note: each undeclared identifier is reported only once for each function it appears in
    /git/dwarves-1.24/dwarves.c:2093:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2093:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2100:3: error: 'DW_LANG_C_plus_plus_03' undeclared (first use in this function)
      [DW_LANG_C_plus_plus_03] = "c++03",
       ^
    /git/dwarves-1.24/dwarves.c:2100:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2100:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2105:3: error: 'DW_LANG_Dylan' undeclared (first use in this function)
      [DW_LANG_Dylan]   = "dylan",
       ^
    /git/dwarves-1.24/dwarves.c:2105:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2105:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2114:3: error: 'DW_LANG_Julia' undeclared (first use in this function)
      [DW_LANG_Julia]   = "julia",
       ^
    /git/dwarves-1.24/dwarves.c:2114:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2114:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2116:3: error: 'DW_LANG_Modula3' undeclared (first use in this function)
      [DW_LANG_Modula3]  = "modula3",
       ^
    /git/dwarves-1.24/dwarves.c:2116:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2116:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2119:3: error: 'DW_LANG_OCaml' undeclared (first use in this function)
      [DW_LANG_OCaml]   = "ocaml",
       ^
    /git/dwarves-1.24/dwarves.c:2119:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2119:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2120:3: error: 'DW_LANG_OpenCL' undeclared (first use in this function)
      [DW_LANG_OpenCL]  = "opencl",
       ^
    /git/dwarves-1.24/dwarves.c:2120:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2120:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2124:3: error: 'DW_LANG_RenderScript' undeclared (first use in this function)
      [DW_LANG_RenderScript]  = "renderscript",
       ^
    /git/dwarves-1.24/dwarves.c:2124:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2124:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2125:3: error: 'DW_LANG_Rust' undeclared (first use in this function)
      [DW_LANG_Rust]   = "rust",
       ^
    /git/dwarves-1.24/dwarves.c:2125:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2125:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2126:3: error: 'DW_LANG_Swift' undeclared (first use in this function)
      [DW_LANG_Swift]   = "swift",
       ^
    /git/dwarves-1.24/dwarves.c:2126:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2126:3: note: (near initialization for 'languages')
    make[2]: *** [CMakeFiles/dwarves.dir/dwarves.c.o] Error 1
  13     4.07 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
  14     4.17 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
  15     4.17 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 12.1.1 20220518 (ALT Sisyphus 12.1.1-alt1) , ALT Linux Team clang version 13.0.1
  16     3.57 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  17     4.27 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
  18     4.87 archlinux:base                : Ok   gcc (GCC) 12.1.1 20220730 , clang version 14.0.6
  19     3.77 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  20     4.07 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-15) , clang version 14.0.0 (Red Hat 14.0.0-1.module_el8.7.0+1142+5343df54)
  21     4.87 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 12.1.1 20220811 releases/gcc-12.1.0-341-g28a7b5df3b
  22     3.36 debian:9                      : FAIL gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)
    /git/dwarves-1.24/dwarves.c: In function 'lang__str2int':
    /git/dwarves-1.24/dwarves.c:2093:3: error: 'DW_LANG_BLISS' undeclared (first use in this function)
      [DW_LANG_BLISS]   = "bliss",
       ^~~~~~~~~~~~~
    /git/dwarves-1.24/dwarves.c:2093:3: note: each undeclared identifier is reported only once for each function it appears in
    /git/dwarves-1.24/dwarves.c:2093:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2093:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2100:3: error: 'DW_LANG_C_plus_plus_03' undeclared (first use in this function)
      [DW_LANG_C_plus_plus_03] = "c++03",
       ^~~~~~~~~~~~~~~~~~~~~~
    /git/dwarves-1.24/dwarves.c:2100:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2100:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2105:3: error: 'DW_LANG_Dylan' undeclared (first use in this function)
      [DW_LANG_Dylan]   = "dylan",
       ^~~~~~~~~~~~~
    /git/dwarves-1.24/dwarves.c:2105:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2105:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2114:3: error: 'DW_LANG_Julia' undeclared (first use in this function)
      [DW_LANG_Julia]   = "julia",
       ^~~~~~~~~~~~~
    /git/dwarves-1.24/dwarves.c:2114:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2114:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2116:3: error: 'DW_LANG_Modula3' undeclared (first use in this function)
      [DW_LANG_Modula3]  = "modula3",
       ^~~~~~~~~~~~~~~
    /git/dwarves-1.24/dwarves.c:2116:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2116:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2119:3: error: 'DW_LANG_OCaml' undeclared (first use in this function)
      [DW_LANG_OCaml]   = "ocaml",
       ^~~~~~~~~~~~~
    /git/dwarves-1.24/dwarves.c:2119:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2119:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2120:3: error: 'DW_LANG_OpenCL' undeclared (first use in this function)
      [DW_LANG_OpenCL]  = "opencl",
       ^~~~~~~~~~~~~~
    /git/dwarves-1.24/dwarves.c:2120:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2120:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2124:3: error: 'DW_LANG_RenderScript' undeclared (first use in this function)
      [DW_LANG_RenderScript]  = "renderscript",
       ^~~~~~~~~~~~~~~~~~~~
    /git/dwarves-1.24/dwarves.c:2124:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2124:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2125:3: error: 'DW_LANG_Rust' undeclared (first use in this function)
      [DW_LANG_Rust]   = "rust",
       ^~~~~~~~~~~~
    /git/dwarves-1.24/dwarves.c:2125:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2125:3: note: (near initialization for 'languages')
    /git/dwarves-1.24/dwarves.c:2126:3: error: 'DW_LANG_Swift' undeclared (first use in this function)
      [DW_LANG_Swift]   = "swift",
       ^~~~~~~~~~~~~
    /git/dwarves-1.24/dwarves.c:2126:3: error: array index in initializer not of integer type
    /git/dwarves-1.24/dwarves.c:2126:3: note: (near initialization for 'languages')
    CMakeFiles/dwarves.dir/build.make:62: recipe for target 'CMakeFiles/dwarves.dir/dwarves.c.o' failed
    make[2]: *** [CMakeFiles/dwarves.dir/dwarves.c.o] Error 1
  23     4.08 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
  24     3.97 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  25     4.77 debian:experimental           : Ok   gcc (Debian 12.1.0-7) 12.1.0 , Debian clang version 14.0.6-2
  26     3.06 fedora:22                     : FAIL gcc version 5.3.1 20160406 (Red Hat 5.3.1-6) (GCC)
    /git/dwarves-1.24/dwarves.c: In function 'lang__str2int':
    /git/dwarves-1.24/dwarves.c:2093:3: error: 'DW_LANG_BLISS' undeclared (first use in this function)
      [DW_LANG_BLISS]   = "bliss",
       ^
    /git/dwarves-1.24/dwarves.c:2093:3: note: each undeclared identifier is reported only once for each function it appears in
  27     3.06 fedora:24                     : FAIL gcc version 6.3.1 20161221 (Red Hat 6.3.1-1) (GCC)
    /git/dwarves-1.24/dwarves.c: In function 'lang__str2int':
    /git/dwarves-1.24/dwarves.c:2093:3: error: 'DW_LANG_BLISS' undeclared (first use in this function)
      [DW_LANG_BLISS]   = "bliss",
       ^~~~~~~~~~~~~
    /git/dwarves-1.24/dwarves.c:2093:3: note: each undeclared identifier is reported only once for each function it appears in
  28     3.17 fedora:25                     : FAIL gcc version 6.4.1 20170727 (Red Hat 6.4.1-1) (GCC)
    /git/dwarves-1.24/dwarves.c: In function 'lang__str2int':
    /git/dwarves-1.24/dwarves.c:2093:3: error: 'DW_LANG_BLISS' undeclared (first use in this function)
      [DW_LANG_BLISS]   = "bliss",
       ^~~~~~~~~~~~~
  29     3.87 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2)
  30     3.57 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6)
  31     3.87 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)
  32     3.97 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2)
  33     3.77 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2)
  34     3.97 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  35     4.07 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  36     3.97 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  37     4.17 fedora:34                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  38     3.97 fedora:35                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
  39     4.27 fedora:36                     : Ok   gcc (GCC) 12.1.1 20220507 (Red Hat 12.1.1-1) , clang version 14.0.0 (Fedora 14.0.0-1.fc36)
  40     4.57 fedora:37                     : Ok   gcc (GCC) 12.1.1 20220628 (Red Hat 12.1.1-3) , clang version 14.0.5 (Fedora 14.0.5-6.fc37)
  41     4.67 fedora:38                     : Ok   gcc (GCC) 12.1.1 20220810 (Red Hat 12.1.1-4) , clang version 14.0.5 (Fedora 14.0.5-6.fc38)
  42     4.56 fedora:rawhide                : Ok   gcc (GCC) 12.1.1 20220810 (Red Hat 12.1.1-4) , clang version 14.0.5 (Fedora 14.0.5-6.fc38)
  43     4.17 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
  44     4.47 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
  45     3.26 opensuse:15.0                 : FAIL gcc version 7.4.1 20190905 [gcc-7-branch revision 275407] (SUSE Linux)
    /git/dwarves-1.24/dwarves.c: In function 'lang__str2int':
    /git/dwarves-1.24/dwarves.c:2093:3: error: 'DW_LANG_BLISS' undeclared (first use in this function); did you mean 'DW_LANG_PLI'?
      [DW_LANG_BLISS]   = "bliss",
       ^~~~~~~~~~~~~
       DW_LANG_PLI
    /git/dwarves-1.24/dwarves.c:2093:3: note: each undeclared identifier is reported only once for each function it appears in
  46     3.17 opensuse:15.1                 : FAIL gcc version 7.5.0 (SUSE Linux)
    /git/dwarves-1.24/dwarves.c: In function 'lang__str2int':
    /git/dwarves-1.24/dwarves.c:2093:3: error: 'DW_LANG_BLISS' undeclared (first use in this function); did you mean 'DW_LANG_PLI'?
      [DW_LANG_BLISS]   = "bliss",
       ^~~~~~~~~~~~~
       DW_LANG_PLI
    /git/dwarves-1.24/dwarves.c:2093:3: note: each undeclared identifier is reported only once for each function it appears in
  47     3.16 opensuse:15.2                 : FAIL gcc version 7.5.0 (SUSE Linux)
    /git/dwarves-1.24/dwarves.c: In function 'lang__str2int':
    /git/dwarves-1.24/dwarves.c:2093:3: error: 'DW_LANG_BLISS' undeclared (first use in this function); did you mean 'DW_LANG_PLI'?
      [DW_LANG_BLISS]   = "bliss",
       ^~~~~~~~~~~~~
       DW_LANG_PLI
    /git/dwarves-1.24/dwarves.c:2093:3: note: each undeclared identifier is reported only once for each function it appears in
  48     3.77 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  49     3.96 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 13.0.1
  50     4.57 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 12.1.1 20220629 [revision 7811663964aa7e31c3939b859bbfa2e16919639f] , clang version 14.0.6
  51     3.87 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
  52     3.97 oraclelinux:9                 : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9.4.0.2) , clang version 13.0.1 (Red Hat 13.0.1-1.0.1.el9)
  53     3.97 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10) , clang version 13.0.1 (Red Hat 13.0.1-2.module+el8.6.0+987+d36ea6a1)
  54     4.17 rockylinux:9                  : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
  55     3.06 ubuntu:16.04                  : FAIL gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.12)
    /git/dwarves-1.24/dwarves.c: In function 'lang__str2int':
    /git/dwarves-1.24/dwarves.c:2093:3: error: 'DW_LANG_BLISS' undeclared (first use in this function)
      [DW_LANG_BLISS]   = "bliss",
       ^
    /git/dwarves-1.24/dwarves.c:2093:3: note: each undeclared identifier is reported only once for each function it appears in
  56     3.77 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  57     4.27 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
  58     4.17 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
  59     4.07 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
  60     4.17 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0 , Ubuntu clang version 14.0.0-1ubuntu1
  61     4.37 ubuntu:22.10                  : Ok   gcc (Ubuntu 11.3.0-5ubuntu1) 11.3.0 , Ubuntu clang version 14.0.6-2

