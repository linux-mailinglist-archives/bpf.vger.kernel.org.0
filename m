Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC134A9EC3
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 19:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiBDSPg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 13:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377473AbiBDSPf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 13:15:35 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E14C061714
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 10:15:35 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id y17so5562220ilm.1
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Rsuxk5Q3j9IWINQzyUelJm6TEHkYAFKF7Hg1wqxO9E=;
        b=TClM+UCyTCVdZzjDe31z7jaEzuV6LoooT0uFdWBWMCYad6xxNMY8nG5iFVHYT4/1D+
         ia/wePbHrt4z+6pmgzPi53QRsuttISubCrUEOoGdZHaxULflVjhiYxbMI1ydSlI0hxRU
         PAmPbLvCDmgs21JnHPO/uBvuN/UA4WSREJjO2J4qx3n7FspeGso48BdwXwUBruYcSpt1
         nWUWu8MhzxC+/1r+1ArLagddVVF0fLOg5NA/rOpWyf8Uz7oELn91mfRtVA23Glicpnrw
         Lt+C/YlWcYMxM93pdizbbC85ziJ4SjhaDeYQMQJCaWkpGwKm36ys5D2Iiufb/sCh225g
         luyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Rsuxk5Q3j9IWINQzyUelJm6TEHkYAFKF7Hg1wqxO9E=;
        b=G8drJbyIoLBohn3mhtvEYh9dFA9bSc9IVVvS/Nbq+xCJV0hBci5c86tShMrOqzv+sE
         y0Lvfkf5MgqE6fQVBqT2qcoTnjWquC2zkH33rSVnIy8xcmi50HjOQeSwSj4NG7cwFb1y
         HncTR1m6wmLEyBXjp21vc+AKkKNKdrd5/EBNvdutgtLGZm9TdJdORZPKXKSTViNcHdkk
         xys+cRFxDfFLZv25tsE1zmG6iV5Cu6BKwf33vqtp08KhMoFyFV55TLDlP90wyA6KxUa9
         DwKr+ChlYxwUOXntGdgwxFSKNt7X1nhtUwBdmvQ3MWjn4Dj6tk4epxbc3PTHEoeI7b7b
         YHoA==
X-Gm-Message-State: AOAM531koNstTV7lAhQ0Fh8RCsi9y1J2gHL3OslN53oNaKKOWpXCKf04
        jrAZ72s/USgtgrshrhXNBUIdfcYwANNlYIdmQVk=
X-Google-Smtp-Source: ABdhPJyYpCALIx8bwAGLlX34jy2czwYVaBHQ0+fAzePYqe7hZml7Fq/0UgQbOiPLudaCSBw541E5qz8oCfuAA9Dqnkw=
X-Received: by 2002:a05:6e02:1b81:: with SMTP id h1mr186546ili.239.1643998534635;
 Fri, 04 Feb 2022 10:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20220204145018.1983773-1-iii@linux.ibm.com> <20220204145018.1983773-6-iii@linux.ibm.com>
 <1643991537.bfyv1b2oym.naveen@linux.ibm.com>
In-Reply-To: <1643991537.bfyv1b2oym.naveen@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Feb 2022 10:15:23 -0800
Message-ID: <CAEf4BzY5tVGsGNy_Z0apLbbJ3L22Ov6q6+XwZo0_jn2oJCpmFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 05/11] libbpf: Add PT_REGS_SYSCALL_REGS macro
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 4, 2022 at 8:46 AM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> Ilya Leoshkevich wrote:
> > Some architectures pass a pointer to struct pt_regs to syscall
> > handlers, others unpack it into individual function parameters.
>
> I think that is just dependent on ARCH_HAS_SYSCALL_WRAPPER, so only x86,
> arm64 and s390 pass pointers to pt_regs to syscall entry points.
>
> > Introduce a macro to describe what a particular arch does, using
> > `passing pt_regs *` as a default.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  tools/lib/bpf/bpf_tracing.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > index 30f0964f8c9e..08d2990c006f 100644
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
> > +#ifndef PT_REGS_SYSCALL_REGS
> > +#define PT_REGS_SYSCALL_REGS(ctx) ((struct pt_regs *)PT_REGS_PARM1(ctx))
> > +#endif
> > +
>
> I think that name is misleading if an architecture doesn't implement syscall
> wrappers, since you are simply getting access to the kprobe pt_regs, rather
> than the syscall pt_regs. This can perhaps be named PT_REGS_SYSCALL_UNWRAP() or
> such to make that clear.

UNWRAP implies that there is something to unwrap, always. In case of
s390x, for example, there is nothing to unwrap. So I think
PT_REGS_SYSCALL_REGS() makes more sense, it just fetches correct
pt_regs to work with to get syscall input arguments (and it might be
exactly the same pt_regs that are passed in).

I think in practice most users won't ever have to use this, as we'll
add BPF_KPROBE_SYSCALL() macro, similar to BPF_KPROBE that we have
now, but specific to syscall kprobe.

>
> Also, should this just be keyed off a simpler HAS_SYSCALL_WRAPPER or such,
> rather than the other way around?

I think the way Ilya did it is totally fine.

>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 032ba809f3e57a..c72f285578d3fc 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -110,6 +110,8 @@
>
>  #endif /* __i386__ */
>
> +#define HAS_SYSCALL_WRAPPER
> +
>  #endif /* __KERNEL__ || __VMLINUX_H__ */
>
>  #elif defined(bpf_target_s390)
> @@ -126,6 +128,7 @@
>  #define __PT_RC_REG gprs[2]
>  #define __PT_SP_REG gprs[15]
>  #define __PT_IP_REG psw.addr
> +#define HAS_SYSCALL_WRAPPER
>
>  #elif defined(bpf_target_arm)
>
> @@ -154,6 +157,7 @@
>  #define __PT_RC_REG regs[0]
>  #define __PT_SP_REG sp
>  #define __PT_IP_REG pc
> +#define HAS_SYSCALL_WRAPPER
>
>  #elif defined(bpf_target_mips)
>
>
> We can then simply do:
>
> #ifdef HAS_SYSCALL_WRAPPER
> #define PT_REGS_SYSCALL_UNWRAP(ctx) ((struct pt_regs *)PT_REGS_PARM1(ctx))
> #else
> #define PT_REGS_SYSCALL_unwRAP(ctx) ((struct pt_regs *)(ctx))
> #endif
>
>
> Taking this a bit further, it would be nice if we can fold in progs/bpf_misc.h
> into bpf_traching.h by also including SYS_PREFIX.

As far as I know, SYS_PREFIX depends not just on architecture but also
on kernel version (older versions of x86-64 kernels didn't need that
prefix). For selftests, given they follow the latest version of kernel
it's ok to always append SYS_PREFIX, but generally speaking for user
BPF apps, they would need to be more careful and check whether they
need SYS_PREFIX or not. So I don't want to add SYS_PREFIX to
bpf_tracing.h because it's misleading.

>
>
> - Naveen
>
