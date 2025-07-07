Return-Path: <bpf+bounces-62567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A5BAFBE22
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89CE188FDA9
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 22:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D24028A719;
	Mon,  7 Jul 2025 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="Nstn7uIQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2304323D282
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926152; cv=none; b=e+iPeczwBJHZd+SsHLuqIlyYiYl1KOkKFrZJMN6tO6F55UnKJLzB7yR5z8zNgpSP2jqvO7cytUShzQs4sFYpwfgb9GBE4Y8fwlFGoWKF8VOgj8984BRtQDsDVUcOWdILry9eJjuPYIMl9pCaqJK3QeYRuSJB8deWnGs234i97xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926152; c=relaxed/simple;
	bh=Asm9EyM9ac3hP8pkwgyZumzz8aAxUfmJlAbNRMWcDFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4q7G36pYc/jMimRfC/rZPnvpa5l7IiMymb+9VOcAWWjYXo8llHlPoYH9AJ2qxHiH6qwqnBDY/S3tD8xEGjFzQEGmnZqxmcBS+aO2YrDiT+NBqziqHw2zKRrt8M92WrTMObpmvIIpm4u4upZIzAWoXqYy5pEXceqMMo/a38Q9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=Nstn7uIQ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso3949311a91.3
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 15:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1751926150; x=1752530950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Asm9EyM9ac3hP8pkwgyZumzz8aAxUfmJlAbNRMWcDFo=;
        b=Nstn7uIQRwoQi10V7vIvl4mK2dErm7xJ62HhW9WjSw7SAKHX6CN6tsZqPpG181i6vR
         voHYkCCkROGVEJMUbSrtWdFHvNae5rywiMT3omzO2r5+UhxWDp5BTs/HqLqAsv4nzRpQ
         HnKTY/svP0GL9dTDZRp76NFIJPcGhGkmfJXyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751926150; x=1752530950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Asm9EyM9ac3hP8pkwgyZumzz8aAxUfmJlAbNRMWcDFo=;
        b=hN5D/ACQj/u+fzq7lXeRRGhnjmJKu+jgkTqZlhqKyge1H3ogceTSMGTc7/4UsLzCoL
         ziu6ZmUpGX0psm7bAv1z4zKXN3PO4olVWCZmMfiFfyXrTk/1KYqODHLIL3G87y/Codhp
         kY2asDes0NMz+aRfbVCtWornbE+1cPb7wFBpXWJZDhv/I45nIyQZYQ54YXGdMZRO9EX3
         vIxBs65u3Wgxtb2V9Tz/q2QCjYenDGpO8E8jVLFHgVIDbrwNL3SBxzzBSPqksYKgrZA+
         mxr3wi1B3z/wxhT6PsJC17UA5pXMQzb4L5LtqTvxRhXkbwtqIB3aoreyNSj+OzpygllO
         ki0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeD/B9QDPogppyjRdt9mJsuodltPa+lVCafDLFnCjJA987HTDFaJ59h2efJCD8XXT8Hno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqhtux4NGLaM+NfXdSfG70CurbJpnM9cvHKOL1OwvPER0qaf/
	U3uEODzkDs+RExm8xlex1jZPZ2Jou5+an6xbU4XzzMSTE9GdBMyqVlqix6kbKj1m86SzhHV0Hzr
	s4nACxBf1aeRZ9yWOqgMO3ZiUGtz19LqoGJU4QtyrlQ==
X-Gm-Gg: ASbGncvfka/uTMKbQy2U2TwvX67blgqJGx1H/24ReocUu7DvkR/8ylXWSZMAYwOQtPA
	yUji2hdivwUM+kJzcwoMXD1PlB8q4q1qIeXz9U49GH1C+iSjxRickZfdsmCbPLWXNIg7IS4+/+O
	3+07PE151NHQE7QTOAsHOn9o9zfZe7YFt43ZrvbaWloA==
X-Google-Smtp-Source: AGHT+IGTZrVEqrq2Bcsb6TLw54MZ00TtJDpqPDEmaTh6ATHUkR7Ni+5DfUwQCmNOuqe+Ox4adShsuszVdVXACZYCQ8o=
X-Received: by 2002:a17:90b:33d1:b0:312:639:a064 with SMTP id
 98e67ed59e1d1-31aaddb4ac6mr19643954a91.28.1751926150364; Mon, 07 Jul 2025
 15:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
 <20250614064056.237005-4-sidchintamaneni@gmail.com> <CAP01T77TBA3eEVoqGMVTpYsEzvg0f7Q95guH0SDQ3gZK=q+Tag@mail.gmail.com>
 <CAM6KYssFT35L5HN_Fes-2BdhEO6EmhF9Qa+WSWLML4qnZ0z1tA@mail.gmail.com>
 <CAP01T76S4X4f=owz9D7dXfv15=vD8HB8dO_Ni2TmKfqTKCtuhA@mail.gmail.com>
 <CAADnVQ+EiaoWUVcN9=Nm=RWJ6XE=Kcm8Q2FYQqWGJ_NsCtyJ=A@mail.gmail.com> <CAP01T74i8a4daQ1Cca5Eysy==hTKox-ovpc1Y==64M1LacATEQ@mail.gmail.com>
In-Reply-To: <CAP01T74i8a4daQ1Cca5Eysy==hTKox-ovpc1Y==64M1LacATEQ@mail.gmail.com>
From: Zvi Effron <zeffron@riotgames.com>
Date: Mon, 7 Jul 2025 15:08:58 -0700
X-Gm-Features: Ac12FXzBHhmEMISC6l_g4oz4OPwXolrcEuFp4ekxNbEWo5ho0PJEeRABNvtZ4JE
Message-ID: <CAC1LvL2LkakWTBfqb40sL0S9u9HCqJWsGJiLNO8m-XwCL-fcXA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 3/4] bpf: Runtime part of fast-path termination approach
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Raj Sahu <rjsu26@gmail.com>, 
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, 
	doniaghazy@vt.edu, quanzhif@vt.edu, Jinghao Jia <jinghao7@illinois.edu>, egor@vt.edu, 
	Sai Roop Somaraju <sairoop10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 12:17=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 7 Jul 2025 at 19:41, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jul 4, 2025 at 12:11=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Fri, 4 Jul 2025 at 19:29, Raj Sahu <rjsu26@gmail.com> wrote:
> > > >
> > > > > > Introduces watchdog based runtime mechanism to terminate
> > > > > > a BPF program. When a BPF program is interrupted by
> > > > > > an watchdog, its registers are are passed onto the bpf_die.
> > > > > >
> > > > > > Inside bpf_die we perform the text_poke and stack walk
> > > > > > to stub helpers/kfunc replace bpf_loop helper if called
> > > > > > inside bpf program.
> > > > > >
> > > > > > Current implementation doesn't handle the termination of
> > > > > > tailcall programs.
> > > > > >
> > > > > > There is a known issue by calling text_poke inside interrupt
> > > > > > context - https://elixir.bootlin.com/linux/v6.15.1/source/kerne=
l/smp.c#L815.
> > > > >
> > > > > I don't have a good idea so far, maybe by deferring work to wq co=
ntext?
> > > > > Each CPU would need its own context and schedule work there.
> > > > > The problem is that it may not be invoked immediately.
> > > > We will give it a try using wq. We were a bit hesitant in pursuing =
wq
> > > > earlier because to modify the return address on the stack we would
> > > > want to interrupt the running BPF program and access its stack sinc=
e
> > > > that's a key part of the design.
> > > >
> > > > Will need some suggestions here on how to achieve that.
> > >
> > > Yeah, this is not trivial, now that I think more about it.
> > > So keep the stack state untouched so you could synchronize with the
> > > callback (spin until it signals us that it's done touching the stack)=
.
> > > I guess we can do it from another CPU, not too bad.
> > >
> > > There's another problem though, wq execution not happening instantly
> > > in time is not a big deal, but it getting interrupted by yet another
> > > program that stalls can set up a cascading chain that leads to lock u=
p
> > > of the machine.
> > > So let's say we have a program that stalls in NMI/IRQ. It might happe=
n
> > > that all CPUs that can service the wq enter this stall. The kthread i=
s
> > > ready to run the wq callback (or in the middle of it) but it may be
> > > indefinitely interrupted.
> > > It seems like this is a more fundamental problem with the non-cloning
> > > approach. We can prevent program execution on the CPU where the wq
> > > callback will be run, but we can also have a case where all CPUs lock
> > > up simultaneously.
> >
> > If we have such bugs that prog in NMI can stall CPU indefinitely
> > they need to be fixed independently of fast-execute.
> > timed may_goto, tailcalls or whatever may need to have different
> > limits when it detects that the prog is running in NMI or with hard irq=
s
> > disabled.
>
> I think a lot of programs end up running with hard IRQs disabled. Most
> scheduler programs (which would use all these runtime checked
> facilities) can fall into this category.
> I don't think we can come up with appropriate limits without proper
> WCET analysis.
>
> > Fast-execute doesn't have to be a universal kill-bpf-prog
> > mechanism that can work in any context. I think fast-execute
> > is for progs that deadlocked in res_spin_lock, faulted arena,
> > or were slow for wrong reasons, but not fatal for the kernel reasons.
> > imo we can rely on schedule_work() and bpf_arch_text_poke() from there.
> > The alternative of clone of all progs and memory waste for a rare case
> > is not appealing. Unless we can detect "dangerous" progs and
> > clone with fast execute only for them, so that the majority of bpf prog=
s
> > stay as single copy.
>
> Right, I sympathize with the memory overhead argument. But I think
> just ignoring NMI programs as broken is not sufficient.
> You can have some tracing program that gets stuck while tracing parts
> of the kernel such that it prevents wq from making progress in
> patching it out.
> I think we will discover more edge cases. All this effort to then have
> something working incompletely is sort of a bummer.
>
> Most of the syzbot reports triggering deadlocks were also not "real"
> use cases, but we still decided to close the gap with rqspinlock.
> When leaving the door open, it's hard to anticipate how the failure
> mode in case fast-execute is not triggered will be.
> I think let's try to see how bad cloning can be, if done
> conditionally, before giving up completely on it.
>
> I think most programs won't use these facilities that end up extending
> the total runtime beyond acceptable bounds.
> Most legacy programs are not using cond_break, rqspinlock, or arenas.
> Most network function programs and tracing programs probably don't use
> these facilities as well.

I can't speak to _most_, but doesn't BPF_MAP_TYPE_LPM_TRIE use rqspinlock? =
And
isn't that map type frequently used by network programs (especially XDP
filters) to do IP prefix lookups?

So it wouldn't be uncommon for network programs (including "legacy" ones) t=
o
use rqspinlock because they use a BPF map type that uses rqspinlock?

> This can certainly change in the future, but I think unless pressing
> use cases come up people would stick to how things are.
> Schedulers are a different category and they will definitely make use
> of all this.
> So only triggering cloning when these are used sounds better to me,
> even if not ideal.
>
> We can have some simple WCET heuristic that assigns fixed weights to
> certain instructions/helpers, and compute an approximate cost which
> when breached triggers cloning of the prog.
> We can obviously disable cloning when we see things like bpf_for(i, 0, 10=
00).
> We can restrict it to specific subprogs where we notice specific
> patterns requiring it, so we may be able to avoid the entire prog.
> But for simplicity we can also just trigger cloning when one of
> rqspinlock/cond_break/arenas/iterators/bpf_loop are used.
>
> The other option of course is to do run time checks of
> prog->aux->terminate bit and start failing things that way.
> Most of the time, the branch will be untaken. It can be set to 1 when
> a prog detects a fatal condition or from a watchdog (later).
> cond_break, rqspinlock, iterators, bpf_loop can all be adjusted to check =
it.
>
> When I was playing with all this, this is basically what I did
> (amortized or not) and I think the overhead was negligible/in range of
> noise.
> If a prog is hot, the line with terminate bit is almost always in
> cache, and it's not a load dependency for other accesses.
> If it's not hot, the cost of every other state access dominates anyway.
>

