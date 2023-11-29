Return-Path: <bpf+bounces-16188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A219F7FE244
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 22:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0382CB210CC
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EDA61687;
	Wed, 29 Nov 2023 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QNkQ707E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D74A98
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 13:46:34 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c604d8e6f5so219622a12.2
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 13:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701294393; x=1701899193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RmPgJjUfKbWa+Er855UcJSrqjq1cQ/hlgSQV1H1avp8=;
        b=QNkQ707E/jN1XznYIHUyYHLMMUUr3nulkmY/0b+eBQtVtiSKBYUjMZlNFVOktRwhI8
         GZVKFuLgbG2dHbOLwQOWWECvufhLGmjoYP9EVVdhF4KFw8FitFTdB2PSEDW8DQacaPJg
         9PA92t7KbZH99wLwtJGpVkmzgOqpmyURxSgIOf1wuYLzyF8O8OG9dS90novav6fvlMRU
         Uvk2c6I+HOSUyjH5nNCrzQYVqiOmHulyNOdX1l+29Wis+LmYYIRwADkSMg5D7zVP+eB1
         zqPrf3uW/iiy8SvR9zAy+epjQcgDbalEnQ7+jj/G4BFIrK8sM+VzxZiInDzBA//fuLTC
         a6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701294393; x=1701899193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmPgJjUfKbWa+Er855UcJSrqjq1cQ/hlgSQV1H1avp8=;
        b=audUQ3qWmlVUchu0PctETDvO9Dw5V8OP8oEk8RVPB547wjsbqqHEonV6LCfwS5uuN/
         GIA4SlZgVpE7Bh18f3K+El1EOiwoFWvoxAXqCGVe17sbM3VOzEeaBMXO4lJe1BXfdhHb
         gvLdcLtfRdngT5bvFfZKgCcI7XGPIkNHwDSInNEzD/uMHvZIY/jBD8/ug8y6WdnmRB81
         R0lv10Em7LNVMda4VOE2P9mnvKKtxKfg6005z5idi0V7IBNxOujK2wkagIQlbP7/qH+u
         w2NrifyRdcXUmD76kgusFj7FusMEH8z9KGqtzWJkhigmLcepqG/FCAwViRMFqwi51vIm
         6MdQ==
X-Gm-Message-State: AOJu0YzgFn39lPcbjtAAboYumnUN/c0fYYgstmdpSCnNh8b/tCp6sQl8
	YIM7ICs3KY6kZOLjyGyKRGComv8=
X-Google-Smtp-Source: AGHT+IFKZxbl8PTby1m1BJqUp4BpFOXctibSXmrTYbtne1CQZhCyhYUcTixDWDXC1EWaZLHdDdmGd80=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:4e52:0:b0:5c1:708f:7288 with SMTP id
 o18-20020a634e52000000b005c1708f7288mr3401777pgl.1.1701294393350; Wed, 29 Nov
 2023 13:46:33 -0800 (PST)
Date: Wed, 29 Nov 2023 13:46:31 -0800
In-Reply-To: <20231129173312.31008-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129173312.31008-1-vadfed@meta.com>
Message-ID: <ZWexN5Uf8XbxYkC7@google.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: make common crypto API for TC/XDP programs
From: Stanislav Fomichev <sdf@google.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 11/29, Vadim Fedorenko wrote:
> Add crypto API support to BPF to be able to decrypt or encrypt packets
> in TC/XDP BPF programs. Special care should be taken for initialization
> part of crypto algo because crypto alloc) doesn't work with preemtion
> disabled, it can be run only in sleepable BPF program. Also async crypto
> is not supported because of the very same issue - TC/XDP BPF programs
> are not sleepable.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> ---
> v5 -> v6:
> - replace lskcipher with infrastructure to provide pluggable cipher
>   types
> - add BPF skcipher as plug-in module in a separate patch
> v4 -> v5:
> - replace crypto API to use lskcipher (suggested by Herbert Xu)
> - remove SG list usage and provide raw buffers
> v3 -> v4:
> - reuse __bpf_dynptr_data and remove own implementation
> - use const __str to provide algorithm name
> - use kfunc macroses to avoid compilator warnings
> v2 -> v3:
> - fix kdoc issues
> v1 -> v2:
> - use kmalloc in sleepable func, suggested by Alexei
> - use __bpf_dynptr_is_rdonly() to check destination, suggested by Jakub
> - use __bpf_dynptr_data_ptr() for all dynptr accesses
> ---
>  include/linux/bpf.h        |   1 +
>  include/linux/bpf_crypto.h |  23 +++
>  kernel/bpf/Makefile        |   3 +
>  kernel/bpf/crypto.c        | 364 +++++++++++++++++++++++++++++++++++++
>  kernel/bpf/helpers.c       |   2 +-
>  kernel/bpf/verifier.c      |   1 +
>  6 files changed, 393 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/bpf_crypto.h
>  create mode 100644 kernel/bpf/crypto.c
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index eb447b0a9423..0143ff6c93a1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1228,6 +1228,7 @@ int bpf_dynptr_check_size(u32 size);
>  u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
>  const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len);
>  void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
> +bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
>  
>  #ifdef CONFIG_BPF_JIT
>  int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
> diff --git a/include/linux/bpf_crypto.h b/include/linux/bpf_crypto.h
> new file mode 100644
> index 000000000000..e81bd8ab979c
> --- /dev/null
> +++ b/include/linux/bpf_crypto.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +#ifndef _BPF_CRYPTO_H
> +#define _BPF_CRYPTO_H
> +
> +struct bpf_crypto_type {
> +	void *(*alloc_tfm)(const char *algo);
> +	void (*free_tfm)(void *tfm);
> +	int (*has_algo)(const char *algo);
> +	int (*setkey)(void *tfm, const u8 *key, unsigned int keylen);
> +	int (*setauthsize)(void *tfm, unsigned int authsize);
> +	int (*encrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
> +	int (*decrypt)(void *tfm, const u8 *src, u8 *dst, unsigned int len, u8 *iv);
> +	unsigned int (*ivsize)(void *tfm);
> +	u32 (*get_flags)(void *tfm);
> +	struct module *owner;
> +	char name[14];
> +};
> +
> +int bpf_crypto_register_type(const struct bpf_crypto_type *type);
> +int bpf_crypto_unregister_type(const struct bpf_crypto_type *type);
> +
> +#endif /* _BPF_CRYPTO_H */
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index f526b7573e97..bcde762bb2c2 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -41,6 +41,9 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
>  obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
>  obj-${CONFIG_BPF_LSM} += bpf_lsm.o
>  endif
> +ifeq ($(CONFIG_CRYPTO),y)
> +obj-$(CONFIG_BPF_SYSCALL) += crypto.o
> +endif
>  obj-$(CONFIG_BPF_PRELOAD) += preload/
>  
>  obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> new file mode 100644
> index 000000000000..46b4d263e472
> --- /dev/null
> +++ b/kernel/bpf/crypto.c
> @@ -0,0 +1,364 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2023 Meta, Inc */
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
> +static LIST_HEAD(bpf_crypto_types);
> +static DECLARE_RWSEM(bpf_crypto_types_sem);
> +
> +/**
> + * struct bpf_crypto_ctx - refcounted BPF crypto context structure
> + * @type:	The pointer to bpf crypto type
> + * @tfm:	The pointer to instance of crypto API struct.
> + * @rcu:	The RCU head used to free the crypto context with RCU safety.
> + * @usage:	Object reference counter. When the refcount goes to 0, the
> + *		memory is released back to the BPF allocator, which provides
> + *		RCU safety.
> + */
> +struct bpf_crypto_ctx {
> +	const struct bpf_crypto_type *type;
> +	void *tfm;
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
> + * @type__str: pointer to string representation of crypto type.
> + * @algo__str: pointer to string representation of algorithm.
> + * @pkey:      bpf_dynptr which holds cipher key to do crypto.
> + * @err:       integer to store error code when NULL is returned
> + */
> +__bpf_kfunc struct bpf_crypto_ctx *
> +bpf_crypto_ctx_create(const char *type__str, const char *algo__str,
> +		      const struct bpf_dynptr_kern *pkey,
> +		      unsigned int authsize, int *err)
> +{
> +	const struct bpf_crypto_type *type = bpf_crypto_get_type(type__str);
> +	struct bpf_crypto_ctx *ctx;
> +	const u8 *key;
> +	u32 key_len;
> +
> +	//type = bpf_crypto_get_type(type__str);

Passing by comment: the line above probably shouldn't start with // ?

