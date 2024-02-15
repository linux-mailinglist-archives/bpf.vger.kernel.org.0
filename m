Return-Path: <bpf+bounces-22100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1428856C64
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 19:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF6FB25728
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1181386AD;
	Thu, 15 Feb 2024 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeEckziM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6983513472F
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021450; cv=none; b=tyKShRVwHSLVMTvTloouIt7KjnxlmgeBTS31Tj2ce/dnhMyb++gHx7sETYgbN2eG7J6ICtHwUDMMfyZI5O0Z6H6H4FpPNa0/q4f+bHMRMYUyUuQCzP4/enBq9qiuNA4Xo3w60pHaXbrhlSpge/h828JmEvYLbu830QJ+sEtPAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021450; c=relaxed/simple;
	bh=cMZkkrkv7yLv3Lva+qZUBVge7nDocHsll5DQD2xti3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kcoZyBsKui9GB3OeuWjBRrx3XTJbDlEcWRbyPo/55rnsjc37hxd0KyTeJcY1zFqUlVy0OUBPXPmdWQf6cqMRFbscWmY/FYPb4fgK9UQ+FG0nGayGoYnvb9ql0WBaoO1leyZJuzDXOfycrkrL5jmNDBzW05YPLzKXTh0ggGCS5dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeEckziM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563d017696eso542107a12.0
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 10:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708021446; x=1708626246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lBuqpx3O8oFfJ17ArtvGV8Tsh6TUGJQlhpzteWpOnKA=;
        b=MeEckziMdgKh63utJzOwLXXYn/fCKMGPTxo501WCyW8B5tVAZNbuQ896C/iaHWX6N6
         YyS2R2aO7LxAZONKvk87ZXudJ8tLDku3XbgOoq+qNGZA0BBLNdvOgMx9bAM6uWWmkaCT
         ZlPCPipSLeFAYQT5CIh7pV/gWKW4hxlIBg0uHeUhEaZPHoFq9hDLmuysAq2YehnVC14w
         rxfyuOtbSq/Iil/3OzdanhhpdglsAVISFsMB+Qk9ktPmcJZ94CX+7Tg1mz5/LWAFnAPT
         UCWWKMEcvtt8c9YA+pmj8shtlMbAzFMiK0+ckFqOUYO881/BDgLDrkflluqGqv+HFhWc
         6xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708021446; x=1708626246;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBuqpx3O8oFfJ17ArtvGV8Tsh6TUGJQlhpzteWpOnKA=;
        b=a7bk3+AxvPKzKoq73e+8puopt0Sz03XxYyzjbL9XmFwqQsuV9IVmRk7YfHCx7OLCZY
         IIaDiKoI1Yt0rV7Q5dJqXBf37DxJVWnpKT8ThdLpMdvLmRN94qpWCnD1qRA4VOYtwPrf
         3fY7wsmHDUQkNpR677jPaG/uBKZ4Ce4GCw5f0vbsvS6/477opXIivydjOHXEvivBcE6e
         Fvf5L5tW3//lZoD/8uC9L3HOHLHu5tJjAXUG+gHVbqxIxxlc7XxBcDr+baMkwCm/7Tw3
         0N4xQwhGlBxDVFB/u8F/zOZV93cSHJO809phDeaLWd0UVs8/oDt7aI3JMbQBgCgnpn59
         pHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHvbGXaZRC+F9vk12J5uv85/Am0d5tE0kQK7sVmXVGEF7yYaZxW9ahklBbQ7dCRXpzN0Z3EtaOBSPteZOThr4Psici
X-Gm-Message-State: AOJu0YyrSmbKgFW7dmoc5JzOEG09hR8TGqq0xiazg2SLqSHO7LQh5OIb
	xXq1qnLb35PvAAMfwjMFPPbGeswkKqNTJlxpmTxqJWHL1eX2T+uG
X-Google-Smtp-Source: AGHT+IGWDAzJWaLa7oLO+4+GX9NvVMMsB1xD8szuVtdTP/KvyIfAYMfnrSETnvYyXfGirh6ABUsBjQ==
X-Received: by 2002:aa7:c24c:0:b0:563:7ee0:b865 with SMTP id y12-20020aa7c24c000000b005637ee0b865mr1995397edo.15.1708021446466;
        Thu, 15 Feb 2024 10:24:06 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id el11-20020a056402360b00b0055fba4996d9sm775497edb.71.2024.02.15.10.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:24:06 -0800 (PST)
Message-ID: <ff88196b95f3f05e8fa2172c101cb29a55a9c3f2.camel@gmail.com>
Subject: Re: [RFC PATCH v1 05/14] bpf: Implement BPF exception frame
 descriptor generation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Thu, 15 Feb 2024 20:24:04 +0200
In-Reply-To: <20240201042109.1150490-6-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-6-memxor@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 04:21 +0000, Kumar Kartikeya Dwivedi wrote:

Question: are there any real-life programs adapted to use exceptions
with cleanup feature? It would be interesting to see how robust
one-descriptor-per-pc is in practice, and also how it affects memory
consumption during verification.

The algorithm makes sense to me, a few comments/nits below.

[...]

> +static int find_and_merge_frame_desc(struct bpf_verifier_env *env, struc=
t bpf_exception_frame_desc_tab *fdtab, u64 pc, struct bpf_frame_desc_reg_en=
try *fd)
> +{
> +	struct bpf_exception_frame_desc **descs =3D NULL, *desc =3D NULL, *p;
> +	int ret =3D 0;
> +
> +	for (int i =3D 0; i < fdtab->cnt; i++) {
> +		if (pc !=3D fdtab->desc[i]->pc)
> +			continue;
> +		descs =3D &fdtab->desc[i];
> +		desc =3D fdtab->desc[i];
> +		break;
> +	}
> +
> +	if (!desc) {
> +		verbose(env, "frame_desc: find_and_merge: cannot find frame descriptor=
 for pc=3D%llu, creating new entry\n", pc);
> +		return -ENOENT;
> +	}
> +
> +	if (fd->off < 0)
> +		goto stack;

Nit: maybe write it down as

	if (fd->off >=3D 0)
		return merge_frame_desc(...);

     and avoid goto?

[...]

> +static int gen_exception_frame_desc_stack_entry(struct bpf_verifier_env =
*env, struct bpf_func_state *frame, int stack_off)
> +{
> +	int spi =3D stack_off / BPF_REG_SIZE, off =3D -stack_off - 1;
> +	struct bpf_reg_state *reg, not_init_reg, null_reg;
> +	int slot_type, ret;
> +
> +	__mark_reg_not_init(env, &not_init_reg);
> +	__mark_reg_known_zero(&null_reg);

__mark_reg_known_zero() does not set .type field,
thus null_reg.type value is undefined.

> +
> +	slot_type =3D frame->stack[spi].slot_type[BPF_REG_SIZE - 1];
> +	reg =3D &frame->stack[spi].spilled_ptr;
> +
> +	switch (slot_type) {
> +	case STACK_SPILL:
> +		/* We skip all kinds of scalar registers, except NULL values, which co=
nsume a slot. */
> +		if (is_spilled_scalar_reg(&frame->stack[spi]) && !register_is_null(&fr=
ame->stack[spi].spilled_ptr))
> +			break;
> +		ret =3D gen_exception_frame_desc_reg_entry(env, reg, off, frame->frame=
no);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case STACK_DYNPTR:
> +		/* Keep iterating until we find the first slot. */
> +		if (!reg->dynptr.first_slot)
> +			break;
> +		ret =3D gen_exception_frame_desc_dynptr_entry(env, reg, off, frame->fr=
ameno);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case STACK_ITER:
> +		/* Keep iterating until we find the first slot. */
> +		if (!reg->ref_obj_id)
> +			break;
> +		ret =3D gen_exception_frame_desc_iter_entry(env, reg, off, frame->fram=
eno);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case STACK_MISC:
> +	case STACK_INVALID:
> +		/* Create an invalid entry for MISC and INVALID */
> +		ret =3D gen_exception_frame_desc_reg_entry(env, &not_init_reg, off, fr=
ame->frameno);
> +		if (ret < 0)
> +			return 0;

No tests are failing if I comment out this block.
Looking at the merge_frame_desc() logic it appears to me that fd
entries with fd->type =3D=3D NOT_INIT would only be merged with other
NOT_INIT entries. What is the point of having such entries at all?

> +		break;
> +	case STACK_ZERO:
> +		reg =3D &null_reg;
> +		for (int i =3D BPF_REG_SIZE - 1; i >=3D 0; i--) {
> +			if (frame->stack[spi].slot_type[i] !=3D STACK_ZERO)
> +				reg =3D &not_init_reg;
> +		}
> +		ret =3D gen_exception_frame_desc_reg_entry(env, &null_reg, off, frame-=
>frameno);
> +		if (ret < 0)
> +			return ret;

Same here, no tests are failing if STACK_ZERO block is commented.
In general, what is the point of adding STACK_ZERO entries?
There is a logic in place to merge NULL and non-NULL entries,
but how is it different from not adding NULL entries in a first place?
find_and_merge_frame_desc() does a linear scan over bpf_exception_frame_des=
c->stack
and does not rely on entries being sorted by .off field.

> +		break;
> +	default:
> +		verbose(env, "verifier internal error: frame%d stack off=3D%d slot_typ=
e=3D%d missing handling for exception frame generation\n",
> +			frame->frameno, off, slot_type);
> +		return -EFAULT;
> +	}
> +	return 0;
> +}

