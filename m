Return-Path: <bpf+bounces-14651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA127E749C
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 23:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5EF28175B
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 22:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1251532C78;
	Thu,  9 Nov 2023 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkhJKkKE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AAD30CF5
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:57:49 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8714220
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 14:57:47 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9e28724ac88so237238466b.2
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 14:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699570666; x=1700175466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx4TBQrZ/O6IoihcuKX2O99Qq7o75kq8NfF2yTwZvWY=;
        b=mkhJKkKEmcc8VqNhzBcGFIXaTKPkv15NCsCZ6VDGk7exhbdbhamiKOuOG/lM70+0Q/
         YhCB2ROk/oja+mQd4perOSFEm1iUL/biK2r1U+K2YK0W/UXZbA/1fEcgNmbEBPBea9r8
         z0jBgGNNTn8Oh4MmEZ4RHGZAGqkWX0lYr9S9iEhiPVup4obdrNnrb+J+A1n+1UqGmKlv
         r7teHk2mh1cHAL7+6lX0sMogb8nKQ95iSHhiHEvVWaEGtzPktId1W8/PxPUorb1MUKnT
         7xgReYDObFG/8wRh7aS1Bvch5jI/eZArtoMREhB6gBAMZmXOKQDvTfi0/e1MRW+lUlr+
         dxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699570666; x=1700175466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fx4TBQrZ/O6IoihcuKX2O99Qq7o75kq8NfF2yTwZvWY=;
        b=qxw9Y1er44fPvYUxrRg18MOC9D5LLM503C54pDnRzWbig+ZYMsx8SI4/Y0M7PI9oEy
         u/kOy5/7maR+iu5PD7qiG+IZV5+K9OND+xmWBamwHiXnHlScoItbnwkDGsVsYryiEC3y
         Cqu/RuPOHoxbzF2hJ7VFXlOyK1c1CKzXxzfnx3AuhmRk+m66nxTHwa8XFkra+fJ2+6X3
         pUEjTil34lJ4kU+PqzA92NfF7LrxU/8WUJj088PvJF2icH8yq2M2NpS09FEYpm2X2xr0
         jQYref9CLn/GBYXAe2l31lCR/I5rJMcGyuZk6RBlW/nYUm9DFq3z74FdJetzUSc2cGjZ
         smDw==
X-Gm-Message-State: AOJu0YwC6133k6MISdwckmK2fo69nN2+rgGpIoirMVo0KSv2Tu/EfBVo
	w/IbCnIJXIRvif4rAQ068WrYGE7hwSzucuNun2An8qR1
X-Google-Smtp-Source: AGHT+IFQs1t2IQkeIRjrD5mx6gbteUr3vLO0lx7r7p+3UAzg+qPuoNHyhKR0pK3Cr7liq+qton23B0TCOv7VV1GS230=
X-Received: by 2002:a17:906:2654:b0:9e5:d313:fee7 with SMTP id
 i20-20020a170906265400b009e5d313fee7mr595372ejc.50.1699570665867; Thu, 09 Nov
 2023 14:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-2-andrii@kernel.org>
 <43f0d9f7219b74bfaff14b6496902f1056847de7.camel@gmail.com>
 <CAADnVQL6_o9z3z1=8o7qGNzAD8vKMZ+OetcYYy-1huxGfCJToA@mail.gmail.com>
 <CAEf4BzaA12xjXm8KZNB1mkVDOTtVDQDDWF4nYQtQ2qRYoTip3A@mail.gmail.com>
 <CAADnVQLGn4vRuZLqTm_t_9ff3t=Hsugr0j47YLThhPsnpNrs_Q@mail.gmail.com>
 <CAEf4BzY72H_0fF4C1kGbX5_ymNu6NHYf55HAnU8i5dnaQ+f_vA@mail.gmail.com>
 <CAEf4BzYn83g6TSwWcqqdcJBPB74kRs5iX73J9Vdrt7fT6VstdA@mail.gmail.com> <CAADnVQ+wd0MVVxxLKgTQiNTSZ34ZwqM84jmgcj-f87F97PgqSw@mail.gmail.com>
In-Reply-To: <CAADnVQ+wd0MVVxxLKgTQiNTSZ34ZwqM84jmgcj-f87F97PgqSw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 14:57:33 -0800
Message-ID: <CAEf4BzaWySecJbYQtVxqqJet=yh3aAyoW-_v9x33VjbMHH0PtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: use common jump (instruction) history
 across all states
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 2:06=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 12:39=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Nov 9, 2023 at 11:49=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Nov 9, 2023 at 11:29=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Nov 9, 2023 at 9:28=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > >
> > > > > If we ever break DFS property, we can easily change this. Or we c=
an
> > > > > even have a hybrid: as long as traversal preserves DFS property, =
we
> > > > > use global shared history, but we can also optionally clone and h=
ave
> > > > > our own history if necessary. It's a matter of adding optional
> > > > > potentially NULL pointer to "local history". All this is very nic=
ely
> > > > > hidden away from "normal" code.
> > > >
> > > > If we can "easily change this" then let's make it last and optional=
 patch.
> > > > So we can revert in the future when we need to take non-DFS path.
> > >
> > > Ok, sounds good. I'll reorder and put it last, you can decide whether
> > > to apply it or not that way.
> > >
> > > >
> > > > > But again, let's look at data first. I'll get back with numbers s=
oon.
> > > >
> > > > Sure. I think memory increase due to more tracking is ok.
> > > > I suspect it won't cause 2x increase. Likely few %.
> > > > The last time I checked the main memory hog is states stashed for p=
runing.
> > >
> > > So I'm back with data. See verifier.c changes I did at the bottom,
> > > just to double check I'm not missing something major. I count the
> > > number of allocations (but that's an underestimate that doesn't take
> > > into account realloc), total number of instruction history entries fo=
r
> > > entire program verification, and then also peak "depth" of instructio=
n
> > > history. Note that entries should be multiplied by 8 to get the amoun=
t
> > > of bytes (and that's not counting per-allocation overhead).
> > >
> > > Here are top 20 results, sorted by number of allocs for Meta-internal=
,
> > > Cilium, and selftests. BEFORE is without added STACK_ACCESS tracking
> > > and STACK_ZERO optimization. AFTER is with all the patches of this
> > > patch set applied.
> > >
> > > It's a few megabytes of memory allocation, which in itself is probabl=
y
> > > not a big deal. But it's just an amount of unnecessary memory
> > > allocations which is basically at least 2x of the total number of
> > > states that we can save. And instead have just a few reallocs to size
> > > global jump history to an order of magnitudes smaller peak entries.
> > >
> > > And if we ever decide to track more stuff similar to
> > > INSNS_F_STACK_ACCESS, we won't have to worry about more allocations o=
r
> > > more memory usage, because the absolute worst case is our global
> > > history will be up to 1 million entries tops. We can track some *code
> > > path dependent* per-instruction information for *each simulated
> > > instruction* easily without having to think twice about this. Which I
> > > think is a nice liberating thought in itself justifying this change.
> > >
> > >
> >
> > Gmail butchered tables. See Github gist ([0]) for it properly formatted=
.
> >
> >   [0] https://gist.github.com/anakryiko/04c5a3a5ae4ee672bd11d4b7b3d832f=
5
>
> I think 'peak insn history' is the one to look for, since
> it indicates total peak memory consumption. Right?

Hm... not really? Peak here is the longest sequence of recorded jumps
from root state to any "current". I calculated that to know how big
global history would be necessary.

But it's definitely not a total peak memory consumption, because there
will be states enqueued in a stack still to be processed, and we keep
their jmp_history around. see push_stack() and copy_verifier_state()
we do in that.

> It seems the numbers point out a bug in number collection or
> a bug in implementation.

yeah, but accounting implementation, I suspect. I think I'm not
handling failing states properly.

I'll double check and fix it up, but basically only failing BPF
programs should have bad accounting.

>
> before:
> verifier_loops1.bpf.linked3.o peak=3D499999
> loop3.bpf.linked3.o peak=3D111111
>
> which makes sense, since both tests hit 1m insn.
> I can see where 1/2 and 1/9 come from based on asm.
>
> after:
> verifier_loops1.bpf.linked3.o peak=3D25002
> loop3.bpf.linked3.o peak=3D333335
>
> So the 1st test got 20 times smaller memory footprint
> while 2nd was 3 times higher.
>
> Both are similar infinite loops.
>
> The 1st one is:
> l1_%=3D:  r0 +=3D 1;                                        \
>         goto l1_%=3D;                                     \
>
> My understanding is that there should be all 500k jmps in history with
> or without these patches.
>
> So now I'm more worried about the correctness of the 1st patch.

I'll look closer at what's going on and will report back.

