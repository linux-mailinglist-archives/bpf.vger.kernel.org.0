Return-Path: <bpf+bounces-49215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296A0A155FC
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A17E188DA5E
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 17:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6551A255C;
	Fri, 17 Jan 2025 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ7cofwO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6033F188A18;
	Fri, 17 Jan 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136275; cv=none; b=IDgv8u52/jyfVYwVLOYck+0EkajYrQ6K5ckQorFaj5PGySEvQ1IPN9A+vA5CfcoPjb7QUBnErEiiHLDhOmNX5FnRPM3Tzw8VotYjUF5hzQXkJF/99rIVTe4C5ecqkC/u1Vxcrl+C8okQ0We3ChL7ee08HYPyQTpeT7LbD0pW4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136275; c=relaxed/simple;
	bh=59n3JanXAj4W5nJ++jbT6kBppiHPtQVhmf60NSVx+AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXXVcaVlHBcNI4Yk6ZHRYxYC4xFp8LDzxuLJEkzIzzJ9VHJVvAD9b1w5SLwYBoZ48V9c6Z2hIsWmChubCGWTVB9fH7yZtKKLZzF95baicwmr8bUFlXFyJgAcqgkHA2GpZ90FJy3tNyi5ALgFVp1JcRJczgezI7OvMJeCDM9R1Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ7cofwO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso3254792a91.2;
        Fri, 17 Jan 2025 09:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737136274; x=1737741074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgchdpJbWAQjMLwDeSmgMjsaNK2uqn9e9RX7bZTPGiE=;
        b=RQ7cofwOoKoEBPGUz6pFuICpr2mYXW3yUYlW6hbyPwc6AOdQ/tsC+xp4PqA07PCNuJ
         vMWZScgvBDh7zAR9yAnkuVLAngOYESIpOG+8flX+GNd+LNiIgGRUeErAP6pyjgkX+Cao
         GU9QnOl+fRqjK3bJsEMvF3Kei1+Bc6HjtpZDDZMJWjBxzOzg8yzc90vmOcCkasOZTdnD
         nOoZ8YrOqUkV7qFErOUY3Hr9mHHjFYjPyrusyueyQPUY1JshxPr0bZJp68u9HjCOJkLJ
         GkgJ3xxc8azp+p1uC4GFVVg3H9IdA7KPjrmdQ4uwP9lcF+dhoDzxc93S3OgLsmad9zJf
         tl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737136274; x=1737741074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgchdpJbWAQjMLwDeSmgMjsaNK2uqn9e9RX7bZTPGiE=;
        b=OKca5h8PBWg6CGh3fMjsYt6OLVrtJX2PBRp2HwC1WvesGaxdBRAcoTMqoZckkhCuEM
         Gs+LbUd3VlXAcNLXCnDFPt2LD7bLZwM7+NyA7QKrBUfSWOt9dlMC4j4e2p2c7nbeJG+w
         TwDMrrXq7hQyawhPEAp+h1r4bz+FFikqV9Ie37mFbbG+h3OiZoZKCxauldMsRkdUxIC5
         91pZSBMubz9WJrIm3gNv//uSdFHlvcezvB/ckxNNyjw52ZEGECOmzW7yA6+ZQLwrcMPv
         gaWMYLF6BbgW6/48diQON6+82aJBjYFaRRE1hS2ExdZoNMCYz/v/0FF4/ix+YBX5/RQR
         1ChQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRnBUAiIpSAaLed0bUdPlqt8Qz2mnb8y+DjitLoylsiF8B2S86tuSXfQ71s8PzP1DlK4p1hflYDUrbjLKc@vger.kernel.org, AJvYcCVwYLyT9KxfHJuaCAU37BghEFgKDQc/9pHyEqotzvQMo6eBpVF4l97JlrRgRZdDV8F5KMY=@vger.kernel.org, AJvYcCXMO90LVkervgUHBzWd5XWaWSnl7U6n5huWBHq8BhZfA4AaZgV6B92Ux8ugxYnjkYUnmeXsav1La5p3@vger.kernel.org, AJvYcCXkfvyw3igQPcCheHb5A+blEqXDKwosYDNrqvaYcRRNh+Eqip3aMzd2IjrHC8ASFNqrfvQ77vZy@vger.kernel.org, AJvYcCXzB40WJHFmk1Yo9TktitdYyKZAvTRlEuN9d02HyQTMHsok1plnmso75xLrHxmxyM2o5gvc78UfisIvkeyl4bQ67rb5@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmUizZDZE8F8PJq+nSFi0KaK7w+0RsWLi415gU4PtacOdUQaj
	31kQEWmtXYrY3IIZeuYUCSF7AmrKvZEqpugWQsJ+BbIZaRrQI0TgI3pNkInIGIPTq96STdK7VkD
	HMNTfRNt6O4HJ87NKUdITtEClG+E=
X-Gm-Gg: ASbGncv3hYImOkzrRIzHK5THaj6PeUSZrdz6XPa0C5DqIk2K5Ot3mULPmiKTdUkRym/
	Au7PYCdC3WhenOKPH9IWN3SB/kF1vuFPL78VB
X-Google-Smtp-Source: AGHT+IFgGZHvaVpyG9evtbseTwW84tvh+4yMJz+UPX4HsHP4aoIIOQbshqpZpl2BCKbUkGappNXJTpfv3VqWAwdsvQ0=
X-Received: by 2002:a17:90b:3a46:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-2f782c519e2mr4648673a91.3.1737136273620; Fri, 17 Jan 2025
 09:51:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <20250117013927.GB2610@redhat.com> <20250117170229.f1e1a9f03a8547d31cd875db@kernel.org>
 <20250117140924.GA21203@redhat.com>
In-Reply-To: <20250117140924.GA21203@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Jan 2025 09:51:01 -0800
X-Gm-Features: AbW1kvbCIlrQcqrIsewf1J2VvfFgAYtuF1bKPaVwM7uFAPqmf8E_bdQIa9-K55Q
Message-ID: <CAEf4BzYhcG8waFMFoQS5dFWVkQGP6ed_0mwGTK4quN5+6-8XuA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
To: Oleg Nesterov <oleg@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, kees@kernel.org, 
	luto@amacapital.net, wad@chromium.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com, 
	bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 6:10=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 01/17, Masami Hiramatsu wrote:
> >
> > On Fri, 17 Jan 2025 02:39:28 +0100
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > A note for the seccomp maintainers...
> > >
> > > I don't know what do you think, but I agree in advance that the very =
fact this
> > > patch adds "#ifdef CONFIG_X86_64" into __secure_computing() doesn't l=
ook nice.
> > >
> >
> > Indeed. in_ia32_syscall() depends arch/x86 too.
> > We can add an inline function like;
> >
> > ``` uprobes.h
> > static inline bool is_uprobe_syscall(int syscall)
> > {
>
> We can, and this is what I tried to suggest from the very beginning.
> But I agree with Eyal who decided to send the most trivial fix for
> -stable, we can add the helper later.
>
> I don't think it should live in uprobes.h and I'd prefer something
> like arch_seccomp_ignored(int) but I won't insist.

yep, I think this is the way, keeping it as a general category. Should
we also put rt_sigreturn there explicitly as well? Also, wouldn't it
be better to have it as a non-arch-specific function for something
like rt_sigreturn where defining it per each arch is cumbersome, and
have the default implementation also call into an arch-specific
function?

>
> >       // arch_is_uprobe_syscall check can be replaced by Kconfig,
> >       // something like CONFIG_ARCH_URETPROBE_SYSCALL.
>
> Or sysctl or both. This is another issue.
>
> > ``` arch/x86/include/asm/uprobes.h
> > #define arch_is_uprobe_syscall(syscall) \
> >       (IS_ENABLED(CONFIG_X86_64) && syscall =3D=3D __NR_uretprobe && !i=
n_ia32_syscall())
> > ```
>
> This won't compile if IS_ENABLED(CONFIG_X86_64) =3D=3D false, __NR_uretpr=
obe
> will be undefined.
>
> > > The problem is that we need a simple patch for -stable which fixes th=
e real
> > > problem. We can cleanup this logic later, I think.
> >
> > Hmm, at least we should make it is_uprobe_syscall() in uprobes.h so tha=
t
> > do not pollute the seccomp subsystem with #ifdef.
>
> See above. But I won't insist.
>
> Oleg.
>

