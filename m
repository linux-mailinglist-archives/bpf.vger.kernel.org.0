Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669FD4A9EB1
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 19:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377382AbiBDSJ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 13:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377399AbiBDSJ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 13:09:56 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714A3C061748
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 10:09:54 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id x6so5503523ilg.9
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 10:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ziu6bEUtOzDCuSYgPNH8ZLsuHw4Dm+wfYQzq2T2Tqo8=;
        b=OloydyAQGDGkqE62B3vGc1qCi6FPldccgJBlrVNfhLZdw+0SqpCpblYuqJacTeHZTv
         aMM4o76G/0M0dmWSo6/SevaVB5XQO3Y0R+W2la4RGSD8oERdqLaQFrfAEnQJOiihY+ga
         LIlUoflnU1/WtIs39FQiVHNCEMCdQijAxuZ1UVQxKA4oobN/mU1CxdXBf+nWoJd3AD3Y
         Az3sytD4CBbMoCjiKvaBjo7bMqkKmTbUIe5/9zUnLyG2iTVWVGHAhSOqpYsyX9+RlYxb
         DED+fiMnHUyizvwkiU545mAEKDG0uly6SKbmI+X/KdXlVukkKj910Fds7Dr5qy1zWamS
         5UXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziu6bEUtOzDCuSYgPNH8ZLsuHw4Dm+wfYQzq2T2Tqo8=;
        b=dt/y0haFP23U7ZogVGNw/Q6wyq2jC0nTnZKqDMqEp79csohQJxJA1bJiGTCI9WEDkY
         OzsZDXF99CByRl2M0d7+DOBsa7GHNDUmwqF4dkm7hmh4FUeAHHICNTlKi3FOgF8aPe10
         Ek5vgEGJPprEmSZDz98+B3R7n8fgYD2K+PgVV14zn1Xn1ue6p22YQww9OtGRJqPosrD0
         Rn6mNAyKDDsqAkXmzsoVgNfQzhdK89GUiVK369FZYjbGoHhFsqy0fdO1R1Y6eQ/65MW7
         qtW1IjyZr96ZsngZvWj2927+rl0rZDLI2KYZq3W7B1hCBEXpwFh58UXqm+9i0OycVsgE
         5u6Q==
X-Gm-Message-State: AOAM530PkMsSDW5LH2zh3ju0QDKUAEQT6288fhzTG8ROzSDIWfqL+fO6
        IH9w46u9enoquzm5Z6ffFzkaM9mrEeC8FUXieV/sUGCz
X-Google-Smtp-Source: ABdhPJxPu2M4xCbktkuPGeTjF3KDjonmPJc+KU6WnbgdjuOJdNM9V1V2JPtp8eezd24VyOWgM0rMVhUMVsBzX6B0G04=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr177628ilu.71.1643998193840;
 Fri, 04 Feb 2022 10:09:53 -0800 (PST)
MIME-Version: 1.0
References: <20220204041955.1958263-1-iii@linux.ibm.com> <20220204041955.1958263-6-iii@linux.ibm.com>
 <CAEf4Bzbz-MP9QX-SaZ4+we1UnWvgiym_+aR580WdpewzmRKKNA@mail.gmail.com>
 <CAEf4Bza3CyG-1O20YbPNpNa25xP7MhcO3d0RwFpbENLmBXzBfQ@mail.gmail.com> <6f30bdf7afe29f379b058300fef9398004b3be35.camel@linux.ibm.com>
In-Reply-To: <6f30bdf7afe29f379b058300fef9398004b3be35.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Feb 2022 10:09:42 -0800
Message-ID: <CAEf4BzYYo7roeTb+09J+EvpXbPmvkXgCw1v4LoVLfFfbm=taww@mail.gmail.com>
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

On Fri, Feb 4, 2022 at 4:30 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Thu, 2022-02-03 at 21:23 -0800, Andrii Nakryiko wrote:
> > On Thu, Feb 3, 2022 at 9:22 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Feb 3, 2022 at 8:20 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > > wrote:
> > > >
> > > > Some architectures pass a pointer to struct pt_regs to syscall
> > > > handlers, others unpack it into individual function parameters.
> > > > Introduce a macro to describe what a particular arch does, using
> > > > `passing pt_regs *` as a default.
> > > >
> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > ---
> > > >  tools/lib/bpf/bpf_tracing.h | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/tools/lib/bpf/bpf_tracing.h
> > > > b/tools/lib/bpf/bpf_tracing.h
> > > > index 30f0964f8c9e..400a4f002f77 100644
> > > > --- a/tools/lib/bpf/bpf_tracing.h
> > > > +++ b/tools/lib/bpf/bpf_tracing.h
> > > > @@ -334,6 +334,15 @@ struct pt_regs;
> > > >
> > > >  #endif /* defined(bpf_target_defined) */
> > > >
> > > > +/*
> > > > + * When invoked from a syscall handler kprobe, returns a pointer
> > > > to a
> > > > + * struct pt_regs containing syscall arguments and suitable for
> > > > passing to
> > > > + * PT_REGS_PARMn_SYSCALL() and PT_REGS_PARMn_CORE_SYSCALL().
> > > > + */
> > > > +#ifndef PT_REGS_SYSCALL
> > > > +#define PT_REGS_SYSCALL(ctx) ((struct pt_regs
> > > > *)PT_REGS_PARM1(ctx))
> > > > +#endif
> > >
> > > maybe PT_REGS_SYSCALL_REGS? It returns regs, not the "syscall".
> > > PT_REGS prefix is for consistency with all other pt_regs macros,
> > > but
> > > "SYSCALL_REGS" is specifying what is actually returned by the macro
> > >
> >
> > Oh, and instead of casting to `struct pt_regs *` directly, maybe use
> > __PT_REGS_CAST() instead? For some architectures it probably should
> > stay user_pt_regs (or whatever it is there).
> >
> > > > +
> > > >  #ifndef ___bpf_concat
> > > >  #define ___bpf_concat(a, b) a ## b
> > > >  #endif
> > > > --
> > > > 2.34.1
> > > >
>
> I think it's better to keep this as struct pt_regs *, so that in
> bpf progs we can do
>
>         struct pt_regs *real_regs = PT_REGS_SYSCALL(ctx);
>
> without having to worry about which arch we are on, or using the
> opaque void *.

Makes sense, sounds good to me.
