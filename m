Return-Path: <bpf+bounces-13721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DCA7DD113
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930361F222F6
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 15:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE307200C7;
	Tue, 31 Oct 2023 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SgvzbpaK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A603D6B
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:58:21 +0000 (UTC)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175F6F1
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:58:19 -0700 (PDT)
Message-ID: <9ed12f60-1466-490f-8dc9-fa986e35dfb7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698767897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv6FT1v1oARNuEkvoGofaGe+Hs2pG06ut3FsS07ptBM=;
	b=SgvzbpaKPYiPsRhFdSvVq744NRs3vRS/XN/bPbWcP/Pd5Ua5lUyylWhfnGgGG85u3Decxg
	QqFyWp96eLVCJFmEb/GHSqgpnGXC7FXi1gRuITcNlcqT9TVlQ3enV2uT+1LeBnZWBP554T
	fN45igRLSp+8NVGF7pOk3PiRgo5uEOo=
Date: Tue, 31 Oct 2023 15:58:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add skcipher API support to TC/XDP
 programs
To: Jiri Olsa <olsajiri@gmail.com>, Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-crypto@vger.kernel.org
References: <20231031134900.1432945-1-vadfed@meta.com>
 <ZUEhT7WqRyUARm4s@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ZUEhT7WqRyUARm4s@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 31/10/2023 15:46, Jiri Olsa wrote:
> On Tue, Oct 31, 2023 at 06:48:59AM -0700, Vadim Fedorenko wrote:
> 
> SNIP
> 
>> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
>> new file mode 100644
>> index 000000000000..c2a0703934fc
>> --- /dev/null
>> +++ b/kernel/bpf/crypto.c
>> @@ -0,0 +1,280 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2023 Meta, Inc */
>> +#include <linux/bpf.h>
>> +#include <linux/bpf_mem_alloc.h>
>> +#include <linux/btf.h>
>> +#include <linux/btf_ids.h>
>> +#include <linux/filter.h>
>> +#include <linux/scatterlist.h>
>> +#include <linux/skbuff.h>
>> +#include <crypto/skcipher.h>
>> +
>> +/**
>> + * struct bpf_crypto_skcipher_ctx - refcounted BPF sync skcipher context structure
>> + * @tfm:	The pointer to crypto_sync_skcipher struct.
>> + * @rcu:	The RCU head used to free the crypto context with RCU safety.
>> + * @usage:	Object reference counter. When the refcount goes to 0, the
>> + *		memory is released back to the BPF allocator, which provides
>> + *		RCU safety.
>> + */
>> +struct bpf_crypto_skcipher_ctx {
>> +	struct crypto_sync_skcipher *tfm;
>> +	struct rcu_head rcu;
>> +	refcount_t usage;
>> +};
>> +
>> +__diag_push();
>> +__diag_ignore_all("-Wmissing-prototypes",
>> +		  "Global kfuncs as their definitions will be in BTF");
>> +
> 
> hi,
> just a heads up.. there's [1] change adding macro for this, it's not
> merged yet, but will probably get in soon
> 
> jirka
> 
> [1] https://lore.kernel.org/bpf/20231030210638.2415306-1-davemarchevsky@fb.com/
> 

Hi Jiri,

Thanks for heads up, I'll adjust the patchset when macro patch is merged.


>> +static void *__bpf_dynptr_data_ptr(const struct bpf_dynptr_kern *ptr)
>> +{
>> +	enum bpf_dynptr_type type;
>> +
>> +	if (!ptr->data)
>> +		return NULL;
>> +
>> +	type = bpf_dynptr_get_type(ptr);
>> +
>> +	switch (type) {
>> +	case BPF_DYNPTR_TYPE_LOCAL:
>> +	case BPF_DYNPTR_TYPE_RINGBUF:
>> +		return ptr->data + ptr->offset;
>> +	case BPF_DYNPTR_TYPE_SKB:
>> +		return skb_pointer_if_linear(ptr->data, ptr->offset, __bpf_dynptr_size(ptr));
>> +	case BPF_DYNPTR_TYPE_XDP:
>> +	{
>> +		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset, __bpf_dynptr_size(ptr));
>> +		if (!IS_ERR_OR_NULL(xdp_ptr))
>> +			return xdp_ptr;
>> +
>> +		return NULL;
>> +	}
>> +	default:
>> +		WARN_ONCE(true, "unknown dynptr type %d\n", type);
>> +		return NULL;
>> +	}
>> +}
>> +
>> +/**
>> + * bpf_crypto_skcipher_ctx_create() - Create a mutable BPF crypto context.
>> + *
>> + * Allocates a crypto context that can be used, acquired, and released by
>> + * a BPF program. The crypto context returned by this function must either
>> + * be embedded in a map as a kptr, or freed with bpf_crypto_skcipher_ctx_release().
>> + *
>> + * bpf_crypto_skcipher_ctx_create() allocates memory using the BPF memory
>> + * allocator, and will not block. It may return NULL if no memory is available.
>> + * @algo: bpf_dynptr which holds string representation of algorithm.
>> + * @key:  bpf_dynptr which holds cipher key to do crypto.
>> + */
>> +__bpf_kfunc struct bpf_crypto_skcipher_ctx *
>> +bpf_crypto_skcipher_ctx_create(const struct bpf_dynptr_kern *palgo,
>> +			       const struct bpf_dynptr_kern *pkey, int *err)
>> +{
>> +	struct bpf_crypto_skcipher_ctx *ctx;
>> +	char *algo;
>> +
>> +	if (__bpf_dynptr_size(palgo) > CRYPTO_MAX_ALG_NAME) {
>> +		*err = -EINVAL;
>> +		return NULL;
>> +	}
>> +
>> +	algo = __bpf_dynptr_data_ptr(palgo);
>> +
>> +	if (!crypto_has_skcipher(algo, CRYPTO_ALG_TYPE_SKCIPHER, CRYPTO_ALG_TYPE_MASK)) {
>> +		*err = -EOPNOTSUPP;
>> +		return NULL;
>> +	}
>> +
>> +	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx) {
>> +		*err = -ENOMEM;
>> +		return NULL;
>> +	}
>> +
>> +	memset(ctx, 0, sizeof(*ctx));
>> +
>> +	ctx->tfm = crypto_alloc_sync_skcipher(algo, 0, 0);
>> +	if (IS_ERR(ctx->tfm)) {
>> +		*err = PTR_ERR(ctx->tfm);
>> +		ctx->tfm = NULL;
>> +		goto err;
>> +	}
>> +
>> +	*err = crypto_sync_skcipher_setkey(ctx->tfm, __bpf_dynptr_data_ptr(pkey),
>> +					   __bpf_dynptr_size(pkey));
>> +	if (*err)
>> +		goto err;
>> +
>> +	refcount_set(&ctx->usage, 1);
>> +
>> +	return ctx;
>> +err:
>> +	if (ctx->tfm)
>> +		crypto_free_sync_skcipher(ctx->tfm);
>> +	kfree(ctx);
>> +
>> +	return NULL;
>> +}
>> +
>> +static void crypto_free_sync_skcipher_cb(struct rcu_head *head)
>> +{
>> +	struct bpf_crypto_skcipher_ctx *ctx;
>> +
>> +	ctx = container_of(head, struct bpf_crypto_skcipher_ctx, rcu);
>> +	crypto_free_sync_skcipher(ctx->tfm);
>> +	kfree(ctx);
>> +}
>> +
>> +/**
>> + * bpf_crypto_skcipher_ctx_acquire() - Acquire a reference to a BPF crypto context.
>> + * @ctx: The BPF crypto context being acquired. The ctx must be a trusted
>> + *	     pointer.
>> + *
>> + * Acquires a reference to a BPF crypto context. The context returned by this function
>> + * must either be embedded in a map as a kptr, or freed with
>> + * bpf_crypto_skcipher_ctx_release().
>> + */
>> +__bpf_kfunc struct bpf_crypto_skcipher_ctx *
>> +bpf_crypto_skcipher_ctx_acquire(struct bpf_crypto_skcipher_ctx *ctx)
>> +{
>> +	refcount_inc(&ctx->usage);
>> +	return ctx;
>> +}
>> +
>> +/**
>> + * bpf_crypto_skcipher_ctx_release() - Release a previously acquired BPF crypto context.
>> + * @ctx: The crypto context being released.
>> + *
>> + * Releases a previously acquired reference to a BPF cpumask. When the final
>> + * reference of the BPF cpumask has been released, it is subsequently freed in
>> + * an RCU callback in the BPF memory allocator.
>> + */
>> +__bpf_kfunc void bpf_crypto_skcipher_ctx_release(struct bpf_crypto_skcipher_ctx *ctx)
>> +{
>> +	if (refcount_dec_and_test(&ctx->usage))
>> +		call_rcu(&ctx->rcu, crypto_free_sync_skcipher_cb);
>> +}
>> +
>> +static int bpf_crypto_skcipher_crypt(struct crypto_sync_skcipher *tfm,
>> +				     const struct bpf_dynptr_kern *src,
>> +				     struct bpf_dynptr_kern *dst,
>> +				     const struct bpf_dynptr_kern *iv,
>> +				     bool decrypt)
>> +{
>> +	struct skcipher_request *req = NULL;
>> +	struct scatterlist sgin, sgout;
>> +	int err;
>> +
>> +	if (crypto_sync_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
>> +		return -EINVAL;
>> +
>> +	if (__bpf_dynptr_is_rdonly(dst))
>> +		return -EINVAL;
>> +
>> +	if (!__bpf_dynptr_size(dst) || !__bpf_dynptr_size(src))
>> +		return -EINVAL;
>> +
>> +	if (__bpf_dynptr_size(iv) != crypto_sync_skcipher_ivsize(tfm))
>> +		return -EINVAL;
>> +
>> +	req = skcipher_request_alloc(&tfm->base, GFP_ATOMIC);
>> +	if (!req)
>> +		return -ENOMEM;
>> +
>> +	sg_init_one(&sgin, __bpf_dynptr_data_ptr(src), __bpf_dynptr_size(src));
>> +	sg_init_one(&sgout, __bpf_dynptr_data_ptr(dst), __bpf_dynptr_size(dst));
>> +
>> +	skcipher_request_set_crypt(req, &sgin, &sgout, __bpf_dynptr_size(src),
>> +				   __bpf_dynptr_data_ptr(iv));
>> +
>> +	err = decrypt ? crypto_skcipher_decrypt(req) : crypto_skcipher_encrypt(req);
>> +
>> +	skcipher_request_free(req);
>> +
>> +	return err;
>> +}
>> +
>> +/**
>> + * bpf_crypto_skcipher_decrypt() - Decrypt buffer using configured context and IV provided.
>> + * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
>> + * @src:	bpf_dynptr to the encrypted data. Must be a trusted pointer.
>> + * @dst:	bpf_dynptr to the buffer where to store the result. Must be a trusted pointer.
>> + * @iv:		bpf_dynptr to IV data to be used by decryptor.
>> + *
>> + * Decrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
>> + */
>> +__bpf_kfunc int bpf_crypto_skcipher_decrypt(struct bpf_crypto_skcipher_ctx *ctx,
>> +					    const struct bpf_dynptr_kern *src,
>> +					    struct bpf_dynptr_kern *dst,
>> +					    const struct bpf_dynptr_kern *iv)
>> +{
>> +	return bpf_crypto_skcipher_crypt(ctx->tfm, src, dst, iv, true);
>> +}
>> +
>> +/**
>> + * bpf_crypto_skcipher_encrypt() - Encrypt buffer using configured context and IV provided.
>> + * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
>> + * @src:	bpf_dynptr to the plain data. Must be a trusted pointer.
>> + * @dst:	bpf_dynptr to buffer where to store the result. Must be a trusted pointer.
>> + * @iv:		bpf_dynptr to IV data to be used by decryptor.
>> + *
>> + * Encrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
>> + */
>> +__bpf_kfunc int bpf_crypto_skcipher_encrypt(struct bpf_crypto_skcipher_ctx *ctx,
>> +					    const struct bpf_dynptr_kern *src,
>> +					    struct bpf_dynptr_kern *dst,
>> +					    const struct bpf_dynptr_kern *iv)
>> +{
>> +	return bpf_crypto_skcipher_crypt(ctx->tfm, src, dst, iv, false);
>> +}
>> +
>> +__diag_pop();
>> +
>> +BTF_SET8_START(crypt_skcipher_init_kfunc_btf_ids)
>> +BTF_ID_FLAGS(func, bpf_crypto_skcipher_ctx_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
>> +BTF_ID_FLAGS(func, bpf_crypto_skcipher_ctx_release, KF_RELEASE)
>> +BTF_ID_FLAGS(func, bpf_crypto_skcipher_ctx_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
>> +BTF_SET8_END(crypt_skcipher_init_kfunc_btf_ids)
>> +
>> +static const struct btf_kfunc_id_set crypt_skcipher_init_kfunc_set = {
>> +	.owner = THIS_MODULE,
>> +	.set   = &crypt_skcipher_init_kfunc_btf_ids,
>> +};
>> +
>> +BTF_SET8_START(crypt_skcipher_kfunc_btf_ids)
>> +BTF_ID_FLAGS(func, bpf_crypto_skcipher_decrypt, KF_RCU)
>> +BTF_ID_FLAGS(func, bpf_crypto_skcipher_encrypt, KF_RCU)
>> +BTF_SET8_END(crypt_skcipher_kfunc_btf_ids)
>> +
>> +static const struct btf_kfunc_id_set crypt_skcipher_kfunc_set = {
>> +	.owner = THIS_MODULE,
>> +	.set   = &crypt_skcipher_kfunc_btf_ids,
>> +};
>> +
>> +BTF_ID_LIST(crypto_skcipher_dtor_ids)
>> +BTF_ID(struct, bpf_crypto_skcipher_ctx)
>> +BTF_ID(func, bpf_crypto_skcipher_ctx_release)
>> +
>> +static int __init crypto_skcipher_kfunc_init(void)
>> +{
>> +	int ret;
>> +	const struct btf_id_dtor_kfunc crypto_skcipher_dtors[] = {
>> +		{
>> +			.btf_id	      = crypto_skcipher_dtor_ids[0],
>> +			.kfunc_btf_id = crypto_skcipher_dtor_ids[1]
>> +		},
>> +	};
>> +
>> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &crypt_skcipher_kfunc_set);
>> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &crypt_skcipher_kfunc_set);
>> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &crypt_skcipher_kfunc_set);
>> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
>> +					       &crypt_skcipher_init_kfunc_set);
>> +	return  ret ?: register_btf_id_dtor_kfuncs(crypto_skcipher_dtors,
>> +						   ARRAY_SIZE(crypto_skcipher_dtors),
>> +						   THIS_MODULE);
>> +}
>> +
>> +late_initcall(crypto_skcipher_kfunc_init);
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 62a53ebfedf9..2020884fca3d 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1429,7 +1429,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
>>   #define DYNPTR_SIZE_MASK	0xFFFFFF
>>   #define DYNPTR_RDONLY_BIT	BIT(31)
>>   
>> -static bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
>> +bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
>>   {
>>   	return ptr->size & DYNPTR_RDONLY_BIT;
>>   }
>> @@ -1444,7 +1444,7 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
>>   	ptr->size |= type << DYNPTR_TYPE_SHIFT;
>>   }
>>   
>> -static enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr)
>> +enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr)
>>   {
>>   	return (ptr->size & ~(DYNPTR_RDONLY_BIT)) >> DYNPTR_TYPE_SHIFT;
>>   }
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index bb58987e4844..75d2f47ca3cb 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5184,6 +5184,7 @@ BTF_ID(struct, prog_test_ref_kfunc)
>>   BTF_ID(struct, cgroup)
>>   BTF_ID(struct, bpf_cpumask)
>>   BTF_ID(struct, task_struct)
>> +BTF_ID(struct, bpf_crypto_skcipher_ctx)
>>   BTF_SET_END(rcu_protected_types)
>>   
>>   static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
>> -- 
>> 2.39.3
>>
>>


