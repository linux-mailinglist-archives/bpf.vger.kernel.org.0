Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F85935E6A7
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 20:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347716AbhDMSrN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347713AbhDMSrK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 14:47:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55417C061574
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 11:46:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r8so28840741lfp.10
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 11:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MkInGQBWLA4tQnVTeDHDhjhiRm6hD8zOBsmOgCNTK6s=;
        b=onRUsU7x1yZ3ym3ZMZvx/4w0EtI3WshSjLrIIYHnCpfpJ3V52SkR3EpUHyJn7kvD+3
         PZLCi8CuPIvJPtNRu71GYumkoChJjEoW3iDgOVOGFB9G3SHuuxW8F2LBL2fEjBYFtQCa
         G4WAo9Xhx0qB5clRwOQ2tc3rNTAbWP455KmLrO7IRh9FBsrnzdGyKOzOtH4d+QKvMLDK
         Qs4WOv/jnmOkXEVUZENS3YTtz2lAUuFNzFQg1f/H3+i40n6WlcKZ89lOvoVYKXKa7cWk
         TW3LbDcgok7iSac9b1BsuUo4TJQHcL0uhcGlbVhw3aHez7VdN0G2vXWaAWeZhLTzYmJY
         l7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkInGQBWLA4tQnVTeDHDhjhiRm6hD8zOBsmOgCNTK6s=;
        b=p1uf5440eTBFCfvXcLJXB6nkaqq8xhcw7YnrIi36vVe8AOfqQbHeQeLMLVHSBJzKG9
         n4rCK76EpRwghpBoE3L5/Fct9x+RTEoLGTA8mgyt4g5zr1bdNUOxqLnguOgaIUAFuJlf
         V7tIL73V93KOezyuqCOqtNMHp+ScXkJMuf6qaOj7jfr0sgECxk4Se2Bp5FVJaiz9GKTI
         KaQK+49WxKd10fTbl8gOIeiriQ2qYSra0cXVKJWFVsv4o9asKcsDRr8ddKRYSGOMb9Ql
         K3i+X2uQZqzDbmhsBtiECLwKXpG2ZyXKE71aEkpOIv1rq7iPlgJoQQbN8+DsHvY10XfT
         PPug==
X-Gm-Message-State: AOAM531Y2Q728HxfVaDHP0S/J9K1LYbzpYAzwSIBxBMfOgfy4cZ+oZyw
        xPN+LVcj26nsoQQKyIMeeXUOt3qq8Ru1aD1GHqAXMw==
X-Google-Smtp-Source: ABdhPJwRnT0IeXBHLSzIk++AYVb2zkt4n1FilG07p7BPya3R6e2izXCdFT+6FtQt8VUpIM4iLSzeOLLHewifeO26NbI=
X-Received: by 2002:a19:a410:: with SMTP id q16mr5910793lfc.73.1618339607630;
 Tue, 13 Apr 2021 11:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210412142905.266942-1-yhs@fb.com> <CAKwvOdkTUFUwq0Uwi4D9-Z9nbg1FfaP1P2oiBsxNn3+ikT9MwA@mail.gmail.com>
 <CAKwvOdkFWe76ggKrLeckS+mzmyQeq6eJBnkQM1bKgEGQBCspSA@mail.gmail.com> <e5f5f6b3-64e6-7068-ca72-9f06f3ffda54@fb.com>
In-Reply-To: <e5f5f6b3-64e6-7068-ca72-9f06f3ffda54@fb.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 13 Apr 2021 11:46:36 -0700
Message-ID: <CAKwvOdnJsQ-XDcjq=tbXL_iBeJYNk2h8VGwx-sSLWw_LRef6Qg@mail.gmail.com>
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

On Mon, Apr 12, 2021 at 5:31 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/12/21 5:02 PM, Nick Desaulniers wrote:
> > On Mon, Apr 12, 2021 at 4:58 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> >>
> >> On Mon, Apr 12, 2021 at 7:29 AM Yonghong Song <yhs@fb.com> wrote:
> >>>
> >>> To build kernel with clang, people typically use
> >>>    make -j60 LLVM=1 LLVM_IAS=1
> >>> LLVM_IAS=1 is not required for non-LTO build but
> >>> is required for LTO build. In my environment,
> >>> I am always having LLVM_IAS=1 regardless of
> >>> whether LTO is enabled or not.
> >>>
> >>> After kernel is build with clang, the following command
> >>> can be used to build selftests with clang:
> >>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
> >>
> >> Thank you for the series Yonghong.  When I test the above command with
> >> your series applied, I observe:
> >> tools/include/tools/libc_compat.h:11:21: error: static declaration of
> >> 'reallocarray' follows non-static declaration
> >> static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
> >>                      ^
> >> /usr/include/stdlib.h:559:14: note: previous declaration is here
> >> extern void *reallocarray (void *__ptr, size_t __nmemb, size_t __size)
> >>               ^
> >> so perhaps the detection of
> >> COMPAT_NEED_REALLOCARRAY/feature-reallocarray is incorrect?
> >
> > Is this related to _DEFAULT_SOURCE vs _GNU_SOURCE.  via man 3 reallocarray:
> >         reallocarray():
> >             Since glibc 2.29:
> >                 _DEFAULT_SOURCE
> >             Glibc 2.28 and earlier:
> >                 _GNU_SOURCE
> >
>
> You can try the following patch to see whether it works or not.
>
> diff --git a/tools/build/feature/test-reallocarray.c
> b/tools/build/feature/test-reallocarray.c
> index 8f6743e31da7..500cdeca07a7 100644
> --- a/tools/build/feature/test-reallocarray.c
> +++ b/tools/build/feature/test-reallocarray.c
> @@ -1,5 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
> +#define _DEFAULT_SOURCE
>   #include <stdlib.h>
>
>   int main(void)
> @@ -7,4 +7,4 @@ int main(void)
>          return !!reallocarray(NULL, 1, 1);
>   }
>
> -#undef _GNU_SOURCE
> +#undef _DEFAULT_SOURCE

Yeah, I had tried that. No luck though; same error message.  Even:

$ cat foo.c
#define _DEFAULT_SOURCE
#include <stdlib.h>
void *reallocarray(void *ptr, size_t nmemb, size_t size) { return (void*)0; };
$ clang -c foo.c
$ echo $?
0

So I'm not sure precisely what's going on here.  I probably have to go
digging around to understand tools/build/feature/ anyways.  With your
v3 applied, I consistently see:
No zlib found
and yet, I certainly do have zlib on my host.
https://stackoverflow.com/a/54558861

> [yhs@devbig003.ftw2 ~/work/bpf-next/tools/build]$
>
> > $ cd tools/testing/selftests/bpf
> > $ grep -rn _DEFAULT_SOURCE | wc -l
> > 0
> > $ grep -rn _GNU_SOURCE | wc -l
> > 37
> > $ ldd --version | head -n1
> > ldd (Debian GLIBC 2.31-9+build1) 2.31
> >



-- 
Thanks,
~Nick Desaulniers
