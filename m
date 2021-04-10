Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836DC35B012
	for <lists+bpf@lfdr.de>; Sat, 10 Apr 2021 21:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhDJTUP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Apr 2021 15:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbhDJTUN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Apr 2021 15:20:13 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA392C06138B
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 12:19:58 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s16so4091582iog.9
        for <bpf@vger.kernel.org>; Sat, 10 Apr 2021 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=xgkO2ESp6uFztUQZqA6oMVu1vokwSusfDdfaSnmRr0k=;
        b=MC3oC6ZajUjR/nCzIYQXYlTi8I95AXEduyDxaFls+SXlIvGmROvxBd54YMOw03XR+V
         FQgfQ1g33IW5EMxEhr6jjuZpZ9l68UMQ/TBeFxWkwzWoAoKF2vo2Vn7ZM7n54PcNCCyF
         ZA462pY3Q8cu6XAYMW2loFKbFlpGdCifKIEZM70EYUGq362Svk+skkF/PrW5DiO4scTs
         CsQIODt0EFwqiOONUJEmeJ9dD8RYcxxsXxy1nt031S6JyjspNLAI9q4FJLRpZiVdz3A4
         XTc1SKhGgcwLZAiDNVd+tmo9B3FlU8dE72ubskONHvKRAoeMbTeGaPTbqmhjuwI8QhFh
         tmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=xgkO2ESp6uFztUQZqA6oMVu1vokwSusfDdfaSnmRr0k=;
        b=JuFyuXANZKI2f9G/hdRRZQoXw5azBvLq8iTwl5eJXJocmWF47bIi6djIITTczjwqkv
         Me0siNrGR450tFyfZQa+pQ6fBhnZ3UMrA6QAlEcQxGl7kmCArYKK1IFDkhDJiuEjxAho
         NV0mx2kBmEWamjYBwELZDjAbAEsbNzphCEXhnxWQl7BjmVXnCaxg212abKkJu8hrvLVT
         HxtQzQP4X5lvs9RJdYxGCQKbiGlkPJ+oWVSk4AFZr+of0w2dulZO0NH/EzdnJR3AKht0
         iLnvRBdLAK9Yfr6ObxLz4CiiXYkphZe7oNxzpIzeKqcNx/HrrhQtQ5nPsxtOsrdqz+jE
         zzSw==
X-Gm-Message-State: AOAM530QZj/ur4fuidS0jQHFSCRiryCyaAxhQNBX3A02va5t6MShVF4z
        eu0kdu2HGq3J4GqXt5FBGoeSVJZzdCU2KMG3Thw=
X-Google-Smtp-Source: ABdhPJxA3XcIhhlI8EVHuLpulVTpkf9s69E0Qh9sc3G6RPKWpEPofCghg4kuYJ/UAeWbDgWp7uVkSRVq/WlAm1xDumI=
X-Received: by 2002:a6b:8bd3:: with SMTP id n202mr2925815iod.57.1618082398105;
 Sat, 10 Apr 2021 12:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210410164925.768741-1-yhs@fb.com>
In-Reply-To: <20210410164925.768741-1-yhs@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 10 Apr 2021 21:19:21 +0200
Message-ID: <CA+icZUVz0US1y7LSkk_cvq5bOrTok0LqVSCLkUukmyde5aChpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] support build selftests/bpf with clang
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
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
>
> But currently, some compilations still use gcc
> and there are also compilation errors and warnings.
> This patch set intends to fix these issues.
> Patch #1 and #2 fixed the issue so clang/clang++ is
> used instead of gcc/g++. Patch #3 fixed a compilation
> failure. Patch #4 and #5 fixed various compiler warnings.
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
>  tools/testing/selftests/bpf/Makefile |  4 +++-
>  tools/testing/selftests/lib.mk       |  4 ++++
>  4 files changed, 18 insertions(+), 4 deletions(-)
>
> --
> 2.30.2
>

Thanks for CCing me and taking care to clean BPF selftests with clang.

I applied (adapted 4/5) the 5 patches to fit latest Linus Git.

As I had a fresh compiled Clang-CFI kernel without enabling BTF
debug-info KConfig this fails at some point.
I am not sure what the situation is with Clang-CFI + BTF thus I will
do another Clang-LTO build with BTF enabled.
So, I was not able to build test_cpp.

I am missing some comments that LLVM=1 misses to set CXX=clang++ if
people want that explicitly as CXX.
Did you try with this?

AFAICS LC_ALL=C was not the culprit.
Did you try with and without LC_ALL=C - I have this in all my build-scripts.
Here I have German localisation as default.

Wil report later... (might be Monday when Linux v5.12-rc7 is released).

- Sedat -
