Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3854A935B
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 06:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbiBDFYB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 00:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbiBDFYA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 00:24:00 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C898C061714
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 21:24:00 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id s1so3956993ilj.7
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 21:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7HD8CuuGHb6IiK6bGY7xI7rYzvyc3PGtpbW+nr+wYoE=;
        b=hWcucTSGG/Xh4Kn556XVLwv7/PorrFr/UBNiuY7egH/lSC0z7LhQ9vN73pyFstm0sr
         w6FHCazHBsk5zel6B5GhvBQGyf2ySI959r4F6UxPDx8rTsx+GF0t7nPdzpkEC//7ecG8
         4wId7VFvCCj5NyYV+f8/yWma1IuRf4lHcK/gQDJOUiK9tL6GjQ3iC9hYbvK5tGheCNeJ
         6ZI1MDrzgWMWRW+LmYCkwohwrOexT1I+lYxS/5sCuURpJdZazKJBfmRmdEpb9P/0/Z1p
         WkqKFDy4GJ7zZfNv9cj8GGqVcnyt6ROhWjRwMc/1gjR9cX0RI94twPUiXcnzIE+X84dC
         t6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HD8CuuGHb6IiK6bGY7xI7rYzvyc3PGtpbW+nr+wYoE=;
        b=fqKzQqf0lw07SDpyh032zFQH6GJBJq6SZvFqYQ72+LMCkAG9oaLqYEuAGVBLVElcHm
         Jqs4lzx/Y999UlknBwKLxvjxUbLZTkimgHKOz7C/Qa8dSzAovdU/5flwp1QVNQMaIXba
         bi19Ilp54T2cPmqQcKE7lEAZjDxrBMAbSK/CYxHRvuUGrKqzprboDsFw+mnYcU+duU/y
         M2mbcrb8hJXEhf3XDj7f3BM7leadBZb+jI2GNKHjA9GKqk2hJWAwLm1XCLGqPp8lXBSQ
         wmj1pc88y4Ayunq6cGK2qRTr0A88w9FDQEvMvcg6Jz4hqsx9oDXcc2fZXe4hCly2Y/nY
         3RtA==
X-Gm-Message-State: AOAM5305TnpsptLnfuhjfmw+tsJqhkJ49MGcFyOUOOP65aKdbZxO+fch
        VI2OYJXrcA+XQrgmslTsmj5zxxgVMAanIAFxpIybfccTysA=
X-Google-Smtp-Source: ABdhPJyHsIGR8zxmQwkKSqQlIxFXqTtp6hBv6NbS3eKiUE+PspMHnrPQ/LjEOerWzqzhxH+lh/onArkj6qSs+l1nlWU=
X-Received: by 2002:a05:6e02:1bc7:: with SMTP id x7mr695793ilv.98.1643952239840;
 Thu, 03 Feb 2022 21:23:59 -0800 (PST)
MIME-Version: 1.0
References: <20220204041955.1958263-1-iii@linux.ibm.com> <20220204041955.1958263-6-iii@linux.ibm.com>
 <CAEf4Bzbz-MP9QX-SaZ4+we1UnWvgiym_+aR580WdpewzmRKKNA@mail.gmail.com>
In-Reply-To: <CAEf4Bzbz-MP9QX-SaZ4+we1UnWvgiym_+aR580WdpewzmRKKNA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Feb 2022 21:23:48 -0800
Message-ID: <CAEf4Bza3CyG-1O20YbPNpNa25xP7MhcO3d0RwFpbENLmBXzBfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/10] libbpf: Add PT_REGS_SYSCALL macro
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 3, 2022 at 9:22 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Feb 3, 2022 at 8:20 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > Some architectures pass a pointer to struct pt_regs to syscall
> > handlers, others unpack it into individual function parameters.
> > Introduce a macro to describe what a particular arch does, using
> > `passing pt_regs *` as a default.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  tools/lib/bpf/bpf_tracing.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > index 30f0964f8c9e..400a4f002f77 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -334,6 +334,15 @@ struct pt_regs;
> >
> >  #endif /* defined(bpf_target_defined) */
> >
> > +/*
> > + * When invoked from a syscall handler kprobe, returns a pointer to a
> > + * struct pt_regs containing syscall arguments and suitable for passing to
> > + * PT_REGS_PARMn_SYSCALL() and PT_REGS_PARMn_CORE_SYSCALL().
> > + */
> > +#ifndef PT_REGS_SYSCALL
> > +#define PT_REGS_SYSCALL(ctx) ((struct pt_regs *)PT_REGS_PARM1(ctx))
> > +#endif
>
> maybe PT_REGS_SYSCALL_REGS? It returns regs, not the "syscall".
> PT_REGS prefix is for consistency with all other pt_regs macros, but
> "SYSCALL_REGS" is specifying what is actually returned by the macro
>

Oh, and instead of casting to `struct pt_regs *` directly, maybe use
__PT_REGS_CAST() instead? For some architectures it probably should
stay user_pt_regs (or whatever it is there).

> > +
> >  #ifndef ___bpf_concat
> >  #define ___bpf_concat(a, b) a ## b
> >  #endif
> > --
> > 2.34.1
> >
