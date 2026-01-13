Return-Path: <bpf+bounces-78728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FD5D19FA2
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 251D1301EFEB
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 15:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469813939AD;
	Tue, 13 Jan 2026 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eCIGcp39"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9129D27D
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318984; cv=none; b=rdtwV3bAJZ+ARJPjHczHd/ZfyzQuj1HQDh4rLxxHn8IQF/dQhSManELAu7F6ki5NQLYYX8GHHThHRSMLNvuy89+RkPnhRucrE9SOhMgc/GADUyn+o3yHN9WCuBh7sgDDWx/FNc56FzsguZx8r1DkD0uQ+8lLrMRP+9Nwp2nDzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318984; c=relaxed/simple;
	bh=JgIlqtTWa84pDzYHYRBImp47HFwfIHOmtysB9ghZeBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqtROwzI86v9JiY1iRCISvHk47+Hx2CnOjwmmFtnZrQ67CB6CbrM5vcQC/cUSZZ2GTvXDYFFgWPGb/ESmQczvG/XVgKEFFfzgugB/m27Uif2wv4Nx6iiciki8z1x7RiDrQNxRloRIhnsFmg/6f3qhNFENFhq5QPxEQObhVciBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eCIGcp39; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Jan 2026 23:42:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768318971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kcT0Rq2eZ+lNzxPFLAdKQnxD9hPonR7DRC64KveBJ74=;
	b=eCIGcp39cm1nzeXHF6v15sJCklJtGZ5xlNyipFNcX4XcjcZemAhgzbLyf9nJKR4d3Aa+sI
	gwwX0qDl5Mr4glgVXXp8RED3x6I56Vw13qkj+0H6NnM4cdR/tCVQIRcrM2cT+0uzyxqF0b
	97J55dhMMXrsT3/hQ1K8wN9/rw1iiTM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH RFC v2 06/20] slab: make percpu sheaves compatible with
 kmalloc_nolock()/kfree_nolock()
Message-ID: <2hsm2byyftzi2d4xxdtkakqnfggtyemr23ofrnqgkzhkh7q7vc@zoqqfr7hba6f>
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-6-98225cfb50cf@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-sheaves-for-all-v2-6-98225cfb50cf@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 12, 2026 at 04:17:00PM +0100, Vlastimil Babka wrote:
> Before we enable percpu sheaves for kmalloc caches, we need to make sure
> kmalloc_nolock() and kfree_nolock() will continue working properly and
> not spin when not allowed to.
> 
> Percpu sheaves themselves use local_trylock() so they are already
> compatible. We just need to be careful with the barn->lock spin_lock.
> Pass a new allow_spin parameter where necessary to use
> spin_trylock_irqsave().
> 
> In kmalloc_nolock_noprof() we can now attempt alloc_from_pcs() safely,
> for now it will always fail until we enable sheaves for kmalloc caches
> next. Similarly in kfree_nolock() we can attempt free_to_pcs().
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 79 +++++++++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 57 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 06d5cf794403..0177a654a06a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2881,7 +2881,8 @@ static void pcs_destroy(struct kmem_cache *s)
>  	s->cpu_sheaves = NULL;
>  }
>  
> -static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
> +static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
> +					       bool allow_spin)
>  {
>  	struct slab_sheaf *empty = NULL;
>  	unsigned long flags;
> @@ -2889,7 +2890,10 @@ static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
>  	if (!data_race(barn->nr_empty))
>  		return NULL;
>  
> -	spin_lock_irqsave(&barn->lock, flags);
> +	if (likely(allow_spin))
> +		spin_lock_irqsave(&barn->lock, flags);
> +	else if (!spin_trylock_irqsave(&barn->lock, flags))
> +		return NULL;
>  
>  	if (likely(barn->nr_empty)) {
>  		empty = list_first_entry(&barn->sheaves_empty,
> @@ -2966,7 +2970,8 @@ static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn *barn)
>   * change.
>   */
>  static struct slab_sheaf *
> -barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
> +barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty,
> +			 bool allow_spin)
>  {
>  	struct slab_sheaf *full = NULL;
>  	unsigned long flags;
> @@ -2974,7 +2979,10 @@ barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
>  	if (!data_race(barn->nr_full))
>  		return NULL;
>  
> -	spin_lock_irqsave(&barn->lock, flags);
> +	if (likely(allow_spin))
> +		spin_lock_irqsave(&barn->lock, flags);
> +	else if (!spin_trylock_irqsave(&barn->lock, flags))
> +		return NULL;
>  
>  	if (likely(barn->nr_full)) {
>  		full = list_first_entry(&barn->sheaves_full, struct slab_sheaf,
> @@ -2995,7 +3003,8 @@ barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
>   * barn. But if there are too many full sheaves, reject this with -E2BIG.
>   */
>  static struct slab_sheaf *
> -barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
> +barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full,
> +			bool allow_spin)
>  {
>  	struct slab_sheaf *empty;
>  	unsigned long flags;
> @@ -3006,7 +3015,10 @@ barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
>  	if (!data_race(barn->nr_empty))
>  		return ERR_PTR(-ENOMEM);
>  
> -	spin_lock_irqsave(&barn->lock, flags);
> +	if (likely(allow_spin))
> +		spin_lock_irqsave(&barn->lock, flags);
> +	else if (!spin_trylock_irqsave(&barn->lock, flags))
> +		return ERR_PTR(-EBUSY);
>  
>  	if (likely(barn->nr_empty)) {
>  		empty = list_first_entry(&barn->sheaves_empty, struct slab_sheaf,
> @@ -5000,7 +5012,8 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
>  		return NULL;
>  	}
>  
> -	full = barn_replace_empty_sheaf(barn, pcs->main);
> +	full = barn_replace_empty_sheaf(barn, pcs->main,
> +					gfpflags_allow_spinning(gfp));
>  
>  	if (full) {
>  		stat(s, BARN_GET);
> @@ -5017,7 +5030,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
>  			empty = pcs->spare;
>  			pcs->spare = NULL;
>  		} else {
> -			empty = barn_get_empty_sheaf(barn);
> +			empty = barn_get_empty_sheaf(barn, true);
>  		}
>  	}
>  
> @@ -5157,7 +5170,8 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
>  }
>  
>  static __fastpath_inline
> -unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
> +unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t size,
> +				 void **p)
>  {
>  	struct slub_percpu_sheaves *pcs;
>  	struct slab_sheaf *main;
> @@ -5191,7 +5205,8 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  			return allocated;
>  		}
>  
> -		full = barn_replace_empty_sheaf(barn, pcs->main);
> +		full = barn_replace_empty_sheaf(barn, pcs->main,
> +						gfpflags_allow_spinning(gfp));
>  
>  		if (full) {
>  			stat(s, BARN_GET);
> @@ -5700,7 +5715,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
>  	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
>  	struct kmem_cache *s;
>  	bool can_retry = true;
> -	void *ret = ERR_PTR(-EBUSY);
> +	void *ret;
>  
>  	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
>  				      __GFP_NO_OBJ_EXT));
> @@ -5727,6 +5742,12 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
>  		 */
>  		return NULL;
>  
> +	ret = alloc_from_pcs(s, alloc_gfp, node);
> +	if (ret)
> +		goto success;
> +
> +	ret = ERR_PTR(-EBUSY);
> +
>  	/*
>  	 * Do not call slab_alloc_node(), since trylock mode isn't
>  	 * compatible with slab_pre_alloc_hook/should_failslab and
> @@ -5763,6 +5784,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
>  		ret = NULL;
>  	}
>  
> +success:
>  	maybe_wipe_obj_freeptr(s, ret);
>  	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
>  			     slab_want_init_on_alloc(alloc_gfp, s), size);
> @@ -6083,7 +6105,8 @@ static void __pcs_install_empty_sheaf(struct kmem_cache *s,
>   * unlocked.
>   */
>  static struct slub_percpu_sheaves *
> -__pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
> +__pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
> +			bool allow_spin)
>  {
>  	struct slab_sheaf *empty;
>  	struct node_barn *barn;
> @@ -6107,7 +6130,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>  	put_fail = false;
>  
>  	if (!pcs->spare) {
> -		empty = barn_get_empty_sheaf(barn);
> +		empty = barn_get_empty_sheaf(barn, allow_spin);
>  		if (empty) {
>  			pcs->spare = pcs->main;
>  			pcs->main = empty;
> @@ -6121,7 +6144,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>  		return pcs;
>  	}
>  
> -	empty = barn_replace_full_sheaf(barn, pcs->main);
> +	empty = barn_replace_full_sheaf(barn, pcs->main, allow_spin);
>  
>  	if (!IS_ERR(empty)) {
>  		stat(s, BARN_PUT);
> @@ -6129,6 +6152,17 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>  		return pcs;
>  	}
>  
> +	if (!allow_spin) {
> +		/*
> +		 * sheaf_flush_unused() or alloc_empty_sheaf() don't support
> +		 * !allow_spin and instead of trying to support them it's
> +		 * easier to fall back to freeing the object directly without
> +		 * sheaves
> +		 */
> +		local_unlock(&s->cpu_sheaves->lock);
> +		return NULL;
> +	}

It looks like when "allow_spin" is false, __pcs_replace_full_main() can
still end up calling alloc_empty_sheaf() if pcs->spare is NULL (via the
"goto alloc_empty" path). Would it make sense to bail out a bit earlier
in that case?

-- 
Thanks
Hao

> +
>  	if (PTR_ERR(empty) == -E2BIG) {
>  		/* Since we got here, spare exists and is full */
>  		struct slab_sheaf *to_flush = pcs->spare;
> @@ -6196,7 +6230,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>   * The object is expected to have passed slab_free_hook() already.
>   */
>  static __fastpath_inline
> -bool free_to_pcs(struct kmem_cache *s, void *object)
> +bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
>  {
>  	struct slub_percpu_sheaves *pcs;
>  
> @@ -6207,7 +6241,7 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
>  
>  	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
>  
> -		pcs = __pcs_replace_full_main(s, pcs);
> +		pcs = __pcs_replace_full_main(s, pcs, allow_spin);
>  		if (unlikely(!pcs))
>  			return false;
>  	}
> @@ -6314,7 +6348,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>  			goto fail;
>  		}
>  
> -		empty = barn_get_empty_sheaf(barn);
> +		empty = barn_get_empty_sheaf(barn, true);
>  
>  		if (empty) {
>  			pcs->rcu_free = empty;
> @@ -6435,7 +6469,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  		goto no_empty;
>  
>  	if (!pcs->spare) {
> -		empty = barn_get_empty_sheaf(barn);
> +		empty = barn_get_empty_sheaf(barn, true);
>  		if (!empty)
>  			goto no_empty;
>  
> @@ -6449,7 +6483,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>  		goto do_free;
>  	}
>  
> -	empty = barn_replace_full_sheaf(barn, pcs->main);
> +	empty = barn_replace_full_sheaf(barn, pcs->main, true);
>  	if (IS_ERR(empty)) {
>  		stat(s, BARN_PUT_FAIL);
>  		goto no_empty;
> @@ -6699,7 +6733,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>  
>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())
>  	    && likely(!slab_test_pfmemalloc(slab))) {
> -		if (likely(free_to_pcs(s, object)))
> +		if (likely(free_to_pcs(s, object, true)))
>  			return;
>  	}
>  
> @@ -6960,7 +6994,8 @@ void kfree_nolock(const void *object)
>  	 * since kasan quarantine takes locks and not supported from NMI.
>  	 */
>  	kasan_slab_free(s, x, false, false, /* skip quarantine */true);
> -	do_slab_free(s, slab, x, x, 0, _RET_IP_);
> +	if (!free_to_pcs(s, x, false))
> +		do_slab_free(s, slab, x, x, 0, _RET_IP_);
>  }
>  EXPORT_SYMBOL_GPL(kfree_nolock);
>  
> @@ -7512,7 +7547,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
>  		size--;
>  	}
>  
> -	i = alloc_from_pcs_bulk(s, size, p);
> +	i = alloc_from_pcs_bulk(s, flags, size, p);
>  
>  	if (i < size) {
>  		/*
> 
> -- 
> 2.52.0
> 

