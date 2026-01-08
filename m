Return-Path: <bpf+bounces-78250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FC7D0615D
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 21:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94077307EA33
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 20:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D932F74D;
	Thu,  8 Jan 2026 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GpC4Nncb"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63032ED22
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904161; cv=none; b=glyHKKe+j2OtmbvAQP8UxBEdpsvJlVpKBSli1W4P6gehGW+M6pf/6xQHXR4qOPgsSZE3SnJJwyOLPq2DU0bObljJJwaxjmaCt0p0qMSqDXI0OJkbyKLPgalpr53TdgiYpBZ/wYpOQEtTsHkT/gQNiGL+9NC9ri602hRGiJMdsaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904161; c=relaxed/simple;
	bh=Elmxtu0EpGvZb0ppPt5OQP1jBQXvA3X4ZEr/mOQ1PQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeQ7sj9d/Qs0zof1S41xCH8DGroQ9DIDWuQAu+PfZBDaCYYwLNgb0+rQ6oYj3YoxAhh6eB2Koac6L3gXO2imc7NorVFtSppaV6xyAfgaSJnhb/H+PpaGkwO3OmiPW0r/uWrdC4++acX9RB2Vc+LTZAc6atCZuvwX0V+9ywMLTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GpC4Nncb; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <74fa8337-b0cb-42fb-af8a-fdf6877e558d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767904148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=81ZhWDVOVX04uUXOb7d5nmsY+iDMPwWWhkP9liTg+sw=;
	b=GpC4NncbNx8VKMsk+Kt5cEnFjafDrw38At4R7SPNvhiIfmn0whRFB14TsW+nzuwel6hY95
	YOTlQf45vDDSUw8xCLQXx6/dhFrB8RB4k/zGpS/2BawZYH7N3BE/mSqqONjdyG5VNM6Y8M
	DMkYkh6RD2zYMWP0/J2/9pv/2Dd1B5A=
Date: Thu, 8 Jan 2026 12:29:00 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 01/16] bpf: Convert bpf_selem_unlink_map to
 failable
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, kpsingh@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, haoluo@google.com,
 kernel-team@meta.com
References: <20251218175628.1460321-1-ameryhung@gmail.com>
 <20251218175628.1460321-2-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251218175628.1460321-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/18/25 9:56 AM, Amery Hung wrote:
> To prepare for changing bpf_local_storage_map_bucket::lock to rqspinlock,
> convert bpf_selem_unlink_map() to failable. It still always succeeds and
> returns 0 for now.
> 
> Since some operations updating local storage cannot fail in the middle,
> open-code bpf_selem_unlink_map() to take the b->lock before the
> operation. There are two such locations:
> 
> - bpf_local_storage_alloc()
> 
>    The first selem will be unlinked from smap if cmpxchg owner_storage_ptr
>    fails, which should not fail. Therefore, hold b->lock when linking
>    until allocation complete. Helpers that assume b->lock is held by
>    callers are introduced: bpf_selem_link_map_nolock() and
>    bpf_selem_unlink_map_nolock().
> 
> - bpf_local_storage_update()
> 
>    The three step update process: link_map(new_selem),
>    link_storage(new_selem), and unlink_map(old_selem) should not fail in
>    the middle.
> 
> In bpf_selem_unlink(), bpf_selem_unlink_map() and
> bpf_selem_unlink_storage() should either all succeed or fail as a whole
> instead of failing in the middle. So, return if unlink_map() failed.
> 
> In bpf_local_storage_destroy(), since it cannot deadlock with itself or
> bpf_local_storage_map_free() who the function might be racing with,
> retry if bpf_selem_unlink_map() fails due to rqspinlock returning
> errors.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>   kernel/bpf/bpf_local_storage.c | 64 +++++++++++++++++++++++++++++-----
>   1 file changed, 55 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index e2fe6c32822b..4e3f227fd634 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -347,7 +347,7 @@ void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
>   	hlist_add_head_rcu(&selem->snode, &local_storage->list);
>   }
>   
> -static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
> +static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)

This will end up only be used by bpf_selem_unlink(). It may as well 
remove this function and open code in the bpf_selem_unlink(). I think it 
may depend on how patch 10 goes and also if it makes sense to remove 
bpf_selem_"link"_map and bpf_selem_unlink_map_nolock also, so treat it 
as a nit note for now.

>   {
>   	struct bpf_local_storage_map *smap;
>   	struct bpf_local_storage_map_bucket *b;
> @@ -355,7 +355,7 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
>   
>   	if (unlikely(!selem_linked_to_map_lockless(selem)))

In the later patch where both local_storage's and map-bucket's locks 
must be acquired, will this check still be needed if there is an earlier 
check that ensures the selem is still linked to the local_storage? It 
does not matter in terms of perf, but I think it will help code reading 
in the future for the common code path (i.e. the code paths other than 
bpf_local_storage_destroy and bpf_local_storage_map_free).

>   		/* selem has already be unlinked from smap */
> -		return;
> +		return 0;
>   
>   	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
>   	b = select_bucket(smap, selem);
> @@ -363,6 +363,14 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
>   	if (likely(selem_linked_to_map(selem)))
>   		hlist_del_init_rcu(&selem->map_node);
>   	raw_spin_unlock_irqrestore(&b->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void bpf_selem_unlink_map_nolock(struct bpf_local_storage_elem *selem)
> +{
> +	if (likely(selem_linked_to_map(selem)))

Take this chance to remove the selem_linked_to_map() check. 
hlist_del_init_rcu has the same check.

> +		hlist_del_init_rcu(&selem->map_node);
>   }
>   
>   void bpf_selem_link_map(struct bpf_local_storage_map *smap,
> @@ -376,13 +384,26 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
>   	raw_spin_unlock_irqrestore(&b->lock, flags);
>   }
>   
> +static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
> +				      struct bpf_local_storage_elem *selem,
> +				      struct bpf_local_storage_map_bucket *b)
> +{
> +	RCU_INIT_POINTER(SDATA(selem)->smap, smap);

Is it needed? bpf_selem_alloc should have init the SDATA(selem)->smap.

> +	hlist_add_head_rcu(&selem->map_node, &b->list);
> +}
> +

[ ... ]

> @@ -574,20 +603,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   		goto unlock;
>   	}
>   
> +	b = select_bucket(smap, selem);
> +
> +	if (old_sdata) {
> +		old_b = select_bucket(smap, SELEM(old_sdata));
> +		old_b = old_b == b ? NULL : old_b;
> +	}
> +
> +	raw_spin_lock_irqsave(&b->lock, b_flags);
> +
> +	if (old_b)
> +		raw_spin_lock_irqsave(&old_b->lock, old_b_flags);

This will deadlock because of the lock ordering of b and old_b. 
Replacing it with res_spin_lock in the later patch can detect it and 
break it more gracefully. imo, we should not introduce a known deadlock 
logic in the kernel code in the syscall code path and ask the current 
user to retry the map_update_elem syscall.

What happened to the patch in the earlier revision that uses the 
local_storage (or owner) for select_bucket?

[ will continue with the rest of the patches a bit later ]

> +
>   	alloc_selem = NULL;
>   	/* First, link the new selem to the map */
> -	bpf_selem_link_map(smap, selem);
> +	bpf_selem_link_map_nolock(smap, selem, b);
>   
>   	/* Second, link (and publish) the new selem to local_storage */
>   	bpf_selem_link_storage_nolock(local_storage, selem);
>   
>   	/* Third, remove old selem, SELEM(old_sdata) */
>   	if (old_sdata) {
> -		bpf_selem_unlink_map(SELEM(old_sdata));
> +		bpf_selem_unlink_map_nolock(SELEM(old_sdata));
>   		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
>   						&old_selem_free_list);
>   	}
>   
> +	if (old_b)
> +		raw_spin_unlock_irqrestore(&old_b->lock, old_b_flags);
> +
> +	raw_spin_unlock_irqrestore(&b->lock, b_flags);
> +
>   unlock:
>   	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>   	bpf_selem_free_list(&old_selem_free_list, false);
> @@ -679,7 +725,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
>   		/* Always unlink from map before unlinking from
>   		 * local_storage.
>   		 */
> -		bpf_selem_unlink_map(selem);
> +		WARN_ON(bpf_selem_unlink_map(selem));
>   		/* If local_storage list has only one element, the
>   		 * bpf_selem_unlink_storage_nolock() will return true.
>   		 * Otherwise, it will return false. The current loop iteration


