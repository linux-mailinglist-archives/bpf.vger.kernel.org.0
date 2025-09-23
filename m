Return-Path: <bpf+bounces-69378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D76FB95855
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 12:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A2518976AC
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269C3314B66;
	Tue, 23 Sep 2025 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjPVvIQD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A081E480
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624759; cv=none; b=CWs0JcLU6KMPc525aBVtCjtwk7Xw5G4SV3FzcYQPG816iQEJ0/yYTR1T1Ste07dfk9ML1iRYOVmyHrhX7a9084f13nA92xVlRW3D+wSsPbg9Ml7kaC87cJX6fHkKyBbZSG6+AFJl2DzxnYy7zIsTUedANaqSoB2++odEJSM6r4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624759; c=relaxed/simple;
	bh=r2cLn70Ldl877ETnuAp+o5yyPEs55n+4fNpTlQgpjLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPjBNbamFO7pQEAI1PPdRw5Tj50i7JUYNeVcVQln2qQ/y3R0oGa97WUOsKuubUCkA/NjLjJaTGKyI7gp1CcWy9FVUWtZG10Q08Jmtr9Y4KPEbg4wjca8iDK+A3WuhjjZ5BdEYR/fvW5Ek4yNi5PW8vsLxsFyTWiz2CkQw3iITLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjPVvIQD; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57afc648b7dso3668361e87.2
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758624756; x=1759229556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WP6HXnoeP+y+mUxsWKIB/s2WgqBM+wsZOgOyBQrTfXw=;
        b=bjPVvIQDpmRkfLrBorzSGPE8l9D97TTQmBnW/lLEvRRWJqr7Ql80VOrrpBbp1z2n97
         +tGnC1k/AHGGi85cZhmQfYHnBtR6eWooiAnjY+/kQKbsL2O7ls32uQid1PFvuO55FFyL
         azOU9VmIO5a1spWF98RiOaZD858t07GnqKizx3lfatNDeOfaK0p8CcJnsa0AHks+3BFX
         n3CH+uD2tj8I8GTuFsDR43jX7ECXOUkIUh3zVl2sjiKGTnqwVAc5rjk+pWc0HK7iXA6B
         4ygyqP/lNV2mIc2VH4afB7VgEnCxpEIwUUzDan7HoP97uu6R2ILmKesTN7UcULmTdt6D
         XEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758624756; x=1759229556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WP6HXnoeP+y+mUxsWKIB/s2WgqBM+wsZOgOyBQrTfXw=;
        b=TbiFmVa6RZGQNHo1uKVmscP77clEZOlCYfDIfFMtLrxYCo6UEUvf+glxU4Ng8SPt2r
         C0xG+LTxZA5xzNao0GB9qeQo60fDiknesZkiJnzIRFJgwnzbp1o7Rq63osdQw53Lgiyq
         LkQt6fGpSFpGiv95WNhAC9rVmpWgBEy6rvADc1ObCH85Ip7Y5wro9iIRt0IMmG5Dyilq
         ZCLWBO5kYQU6Hj32Yf6uBmhL5HjlaJ19sE8CMzo8oZbcgzjc5bF06xDF5rHoQXJy0nFc
         xrFQYBIbKJhkleNCQm7CIVu8AYiZtQWcKsJWHyS+8OUz/si89CYCcZ4xwGryZei28Yvz
         EgwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1uwrfpmjC/nSZuvuarJxdkLmh1PiGWjSSd6ybbrJVkLt9VDa/6sjWtyUrLxV6AFPpVRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXhfyX+9ZZbBquWLLsfrCsu91JRJbyNk4zuNOcEdDkR2nxvC3
	McS1RsskD62AKcm5rAhrIPhjH063oTn36OJADeD1FKsP7Ut2naGsFyFLQN0MTd3bK4r7ZnHMSaA
	vfCR3riAilpYICcXvOuMZ9DpSC2889kg=
X-Gm-Gg: ASbGncs8Z6J5l3NsQKVwdjnak7rs2B8+ZPJN14nURd0oHQbZW0TJ6uG5cLDcl9NVkZq
	l9Ot7SvDcrhpPFJZjfHr/apgfxrzwcrQ72JriDtKmofVS1RRUm/64/lVy8hcx/C3eTeo5Gz/zPt
	9bJMeunyrA4TranGXrpSInptwyzOo4t4BOTN8GZfBPkOcaDKohWosIGW56QJxy2nG0sUCIqCZdL
	YqGqfASpoY/eP+f
X-Google-Smtp-Source: AGHT+IGc/Sgv5ecAZW9v0DkjNmrT4iC3dDaJ/zuzBHQQuroj2SWU1pPlsw/IwcJptqhITpKdypdHEWhRapBkLJ8Pa4E=
X-Received: by 2002:a05:6512:224b:b0:553:2c58:f96f with SMTP id
 2adb3069b0e04-5807032da8cmr765338e87.1.1758624755651; Tue, 23 Sep 2025
 03:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915162848.54282-1-puranjay@kernel.org> <20250915162848.54282-3-puranjay@kernel.org>
 <14c06b60-7923-4f27-ae8d-ba62ac7a2248@huaweicloud.com>
In-Reply-To: <14c06b60-7923-4f27-ae8d-ba62ac7a2248@huaweicloud.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 23 Sep 2025 12:52:24 +0200
X-Gm-Features: AS18NWBNk6kReWcC8kB5-It9Vx_QvtwCag_R56cphNTVrzeZYMZVTZEqv9pScjM
Message-ID: <CANk7y0jcD65oWuyk=+scJarEtjW9BqN9TmKyUcPOU1xOU7uppQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf, arm64: Add support for signed arena loads
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 12:37=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.co=
m> wrote:
>
> On 9/16/2025 12:28 AM, Puranjay Mohan wrote:
> > Add support for signed loads from arena which are internally converted
> > to loads with mode set BPF_PROBE_MEM32SX by the verifier. The
> > implementation is similar to BPF_PROBE_MEMSX and BPF_MEMSX but for
> > BPF_PROBE_MEM32SX, arena_vm_base is added to the src register to form
> > the address.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >   arch/arm64/net/bpf_jit_comp.c | 30 +++++++++++++++++-------------
> >   1 file changed, 17 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_com=
p.c
> > index f2b85a10add2..7233acec69ce 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -1133,12 +1133,14 @@ static int add_exception_handler(const struct b=
pf_insn *insn,
> >               return 0;
> >
> >       if (BPF_MODE(insn->code) !=3D BPF_PROBE_MEM &&
> > -             BPF_MODE(insn->code) !=3D BPF_PROBE_MEMSX &&
> > -                     BPF_MODE(insn->code) !=3D BPF_PROBE_MEM32 &&
> > -                             BPF_MODE(insn->code) !=3D BPF_PROBE_ATOMI=
C)
> > +         BPF_MODE(insn->code) !=3D BPF_PROBE_MEMSX &&
> > +         BPF_MODE(insn->code) !=3D BPF_PROBE_MEM32 &&
> > +         BPF_MODE(insn->code) !=3D BPF_PROBE_MEM32SX &&
> > +         BPF_MODE(insn->code) !=3D BPF_PROBE_ATOMIC)
> >               return 0;
> >
> >       is_arena =3D (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32) ||
> > +                (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32SX) ||
> >                  (BPF_MODE(insn->code) =3D=3D BPF_PROBE_ATOMIC);
> >
> >       if (!ctx->prog->aux->extable ||
> > @@ -1659,7 +1661,11 @@ static int build_insn(const struct bpf_insn *ins=
n, struct jit_ctx *ctx,
> >       case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
> >       case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
> >       case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
> > -             if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32) {
> > +     case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
> > +     case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
> > +     case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
> > +             if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32 ||
> > +                 BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM32SX) {
> >                       emit(A64_ADD(1, tmp2, src, arena_vm_base), ctx);
> >                       src =3D tmp2;
> >               }
> > @@ -1671,7 +1677,8 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx,
> >                       off_adj =3D off;
> >               }
> >               sign_extend =3D (BPF_MODE(insn->code) =3D=3D BPF_MEMSX ||
> > -                             BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM=
SX);
> > +                             BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM=
SX ||
> > +                              BPF_MODE(insn->code) =3D=3D BPF_PROBE_ME=
M32SX);
> >               switch (BPF_SIZE(code)) {
> >               case BPF_W:
> >                       if (is_lsi_offset(off_adj, 2)) {
> > @@ -1879,9 +1886,11 @@ static int build_insn(const struct bpf_insn *ins=
n, struct jit_ctx *ctx,
> >               if (ret)
> >                       return ret;
> >
> > -             ret =3D add_exception_handler(insn, ctx, dst);
> > -             if (ret)
> > -                     return ret;
> > +             if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_ATOMIC) {
>
> add_exception_handler already checked this condition, why add a check her=
e?
>

If I don't check it here then add_exception_handler() will be called
even for BPF_ATOMIC (0xc0), earlier
add_exception_handler() would have rejected it but now
BPF_PROBE_MEM32SX is also defined as 0xc0, so
add_exception_handler() will confuse BPF_ATOMIC for BPF_PROBE_MEM32SX
and allow it, I felt it was better to
just add a check here.

Thanks,
Puranjay

