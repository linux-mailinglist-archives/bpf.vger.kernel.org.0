Return-Path: <bpf+bounces-49270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19052A15ED0
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 21:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6853A69AE
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 20:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8321D5CCF;
	Sat, 18 Jan 2025 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6CI+C4g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF02B9BF;
	Sat, 18 Jan 2025 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737233162; cv=none; b=HUTkLrczcx0ol7hD1+jANAQRHly6n0Q0GrjeG89YJap948MVl00XXDY4RsMTwxiN0Z6l+Ftvx//3IX222zd1mCzJ/cdOgZauZ3StsLLr3VuwiLaK2qfJzHnOP+4FVpxOW37UkTreVfdBaKA+erf8RVXQeXL1zJLufWYOLDjVzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737233162; c=relaxed/simple;
	bh=wuHxL51/Wf3p1z36mLb1L4OG9yrDBrf1R6y7vpGobbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mo3Tl80TzhDncOkWNWP/e2+Hds+kYczXNkqe3iTOb97B9Q30NK6b5DqFA0yiyAchlSet4dS8EBfX7urub6MQtjePSViH8/MCfFUD6BvZ3ZkJROirNMAC8sftNh2gPH+Yz6jhCAS5R558FbbPZAR8bBCPvR0AcXD4iEkhHdNE6jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6CI+C4g; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2aa179a8791so2848963fac.1;
        Sat, 18 Jan 2025 12:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737233160; x=1737837960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuHxL51/Wf3p1z36mLb1L4OG9yrDBrf1R6y7vpGobbU=;
        b=F6CI+C4g5tH05MZuPnNWJiZTQX7V1lHeng5f0a0KgcUMc3KJvVpsH5MjbIbnmavJmy
         Bay1MOe0LBfdYjvdGUWEQVfUjYxQgVCGbQxpaLKbcoWbc8I+/Ko5EvHAAQOlNjR5dXsD
         3ZHgpsehuy8RQUn9f/SuBz/9UECnp8m7HEDCXWZKluDIBx8LrubbvWOdTKKvTzVCrrkS
         lr5hGgom/xuCMpIT+JKnCK1CZNH1h2TobsppolIiF2xtHyIONdMHLq1x1c2qL/pTofB8
         dP3WoYxNqPNPeIOXabxrqGkb+noQ6H+2XdpLSpdKA172n2dZOcRoCv7iDJLkZYg/DFsF
         jbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737233160; x=1737837960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuHxL51/Wf3p1z36mLb1L4OG9yrDBrf1R6y7vpGobbU=;
        b=l7CL2Du2TD8lZvwYLu7r1B+vH9c81Z41e9JNgQoUxR1X5n4PERPH0O3JkYUzOC3caw
         2ZZnyri1coCJmkLEQiqC3HxkzEN3t9pf95XtyWZ98UZdR0p7dnQSlgA8tclq9hw7ML9o
         2cTs2Hqm9Cpk9wAjDLG6bEJDrczsIyC9G7RoNGesVgS/G02rtxILdAtPhYGnQ4lAmtSN
         TVHeotVZsisvQdE4KWzVWFAHi1yKJHPAh0O7Q7q4GDrIirZurthAySkHCeUV0eJZy3A0
         WIJAxB75TXId+PqdIxwvvvfJc2PyrlbK9hH34ZwbsEuzNtcaZXJeni5iVRcZxGS9IsCj
         2jfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV82ThRntWpJwOKvbv+S715S5xJGQOlU/3CL8RZBgfqc4i+IKoguP9AGLfJjUGv5jTJrDjWYy8tqUaR@vger.kernel.org, AJvYcCVNxkTuLP8ec/c21G6nCQSbCSlnoYYbg2brzjB7jKOYdehcemqLlafQqdEj5gWdAX3j79SUwF2iwPTpJKcA@vger.kernel.org, AJvYcCWKy3/ON+kxCCURLGvMSl2nuyFWVJ99UFTa3qCYvUhaLHlbbtH2Y49C29J4H54/E2B49evnhLd4@vger.kernel.org, AJvYcCWaqRVzPUrWkKdl7vo78B0ucN4DzkBlBYwBnSpOKFoEUtcozWefQHPqLWdvVy6a+jouptU=@vger.kernel.org, AJvYcCX2ofnbTWbDarvxqCNi2SH3ipcLLXpurmDFPYqQrKapPKacXrkTNB4hs0VBe79PaFx7TMSfh9ivHuBtND1G9pvQwmYH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn46hGY+pFMyIfIF+IQx9bci+7A9nMt2TQfwzn5rIXJJQvkNl9
	vvthPiQikd0IGZ08LNoiwy7g+7LfJzH+baJVcy+TGwlq1R7ywbbBUUCdONZ1oB5FM+iILZ9z3aq
	DGIDPZP9oTA6kkThj+3Wv+kTvxa0=
X-Gm-Gg: ASbGnctaMIiBaSla3UxCTz9Orvh+Jmckqo0Y5j0sFCrbn41cg4CbU1AioOxve1/OsGX
	BoKconGFb7u1aXQiXnigRW1lT8pPu5f4iqMCGYK92upr+/fjtgts=
X-Google-Smtp-Source: AGHT+IEi3146M3WibZFUB4/vexkKaG40ELpZPEbygR1/VguT9SleYFm8f68+hd1ily4mZPGiABLuRf0mOlng6C4ZSpo=
X-Received: by 2002:a05:6871:d048:b0:29e:3d0b:834 with SMTP id
 586e51a60fabf-2b1c099e3c4mr4739751fac.5.1737233159676; Sat, 18 Jan 2025
 12:45:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117005539.325887-1-eyal.birger@gmail.com> <202501181212.4C515DA02@keescook>
In-Reply-To: <202501181212.4C515DA02@keescook>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Sat, 18 Jan 2025 12:45:47 -0800
X-Gm-Features: AbW1kvbw6S8xpdtb94Wo1WTSg-JeiUO86e6CDZ6IKLcW-Ex7y7_kd2M5G4NWa64
Message-ID: <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
To: Kees Cook <kees@kernel.org>
Cc: luto@amacapital.net, wad@chromium.org, oleg@redhat.com, ldv@strace.io, 
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

H=D7=9F=D7=AA

On Sat, Jan 18, 2025 at 12:21=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Jan 16, 2025 at 04:55:39PM -0800, Eyal Birger wrote:
> > Since uretprobe is a "kernel implementation detail" system call which i=
s
> > not used by userspace application code directly, it is impractical and
> > there's very little point in forcing all userspace applications to
> > explicitly allow it in order to avoid crashing tracked processes.
>
> How is this any different from sigreturn, rt_sigreturn, or
> restart_syscall? These are all handled explicitly by userspace filters
> already, and I don't see why uretprobe should be any different. Docker
> has had plenty of experience with fixing their seccomp filters for new
> syscalls. For example, many times already a given libc will suddenly
> start using a new syscall when it sees its available, etc.

I think the difference is that this syscall is not part of the process's
code - it is inserted there by another process tracing it.
So this is different than desiring to deploy a new version of a binary
that uses a new libc or a new syscall. Here the case is that there are
three players - the tracer running out of docker, the tracee running in doc=
ker,
and docker itself. All three were running fine in a specific kernel version=
,
but upgrading the kernel now crashes the traced process.

>
> Basically, this is a Docker issue, not a kernel issue.

As mentione above, for all three given binaries, nothing changed - only the
kernel version.

> Seccomp is behaving correctly. I don't want to start making syscalls invi=
sible
> without an extremely good reason. If _anything_ should be invisible, it
> is restart_syscall (which actually IS invisible under certain
> architectures).

I think this syscall is different in that respect for the reasons described=
.
I don't know if seccomp is behaving correctly when it blocks a kernel
implementation detail that isn't user created. IMHO the fact that this
implementation detail is implemented as a syscall is unfortunate, and I'm
trying to mitigate the result.

Eyal.
>
> -Kees
>
> --
> Kees Cook

