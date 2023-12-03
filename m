Return-Path: <bpf+bounces-16548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C92802678
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 20:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A804A280DAE
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA78179B2;
	Sun,  3 Dec 2023 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oiCifH/n"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [IPv6:2001:41d0:203:375::bb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238FBE8;
	Sun,  3 Dec 2023 11:02:58 -0800 (PST)
Message-ID: <b5547960-c4ef-2b90-0186-a859d18849fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701630176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxq7aIbrJ6AwmWr1/OebIisO2F9yp31b2RngOBMBOEg=;
	b=oiCifH/n2sWY6Hpd+2O+bQvik1y5jeLRfh5DVfSuj4bGr9s6kubIRLUxvZAf0CPzaMj3vb
	8Gsp6rMvtkyhWZRNLu50vCrCR8oDxtykvqEXrykYJjaruXs2uDX+o2JEwKZXe8QWIfcBiE
	tnq2ZhM7soM6Gzot+GWwB6uD+cagc0g=
Date: Sun, 3 Dec 2023 19:02:54 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 1/3] bpf: make common crypto API for TC/XDP
 programs
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Vadim Fedorenko <vadfed@meta.com>
References: <20231202010604.1877561-1-vadfed@meta.com>
 <3bea70d0-94a5-4d41-be15-2e8b5932a3b0@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <3bea70d0-94a5-4d41-be15-2e8b5932a3b0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 02.12.2023 01:48, Martin KaFai Lau wrote:
> On 12/1/23 5:06 PM, Vadim Fedorenko wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index eb447b0a9423..0143ff6c93a1 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1228,6 +1228,7 @@ int bpf_dynptr_check_size(u32 size);
>>   u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
>>   const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
>>   void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
>> +bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
>>   #ifdef CONFIG_BPF_JIT
>>   int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct 
>> bpf_trampoline *tr);
>> diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
>> new file mode 100644
>> index 000000000000..e81bd8ab979c
>> --- /dev/null
>> +++ b/include/linux/bpf_crypto.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>> +#ifndef _BPF_CRYPTO_H
>> +#define _BPF_CRYPTO_H
>> +
>> +struct bpf_crypto_type {
>> +    void *(*alloc_tfm)(const char *algo);
>> +    void (*free_tfm)(void *tfm);
>> +    int (*has_algo)(const char *algo);
>> +    int (*setkey)(void *tfm, const u8 *key, unsigned int keylen);
>> +    int (*setauthsize)(void *tfm, unsigned int authsize);
>> +    int (*encrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
>> +    int (*decrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
>> +    unsigned int (*ivsize)(void *tfm);
>> +    u32 (*get_flags)(void *tfm);
>> +    struct module *owner;
>> +    char name[14];
> 
> Does it have a macro (from crypto ?) that can be reused here instead of a 
> numeric constant?
> 
I have checked AF_ALG which uses the same way and there is no constant
unfortunately:
https://elixir.bootlin.com/linux/v6.7-rc3/source/include/crypto/if_alg.h#L55

Maybe Herbert will suggest some constant instead?

>> +};
>> +
>> +int bpf_crypto_register_type(const struct bpf_crypto_type *type);
>> +int bpf_crypto_unregister_type(const struct bpf_crypto_type *type);
>> +
>> +#endif /* _BPF_CRYPTO_H */
>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>> index f526b7573e97..bcde762bb2c2 100644
>> --- a/kernel/bpf/Makefile
>> +++ b/kernel/bpf/Makefile
>> @@ -41,6 +41,9 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
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
>> index 000000000000..a1e543d1d7fe
>> --- /dev/null
>> +++ b/kernel/bpf/crypto.c
>> @@ -0,0 +1,364 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2023 Meta, Inc */
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
>> +static LIST_HEAD(bpf_crypto_types);
>> +static DECLARE_RWSEM(bpf_crypto_types_sem);
>> +
>> +/**
>> + * struct bpf_crypto_ctx - refcounted BPF crypto context structure
>> + * @type:    The pointer to bpf crypto type
>> + * @tfm:    The pointer to instance of crypto API struct.
>> + * @rcu:    The RCU head used to free the crypto context with RCU safety.
>> + * @usage:    Object reference counter. When the refcount goes to 0, the
>> + *        memory is released back to the BPF allocator, which provides
>> + *        RCU safety.
>> + */
>> +struct bpf_crypto_ctx {
>> +    const struct bpf_crypto_type *type;
>> +    void *tfm;
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
>> +static const struct bpf_crypto_type *bpf_crypto_get_type(const char *name)
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
> 
> If I read patch 2 correctly, it is always built-in. I am not sure I understand 
> the module_put/get in this patch.

Well, yeah, right now it's built-in, but it can be easily converted to module
with it's own Kconfig option. Especially if we think about adding aead crypto
and using bpf in embedded setups with less amount of resources.

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
>> + * @pkey:      bpf_dynptr which holds cipher key to do crypto.
>> + * @err:       integer to store error code when NULL is returned
>> + */
>> +__bpf_kfunc struct bpf_crypto_ctx *
>> +bpf_crypto_ctx_create(const char *type__str, const char *algo__str,
>> +              const struct bpf_dynptr_kern *pkey,
>> +              unsigned int authsize, int *err)
>> +{
>> +    const struct bpf_crypto_type *type = bpf_crypto_get_type(type__str);
>> +    struct bpf_crypto_ctx *ctx;
>> +    const u8 *key;
>> +    u32 key_len;
>> +
>> +    type = bpf_crypto_get_type(type__str);
>> +    if (IS_ERR(type)) {
>> +        *err = PTR_ERR(type);
>> +        return NULL;
>> +    }
>> +
>> +    if (!type->has_algo(algo__str)) {
>> +        *err = -EOPNOTSUPP;
>> +        goto err;
> 
> ctx is still not initialized. The error path will crash.

good catch, thanks!

>> +    }
>> +
>> +    if (!authsize && type->setauthsize) {
>> +        *err = -EOPNOTSUPP;
>> +        goto err;
>> +    }
>> +
>> +    if (authsize && !type->setauthsize) {
>> +        *err = -EOPNOTSUPP;
>> +        goto err;
>> +    }
>> +
>> +    key_len = __bpf_dynptr_size(pkey);
>> +    if (!key_len) {
>> +        *err = -EINVAL;
>> +        goto err;
>> +    }
>> +    key = __bpf_dynptr_data(pkey, key_len);
>> +    if (!key) {
>> +        *err = -EINVAL;
>> +        goto err;
>> +    }
>> +
>> +    ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>> +    if (!ctx) {
>> +        *err = -ENOMEM;
>> +        goto err;
>> +    }
>> +
>> +    ctx->type = type;
>> +    ctx->tfm = type->alloc_tfm(algo__str);
>> +    if (IS_ERR(ctx->tfm)) {
>> +        *err = PTR_ERR(ctx->tfm);
>> +        ctx->tfm = NULL;
>> +        goto err;
>> +    }
>> +
>> +    if (authsize) {
>> +        *err = type->setauthsize(ctx->tfm, authsize);
>> +        if (*err)
>> +            goto err;
>> +    }
>> +
>> +    *err = type->setkey(ctx->tfm, key, key_len);
>> +    if (*err)
>> +        goto err;
>> +
>> +    refcount_set(&ctx->usage, 1);
>> +
>> +    return ctx;
>> +err:
>> +    if (ctx->tfm)
>> +        type->free_tfm(ctx->tfm);
>> +    kfree(ctx);
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
>> + * bpf_crypto_ctx_acquire() - Acquire a reference to a BPF crypto context.
>> + * @ctx: The BPF crypto context being acquired. The ctx must be a trusted
>> + *         pointer.
>> + *
>> + * Acquires a reference to a BPF crypto context. The context returned by this 
>> function
>> + * must either be embedded in a map as a kptr, or freed with
>> + * bpf_crypto_skcipher_ctx_release().
>> + */
>> +__bpf_kfunc struct bpf_crypto_ctx *
>> +bpf_crypto_ctx_acquire(struct bpf_crypto_ctx *ctx)
>> +{
>> +    refcount_inc(&ctx->usage);
>> +    return ctx;
>> +}
>> +
>> +/**
>> + * bpf_crypto_ctx_release() - Release a previously acquired BPF crypto context.
>> + * @ctx: The crypto context being released.
>> + *
>> + * Releases a previously acquired reference to a BPF crypto context. When the 
>> final
>> + * reference of the BPF crypto context has been released, it is subsequently 
>> freed in
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
>> +                const struct bpf_dynptr_kern *iv,
>> +                bool decrypt)
>> +{
>> +    u32 src_len, dst_len, iv_len;
>> +    const u8 *psrc;
>> +    u8 *pdst, *piv;
>> +    int err;
>> +
>> +    if (ctx->type->get_flags(ctx->tfm) & CRYPTO_TFM_NEED_KEY)
>> +        return -EINVAL;
>> +
>> +    if (__bpf_dynptr_is_rdonly(dst))
>> +        return -EINVAL;
>> +
>> +    iv_len = __bpf_dynptr_size(iv);
>> +    src_len = __bpf_dynptr_size(src);
>> +    dst_len = __bpf_dynptr_size(dst);
>> +    if (!src_len || !dst_len)
>> +        return -EINVAL;
>> +
>> +    if (iv_len != ctx->type->ivsize(ctx->tfm))
>> +        return -EINVAL;
>> +
>> +    psrc = __bpf_dynptr_data(src, src_len);
>> +    if (!psrc)
>> +        return -EINVAL;
>> +    pdst = __bpf_dynptr_data_rw(dst, dst_len);
>> +    if (!pdst)
>> +        return -EINVAL;
>> +
>> +    piv = iv_len ? __bpf_dynptr_data_rw(iv, iv_len) : NULL;
>> +    if (iv_len && !piv)
>> +        return -EINVAL;
>> +
>> +    err = decrypt ? ctx->type->decrypt(ctx->tfm, psrc, pdst, src_len, piv)
>> +              : ctx->type->encrypt(ctx->tfm, psrc, pdst, src_len, piv);
>> +
>> +    return err;
>> +}
>> +
>> +/**
>> + * bpf_crypto_decrypt() - Decrypt buffer using configured context and IV 
>> provided.
>> + * @ctx:    The crypto context being used. The ctx must be a trusted pointer.
>> + * @src:    bpf_dynptr to the encrypted data. Must be a trusted pointer.
>> + * @dst:    bpf_dynptr to the buffer where to store the result. Must be a 
>> trusted pointer.
>> + * @iv:        bpf_dynptr to IV data to be used by decryptor.
>> + *
>> + * Decrypts provided buffer using IV data and the crypto context. Crypto 
>> context must be configured.
>> + */
>> +__bpf_kfunc int bpf_crypto_decrypt(struct bpf_crypto_ctx *ctx,
>> +                   const struct bpf_dynptr_kern *src,
>> +                   struct bpf_dynptr_kern *dst,
>> +                   struct bpf_dynptr_kern *iv)
>> +{
>> +    return bpf_crypto_crypt(ctx, src, dst, iv, true);
>> +}
>> +
>> +/**
>> + * bpf_crypto_encrypt() - Encrypt buffer using configured context and IV 
>> provided.
>> + * @ctx:    The crypto context being used. The ctx must be a trusted pointer.
>> + * @src:    bpf_dynptr to the plain data. Must be a trusted pointer.
>> + * @dst:    bpf_dynptr to buffer where to store the result. Must be a trusted 
>> pointer.
>> + * @iv:        bpf_dynptr to IV data to be used by decryptor.
>> + *
>> + * Encrypts provided buffer using IV data and the crypto context. Crypto 
>> context must be configured.
>> + */
>> +__bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
>> +                   const struct bpf_dynptr_kern *src,
>> +                   struct bpf_dynptr_kern *dst,
>> +                   struct bpf_dynptr_kern *iv)
>> +{
>> +    return bpf_crypto_crypt(ctx, src, dst, iv, false);
>> +}
>> +
>> +__bpf_kfunc_end_defs();
>> +
>> +BTF_SET8_START(crypt_init_kfunc_btf_ids)
>> +BTF_ID_FLAGS(func, bpf_crypto_ctx_create, KF_ACQUIRE | KF_RET_NULL | 
>> KF_SLEEPABLE)
>> +BTF_ID_FLAGS(func, bpf_crypto_ctx_release, KF_RELEASE)
>> +BTF_ID_FLAGS(func, bpf_crypto_ctx_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
> 
> Considering bpf_crypto_ctx is rcu protected, the acquire may use "KF_ACQUIRE | 
> KF_RCU | KF_RET_NULL" such that the bpf_crypto_ctx_acquire(ctx_from_map_value) 
> will work and the user will prepare checking NULL from day one.
>

Got it. What about create? Should it also include KF_RCU?


