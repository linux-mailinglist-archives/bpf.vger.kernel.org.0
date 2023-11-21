Return-Path: <bpf+bounces-15533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC3B7F3265
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9274E2820E2
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AAF5811A;
	Tue, 21 Nov 2023 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pfy6KfBf"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FB110E
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 07:34:15 -0800 (PST)
Message-ID: <20669b09-36be-493c-9cf7-bf34e906832c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700580853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd37BLzXI85b/gmfPs2QZHtLeNa+fT9UsVCWb5drAAA=;
	b=Pfy6KfBfgT/fWjCJBS4VfOlvIJo+pY7NmkbK2Xh29qPDQnBNMvSpz4nCDFNoVVOmGW0VDw
	h7g7xRlv2CbllDymA0AI07Y+MtV9ImJyOqffVGquGa4rMXF2pmM/WPLYsKvFCHR6eiqYEp
	sKE9pFva4YFrTXr4F3HCKUztPjyMtxg=
Date: Tue, 21 Nov 2023 07:34:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local
 storage
Content-Language: en-GB
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20231120175925.733167-1-davemarchevsky@fb.com>
 <20231120175925.733167-2-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231120175925.733167-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/20/23 12:59 PM, Dave Marchevsky wrote:
> This patch modifies the generic bpf_local_storage infrastructure to
> support mmapable map values and adds mmap() handling to task_local
> storage leveraging this new functionality. A userspace task which
> mmap's a task_local storage map will receive a pointer to the map_value
> corresponding to that tasks' key - mmap'ing in other tasks' mapvals is
> not supported in this patch.
>
> Currently, struct bpf_local_storage_elem contains both bookkeeping
> information as well as a struct bpf_local_storage_data with additional
> bookkeeping information and the actual mapval data. We can't simply map
> the page containing this struct into userspace. Instead, mmapable
> local_storage uses bpf_local_storage_data's data field to point to the
> actual mapval, which is allocated separately such that it can be
> mmapped. Only the mapval lives on the page(s) allocated for it.
>
> The lifetime of the actual_data mmapable region is tied to the
> bpf_local_storage_elem which points to it. This doesn't necessarily mean
> that the pages go away when the bpf_local_storage_elem is free'd - if
> they're mapped into some userspace process they will remain until
> unmapped, but are no longer the task_local storage's mapval.
>
> Implementation details:
>
>    * A few small helpers are added to deal with bpf_local_storage_data's
>      'data' field having different semantics when the local_storage map
>      is mmapable. With their help, many of the changes to existing code
>      are purely mechanical (e.g. sdata->data becomes sdata_mapval(sdata),
>      selem->elem_size becomes selem_bytes_used(selem)).
>
>    * The map flags are copied into bpf_local_storage_data when its
>      containing bpf_local_storage_elem is alloc'd, since the
>      bpf_local_storage_map associated with them may be gone when
>      bpf_local_storage_data is free'd, and testing flags for
>      BPF_F_MMAPABLE is necessary when free'ing to ensure that the
>      mmapable region is free'd.
>      * The extra field doesn't change bpf_local_storage_elem's size.
>        There were 48 bytes of padding after the bpf_local_storage_data
>        field, now there are 40.
>
>    * Currently, bpf_local_storage_update always creates a new
>      bpf_local_storage_elem for the 'updated' value - the only exception
>      being if the map_value has a bpf_spin_lock field, in which case the
>      spin lock is grabbed instead of the less granular bpf_local_storage
>      lock, and the value updated in place. This inplace update behavior
>      is desired for mmapable local_storage map_values as well, since
>      creating a new selem would result in new mmapable pages.
>
>    * The size of the mmapable pages are accounted for when calling
>      mem_{charge,uncharge}. If the pages are mmap'd into a userspace task
>      mem_uncharge may be called before they actually go away.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   include/linux/bpf_local_storage.h |  14 ++-
>   kernel/bpf/bpf_local_storage.c    | 145 ++++++++++++++++++++++++------
>   kernel/bpf/bpf_task_storage.c     |  35 ++++++--
>   kernel/bpf/syscall.c              |   2 +-
>   4 files changed, 163 insertions(+), 33 deletions(-)
>
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
> +	};
>   };
>   
>   /* Linked to bpf_local_storage and bpf_local_storage_map */
> @@ -124,6 +134,8 @@ static struct bpf_local_storage_cache name = {			\
>   /* Helper functions for bpf_local_storage */
>   int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
>   
> +void *sdata_mapval(struct bpf_local_storage_data *data);
> +
>   struct bpf_map *
>   bpf_local_storage_map_alloc(union bpf_attr *attr,
>   			    struct bpf_local_storage_cache *cache,
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 146824cc9689..9b3becbcc1a3 100644
> --- a/kernel/bpf/bpf_local_storage.c
[...]
> @@ -583,14 +665,14 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   		err = bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
>   		if (err) {
>   			bpf_selem_free(selem, smap, true);
> -			mem_uncharge(smap, owner, smap->elem_size);
> +			mem_uncharge(smap, owner, selem_bytes_used(smap));
>   			return ERR_PTR(err);
>   		}
>   
>   		return SDATA(selem);
>   	}
>   
> -	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
> +	if (can_update_existing_selem(smap, map_flags) && !(map_flags & BPF_NOEXIST)) {
>   		/* Hoping to find an old_sdata to do inline update
>   		 * such that it can avoid taking the local_storage->lock
>   		 * and changing the lists.
> @@ -601,8 +683,13 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   		if (err)
>   			return ERR_PTR(err);
>   		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
> -			copy_map_value_locked(&smap->map, old_sdata->data,
> -					      value, false);
> +			if (map_flags & BPF_F_LOCK)
> +				copy_map_value_locked(&smap->map,
> +						      sdata_mapval(old_sdata),
> +						      value, false);
> +			else
> +				copy_map_value(&smap->map, sdata_mapval(old_sdata),
> +					       value);

IIUC, if two 'storage_update' to the same map/key and then
these two updates will be serialized due to spin_lock.
How about concurrent update for mmap'ed sdata, do we need
any protection here?

>   			return old_sdata;
>   		}
>   	}
> @@ -633,8 +720,8 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   		goto unlock;
>   
>   	if (old_sdata && (map_flags & BPF_F_LOCK)) {
> -		copy_map_value_locked(&smap->map, old_sdata->data, value,
> -				      false);
> +		copy_map_value_locked(&smap->map, sdata_mapval(old_sdata),
> +				      value, false);
>   		selem = SELEM(old_sdata);
>   		goto unlock;
>   	}
> @@ -656,7 +743,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   unlock:
>   	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>   	if (alloc_selem) {
> -		mem_uncharge(smap, owner, smap->elem_size);
> +		mem_uncharge(smap, owner, selem_bytes_used(smap));
>   		bpf_selem_free(alloc_selem, smap, true);
>   	}
>   	return err ? ERR_PTR(err) : SDATA(selem);
> @@ -707,6 +794,10 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
>   	if (attr->value_size > BPF_LOCAL_STORAGE_MAX_VALUE_SIZE)
>   		return -E2BIG;
>   
> +	if ((attr->map_flags & BPF_F_MMAPABLE) &&
> +	    attr->map_type != BPF_MAP_TYPE_TASK_STORAGE)
> +		return -EINVAL;
> +
>   	return 0;
>   }
>   

[...]


