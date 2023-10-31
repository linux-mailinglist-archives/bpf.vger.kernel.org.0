Return-Path: <bpf+bounces-13724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336727DD212
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337331C20D01
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0052D1DDC8;
	Tue, 31 Oct 2023 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg3URAGb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40120322
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 16:35:52 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6431BF7
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 09:35:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-408002b5b9fso42286175e9.3
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698770101; x=1699374901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKfSWPxZTtHcSwazW3RxUH0blTHV8hg3jlROv/dLM1s=;
        b=mg3URAGb4OhHBsE9m6Q2JFWPF+wDb8jVfUYpD//10Q0xeGVVFVROE35vVIC8nzwZe4
         Qydd70MFDrq2LtHEmjxNrsj8tEIj31Vn7yLJwU8Ilil/4gck/zXNRPHFk2tHOZbRU5aK
         nZUeMlqHwKIgnJiclI+BS1S4URlYnRg6wB5f710BTZoq2U5p+Mx7sUjzB8ATl1EmJ3hK
         E8dHR/5rMB7jhz781V/sKjKiH0lVjfCcHy8LpjOVnsrw+Fxp9dc/MFE18r5CuIhLA9h4
         pzH/HM7di2dEPvvLVGf2lYWEbBCfUp/PkElk2pSgY69nUSpFvc7XobzcSozirRPvvE9q
         mzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698770101; x=1699374901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKfSWPxZTtHcSwazW3RxUH0blTHV8hg3jlROv/dLM1s=;
        b=gPc3NBziMdO/60/bwhyLc/vxiqA7hbLo3tle5cijccFAmjz3v43WhGhqKYol5eQZRG
         bTTJyy19jLY/OqDlbAoqYaRlBcoADvFck3KFNABmqe/FDr5pLEP/jNgrBvbr94elTyvR
         miwlhVqehf3HoauB21v6Q5pSamyW9kDj1TblQyTZ1iG2vZCFQs63IKaj01fWP4mgC16I
         ygI9+ewyZdiJcTDkwDELOZ8EhAEySmYuKZuH56GwIOYZ1IGw5MBVJUCHIzYPLiWPB58z
         TYuL6nqz0JC573Uce+1E8VM2pFQ2kCA0ePhKjKdMTEc1ScR4BZGxA+YLkkMDhokZNhO8
         VHmw==
X-Gm-Message-State: AOJu0YzFPPZttU3LTMkIC4hmKra1gIxHVHm8etfnCQf67OX/Dm8cPHl5
	P1NsJ5ndrnW0VcBWf0TcYebFT1xdpRTQZA7aOq6P0SElgBo=
X-Google-Smtp-Source: AGHT+IFyiPDVOazML+bHEq/9g5YhCEuNc5jF89FM0gGWjVtzzhQKHDHro9yfdLkRsjMBvhbAV3jKUMbAy+xoBSjBzVM=
X-Received: by 2002:a05:600c:4ed2:b0:408:2f50:f228 with SMTP id
 g18-20020a05600c4ed200b004082f50f228mr11289096wmq.41.1698770100502; Tue, 31
 Oct 2023 09:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-20-andrii@kernel.org>
 <20231031021200.lryk4xjudptseasm@MacBook-Pro-49.local> <CAEf4BzZ0oPHe8p96OjY=o7R+=cMn9utk9K5YgYQp8Ai=T6fPCQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZ0oPHe8p96OjY=o7R+=cMn9utk9K5YgYQp8Ai=T6fPCQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Oct 2023 09:34:49 -0700
Message-ID: <CAADnVQKOYk7emThHsRxuPVVAZFfE7U6qngcM+L=gt6JQfLgcLg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 19/23] bpf: generalize is_scalar_branch_taken()
 logic
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 11:12=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 30, 2023 at 7:12=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Oct 27, 2023 at 11:13:42AM -0700, Andrii Nakryiko wrote:
> > > Generalize is_branch_taken logic for SCALAR_VALUE register to handle
> > > cases when both registers are not constants. Previously supported
> > > <range> vs <scalar> cases are a natural subset of more generic <range=
>
> > > vs <range> set of cases.
> > >
> > > Generalized logic relies on straightforward segment intersection chec=
ks.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/bpf/verifier.c | 104 ++++++++++++++++++++++++++--------------=
--
> > >  1 file changed, 64 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 4c974296127b..f18a8247e5e2 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -14189,82 +14189,105 @@ static int is_scalar_branch_taken(struct b=
pf_reg_state *reg1, struct bpf_reg_sta
> > >                                 u8 opcode, bool is_jmp32)
> > >  {
> > >       struct tnum t1 =3D is_jmp32 ? tnum_subreg(reg1->var_off) : reg1=
->var_off;
> > > +     struct tnum t2 =3D is_jmp32 ? tnum_subreg(reg2->var_off) : reg2=
->var_off;
> > >       u64 umin1 =3D is_jmp32 ? (u64)reg1->u32_min_value : reg1->umin_=
value;
> > >       u64 umax1 =3D is_jmp32 ? (u64)reg1->u32_max_value : reg1->umax_=
value;
> > >       s64 smin1 =3D is_jmp32 ? (s64)reg1->s32_min_value : reg1->smin_=
value;
> > >       s64 smax1 =3D is_jmp32 ? (s64)reg1->s32_max_value : reg1->smax_=
value;
> > > -     u64 val =3D is_jmp32 ? (u32)tnum_subreg(reg2->var_off).value : =
reg2->var_off.value;
> > > -     s64 sval =3D is_jmp32 ? (s32)val : (s64)val;
> > > +     u64 umin2 =3D is_jmp32 ? (u64)reg2->u32_min_value : reg2->umin_=
value;
> > > +     u64 umax2 =3D is_jmp32 ? (u64)reg2->u32_max_value : reg2->umax_=
value;
> > > +     s64 smin2 =3D is_jmp32 ? (s64)reg2->s32_min_value : reg2->smin_=
value;
> > > +     s64 smax2 =3D is_jmp32 ? (s64)reg2->s32_max_value : reg2->smax_=
value;
> > >
> > >       switch (opcode) {
> > >       case BPF_JEQ:
> > > -             if (tnum_is_const(t1))
> > > -                     return !!tnum_equals_const(t1, val);
> > > -             else if (val < umin1 || val > umax1)
> > > +             /* const tnums */
> > > +             if (tnum_is_const(t1) && tnum_is_const(t2))
> > > +                     return t1.value =3D=3D t2.value;
> > > +             /* const ranges */
> > > +             if (umin1 =3D=3D umax1 && umin2 =3D=3D umax2)
> > > +                     return umin1 =3D=3D umin2;
> >
> > I don't follow this logic.
> > umin1 =3D=3D umax1 means that it's a single constant and
> > it should have been handled by earlier tnum_is_const check.
>
> I think you follow the logic, you just think it's redundant. Yes, it's
> basically the same as
>
>           if (tnum_is_const(t1) && tnum_is_const(t2))
>                 return t1.value =3D=3D t2.value;
>
> but based on ranges. I didn't feel comfortable to assume that if umin1
> =3D=3D umax1 then tnum_is_const(t1) will always be true. At worst we'll
> perform one redundant check.
>
> In short, I don't trust tnum to be as precise as umin/umax and other rang=
es.
>
> >
> > > +             if (smin1 =3D=3D smax1 && smin2 =3D=3D smax2)
> > > +                     return umin1 =3D=3D umin2;
> >
> > here it's even more confusing. smin =3D=3D smax -> singel const,
> > but then compare umin1 with umin2 ?!
>
> Eagle eyes! Typo, sorry :( it should be `smin1 =3D=3D smin2`, of course.
>
> What saves us is reg_bounds_sync(), and if we have umin1 =3D=3D umax1 the=
n
> we'll have also smin1 =3D=3D smax1 =3D=3D umin1 =3D=3D umax1 (and corresp=
onding
> relation for second register). But I fixed these typos in both BPF_JEQ
> and BPF_JNE branches.

Not just 'saves us'. The tnum <-> bounds sync is mandatory.
I think we have a test where a function returns [-errno, 0]
and then we do if (ret < 0) check. At this point the reg has
to be tnum_is_const and zero.
So if smin1 =3D=3D smax1 =3D=3D umin1 =3D=3D umax1 it should be tnum_is_con=
st.
Otherwise it's a bug in sync logic.
I think instead of doing redundant and confusing check may be
add WARN either here or in sync logic to make sure it's all good ?

