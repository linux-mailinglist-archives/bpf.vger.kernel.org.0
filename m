Return-Path: <bpf+bounces-16654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7C8804261
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622172813A7
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77526AE0;
	Mon,  4 Dec 2023 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vvA+FTKZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423BEC0
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:08:34 -0800 (PST)
Message-ID: <7e93cc7b-0bc0-41d7-af36-d21f919d5755@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701731312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMTDuBvfrBcTj07LSr3P2m6REF9k0/Ryy4y4Trr/lFg=;
	b=vvA+FTKZPChnV3ecNA06X9JnFKhJYMavhM7/yPr+2hBLNJhNmR8omGqAChlikGU1gys05A
	KZs1A6yX12c4IVzkdX8PKMP1yhIy5D1LJeQnfGppovnMsCbqx4IhXSDswi/LpW9CKB0jmy
	YneU4DfBp+Ie5xHz0EyuBt5fh/Kzf+E=
Date: Mon, 4 Dec 2023 15:08:25 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 1/3] bpf: make common crypto API for TC/XDP
 programs
Content-Language: en-US
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Vadim Fedorenko <vadfed@meta.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20231202010604.1877561-1-vadfed@meta.com>
 <3bea70d0-94a5-4d41-be15-2e8b5932a3b0@linux.dev>
 <b5547960-c4ef-2b90-0186-a859d18849fc@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <b5547960-c4ef-2b90-0186-a859d18849fc@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/3/23 11:02 AM, Vadim Fedorenko wrote:
>>> +static const struct bpf_crypto_type *bpf_crypto_get_type(const char *name)
>>> +{
>>> +    const struct bpf_crypto_type *type = ERR_PTR(-ENOENT);
>>> +    struct bpf_crypto_type_list *node;
>>> +
>>> +    down_read(&bpf_crypto_types_sem);
>>> +    list_for_each_entry(node, &bpf_crypto_types, list) {
>>> +        if (strcmp(node->type->name, name))
>>> +            continue;
>>> +
>>> +        if (try_module_get(node->type->owner))
>>
>> If I read patch 2 correctly, it is always built-in. I am not sure I understand 
>> the module_put/get in this patch.
> 
> Well, yeah, right now it's built-in, but it can be easily converted to module
> with it's own Kconfig option. Especially if we think about adding aead crypto
> and using bpf in embedded setups with less amount of resources.

What code is missing to support module? It sounds like all codes are ready.
and does it really need a separate kconfig option? Can it depend on 
CONFIG_BPF_SYSCALL and CONFIG_CRYPTO_SKCIPHER?

>>> +BTF_SET8_START(crypt_init_kfunc_btf_ids)
>>> +BTF_ID_FLAGS(func, bpf_crypto_ctx_create, KF_ACQUIRE | KF_RET_NULL | 
>>> KF_SLEEPABLE)
>>> +BTF_ID_FLAGS(func, bpf_crypto_ctx_release, KF_RELEASE)
>>> +BTF_ID_FLAGS(func, bpf_crypto_ctx_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
>>
>> Considering bpf_crypto_ctx is rcu protected, the acquire may use "KF_ACQUIRE | 
>> KF_RCU | KF_RET_NULL" such that the bpf_crypto_ctx_acquire(ctx_from_map_value) 
>> will work and the user will prepare checking NULL from day one.
>>
> 
> Got it. What about create? Should it also include KF_RCU?

create should not need KF_RCU. The return value is a trusted/refcounted pointer. 
It has a reg->ref_obj_id => is_trusted_reg().

