Return-Path: <bpf+bounces-20381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F6D83D84C
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 11:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0022D1F230D6
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C140C17993;
	Fri, 26 Jan 2024 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wX446PTZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B86175A1
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706265060; cv=none; b=dqg7gT1MCBisc4q4YdXlWYvH1C+zuKgCZXK5rVrOKIB2DMc4NJ+M8Pu1t4+t48GEFXR9fbtJIctEzp7XuO80PdvTDPl/PX8qfeJo6s75xSn8hrsZE7yYA38IdeUzConcIFMx5ZRFplFLiAKmIy7sHuez77GL1AGRPgjdtccXK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706265060; c=relaxed/simple;
	bh=8lg/b7eX807+j1J3wZYy8O4FO7Zd4a5U1Nff7rJUlWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yp3jm6Zt+v5HCLiCcgdEpIKkTd8qF8fN1GKb0MNDTxTEm5fnpMPIlJCGH/fhSorLeFPA+F+b+DqLGSR2wLo2wOWzofUpm5FGz6kd79mZPJaG7y48tPsK9bExVRJ5hkEQpUGmm7ND3thixccigOqVlvcG//Npt+F11WQQojw5gFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wX446PTZ; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f70e2d1e-b17d-44c2-9077-51afa9f4f05e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706265056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQ5cQQbN07W3Mr8WJy7OQCLh5hYQXPQPQN6G40syBwQ=;
	b=wX446PTZNwlaRGbnarns756kx9vXUVcwAQ0IMJWhtOzdLSXSNzC5yv3VXQY/VD63MpQsF0
	MKtrioPpboc/H4N6vRPsJK8ORZO8CnpZ5Q+/D5/9D4CP1vcl9Kb09wsj0R5dJK44gDM0PY
	0yeMrn/aLlSjNM68CEv2zt1y1Htxt4Y=
Date: Fri, 26 Jan 2024 10:30:50 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 1/3] bpf: make common crypto API for TC/XDP
 programs
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, Vadim Fedorenko <vadfed@meta.com>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 bpf@vger.kernel.org, Victor Stewart <v@nametag.social>,
 Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20240115220803.1973440-1-vadfed@meta.com>
 <3d2d5f4e-c554-4648-bcec-839d83585123@linux.dev>
 <a682b902-37a2-4d43-8f39-56ca213f6663@linux.dev>
 <cec469f4-2fd0-479a-8919-0d5578687fb2@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <cec469f4-2fd0-479a-8919-0d5578687fb2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 25/01/2024 22:34, Martin KaFai Lau wrote:
> On 1/25/24 3:19 AM, Vadim Fedorenko wrote:
>> On 25/01/2024 01:10, Martin KaFai Lau wrote:
>>> On 1/15/24 2:08 PM, Vadim Fedorenko wrote:
>>>> +static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
>>>> +                const struct bpf_dynptr_kern *src,
>>>> +                struct bpf_dynptr_kern *dst,
>>>> +                const struct bpf_dynptr_kern *siv,
>>>> +                bool decrypt)
>>>> +{
>>>> +    u32 src_len, dst_len, siv_len;
>>>> +    const u8 *psrc;
>>>> +    u8 *pdst, *piv;
>>>> +    int err;
>>>> +
>>>> +    if (ctx->type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY)
>>>
>>> nit. Does the indirect call get_flags() return different values?
>>> Should it be rejected earlier, e.g. in bpf_crypto_ctx_create()?
>>
>> Well, that is the common pattern in crypto subsys to check flags.
>> But after looking at it second time, I think I have to refactor this
>> part. CRYPTO_TFM_NEED_KEY is set during tfm creation if algo requires
>> the key. And it's freed when the key setup is successful. As there is no
>> way bpf programs can modify tfm directly we can move this check to
>> bpf_crypto_ctx_create() to key setup part and avoid indirect call in 
>> this place.
>>>
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (__bpf_dynptr_is_rdonly(dst))
>>>> +        return -EINVAL;
>>>> +
>>>> +    siv_len = __bpf_dynptr_size(siv);
>>>> +    src_len = __bpf_dynptr_size(src);
>>>> +    dst_len = __bpf_dynptr_size(dst);
>>>> +    if (!src_len || !dst_len)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (siv_len != (ctx->type->ivsize(ctx->tfm) + 
>>>> ctx->type->statesize(ctx->tfm)))
>>>
>>> Same here, two indirect calls per en/decrypt kfunc call. Does the 
>>> return value change?
>>
>> I have to check the size of IV provided by the caller, and then to avoid
>> indirect calls I have to store these values somewhere in ctx. It gives a
>> direct access to these values to bpf programs, which can potentially
>> abuse them. Not sure if it's good to open such opportunity.
> 
> I don't think it makes any difference considering tfm has already been 
> accessible in ctx->tfm.

Fair. I'll do it then.

> A noob question, what secret is in the siv len?

No secrets in the values themself. The problem I see is that user (bpf
program) can adjust them to avoid proper validation and then pass
smaller buffer and trigger read/write out-of-bounds.

> btw, unrelated, based on the selftest in patch 3, is it supporting any 
> siv_len > 0 for now?

Well, it should. I see no reasons not to support it. But to test it
properly another cipher should be used. I'll think about extending tests

> 
>>
>>>
>>>> +        return -EINVAL;
>>>> +
>>>> +    psrc = __bpf_dynptr_data(src, src_len);
>>>> +    if (!psrc)
>>>> +        return -EINVAL;
>>>> +    pdst = __bpf_dynptr_data_rw(dst, dst_len);
>>>> +    if (!pdst)
>>>> +        return -EINVAL;
>>>> +
>>>> +    piv = siv_len ? __bpf_dynptr_data_rw(siv, siv_len) : NULL;
>>>> +    if (siv_len && !piv)
>>>> +        return -EINVAL;
>>>> +
>>>> +    err = decrypt ? ctx->type->decrypt(ctx->tfm, psrc, pdst, 
>>>> src_len, piv)
>>>> +              : ctx->type->encrypt(ctx->tfm, psrc, pdst, src_len, 
>>>> piv);
>>>> +
>>>> +    return err;
>>>> +}
>>>
>>
> 


