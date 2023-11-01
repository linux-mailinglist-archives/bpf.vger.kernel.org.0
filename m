Return-Path: <bpf+bounces-13836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0967DE7AE
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF296B21197
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7A41B274;
	Wed,  1 Nov 2023 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bbnLw2Cl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C41F19BDC
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 21:49:58 +0000 (UTC)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE36110
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 14:49:53 -0700 (PDT)
Message-ID: <dac97b74-5ff1-172b-9cd5-4cdcf07386ec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698875391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJb8fcPkIjKhEUkI+PH0lsooD3YZLY5TV+Qc2cTWciQ=;
	b=bbnLw2ClX7of8ZRikkyHj+Ujov3MslfMkaNc6MUm3eiN4llIaytO7KnWecYksg1kAor520
	s7DFLeyqrJFtimzvU/AHM4++223TEwB3cNdA2iPmOFexLbOAQvHW3WowMEPSRy7So/r8Kg
	okCzJ1oAvZk0ldlyP6vz3aJOfUEEvbg=
Date: Wed, 1 Nov 2023 14:49:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add skcipher API support to TC/XDP
 programs
Content-Language: en-US
To: Vadim Fedorenko <vadfed@meta.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>
References: <20231031134900.1432945-1-vadfed@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231031134900.1432945-1-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/31/23 6:48 AM, Vadim Fedorenko wrote:
> --- /dev/null
> +++ b/kernel/bpf/crypto.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2023 Meta, Inc */
> +#include <linux/bpf.h>
> +#include <linux/bpf_mem_alloc.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/filter.h>
> +#include <linux/scatterlist.h>
> +#include <linux/skbuff.h>
> +#include <crypto/skcipher.h>
> +
> +/**
> + * struct bpf_crypto_skcipher_ctx - refcounted BPF sync skcipher context structure
> + * @tfm:	The pointer to crypto_sync_skcipher struct.
> + * @rcu:	The RCU head used to free the crypto context with RCU safety.
> + * @usage:	Object reference counter. When the refcount goes to 0, the
> + *		memory is released back to the BPF allocator, which provides
> + *		RCU safety.
> + */
> +struct bpf_crypto_skcipher_ctx {
> +	struct crypto_sync_skcipher *tfm;
> +	struct rcu_head rcu;
> +	refcount_t usage;
> +};
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "Global kfuncs as their definitions will be in BTF");
> +
> +static void *__bpf_dynptr_data_ptr(const struct bpf_dynptr_kern *ptr)
> +{
> +	enum bpf_dynptr_type type;
> +
> +	if (!ptr->data)
> +		return NULL;
> +
> +	type = bpf_dynptr_get_type(ptr);
> +
> +	switch (type) {
> +	case BPF_DYNPTR_TYPE_LOCAL:
> +	case BPF_DYNPTR_TYPE_RINGBUF:
> +		return ptr->data + ptr->offset;
> +	case BPF_DYNPTR_TYPE_SKB:
> +		return skb_pointer_if_linear(ptr->data, ptr->offset, __bpf_dynptr_size(ptr));
> +	case BPF_DYNPTR_TYPE_XDP:
> +	{
> +		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset, __bpf_dynptr_size(ptr));

I suspect what it is doing here (for skb and xdp in particular) is very similar 
to bpf_dynptr_slice. Please check if bpf_dynptr_slice(ptr, 0, NULL, sz) will work.


> +		if (!IS_ERR_OR_NULL(xdp_ptr))
> +			return xdp_ptr;
> +
> +		return NULL;
> +	}
> +	default:
> +		WARN_ONCE(true, "unknown dynptr type %d\n", type);
> +		return NULL;
> +	}
> +}
> +
> +/**
> + * bpf_crypto_skcipher_ctx_create() - Create a mutable BPF crypto context.
> + *
> + * Allocates a crypto context that can be used, acquired, and released by
> + * a BPF program. The crypto context returned by this function must either
> + * be embedded in a map as a kptr, or freed with bpf_crypto_skcipher_ctx_release().
> + *
> + * bpf_crypto_skcipher_ctx_create() allocates memory using the BPF memory
> + * allocator, and will not block. It may return NULL if no memory is available.
> + * @algo: bpf_dynptr which holds string representation of algorithm.
> + * @key:  bpf_dynptr which holds cipher key to do crypto.
> + */
> +__bpf_kfunc struct bpf_crypto_skcipher_ctx *
> +bpf_crypto_skcipher_ctx_create(const struct bpf_dynptr_kern *palgo,

Song's patch on __const_str should help on the palgo (which is a string) also:
https://lore.kernel.org/bpf/20231024235551.2769174-4-song@kernel.org/

> +			       const struct bpf_dynptr_kern *pkey, int *err)
> +{
> +	struct bpf_crypto_skcipher_ctx *ctx;
> +	char *algo;
> +
> +	if (__bpf_dynptr_size(palgo) > CRYPTO_MAX_ALG_NAME) {
> +		*err = -EINVAL;
> +		return NULL;
> +	}
> +
> +	algo = __bpf_dynptr_data_ptr(palgo);
> +
> +	if (!crypto_has_skcipher(algo, CRYPTO_ALG_TYPE_SKCIPHER, CRYPTO_ALG_TYPE_MASK)) {
> +		*err = -EOPNOTSUPP;
> +		return NULL;
> +	}
> +
> +	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx) {
> +		*err = -ENOMEM;
> +		return NULL;
> +	}
> +
> +	memset(ctx, 0, sizeof(*ctx));

nit. kzalloc()

> +
> +	ctx->tfm = crypto_alloc_sync_skcipher(algo, 0, 0);
> +	if (IS_ERR(ctx->tfm)) {
> +		*err = PTR_ERR(ctx->tfm);
> +		ctx->tfm = NULL;
> +		goto err;
> +	}
> +
> +	*err = crypto_sync_skcipher_setkey(ctx->tfm, __bpf_dynptr_data_ptr(pkey),
> +					   __bpf_dynptr_size(pkey));
> +	if (*err)
> +		goto err;
> +
> +	refcount_set(&ctx->usage, 1);
> +
> +	return ctx;
> +err:
> +	if (ctx->tfm)
> +		crypto_free_sync_skcipher(ctx->tfm);
> +	kfree(ctx);
> +
> +	return NULL;
> +}

[ ... ]

> +static int bpf_crypto_skcipher_crypt(struct crypto_sync_skcipher *tfm,
> +				     const struct bpf_dynptr_kern *src,
> +				     struct bpf_dynptr_kern *dst,
> +				     const struct bpf_dynptr_kern *iv,
> +				     bool decrypt)
> +{
> +	struct skcipher_request *req = NULL;
> +	struct scatterlist sgin, sgout;
> +	int err;
> +
> +	if (crypto_sync_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
> +		return -EINVAL;
> +
> +	if (__bpf_dynptr_is_rdonly(dst))
> +		return -EINVAL;
> +
> +	if (!__bpf_dynptr_size(dst) || !__bpf_dynptr_size(src))
> +		return -EINVAL;
> +
> +	if (__bpf_dynptr_size(iv) != crypto_sync_skcipher_ivsize(tfm))
> +		return -EINVAL;
> +
> +	req = skcipher_request_alloc(&tfm->base, GFP_ATOMIC);

Doing alloc per packet may kill performance. Is it possible to optimize it 
somehow? What is the usual size of the req (e.g. the example in the selftest)?

> +	if (!req)
> +		return -ENOMEM;
> +
> +	sg_init_one(&sgin, __bpf_dynptr_data_ptr(src), __bpf_dynptr_size(src));
> +	sg_init_one(&sgout, __bpf_dynptr_data_ptr(dst), __bpf_dynptr_size(dst));
> +
> +	skcipher_request_set_crypt(req, &sgin, &sgout, __bpf_dynptr_size(src),
> +				   __bpf_dynptr_data_ptr(iv));
> +
> +	err = decrypt ? crypto_skcipher_decrypt(req) : crypto_skcipher_encrypt(req);

I am hitting this with the selftest in patch 2:

[   39.806675] =============================
[   39.807243] WARNING: suspicious RCU usage
[   39.807825] 6.6.0-rc7-02091-g17e023652cc1 #336 Tainted: G           O
[   39.808798] -----------------------------
[   39.809368] kernel/sched/core.c:10149 Illegal context switch in RCU-bh 
read-side critical section!
[   39.810589]
[   39.810589] other info that might help us debug this:
[   39.810589]
[   39.811696]
[   39.811696] rcu_scheduler_active = 2, debug_locks = 1
[   39.812616] 2 locks held by test_progs/1769:
[   39.813249]  #0: ffffffff84dce140 (rcu_read_lock){....}-{1:3}, at: 
ip6_finish_output2+0x625/0x1b70
[   39.814539]  #1: ffffffff84dce1a0 (rcu_read_lock_bh){....}-{1:3}, at: 
__dev_queue_xmit+0x1df/0x2c40
[   39.815813]
[   39.815813] stack backtrace:
[   39.816441] CPU: 1 PID: 1769 Comm: test_progs Tainted: G           O 
6.6.0-rc7-02091-g17e023652cc1 #336
[   39.817774] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   39.819312] Call Trace:
[   39.819655]  <TASK>
[   39.819967]  dump_stack_lvl+0x130/0x1d0
[   39.822669]  dump_stack+0x14/0x20
[   39.823136]  lockdep_rcu_suspicious+0x220/0x350
[   39.823777]  __might_resched+0xe0/0x660
[   39.827915]  __might_sleep+0x89/0xf0
[   39.828423]  skcipher_walk_virt+0x55/0x120
[   39.828990]  crypto_ecb_decrypt+0x159/0x310
[   39.833846]  crypto_skcipher_decrypt+0xa0/0xd0
[   39.834481]  bpf_crypto_skcipher_crypt+0x29a/0x3c0
[   39.837100]  bpf_crypto_skcipher_decrypt+0x56/0x70
[   39.837770]  bpf_prog_fa576505ab32d186_decrypt_sanity+0x180/0x185
[   39.838627]  cls_bpf_classify+0x3b6/0xf80
[   39.839807]  tcf_classify+0x2f4/0x550

> +
> +	skcipher_request_free(req);
> +
> +	return err;
> +}
> +



