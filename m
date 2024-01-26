Return-Path: <bpf+bounces-20415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2446A83E07E
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 18:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7F71F257F0
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAD820327;
	Fri, 26 Jan 2024 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f1+j2jRx"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED03208A7
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290728; cv=none; b=gmCZGvDvClXSxAbUlUlq/bL/SUu+dK5JaSjgy7q5sNPNvbNfnl1+pDYuPCz+Z8vQ58S339UMLKZxv56eI3sYMEN/4iyjGLlZ/iBGtCZ/UC4pOGCcEVP6iZJm3QKWPwCBLdfrTgZgZ9ZeFIpMT3ZqvoSW7aAeZq9VseBjGDc+G3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290728; c=relaxed/simple;
	bh=ofuQOEbQQFzE0GCfYJoMi9Q3uD0EeA4A29bglOPy/LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T26MT+enFNfWAJMEkx1ZLe4k/YRDS5KA3q0Fhpfd8aR9c4O+felpLLYdwCPEn7fOW1zdj3tuUclUI6irSMyH8PogtY1gsaELQq3JiqkAOdH7gFryxlt8YsUiHijg0+x+w4VZFxv9FPsleCb/3VeW7WPlXvNkhyuMQuPTcqvKslE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f1+j2jRx; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d15e44d8-941a-4da6-ae8a-c4e031623e0f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706290723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrNyYEKOGi6GDPwxj18KT3Z3avOcsu6ZH6V/ZzqbE58=;
	b=f1+j2jRxHnceOOU3X1qIJXeHPH/lliU0My8D+iJacSp615kLkXvFZoouPy+6aEwjSzpE36
	xUsCDywGERV9zVuMMfcKS9V4swaD6V24uAfHekt4L6/B299PzoKs718N7UOOMYmoWF68ap
	pvhp8ZGZon06J23aL3HWECXI7Q3iPU0=
Date: Fri, 26 Jan 2024 17:38:36 +0000
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
 <f70e2d1e-b17d-44c2-9077-51afa9f4f05e@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <f70e2d1e-b17d-44c2-9077-51afa9f4f05e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 26/01/2024 10:30, Vadim Fedorenko wrote:
> On 25/01/2024 22:34, Martin KaFai Lau wrote:
>> On 1/25/24 3:19 AM, Vadim Fedorenko wrote:
>>> On 25/01/2024 01:10, Martin KaFai Lau wrote:
>>>> On 1/15/24 2:08 PM, Vadim Fedorenko wrote:
>>>>> +static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
>>>>> +                const struct bpf_dynptr_kern *src,
>>>>> +                struct bpf_dynptr_kern *dst,
>>>>> +                const struct bpf_dynptr_kern *siv,
>>>>> +                bool decrypt)
>>>>> +{
>>>>> +    u32 src_len, dst_len, siv_len;
>>>>> +    const u8 *psrc;
>>>>> +    u8 *pdst, *piv;
>>>>> +    int err;
>>>>> +
>>>>> +    if (ctx->type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY)
>>>>
>>>> nit. Does the indirect call get_flags() return different values?
>>>> Should it be rejected earlier, e.g. in bpf_crypto_ctx_create()?
>>>
>>> Well, that is the common pattern in crypto subsys to check flags.
>>> But after looking at it second time, I think I have to refactor this
>>> part. CRYPTO_TFM_NEED_KEY is set during tfm creation if algo requires
>>> the key. And it's freed when the key setup is successful. As there is no
>>> way bpf programs can modify tfm directly we can move this check to
>>> bpf_crypto_ctx_create() to key setup part and avoid indirect call in 
>>> this place.
>>>>
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (__bpf_dynptr_is_rdonly(dst))
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    siv_len = __bpf_dynptr_size(siv);
>>>>> +    src_len = __bpf_dynptr_size(src);
>>>>> +    dst_len = __bpf_dynptr_size(dst);
>>>>> +    if (!src_len || !dst_len)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    if (siv_len != (ctx->type->ivsize(ctx->tfm) + 
>>>>> ctx->type->statesize(ctx->tfm)))
>>>>
>>>> Same here, two indirect calls per en/decrypt kfunc call. Does the 
>>>> return value change?
>>>
>>> I have to check the size of IV provided by the caller, and then to avoid
>>> indirect calls I have to store these values somewhere in ctx. It gives a
>>> direct access to these values to bpf programs, which can potentially
>>> abuse them. Not sure if it's good to open such opportunity.
>>
>> I don't think it makes any difference considering tfm has already been 
>> accessible in ctx->tfm.
> 
> Fair. I'll do it then.
> 
>> A noob question, what secret is in the siv len?
> 
> No secrets in the values themself. The problem I see is that user (bpf
> program) can adjust them to avoid proper validation and then pass
> smaller buffer and trigger read/write out-of-bounds.

I've done more tests, and looks like verifier will block programs that
are trying to write directly to the struct. In this case no abuse is
possible and it's safe to export the value into ctx and avoid indirect
calls.

> 
>> btw, unrelated, based on the selftest in patch 3, is it supporting any 
>> siv_len > 0 for now?
> 
> Well, it should. I see no reasons not to support it. But to test it
> properly another cipher should be used. I'll think about extending tests
> 
>>
>>>
>>>>
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    psrc = __bpf_dynptr_data(src, src_len);
>>>>> +    if (!psrc)
>>>>> +        return -EINVAL;
>>>>> +    pdst = __bpf_dynptr_data_rw(dst, dst_len);
>>>>> +    if (!pdst)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    piv = siv_len ? __bpf_dynptr_data_rw(siv, siv_len) : NULL;
>>>>> +    if (siv_len && !piv)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    err = decrypt ? ctx->type->decrypt(ctx->tfm, psrc, pdst, 
>>>>> src_len, piv)
>>>>> +              : ctx->type->encrypt(ctx->tfm, psrc, pdst, src_len, 
>>>>> piv);
>>>>> +
>>>>> +    return err;
>>>>> +}
>>>>
>>>
>>
> 


