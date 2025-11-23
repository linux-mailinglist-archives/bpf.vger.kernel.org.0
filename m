Return-Path: <bpf+bounces-75302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA406C7E450
	for <lists+bpf@lfdr.de>; Sun, 23 Nov 2025 17:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6A063477CB
	for <lists+bpf@lfdr.de>; Sun, 23 Nov 2025 16:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA17223184F;
	Sun, 23 Nov 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcEE0WRB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB1F4A35
	for <bpf@vger.kernel.org>; Sun, 23 Nov 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763916006; cv=none; b=TOQP7U4lNvRYwZu9utbVtBsqTkieoV++1OggDodV5Lidgi7iTE9atGcbt+HSPCv+yt/HDzx2WJvsLpAKUPCt7/ONY019q3sg+RIW8u4suGw6YfwRcKaF5/yeZ9SuwpF8SSVeiMaJ9Bd+bE7P00qjbdJoJAwmA9pYxCVDr6G04fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763916006; c=relaxed/simple;
	bh=no7l8Yi2tlbVAwhav6s66YfJRPLxzlttnJDFOFZ2RNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFGwn9DUgYBb2mAqTkGdmfFtTXiEiQxTAZ6rkneGvEkCrBzVQcNYJGwc7P3AH3fHi2wZzQeFhswPYhjhzRWgs7hql2ZALCVZpQNYrdMi40xgd7++i3N2JbX/9+K5cNHupnfALRykg0ybiB6pXkE2dMfeIerR4GLGoW9aTnvnhRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcEE0WRB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b387483bbso2574968f8f.1
        for <bpf@vger.kernel.org>; Sun, 23 Nov 2025 08:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763916003; x=1764520803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlXDyenhz16zbnpxR255JR3Ue4Ne5g74wGgyhkrzmws=;
        b=FcEE0WRBWJiacw59MlYmI9/fEOp2mdnPv5MlJ2Hfzpph15AIYG61VgONU/US7Tztxt
         zoFqqkul1YL2bRigTZumwV4dvBt7cXopHtsi2bAg7LT3iAfe1zof2/gbtu91DMy6sSVF
         aakeZxf886BN6Zeyn/AZv8C7y4+6kzquxbSIyHpVFgHFHnx1R3hub6PLJ8KWhLhYYdZb
         a22KIBEbtbUMGs5B3uUvTlTRMcQ31ufyhMlscKXIuc2nFqKs710bOqrs1NYOEqxgof5Z
         AGWV9Ao6F0ecaDZYKpsi4pwFRH5eRKNU7SdubxX1ca4DTqXnKFfCpgg1CwOvMH4HUDhu
         oJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763916003; x=1764520803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hlXDyenhz16zbnpxR255JR3Ue4Ne5g74wGgyhkrzmws=;
        b=JAT+x3kPUVMKtpj8ZrG2SplQd66TR/KqJto+Y5C/WC321P86dmY5nFVGdmidjscneL
         3GdM2wgpTfAAq+zKQHLzNkX3IZfXFfkcbqb6LigO3jb472pbneGs8+59sZP+YElCOm99
         mNlkDVgs+++qs1+0T00UB2H05zPH3hDTqhMLmsfF0TP5H9x9/BTsmMKi58tkcQ2sJ7XJ
         3Hv1JKSbCXY4dEl37/LHH7lhA/GSAW0X5zJU9D9zQP7capZVhdaGdDsQpYDTigXDrYCD
         rNJgxtgW+TSkzJeakJ8bmj6YVDM3dk2NzgSHY9w6UAIg/uLm3NGACd1NA4wohdlLDcNr
         xEPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo0o2Gfix7jBkhPBfeTJb6lUuTJnM5AnE9ZusT2bJEcsDsMv3y8pDGw9A5cq6hX5k+uQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYNjGAzxH6+2p18jSVnTAtvcC/K5e1jZQNMTja+X+bQ4Tg59bx
	LDawq/yB5W1DvuCXqU6ZrNi1SCXSqxScPfs1NNYkgKH6OROCP2wBMYWlmHV9vM1A+PZUkHp4JA1
	A+3gA/Wm04fZkb6aYJYKV3/QPD8q6yE0=
X-Gm-Gg: ASbGncs148BAsfRsLE+0ReBC6Q9BWROg/d8T1pVydFq7N6F816dF9EvsNbAiTn8favM
	SMpbpJFJITALZFeK66H9ljJNlN3FTYDQJsupZC+MN4xPnxAmgz9X2MgCp14eZP/u7lu5h0cQV8k
	JBy6ZNhFvHFvGFGdZj9OE/eNpFnBIrsUmt8ifCt4Rw3hIAKIUTTGjbRJCBm2pue/yVYDl9NnL7H
	Bl2SagPBJZv9l4V3MbhdBJngbakiuZN5a7QspyGypp0T4ndRUwUHihSbKyEBn8ELF3oOosl/Isk
	XHGchCMeCE9q0H7uMs5bmyK/N8ZzX2ye/5LOj2s=
X-Google-Smtp-Source: AGHT+IFcfVjrlRGxbHe/ozlbAJVNFvyc0PKaIb6PyayWLZq50H8THtXwOaZA6WVxf+op6cM/0YuzB7hyT89MlbylB5U=
X-Received: by 2002:a05:6000:240b:b0:42b:43b4:2870 with SMTP id
 ffacd0b85a97d-42cc1d0897cmr9310986f8f.26.1763916002668; Sun, 23 Nov 2025
 08:40:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-7-david.laight.linux@gmail.com> <CAADnVQKFPpzbcakNmq2RkYQvm1TsdgO73UNuoaa_F8SCm6suNw@mail.gmail.com>
 <20251121222151.7056c4fa@pumpkin>
In-Reply-To: <20251121222151.7056c4fa@pumpkin>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 23 Nov 2025 08:39:51 -0800
X-Gm-Features: AWmQ_blnW1Rk3uvG4uJ5xUGQEXNyDgnVY-aUXHGbav0k1QzCw-4ktvUcAYZZCf4
Message-ID: <CAADnVQJFxWParvYg9_YZaD7HFFPW6yzStm7e1nKgdMQ+UYUtqw@mail.gmail.com>
Subject: Re: [PATCH 06/44] bpf: Verifier, remove some unusual uses of min_t()
 and max_t()
To: David Laight <david.laight.linux@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 2:21=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 21 Nov 2025 13:40:36 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Wed, Nov 19, 2025 at 2:42=E2=80=AFPM <david.laight.linux@gmail.com> =
wrote:
> > >
> > > From: David Laight <david.laight.linux@gmail.com>
> > >
> > > min_t() and max_t() are normally used to change the signedness
> > > of a positive value to avoid a signed-v-unsigned compare warning.
> > >
> > > However they are used here to convert an unsigned 64bit pattern
> > > to a signed to a 32/64bit signed number.
> > > To avoid any confusion use plain min()/max() and explicitely cast
> > > the u64 expression to the correct signed value.
> > >
> > > Use a simple max() for the max_pkt_offset calulation and delete the
> > > comment about why the cast to u32 is safe.
> > >
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 29 +++++++++++------------------
> > >  1 file changed, 11 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index ff40e5e65c43..22fa9769fbdb 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -2319,12 +2319,12 @@ static void __update_reg32_bounds(struct bpf_=
reg_state *reg)
> > >         struct tnum var32_off =3D tnum_subreg(reg->var_off);
> > >
> > >         /* min signed is max(sign bit) | min(other bits) */
> > > -       reg->s32_min_value =3D max_t(s32, reg->s32_min_value,
> > > -                       var32_off.value | (var32_off.mask & S32_MIN))=
;
> > > +       reg->s32_min_value =3D max(reg->s32_min_value,
> > > +                       (s32)(var32_off.value | (var32_off.mask & S32=
_MIN)));
> > >         /* max signed is min(sign bit) | max(other bits) */
> > > -       reg->s32_max_value =3D min_t(s32, reg->s32_max_value,
> > > -                       var32_off.value | (var32_off.mask & S32_MAX))=
;
> > > -       reg->u32_min_value =3D max_t(u32, reg->u32_min_value, (u32)va=
r32_off.value);
> > > +       reg->s32_max_value =3D min(reg->s32_max_value,
> > > +                       (s32)(var32_off.value | (var32_off.mask & S32=
_MAX)));
> >
> > Nack.
> > This is plain ugly for no good reason.
> > Leave the code as-is.
>
> It is really horrid before.
> From what i remember var32_off.value (and .mask) are both u64.
> The pattern actually patches that used a few lines down the file.
>
> I've been trying to build allmodconfig with the size test added to min_t(=
)
> and max_t().
> The number of real (or potentially real) bugs I've found is stunning.
> The only fix is to nuke min_t() and max_t() to they can't be used.

No. min_t() is going to stay. It's not broken and
this crusade against it is inappropriate.

> The basic problem is the people have used the type of the target not that
> of the largest parameter.
> The might be ok for ulong v uint (on 64bit), but there are plenty of plac=
es
> where u16 and u8 are used - a lot are pretty much buggy.
>
> Perhaps the worst ones I've found are with clamp_t(),
> this is from 2/44:
> -               (raw_inode)->xtime =3D cpu_to_le32(clamp_t(int32_t, (ts).=
tv_sec, S32_MIN, S32_MAX));      \
> +               (raw_inode)->xtime =3D cpu_to_le32(clamp((ts).tv_sec, S32=
_MIN, S32_MAX)); \
> If also found clamp_t(u8, xxx, 0, 255).
>
> There are just so many broken examples.

clamp_t(u8, xxx, 0, 255) is not wrong. It's silly, but
it's doing the right thing and one can argue and explicit
clamp values serve as a documentation.
clamp_t(int32_t, (ts).tv_sec, S32_MIN, S32_MAX)) is indeed incorrect,
but it's a bug in the implementation of __clamp_once().
Fix it, instead of spamming people with "_t" removal.

