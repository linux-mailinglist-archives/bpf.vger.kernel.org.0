Return-Path: <bpf+bounces-37007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C861194FF29
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 09:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1931F25090
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 07:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C1F13541B;
	Tue, 13 Aug 2024 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoQSqQ8b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3912E1D1
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723535719; cv=none; b=Eqo7pm/K5pvz1hoXg1O7wpMl25pJRPv79lLsZF0yZOJeXRLg+eRQkunnaR8WYcOrLEL3/tNl7ddunznNv9ZKVLYSrMqJxDsedDsFW6i5kJlk8XBMwlE09PAWjPfl7yrKGT016g8pccyTseHO5xFrKwAsU3qywAbqqL+35wMCjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723535719; c=relaxed/simple;
	bh=Tf79v+vqbNFGwJ6iCl410TIMl9R56EAwJyRzPXr8QYg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PEGmDqO/kKOmmr07+lRlYNXASwO4oG1XkAQTLM9UsjasDaHUg/lQCNxWP6cI8hXSyhFQKcOHyiFEZl0uWHUAuxMBMNMe7Ftzy9bAz+uQ54fXSWO/zB8mHKjbnUub++Me6/Nam1rcE+voQzR9FcecGqGyX7MkD9ajkbmYlmfPO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoQSqQ8b; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d394313aceso533759a91.3
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 00:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723535717; x=1724140517; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GdrfnSYFRA93sNqJBwV2UsiOuLvbLtvyl1q3iR7B5HA=;
        b=PoQSqQ8b0X+Sakr8/wlWygecAqS9wHp+AJqAHra0sJfBvcTsS6qHZpuo6KbCg4+wou
         OGp9DF8T5TDxGZVrIPTkoYJ+VxlU4zsePinuXHtmm+kJz738s+d0C6wAPNyroDgv4ZfW
         1TMioCfztOuJTCLjkeNjyGhG8Ll/h5wTE7bhKzunOdFR6idK2cAiDFR04woj+fo1TEz9
         9dGWuJbkpdpphA4sOaIcUlCWzcawYI1SNamFM+P0sPHEj+6MARy173WPO9jEePGN+5wP
         is8oJU8Vtsetq95h6ZF5/twHskdXybOlz3NDOpy77hKzUMiCAxvi0arPWUB8K6XJNY45
         v5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723535717; x=1724140517;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GdrfnSYFRA93sNqJBwV2UsiOuLvbLtvyl1q3iR7B5HA=;
        b=j2n5f/xRYeyzUXLdjMb62n7Gip8yDzHjhFCoYhnip5/739XM3cvV64b3HtQXi7HyBQ
         TiWLE35SVCNXdLh/5sdJnSj6J0ycspJ/DunhAbh7897iXFA+200Ap8P9Hqpio32EejkW
         Ii9ZrgmVRaBoR13x+5TW3gJHptaeqffDZF3rnC7eXq0aXKXHmuNBmlonZsCnyaXNwfvB
         yj4xtyxgxeXTrzh45XdQ8aEXFKP2Jg8azS6hfZbFa3XeFw7vOykSYTSppHXF+VpIOIKF
         qQbAc0LKguR+CwTATyMkJ6V/J5ITnXANW5Z34CgCRHRCATX6ZSercEIfGCDZJ1w+FI44
         Tllg==
X-Forwarded-Encrypted: i=1; AJvYcCX5cg0Mwd93ZqhWO7jpiAR3/2AAW1w5SJK4+XMTYnOqQCslrY7YtIdqPiabLhzMLsjuwDUpW0nqx8yb93TqUQWD1+2O
X-Gm-Message-State: AOJu0YzuK9dYajCUQihAe3/zZy9/ZhYt218SZa0PMHZjKNS23HQUhC3C
	wFo/9rPIGbvWFuQVkVa9HUNqppPMT4nrqbTouaYWJ8rddJd9ArSU
X-Google-Smtp-Source: AGHT+IFpVIfJ0Tt/0xzEyZrNV15QqdK9alTKrZLmKvOL/mHF9mV66JplzjQYCAekh8WlIKZlF0UPtQ==
X-Received: by 2002:a17:90a:e10d:b0:2c9:6ad7:659d with SMTP id 98e67ed59e1d1-2d3924d2da7mr3083105a91.6.1723535716834;
        Tue, 13 Aug 2024 00:55:16 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fce56257sm6492548a91.7.2024.08.13.00.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 00:55:16 -0700 (PDT)
Message-ID: <b7518fdfd0a01f1eef66556b62f5e72484501eae.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: support nocsr patterns for calls to
 kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com
Date: Tue, 13 Aug 2024 00:55:11 -0700
In-Reply-To: <2ca49adc-2c90-42ee-b1ff-bf339731ad5a@linux.dev>
References: <20240812234356.2089263-1-eddyz87@gmail.com>
	 <20240812234356.2089263-2-eddyz87@gmail.com>
	 <2ca49adc-2c90-42ee-b1ff-bf339731ad5a@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-12 at 22:36 -0700, Yonghong Song wrote:

[...]

> > @@ -16140,6 +16140,28 @@ static bool verifier_inlines_helper_call(struc=
t bpf_verifier_env *env, s32 imm)
> >   	}
> >   }
> >  =20
> > +/* Same as helper_nocsr_clobber_mask() but for kfuncs, see comment abo=
ve */
> > +static u32 kfunc_nocsr_clobber_mask(struct bpf_kfunc_call_arg_meta *me=
ta)
> > +{
> > +	const struct btf_param *params;
> > +	u32 vlen, i, mask;
>=20
> In helper_nocsr_clobber_mask, we have u8 mask. To be consistent, can we h=
ave 'u8 mask' here?
> Are you worried that the number of arguments could be more than 7? This s=
eems not the case
> right now.

Before the nocsr part for helpers landed there was a change request to
make helper_nocsr_clobber_mask() return u32. I modified the function
but forgot to change the type for 'mask' local variable.

The main point in using u32 is uniformity.
I can either change kfunc_nocsr_clobber_mask() to use u8 for mask,
or update helper_nocsr_clobber_mask() to use u32 for mask.

>=20
> > +
> > +	params =3D btf_params(meta->func_proto);
> > +	vlen =3D btf_type_vlen(meta->func_proto);
> > +	mask =3D 0;
> > +	if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_proto->typ=
e)))
> > +		mask |=3D BIT(BPF_REG_0);
> > +	for (i =3D 0; i < vlen; ++i)
> > +		mask |=3D BIT(BPF_REG_1 + i);
> > +	return mask;
> > +}
> > +
> > +/* Same as verifier_inlines_helper_call() but for kfuncs, see comment =
above */
> > +static bool verifier_inlines_kfunc_call(struct bpf_kfunc_call_arg_meta=
 *meta)
> > +{
> > +	return false;
> > +}
> > +
> >   /* GCC and LLVM define a no_caller_saved_registers function attribute=
.
> >    * This attribute means that function scratches only some of
> >    * the caller saved registers defined by ABI.
> > @@ -16238,6 +16260,20 @@ static void mark_nocsr_pattern_for_call(struct=
 bpf_verifier_env *env,
> >   				  bpf_jit_inlines_helper_call(call->imm));
> >   	}
> >  =20
> > +	if (bpf_pseudo_kfunc_call(call)) {
> > +		struct bpf_kfunc_call_arg_meta meta;
> > +		int err;
> > +
> > +		err =3D fetch_kfunc_meta(env, call, &meta, NULL);
> > +		if (err < 0)
> > +			/* error would be reported later */
> > +			return;
> > +
> > +		clobbered_regs_mask =3D kfunc_nocsr_clobber_mask(&meta);
> > +		can_be_inlined =3D (meta.kfunc_flags & KF_NOCSR) &&
> > +				 verifier_inlines_kfunc_call(&meta);
>=20
> I think we do not need both meta.kfunc_flags & KF_NOCSR and
> verifier_inlines_kfunc_call(&meta). Only one of them is enough
> since they test very similar thing. You do need to ensure
> kfuncs with KF_NOCSR in special_kfunc_list though.
> WDYT?

I can remove the flag in favour of verifier_inlines_kfunc_call().

>=20
> > +	}
> > +
> >   	if (clobbered_regs_mask =3D=3D ALL_CALLER_SAVED_REGS)
> >   		return;
> >  =20



