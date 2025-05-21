Return-Path: <bpf+bounces-58704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7ADAC00CC
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 01:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA18B3BFF7B
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 23:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3607323C8A8;
	Wed, 21 May 2025 23:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ApQe7xIV"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E501C186294
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747871460; cv=none; b=q+NJ0rZtRPtQ2J6JjgtjK/dUPGhcfgJGGDDRMSo2W8TRfN/yEH7e4nPlvrY6WQuato+Je0z5ZWMFrp2AsD7OKnzgabc9S3MhIoeFYHmaX3XD41VgDYi2Si4UH5BqB7S3/TI7w8PcMZNTddoS0TtYG1UyqFlSMOX2qSA9id+SYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747871460; c=relaxed/simple;
	bh=lc83500E611NodH+3wkC7271Cl/mQIsbNFuQo3YJ65M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PITlPGACOkvUmlRE+XZ5Ufkzm1b5plulOmRiKb89S223s9nbTC6taYLLAkf9mx1EglEZDfqQiL9mBrccy1MsKRbwHfAaXIi1U8buSbCKtlfSjdx2wTVqnvaSYEW/itp9PWYpka4tltuaFfCeMPWNrP3bw03PfRDdB9lN8buBaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ApQe7xIV; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 May 2025 16:50:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747871456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Li8vMzkz2DScQy48n1mOKI/BV9l+/HG3atLWmKwQyVo=;
	b=ApQe7xIVIUjgwmE9xIOAZ0Zd8DvOwH0fYJMiY7Twa8IZ7ybgRSmUqddUI4tQjGm4NAar1Z
	I8h1B0l6ha6EcqSWaXO+6If8l2r1m9vG2S3nHIdYU31Px/+b6AqWQlrg0/7NyrAM36wCnX
	jq1RUs+w5szf53y5VGOBrANIvP2L1TQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Klara Modin <klarasmodin@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [OFFLIST PATCH 2/2] cgroup: use subsystem-specific rstat locks
 to avoid contention
Message-ID: <fyu3eohrzarujgjwtpg6b2jultwntihm5kreoqx3b3gqlamum3@imbouehlyhle>
References: <20250428174943.69803-1-inwardvessel@gmail.com>
 <20250428174943.69803-2-inwardvessel@gmail.com>
 <ad2otaw2zrzql4dch72fal6hlkyu2mt7h2eeg4rxgofzyxsb2f@7cfodklpbexu>
 <gzwa67k6i35jw5h3qfdajuzxa2zgm6ws2x5rjiisont4xiz4bp@kneusjz5bxwb>
 <a6le7a3gzao7acxzo4i2sfnoxffmz2vhd34gzlgsow4uy7lv6k@tigt33bel4fi>
 <netbpt5aylanmxb6pxdvvkgket7hjbtxyjyceb6h6v2yyr4tcd@rc5zbyhsms2e>
 <9151095d-98dc-4497-9a64-b2eb7f8f96ea@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9151095d-98dc-4497-9a64-b2eb7f8f96ea@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, May 21, 2025 at 04:47:01PM -0700, JP Kobryn wrote:
> 
> 
> On 5/21/25 4:33 PM, Shakeel Butt wrote:
> > On Wed, May 21, 2025 at 04:23:44PM -0700, Shakeel Butt wrote:
> > > On Thu, May 22, 2025 at 12:23:44AM +0200, Klara Modin wrote:
> > > > Hi,
> > > > 
> > > > On 2025-04-28 23:15:58 -0700, Shakeel Butt wrote:
> > > > > Please ignore this patch as it was sent by mistake.
> > > > 
> > > > This seems to have made it into next:
> > > > 
> > > > 748922dcfabd ("cgroup: use subsystem-specific rstat locks to avoid contention")
> > > > 
> > > > It causes a BUG and eventually a panic on my Raspberry Pi 1:
> > > > 
> > > > WARNING: CPU: 0 PID: 0 at mm/percpu.c:1766 pcpu_alloc_noprof (mm/percpu.c:1766 (discriminator 2))
> > > > illegal size (0) or align (4) for percpu allocation
> > > 
> > > Ok this config is without CONFIG_SMP and on such configs we have:
> > > 
> > > typedef struct { } arch_spinlock_t;
> > > 
> > > So, we are doing ss->rstat_ss_cpu_lock = alloc_percpu(0).
> > > 
> > > Hmm, let me think more on how to fix this.
> > > 
> > 
> > I think following is the simplest fix:
> > 
> > diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> > index 7dd396ae3c68..aab09495192e 100644
> > --- a/kernel/cgroup/rstat.c
> > +++ b/kernel/cgroup/rstat.c
> > @@ -511,7 +511,10 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
> >   	int cpu;
> >   	if (ss) {
> > -		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
> > +		size_t size = sizeof(raw_spinlock_t) ?: 1;
> > +
> > +		ss->rstat_ss_cpu_lock = __alloc_percpu(size,
> > +						__alignof__(raw_spinlock_t));
> 
> Thanks for narrowing this one down so fast. Would this approach be more
> straightforward?
> 
> if (ss) {
> #ifdef CONFIG_SMP
> 	ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
> #endif
> 
> Since on non-smp the lock functions are no-ops, leaving the ss cpu lock
> can perhaps be left NULL. I could include a comment as well explaining
> why.
> 
> >   		if (!ss->rstat_ss_cpu_lock)
> >   			return -ENOMEM;

Include this check and return -ENOMEM in the ifdef as well.

> >   	}
> 

