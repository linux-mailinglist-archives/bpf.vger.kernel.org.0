Return-Path: <bpf+bounces-10087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEDC7A0FA6
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1601C2109E
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D271426E24;
	Thu, 14 Sep 2023 21:14:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A898266CB
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:14:53 +0000 (UTC)
Received: from out-221.mta1.migadu.com (out-221.mta1.migadu.com [95.215.58.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEE026B2
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:14:52 -0700 (PDT)
Message-ID: <208035ba-3016-c9ba-92e4-fe2cee797ca8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694726091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yaE0JpSacjtdhjgopBFnoXJKj/c/kqt2YCQizRf+ziY=;
	b=f/7GxnwZXfQCR9WvStvW3pytZOSdzP495FYiZ4lmftT3yIz6ZTFlzuZYDCgxjaAtippLNo
	DpoHms+ZPNGNCUd0qX8I5uvLMRRKx560FQuzzxVK+7chvvPmvA/eCpu7UCDv+ZEum2GijO
	N7yrZOdsjlUyr6ZrPGYwaL3Lqbhx+nI=
Date: Thu, 14 Sep 2023 14:14:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Charge modmem for struct_ops trampoline
Content-Language: en-US
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20230913222632.3312183-1-song@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230913222632.3312183-1-song@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/13/23 3:26 PM, Song Liu wrote:
> Current code charges modmem for regular trampoline, but not for struct_ops
> trampoline. Add bpf_jit_[charge|uncharge]_modmem() to struct_ops so the
> trampoline is charged in both cases.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>   kernel/bpf/bpf_struct_ops.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index fdc3e8705a3c..ea6ca87a2ed9 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -615,7 +615,10 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
>   	if (st_map->links)
>   		bpf_struct_ops_map_put_progs(st_map);
>   	bpf_map_area_free(st_map->links);
> -	bpf_jit_free_exec(st_map->image);
> +	if (st_map->image) {
> +		bpf_jit_free_exec(st_map->image);
> +		bpf_jit_uncharge_modmem(PAGE_SIZE);
> +	}
>   	bpf_map_area_free(st_map->uvalue);
>   	bpf_map_area_free(st_map);
>   }
> @@ -657,6 +660,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	struct bpf_struct_ops_map *st_map;
>   	const struct btf_type *t, *vt;
>   	struct bpf_map *map;
> +	int ret;
>   
>   	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
>   	if (!st_ops)
> @@ -681,6 +685,12 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	st_map->st_ops = st_ops;
>   	map = &st_map->map;
>   
> +	ret = bpf_jit_charge_modmem(PAGE_SIZE);
> +	if (ret) {
> +		__bpf_struct_ops_map_free(map);
> +		return ERR_PTR(ret);
> +	}


This just came to my mind when reading it again.

It will miss a bpf_jit_uncharge_modmem() if the bpf_jit_alloc_exec() at a few 
lines below did fail (meaning st_map->image is NULL). It is because the 
__bpf_struct_ops_map_free() only uncharge if st_map->image is not NULL.

How above moving the bpf_jit_alloc_exec() to here (immediately after 
bpf_jit_charge_modem succeeded). Like,

	st_map->image = bpf_jit_alloc_exec(PAGE_SIZE);
	if (!st_map->image) {
		bpf_jit_uncharge_modmem(PAGE_SIZE);
		__bpf_struct_ops_map_free(map);
		return ERR_PTR(-ENOMEM);
	}

Then there is also no need to test 'if (st_map->image)' in 
__bpf_struct_ops_map_free().

> +
>   	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
>   	st_map->links =
>   		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_links *),
> @@ -907,4 +917,3 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>   	kfree(link);
>   	return err;
>   }
> -


