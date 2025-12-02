Return-Path: <bpf+bounces-75872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D61C9B3AD
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 11:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 110464E34D0
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 10:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9F630DD1F;
	Tue,  2 Dec 2025 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="P4IU+I2P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609928506B
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764672841; cv=none; b=slWH8puYQfbhrH+Lc5KH8KCBB7dSZzZLas221OxB3OTxE17MXS9HmNwzKn+6AD8KyioiE5BZ+M+LkPuf3EUa5o2Ym0y0plA5Px229I0KHolWf7R8rH0UHGOxKlMJ0vtXJnQuSYxIR6rQAIQ39pB9NBuFQptk0FQ7Zlpr0PoPhRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764672841; c=relaxed/simple;
	bh=kzPjRKrFxCJwZ0QptP/JKur/1ZW6miGYEC6D7MgVokw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYfejA03gAwO8ju9AFNnKfI4ahYsi0xL6faNa82/AGCKLlqcdbU85Af16/DeeARobBFZ1OKaW52wRB2YtsIcUFaXMI+ubKBVWIA6Qk+TxXo6fOoy0Ek7m0UTRyWJ7uKDCiMYV8ihCm3OFdBwghBswtNmBMZ53fqkpxRPg1X3V/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=P4IU+I2P; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59583505988so6792979e87.1
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 02:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1764672837; x=1765277637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW9NjMB8nxFe7q45WwvHBBBncnM13/ZvpsYHaclBc9A=;
        b=P4IU+I2P0Rs3rXlme/njWaI1u7o65FMxKuiPjMXsjOlOHEnuNrlpiVohWMiDYzLjko
         Ygikr35F3fZwKScKZYRcdH0Em0HC+h1Qm0Vj6P90TWVMKuO0EDPJBLxy9lx89Y+00Wb0
         Qen5nmFX9dc/cO4IEtId0S0jrw2i/XVqa0GCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764672837; x=1765277637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DW9NjMB8nxFe7q45WwvHBBBncnM13/ZvpsYHaclBc9A=;
        b=q9IZ2pFT5aVTCLa7o0yIJR+C7/F0kHYAq6ZguzvtMTEUpRuJU1F81xmM1OruB9+9wg
         jyG1gSejPrXh0Lb6ALPvgipkRMlSvfxk9Z/T1cdLnyt21ihFmbpi2NrnDtUG86VPSbpF
         0uJbloUkV+SUxu3Z2IC7izh97PNifIyq3FWpo2nVBZhiqy5z2hl/bfji00kqxV+ENGG6
         P/CRStZwQAZCw3e6gIeIkFoT59a2/N8RGoZ3uSTw1SecA2krfTgh6U24VmLwidpoBbUp
         DI5HhKz0ll8Gd5+ee7tTlsWtogesWrzCM83NUbw1gPLepQdm7DyyYJwPAL7IoJPb7z8f
         u1JQ==
X-Gm-Message-State: AOJu0YwBGQ/hDQmdWOIG6HlHwD72ILgvT9Ogsu0TfyhHtzgIVuLw2i4A
	wKOAt7M+1bfa8jqIiOUPkChGI/sQzHfTt9LvwnHDaprQOIXxG/Nis3ieA2AngK2X029pfKwam/x
	gHA1jANXSCHpvt4XmU9JWMpjoc/dlNaqjsVsbGShDDw==
X-Gm-Gg: ASbGnctQK0qO03G2nb3MOCgWc8b7qadhCZP5Mr7XleIRY6Dt+Ti808ijeEGpTnhmL5x
	8hguMF3JNtPHO2i174gfkLQ7RAI/2R9FQ5kBCllq5Cil1k/bWbBT5r74SeLGHM7FT8KsDx7bhaQ
	vSvJE1nF474q4sQqR6pHOZiBxGlNePnSyEOzNhlQ7rSEje+k3SXMcv8h4NT7DqxDwd55HgDhQGC
	HMEo2XR8oF0geWIymgknh4PxJLhWVzAenJC8bj9DAALpRlz716QsPnD+e+uPobixUlC9Jnecmya
	PiGmGoU=
X-Google-Smtp-Source: AGHT+IEqHxG+QeVtey8UkpPxSV5j1H44OBS27vCvhjZrMF5iWilIWgu6GrWrKF7xrWdNwj+AftXkeuHdDCTaUCszcQ8=
X-Received: by 2002:a05:6512:1081:b0:594:27de:77e7 with SMTP id
 2adb3069b0e04-597cfb0430dmr783607e87.15.1764672836640; Tue, 02 Dec 2025
 02:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125125634.2671-1-dimitar.kanaliev@siteground.com>
 <20251125125634.2671-3-dimitar.kanaliev@siteground.com> <cad6577291b778e6caad2f06fae304b2ec07f752.camel@gmail.com>
In-Reply-To: <cad6577291b778e6caad2f06fae304b2ec07f752.camel@gmail.com>
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Date: Tue, 2 Dec 2025 12:53:45 +0200
X-Gm-Features: AWmQ_bk7aKlIm5nWLtu_SZEEbaj21oywY7HKS5aHLPy8TUM4srnVLGy2cQqcTws
Message-ID: <CAHx3w9JOXv-p_LeTiS9Z=C+wvPn-PAbm6u-i8a3jnSTTqJo3eg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] bpf: verifier: Simplify register sign extension
 with tnum_scast
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 1:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-11-25 at 14:56 +0200, Dimitar Kanaliev wrote:
>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 766695491bc5..c9a6bf85b4ad 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6876,147 +6876,57 @@ static void coerce_reg_to_size(struct bpf_reg_=
state *reg, int size)
> >       reg_bounds_sync(reg);
> >  }
> >
> > -static void set_sext64_default_val(struct bpf_reg_state *reg, int size=
)
> > -{
> > -     if (size =3D=3D 1) {
> > -             reg->smin_value =3D reg->s32_min_value =3D S8_MIN;
> > -             reg->smax_value =3D reg->s32_max_value =3D S8_MAX;
> > -     } else if (size =3D=3D 2) {
> > -             reg->smin_value =3D reg->s32_min_value =3D S16_MIN;
> > -             reg->smax_value =3D reg->s32_max_value =3D S16_MAX;
> > -     } else {
> > -             /* size =3D=3D 4 */
> > -             reg->smin_value =3D reg->s32_min_value =3D S32_MIN;
> > -             reg->smax_value =3D reg->s32_max_value =3D S32_MAX;
> > -     }
> > -     reg->umin_value =3D reg->u32_min_value =3D 0;
> > -     reg->umax_value =3D U64_MAX;
> > -     reg->u32_max_value =3D U32_MAX;
> > -     reg->var_off =3D tnum_unknown;
> > -}
> > -
> >  static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
> >  {
> > -     s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
> > -     u64 top_smax_value, top_smin_value;
> > -     u64 num_bits =3D size * 8;
> > +     s64 smin_value, smax_value;
> >
> > -     if (tnum_is_const(reg->var_off)) {
> > -             u64_cval =3D reg->var_off.value;
> > -             if (size =3D=3D 1)
> > -                     reg->var_off =3D tnum_const((s8)u64_cval);
> > -             else if (size =3D=3D 2)
> > -                     reg->var_off =3D tnum_const((s16)u64_cval);
> > -             else
> > -                     /* size =3D=3D 4 */
> > -                     reg->var_off =3D tnum_const((s32)u64_cval);
> > -
> > -             u64_cval =3D reg->var_off.value;
> > -             reg->smax_value =3D reg->smin_value =3D u64_cval;
> > -             reg->umax_value =3D reg->umin_value =3D u64_cval;
> > -             reg->s32_max_value =3D reg->s32_min_value =3D u64_cval;
> > -             reg->u32_max_value =3D reg->u32_min_value =3D u64_cval;
> > +     if (size >=3D 8)
> >               return;
> > -     }
> >
> > -     top_smax_value =3D ((u64)reg->smax_value >> num_bits) << num_bits=
;
> > -     top_smin_value =3D ((u64)reg->smin_value >> num_bits) << num_bits=
;
> > +     reg->var_off =3D tnum_scast(reg->var_off, size);
> >
> > -     if (top_smax_value !=3D top_smin_value)
> > -             goto out;
> > +     smin_value =3D -(1LL << (size * 8 - 1));
> > +     smax_value =3D (1LL << (size * 8 - 1)) - 1;
> >
> > -     /* find the s64_min and s64_min after sign extension */
> > -     if (size =3D=3D 1) {
> > -             init_s64_max =3D (s8)reg->smax_value;
> > -             init_s64_min =3D (s8)reg->smin_value;
> > -     } else if (size =3D=3D 2) {
> > -             init_s64_max =3D (s16)reg->smax_value;
> > -             init_s64_min =3D (s16)reg->smin_value;
> > -     } else {
> > -             init_s64_max =3D (s32)reg->smax_value;
> > -             init_s64_min =3D (s32)reg->smin_value;
> > -     }
> > -
> > -     s64_max =3D max(init_s64_max, init_s64_min);
> > -     s64_min =3D min(init_s64_max, init_s64_min);
> > +     reg->smin_value =3D smin_value;
> > +     reg->smax_value =3D smax_value;
> >
> > -     /* both of s64_max/s64_min positive or negative */
> > -     if ((s64_max >=3D 0) =3D=3D (s64_min >=3D 0)) {
> > -             reg->s32_min_value =3D reg->smin_value =3D s64_min;
> > -             reg->s32_max_value =3D reg->smax_value =3D s64_max;
> > -             reg->u32_min_value =3D reg->umin_value =3D s64_min;
> > -             reg->u32_max_value =3D reg->umax_value =3D s64_max;
> > -             reg->var_off =3D tnum_range(s64_min, s64_max);
> > -             return;
> > -     }
> > +     reg->s32_min_value =3D (s32)smin_value;
> > +     reg->s32_max_value =3D (s32)smax_value;
> >
> > -out:
> > -     set_sext64_default_val(reg, size);
> > -}
>
> Assume that size =3D=3D 1, s64_min =3D 0b000, s64_max =3D=3D 0b100.
> This corresponds to tnum with value =3D=3D 0b000 and mask =3D=3D 0b111.
> Old algorithm computes more precise range in this situation.
> Old:
>
>   0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
>   1: (25) if r0 > 0x4 goto pc+2         ; R0=3Dscalar(smin=3Dsmin32=3D0,s=
max=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7))
>   2: (7b) *(u64 *)(r10 -8) =3D r0         ; R0=3Dscalar(id=3D1,smin=3Dsmi=
n32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7)) ...
>   3: (91) r0 =3D *(s8 *)(r10 -8)          ; R0=3Dscalar(id=3D1,smin=3Dsmi=
n32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7)) ...
>   4: (b7) r0 =3D 0                        ; R0=3D0
>   5: (95) exit
>
> New:
>
>   0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
>   1: (25) if r0 > 0x4 goto pc+2         ; R0=3Dscalar(smin=3Dsmin32=3D0,s=
max=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7))
>   2: (7b) *(u64 *)(r10 -8) =3D r0         ; R0=3Dscalar(id=3D1,smin=3Dsmi=
n32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7)) ...
>   3: (91) r0 =3D *(s8 *)(r10 -8)          ; R0=3Dscalar(id=3D1,smin=3Dsmi=
n32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D7,var_off=3D(0x0; 0x7)) ...
>   4: (b7) r0 =3D 0                        ; R0=3D0
>   5: (95) exit
>
> Note that range for R0 at (3) is 0..4 for old algorithm and 0..7 for
> new algorithm.
>
> Can we keep both algorithms by e.g. replacing set_sext64_default_val()
> implementation with tnum_scast() adding tnum_scast() in
> coerce_reg_to_size_sx()?
>
> In general, for such kinds of patch-sets it is interesting to see how
> much precision is gained/lost with the change. It shouldn't be hard to
> collect such data for e.g. complete s8 range by writing a small
> user-space program that enumerates the s8 x s8 range and applies both
> old an new range computations.
>
> [...]

I was mostly focused on preserving the info from tnum for sparse ranges, so
I kind of forgot about continuous ranges entirely.
As per your suggestion, I plucked out anything relevant from the kernel,
and compared the smax / smin values for the entire -1024,1024 range in a
loop, like so:

  struct bpf_reg_state r_old, r_new;

  init_reg(&r_old, start, end);
  r_new =3D r_old;

  coerce_reg_to_size_sx_old(&r_old, size);
  coerce_reg_to_size_sx_new(&r_new, size);

  s64 range_old =3D r_old.smax_value - r_old.smin_value;
  s64 range_new =3D r_new.smax_value - r_new.smin_value;

  if (range_old < range_new) { ...

In these continous ranges, the old implementation is much better:

  [-1024, 1024]:
  Old Better: 128016
  New Better: 0
  Equal: 1972209

So I endeed up drafting this:

  static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
  {
    s64 smin_value, smax_value;
    u64 num_bits =3D size * 8;
    u64 top_smax_value, top_smin_value;

    reg->var_off =3D tnum_scast(reg->var_off, size);

    top_smax_value =3D ((u64)reg->smax_value >> num_bits) << num_bits;
    top_smin_value =3D ((u64)reg->smin_value >> num_bits) << num_bits;

    if (top_smax_value =3D=3D top_smin_value) {
            if (size =3D=3D 1) {
                smin_value =3D (s8)reg->smin_value;
                smax_value =3D (s8)reg->smax_value;
            } else if (size =3D=3D 2) {
                smin_value =3D (s16)reg->smin_value;
                smax_value =3D (s16)reg->smax_value;
            } else {
                smin_value =3D (s32)reg->smin_value;
                smax_value =3D (s32)reg->smax_value;
            }
        } else {
            smin_value =3D -(1LL << (num_bits - 1));
            smax_value =3D (1LL << (num_bits - 1)) - 1;
        }

        reg->smin_value =3D smin_value;
        reg->smax_value =3D smax_value;

        reg->umin_value =3D 0;
        reg->umax_value =3D U64_MAX;

        reg->s32_min_value =3D (s32)smin_value;
        reg->s32_max_value =3D (s32)smax_value;
        reg->u32_min_value =3D 0;
        reg->u32_max_value =3D U32_MAX;

        __update_reg_bounds(reg);
}

I'm trying to always perform tnum_scast in order to preserve bitwise
info, but attempt to use the old numeric logic first. If the range fits
into the target size, we preserve the existing numeric bounds. If not, we
fall back to the type limits and let __update_reg_bounds reconstruct the
range from var_off. The imeplementation is similar for the subreg variant.

Rerunning the comparison for the same range looks much better, we should be
consistently seeing precision gains in the cases where the original
implementation bails out via goto:

  [-1024, 1024]:
  Old Better: 0
  New Better: 131072
  Equal: 1969153

I also went through the CI, the existing selftest in the series still
covers the change.

wdyt?

