Return-Path: <bpf+bounces-45965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E439E0F56
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B98281F32
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 23:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2454B1DFD82;
	Mon,  2 Dec 2024 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPijlskg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E902C18C;
	Mon,  2 Dec 2024 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733182287; cv=none; b=EJnDhGsVWa02JNDxy6zqBDmmve8w5rEztKs2GStoxTvKhjamxBvoGqpJr7xu05wrG8eahK6ZTo0CPVGGqROucG1DnDHjEFubbxukgIjN8TugtoIdnx8HEdliI3yRFWz3GaFl8fINWshU94lcDpyDSzgdl+Nesp6+X0va59iPLok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733182287; c=relaxed/simple;
	bh=stsqt+IAyvdgQbjBQMS9SdtlQGFWzhw2XwobQdJXe5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrTWByo8LUsJAy47QfqPXKp36Oh7uSLp7X+JLxwGFc86Yglz/oKE5qtTc6C1SdUDVzB/wSrp2oB9o2C5NIecf5Ae+B+9GZY+x974ir+MVffwlKWDd6lcJwfLBkuO3RO8I8/rejdn4QIWIwasgHBbR8IpYISe03U7fglCvuRmmwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPijlskg; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffc1f72a5bso49731061fa.1;
        Mon, 02 Dec 2024 15:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733182284; x=1733787084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FpbSqOOJ7PMriOQtVywjd65Cd51GKP6Qcuj0IVCIhY=;
        b=hPijlskgpoPOkSLEMKbUJ+DZsLNyAEQNiGJHdbog/AF80t0qokl4YLvdqs3rLei50o
         BlPQri6hQnuqVcSr1DxsvtAem4DpBOZFPqvTd78pEgKgq8MvgQeD5zYjom1HsIgZpztt
         t2uSa8n8MBEwcWv3D34kqJtAi7EVw2I0U9DMF3P3ZqAyw5XZRAN0+eY2B9OY3YX38Hii
         TOUWGPDoekN3jt7wdkDrlUuHgL3UgQyx7Q73Xb5n8R4ld9nwobc91fh6KD2MdyTKY9g0
         EMrqASqpHgBgmh7WJV8V1QgOJJRNKbXZpwy/oeraI3mSEcrB3L9zUNsuy3JO4qv1dGje
         EWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733182284; x=1733787084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FpbSqOOJ7PMriOQtVywjd65Cd51GKP6Qcuj0IVCIhY=;
        b=bxGaI9DKL5oTwrzFezbnedUJi8Sl248lJ5Y010QpScXUCBDxMUyvKHIDkq4XLDajLf
         kxUgTbXSQeTNKJ21KMLgPlxURelQF+ySwkLPTJ7s3zauvisWTG78XeO3fwzhAVf6ETsv
         NEnAPgT/y0eZ9Uuebc/MuaQMRMqHQ6pSSgECDMOVh67UmA2u8zzoKGNzBNQo3et/lkI+
         xoDARAznfRyLCASvGS1hNfaEV9N6/7p1TbJUuut3UkQiZDBj85Xx540rujolZMazF5uS
         13er97Q7zwEfPNcaeBw6QKIV1pXbYbmaX4rkjdevfpfFCNDh6fuonZOER4RcT7nIg7ff
         7+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCULV87UUCiJ2OIFk+gxFjJd7H83oky+/Ay5nucrVpGaO//Yz7AcctgUE1lu5Y2wrtLquNE=@vger.kernel.org, AJvYcCUYGteKBroNSGT8PEOnQRjN2TFGwSbH/eB4BB6cuJXESCVCFDBcSU4NL6+EbhGGYemAO6I2GBe+sPYM/GZx@vger.kernel.org
X-Gm-Message-State: AOJu0YyUX3FVzNN5vSPADejeClvALscrVe7RAjDllZt5pG5N2xv9l8vM
	xFZNaS0SGJjoujq6oSjS84vFzprM+i6Xrv5SiHlmwKtiaCo5BIPeuKjP02lc69vH+wKIVkRYUcQ
	cUsNbfrRLdKd1FAsdFqMWBnA58SM=
X-Gm-Gg: ASbGncvor8/isMiV2z7YDi4aFlwyEKrx8PrneO/J4ow7+dLPZwKR6YAtySNGOg2pdIG
	lzYFrZY3pv7nDivVkRtPEwwI70AO1W1A=
X-Google-Smtp-Source: AGHT+IEsoybb8WxQPdlIg0Mtq2P261xRypFmnMMGaqXQE4CBATrjFjLPK9qV8u5oP3l63m3T+D9hDtu+3BZPwi6ND2o=
X-Received: by 2002:a05:651c:b11:b0:2ff:d2d7:ef91 with SMTP id
 38308e7fff4ca-3000a274ed3mr533431fa.11.1733182283693; Mon, 02 Dec 2024
 15:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127074156.17567-1-m.shachnai@gmail.com> <bada6a6b9ab67da9a51a73d3cae36f650c2d48e0.camel@gmail.com>
In-Reply-To: <bada6a6b9ab67da9a51a73d3cae36f650c2d48e0.camel@gmail.com>
From: M Shachnai <m.shachnai@gmail.com>
Date: Mon, 2 Dec 2024 18:31:11 -0500
Message-ID: <CACGhDH2wN4FOc38aPvX5SFx_bWTH23v07s5C+qKdFnjhVHUC9Q@mail.gmail.com>
Subject: Re: [PATCH v2] bpf, verifier: Improve precision of BPF_MUL
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 5:53=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-11-27 at 02:41 -0500, Matan Shachnai wrote:
>
> [...]
>
> > In conclusion, with this patch,
> >
> > 1. We were able to show that we can improve the overall precision of
> >    BPF_MUL. We proved (using an SMT solver) that this new version of
> >    BPF_MUL is at least as precise as the current version for all inputs=
.
> >
> > 2. We are able to prove the soundness of the new scalar_min_max_mul() a=
nd
> >    scalar32_min_max_mul(). By leveraging the existing proof of tnum_mul
> >    [1], we can say that the composition of these three functions within
> >    BPF_MUL is sound.
>
> Hi Matan,
>
> I think this is a nice simplification of the existing code.
> Could you please also add a few canary tests in the
> tools/testing/selftests/bpf/progs/verifier_bounds.c ?
> (e.g. simple case plus possible edge cases).

Thanks for your feedback, Eduard! We'll be happy to add test-cases to
exercise BPF_MUL.

> Something like:
>
>     SEC("tc")
>     __success __log_level(2)
>     __msg("r6 *=3D r7 {{.*}}; R6_w=3Dsome-range-here")
>     __naked void mult_mixed_sign(void)
>     {
>         asm volatile (
>         "call %[bpf_get_prandom_u32];"
>         "r6 =3D r0;"
>         "call %[bpf_get_prandom_u32];"
>         "r7 =3D r0;"
>         "r6 &=3D 0xf;"
>         "r6 -=3D 1000000000;"
>         "r7 &=3D 0xf;"
>         "r7 -=3D 2000000000;"
>         "r6 *=3D r7;"
>         "exit"
>         :
>         : __imm(bpf_get_prandom_u32),
>           __imm(bpf_skb_store_bytes)
>         : __clobber_all);
>     }
>
> We usually do this as a separate patch in a patch-set.
>
> Also, it looks like this has limited applicability in practice,
> because small negative values denote huge unsigned values,
> hence overflow check kicks in for such values.
> E.g. no range inferred for [-10,5] * [-20,-5]:
>
>   0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
>   1: (bf) r6 =3D r0                       ; R0_w=3Dscalar(id=3D1) R6_w=3D=
scalar(id=3D1)
>   2: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
>   3: (bf) r7 =3D r0                       ; R0_w=3Dscalar(id=3D2) R7_w=3D=
scalar(id=3D2)
>   4: (57) r6 &=3D 15                      ; R6_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D(0x0; 0xf))
>   5: (17) r6 -=3D 10                      ; R6_w=3Dscalar(smin=3Dsmin32=
=3D-10,smax=3Dsmax32=3D5)
>   6: (57) r7 &=3D 15                      ; R7_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D(0x0; 0xf))
>   7: (17) r7 -=3D 20                      ; R7_w=3Dscalar(smin=3Dsmin32=
=3D-20,smax=3Dsmax32=3D-5,umin=3D0xffffffffffffffec,umax=3D0xffffffffffffff=
fb,umin32=3D0xffffffec,umax32=3D0xfffffffb,var_off=3D(0xffffffffffffffe0; 0=
x1f))
>   8: (2f) r6 *=3D r7                      ; R6_w=3Dscalar() R7_w=3Dscalar=
(smin=3Dsmin32=3D-20,smax=3Dsmax32=3D-5,umin=3D0xffffffffffffffec,umax=3D0x=
fffffffffffffffb,umin32=3D0xffffffec,umax32=3D0xfffffffb,var_off=3D(0xfffff=
fffffffffe0; 0x1f))
>   9: (95) exit
>
> Compared to:
>
>   0: R1=3Dctx() R10=3Dfp0
>   ; asm volatile ( @ verifier_bounds.c:1208
>   0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
>   1: (bf) r6 =3D r0                       ; R0_w=3Dscalar(id=3D1) R6_w=3D=
scalar(id=3D1)
>   2: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
>   3: (bf) r7 =3D r0                       ; R0_w=3Dscalar(id=3D2) R7_w=3D=
scalar(id=3D2)
>   4: (57) r6 &=3D 15                      ; R6_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D(0x0; 0xf))
>   5: (17) r6 -=3D 1000000000              ; R6_w=3Dscalar(smin=3D0xffffff=
ffc4653600,smax=3D0xffffffffc465360f,umin=3D0xffffffffc4653600,umax=3D0xfff=
fffffc465360f,smin32=3Dumin32=3D0xc4653600,smax32=3Dumax32=3D0xc465360f,var=
_off=3D(0xffffffffc4653600; 0xf))
>   6: (57) r7 &=3D 15                      ; R7_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D(0x0; 0xf))
>   7: (17) r7 -=3D 2000000000              ; R7_w=3Dscalar(smin=3D0xffffff=
ff88ca6c00,smax=3D0xffffffff88ca6c0f,umin=3D0xffffffff88ca6c00,umax=3D0xfff=
fffff88ca6c0f,smin32=3Dumin32=3D0x88ca6c00,smax32=3Dumax32=3D0x88ca6c0f,var=
_off=3D(0xffffffff88ca6c00; 0xf))
>   8: (2f) r6 *=3D r7                      ; R6_w=3Dscalar(smax=3D0x7fffff=
fffffffeff,umax=3D0xfffffffffffffeff,smax32=3D0x7ffffeff,umax32=3D0xfffffef=
f,var_off=3D(0x0; 0xfffffffffffffeff)) R7_w=3Dscalar(smin=3D0xffffffff88ca6=
c00,smax=3D0xffffffff88ca6c0f,umin=3D0xffffffff88ca6c00,umax=3D0xffffffff88=
ca6c0f,smin32=3Dumin32=3D0x88ca6c00,smax32=3Dumax32=3D0x88ca6c0f,var_off=3D=
(0xffffffff88ca6c00; 0xf))
>   9: (95) exit
>
> Is it possible to do check_mul_overflow() for signed bounds and
> rely on reg_bounds_sync() for unsigned?
>

The patch in its current form (and the existing BPF_MUL version in the
verifier) doesn't handle negative values well, as the example you gave
here illustrates. The initial goal of this patch was to improve
precision of unsigned multiplication. However, there is a canonical
way to perform signed multiplication which is sound and is able to
handle negative values. Specifically, signed multiplication can be
performed soundly by [min(a, b, c, d), max(a, b, c, d)], where a, b,
c, d correspond to the four products obtained by multiplying all the
bounds (these products are checked for overflows). For better
precision, we propose having both unsigned multiplication as well as
signed multiplication. The resulting bounds can then be refined in
reg_bounds_sync().

We will update our patch with both signed and unsigned multiplication,
add test-cases, and send it all as a patch-set soon.

Best,
Matan

> [...]
>

