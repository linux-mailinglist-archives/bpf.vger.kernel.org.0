Return-Path: <bpf+bounces-34187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86FA92AE01
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 04:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D792282874
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 02:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FD538DF2;
	Tue,  9 Jul 2024 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDM8JDRz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9747F4A
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720490646; cv=none; b=BYK7m4+T3eAdGzhnjMo1cYoQvegoNdDX4ExjqR6HueaBTxADEniX7e5AWnliPWKjtwtXpVfMuqs4PJTP6K89QUqxXmhW3TlUawY39p50ud+WIuQanVoV7cqX9/GvTuYAutCDxVUGMM0HvWtaglF0uwFpn0U91pFuKe+3D+FLd40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720490646; c=relaxed/simple;
	bh=nCz+u90FShihLbEG5wWe9aovwu+pNENsbKplgpXoNsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCob+joF6DuqzNguiLGuQ1iZXqu8VTT0VeQ/8ArwaYlJ3VFNAyMPxvtPEytjrjKe4NyD4WgFJQB0KEkNsPKQR0X5URl5TdXbUwIPTY4FbJcHg4dRRkbHKCAl6IWphGynLGlcTtQsV0iXB+U56VxtftP6lfy8ypixqkA66+xKNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDM8JDRz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36799a67d9cso3809562f8f.0
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 19:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720490643; x=1721095443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN2lGVvwcDyJrfG6FxpqRNL5lTIicwiyE6sjAYJ4jRk=;
        b=SDM8JDRzA76j4eaMIFaPciVmHzLN1HhGhrPQxAEROJniefh9f1UOlZe5SXOcIDeYto
         +/f8bkaEb+1Vqh8QxZM7mhF6l+rCt4REul/2+Q/lQiOMmsnPs3sAt9/bDmOAIKNa4+0A
         VqnzCZLb0/q8LxBO+gKnEA3HXdthMpQlsmbQPM+TE9ENLUxJuiIEq2FuyW3esXep78L6
         aLXo6wa0uWm2KMxfJVKcNIW99d9atL5uoL+Tjl8g3aZZjQycI5LtJeVkYNSngOmO1ksv
         jv8giVXh89UyCuwezjT1pTw8B2ZZIx9rPldIvVA7rxrPtYZB4RoaTTMFZDCkyxygZg81
         wz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720490643; x=1721095443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yN2lGVvwcDyJrfG6FxpqRNL5lTIicwiyE6sjAYJ4jRk=;
        b=udCosP1jobr9wmBOXfOEwljMFRsYVDkkcpMF1ehJhY7hQVG7+hsStUIjJxkpEcQvEx
         SfncFwbj+x621Mtd5OKK28IKUD0Xg5JerLQLyQCognDAv1tACZLjDZKBNILnIQsPu/9i
         m2AibCF/vltRm1vRCKf0A+fGJONCU7jU3f8BZUt1EBA6k7+xxsjUtZQQVoJxXThlEY17
         rcSyrT/lvoxhaWLB567rhxjlPGtbM6P0LgO27MrSzJ5WWBTqB1gwK+8Ea0ptrPuZgKST
         aDOMwY5bSjE/OZZohNSpIW0B0IzBTluJIH4i9yt6ylkYBHcBIvZmhjyLk5AIsgqrTQ0D
         Ha7w==
X-Forwarded-Encrypted: i=1; AJvYcCUaSPQwLAxO7VJc+1bvshDDQKPkmZaBcpKyDaigfxV6z8b7T7Wi7uqhfIfmrZV4w8NXo6w4C2rdas11b7lSe4ZrGow8
X-Gm-Message-State: AOJu0Yzca21r1OkeckRhkuueKsOaLhu5gpiQH6HVvy3bVncDn5Sa8ZgW
	d5f1LkvI9J/phvqLz+lI5Sp/KIj7IABeHz6dH6MbGCWsg0D5P72NSa2vMtm6hOav17kaFnSGL4P
	Fi2Pi5ohqD/j9MyFqYq4McTIhBR0=
X-Google-Smtp-Source: AGHT+IEiC/Cx+BxaOfmDgI/b4CeytQ+TtxVFeU3675DM/VUSAWPAjkAQBmk/tiQwxPFAAeb/JtCnuQWE6p9F8pmpF14=
X-Received: by 2002:a5d:4cd2:0:b0:367:9801:9c67 with SMTP id
 ffacd0b85a97d-367cead15c3mr916072f8f.48.1720490643251; Mon, 08 Jul 2024
 19:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708154634.283426-1-yonghong.song@linux.dev>
 <CAADnVQL4YenuuaAjpW0T7mHv=LEk4xZHS2W=OF6QJsUPL700ZQ@mail.gmail.com>
 <234f2c8e-b4f5-4cda-86b9-651b5b9bc915@linux.dev> <CAADnVQJTgxhpKJDLVb9FY+Zuu7NNuTzEq9Cy4zFJ2=DDHSCFng@mail.gmail.com>
 <0e6db29edc9121d21fb25fe2b239c9d1cd8d6f58.camel@gmail.com>
 <CAEf4BzZac9SXdNHT3SwzAF4OGddj1KKpMNNQRwW_Rf5o+Jakbg@mail.gmail.com> <CAEf4BzZ3iTi1KGU6toCaKrzjQvP5SrJiB5LK0sSOTdctB_93+A@mail.gmail.com>
In-Reply-To: <CAEf4BzZ3iTi1KGU6toCaKrzjQvP5SrJiB5LK0sSOTdctB_93+A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jul 2024 19:03:52 -0700
Message-ID: <CAADnVQK9LbN2AbHj653RE45MeZYmpzJOHFRGRjRUVqeLEGRmsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround iters/iter_arr_with_actual_elem_count
 failure when -mcpu=cpuv4
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:12=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jul 8, 2024 at 3:11=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jul 8, 2024 at 2:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Mon, 2024-07-08 at 13:18 -0700, Alexei Starovoitov wrote:
> > >
> > > [...]
> > >
> > > > > the 32bit_sign_ext will indicate the register r1 is from 32bit si=
gn extension, so once w1 range is refined, the upper 32bit can be recalcula=
ted.
> > > > >
> > > > > Can we avoid 32bit_sign_exit in the above? Let us say we have
> > > > >    r1 =3D ...;  R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x=
7fffffff), R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D=
32,var_off=3D(0x0; 0x3f))
> > > > >    if w1 < w6 goto pc+4
> > > > > where r1 achieves is trange through other means than 32bit sign e=
xtension e.g.
> > > > >    call bpf_get_prandom_u32;
> > > > >    r1 =3D r0;
> > > > >    r1 <<=3D 32;
> > > > >    call bpf_get_prandom_u32;
> > > > >    r1 |=3D r0;  /* r1 is 64bit random number */
> > > > >    r2 =3D 0xffffffff80000000 ll;
> > > > >    if r1 s< r2 goto end;
> > > > >    if r1 s> 0x7fffFFFF goto end; /* after this r1 range (smin=3D0=
xffffffff80000000,smax=3D0x7fffffff) */
> > > > >    if w1 < w6 goto end;
> > > > >    ...  <=3D=3D=3D w1 range [0,31]
> > > > >         <=3D=3D=3D but if we have upper bit as 0xffffffff........=
, then the range will be
> > > > >         <=3D=3D=3D [0xffffffff0000001f, 0xffffffff00000000] and t=
his range is not possible compared to original r1 range.
> > > >
> > > > Just rephrasing for myself...
> > > > Because smin=3D0xffffffff80000000 if upper 32-bit =3D=3D 0xffffFFFF
> > > > then lower 32-bit has to be negative.
> > > > and because we're doing unsigned compare w1 < w6
> > > > and w6 is less than 80000000
> > > > we can conclude that upper bits are zero.
> > > > right?
> > >
> > > Sorry, could you please explain this a bit more.
> >
> > Yep, also curious.
> >
> > But meanwhile, I'm intending to update bpf_for() to something like
> > below to avoid this code generation pattern:
> >
>
> Well, thank you, Gmail, for messed up formatting. See [0] for properly
> formatted diff.
>
>   [0] https://gist.github.com/anakryiko/08a4374259469803af4ea2185296b0cb

Not that simple. It needs sizeof(start)=3D=3D8 extra hack like bpf_cmp().
And the same with 'end'. So it will get just as ugly.
Let's make the verifier smarter instead.

