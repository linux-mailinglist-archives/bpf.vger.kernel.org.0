Return-Path: <bpf+bounces-79583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E79D3C3F2
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 10:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EEAA5400F2
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE6F3D4121;
	Tue, 20 Jan 2026 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZYE6svoZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AF23BB9F8
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901583; cv=none; b=PY58zUdeq+WX0y2Ki/DlC78pTc9WhFBqUg+PWPQzbDfSAdqSYHMJxoiuyNa/gjt8l06MwyfYggWTsL5D85wRLBeSkHYRrUHLnskS6+eqqhzHu/c4CHCQ/LiIR3zZqpjMvxG4Ex7VgCvi5H7zwslu/7r29+5Teft/3iDxzyL+rHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901583; c=relaxed/simple;
	bh=fYZLITG4pTsD3JjUNUDb4IA0sNEHSPua81Hw6Kz+jBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPH8dZh9B1zx9PwejL4wikzzXqFBd3NFQk/z9nUyaBZ43xTu40ZFoACF8diIpWRD9DtnTUz3AnqVcVWfR4POx3R8XeBBwVJfNbgB0acGQPShPqFRzUqchMuv+SybM00HnmoxUV/zO2yo1ZCVByB9KYJAzBZOeuBNOuW0FiEGEwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZYE6svoZ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Jan 2026 17:32:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768901567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kHHh12InGybJlgb+yVFYP3fxoRRSSX2x0XpjMmVp7aY=;
	b=ZYE6svoZOmJtF9deg4k49Cw62GzmDfZmWfTCEfZ+EMirLCOdTGeWWKUxmJFGg7OJv2TYLQ
	r3WdcAJbcl782ZRZMBe8+8OQEb2kReroeGK6QOyxCSFjtsfo5nrB7O1YIouLbaduF5wRVc
	Xfa+lRmA4fKAdV99WPLtq4HmAP0S7u4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 09/21] slab: add optimized sheaf refill from partial
 list
Message-ID: <zo75mmcyxdzrefl7fo4vy2zqfpzcox4vrmjsk63qtzzmwigbzk@2hb52by2j7yy>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz>
 <aW3SJBR1BcDor-ya@hyeyoo>
 <e106a4d5-32f7-4314-b8c1-19ebc6da6d7a@suse.cz>
 <aW7dUeoDALhJI0Ic@hyeyoo>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW7dUeoDALhJI0Ic@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 20, 2026 at 10:41:37AM +0900, Harry Yoo wrote:
> On Mon, Jan 19, 2026 at 11:54:18AM +0100, Vlastimil Babka wrote:
> > On 1/19/26 07:41, Harry Yoo wrote:
> > > On Fri, Jan 16, 2026 at 03:40:29PM +0100, Vlastimil Babka wrote:
> > >>  /*
> > >>   * Try to allocate a partial slab from a specific node.
> > >>   */
> > >> +static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
> > >> +		void **p, unsigned int count, bool allow_spin)
> > >> +{
> > >> +	unsigned int allocated = 0;
> > >> +	struct kmem_cache_node *n;
> > >> +	unsigned long flags;
> > >> +	void *object;
> > >> +
> > >> +	if (!allow_spin && (slab->objects - slab->inuse) > count) {
> > >> +
> > >> +		n = get_node(s, slab_nid(slab));
> > >> +
> > >> +		if (!spin_trylock_irqsave(&n->list_lock, flags)) {
> > >> +			/* Unlucky, discard newly allocated slab */
> > >> +			defer_deactivate_slab(slab, NULL);
> > >> +			return 0;
> > >> +		}
> > >> +	}
> > >> +
> > >> +	object = slab->freelist;
> > >> +	while (object && allocated < count) {
> > >> +		p[allocated] = object;
> > >> +		object = get_freepointer(s, object);
> > >> +		maybe_wipe_obj_freeptr(s, p[allocated]);
> > >> +
> > >> +		slab->inuse++;
> > >> +		allocated++;
> > >> +	}
> > >> +	slab->freelist = object;
> > >> +
> > >> +	if (slab->freelist) {
> > >> +
> > >> +		if (allow_spin) {
> > >> +			n = get_node(s, slab_nid(slab));
> > >> +			spin_lock_irqsave(&n->list_lock, flags);
> > >> +		}
> > >> +		add_partial(n, slab, DEACTIVATE_TO_HEAD);
> > >> +		spin_unlock_irqrestore(&n->list_lock, flags);
> > >> +	}
> > >> +
> > >> +	inc_slabs_node(s, slab_nid(slab), slab->objects);
> > > 
> > > Maybe add a comment explaining why inc_slabs_node() doesn't need to be
> > > called under n->list_lock?

I think this is a great observation.

> > 
> > Hm, we might not even be holding it. The old code also did the inc with no
> > comment. If anything could use one, it would be in
> > alloc_single_from_new_slab()? But that's outside the scope here.
> 
> Ok. Perhaps worth adding something like this later, but yeah it's outside
> the scope here.
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 698c0d940f06..c5a1e47dfe16 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1633,6 +1633,9 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
>  {
>  	struct kmem_cache_node *n = get_node(s, node);
>  
> +	if (kmem_cache_debug(s))
> +		/* slab validation may generate false errors without the lock */
> +		lockdep_assert_held(&n->list_lock);
>  	atomic_long_inc(&n->nr_slabs);
>  	atomic_long_add(objects, &n->total_objects);
>  }

Yes. This makes sense to me.

Just to double-check - I noticed that inc_slabs_node() is also called by
early_kmem_cache_node_alloc(). Could this potentially lead to false positive
warnings for boot-time caches when debug flags are enabled?

-- 
Thanks,
Hao

