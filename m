Return-Path: <bpf+bounces-48879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA324A115AB
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B80A167AFE
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E977121ADD1;
	Tue, 14 Jan 2025 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHAS9WE4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9942135A0;
	Tue, 14 Jan 2025 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898759; cv=none; b=bi4TAEzgT04XIdFDS/cM1Ho1fhBSYgBatj3mKAH6+riGOU4dYEqNyn/S+wPtxZ/HRNa1VJeewQGhh1aRfBPTgL2IzbTcmm5iHPHFoxpEz/XFmnYuxbdkkbla3NI0jETBBSUfUBoV4M7/pdQ2fQ/CbqkBbYhn08Sf2qUPApf/+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898759; c=relaxed/simple;
	bh=1cvucDChMYk3wMwc3GU/lXASMHIz0KpwFlvJNT7FI7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYjTnaMYq77c9MVr0xBhbMNY/2JSfzI/oFeJgK/ptmmJn4PpKD3V73z1bhzekQ6HJR8XpyNHLtporp6FWKiqno/lLXnFcxXQLvXOkemv1rEPzNjhoFRYuOKOCZ8lp5PUgT9r0QHS4RYLndRbWF+bzXw0/V4pu+jru8J4pGqTddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHAS9WE4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2164b1f05caso108586365ad.3;
        Tue, 14 Jan 2025 15:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736898757; x=1737503557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cvucDChMYk3wMwc3GU/lXASMHIz0KpwFlvJNT7FI7M=;
        b=EHAS9WE4hNsJOW7qF0bQ+lsHlt2actt/lOKQ3Q659Tl0ZEW2v0wV4a/b7o4QUBoDOI
         gKIigbXH7cLc2fl37Q2hBOLg8+PZu0RxgD7+rP562+uKz2Vgfdcx9efJ/GPIcb0h7dCg
         uGwmZnvo1nALv+3wVgeikLccGVYz8/aJ3r8jZ/RTawINH3z2gXFkzcMBGUnJoXdhpJNj
         +ZRBI1OKmD8UvGVJ2aGQIQQjnnGmyXQr2pCOSoe1mhY/BzSVmTVZp0wUkZJlrXSTGbld
         81n5H8aA8IPIdctILtSnd2sS6tLJyCLmOkriNxv8ixL+ZPH7rDnDFqss4ExQLRdkYPKf
         7f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736898757; x=1737503557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cvucDChMYk3wMwc3GU/lXASMHIz0KpwFlvJNT7FI7M=;
        b=IxeUeSiAkJMcWTYJXBNYYrYJF6n33vjxchAMoKL+SyK0f0FNpv1HN9XPnvjvrFNdpX
         Bl/OUxsRbsrN7VKCPZhcdYPAvmJvJHdzEdHtXrI/rW7kn1zGBaXQ2eGWaM5cECRv4Rts
         wdqSbE+Xotf+IGAyPdOJ+Uj5ybG1IlgsdidFwqprX1c/PZSB9NwtzoIlZBA439ofVtWw
         1wje/aUHQl1vwfWggU45UMhyQOyIQ8Bmhf05rf1KK8SANsro/1hYEkQeCvswhsjj5aRU
         bzDbbjMylHJfb8wr/I5p8+zO8CQfPhIH3RxeC2MHMftrTW9UbepviM13nMauhhA6Bkxr
         GvMw==
X-Forwarded-Encrypted: i=1; AJvYcCUjCsYXbLJPu4lpbEpE3N8LYB+P/xs5tRI7cwRsUkcJaU7XaMgxD0RWTQpcqm7Y6xdNUAJQMcC/hMiDbB0T@vger.kernel.org, AJvYcCVTeZercjj6Vor0ljIFd96vRSe2LRavEaYvpXtqDzqZGEm31mEkOCmFc2IsAVVstOTRJVO9Cf6rADw0YtOOKR4FusKQ@vger.kernel.org, AJvYcCWJT7d2KmCghnETe4n7se6OLYZYHGi2Lo2/9VILq7CQfXeeDDpL+fbgZ4WeFxichAj+4ec=@vger.kernel.org, AJvYcCXZGnIzKQcguUn1XK6LHHLaZT++lZRbDPFcDx7sHaec035o3dArA7DzJD5pLywuBiGIuCBNMgjtnIRU@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKYYCX9vA5zQ4nQSWgSHXbtxuHSTrD7V1Ff6rAj15IxLnaRsM
	3UVhj283AJrzHh8cXbI0Y8a9VRs2+eiAd5OiCGJt9W5Ljuh9SsSqF6D+2iJ0H83vZ1JmF33FeXD
	yl3lLIadEdZ0Hhw2FX2pbiZPcZjg=
X-Gm-Gg: ASbGncsEKrkCHJuuUvDTSLI4aiqj2IMb1H5iN0KW8HPtD7+9LaMILiywBosBOJYbbGA
	kxh5hRgbqjXXOFEXbcNs21AXP9BYd6MG4yGeU
X-Google-Smtp-Source: AGHT+IF9xrZ0Fm+qK9t0KO7jgFf8WDiEIH8bHqVXht+PM6el+fFq+yNfKKY5u1HiXjh5A3WocKYKkCR6jz2kUE9lTjk=
X-Received: by 2002:a05:6a20:3d8a:b0:1e1:b28e:a148 with SMTP id
 adf61e73a8af0-1e88cf7bfb7mr38140531637.5.1736898757299; Tue, 14 Jan 2025
 15:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava> <Z4YszJfOvFEAaKjF@krava> <20250114105802.GA19816@redhat.com>
 <Z4ZyYudZSD92DPiF@krava> <CAEf4BzZoa6gBQzfPLeMTQu+s=GqVdmihFdb1BHkcPPQMFQp+MQ@mail.gmail.com>
 <20250114203922.GA5051@redhat.com> <CAEf4BzaRCzWMVvyGC_T52djF7q65yM8=AdBEMOPUU8edG-PLxg@mail.gmail.com>
 <20250114221002.GA10122@redhat.com>
In-Reply-To: <20250114221002.GA10122@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 14 Jan 2025 15:52:23 -0800
X-Gm-Features: AbW1kvaFB1PYsr93n9yEMVFW17_zPOqRsiM6abSy7Xf7yYcskYH5C-Hh6Hu8sVw
Message-ID: <CAEf4BzZquQBW1DuEmfhUTicoyHOeEpT6FG7VBR-kG35f7Rb5Zw@mail.gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eyal Birger <eyal.birger@gmail.com>, mhiramat@kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	BPF-dev-list <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org, tglx@linutronix.de, 
	bp@alien8.de, x86@kernel.org, linux-api@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 2:11=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 01/14, Andrii Nakryiko wrote:
> >
> > On Tue, Jan 14, 2025 at 12:40=E2=80=AFPM Oleg Nesterov <oleg@redhat.com=
> wrote:
> > >
> > > But, unlike sys_uretprobe(), sys_rt_sigreturn() is old, so the existi=
ng
> > > setups must know that sigreturn() should be respected...
> >
> > someday sys_uretprobe will be old as well ;) FWIW, systemd allowlisted
> > sys_uretprobe, see [0]
>
> And I agree! ;)
>
> I mean, I'd personally prefer to do nothing and wait until userspace figu=
res
> out that we have another "special" syscall.
>
> But can we do it? I simply do not know. Can we ignore this (valid) bug re=
port?
>

Seems wrong for kernel to try to guess whether some syscall is
filtered by some policy or not (though maybe I'm misunderstanding the
details and it's kernel-originated problem?). Seems like a recipe for
more problems.

Nothing is really fundamentally broken. Some piece of software needs
an upgraded library to not disable the kernel's special syscall (just
like sys_rt_sigreturn, nothing "new" here, really). Users can't do
uprobing in such broken setups (but not in general), seems like a good
incentive for everyone to push for the right thing here: fixed up to
date software.

> Oleg.
>

