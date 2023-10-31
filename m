Return-Path: <bpf+bounces-13729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123AE7DD4B2
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEED21C20CAE
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 17:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3077F208C1;
	Tue, 31 Oct 2023 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbZItavC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7E51945A
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 17:30:53 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE90BF1
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 10:30:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso843339666b.0
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698773450; x=1699378250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkqqR0n+8oUQ6AAyIvTTSh3RfNG7ffYbjY6haPDG8Xc=;
        b=XbZItavCbcdbGgHoFoVkh+D1EqJzMTc5FTQXFds5n+GijAoegfYsPWttIqiU4D+kiT
         erNlRTQyTKmH7YSsWC2fAOcYGhRVX9pgr7URpJeY+T/sLB6o0wB6PwK5I90SFDLr/NQc
         gdL9IHf/yt6UutFV1XrvLJHa+rwyoLhE2GguyY5/LwoDa1LY2FgsPrtEg6PU0YR4tJdI
         QxHIjTgnRIAUJ+1ZnN4SensxW2ME4cE9AG8OsWF4B3fKVYkhnq97dFRgOtd8/o/9aacy
         G9m6ltJw5CQiPMAqDIlQsnmacVw6WwMyZA94lWLlds/zvpX+3MldhcdTUZzqKzhCk50P
         aTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698773450; x=1699378250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkqqR0n+8oUQ6AAyIvTTSh3RfNG7ffYbjY6haPDG8Xc=;
        b=Y/Z8FOskLpsdoHRrxcY/ryrg7z+oQo/6Vf8yrr/AXEhyHnM5xntSuCy61w1aPCGfRs
         3F9cM0hbYyeXTiGRDOpkmCLHQiskoU57k53jaRQLskhs3zQv47Xb+HlWKJYZ/XrXDX30
         vqxkFGNUFvBlogu7Al88uVcPb0nr2gKWwH0C6z15cAq2FUYZ/f1EhcaijvfOAn9wg3Bd
         VrqAH9lqAWQ0MzAnUe4aPOmHulk4N/Vh9d1Xf8X7Vy7SdlrlYQzExueZqxcOAJe90Kfs
         7vE3qqTZ2MVF5EQPndszp/4Ns/avs1R/cqZF8e6SfeG44KSL6dlS3kTjRA/nc+9pgh5k
         1Omg==
X-Gm-Message-State: AOJu0YxkH0f6hk49k+trduKr0JglE/+Yg3V4Yg7u4cPjP2l/ahWR1Pm7
	sy8pL5QDrzx8/yqmALBA+GhSTfRkKmO0KqqF+Jw=
X-Google-Smtp-Source: AGHT+IEK0jHNzPcqoym/eLkfmvGR/k4l/7tp5TxNey3NfNV3RjDImaJLoeyidQ7FYQQt+Pqd8e2FM6JrU8/BWYpWm/I=
X-Received: by 2002:a17:906:fd8b:b0:9c1:66cc:1d7d with SMTP id
 xa11-20020a170906fd8b00b009c166cc1d7dmr3806ejb.64.1698773450037; Tue, 31 Oct
 2023 10:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-4-andrii@kernel.org>
 <487ae806ba081a07b43733d0698752f4414cd01d.camel@gmail.com>
In-Reply-To: <487ae806ba081a07b43733d0698752f4414cd01d.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 10:30:38 -0700
Message-ID: <CAEf4BzY5TSpNf4wdeU9jn_Sv4ugi_FrDONCtrm-KMdf=v72iYQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 03/23] bpf: derive smin/smax from umin/max bounds
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 8:37=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
> > Add smin/smax derivation from appropriate umin/umax values. Previously =
the
> > logic was surprisingly asymmetric, trying to derive umin/umax from smin=
/smax
> > (if possible), but not trying to do the same in the other direction. A =
simple
> > addition to __reg64_deduce_bounds() fixes this.
> >
> > Added also generic comment about u64/s64 ranges and their relationship.
> > Hopefully that helps readers to understand all the bounds deductions
> > a bit better.
> >
> > Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Nice comment, thank you. I noticed two typos, see below.
>
> > ---
> >  kernel/bpf/verifier.c | 70 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 857d76694517..bf4193706744 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2358,6 +2358,76 @@ static void __reg32_deduce_bounds(struct bpf_reg=
_state *reg)
> >
> >  static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
> >  {
> > +     /* If u64 range forms a valid s64 range (due to matching sign bit=
),
> > +      * try to learn from that. Let's do a bit of ASCII art to see whe=
n
> > +      * this is happening. Let's take u64 range first:
> > +      *
> > +      * 0             0x7fffffffffffffff 0x8000000000000000        U64=
_MAX
> > +      * |-------------------------------|-----------------------------=
---|
> > +      *
> > +      * Valid u64 range is formed when umin and umax are anywhere in t=
his
> > +      * range [0, U64_MAX] and umin <=3D umax. u64 is simple and
> > +      * straightforward. Let's where s64 range maps to this simple [0,
> > +      * U64_MAX] range, annotated below the line for comparison:
>
> Nit: this sentence sounds a bit weird, probably some word is missing
>      between "let's" and "where".
>

I don't know what's going on here, I wasn't drunk when I wrote this
and I don't remember it being so incoherent :) Will re-read and try to
make it clearer.

> > +      *
> > +      * 0             0x7fffffffffffffff 0x8000000000000000        U64=
_MAX
> > +      * |-------------------------------|-----------------------------=
---|
> > +      * 0                        S64_MAX S64_MIN                      =
  -1
> > +      *
> > +      * So s64 values basically start in the middle and then are conti=
guous
> > +      * to the right of it, wrapping around from -1 to 0, and then
> > +      * finishing as S64_MAX (0x7fffffffffffffff) right before S64_MIN=
.
> > +      * We can try drawing more visually continuity of u64 vs s64 valu=
es as
> > +      * mapped to just actual hex valued range of values.
> > +      *
> > +      *  u64 start                                               u64 e=
nd
> > +      *  _____________________________________________________________=
__
> > +      * /                                                             =
  \
> > +      * 0             0x7fffffffffffffff 0x8000000000000000        U64=
_MAX
> > +      * |-------------------------------|-----------------------------=
---|
> > +      * 0                        S64_MAX S64_MIN                      =
  -1
> > +      *                                / \
> > +      * >------------------------------   ----------------------------=
--->
> > +      * s64 continues...        s64 end   s64 start          s64 "midp=
oint"
> > +      *
> > +      * What this means is that in general, we can't always derive
> > +      * something new about u64 from any random s64 range, and vice ve=
rsa.
> > +      * But we can do that in two particular cases. One is when entire
> > +      * u64/s64 range is *entirely* contained within left half of the =
above
> > +      * diagram or when it is *entirely* contained in the right half. =
I.e.:
> > +      *
> > +      * |-------------------------------|-----------------------------=
---|
> > +      *     ^                   ^            ^                 ^
> > +      *     A                   B            C                 D
> > +      *
> > +      * [A, B] and [C, D] are contained entirely in their respective h=
alves
> > +      * and form valid contiguous ranges as both u64 and s64 values. [=
A, B]
> > +      * will be non-negative both as u64 and s64 (and in fact it will =
be
> > +      * identical ranges no matter the signedness). [C, D] treated as =
s64
> > +      * will be a range of negative values, while in u64 it will be
> > +      * non-negative range of values larger than 0x8000000000000000.
> > +      *
> > +      * Now, any other range here can't be represented in both u64 and=
 s64
> > +      * simultaneously. E.g., [A, C], [A, D], [B, C], [B, D] are valid
> > +      * contiguous u64 ranges, but they are discontinuous in s64. [B, =
C]
> > +      * in s64 would be properly presented as [S64_MIN, C] and [B, S64=
_MAX],
> > +      * for example. Similarly, valid s64 range [D, A] (going from neg=
ative
> > +      * to positive values), would be two separate [D, U64_MAX] and [0=
, A]
> > +      * ranges as u64. Currently reg_state can't represent two segment=
s per
> > +      * numeric domain, so in such situations we can only derive maxim=
al
> > +      * possible range ([0, U64_MAX] for u64, and [S64_MIN, S64_MAX) f=
or s64).
>                                                                   ^
> Nit:                                                      missing bracket
>

it's actually a typo, ) -> ], which is now fixed as well, thanks

> > +      *
> > +      * So we use these facts to derive umin/umax from smin/smax and v=
ice
> > +      * versa only if they stay within the same "half". This is equiva=
lent
> > +      * to checking sign bit: lower half will have sign bit as zero, u=
pper
> > +      * half have sign bit 1. Below in code we simplify this by just
> > +      * casting umin/umax as smin/smax and checking if they form valid
> > +      * range, and vice versa. Those are equivalent checks.
> > +      */
> > +     if ((s64)reg->umin_value <=3D (s64)reg->umax_value) {
> > +             reg->smin_value =3D max_t(s64, reg->smin_value, reg->umin=
_value);
> > +             reg->smax_value =3D min_t(s64, reg->smax_value, reg->umax=
_value);
> > +     }
> >       /* Learn sign from signed bounds.
> >        * If we cannot cross the sign boundary, then signed and unsigned=
 bounds
> >        * are the same, so combine.  This works even in the negative cas=
e, e.g.
>
>
>

