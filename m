Return-Path: <bpf+bounces-75305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96D6C7E94E
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 00:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D313A4D07
	for <lists+bpf@lfdr.de>; Sun, 23 Nov 2025 23:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFAB231827;
	Sun, 23 Nov 2025 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RovRUwGN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42326560B
	for <bpf@vger.kernel.org>; Sun, 23 Nov 2025 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763939004; cv=none; b=Un/FktBFTUYGsKURTe6eozxq4/w/VxpmTYii38KZtfmeHJJDJ/vxr/RR/mFUTqhpmgDpAKIuFxv8M9ezR2yU8dp+6NgxYEmno9q0Pv8aTkqk4aYwzPkNzeKkkGqR+F592YRPKUMtZPW6J/OxXrFwSzi9XAgOmWr2k5Z5fIPPP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763939004; c=relaxed/simple;
	bh=q+CBTRohQAdufFFh0acw522qO+EW8I5Rd0+QL0DK6bU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQ0Ej+eVuoFYv/NFEB/xmVDGkddXEY/9+y1dAEgG6fhN8Dvi2wdFKqfOYp2BkwT9PsSGAlswYRuLsh9BtkfHJtWuJArVInpkwKUguQJyGgDEQiCFFmGibVSx02lvEkHt7s2/6N6ehyNZ84Y5ZcalWMhFcO495F5qhstAMKAvndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RovRUwGN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso2975988f8f.1
        for <bpf@vger.kernel.org>; Sun, 23 Nov 2025 15:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763939000; x=1764543800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVgZoX1+IIDbzgQaS6E0qdZz5TSyOvL6XsPSTda1Wkw=;
        b=RovRUwGNzIPdK6FWE58IFWm8B6V83j/Lp4uPzQeSaTcd0pyjBu5eTEz0Iga0W0oqgF
         4Vl6Io+n8j2la547xhAxAxwpyh/V0I7gYXU3bq/Mjcdk+HOVCEaeFL7Q65LRV0DbJ0Nu
         SfX9GBv/YnxwYvTyG6rM/DqArok6PibSl9hQA1XixAnohwIWGhA8d9Zuzv55jR3Odz6d
         RAMm1PiWSRy2uqFYbDlW+7Ggid0BayDY0uwX0j7hAuvc8FwzMQ/SIN/Zu1a8ppM4xCvV
         e2+V0EuI4fF/m6AgnqeWhyCKJwjNidfQ2DDrj5trzHJY4wi+/0enBjUI2mZRB5lr71c+
         I1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763939000; x=1764543800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xVgZoX1+IIDbzgQaS6E0qdZz5TSyOvL6XsPSTda1Wkw=;
        b=XfZ+yjPKQ1GFjs8dTiMJB94nMfGr3ZIs61cZ0IZtIsGP6XJ8pec6frkEoK7A/hsi6t
         NwtXDcid/i00C2RG0qgUbYLuhuQWbzLLaKU9y4vV6M76SjarsoC/4eYoX+zvIjnVZDBq
         MMG1YRtfxKJA0Gu+y8n/nyhj4JWPeUQ0qCHxM/iTxsKIFIuUVcjtH2thf+xb1i0Gz5vn
         bleATJv28zUK3YiyU40TmL0jYuvgCBxw/8YnIjf3NUaSjv1K9PG0Nk76BBLb9cBNCt5r
         e2nN9FTYJuCdWVDzsKnMwnrrQ6pxy7OdCjrYbJc0DZLc58U5S6xPgoNQWkFppXD6oZTN
         QlrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdoIzxch/LOkAz6PMRRl849VmDVnGLcDGeuHTs80G3nTDKCH6v/DEjGRLYxdvYjQOYxgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVYLN7RKgcAGSmFSAUnEyIicOsjk46H9B5qJnQlxdmwEJU8ZyL
	YnaYMuZ10xs1m+H5fs9sFO0kuFUNrTotlYizI539DaROiOztWp4EHUe5
X-Gm-Gg: ASbGnctsAZ/A5ERJJ+dPnNKxSNvZy77wUtal9LxyHT5u2ZjZFXEnZKUETpQ5Uq/TmA5
	ETEbX2Ke5BsrdgmqT8zGfvs9TvIrv7oCJ4MNAafCqIB9WiziJDjE8yuhWqCxmDP6rEtNDK50aT5
	7SYqixFAYf3/oPYuSDMYfzBjSDwavW3mysT4BpIqG5+A/aOT/EQuqILp+qEnWEhTfIPud7hI0op
	huOhuWZlSqFtVvIi7IqnglR/4A50b7wDZBDHTTZFanqhllk1cOBN2FgNpNgDIoONq72pRVsa7m3
	jZCcwmnwtjwpYpiFhdLERhSUSGsvuLtrZMnz+xSUNQuDS27u270zAwNSpiRuArTAWzVZhgmcpsQ
	mOnduuY34QCjOYNnKFPn5LXbj29iK2+pFK1PxNx/jOyUkjvAAFoFiaFeQhDmydH1vlRaCPak6jA
	xduSTm3VUkt7FoNPy5KfweZq9z6n620R5X0EmBDeIvzeKMsetSL0PcrtbLsFqctlg=
X-Google-Smtp-Source: AGHT+IEMqc0mbwAOm/yFMc6I4lHzGDltEwXfe21zVP/xGh57Atz64hMLhWHHnVxrU5bdL6WJ9NCbIA==
X-Received: by 2002:a05:6000:1868:b0:429:8daa:c6b4 with SMTP id ffacd0b85a97d-42cc1ce4791mr9491605f8f.21.1763939000145;
        Sun, 23 Nov 2025 15:03:20 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363e4sm25186765f8f.12.2025.11.23.15.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:03:19 -0800 (PST)
Date: Sun, 23 Nov 2025 23:03:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 06/44] bpf: Verifier, remove some unusual uses of
 min_t() and max_t()
Message-ID: <20251123230318.74b94c99@pumpkin>
In-Reply-To: <CAADnVQL95nwYGYO0jNGR2Pt3ApJa31LsD7y7sbLMtVDyvWJWZA@mail.gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
	<20251119224140.8616-7-david.laight.linux@gmail.com>
	<CAADnVQKFPpzbcakNmq2RkYQvm1TsdgO73UNuoaa_F8SCm6suNw@mail.gmail.com>
	<20251121222151.7056c4fa@pumpkin>
	<CAADnVQJFxWParvYg9_YZaD7HFFPW6yzStm7e1nKgdMQ+UYUtqw@mail.gmail.com>
	<20251123180741.65cd2dd3@pumpkin>
	<CAADnVQL95nwYGYO0jNGR2Pt3ApJa31LsD7y7sbLMtVDyvWJWZA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Nov 2025 11:20:03 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Sun, Nov 23, 2025 at 10:07=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sun, 23 Nov 2025 08:39:51 -0800
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > =20
> > > On Fri, Nov 21, 2025 at 2:21=E2=80=AFPM David Laight
> > > <david.laight.linux@gmail.com> wrote: =20
> > > >
> > > > On Fri, 21 Nov 2025 13:40:36 -0800
> > > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > > =20
> > > > > On Wed, Nov 19, 2025 at 2:42=E2=80=AFPM <david.laight.linux@gmail=
.com> wrote: =20
> > > > > >
> > > > > > From: David Laight <david.laight.linux@gmail.com>
> > > > > >
> > > > > > min_t() and max_t() are normally used to change the signedness
> > > > > > of a positive value to avoid a signed-v-unsigned compare warnin=
g.
> > > > > >
> > > > > > However they are used here to convert an unsigned 64bit pattern
> > > > > > to a signed to a 32/64bit signed number.
> > > > > > To avoid any confusion use plain min()/max() and explicitely ca=
st
> > > > > > the u64 expression to the correct signed value.
> > > > > >
> > > > > > Use a simple max() for the max_pkt_offset calulation and delete=
 the
> > > > > > comment about why the cast to u32 is safe.
> > > > > >
> > > > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > > > > ---
> > > > > >  kernel/bpf/verifier.c | 29 +++++++++++------------------
> > > > > >  1 file changed, 11 insertions(+), 18 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > > index ff40e5e65c43..22fa9769fbdb 100644
> > > > > > --- a/kernel/bpf/verifier.c
> > > > > > +++ b/kernel/bpf/verifier.c
> > > > > > @@ -2319,12 +2319,12 @@ static void __update_reg32_bounds(struc=
t bpf_reg_state *reg)
> > > > > >         struct tnum var32_off =3D tnum_subreg(reg->var_off);
> > > > > >
> > > > > >         /* min signed is max(sign bit) | min(other bits) */
> > > > > > -       reg->s32_min_value =3D max_t(s32, reg->s32_min_value,
> > > > > > -                       var32_off.value | (var32_off.mask & S32=
_MIN));
> > > > > > +       reg->s32_min_value =3D max(reg->s32_min_value,
> > > > > > +                       (s32)(var32_off.value | (var32_off.mask=
 & S32_MIN)));
> > > > > >         /* max signed is min(sign bit) | max(other bits) */
> > > > > > -       reg->s32_max_value =3D min_t(s32, reg->s32_max_value,
> > > > > > -                       var32_off.value | (var32_off.mask & S32=
_MAX));
> > > > > > -       reg->u32_min_value =3D max_t(u32, reg->u32_min_value, (=
u32)var32_off.value);
> > > > > > +       reg->s32_max_value =3D min(reg->s32_max_value,
> > > > > > +                       (s32)(var32_off.value | (var32_off.mask=
 & S32_MAX))); =20
> > > > >
> > > > > Nack.
> > > > > This is plain ugly for no good reason.
> > > > > Leave the code as-is. =20
> > > >
> > > > It is really horrid before.
> > > > From what i remember var32_off.value (and .mask) are both u64.
> > > > The pattern actually patches that used a few lines down the file.
> > > >
> > > > I've been trying to build allmodconfig with the size test added to =
min_t()
> > > > and max_t().
> > > > The number of real (or potentially real) bugs I've found is stunnin=
g.
> > > > The only fix is to nuke min_t() and max_t() to they can't be used. =
=20
> > >
> > > No. min_t() is going to stay. It's not broken and
> > > this crusade against it is inappropriate. =20
> >
> > I bet to differ...
> > =20
> > > > The basic problem is the people have used the type of the target no=
t that
> > > > of the largest parameter.
> > > > The might be ok for ulong v uint (on 64bit), but there are plenty o=
f places
> > > > where u16 and u8 are used - a lot are pretty much buggy.
> > > >
> > > > Perhaps the worst ones I've found are with clamp_t(),
> > > > this is from 2/44:
> > > > -               (raw_inode)->xtime =3D cpu_to_le32(clamp_t(int32_t,=
 (ts).tv_sec, S32_MIN, S32_MAX));      \
> > > > +               (raw_inode)->xtime =3D cpu_to_le32(clamp((ts).tv_se=
c, S32_MIN, S32_MAX)); \
> > > > If also found clamp_t(u8, xxx, 0, 255).
> > > >
> > > > There are just so many broken examples. =20
> > >
> > > clamp_t(u8, xxx, 0, 255) is not wrong. It's silly, but
> > > it's doing the right thing and one can argue and explicit
> > > clamp values serve as a documentation. =20
> >
> > Not when you look at some of the code that uses it.
> > The clear intention is to saturate a large value - which isn't what it =
does.
> > =20
> > > clamp_t(int32_t, (ts).tv_sec, S32_MIN, S32_MAX)) is indeed incorrect,
> > > but it's a bug in the implementation of __clamp_once().
> > > Fix it, instead of spamming people with "_t" removal. =20
> >
> > It is too late by the time you get to clamp_once().
> > The 'type' for all the xxx_t() functions is an input cast, not the type
> > for the result.
> > clamp_t(type, v, lo, hi) has always been clamp((type)v, (type)lo, type(=
hi)).
> > From a code correctness point of view you pretty much never want those =
casts. =20
>=20
> Historical behavior doesn't justify a footgun.
> You definitely can make clampt_t() to behave like clamp_val() plus
> the final cast.

clamp_val() is actually the worst of the lot.

> Also note:
> git grep -w clamp_val|wc -l
> 818
> git grep -w clamp_t|wc -l
> 494
>=20
> a safer macro is already used more often.

clamp_val() is worse than clamp_t() ...

Nope...
The problem is that clamp() requires all three parameters have the same typ=
e.
Coders are lazy and want to write clamp(variable, 1, 10).
This was fine if 'variable' had type 'int', but if it was 'unsigned int' you
had to write clamp(variable, 1u, 10u), worse if it is 'u8' you to either ca=
st
both constants clamp(variable, (u8)1, (u8)10) or the variable
clamp((int)variable, 1, 10).
It the types/values aren't immediately obvious then any of those casts can
discard high bits.

A lot of the clamp_val() are actually for u8 structure members.
One thing to remember about C is it doesn't have any maths operators
for u8, the values are always promoted to 'int' before anything happens.
So if you write (foo->u8_member > 4 ? foo->u8_member : 4) the comparison
is done as an integer one.
Add some casts ((u8)f->m > (u8)x ? (u8)f->m : (u8)x) then the values are
all masked to 8 bits, promoted to 32 and then compared.
Even the ?: operator promotes its arguments and has a result type of 'int'.

Consider clamp_val(f->u8_m, LO, HI);
If HI is 255 it is fine, make HI 256 (perhaps it is sizeof() and something
got changed) and you suddenly have clamp(f->u8_m, LO, 0).
It is all just so fragile.

Maybe you are trying to find the 'chunk size' for a transfer of some kind.
If the transfer size is 'small' it might be in a 'u32', you want to limit it
to the size of the hardware's PCIe window - so do:
	copy_size =3D min(transfer_size, hardware_window_size);
But the hardware_window_size is a size_t (so 64bit).
The old min() would complain about the type mismatch, since the
hardware_window_size might actually be 4GB (that is true) casting to u32
is broken - you have to use the larger type.
But it might be the other way around, transfer_size is u64 and
hardware_window_size is u32, you still have to cast to u64 - but this
time it is the size of the other parameter.
The trouble is people have a habit of using the type they want for the
result, u32 in both the above and wrong twice.
But it was only the type check in min() that caused a problem.
Without the casts the compiler generates the right code, the only problem
is when a signed variable might contain a negative value that gets promoted
to a large negative value.
The current implementations of min/max/clamp only generate an error if they
can't prove that negative values won't be promoted to large unsigned values.

This is all fine provided the variable/expressions have the correct type
for the value they contain - and they usually do.
But for this bpf code the type of 'var32_off.value | (var32_off.mask & S32_=
MIN)'
is actually u64, it really does need an explicit cast to s32.

	David

>=20
> > I've already fixed clamp() so it doesn't complain about comparing s64 a=
gainst s32.
> > The next stage is to change pretty much all the xxx_t() to plain xxx().=
 =20
>=20
> Nack to that. Fix the problem. Not the symptom.


