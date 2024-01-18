Return-Path: <bpf+bounces-19842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2593A832189
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 23:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7A11F2434A
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 22:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1C9321B9;
	Thu, 18 Jan 2024 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rqR6ifsU"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A0331A82
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705616708; cv=none; b=FhzVR0I9kAU3ukAT839T+HjiST7vCRZOJp7zkNqxp7uCpvaHUQ70STgGtgBosoT2tScsIuEj+Pg2RVzj5dDZyNZCySnA1sFMInUBbka83nFLOR4aG1plDp/pA6bpCi5k+jibjjwznNEfyZ9nXBkzY52OEnQABfyu2tnYvOwaLcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705616708; c=relaxed/simple;
	bh=TuUVNMDKnLOrknBJYR1NgHu5j86Z1Qzgu7HmiEZJyo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVmcdNeYyqlxMVhXHnFmyMnrtZGAeIF2wvQo1JRseDzzligDFcMyWMHTnViZBPaTkgix4h0+KVvVKOOpwVnmBWM/dr0EtEubD7uHpBVUi6p0vdHF8X9Kzjn8KkmO3MLQVJ38/yPEkMzLo5F1W7RDMR2oF40iwPHyXE6Vu5bZV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rqR6ifsU; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <be69cc3f-0ded-4c7e-8709-1602807d1914@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705616704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpunguM6elAo7lX2vjISkjRnz4HSLbCW0GHQPTUreMg=;
	b=rqR6ifsUiZxcX1bTGNz6zBbz9lCMkHhQuvNNqDckCBzCx35jM8TOOD8TakuWOWNdGA/feJ
	Z/3cjnjQjaxiStn9R/Ont8X0lZpIarB0BkAOpqXvn+KGzdglaYIwzx8Cg3bmYms1lE0V7D
	/BlLP+v3+t1huEX9TwNbg8Z83DA0i2Q=
Date: Thu, 18 Jan 2024 14:25:00 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v16 11/14] bpf, net: switch to dynamic
 registration
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-12-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240118014930.1992551-12-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1cfbb89944c5..a2522fcfe57c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1700,10 +1700,22 @@ struct bpf_struct_ops_common_value {
>   	enum bpf_struct_ops_state state;
>   };
>   
> +/* This macro helps developer to register a struct_ops type and generate
> + * type information correctly. Developers should use this macro to register
> + * a struct_ops type instead of calling register_bpf_struct_ops() directly.
> + */
> +#define REGISTER_BPF_STRUCT_OPS(st_ops, type)				\

One final nit on this macro. Rename this to register_bpf_struct_ops since it is 
the one will be used a lot, so give it an easier typing name.

> +	({								\
> +		struct bpf_struct_ops_##type {				\
> +			struct bpf_struct_ops_common_value common;	\
> +			struct type data ____cacheline_aligned_in_smp;	\
> +		};							\
> +		BTF_TYPE_EMIT(struct bpf_struct_ops_##type);		\
> +		register_bpf_struct_ops(st_ops);			\

and rename this to __register_bpf_struct_ops. Thanks.

> +	})
> +
>   #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
>   #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
> -const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
> -void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
>   bool bpf_struct_ops_get(const void *kdata);
>   void bpf_struct_ops_put(const void *kdata);
>   int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
> @@ -1745,16 +1757,11 @@ struct bpf_dummy_ops {
>   int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>   			    union bpf_attr __user *uattr);
>   #endif
> +int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
> +			     struct btf *btf,
> +			     struct bpf_verifier_log *log);
>   void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
>   #else
> -static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
> -{
> -	return NULL;
> -}
> -static inline void bpf_struct_ops_init(struct btf *btf,
> -				       struct bpf_verifier_log *log)
> -{
> -}
>   static inline bool bpf_try_module_get(const void *data, struct module *owner)
>   {
>   	return try_module_get(owner);
> @@ -1769,6 +1776,10 @@ static inline int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map,
>   {
>   	return -EINVAL;
>   }
> +static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
> +{
> +	return -EOPNOTSUPP;
> +}

This is added back here which was removed in patch 3...

Others lgtm.


