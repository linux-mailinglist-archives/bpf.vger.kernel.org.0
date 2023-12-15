Return-Path: <bpf+bounces-17964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37570814200
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 07:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7CD1C22313
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 06:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338E9D28F;
	Fri, 15 Dec 2023 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wDarasQ9"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1563BD27D
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5918e180-beb6-43cc-919b-1018efdf06d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702623121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAabUvWVUDumHKqzrIGE4cDELpHSuAO8oKlQsLV2LqQ=;
	b=wDarasQ9SbymyUeiZHT2Qughkv5lWD+uSSLx64gRAnFcSr1htqsm/b5eMtd1oVweTcBvFx
	l9hCbH/Yg9WhZJLEeQvySUhQSugH5oLINNPeSODMbCwoxm8WBfyazKY3DnAgL32rmV/dyf
	yUgLXyC1MY8X1UsjBi9LVtD6l29YRZs=
Date: Thu, 14 Dec 2023 22:51:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 10/14] bpf, net: switch to dynamic
 registration
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-11-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231209002709.535966-11-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/8/23 4:27 PM, thinker.li@gmail.com wrote:
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7384806ee74e..c881befa35f5 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1698,7 +1698,6 @@ struct bpf_struct_ops_desc {
>   #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
>   #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
>   const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
> -void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
>   bool bpf_struct_ops_get(const void *kdata);
>   void bpf_struct_ops_put(const void *kdata);
>   int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
> @@ -1744,10 +1743,6 @@ static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *
>   {
>   	return NULL;
>   }
> -static inline void bpf_struct_ops_init(struct btf *btf,
> -				       struct bpf_verifier_log *log)
> -{
> -}
>   static inline bool bpf_try_module_get(const void *data, struct module *owner)
>   {
>   	return try_module_get(owner);
> @@ -3321,6 +3316,14 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
>   	return prog->aux->func_idx != 0;
>   }
>   
> +int register_bpf_struct_ops(struct bpf_struct_ops *st_ops);

This probably should be in btf.h like register_btf_kfunc_id_set().
and should have an empty implementation when CONFIG_BPF_SYSCALL is not set.

> +
> +#define REGISTER_BPF_STRUCT_OPS(st_ops, type) \

Add comment here to suggest the module writer to use REGISTER_BPF_STRUCT_OPS 
instead of register_bpf_struct_ops().

> +({					      \
> +	BTF_STRUCT_OPS_TYPE_EMIT(type);	      \

Directly use BTF_TYPE_EMIT(struct bpf_struct_ops_##type) here.

Also, is it possible to do the DEFINE_STRUCT_OPS_VALUE_TYPE() type here such 
that the module writer does not need to. It will be nice if 
REGISTER_BPF_STRUCT_OPS does the define value type and emit value type together.

> +	register_bpf_struct_ops(st_ops);      \
> +})
> +
>   enum bpf_struct_ops_state {
>   	BPF_STRUCT_OPS_STATE_INIT,
>   	BPF_STRUCT_OPS_STATE_INUSE,
> @@ -3333,4 +3336,19 @@ struct bpf_struct_ops_common_value {
>   	enum bpf_struct_ops_state state;
>   };
>   
> +/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
> + * the map's value exposed to the userspace and its btf-type-id is
> + * stored at the map->btf_vmlinux_value_type_id.
> + *
> + */
> +#define DEFINE_STRUCT_OPS_VALUE_TYPE(_name)			\
> +struct bpf_struct_ops_##_name {					\
> +	struct bpf_struct_ops_common_value common;		\
> +	struct _name data ____cacheline_aligned_in_smp;		\
> +}
> +
> +int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
> +			     struct btf *btf,
> +			     struct bpf_verifier_log *log);
> +

nit. same as the comment in previous patch 8. Move these up closer to other 
struct_ops structs and functions. bpf_struct_ops_desc_init is implemented in 
bpf_struct_ops.c and it should be in the same CONFIG_BPF_JIT guard earlier in 
this file. Also, where is the empty bpf_struct_ops_desc_init() when 
CONFIG_BPF_JIT is not set?

>   #endif /* _LINUX_BPF_H */
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index e2f4b85cf82a..cabab3db5216 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -12,6 +12,8 @@
>   #include <uapi/linux/bpf.h>
>   
>   #define BTF_TYPE_EMIT(type) ((void)(type *)0)
> +#define BTF_STRUCT_OPS_TYPE_EMIT(type) \
> +	((void)(struct bpf_struct_ops_##type *)0)

Remove this new macro. It is almost the same as BTF_TYPE_EMIT and it is only 
used once in REGISTER_BPF_STRUCT_OPS. module writer will use 
REGISTER_BPF_STRUCT_OPS and no need to figure out what type needs to be emitted.

>   #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
>   
>   /* These need to be macros, as the expressions are used in assembler input */

[ ... ]

>   static const struct bpf_struct_ops_desc *
>   bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
>   {
> +	const struct bpf_struct_ops_desc *st_ops_list;
>   	unsigned int i;
> +	u32 cnt = 0;
>   
> -	if (!value_id || !btf)
> +	if (!value_id)
>   		return NULL;
>   
> -	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		if (bpf_struct_ops[i].value_id == value_id)
> -			return &bpf_struct_ops[i];
> +	st_ops_list = btf_get_struct_ops(btf, &cnt);
> +	for (i = 0; i < cnt; i++) {
> +		if (st_ops_list[i].value_id == value_id)
> +			return &st_ops_list[i];
>   	}
>   
>   	return NULL;
> @@ -266,14 +227,17 @@ bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
>   const struct bpf_struct_ops_desc *
>   bpf_struct_ops_find(struct btf *btf, u32 type_id)
>   {
> +	const struct bpf_struct_ops_desc *st_ops_list;
>   	unsigned int i;
> +	u32 cnt;

cnt is not initialized here. The above bpf_struct_ops_find_value() did init cnt 
to 0 though.

>   
> -	if (!type_id || !btf)
> +	if (!type_id)
>   		return NULL;
>   
> -	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		if (bpf_struct_ops[i].type_id == type_id)
> -			return &bpf_struct_ops[i];
> +	st_ops_list = btf_get_struct_ops(btf, &cnt);
> +	for (i = 0; i < cnt; i++) {

If st_ops_list is NULL, cnt could be anything here. Lets fix patch 4 to set cnt 
to 0 when btf->struct_ops_tab is empty.

> +		if (st_ops_list[i].type_id == type_id)
> +			return &st_ops_list[i];
>   	}
>   
>   	return NULL;
> diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_types.h
> deleted file mode 100644
> index 5678a9ddf817..000000000000
> --- a/kernel/bpf/bpf_struct_ops_types.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* internal file - do not include directly */
> -
> -#ifdef CONFIG_BPF_JIT
> -#ifdef CONFIG_NET
> -BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
> -#endif
> -#ifdef CONFIG_INET
> -#include <net/tcp.h>
> -BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
> -#endif
> -#endif
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index edbe3cbf2dcc..5545dee3ff54 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -19,6 +19,7 @@
>   #include <linux/bpf_verifier.h>
>   #include <linux/btf.h>
>   #include <linux/btf_ids.h>
> +#include <linux/bpf.h>
>   #include <linux/bpf_lsm.h>
>   #include <linux/skmsg.h>
>   #include <linux/perf_event.h>
> @@ -5792,8 +5793,6 @@ struct btf *btf_parse_vmlinux(void)
>   	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
>   	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
>   
> -	bpf_struct_ops_init(btf, log);
> -
>   	refcount_set(&btf->refcnt, 1);
>   
>   	err = btf_alloc_id(btf);
> @@ -8621,11 +8620,21 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
>   	return !strncmp(reg_name, arg_name, cmp_len);
>   }
>   
> +#ifndef CONFIG_BPF_JIT
> +int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
> +			     struct btf *btf,
> +			     struct bpf_verifier_log *log)
> +{
> +	return -ENOTSUPP;
> +}
> +#endif /* CONFIG_BPF_JIT */

ah. It is here. This should be in bpf.h.



