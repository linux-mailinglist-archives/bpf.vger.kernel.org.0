Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0994EC9350
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 23:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfJBVNb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 17:13:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39278 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbfJBVNb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 17:13:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so184637qki.6;
        Wed, 02 Oct 2019 14:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nS55Gc+Wv5/nS3zhWqKGsQA+EFTAinrmi2NmXLvOimM=;
        b=p5/RX4IYlDc7ukUBIt6El1HamNmNTdFO1AOqwKivIZtpuB59c9V4J7GnoqgOUeSkQ3
         5bxDF5IgF1YRRpSHWaCkbTdbAA0JXIwTJSomNFSwjcGgtfMRb3oKus1wRN4z5SmN+a7R
         Y8oV9TywyZ5rCm5wrVbjPUsAYTLKI8wnE0vhGeHFBM/9s6wA1O3Uzr8uswpp/Ti4gg8Y
         m/vIB6JQl7L0JBvxC5cSp8tY05kRmvEYSBQSGfsd4xMpxM0XhHY6M51ltN/BKA/So7Qa
         ZUFjaPguL1kE3gd1ESJ+CFhsz854H/0b2SLSoACfC7nk4B+JT3oOpc7+sOEcsphEesDJ
         EAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nS55Gc+Wv5/nS3zhWqKGsQA+EFTAinrmi2NmXLvOimM=;
        b=LN7mxXhMTSnBV+g/EKjYyLTv8WNbZTbiYJwcwSg1vssZfOygLGWsraZGabPvndzjmM
         Ph9I/6xjt/hUXSaxwa55cFdvnGwjfdvsC3ZyQO+0wFxdk3u7J31j6bHfqkNmmXnqxne2
         sPLhCeX+mFiqtJZzetx5AFLSOocWTc837cAbdtV3ZrHNfTssPdpU6yeZLS/pBtUROEiX
         uzh2qAs9KQpRpHcOTi1aOG28GhN9xe5DpN0vdNX5OYCxPhdknhV/1B0NT3lCad+BzGxa
         Hc5GZ3/YjpKmKE4a5T1qOXPBjgQceoppa4ETDEDqXzi59KOappVsbm6VFpooPy5CIf24
         8Y4A==
X-Gm-Message-State: APjAAAUXKP4iCz7ZbWd7U3wQLSI4IJkNAZOueAIzzxJkEyH8BaBgK3Zu
        CVewL8z1hFu3azL5Y8rAnpIKuJ8PUu3bQfYzxtM=
X-Google-Smtp-Source: APXvYqzOz103T/YDH9M3NoQFnxa0eSLeJtiSfsLzfA23Gn47+eYnLSS9ucBhmDfi6X5TsVTjxANWKXSDURw1zM2p+lw=
X-Received: by 2002:a37:4e55:: with SMTP id c82mr897485qkb.437.1570050808374;
 Wed, 02 Oct 2019 14:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191002191652.11432-1-kpsingh@chromium.org> <CAEf4BzY4tXd=sHbkN=Bbhj5=7=W_PBs_BB=wjGJ4-bHenKz6sw@mail.gmail.com>
 <E7A6B893-9E4B-4C22-A0CC-833AF45AF460@fb.com>
In-Reply-To: <E7A6B893-9E4B-4C22-A0CC-833AF45AF460@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Oct 2019 14:13:16 -0700
Message-ID: <CAEf4BzZ3jqKRap4h9n-JY=-Sp1RdsDDX=1fnX2ZPxbXURdnvvQ@mail.gmail.com>
Subject: Re: [PATCH v2] samples/bpf: Add a workaround for asm_inline
To:     Song Liu <songliubraving@fb.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 2, 2019 at 2:05 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Oct 2, 2019, at 1:22 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Oct 2, 2019 at 12:17 PM KP Singh <kpsingh@chromium.org> wrote:
> >>
> >> From: KP Singh <kpsingh@google.com>
> >>
> >> This was added in:
> >>
> >>  commit eb111869301e ("compiler-types.h: add asm_inline definition")
> >>
> >> and breaks samples/bpf as clang does not support asm __inline.
> >>
> >> Co-developed-by: Florent Revest <revest@google.com>
> >> Signed-off-by: Florent Revest <revest@google.com>
> >> Signed-off-by: KP Singh <kpsingh@google.com>
> >> ---
> >>
> >> Changes since v1:
> >>
> >> - Dropped the rename from asm_workaround.h to asm_goto_workaround.h
> >> - Dropped the fix for task_fd_query_user.c as it is updated in
> >>  https://lore.kernel.org/bpf/20191001112249.27341-1-bjorn.topel@gmail.com/
> >>
> >> samples/bpf/asm_goto_workaround.h | 13 ++++++++++++-
> >> 1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/samples/bpf/asm_goto_workaround.h b/samples/bpf/asm_goto_workaround.h
> >> index 7409722727ca..7048bb3594d6 100644
> >> --- a/samples/bpf/asm_goto_workaround.h
> >> +++ b/samples/bpf/asm_goto_workaround.h
> >> @@ -3,7 +3,8 @@
> >> #ifndef __ASM_GOTO_WORKAROUND_H
> >> #define __ASM_GOTO_WORKAROUND_H
> >>
> >> -/* this will bring in asm_volatile_goto macro definition
> >> +/*
> >> + * This will bring in asm_volatile_goto and asm_inline macro definitions
> >>  * if enabled by compiler and config options.
> >>  */
> >> #include <linux/types.h>
> >> @@ -13,5 +14,15 @@
> >> #define asm_volatile_goto(x...) asm volatile("invalid use of asm_volatile_goto")
> >> #endif
> >>
> >> +/*
> >> + * asm_inline is defined as asm __inline in "include/linux/compiler_types.h"
> >> + * if supported by the kernel's CC (i.e CONFIG_CC_HAS_ASM_INLINE) which is not
> >> + * supported by CLANG.
> >> + */
> >> +#ifdef asm_inline
> >> +#undef asm_inline
> >> +#define asm_inline asm
> >> +#endif
> >
> > Would it be better to just #undef CONFIG_CC_HAS_ASM_INLINE for BPF programs?
>
> I guess that is still useful when gcc fully support BPF?

Ah, I missed that it's Clang-specific, not BPF target-specific thing.
Yeah, then it makes sense.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>
> Thanks,
> Song
>
