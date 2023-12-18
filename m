Return-Path: <bpf+bounces-18160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3161C816578
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 04:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2E41F223A5
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 03:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4FD5399;
	Mon, 18 Dec 2023 03:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3QDVa1W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF2538B;
	Mon, 18 Dec 2023 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-6d9fdbcec6eso2158521a34.1;
        Sun, 17 Dec 2023 19:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702871790; x=1703476590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAXpZwPFWYTh7NYI9cITpDm8WNXyOT7XhEo/q9GXWHo=;
        b=e3QDVa1WRby/aBsxaTlKmbybUsSMNscE4NGD1WiAZofOXu+5cLkCOokpRPU/ZxjSvG
         cwrtqJ6C0VOKGkGYLMwrlSCzTZ12q1o2RtolFY51CbePTw4RsOQl9BmOlU7kF6GtEMHd
         1clLvPwL1sfBQyTsFsnY0bUk2lrVGvnAY6w4wkRsLlhDVyYZoueMF89+Z/0+aaGLlpzS
         Ojk6708qOiVOvx8diE8lkylqhfu5EPE4RvhX6ejiSquub11Qez4XYKjIF3nxlMtP+vqS
         XOrPANAHVmVqxsyEzNSepcb0+VA3xJfyLCzqPTt7v5nzp0fDY8aU1xvqPnE3T1omyoa4
         uh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702871790; x=1703476590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAXpZwPFWYTh7NYI9cITpDm8WNXyOT7XhEo/q9GXWHo=;
        b=r+euyC7PMvp+5WOP8Ae6rhxVEfFmXokywGfts41/+vcU4GTEE85ikr6WRp+/jn8Rig
         uCc1+ZL7F7+CisqWL7+teQsOaJyGEejZYAZbmMCJl+tu9c+MiS/atczX2Y90ozMeluEF
         RzxsizozFsEAgyBq3e3OBrEEtI3X4J89BEQJj+s2R5KfUyqQIla9EZ8Si8epXH8Z8jun
         Eg/S1EDBk3/zroeousR51s6QR6UZMzXj8iEh8t0frq8/1d17GTTXIYgcnCqJ1wJsmn4I
         JCyQNotfOLrBfxcS0fkaxv183x2Y+6F0XoTHqitMTWA78FpfRS93lzPgR7LuC6/nVedQ
         eT3g==
X-Gm-Message-State: AOJu0Yz2vxrdO5CUSJDPf+LUBQxFJkElSFijAek86hb9Hb6E28ecIeVs
	TpWavBjYyyDQI58GU6kYE5pdEbNm9Oa+u9d9/3g=
X-Google-Smtp-Source: AGHT+IF8j1fEkzHM/ilC1Wmslv4guuqgchcdZ5NGZ0Ihl6Dd+1P3eeJblWw/N/RfVLyHrPgmdzu+bt4BkPLZ3xjbeUU=
X-Received: by 2002:a05:6808:1443:b0:3b9:cca7:2f33 with SMTP id
 x3-20020a056808144300b003b9cca72f33mr16554996oiv.72.1702871790196; Sun, 17
 Dec 2023 19:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217131716.830290-1-menglong8.dong@gmail.com>
 <20231217131716.830290-3-menglong8.dong@gmail.com> <CAADnVQJ6yVJzzAnHT9dWcQ+-0czcT9qf6Qm_b_tmYsBs3UVUEQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ6yVJzzAnHT9dWcQ+-0czcT9qf6Qm_b_tmYsBs3UVUEQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 18 Dec 2023 11:56:18 +0800
Message-ID: <CADxym3bOgnU84Xngx_H3cwxzEqsaK8JkaYDY3F4dSr74R492ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: activate the OP_NE login
 in range_cond()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 2:20=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
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
> > +       {S32, U32, {(u32)(s32)S32_MIN, 0}, {0, 0}},
> > +       {S32, U32, {(u32)(s32)S32_MIN, 0}, {(u32)(s32)S32_MIN, (u32)(s3=
2)S32_MIN}},
> > +       {S32, U32, {(u32)(s32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
>
> I think you're copying the style of the casts from few lines above,
> but (s32)S32_MIN is unnecessary. S32_MIN includes the cast already.
> Please remove and fix the above lines too.

Enn...yes, I simulated the usage of S32_MIN from the lines above.
You are right, the s32 casting is unnecessary, I'll just keep the
u32 casting.

I'll wait a while before sending the next version to see if
someone else any comments on this series.

Thanks!
Menglong Dong

