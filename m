Return-Path: <bpf+bounces-79449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6775D3A824
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 13:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E44B301056B
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6343590DB;
	Mon, 19 Jan 2026 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ujesgdvy"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F11314D2A
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824421; cv=none; b=lwyhkjm2aBwWQ1ONcwnvYizDf5r2gG6WvPz+FIYiFpcWeacvGx4mTqzwJIgTjcUlRWTbSu7RWjsDUDc2g3K+t8oWMwkcKozczuKVTdKAm2dAuYZsPJMbiEHhvRQG0EeiPVqD7aPouhMH1luM/YqDMzH91ruRGsh0ra0CTcwxzes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824421; c=relaxed/simple;
	bh=pYS6b2o5I8/LsW64YrWNylrncmSozhUOW9F9cMbip/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gie4he9QWutLb/fO9Cge4ywcN58M5FKrvid6d2q51PW7jUbk1CprWgJ8w84xjdzO2gJO731y2meH1aw+dCzjwT8RPr/hFAV+GBBJ6eumhTgitYIBfurd+bJ+5xL5IKUgfMGIwf1FlgCraUTuPJ+9PGUrIhIXvDbl8roUhck08b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ujesgdvy; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 19 Jan 2026 20:06:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768824407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lpMiDKyrIJgj/yq5I6LOa2WeBqzXUsHVn4Q35ITZoyg=;
	b=ujesgdvyRBm28X880BAWZx79BMQ8RohqEjA7JqLuDJpP/DmSQXgQ+8bYT7NuR+jJvmzVhR
	ljG7a5fFdVjNZaMsXyB0IzFcHjxszBq1zB2xjT5RXzCvPaoGf+cnw3Vk3/ji1INMlA3uik
	Aum7CZXs5jKjjyUuw5WRcMWNV65zXr4=
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
Subject: Re: [PATCH v3 07/21] slab: make percpu sheaves compatible with
 kmalloc_nolock()/kfree_nolock()
Message-ID: <gv3ixsxai47hjv2pzpnptcjeqw7ikt5nnds22hkxlbtk7wgnfd@rzzcijtth6f6>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-7-5595cb000772@suse.cz>
 <aW2zmf4dXL5C_Iu2@hyeyoo>
 <e4831aab-40e6-48ec-a4b9-1967bd0d6a4c@suse.cz>
 <008029ff-3fd8-49cf-8aa7-71b98dc15be9@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008029ff-3fd8-49cf-8aa7-71b98dc15be9@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 19, 2026 at 11:23:04AM +0100, Vlastimil Babka wrote:
> On 1/19/26 11:09, Vlastimil Babka wrote:
> > On 1/19/26 05:31, Harry Yoo wrote:
> >> On Fri, Jan 16, 2026 at 03:40:27PM +0100, Vlastimil Babka wrote:
> >>> Before we enable percpu sheaves for kmalloc caches, we need to make sure
> >>> kmalloc_nolock() and kfree_nolock() will continue working properly and
> >>> not spin when not allowed to.
> >>> 
> >>> Percpu sheaves themselves use local_trylock() so they are already
> >>> compatible. We just need to be careful with the barn->lock spin_lock.
> >>> Pass a new allow_spin parameter where necessary to use
> >>> spin_trylock_irqsave().
> >>> 
> >>> In kmalloc_nolock_noprof() we can now attempt alloc_from_pcs() safely,
> >>> for now it will always fail until we enable sheaves for kmalloc caches
> >>> next. Similarly in kfree_nolock() we can attempt free_to_pcs().
> >>> 
> >>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >>> ---
> >> 
> >> Looks good to me,
> >> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > 
> > Thanks.
> > 
> >> 
> >> with a nit below.
> >> 
> >>>  mm/slub.c | 79 ++++++++++++++++++++++++++++++++++++++++++++-------------------
> >>>  1 file changed, 56 insertions(+), 23 deletions(-)
> >>> 
> >>> diff --git a/mm/slub.c b/mm/slub.c
> >>> index 706cb6398f05..b385247c219f 100644
> >>> --- a/mm/slub.c
> >>> +++ b/mm/slub.c
> >>> @@ -6703,7 +6735,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
> >>>  
> >>>  	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())
> >>>  	    && likely(!slab_test_pfmemalloc(slab))) {
> >>> -		if (likely(free_to_pcs(s, object)))
> >>> +		if (likely(free_to_pcs(s, object, true)))
> >>>  			return;
> >>>  	}
> >>>  
> >>> @@ -6964,7 +6996,8 @@ void kfree_nolock(const void *object)
> >>>  	 * since kasan quarantine takes locks and not supported from NMI.
> >>>  	 */
> >>>  	kasan_slab_free(s, x, false, false, /* skip quarantine */true);
> >>> -	do_slab_free(s, slab, x, x, 0, _RET_IP_);
> >>> +	if (!free_to_pcs(s, x, false))
> >>> +		do_slab_free(s, slab, x, x, 0, _RET_IP_);
> >>>  }
> >> 
> >> nit: Maybe it's not that common but should we bypass sheaves if
> >> it's from remote NUMA node just like slab_free()?
> > 
> > Right, will do.
> 
> However that means sheaves will help less with the defer_free() avoidance
> here. It becomes more obvious after "slab: remove the do_slab_free()
> fastpath". All remote object frees will be deferred. Guess we can revisit
> later if we see there are too many and have no better solution...

This makes sense to me, and the commit looks good as well. Thanks!

Reviewed-by: Hao Li <hao.li@linux.dev>

> 
> >>>  EXPORT_SYMBOL_GPL(kfree_nolock);
> >>>  
> >>> @@ -7516,7 +7549,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
> >>>  		size--;
> >>>  	}
> >>>  
> >>> -	i = alloc_from_pcs_bulk(s, size, p);
> >>> +	i = alloc_from_pcs_bulk(s, flags, size, p);
> >>>  
> >>>  	if (i < size) { >  		/*
> >>> 
> >> 
> > 
> 

