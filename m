Return-Path: <bpf+bounces-37046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED99508CA
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 17:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAD3286F12
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5501A01CE;
	Tue, 13 Aug 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DyZEsaJH"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C51A01AB
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562314; cv=none; b=oTqp4W9fgvnB2zK26mCC9Qy5yxb0eTEW/ktqsXDxUtOxo42Vx/bRZ8J+kfbIIqDoq4zjB8A24PEH0meE1I5GDydUV3eo5NZLqyW6MypDlc9uTfD/CIXhgU6U1kszH8qhQl8UVcX3lAb5VVUTP2HsqWjDsL39pPfagv9P8kOiFas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562314; c=relaxed/simple;
	bh=q1JQ4/9baglWo0PLilyIXgbSLQbTWKxnlrlAtZa/dYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/rI8nUVOkJ4N17FdLeljD1KGqZs2cbPxWTE2vOwl6nGxeD40FzfQi53jrmv0j7sErWW+qHbQdDLkkl97PaFEmCVftLSU8KLHZUIJRvrhDDbAmFMKN0z/yRxLcGr7In3b5/fPFwVjvRBlo1Laj0Ti8jJf85Q9uZTbObSrqW6djg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DyZEsaJH; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2970dc12-3dab-446d-9d75-a33c2f6bc008@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723562310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1RMbpd9pIEmU6CPY4F0VMGYhCAG6OhUbN1ZD14N5yU=;
	b=DyZEsaJHg01u7lcwe302GQEWZMIKxa2wYWlU08xkIkXNvyc/K406umJLNM1TtbcicQy9TP
	tTskEjldeE4+RJUmRF6ZT9E7BMqFKKp7mNvUg48MEvQZ/ecd9r7RxOLY0eXHEKrl+pjjkD
	QRF9eOhmeWhIg6EXc3TUNA3QSozklxk=
Date: Tue, 13 Aug 2024 08:18:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: support nocsr patterns for calls to
 kfuncs
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com
References: <20240812234356.2089263-1-eddyz87@gmail.com>
 <20240812234356.2089263-2-eddyz87@gmail.com>
 <2ca49adc-2c90-42ee-b1ff-bf339731ad5a@linux.dev>
 <b7518fdfd0a01f1eef66556b62f5e72484501eae.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b7518fdfd0a01f1eef66556b62f5e72484501eae.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/13/24 12:55 AM, Eduard Zingerman wrote:
> On Mon, 2024-08-12 at 22:36 -0700, Yonghong Song wrote:
>
> [...]
>
>>> @@ -16140,6 +16140,28 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
>>>    	}
>>>    }
>>>    
>>> +/* Same as helper_nocsr_clobber_mask() but for kfuncs, see comment above */
>>> +static u32 kfunc_nocsr_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
>>> +{
>>> +	const struct btf_param *params;
>>> +	u32 vlen, i, mask;
>> In helper_nocsr_clobber_mask, we have u8 mask. To be consistent, can we have 'u8 mask' here?
>> Are you worried that the number of arguments could be more than 7? This seems not the case
>> right now.
> Before the nocsr part for helpers landed there was a change request to
> make helper_nocsr_clobber_mask() return u32. I modified the function
> but forgot to change the type for 'mask' local variable.
>
> The main point in using u32 is uniformity.
> I can either change kfunc_nocsr_clobber_mask() to use u8 for mask,
> or update helper_nocsr_clobber_mask() to use u32 for mask.

Changing to u32 in helper_nocsr_clobber_mask() is okay. I
just want to have consistent type for 'mask' in both functions.

>
>>> +
>>> +	params = btf_params(meta->func_proto);
>>> +	vlen = btf_type_vlen(meta->func_proto);
>>> +	mask = 0;
>>> +	if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_proto->type)))
>>> +		mask |= BIT(BPF_REG_0);
>>> +	for (i = 0; i < vlen; ++i)
>>> +		mask |= BIT(BPF_REG_1 + i);
>>> +	return mask;
>>> +}
>>> +
>>> +/* Same as verifier_inlines_helper_call() but for kfuncs, see comment above */
>>> +static bool verifier_inlines_kfunc_call(struct bpf_kfunc_call_arg_meta *meta)
>>> +{
>>> +	return false;
>>> +}
>>> +
>>>    /* GCC and LLVM define a no_caller_saved_registers function attribute.
>>>     * This attribute means that function scratches only some of
>>>     * the caller saved registers defined by ABI.
>>> @@ -16238,6 +16260,20 @@ static void mark_nocsr_pattern_for_call(struct bpf_verifier_env *env,
>>>    				  bpf_jit_inlines_helper_call(call->imm));
>>>    	}
>>>    
>>> +	if (bpf_pseudo_kfunc_call(call)) {
>>> +		struct bpf_kfunc_call_arg_meta meta;
>>> +		int err;
>>> +
>>> +		err = fetch_kfunc_meta(env, call, &meta, NULL);
>>> +		if (err < 0)
>>> +			/* error would be reported later */
>>> +			return;
>>> +
>>> +		clobbered_regs_mask = kfunc_nocsr_clobber_mask(&meta);
>>> +		can_be_inlined = (meta.kfunc_flags & KF_NOCSR) &&
>>> +				 verifier_inlines_kfunc_call(&meta);
>> I think we do not need both meta.kfunc_flags & KF_NOCSR and
>> verifier_inlines_kfunc_call(&meta). Only one of them is enough
>> since they test very similar thing. You do need to ensure
>> kfuncs with KF_NOCSR in special_kfunc_list though.
>> WDYT?
> I can remove the flag in favour of verifier_inlines_kfunc_call().

Sounds good to me.

>
>>> +	}
>>> +
>>>    	if (clobbered_regs_mask == ALL_CALLER_SAVED_REGS)
>>>    		return;
>>>    
>

