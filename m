Return-Path: <bpf+bounces-47286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9F59F712F
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 01:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF01893DF7
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 00:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C84C23A0;
	Thu, 19 Dec 2024 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vll38aF2"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB79380
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734566737; cv=none; b=CplPDW1TMT0Oa52U9d6Q3B35zK+ZXWJ6vQ4fNggnK4h0KWf82pAQZMokKhE+Bk9Lp1O2718VwJqGea7sN0SyUQoUCZX1tDRxjfrWT5cxdclBLQQmUdmeB+vIJC+9ptYJx3wx2yvNg0pI76V/wUq9O3WfMhOfnQ+W6s802LlMhpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734566737; c=relaxed/simple;
	bh=GuQgvd7SF8RrY+F6mYEluZQnZZJ5mVaVrgVYQ97uhCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb4AqGg5T8fTw98psNsLLIxAkPXF7ryOAts4n2jbdBeSQgmDretDo7hn4MuVNkEXqS8t5qenn9wIkMIXTsVf1UpmQ5mrIHRLrkuryDdJZ3/ckGNzJtVNWnBth/w7B0pLfF9DvWjPRfZyXiSq/Ib385/MSOVqPzniDTJR+Mr6Ygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vll38aF2; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 18 Dec 2024 16:05:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734566731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SOK3ZtEseDjwOKpJ37gcJmuhGOSuB84o0DwZ4QagqN8=;
	b=vll38aF2Q3hwF8f6Rl/ie8P7JvNw2u/3SlYfQoob5waHjDTQbVmBSO62S5OcKU4QAvFIKU
	icgYVipH8XiQpIkWuSsUa009OiIflz00pYoolqvHbMCmFeBxhtFr3xLyQ6odAXClyRMa13
	XJRqeeH1NzMUGPbE52D+XRCOghhz89k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org, andrii@kernel.org, 
	memxor@gmail.com, akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz, 
	bigeasy@linutronix.de, rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org, 
	willy@infradead.org, tglx@linutronix.de, jannh@google.com, tj@kernel.org, 
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <mnvsu2v4tnhhbzmebzg6mdmglcs3kq2nxqj2kz3v6p2eigcy6l@c5amf2pgd4zq>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-2-alexei.starovoitov@gmail.com>
 <Z2KyxEHA8NCNGF6u@tiehlicka>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2KyxEHA8NCNGF6u@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 18, 2024 at 12:32:20PM +0100, Michal Hocko wrote:
> I like this proposal better. I am still not convinced that we really
> need internal __GFP_TRYLOCK though. 
> 
> If we reduce try_alloc_pages to the gfp usage we are at the following
> 
> On Tue 17-12-24 19:07:14, alexei.starovoitov@gmail.com wrote:
> [...]
> > +struct page *try_alloc_pages_noprof(int nid, unsigned int order)
> > +{
> > +	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO |
> > +			  __GFP_NOMEMALLOC | __GFP_TRYLOCK;
> > +	unsigned int alloc_flags = ALLOC_TRYLOCK;
> [...]
> > +	prepare_alloc_pages(alloc_gfp, order, nid, NULL, &ac,
> > +			    &alloc_gfp, &alloc_flags);
> [...]
> > +	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
> > +
> > +	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
> > +
> > +	trace_mm_page_alloc(page, order, alloc_gfp & ~__GFP_TRYLOCK, ac.migratetype);
> > +	kmsan_alloc_page(page, order, alloc_gfp);
> [...]
> 
> From those that care about __GFP_TRYLOCK only kmsan_alloc_page doesn't
> have alloc_flags. Those could make the locking decision based on
> ALLOC_TRYLOCK.
> 
> I am not familiar with kmsan internals and my main question is whether
> this specific usecase really needs a dedicated reentrant
> kmsan_alloc_page rather than rely on gfp flag to be sufficient.
> Currently kmsan_in_runtime bails out early in some contexts. The
> associated comment about hooks is not completely clear to me though.
> Memory allocation down the road is one of those but it is not really
> clear to me whether this is the only one.

Is the suggestion that just introduce and use ALLOC_TRYLOCK without the
need of __GFP_TRYLOCK?

Regarding KMSAN, the __GFP_ZERO would bypass it. Maybe a comment to
explain that.


