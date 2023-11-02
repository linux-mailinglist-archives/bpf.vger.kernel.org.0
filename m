Return-Path: <bpf+bounces-13864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094587DE953
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 01:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B638728182E
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 00:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708581FB4;
	Thu,  2 Nov 2023 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AfhTKVv5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA171FB5
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 00:31:11 +0000 (UTC)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D7101
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 17:31:07 -0700 (PDT)
Message-ID: <b07fbb30-92a5-7c96-339c-ffbdf40ea1bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698885065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYyCqd0cmrSjG084WqxLPqA2/nJgQp5TviiyD9gAa58=;
	b=AfhTKVv5CFyGMnt1TteJDVqyRwYnFzpW/gx22EfntCf3ITt2CV3DoB2gisZStZ8WttZEYi
	FRhowJlpq9vLvhONTC+qAOo32w/z8HpU0I2iinUSBgo74HivpSUMx9MMVpfE4DNC8tNKpC
	ewjCdoK5NZZ/P9iRlEUwAFyEF/vLPcs=
Date: Thu, 2 Nov 2023 00:31:03 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add skcipher API support to TC/XDP
 programs
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Vadim Fedorenko <vadfed@meta.com>,
 "David S. Miller" <davem@davemloft.net>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20231031134900.1432945-1-vadfed@meta.com>
 <dac97b74-5ff1-172b-9cd5-4cdcf07386ec@linux.dev>
 <91a6d5a7-7b18-48a2-9a74-7c00509467f8@linux.dev>
 <4adea710-72ca-0908-d280-625bc3682aa1@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <4adea710-72ca-0908-d280-625bc3682aa1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 01.11.2023 22:59, Martin KaFai Lau wrote:
> On 11/1/23 3:50 PM, Vadim Fedorenko wrote:
>>>> +static int bpf_crypto_skcipher_crypt(struct crypto_sync_skcipher *tfm,
>>>> +                     const struct bpf_dynptr_kern *src,
>>>> +                     struct bpf_dynptr_kern *dst,
>>>> +                     const struct bpf_dynptr_kern *iv,
>>>> +                     bool decrypt)
>>>> +{
>>>> +    struct skcipher_request *req = NULL;
>>>> +    struct scatterlist sgin, sgout;
>>>> +    int err;
>>>> +
>>>> +    if (crypto_sync_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (__bpf_dynptr_is_rdonly(dst))
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (!__bpf_dynptr_size(dst) || !__bpf_dynptr_size(src))
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (__bpf_dynptr_size(iv) != crypto_sync_skcipher_ivsize(tfm))
>>>> +        return -EINVAL;
>>>> +
>>>> +    req = skcipher_request_alloc(&tfm->base, GFP_ATOMIC);
>>>
>>> Doing alloc per packet may kill performance. Is it possible to optimize it 
>>> somehow? What is the usual size of the req (e.g. the example in the selftest)?
>>>
>>
>> In ktls code aead_request is allocated every time encryption is invoked, see 
>> tls_decrypt_sg(), apparently per skb. Doesn't look like performance
>> killer. For selftest it's only sizeof(struct skcipher_request).
> 
> ktls is doing the en/decrypt on the userspace behalf to compensate the cost.
> 
> When this kfunc is used in xdp to decrypt a few bytes for each packet and then 
> XDP_TX out, this extra alloc will be quite noticeable. If the size is usually 
> small, can it be done in the stack memory?

Hmm... looks like SYNC_SKCIPHER_REQUEST_ON_STACK will help us. Ok, I'll change 
this part to use stack allocations.


