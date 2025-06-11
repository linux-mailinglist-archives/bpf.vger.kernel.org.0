Return-Path: <bpf+bounces-60256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D259AD46A9
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 01:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FFB3A7630
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 23:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227E8280021;
	Tue, 10 Jun 2025 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RfMwful8"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D672D5431
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598113; cv=none; b=Nkc2ICAI+/qAfsSpnBSZsGRC9Owl+aeqRLtT/iFaTNnRdB8tUNlOJQ9MUrF86M2uRepo2RVziVPocfRe4TLjXsMvHFU4sVp16+xucXyzVnGLHgdvG6NIrGfv8vtJ3dUHjomNJ7y41dL3DFK+QDOPe1TGBkg79xbGYH6zCrZWaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598113; c=relaxed/simple;
	bh=bq/1yugEyImqQF2OmGun7RE4JLg4QnkOliWZgSX1DhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPSzkW1SLaKTA03ESGFO8G++FlOOVFw0qz/UzHnHKkKyS3bqireND61EzONEi1AKSKQmE4zJniJ9OJJlrMW3ywi/HQnPRD8jIRQjvXAqV0ZJtq4GwNlmphGWkK4yVABM99NLBFn6goIX64XiihkfqCjGv1sDCo06CXMXq6JynE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RfMwful8; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Jun 2025 16:28:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749598109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EqVyj4QmrQUHnNz4aolJa1B8A00baXtmiLbQJA7wgSY=;
	b=RfMwful8cDyssomCxR8rs9ARmx4/O++2QaXVOwIeiQHtYXhwJ332yE+ueeGB0JfFjar4ts
	NEIHwXfrGliMnasA2I1p59YCoi5mh/wF+BXG95/FNGlSsMGY5YxjLWqFCzqWwj5CwLO0lq
	cLL7ZhnqmgyAgoTK38UDesZD7cbkmu0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/3] cgroup: make css_rstat_updated nmi safe
Message-ID: <lmjsy6fp25bhno62mg3hz7z2ysggg4z66yhhpd6mxpzksthsbz@55hjcvz2jymh>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
 <20250609225611.3967338-3-shakeel.butt@linux.dev>
 <aEijC1iHehAxdsfi@slm.duckdns.org>
 <35ppn2muk4bsyosca4nxnbv5l6qv4ov2cxg5ksypst5ldf5zc4@vwrpziws4wjy>
 <aEi0FplA6eZUHF01@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEi0FplA6eZUHF01@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 10, 2025 at 12:39:18PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jun 10, 2025 at 03:31:03PM -0700, Shakeel Butt wrote:
> ...
> > Couple of lines above I have llist_on_list(&rstatc->lnode) check which
> > should be as cheap as data_race(css_rstat_cpu(css, cpu)->updated_next). 
> 
> Ah, I missed that.
> 
> > So, I can add lnode for nmi and non-nmi contexts (with irqs disabled)
> > but I think that is not needed. Actually I ran the netperf benchmark (36
> > parallel instances) and I see no significant differences with and
> > without the patch.
> 
> Yeah, as long as the hot path doesn't hit the extra cmpxchg, I think it
> should be fine. Can you fortify the comments a bit that the synchronization
> is against the stacking contexts on the same CPU. The use of cmpxchg for
> something like this is a bit unusual and it'd be nice to have explanation on
> why it's done this way and why the overhead doesn't matter.

I was actually thinking of using this_cpu_cmpxchg but then I need to
also check for CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS. However if you
prefer that, I can try this_cpu_cmpxchg in the next version.

I will also fix the comment with additional information about stacking
context.

