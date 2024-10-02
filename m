Return-Path: <bpf+bounces-40729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD25498C9FC
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 02:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086781C236E5
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 00:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18F01372;
	Wed,  2 Oct 2024 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3J1Gcvr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF410F7
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727828600; cv=none; b=IgzPv6lVc5aH+hpahS9y0U9zMJurmXR1DLWYfpZAF3vvGDzLznDiDmZtfwHz0Uvw+Su1U/bAWw4p+BbjqhQH6mC1mMX892NM1YBD9bl1+JfVqZQXK+5jw11SolU9RM3MWlsu9873r6CFFyVv6l2RT+h66e3T4cpUFc7vUZI+skY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727828600; c=relaxed/simple;
	bh=Bnkd2SOEFRLaAR/2B/R+kf+BlEmtF85hhCGWwdQLwds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6hLC1QLMVlrOYyK36eJtmCMW+9xtUahTEe62QVr7DD0kBfgKkF5tUu5hEQuDKKpMPSnNgG8mmP+1pQxPPYDeDSXLr9VEtJz126bCoIG2+XlFj/tAOjNtxpZGGqjudu6OIModtxsGPS2/PPNSRj20nDf83QZI0qPryfkYGDLXuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3J1Gcvr; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso7323077a12.1
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 17:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727828597; x=1728433397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bnkd2SOEFRLaAR/2B/R+kf+BlEmtF85hhCGWwdQLwds=;
        b=i3J1GcvrbmBHdYiAT5GWbKlkCvWq9T9mL4BnomZr0s3FhrC86OU4L9wa0xcdCefilh
         BmZfY/PYzu6/Dy2Nct7oXUGtqAzbjtc1pYl9+HydxoGI/Oa/dUg3BFanwlUhR4ASelFW
         A8Eruv75KDpzWpEzF6Zockwl+NtPxhQ3URQ/lJ1FkU1q/fVxRdc1M6MlrRXK+rwSOyAm
         qv/OeQHtiqXUZ6HfpwS+Sq/gVPzcVLA36fKNeIfelLP+yuCDwbYwFmCIiwL1dGyl9Evf
         4RnAGUnTVQVydfEHNucdCf4rpkz13vJAURAfJHEDOi9kXl4kXsPM3JUcnVVMCXywGk1U
         ch8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727828597; x=1728433397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bnkd2SOEFRLaAR/2B/R+kf+BlEmtF85hhCGWwdQLwds=;
        b=X/JpdP//4b6G/u+Toy4sY/MUavmsxnjHr8r1+upx4fwxiSw6nhjFdtrE87+paCq33W
         Yt2RahEgIHod8ME0aSKVJyvmL0GGxlBH7Je1hv8IiwEEGT9zX99OKOELzpudJ8Rig8AE
         BfMZbRRn2DJx/8fpKF+f1pmV2sntNt+C2VA1LE8x2p8A/HVrUYNGzfAXcW1Dz4mPup/5
         MyqnMGrwZGGIogcpTcVSUZFFI1Ig7rO2lYWLgPFI7eSbXpbsvQrmdq2d8laLF5qpYdfj
         TYORYdbiRYh2H2nhd3kJryQXfUaVjZlSkVyjts5eCDm3+nCnkmKBhHDCgycDezk5Shy1
         RwFw==
X-Forwarded-Encrypted: i=1; AJvYcCWtGEdREa/ubFVDLWKE5f+/08Ksd8vyivrfBcIIj8NVhx09EAlcElvzLVMvasN+Rrpc52U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8gZRo33oCWvycmt/Pv3GcMVyIiSoXOsOzEaAx2UrP9xHjFKe0
	R0VB7lB/Z3BIJs5kIxQhk4DC3NtI0MuZYc/PI1CLAxezAETBjZqO6Ij/POpxTblcE2YlWZfSBWk
	cAWS7+lhTbNJnmjIm+1t6FM2nDZY=
X-Google-Smtp-Source: AGHT+IEfTNK2xpyMXdtqNHX5M+LLUkBdnaN5itnXTAKEAJoMH2T3u9HTdKD+Y4KuSXp+RRG6aYdXXODjDP7oMOOEAow=
X-Received: by 2002:a05:6402:5294:b0:5a2:68a2:ae57 with SMTP id
 4fb4d7f45d1cf-5c8b1b8211cmr802481a12.31.1727828596631; Tue, 01 Oct 2024
 17:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev> <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
 <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com>
 <CAP01T76UnVfn3x7zZH4vJgZMGv_Ygewxg=9gUA-xuOa7pwGr3A@mail.gmail.com>
 <CAADnVQ+caNh8+fgCj2XeZDrXniYif5Y+rw6vsMOojBO3Qwk+Nw@mail.gmail.com>
 <CAADnVQKLWi_TfpbiYb1vPMYMqPOPWPS-RGbB0FksEQW5i36poQ@mail.gmail.com>
 <CAP01T77q_H31mPXPQV4xHifutxxFeuoD8eg75C717MZ=OOeHew@mail.gmail.com> <CAADnVQLfWgpu6WvZRCFo39YHJ=zSSQWcOnaCOqdfyCg8uRoddg@mail.gmail.com>
In-Reply-To: <CAADnVQLfWgpu6WvZRCFo39YHJ=zSSQWcOnaCOqdfyCg8uRoddg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 2 Oct 2024 02:22:40 +0200
Message-ID: <CAP01T77G63MGvomrd3563bgBcNKUZg0Jc=GGmcGO0zPLS0hcHA@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Oct 2024 at 23:28, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 1, 2024 at 1:51=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > On Tue, 1 Oct 2024 at 21:53, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > Another idea...
> > >
> >
> > Thanks for explaining why push/pop is still necessary. I agree then it
> > seems it cannot be avoided.
> >
> > > Currently the prologue looks like:
> > > push rbp
> > > mov rbp, rsp
> > > sub rsp, stack_depth
> > >
> > > how about in the main prog we keep the first two insns,
> > > but then set rsp with a single insn to point to the top
> > > of our private stack that should have enough room
> > > for stack_of_main_prog + stacks_of_all_subprogs + extra 8k for kfuncs=
/helpers.
> > >
> > > The prologue of all subprogs will stay as-is with above 3 insns.
> > > The epilogue is the same in main prog and subprogs: leave + ret.
> > >
> > > Such stack will look like a typical split stack used in compilers.
> > >
> > > The obvious advantage is we don't need to touch r9, do push/pop,
> > > and stack unwind will work just fine.
> > > In the past we discussed something like this, but
> > > then we did all 3 insns in the private stack
> > > and it was problematic due to IRQs.
> > > In this approach the main prog will use up to 512 bytes of
> > > kernel stack, but everything that it calls will be in the private sta=
ck,
> > > and since it doesn't migrate there is no per-cpu memory reuse issue.
> > >
> >
> > I think this is much better, but I'm wondering how the hierarchical
> > scheduling case will occur in reality.
> >
> > Will it be the main prog invoking a kfunc, that in turn invokes
> > another prog, which can do the same thing again?
>
> I believe that's the plan.
>
> > If so, the lack of using a private stack for main prog would be a
> > problem, right? Because effectively if we don't call into subprogs we
> > don't use the private stack at all, and all invocations share the same
> > kernel stack, which brings us back to the current state.
>
> Not quite. With the above proposal anything that the main prog
> calls (kfuncs, helpers, subprogs) will be using private stack
> prepared by that main prog.
> Then another 'struct bpf_prog' called from kfunc will use
> the stack prepared by the main prog and that 2nd main prog
> will prepare another priv stack for everything that 2nd main prog calls.
> So we can allow arbitrary depth.
> The only problem if the same 'struct bpf_prog' is called
> recursively (since it will use the same priv stack),
> but that issue we avoid with per prog recursion counter.
> So I think this proposal should work for all prog types
> except those where bpf_prog_check_recur() returns false.
>
> I think we can make it work with a special
> __bpf_prog_enter_limited_recur()
> that does this_cpu_inc_return(*(prog->active) and allows
> limited recursion (up to 4 ?) and then sets %rsp on entry
> to a different slot in preallocated private stack
> based on prog->active value.

Makes sense, though will we have cases where hierarchical scheduling
attaches the same prog at different points of the hierarchy? Then the
limit of 4 may not be enough (e.g. say with cgroup nested levels > 4).
It might be that all non-leaf progs simply call into the successor
prog until the leaf is hit and the actual logic kicks in. Then it
could all be the same progs while walking down the hierarchy until a
different prog is called for the leaf.

>
> > Instead can we set rbp to point to the top of the private stack in the
> > main prog itself?
>
> we cannot change both %rsp and %rbp atomically,
> so setting rsp and then adjusting rbp will break stack unwind.
> After 'mov %rsp, priv_stack_addr' we can do 2nd pair of
> push rbp
> mov rbp, rsp
> sub rsp, stack_size
> so that even the main prog will use the priv stack, but
> I'm not sure how unwinder will deal with that.
> So I would let the main prog use the kernel stack.

Ack. I think letting the main subprog use the kernel stack as you
propose is fine.

