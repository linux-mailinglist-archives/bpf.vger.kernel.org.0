Return-Path: <bpf+bounces-79221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4496D2D9D3
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 09:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 071D6309B926
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2459D2D73A6;
	Fri, 16 Jan 2026 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TymSe3fT"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFAB21FF47;
	Fri, 16 Jan 2026 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550244; cv=none; b=orzw6eVPJLr6jPBHdXj7KsVXbFdClikKowa2308Hq0Q5Y6smWUdQBSQfUBND0NngCI2mXRgdQ2QMKwddRxzKNVYIBvA7AvZ6b4E/9USrQ4qo/z/FHGyCGVI4X5IzuLxZWgBzb7aaiJQAT/p/P6HcUTcK2jaD4Lo24HgzmMSE2fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550244; c=relaxed/simple;
	bh=olSbzdwlvSE+g+cVEIs4ZCNHMf6TOB2lwdfPUtA7LTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlvC02md5cFiVkQp040qFMC86UF5E+dmK3T2EHzYmlaL59D/J2Te+UfS0Qe3+nPxem7J9csG/313/8B7em/iu2XCg9sd7mEdMSwvyIomg69ePXiv0dumDVk95ITaJESTdRYm5/G9lcGrKX6NVv6YJ01tNudSZSpXvuy9D17L9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TymSe3fT; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 16 Jan 2026 15:56:58 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768550230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8PsGNXpmMoDJe1yHU7yqWS6tBazZC3oE9e62iQ9nE4c=;
	b=TymSe3fTdIyFVQMQQP7IHFHCaMh/PCzDQo+dEFkAYYQYNwDT1s9H4/71uzSbo6jpL/6qBh
	WoBMsOrlmofja3Wo5HkAZZK2f1iuTObqGZw6KxlSjG8J3zh59PfoUFX8lf2d4E9vNaHC1I
	m7Rq7f8WVgy9E1jUSKv1tQeH3+njf2w=
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
Message-ID: <5lmryxzoe2d5ywqfjwxqd63xsfq246ytb6lpkebkc3zxvu65xb@sdtiyxfez43v>
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-8-98225cfb50cf@suse.cz>
 <38de0039-e0ea-41c4-a293-400798390ea1@suse.cz>
 <kp7fvhxxjyyzk47n67m4xwzgm7gxoqmgglqdvzpkcxqb26sjc4@bu4lil75nc3c>
 <bb58c778-be6b-445e-a331-ddaf04f97f0e@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb58c778-be6b-445e-a331-ddaf04f97f0e@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 08:32:00AM +0100, Vlastimil Babka wrote:
> On 1/16/26 07:27, Hao Li wrote:
> > On Thu, Jan 15, 2026 at 03:25:59PM +0100, Vlastimil Babka wrote:
> >> On 1/12/26 16:17, Vlastimil Babka wrote:
> >> > At this point we have sheaves enabled for all caches, but their refill
> >> > is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
> >> > slabs - now a redundant caching layer that we are about to remove.
> >> > 
> >> > The refill will thus be done from slabs on the node partial list.
> >> > Introduce new functions that can do that in an optimized way as it's
> >> > easier than modifying the __kmem_cache_alloc_bulk() call chain.
> >> > 
> >> > Extend struct partial_context so it can return a list of slabs from the
> >> > partial list with the sum of free objects in them within the requested
> >> > min and max.
> >> > 
> >> > Introduce get_partial_node_bulk() that removes the slabs from freelist
> >> > and returns them in the list.
> >> > 
> >> > Introduce get_freelist_nofreeze() which grabs the freelist without
> >> > freezing the slab.
> >> > 
> >> > Introduce alloc_from_new_slab() which can allocate multiple objects from
> >> > a newly allocated slab where we don't need to synchronize with freeing.
> >> > In some aspects it's similar to alloc_single_from_new_slab() but assumes
> >> > the cache is a non-debug one so it can avoid some actions.
> >> > 
> >> > Introduce __refill_objects() that uses the functions above to fill an
> >> > array of objects. It has to handle the possibility that the slabs will
> >> > contain more objects that were requested, due to concurrent freeing of
> >> > objects to those slabs. When no more slabs on partial lists are
> >> > available, it will allocate new slabs. It is intended to be only used
> >> > in context where spinning is allowed, so add a WARN_ON_ONCE check there.
> >> > 
> >> > Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
> >> > only refilled from contexts that allow spinning, or even blocking.
> >> > 
> >> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> 
> >> ...
> >> 
> >> > +static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
> >> > +		void **p, unsigned int count, bool allow_spin)
> >> > +{
> >> > +	unsigned int allocated = 0;
> >> > +	struct kmem_cache_node *n;
> >> > +	unsigned long flags;
> >> > +	void *object;
> >> > +
> >> > +	if (!allow_spin && (slab->objects - slab->inuse) > count) {
> >> > +
> >> > +		n = get_node(s, slab_nid(slab));
> >> > +
> >> > +		if (!spin_trylock_irqsave(&n->list_lock, flags)) {
> >> > +			/* Unlucky, discard newly allocated slab */
> >> > +			defer_deactivate_slab(slab, NULL);
> >> 
> >> This actually does dec_slabs_node() only with slab->frozen which we don't set.
> > 
> > Hi, I think I follow the intent, but I got a little tripped up here: patch 08
> > (current patch) seems to assume "slab->frozen = 1" is already gone. That's true
> > after the whole series, but the removal only happens in patch 09.
> > 
> > Would it make sense to avoid relying on that assumption when looking at patch 08
> > in isolation?
> 
> Hm I did think it's fine. alloc_from_new_slab() introduced here is only used
> from __refill_objects() and that one doesn't set slab->frozen = 1 on the new
> slab?

Yes, exactly!

> 
> Then patch 09 switches ___slab_alloc() to alloc_from_new_slab() and at the
> same time also stops setting slab->frozen = 1 so it should be also fine.

Yes. This make sense to me.

> 
> And then 12/20 slab: remove defer_deactivate_slab() removes the frozen = 1
> treatment as nobody uses it anymore.
> 
> If there's some mistake in the above, please tell!

Everything makes sense to me. The analysis looks reasonable. Thanks!

Just a quick note - I noticed that the code in your repo for b4/sheaves-for-all
has been updated. I also saw that Harry posted the latest link and did an inline
review in his reply to [05/20].

Do you happen to plan a v3 version of this patchset? Thanks!

> 
> Thanks.

