Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768F535D43A
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 01:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbhDLX6k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 19:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbhDLX6k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 19:58:40 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B320C061574
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 16:58:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j18so24292888lfg.5
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnFwuB0dl3hcjRBVdGB2vdeeP7bbaNpyVnIEZjx0FDY=;
        b=KzX59tygEznFWAN4BkrgH30VYUcWM0wuKeyg8JA/SESqf1EjCex3NuidyrTI2AiNTg
         hICAfxG+NxBpaFW4lIxDwf3A4bsafkZLTpC5ZOvD9l2AVMm3rC9w3peNnoeERk1k1puh
         iTfVxbhmX2PXoYpNwI9rdkMaqj3DEevUtgfte3tRcg1jOAXXawFC89uVCWuuMihlbB75
         cFDjd4y5kUXTOGOSoWUluTcwx6TJW4N/R9kYHcrM/g9RGbJOvRohSPAQRirP0+kSUKAC
         9RDPCxf6vrZb7fkmCUCXVMW1/f72sMPINCwxkml1vDo7VwIJ2fzVv6iHXOCuPa8p0Int
         CSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnFwuB0dl3hcjRBVdGB2vdeeP7bbaNpyVnIEZjx0FDY=;
        b=jSLrKxH6ug1mhmnjMTTqoBNiaN1lo/nMEEuvNOxyl3r4YbL+rb8F+0NN0MTRfJo2c9
         gO+qyUPX5yAWE0xboIIvBN0grDTeGBqFG04gyybuhgF7LHZ7JpAkQdggAnsJXZMuQP1r
         /ydEx247xoBbAgRHEm4/ldBSni/D5x5pyd1WVE48DexSZPUeawQRHGwgrNgIyCoqmbUH
         DYxWwwL3L8QSdpPtrFtHrBtqbVW52p/lF9CH0nSzTJLs6UDphXhfdD3R/bMov1icxZEt
         8O/GxrLZBgw9uRwxgBVzVAjSSghugr5JonogQdPH5gDrGIUflxknvvBLNkmC4cw8L2I3
         2HGA==
X-Gm-Message-State: AOAM533oZB7nPVntRNVvDw/CxSdqJkCl/kqzIpwy+1HC//h0VbuB0oMU
        PyftMEEiUN8Bg7m73iPruL8nJ8M7NnYF+T1dWdd1ZUa91GWV6w==
X-Google-Smtp-Source: ABdhPJyxFrgTRPEocFBRWt2An4uwC49OSWOLqgykurlM0/YJtbp8DVL9yj3a3wb91tl/f7E/nLLBYl4f6gR8X2NMi7U=
X-Received: by 2002:a19:430e:: with SMTP id q14mr21802935lfa.374.1618271898588;
 Mon, 12 Apr 2021 16:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210412142905.266942-1-yhs@fb.com>
In-Reply-To: <20210412142905.266942-1-yhs@fb.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Apr 2021 16:58:07 -0700
Message-ID: <CAKwvOdkTUFUwq0Uwi4D9-Z9nbg1FfaP1P2oiBsxNn3+ikT9MwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 12, 2021 at 7:29 AM Yonghong Song <yhs@fb.com> wrote:
>
> To build kernel with clang, people typically use
>   make -j60 LLVM=1 LLVM_IAS=1
> LLVM_IAS=1 is not required for non-LTO build but
> is required for LTO build. In my environment,
> I am always having LLVM_IAS=1 regardless of
> whether LTO is enabled or not.
>
> After kernel is build with clang, the following command
> can be used to build selftests with clang:
>   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1

Thank you for the series Yonghong.  When I test the above command with
your series applied, I observe:
/usr/bin/ld: cannot find -lcap
clang-13: error: linker command failed with exit code 1 (use -v to see
invocation)

I need to install libcap-dev, but this also seems to imply that BFD is
being used as the linker, not LLD.  Perhaps if the compiler is being
used as the "driver" to also link executables, `-fuse-ld=lld` is
needed for the compiler flags.

Then there's:
tools/include/tools/libc_compat.h:11:21: error: static declaration of
'reallocarray' follows non-static declaration
static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
                    ^
/usr/include/stdlib.h:559:14: note: previous declaration is here
extern void *reallocarray (void *__ptr, size_t __nmemb, size_t __size)
             ^
so perhaps the detection of
COMPAT_NEED_REALLOCARRAY/feature-reallocarray is incorrect?


>
> But currently, using the above command, some compilations
> still use gcc and there are also compilation errors and warnings.
> This patch set intends to fix these issues.
> Patch #1 and #2 fixed the issue so clang/clang++ is
> used instead of gcc/g++. Patch #3 fixed a compilation
> failure. Patch #4 and #5 fixed various compiler warnings.
>
> Changelog:
>   v1 -> v2:
>     . add -Wno-unused-command-line-argument and -Wno-format-security
>       for clang only as (1). gcc does not exhibit those
>       warnings, and (2). -Wno-unused-command-line-argument is
>       only supported by clang. (Sedat)
>
> Yonghong Song (5):
>   selftests: set CC to clang in lib.mk if LLVM is set
>   tools: allow proper CC/CXX/... override with LLVM=1 in
>     Makefile.include
>   selftests/bpf: fix test_cpp compilation failure with clang
>   selftests/bpf: silence clang compilation warnings
>   bpftool: fix a clang compilation warning
>
>  tools/bpf/bpftool/net.c              |  2 +-
>  tools/scripts/Makefile.include       | 12 ++++++++++--
>  tools/testing/selftests/bpf/Makefile |  7 ++++++-
>  tools/testing/selftests/lib.mk       |  4 ++++
>  4 files changed, 21 insertions(+), 4 deletions(-)
>
> --
> 2.30.2
>


--
Thanks,
~Nick Desaulniers
