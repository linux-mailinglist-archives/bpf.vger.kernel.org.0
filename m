Return-Path: <bpf+bounces-18266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB02F81812B
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 06:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7761C233B0
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 05:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E736FB4;
	Tue, 19 Dec 2023 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9tG77Hv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5F8C123;
	Tue, 19 Dec 2023 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5522ba3f94aso4816510a12.1;
        Mon, 18 Dec 2023 21:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702965158; x=1703569958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjKvIfyh3X2uXJsjh+uNuHx78kVuqzdM9QpykL89Q5w=;
        b=U9tG77HvAFCfTynoBOPrdlsYkEuy016lhzuTaPA9oNU9kz1USGAu+BFMu8i2D66Fj4
         vwe+XDptxFaPB0GAzeX/Ry7BmmgLNm8gapVczsIQ0P9AW5N78Mb8Wc4wD89ClazkTF9d
         yB6uczqKAxRIHcqbb86SF/K4iZA8XOTiOU8SKCiWzL6ORlQJDN2FEdah3ugJhe2SGVGQ
         ykmj+l5xVJnTrJSO58MVjU+7aZPgz0CL+dUPXd6bhp6EwA3t0f+pQhpVPfmbmkCuJURC
         OP4fd4Ly3ab5l9fG68wDHxHg2nJPwQb8gUFY5epax2bWeUSW30Bi5rZ5ff1Wz2Zoei99
         cdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702965158; x=1703569958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjKvIfyh3X2uXJsjh+uNuHx78kVuqzdM9QpykL89Q5w=;
        b=ftKNloraiRWaueP0BVi6kBDCVU9VPCznRTE4dhWLtzX9HEdUFbsYZY144fyp0xVJkH
         KKSh309P8EoMZ95X86Up71HLo/SlDBIXNUOPSKW8Q1YoUkY65QtFbEOfgrvooVcFvgeR
         frEfb0X7w6XuwmHy6FiNuOpgcOPkhceH6Uk/jv/CTqMWrPHVmmE+uQHiZA4/Vsl79H+W
         Xg00/jU1CP5WdTLDQz9FpM0HQycuUcCpJvn/hiNolZyNMsN9jVLEyJq7QIYaCzAmZl6g
         Us72x6/oIR3aI8r9OzM3JAoef8x3mXindarMiP7MDlSWPdwmE+WPfgGayFIG1nMXH31m
         Lskw==
X-Gm-Message-State: AOJu0YxR0ZiVEpkKUYAT4wxZSmaRkZBSYUvqifLiYtOsUOCvx+uGXUgH
	TxQTVxCkVoGxRnqoEBgRRmwL2VSC1Al2DxckUSE=
X-Google-Smtp-Source: AGHT+IGlXUYN/xt/hszzXLDhAjr0+M4RYUQUIXhOimBvD2LNQHG/0zRErbSB4yuk1RCo8k4nCmk/S9lhj8X0NNxwyWY=
X-Received: by 2002:a50:c35d:0:b0:553:88d0:f3f0 with SMTP id
 q29-20020a50c35d000000b0055388d0f3f0mr186304edb.153.1702965157908; Mon, 18
 Dec 2023 21:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217131716.830290-1-menglong8.dong@gmail.com>
 <20231217131716.830290-3-menglong8.dong@gmail.com> <CAEf4Bza8UtCTCxe5QgstxexDhU1oz83MMmnT1w5xzV7czF+7zQ@mail.gmail.com>
 <CADxym3Z6nVemG7_-jmCgfxVhKAYr7Joq6wgg7RRZFJ7hQVH2og@mail.gmail.com>
In-Reply-To: <CADxym3Z6nVemG7_-jmCgfxVhKAYr7Joq6wgg7RRZFJ7hQVH2og@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Dec 2023 21:52:25 -0800
Message-ID: <CAEf4Bzak5OfPftovaAZw5LYPxuQxe1HRXVbPos=QOo_=cr8TsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: activate the OP_NE login
 in range_cond()
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 6:22=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Tue, Dec 19, 2023 at 1:58=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Dec 17, 2023 at 5:18=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > The edge range checking for the registers is supported by the verifie=
r
> > > now, so we can activate the extended login in
> > > tools/testing/selftests/bpf/prog_tests/reg_bounds.c/range_cond() to t=
est
> > > such logic.
> > >
> > > Besides, I added some cases to the "crafted_cases" array for this log=
ic.
> > > These cases are mainly used to test the edge of the src reg and dst r=
eg.
> > >
> > > All reg bounds testings has passed in the SLOW_TESTS mode:
> > >
> > > $ export SLOW_TESTS=3D1 && ./test_progs -t reg_bounds -j
> > > Summary: 65/18959832 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> > > ---
> > > v3:
> > > - do some adjustment to the crafted cases that we added
> > > v2:
> > > - add some cases to the "crafted_cases"
> > > ---
> > >  .../selftests/bpf/prog_tests/reg_bounds.c     | 20 +++++++++++++----=
--
> > >  1 file changed, 14 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/to=
ols/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > index 0c9abd279e18..c9dc9fe73211 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > > @@ -590,12 +590,7 @@ static void range_cond(enum num_t t, struct rang=
e x, struct range y,
> > >                 *newy =3D range(t, max_t(t, x.a, y.a), min_t(t, x.b, =
y.b));
> > >                 break;
> > >         case OP_NE:
> > > -               /* generic case, can't derive more information */
> > > -               *newx =3D range(t, x.a, x.b);
> > > -               *newy =3D range(t, y.a, y.b);
> > > -               break;
> > > -
> > > -               /* below extended logic is not supported by verifier =
just yet */
> > > +               /* below logic is supported by the verifier now */
> > >                 if (x.a =3D=3D x.b && x.a =3D=3D y.a) {
> > >                         /* X is a constant matching left side of Y */
> > >                         *newx =3D range(t, x.a, x.b);
> > > @@ -2101,6 +2096,19 @@ static struct subtest_case crafted_cases[] =3D=
 {
> > >         {S32, S64, {(u32)(s32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2=
, 0}},
> > >         {S32, S64, {0, 1}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
> > >         {S32, U32, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}, {(u32)(s32=
)S32_MIN, (u32)(s32)S32_MIN}},
> > > +
> > > +       /* edge overlap testings for BPF_NE, skipped some cases that =
already
> > > +        * exist above.
> > > +        */
> > > +       {U64, U64, {0, U64_MAX}, {U64_MAX, U64_MAX}},
> > > +       {U64, U64, {0, U64_MAX}, {0, 0}},
> > > +       {S64, U64, {S64_MIN, 0}, {S64_MIN, S64_MIN}},
> > > +       {S64, U64, {S64_MIN, 0}, {0, 0}},
> > > +       {S64, U64, {S64_MIN, S64_MAX}, {S64_MAX, S64_MAX}},
> > > +       {U32, U32, {0, U32_MAX}, {0, 0}},
> >
> > missing case where we compare against U32_MAX constant?
> >
>
> Hello,
>
> There seems to already be one existing above:
>
> {U32, S32, {0, U32_MAX}, {U32_MAX, U32_MAX}},
>

This one is doing S32 comparisons. For =3D=3D and !=3D it doesn't matter,
but it is a different use case. So I'd add U32, U32 case nevertheless.

> > > +       {S32, U32, {(u32)(s32)S32_MIN, 0}, {0, 0}},
> > > +       {S32, U32, {(u32)(s32)S32_MIN, 0}, {(u32)(s32)S32_MIN, (u32)(=
s32)S32_MIN}},
> > > +       {S32, U32, {(u32)(s32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
> > >  };
> > >
> > >  /* Go over crafted hard-coded cases. This is fast, so we do it as pa=
rt of
> > > --
> > > 2.39.2
> > >

