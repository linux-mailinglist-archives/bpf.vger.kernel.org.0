Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576F935BA00
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 08:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhDLGHS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 02:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhDLGHS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 02:07:18 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA27C061574
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 23:07:01 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id b17so10011668ilh.6
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 23:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=gZL8CPuSFxYaHKrIrxs31jCc9N3Kv6YKpjYfleP6x30=;
        b=U/nfscG/0gBeNo/tHY4PCNgtElf57HmU4yR93On156u0rMixWmE737YsuXk5pZhVYS
         E8x5tIDmB/X1qom/166tGCfbkc4F3IDmdqo8/18dPAGouGueGLG3OM+vbfd7NhZTUIiT
         l5gyCZaQYznB5kSVwJO64RZID5AbRRHmT39SOtc+KrvxOakRM2wpmh+/p58NDVXCaEE3
         5VKyJFE5zAB2imvVIEMPeT+bO7RrJbe5T6Yk8d+KAsgYPvLLTHLi6yMfdDKW/SFfK4gl
         FySJR+aqSfPzwOUPhyaPojJq8Gmu6JSqRPhQdLF39nBq21kNj5ALZsP6DI2ILnC9COYR
         ZbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=gZL8CPuSFxYaHKrIrxs31jCc9N3Kv6YKpjYfleP6x30=;
        b=U4ialS3+6t+eRx04Ap518VSR/cc7JaR/tFM4TPCYOo94E136th6nLywg9Glu/kL0ZZ
         eGgWODKiKY+p3/ZARGGtWg6gxMbx4kKrjeUev9HVX/VEe8/Naqhhvgp5jh6XLVstMY45
         b6NrmzHDwBtGPVfuyjQrKoyyVC4QK44bXKj/FiXy5vbpI0IuQt6GTGG6D7VatZ/AFRSX
         xZUKxToYsHJWLHZEhLKMb9EAIV0jHMXvyiC8viLqfxdUd3SlMAe4Goa1MPnyLqfbURqN
         4A39DO1YgZX3DRb3LZcAOQqqbj2I18mzqyHWo7sr61BhwJ86l8L7c3kErBkUqgFyhLPr
         K8Tg==
X-Gm-Message-State: AOAM53365JhnwmNaJ0LMOctCKZB7II1bGNygzOqXkRw7ukOSwIZi2pG3
        gS7TJK3KDc90CL9Yi9+Ts3uxfe2AOK8Mb7UwFwM=
X-Google-Smtp-Source: ABdhPJwS5BHIjTp4bi1L74Bx5O1UBQyFaZCA+sT+v3LPqqdcY0fzTjeIigt2f+E1RQg43PDgt/uIOOvAkkaOfO7MUbM=
X-Received: by 2002:a05:6e02:dea:: with SMTP id m10mr14515354ilj.112.1618207620841;
 Sun, 11 Apr 2021 23:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210410164925.768741-1-yhs@fb.com> <20210410164940.770304-1-yhs@fb.com>
 <CA+icZUXzCpHWk8Vm5D4ZcCbdd9gqipVD5ALCw6SGTFbYfdJZiA@mail.gmail.com>
 <7c82c0f5-2a96-7a5c-b090-f26c9351786c@fb.com> <CA+icZUWwSg4Nd+AzAMx8Os4iAfs=40zeoYn0eVKg3Cy7fB5Cow@mail.gmail.com>
 <3f224f2c-bb7e-accc-b095-7fee8210861b@fb.com> <CA+icZUVPQT9WNona7xdmZP+2nS=xLn6hssd1wmLSeVNBzsOqTQ@mail.gmail.com>
 <1184be32-46d6-15a8-06b6-7e9bd26a88c6@fb.com>
In-Reply-To: <1184be32-46d6-15a8-06b6-7e9bd26a88c6@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 12 Apr 2021 08:06:26 +0200
Message-ID: <CA+icZUWYNFpL+ueU3i2+1N=C1s51BgRv0D1kusfhzZsYscMTUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: fix test_cpp compilation
 failure with clang
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 12, 2021 at 7:42 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/11/21 9:47 PM, Sedat Dilek wrote:
> > On Sun, Apr 11, 2021 at 9:08 PM Yonghong Song <yhs@fb.com> wrote:
> > [ ... ]
> >>> BTW, did you check (llvm-)objdump output?
> >>>
> >>> $ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep core_extern
> >>
> >> This is what I got with g++ compiled test_cpp:
> >>
> >> $ llvm-objdump -Dr test_cpp | grep core_extern
> >>     406a80: e8 5b 01 00 00                callq   0x406be0
> >> <_ZL25test_core_extern__destroyP16test_core_extern>
> >>     406ab9: e8 22 01 00 00                callq   0x406be0
> >> <_ZL25test_core_extern__destroyP16test_core_extern>
> >> 0000000000406be0 <_ZL25test_core_extern__destroyP16test_core_extern>:
> >>     406be3: 74 1a                         je      0x406bff
> >> <_ZL25test_core_extern__destroyP16test_core_extern+0x1f>
> >>     406bef: 74 05                         je      0x406bf6
> >> <_ZL25test_core_extern__destroyP16test_core_extern+0x16>
> >>
> >
> > What is the output when compiling with clang++ in your bpf-next environment?
>
> $ llvm-objdump -Dr test_cpp | grep core_extern
> $
>
> So looks like all test_core_extern_*() functions are inlined.
> This can be confirmed by looking at assembly code.
> while for gcc, there is still the call to
>    _ZL25test_core_extern__destroyP16test_core_extern
> which is
>    test_core_extern__destroy(test_core_extern*)
>
> This is just a difference between compiler optimizations
> between gcc and clang. We don't need to worry about this.
>

( My previous comment was from my samrtphone - so I started into my desktop. )

Thanks for your analysis and hint about inlining.

My inbox is full with that different handling of inlining "GCC vs. LLVM/Clang".

When I recall correctly and I have not to care about the inlining
optimization of clang++, then we can drop
"$(OUTPUT)/test_core_extern.skel.h" from the BPF selftests Makefile:

[ tools/testing/selftests/bpf/Makefile ]

# Make sure we are able to include and link libbpf against c++.
$(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
$(call msg,CXX,,$@)
$(Q)$(CXX) $(CFLAGS) test_cpp.cpp $(BPFOBJ) $(LDLIBS) -o $@

Note: This is with your patchset applied against Linus Git

As we have the include here:

[ tools/testing/selftests/bpf/test_cpp.cpp ]

/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
#include <iostream>
#include <bpf/libbpf.h>
#include <bpf/bpf.h>
#include <bpf/btf.h>
#include "test_core_extern.skel.h"
...

With and without keeping "test_core_extern.skel.h" I got the same
output with g++ and llvm-objdump.
Compiling with clang++ did not show that "CPP-file and C-header"
build-error when dropping "test_core_extern.skel.h" from the Makefile.

As said here all my testings with Linus Git not bpf-next.

Thanks for your precious time!

- Sedat -
