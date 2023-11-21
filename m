Return-Path: <bpf+bounces-15470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147CD7F226E
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 01:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C2F282345
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723CF15B6;
	Tue, 21 Nov 2023 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jyKQc/PE"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [IPv6:2001:41d0:203:375::b2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C1EC9
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 16:42:30 -0800 (PST)
Message-ID: <9b037dde-e65c-4d1a-8295-68d51ac3ce25@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700527349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acaf17Q0NNuM+Wdg/HUB9N3cO7Z2FPWOT2nLmDLwXe8=;
	b=jyKQc/PETGniDYpVFoKwi3wkzPtghbAqGg2LYRC2HPYL07aZpnajR6O62Ov9tUSY5MDU4N
	2U94YnuHg0s91MjjB6tVqAopUGlForLcEzI2ZCZpSvgNA2UcQbmxRds5i+B3aM0hmt3kYM
	6HHPKQn+yZiC6jB7FBnyn4qlcx/EpIg=
Date: Mon, 20 Nov 2023 16:42:21 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local
 storage
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 Johannes Weiner <hannes@cmpxchg.org>, bpf@vger.kernel.org
References: <20231120175925.733167-1-davemarchevsky@fb.com>
 <20231120175925.733167-2-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231120175925.733167-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/20/23 9:59 AM, Dave Marchevsky wrote:
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 173ec7f43ed1..114973f925ea 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -69,7 +69,17 @@ struct bpf_local_storage_data {
>   	 * the number of cachelines accessed during the cache hit case.
>   	 */
>   	struct bpf_local_storage_map __rcu *smap;
> -	u8 data[] __aligned(8);
> +	/* Need to duplicate smap's map_flags as smap may be gone when
> +	 * it's time to free bpf_local_storage_data
> +	 */
> +	u64 smap_map_flags;
> +	/* If BPF_F_MMAPABLE, this is a void * to separately-alloc'd data
> +	 * Otherwise the actual mapval data lives here
> +	 */
> +	union {
> +		DECLARE_FLEX_ARRAY(u8, data) __aligned(8);
> +		void *actual_data __aligned(8);

The pages (that can be mmap'ed later) feel like a specific kind of kptr.

Have you thought about allowing a kptr (pointing to some pages that can be 
mmap'ed later) to be stored as one of the members of the map's value as a kptr. 
bpf_local_storage_map is one of the maps that supports kptr.

struct normal_and_mmap_value {
     int some_int;
     int __percpu_kptr *some_cnts;

     struct bpf_mmap_page __kptr *some_stats;
};

struct mmap_only_value {
     struct bpf_mmap_page __kptr *some_stats;
};

[ ... ]

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 146824cc9689..9b3becbcc1a3 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -15,7 +15,8 @@
>   #include <linux/rcupdate_trace.h>
>   #include <linux/rcupdate_wait.h>
>   
> -#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
> +#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK \
> +	(BPF_F_NO_PREALLOC | BPF_F_CLONE | BPF_F_MMAPABLE)
>   
>   static struct bpf_local_storage_map_bucket *
>   select_bucket(struct bpf_local_storage_map *smap,
> @@ -24,6 +25,51 @@ select_bucket(struct bpf_local_storage_map *smap,
>   	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
>   }
>   
> +struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map);
> +
> +void *alloc_mmapable_selem_value(struct bpf_local_storage_map *smap)
> +{
> +	struct mem_cgroup *memcg, *old_memcg;
> +	void *ptr;
> +
> +	memcg = bpf_map_get_memcg(&smap->map);
> +	old_memcg = set_active_memcg(memcg);
> +	ptr = bpf_map_area_mmapable_alloc(PAGE_ALIGN(smap->map.value_size),
> +					  NUMA_NO_NODE);
> +	set_active_memcg(old_memcg);
> +	mem_cgroup_put(memcg);
> +
> +	return ptr;
> +}

[ ... ]

> @@ -76,10 +122,19 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>   		void *value, bool charge_mem, gfp_t gfp_flags)
>   {
>   	struct bpf_local_storage_elem *selem;
> +	void *mmapable_value = NULL;
> +	u32 selem_mem;
>   
> -	if (charge_mem && mem_charge(smap, owner, smap->elem_size))
> +	selem_mem = selem_bytes_used(smap);
> +	if (charge_mem && mem_charge(smap, owner, selem_mem))
>   		return NULL;
>   
> +	if (smap->map.map_flags & BPF_F_MMAPABLE) {
> +		mmapable_value = alloc_mmapable_selem_value(smap);

This probably is not always safe for bpf prog to do. Leaving the gfp_flags was 
not used aside, the bpf local storage is moving to the bpf's memalloc because of 
https://lore.kernel.org/bpf/20221118190109.1512674-1-namhyung@kernel.org/

> +		if (!mmapable_value)
> +			goto err_out;
> +	}
> +


