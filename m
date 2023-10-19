Return-Path: <bpf+bounces-12632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092DE7CECD2
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 02:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351C71C20E32
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 00:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433308F6F;
	Thu, 19 Oct 2023 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D8bdcP7+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1F28F63
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 00:36:17 +0000 (UTC)
Received: from out-201.mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C0FE
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 17:36:16 -0700 (PDT)
Message-ID: <a245d4c4-6eb0-ce54-41aa-4f8c8acf3051@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697675774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svfeXZnS4yc+/OvMqdJe5A9oe+3GQEVWS3h6543MKms=;
	b=D8bdcP7+m1hHdTEZj55585qB5SSm+dVWBAyncS5fff3A0SUlihTUIHg4id7+bC7nVhQS0k
	XVBL/Xse2A583G2G0iIzSMtWhSRXjBBZsQ1/eBYSxmv0Poa9h0g9JOSvtRX6kcad+cLLCi
	WIM9FXGGHRv2Gcg9IaZkibg4qd14THs=
Date: Wed, 18 Oct 2023 17:36:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 3/9] bpf: hold module for bpf_struct_ops_map.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 drosen@google.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-4-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231017162306.176586-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/17/23 9:23 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> To ensure that a module remains accessible whenever a struct_ops object of
> a struct_ops type provided by the module is still in use.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/bpf.h         |  1 +
>   kernel/bpf/bpf_struct_ops.c | 21 ++++++++++++++++++---
>   2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e6a648af2daa..1e1647c8b0ce 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1627,6 +1627,7 @@ struct bpf_struct_ops {
>   	int (*update)(void *kdata, void *old_kdata);
>   	int (*validate)(void *kdata);
>   	struct btf *btf;
> +	struct module *owner;
>   	const struct btf_type *type;
>   	const struct btf_type *value_type;
>   	const char *name;
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 7758f66ad734..b561245fe235 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -112,6 +112,7 @@ static const struct btf_type *module_type;
>   
>   static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
>   				    struct btf *btf,
> +				    struct module *owner,
>   				    struct bpf_verifier_log *log)
>   {
>   	const struct btf_member *member;
> @@ -186,6 +187,7 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
>   				st_ops->name);
>   		} else {
>   			st_ops->btf = btf;
> +			st_ops->owner = owner;

I suspect it will turn out to be just "st_ops->owner = st_ops->owner;" in a 
latter patch. st_ops->owner should have already been initialized (with 
THIS_MODULE?).

>   			st_ops->type_id = type_id;
>   			st_ops->type = t;
>   			st_ops->value_id = value_id;
> @@ -193,6 +195,7 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
>   							    value_id);
>   		}
>   	}
> +

nit. extra newline.

>   }
>   
>   void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
> @@ -215,7 +218,7 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
>   
>   	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
>   		st_ops = bpf_struct_ops[i];
> -		bpf_struct_ops_init_one(st_ops, btf, log);
> +		bpf_struct_ops_init_one(st_ops, btf, NULL, log);
>   	}
>   }
>   
> @@ -630,6 +633,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
>   		bpf_jit_uncharge_modmem(PAGE_SIZE);
>   	}
>   	bpf_map_area_free(st_map->uvalue);
> +	module_put(st_map->st_ops->owner);
>   	bpf_map_area_free(st_map);
>   }
>   
> @@ -676,9 +680,18 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	if (!st_ops)
>   		return ERR_PTR(-ENOTSUPP);
>   
> +	/* If st_ops->owner is NULL, it means the struct_ops is
> +	 * statically defined in the kernel.  We don't need to
> +	 * take a refcount on it.
> +	 */
> +	if (st_ops->owner && !btf_try_get_module(st_ops->btf))

This just came to my mind. Is the module refcnt needed during map alloc/free or 
it could be done during the reg/unreg instead?


> +		return ERR_PTR(-EINVAL);
> +
>   	vt = st_ops->value_type;
> -	if (attr->value_size != vt->size)
> +	if (attr->value_size != vt->size) {
> +		module_put(st_ops->owner);
>   		return ERR_PTR(-EINVAL);
> +	}
>   
>   	t = st_ops->type;
>   
> @@ -689,8 +702,10 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   		(vt->size - sizeof(struct bpf_struct_ops_value));
>   
>   	st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
> -	if (!st_map)
> +	if (!st_map) {
> +		module_put(st_ops->owner);
>   		return ERR_PTR(-ENOMEM);
> +	}
>   
>   	st_map->st_ops = st_ops;
>   	map = &st_map->map;


