Return-Path: <bpf+bounces-46560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768819EBACB
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 21:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0DC167117
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859E1226872;
	Tue, 10 Dec 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="md3ET4Dx"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86223ED5E
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862322; cv=none; b=b6pUSe2RPERCzJGFFDXYuTGbMMlHza2AzeVJWZ3jew/OrXb4zE/LqEL9r6KroMjMC+wgpSaLuXIo1qnetE3hhyzZJTxHNQrfJXnKGakT3OI3Dt5cF12aeG1SHsrGvROuCXRHJMMnFvyhfXb9JAuj5EECrAP3WYGKMFGRZ7hdVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862322; c=relaxed/simple;
	bh=S6Db+n6VK3ZgYkgNUb5Tq6DVRN0dD3/7NTwNkNIIlhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6l2GuT61/7G6JFrUwwu+KxKYsImyVqJYpNtz7RUxAuwURFR8IX58y52sQ78/M1qW9hHozwqc9NOpDPapW61R8jDT3AMg9lPz2Zf4hKAM6a1Bn/fqMn9Yv1i85OZ46Do90/JuSKMptKQGaRacmR94pZoCsn4MOHoLrilRmr1gRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=md3ET4Dx; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Dec 2024 12:25:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733862316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7UEk9YCLql77ctfkbt68qK2vcpFDVgn1aspbQQz0FRE=;
	b=md3ET4DxfmJDU3hnmvOZoa5rfVLNCUshC7NtrNcXmuq233UkoO8gfSx3qYhylaQcUJhjso
	wykD7Czc1leWXx6uwKmgw0NkOL+boVz6SFNwzeRO+zYeIILsTP65vh1X8B2C9fNdg3X0Nd
	uLckfoqB3qfrt1ie6OuWmIN2h/Aje3M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com, 
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de, 
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org, tglx@linutronix.de, 
	tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <d7hy4vsnssi3melcb2jabdpyiuqsub5rq7fkn7u2ty5l3p27p3@r5xiszmmzquq>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com>
 <Z1fSMhHdSTpurYCW@casper.infradead.org>
 <Z1gEUmHkF1ikgbor@tiehlicka>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1gEUmHkF1ikgbor@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 10, 2024 at 10:05:22AM +0100, Michal Hocko wrote:
> On Tue 10-12-24 05:31:30, Matthew Wilcox wrote:
> > On Mon, Dec 09, 2024 at 06:39:31PM -0800, Alexei Starovoitov wrote:
> > > +	if (preemptible() && !rcu_preempt_depth())
> > > +		return alloc_pages_node_noprof(nid,
> > > +					       GFP_NOWAIT | __GFP_ZERO,
> > > +					       order);
> > > +	return alloc_pages_node_noprof(nid,
> > > +				       __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO,
> > > +				       order);
> > 
> > [...]
> > 
> > > @@ -4009,7 +4018,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
> > >  	 * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
> > >  	 */
> > >  	alloc_flags |= (__force int)
> > > -		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
> > > +		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM | __GFP_TRYLOCK));
> > 
> > It's not quite clear to me that we need __GFP_TRYLOCK to implement this.
> > I was originally wondering if this wasn't a memalloc_nolock_save() /
> > memalloc_nolock_restore() situation (akin to memalloc_nofs_save/restore),
> > but I wonder if we can simply do:
> > 
> > 	if (!preemptible() || rcu_preempt_depth())
> > 		alloc_flags |= ALLOC_TRYLOCK;
> 
> preemptible is unusable without CONFIG_PREEMPT_COUNT but I do agree that
> __GFP_TRYLOCK is not really a preferred way to go forward. For 3
> reasons. 
> 
> First I do not really like the name as it tells what it does rather than
> how it should be used. This is a general pattern of many gfp flags
> unfotrunatelly and historically it has turned out error prone. If a gfp
> flag is really needed then something like __GFP_ANY_CONTEXT should be
> used.  If the current implementation requires to use try_lock for
> zone->lock or other changes is not an implementation detail but the user
> should have a clear understanding that allocation is allowed from any
> context (NMI, IRQ or otherwise atomic contexts).
> 
> Is there any reason why GFP_ATOMIC cannot be extended to support new

GFP_ATOMIC has access to memory reserves. I see GFP_NOWAIT a better fit
and if someone wants access to the reserve they can use __GFP_HIGH with
GFP_NOWAIT.

> contexts? This allocation mode is already documented to be usable from
> atomic contexts except from NMI and raw_spinlocks. But is it feasible to
> extend the current implementation to use only trylock on zone->lock if
> called from in_nmi() to reduce unexpected failures on contention for
> existing users?

I think this is the question we (MM folks) need to answer, not the
users.

> 
> Third, do we even want such a strong guarantee in the generic page
> allocator path and make it even more complex and harder to maintain?

I think the alternative would be higher maintenance cost i.e. everyone
creating their own layer/solution/caching over page allocator which I
think we agree we want to avoid (Vlastimil's LSFMM talk).

> We
> already have a precence in form of __alloc_pages_bulk which is a special
> case allocator mode living outside of the page allocator path. It seems
> that it covers most of your requirements except the fallback to the
> regular allocation path AFAICS. Is this something you could piggy back
> on?

BPF already have bpf_mem_alloc() and IIUC this series is an effort to
unify and have a single solution.

