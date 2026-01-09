Return-Path: <bpf+bounces-78312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5243D090FE
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 12:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54328304918E
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 11:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5514359FBA;
	Fri,  9 Jan 2026 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DGG+debD"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9590359F80
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959338; cv=none; b=BPQ8TtO3y3yQ0QwRKYAzu3z146X+J+BTklQUX4slLPENmSNIagjWky3fWH28tSvXujvjlhiE6B3jB3eRkSsFDGQoXvg51zKbH0pb6K3no5S6fg1Mw6EYp2tOF3b+R1IWV0brhHP2sgsUJRL40RxaDpd/zP2gihzhO/W2uh5pqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959338; c=relaxed/simple;
	bh=eErXE//ncGyeU4JQY/JXneK1qVVCn2SNPo5WntgoMWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfTiWTdeeUHSeN/+6h1wVWaIgzkgjNtlXAKVa5HWc0FTb0nncRwF4tN4QDpHHLWAFhn7zTjp5QA99VVanKMM5QodEFYaDrDpWsqp4tv45m+5rznnun4cC23L6sTQNHqS29ezbf4/VL0Isx1xbSGK2FEJY1qpse1TbOsmcsPJqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DGG+debD; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 9 Jan 2026 19:48:20 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767959323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oYF757VFZbjPp9+rgGQc+tuvo82+suocCGJ/1TmFUs0=;
	b=DGG+debD1nXBpLE0MoRfyiShZtxYlLel08B5gTq+kCz48gVHJQcOg0/1PR9z7KH/fhJbRi
	+YEQA1Le1H2Bu4DPWxSQyN7g6gxXcrzw9wUwJ68Z1KZtbsot2V9xdcPpeZsFkyVHo8vwrD
	yusszebGfsODVk/Td+V3bNeApIR86+0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH RFC 14/19] slab: simplify kmalloc_nolock()
Message-ID: <6lagtqkkxsnuphgmluwodah7nlhiuovw74fzdzr7xgq4nwdwup@eyfgwukzbynd>
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-14-6ffa2c9941c0@suse.cz>
 <4ukrk3ziayvxrcfxm2izwrwt3qrmr4fcsefl4n7oodc4t2hxgt@ijk63r4f3rkr>
 <4fca7893-60bd-41da-844f-971934de19b6@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fca7893-60bd-41da-844f-971934de19b6@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 09, 2026 at 11:11:26AM +0100, Vlastimil Babka wrote:
> On 12/16/25 03:35, Hao Li wrote:
> > On Thu, Oct 23, 2025 at 03:52:36PM +0200, Vlastimil Babka wrote:
> >> @@ -5214,27 +5144,13 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> >>  	if (ret)
> >>  		goto success;
> >>  
> >> -	ret = ERR_PTR(-EBUSY);
> >> -
> >>  	/*
> >>  	 * Do not call slab_alloc_node(), since trylock mode isn't
> >>  	 * compatible with slab_pre_alloc_hook/should_failslab and
> >>  	 * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
> >>  	 * and slab_post_alloc_hook() directly.
> >> -	 *
> >> -	 * In !PREEMPT_RT ___slab_alloc() manipulates (freelist,tid) pair
> >> -	 * in irq saved region. It assumes that the same cpu will not
> >> -	 * __update_cpu_freelist_fast() into the same (freelist,tid) pair.
> >> -	 * Therefore use in_nmi() to check whether particular bucket is in
> >> -	 * irq protected section.
> >> -	 *
> >> -	 * If in_nmi() && local_lock_is_locked(s->cpu_slab) then it means that
> >> -	 * this cpu was interrupted somewhere inside ___slab_alloc() after
> >> -	 * it did local_lock_irqsave(&s->cpu_slab->lock, flags).
> >> -	 * In this case fast path with __update_cpu_freelist_fast() is not safe.
> >>  	 */
> >> -	if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
> >> -		ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);
> >> +	ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);
> >>  
> >>  	if (PTR_ERR(ret) == -EBUSY) {
> > 
> > After Patch 10 is applied, the logic that returns `EBUSY` has been
> > removed along with the `s->cpu_slab` logic. As a result, it appears that
> > `__slab_alloc_node` will no longer return `EBUSY`.
> 
> True, I missed that, thanks.
> Since we can still get failures due to the cpu_sheaves local lock held, I
> think we could just do the single retry with a larger bucket if ret is NULL.

Sounds good - this is a clean approach.

> Whlle it may be NULL for other reasons (being genuinely out of memory and
> the limited context not allowing reclaim etc), it wouldn't hurt, and it's
> better than to introduce returning EBUSY into various paths.

I agree - it seems cleaner for __slab_alloc_node() to return only NULL
or a valid pointer. If it could also return -EBUSY, the return semantics
would be a bit less clear.

-- 
Thanks,
Hao

> 
> >>  		if (can_retry) {
> >> @@ -7250,10 +7166,6 @@ void __kmem_cache_release(struct kmem_cache *s)
> >>  {
> >>  	cache_random_seq_destroy(s);
> >>  	pcs_destroy(s);
> >> -#ifdef CONFIG_PREEMPT_RT
> >> -	if (s->cpu_slab)
> >> -		lockdep_unregister_key(&s->lock_key);
> >> -#endif
> >>  	free_percpu(s->cpu_slab);
> >>  	free_kmem_cache_nodes(s);
> >>  }
> >> 
> >> -- 
> >> 2.51.1
> >> 
> 

