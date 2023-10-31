Return-Path: <bpf+bounces-13713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C60F7DD0AA
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A544BB20EBE
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 15:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB8E1E531;
	Tue, 31 Oct 2023 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKW+3cRy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B9E1DDFC
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:38:02 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48E6E4
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:38:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50930f126b1so1387769e87.3
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698766679; x=1699371479; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a20o6Ryiuiwh1LovDC8lYi+ZGZjZZBhko4ZtqekyTy4=;
        b=iKW+3cRy4s9etcvJVaBmTsPzMlkGNtfWTqYhgPaUEAwtqJA8MP7e7Xl3SFNtvFm1dg
         MDydkHSqfO/3eWTnn3uXsotcbnpz1ys9mcCg7CeLXtsGIbYyIaaTYcp7m4CN8vADI5vt
         DnOniMFP00GiW0UOWuWJ3zGcPaDhWUT1m6CqkPIf0QAOdEya1EIC4G0d7bXuiaUorsnp
         tzG+qnW3BbEe67eYFSSSGBmaSjCPYhBUfYpcugXultwkeeeX4+fqpdchyPNV2RMafHGV
         L0gSUkO83tMB61FA0virecFiBoRXKypwh+Ow31VJGFa8rVzN9snfOeqYl2EAQFWh66E+
         bYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698766679; x=1699371479;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a20o6Ryiuiwh1LovDC8lYi+ZGZjZZBhko4ZtqekyTy4=;
        b=rsM7qeMnYQwbrGRoqXp8l69DjB5G3buFHps3iE7pUi+r87N7riSAPWvvpVOlI5swuJ
         L40Em3cdXxJXdVIz2B8MafS/O6nV6GnIt6ZJcWaxWcqKfH4WQsUkz06ohSYs4CNsLcRF
         HNyvGIfXoRw2XPeKLqie/LxwPqbWJlqJDt8nL7rz7lB4dMfy4Mm7zX0WFAvnzSwUQCA7
         MdYt1TTxWqS7mznJxx2of1/088maYXzYayGofPVlF2WRloi4rm7xoT/ItB7wD3gXq29i
         2wBtJgBo+CeWwPV1F7x/OjSKBGtsJxyHvEb4q8HZs2YDUVFKM0Gfa6vRUIeOP1rstoVE
         3OqQ==
X-Gm-Message-State: AOJu0YwNGnXE3b0u1ENeFzSLKDvMBkger9Bqcpj6evHcMHegqDfyjIpR
	r8mkuk2OOAVNYxehD0y9YmxHhkNgcFytTw==
X-Google-Smtp-Source: AGHT+IFNiQJfEKD2fju3C/JtjaAYDBvv/7jxfDCtX9wuf7TXOrnND2jMz32OlCUOjJ9swR4BFbjuIw==
X-Received: by 2002:ac2:4ecb:0:b0:507:a6b2:c63e with SMTP id p11-20020ac24ecb000000b00507a6b2c63emr8724098lfr.53.1698766678785;
        Tue, 31 Oct 2023 08:37:58 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a19-20020a509b53000000b0053443c8fd90sm1319953edj.24.2023.10.31.08.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 08:37:58 -0700 (PDT)
Message-ID: <99c1ae71b65ca074adf9da47cb38e823945de74b.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 07/23] bpf: improve deduction of 64-bit
 bounds from 32-bit bounds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 31 Oct 2023 17:37:57 +0200
In-Reply-To: <20231027181346.4019398-8-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-8-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
> > Add a few interesting cases in which we can tighten 64-bit bounds based
> > on newly learnt information about 32-bit bounds. E.g., when full u64/s6=
4
> > registers are used in BPF program, and then eventually compared as
> > u32/s32. The latter comparison doesn't change the value of full
> > register, but it does impose new restrictions on possible lower 32 bits
> > of such full registers. And we can use that to derive additional full
> > register bounds information.
> >=20
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> > ---
> >  kernel/bpf/verifier.c | 47 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 38d21d0e46bd..768247e3d667 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2535,10 +2535,57 @@ static void __reg64_deduce_bounds(struct bpf_re=
g_state *reg)
> >  	}
> >  }
> > =20
> > +static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
> > +{
> > +	/* Try to tighten 64-bit bounds from 32-bit knowledge, using 32-bit
> > +	 * values on both sides of 64-bit range in hope to have tigher range.
> > +	 * E.g., if r1 is [0x1'00000000, 0x3'80000000], and we learn from
> > +	 * 32-bit signed > 0 operation that s32 bounds are now [1; 0x7fffffff=
].
> > +	 * With this, we can substitute 1 as low 32-bits of _low_ 64-bit boun=
d
> > +	 * (0x100000000 -> 0x100000001) and 0x7fffffff as low 32-bits of
> > +	 * _high_ 64-bit bound (0x380000000 -> 0x37fffffff) and arrive at a
> > +	 * better overall bounds for r1 as [0x1'000000001; 0x3'7fffffff].
> > +	 * We just need to make sure that derived bounds we are intersecting
> > +	 * with are well-formed ranges in respecitve s64 or u64 domain, just
> > +	 * like we do with similar kinds of 32-to-64 or 64-to-32 adjustments.
> > +	 */
> > +	__u64 new_umin, new_umax;
> > +	__s64 new_smin, new_smax;
> > +
> > +	/* u32 -> u64 tightening, it's always well-formed */
> > +	new_umin =3D (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
> > +	new_umax =3D (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
> > +	reg->umin_value =3D max_t(u64, reg->umin_value, new_umin);
> > +	reg->umax_value =3D min_t(u64, reg->umax_value, new_umax);
> > +
> > +	/* s32 -> u64 tightening, s32 should be a valid u32 range (same sign)=
 */
> > +	if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
> > +		new_umin =3D (reg->umin_value & ~0xffffffffULL) | (u32)reg->s32_min_=
value;
> > +		new_umax =3D (reg->umax_value & ~0xffffffffULL) | (u32)reg->s32_max_=
value;
> > +		reg->umin_value =3D max_t(u64, reg->umin_value, new_umin);
> > +		reg->umax_value =3D min_t(u64, reg->umax_value, new_umax);
> > +	}
> > +
> > +	/* u32 -> s64 tightening, u32 range embedded into s64 preserves range=
 validity */
> > +	new_smin =3D (reg->smin_value & ~0xffffffffULL) | reg->u32_min_value;
> > +	new_smax =3D (reg->smax_value & ~0xffffffffULL) | reg->u32_max_value;
> > +	reg->smin_value =3D max_t(s64, reg->smin_value, new_smin);
> > +	reg->smax_value =3D min_t(s64, reg->smax_value, new_smax);
> > +
> > +	/* s32 -> s64 tightening, check that s32 range behaves as u32 range *=
/
> > +	if ((u32)reg->s32_min_value <=3D (u32)reg->s32_max_value) {
> > +		new_smin =3D (reg->smin_value & ~0xffffffffULL) | (u32)reg->s32_min_=
value;
> > +		new_smax =3D (reg->smax_value & ~0xffffffffULL) | (u32)reg->s32_max_=
value;
> > +		reg->smin_value =3D max_t(s64, reg->smin_value, new_smin);
> > +		reg->smax_value =3D min_t(s64, reg->smax_value, new_smax);
> > +	}
> > +}
> > +
> >  static void __reg_deduce_bounds(struct bpf_reg_state *reg)
> >  {
> >  	__reg32_deduce_bounds(reg);
> >  	__reg64_deduce_bounds(reg);
> > +	__reg_deduce_mixed_bounds(reg);
> >  }
> > =20
> >  /* Attempts to improve var_off based on unsigned min/max information *=
/


