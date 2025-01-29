Return-Path: <bpf+bounces-50073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72299A22678
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 23:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E310618858B5
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 22:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226281E3785;
	Wed, 29 Jan 2025 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwIHm0Nf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0DB1ACEB5;
	Wed, 29 Jan 2025 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738191189; cv=none; b=DGotGyZ0QHX6EtYuMzcVPklJY7K9kXuTSgi157YHAmXm+GRVNdMq3PZllquuf0daVXndPUN5Gs/7oHPIl6P6iJE5YNTA6ZGYDltVRorFZIeoqIDskvZ5KDtjrYnwm3tBZfNWqPEg5589qO9Lk+RjlEt7UsCQZ7uxw8h1am3WVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738191189; c=relaxed/simple;
	bh=JQMPttJqfWA8jYJfQMhKKdaY7u1wRGX2h33H9KEYbbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lB19j53lKjBUxt1VjKzikTrtoautBSjkTMxkSJrcNB1BJ2g3mBYaPM+xc9PnIXebWhkhSGJzOSRP+MHByeuft5kQj0+2tf31va+v1Hm6hx2PDP+2fzl1xs//7duzURCt9/xfteU69Cqbtm0/geo9mE1aSz6Sm1BGZT3uVQQttac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwIHm0Nf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2164b662090so2914525ad.1;
        Wed, 29 Jan 2025 14:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738191187; x=1738795987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQMPttJqfWA8jYJfQMhKKdaY7u1wRGX2h33H9KEYbbE=;
        b=NwIHm0NfpNQVBigNHYsfAyr6h+zsKHIBvdLtHVe5wQIZv0+bKoXWwEj5XWcLI9lEey
         X3etN/hfCejrXLkhvTOaoByZ2qsEC1LcDnc2BOj7GnYLy8fxzQ2DYoAqxYzASj6W3lB0
         h5Va51aOvOE3Ai5J4ggtRpOfQc1xwSNWtl5adpN9GuPe9BgI36ajcrj0AZcHlofG78RY
         VklVqvVHkzRT4pRwKAg3wfk0o3lUsHNY8MmL1Ldi/X6WPWm1uaTn6MmZ5gf+S7ln5eKO
         XTxWFI9yZPLr8wzbsfB6L/zZNWBhKKGpVi6TEjHRxmtKLvI6Qenly+bYhZs2YcM7yrtm
         yk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738191187; x=1738795987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQMPttJqfWA8jYJfQMhKKdaY7u1wRGX2h33H9KEYbbE=;
        b=GiNkGJ0EuikdKIoJOqtWS/KT2xwOnNqCLvhK/N3TJwp0MmcssN+nJRIWbvByAgjB56
         IXuWun+t6+wch42lXW8uibseNTZNzJ+H1hUosvT5rpVUTPpfs1JB1WFKK4w6Ws3qzuod
         MIeAXgw13Yyk5+o3iyQL3xfJEHOwucT1N62XMyBbGyUmkPipPy63dPvWMhoNWjUeis9Q
         X5YiMtSz9WfPpoa7tYhn82v85AYcpJ5mhrG2V0ipgPzxSkG7CAUSp8YRQLvs9FN3zSPG
         v1CLTuFWOw6sg4+1uxusEh4GGU/ex0G2hyoQORWlr7lijPrYec2Sb1ofnlq074b8xX2c
         u0KA==
X-Forwarded-Encrypted: i=1; AJvYcCU1PP4Z75xoF/R/tNyZCs2nszFq7snbUVkGAOZxMhBCxrQimzoSsgEvcpt3tCGW0kh//0FnYFsI@vger.kernel.org, AJvYcCUMVIRwBj+DQDqMHnY00Yr57OjZ6paYbIAc8MpW7XR2ERO7cS1PbGP6ppAhEJtV4G9z4sH0Fjt/7Lgcsg3bLeRc8IJa@vger.kernel.org, AJvYcCUeePPRukB17rs2o9WHZd6I3SF/b+Xg8ThlmI6HuzgdQ8YkpELhPBJh5Gd8Wg4ly6NrnHInlX4ucEkI6S11@vger.kernel.org, AJvYcCVPlUzet1xohbAJErI5fbf0EHB5nv1oU0QfLuj5/zNlsfkzFvlMdA2LL6vFD3bTQGgz1yYUmhuXj8MN@vger.kernel.org, AJvYcCW8ehYtw0vRdPfVSpVVogpFlXuoHZ14NHa3fwQEhYYcBtMAIR2m7cucgwRwOLF2L5p284s=@vger.kernel.org
X-Gm-Message-State: AOJu0YydPkRevYR7swJA1Fh3kuccKHpCEdOnvyRX1qftYic7+j8j64VV
	mWjLaAB8K6B5ZNQFLRZm1sQG4qR/ahhRKJ1VuNL6zey9p/z+KaAlnO6mEc5aTwyjy2IVx49qhOL
	a7Ouq5PSHmFVERargvYBn9lGOgzI=
X-Gm-Gg: ASbGncs/QEhYty1NHD95g/TDlcbKRDm1Nd4PVSrz6mDm6nV8suvvX6qsNwm/JWqgwwb
	iobUAAdcVOmOXZM+Jg//P0CSCgHjoTYtsrCM7i1qGEsN5cpm0BScGYcIqIcV/kFRMkZSZtIWVDR
	QDjf2NjKSRZtyg
X-Google-Smtp-Source: AGHT+IF9R0kh6Qz446uOMnRTkvyYjffEe3Mspfw6bk+dJOSpnnwLEULvROpWxgb2xSxeZZSiByL7CobNy8/T5o6Q6hA=
X-Received: by 2002:a05:6a21:3284:b0:1e8:bd15:6845 with SMTP id
 adf61e73a8af0-1ed7a5a50eamr7493543637.1.1738191187437; Wed, 29 Jan 2025
 14:53:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
 <202501281634.7F398CEA87@keescook> <CAHsH6Gsv3DB0O5oiEDsf2+Go4O1+tnKm-Ab0QPyohKSaroSxxA@mail.gmail.com>
In-Reply-To: <CAHsH6Gsv3DB0O5oiEDsf2+Go4O1+tnKm-Ab0QPyohKSaroSxxA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Jan 2025 14:52:55 -0800
X-Gm-Features: AWEUYZms5OpDUt9oje1WedETk3FwRlRnwT8KINnzUtYSHN_teRJwe2rU5R01zCQ
Message-ID: <CAEf4BzZxR0RDTQ2TmBko-AM9FQg6JjvRmqXeuqS4K99TdSO1uQ@mail.gmail.com>
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without filtering
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Kees Cook <kees@kernel.org>, luto@amacapital.net, wad@chromium.org, oleg@redhat.com, 
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com, 
	bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 9:27=E2=80=AFAM Eyal Birger <eyal.birger@gmail.com>=
 wrote:
>
> Hi,
>
> Thanks for the review!
>
> On Tue, Jan 28, 2025 at 5:41=E2=80=AFPM Kees Cook <kees@kernel.org> wrote=
:
> >
> > On Tue, Jan 28, 2025 at 06:58:06AM -0800, Eyal Birger wrote:
> > > Note: uretprobe isn't supported in i386 and __NR_ia32_rt_tgsigqueuein=
fo
> > > uses the same number as __NR_uretprobe so the syscall isn't forced in=
 the
> > > compat bitmap.
> >
> > So a 64-bit tracer cannot use uretprobe on a 32-bit process? Also is
> > uretprobe strictly an x86_64 feature?
> >
>
> My understanding is that they'd be able to do so, but use the int3 trap
> instead of the uretprobe syscall.
>

Syscall-based uretprobe implementation is strictly x86-64 and I don't
think we have any plans to expand it beyond x86-64. But uretprobes in
general do work across many bitnesses and architectures, they are just
implemented through a trap approach (int3 on x86), so none of that
should be relevant to seccomp. It's just that trapping on x86-64 is
that much slower that we had to do syscall to speed it up but quite a
lot.

> > > [...]
> > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > index 385d48293a5f..23b594a68bc0 100644
> > > --- a/kernel/seccomp.c
> > > +++ b/kernel/seccomp.c
> > > @@ -734,13 +734,13 @@ seccomp_prepare_user_filter(const char __user *=
user_filter)
> > >

[...]

