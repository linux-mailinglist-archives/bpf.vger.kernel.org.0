Return-Path: <bpf+bounces-16190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0D57FE27A
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 22:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4085A282305
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 21:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1534CB39;
	Wed, 29 Nov 2023 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aN1S1hp0"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC810D0
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 13:53:35 -0800 (PST)
Message-ID: <0d0ff71c-d82d-4214-859c-77876f0fc050@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701294813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rslo3V8ZqVfSJZBjHejgPme02WjylEhdGhl+qTwlIKY=;
	b=aN1S1hp0dlHgVyqK/Fs3tzbbOnvJ0coxD1og/0t5icaXcHydIRykwJZaJRK9kHrUYJsWDs
	J4Z1W+BhuQh3wRlUImlnJ5e5t3LkzEdUB1rpQxyOWgyz81toFmXkgS9eFwtAFEi9c8uULj
	Q9pq5G5lcGYCJ+uRrDgMdr+dQAzNPtY=
Date: Wed, 29 Nov 2023 13:53:25 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/3] bpf: make common crypto API for TC/XDP
 programs
To: Stanislav Fomichev <sdf@google.com>, Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org
References: <20231129173312.31008-1-vadfed@meta.com>
 <ZWexN5Uf8XbxYkC7@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ZWexN5Uf8XbxYkC7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/11/2023 13:46, Stanislav Fomichev wrote:
> On 11/29, Vadim Fedorenko wrote:
>> Add crypto API support to BPF to be able to decrypt or encrypt packets
>> in TC/XDP BPF programs. Special care should be taken for initialization
>> part of crypto algo because crypto alloc) doesn't work with preemtion
>> disabled, it can be run only in sleepable BPF program. Also async crypto
>> is not supported because of the very same issue - TC/XDP BPF programs
>> are not sleepable.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>
>> ---
>> v5 -> v6:
>> - replace lskcipher with infrastructure to provide pluggable cipher
>>    types
>> - add BPF skcipher as plug-in module in a separate patch
>> v4 -> v5:
>> - replace crypto API to use lskcipher (suggested by Herbert Xu)
>> - remove SG list usage and provide raw buffers
>> v3 -> v4:
>> - reuse __bpf_dynptr_data and remove own implementation
>> - use const __str to provide algorithm name
>> - use kfunc macroses to avoid compilator warnings
>> v2 -> v3:
>> - fix kdoc issues
>> v1 -> v2:
>> - use kmalloc in sleepable func, suggested by Alexei
>> - use __bpf_dynptr_is_rdonly() to check destination, suggested by Jakub
>> - use __bpf_dynptr_data_ptr() for all dynptr accesses
>> ---
>>   include/linux/bpf.h        |   1 +
>>   include/linux/bpf_crypto.h |  23 +++
>>   kernel/bpf/Makefile        |   3 +
>>   kernel/bpf/crypto.c        | 364 +++++++++++++++++++++++++++++++++++++
>>   kernel/bpf/helpers.c       |   2 +-
>>   kernel/bpf/verifier.c      |   1 +
>>   6 files changed, 393 insertions(+), 1 deletion(-)
>>   create mode 100644 include/linux/bpf_crypto.h
>>   create mode 100644 kernel/bpf/crypto.c
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index eb447b0a9423..0143ff6c93a1 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1228,6 +1228,7 @@ int bpf_dynptr_check_size(u32 size);
>>   u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
>>   const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
>>   void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
>> +bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
>>   
>>   #ifdef CONFIG_BPF_JIT
>>   int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
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
>> +	void *(*alloc_tfm)(const char *algo);
>> +	void (*free_tfm)(void *tfm);
>> +	int (*has_algo)(const char *algo);
>> +	int (*setkey)(void *tfm, const u8 *key, unsigned int keylen);
>> +	int (*setauthsize)(void *tfm, unsigned int authsize);
>> +	int (*encrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
>> +	int (*decrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
>> +	unsigned int (*ivsize)(void *tfm);
>> +	u32 (*get_flags)(void *tfm);
>> +	struct module *owner;
>> +	char name[14];
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
>>   obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
>>   obj-${CONFIG_BPF_LSM} += bpf_lsm.o
>>   endif
>> +ifeq ($(CONFIG_CRYPTO),y)
>> +obj-$(CONFIG_BPF_SYSCALL) += crypto.o
>> +endif
>>   obj-$(CONFIG_BPF_PRELOAD) += preload/
>>   
>>   obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
>> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
>> new file mode 100644
>> index 000000000000..46b4d263e472
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
>> +	const struct bpf_crypto_type *type;
>> +	struct list_head list;
>> +};
>> +
>> +static LIST_HEAD(bpf_crypto_types);
>> +static DECLARE_RWSEM(bpf_crypto_types_sem);
>> +
>> +/**
>> + * struct bpf_crypto_ctx - refcounted BPF crypto context structure
>> + * @type:	The pointer to bpf crypto type
>> + * @tfm:	The pointer to instance of crypto API struct.
>> + * @rcu:	The RCU head used to free the crypto context with RCU safety.
>> + * @usage:	Object reference counter. When the refcount goes to 0, the
>> + *		memory is released back to the BPF allocator, which provides
>> + *		RCU safety.
>> + */
>> +struct bpf_crypto_ctx {
>> +	const struct bpf_crypto_type *type;
>> +	void *tfm;
>> +	struct rcu_head rcu;
>> +	refcount_t usage;
>> +};
>> +
>> +int bpf_crypto_register_type(const struct bpf_crypto_type *type)
>> +{
>> +	struct bpf_crypto_type_list *node;
>> +	int err = -EEXIST;
>> +
>> +	down_write(&bpf_crypto_types_sem);
>> +	list_for_each_entry(node, &bpf_crypto_types, list) {
>> +		if (!strcmp(node->type->name, type->name))
>> +			goto unlock;
>> +	}
>> +
>> +	node = kmalloc(sizeof(*node), GFP_KERNEL);
>> +	err = -ENOMEM;
>> +	if (!node)
>> +		goto unlock;
>> +
>> +	node->type = type;
>> +	list_add(&node->list, &bpf_crypto_types);
>> +	err = 0;
>> +
>> +unlock:
>> +	up_write(&bpf_crypto_types_sem);
>> +
>> +	return err;
>> +}
>> +EXPORT_SYMBOL_GPL(bpf_crypto_register_type);
>> +
>> +int bpf_crypto_unregister_type(const struct bpf_crypto_type *type)
>> +{
>> +	struct bpf_crypto_type_list *node;
>> +	int err = -ENOENT;
>> +
>> +	down_write(&bpf_crypto_types_sem);
>> +	list_for_each_entry(node, &bpf_crypto_types, list) {
>> +		if (strcmp(node->type->name, type->name))
>> +			continue;
>> +
>> +		list_del(&node->list);
>> +		kfree(node);
>> +		err = 0;
>> +		break;
>> +	}
>> +	up_write(&bpf_crypto_types_sem);
>> +
>> +	return err;
>> +}
>> +EXPORT_SYMBOL_GPL(bpf_crypto_unregister_type);
>> +
>> +static const struct bpf_crypto_type *bpf_crypto_get_type(const char *name)
>> +{
>> +	const struct bpf_crypto_type *type = ERR_PTR(-ENOENT);
>> +	struct bpf_crypto_type_list *node;
>> +
>> +	down_read(&bpf_crypto_types_sem);
>> +	list_for_each_entry(node, &bpf_crypto_types, list) {
>> +		if (strcmp(node->type->name, name))
>> +			continue;
>> +
>> +		if (try_module_get(node->type->owner))
>> +			type = node->type;
>> +		break;
>> +	}
>> +	up_read(&bpf_crypto_types_sem);
>> +
>> +	return type;
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
>> + * @pkey:      bpf_dynptr which holds cipher key to do crypto.
>> + * @err:       integer to store error code when NULL is returned
>> + */
>> +__bpf_kfunc struct bpf_crypto_ctx *
>> +bpf_crypto_ctx_create(const char *type__str, const char *algo__str,
>> +		      const struct bpf_dynptr_kern *pkey,
>> +		      unsigned int authsize, int *err)
>> +{
>> +	const struct bpf_crypto_type *type = bpf_crypto_get_type(type__str);
>> +	struct bpf_crypto_ctx *ctx;
>> +	const u8 *key;
>> +	u32 key_len;
>> +
>> +	//type = bpf_crypto_get_type(type__str);
> 
> Passing by comment: the line above probably shouldn't start with // ?

Yeah, just spotted this line with Martin, this line should be real code.
I'll fix it in v6, but for now I would like to have some comments about
implementation itself.

