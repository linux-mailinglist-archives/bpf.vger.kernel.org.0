Return-Path: <bpf+bounces-75261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 568D9C7BD9A
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 23:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0662D381146
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 22:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675302F3617;
	Fri, 21 Nov 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg7o7pLr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122A30AD09
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763718; cv=none; b=jysqsAsaJgKIQDZl5SsebvYYzhIlQpmlk7z9lNUOBshdP4+MBbeKL8WLrudx3Lm1201c6s/i3pL+IluN0exdiCOmLJxBfq+y5n/3ST0ODmhANrJoi+3hJNrC7FpC0u4PjNt0dKWWJvz6RNQI8Iiyew8DJU0My0pD5YBlpRXn5J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763718; c=relaxed/simple;
	bh=3mbP4oJdEUwqMn1arQ0PSlVAjMxz6nq0gDpKZ/8yC18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZIVUauyvHyDXHkRve2Get2HW3/p60b74rUQtWFo6K09dmk9zfbeJwpcN4lIYvC+mE7VRgVhZ7er7f08x0jDjAIw/Yi0fr9yotHfi4gGWPSY8u6AI35ssqjCsRwK5Q1mnQl6rHPx/rs0QVgz8BbiKZwGlOY/BwbNI/tp77q4smE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg7o7pLr; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso1050920f8f.0
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 14:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763763714; x=1764368514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+9ZuFI1JtdjyJq6hwdeVp2Tnba9rAmSqaxmJ5MGXJg=;
        b=Yg7o7pLreDP/mhuLoA9qPdAK80O3iThcBF/gi1PrVfIQM6p4TjlQhvRW2zgQm3MDuG
         Qk5L/KDzdPs93hpMdjsQue7HsZLDa4NbMIA7wOK5o0UVhC78kUp1hu+thyeczyshTHBj
         982KS5FzcySetUchH+aEE0X37tXrZuDoqOYFEbsclut5dcg3MCwQnL10Wjjaz7tmTj8G
         ntaC/MxpXGQ7edvFeUFW+7Tl2W5/DGDJ+mBIWv9ggjDtsN+1S8tPohod2zyrFDfsQXdd
         JmKIFDkGPxwtVqEUasx2jTrdbJbdZph0b+My7OIMi2qxrO9jQ3n4HtV+iSgKe5d9pXrI
         Nxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763763714; x=1764368514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m+9ZuFI1JtdjyJq6hwdeVp2Tnba9rAmSqaxmJ5MGXJg=;
        b=m99YbBD6I5hk9JkdnmrRQONzVtVpprGhOZWxH1668XK1G8qt7hdq9pdh6FhrmZLpbO
         JwAQQAzvRpJbHdIrEfYlOF8r6PyTeE+Fjcc+9quydzl1RFp1XIOg7AgdoEQ90qPeQCS6
         cpdeEjh5+HQLJn3lyxslX9yares6K2UvccBvDrn50kdyYiw69EszCz9gZBK9V5RHwY2G
         wFEsre5bsfyVEZZAXjaFWhOh2QvPzYTfm6awxkj4/Ej41TOKYUyPlnq640H0s/LqedeU
         EAZBU1Ffml053D0mgOrBuSNslxPhTA7SvbidNZr5NTAh0TvN8BKD737UivjJWtRIJKBg
         cCRA==
X-Forwarded-Encrypted: i=1; AJvYcCX2Xh2bizy0xC6aEgmRobzzoTuuTEBifaojwfNVgEkMf/Rg8BS0R0F+/QU9MN9sb0NI8L0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34KKwDRxeOECKgNR2lhHXKYKMb1uI9uq50aImSWpgDWhwHI4B
	bEFOLRc8ZVflPbLe4npMej3LeditiQ60baVqin1mRtp7esOopElkmQuyRG/6nw==
X-Gm-Gg: ASbGncvUUIFchrIxsZMq7Z8m6Wsb1AvlRQdOT2CaYbylvIg7ot6uvu+9rbE7p8ZiysY
	X6I/d9VKdJKyvpZ7p9kl36JPf9e085WVakH35rwrJYGts1eCUs5qc2ZxNGrhfkA6srIveCjE0fZ
	4zoaYM628UB+5iR52WzNMEO2sVaKxOsGRC5/x3g44pd5R28gYgL7KcmxchkeRdc6hVVjy+MT/ML
	q05K5yZviAk9u67zeW3FHSTS36Laiasr52LxY8E0DVzzoTflflPpWjAYQOvXaYZ7CAJW8vdskCX
	qxovRJID8nC2cHf9fS9xQqdlTOdXEFh1D3dWNsBZH59fm5QotkssPEpNz56Vifq9HUxO2LOHtwD
	mXNHfG6rCbVAoNT38bx2V4J1EdWYuHxWoN7lLpDQjBR5TKHW3y49DNKcvHLYBLC73LfeOyW27Zx
	e5C7NKzjp3dVrN4ofUQSJ1Tm69E1gnatn3Q1QSVeGaf17rbeBBC2AE
X-Google-Smtp-Source: AGHT+IGd6rMg3zzv9HBTrZB1Yxi0Hawm3D5oRHAYi+F3tGVuQ0Hom334ujQBjZSLME0pvZtm8O722w==
X-Received: by 2002:a05:6000:184d:b0:429:d66b:508f with SMTP id ffacd0b85a97d-42cc1d0cf29mr3643189f8f.30.1763763713643;
        Fri, 21 Nov 2025 14:21:53 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34ff3sm13948627f8f.16.2025.11.21.14.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 14:21:53 -0800 (PST)
Date: Fri, 21 Nov 2025 22:21:51 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 06/44] bpf: Verifier, remove some unusual uses of
 min_t() and max_t()
Message-ID: <20251121222151.7056c4fa@pumpkin>
In-Reply-To: <CAADnVQKFPpzbcakNmq2RkYQvm1TsdgO73UNuoaa_F8SCm6suNw@mail.gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
	<20251119224140.8616-7-david.laight.linux@gmail.com>
	<CAADnVQKFPpzbcakNmq2RkYQvm1TsdgO73UNuoaa_F8SCm6suNw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Nov 2025 13:40:36 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Nov 19, 2025 at 2:42=E2=80=AFPM <david.laight.linux@gmail.com> wr=
ote:
> >
> > From: David Laight <david.laight.linux@gmail.com>
> >
> > min_t() and max_t() are normally used to change the signedness
> > of a positive value to avoid a signed-v-unsigned compare warning.
> >
> > However they are used here to convert an unsigned 64bit pattern
> > to a signed to a 32/64bit signed number.
> > To avoid any confusion use plain min()/max() and explicitely cast
> > the u64 expression to the correct signed value.
> >
> > Use a simple max() for the max_pkt_offset calulation and delete the
> > comment about why the cast to u32 is safe.
> >
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 29 +++++++++++------------------
> >  1 file changed, 11 insertions(+), 18 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index ff40e5e65c43..22fa9769fbdb 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2319,12 +2319,12 @@ static void __update_reg32_bounds(struct bpf_re=
g_state *reg)
> >         struct tnum var32_off =3D tnum_subreg(reg->var_off);
> >
> >         /* min signed is max(sign bit) | min(other bits) */
> > -       reg->s32_min_value =3D max_t(s32, reg->s32_min_value,
> > -                       var32_off.value | (var32_off.mask & S32_MIN));
> > +       reg->s32_min_value =3D max(reg->s32_min_value,
> > +                       (s32)(var32_off.value | (var32_off.mask & S32_M=
IN)));
> >         /* max signed is min(sign bit) | max(other bits) */
> > -       reg->s32_max_value =3D min_t(s32, reg->s32_max_value,
> > -                       var32_off.value | (var32_off.mask & S32_MAX));
> > -       reg->u32_min_value =3D max_t(u32, reg->u32_min_value, (u32)var3=
2_off.value);
> > +       reg->s32_max_value =3D min(reg->s32_max_value,
> > +                       (s32)(var32_off.value | (var32_off.mask & S32_M=
AX))); =20
>=20
> Nack.
> This is plain ugly for no good reason.
> Leave the code as-is.

It is really horrid before.
=46rom what i remember var32_off.value (and .mask) are both u64.
The pattern actually patches that used a few lines down the file.

I've been trying to build allmodconfig with the size test added to min_t()
and max_t().
The number of real (or potentially real) bugs I've found is stunning.
The only fix is to nuke min_t() and max_t() to they can't be used.

The basic problem is the people have used the type of the target not that
of the largest parameter.
The might be ok for ulong v uint (on 64bit), but there are plenty of places
where u16 and u8 are used - a lot are pretty much buggy.

Perhaps the worst ones I've found are with clamp_t(),
this is from 2/44:
-		(raw_inode)->xtime =3D cpu_to_le32(clamp_t(int32_t, (ts).tv_sec, S32_MIN=
, S32_MAX));	\
+		(raw_inode)->xtime =3D cpu_to_le32(clamp((ts).tv_sec, S32_MIN, S32_MAX))=
;	\
If also found clamp_t(u8, xxx, 0, 255).

There are just so many broken examples.

	David




>=20
> pw-bot: cr


