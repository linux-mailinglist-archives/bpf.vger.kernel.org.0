Return-Path: <bpf+bounces-16550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3053880268B
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 20:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AE0280DBE
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 19:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F98179AC;
	Sun,  3 Dec 2023 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w8AJALyp"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [IPv6:2001:41d0:1004:224b::af])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6073ADA
	for <bpf@vger.kernel.org>; Sun,  3 Dec 2023 11:09:02 -0800 (PST)
Message-ID: <7ac7b494-2409-6f2d-b18a-ac5154545066@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701630540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wq4rDgWW2SmuNmn6jKwaMqEYOLB2GQKsCbNg2kGA0U8=;
	b=w8AJALypv0b/Q/gBNDOmGxnxkINypVNQzu/6pThMwUuyxASx5epojzqd/4aco1nZqo/d4U
	FBvMvlppoIpxAcJUuu5aHseNpDz7+YTmSN/Vg7wzJEeGN8nW2DKDpDnqFge9W4zaih08/A
	2+/bv8k4gvT19iv+hrm/wQuzw00+y4o=
Date: Sun, 3 Dec 2023 19:08:58 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 1/3] bpf: make common crypto API for TC/XDP
 programs
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org
References: <20231202010604.1877561-1-vadfed@meta.com>
 <20231203105748.GD50400@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231203105748.GD50400@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03.12.2023 10:57, Simon Horman wrote:
> On Fri, Dec 01, 2023 at 05:06:02PM -0800, Vadim Fedorenko wrote:
>> Add crypto API support to BPF to be able to decrypt or encrypt packets
>> in TC/XDP BPF programs. Special care should be taken for initialization
>> part of crypto algo because crypto alloc) doesn't work with preemtion
>> disabled, it can be run only in sleepable BPF program. Also async crypto
>> is not supported because of the very same issue - TC/XDP BPF programs
>> are not sleepable.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> ...
> 
>> +/**
>> + * bpf_crypto_ctx_create() - Create a mutable BPF crypto context.
>> + *
>> + * Allocates a crypto context that can be used, acquired, and released by
>> + * a BPF program. The crypto context returned by this function must either
>> + * be embedded in a map as a kptr, or freed with bpf_crypto_ctx_release().
>> + * As crypto API functions use GFP_KERNEL allocations, this function can
>> + * only be used in sleepable BPF programs.
>> + *
>> + * bpf_crypto_ctx_create() allocates memory for crypto context.
>> + * It may return NULL if no memory is available.
>> + * @type__str: pointer to string representation of crypto type.
>> + * @algo__str: pointer to string representation of algorithm.
>> + * @pkey:      bpf_dynptr which holds cipher key to do crypto.
> 
> Hi Vadim,
> 
> a minor nit from my side: something about @authsize should go here.
> 
Hi Simon!

Good catch, I'll definitely add description to authsize, thanks!

>> + * @err:       integer to store error code when NULL is returned
>> + */
>> +__bpf_kfunc struct bpf_crypto_ctx *
>> +bpf_crypto_ctx_create(const char *type__str, const char *algo__str,
>> +		      const struct bpf_dynptr_kern *pkey,
>> +		      unsigned int authsize, int *err)
> 
> ...


