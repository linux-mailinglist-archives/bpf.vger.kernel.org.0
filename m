Return-Path: <bpf+bounces-62569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D59DEAFBE53
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A33B5613BD
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 22:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351442877FA;
	Mon,  7 Jul 2025 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt3i60M7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A61CAA6C
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927986; cv=none; b=nbd4A/S4tO7ooRvE8qBFY9FeiFuf3fEhnOSM9Rl2SDWVbsZi5+dmJ7XLOEox/rqcWFa4lZ+cC8/Nrx1EnjsgWzEsX3OL48Pjz0CcNHyysd3YXQkCXXi5FiS3MRdwUgykOzanh81ICPacRwYKQZlXO8CngIkKq6wSGoaP2mUExeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927986; c=relaxed/simple;
	bh=Te1ou+UNsJnFOeIVOlzvHyA8KenGuBPb0pXdPgU6TwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4Gg4SeOSqS3ICBLI18xDci+g2HkttnlHLT/A/iXPdM+GWsmCL5Gr6eQsRgfkesI5zthUKVLkxA3fUHO6/4ZKP0qUTg5ODfsZPtiN6ouzOj9rgMhJnTjSBf/sWQsBET0u4M9SHnTkXOdVrOhrye2+4oeb5dIhexzF9qjH5WQF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt3i60M7; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so787598966b.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 15:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751927983; x=1752532783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te1ou+UNsJnFOeIVOlzvHyA8KenGuBPb0pXdPgU6TwA=;
        b=Nt3i60M7cavXGTwbgkywqtLlhSwKSDYkKzP3bG6D3jaj7pFY5RMPf420xOQGNhq872
         p27VCfcsGn96CaYelWqk83Pn688YYNtkuVpeLspkP5j6kL5TJJtq2qmzeOJmzA5mnqVW
         AgNib4aTEJEHg7hlCjOp2YhGh9FbQm1o3KipIAoAP8eW9nIqAzDZyO3Nx2c4gfv5sA5Q
         hK+NbbsjY/re+CmFLlwJOCvs6UrWIGkhm9+cEIa6dA8g/NXolCoN2ctfyH+zq3VnFtLQ
         XLFCQDmMqXneLRpE6Xxauxv8ClZ4ZqXpmnD473LHlHHXwoKnDE//DwWtfQEvmSVocfB+
         biJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751927983; x=1752532783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te1ou+UNsJnFOeIVOlzvHyA8KenGuBPb0pXdPgU6TwA=;
        b=oecOY6NVJDQZueouygqp9e478cg7Y0t5LPw+hdQVo81G2fefFv2+IU7AWFCB9DYofB
         tquQM8iJzAmn8FaynwPhjEjKpzvJ6ACXNST8uC+GK07+RxtvEZks83sDOzlhTfM7OLrn
         1q1JsQRXAy6FO5MQdOZLI/mlx3WSyFecQFxHi1NPJ0Cc5/8VdkL8RA+jAKgksKnVBm4k
         5k0HGXVM5O9ufN3LhbCIcALMPtYPgspGSonBD77djMp8S/pp5by8C5zGqiufYtv7gO3t
         VcUFYwbV8ygPCUblJ0HRZAEZjDslDg/iDMFRx22gBB8bnFOpKtRc6Usw5cHD9aipmxZP
         ZyjA==
X-Forwarded-Encrypted: i=1; AJvYcCVcTmNRRIhpjoZyGaLpgHbBsYl5U+cLrexfWyMupq5m5MJlcibODieyBDjdhs1dw7/bruA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUaWbJKdvVCaPLOKiYdVoDvbhYJbIwt1w+0lUVE+DshWtHgw+y
	U/ztYHvVdDsOJVOMyzzKHKxSSqpCwnU05J81OFqWl8AGRcZ1AABsSaEeenk4XlvPfnrN63U2fDX
	I4lxPiUHxDPYs1k2zhKniffK60MIOs+0=
X-Gm-Gg: ASbGncvQSe0jer5K2RmEPCL/hAsseTjScq3/n5HbG/m9GtuUptmz9ZdOWXbjNwGdRan
	+0GWzPasoKd2wXFmMx6qod2YK/wyk7RsvKoH+6tWs01iJ9Xo7/KU5qSvMoB1v413dl2LY1WF1bI
	HYO+G6yWpv56ejvY/7NWndTf5nejM1zl9UvLvd2Yd2RqLjzQ==
X-Google-Smtp-Source: AGHT+IF6xFXD43HwtcRZWtO2B9uDRSYhOHUUCU/cDdZJWuWPjFyZW2EANhVGf2F5OkBTykXDeYvsU2Wk0U0Bnk3Zfj0=
X-Received: by 2002:a17:907:60d1:b0:ae0:a597:2959 with SMTP id
 a640c23a62f3a-ae3fe6fc406mr1571096866b.32.1751927982642; Mon, 07 Jul 2025
 15:39:42 -0700 (PDT)
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
 <CAADnVQ+EiaoWUVcN9=Nm=RWJ6XE=Kcm8Q2FYQqWGJ_NsCtyJ=A@mail.gmail.com>
 <CAP01T74i8a4daQ1Cca5Eysy==hTKox-ovpc1Y==64M1LacATEQ@mail.gmail.com> <CAC1LvL2LkakWTBfqb40sL0S9u9HCqJWsGJiLNO8m-XwCL-fcXA@mail.gmail.com>
In-Reply-To: <CAC1LvL2LkakWTBfqb40sL0S9u9HCqJWsGJiLNO8m-XwCL-fcXA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 8 Jul 2025 00:39:05 +0200
X-Gm-Features: Ac12FXzHVcRxyFNGnd56eafTSoaPGBhba__oycgtzjUd5Tnm4oZjTBplczDLSDo
Message-ID: <CAP01T77mWuMBRyXZaNZN-7hoRnyd1LwaH85zS39tpX9Md71XaA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 3/4] bpf: Runtime part of fast-path termination approach
To: Zvi Effron <zeffron@riotgames.com>
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

On Tue, 8 Jul 2025 at 00:09, Zvi Effron <zeffron@riotgames.com> wrote:
>
> On Mon, Jul 7, 2025 at 12:17=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Mon, 7 Jul 2025 at 19:41, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jul 4, 2025 at 12:11=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Fri, 4 Jul 2025 at 19:29, Raj Sahu <rjsu26@gmail.com> wrote:
> > > > >
> > > > > > > Introduces watchdog based runtime mechanism to terminate
> > > > > > > a BPF program. When a BPF program is interrupted by
> > > > > > > an watchdog, its registers are are passed onto the bpf_die.
> > > > > > >
> > > > > > > Inside bpf_die we perform the text_poke and stack walk
> > > > > > > to stub helpers/kfunc replace bpf_loop helper if called
> > > > > > > inside bpf program.
> > > > > > >
> > > > > > > Current implementation doesn't handle the termination of
> > > > > > > tailcall programs.
> > > > > > >
> > > > > > > There is a known issue by calling text_poke inside interrupt
> > > > > > > context - https://elixir.bootlin.com/linux/v6.15.1/source/ker=
nel/smp.c#L815.
> > > > > >
> > > > > > I don't have a good idea so far, maybe by deferring work to wq =
context?
> > > > > > Each CPU would need its own context and schedule work there.
> > > > > > The problem is that it may not be invoked immediately.
> > > > > We will give it a try using wq. We were a bit hesitant in pursuin=
g wq
> > > > > earlier because to modify the return address on the stack we woul=
d
> > > > > want to interrupt the running BPF program and access its stack si=
nce
> > > > > that's a key part of the design.
> > > > >
> > > > > Will need some suggestions here on how to achieve that.
> > > >
> > > > Yeah, this is not trivial, now that I think more about it.
> > > > So keep the stack state untouched so you could synchronize with the
> > > > callback (spin until it signals us that it's done touching the stac=
k).
> > > > I guess we can do it from another CPU, not too bad.
> > > >
> > > > There's another problem though, wq execution not happening instantl=
y
> > > > in time is not a big deal, but it getting interrupted by yet anothe=
r
> > > > program that stalls can set up a cascading chain that leads to lock=
 up
> > > > of the machine.
> > > > So let's say we have a program that stalls in NMI/IRQ. It might hap=
pen
> > > > that all CPUs that can service the wq enter this stall. The kthread=
 is
> > > > ready to run the wq callback (or in the middle of it) but it may be
> > > > indefinitely interrupted.
> > > > It seems like this is a more fundamental problem with the non-cloni=
ng
> > > > approach. We can prevent program execution on the CPU where the wq
> > > > callback will be run, but we can also have a case where all CPUs lo=
ck
> > > > up simultaneously.
> > >
> > > If we have such bugs that prog in NMI can stall CPU indefinitely
> > > they need to be fixed independently of fast-execute.
> > > timed may_goto, tailcalls or whatever may need to have different
> > > limits when it detects that the prog is running in NMI or with hard i=
rqs
> > > disabled.
> >
> > I think a lot of programs end up running with hard IRQs disabled. Most
> > scheduler programs (which would use all these runtime checked
> > facilities) can fall into this category.
> > I don't think we can come up with appropriate limits without proper
> > WCET analysis.
> >
> > > Fast-execute doesn't have to be a universal kill-bpf-prog
> > > mechanism that can work in any context. I think fast-execute
> > > is for progs that deadlocked in res_spin_lock, faulted arena,
> > > or were slow for wrong reasons, but not fatal for the kernel reasons.
> > > imo we can rely on schedule_work() and bpf_arch_text_poke() from ther=
e.
> > > The alternative of clone of all progs and memory waste for a rare cas=
e
> > > is not appealing. Unless we can detect "dangerous" progs and
> > > clone with fast execute only for them, so that the majority of bpf pr=
ogs
> > > stay as single copy.
> >
> > Right, I sympathize with the memory overhead argument. But I think
> > just ignoring NMI programs as broken is not sufficient.
> > You can have some tracing program that gets stuck while tracing parts
> > of the kernel such that it prevents wq from making progress in
> > patching it out.
> > I think we will discover more edge cases. All this effort to then have
> > something working incompletely is sort of a bummer.
> >
> > Most of the syzbot reports triggering deadlocks were also not "real"
> > use cases, but we still decided to close the gap with rqspinlock.
> > When leaving the door open, it's hard to anticipate how the failure
> > mode in case fast-execute is not triggered will be.
> > I think let's try to see how bad cloning can be, if done
> > conditionally, before giving up completely on it.
> >
> > I think most programs won't use these facilities that end up extending
> > the total runtime beyond acceptable bounds.
> > Most legacy programs are not using cond_break, rqspinlock, or arenas.
> > Most network function programs and tracing programs probably don't use
> > these facilities as well.
>
> I can't speak to _most_, but doesn't BPF_MAP_TYPE_LPM_TRIE use rqspinlock=
? And
> isn't that map type frequently used by network programs (especially XDP
> filters) to do IP prefix lookups?
>
> So it wouldn't be uncommon for network programs (including "legacy" ones)=
 to
> use rqspinlock because they use a BPF map type that uses rqspinlock?

Right, good point.
We would probably need to penalize such a program when it triggers a deadlo=
ck.
That would require cloning if we don't go the text_poke() way.
So it may indeed end up covering most programs.
hashtab.c uses it too, which probably the majority of programs use.
Oh well, I guess it would be most of them then.
So it's hard to eliminate the memory overhead in cloning.

>
> > This can certainly change in the future, but I think unless pressing
> > use cases come up people would stick to how things are.
> > Schedulers are a different category and they will definitely make use
> > of all this.
> > So only triggering cloning when these are used sounds better to me,
> > even if not ideal.
> >
> > We can have some simple WCET heuristic that assigns fixed weights to
> > certain instructions/helpers, and compute an approximate cost which
> > when breached triggers cloning of the prog.
> > We can obviously disable cloning when we see things like bpf_for(i, 0, =
1000).
> > We can restrict it to specific subprogs where we notice specific
> > patterns requiring it, so we may be able to avoid the entire prog.
> > But for simplicity we can also just trigger cloning when one of
> > rqspinlock/cond_break/arenas/iterators/bpf_loop are used.
> >
> > The other option of course is to do run time checks of
> > prog->aux->terminate bit and start failing things that way.
> > Most of the time, the branch will be untaken. It can be set to 1 when
> > a prog detects a fatal condition or from a watchdog (later).
> > cond_break, rqspinlock, iterators, bpf_loop can all be adjusted to chec=
k it.
> >
> > When I was playing with all this, this is basically what I did
> > (amortized or not) and I think the overhead was negligible/in range of
> > noise.
> > If a prog is hot, the line with terminate bit is almost always in
> > cache, and it's not a load dependency for other accesses.
> > If it's not hot, the cost of every other state access dominates anyway.
> >

