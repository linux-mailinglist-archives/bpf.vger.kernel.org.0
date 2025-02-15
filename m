Return-Path: <bpf+bounces-51636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EF7A36B7A
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 03:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511F51700E1
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 02:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A3A1519B7;
	Sat, 15 Feb 2025 02:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcoCYbtV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13561EACE
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739587332; cv=none; b=cSlDXHbNiD1uBfB90bfvh1yzew26fekm5GcUboFhiO0gVfFuSUsuwRqiXqu4e/W83YZr83xNHDLOXjal9UTnXisr4MeNgj3lwjLdDyJvWCDMBcid1V6B1A3oWg0hS/YvSlEb3a5reymFsDtoYhxebEkZnUEe6JaZxJVLJHt+zwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739587332; c=relaxed/simple;
	bh=mpOMUYKPtSUdiE1UgWdTT/0nSzWZmvr5PfIxu+T0cCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5X5AHcG2U3oMERyJ8+3UNyIfEQD97gC9pQZx3dyR8ZyPCJrSOK643qN1CQFctLrrtJvbsIKjOSBg6HVqWRZSNWcE1WvE4SNNzzrnQBsXfnyGESpDu2ECGgAgV1QVt44L9O1MoONVXPaG1j2p2fL7nRRHsB61+YjIBEa8YVb/BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcoCYbtV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4396794bfdeso15327805e9.3
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 18:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739587329; x=1740192129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J/D99PBia4hft2W4Z0thFDE2dpQunYUlxtV+zdvL1M=;
        b=LcoCYbtVhpEqGJZMBpid5DyMsg4+H1rp1G/N3bfIG9yJf9hnSJD390Xn+7/o1epjqS
         f769JG01BPjzWjUK6isE4P222ceL+sqsdSY3C/BuxmGzrypvrKY7f5nlrkZ5UNSnUPNl
         VxugTQNTp8+LOj5c1e3GhuPkWXzSVa9EMSZk4IBWDpsO4sb3Q/pGlShpr+Pvp5NWdt8X
         OpFWpGbp3AsuBSVvJmj6iu6FsutnbXWTYSaZfSFzcVC0qHOKz5xSvBlQtnTkwj5s3xmx
         J7CQekjL5OaA9r0pK1Vzjw7o7XetSrz2GmgGPD6VmQiprveQ10TtZCKMfQvI3c2IsZM7
         lYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739587329; x=1740192129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4J/D99PBia4hft2W4Z0thFDE2dpQunYUlxtV+zdvL1M=;
        b=eJjo0cMo72tRzY3WWVwl0LcEfujSxr4thhqX1crcAG60xBHajGa0GahPu4xm3HD6Tc
         DVa9oiUHe77xcc5iNIJw/3nvX5Dk4kDnqEhZayL4wFbzsVVHELO0anEgVdW/kQYgA09u
         g2fl1I1C1fI4NtXd7UtbHGfWLH+RQjvq9hsAP6VfB6kZv+MwyM+0SLzz8hXGZn5Ohfvm
         rsuAkuDAK2DlaQgYD41jMbmslu0DCNISHL/m0IhwkGspsRAlX2LRa2dP2KR98B+0PB2n
         Ksm68dvOPPQbVa1HCZa9jUg/dUlFW1U3TmMwmUGyOV5lgeFNSSA8IHIuNvbagR3bZEPF
         sEZQ==
X-Gm-Message-State: AOJu0Yw0Twgf+SqyCtj5no+D2SmajoruddUEi659iuvIV5FDOAVYsaFa
	huaoHdmFexFEqgtompvn2kjf7Al6SPO/EDUZNYCGzxxS4vZC/2YNFQ+VS9c2QcH46cgLlxUtbO9
	ShTcnbFNrs+SF7SsewIgJIiEvjYo=
X-Gm-Gg: ASbGncs+0llMP12dl8jIEAucn4O3iC3GDkKCujnqM7RP+odKzoyrLXbjrFf5oUvowJY
	zjlLkwm4KXij72Xy33tuRY1RduO1Nc8WodnHmTG/SwsDu/8wzD1diYVKZDsOdIfFng1pUwHkH
X-Google-Smtp-Source: AGHT+IFU/RETiPLCoLfVB3afFl5e+eLF8GsTUO0py9pJYzrmq071YA3TVVyGnozJC1NdUPM1xnEO/zmNgVM77qfH3vI=
X-Received: by 2002:a05:600c:46d1:b0:439:6712:643d with SMTP id
 5b1f17b1804b1-4396e6a74f2mr16131475e9.9.1739587328951; Fri, 14 Feb 2025
 18:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214164520.1001211-1-ameryhung@gmail.com> <20250214164520.1001211-2-ameryhung@gmail.com>
In-Reply-To: <20250214164520.1001211-2-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Feb 2025 18:41:58 -0800
X-Gm-Features: AWEUYZlLMth5-_WPTkyBVaayCMUYejnBJRL4DDJvT1FY1H3tFZebgR68yECGptE
Message-ID: <CAADnVQJs0d9fihukcNaw5jfjHTEAMuisR=7fypoJn_DumfV_5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/5] bpf: Make every prog keep a copy of ctx_arg_info
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:45=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
>
> +int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
> +                              const struct bpf_ctx_arg_aux *info, u32 cn=
t)
> +{
> +       prog->aux->ctx_arg_info =3D kcalloc(cnt, sizeof(*info), GFP_KERNE=
L);

could have been kmalloc_array.

> +       if (!prog->aux->ctx_arg_info)
> +               return -ENOMEM;
> +
> +       memcpy(prog->aux->ctx_arg_info, info, sizeof(*info) * cnt);

Please use kmemdup().
Otherwise cocci fans will send a patch for this tomorrow.
imo kmalloc+memcpy is fine, but, sigh, cocci.

pw-bot: cr

