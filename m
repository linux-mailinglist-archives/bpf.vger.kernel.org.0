Return-Path: <bpf+bounces-22346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 825F785CA3F
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 22:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381D32841C6
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 21:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6091C151CFD;
	Tue, 20 Feb 2024 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T6ZUaqcm"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94B151CEA
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465635; cv=none; b=JVj5Uupkpqa5Q/4XTOd3pNau9GA6QnhZjJfhgPmgje1vTHg/bPS1KReb4T7JBZib+N3xi2/S29r5TezNkKMKk0FH81YyBKQC7rcrARvYf+oExtw+ypZxrh7hfB6Przo7bGbDYpF9eVg2RblI5l3H7YtbCmN6QUI3OT0SoOOVVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465635; c=relaxed/simple;
	bh=FJ7qWLx48XetyYj8B173QSb6BJHlkGKwEgVae8G1E/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPPG9gDfsyVO9iJG7f+0a9381NRFZf47G/ywP/lM9KB86pcP3z4FMJ2fhBZNhB8c7qlA4a/2IszXUsxKVYOp8POfOqtXyPAiPvDs6xp5g9Y+8yPdKESspU/pbo4neGbXmHu5iZogcGoGmiycl2RwfakJEZncPUD5W4BDaqe7OAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T6ZUaqcm; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a639c697-bc7d-4a1b-8fcd-7c7ac8dabc7f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708465631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Lrq900nUt8vKHE4ft7I41mKFQkpOY0BQ6/cKTqgD8U=;
	b=T6ZUaqcm7lVtRpSsv1s9tWa6OZnyAMlPMbQocLBAXo5cGNDFa29d3RfaJuNF2uSENkm5Bb
	RmG2lr0Bhl9iYs4Jx9GGIH/H7m1ACynJPBXSnOXJcxcstJdepBs4zerDQLeeCYWVekjvwF
	o7aALRo1marR5HGg0uh2HH3GWsU1+oA=
Date: Tue, 20 Feb 2024 13:47:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: struct_ops supports more than one page
 for trampolines.
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240216182828.201727-1-thinker.li@gmail.com>
 <20240216182828.201727-2-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240216182828.201727-2-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/16/24 10:28 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> The BPF struct_ops previously only allowed for one page to be used for the
> trampolines of all links in a map. However, we have recently run out of
> space due to the large number of BPF program links. By allocating
> additional pages when we exhaust an existing page, we can accommodate more
> links in a single map.
> 
> The variable st_map->image has been changed to st_map->image_pages, and its
> type has been changed to an array of pointers to buffers of PAGE_SIZE. The
> array is dynamically resized and additional pages are allocated when all
> existing pages are exhausted.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   kernel/bpf/bpf_struct_ops.c | 99 ++++++++++++++++++++++++++++++-------
>   1 file changed, 80 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 0d7be97a2411..bb7ae665006a 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -30,12 +30,11 @@ struct bpf_struct_ops_map {
>   	 */
>   	struct bpf_link **links;
>   	u32 links_cnt;
> -	/* image is a page that has all the trampolines
> +	u32 image_pages_cnt;
> +	/* image_pages is an array of pages that has all the trampolines
>   	 * that stores the func args before calling the bpf_prog.
> -	 * A PAGE_SIZE "image" is enough to store all trampoline for
> -	 * "links[]".
>   	 */
> -	void *image;
> +	void **image_pages;
>   	/* The owner moduler's btf. */
>   	struct btf *btf;
>   	/* uvalue->data stores the kernel struct
> @@ -535,7 +534,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	void *udata, *kdata;
>   	int prog_fd, err;
>   	void *image, *image_end;
> -	u32 i;
> +	void **image_pages;
> +	u32 i, next_page = 0;
>   
>   	if (flags)
>   		return -EINVAL;
> @@ -573,8 +573,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   
>   	udata = &uvalue->data;
>   	kdata = &kvalue->data;
> -	image = st_map->image;
> -	image_end = st_map->image + PAGE_SIZE;
> +	image = st_map->image_pages[next_page++];
> +	image_end = image + PAGE_SIZE;
>   
>   	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
>   	for_each_member(i, t, member) {
> @@ -657,6 +657,43 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   							&st_ops->func_models[i],
>   							*(void **)(st_ops->cfi_stubs + moff),
>   							image, image_end);
> +		if (err == -E2BIG) {
> +			/* Use an additional page to try again.
> +			 *
> +			 * It may reuse pages allocated for the previous
> +			 * failed calls.
> +			 */
> +			if (next_page >= st_map->image_pages_cnt) {

This check (more on this later) ...

> +				/* Allocate an additional page */
> +				image_pages = krealloc(st_map->image_pages,
> +						       (st_map->image_pages_cnt + 1) * sizeof(void *),
> +						       GFP_KERNEL);

 From the patch 2 test, one page is enough for at least 20 ops. How about keep 
it simple and allow a max 8 pages which should be much more than enough for sane 
usage. (i.e. add "void *images[MAX_STRUCT_OPS_PAGES];" to "struct 
bpf_struct_ops_map").

> +				if (!image_pages) {
> +					err = -ENOMEM;
> +					goto reset_unlock;
> +				}
> +				st_map->image_pages = image_pages;
> +
> +				err = bpf_jit_charge_modmem(PAGE_SIZE);
> +				if (err)
> +					goto reset_unlock;
> +
> +				image = arch_alloc_bpf_trampoline(PAGE_SIZE);
> +				if (!image) {
> +					bpf_jit_uncharge_modmem(PAGE_SIZE);
> +					err = -ENOMEM;
> +					goto reset_unlock;
> +				}
> +				st_map->image_pages[st_map->image_pages_cnt++] = image;
> +			}
> +			image = st_map->image_pages[next_page++];
> +			image_end = image + PAGE_SIZE;
> +
> +			err = bpf_struct_ops_prepare_trampoline(tlinks, link,
> +								&st_ops->func_models[i],
> +								*(void **)(st_ops->cfi_stubs + moff),
> +								image, image_end);
> +		}
>   		if (err < 0)
>   			goto reset_unlock;
>   
> @@ -667,6 +704,18 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   		*(unsigned long *)(udata + moff) = prog->aux->id;
>   	}
>   
> +	while (next_page < st_map->image_pages_cnt) {

This check and the above "if (next_page >= st_map->image_pages_cnt)" should not 
happen for the common case?

Together with the new comment after the above "if (err == -E2BIG)", is it trying 
to optimize to reuse the pages allocated in the previous error-ed out 
map_update_elem() call?

How about keep it simple for the common case and always free all pages when 
map_update_elem() failed?

Also, after this patch, the same calls are used in different places.

arch_alloc_bpf_trampoline() is done in two different places, one in map_alloc() 
and one in map_update_elem(). How about do all the page alloc in map_update_elem()?

bpf_struct_ops_prepare_trampoline() is also called in two different places 
within the same map_update_elem(). When looking inside the 
bpf_struct_ops_prepare_trampoline(), it does call arch_bpf_trampoline_size() to 
learn the required size first. bpf_struct_ops_prepare_trampoline() should be a 
better place to call arch_alloc_bpf_trampoline() when needed. Then there is no 
need to retry bpf_struct_ops_prepare_trampoline() in map_update_elem()?


> +		/* Free unused pages
> +		 *
> +		 * The value can not be updated anymore if the value is not
> +		 * rejected by st_ops->validate() or st_ops->reg().  So,
> +		 * there is no reason to keep the unused pages.
> +		 */
> +		bpf_jit_uncharge_modmem(PAGE_SIZE);
> +		image = st_map->image_pages[--st_map->image_pages_cnt];
> +		arch_free_bpf_trampoline(image, PAGE_SIZE);
> +	}
> +
>   	if (st_map->map.map_flags & BPF_F_LINK) {
>   		err = 0;
>   		if (st_ops->validate) {
> @@ -674,7 +723,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   			if (err)
>   				goto reset_unlock;
>   		}
> -		arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
> +		for (i = 0; i < next_page; i++)
> +			arch_protect_bpf_trampoline(st_map->image_pages[i],
> +						    PAGE_SIZE);

arch_protect_bpf_trampoline() is called here for BPF_F_LINK.

>   		/* Let bpf_link handle registration & unregistration.
>   		 *
>   		 * Pair with smp_load_acquire() during lookup_elem().
> @@ -683,7 +734,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   		goto unlock;
>   	}
>   
> -	arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
> +	for (i = 0; i < next_page; i++)
> +		arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);

arch_protect_bpf_trampoline() is called here also in the same function for non 
BPF_F_LINK.

Can this be cleaned up a bit? For example, "st_ops->validate(kdata);" should not 
be specific to BPF_F_LINK which had been brought up earlier when making the 
"->validate" optional. It is a good time to clean this up also.

----
pw-bot: cr

>   	err = st_ops->reg(kdata);
>   	if (likely(!err)) {
>   		/* This refcnt increment on the map here after
> @@ -706,7 +758,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	 * there was a race in registering the struct_ops (under the same name) to
>   	 * a sub-system through different struct_ops's maps.
>   	 */
> -	arch_unprotect_bpf_trampoline(st_map->image, PAGE_SIZE);
> +	for (i = 0; i < next_page; i++)
> +		arch_unprotect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
>   
>   reset_unlock:
>   	bpf_struct_ops_map_put_progs(st_map);
> @@ -771,14 +824,15 @@ static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
>   static void __bpf_struct_ops_map_free(struct bpf_map *map)
>   {
>   	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
> +	int i;
>   
>   	if (st_map->links)
>   		bpf_struct_ops_map_put_progs(st_map);
>   	bpf_map_area_free(st_map->links);
> -	if (st_map->image) {
> -		arch_free_bpf_trampoline(st_map->image, PAGE_SIZE);
> -		bpf_jit_uncharge_modmem(PAGE_SIZE);
> -	}
> +	for (i = 0; i < st_map->image_pages_cnt; i++)
> +		arch_free_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
> +	bpf_jit_uncharge_modmem(PAGE_SIZE * st_map->image_pages_cnt);
> +	kfree(st_map->image_pages);
>   	bpf_map_area_free(st_map->uvalue);
>   	bpf_map_area_free(st_map);
>   }
> @@ -888,20 +942,27 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	st_map->st_ops_desc = st_ops_desc;
>   	map = &st_map->map;
>   
> +	st_map->image_pages = kcalloc(1, sizeof(void *), GFP_KERNEL);
> +	if (!st_map->image_pages) {
> +		ret = -ENOMEM;
> +		goto errout_free;
> +	}
> +
>   	ret = bpf_jit_charge_modmem(PAGE_SIZE);
>   	if (ret)
>   		goto errout_free;
>   
> -	st_map->image = arch_alloc_bpf_trampoline(PAGE_SIZE);
> -	if (!st_map->image) {
> -		/* __bpf_struct_ops_map_free() uses st_map->image as flag
> -		 * for "charged or not". In this case, we need to unchange
> -		 * here.
> +	st_map->image_pages[0] = arch_alloc_bpf_trampoline(PAGE_SIZE);
> +	if (!st_map->image_pages[0]) {
> +		/* __bpf_struct_ops_map_free() uses st_map->image_pages_cnt
> +		 * to for uncharging a number of pages.  In this case, we
> +		 * need to uncharge here.
>   		 */
>   		bpf_jit_uncharge_modmem(PAGE_SIZE);
>   		ret = -ENOMEM;
>   		goto errout_free;
>   	}
> +	st_map->image_pages_cnt = 1;
>   	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
>   	st_map->links_cnt = btf_type_vlen(t);
>   	st_map->links =


