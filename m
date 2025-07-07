Return-Path: <bpf+bounces-62541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44324AFBA09
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 19:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D908B1AA0EE5
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878AB288C19;
	Mon,  7 Jul 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du29VzZP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C1C23027C
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910075; cv=none; b=j7Os7P+5mR3woXYYsLiZJ13RgjzhbC6XwJhPS1PFnGNyxi24UPg0XefotJfnkwCDIbJFo+/AyiJcG1UE2n7szdK75HCYzzCC+qJJVAfS9Lp5EeygTejsShaJHBKo42v8MPAUi+nJdE/pCIg4Abi7yPhWjJiFAFrhniAnCqW11dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910075; c=relaxed/simple;
	bh=HhZaX5fD36+c1RJ/5BpE55Q0kbpG2TpPSSrdAR4Aifg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZmlAyIpxiEnhl55Na4OnEZUe9Wsvg7inhWRgJWyQd+x2c40sxfRGJH1CGFMseFlNgHOErY+ghd4MqyiO4wnGGHBt7CEbGglnqFTLx9DgeJdWRyEKSXEv1FVeUPLHSSg3GalUDwZynQo8L9JPJ1Fn7sT/8iozbqAwxLWvW6OYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du29VzZP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso3086829f8f.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 10:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751910072; x=1752514872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhZaX5fD36+c1RJ/5BpE55Q0kbpG2TpPSSrdAR4Aifg=;
        b=Du29VzZP8wWacUNLGzunMdvQTylaF4Bx+TyYHtLgBecaZVpNXBB4k8FqbbXFLQRcx4
         uVZezD+wpw4g0yk+t2hEZewZsRWiAZvTPWsMOBIWl8XzzNQkrjRFTZ7vygZH7PxRgR6K
         SQW9smDDkNLC+qnAnlRwh9jL2xP8Xr7VhOqIP60DFmaPODONiaDCmzc+T0KG2m6x9iU5
         ORIA6FNcwwvq9mTcGrRBHeG4qrHgYz192BYTctjkhioUy/OqdRnKr+cx6Ap/XeZbtRWh
         KKj3hoItoUzLcsirBSkwwgsdhSSppInj+FOTQVdhz9vo8wOfOEX/VyfXFKcW7PJF2Q3z
         5J7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751910072; x=1752514872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhZaX5fD36+c1RJ/5BpE55Q0kbpG2TpPSSrdAR4Aifg=;
        b=rmscTzVbGu6D0U75TIjZhpG/Ij61UOUfRt2WyZA8290UQaJcvZPFT3XRcck71Ct7yA
         2HD9T7Usn7wJ0yuSCHU2jxboMUTG1lw2/0/RmRyFaX4ThupsSJSqALFra1Q3/xtsPjZK
         TG+/9Uech8EhoWW1zcq0WVxjTOkxSi6Q9YTPT2XdVkG8zGTK/mGnpepmEp1+Omkwn4zt
         FnK6f5A76fed0p9m4NEKPGZzIsdffm/lqYegKFPE8rwFiQLIRphYNNOV0+f9LSH756NJ
         CEG/S9o9W5Xfwlk377sareSSgap6NCCfrmVdvfIPHjY70Eo+GaS3dR76sxTH/YMKAjnV
         g9JA==
X-Forwarded-Encrypted: i=1; AJvYcCX+uMlhibEFYiAtNGpi1IEPYdnBp3NhuflDGv5c281foejkMgvMVSwGNS08WIedciuh4d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTQaLTQK+LxfMC33FHQEZTsphcL6Q/lCFx81S3rEGDgzMGqmW2
	dBIGFAmwD525SENVe1f4qAGW3SIAcEnsDO9GWbkINMilXvmI82H7S9F4m00fEshh1uUel3aoA8h
	0bmBqw3WHts8pYMjnelCaTDxFAhCa6RM=
X-Gm-Gg: ASbGncvmYoj83sYJldSIrmg1Iz5TSpB3RUnKVfHNm9x99KOZaHZqHX/954hXhBDNOqO
	BqdzIkDu8Z8JGaWZFgSrbFAvJws0ljRHCxYhzs23kTGx1g4IIMA5x9PkC/hZ43n3pTGJNLHecSh
	mwDejnSf1ak0WH2rpWjuexikDRrPS/OsRBykRO47Uk0qFud6ucxKm4/6S7CAMM5i/r8E1Rug==
X-Google-Smtp-Source: AGHT+IGIGPB9LKXCROvz5zoxuYE6IL0wGFUAixtzZQuRqqI9jF0VaLCmErRlyN3hPoLKquvSt/cVerqGE0RlY1q7puc=
X-Received: by 2002:a05:6000:3c7:b0:3a3:5f36:33ee with SMTP id
 ffacd0b85a97d-3b497029498mr9893544f8f.32.1751910071609; Mon, 07 Jul 2025
 10:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
 <20250614064056.237005-4-sidchintamaneni@gmail.com> <CAP01T77TBA3eEVoqGMVTpYsEzvg0f7Q95guH0SDQ3gZK=q+Tag@mail.gmail.com>
 <CAM6KYssFT35L5HN_Fes-2BdhEO6EmhF9Qa+WSWLML4qnZ0z1tA@mail.gmail.com> <CAP01T76S4X4f=owz9D7dXfv15=vD8HB8dO_Ni2TmKfqTKCtuhA@mail.gmail.com>
In-Reply-To: <CAP01T76S4X4f=owz9D7dXfv15=vD8HB8dO_Ni2TmKfqTKCtuhA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Jul 2025 10:40:57 -0700
X-Gm-Features: Ac12FXw-pPU5Mx_C8_s5x-thOVNFfZ6IE3W5eS5HZFiMkPVJOErOUFFqcrUvjHs
Message-ID: <CAADnVQ+EiaoWUVcN9=Nm=RWJ6XE=Kcm8Q2FYQqWGJ_NsCtyJ=A@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 3/4] bpf: Runtime part of fast-path termination approach
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Fri, Jul 4, 2025 at 12:11=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 4 Jul 2025 at 19:29, Raj Sahu <rjsu26@gmail.com> wrote:
> >
> > > > Introduces watchdog based runtime mechanism to terminate
> > > > a BPF program. When a BPF program is interrupted by
> > > > an watchdog, its registers are are passed onto the bpf_die.
> > > >
> > > > Inside bpf_die we perform the text_poke and stack walk
> > > > to stub helpers/kfunc replace bpf_loop helper if called
> > > > inside bpf program.
> > > >
> > > > Current implementation doesn't handle the termination of
> > > > tailcall programs.
> > > >
> > > > There is a known issue by calling text_poke inside interrupt
> > > > context - https://elixir.bootlin.com/linux/v6.15.1/source/kernel/sm=
p.c#L815.
> > >
> > > I don't have a good idea so far, maybe by deferring work to wq contex=
t?
> > > Each CPU would need its own context and schedule work there.
> > > The problem is that it may not be invoked immediately.
> > We will give it a try using wq. We were a bit hesitant in pursuing wq
> > earlier because to modify the return address on the stack we would
> > want to interrupt the running BPF program and access its stack since
> > that's a key part of the design.
> >
> > Will need some suggestions here on how to achieve that.
>
> Yeah, this is not trivial, now that I think more about it.
> So keep the stack state untouched so you could synchronize with the
> callback (spin until it signals us that it's done touching the stack).
> I guess we can do it from another CPU, not too bad.
>
> There's another problem though, wq execution not happening instantly
> in time is not a big deal, but it getting interrupted by yet another
> program that stalls can set up a cascading chain that leads to lock up
> of the machine.
> So let's say we have a program that stalls in NMI/IRQ. It might happen
> that all CPUs that can service the wq enter this stall. The kthread is
> ready to run the wq callback (or in the middle of it) but it may be
> indefinitely interrupted.
> It seems like this is a more fundamental problem with the non-cloning
> approach. We can prevent program execution on the CPU where the wq
> callback will be run, but we can also have a case where all CPUs lock
> up simultaneously.

If we have such bugs that prog in NMI can stall CPU indefinitely
they need to be fixed independently of fast-execute.
timed may_goto, tailcalls or whatever may need to have different
limits when it detects that the prog is running in NMI or with hard irqs
disabled. Fast-execute doesn't have to be a universal kill-bpf-prog
mechanism that can work in any context. I think fast-execute
is for progs that deadlocked in res_spin_lock, faulted arena,
or were slow for wrong reasons, but not fatal for the kernel reasons.
imo we can rely on schedule_work() and bpf_arch_text_poke() from there.
The alternative of clone of all progs and memory waste for a rare case
is not appealing. Unless we can detect "dangerous" progs and
clone with fast execute only for them, so that the majority of bpf progs
stay as single copy.

