Return-Path: <bpf+bounces-13682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D30357DC666
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104911C20BDA
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2D91078A;
	Tue, 31 Oct 2023 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi9Av1Yz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D0B101FE
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:18:50 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6874C121
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:12:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9d10f94f70bso470648166b.3
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698732735; x=1699337535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+HfIaOTVru0DOA+OmJipm5bKDf8mLydMhPWsMfHbcA=;
        b=mi9Av1YzBLLxU9vYDNRTuKhhAspVAdTgNJKYswn02D2EvCQTQqsh/yB02yuLpZJDlt
         eeOPETYQw7xzfAndoIKGk5Xj6OK/hVYiny3Zd2TuoNG5vjlahOD3t2rTrNvcuUVIXB97
         JkOBJHLSR88z1NdZiYJZVMccZSp/b7vLtgOuHVplUBg3GAz+Dm2aiCr72jOCvFvcxiVl
         5WG8O3Uieid9Tz19CYzmYk+nO72WjXckl/pZ91tMWgXWRHb4KQTQw4O6LMj6E2hvmEQA
         i/se2qYp+1JM4ZhqUfmHtETcvzbstnaDbLtI3Gg3+dZDf0uT1THcIWCiLX8Lmkqg5r9t
         /HKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732735; x=1699337535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+HfIaOTVru0DOA+OmJipm5bKDf8mLydMhPWsMfHbcA=;
        b=j7uUJ+TgAcaxe+AvEnTyODZypctw04nyV8RIA8S5Bo+degmdPWozQpOiR2ry4cJ1LW
         w8RAcOMzxb1Ngg5cihiUITEdJiCa9K71E1mpyy1lvMKJDH/nE0JHWbAuMRoRptea7hUU
         6MDn+GMnXBoMsBeENGeFd5iGxbz7gWFAXyFC22GNULu2EfnsiJnH7d6WylqzzNst360z
         4y2502GQJHQhaZSWGT5/uhXH++O4XzIy+PSLy3NzMOcAaWLVOC19iQCkmyZtob+ZA8Jh
         EyVtlt6rasH4wVHRRqFY4lY0wvOGHuGBgLhc8/u5cXGx1lPgOS0XyHGA6KJPyi6zPESo
         W3Ew==
X-Gm-Message-State: AOJu0Yx851XLxJc1DlAp7Z3rf8XiFUBSOGTgfYX8RLPvWxru9ISHphLc
	qHEc0dyGPD2xsT2j/vQOnDENuixD2/VjBJpjyTs=
X-Google-Smtp-Source: AGHT+IFLS1ugvYclc1FO5O6oJIhvccuEsVpTaXIcOxj/+rE5iCll1HQqtuCI5V98dyh7qXCtRAOhg2DHzC1KbxBEYiU=
X-Received: by 2002:a17:907:7f26:b0:9be:fc31:8cd3 with SMTP id
 qf38-20020a1709077f2600b009befc318cd3mr9120006ejc.17.1698732734778; Mon, 30
 Oct 2023 23:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-20-andrii@kernel.org>
 <20231031021200.lryk4xjudptseasm@MacBook-Pro-49.local>
In-Reply-To: <20231031021200.lryk4xjudptseasm@MacBook-Pro-49.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Oct 2023 23:12:03 -0700
Message-ID: <CAEf4BzZ0oPHe8p96OjY=o7R+=cMn9utk9K5YgYQp8Ai=T6fPCQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 19/23] bpf: generalize is_scalar_branch_taken()
 logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 7:12=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 27, 2023 at 11:13:42AM -0700, Andrii Nakryiko wrote:
> > Generalize is_branch_taken logic for SCALAR_VALUE register to handle
> > cases when both registers are not constants. Previously supported
> > <range> vs <scalar> cases are a natural subset of more generic <range>
> > vs <range> set of cases.
> >
> > Generalized logic relies on straightforward segment intersection checks=
.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 104 ++++++++++++++++++++++++++----------------
> >  1 file changed, 64 insertions(+), 40 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 4c974296127b..f18a8247e5e2 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -14189,82 +14189,105 @@ static int is_scalar_branch_taken(struct bpf=
_reg_state *reg1, struct bpf_reg_sta
> >                                 u8 opcode, bool is_jmp32)
> >  {
> >       struct tnum t1 =3D is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->=
var_off;
> > +     struct tnum t2 =3D is_jmp32 ? tnum_subreg(reg2->var_off) : reg2->=
var_off;
> >       u64 umin1 =3D is_jmp32 ? (u64)reg1->u32_min_value : reg1->umin_va=
lue;
> >       u64 umax1 =3D is_jmp32 ? (u64)reg1->u32_max_value : reg1->umax_va=
lue;
> >       s64 smin1 =3D is_jmp32 ? (s64)reg1->s32_min_value : reg1->smin_va=
lue;
> >       s64 smax1 =3D is_jmp32 ? (s64)reg1->s32_max_value : reg1->smax_va=
lue;
> > -     u64 val =3D is_jmp32 ? (u32)tnum_subreg(reg2->var_off).value : re=
g2->var_off.value;
> > -     s64 sval =3D is_jmp32 ? (s32)val : (s64)val;
> > +     u64 umin2 =3D is_jmp32 ? (u64)reg2->u32_min_value : reg2->umin_va=
lue;
> > +     u64 umax2 =3D is_jmp32 ? (u64)reg2->u32_max_value : reg2->umax_va=
lue;
> > +     s64 smin2 =3D is_jmp32 ? (s64)reg2->s32_min_value : reg2->smin_va=
lue;
> > +     s64 smax2 =3D is_jmp32 ? (s64)reg2->s32_max_value : reg2->smax_va=
lue;
> >
> >       switch (opcode) {
> >       case BPF_JEQ:
> > -             if (tnum_is_const(t1))
> > -                     return !!tnum_equals_const(t1, val);
> > -             else if (val < umin1 || val > umax1)
> > +             /* const tnums */
> > +             if (tnum_is_const(t1) && tnum_is_const(t2))
> > +                     return t1.value =3D=3D t2.value;
> > +             /* const ranges */
> > +             if (umin1 =3D=3D umax1 && umin2 =3D=3D umax2)
> > +                     return umin1 =3D=3D umin2;
>
> I don't follow this logic.
> umin1 =3D=3D umax1 means that it's a single constant and
> it should have been handled by earlier tnum_is_const check.

I think you follow the logic, you just think it's redundant. Yes, it's
basically the same as

          if (tnum_is_const(t1) && tnum_is_const(t2))
                return t1.value =3D=3D t2.value;

but based on ranges. I didn't feel comfortable to assume that if umin1
=3D=3D umax1 then tnum_is_const(t1) will always be true. At worst we'll
perform one redundant check.

In short, I don't trust tnum to be as precise as umin/umax and other ranges=
.

>
> > +             if (smin1 =3D=3D smax1 && smin2 =3D=3D smax2)
> > +                     return umin1 =3D=3D umin2;
>
> here it's even more confusing. smin =3D=3D smax -> singel const,
> but then compare umin1 with umin2 ?!

Eagle eyes! Typo, sorry :( it should be `smin1 =3D=3D smin2`, of course.

What saves us is reg_bounds_sync(), and if we have umin1 =3D=3D umax1 then
we'll have also smin1 =3D=3D smax1 =3D=3D umin1 =3D=3D umax1 (and correspon=
ding
relation for second register). But I fixed these typos in both BPF_JEQ
and BPF_JNE branches.


>
> > +             /* non-overlapping ranges */
> > +             if (umin1 > umax2 || umax1 < umin2)
> >                       return 0;
> > -             else if (sval < smin1 || sval > smax1)
> > +             if (smin1 > smax2 || smax1 < smin2)
> >                       return 0;
>
> this part makes sense.

