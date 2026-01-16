Return-Path: <bpf+bounces-79190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84138D2C883
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 070FB300ACBD
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 06:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF7F34D926;
	Fri, 16 Jan 2026 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YTxvBXK0"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56523385BF
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768544873; cv=none; b=HL7sH3cEY5UTbhpgE5atAvm20J2xA/7Qk6q+it43ZE+MPKTPdAQWpn1zkaK1Yx4f8TaZZRhZmcnxIm2XYihkdz9iX5S1VkIht9zbuXljzdib1DxjyEfEPeK3kmYl9zGlGlIhhXF+E7uFW5va835tMp7s9VC3aqeiJELCU/DnUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768544873; c=relaxed/simple;
	bh=j2PO0YsyUoxtquDQPkeDI3JHhZ1hOFAZIbrvV52+arw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFkMcYCJGYI05a3fXZGpllF9sHZJuQDGT8eSY21TJbrvXwjZE9nSpi5zaBMoX+uzYXsh3b9RH0gi17sZSAtcRIAoi41SORwbzvH1wqRDGNMR2Fm0YrY55ZFhq6YomfrA7AQ4LcY8L66l1ccbCk+hQfS711eHdislVSvqVIhIGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YTxvBXK0; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 Jan 2026 14:27:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768544859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtRqq1YheiNBBvVmImDMizfzqDOKIgcriEPR9727W+A=;
	b=YTxvBXK0JBNk0RbWd3h8MJih88revancn1zLe8lx27VZO9joNgTadN2VzM/l6k1bIL5pap
	czE0RgU8pSmFOxCnYRduit8IdxaQhwO+0ObsWermDa+LI1bEr82fMrAXrzsmmlZa4XhfDI
	xw1CXap5a2b4p/rnYcg01tNYL6P88+U=
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
Subject: Re: [PATCH RFC v2 08/20] slab: add optimized sheaf refill from
 partial list
Message-ID: <kp7fvhxxjyyzk47n67m4xwzgm7gxoqmgglqdvzpkcxqb26sjc4@bu4lil75nc3c>
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-8-98225cfb50cf@suse.cz>
 <38de0039-e0ea-41c4-a293-400798390ea1@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38de0039-e0ea-41c4-a293-400798390ea1@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 15, 2026 at 03:25:59PM +0100, Vlastimil Babka wrote:
> On 1/12/26 16:17, Vlastimil Babka wrote:
> > At this point we have sheaves enabled for all caches, but their refill
> > is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
> > slabs - now a redundant caching layer that we are about to remove.
> > 
> > The refill will thus be done from slabs on the node partial list.
> > Introduce new functions that can do that in an optimized way as it's
> > easier than modifying the __kmem_cache_alloc_bulk() call chain.
> > 
> > Extend struct partial_context so it can return a list of slabs from the
> > partial list with the sum of free objects in them within the requested
> > min and max.
> > 
> > Introduce get_partial_node_bulk() that removes the slabs from freelist
> > and returns them in the list.
> > 
> > Introduce get_freelist_nofreeze() which grabs the freelist without
> > freezing the slab.
> > 
> > Introduce alloc_from_new_slab() which can allocate multiple objects from
> > a newly allocated slab where we don't need to synchronize with freeing.
> > In some aspects it's similar to alloc_single_from_new_slab() but assumes
> > the cache is a non-debug one so it can avoid some actions.
> > 
> > Introduce __refill_objects() that uses the functions above to fill an
> > array of objects. It has to handle the possibility that the slabs will
> > contain more objects that were requested, due to concurrent freeing of
> > objects to those slabs. When no more slabs on partial lists are
> > available, it will allocate new slabs. It is intended to be only used
> > in context where spinning is allowed, so add a WARN_ON_ONCE check there.
> > 
> > Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
> > only refilled from contexts that allow spinning, or even blocking.
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> ...
> 
> > +static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
> > +		void **p, unsigned int count, bool allow_spin)
> > +{
> > +	unsigned int allocated = 0;
> > +	struct kmem_cache_node *n;
> > +	unsigned long flags;
> > +	void *object;
> > +
> > +	if (!allow_spin && (slab->objects - slab->inuse) > count) {
> > +
> > +		n = get_node(s, slab_nid(slab));
> > +
> > +		if (!spin_trylock_irqsave(&n->list_lock, flags)) {
> > +			/* Unlucky, discard newly allocated slab */
> > +			defer_deactivate_slab(slab, NULL);
> 
> This actually does dec_slabs_node() only with slab->frozen which we don't set.

Hi, I think I follow the intent, but I got a little tripped up here: patch 08
(current patch) seems to assume "slab->frozen = 1" is already gone. That's true
after the whole series, but the removal only happens in patch 09.

Would it make sense to avoid relying on that assumption when looking at patch 08
in isolation?

> 
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	object = slab->freelist;
> > +	while (object && allocated < count) {
> > +		p[allocated] = object;
> > +		object = get_freepointer(s, object);
> > +		maybe_wipe_obj_freeptr(s, p[allocated]);
> > +
> > +		slab->inuse++;
> > +		allocated++;
> > +	}
> > +	slab->freelist = object;
> > +
> > +	if (slab->freelist) {
> > +
> > +		if (allow_spin) {
> > +			n = get_node(s, slab_nid(slab));
> > +			spin_lock_irqsave(&n->list_lock, flags);
> > +		}
> > +		add_partial(n, slab, DEACTIVATE_TO_HEAD);
> > +		spin_unlock_irqrestore(&n->list_lock, flags);
> > +	}
> 
> So we should only do inc_slabs_node() here.
> This also addresses the problem in 9/20 that Hao Li pointed out...

Yes, thanks,
Looking at the patchset as a whole, I think this part - together with the later
removal of inc_slabs_node() - does address the issue.

> 
> > +	return allocated;
> > +}
> > +
> 
> ...
> 
> > +static unsigned int
> > +__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
> > +		 unsigned int max)
> > +{
> > +	struct slab *slab, *slab2;
> > +	struct partial_context pc;
> > +	unsigned int refilled = 0;
> > +	unsigned long flags;
> > +	void *object;
> > +	int node;
> > +
> > +	pc.flags = gfp;
> > +	pc.min_objects = min;
> > +	pc.max_objects = max;
> > +
> > +	node = numa_mem_id();
> > +
> > +	if (WARN_ON_ONCE(!gfpflags_allow_spinning(gfp)))
> > +		return 0;
> > +
> > +	/* TODO: consider also other nodes? */
> > +	if (!get_partial_node_bulk(s, get_node(s, node), &pc))
> > +		goto new_slab;
> > +
> > +	list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
> > +
> > +		list_del(&slab->slab_list);
> > +
> > +		object = get_freelist_nofreeze(s, slab);
> > +
> > +		while (object && refilled < max) {
> > +			p[refilled] = object;
> > +			object = get_freepointer(s, object);
> > +			maybe_wipe_obj_freeptr(s, p[refilled]);
> > +
> > +			refilled++;
> > +		}
> > +
> > +		/*
> > +		 * Freelist had more objects than we can accomodate, we need to
> > +		 * free them back. We can treat it like a detached freelist, just
> > +		 * need to find the tail object.
> > +		 */
> > +		if (unlikely(object)) {
> > +			void *head = object;
> > +			void *tail;
> > +			int cnt = 0;
> > +
> > +			do {
> > +				tail = object;
> > +				cnt++;
> > +				object = get_freepointer(s, object);
> > +			} while (object);
> > +			do_slab_free(s, slab, head, tail, cnt, _RET_IP_);
> > +		}
> > +
> > +		if (refilled >= max)
> > +			break;
> > +	}
> > +
> > +	if (unlikely(!list_empty(&pc.slabs))) {
> > +		struct kmem_cache_node *n = get_node(s, node);
> > +
> > +		spin_lock_irqsave(&n->list_lock, flags);
> > +
> > +		list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
> > +
> > +			if (unlikely(!slab->inuse && n->nr_partial >= s->min_partial))
> > +				continue;
> > +
> > +			list_del(&slab->slab_list);
> > +			add_partial(n, slab, DEACTIVATE_TO_HEAD);
> > +		}
> > +
> > +		spin_unlock_irqrestore(&n->list_lock, flags);
> > +
> > +		/* any slabs left are completely free and for discard */
> > +		list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
> > +
> > +			list_del(&slab->slab_list);
> > +			discard_slab(s, slab);
> > +		}
> > +	}
> > +
> > +
> > +	if (likely(refilled >= min))
> > +		goto out;
> > +
> > +new_slab:
> > +
> > +	slab = new_slab(s, pc.flags, node);
> > +	if (!slab)
> > +		goto out;
> > +
> > +	stat(s, ALLOC_SLAB);
> > +	inc_slabs_node(s, slab_nid(slab), slab->objects);
> 
> And remove it from here.
> 
> > +
> > +	/*
> > +	 * TODO: possible optimization - if we know we will consume the whole
> > +	 * slab we might skip creating the freelist?
> > +	 */
> > +	refilled += alloc_from_new_slab(s, slab, p + refilled, max - refilled,
> > +					/* allow_spin = */ true);
> > +
> > +	if (refilled < min)
> > +		goto new_slab;
> > +out:
> > +
> > +	return refilled;
> > +}
> > +
> >  static inline
> >  int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
> >  			    void **p)
> > 
> 

