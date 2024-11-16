Return-Path: <bpf+bounces-45024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20EF9D00B9
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 20:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A733F283206
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35937199243;
	Sat, 16 Nov 2024 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pf59OvQL"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702DB1953B0
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731786136; cv=none; b=VBjaw34ebon0RCRxjWfvylQu4tNjah+2MPixnSLuXoqxL5QkWI23pNutb8IevjGLxiwATdUJRtvr3xPrK6SnNkH9QBP8GYJxp45ISlQS67q4YGAgWF+SRs3VGb1yl/65iGg4izs2hgxNTkCr2HsCYQhYSMgItoFALkWn13orphI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731786136; c=relaxed/simple;
	bh=Ey4eESnExxIeDRTRgUJAJahzmwLekDVcwTrAooF4im8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJPBa8q8GMpknDdnlW4i5SgVIrrQlOs4K5HN2JR5/cSnsAQ8xgMlV8H4NbeuNRQie489k+PznainqKOaOojc4bBN6kn0M96YfUIyLi/4tBsXtRwtnnPs+iTpNCc8iUQQpmGdi6ZrLEdpiovMVp2aeH9KDjKo2KskL7i/akhskD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pf59OvQL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fZGbomyZu6zTnQ62uppZtmdlye3OKIH3UwVWExVH2Og=; b=Pf59OvQLIcw4zdejI9rF5drxU0
	/JJgKwV9K9jSEUZoWwOk0CKiGZRVoZGoui+2wTh+rfxUpAuPhvNC7HgmSz4Vbmrzef8R6DXtl7xCS
	Ggh3lYFoVfKLIgsJ25HlD3UPUAtSZen2xpthm7kjsILNIRoQH8zgi5ZdMx03o8BF2r11GyzGcOYrl
	em+8jK/As7HVPrjh4GlWQpD5xOae0nO+DJUAYAjUb3RfLuyoRgq9630Ny25x6Jxk5Y/SF9mKrx0gT
	xg7+ReZbuw1jptTEU53r3EwOidiinwB0ERPurLC//To4v7sCdTsvMfha275fdzmHdTgrsviKzvGYz
	EDlqEaKA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tCOgD-00000001P4Y-1DrO;
	Sat, 16 Nov 2024 19:42:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 23668300472; Sat, 16 Nov 2024 20:42:02 +0100 (CET)
Date: Sat, 16 Nov 2024 20:42:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, vbabka@suse.cz, houtao1@huawei.com,
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@suse.com,
	tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/2] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <20241116194202.GR22801@noisy.programming.kicks-ass.net>
References: <20241116014854.55141-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116014854.55141-1-alexei.starovoitov@gmail.com>

On Fri, Nov 15, 2024 at 05:48:53PM -0800, Alexei Starovoitov wrote:
> +static inline struct page *try_alloc_page_noprof(int nid)
> +{
> +	/* If spin_locks are not held and interrupts are enabled, use normal path. */
> +	if (preemptible())
> +		return alloc_pages_node_noprof(nid, GFP_NOWAIT | __GFP_ZERO, 0);

This isn't right for PREEMPT_RT, spinlock_t will be preemptible, but you
very much do not want regular allocation calls while inside the
allocator itself for example.

> +	/*
> +	 * Best effort allocation from percpu free list.
> +	 * If it's empty attempt to spin_trylock zone->lock.
> +	 * Do not specify __GFP_KSWAPD_RECLAIM to avoid wakeup_kswapd
> +	 * that may need to grab a lock.
> +	 * Do not specify __GFP_ACCOUNT to avoid local_lock.
> +	 * Do not warn either.
> +	 */
> +	return alloc_pages_node_noprof(nid, __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO, 0);
> +}

