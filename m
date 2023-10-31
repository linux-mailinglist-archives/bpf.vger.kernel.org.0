Return-Path: <bpf+bounces-13737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 215B27DD5B8
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 19:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC053B2100B
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29662210F0;
	Tue, 31 Oct 2023 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfBH27+3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B5210EE
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:02:12 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A191
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:02:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c773ac9b15so893003066b.2
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698775330; x=1699380130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQy/VqitbyEuc12Ikl0VAa2LnxPRDn6OLhHR1+RDTvM=;
        b=bfBH27+3UhnjdxqKogGMjA+JAMdUQ4HYMnIPfgQo+GssCguOovI5W14nOaMfhxqbLF
         rGb6m25P2r86mKQHwnzSMDOPICsRv7PPpX0zbkHYVWkXJXp4TF+Xpiua9LeUXrNvduLQ
         iQbOuSCAhGKgjWeuStBUuuD5AFIhJuQTrvzqzH8zKAsRUDTtqmjaHJUff6UrHF6xjSPP
         lWfjox1l9BGqSbp66EqpaNzDeB4WftHLVR0o1tegozUrv5VPQsemgCx+BBPDKDxXxqt2
         76ogl67rF6zuSBx3kb36FetbgI3ESRimzUshVNWyDZml7IKZVMq4ObWCdiywF53nvG/u
         UNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698775330; x=1699380130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQy/VqitbyEuc12Ikl0VAa2LnxPRDn6OLhHR1+RDTvM=;
        b=TVfLXmoTFLByuR7kps986CpQtDvB3VPezRiwm1KdXcJwlo2nl6beRZ6xW7QeOJz5At
         YnL9KHNXNy33lIy2C/E1xwSUQ+pLF2OpPab2TaUyxKNdJv5PvQPiWyGSF9t9/cLm0BTZ
         fnM/qqxse5mH4ghAUxMrH1aYvvt2K3qOxlosTKO3+E4MpFIloUSVhzY4GzSLyytSDTJu
         EPbJXUCpnzAKvArm+hYkN0xkiYsMqSUWGu66yQImvnv4kct0w3Y7ljh1dOLJmCCE6LAn
         KbFSB08rd8x0CNVqUpItxUflr7SHiJOY1lF7SkMJKRLBQsGriNs8NfWarQ5reUc/gOMR
         4k4w==
X-Gm-Message-State: AOJu0YxPpW4w1PdCDfvw8pb6e2gVpgn6InKIMi7Ztik+bKfFg53ZJi1/
	bflGmnJ63TvgZiEU/ApftMTnjybdvIxHDtR1d+RS4jo6
X-Google-Smtp-Source: AGHT+IGA9bRE/HOLPbN6RRqTOl6wyDp0k7C7ElIQN+WST+v2hbsT68f2n+P/kAW4Ulo64p8hs6fiCKijAAEvih3BODs=
X-Received: by 2002:a17:906:ee85:b0:9d4:2080:61d7 with SMTP id
 wt5-20020a170906ee8500b009d4208061d7mr70587ejb.51.1698775329634; Tue, 31 Oct
 2023 11:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-20-andrii@kernel.org>
 <20231031021200.lryk4xjudptseasm@MacBook-Pro-49.local> <CAEf4BzZ0oPHe8p96OjY=o7R+=cMn9utk9K5YgYQp8Ai=T6fPCQ@mail.gmail.com>
 <CAADnVQKOYk7emThHsRxuPVVAZFfE7U6qngcM+L=gt6JQfLgcLg@mail.gmail.com>
In-Reply-To: <CAADnVQKOYk7emThHsRxuPVVAZFfE7U6qngcM+L=gt6JQfLgcLg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 11:01:58 -0700
Message-ID: <CAEf4BzYurVB-6J-1oAVuPj8BbtzfKRYue6ajOUeofchAYCrNjA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 19/23] bpf: generalize is_scalar_branch_taken()
 logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 9:35=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 30, 2023 at 11:12=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 30, 2023 at 7:12=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Oct 27, 2023 at 11:13:42AM -0700, Andrii Nakryiko wrote:
> > > > Generalize is_branch_taken logic for SCALAR_VALUE register to handl=
e
> > > > cases when both registers are not constants. Previously supported
> > > > <range> vs <scalar> cases are a natural subset of more generic <ran=
ge>
> > > > vs <range> set of cases.
> > > >
> > > > Generalized logic relies on straightforward segment intersection ch=
ecks.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  kernel/bpf/verifier.c | 104 ++++++++++++++++++++++++++------------=
----
> > > >  1 file changed, 64 insertions(+), 40 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 4c974296127b..f18a8247e5e2 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -14189,82 +14189,105 @@ static int is_scalar_branch_taken(struct=
 bpf_reg_state *reg1, struct bpf_reg_sta
> > > >                                 u8 opcode, bool is_jmp32)
> > > >  {
> > > >       struct tnum t1 =3D is_jmp32 ? tnum_subreg(reg1->var_off) : re=
g1->var_off;
> > > > +     struct tnum t2 =3D is_jmp32 ? tnum_subreg(reg2->var_off) : re=
g2->var_off;
> > > >       u64 umin1 =3D is_jmp32 ? (u64)reg1->u32_min_value : reg1->umi=
n_value;
> > > >       u64 umax1 =3D is_jmp32 ? (u64)reg1->u32_max_value : reg1->uma=
x_value;
> > > >       s64 smin1 =3D is_jmp32 ? (s64)reg1->s32_min_value : reg1->smi=
n_value;
> > > >       s64 smax1 =3D is_jmp32 ? (s64)reg1->s32_max_value : reg1->sma=
x_value;
> > > > -     u64 val =3D is_jmp32 ? (u32)tnum_subreg(reg2->var_off).value =
: reg2->var_off.value;
> > > > -     s64 sval =3D is_jmp32 ? (s32)val : (s64)val;
> > > > +     u64 umin2 =3D is_jmp32 ? (u64)reg2->u32_min_value : reg2->umi=
n_value;
> > > > +     u64 umax2 =3D is_jmp32 ? (u64)reg2->u32_max_value : reg2->uma=
x_value;
> > > > +     s64 smin2 =3D is_jmp32 ? (s64)reg2->s32_min_value : reg2->smi=
n_value;
> > > > +     s64 smax2 =3D is_jmp32 ? (s64)reg2->s32_max_value : reg2->sma=
x_value;
> > > >
> > > >       switch (opcode) {
> > > >       case BPF_JEQ:
> > > > -             if (tnum_is_const(t1))
> > > > -                     return !!tnum_equals_const(t1, val);
> > > > -             else if (val < umin1 || val > umax1)
> > > > +             /* const tnums */
> > > > +             if (tnum_is_const(t1) && tnum_is_const(t2))
> > > > +                     return t1.value =3D=3D t2.value;
> > > > +             /* const ranges */
> > > > +             if (umin1 =3D=3D umax1 && umin2 =3D=3D umax2)
> > > > +                     return umin1 =3D=3D umin2;
> > >
> > > I don't follow this logic.
> > > umin1 =3D=3D umax1 means that it's a single constant and
> > > it should have been handled by earlier tnum_is_const check.
> >
> > I think you follow the logic, you just think it's redundant. Yes, it's
> > basically the same as
> >
> >           if (tnum_is_const(t1) && tnum_is_const(t2))
> >                 return t1.value =3D=3D t2.value;
> >
> > but based on ranges. I didn't feel comfortable to assume that if umin1
> > =3D=3D umax1 then tnum_is_const(t1) will always be true. At worst we'll
> > perform one redundant check.
> >
> > In short, I don't trust tnum to be as precise as umin/umax and other ra=
nges.
> >
> > >
> > > > +             if (smin1 =3D=3D smax1 && smin2 =3D=3D smax2)
> > > > +                     return umin1 =3D=3D umin2;
> > >
> > > here it's even more confusing. smin =3D=3D smax -> singel const,
> > > but then compare umin1 with umin2 ?!
> >
> > Eagle eyes! Typo, sorry :( it should be `smin1 =3D=3D smin2`, of course=
.
> >
> > What saves us is reg_bounds_sync(), and if we have umin1 =3D=3D umax1 t=
hen
> > we'll have also smin1 =3D=3D smax1 =3D=3D umin1 =3D=3D umax1 (and corre=
sponding
> > relation for second register). But I fixed these typos in both BPF_JEQ
> > and BPF_JNE branches.
>
> Not just 'saves us'. The tnum <-> bounds sync is mandatory.
> I think we have a test where a function returns [-errno, 0]
> and then we do if (ret < 0) check. At this point the reg has
> to be tnum_is_const and zero.
> So if smin1 =3D=3D smax1 =3D=3D umin1 =3D=3D umax1 it should be tnum_is_c=
onst.
> Otherwise it's a bug in sync logic.
> I think instead of doing redundant and confusing check may be
> add WARN either here or in sync logic to make sure it's all good ?

Ok, let's add it as part of register state sanity checks we discussed
on another patch. I'll drop the checks and will re-run all the test to
make sure we are not missing anything.

