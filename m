Return-Path: <bpf+bounces-77655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACCDCECABB
	for <lists+bpf@lfdr.de>; Thu, 01 Jan 2026 00:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AA753006446
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 23:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFD130F52D;
	Wed, 31 Dec 2025 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOXikN5b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C6309DA1
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767223758; cv=none; b=q5bjEkZH0URV/2GTTk3WWxpGeURpTFfvN2KcvNAhIBDRxyuei+ArQBFaYaNdZkfmRba00DoNcpfL8yf9d5rSec1Wbqkkwe7VviwFMQVAvqKUQNQ6tGUFkKekPu8aB4rAoaE6WIRgGB1zAjS0kXpzzcVEnUgL6Gd+Gp9bNQ/ZI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767223758; c=relaxed/simple;
	bh=hB0xMx3xK4vlUcAdrxG3o1/qMew7WKffp4OlrNltVI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3BaLGaXg0QpWIuAyBptCKk9KVmkbLF7tHHKETptgq97YzxDWWOLgvoO8gUG7ZIijelKPUJlt8MtqQB+og96XC2hsvnWPYXk1gi8wIiXSgxutr5hnWBZRnYm/3QIpNU4iZLGlHAzptjYlP/yu3r9BTK3z35Gxg3mec53Yw6UBVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOXikN5b; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b73161849e1so2130178466b.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 15:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767223755; x=1767828555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB0xMx3xK4vlUcAdrxG3o1/qMew7WKffp4OlrNltVI0=;
        b=lOXikN5bgKkeBcu42Skz1ASkL9pYYZs+e6kRxYQsGzTLfqmR9Ee4K1j4ElQeWsJExI
         U1/GyHURClr565DPGjjus22ZJ53RK6MHfegtEUJr8OFH+WU3TIiSieQchnnPCFpue0cE
         FntDRR8892QlZU0zCWifvUfG/ammFh9HwFYirCcGAPNyYj6p1DKq1sSV7ahjyyJBaH2u
         nr3MtXs/Qi5+kzdkK0o/1fZvWZa8nu1Ek9Z72dOPmEGZyhwVK4AQHqWSHSGErrvRHtNk
         Yc02fj/BeRE44KtiBGu3kQQ8rPSL7nTmG0KIjgwGz66Abk+ERxghqppWEV1DvmC0WEuf
         Lahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767223755; x=1767828555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hB0xMx3xK4vlUcAdrxG3o1/qMew7WKffp4OlrNltVI0=;
        b=T/vQlCW+iwEAE1ukCRDH+DbSjNEau0yV3D0QB9rPYTXkfpHq4gKhmhNwt61hbEnGJE
         UdZTbh36QvmkPACpTyLlozwU+jEoXuNe9Uwz+4m2j6Eck9ZDEiMQaDTe86xMA49pziR2
         JWWksd+Dh6JjfcOejBz7t+feV7aCMcARZjwoXDsaDt162hoVPUnZX5l5fd8jcpWqI+is
         FobJARFPtRgjyuZbiIicBKFEpatVWZ4F0fbtDjc2WToTeve5w96Uqy4cFb6RgBaC4357
         XBirHU/aO9lc8tQlmx5bPXFLt9csQn+6Or/+veZ/ZygQVfZN01MaGXuBWDrIxN4SSYhx
         nlYA==
X-Gm-Message-State: AOJu0YyNqEkR3imisJ0jq2l6UkYep7kdUNMqQn9UiH/yVMgyxT/zCoPD
	b6g0IfxOu/TgXpnom2arKHVmxpaFkjVPoEZXirPh0hjsreROHOrPhbssEfilSf6YG99Wxy8qDKT
	p3iR9yBBgA9Is45BhHAPj2G/mLWKMNeU=
X-Gm-Gg: AY/fxX6sfjsf4f0bLVErJrYY6Ojcs2sk/CiNNUzRb0hLlb7gvQAuqtMnZSsLA/66+y2
	EscvKqs9nfTaYxRHAXiRPRgSZVqqDpN/auYNa13PIVYgP6lkZ3G6Ebk3aSTgTMmo5/U/W91n5si
	T1ptR6J9dCZSlmQ1Q/2d+byXvPi1WSzBhTIyUtzOCXeJmS74637baOv4a+ElrMeIzwzx0HlPv98
	aDe4LS3T/LnRVc4ksfQwLlrLNTj52EhpFsoTrT9+mj+IGfvJ054d/94oKHi8Pep4uKcAopjInnD
	Ul5R0i8FL6yUWm/KNAv2qw==
X-Google-Smtp-Source: AGHT+IEUxyeDJXy+JLZmOMUYq1RvLPj6yg2qJS6968JMrTOiqsBqkeVqzxFsHJhb315XSzAWgI3k/Zvl7vmGpUQTMNk=
X-Received: by 2002:a17:907:720a:b0:b7d:406f:2d3d with SMTP id
 a640c23a62f3a-b80371da8dfmr4216679866b.54.1767223755130; Wed, 31 Dec 2025
 15:29:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231171118.1174007-1-puranjay@kernel.org> <20251231171118.1174007-7-puranjay@kernel.org>
 <138667689e511652194fd98ad0e20d71f7738234.camel@gmail.com>
 <CANk7y0hXxYsmgMY9km1ivtt-Bd3=tbjf4+vra5y_5M66srEh_A@mail.gmail.com> <8944ddc867831bf2e5c6d9275618f9c56c61395c.camel@gmail.com>
In-Reply-To: <8944ddc867831bf2e5c6d9275618f9c56c61395c.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 31 Dec 2025 23:29:03 +0000
X-Gm-Features: AQt7F2qPhqYtSNo6X7KTAQlh_tv2Cdq8vpzDBPIhKZZRG8FloHDijgi4LzlzeqI
Message-ID: <CANk7y0gfp=A-1OOj=65VPqCOvZR-E7eZnnXGQt0gnW6u=Ca2DQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 6/9] selftests: bpf: fix test_kfunc_dynptr_param
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 7:44=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-12-31 at 19:39 +0000, Puranjay Mohan wrote:
> > On Wed, Dec 31, 2025 at 7:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Wed, 2025-12-31 at 09:08 -0800, Puranjay Mohan wrote:
> > > > As verifier now assumes that all kfuncs only takes trusted pointer
> > > > arguments, passing 0 (NULL) to a kfunc that doesn't mark the argume=
nt as
> > > > __nullable or __opt will be rejected with a failure message of: Pos=
sibly
> > > > NULL pointer passed to trusted arg<n>
> > > >
> > > > Pass a non-null value to the kfunc to test the expected failure mod=
e.
> > > >
> > > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > > > ---
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > >
> > > Unrelated to this patch-set:
> > > what do you think about merging __nullable and __opt?
> >
> >
> > Yes, I think we should only have __nullable, because that is how
> > programmers are used to think about functions, just pass NULL if it is
> > unused. But I will see what the verifier expects differently from
> > these two and send a patch to merge them.
>
> Ack, thank you.
> After cursory examination seems doable to me.
> __nullable was introduced [1] after __opt, but mailing list discussion
> does not mention __opt at all.
>
> [1] https://lore.kernel.org/all/20231018061746.111364-7-zhouchuyi@bytedan=
ce.com/T/#u

It wasn't that difficult:
https://lore.kernel.org/bpf/20251231232623.2713255-1-puranjay@kernel.org/

I guess this should be merged before default trusted_args.

