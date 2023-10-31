Return-Path: <bpf+bounces-13753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C603B7DD71C
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 21:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65FABB21021
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 20:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35848200BB;
	Tue, 31 Oct 2023 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvLrzRlX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB4225B5
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 20:34:13 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806AAF5
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 13:34:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9d274222b5dso504233666b.3
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 13:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698784451; x=1699389251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYkfpf9VSiGZWUB37LGHBLpxZHn99bG7xKA6jRWPpEQ=;
        b=NvLrzRlX54Ip397JLvu5ztEy514FSTYnnwleRYuzGrqG6datYyDamDANewyeeFR4E2
         mga9hqCc+8BGN3pb3R0RuyV9SRb0k+SHE3MXiJuxs+Jkhll8dGUrzfBCA/vaT0QlyFXE
         beOrU1WRWF7UhZEqUJKHqlrPl/zY23AFea8vggI7uxXDZflf+i1h8uD0TDCNMIHfyuqZ
         DHTNgvr4IYPnz0I09Uw11Bn384glzi0sfCM7nXJtUCB5f++ULW3I77pqVaoQqFA+u/v6
         jaqjRoCzlgbYzJKpsX01O1ygSBzgH6ajqD6xdMuCCLHjL2kjqtWeWBtiUbw6rzatJHis
         TA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698784451; x=1699389251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYkfpf9VSiGZWUB37LGHBLpxZHn99bG7xKA6jRWPpEQ=;
        b=YZvuOUv2NSHYZfjZ65l0b9OEGLauO+ACQfh+gbFYwMFoK1Pa2cOJD5seCHO8iKl1yb
         UAgGSqgW99cabbhirK9+XUqAWkKIVdfpVAhgbnHnYhQTbxXW++inbCmzGluJsgkYj4mv
         ZvCAUhT1g5P31JkYtUGq96hw3uAKwpXyH1gXpN9wvsR4cleeEYfpj/PvuvKim7TFybAg
         cxWBLss34AIyqzLDlIxDBj2w8zZLK24a99HjaZgYatUQbP8kXSxjW+qfuTJRfgma2Zx1
         7wHcwlm0ZDhWGqEal+wcdsdPCkAAix8bVybcawkSBLvtZKpsREO3j5c2B+dVgKZCU+16
         +Rnw==
X-Gm-Message-State: AOJu0Yzxz2Jv18U/6Ox4LV0FNmBTXvGLJSax/cmmmScWMkuIyjN+3Epq
	YVdbumQ06hFE5Vk+tsc4V6Dn9y7HXYxDQbgrC8M=
X-Google-Smtp-Source: AGHT+IEUVe3CnTg8RiQnuJ5dHgohB4fYDQeYyvNRqwubMdInksh29vODWz7TxYkn1XvxWU+VJu/+IpUx6xccbnvUSvw=
X-Received: by 2002:a17:907:d19:b0:9c7:5651:9018 with SMTP id
 gn25-20020a1709070d1900b009c756519018mr329006ejc.68.1698784450731; Tue, 31
 Oct 2023 13:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-8-andrii@kernel.org>
 <CAADnVQLDDVJuhFM3Q-Dith4-r5SXCemFntCbisz8SfGeSBsz5Q@mail.gmail.com>
In-Reply-To: <CAADnVQLDDVJuhFM3Q-Dith4-r5SXCemFntCbisz8SfGeSBsz5Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 13:33:59 -0700
Message-ID: <CAEf4BzbsZZjpY0HqtAb3nUrDBASx0ah6ZRGXh2HmBJjSfQet+w@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 07/23] bpf: improve deduction of 64-bit bounds
 from 32-bit bounds
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 1:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 27, 2023 at 11:17=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > Add a few interesting cases in which we can tighten 64-bit bounds based
> > on newly learnt information about 32-bit bounds. E.g., when full u64/s6=
4
> > registers are used in BPF program, and then eventually compared as
> > u32/s32. The latter comparison doesn't change the value of full
> > register, but it does impose new restrictions on possible lower 32 bits
> > of such full registers. And we can use that to derive additional full
> > register bounds information.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 47 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 38d21d0e46bd..768247e3d667 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2535,10 +2535,57 @@ static void __reg64_deduce_bounds(struct bpf_re=
g_state *reg)
> >         }
> >  }
> >
> > +static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
> > +{
> > +       /* Try to tighten 64-bit bounds from 32-bit knowledge, using 32=
-bit
> > +        * values on both sides of 64-bit range in hope to have tigher =
range.
> > +        * E.g., if r1 is [0x1'00000000, 0x3'80000000], and we learn fr=
om
> > +        * 32-bit signed > 0 operation that s32 bounds are now [1; 0x7f=
ffffff].
> > +        * With this, we can substitute 1 as low 32-bits of _low_ 64-bi=
t bound
> > +        * (0x100000000 -> 0x100000001) and 0x7fffffff as low 32-bits o=
f
> > +        * _high_ 64-bit bound (0x380000000 -> 0x37fffffff) and arrive =
at a
> > +        * better overall bounds for r1 as [0x1'000000001; 0x3'7fffffff=
].
> > +        * We just need to make sure that derived bounds we are interse=
cting
> > +        * with are well-formed ranges in respecitve s64 or u64 domain,=
 just
> > +        * like we do with similar kinds of 32-to-64 or 64-to-32 adjust=
ments.
> > +        */
> > +       __u64 new_umin, new_umax;
> > +       __s64 new_smin, new_smax;
> > +
> > +       /* u32 -> u64 tightening, it's always well-formed */
> > +       new_umin =3D (reg->umin_value & ~0xffffffffULL) | reg->u32_min_=
value;
> > +       new_umax =3D (reg->umax_value & ~0xffffffffULL) | reg->u32_max_=
value;
> > +       reg->umin_value =3D max_t(u64, reg->umin_value, new_umin);
> > +       reg->umax_value =3D min_t(u64, reg->umax_value, new_umax);
> > +
> > +       /* s32 -> u64 tightening, s32 should be a valid u32 range (same=
 sign) */
> > +       if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
> > +               new_umin =3D (reg->umin_value & ~0xffffffffULL) | (u32)=
reg->s32_min_value;
> > +               new_umax =3D (reg->umax_value & ~0xffffffffULL) | (u32)=
reg->s32_max_value;
> > +               reg->umin_value =3D max_t(u64, reg->umin_value, new_umi=
n);
> > +               reg->umax_value =3D min_t(u64, reg->umax_value, new_uma=
x);
> > +       }
> > +
> > +       /* u32 -> s64 tightening, u32 range embedded into s64 preserves=
 range validity */
> > +       new_smin =3D (reg->smin_value & ~0xffffffffULL) | reg->u32_min_=
value;
> > +       new_smax =3D (reg->smax_value & ~0xffffffffULL) | reg->u32_max_=
value;
> > +       reg->smin_value =3D max_t(s64, reg->smin_value, new_smin);
> > +       reg->smax_value =3D min_t(s64, reg->smax_value, new_smax);
> > +
> > +       /* s32 -> s64 tightening, check that s32 range behaves as u32 r=
ange */
> > +       if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
>
> There is no typo in this check, right?

I don't think so.

> To make sure somebody doesn't ask this question again can we
> combine the same 'if'-s into one?
> In order:
> u32->u64
> u32->s64
> if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
>   s32->u64
>   s32->s64
> }
> ?
> imo will be easier to follow and the same end result?

yep, absolutely, will regroup

