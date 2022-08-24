Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267475A00ED
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbiHXSAD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 14:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbiHXR7i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 13:59:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE48277C;
        Wed, 24 Aug 2022 10:59:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x14-20020a17090a8a8e00b001fb61a71d99so2447112pjn.2;
        Wed, 24 Aug 2022 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc;
        bh=RZtJ7WFv27iGcxpx2iAvk1B4DM+wxHBEH/r6GSdGfcg=;
        b=Dbb8/yAXgGCJrsKLzLiips2OEaqFfOFGImmgWB0bSe1srHeYpkPAPQ99rBio9fXvDq
         EyCbVf3pzxsT6jT5FNMs6cLu4Oqu2CLSCyjzurb+w7eBHELmm7Z96/wzb23jUYy0D418
         gynhFZwTmew7uY0orm7Mm5mk+4KIXU1L4St35a+cuYzZxRq3pmpoAX9hf4xNfGMP3qbe
         h2ckez8fyPRt4hIGbmFvYso72lVNP0/mEGSef6OGyTC83JC6sgDNEYJ0ctxmA9iT95MF
         L9O6vdUoMZxCc337A8y2Hc8QvOeH6zVSjnaQA3JT6P05xl6hZQn4qT0LpqIoG3wdvxYL
         dp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RZtJ7WFv27iGcxpx2iAvk1B4DM+wxHBEH/r6GSdGfcg=;
        b=LHeXZlD7QG4HeyLM2CcHrZMuA675akIH2nnJ4WXXu5YpSiWbc+O21WceMkF96f4EaX
         ehq8Hw1tByXgv/D+k+ZEpDotEs0Fm7Lw73zjiZbtQQuHdFHbUqx7c8+Mn4DJxvwH86fT
         LzbJLJTSLtnUXuSdGposc0Mg00gN7TU//ryc1yXHJJuh4Uf1VF0uvHqv3xLi1kic9oF1
         TI5hbrBH58oEn+XVIcCCohWOPblwKcEbAYa6JZGcIi/4qK5LVggLhXNTM396uQXOm3xH
         kPEvsnYzHWcwWABKlN0uYGzbqpC+8NfuD0dKLsc02ZDxFKWXm/eQmKjsqHPahlcP8vjs
         4GeA==
X-Gm-Message-State: ACgBeo0bXdeS0+2399tezSV3AS06Yv2lhke20SzAEmXHejSpVx7HO49J
        gl4G0g+xMVM7VfRe4qfRNI3CeuhD5Ln6W146+K4=
X-Google-Smtp-Source: AA6agR4qaETV2m0oQP5t4+1BAaQRYaYBghErY31KDOWChcOlRELmJZkRoAmfNfBeKaqkd+3n+P2L7HTT+qXx/SwyB1Q=
X-Received: by 2002:a17:90b:1b0a:b0:1fb:8027:ead with SMTP id
 nu10-20020a17090b1b0a00b001fb80270eadmr291143pjb.185.1661363947908; Wed, 24
 Aug 2022 10:59:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:612:b0:43:c853:4cf0 with HTTP; Wed, 24 Aug 2022
 10:59:06 -0700 (PDT)
In-Reply-To: <YwZcuCj49wMkr18W@kernel.org>
References: <YwQRKkmWqsf/Du6A@kernel.org> <YwZQ0UkLsoa+6VyY@dev-arch.thelio-3990X>
 <YwZcuCj49wMkr18W@kernel.org>
From:   Luna Jernberg <droidbittin@gmail.com>
Date:   Wed, 24 Aug 2022 19:59:06 +0200
Message-ID: <CADo9pHi+120JrR2y0Zg5z=iaZsytDR3++P2YcuL9NmfLs1ydKw@mail.gmail.com>
Subject: Re: ANNOUNCE: pahole v1.24 (Faster BTF encoding, 64-bit BTF enum entries)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>, droidbittin@gmail.com
Cc:     Nathan Chancellor <nathan@kernel.org>, dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alibek Omarov <a1ba.omarov@gmail.com>,
        Kornilios Kourtis <kornilios@isovalent.com>,
        Kui-Feng Lee <kuifeng@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Great :)

On 8/24/22, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> Em Wed, Aug 24, 2022 at 09:24:49AM -0700, Nathan Chancellor escreveu:
>> Hi Arnaldo,
>>
>> On Mon, Aug 22, 2022 at 08:28:42PM -0300, Arnaldo Carvalho de Melo wrote:
>> > Hi,
>> >
>> > 	The v1.24 release of pahole and its friends is out, with faster
>> > BTF generation by parallelizing the encoding part in addition to the
>> > previoulsy parallelized DWARF loading, support for 64-bit BTF
>> > enumeration
>> > entries, signed BTF encoding of 'char', exclude/select DWARF loading
>> > based on the language that generated the objects, etc.
>>
>> <snip>
>>
>> > - Introduce --lang and --lang_exclude to specify the language the
>> >   DWARF compile units were originated from to use or filter.
>>
>> This appears to break building pahole with older versions of libdw (?).
>> I build container images with older versions of compilers for easy
>> matrix testing and my gcc-5 and gcc-6 images (based off Ubuntu Xenial
>> and Debian Stretch respectively) fail to build.
>
> I do it for perf, should have done it for pahole :-\
>
> So I'll have to come up with a patch that checks if those are defined
> and if not, define it :-\ Ooops, its an enumeration :-\ I'll have to
> check how to fix this, thanks for the report!
>
> Will rebuild it with the containers I have to see if there are other
> cases.
>
> - Arnaldo
>
>>     $ podman run --rm -ti -v
>> $TMP_FOLDER/dwarves-1.24.tar.xz:/tmp/dwarves-1.24.tar.xz:ro
>> docker.io/ubuntu:xenial
>>     # apt update
>>     # apt install build-essential cmake libdw-dev libelf-dev xz-utils
>> zlib1g-dev
>>     # cd $(mktemp -d)
>>     # tar -xJf /tmp/dwarves-1.24.tar.xz
>>     # mkdir build
>>     # cd build
>>     # cmake -DBUILD_SHARED_LIBS=OFF -D__LIB=lib ../dwarves-1.24
>>     # make -j$(nproc)
>>     ...
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c: In function
>> 'lang__str2int':
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2093:3: error:
>> 'DW_LANG_BLISS' undeclared (first use in this function)
>>       [DW_LANG_BLISS]   = "bliss",
>>        ^
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2093:3: note: each
>> undeclared identifier is reported only once for each function it appears
>> in
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2093:3: error: array index
>> in initializer not of integer type
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2093:3: note: (near
>> initialization for 'languages')
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2100:3: error:
>> 'DW_LANG_C_plus_plus_03' undeclared (first use in this function)
>>       [DW_LANG_C_plus_plus_03] = "c++03",
>>        ^
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2100:3: error: array index
>> in initializer not of integer type
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2100:3: note: (near
>> initialization for 'languages')
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2105:3: error:
>> 'DW_LANG_Dylan' undeclared (first use in this function)
>>       [DW_LANG_Dylan]   = "dylan",
>>        ^
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2105:3: error: array index
>> in initializer not of integer type
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2105:3: note: (near
>> initialization for 'languages')
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2114:3: error:
>> 'DW_LANG_Julia' undeclared (first use in this function)
>>       [DW_LANG_Julia]   = "julia",
>>        ^
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2114:3: error: array index
>> in initializer not of integer type
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2114:3: note: (near
>> initialization for 'languages')
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2116:3: error:
>> 'DW_LANG_Modula3' undeclared (first use in this function)
>>       [DW_LANG_Modula3]  = "modula3",
>>        ^
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2116:3: error: array index
>> in initializer not of integer type
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2116:3: note: (near
>> initialization for 'languages')
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2119:3: error:
>> 'DW_LANG_OCaml' undeclared (first use in this function)
>>       [DW_LANG_OCaml]   = "ocaml",
>>        ^
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2119:3: error: array index
>> in initializer not of integer type
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2119:3: note: (near
>> initialization for 'languages')
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2120:3: error:
>> 'DW_LANG_OpenCL' undeclared (first use in this function)
>>       [DW_LANG_OpenCL]  = "opencl",
>>        ^
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2120:3: error: array index
>> in initializer not of integer type
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2120:3: note: (near
>> initialization for 'languages')
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2122:3: error:
>> 'DW_LANG_PLI' undeclared (first use in this function)
>>       [DW_LANG_PLI]   = "pli",
>>        ^
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2122:3: error: array index
>> in initializer not of integer type
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2122:3: note: (near
>> initialization for 'languages')
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2124:3: error:
>> 'DW_LANG_RenderScript' undeclared (first use in this function)
>>       [DW_LANG_RenderScript]  = "renderscript",
>>        ^
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2124:3: error: array index
>> in initializer not of integer type
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2124:3: note: (near
>> initialization for 'languages')
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2125:3: error:
>> 'DW_LANG_Rust' undeclared (first use in this function)
>>       [DW_LANG_Rust]   = "rust",
>>        ^
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2125:3: error: array index
>> in initializer not of integer type
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2125:3: note: (near
>> initialization for 'languages')
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2126:3: error:
>> 'DW_LANG_Swift' undeclared (first use in this function)
>>       [DW_LANG_Swift]   = "swift",
>>        ^
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2126:3: error: array index
>> in initializer not of integer type
>>     /tmp/tmp.pQ2GsHbGAx/dwarves-1.24/dwarves.c:2126:3: note: (near
>> initialization for 'languages')
>>     CMakeFiles/dwarves.dir/build.make:62: recipe for target
>> 'CMakeFiles/dwarves.dir/dwarves.c.o' failed
>>     ...
>>
>> If there is any additional information I can provide or patches I can
>> test, please let me know!
>>
>> Cheers,
>> Nathan
>
> --
>
> - Arnaldo
>
