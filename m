Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F585A166B
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 18:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbiHYQMd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 12:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbiHYQMc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 12:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D19E69A;
        Thu, 25 Aug 2022 09:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2AEB61B79;
        Thu, 25 Aug 2022 16:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57C2C433D6;
        Thu, 25 Aug 2022 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661443950;
        bh=X9Ac/hi185MXI9atczg2YUw4hk1KYe6CKc1/03EaKm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9FsD/fYIRRUyBuMDinB1j1GaxweIpWzuMAWQAkUN8PZNNkVt8MivHj5oELzjicQP
         WE33klN8gPpuaEGjwSB4yHKeHsLuEudhxjeXEpG6xvFne6VDsZJDC3UikebsOINpP7
         bndLRBki0Bk78D0ORQrg9dBbaQtmoVREux2d83hLV10e2H3UChniPsSTvcRPZXBgLO
         bvNfGjTmf4UrsbxQg7TY4fcxHLcPKz904EIWLcPSRfuQHG4DsZG5YYUnmNJDlYptNx
         Pmj9itD9SIOAW6S7C+2uRuUzlljYwF4PTf3ojlAH0J/x+QRGTmXRonn6DPU4YNliLm
         5jiFJQ8Pr5QtQ==
Date:   Thu, 25 Aug 2022 09:12:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alibek Omarov <a1ba.omarov@gmail.com>,
        Kornilios Kourtis <kornilios@isovalent.com>,
        Kui-Feng Lee <kuifeng@fb.com>, Yonghong Song <yhs@fb.com>,
        Luna Jernberg <droidbittin@gmail.com>, bpf@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] core: Conditionally define language encodings entries)
Message-ID: <YwefbJSpXBhCH8Tn@dev-arch.thelio-3990X>
References: <YwQRKkmWqsf/Du6A@kernel.org>
 <YwZQ0UkLsoa+6VyY@dev-arch.thelio-3990X>
 <YwZcuCj49wMkr18W@kernel.org>
 <YwZl9xaRplsFkWXb@kernel.org>
 <Ywd2zJA63QCkd3RL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywd2zJA63QCkd3RL@kernel.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 25, 2022 at 10:19:08AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 24, 2022 at 02:55:03PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Yeah, recent enough distros are all building ok, I'll try and add some
> > fallback for old distros.
> > 
> 
> Ok, now it builds everywhere:
> 
> [perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.86.14/pahole/dwarves-1.25.tar.xz
> [perfbuilder@five ~]$ export BUILD_CMD=buildcmd.sh
> [perfbuilder@five ~]$ dm -X
>      1	     4.07 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
>      2	     4.07 almalinux:9                   : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
>      3	     4.87 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
>      4	     5.47 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
>      5	     5.47 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
>      6	     5.27 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
>      7	     5.87 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1
>      8	     5.68 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 14.0.6
>      9	     3.27 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) 
>     10	     3.77 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
>     11	     4.17 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
>     12	     4.48 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 12.1.1 20220518 (ALT Sisyphus 12.1.1-alt1) , ALT Linux Team clang version 13.0.1
>     13	     3.77 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-15) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
>     14	     4.07 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
>     15	     5.38 archlinux:base                : Ok   gcc (GCC) 12.1.1 20220730 , clang version 14.0.6
>     16	     3.97 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
>     17	     4.17 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-15) , clang version 14.0.0 (Red Hat 14.0.0-1.module_el8.7.0+1142+5343df54)
>     18	     4.67 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 12.1.1 20220811 releases/gcc-12.1.0-341-g28a7b5df3b 
>     19	     4.07 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 
>     20	     4.27 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , Debian clang version 11.0.1-2~deb10u1
>     21	     4.07 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
>     22	     4.57 debian:experimental           : Ok   gcc (Debian 12.1.0-7) 12.1.0 , Debian clang version 14.0.6-2
>     23	     3.57 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) 
>     24	     4.07 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) 
>     25	     3.87 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) 
>     26	     4.07 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) 
>     27	     3.67 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) 
>     28	     3.98 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) 
>     29	     3.87 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) 
>     30	     4.77 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) 
>     31	     4.07 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
>     32	     4.07 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
>     33	     3.97 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
>     34	     4.37 fedora:34                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
>     35	     4.07 fedora:35                     : Ok   gcc (GCC) 11.3.1 20220421 (Red Hat 11.3.1-2) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
>     36	     4.37 fedora:36                     : Ok   gcc (GCC) 12.1.1 20220507 (Red Hat 12.1.1-1) , clang version 14.0.0 (Fedora 14.0.0-1.fc36)
>     37	     4.77 fedora:37                     : Ok   gcc (GCC) 12.1.1 20220628 (Red Hat 12.1.1-3) , clang version 14.0.5 (Fedora 14.0.5-6.fc37)
>     38	     7.77 fedora:38                     : Ok   gcc (GCC) 12.1.1 20220810 (Red Hat 12.1.1-4) , clang version 14.0.5 (Fedora 14.0.5-6.fc38)
>     39	     4.97 fedora:rawhide                : Ok   gcc (GCC) 12.1.1 20220810 (Red Hat 12.1.1-4) , clang version 14.0.5 (Fedora 14.0.5-6.fc38)
>     40	     4.37 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
>     41	     4.77 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
>     42	     3.87 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] 
>     43	     3.57 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 
>     44	     3.87 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
>     45	     5.31 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
>     46	     3.77 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 13.0.1
>     47	     4.68 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 12.1.1 20220629 [revision 7811663964aa7e31c3939b859bbfa2e16919639f] , clang version 14.0.6
>     48	     4.27 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
>     49	     3.96 oraclelinux:9                 : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9.4.0.2) , clang version 13.0.1 (Red Hat 13.0.1-1.0.1.el9)
>     50	     3.87 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10) , clang version 13.0.1 (Red Hat 13.0.1-2.module+el8.6.0+987+d36ea6a1)
>     51	     4.07 rockylinux:9                  : Ok   gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9) , clang version 13.0.1 (Red Hat 13.0.1-1.el9)
>     52	     3.47 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 
>     53	     3.57 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
>     54	     4.28 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0 
>     55	     4.17 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
>     56	     3.97 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
>     57	     4.27 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0 , Ubuntu clang version 14.0.0-1ubuntu1
>     58	     4.37 ubuntu:22.10                  : Ok   gcc (Ubuntu 11.3.0-5ubuntu1) 11.3.0 , Ubuntu clang version 14.0.6-2
> [perfbuilder@five ~]$
> 
> With this patch:
> 
> From c3eac0a3591a36f6590691a21434241d67a3fa89 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Thu, 25 Aug 2022 10:01:49 -0300
> Subject: [PATCH 1/1] core: Conditionally define language encodings
> 
> It it defined in an enumeration on dwarf.h, so doing it here as defines
> doesn't clash with it and makes this file to build with older distros.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thank you for the quick fix, it passed all of my build tests as well:

https://github.com/nathanchance/env/actions/runs/2927921590

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  dwarves.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/dwarves.c b/dwarves.c
> index db1dcf5904bc98fe..394a8155325484fc 100644
> --- a/dwarves.c
> +++ b/dwarves.c
> @@ -2085,6 +2085,118 @@ int cus__load_file(struct cus *cus, struct conf_load *conf,
>  
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>  
> +#ifndef DW_LANG_C89
> +#define DW_LANG_C89		0x0001
> +#endif
> +#ifndef DW_LANG_C
> +#define DW_LANG_C		0x0002
> +#endif
> +#ifndef DW_LANG_Ada83
> +#define DW_LANG_Ada83		0x0003
> +#endif
> +#ifndef DW_LANG_C_plus_plus
> +#define DW_LANG_C_plus_plus	0x0004
> +#endif
> +#ifndef DW_LANG_Cobol74
> +#define DW_LANG_Cobol74		0x0005
> +#endif
> +#ifndef DW_LANG_Cobol85
> +#define DW_LANG_Cobol85		0x0006
> +#endif
> +#ifndef DW_LANG_Fortran77
> +#define DW_LANG_Fortran77	0x0007
> +#endif
> +#ifndef DW_LANG_Fortran90
> +#define DW_LANG_Fortran90	0x0008
> +#endif
> +#ifndef DW_LANG_Pascal83
> +#define DW_LANG_Pascal83	0x0009
> +#endif
> +#ifndef DW_LANG_Modula2
> +#define DW_LANG_Modula2		0x000a
> +#endif
> +#ifndef DW_LANG_Java
> +#define DW_LANG_Java		0x000b
> +#endif
> +#ifndef DW_LANG_C99
> +#define DW_LANG_C99		0x000c
> +#endif
> +#ifndef DW_LANG_Ada95
> +#define DW_LANG_Ada95		0x000d
> +#endif
> +#ifndef DW_LANG_Fortran95
> +#define DW_LANG_Fortran95	0x000e
> +#endif
> +#ifndef DW_LANG_PLI
> +#define DW_LANG_PLI		0x000f
> +#endif
> +#ifndef DW_LANG_ObjC
> +#define DW_LANG_ObjC		0x0010
> +#endif
> +#ifndef DW_LANG_ObjC_plus_plus
> +#define DW_LANG_ObjC_plus_plus	0x0011
> +#endif
> +#ifndef DW_LANG_UPC
> +#define DW_LANG_UPC		0x0012
> +#endif
> +#ifndef DW_LANG_D
> +#define DW_LANG_D		0x0013
> +#endif
> +#ifndef DW_LANG_Python
> +#define DW_LANG_Python		0x0014
> +#endif
> +#ifndef DW_LANG_OpenCL
> +#define DW_LANG_OpenCL		0x0015
> +#endif
> +#ifndef DW_LANG_Go
> +#define DW_LANG_Go		0x0016
> +#endif
> +#ifndef DW_LANG_Modula3
> +#define DW_LANG_Modula3		0x0017
> +#endif
> +#ifndef DW_LANG_Haskell
> +#define DW_LANG_Haskell		0x0018
> +#endif
> +#ifndef DW_LANG_C_plus_plus_03
> +#define DW_LANG_C_plus_plus_03	0x0019
> +#endif
> +#ifndef DW_LANG_C_plus_plus_11
> +#define DW_LANG_C_plus_plus_11	0x001a
> +#endif
> +#ifndef DW_LANG_OCaml
> +#define DW_LANG_OCaml		0x001b
> +#endif
> +#ifndef DW_LANG_Rust
> +#define DW_LANG_Rust		0x001c
> +#endif
> +#ifndef DW_LANG_C11
> +#define DW_LANG_C11		0x001d
> +#endif
> +#ifndef DW_LANG_Swift
> +#define DW_LANG_Swift		0x001e
> +#endif
> +#ifndef DW_LANG_Julia
> +#define DW_LANG_Julia		0x001f
> +#endif
> +#ifndef DW_LANG_Dylan
> +#define DW_LANG_Dylan		0x0020
> +#endif
> +#ifndef DW_LANG_C_plus_plus_14
> +#define DW_LANG_C_plus_plus_14	0x0021
> +#endif
> +#ifndef DW_LANG_Fortran03
> +#define DW_LANG_Fortran03	0x0022
> +#endif
> +#ifndef DW_LANG_Fortran08
> +#define DW_LANG_Fortran08	0x0023
> +#endif
> +#ifndef DW_LANG_RenderScript
> +#define DW_LANG_RenderScript	0x0024
> +#endif
> +#ifndef DW_LANG_BLISS
> +#define DW_LANG_BLISS		0x0025
> +#endif
> +
>  int lang__str2int(const char *lang)
>  {
>  	static const char *languages[] = {
> -- 
> 2.37.2
> 
