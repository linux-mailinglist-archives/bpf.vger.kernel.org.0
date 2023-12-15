Return-Path: <bpf+bounces-17936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B9A813FA4
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76269283FE9
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791A2808;
	Fri, 15 Dec 2023 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbZRVB8E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511BA53A0;
	Fri, 15 Dec 2023 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-5e32af77f15so1522627b3.2;
        Thu, 14 Dec 2023 18:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702606650; x=1703211450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHC0g7TxjnoDlXpoO2sk8yHPL9OSrBgd0saG+LoF+14=;
        b=IbZRVB8EW/R3b40mXHkrkejAOOwssT/SXJyL/JSP0KJWXrlCirfF3BPsXS+H27/iqr
         FPC8F5xFkIR57ANHkzCC9OWgvLsEgViZp1rIdktXClVCMNhqPjclJxA51/W9O4pnPOxv
         taGNiM38Bxp0+o+tlJAa9y/1vDJLqjJEnOPt29D0TniO1f95CE6jql/qj9uOsMyY7co6
         7zrKIMUMVGHEJ6YvqGA4YA+sjF2IU0X37NQjkuGQZTaJILt/J6Ibd7HLl92fUlOKhKry
         aQ894sRyHqRyayYCoNRPRsgZla+hZetb8wLIMGXOiWAu4pk9P3iUtQJvdbcqNNlvl6p+
         tntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702606650; x=1703211450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHC0g7TxjnoDlXpoO2sk8yHPL9OSrBgd0saG+LoF+14=;
        b=QAEX1QRkqgj1gDSMzzkufz5Gw8kE+TJglAmdvP+MSPORjZeW4umakzKjpkAzv7E2mb
         wCu/dUBnj3CGBPnxLehu0fezqhbPUDCElaLmLvEb5NzBw2rZia4Gu9JQ2dXXbjHPmmeQ
         y5R6cvSUV2pHW39dH9+2jmNpLqFMhOnbp26i2qadR50yLxu8N82pOmOeFOao9oyPQCgq
         Pj6Ynb28VuCrnDZFFZ8UiYVWriFk39rcstG0IQpb55sA4zZu9BGUHT37Dk1VT4vEehn8
         0w3ZSzJFff5xM2NjQiudSWWxUOUKT8i+JNaxh18DY3YuOB4PrNCLElRZbv1j+/yLnEDP
         s8vQ==
X-Gm-Message-State: AOJu0Yzh26fi0xvl3QHNgcdSWepHKOxnx1gGAdhkWgWlYsYZ3YWF5a/w
	10Evgbg62/fYyxUoLL1bUpQb4NUCdu7Kzoa3d1A=
X-Google-Smtp-Source: AGHT+IHIlLEN/LIHWzGPceKJyEZmh1J+JxEJzDy6iX3IyTPLxygFgF1NxCUnebMy/N80cCQpORMWZr72Q6N861mh980=
X-Received: by 2002:a81:8401:0:b0:5e2:b258:4e1e with SMTP id
 u1-20020a818401000000b005e2b2584e1emr3673494ywf.16.1702606649933; Thu, 14 Dec
 2023 18:17:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214062434.3565630-1-menglong8.dong@gmail.com>
 <20231214062434.3565630-3-menglong8.dong@gmail.com> <CAEf4BzZdLvwbh_-GNoqD=ghgK+GxgXwUBKP6yQQH=vWMP4Csqw@mail.gmail.com>
In-Reply-To: <CAEf4BzZdLvwbh_-GNoqD=ghgK+GxgXwUBKP6yQQH=vWMP4Csqw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 15 Dec 2023 10:17:18 +0800
Message-ID: <CADxym3Zv+cbQApEFgRVYj1p9B9i8Hyj6V4Cm5etA8dgWP2Vwqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: activate the OP_NE login
 in range_cond()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 7:24=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 13, 2023 at 10:28=E2=80=AFPM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > The edge range checking for the registers is supported by the verifier
> > now, so we can activate the extended login in
> > tools/testing/selftests/bpf/prog_tests/reg_bounds.c/range_cond() to tes=
t
> > such logic.
> >
> > Besides, I added some cases to the "crafted_cases" array for this logic=
.
> > These cases are mainly used to test the edge of the src reg and dst reg=
.
> >
> > Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> > ---
> > v2:
> > - add some cases to the "crafted_cases"
> > ---
> >  .../selftests/bpf/prog_tests/reg_bounds.c     | 25 ++++++++++++++-----
> >  1 file changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tool=
s/testing/selftests/bpf/prog_tests/reg_bounds.c
> > index 0c9abd279e18..53b8711cfd2d 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> > @@ -590,12 +590,7 @@ static void range_cond(enum num_t t, struct range =
x, struct range y,
> >                 *newy =3D range(t, max_t(t, x.a, y.a), min_t(t, x.b, y.=
b));
> >                 break;
> >         case OP_NE:
> > -               /* generic case, can't derive more information */
> > -               *newx =3D range(t, x.a, x.b);
> > -               *newy =3D range(t, y.a, y.b);
> > -               break;
> > -
> > -               /* below extended logic is not supported by verifier ju=
st yet */
> > +               /* below logic is supported by the verifier now */
> >                 if (x.a =3D=3D x.b && x.a =3D=3D y.a) {
> >                         /* X is a constant matching left side of Y */
> >                         *newx =3D range(t, x.a, x.b);
> > @@ -2101,6 +2096,24 @@ static struct subtest_case crafted_cases[] =3D {
> >         {S32, S64, {(u32)(s32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2, =
0}},
> >         {S32, S64, {0, 1}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
> >         {S32, U32, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}, {(u32)(s32)S=
32_MIN, (u32)(s32)S32_MIN}},
> > +
> > +       /* edge overlap testings for BPF_NE */
> > +       {U64, U64, {1, 1}, {1, 0x80000000}},
> > +       {U64, S64, {1, 1}, {1, 0x80000000}},
> > +       {U64, U32, {1, 1}, {1, 0x80000000}},
> > +       {U64, S32, {1, 1}, {1, 0x80000000}},
> > +       {U64, U64, {0x80000000, 0x80000000}, {1, 0x80000000}},
> > +       {U64, S64, {0x80000000, 0x80000000}, {1, 0x80000000}},
> > +       {U64, U32, {0x80000000, 0x80000000}, {1, 0x80000000}},
> > +       {U64, S32, {0x80000000, 0x80000000}, {1, 0x80000000}},
> > +       {U64, U64, {1, 0x80000000}, {1, 1}},
> > +       {U64, S64, {1, 0x80000000}, {1, 1}},
> > +       {U64, U32, {1, 0x80000000}, {1, 1}},
> > +       {U64, S32, {1, 0x80000000}, {1, 1}},
> > +       {U64, U64, {1, 0x80000000}, {0x80000000, 0x80000000}},
> > +       {U64, S64, {1, 0x80000000}, {0x80000000, 0x80000000}},
> > +       {U64, U32, {1, 0x80000000}, {0x80000000, 0x80000000}},
> > +       {U64, S32, {1, 0x80000000}, {0x80000000, 0x80000000}},
>
> JNE and JEQ are sign-agnostic, so there is no need to use both U64 and
> S64 variants for comparison. As for the choice of values. Wouldn't it
> make sense to use really a boundary conditions:
>
> 0, 0xffffffffffffffff, and 0x80000000000000 for 64-bit and
> 0, 0xffffffff, and 0x80000000 for 32-bit? For this one use U32 as the ini=
t type?
>

Yeah, this makes sense.

> BTW, all these cases should be tested with auto-generated tests, so
> please make sure to run
>
> sudo SLOW_TESTS=3D1 ./test_progs -t reg_bounds_gen -j
>
> locally. It will take a bit of time, but should help to get confidence
> in that everything is working and nothing regressed.
>

I have already run the slow testing (it indeed takes some time)
and everything works well. I'll add the test results to the commit
log in the next version too.

Thanks!
Menglong Dong

> >  };
> >
> >  /* Go over crafted hard-coded cases. This is fast, so we do it as part=
 of
> > --
> > 2.39.2
> >

