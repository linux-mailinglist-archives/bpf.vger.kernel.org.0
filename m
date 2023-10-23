Return-Path: <bpf+bounces-13026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8267D3C57
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 18:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E76B20DFD
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2F1D54C;
	Mon, 23 Oct 2023 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkmPIpB+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4F41CA96
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 16:24:12 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78060E4
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 09:24:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e855d7dacso5436998a12.0
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 09:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698078249; x=1698683049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6ZPQVCJpqA47KolMw8QZ3KXMEjkepWRzItV0FneF+w=;
        b=jkmPIpB+zf0rhZWPO4HxUEtGpsN7SNopQO9XgrAIO7II4jzNGEQR/qQ+u9+onD7+sY
         doHKY5KFbDN0c9nRntdQd891LuHA/wEavR86dA1CRcXMc9gh3V7A2vOvT7MYGB2WSQ1H
         0zB2pGNNEzYgwr1+PIWlC4J7VcRDXNkceeHrv0oXiYlfPuYxJzm1N1E+P8BpJguAA79u
         xN7bvSpAo0ZIwFDso1MYXcYJQAW6C8kdUdcuhexfUq+qLLEZ4oIqCdPcUwCtACjSdxq1
         Z1A9jzMzDFqSgEfSddtrSg6oWq99YDijvkVF0ApzcHPOf90g5Zq7f+bhDyAXJ7FMbOpi
         o3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698078249; x=1698683049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6ZPQVCJpqA47KolMw8QZ3KXMEjkepWRzItV0FneF+w=;
        b=hEIQ0XWLw/wn+RY6wkv9sfEHuXlFNMdZCWx6l3h9/B6yRD9Q67f2vsTlY/1yFN95Ud
         +6lCiHUXSPDA4ZQp7OkcCB27yAHLqrBuX1SOhVDj60M/s3Ru2KV1AzNUcjMFWKEhEWcQ
         WMj0RjDjrc9QGcz7oHnJBCYM1M+AHkqF2gwTUNIEBjZ2BMmAcLuWcZ5eyPpZmnejjNwP
         CcM0P2Mwd2gH6RGTQWIeqfOVGhFqZxSWmbPcMb7vABIEeuwfTy4/3kH21Ai/p7+UO8iR
         p+dh6lrVBaHvWXwdGtE3sCOPmfjcRRNE5CPGnKgF0q1UGPXYOgo+N+BcCJtwmcvsSZJF
         9/4Q==
X-Gm-Message-State: AOJu0YyR/ed8Z/8ITK3ijm0clEUtOBHUCr+QXKmvzjrahzocnDydH2/p
	8caEiOBXe/fsvyhayT72uBjqKkYsrNQFcdloOjk=
X-Google-Smtp-Source: AGHT+IE5nPzSBijGzmgTsixN3I+GOwlz4Vff6SKs+15Z7+uPCo8uHIyvWsWoV9NRxKHDhmgnYtxPkr2DOgLp6axCJBE=
X-Received: by 2002:a50:d69d:0:b0:53d:d4e7:af5f with SMTP id
 r29-20020a50d69d000000b0053dd4e7af5fmr6986261edi.13.1698078248583; Mon, 23
 Oct 2023 09:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022205743.72352-1-andrii@kernel.org> <20231022205743.72352-4-andrii@kernel.org>
 <ZTXmjp7AtrRpHZzR@u94a> <ZTXvAmZmQzKxS2kj@u94a>
In-Reply-To: <ZTXvAmZmQzKxS2kj@u94a>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Oct 2023 09:23:57 -0700
Message-ID: <CAEf4BzZeOt-u+vZsrdj_8o6hMCiPuYrvE5=CCfAhDadSLTC42g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: enhance subregister bounds deduction logic
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 8:57=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Mon, Oct 23, 2023 at 11:20:46AM +0800, Shung-Hsi Yu wrote:
> > On Sun, Oct 22, 2023 at 01:57:39PM -0700, Andrii Nakryiko wrote:
> > > Add handling of a bunch of possible cases which allows deducing extra
> > > information about subregister bounds, both u32 and s32, from full reg=
ister
> > > u64/s64 bounds.
> > >
> > > Also add smin32/smax32 bounds derivation from corresponding umin32/um=
ax32
> > > bounds, similar to what we did with smin/smax from umin/umax derivati=
on in
> > > previous patch.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > ---
> > >  kernel/bpf/verifier.c | 52 +++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 52 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 885dd4a2ff3a..3fc9bd5e72b8 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -2130,6 +2130,58 @@ static void __update_reg_bounds(struct bpf_reg=
_state *reg)
> > >  /* Uses signed min/max values to inform unsigned, and vice-versa */
> > >  static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
> > >  {
> > > +   /* if upper 32 bits of u64/s64 range don't change,
> > > +    * we can use lower 32 bits to improve our u32/s32 boundaries
> > > +    */
> > > +   if ((reg->umin_value >> 32) =3D=3D (reg->umax_value >> 32)) {
> > > +           /* u64 to u32 casting preserves validity of low 32 bits a=
s
> > > +            * a range, if upper 32 bits are the same
> > > +            */
> > > +           reg->u32_min_value =3D max_t(u32, reg->u32_min_value, (u3=
2)reg->umin_value);
> > > +           reg->u32_max_value =3D min_t(u32, reg->u32_max_value, (u3=
2)reg->umax_value);
> > > +
> > > +           if ((s32)reg->umin_value <=3D (s32)reg->umax_value) {
> > > +                   reg->s32_min_value =3D max_t(s32, reg->s32_min_va=
lue, (s32)reg->umin_value);
> > > +                   reg->s32_max_value =3D min_t(s32, reg->s32_max_va=
lue, (s32)reg->umax_value);
> > > +           }
> > > +   }
> > > +   if ((reg->smin_value >> 32) =3D=3D (reg->smax_value >> 32)) {
> > > +           /* low 32 bits should form a proper u32 range */
> > > +           if ((u32)reg->smin_value <=3D (u32)reg->smax_value) {
> > > +                   reg->u32_min_value =3D max_t(u32, reg->u32_min_va=
lue, (u32)reg->smin_value);
> > > +                   reg->u32_max_value =3D min_t(u32, reg->u32_max_va=
lue, (u32)reg->smax_value);
> > > +           }
> > > +           /* low 32 bits should form a proper s32 range */
> > > +           if ((s32)reg->smin_value <=3D (s32)reg->smax_value) {
> > > +                   reg->s32_min_value =3D max_t(s32, reg->s32_min_va=
lue, (s32)reg->smin_value);
> > > +                   reg->s32_max_value =3D min_t(s32, reg->s32_max_va=
lue, (s32)reg->smax_value);
> > > +           }
> > > +   }
> > > +   /* Special case where upper bits form a small sequence of two
> > > +    * sequential numbers (in 32-bit unsigned space, so 0xffffffff to
> > > +    * 0x00000000 is also valid), while lower bits form a proper s32 =
range
> > > +    * going from negative numbers to positive numbers.
> > > +    * E.g.: [0xfffffff0ffffff00; 0xfffffff100000010]. Iterating
> > > +    * over full 64-bit numbers range will form a proper [-16, 16]
> > > +    * ([0xffffff00; 0x00000010]) range in its lower 32 bits.
> > > +    */
>
> Oops, scratch that, these below is not entirely incorrect.
>
> > Not sure if we want ascii art here but though it'd be useful to share. =
It
> > took a while to wrap my head around this concept until I look at this a=
s
> > number lines.
> >
> > Say we've got umin, umax tracked like so (asterisk * marks the sequence=
 of
> > numbers we believe is possible to occur).
> >
> >               u64
> >   |--------***--------------|
> >    {  32-bits }{  32-bits  }
> >
> > And s32_min, s32_max tracked liked so.
> >
> >                            s32
> >                      |***---------|
> >
> > The above u64 range can be mapped into two possible s32 range when we'v=
e
> > removed the upper 32-bits.
>
> The u64 range can be mapped into 2^32 possible s32 ranges. So the s32 ran=
ges
> view has been enlarged 2^32 here.
>
> And I'm also missing the condition that it crosses U32_MAX in u32 range.
>
> I will redo the graphs.

Yeah, tbh, the graphs above weren't really all that helpful, rather
more confusing. But I think you got the point correctly, that we are
stitching two s32 ranges, if we can. And we can if upper 32 bits are
two consecutive numbers and lower 32-bits goes from negative to
positive (as s32).

>
> >               u64               same u64 wrapped
> >   |--------***--------------|-----...
> >            |||
> >         |--***-------|------------|
> >               s32          s32
> >
> > Since both s32 range are possible, we take the union between then, and =
the
> > s32 range we're already tracking
> >
> >         |------------|
> >         |--***-------|
> >         |***---------|
> >
> > And arrives at the final s32 range.
> >
> >         |*****-------|
> >
> > Taking this (wrapped) number line view and operates them with set opera=
tions
> > (latter is similar to what tnum does) is quite useful and I think hints=
 that
> > we may be able to unify signed and unsigned range tracking. I'll look i=
nto
> > this a bit more and send a follow up.
> >
> > > +   if ((u32)(reg->umin_value >> 32) + 1 =3D=3D (u32)(reg->umax_value=
 >> 32) &&
> > > +       (s32)reg->umin_value < 0 && (s32)reg->umax_value >=3D 0) {
> > > +           reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s3=
2)reg->umin_value);
> > > +           reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s3=
2)reg->umax_value);
> > > +   }
> > > +   if ((u32)(reg->smin_value >> 32) + 1 =3D=3D (u32)(reg->smax_value=
 >> 32) &&
> > > +       (s32)reg->smin_value < 0 && (s32)reg->smax_value >=3D 0) {
> > > +           reg->s32_min_value =3D max_t(s32, reg->s32_min_value, (s3=
2)reg->smin_value);
> > > +           reg->s32_max_value =3D min_t(s32, reg->s32_max_value, (s3=
2)reg->smax_value);
> > > +   }
> > > +   /* if u32 range forms a valid s32 range (due to matching sign bit=
),
> > > +    * try to learn from that
> > > +    */
> > > +   if ((s32)reg->u32_min_value <=3D (s32)reg->u32_max_value) {
> > > +           reg->s32_min_value =3D max_t(s32, reg->s32_min_value, reg=
->u32_min_value);
> > > +           reg->s32_max_value =3D min_t(s32, reg->s32_max_value, reg=
->u32_max_value);
> > > +   }
> > >     /* Learn sign from signed bounds.
> > >      * If we cannot cross the sign boundary, then signed and unsigned=
 bounds
> > >      * are the same, so combine.  This works even in the negative cas=
e, e.g.
> > > --
> > > 2.34.1
> > >

