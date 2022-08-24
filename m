Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB75A002E
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 19:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiHXRPt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 13:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240189AbiHXRPr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 13:15:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF031DA5E;
        Wed, 24 Aug 2022 10:15:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD5AAB82543;
        Wed, 24 Aug 2022 17:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14508C433D6;
        Wed, 24 Aug 2022 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661361341;
        bh=k9o2Q3E5+a/u89eGTTu8XHPHlJiTDB5A9FmQy5ppO5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAy+gShcDYcWO9hFSgnkNy5y3RLT6XAjxEmrWSiIPnKcyjLlGYZUUH9T0pyCXcj+w
         k/HlDAzvheWoSms85NAW7NOJ+QzDlXsRYPARMWxRKFJZYlJetu0iIolqgLsn7wxIIj
         EMLzbJj3+XF4471lOZ8qjbrwnZAez1UiNKlgbC4LkgbYvfZG75VqPXJt4wZR+xv32i
         Jhi3jqy8TBZ18+ZY4QqJE2R4jUvGMZExpavr+mFdcrE/z+GfkA6S5JAbEzg6w5lYuU
         4E0nxg8vowXYOIlrZ/BUEcbI153x6h+rTf/kJZX0UmknchVjVGa4z1QwFYRdhzDf6N
         0Hv+8uERlxueA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 36C07404A1; Wed, 24 Aug 2022 14:15:36 -0300 (-03)
Date:   Wed, 24 Aug 2022 14:15:36 -0300
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
Message-ID: <YwZcuCj49wMkr18W@kernel.org>
References: <YwQRKkmWqsf/Du6A@kernel.org>
 <YwZQ0UkLsoa+6VyY@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwZQ0UkLsoa+6VyY@dev-arch.thelio-3990X>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Aug 24, 2022 at 09:24:49AM -0700, Nathan Chancellor escreveu:
> Hi Arnaldo,
> 
> On Mon, Aug 22, 2022 at 08:28:42PM -0300, Arnaldo Carvalho de Melo wrote:
> > Hi,
> >   
> > 	The v1.24 release of pahole and its friends is out, with faster
> > BTF generation by parallelizing the encoding part in addition to the
> > previoulsy parallelized DWARF loading, support for 64-bit BTF enumeration
> > entries, signed BTF encoding of 'char', exclude/select DWARF loading
> > based on the language that generated the objects, etc.
> 
> <snip>
> 
> > - Introduce --lang and --lang_exclude to specify the language the
> >   DWARF compile units were originated from to use or filter.
> 
> This appears to break building pahole with older versions of libdw (?).
> I build container images with older versions of compilers for easy
> matrix testing and my gcc-5 and gcc-6 images (based off Ubuntu Xenial
> and Debian Stretch respectively) fail to build.

I do it for perf, should have done it for pahole :-\

So I'll have to come up with a patch that checks if those are defined
and if not, define it :-\ Ooops, its an enumeration :-\ I'll have to
check how to fix this, thanks for the report!

Will rebuild it with the containers I have to see if there are other
cases.

- Arnaldo
 
>     $ podman run --rm -ti -v $TMP_FOLDER/dwarves-1.24.tar.xz:/tmp/dwarves-1.24.tar.xz:ro docker.io/ubuntu:xenial
>     # apt update
>     # apt install build-essential cmake libdw-dev libelf-dev xz-utils zlib1g-dev
>     # cd $(mktemp -d)
>     # tar -xJf /tmp/dwarves-1.24.tar.xz
>     # mkdir build
>     # cd build
>     # cmake -DBUILD_SHARED_LIBS=OFF -D__LIB=lib ../dwarves-1.24
>     # make -j$(nproc)
>     ...
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c: In function 'lang__str2int':
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2093:3: error: 'DW_LANG_BLISS' undeclared (first use in this function)
>       [DW_LANG_BLISS]   = "bliss",
>        ^
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2093:3: note: each undeclared identifier is reported only once for each function it appears in
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2093:3: error: array index in initializer not of integer type
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2093:3: note: (near initialization for 'languages')
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2100:3: error: 'DW_LANG_C_plus_plus_03' undeclared (first use in this function)
>       [DW_LANG_C_plus_plus_03] = "c++03",
>        ^
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2100:3: error: array index in initializer not of integer type
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2100:3: note: (near initialization for 'languages')
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2105:3: error: 'DW_LANG_Dylan' undeclared (first use in this function)
>       [DW_LANG_Dylan]   = "dylan",
>        ^
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2105:3: error: array index in initializer not of integer type
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2105:3: note: (near initialization for 'languages')
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2114:3: error: 'DW_LANG_Julia' undeclared (first use in this function)
>       [DW_LANG_Julia]   = "julia",
>        ^
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2114:3: error: array index in initializer not of integer type
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2114:3: note: (near initialization for 'languages')
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2116:3: error: 'DW_LANG_Modula3' undeclared (first use in this function)
>       [DW_LANG_Modula3]  = "modula3",
>        ^
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2116:3: error: array index in initializer not of integer type
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2116:3: note: (near initialization for 'languages')
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2119:3: error: 'DW_LANG_OCaml' undeclared (first use in this function)
>       [DW_LANG_OCaml]   = "ocaml",
>        ^
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2119:3: error: array index in initializer not of integer type
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2119:3: note: (near initialization for 'languages')
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2120:3: error: 'DW_LANG_OpenCL' undeclared (first use in this function)
>       [DW_LANG_OpenCL]  = "opencl",
>        ^
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2120:3: error: array index in initializer not of integer type
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2120:3: note: (near initialization for 'languages')
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2122:3: error: 'DW_LANG_PLI' undeclared (first use in this function)
>       [DW_LANG_PLI]   = "pli",
>        ^
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2122:3: error: array index in initializer not of integer type
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2122:3: note: (near initialization for 'languages')
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2124:3: error: 'DW_LANG_RenderScript' undeclared (first use in this function)
>       [DW_LANG_RenderScript]  = "renderscript",
>        ^
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2124:3: error: array index in initializer not of integer type
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2124:3: note: (near initialization for 'languages')
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2125:3: error: 'DW_LANG_Rust' undeclared (first use in this function)
>       [DW_LANG_Rust]   = "rust",
>        ^
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2125:3: error: array index in initializer not of integer type
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2125:3: note: (near initialization for 'languages')
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2126:3: error: 'DW_LANG_Swift' undeclared (first use in this function)
>       [DW_LANG_Swift]   = "swift",
>        ^
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2126:3: error: array index in initializer not of integer type
>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2126:3: note: (near initialization for 'languages')
>     CMakeFiles/dwarves.dir/build.make:62: recipe for target 'CMakeFiles/dwarves.dir/dwarves.c.o' failed
>     ...
> 
> If there is any additional information I can provide or patches I can
> test, please let me know!
> 
> Cheers,
> Nathan

-- 

- Arnaldo
