Return-Path: <bpf+bounces-13714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A027DD0AC
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF44B20F0C
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA891E532;
	Tue, 31 Oct 2023 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQABt3Cc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4191E529
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:38:12 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78999E6
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:38:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso826058366b.0
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698766689; x=1699371489; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dOIWhmmS3+Ni7YpvzH1iVGDh0FWqB0EI5pu1L4ksWDo=;
        b=RQABt3Cc3GL2xdFsap+9yYZHZDf//SQprQlFraiocRdEOv28x7VX9VlXe9fB7vZ/7E
         Y7gJAkJTs+f6ii1Ivv27dKcvii5Tiifs7xkY15bXK/JZTvuyPq89WHiHhte3M52IGn1h
         k4fnI+JsYeSrfvY9OWjCCvoV9KPNFaCmHTKSipTtM6XvGfQYvuRIQ4wf7adrRs0UU9d7
         idrm5LDZTfXh1SiPNb99qgf3O7ze6ulqzeUVZJ1Ls/2vLi1p4U+tcguquFl7Y9l6LtCN
         UMEQFobKhF25No/Nj21NWNqBNWgrtwZ/GQYZwxRLhTvEVumYkn7ItVLdpNoc8ioaeRX4
         Xdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698766689; x=1699371489;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOIWhmmS3+Ni7YpvzH1iVGDh0FWqB0EI5pu1L4ksWDo=;
        b=WMMMEVUWKVEhLsllyM4Gw+Q9XEUJrmCHPWes1IJBhcnVwcvXrC2W9q1h6WQhcM39cv
         mLghmXf2VrP0fbOu597VdqiLxJf6pQsVxtZxunavsWJmlGHXWLjx6cd1XmKqfKP/28tW
         Fh53m78CmguONyOXhAwiltaXEr9Ibk1pFt1B/MdyNstElf4o7sulmeZ3dITXi+deR+IO
         fQaR4+wIyD4OV2M6fc1tfIMn9NU1Ftq2lrabd0lyojwTEOOIlaovRfkygdWm/c792QpO
         goGbfx92wpLmohENC2mWtuD4p5FFjPdTDyYaEw0pKBdGbXmM21/J9caX9ms1WLv0l9eF
         UR1g==
X-Gm-Message-State: AOJu0YyfSRiAUkxDKQkrG2I8SPgSU2aJB+FvI/tDmrYFurwsm//G/WAN
	zVcODXvCoQ0ulNeIT32ONzUj5sHzVx+NFw==
X-Google-Smtp-Source: AGHT+IF3gCj/z5OWac1kBqHSm+34ic+CD2b/PRYtuSTm7ZxNuqe5THA5tHXYwjFfYLSOLnFV86u9eQ==
X-Received: by 2002:a17:906:c10c:b0:9b9:faee:4228 with SMTP id do12-20020a170906c10c00b009b9faee4228mr8944063ejc.56.1698766688675;
        Tue, 31 Oct 2023 08:38:08 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lh8-20020a170906f8c800b009b9a1714524sm1171174ejb.12.2023.10.31.08.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 08:38:08 -0700 (PDT)
Message-ID: <3bf9132b948f35c6626fa5bd84f7c864b2e52677.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 09/23] bpf: drop knowledge-losing
 __reg_combine_{32,64}_into_{64,32} logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 31 Oct 2023 17:38:07 +0200
In-Reply-To: <20231027181346.4019398-10-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-10-andrii@kernel.org>
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
> > When performing 32-bit conditional operation operating on lower 32 bits
> > of a full 64-bit register, register full value isn't changed. We just
> > potentially gain new knowledge about that register's lower 32 bits.
> >=20
> > Unfortunately, __reg_combine_{32,64}_into_{64,32} logic that
> > reg_set_min_max() performs as a last step, can lose information in some
> > cases due to __mark_reg64_unbounded() and __reg_assign_32_into_64().
> > That's bad and completely unnecessary. Especially __reg_assign_32_into_=
64()
> > looks completely out of place here, because we are not performing
> > zero-extending subregister assignment during conditional jump.
> >=20
> > So this patch replaced __reg_combine_* with just a normal
> > reg_bounds_sync() which will do a proper job of deriving u64/s64 bounds
> > from u32/s32, and vice versa (among all other combinations).
> >=20
> > __reg_combine_64_into_32() is also used in one more place,
> > coerce_reg_to_size(), while handling 1- and 2-byte register loads.
> > Looking into this, it seems like besides marking subregister as
> > unbounded before performing reg_bounds_sync(), we were also performing
> > deduction of smin32/smax32 and umin32/umax32 bounds from respective
> > smin/smax and umin/umax bounds. It's now redundant as reg_bounds_sync()
> > performs all the same logic more generically (e.g., without unnecessary
> > assumption that upper 32 bits of full register should be zero).
> >=20
> > Long story short, we remove __reg_combine_64_into_32() completely, and
> > coerce_reg_to_size() now only does resetting subreg to unbounded and th=
en
> > performing reg_bounds_sync() to recover as much information as possible
> > from 64-bit umin/umax and smin/smax bounds, set explicitly in
> > coerce_reg_to_size() earlier.
> >=20
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> > ---
> >  kernel/bpf/verifier.c | 60 ++++++-------------------------------------
> >  1 file changed, 8 insertions(+), 52 deletions(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6b0736c04ebe..f5fcb7fb2c67 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2641,51 +2641,6 @@ static void __reg_assign_32_into_64(struct bpf_r=
eg_state *reg)
> >  	}
> >  }
> > =20
> > -static void __reg_combine_32_into_64(struct bpf_reg_state *reg)
> > -{
> > -	/* special case when 64-bit register has upper 32-bit register
> > -	 * zeroed. Typically happens after zext or <<32, >>32 sequence
> > -	 * allowing us to use 32-bit bounds directly,
> > -	 */
> > -	if (tnum_equals_const(tnum_clear_subreg(reg->var_off), 0)) {
> > -		__reg_assign_32_into_64(reg);
> > -	} else {
> > -		/* Otherwise the best we can do is push lower 32bit known and
> > -		 * unknown bits into register (var_off set from jmp logic)
> > -		 * then learn as much as possible from the 64-bit tnum
> > -		 * known and unknown bits. The previous smin/smax bounds are
> > -		 * invalid here because of jmp32 compare so mark them unknown
> > -		 * so they do not impact tnum bounds calculation.
> > -		 */
> > -		__mark_reg64_unbounded(reg);
> > -	}
> > -	reg_bounds_sync(reg);
> > -}
> > -
> > -static bool __reg64_bound_s32(s64 a)
> > -{
> > -	return a >=3D S32_MIN && a <=3D S32_MAX;
> > -}
> > -
> > -static bool __reg64_bound_u32(u64 a)
> > -{
> > -	return a >=3D U32_MIN && a <=3D U32_MAX;
> > -}
> > -
> > -static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
> > -{
> > -	__mark_reg32_unbounded(reg);
> > -	if (__reg64_bound_s32(reg->smin_value) && __reg64_bound_s32(reg->smax=
_value)) {
> > -		reg->s32_min_value =3D (s32)reg->smin_value;
> > -		reg->s32_max_value =3D (s32)reg->smax_value;
> > -	}
> > -	if (__reg64_bound_u32(reg->umin_value) && __reg64_bound_u32(reg->umax=
_value)) {
> > -		reg->u32_min_value =3D (u32)reg->umin_value;
> > -		reg->u32_max_value =3D (u32)reg->umax_value;
> > -	}
> > -	reg_bounds_sync(reg);
> > -}
> > -
> >  /* Mark a register as having a completely unknown (scalar) value. */
> >  static void __mark_reg_unknown(const struct bpf_verifier_env *env,
> >  			       struct bpf_reg_state *reg)
> > @@ -6382,9 +6337,10 @@ static void coerce_reg_to_size(struct bpf_reg_st=
ate *reg, int size)
> >  	 * values are also truncated so we push 64-bit bounds into
> >  	 * 32-bit bounds. Above were truncated < 32-bits already.
> >  	 */
> > -	if (size >=3D 4)
> > -		return;
> > -	__reg_combine_64_into_32(reg);
> > +	if (size < 4) {
> > +		__mark_reg32_unbounded(reg);
> > +		reg_bounds_sync(reg);
> > +	}
> >  }
> > =20
> >  static void set_sext64_default_val(struct bpf_reg_state *reg, int size=
)
> > @@ -14623,13 +14579,13 @@ static void reg_set_min_max(struct bpf_reg_st=
ate *true_reg,
> >  					     tnum_subreg(false_32off));
> >  		true_reg->var_off =3D tnum_or(tnum_clear_subreg(true_64off),
> >  					    tnum_subreg(true_32off));
> > -		__reg_combine_32_into_64(false_reg);
> > -		__reg_combine_32_into_64(true_reg);
> > +		reg_bounds_sync(false_reg);
> > +		reg_bounds_sync(true_reg);
> >  	} else {
> >  		false_reg->var_off =3D false_64off;
> >  		true_reg->var_off =3D true_64off;
> > -		__reg_combine_64_into_32(false_reg);
> > -		__reg_combine_64_into_32(true_reg);
> > +		reg_bounds_sync(false_reg);
> > +		reg_bounds_sync(true_reg);
> >  	}
> >  }
> > =20


