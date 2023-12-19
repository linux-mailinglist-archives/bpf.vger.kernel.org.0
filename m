Return-Path: <bpf+bounces-18256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4D817FBE
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 03:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF23B22840
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 02:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54311FDE;
	Tue, 19 Dec 2023 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNxvadv8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80317D9;
	Tue, 19 Dec 2023 02:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-5e7409797a1so9432317b3.0;
        Mon, 18 Dec 2023 18:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702952576; x=1703557376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0MMmo01++ujfRsHacPRwxc7wnu/ArFjS9XrD77sdog=;
        b=MNxvadv8UWXwoICMDFUbNcyKPlPm4u3LuZJ/+YVdxtGPDZBahDxHR3Oe4v8Z4UTt18
         BlAmSs6j1S9e9uSy2rpvM5P5xkH9fBUVjoBFh8oWBc8aHEURettmfnkqiaDKB59FTdiq
         WhLRQTEA6arBuSl6mwKhtZvGRZroMigX1c8TXPRfGYO9QDbp1VME7Ljp5mirAATe6trH
         rFV6U2Ts6ejVI4q58phlTWj+EPNtKse31xqrdPfE2alHvH0SsVskaRL/m7T3XmBC9iCK
         39CSv8mKu5MdSTbaL6nNMQdlCoAeAxgY/44tE6N4gW2F/WoZv0zIKv8Q4zwHiSO6LsDT
         yqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702952576; x=1703557376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0MMmo01++ujfRsHacPRwxc7wnu/ArFjS9XrD77sdog=;
        b=bC1ky6pKeCJRIMvFaWqI0ecZFLsR8pyeQssss9ALbYDNPfDJnwNdMFxTPzh3jDpk0p
         swAtlA0PmX+UUStJ97DSS/CpzgpYvRcrLj0ebdQEAcCQcsgKyv/Gyub1LFDSsgn1lzDU
         9YQpbEstNyEXeTnQCdpbxK/994uDswwACgnYOYyG3MK1eC9SqKRDJ1odYyNH8tUOTNL0
         O+Oknh6NSdx/lV/IEK7IMldIiQBKZwJb0G0UJJnfiTPPWvlF44QkojptJGjcjWjGRBMO
         RCeYs+hUnmiRzMhREWezVbijVJ7xY1LhHRgrgn8ei4DSE5aWfVgqoBZiF7eD0Nifabtz
         IiEw==
X-Gm-Message-State: AOJu0YzMBNTGWlOPi0JNvsOtJc8OAhkB9Vrlse62TivABdBDQaQLUlT/
	KPr5gEWBP022oLpxgHPzy68e9QYIzCHTQMZcdgE=
X-Google-Smtp-Source: AGHT+IEh228hTmz0xlRT40MIh8uMoBnIdsuSC7gcjApzEBkCcZga3ZewAqE+gi7kXZMiuB/RJSj8QuA3ACONWAfhktg=
X-Received: by 2002:a81:5bd7:0:b0:5de:a261:9074 with SMTP id
 p206-20020a815bd7000000b005dea2619074mr12430086ywb.7.1702952575959; Mon, 18
 Dec 2023 18:22:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217131716.830290-1-menglong8.dong@gmail.com>
 <20231217131716.830290-3-menglong8.dong@gmail.com> <CAEf4Bza8UtCTCxe5QgstxexDhU1oz83MMmnT1w5xzV7czF+7zQ@mail.gmail.com>
In-Reply-To: <CAEf4Bza8UtCTCxe5QgstxexDhU1oz83MMmnT1w5xzV7czF+7zQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 19 Dec 2023 10:22:44 +0800
Message-ID: <CADxym3Z6nVemG7_-jmCgfxVhKAYr7Joq6wgg7RRZFJ7hQVH2og@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: activate the OP_NE login
 in range_cond()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:58=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Dec 17, 2023 at 5:18=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
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
> > All reg bounds testings has passed in the SLOW_TESTS mode:
> >
> > $ export SLOW_TESTS=3D1 && ./test_progs -t reg_bounds -j
> > Summary: 65/18959832 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> > ---
> > v3:
> > - do some adjustment to the crafted cases that we added
> > v2:
> > - add some cases to the "crafted_cases"
> > ---
> >  .../selftests/bpf/prog_tests/reg_bounds.c     | 20 +++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tool=
s/testing/selftests/bpf/prog_tests/reg_bounds.c
> > index 0c9abd279e18..c9dc9fe73211 100644
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
> > @@ -2101,6 +2096,19 @@ static struct subtest_case crafted_cases[] =3D {
> >         {S32, S64, {(u32)(s32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2, =
0}},
> >         {S32, S64, {0, 1}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
> >         {S32, U32, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}, {(u32)(s32)S=
32_MIN, (u32)(s32)S32_MIN}},
> > +
> > +       /* edge overlap testings for BPF_NE, skipped some cases that al=
ready
> > +        * exist above.
> > +        */
> > +       {U64, U64, {0, U64_MAX}, {U64_MAX, U64_MAX}},
> > +       {U64, U64, {0, U64_MAX}, {0, 0}},
> > +       {S64, U64, {S64_MIN, 0}, {S64_MIN, S64_MIN}},
> > +       {S64, U64, {S64_MIN, 0}, {0, 0}},
> > +       {S64, U64, {S64_MIN, S64_MAX}, {S64_MAX, S64_MAX}},
> > +       {U32, U32, {0, U32_MAX}, {0, 0}},
>
> missing case where we compare against U32_MAX constant?
>

Hello,

There seems to already be one existing above:

{U32, S32, {0, U32_MAX}, {U32_MAX, U32_MAX}},

> > +       {S32, U32, {(u32)(s32)S32_MIN, 0}, {0, 0}},
> > +       {S32, U32, {(u32)(s32)S32_MIN, 0}, {(u32)(s32)S32_MIN, (u32)(s3=
2)S32_MIN}},
> > +       {S32, U32, {(u32)(s32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
> >  };
> >
> >  /* Go over crafted hard-coded cases. This is fast, so we do it as part=
 of
> > --
> > 2.39.2
> >

