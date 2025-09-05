Return-Path: <bpf+bounces-67642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0112B4662D
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83B51D23739
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E58287241;
	Fri,  5 Sep 2025 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGhRh6Rx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34C22129B
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757109120; cv=none; b=b6fm0SgTN6G2IjGAOv5e7qUrrWJo80jm7/i+4XT5Rdr1WoHtFqbC7xXdEVSvnYyDgKE9UhV9VfQcPizikZb2XZAkgGf5VHRtIihJ8lZQA0mFXEw17Je/9Nu2cqsEk7vWluQ2Qfx3mIbl9LumeThYGAFnXQIImkNvZk3zMDGIyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757109120; c=relaxed/simple;
	bh=4lYuciLgrFDDNH1UYNu7CasoUrpi/S5C5VKKOipoEQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yt9B1E9s2lL4sbGIDHMbxqdnMpLQ9YdRTLAm1/LdSNxBi7s623C/DZmxzI1rie2FvjB+vJGhH4ItkP+DfbK34g7JG5rk+5lTae8cdb20h4QZDdmeriFTc5A4TaAygHEUsLUNRv1xSaLsIZxdz2JDKNCcjBaCvSZGF7gQ6bkqk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGhRh6Rx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-248df8d82e2so28332445ad.3
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757109118; x=1757713918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFQVJz+YDMCWdxavl6HxN+CA7fguDUAUcHuwcPmPUdQ=;
        b=CGhRh6RxhBf88ALobBJI8Ze9wRP7E9OslGkaVZs8dIcZzYT5aRrSmaIaC7mwbK9pbQ
         Nw1ol32/vRSWMXZqRqDcyz0NYiLZizFx2/isxItAqVzxt+c19deursERkcdp7sFJk8AX
         mALjasaxDgC0vObrYqP3Gz40qVwpreX5OjfkHfUxoUfdvY+mMKgddycabi65kipyTujr
         M+3HUJ27P35n2wwDvNXdq8aRl41gEt3/HjsFAOw9McvA5tVPy0dZc6guWfqU8Kje1wW9
         Np0CUFNnej5gMQPPkhXd7aksDSY1Avfo509in88Bu7qAxwS8OuTBoeo/EyDLMGMiS9cG
         856Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757109118; x=1757713918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFQVJz+YDMCWdxavl6HxN+CA7fguDUAUcHuwcPmPUdQ=;
        b=J8lbAcc+qAuCVczjr/5Z9nzbKmjuGge62p5+pEgu7mG2fuQF5G9LQzLXXCwpZ/TmjJ
         DQt6uEsUxcvjczzQRTbjC7sC6Wlr0LQDiD3RcHwU7JmR2c91bcGcAU3YFFGT0X20df9+
         AR5hxR5y5byzGjqNuRvG1A5G5sR5z3rtDS9rfiopgDeB3KTZLWq89s58o34CgiG0WBDs
         qTDq5iaE0V513rxKbZ7m8vKmg3F16WoDQXfq+qh+l0lk2/eyejTQKHogKHzCZIZ5j38h
         u2s2nBSrXFmDrS0kHCfL8/5iPpcVE70b4qo78+OkpuO0z1cGEQBTfPcO9fyzGdJYY95X
         UkrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp5xb+WrAKGAtNKuQNbrk7L+sQvkErXBYmkHA3M6jZbsy+atljTAycor0qm0ulAzF4EQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb26+EKdOKV8ljx9AdC9C+cTBPvGh9Qfv8yz7OPng8VAUda1A+
	CDl9eyg5ttgMvMmXvtuFs5dBM1g01U2EwJgW86f4zgkIRrUI9ypOqnSQKoho4zS115zWN9UzqpE
	E9k4qYtmi6pPWgUoLmB8RlR78C2kxdhw=
X-Gm-Gg: ASbGncs4Q6PbLe85DYADYWIE6lae9Ov1sZRxPyKGsImx1P0BVLQ4yrH1xgAdZyFGKEX
	hDDCvqDCr1a/l1LFKSJ1GWqk0CBocnUq3yDJaU09L6dkGWAaVPTb4KjFFQlpxVEXcH1Kg1zA0OW
	YKI+KVzurtnz2ZK6cihuRv5YV+Z4J//1jrSqqtZ54ILEcwZBNclaj3ci1/6bXkIQ6wbMzhCpwCc
	d6WCm8y1YlRDQw=
X-Google-Smtp-Source: AGHT+IHarFSvDXs80fx+ZJ6BgQ9S+OuLRq7aSkVnC9lXT/E8bL31C49uUu2Jvjso9FlrfFqJK6S2ZMmlJ9IeobAxxYI=
X-Received: by 2002:a17:902:e88d:b0:251:2d4d:bdfa with SMTP id
 d9443c01a7336-2516dce7bbdmr2062365ad.20.1757109117947; Fri, 05 Sep 2025
 14:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905140835.1416179-1-mykyta.yatsenko5@gmail.com>
 <ac6e70c96097c677d5689d86dd2bc0dea603a5d1.camel@gmail.com>
 <CAEf4BzbZg-BqMQV5vKHSDPabZQbpHFbdZhQ4NXCRiAZvh0yc=A@mail.gmail.com>
 <d38c391c806ed34e9b669e64be4e1c85afdfd6e3.camel@gmail.com>
 <CAEf4BzawRYXXSJDiK4GzuYo=g-N_-QMgUXQAGN15eaPYuWXBWQ@mail.gmail.com> <84b34c685418234c21bb3c127bb966d5744efc59.camel@gmail.com>
In-Reply-To: <84b34c685418234c21bb3c127bb966d5744efc59.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 14:51:45 -0700
X-Gm-Features: Ac12FXxIsu_4yQIT0sEo_1ZAMyO3waWGzeqU13J88AjeCSGVwzPhmCIIV-fsFsw
Message-ID: <CAEf4Bza5RNDAt0EW4zo27QhHN=qw4CmJakAneCS6T7URxjq-ig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7] selftests/bpf: add BPF program dump in veristat
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 2:43=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2025-09-05 at 14:38 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > > > Fun fact: if you do a minimal Fedora install (dnf group install c=
ore)
> > > > >           "which" is not installed by default o.O
> > > > >           (not suggesting any changes).
> > > >
> > > > I switched to `command -v bpftool` for now, is there any gotcha wit=
h
> > > > that one as well?
> > >
> > > Should be fine, I guess:
> > >
> > >   $ rpm -qf /usr/sbin/command
> > >   bash-5.2.37-1.fc42.x86_64
> >
> > command is actually a shell built-in ([0]). At least for Bourne shells,=
 I think.
> >
> >   [0] https://pubs.opengroup.org/onlinepubs/009695399/utilities/command=
.html
> >
>
> Yes, but looks like it's a separate binary, not a command:
>
>   $ strace command -v ls 2>&1 | grep command
>   execve("/usr/bin/command", ["command", "-v", "ls"], 0x7ffffeaef7b0 /* 6=
5 vars */) =3D 0
>
> (Not that it changes much).

You nerd sniped me here :) You get that execve("/usr/bin/command")
because strace forces the command to be resolved as binary. If you run
something like execsnoop in background and execute `command -v blah`
you won't see this execve. =C2=AF\_(=E3=83=84)_/=C2=AF

>
> [...]

