Return-Path: <bpf+bounces-75303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4BFC7E540
	for <lists+bpf@lfdr.de>; Sun, 23 Nov 2025 19:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49B7A4E14C4
	for <lists+bpf@lfdr.de>; Sun, 23 Nov 2025 18:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3982234966;
	Sun, 23 Nov 2025 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyeCKT6r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D05019E819
	for <bpf@vger.kernel.org>; Sun, 23 Nov 2025 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763921267; cv=none; b=Ck27j0bUmJQZIrIXNf0YI3kE7Av55GZVShr5972zAFtedAeK/oFWn5C8IZMAmxO1hqUSttKxfIXz0cfrsAg+wlN/4AfUtK6Fe2bVfAVkeyxOkq5uz94IjfGbOswiUvHf9io7Z2uppuK7FIdOgp7WOC97mORO5MWHL/1UJIhNV7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763921267; c=relaxed/simple;
	bh=PdY3TC8QxHLo+F+nDS9HZRCJ2UTQFbY+XHEF+vEH64A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ij9PfZ+zmFq1O6jXbaHddeMATovwNpFLo2veE+9jMXdx1mjJQI7a77+xUvRED/iy8NOnss5/JtCnvjBTLuYctYhiBQv/yClH+sDKQZTY5zxyRHiC1MzJquw6m9ZmInU+fFuRMxb/ovtHRBSV8g0rt+wPPOr1yPgWu7r7hXqDqnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyeCKT6r; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so24900145e9.2
        for <bpf@vger.kernel.org>; Sun, 23 Nov 2025 10:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763921264; x=1764526064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NhQxnxNvy8W4MIozVgyD6WAqeyUL2JQLmu0aTdNPuk=;
        b=cyeCKT6r0h+TFuHyEDyHltGZXbQJNcXQ2ntHOxfzV7NBcXJdhxFZWQg7kmbyOiT7Uf
         qfk2tR8n99vXmzeZkpHpa0M2AuEISd/+Cjb/yh0KyCOdB6+YFc4lAAAo+UyCgdjw0JS+
         oMah6fSy+DBfV5ZAGxRRUvYwO6we8MTO1ZO5PLq9dfNV59uOldqLBAu8Dn844wQ6X0Na
         sfEEfNNib6kwxd7po8EGPJ5Y9wpeqBDp7WnWB8GkeE0OHPKsesdcQ+XO/C0y1Q8OO/Yz
         jTD11zWN8DIasii5qwoE5y8OdlXTpbGJygGMoTqUoP0IcOH3/tdxdj+JGJyCRKjC/Yzi
         Zr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763921264; x=1764526064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+NhQxnxNvy8W4MIozVgyD6WAqeyUL2JQLmu0aTdNPuk=;
        b=kwIVOsqgSO2ECnuCL/MiwrrNxjICI6Z01q6XXOBALdki24S+jyXkWoJKqwSVTVzB50
         wpd0u3WPog1z+gHzoE228DoN42mG/AdNgwTvRqp8aXe1ZMHnOb2ZVDOuH1L9wBd+1gGH
         ZLryQoltCGdZBBN1A/WAPC1WgVAD6ukefOzKt302YnrDPQX2GjVGjYyYDTnNRxvWKU/a
         hXeeOauY2FLWhaWvUwTRz0vkoTY0BQ44R+7GkN1DNwgwXju3AfBtlmDA4wJbbZ60lEl9
         ukATEoUiNaMELU27yXR1LA/lTSlbPPlWz6e7/HdRKpE8/fnafAaHAMm8w77fV4gd540z
         y7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYgf+qR93Q2+NxDg8jTfkXVBnwAv9NJ75LGCq54Xt01489EpY3oqoihSstvkpfsqK7bx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU4brJ9O7wwqnNvPMt9yb682vNmvFjJrOLBl2ByMw5FfyxdNHH
	wJb3Z2f0j2ilrsFoo+0UT3PmES0uJ02VbTUHyTuQfxzJVmRG13Zz9wLz
X-Gm-Gg: ASbGncv9UejC4d7jPxQZia+K5KnoX4CKDzRTHGKSld7Cf8vrQ+3FTBT3NofOs2cbT0a
	EzUiuIlSTiMCy2kgUjRX5NextT8EHWktqmkrtL8ilggF1Eu03MonXCQwGyyLhYO0MNVJUKRRjmf
	Fi/1/ez5hnXtuIRA/psVwRnSyIxaU2hZQoJMCBBbrNqnVanNcee748T2aD7NTGgSLM8RgD8Iw50
	qEumQL/ZgcNeB/pCtQF/QrbF2K69HW9mawRdV75giay9q30yH+uqQ4/gIjVFtsDAtkAuXYRNZgs
	txMvkM+3MEucL1HwzmI48C01IZfLNpExlsQhoc3z1tDhZPTBVsSJaJ0XQJpJc8Y7c2nSdbax19k
	blmlWSanLk5XhbkM6SVTFWI9aF3SYjwsPoR0kWdUqBbPUcZmW9nzpYy2CXsB1Ed5akTTdl/XwCp
	gaa3po47wTGq7eiEDGWwNUd2wJrHb212bxe8fO+4RV8h+cBJBHB2jo
X-Google-Smtp-Source: AGHT+IG/cYV7vixIRxYiH4QYGFWv0RK1n9tpfEodwp2gcBftSOhsCx+PTMxXKlZgmsLIzHaPUIXBAQ==
X-Received: by 2002:a05:600c:1c28:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-477c01c11afmr106667295e9.18.1763921263655;
        Sun, 23 Nov 2025 10:07:43 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dcbca9sm132822365e9.6.2025.11.23.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 10:07:43 -0800 (PST)
Date: Sun, 23 Nov 2025 18:07:41 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 06/44] bpf: Verifier, remove some unusual uses of
 min_t() and max_t()
Message-ID: <20251123180741.65cd2dd3@pumpkin>
In-Reply-To: <CAADnVQJFxWParvYg9_YZaD7HFFPW6yzStm7e1nKgdMQ+UYUtqw@mail.gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
	<20251119224140.8616-7-david.laight.linux@gmail.com>
	<CAADnVQKFPpzbcakNmq2RkYQvm1TsdgO73UNuoaa_F8SCm6suNw@mail.gmail.com>
	<20251121222151.7056c4fa@pumpkin>
	<CAADnVQJFxWParvYg9_YZaD7HFFPW6yzStm7e1nKgdMQ+UYUtqw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Nov 2025 08:39:51 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Fri, Nov 21, 2025 at 2:21=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Fri, 21 Nov 2025 13:40:36 -0800
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > =20
> > > On Wed, Nov 19, 2025 at 2:42=E2=80=AFPM <david.laight.linux@gmail.com=
> wrote: =20
> > > >
> > > > From: David Laight <david.laight.linux@gmail.com>
> > > >
> > > > min_t() and max_t() are normally used to change the signedness
> > > > of a positive value to avoid a signed-v-unsigned compare warning.
> > > >
> > > > However they are used here to convert an unsigned 64bit pattern
> > > > to a signed to a 32/64bit signed number.
> > > > To avoid any confusion use plain min()/max() and explicitely cast
> > > > the u64 expression to the correct signed value.
> > > >
> > > > Use a simple max() for the max_pkt_offset calulation and delete the
> > > > comment about why the cast to u32 is safe.
> > > >
> > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > > ---
> > > >  kernel/bpf/verifier.c | 29 +++++++++++------------------
> > > >  1 file changed, 11 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index ff40e5e65c43..22fa9769fbdb 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -2319,12 +2319,12 @@ static void __update_reg32_bounds(struct bp=
f_reg_state *reg)
> > > >         struct tnum var32_off =3D tnum_subreg(reg->var_off);
> > > >
> > > >         /* min signed is max(sign bit) | min(other bits) */
> > > > -       reg->s32_min_value =3D max_t(s32, reg->s32_min_value,
> > > > -                       var32_off.value | (var32_off.mask & S32_MIN=
));
> > > > +       reg->s32_min_value =3D max(reg->s32_min_value,
> > > > +                       (s32)(var32_off.value | (var32_off.mask & S=
32_MIN)));
> > > >         /* max signed is min(sign bit) | max(other bits) */
> > > > -       reg->s32_max_value =3D min_t(s32, reg->s32_max_value,
> > > > -                       var32_off.value | (var32_off.mask & S32_MAX=
));
> > > > -       reg->u32_min_value =3D max_t(u32, reg->u32_min_value, (u32)=
var32_off.value);
> > > > +       reg->s32_max_value =3D min(reg->s32_max_value,
> > > > +                       (s32)(var32_off.value | (var32_off.mask & S=
32_MAX))); =20
> > >
> > > Nack.
> > > This is plain ugly for no good reason.
> > > Leave the code as-is. =20
> >
> > It is really horrid before.
> > From what i remember var32_off.value (and .mask) are both u64.
> > The pattern actually patches that used a few lines down the file.
> >
> > I've been trying to build allmodconfig with the size test added to min_=
t()
> > and max_t().
> > The number of real (or potentially real) bugs I've found is stunning.
> > The only fix is to nuke min_t() and max_t() to they can't be used. =20
>=20
> No. min_t() is going to stay. It's not broken and
> this crusade against it is inappropriate.

I bet to differ...

> > The basic problem is the people have used the type of the target not th=
at
> > of the largest parameter.
> > The might be ok for ulong v uint (on 64bit), but there are plenty of pl=
aces
> > where u16 and u8 are used - a lot are pretty much buggy.
> >
> > Perhaps the worst ones I've found are with clamp_t(),
> > this is from 2/44:
> > -               (raw_inode)->xtime =3D cpu_to_le32(clamp_t(int32_t, (ts=
).tv_sec, S32_MIN, S32_MAX));      \
> > +               (raw_inode)->xtime =3D cpu_to_le32(clamp((ts).tv_sec, S=
32_MIN, S32_MAX)); \
> > If also found clamp_t(u8, xxx, 0, 255).
> >
> > There are just so many broken examples. =20
>=20
> clamp_t(u8, xxx, 0, 255) is not wrong. It's silly, but
> it's doing the right thing and one can argue and explicit
> clamp values serve as a documentation.

Not when you look at some of the code that uses it.
The clear intention is to saturate a large value - which isn't what it does.

> clamp_t(int32_t, (ts).tv_sec, S32_MIN, S32_MAX)) is indeed incorrect,
> but it's a bug in the implementation of __clamp_once().
> Fix it, instead of spamming people with "_t" removal.

It is too late by the time you get to clamp_once().
The 'type' for all the xxx_t() functions is an input cast, not the type
for the result.
clamp_t(type, v, lo, hi) has always been clamp((type)v, (type)lo, type(hi)).
=46rom a code correctness point of view you pretty much never want those cast=
s.

I've already fixed clamp() so it doesn't complain about comparing s64 again=
st s32.
The next stage is to change pretty much all the xxx_t() to plain xxx().

If you've got some spare time try issuing read calls with a 4GB buffer to a=
ll
the subsystems you can find - and see how many loop for ever.
(I think you can do that with readv() and a single buffer.)
The issue there is that a lot use min_t(u32, max_frag_size, xfer_size) to s=
plit
operations - and xfer_size is size_t (so I'm pretty sure there are ways to =
get
4GB in there).

	David



