Return-Path: <bpf+bounces-62551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9C7AFBB9E
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 21:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEF93B4769
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 19:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C54262FD5;
	Mon,  7 Jul 2025 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPCZTxYi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548D2E3716
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915821; cv=none; b=cD1oTD6/eGmlO0y3bZ9VvnBn8xvXn+8LBzkHPCLSp5LGK76r+zpgj843TyAtwSZ7OlvRzwhVzDgae8uCrd1icv3pJQolimCo5qXLX0WwiXZjOpDN0ci65j1vy5N7fRRGHeIfzEyfKj40MYrOD8nXNatO07RN7/Vd5fdHck89z+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915821; c=relaxed/simple;
	bh=E90qwXP5j94aHKD17kcHsfIvpzhC4hdErRFCIGMp5ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reT4kRBpHC7/f6OlPX+0U9xB3NNWggOaYUuwrM2CnSi/yos0ELn5z9z7yBzr3kllbQq68Jse5oXIkgGk7Bt83aTygYEErcCm9XolsUhv4fgZO5npOk4zuaKWKVt50ij4PdkhzDoVR7wPCMaFKCfVLaxbjPjl2YR8ep0EOqsFwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPCZTxYi; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso751979266b.2
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751915818; x=1752520618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E90qwXP5j94aHKD17kcHsfIvpzhC4hdErRFCIGMp5ec=;
        b=TPCZTxYiFQ1vDQvtSrLqIPhWBcsQEby9HFzovNhZ2IoGZUqRLQqclVXILhfIs62RY+
         3Bb66KLCYG4i950UGbCauoaKRaEk+4PvA8rk//1JzHmP/bZi9eIEoy5XrELT+6Osj5t7
         ClLV42S6Iy8HlCicEg3mXm+cW2WbRdff9sMOZEM8Vzxp7nMblwmQRrxQaH8bOhVpGduU
         FZG4XW0+gDME8B0yfO1AzJvY8IXvxq/jNCNroCaJSlVCR0NOAFmpN8cmcD+01MXLABv1
         hJKAs+vj9Xx5X9zI4yu+gBITq/5qpRdERYrIX/GtqQrsbWcVBhtsSxOn0/kTIWrDCDzj
         bsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751915818; x=1752520618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E90qwXP5j94aHKD17kcHsfIvpzhC4hdErRFCIGMp5ec=;
        b=uNvXmrqFLOpKajNLuADMN0gj4uNT2jC1yeoziWGGQ1XjjwwEu3UTd2bmvW7tWtqA1E
         2zvsucj0KbnqpvhJZ4KLVX4xZ3AR9p8TsRRISare6OBaCw67Ce+wA9J2F61O+Ln031Bx
         IXeJQXo7TWFnnrVQ1TqiTZho31fkFPeo7Xy8BS0sfQXk0kSDaMtT09si5iDwpiCWyOzQ
         Sl9pn1FizVrpnL95v1qPe/W/4BPf5Ns9cJg9geQiFj4/g1ppYHnXTwAs3iSMcAgCJKlR
         LgcKaQPuAlYpKTRwwhyfYRTdXNMyT90KDbE1Bd4DJExh7IZKuNH8EjoYdU7ffiCiWbf/
         3bUg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Tk5zPFgUCScYaDB+XlFMd5U6CumLQ1w+v6QALcK6Aqz1hundDrD04qPaw5O7f9G1RY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoiynIZpqTzNKNDTgpowwTnksab1Afg1ZboSjwZJzW0CvqV4YG
	d7wb+/sRpCVeFMGyf6vqTS7kJoF/uzMtwjrstBLN8131MP4ssQ5GYCLFzsRowa2v9Lh0u/6+z68
	nYTHduZ02bEyPUHeqqOJVzI7GliFbTUM=
X-Gm-Gg: ASbGncupZ8htg6L2lmSYlOiFbSf1BIHBW8U+xmAknBGafXHZt6EdeY8gcBfl7Tt6He6
	weOkSLxeXds+QKG2OAhyd/dk+hfg3YxD+u3byUcO6JQraZKBFnwRAz0OfeLx0QmSO8KHQxken4v
	guncC9AgO4igfFLmZfxBKqzRaKMj3q5VkuREk7lOhXNipEWg==
X-Google-Smtp-Source: AGHT+IHIh9JqKM2auA0YA8Pcm/N7VQb0MPFECLouJQZrU1JgiCXKXtFQ6yg2Qf4lbf4dzfveUqkowTLYVwEPO3BXuBA=
X-Received: by 2002:a17:907:3c90:b0:ae3:bb4a:91fb with SMTP id
 a640c23a62f3a-ae3fe791ef6mr1363506366b.59.1751915817661; Mon, 07 Jul 2025
 12:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
 <20250614064056.237005-4-sidchintamaneni@gmail.com> <CAP01T77TBA3eEVoqGMVTpYsEzvg0f7Q95guH0SDQ3gZK=q+Tag@mail.gmail.com>
 <CAM6KYssFT35L5HN_Fes-2BdhEO6EmhF9Qa+WSWLML4qnZ0z1tA@mail.gmail.com>
 <CAP01T76S4X4f=owz9D7dXfv15=vD8HB8dO_Ni2TmKfqTKCtuhA@mail.gmail.com> <CAADnVQ+EiaoWUVcN9=Nm=RWJ6XE=Kcm8Q2FYQqWGJ_NsCtyJ=A@mail.gmail.com>
In-Reply-To: <CAADnVQ+EiaoWUVcN9=Nm=RWJ6XE=Kcm8Q2FYQqWGJ_NsCtyJ=A@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 7 Jul 2025 21:16:21 +0200
X-Gm-Features: Ac12FXyoLgoJ9YdWGxJYDHhEvy2ZpW0-s2BMNEasB1X9XzxSNlEEh7oxKWUV8x8
Message-ID: <CAP01T74i8a4daQ1Cca5Eysy==hTKox-ovpc1Y==64M1LacATEQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 3/4] bpf: Runtime part of fast-path termination approach
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Raj Sahu <rjsu26@gmail.com>, Siddharth Chintamaneni <sidchintamaneni@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, 
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	Jinghao Jia <jinghao7@illinois.edu>, egor@vt.edu, 
	Sai Roop Somaraju <sairoop10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Jul 2025 at 19:41, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 4, 2025 at 12:11=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri, 4 Jul 2025 at 19:29, Raj Sahu <rjsu26@gmail.com> wrote:
> > >
> > > > > Introduces watchdog based runtime mechanism to terminate
> > > > > a BPF program. When a BPF program is interrupted by
> > > > > an watchdog, its registers are are passed onto the bpf_die.
> > > > >
> > > > > Inside bpf_die we perform the text_poke and stack walk
> > > > > to stub helpers/kfunc replace bpf_loop helper if called
> > > > > inside bpf program.
> > > > >
> > > > > Current implementation doesn't handle the termination of
> > > > > tailcall programs.
> > > > >
> > > > > There is a known issue by calling text_poke inside interrupt
> > > > > context - https://elixir.bootlin.com/linux/v6.15.1/source/kernel/=
smp.c#L815.
> > > >
> > > > I don't have a good idea so far, maybe by deferring work to wq cont=
ext?
> > > > Each CPU would need its own context and schedule work there.
> > > > The problem is that it may not be invoked immediately.
> > > We will give it a try using wq. We were a bit hesitant in pursuing wq
> > > earlier because to modify the return address on the stack we would
> > > want to interrupt the running BPF program and access its stack since
> > > that's a key part of the design.
> > >
> > > Will need some suggestions here on how to achieve that.
> >
> > Yeah, this is not trivial, now that I think more about it.
> > So keep the stack state untouched so you could synchronize with the
> > callback (spin until it signals us that it's done touching the stack).
> > I guess we can do it from another CPU, not too bad.
> >
> > There's another problem though, wq execution not happening instantly
> > in time is not a big deal, but it getting interrupted by yet another
> > program that stalls can set up a cascading chain that leads to lock up
> > of the machine.
> > So let's say we have a program that stalls in NMI/IRQ. It might happen
> > that all CPUs that can service the wq enter this stall. The kthread is
> > ready to run the wq callback (or in the middle of it) but it may be
> > indefinitely interrupted.
> > It seems like this is a more fundamental problem with the non-cloning
> > approach. We can prevent program execution on the CPU where the wq
> > callback will be run, but we can also have a case where all CPUs lock
> > up simultaneously.
>
> If we have such bugs that prog in NMI can stall CPU indefinitely
> they need to be fixed independently of fast-execute.
> timed may_goto, tailcalls or whatever may need to have different
> limits when it detects that the prog is running in NMI or with hard irqs
> disabled.

I think a lot of programs end up running with hard IRQs disabled. Most
scheduler programs (which would use all these runtime checked
facilities) can fall into this category.
I don't think we can come up with appropriate limits without proper
WCET analysis.

> Fast-execute doesn't have to be a universal kill-bpf-prog
> mechanism that can work in any context. I think fast-execute
> is for progs that deadlocked in res_spin_lock, faulted arena,
> or were slow for wrong reasons, but not fatal for the kernel reasons.
> imo we can rely on schedule_work() and bpf_arch_text_poke() from there.
> The alternative of clone of all progs and memory waste for a rare case
> is not appealing. Unless we can detect "dangerous" progs and
> clone with fast execute only for them, so that the majority of bpf progs
> stay as single copy.

Right, I sympathize with the memory overhead argument. But I think
just ignoring NMI programs as broken is not sufficient.
You can have some tracing program that gets stuck while tracing parts
of the kernel such that it prevents wq from making progress in
patching it out.
I think we will discover more edge cases. All this effort to then have
something working incompletely is sort of a bummer.

Most of the syzbot reports triggering deadlocks were also not "real"
use cases, but we still decided to close the gap with rqspinlock.
When leaving the door open, it's hard to anticipate how the failure
mode in case fast-execute is not triggered will be.
I think let's try to see how bad cloning can be, if done
conditionally, before giving up completely on it.

I think most programs won't use these facilities that end up extending
the total runtime beyond acceptable bounds.
Most legacy programs are not using cond_break, rqspinlock, or arenas.
Most network function programs and tracing programs probably don't use
these facilities as well.
This can certainly change in the future, but I think unless pressing
use cases come up people would stick to how things are.
Schedulers are a different category and they will definitely make use
of all this.
So only triggering cloning when these are used sounds better to me,
even if not ideal.

We can have some simple WCET heuristic that assigns fixed weights to
certain instructions/helpers, and compute an approximate cost which
when breached triggers cloning of the prog.
We can obviously disable cloning when we see things like bpf_for(i, 0, 1000=
).
We can restrict it to specific subprogs where we notice specific
patterns requiring it, so we may be able to avoid the entire prog.
But for simplicity we can also just trigger cloning when one of
rqspinlock/cond_break/arenas/iterators/bpf_loop are used.

The other option of course is to do run time checks of
prog->aux->terminate bit and start failing things that way.
Most of the time, the branch will be untaken. It can be set to 1 when
a prog detects a fatal condition or from a watchdog (later).
cond_break, rqspinlock, iterators, bpf_loop can all be adjusted to check it=
.

When I was playing with all this, this is basically what I did
(amortized or not) and I think the overhead was negligible/in range of
noise.
If a prog is hot, the line with terminate bit is almost always in
cache, and it's not a load dependency for other accesses.
If it's not hot, the cost of every other state access dominates anyway.

