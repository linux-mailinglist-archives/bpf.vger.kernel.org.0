Return-Path: <bpf+bounces-73570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3520C33FCF
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 06:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17D7934A746
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 05:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566BB261B83;
	Wed,  5 Nov 2025 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSYZc91e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D522208AD
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 05:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762320386; cv=none; b=hvkgzvFPEZLQu4ijc8ijQp5stOVD54K9XHw0CbegDjNRP5WLPd3K8J8L/mVS+XytsIsHD4qr39HaQjoxW/HaMXhCxHmDqln9Gh3MZD0DHy1Dcupl9S78UqEW9aw8EZ5SornNNx2oEt5cECcrEmQXS47DUqmipquS4lP9WxE8c2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762320386; c=relaxed/simple;
	bh=+WlN5Z8R7zzLkwqpXHJfBJx1BtXAUcTH4scr2OTFyPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHNTAgHqqDo/koGXEiIi+ZjmIvDWSL+DTfSvUsRrZaR9vDmOw3LyKLFqnjdEqAwh+nQtzfo2xpSgepsbZZKibtthFZobBqejp+jdJGzyUUhmKhvHPQQYgjRQI1YWMkHF2RjfKrf8BBwrQtiX85csSeHyMxNY7Rgi0ldIwc9yZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSYZc91e; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b710601e659so450271066b.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 21:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762320383; x=1762925183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IiPIHusgOvi1w06OgPMd/3g+DnhurgRwL5krG8va4g=;
        b=OSYZc91eqLx5vm0yeivZ34re3yDpQ7/5Yyv1v6T6REICP+i0MR5YxV59qxUnc+Hxlr
         hS+HOpFOckBZmhGvTHR1T+I30/vGo4VpLSkfQ7AORmdhLsWUTYdnO/PGmEz7YO9yAljU
         TEM1OQDEunv0fH/oSbCQL093udfA3e7z9ckuoqhj5Y0os2QjNrJKxrmm1kz5Te35WBu3
         dx/Ueo0wOh4rYfXpXIgkJv1/jdsBEroCGisn67gf4gRYty/b7/WdiHWf2bj0iP9dWoC6
         UwSGcG6uuCuu+FzBk6OyO3KccdoASs0Be4ZLm6AIk7fAgf3h47i0dYvUkF7y4ac9jClv
         wOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762320383; x=1762925183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IiPIHusgOvi1w06OgPMd/3g+DnhurgRwL5krG8va4g=;
        b=cl3KaxkSnk78DpIZNgLRCF6818CqxNEyoP8o/Hri1EcYrEMg4bQLKle9QaYVT3e408
         gjHd/r+vk6KAJxvEUkOaaDybfbQWtdGtD11I6F60lvnht+oGT4Y3ASVKHD33XNZOMpwC
         dvUjBOgjGIWNpb6vndH17t7BS2UW4B7ZjBlbsrESLn5CQXpG8a5MoraOxFoR17GWgCik
         MchCeJKJF3Ldb61UYGU9fp5Y3k8DlHElGddoispKKc6u0patmAQ4sGQRbNBq8KpNfMxP
         BXVDtuqwPghtAJI2acPJiY0KgtGiC6G4Wddk1IFw2VH5DyP8xc4sNDz0P3GtWv5Qn8uy
         Hw0g==
X-Forwarded-Encrypted: i=1; AJvYcCVeyDf78iFtFSNdZyFD9iscZ5L6xfYNq0ItBlyJBvnDqnbykq06mO/bMIF4kFc4QYytaSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAqUnSUWNObre7J7vpgq5hL/YJS59HxiWTPcIWODVdjj3TY0yt
	tsroE21OcntvKDHCmwMZcufb4sP/7umq3W1qvYcEibvGCdid5SAT693JuiyQkEsoqBAkXZCQy/b
	S9mK7BQwJwzeW1cO2x9DrXuL6XUFuADA=
X-Gm-Gg: ASbGncsGKA6mgc2nL9fxQEJysPplEZSYKEh06wayb1oRrRFbnmB4avHh0ufXrgd/VWv
	2Z/8KZe5c0nJyRMLA/w2R1qywGTMfP9Jt0KoQgus2t9O8P7gn8NBZYpcKg0hyKb4I7tiSvvAj62
	4LJgoSCbyvaqLwiIG7dtkNEn96VZb99h/IdCTeutPzLfT4ajG+RtYbLKQ0FszGLdh4047MgmPNe
	wWb/20f2O+3QWcY7k4nT+YgMy9c810wJ/EFLgjmHU4kQG1ulCC7uHjkOCHcpB9st2aNtJ3IGDQR
	45vAmD0=
X-Google-Smtp-Source: AGHT+IG7Nj/p7Cl2BJ2bkaswA2ZnN6Mmn09vK6UT5Yz333QitQDayB77lmwWzAio3DLfAkVUDUCiU2w2T8ob/FXDHgI=
X-Received: by 2002:a17:907:3c8d:b0:b04:c373:2833 with SMTP id
 a640c23a62f3a-b72654d755emr172869266b.32.1762320383224; Tue, 04 Nov 2025
 21:26:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104164948.33408-1-puranjay@kernel.org> <CAADnVQJabNCvyT_b2JcW6YdtwCaSs8YVPcdk1FacLJjpz=KFqQ@mail.gmail.com>
In-Reply-To: <CAADnVQJabNCvyT_b2JcW6YdtwCaSs8YVPcdk1FacLJjpz=KFqQ@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 5 Nov 2025 06:26:11 +0100
X-Gm-Features: AWmQ_bkIUoSzB0o3fJ8XEWgzZA2gzQ-YkY3iDxKMv60wpi4CBcpWFcaYE9OP-VQ
Message-ID: <CANk7y0ik9_UHUK+k4MTvCggr3Bqm3CqwK3gnGGawydg5xsmc=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Optimize recursion detection for arm64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 12:52=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 4, 2025 at 8:49=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
> >
> > BPF programs detect recursion by a per-cpu active flag in struct
> > bpf_prog. This flag is set/unset in the trampoline using atomic
> > operations to prevent inter-context recursion.
> >
> > Some arm64 platforms have slow per-CPU atomic operations, for example,
> > the Neoverse V2.  This commit therefore changes the recursion detection
> > mechanism to allow four levels of recursion (normal -> softirq -> hardi=
rq
> > -> NMI). With allowing limited recursion, we can now stop using atomic
> > operations. This approach is similar to get_recursion_context() in perf=
.
> >
> > Change active to a per-cpu array of four u8 values, one for each contex=
t
> > and use non-atomic increment/decrement on them.
> >
> > This improves the performance on ARM64 (64-CPU Neoverse-N1):
> >
> >  +----------------+-------------------+-------------------+---------+
> >  |    Benchmark   |     Base run      |   Patched run     |  =CE=94 (%)=
  |
> >  +----------------+-------------------+-------------------+---------+
> >  | fentry         |  3.694 =C2=B1 0.003M/s |  3.828 =C2=B1 0.007M/s | +=
3.63%  |
> >  | fexit          |  1.389 =C2=B1 0.006M/s |  1.406 =C2=B1 0.003M/s | +=
1.22%  |
> >  | fmodret        |  1.366 =C2=B1 0.011M/s |  1.398 =C2=B1 0.002M/s | +=
2.34%  |
> >  | rawtp          |  3.453 =C2=B1 0.026M/s |  3.714 =C2=B1 0.003M/s | +=
7.56%  |
> >  | tp             |  2.596 =C2=B1 0.005M/s |  2.699 =C2=B1 0.006M/s | +=
3.97%  |
> >  +----------------+-------------------+-------------------+---------+
>
> The gain is nice, but absolute numbers look very low.
> I see fentry doing 52M on the debug kernel with kasan inside VM.
>
> The patch itself looks good to me, but I realized that we cannot
> use this approach for progs with a private stack,
> since they require a strict one user per cpu.


I figured that out after sending the patch and was going to suggest
per-cpu-per-context private stack, but that is an overkill.


> Also tracing progs might have conceptually similar restriction.
> A prog could use per-cpu map to store some data.
> If prog is attached to some function that may be called from
> task and irq context the irq execution will write over per-cpu data
> and when it returns the same prog in task context will see garbage.
> I'm afraid get_recursion_context() approach won't work. Sorry for
> not-thought-through suggestion.
>
> Looking at the other thread it looks like this_cpu_inc_return()
> is actually fast on arm64, while this_cpu_inc() is horrible.
> And we're using _return() flavor almost everywhere,
> so it's probably fine, but this patch shows that there is room
> for improvement.
> Please check why absolute numbers are so low though.

I was using kvm with qemu and gave it 32 cpus, will try to use a full
metal host to see if I get better numbers.

>
> Also let's benchmark xchg(prog->active, 1) vs this_cpu_inc_return().
> And its variant this_cpu_xchg().
> xchg() will probably be slower.
> this_cpu_xchg() may be faster?
> pls test a few x86 and arm64 setups.
>
> pw-bot: cr

