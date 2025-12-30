Return-Path: <bpf+bounces-77494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9A6CE86F8
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 01:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01EE13010A82
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 00:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608082DAFD7;
	Tue, 30 Dec 2025 00:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjlvxpcP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F371DF736
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767055353; cv=none; b=mGcECZH0kHj6PWVaMRQqNq2TH4ywKHCVIykkPzZdRZs2o719X0noGpV+6XqEcszR/HeVCEwYc0+ZKuLb9qT/WvoxuClFKhI3xSX2Q15+Mmyb+AMPjx9QEeAUfvtTXBQpnZ6Z+A+EhjzcBu/G5Co0RR3Qa+bFHF9HAnNsWInnm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767055353; c=relaxed/simple;
	bh=3ncqDlJ6xuyphhlFTZzw9mX/PJjKmR4VmWm5V2m3+hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBCTXgnMWJn/Cp1clpkBqwNDDdTcHb2nsLuf/hmdnMYYjLbdWqrRZ1mqKd0fbYp3wZb3T3YlVGTd0hEBQxy5oYzhpvCOkYi3FBuoXyGIdID8eDX3p2OyrqOlhlYurxcB3B4xAzsDHhBMN188RBjmjsrX3mW15RtGDX76jtgCX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjlvxpcP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso4716189f8f.2
        for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 16:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767055350; x=1767660150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2unvBg3iVnsyhMovfBzt9bGCp7UXURD1k8Zno8shQX0=;
        b=DjlvxpcPBSlmV8KWQs7mQVc+Z8yIaVNixfjW8fjudQQwzeM26iB0fKNptcB5JvfW5C
         pbE+kUF+/+ZqtJ7gHd3NzKrVDex8H6lHIgtLTCZb6BKbRUQGhRGHRcbDRgbiXE/jsJXs
         EaXkjMpV0i6hppEy1OQLFron18cMnqWrd8JJFS+wgbQwq72KPoFhkWiKhCp8mZZCjVp7
         2MVA80as5vC6tiSYLPdqbR/k8OBUst0RmcW0B66XjCc8p/sQX47GBibWksjXxNe6ACrr
         no5px6rEMkJ9qC8JiWL/tVIKMg0xO7MRHKVI2SJ9edpJs3+W/suEGIFAdKvDldHtWven
         DftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767055350; x=1767660150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2unvBg3iVnsyhMovfBzt9bGCp7UXURD1k8Zno8shQX0=;
        b=YG1hJhNAWYycYDAfWmyaQZJf9DtLXlOrFbFG98ZIgdnopXVibDlBnyDZR1cbG6WB9m
         DAZTh7LdLxcYgNcy1mqOEuPKegGI5OjWvJmEyIYBnC5ZoI+VjJUpdXzbi1i582VLWUbv
         f0EoQqm9cKREg1/xjIJhTvapqIyR1vW0qEy5wleuydvS2yt6VWQHy5P/M0cU36sheai6
         7ydyAylgMdFmGzDZC/TaSDn/dfgOSnKo4SWDDZhDYuqkyJ8icFQYtrUeA+5nQgoH0rj7
         J4ehw1Ab0NPDsIOHgEAxFOZbWyiHKhX1LZw6k6RNHF6IMyQBbbbWWWo8JJ2MqVPbjRGe
         o2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVy2GLQ3n4C0sQdP5+KVUk+f6pg/FccVTiY5b000tPI7EoD9Pp1VKF/tnYicoKYwEKpGMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAG4VpVmw3IIqdThfQPNXU4WuYj/zcYZXP8ojNOvfKUcIHxuq2
	AQvjc93nNFOwvZ1Q1eOT7Zj0XVCf+xKRitq27nAmbhg8poIYX7rOtqGaEV/UbuCObi14a2Z8zUS
	NtcEs4HJFV+gN0oMDbZfN5OmKhwuilUE=
X-Gm-Gg: AY/fxX4UhAY+JGPRjw+H8zGJst9+6qiFblF1W7Mh96fHc8e9iyxawPN+TR7KeoA7K+I
	JXdkGCTecNOxgty822soflWsDsKQueY29rFa6gTUoBEynpslTkzqT0+dGVYZadxyru3itSEcwRg
	nWZnkMj6WUVE/78bhwB6wc4wHAPUXOH/TwyBFhMHmZ17tW1TL6G6+gwOLGeRI20EWHssCVvcW6w
	54UKUWjOk768U3YJTleX7TLc30vXbnPIe1+D8JhHQjwcOXmu06NOhS5OCRAyFQ8qI4OO+fL0YgJ
	pTwUAuxoaxpcozoiVf9ooa+5eUmx
X-Google-Smtp-Source: AGHT+IH2StqfBuWreoB6v9ZiCDD2Zx04PwPR8uCEmD1jD3V9ilHb0rbL5MOKXP14vf9Db8FcfbqRB8kJStES3DszCus=
X-Received: by 2002:a5d:5847:0:b0:431:327:5dd1 with SMTP id
 ffacd0b85a97d-4324e50e0d8mr43118253f8f.50.1767055350230; Mon, 29 Dec 2025
 16:42:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222185813.150505-1-mahe.tardy@gmail.com> <CAADnVQLF+ihK16J3x5pQcJY0t2_gUHiur7ENZNqJdazzr+f8Pg@mail.gmail.com>
 <aUprAOkSFgHyUMfB@gmail.com> <4eec6b7605d007c6f906bf9a4cd95f2423781b0a.camel@gmail.com>
In-Reply-To: <4eec6b7605d007c6f906bf9a4cd95f2423781b0a.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 29 Dec 2025 16:42:19 -0800
X-Gm-Features: AQt7F2rWO_QUwo0Ke-pDxlyXwoRHHfy_Q_WH3Qshr_DCuEzSYvOfg1TGFZU8SrU
Message-ID: <CAADnVQLsJeSjwFVE=gcnVzh7HftDqZJM+xByr2cD6TRmTRGLsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] verifier: add prune points to live registers print
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mahe Tardy <mahe.tardy@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 10:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2025-12-23 at 11:12 +0100, Mahe Tardy wrote:
> > On Mon, Dec 22, 2025 at 08:32:57PM -1000, Alexei Starovoitov wrote:
> > > On Mon, Dec 22, 2025 at 8:58=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.=
com> wrote:
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index d6b8a77fbe3b..a82702405c12 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -24892,7 +24892,7 @@ static int compute_live_registers(struct bp=
f_verifier_env *env)
> > > >                 insn_aux[i].live_regs_before =3D state[i].in;
> > > >
> > > >         if (env->log.level & BPF_LOG_LEVEL2) {
> > > > -               verbose(env, "Live regs before insn:\n");
> > > > +               verbose(env, "Live regs before insn, pruning points=
 (p), and force checkpoints (P):\n");
> > > >                 for (i =3D 0; i < insn_cnt; ++i) {
> > > >                         if (env->insn_aux_data[i].scc)
> > > >                                 verbose(env, "%3d ", env->insn_aux_=
data[i].scc);
> > > > @@ -24904,7 +24904,12 @@ static int compute_live_registers(struct b=
pf_verifier_env *env)
> > > >                                         verbose(env, "%d", j);
> > > >                                 else
> > > >                                         verbose(env, ".");
> > > > -                       verbose(env, " ");
> > > > +                       if (is_force_checkpoint(env, i))
> > > > +                               verbose(env, " P ");
> > > > +                       else if (is_prune_point(env, i))
> > > > +                               verbose(env, " p ");
> > > > +                       else
> > > > +                               verbose(env, "   ");
> > >
> > > tbh I don't quite see the value. I never needed to know
> > > the exact pruning points while working on the verifier.
> > > It has to work with existing pruning heuristics and with
> > > BPF_F_TEST_STATE_FREQ. So pruning points shouldn't matter
> > > to the verifier algorithms. If they are we have a bigger problem
> > > to solve than show them in the verifier log to users
> > > who won't be able to make much sense of them.
> >
> > Yeah I think we would agree with Paul on that. And as you mention, with
> > the addition of the heuristics on top of prune points, it would maybe b=
e
> > more useful to know when the verifier actually saves a new state (but
> > that would increase log verbosity).
> >
> > > It's my .02. If other folks feel that it's definitely
> > > useful we can introduce this extra verbosity,
> > > but all the churn in the selftests is another indication
> > > of a feature that "nice, but..."
> >
> > Tbh that's also when I realized that indeed it was "nice, but..." since
> > because of those changes, all those liveness tests would depend on the
> > position of prune points.
> >
> > At the same time, the new print would allow us to write a series of
> > tests to check for all the possible cases of prune points as presented
> > in the talk, not sure it's actually useful as well...
>
> Hi Everyone,
>
> Sorry, a bit late to the discussion, here are another .02 cents.
> Tbh, I'm neither for nor against printing these marks.
> Knowing where exactly the checkpoints are is helpful to me sometimes
> when I'd like to construct a specific test. On the other hand,
> I can always add debug prints locally + you do learn the rules for
> checkpoints after some time.  If we go for it, we should probably
> distinguish between prune points and "force checkpoints" ('f'?).

and this kind of bikeshedding is why I think we shouldn't print either:
prune point, force checkpoint, jmp point.
They are useful in some debugging, but rarely universally needed.
Also the change may or may not screw up bpfvv parsing.
Not saying that we shouldn't improve verifier logging, but
it really needs to have a strong signal.

> Imo, it would be indeed more interesting to print where checkpoint
> match had been attempted and why it failed, e.g. as I do in [1].
> Here is a sample:
>
>   cache miss at (140, 5389): frame=3D1, reg=3D0, spi=3D-1, loop=3D0 (cur:=
 1) vs (old: P0)
>   from 5387 to 5389: frame1: R0=3D1 R1=3D0xffffffff ...
>
> However, in the current form it slows down log level 2 output
> significantly (~5 times). Okay for my debugging purposes but is not
> good for upstream submission.
>
> Thanks,
> Eduard.
>
> [1] https://github.com/kernel-patches/bpf/commit/65fcd66d03ad9d6979df7962=
8e569b90563d5368

bpf_print_stack_state() refactor can land.
While the rest potentially bpfvv can do.
With log_level=3D=3D2 all the previous paths through particular instruction
will be in the log earlier, so I can imagine clicking on an insn
and it will show current and all previous seen states.
The verifier heuristic will drop some of them, so it will show more
than actually known during the verification, but that's probably ok
for debugging to see why states don't converge.
bpfvv can make it easier to see the difference too instead of
"frame=3D1, reg=3D0, spi=3D-1, loop=3D0 (cur: 1) vs (old: P0)"
which is not easy to understand.
Only after reading the diff I realized that reg R0 is the one
that caused a mismatch.

