Return-Path: <bpf+bounces-48998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C48FA12F03
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1F7164988
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47B11DC983;
	Wed, 15 Jan 2025 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GmzTUVI+"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DCC14B959
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983003; cv=none; b=VOC4N38PJVCaGCBC367BRtl+m17gE7femr+JaJf/vAUM1nUmuUSZTNUfIkuRzi2Gk3Yvc0evCVc+CigotZQe6aFBpvvh1iDQKFfwmmm3MhgYRzEqtMxRkCMMTPdPmgbsGTPOdvFoLKDm6CX9k2QNay2hv5sMoT47SZh5Owc5O3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983003; c=relaxed/simple;
	bh=6Rk5XuUtIq5USy1W8DDy3wtt6XymrFh2crZ0XgRBLzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNFTybWqdN9g6gIdm7hsl9fitLP0v+cCj1XpgBIJRWJwWntE49jHKmbm0PPIvEHZD7fQEADc3m8TvhulhQ7GlDkmEe1blobyHiHP44Vn3PSqKNRjlIIky1q7BpUu3oY2srNaySAMxMYCgsShoe8XrDNPHjsiPmhj7LmCqz6pqto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GmzTUVI+; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Jan 2025 15:16:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736982999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=axF+f7tzSqusWtb6U7ffYDPSYLjV3pC91g+FQtc03MU=;
	b=GmzTUVI+MtUT8zdo2uwaMDl1gpHXwSwFFyIX4leoZUwA8PBruXddyB8z14iMD47iL50YXY
	spJwUeGTQ9hQEekzfIp5mhuaXktNXTdfY30dlGeb3Ikl1VH/P9PoKUbQi9bsNHywJAWi6c
	0dm7D7u2C0TiS0EDiFUX+Wu6b1LW9Pc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org, 
	peterz@infradead.org, bigeasy@linutronix.de, rostedt@goodmis.org, houtao1@huawei.com, 
	hannes@cmpxchg.org, mhocko@suse.com, willy@infradead.org, tglx@linutronix.de, 
	jannh@google.com, tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v5 1/7] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <z4uojz6n4w6xctnpclllrdzaju3yfy2apkkiul4esxjgnhdm6k@bxyg5gzvyxdn>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-2-alexei.starovoitov@gmail.com>
 <9fb94763-69b2-45bd-bc54-aef82037a68c@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fb94763-69b2-45bd-bc54-aef82037a68c@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 15, 2025 at 12:19:26PM +0100, Vlastimil Babka wrote:
> On 1/15/25 03:17, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> > 
[...]
> > +
> > +	if (nid == NUMA_NO_NODE)
> > +		nid = numa_node_id();
> > +
> > +	prepare_alloc_pages(alloc_gfp, order, nid, NULL, &ac,
> > +			    &alloc_gfp, &alloc_flags);
> > +
> > +	/*
> > +	 * Best effort allocation from percpu free list.
> > +	 * If it's empty attempt to spin_trylock zone->lock.
> > +	 */
> > +	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
> 
> What about set_page_owner() from post_alloc_hook() and it's stackdepot
> saving. I guess not an issue until try_alloc_pages() gets used later, so
> just a mental note that it has to be resolved before. Or is it actually safe?
> 

stack_depot_save() does not seem safe here.

> > +
> > +	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
> > +
> > +	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
> > +	kmsan_alloc_page(page, order, alloc_gfp);
> > +	return page;
> > +}
> 

