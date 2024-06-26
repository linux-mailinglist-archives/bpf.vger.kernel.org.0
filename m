Return-Path: <bpf+bounces-33139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28703917AD9
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 10:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D1C1C213C0
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4237013B78F;
	Wed, 26 Jun 2024 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rQOm0wP+"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910613AD33;
	Wed, 26 Jun 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390250; cv=none; b=W/B27oLu/HhT1ozTzx5tUpnFDKiPVtVtUUrdyAMYcpZ97/OMg+X2qDUbwn6ugWjaFsA2ALAqfdP2Ytv68gCOPC2xIVAMKynLOPMWp0PKqqPqZfjZgDPrGKMkXVTO0rGf8BCGRTHfiwGqOji8QMP7g7JqM+49TU7M5c1V6Do/9/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390250; c=relaxed/simple;
	bh=hFjnBVZaQ84KTi0KY90vzMyKPz9vZmAD8T9JcF4ZFHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsp5XRrpiBch2g+eU9tZEJdFwA0bJM7efQ3FKdDXOJvrQ0YetMw9Rbcv6ZLBlYnfHUQ6vPCgWvmf27pJDnfR7yx0Nn1KNC2A0gxRB+81qOdycZiNouAaZra6t2a3+L9hk5uRQn1aiGEllcq1zTS/bO0RhD6emFOux5XP9X9oPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rQOm0wP+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MnInG30T3/lPXgCTZ/E8svWPD172SSqlozhE6pwL6I4=; b=rQOm0wP+qt4RlZnCnk+Shs/54e
	OEcC6DPtfrsBospnr2WOy9IKLOZ8ZW5avgBUeLH4NAn/+Vpawus3vdmns3NYVqyxF4ru7cCXGTxuG
	/Lxygd99pdTyO3eS6fWucxN0KdGilLir7qkQOsx192dJSozHWcR/R4kU+spThcGLFzr0L73z6WcAw
	91WX4ghBIda52QAFRlhy/uNpppFfd1Aoub8KR/nsOqoFjprGXk6yJd8i6xy/shpUKbNR0VTqzyYgi
	odZOp1xJ3BwKQiBvO2inK4rBeLJtToJ0TuDjckWcO+bHX86wsRiSovM6UlOUlCRSOueS1pxhDsEP2
	PuK2PLbg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMNwN-0000000C3pz-0dkv;
	Wed, 26 Jun 2024 08:23:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8DF0A3002C7; Wed, 26 Jun 2024 10:23:42 +0200 (CEST)
Date: Wed, 26 Jun 2024 10:23:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 09/39] sched: Add @reason to
 sched_class->rq_{on|off}line()
Message-ID: <20240626082342.GY31592@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-10-tj@kernel.org>
 <20240624113212.GL31592@noisy.programming.kicks-ass.net>
 <ZnnijsMAQYgCnrZF@slm.duckdns.org>
 <20240625082926.GT31592@noisy.programming.kicks-ass.net>
 <ZntVjZ3a2k5IGbzE@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZntVjZ3a2k5IGbzE@slm.duckdns.org>

On Tue, Jun 25, 2024 at 01:41:01PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jun 25, 2024 at 10:29:26AM +0200, Peter Zijlstra wrote:
> ...
> > > Taking a step back to the sched domains. They don't translate well to
> > > sched_ext schedulers where task to CPU associations are often more dynamic
> > > (e.g. multiple CPUs sharing a task queue) and load balancing operations can
> > > be implemented pretty differently from CFS. The benefits of exposing sched
> > > domains directly to the BPF schedulers is unclear as most of relevant
> > > information can be obtained from userspace already.
> > 
> > Either which way around you want to turn it, you must not violate
> > partitions. If a bpf thing isn't capable of handling partitions, you
> > must refuse loading it when a partition exists and equally disallow
> > creation of partitions when it does load.
> > 
> > For partitions specifically, you only need the root_domain, not the full
> > sched_domain trees.
> > 
> > I'm aware you have these shared runqueues, but you don't *have* to do
> > that. Esp. so if the user explicitly requested partitions.
> 
> As a quick work around, I can just disallow / eject the BPF scheduler when
> partitioning is configured. However, I think I'm still missing something and
> would appreciate if you can fill me in.
> 
> Abiding by core scheduling configuration is critical because it has direct
> user visible and security implications and this can be tested from userspace
> - are two threads which shouldn't be on the same core on the same core or
> not? So, the violation condition is pretty clear.
> 
> However, I'm not sure how partioning is similar.

I'm not sure what you mean. It's like violating the cpumask, probably
not a big deal, but against the express wishes of the user.

> My understanding is that it
> works as a barrier for the load balancer. LB on this side can't look there
> and LB on that side can't look here. However, isn't the impact purely
> performance / isolation difference? 

Yes. But this isolation is very important to some people.

> IOW, let's say you laod a BPF scheduler
> which consumes the partition information but doesn't do anything differently
> based on it. cpumasks are still enforced the same and I can't think of
> anything which userspace would be able to test to tell whether partitioning
> is working or not.

So barring a few caveats it really boils down to a task staying in the
partition it's part of. If you ever see it leave, you know you got a
problem.

Now, there's a bunch of ways to actually create partitions:

 - cpuset
 - cpuset-v2
 - isolcpus boot crap

And they're all subtly different iirc, but IIRC the cpuset ones are
simplest since the task is part of a cgroup and the cgroup cpumask is
imposed on them and things should be fairly straight forward.

The isolcpus thing creates a pile of single CPU partitions and people
have to manually set cpu-affinity, and here we have some hysterical
behaviour that I would love to change but have not yet dared do --
because I know there's people doing dodgy things because they've been
sending 'bug' reports.

Specifically it is possible to set a cpumask that spans multiple
partitions :-( Traditionally the behaviour was that it would place the
task on the lowest cpu number, the current behaviour is the task it
placed randomly on any CPU in the given mask.

It is my opinion that both behaviours are correct, since after all, we
don't violate the given constraint, the user provided mask. If that's
not what you wanted, you should be setting something else etc..

I've proposed rejecting a cpumask that spans partitions -- I've not yet
done this, because clearly people are doing this, however misguided. But
perhaps we should just bite the bullet and cause pain -- dunno.

Anyway, tl;dr, you can have a cpumask wider than a parition and people
still not wanting migrations to happen.

> If the only difference partitions make is on performance. 

People explicitly did not want migrations there -- otherwise they would
not have gone to the trouble of setting up the partitions in the first
place.

> While it would
> make sense to communicate partitions to the BPF scheduler, would it make
> sense to reject BPF scheduler based on it? ie. Assuming that the feature is
> implemented, what would distinguish between one BPF scheduler which handles
> partitions specially and the other which doesn't care?

Correctness? Anyway, can't you handle this in the kernel part, simply
never allow a shared runqueue to cross a root_domain's mask and put some
WARNs on to ensure constraints are respected etc.? Should be fairly
simple to check prev_cpu and new_cpu are having the same root_domain for
instance.


