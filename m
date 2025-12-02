Return-Path: <bpf+bounces-75910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9D1C9C886
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 19:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC7423499AE
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 18:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8A42D060B;
	Tue,  2 Dec 2025 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuCrpCiQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED12C324C
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698634; cv=none; b=Ai2QLR88Am2yUlw0MHB6WovgZM8j0/uPc0y9OIexznzClwbdx563sXZjc8Q5sTnOIFQtjNHKgCLACRuZEqeRHNtFQgkdbic3pFtdKWR4CeN8g83M+Jy5yLuSOP5Jj+FuNrsU87BITi3MgKxuyF1T0xfVtb2YY2NabobR9SVGIzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698634; c=relaxed/simple;
	bh=kDvVu0dP1EqrfbA/cz1taWpIeoZsDWPzNFKw2DKRTbA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sMXbMyI2BjFmE8Ead2xeKhZfzyCDgx1vuacJSjoCbIl3ULdKziLgsfibWXkphusBVAeH5WxvRZ4o4iuxy06aZFPR9hKrThumLsBpp9QuQaqRvisSIQ1TKIk1Nmef09L+fC83Bdcica24MVP7k/Qeb9USScZMzc4oOL1PhZw9Nq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuCrpCiQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343ff854297so7598842a91.1
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 10:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764698632; x=1765303432; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LabsOKhQyjKD4tx01JVB9reuouUAx25N0i0FBFz7i7E=;
        b=JuCrpCiQk0bNv6jwOSe8gZkw53KcFlLqUnXaGJcSON6L+7VGJ8pKhJvMZjWO6hYCy1
         RcFxpmGjekAki73c7oL1ifziiTvl7ufTxlan2Ulg4+8uAaYh2ezoMBOKcMCQsjQLz5xf
         mpNLPcN6wvvkMycwV4c1jgnD6ZTOebqq4E2zuu2sGSniThhGDaCpSuCA83T+0JyuBiXZ
         vmcVPozDisV7ak7wMdTKr8FIzHa0NhpuWLUXtl9lcERJLUE8e+bxVVf1lIeKZ5jXXKdJ
         F0l1UVqFanEglghnxdxzUCueF1CJYQuZAZcZp/aC89Dm+j1RrRcZomMUPoA08TXmyY5l
         Os/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698632; x=1765303432;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LabsOKhQyjKD4tx01JVB9reuouUAx25N0i0FBFz7i7E=;
        b=uTk1zdsoDRVxH2uXjPXeizMr71Hv0RDmyreAq3Wb085Dk6Gu/8ooCEUIezZ0Myl7rm
         Y5TkwRct5uNnAZQjB6wXBXKCY9+DiCvBT9CDStOTPIJWpbuYFb+aCD1thFRSiRfdhHYW
         z8Slidm4KfDXN1uEQthHWZfKdeSuHB+csPCyzwIHtIZjD90qW2oIK2Mh3v9B3Qyea5D2
         6cwFUo+NBs06Ok3UZ6o42YaShWZovTU5U5ujwtGhp8RSfi4LNA1diibpsfI9UdK4h/gQ
         lxlSMgdcPVoEVmt6kF/fVg1eMn9SyEKSsTEStmtwLedpN9btQngzkE+WOyZwpr1HzaBg
         6qww==
X-Gm-Message-State: AOJu0Ywvw3wJ96eubQtw7qgwH0Om5kQwGW/kKB+8eJo7DMf1aTnbzAAB
	c+r2xE4iDJTnWxrlhMtQ8WTeGgX0LnAvU8iCE6kAxOyxpDR5Fto65UOp
X-Gm-Gg: ASbGncsUEvYGKjCaGqkGpcw93Ms+OjNHk9s1cnt3bCJMGTEdLmlo01x84fF/6+EL3sn
	ncdoxEPiryQFokTCzoxvPG179efgADyzTQm2oi3Yy3W9aoCCvyUiRUNR9GixSIluMty3s36wL+b
	ndFed/2xnfj8rEFX0fuxPJmbiPplUKOoPJ2+pUK7r4IEKez/Ap6Lh5du9WECW7iY14hiBc5aBm8
	rWcmCyD3g1xmEGgZMrUmkWIY5MNGPD8Z6T5u70pFBeU2H++7Vm2IlMAoiStA38ZqGSMjpRMwR+M
	444PraIgZeLqRR5TxP+0uwhT3K4xOfj7sKfF5rAOlfGLwPdIXN2YY6pfNpNuSxbPLY+mC0nRI/C
	cOs32WHTX20ghytkx1TMzy1BoFTp9KJuJxW/Twp4h5g6Vl1RIHBWUq4vHqM32HaXvNguFTuV+CX
	cQxS3+9BLZns9/dMa1oyrWl2UooRY0m5SgsxKp
X-Google-Smtp-Source: AGHT+IFApUoayHMZIMUKL5MCEmGhXyw+2vhvCQrfs3IWROSZD9OJbL36vBZmMufIHCFrgMZh7KYeSw==
X-Received: by 2002:a17:90b:534f:b0:341:88ba:c6d3 with SMTP id 98e67ed59e1d1-34910825900mr276470a91.23.1764698631653;
        Tue, 02 Dec 2025 10:03:51 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:efc2:226e:efa5:2264? ([2620:10d:c090:500::5:e42b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34910ba58a9sm79899a91.8.2025.12.02.10.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 10:03:51 -0800 (PST)
Message-ID: <f072aed1eb229fe5308bebce64819ecaf3794308.camel@gmail.com>
Subject: Re: [PATCH v1 2/3] bpf: verifier: Simplify register sign extension
 with tnum_scast
From: Eduard Zingerman <eddyz87@gmail.com>
To: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,  Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Tue, 02 Dec 2025 10:03:48 -0800
In-Reply-To: <CAHx3w9JOXv-p_LeTiS9Z=C+wvPn-PAbm6u-i8a3jnSTTqJo3eg@mail.gmail.com>
References: <20251125125634.2671-1-dimitar.kanaliev@siteground.com>
	 <20251125125634.2671-3-dimitar.kanaliev@siteground.com>
	 <cad6577291b778e6caad2f06fae304b2ec07f752.camel@gmail.com>
	 <CAHx3w9JOXv-p_LeTiS9Z=C+wvPn-PAbm6u-i8a3jnSTTqJo3eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-02 at 12:53 +0200, Dimitar Kanaliev wrote:
> On Tue, Dec 2, 2025 at 1:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Tue, 2025-11-25 at 14:56 +0200, Dimitar Kanaliev wrote:
> >=20
> > [...]
> >=20
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 766695491bc5..c9a6bf85b4ad 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -6876,147 +6876,57 @@ static void coerce_reg_to_size(struct bpf_re=
g_state *reg, int size)
> > >       reg_bounds_sync(reg);
> > >  }
> > >=20
> > > -static void set_sext64_default_val(struct bpf_reg_state *reg, int si=
ze)
> > > -{
> > > -     if (size =3D=3D 1) {
> > > -             reg->smin_value =3D reg->s32_min_value =3D S8_MIN;
> > > -             reg->smax_value =3D reg->s32_max_value =3D S8_MAX;
> > > -     } else if (size =3D=3D 2) {
> > > -             reg->smin_value =3D reg->s32_min_value =3D S16_MIN;
> > > -             reg->smax_value =3D reg->s32_max_value =3D S16_MAX;
> > > -     } else {
> > > -             /* size =3D=3D 4 */
> > > -             reg->smin_value =3D reg->s32_min_value =3D S32_MIN;
> > > -             reg->smax_value =3D reg->s32_max_value =3D S32_MAX;
> > > -     }
> > > -     reg->umin_value =3D reg->u32_min_value =3D 0;
> > > -     reg->umax_value =3D U64_MAX;
> > > -     reg->u32_max_value =3D U32_MAX;
> > > -     reg->var_off =3D tnum_unknown;
> > > -}
> > > -
> > >  static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int siz=
e)
> > >  {
> > > -     s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
> > > -     u64 top_smax_value, top_smin_value;
> > > -     u64 num_bits =3D size * 8;
> > > +     s64 smin_value, smax_value;
> > >=20
> > > -     if (tnum_is_const(reg->var_off)) {
> > > -             u64_cval =3D reg->var_off.value;
> > > -             if (size =3D=3D 1)
> > > -                     reg->var_off =3D tnum_const((s8)u64_cval);
> > > -             else if (size =3D=3D 2)
> > > -                     reg->var_off =3D tnum_const((s16)u64_cval);
> > > -             else
> > > -                     /* size =3D=3D 4 */
> > > -                     reg->var_off =3D tnum_const((s32)u64_cval);
> > > -
> > > -             u64_cval =3D reg->var_off.value;
> > > -             reg->smax_value =3D reg->smin_value =3D u64_cval;
> > > -             reg->umax_value =3D reg->umin_value =3D u64_cval;
> > > -             reg->s32_max_value =3D reg->s32_min_value =3D u64_cval;
> > > -             reg->u32_max_value =3D reg->u32_min_value =3D u64_cval;
> > > +     if (size >=3D 8)
> > >               return;
> > > -     }
> > >=20
> > > -     top_smax_value =3D ((u64)reg->smax_value >> num_bits) << num_bi=
ts;
> > > -     top_smin_value =3D ((u64)reg->smin_value >> num_bits) << num_bi=
ts;
> > > +     reg->var_off =3D tnum_scast(reg->var_off, size);
> > >=20
> > > -     if (top_smax_value !=3D top_smin_value)
> > > -             goto out;
> > > +     smin_value =3D -(1LL << (size * 8 - 1));
> > > +     smax_value =3D (1LL << (size * 8 - 1)) - 1;
> > >=20
> > > -     /* find the s64_min and s64_min after sign extension */
> > > -     if (size =3D=3D 1) {
> > > -             init_s64_max =3D (s8)reg->smax_value;
> > > -             init_s64_min =3D (s8)reg->smin_value;
> > > -     } else if (size =3D=3D 2) {
> > > -             init_s64_max =3D (s16)reg->smax_value;
> > > -             init_s64_min =3D (s16)reg->smin_value;
> > > -     } else {
> > > -             init_s64_max =3D (s32)reg->smax_value;
> > > -             init_s64_min =3D (s32)reg->smin_value;
> > > -     }
> > > -
> > > -     s64_max =3D max(init_s64_max, init_s64_min);
> > > -     s64_min =3D min(init_s64_max, init_s64_min);
> > > +     reg->smin_value =3D smin_value;
> > > +     reg->smax_value =3D smax_value;
> > >=20
> > > -     /* both of s64_max/s64_min positive or negative */
> > > -     if ((s64_max >=3D 0) =3D=3D (s64_min >=3D 0)) {
> > > -             reg->s32_min_value =3D reg->smin_value =3D s64_min;
> > > -             reg->s32_max_value =3D reg->smax_value =3D s64_max;
> > > -             reg->u32_min_value =3D reg->umin_value =3D s64_min;
> > > -             reg->u32_max_value =3D reg->umax_value =3D s64_max;
> > > -             reg->var_off =3D tnum_range(s64_min, s64_max);
> > > -             return;
> > > -     }
> > > +     reg->s32_min_value =3D (s32)smin_value;
> > > +     reg->s32_max_value =3D (s32)smax_value;
> > >=20
> > > -out:
> > > -     set_sext64_default_val(reg, size);
> > > -}
> >=20
> > Assume that size =3D=3D 1, s64_min =3D 0b000, s64_max =3D=3D 0b100.
> > This corresponds to tnum with value =3D=3D 0b000 and mask =3D=3D 0b111.
> > Old algorithm computes more precise range in this situation.
> > Old:
> >=20
> >   0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
> >   1: (25) if r0 > 0x4 goto pc+2         ; R0=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7))
> >   2: (7b) *(u64 *)(r10 -8) =3D r0         ; R0=3Dscalar(id=3D1,smin=3Ds=
min32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7)) ...
> >   3: (91) r0 =3D *(s8 *)(r10 -8)          ; R0=3Dscalar(id=3D1,smin=3Ds=
min32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7)) ...
> >   4: (b7) r0 =3D 0                        ; R0=3D0
> >   5: (95) exit
> >=20
> > New:
> >=20
> >   0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
> >   1: (25) if r0 > 0x4 goto pc+2         ; R0=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7))
> >   2: (7b) *(u64 *)(r10 -8) =3D r0         ; R0=3Dscalar(id=3D1,smin=3Ds=
min32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4,var_off=3D(0x0; 0x7)) ...
> >   3: (91) r0 =3D *(s8 *)(r10 -8)          ; R0=3Dscalar(id=3D1,smin=3Ds=
min32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D7,var_off=3D(0x0; 0x7)) ...
> >   4: (b7) r0 =3D 0                        ; R0=3D0
> >   5: (95) exit
> >=20
> > Note that range for R0 at (3) is 0..4 for old algorithm and 0..7 for
> > new algorithm.
> >=20
> > Can we keep both algorithms by e.g. replacing set_sext64_default_val()
> > implementation with tnum_scast() adding tnum_scast() in
> > coerce_reg_to_size_sx()?
> >=20
> > In general, for such kinds of patch-sets it is interesting to see how
> > much precision is gained/lost with the change. It shouldn't be hard to
> > collect such data for e.g. complete s8 range by writing a small
> > user-space program that enumerates the s8 x s8 range and applies both
> > old an new range computations.
> >=20
> > [...]
>=20
> I was mostly focused on preserving the info from tnum for sparse ranges, =
so
> I kind of forgot about continuous ranges entirely.
> As per your suggestion, I plucked out anything relevant from the kernel,
> and compared the smax / smin values for the entire -1024,1024 range in a
> loop, like so:
>=20
>   struct bpf_reg_state r_old, r_new;
>=20
>   init_reg(&r_old, start, end);
>   r_new =3D r_old;
>=20
>   coerce_reg_to_size_sx_old(&r_old, size);
>   coerce_reg_to_size_sx_new(&r_new, size);
>=20
>   s64 range_old =3D r_old.smax_value - r_old.smin_value;
>   s64 range_new =3D r_new.smax_value - r_new.smin_value;
>=20
>   if (range_old < range_new) { ...
>=20
> In these continous ranges, the old implementation is much better:
>=20
>   [-1024, 1024]:
>   Old Better: 128016
>   New Better: 0
>   Equal: 1972209
>=20
> So I endeed up drafting this:
>=20
>   static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>   {
>     s64 smin_value, smax_value;
>     u64 num_bits =3D size * 8;
>     u64 top_smax_value, top_smin_value;
>=20
>     reg->var_off =3D tnum_scast(reg->var_off, size);
>=20
>     top_smax_value =3D ((u64)reg->smax_value >> num_bits) << num_bits;
>     top_smin_value =3D ((u64)reg->smin_value >> num_bits) << num_bits;
>=20
>     if (top_smax_value =3D=3D top_smin_value) {
>             if (size =3D=3D 1) {
>                 smin_value =3D (s8)reg->smin_value;
>                 smax_value =3D (s8)reg->smax_value;
>             } else if (size =3D=3D 2) {
>                 smin_value =3D (s16)reg->smin_value;
>                 smax_value =3D (s16)reg->smax_value;
>             } else {
>                 smin_value =3D (s32)reg->smin_value;
>                 smax_value =3D (s32)reg->smax_value;
>             }
>         } else {
>             smin_value =3D -(1LL << (num_bits - 1));
>             smax_value =3D (1LL << (num_bits - 1)) - 1;
>         }

The current implementation has the following part:

         s64_max =3D max(init_s64_max, init_s64_min);
         s64_min =3D min(init_s64_max, init_s64_min);

And I think this part is necessary. E.g. consider that
smin_value=3D=3D0x00 and smax_value=3D0x80, then with suggested
implementation:

  clang-repl> #include <stdio.h>
  clang-repl> printf("%ld\n", (long)(char)(0x80UL));
  -128

Sign of the smin_value will be positive, while sign of the smax_value
will become negative.

When respining for v2, could you please also provide a link to a
repository with test harness you use to check range [-1024,1024]?
(E.g. push it to the github).

>=20
>         reg->smin_value =3D smin_value;
>         reg->smax_value =3D smax_value;
>=20
>         reg->umin_value =3D 0;
>         reg->umax_value =3D U64_MAX;
>=20
>         reg->s32_min_value =3D (s32)smin_value;
>         reg->s32_max_value =3D (s32)smax_value;
>         reg->u32_min_value =3D 0;
>         reg->u32_max_value =3D U32_MAX;
>=20
>         __update_reg_bounds(reg);
> }
>=20
> I'm trying to always perform tnum_scast in order to preserve bitwise
> info, but attempt to use the old numeric logic first. If the range fits
> into the target size, we preserve the existing numeric bounds. If not, we
> fall back to the type limits and let __update_reg_bounds reconstruct the
> range from var_off. The imeplementation is similar for the subreg variant=
.
>=20
> Rerunning the comparison for the same range looks much better, we should =
be
> consistently seeing precision gains in the cases where the original
> implementation bails out via goto:
>=20
>   [-1024, 1024]:
>   Old Better: 0
>   New Better: 131072
>   Equal: 1969153
>=20
> I also went through the CI, the existing selftest in the series still
> covers the change.
>=20
> wdyt?

