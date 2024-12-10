Return-Path: <bpf+bounces-46491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04659EA7DE
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 06:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EE1284A7F
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533C52248B0;
	Tue, 10 Dec 2024 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a0OxHuVW"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD96279FD
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 05:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733808700; cv=none; b=OjuZgq3als9IzmcjXHKVsGpwNJa4UV8S1rMoLZw6hEGrVplorM6Jyp0LYKgN25kr35Vm2dJeJpN98A3sXxjlZMuII4CdFGeuEt6EhwLAJ9kyY2MLJkuDIuoCPf0ZlwSr44O+/Cl+OWKvBCLJ+l25FZxIeVRQWBc7mR9ufj6ANpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733808700; c=relaxed/simple;
	bh=byuXzvhykZOyc0qLoEGAZdoKa/xzmLnmuysa0qRnIk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Op7cyD2u6HpY/R/CSiPJCgTq73kpn7cllEASqobDgL1K+5GCk1MAhwF5J5CfktH8jkEmVKAxukGeP/1g3osm0gspBHjWog+SXu2k2EBZp7hF6+4fOGovjaUxW8eZyqJIz0F+80Ax4Qom5OwECBY78mziTVZYq1UzXm7nGJtLKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a0OxHuVW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Gw+FTs0IxbI0TUivHWQ4v/YMUdOEV6kkcJRQz1yZZAc=; b=a0OxHuVW148VUvlyRtJ70qpMPB
	TkRSl6IErOfSj+gxGBDMc224HtvbA+m2vxx/zLVLdq6AMF2LXyUmR+dQpxqJ2uTJLj6RdcUg8z9cT
	eqUXVkj7V/7hUAaAgg3t5nJWkFLGmRKIv02V7y4T8QHen218lXfzIprjofH6Ft9bhhYTpOf+dAaNh
	Li5wLl6s6CDszkaW81PEOHvk/eGQa40VE/SjcPxJiqcB4IgWjbAIfyCAM3y5cg/s+BJ3JaTUH0c/Z
	ORvegTjvqeWIi27cqbAMmWjCMWqX28WWVWHDip7YeE7sk87gYNTJXqt/U/mvN9qyWvx8biEVXYdhU
	4vrWtyZA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKsqI-00000007CnB-1O1X;
	Tue, 10 Dec 2024 05:31:30 +0000
Date: Tue, 10 Dec 2024 05:31:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	bigeasy@linutronix.de, rostedt@goodmis.org, houtao1@huawei.com,
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@suse.com,
	tglx@linutronix.de, tj@kernel.org, linux-mm@kvack.org,
	kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Message-ID: <Z1fSMhHdSTpurYCW@casper.infradead.org>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210023936.46871-2-alexei.starovoitov@gmail.com>

On Mon, Dec 09, 2024 at 06:39:31PM -0800, Alexei Starovoitov wrote:
> +	if (preemptible() && !rcu_preempt_depth())
> +		return alloc_pages_node_noprof(nid,
> +					       GFP_NOWAIT | __GFP_ZERO,
> +					       order);
> +	return alloc_pages_node_noprof(nid,
> +				       __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO,
> +				       order);

[...]

> @@ -4009,7 +4018,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
>  	 * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
>  	 */
>  	alloc_flags |= (__force int)
> -		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
> +		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM | __GFP_TRYLOCK));

It's not quite clear to me that we need __GFP_TRYLOCK to implement this.
I was originally wondering if this wasn't a memalloc_nolock_save() /
memalloc_nolock_restore() situation (akin to memalloc_nofs_save/restore),
but I wonder if we can simply do:

	if (!preemptible() || rcu_preempt_depth())
		alloc_flags |= ALLOC_TRYLOCK;

