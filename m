Return-Path: <bpf+bounces-27763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5A28B16C6
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 01:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F7CB26F55
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 23:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A1B16EC0F;
	Wed, 24 Apr 2024 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VJkeUh8D"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9213B5B4
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999853; cv=none; b=FPwspBkVhVWmIs1VLzk0On+eHR+M6u4ka2NWKD8QPGNi4rvTK57wSCi3oKW7cmAXQh8mClkli6MRkh1io23kDAD7pYbL5A+HztN6CvRglPpgKHrp22ZXUT/Xt3hlRnE7DNVRRc35OgFDnSlvGvIFL3LGQaNqSSJbJ3xPSvscEtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999853; c=relaxed/simple;
	bh=JF6A8ALuFVZ0RoqK0OdTJ0ZWfZ7ym40V3tiOUx0LEQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLboZ76L6VrVuEGLCpvzLshB03AzYUXNWtTvXWBH968Be0FrYI1+N/4JyBqXucPgzC7OPxJvy4k7HdcPrO3nc29wMuwIjopmrAtK1w/u6P51qsvNXgQ9C0ytlZuMGoiAKUN2ZwTZiN2SpplHs1tt9NBBc264qQbFu6VNr04jyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VJkeUh8D; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a42e0ea6-9bc6-44ca-9338-5d5927ef3cc9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713999849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfHdCD5et8VuETlqHFHGECPm2y119T5GNlGOobsUSSs=;
	b=VJkeUh8D67eoo8S1nlaGbYCzaDRra9YgY19yaTCDPo6tFMQMmXGP4xfh1aRlsQluN2Q98b
	YULtQVakNSX6ZjqUOOQxGNi8bnYRGZEBGBsIGQDiC3X2obbYq8H5Wv+4oHtPh1rZjxYfN4
	YYKzVljFc50yGdLtuZV2GBBexNtqN4c=
Date: Wed, 24 Apr 2024 16:04:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 1/4] bpf: make common crypto API for TC/XDP
 programs
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org
References: <20240422225024.2847039-1-vadfed@meta.com>
 <20240422225024.2847039-2-vadfed@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240422225024.2847039-2-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/22/24 3:50 PM, Vadim Fedorenko wrote:
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 368c5d86b5b7..736bd22e5ce0 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -44,6 +44,9 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
>   obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
>   obj-${CONFIG_BPF_LSM} += bpf_lsm.o
>   endif
> +ifeq ($(CONFIG_CRYPTO),y)
> +obj-$(CONFIG_BPF_SYSCALL) += crypto.o
> +endif
>   obj-$(CONFIG_BPF_PRELOAD) += preload/
>   
>   obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> new file mode 100644
> index 000000000000..fe5e60a2f6ca
> --- /dev/null
> +++ b/kernel/bpf/crypto.c
> @@ -0,0 +1,382 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2024 Meta, Inc */
> +#include <linux/bpf.h>
> +#include <linux/bpf_crypto.h>
> +#include <linux/bpf_mem_alloc.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/filter.h>
> +#include <linux/scatterlist.h>
> +#include <linux/skbuff.h>
> +#include <crypto/skcipher.h>
> +
> +struct bpf_crypto_type_list {
> +	const struct bpf_crypto_type *type;
> +	struct list_head list;
> +};
> +
> +/* BPF crypto initialization parameters struct */
> +/**
> + * struct bpf_crypto_params - BPF crypto initialization parameters structure
> + * @type:	The string of crypto operation type.

I added kdoc for the "reserved" field.

> + * @algo:	The string of algorithm to initialize.
> + * @key:	The cipher key used to init crypto algorithm.
> + * @key_len:	The length of cipher key.
> + * @authsize:	The length of authentication tag used by algorithm.
> + */
> +struct bpf_crypto_params {
> +	char type[14];
> +	u8 reserved[2];
> +	char algo[128];
> +	u8 key[256];
> +	u32 key_len;
> +	u32 authsize;
> +};
> +
> +static LIST_HEAD(bpf_crypto_types);
> +static DECLARE_RWSEM(bpf_crypto_types_sem);
> +
> +/**
> + * struct bpf_crypto_ctx - refcounted BPF crypto context structure
> + * @type:	The pointer to bpf crypto type
> + * @tfm:	The pointer to instance of crypto API struct.
> + * @siv_len     Size of IV and state storage for cipher

Fixed this missing ":" that the testbot is complaining.

> + * @rcu:	The RCU head used to free the crypto context with RCU safety.
> + * @usage:	Object reference counter. When the refcount goes to 0, the
> + *		memory is released back to the BPF allocator, which provides
> + *		RCU safety.
> + */
> +struct bpf_crypto_ctx {
> +	const struct bpf_crypto_type *type;
> +	void *tfm;
> +	u32 siv_len;
> +	struct rcu_head rcu;
> +	refcount_t usage;
> +};
> +
> +int bpf_crypto_register_type(const struct bpf_crypto_type *type)
> +{
> +	struct bpf_crypto_type_list *node;
> +	int err = -EEXIST;
> +
> +	down_write(&bpf_crypto_types_sem);
> +	list_for_each_entry(node, &bpf_crypto_types, list) {
> +		if (!strcmp(node->type->name, type->name))
> +			goto unlock;
> +	}
> +
> +	node = kmalloc(sizeof(*node), GFP_KERNEL);
> +	err = -ENOMEM;
> +	if (!node)
> +		goto unlock;
> +
> +	node->type = type;
> +	list_add(&node->list, &bpf_crypto_types);
> +	err = 0;
> +
> +unlock:
> +	up_write(&bpf_crypto_types_sem);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(bpf_crypto_register_type);
> +
> +int bpf_crypto_unregister_type(const struct bpf_crypto_type *type)
> +{
> +	struct bpf_crypto_type_list *node;
> +	int err = -ENOENT;
> +
> +	down_write(&bpf_crypto_types_sem);
> +	list_for_each_entry(node, &bpf_crypto_types, list) {
> +		if (strcmp(node->type->name, type->name))
> +			continue;
> +
> +		list_del(&node->list);
> +		kfree(node);
> +		err = 0;
> +		break;
> +	}
> +	up_write(&bpf_crypto_types_sem);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(bpf_crypto_unregister_type);
> +
> +static const struct bpf_crypto_type *bpf_crypto_get_type(const char *name)
> +{
> +	const struct bpf_crypto_type *type = ERR_PTR(-ENOENT);
> +	struct bpf_crypto_type_list *node;
> +
> +	down_read(&bpf_crypto_types_sem);
> +	list_for_each_entry(node, &bpf_crypto_types, list) {
> +		if (strcmp(node->type->name, name))
> +			continue;
> +
> +		if (try_module_get(node->type->owner))
> +			type = node->type;
> +		break;
> +	}
> +	up_read(&bpf_crypto_types_sem);
> +
> +	return type;
> +}
> +
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_crypto_ctx_create() - Create a mutable BPF crypto context.
> + *
> + * Allocates a crypto context that can be used, acquired, and released by
> + * a BPF program. The crypto context returned by this function must either
> + * be embedded in a map as a kptr, or freed with bpf_crypto_ctx_release().
> + * As crypto API functions use GFP_KERNEL allocations, this function can
> + * only be used in sleepable BPF programs.
> + *
> + * bpf_crypto_ctx_create() allocates memory for crypto context.
> + * It may return NULL if no memory is available.
> + * @params:	pointer to struct bpf_crypto_params which contains all the
> + *		details needed to initialise crypto context.
> + * @params__sz:	size of steuct bpf_crypto_params usef by bpf program
> + * @err:	integer to store error code when NULL is returned.
> + */
> +__bpf_kfunc struct bpf_crypto_ctx *
> +bpf_crypto_ctx_create(const struct bpf_crypto_params *params, u32 params__sz,
> +		      int *err)
> +{
> +	const struct bpf_crypto_type *type;
> +	struct bpf_crypto_ctx *ctx;
> +
> +	if (!params || params->reserved[0] || params->reserved[1] ||
> +	    params__sz != sizeof(struct bpf_crypto_params)) {
> +		*err = -EINVAL;
> +		return NULL;
> +	}
> +
> +	type = bpf_crypto_get_type(params->type);
> +	if (IS_ERR(type)) {
> +		*err = PTR_ERR(type);
> +		return NULL;
> +	}
> +
> +	if (!type->has_algo(params->algo)) {
> +		*err = -EOPNOTSUPP;
> +		goto err_module_put;
> +	}
> +
> +	if (!!params->authsize ^ !!type->setauthsize) {
> +		*err = -EOPNOTSUPP;
> +		goto err_module_put;
> +	}
> +
> +	if (!params->key_len || params->key_len > sizeof(params->key)) {
> +		*err = -EINVAL;
> +		goto err_module_put;
> +	}
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx) {
> +		*err = -ENOMEM;
> +		goto err_module_put;
> +	}
> +
> +	ctx->type = type;
> +	ctx->tfm = type->alloc_tfm(params->algo);
> +	if (IS_ERR(ctx->tfm)) {
> +		*err = PTR_ERR(ctx->tfm);
> +		goto err_free_ctx;
> +	}
> +
> +	if (params->authsize) {
> +		*err = type->setauthsize(ctx->tfm, params->authsize);
> +		if (*err)
> +			goto err_free_tfm;
> +	}
> +
> +	*err = type->setkey(ctx->tfm, params->key, params->key_len);
> +	if (*err)
> +		goto err_free_tfm;
> +
> +	if (type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY) {
> +		*err = -EINVAL;
> +		goto err_free_tfm;
> +	}
> +
> +	ctx->siv_len = type->ivsize(ctx->tfm) + type->statesize(ctx->tfm);
> +
> +	refcount_set(&ctx->usage, 1);
> +
> +	return ctx;
> +
> +err_free_tfm:
> +	type->free_tfm(ctx->tfm);
> +err_free_ctx:
> +	kfree(ctx);
> +err_module_put:
> +	module_put(type->owner);
> +
> +	return NULL;
> +}
> +
> +static void crypto_free_cb(struct rcu_head *head)
> +{
> +	struct bpf_crypto_ctx *ctx;
> +
> +	ctx = container_of(head, struct bpf_crypto_ctx, rcu);
> +	ctx->type->free_tfm(ctx->tfm);
> +	module_put(ctx->type->owner);
> +	kfree(ctx);
> +}
> +
> +/**
> + * bpf_crypto_ctx_acquire() - Acquire a reference to a BPF crypto context.
> + * @ctx: The BPF crypto context being acquired. The ctx must be a trusted
> + *	     pointer.
> + *
> + * Acquires a reference to a BPF crypto context. The context returned by this function
> + * must either be embedded in a map as a kptr, or freed with
> + * bpf_crypto_skcipher_ctx_release().

The release function name is incorrect. It should be bpf_crypto_ctx_release().

> + */
> +__bpf_kfunc struct bpf_crypto_ctx *
> +bpf_crypto_ctx_acquire(struct bpf_crypto_ctx *ctx)
> +{
> +	if (!refcount_inc_not_zero(&ctx->usage))
> +		return NULL;
> +	return ctx;
> +}
> +
> +/**
> + * bpf_crypto_ctx_release() - Release a previously acquired BPF crypto context.
> + * @ctx: The crypto context being released.
> + *
> + * Releases a previously acquired reference to a BPF crypto context. When the final
> + * reference of the BPF crypto context has been released, it is subsequently freed in
> + * an RCU callback in the BPF memory allocator.

The BPF memory allocator part is incorrect.

I don't think the bpf prog writer needs to worry about the RCU callback details 
also.

> + */
> +__bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
> +{
> +	if (refcount_dec_and_test(&ctx->usage))
> +		call_rcu(&ctx->rcu, crypto_free_cb);
> +}
> +
> +static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
> +			    const struct bpf_dynptr_kern *src,
> +			    struct bpf_dynptr_kern *dst,
> +			    const struct bpf_dynptr_kern *siv,
> +			    bool decrypt)
> +{
> +	u32 src_len, dst_len, siv_len;
> +	const u8 *psrc;
> +	u8 *pdst, *piv;
> +	int err;
> +
> +	if (__bpf_dynptr_is_rdonly(dst))
> +		return -EINVAL;
> +
> +	siv_len = __bpf_dynptr_size(siv);
> +	src_len = __bpf_dynptr_size(src);
> +	dst_len = __bpf_dynptr_size(dst);
> +	if (!src_len || !dst_len)
> +		return -EINVAL;
> +
> +	if (siv_len != ctx->siv_len)
> +		return -EINVAL;
> +
> +	psrc = __bpf_dynptr_data(src, src_len);
> +	if (!psrc)
> +		return -EINVAL;
> +	pdst = __bpf_dynptr_data_rw(dst, dst_len);
> +	if (!pdst)
> +		return -EINVAL;
> +
> +	piv = siv_len ? __bpf_dynptr_data_rw(siv, siv_len) : NULL;
> +	if (siv_len && !piv)
> +		return -EINVAL;
> +
> +	err = decrypt ? ctx->type->decrypt(ctx->tfm, psrc, pdst, src_len, piv)
> +		      : ctx->type->encrypt(ctx->tfm, psrc, pdst, src_len, piv);
> +
> +	return err;
> +}
> +
> +/**
> + * bpf_crypto_decrypt() - Decrypt buffer using configured context and IV provided.
> + * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
> + * @src:	bpf_dynptr to the encrypted data. Must be a trusted pointer.
> + * @dst:	bpf_dynptr to the buffer where to store the result. Must be a trusted pointer.
> + * @siv:	bpf_dynptr to IV data and state data to be used by decryptor.
> + *
> + * Decrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
> + */
> +__bpf_kfunc int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx,
> +				   const struct bpf_dynptr_kern *src,
> +				   struct bpf_dynptr_kern *dst,
> +				   struct bpf_dynptr_kern *siv)

nit. Added const to all "struct bpf_dynptr_kern *". Mostly to follow 
"bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, ...)" which the dynptr 
itself does not change but the data it pointing to could change.

> +{
> +	return bpf_crypto_crypt(ctx, src, dst, siv, true);
> +}
> +
> +/**
> + * bpf_crypto_encrypt() - Encrypt buffer using configured context and IV provided.
> + * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
> + * @src:	bpf_dynptr to the plain data. Must be a trusted pointer.
> + * @dst:	bpf_dynptr to buffer where to store the result. Must be a trusted pointer.
> + * @siv:		bpf_dynptr to IV data and state data to be used by decryptor.

Alignment is off. Fixed.

> + *
> + * Encrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
> + */
> +__bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
> +				   const struct bpf_dynptr_kern *src,
> +				   struct bpf_dynptr_kern *dst,
> +				   struct bpf_dynptr_kern *siv)

Same here. "const struct bpf_dynptr_kern *".

I also fixed the bench in patch 4. Made some adjustment to the percpu map 
comment in patch 3.

Applied. Thanks.



