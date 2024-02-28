Return-Path: <bpf+bounces-22934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F686BA0C
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234FF1C21233
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935907003E;
	Wed, 28 Feb 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYnLWNO3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812670036
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156202; cv=none; b=r5bWu6Fzqcpz21lAIuwMB0QuCyWDolLU2gOYvF+P+2NJqvqDyXSD11rC4i9tqDaTXspR8TLGQU0kade4FpHwNMo5n6Td1YpHx6byKhVu8bTtuOAV0IGyXLxByKhRzAOWX+rbXSy4zeSio/1f6CZkeR2BnfdjMV78qw/tp84Cpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156202; c=relaxed/simple;
	bh=R0bKSqKbLER0/tawp873iuI7UNZHujozQmFmDDG1+uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myH0LR7Buoy5u1gyToWGgtw+r4YUvhdmOgeb6eqfghhDlzgGvmY20dd4slnif5qPNg+Qpto/A9kiZnTEp3PKakFlp1Woe+koKDLAEc+CPvhSdFuzXAqOOcmJNYRvvmIPiN3zmQJbCmawc4mvG8mXFVqGSwJ71ItfouLdAt/dcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYnLWNO3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d93edfa76dso2865335ad.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 13:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709156200; x=1709761000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jub6oEPvlWUttJ670AQ3nOIc55pZPLkK7c7Bm81h+aA=;
        b=cYnLWNO3lRSI2ppElWp6oAQDG+qml7uXdlX3oirhk2QKVwcLkyapJqwBc6mxaE6fy8
         +fQNse6dwYcjp9by2lefdfQrXR4yWcRL3F/OKYq2TMRpDdiwLFgA7EAH1kVXJ3BXjW5w
         ALV3c9HRmLhRcfpYkmIDzpalqOGl0nMWPwgxtRAz6HTsaIer8ltw0jKXrJurj+7f99Yv
         3wDTLoR1gdzPOVRTIjA2gqD5sx/OkNx3AlerjV0Fb8YcbS8KEqa28z8JMjY4mz/X1qLK
         sjegJtBXgC5ORk1eKaFhNTkPisNWDYln5aHKTaSfGomcUUyPU1w4BDsf6q4DVZvi51qq
         RU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709156200; x=1709761000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jub6oEPvlWUttJ670AQ3nOIc55pZPLkK7c7Bm81h+aA=;
        b=uzNKg6Qvvwz/7qKZbw8n4vGCsHjrhJXuC8d9wSjYqhQxrlWR4eqzuzYWuHUbIn9xjj
         HFGJoGnWk+HrkS/HJBgaBcPH/WAugWzsLLJmUVqpkvraz7MnFR0p5tnEVGL7Jq3a/aGc
         m0AG+5AhQ/RSQTdDjFp64AGm8DS2bEtCTW3PflGW4lLKD3gEbh9kNYHJg7xhaA7L1EP1
         4NXB3KHV0AX5MJv1b/nizv0WA3LtiAGjkpMbEpKBjhCWaf2974/wMLGxs/WHwc05TQa/
         ArttZlC5PDDh643pggneXofLiC+XDOt1g/LjJPGvJAvmyOFqqih8hjIhTk5rA8hq0ORi
         75eg==
X-Gm-Message-State: AOJu0Yz8qQov5RgWQVh5CfNxNvq6xzEgFwibxzu46hYKADuCWAYBwWTQ
	KFx97WJHIY1eNq6LM7YmnYAcpCM/Nm4SFkpuYUKm54Yim/0XlyQjzX7PAdh7R7Zag5dRCgb/ktA
	hT2SdwPI7TcqM/iJ0TaWsnkn//Bg=
X-Google-Smtp-Source: AGHT+IHDnlYzmofi8B6NVpXPEnD8t+3BQaNheKjsJeEExuKvjJ7ErtRatfL5cLOeKml329RdVNe4DwJ3L3mkh/JqCRU=
X-Received: by 2002:a17:903:8c5:b0:1dc:b16c:6403 with SMTP id
 lk5-20020a17090308c500b001dcb16c6403mr207772plb.3.1709156199969; Wed, 28 Feb
 2024 13:36:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222005005.31784-1-eddyz87@gmail.com> <20240222005005.31784-3-eddyz87@gmail.com>
 <CAEf4BzYwoFN8GzdWt+6Avbh1jT5LoybOUVh=C-8=dX8H75J_+Q@mail.gmail.com> <27ec4223c14109a28422e8910232be157bf258d3.camel@gmail.com>
In-Reply-To: <27ec4223c14109a28422e8910232be157bf258d3.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 13:36:27 -0800
Message-ID: <CAEf4BzbRQRSDhb_qOdKBBx8r-qa25cTu29KWVdxBq7V6zEGfrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: track find_equal_scalars history on
 per-instruction level
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 1:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-02-28 at 11:58 -0800, Andrii Nakryiko wrote:
> [...]
>
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index cbfb235984c8..26e32555711c 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -361,6 +361,7 @@ struct bpf_jmp_history_entry {
> > >         u32 prev_idx : 22;
> > >         /* special flags, e.g., whether insn is doing register stack =
spill/load */
> > >         u32 flags : 10;
> > > +       u64 equal_scalars;
> >
> > nit: should we call this concept as a bit more generic "linked
> > registers" instead of "equal scalars"?
>
> It's a historical name for the feature and it is present in a few commit =
and tests.
> Agree that "linked_registers" is better in current context.
> A bit reluctant but can change it here.
>
> [...]
>
> > I'm wondering if this pop/push set of primitives is the best approach?
>
> I kinda like it :)
>
> > What if we had pack/unpack operations, where for various checking
> > logic we'd be working with "unpacked" representation, e.g., something
> > like this:
> >
> > struct linked_reg_set {
> >     int cnt;
> >     struct {
>
> Will need a name here, otherwise iteration would be somewhat inconvenient=
.
> Suppose 'struct reg_or_spill'.
>
> >         int frameno;
> >         union {
> >             int spi;
> >             int regno;
> >         };
> >         bool is_set;
> >         bool is_reg;
> >     } reg_set[6];
> > };
> >
> > bt_set_equal_scalars() could accept `struct linked_reg_set*` instead
> > of bitmask itself. Same for find_equal_scalars().
>
> For clients it would be
>
>         while (equal_scalars_pop(&equal_scalars, &fr, &spi, &is_reg)) {
>                 if ((is_reg && bt_is_frame_reg_set(bt, fr, spi)) ||
>                     (!is_reg && bt_is_frame_slot_set(bt, fr, spi)))
>                     ...
>         }
>
>     --- vs ---
>
>         for (i =3D 0; i < equal_scalars->cnt; ++i) {
>                 struct reg_or_spill *r =3D equal_scalars->reg_set[i];
>
>                 if ((r->is_reg && bt_is_frame_reg_set(bt, r->frameno, r->=
regno)) ||
>                     (!r->is_reg && bt_is_frame_slot_set(bt, r->frameno, r=
->spi)))
>                     ...
>         }
>
> I'd say, no significant difference.

Can I disagree? I find the second to be much better. There is no
in-place modification of a mask, no out parameters, we have a clean
record r with a few fields. We also know the count upfront, though we
maintain a simple rule (mask =3D=3D 0 =3D> cnt =3D=3D 0), so not really a b=
ig
deal either way.

>
> > I think even implementation of packing/unpacking would be more
> > straightforward and we won't even need all those ES_xxx consts (or at
> > least fewer of them).
> >
> > WDYT?
>
> I wouldn't say it simplifies packing/unpacking much.
> Below is the code using new data structure and it's like
> 59 lines old version vs 56 lines new version.

I'd say it's not about a number of lines, it's about ease of
understanding, reasoning, and using these helpers.

I do prefer the code you wrote below, but I'm not going to die on this
hill if you insist. I'll go think about the rest of the logic.

>
> --- 8< ----------------------------------------------------------------
>
> struct reg_or_spill {
>         int frameno;
>         union {
>                 int spi;
>                 int regno;
>         };
>         bool is_reg;
> };
>
> struct linked_reg_set {
>         int cnt;
>         struct reg_or_spill reg_set[6];
> };
>
> /* Pack one history entry for equal scalars as 10 bits in the following f=
ormat:
>  * - 3-bits frameno
>  * - 6-bits spi_or_reg
>  * - 1-bit  is_reg
>  */
> static u64 linked_reg_set_pack(struct linked_reg_set *s)
> {
>         u64 val =3D 0;
>         int i;
>
>         for (i =3D 0; i < s->cnt; ++i) {
>                 struct reg_or_spill *r =3D &s->reg_set[i];
>                 u64 tmp =3D 0;
>
>                 tmp |=3D r->frameno & ES_FRAMENO_MASK;
>                 tmp |=3D (r->spi & ES_SPI_MASK) << ES_SPI_OFF;

nit: we shouldn't mask anything here, it just makes an impression that
r->frameno can be bigger than we have bits for it in a bitmask

>                 tmp |=3D (r->is_reg ? 1 : 0) << ES_IS_REG_OFF;
>
>                 val <<=3D ES_ENTRY_BITS;
>                 val |=3D tmp;

val <<=3D ES_ENTRY_BITS;
val |=3D r->frameno | (r->spi << ES_SPI_OFF) | ((r->is_reg ? 1 : 0) <<
ES_IS_REG_OFF);

or you can do it as three assignment, but there is no need for tmp

>         }
>         val <<=3D ES_SIZE_BITS;
>         val |=3D s->cnt;
>         return val;
> }
>
> static void linked_reg_set_unpack(u64 val, struct linked_reg_set *s)
> {
>         int i;
>
>         s->cnt =3D val & ES_SIZE_MASK;
>         val >>=3D ES_SIZE_BITS;
>
>         for (i =3D 0; i < s->cnt; ++i) {
>                 struct reg_or_spill *r =3D &s->reg_set[i];
>
>                 r->frameno =3D  val & ES_FRAMENO_MASK;
>                 r->spi     =3D (val >> ES_SPI_OFF) & ES_SPI_MASK;
>                 r->is_reg  =3D (val >> ES_IS_REG_OFF) & 0x1;
>                 val >>=3D ES_ENTRY_BITS;
>         }
> }
>

I do think that the above is much easier to read and follow.

> ---------------------------------------------------------------- >8 ---

