Return-Path: <bpf+bounces-75304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613A6C7E65A
	for <lists+bpf@lfdr.de>; Sun, 23 Nov 2025 20:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD7C3A7DD4
	for <lists+bpf@lfdr.de>; Sun, 23 Nov 2025 19:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8318F23D7EC;
	Sun, 23 Nov 2025 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ffn3s/R8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333031D618E
	for <bpf@vger.kernel.org>; Sun, 23 Nov 2025 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763925619; cv=none; b=UO18soKUWcrrswOEM79Be+HF7gzU2Ccd+xSn0UGgqGWQYqdKL534W3JkIvwhTE0+NmChscwL1gTcurIgn7bbATPg50505wOV2ZYbmnGFNOWTa3FOB7lZsxJAg1NsN39S46R7ULxVCvoNHeNs4fsO60VzgqeL7YcWF3bOrZy2hQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763925619; c=relaxed/simple;
	bh=8ifEKeaxW225FJkZRygSWZAYGA5Ah1PPTeZY+KtvZKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsCSkbAHULw2bv9U3ArKoKxWy0Q2Kt9Yv3QcEOkAkOLpP+MsbjGj4n4Vy8uHDGg5y0OK2ZKZaCfPb6r/XT5TwhOxgun4/h9j/+jshk1P6GNpckJzvqhdeeeHAP+llD0mmGa+5N9pLxu00Q5HhyhLDf/hxh2u1baDaFxhuNMbxJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ffn3s/R8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c8632fcbso2174409f8f.1
        for <bpf@vger.kernel.org>; Sun, 23 Nov 2025 11:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763925615; x=1764530415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVMex6lt89lAYPKAAWkSdAEGvWChhx8HQIgJ9oPRay4=;
        b=Ffn3s/R8KAsTSbYJYKE+nPBtWouimK14mKORBMR+u1uDQWYVVBqtWmXiSN5rlcgNM3
         39Owctt6MDzmdRMb48oZlqTzqgZgJcJVh1lt0pOixldmoDEbGSmBjLWk4XjFdhPDwqCC
         irAzesiwbvYFN0svYcqv5YR1hHWirck+u9FZNt5JSX5ChzvsFym//H6GDymzJA8MQ8bK
         OyUR6N0KAOWoYioUeaiv8I1xiEc2cF982sRKAT0zx6FivucSIsWtnW1PFxcnF1EB/814
         McsxFwdYOsppJH8z99OIfuw5wS1zGrnoHPV3Q9sjU6QBhZ/K3G3gQTrvElaX8d1oaFvD
         fWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763925615; x=1764530415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lVMex6lt89lAYPKAAWkSdAEGvWChhx8HQIgJ9oPRay4=;
        b=XyQv4wA4np2QXsI0IeUyQP0XLjw+Up8JoRo0JkkrrEyC8P55sQV71djhsEtYGLd9V9
         /HaIrb4vvEPikk3B4M3TRt9Ov53GHMxEkxQvQBO7Nsuazm0JO7U2HcrvaKs4k3qr0ikr
         xO+0MMP8s+bnP48xhZdro4jUi6YDuRE3M1A5jD73pOAL0GwSMoAHLztLqrmuWq/Un8in
         JR3DYxgAM0VIeFEMO6uegLR04xLY/cDGoePPfssiDHnB8gdZnkK//+gi10DUrqT8LR6S
         zVb6dSkWqBcuWBavTu1QRh01KktEpCaczE9UIdFVDCEQ+S+gc1yur2wQU7rLM5StFIlk
         gsjA==
X-Forwarded-Encrypted: i=1; AJvYcCVTXidXxjTpbWUl8pPcZu1mlrJWlLddndaUhCkrQo3b5WRaolSZ6CqU90tNYCWoLgHDFXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhGDVrNKXuas5F18ydFryvQLuacXSGn6SbjCbtXYleTThg2vr
	jp1zZg9/fPlJkvOYPUc65gi0AO3xGoJG1o1B5ZqbpmoGbsMRcImHfs5hgMe7F99lWE4GZ73wDw/
	LlFHb9TvAbjk4ZbDc2poQ++n5Zl+qGSI=
X-Gm-Gg: ASbGncsf//CLB+KXuqbu6KPKPB/Pj0i8XNnv7vCuvR0T1sls8hfCoQgPnBX+1IFxEeB
	IA595kB9hyQvN/wZ8T+3qw8WLEAafXPf0pJ0W1PKw/LkR1QJsPwFETcQIeLr2s1krAfKTo3lYfq
	tcRKVtiLNX7Vt6dhYNNqkaf1+lkEZFFjqh1fvhW4L0tWXZiU6DkN0HYZzpuu7ZOv8vaQqajYPy6
	nfG6yp6tgsWJ20pGkysBZ9vUUCMaLT5cE66GNCeeekLlWmO3JsioPd2xitprRMcAevgrTezLy4d
	d1l+2V89r6SvMCsvBbxraLZMPU+8PoGv53fT3Bo=
X-Google-Smtp-Source: AGHT+IHcWJqn6QXxxRbNfvEbKOmatXFRsHGLcW8a6LFBw/NoZk7Vq2TrVPp05H0z3mLw5t5HIoEyDNgw0EC7U3l3a3s=
X-Received: by 2002:a05:6000:2584:b0:42b:2a09:2e59 with SMTP id
 ffacd0b85a97d-42cc19f0942mr10245175f8f.0.1763925615208; Sun, 23 Nov 2025
 11:20:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-7-david.laight.linux@gmail.com> <CAADnVQKFPpzbcakNmq2RkYQvm1TsdgO73UNuoaa_F8SCm6suNw@mail.gmail.com>
 <20251121222151.7056c4fa@pumpkin> <CAADnVQJFxWParvYg9_YZaD7HFFPW6yzStm7e1nKgdMQ+UYUtqw@mail.gmail.com>
 <20251123180741.65cd2dd3@pumpkin>
In-Reply-To: <20251123180741.65cd2dd3@pumpkin>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 23 Nov 2025 11:20:03 -0800
X-Gm-Features: AWmQ_bnlE0-0HwnB1J5yU2fZO_3gR73FWrRdOUESjOeNUB0cj2s9Ac6hGJ8gr9Q
Message-ID: <CAADnVQL95nwYGYO0jNGR2Pt3ApJa31LsD7y7sbLMtVDyvWJWZA@mail.gmail.com>
Subject: Re: [PATCH 06/44] bpf: Verifier, remove some unusual uses of min_t()
 and max_t()
To: David Laight <david.laight.linux@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 10:07=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sun, 23 Nov 2025 08:39:51 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Fri, Nov 21, 2025 at 2:21=E2=80=AFPM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Fri, 21 Nov 2025 13:40:36 -0800
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > >
> > > > On Wed, Nov 19, 2025 at 2:42=E2=80=AFPM <david.laight.linux@gmail.c=
om> wrote:
> > > > >
> > > > > From: David Laight <david.laight.linux@gmail.com>
> > > > >
> > > > > min_t() and max_t() are normally used to change the signedness
> > > > > of a positive value to avoid a signed-v-unsigned compare warning.
> > > > >
> > > > > However they are used here to convert an unsigned 64bit pattern
> > > > > to a signed to a 32/64bit signed number.
> > > > > To avoid any confusion use plain min()/max() and explicitely cast
> > > > > the u64 expression to the correct signed value.
> > > > >
> > > > > Use a simple max() for the max_pkt_offset calulation and delete t=
he
> > > > > comment about why the cast to u32 is safe.
> > > > >
> > > > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > > > ---
> > > > >  kernel/bpf/verifier.c | 29 +++++++++++------------------
> > > > >  1 file changed, 11 insertions(+), 18 deletions(-)
> > > > >
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index ff40e5e65c43..22fa9769fbdb 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -2319,12 +2319,12 @@ static void __update_reg32_bounds(struct =
bpf_reg_state *reg)
> > > > >         struct tnum var32_off =3D tnum_subreg(reg->var_off);
> > > > >
> > > > >         /* min signed is max(sign bit) | min(other bits) */
> > > > > -       reg->s32_min_value =3D max_t(s32, reg->s32_min_value,
> > > > > -                       var32_off.value | (var32_off.mask & S32_M=
IN));
> > > > > +       reg->s32_min_value =3D max(reg->s32_min_value,
> > > > > +                       (s32)(var32_off.value | (var32_off.mask &=
 S32_MIN)));
> > > > >         /* max signed is min(sign bit) | max(other bits) */
> > > > > -       reg->s32_max_value =3D min_t(s32, reg->s32_max_value,
> > > > > -                       var32_off.value | (var32_off.mask & S32_M=
AX));
> > > > > -       reg->u32_min_value =3D max_t(u32, reg->u32_min_value, (u3=
2)var32_off.value);
> > > > > +       reg->s32_max_value =3D min(reg->s32_max_value,
> > > > > +                       (s32)(var32_off.value | (var32_off.mask &=
 S32_MAX)));
> > > >
> > > > Nack.
> > > > This is plain ugly for no good reason.
> > > > Leave the code as-is.
> > >
> > > It is really horrid before.
> > > From what i remember var32_off.value (and .mask) are both u64.
> > > The pattern actually patches that used a few lines down the file.
> > >
> > > I've been trying to build allmodconfig with the size test added to mi=
n_t()
> > > and max_t().
> > > The number of real (or potentially real) bugs I've found is stunning.
> > > The only fix is to nuke min_t() and max_t() to they can't be used.
> >
> > No. min_t() is going to stay. It's not broken and
> > this crusade against it is inappropriate.
>
> I bet to differ...
>
> > > The basic problem is the people have used the type of the target not =
that
> > > of the largest parameter.
> > > The might be ok for ulong v uint (on 64bit), but there are plenty of =
places
> > > where u16 and u8 are used - a lot are pretty much buggy.
> > >
> > > Perhaps the worst ones I've found are with clamp_t(),
> > > this is from 2/44:
> > > -               (raw_inode)->xtime =3D cpu_to_le32(clamp_t(int32_t, (=
ts).tv_sec, S32_MIN, S32_MAX));      \
> > > +               (raw_inode)->xtime =3D cpu_to_le32(clamp((ts).tv_sec,=
 S32_MIN, S32_MAX)); \
> > > If also found clamp_t(u8, xxx, 0, 255).
> > >
> > > There are just so many broken examples.
> >
> > clamp_t(u8, xxx, 0, 255) is not wrong. It's silly, but
> > it's doing the right thing and one can argue and explicit
> > clamp values serve as a documentation.
>
> Not when you look at some of the code that uses it.
> The clear intention is to saturate a large value - which isn't what it do=
es.
>
> > clamp_t(int32_t, (ts).tv_sec, S32_MIN, S32_MAX)) is indeed incorrect,
> > but it's a bug in the implementation of __clamp_once().
> > Fix it, instead of spamming people with "_t" removal.
>
> It is too late by the time you get to clamp_once().
> The 'type' for all the xxx_t() functions is an input cast, not the type
> for the result.
> clamp_t(type, v, lo, hi) has always been clamp((type)v, (type)lo, type(hi=
)).
> From a code correctness point of view you pretty much never want those ca=
sts.

Historical behavior doesn't justify a footgun.
You definitely can make clampt_t() to behave like clamp_val() plus
the final cast.

Also note:
git grep -w clamp_val|wc -l
818
git grep -w clamp_t|wc -l
494

a safer macro is already used more often.

> I've already fixed clamp() so it doesn't complain about comparing s64 aga=
inst s32.
> The next stage is to change pretty much all the xxx_t() to plain xxx().

Nack to that. Fix the problem. Not the symptom.

