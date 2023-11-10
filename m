Return-Path: <bpf+bounces-14683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD977E7752
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D357AB21088
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95AA1399;
	Fri, 10 Nov 2023 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QyjcrKPU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C410F2
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 02:19:44 +0000 (UTC)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C96D3AA3
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:19:43 -0800 (PST)
Message-ID: <c2876de6-d726-5a6a-fe65-98c08e7f2b91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699582780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXr3OW+JOqQdCV5G2uN97NaBkYH0dfJ121VxZ3Q01Lw=;
	b=QyjcrKPUYD66No7gYOvd06XhQKZ/ETtw5h8qpYozarvlYRY2HxCCFwhBQfxWi+idCZSP/N
	nauDZ2MxpLWoj+53h7t4Apwz8KhGiPW2zKIomr/1vB5u8YfppqFLNxVTZnjqaNdPCODd75
	IJVs8fVGSfKjhnfU/ouv3NcLnHJ2sbM=
Date: Thu, 9 Nov 2023 18:19:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 10/13] bpf, net: switch to dynamic
 registration
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-11-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231106201252.1568931-11-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 48e97a255945..432c088d4001 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1643,7 +1643,6 @@ struct bpf_struct_ops_desc {
>   #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
>   #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
>   const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
> -void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
>   bool bpf_struct_ops_get(const void *kdata);
>   void bpf_struct_ops_put(const void *kdata);
>   int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
> @@ -1689,10 +1688,6 @@ static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *
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
> @@ -3232,6 +3227,8 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
>   }
>   
>   #ifdef CONFIG_BPF_JIT
> +int register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
> +
>   enum bpf_struct_ops_state {
>   	BPF_STRUCT_OPS_STATE_INIT,
>   	BPF_STRUCT_OPS_STATE_INUSE,
> @@ -3243,6 +3240,23 @@ struct bpf_struct_ops_common_value {
>   	refcount_t refcnt;
>   	enum bpf_struct_ops_state state;
>   };
> +
> +/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
> + * the map's value exposed to the userspace and its btf-type-id is
> + * stored at the map->btf_vmlinux_value_type_id.
> + *
> + */
> +#define DEFINE_STRUCT_OPS_VALUE_TYPE(_name)			\
> +extern struct bpf_struct_ops bpf_##_name;			\

Is it still needed?

> +								\
> +struct bpf_struct_ops_##_name {					\
> +	struct bpf_struct_ops_common_value common;		\
> +	struct _name data ____cacheline_aligned_in_smp;		\
> +}
> +
> +extern int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
> +				    struct btf *btf,
> +				    struct bpf_verifier_log *log);

nit. Remove extern.

>   #endif /* CONFIG_BPF_JIT */
>   
>   #endif /* _LINUX_BPF_H */


