Return-Path: <bpf+bounces-27270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EC68AB81C
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 02:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13D91F2179E
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 00:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3A71113;
	Sat, 20 Apr 2024 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TW8dPeuD"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2950C623
	for <bpf@vger.kernel.org>; Sat, 20 Apr 2024 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713572671; cv=none; b=pJpaoozb0VZNkF1EaM0aO/eqvL7XqlrBy2nETjbUOGeqe93oJdwSekVlPCuFycac4kGcaRWzQ7YUqXWVJA7PlvOGQ1qAhXZcOxfXgZjTPoHdnbjjPos1vJoXg6sq2pQ5zFASIeZJ9YiaOlsU/F4ti6Zxr2gg+Aa7kqmXpUNxxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713572671; c=relaxed/simple;
	bh=XZom9eRU0/Br5iUDIV5K1z1qBGKspiukW33kCKvZCks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqVgCDzctqVfnNcOlHAB8FSJncuKSsKIX8nt7ojptKXxOcRzFbTW7vtesSAyKHSHX7aBgQgmyM3CCUpmdfOVRmzKbYU10vFapsPQoqXAWYC3b5C97HJY02WREdYzxK8VEl/idZlYraJZmDJf71VI9elj3/2FuJmMzVOH1XF6mlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TW8dPeuD; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <89a92b51-fbfe-4eab-840c-c27174b7f3a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713572666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RY3hiUFR7II5ASu3ER9K1+B2V4GiZaAI3dEOO3RSMEw=;
	b=TW8dPeuDvt6UsxE9oDN/zp8PptpzifTBeWIewQtY5Hmgv4PILxyyYXufoBZM6lAWvkEIyL
	MrfZ+fVqbLtUT0ljSpKcEZqa8Dh09zYNPKZ0f+Su+sGtxid44Dqq33HuHuDDKE3Y3zHEKy
	26/Ci9pnyewfV9l/n0gTxoftEbAD5Ls=
Date: Sat, 20 Apr 2024 01:24:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 1/4] bpf: make common crypto API for TC/XDP
 programs
To: Martin KaFai Lau <martin.lau@linux.dev>, Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org
References: <20240416204004.3942393-1-vadfed@meta.com>
 <20240416204004.3942393-2-vadfed@meta.com>
 <adf36f26-76b7-4c57-8caf-82f4bb98f017@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <adf36f26-76b7-4c57-8caf-82f4bb98f017@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 19/04/2024 19:57, Martin KaFai Lau wrote:
> On 4/16/24 1:40 PM, Vadim Fedorenko wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 5034c1b4ded7..acc479c13f52 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1265,6 +1265,7 @@ int bpf_dynptr_check_size(u32 size);
>>   u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
>>   const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 
>> len);
>>   void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
>> +bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
>>   #ifdef CONFIG_BPF_JIT
>>   int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct 
>> bpf_trampoline *tr);
>> diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
>> new file mode 100644
>> index 000000000000..a41e71d4e2d9
>> --- /dev/null
>> +++ b/include/linux/bpf_crypto.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
>> +#ifndef _BPF_CRYPTO_H
>> +#define _BPF_CRYPTO_H
>> +
>> +struct bpf_crypto_type {
>> +    void *(*alloc_tfm)(const char *algo);
>> +    void (*free_tfm)(void *tfm);
>> +    int (*has_algo)(const char *algo);
>> +    int (*setkey)(void *tfm, const u8 *key, unsigned int keylen);
>> +    int (*setauthsize)(void *tfm, unsigned int authsize);
>> +    int (*encrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int 
>> len, u8 *iv);
>> +    int (*decrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int 
>> len, u8 *iv);
>> +    unsigned int (*ivsize)(void *tfm);
>> +    unsigned int (*statesize)(void *tfm);
>> +    u32 (*get_flags)(void *tfm);
>> +    struct module *owner;
>> +    char name[14];
>> +};
>> +
>> +int bpf_crypto_register_type(const struct bpf_crypto_type *type);
>> +int bpf_crypto_unregister_type(const struct bpf_crypto_type *type);
>> +
>> +#endif /* _BPF_CRYPTO_H */
>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>> index 368c5d86b5b7..736bd22e5ce0 100644
>> --- a/kernel/bpf/Makefile
>> +++ b/kernel/bpf/Makefile
>> @@ -44,6 +44,9 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
>>   obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
>>   obj-${CONFIG_BPF_LSM} += bpf_lsm.o
>>   endif
>> +ifeq ($(CONFIG_CRYPTO),y)
>> +obj-$(CONFIG_BPF_SYSCALL) += crypto.o
>> +endif
>>   obj-$(CONFIG_BPF_PRELOAD) += preload/
>>   obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
>> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
>> new file mode 100644
>> index 000000000000..a76d80f37f55
>> --- /dev/null
>> +++ b/kernel/bpf/crypto.c
>> @@ -0,0 +1,377 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2024 Meta, Inc */
>> +#include <linux/bpf.h>
>> +#include <linux/bpf_crypto.h>
>> +#include <linux/bpf_mem_alloc.h>
>> +#include <linux/btf.h>
>> +#include <linux/btf_ids.h>
>> +#include <linux/filter.h>
>> +#include <linux/scatterlist.h>
>> +#include <linux/skbuff.h>
>> +#include <crypto/skcipher.h>
>> +
>> +struct bpf_crypto_type_list {
>> +    const struct bpf_crypto_type *type;
>> +    struct list_head list;
>> +};
>> +
>> +/* BPF crypto initialization parameters struct */
>> +/**
>> + * struct bpf_crypto_params - BPF crypto initialization parameters 
>> structure
>> + * @type:    The string of crypto operation type.
>> + * @algo:    The string of algorithm to initialize.
>> + * @key:    The cipher key used to init crypto algorithm.
>> + * @key_len:    The length of cipher key.
>> + * @authsize:    The length of authentication tag used by algorithm.
>> + */
>> +struct bpf_crypto_params {
>> +    char type[14];
>> +    char algo[128];
>> +    __u8 key[256];
> 
> It should have a two byte hole here. Add
>      __u8 reserved[2];
> 
> and check for 0 in bpf_crypto_ctx_create() in case it could be reused 
> later. The bpf_crypto_ctx_create() should not be called very often.
> 

Sure, I'll add it to have algo, key and other fields aligned to 8 bytes.

>> +    __u32 key_len;
>> +    __u32 authsize;
> 
> I don't think there is tail padding of this struct, so should be fine.
> 
>> +} __attribute__((aligned(8)));
> 
> Does it need aligned(8) here?

Nope, looks like left over after uapi variant.

> 
>> +
>> +static LIST_HEAD(bpf_crypto_types);
>> +static DECLARE_RWSEM(bpf_crypto_types_sem);
>> +
>> +/**
>> + * struct bpf_crypto_ctx - refcounted BPF crypto context structure
>> + * @type:    The pointer to bpf crypto type
>> + * @tfm:    The pointer to instance of crypto API struct.
>> + * @rcu:    The RCU head used to free the crypto context with RCU 
>> safety.
>> + * @usage:    Object reference counter. When the refcount goes to 0, the
>> + *        memory is released back to the BPF allocator, which provides
>> + *        RCU safety.
>> + */
>> +struct bpf_crypto_ctx {
>> +    const struct bpf_crypto_type *type;
>> +    void *tfm;
>> +    u32 siv_len;
>> +    struct rcu_head rcu;
>> +    refcount_t usage;
>> +};
>> +
>> +int bpf_crypto_register_type(const struct bpf_crypto_type *type)
>> +{
>> +    struct bpf_crypto_type_list *node;
>> +    int err = -EEXIST;
>> +
>> +    down_write(&bpf_crypto_types_sem);
>> +    list_for_each_entry(node, &bpf_crypto_types, list) {
>> +        if (!strcmp(node->type->name, type->name))
>> +            goto unlock;
>> +    }
>> +
>> +    node = kmalloc(sizeof(*node), GFP_KERNEL);
>> +    err = -ENOMEM;
>> +    if (!node)
>> +        goto unlock;
>> +
>> +    node->type = type;
>> +    list_add(&node->list, &bpf_crypto_types);
>> +    err = 0;
>> +
>> +unlock:
>> +    up_write(&bpf_crypto_types_sem);
>> +
>> +    return err;
>> +}
>> +EXPORT_SYMBOL_GPL(bpf_crypto_register_type);
>> +
>> +int bpf_crypto_unregister_type(const struct bpf_crypto_type *type)
>> +{
>> +    struct bpf_crypto_type_list *node;
>> +    int err = -ENOENT;
>> +
>> +    down_write(&bpf_crypto_types_sem);
>> +    list_for_each_entry(node, &bpf_crypto_types, list) {
>> +        if (strcmp(node->type->name, type->name))
>> +            continue;
>> +
>> +        list_del(&node->list);
>> +        kfree(node);
>> +        err = 0;
>> +        break;
>> +    }
>> +    up_write(&bpf_crypto_types_sem);
>> +
>> +    return err;
>> +}
>> +EXPORT_SYMBOL_GPL(bpf_crypto_unregister_type);
>> +
>> +static const struct bpf_crypto_type *bpf_crypto_get_type(const char 
>> *name)
>> +{
>> +    const struct bpf_crypto_type *type = ERR_PTR(-ENOENT);
>> +    struct bpf_crypto_type_list *node;
>> +
>> +    down_read(&bpf_crypto_types_sem);
>> +    list_for_each_entry(node, &bpf_crypto_types, list) {
>> +        if (strcmp(node->type->name, name))
>> +            continue;
>> +
>> +        if (try_module_get(node->type->owner))
>> +            type = node->type;
>> +        break;
>> +    }
>> +    up_read(&bpf_crypto_types_sem);
>> +
>> +    return type;
>> +}
>> +
>> +__bpf_kfunc_start_defs();
>> +
>> +/**
>> + * bpf_crypto_ctx_create() - Create a mutable BPF crypto context.
>> + *
>> + * Allocates a crypto context that can be used, acquired, and 
>> released by
>> + * a BPF program. The crypto context returned by this function must 
>> either
>> + * be embedded in a map as a kptr, or freed with 
>> bpf_crypto_ctx_release().
>> + * As crypto API functions use GFP_KERNEL allocations, this function can
>> + * only be used in sleepable BPF programs.
>> + *
>> + * bpf_crypto_ctx_create() allocates memory for crypto context.
>> + * It may return NULL if no memory is available.
>> + * @params: pointer to struct bpf_crypto_params which contains all the
>> + *          details needed to initialise crypto context.
>> + * @err:    integer to store error code when NULL is returned.
>> + */
>> +__bpf_kfunc struct bpf_crypto_ctx *
>> +bpf_crypto_ctx_create(const struct bpf_crypto_params *params, int *err)
> 
> Add a "u32 params__sz" arg in case that the params struct will have 
> addition.
> Take a look at how opts__sz is checked in nf_conntrack_bpf.c.
> 

nf_conntrack uses hard-coded value, while xfrm code uses
sizeof(struct bpf_xfrm_state_opts), which one is better?

>> +{
>> +    const struct bpf_crypto_type *type;
>> +    struct bpf_crypto_ctx *ctx;
>> +
>> +    type = bpf_crypto_get_type(params->type);
>> +    if (IS_ERR(type)) {
>> +        *err = PTR_ERR(type);
>> +        return NULL;
>> +    }
>> +
>> +    if (!type->has_algo(params->algo)) {
>> +        *err = -EOPNOTSUPP;
>> +        goto err_module_put;
>> +    }
>> +
>> +    if (!params->authsize && type->setauthsize) {
>> +        *err = -EOPNOTSUPP;
>> +        goto err_module_put;
>> +    }
>> +
>> +    if (params->authsize && !type->setauthsize) {
> 
> nit. Together with the previous "if" test, replace them with one test like:
> 
>      if (!!params->authsize ^ !!type->setauthsize) {
> 

yep

> 
>> +        *err = -EOPNOTSUPP;
>> +        goto err_module_put;
>> +    }
>> +
>> +    if (!params->key_len) {
> 
> Also checks "|| params->key_len > sizeof(params->key)"

Sure

>> +        *err = -EINVAL;
>> +        goto err_module_put;
>> +    }
>> +
>> +    ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +    if (!ctx) {
>> +        *err = -ENOMEM;
>> +        goto err_module_put;
>> +    }
>> +
>> +    ctx->type = type;
>> +    ctx->tfm = type->alloc_tfm(params->algo);
>> +    if (IS_ERR(ctx->tfm)) {
>> +        *err = PTR_ERR(ctx->tfm);
>> +        goto err_free_ctx;
>> +    }
>> +
>> +    if (params->authsize) {
>> +        *err = type->setauthsize(ctx->tfm, params->authsize);
>> +        if (*err)
>> +            goto err_free_tfm;
>> +    }
>> +
>> +    *err = type->setkey(ctx->tfm, params->key, params->key_len);
>> +    if (*err)
>> +        goto err_free_tfm;
>> +
>> +    if (type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY) {
>> +        *err = -EINVAL;
>> +        goto err_free_tfm;
>> +    }
>> +
>> +    ctx->siv_len = type->ivsize(ctx->tfm) + type->statesize(ctx->tfm);
>> +
>> +    refcount_set(&ctx->usage, 1);
>> +
>> +    return ctx;
>> +
>> +err_free_tfm:
>> +    type->free_tfm(ctx->tfm);
>> +err_free_ctx:
>> +    kfree(ctx);
>> +err_module_put:
>> +    module_put(type->owner);
>> +
>> +    return NULL;
>> +}
>> +
>> +static void crypto_free_cb(struct rcu_head *head)
>> +{
>> +    struct bpf_crypto_ctx *ctx;
>> +
>> +    ctx = container_of(head, struct bpf_crypto_ctx, rcu);
>> +    ctx->type->free_tfm(ctx->tfm);
>> +    module_put(ctx->type->owner);
>> +    kfree(ctx);
>> +}
>> +
>> +/**
>> + * bpf_crypto_ctx_acquire() - Acquire a reference to a BPF crypto 
>> context.
>> + * @ctx: The BPF crypto context being acquired. The ctx must be a 
>> trusted
>> + *         pointer.
>> + *
>> + * Acquires a reference to a BPF crypto context. The context returned 
>> by this function
>> + * must either be embedded in a map as a kptr, or freed with
>> + * bpf_crypto_skcipher_ctx_release().
>> + */
>> +__bpf_kfunc struct bpf_crypto_ctx *
>> +bpf_crypto_ctx_acquire(struct bpf_crypto_ctx *ctx)
>> +{
>> +    if (!refcount_inc_not_zero(&ctx->usage))
>> +        return NULL;
>> +    return ctx;
>> +}
>> +
>> +/**
>> + * bpf_crypto_ctx_release() - Release a previously acquired BPF 
>> crypto context.
>> + * @ctx: The crypto context being released.
>> + *
>> + * Releases a previously acquired reference to a BPF crypto context. 
>> When the final
>> + * reference of the BPF crypto context has been released, it is 
>> subsequently freed in
>> + * an RCU callback in the BPF memory allocator.
>> + */
>> +__bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
>> +{
>> +    if (refcount_dec_and_test(&ctx->usage))
>> +        call_rcu(&ctx->rcu, crypto_free_cb);
>> +}
>> +
>> +static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
>> +                const struct bpf_dynptr_kern *src,
>> +                struct bpf_dynptr_kern *dst,
>> +                const struct bpf_dynptr_kern *siv,
>> +                bool decrypt)
>> +{
>> +    u32 src_len, dst_len, siv_len;
>> +    const u8 *psrc;
>> +    u8 *pdst, *piv;
>> +    int err;
>> +
>> +    if (__bpf_dynptr_is_rdonly(dst))
>> +        return -EINVAL;
>> +
>> +    siv_len = __bpf_dynptr_size(siv);
>> +    src_len = __bpf_dynptr_size(src);
>> +    dst_len = __bpf_dynptr_size(dst);
>> +    if (!src_len || !dst_len)
>> +        return -EINVAL;
>> +
>> +    if (siv_len != ctx->siv_len)
>> +        return -EINVAL;
>> +
>> +    psrc = __bpf_dynptr_data(src, src_len);
>> +    if (!psrc)
>> +        return -EINVAL;
>> +    pdst = __bpf_dynptr_data_rw(dst, dst_len);
>> +    if (!pdst)
>> +        return -EINVAL;
>> +
>> +    piv = siv_len ? __bpf_dynptr_data_rw(siv, siv_len) : NULL;
> 
> It has been a while. I don't remember if it has already been brought up 
> before.
> 
> The "const struct bpf_dynptr_kern *siv" here is essentially an optional 
> pointer. Allowing NULL is a more intuitive usage instead of passing a 
> 0-len dynptr. The verifier needs some changes to take __nullable suffix 
> for "struct bpf_dynptr_kern *siv__nullable". This could be a follow up 
> to relax the restriction to allow NULL and not necessary in this set.
>

I think we have already discussed and agreed to have follow up once this 
part is merged.


>> +    if (siv_len && !piv)
>> +        return -EINVAL;
>> +
>> +    err = decrypt ? ctx->type->decrypt(ctx->tfm, psrc, pdst, src_len, 
>> piv)
>> +              : ctx->type->encrypt(ctx->tfm, psrc, pdst, src_len, piv);
>> +
>> +    return err;
>> +}
> 
> 


