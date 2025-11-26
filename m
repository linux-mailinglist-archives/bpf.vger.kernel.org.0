Return-Path: <bpf+bounces-75572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B70C8950C
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 11:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 323EA358156
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB80302150;
	Wed, 26 Nov 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="aBBEr8lj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1333C2D3218
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153184; cv=none; b=PL7SmMHdw7yS4d1tflzyrt031VsJD6W+tRb+nP7lXeFXRDZGf0DsF2cNSN7LZPq5GEngAOaTvIdNf1+CJBi22aSJhUx3sWIF/VtRisV3dWQ1RS0Wki4kAcYpm6BRxOd+m0eWvVOIbdZMH6yD0Y21UWKIVBOlmRce7DMPnlGOPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153184; c=relaxed/simple;
	bh=LhhLEwMBrHVC/XwAD+mCPJGWJiPxLdxwKyHKx4YVn5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dO1ifQeivitkyZ2qzCg9e2biaonQdijy0tLqHToX5YDHXzWwbQVQEDxkIlwRtAP0kyYW1Ad4pliO//bVwyFpmnrkgSmU838BiY2Zx9EH9dhEOlAcr0yBMme4C0l/pOwHx5L+VmHyRkNtkJoKqp53nZQXXCyypgIluNl8T8iz1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=aBBEr8lj; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37a2dced861so6665681fa.1
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 02:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1764153180; x=1764757980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGTQhS10YrGD9obtWMqJl14sPNcMbLJvX79EZQ8xfYk=;
        b=aBBEr8lj6p3PsZlJS8zqcnP7MP+n299exkWLC1WFtUWQh1GfpfEpehEVZ8LyGAuyhf
         Cu3dwXD8FlhvLEzOe1uhxhCwP9vR3jCgIOWR1SRBl4Y9ximlCp2n9sOW8GbBAVgBU7uF
         dshtc63F8ZWE/+dgbgt9BKpv2FoGRVJvWZWss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764153180; x=1764757980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGTQhS10YrGD9obtWMqJl14sPNcMbLJvX79EZQ8xfYk=;
        b=VKWM/eO6RM+J07igZraKetQaQIj0J+S2F0Ij6FXO26FrwCunwaJoYTDiZJicNgIixN
         UnYQVhvHJn1DX+2c7f81/eYF6Tff+mXon4TGzFxD67vkJStaF8VrdtdW9EQ5V1GU9o+b
         sBUHZfyteSKmDjNAyTyogLF3qlGElS8r7/zsAqIJA9CQNXvh5C9EiFRts1JPAnTDfb51
         7m//z/nr3c2sqn0IPOzpMKOARnTKsqvb5RKXIKS7ocz19nnuklkRVUHpmJ/cliHtX1Ul
         VBT25aJ5Man93EEKZQ2XnxRx7WBj74AwLpMQnAtxRIqZ4EZZrZweeUT3IFxWxJiFNd1H
         4Flg==
X-Gm-Message-State: AOJu0YyNhnlrmT7J0OcBFj330I3d5/Hqmjm+5acU6QMbeJ+INn6rqvYb
	aj+LC6KBrhYaknim3sbQLKpC0wPNjVuJ2wxxTJ6OR1j1NYgvgmSek6ggXhgOiT9Vl/RIa19LYgH
	b0L+lZQTMPz1HU9ZmCg8vS9V/l5nlu8XIQ/dY+a3OMw==
X-Gm-Gg: ASbGncv0W7anCOJwVKkxXigIqS0WDvVF6RBGBe0AapanXxJ+TAOzysLcRXXeLL+ZARL
	pi1kiHTX3ARQ4EDnEROB12o5FnHosdNfXoTtSsUy7wfNIHf3R5HJIplV0yBH7KRIdFdVxNJ0HX3
	+VZjRLLXBpVQaDFKMmwUIkSYiLvpeY8hPBNvcvz0ddb8GNdHCftB13SCKCfx8JEVvkZMkoWOTLb
	/JvdGGRr6EQoBLjk/jIAqx+aRDahYjoecR/9jUM+qJbjyVF9w4G0rWgkT0hRh3S2U3pWy02b0Ba
	tYVa2jxozMjYitxR/sT1vsEMvw==
X-Google-Smtp-Source: AGHT+IEPeQ+E9Lx7VR4upq06vpOgkb5+FmZ1L7GZr/BuIcCg+pUCYZ9mCk2eMTsA/wby185iMGDShxM7p5VSakvjzn0=
X-Received: by 2002:a05:651c:2347:20b0:37a:4018:e5fe with SMTP id
 38308e7fff4ca-37cd8041d95mr42211621fa.18.1764153180012; Wed, 26 Nov 2025
 02:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125125634.2671-3-dimitar.kanaliev@siteground.com> <35d5864ecbfca2f37ee4f8219575a9c1dc69874fca80d2d2179c8044824ec1f4@mail.kernel.org>
In-Reply-To: <35d5864ecbfca2f37ee4f8219575a9c1dc69874fca80d2d2179c8044824ec1f4@mail.kernel.org>
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Date: Wed, 26 Nov 2025 12:32:48 +0200
X-Gm-Features: AWmQ_bl3d5gbii_ExtRjrs46YslJq9-lBnALGDqvVma6ClRMhzuCjWfEx-26g4Y
Message-ID: <CAHx3w9JZHHdbyquSTXo4788WB9=7VzZT6v6kbSq6f9K8Fj1qEw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] bpf: verifier: Simplify register sign extension
 with tnum_scast
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, shung-hsi.yu@suse.com, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:22=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 766695491..c9a6bf85b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -6876,147 +6876,57 @@ static void coerce_reg_to_size(struct bpf_reg_=
state *reg, int size)
> >       reg_bounds_sync(reg);
> >  }
> >
> > -static void set_sext64_default_val(struct bpf_reg_state *reg, int size=
)
> > -{
>
> [ ... ]
>
> > -}
> > -
> >  static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
> >  {
>
> [ ... ]
>
> >  }
> >
> > -static void set_sext32_default_val(struct bpf_reg_state *reg, int size=
)
> > -{
>
> [ ... ]
>
> > -}
> > -
> >  static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int si=
ze)
> >  {
> > -     s32 init_s32_max, init_s32_min, s32_max, s32_min, u32_val;
> > -     u32 top_smax_value, top_smin_value;
> > -     u32 num_bits =3D size * 8;
> > -
> > -     if (tnum_is_const(reg->var_off)) {
> > -             u32_val =3D reg->var_off.value;
> > -             if (size =3D=3D 1)
> > -                     reg->var_off =3D tnum_const((s8)u32_val);
> > -             else
> > -                     reg->var_off =3D tnum_const((s16)u32_val);
> > +     s32 smin_value, smax_value;
> >
> > -             u32_val =3D reg->var_off.value;
> > -             reg->s32_min_value =3D reg->s32_max_value =3D u32_val;
> > -             reg->u32_min_value =3D reg->u32_max_value =3D u32_val;
> > +     if (size >=3D 4)
> >               return;
> > -     }
> >
> > -     top_smax_value =3D ((u32)reg->s32_max_value >> num_bits) << num_b=
its;
> > -     top_smin_value =3D ((u32)reg->s32_min_value >> num_bits) << num_b=
its;
> > +     reg->var_off =3D tnum_subreg(tnum_scast(reg->var_off, size));
> >
> > -     if (top_smax_value !=3D top_smin_value)
> > -             goto out;
> > +     smin_value =3D -(1 << (size * 8 - 1));
> > +     smax_value =3D (1 << (size * 8 - 1)) - 1;
> >
> > -     /* find the s32_min and s32_min after sign extension */
> > -     if (size =3D=3D 1) {
> > -             init_s32_max =3D (s8)reg->s32_max_value;
> > -             init_s32_min =3D (s8)reg->s32_min_value;
> > -     } else {
> > -             /* size =3D=3D 2 */
> > -             init_s32_max =3D (s16)reg->s32_max_value;
> > -             init_s32_min =3D (s16)reg->s32_min_value;
> > -     }
> > -     s32_max =3D max(init_s32_max, init_s32_min);
> > -     s32_min =3D min(init_s32_max, init_s32_min);
> > -
> > -     if ((s32_min >=3D 0) =3D=3D (s32_max >=3D 0)) {
> > -             reg->s32_min_value =3D s32_min;
> > -             reg->s32_max_value =3D s32_max;
> > -             reg->u32_min_value =3D (u32)s32_min;
> > -             reg->u32_max_value =3D (u32)s32_max;
> > -             reg->var_off =3D tnum_subreg(tnum_range(s32_min, s32_max)=
);
> > -             return;
> > -     }
> > +     reg->s32_min_value =3D smin_value;
> > +     reg->s32_max_value =3D smax_value;
> >
> > -out:
> > -     set_sext32_default_val(reg, size);
> > +     reg->u32_min_value =3D 0;
> > +     reg->u32_max_value =3D U32_MAX;
> > +
> > +     __update_reg32_bounds(reg);
> > +
> > +     reg->umin_value =3D reg->u32_min_value;
> > +     reg->umax_value =3D reg->u32_max_value;
> > +
> > +     reg->smin_value =3D reg->umin_value;
> > +     reg->smax_value =3D reg->umax_value;
>                         ^^^^^^^^
> Can reg->smin_value and reg->smax_value be correctly set from unsigned
> values here? For sign-extended negative values, the 64-bit unsigned
> bounds (umin/umax) will be positive after zero-extension, but the 64-bit
> signed bounds (smin/smax) should remain negative.
>
> Consider an 8-bit value -1 (0xFF) that gets sign-extended:
> - After sign extension: s32_min_value =3D s32_max_value =3D -1 (0xFFFFFFF=
F)
> - After __update_reg32_bounds: u32_min_value =3D u32_max_value =3D 0xFFFF=
FFFF
> - After zero-extension to 64-bit: umin_value =3D umax_value =3D 0x0000000=
0FFFFFFFF
> - Then: smin_value =3D 0x00000000FFFFFFFF (interpreted as +4294967295)
>
> But the correct 64-bit signed value should be -1 (0xFFFFFFFFFFFFFFFF),
> not +4294967295.
>
> The pattern in __reg_assign_32_into_64() at verifier.c:2771-2772 shows
> the correct approach for propagating signed 32-bit bounds to 64-bit:
>
>     reg->smin_value =3D reg->s32_min_value;
>     reg->smax_value =3D reg->s32_max_value;
>
> This uses implicit sign-extension from s32 to s64. Should
> coerce_subreg_to_size_sx() follow the same pattern?
>
Correct me if I'm wrong, but my assumption here is that ALU ops on wX
registers, we need to sign extend to 32-bits and then zero extend to the
whole 64-bit range, so zeroing the upper 32 bits means every possible
runtime value is in the range:

    0 <=3D value <=3D U32_MAX

which implies

    s64(value) =3D=3D u64(value)

For the 64-bit view of the register after zero extending?

This is what the spec from the docs says on the topic:

    The MOVSX instruction does a move operation with sign extension.
    {MOVSX, X, ALU} sign extends 8-bit and 16-bit operands into 32-bit
    operands, and zeroes the remaining upper 32 bits. {MOVSX, X, ALU64}
    sign extends 8-bit, 16-bit, and 32-bit operands into 64-bit operands.

> >  }
> >
> >  static bool bpf_map_is_rdonly(const struct bpf_map *map)
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/196705=
38430

