Return-Path: <bpf+bounces-29929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA858C845F
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 11:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D4A1B23584
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FC2364BE;
	Fri, 17 May 2024 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VlRnJynH"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC192C68F;
	Fri, 17 May 2024 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715939922; cv=none; b=dJPQIx5ZOCN3gwcm9JZa2jexv/9HGIv3equzdTNIpxOh4CNXRJiFus6HAW/M5U8dW4VKGXg5g/lDdeALXSC926bBQpl0EBhWtMBl+QEI3yWsQnqiaYr9ASEkr7M5/pCU2iw7QXqWwNoITbREgTtU2qoiDbME4vsvIP0TjKJxTjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715939922; c=relaxed/simple;
	bh=Ia/dVEWr7HUDim7yKQ618Z6eSusWdkAeUMCVf/PkIBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKpGrzlIvxs/gXj6zVQdR978ICeU56xf45Wu7ofilNAqlycEb4oxqpnDy/yNZOxUPkmPofwm5vAhgeKdgyJUMf39HdeWREjV6gcYijeL5bkxke9MLjbdOIqXK1zAkdnYyG8QBui7fIPbgG+6O+CWmvbOujqEys7cudGG5C8PhmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VlRnJynH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hxpi/TgnORew9Z/XVkDVjx2QVxlulE667vNxVvqbtUY=; b=VlRnJynHf9XB1WJ2PuU8uoeNgE
	VdIMolFav8OAqCi1rx/aeYzCQ5aWp6It1sZZRN8BaQATBARFNT0qTDGipMZggVztCksTuSiTW9Xod
	h7r0+s51aMAtM2HoQ5EfDx9DIBhsjZff/7Hl74WAvcruReu/0HGpQ0EyIWFIUtqjmc/8YNduhWw26
	sHNIsA7PWEcbQ1+0UPn7DfJPFOOgmTqp9sC6pcY+FAKWFy4P6Ku736gXrhmJgvnCO4gdadR4DXkAP
	p8KukVuQkhH160MXcGP8GtmlCgLUl3fh2EIxK4ZeO/XCi64BWpa16V2qfytp6hFKbQnHYJHYA9VY2
	MRLOcXQA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7uLn-00000005eN4-0oKS;
	Fri, 17 May 2024 09:58:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C30AE3005E3; Fri, 17 May 2024 11:58:06 +0200 (CEST)
Date: Fri, 17 May 2024 11:58:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	torvalds@linux-foundation.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <20240517095806.GJ30852@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <ZjgWzhruwo8euPC0@slm.duckdns.org>
 <20240513080359.GI30852@noisy.programming.kicks-ass.net>
 <20240513142646.4dc5484d@rorschach.local.home>
 <20240514000715.4765jfpwi5ovlizj@airbuntu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514000715.4765jfpwi5ovlizj@airbuntu>

On Tue, May 14, 2024 at 01:07:15AM +0100, Qais Yousef wrote:
> On 05/13/24 14:26, Steven Rostedt wrote:

> > > That is, from where I am sitting I see $vendor mandate their $enterprise
> > > product needs their $BPF scheduler. At which point $vendor will have no
> > > incentive to ever contribute back.
> > 
> > Believe me they already have their own scheduler, and because its so
> > different, it's very hard to contribute back.

'They' are free to have their own scheduler, but since 'nobody' is using
it and 'they' want to have their product work on RHEL / SLES / etc..
therefore are bound to respect the common interfaces, no?

> > > So I don't at all mind people playing around with schedulers -- they can
> > > do so today, there are a ton of out of tree patches to start or learn
> > > from, or like I said, it really isn't all that hard to just rip out fair
> > > and write something new.
> > 
> > For cloud servers, I bet a lot of schedulers are not public. Although,
> > my company tries to publish the schedulers they use.

Yeah, it's the TIVO thing. Keeping all that private creates the rebase
pain. Outside of that there's nothing we can do.

Anyway, instead of doing magic mushroom schedulers, what does the cloud
crud actually want? I know the KVM people were somewhat looking forward
to the EEVDF sched_attr::sched_runtime extension because virt likes the
longer slices. Less preemption more better for them.

In fact, some of the facebook workloads also wanted longer slices (and
no wakeup preemption).

> > From what I understand (I don't work on production, but Chromebooks), a
> > lot of changes cannot be contributed back because their updates are far
> > from what is upstream. Having a plugable scheduler would actually allow
> > them to contribute *more*.

So can we please start by telling what kind of magic hacks ChromeOS has
and whatfor?

The term contributing seems to mean different things to us. Building a
external scheduler isn't contributing, it's fragmenting.

> > > Keeping a rando github repo with BPF schedulers is not contributing.
> > 
> > Agreed, and I would guess having them in the Linux kernel tree would be
> > more beneficial.

Yeah, no. Same thing. It's just a pile of junk until someone puts the
time in to figure out how to properly integrate it. Very much like Qais
argues below.

> > > That's just a repo with multiple out of tree schedulers to be ignored.
> > > Who will put in the effort of upsteaming things if they can hack up a
> > > BPF and throw it over the wall?
> > 
> > If there's a place in the Linux kernel tree, I'm sure there would be
> > motivation to place it there. Having it in the kernel proper does give
> > more visibility of code, and therefore enhancements to that code. This
> > was the same rationale for putting perf into the kernel proper.

These things are very much not the same. A pile of random hacks vs a
single unified interface to PMUs. They're like the polar opposite of
one another.

> > > So yeah, I'm very much NOT supportive of this effort. From where I'm
> > > sitting there is simply not a single benefit. You're not making my life
> > > better, so why would I care?
> > > 
> > > How does this BPF muck translate into better quality patches for me?
> > 
> > Here's how we will be using it (we will likely be porting sched_ext to
> > ChromeOS regardless of its acceptance).
> > 
> > Doing testing of scheduler changes in the field is extremely time
> > consuming and complex. We tested EEVDF vs CFS by backporting EEVDF to
> > 5.15 (as that is the kernel version we are using on the chromebooks we

/me mumbles something about necro-kernels...

> > were testing on), and then we need to add a user space "switch" to
> > change the scheduler. Note, this also risks causing a bug in adding
> > these changes. Then we push the kernel out, and then start our
> > experiment that enables our feature to a small percentage, and slowly
> > increases the number of users until we have a enough for a statistical
> > result.
> > 
> > What sched_ext would give us is a easy way to try different scheduling
> > algorithms and get feedback much quicker. Once we determine a solution
> > that improves things, we would then spend the time to implement it in
> > the scheduler, and yes, send it upstream.

This sounds a little backwards... ok, a lot. How do you do actual
problem analysis in this case? Having random statistics is not really
useful - beyond determining there might be a problem.

The next step is isolating that problem locally and reproducing it. Then
analysing *what* the actual problem is and how it happens, and then try
and think of a solution.

(preferably one that then doesn't break another thing :-)

> > To me, sched_ext should never be the final solution, but it can be
> > extremely useful in testing various changes quickly in the field. Which
> > to me would encourage more contributions.

Well, the thing is, the moment sched_ext itself lands upstream, it will
become the final solution for a fair number of people and leave us, the
wider Linux scheduler community, up a creek without no paddles on.

There is absolutely no inherent incentive to further contribute. Your
immediate problem is solved, you get assigned the next problem. That is
reality.

Worse, they can share the BPF hack and get warm fuzzy feeling of
'contribution' while in fact it's useless. At best we know 'random hack
changed something for them'. No problem description, no reproducer, no
nothing.

Anyway, if you feel you need BPF hackery to do this, by all means, do
so. But realize that it is a debug tool and in general we don't merge
debug tools.

Also, I would argue that perhaps a scheduler livepatch would be more
convenient to actually debug / A-B test things.

> I really don't think the problems we have are because of EEVDF vs CFS vs
> anything else. Other major OSes have one scheduler, but what they exceed on is
> providing better QoS interfaces and mechanism to handle specific scenarios that
> Linux lacks.

Quite possibly. The immediate problem being that adding interfaces is
terrifying. Linus has a rather strong opinion about breaking stuff, and
getting this wrong will very quickly result in a paint-into-corner type
problem.

We can/could add fields to sched_attr under the understanding that
they're purely optional and try thing, *however* too many such fields
and we're up a creek again.

> The confusion I see again and again over the years is the fragmentation of
> Linux eco system and app writers don't know how to do things properly on Linux
> vs other OSes. Note our CONFIG system is part of this fragmentation.
> 
> The addition of more flavours which inevitably will lead to custom QoS specific
> to that scheduler and libraries built on top of it that require that particular
> extension available is a recipe for more confusion and fragmentation.

Yes, this!

> I really don't buy the rapid development aspect too. The scheduler was heavily
> influenced by the early contributors which come from server market that had
> (few) very specific workloads they needed to optimize for and throughput had
> a heavier weight vs latency. Fast forward to now, things are different. Even on
> server market latency/responsiveness has become more important. Power and
> thermal are important on a larger class of systems now too. I'd dare say even
> on server market.

Absolutely, AFAIU racks are both power and thermal limited. There are
some crazy ACPI protocols to manage some of this.

> How do you know when it's okay for an app/task to consume too
> much power and when it is not? Hint hint, you can't unless someone in userspace
> tells you.

Yes, cluster/cloud infrastructure needs to manage that. There is nothing
smart the kernel can do here on its own, except respect the ACPI lunacy
and hard throttle itself when the panic signal comes.

> Similarly for latency vs throughput. What is the correct way to
> write an application to provide this info? Then we can ask what is missing in
> the scheduler to enable this.

Right, so the EEVDF thing is a start here. By providing a per task
request size, applications can indicate if they want frequent and short
activations or more infrequent longer activations.

An application can know it's (average) activation time, the kernel has
no clue when work starts and is completed. Applications can fairly
trivially measure this using CLOCK_THREAD_CPUTIME_ID reads before and
after and communicate this (very much like SCHED_DEADLINE).

Anyway, yes, userspace needs to change and provide more information. The
trick ofcourse is figuring out which bit of information is critical /
useful etc.

There is a definite limit on the amount of constraints you want to solve
at runtime.

Everybody going off and hacking their own thing does not help, we need
collaboration to figure out what it is that is needed.

> Note the original min/wakeup_granularity_ns, latency_ns etc were tuned by
> default for throughput by the way (server market bias). You can manipulate
> those and get better latencies.

The immediate problem with those knobs is that they are system wide. But
yes, everybody was randomly poking them knobs, sometimes in obviously
insane ways.

> FWIW IMO the biggest issues I see in the scheduler is that its testability and
> debuggability is hard. I think BPF can be a good fit for that. For the latter
> I started this project, yet I am still trying to figure out how to add tracer
> for the difficult paths to help people more easily report when a bad decision
> has happened to provide more info about the internal state of the scheduler, in
> hope to accelerate the process of finding solutions. 

So the pitfalls here are that exposing that information for debug
purposes can/will lead to people consuming this information for
non-debug purposes and then when we want to change things we're stuck
because suddenly someone relies something we believed was an
implementation detail :/

I've been bitten by this before and this is why I'm so very hesitant to
put tracepoints in the scheduler.

> I think it would be great to have a clear list of the current limitations
> people see in the scheduler. It could be a failure on my end, but I haven't
> seen specifics of problems and what was tried and failed to the point it is
> impossible to move forward. 

Right, list, but also ideally reproducers (yeah, I know, really hard).

The moment we merge sched_ext all motivation to do any of this work goes
out the window.

> From what I see, I am hitting bugs here and there
> all the time. But they are hard to debug to truly understand where things went
> wrong. Like this one for example where PTHREAD_PRIO_PI is a NOP for fair tasks.
> Many thought using this flag doesn't help (rather than buggy)..

Yay for the terminal backlog :/ I'll try and have a look.

