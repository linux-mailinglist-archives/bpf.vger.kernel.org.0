Return-Path: <bpf+bounces-34676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11B093007E
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 20:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CA71C225B8
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 18:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57DB1B978;
	Fri, 12 Jul 2024 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuFq4Geg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961D18638
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720809042; cv=none; b=AvPQHaJrrA0hj8+zdEdzEGDjzwBuHX3Usqul1JmmX4YIXIuApRAW5dZ3yP3lnIZJoOoCYOeFzTGn08Jj+/siiY2Zgr/DSnGlLOYpH0N7GH7zr1C8Xv4WqidZ1km6DrZDoQVMIK+fWSTMDmLYPTZVSU4RHBDt898HQMwotBSL/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720809042; c=relaxed/simple;
	bh=9D1kcy0VVywANUrpqUjuEE3I8WfIz1jJVbKbPplrLoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBlQnl1x+nGt9wESB1/qIXxUrfKvoj+DguYOw+RMyWUk6b9LcwoLHKiTFzqsxRgSf7M4q/zly6kokR8UhDDFSsTjprj2u2WQ/2GQF7KgkdQ7cGhEQdSraQAAouLlMD7uc0nSNuiYZCCcOmoS0opzHpyHLS2G7TDIwzMXBuXSOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuFq4Geg; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367a3d1a378so1935557f8f.1
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 11:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720809039; x=1721413839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB6SRWzJN5slfMRrSHxmRDvyf4gBRfjRtbaZ5hsA5+w=;
        b=JuFq4GeguLOPT6SVi/ZFNGUMOMyr/vuwXqDZjCoFy+ery8+8lTPA4UJOBFimjp66bL
         Y+QTLI7boke59ISYf9JcuA+E5KhWbsg9bvx4Fj9K+umfhk6qE6LufM5Myh+ZhwFbK4vP
         MgyrclqJH48VHZjeNFjeyBxNrP3+axuHomYum4IHH7MwIeANduK55dgiBsuuBel+bqax
         qMrGHjboAdZRTiqSKhhMzyPCBUkepwyWXThpcR/VN/NfL10NTimpZuyLJckI2fS2tRA9
         o5DjeY2Ja50ps3lE8ET55xk7bkAls2Xl7SeOyPErxEvYF9LoZ6a0Ito3bxXoARcYzmw1
         MbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720809039; x=1721413839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NB6SRWzJN5slfMRrSHxmRDvyf4gBRfjRtbaZ5hsA5+w=;
        b=o28g+f3wdEUc29EpuzNaY/trdbhJdjgia7sEJPfXoxy71FD9NL8nCAYPlYqGdHFfhF
         h/5ygtMxeBdmNL09c6lC7IReUnfgqGUjXL8k9pHQEDdxGX3by1US7NhmxOuZ6Gd4d0eN
         S71yyny46NKqMtEkNVxPuKQFJMNM0zJs6m6SQu3V8lttAKRz1Ano2+oTE98LEd5UeWnX
         /T/VHViO/F68XDw4vy0pG2erlHxsjRJgT7Flp8qZ7F7rXq0eQvZTCidkUuudhXkvFb2N
         r+h15eQ1enj32jGQ5YkgvqwThMrHsMPCXYftbK4+6q+ocs26sdG7ReGVtJgJfn72a2dT
         seDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh46OhZqXG4eElnqzlVDJCXecL63vsF0x3cWek+F1Zq5tFdq6AO+znlGqu780nK9JaYtNDYbVEOpKIORuK559AXA48
X-Gm-Message-State: AOJu0Yx8LftuGFcrkZKMJZvyxV/07WnqpyhXsFtAHHDDU9Kw6tOZnXHO
	rHhdObOnGGXuHhZ58GRGry8fJVorqA8TvgMh4cNnAtUWyIObueLcY4+dHHrFN2Y61jKQmbYSDw2
	rLHjWtU5WqVe4SnoIcwIxwWcwyZk=
X-Google-Smtp-Source: AGHT+IF+7N2D5VvvatCLXwmrjKRFsu24oa93AB2lowwlURyfS30piFKkhF72/EI4q5CXC1SBlIkPClWbfqJdmbMZTlg=
X-Received: by 2002:adf:cd84:0:b0:367:418d:d4d with SMTP id
 ffacd0b85a97d-367ceadc7fbmr8968846f8f.60.1720809038557; Fri, 12 Jul 2024
 11:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710042915.1211933-1-yonghong.song@linux.dev>
 <de03d550a466ef98d4adec4778cdfd12bb247ac3.camel@gmail.com> <d0040ec5-608d-4fc0-903d-0c5e10dfdedc@linux.dev>
In-Reply-To: <d0040ec5-608d-4fc0-903d-0c5e10dfdedc@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jul 2024 11:30:27 -0700
Message-ID: <CAADnVQK-=4UY5W+91MUbUgjb7h3QDw2j6FJ88neh5N4hKjOmKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Get better reg range with ldsx and
 32bit compare
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 10:07=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> >
> >    Here we would like to handle a special case after sign extending loa=
d,
> >    when upper bits for a 64-bit range are all 1s or all 0s.
> >
> >    Upper bits are all 1s when register is in a rage:
> >      [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
> >    Upper bits are all 0s when register is in a range:
> >      [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
> >    Together this forms are continuous range:
> >      [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
> >
> >    Now, suppose that register range is in fact tighter:
> >      [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
> >    Also suppose that it's 32-bit range is positive,
> >    meaning that lower 32-bits of the full 64-bit register
> >    are in the range:
> >      [0x0000_0000, 0x7fff_ffff] (W)
> >
> >    It so happens, that any value in a range:
> >      [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
> >    is smaller than a lowest bound of the range (R):
> >       0xffff_ffff_8000_0000
> >    which means that upper bits of the full 64-bit register
> >    can't be all 1s, when lower bits are in range (W).
> >
> >    Note that:
> >    - 0xffff_ffff_8000_0000 =3D=3D (s64)S32_MIN
> >    - 0x0000_0000_ffff_ffff =3D=3D (s64)S32_MAX
> >    These relations are used in the conditions below.
>
> Sounds good. I will add some comments like the above in v2.

I would add Ed's explanation verbatim as a comment to verifier.c

> >
> >> +    if (reg->s32_min_value >=3D 0) {
> >> +            if ((reg->smin_value =3D=3D S32_MIN && reg->smax_value <=
=3D S32_MAX) ||
> >> +                (reg->smin_value =3D=3D S16_MIN && reg->smax_value <=
=3D S16_MAX) ||
> >> +                (reg->smin_value =3D=3D S8_MIN && reg->smax_value <=
=3D S8_MAX)) {
> > The explanation above also lands a question, would it be correct to
> > replace the checks above by a single one?
> >
> >    reg->smin_value >=3D S32_MIN && reg->smax_value <=3D S32_MAX
>
> You are correct, the range check can be better. The following is the rela=
ted
> description in the commit message:
>
> > This patch fixed the issue by adding additional register deduction afte=
r 32-bit compare
> > insn such that if the signed 32-bit register range is non-negative and =
64-bit smin is
> > {S32/S16/S8}_MIN and 64-bit max is no greater than {U32/U16/U8}_MAX.
> > Here, we check smin with {S32/S16/S8}_MIN since this is the most common=
 result related to
> > signed extension load.
>
> The corrent code simply represents the most common pattern.
> Since you mention this, I will resive it as below in v2:
>     reg->smin_value >=3D S32_MIN && reg->smin_value < 0 && reg->smax_valu=
e <=3D S32_MAX

Why add smin_value < 0 check ?

I'd think
if (reg->s32_min_value >=3D 0 && reg->smin_value >=3D S32_MIN &&
    reg->smax_value <=3D S32_MAX)

is enough?

If smin_value is >=3D0 it's fine to reassign it with s32_min_value
which is positive as well.

