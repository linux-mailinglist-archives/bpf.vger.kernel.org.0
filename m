Return-Path: <bpf+bounces-10814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A857AE22E
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 81362281637
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17982629F;
	Mon, 25 Sep 2023 23:23:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE726292
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 23:23:48 +0000 (UTC)
Received: from out-190.mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0742C0
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:23:46 -0700 (PDT)
Message-ID: <8393a1f3-b4cf-9e4c-ce76-4b09a3f1622b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695684224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ei3LveTbzw6U4jJvoU6qtsaPNVWUrcodFabxouX/M20=;
	b=I91V25ywHnPtsLKyV8UQ6CfuQW/wCHFsiWIaPsQlIv+Sm4R5W0mAcNTYCw0V+vt/iBoYSp
	lYMLUmPILlG0B32rZtDgNd0OMUE45XtfCSOv9zfUI6P3vLrj+vAeiqCr0tmZR+Tpb9sA0s
	ZlsPa9RaSdWf8y0mV956MCIHSKy09Xs=
Date: Mon, 25 Sep 2023 16:23:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 05/11] bpf: hold module for bpf_struct_ops_map.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-6-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230920155923.151136-6-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Ensure a module doesn't go away when a struct_ops object is still alive,
> being a struct_ops type that is registered by the module.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/bpf.h         | 1 +
>   kernel/bpf/bpf_struct_ops.c | 6 ++++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0776cb584b3f..faaec20156f1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1627,6 +1627,7 @@ struct bpf_struct_ops {
>   	int (*update)(void *kdata, void *old_kdata);
>   	int (*validate)(void *kdata);
>   	const struct btf *btf;
> +	struct module *owner;
>   	const struct btf_type *type;
>   	const struct btf_type *value_type;
>   	const char *name;
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 7c2ef53687ef..ef8a1edec891 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -632,6 +632,8 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
>   
>   static void bpf_struct_ops_map_free(struct bpf_map *map)
>   {
> +	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
> +
>   	/* The struct_ops's function may switch to another struct_ops.
>   	 *
>   	 * For example, bpf_tcp_cc_x->init() may switch to
> @@ -649,6 +651,7 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
>   	 */
>   	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
>   
> +	module_put(st_map->st_ops->owner);
>   	__bpf_struct_ops_map_free(map);
>   }
>   
> @@ -673,6 +676,9 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	if (!st_ops)
>   		return ERR_PTR(-ENOTSUPP);
>   
> +	if (!try_module_get(st_ops->owner))
> +		return ERR_PTR(-EINVAL);

The module can be gone at this point?
I don't think try_module_get is safe. btf_try_get_module should be used instead.

> +
>   	vt = st_ops->value_type;
>   	if (attr->value_size != vt->size)
>   		return ERR_PTR(-EINVAL);


