Return-Path: <bpf+bounces-30877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D20B8D4124
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 00:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D3A28964B
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 22:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E241C9EC7;
	Wed, 29 May 2024 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="orAqw0sq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD6E1A0B06
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020593; cv=none; b=kp3tELUvWaW1qGrt2nQ6acL1fJTMAVHxYMMFVIN4DxoRt6sry+tHRgT0yI91u6g9f68BLoiVxIa9hL65wd8bfjrqYRsM7oKyH6shPTw++O2hfROqXS96UewAmLawCjoqLk33GK7sSayzbJqBQfeHJ4xo7UvtX4Y7FuK0k6TzvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020593; c=relaxed/simple;
	bh=lsUrj+g5d0SbZG3Yj7cDrsprDSMCwBebex4XzId6dLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dg7NGzGFrcaA0+g3IgaP5JDJKGL+ARltwk8gqNIU4nrvs/2rPbcDskMLyQQ/aLFhGfRYr25RrXeedPXh/Yp8a9yxbZMq3PBAwaGmrXVZXMDZHPTLo4slE/xEOWMH1SedyLMxsV6Jn6x5vwxUH/WwScl99/xzR6QeE5Tmu+Dhung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=orAqw0sq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4211249fbafso2480945e9.3
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717020590; x=1717625390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=peC3dLc1iF5iZFELK9i3hjmf/MdP9AREksPgTWzVxyQ=;
        b=orAqw0sqqTKDnB5CayuomXXgcdPW/tav/T8DwP1/sVlvXv2iPYaUgORGsxTGiUiNg4
         aaf/XHW2LzjvONXcLQlnknmygnCraTRdM78zmes8rDcaQAVJd7K+T1eMRC0RREoCvLQ/
         cI9rs4VkImTx6RgTeRhvbVsS7q2nrLcteDXFA0D3ZVOeqCJQSgqw4E7wTa66EvbfiX2H
         vsEuh6tD8WCiyEdU4wfp/UATZlbKod7DS4gm+0zaE4ewLMFwqStJERkCOuor8XqM4W7a
         DKkjFFeUWse6zAq2uRNrw8rOSdCb9iBmNfdr/6Uk2rD8L3XPauetcsGpVIcw0106WhdG
         hfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717020590; x=1717625390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peC3dLc1iF5iZFELK9i3hjmf/MdP9AREksPgTWzVxyQ=;
        b=j+eGKj2a7W7IheI0FoHRDN67lcGWtor7NObEOVvCSnretufYQ/6vpOAmNL+cf5r9dX
         F7ICTUnAvtIiB+je+1hsssxUlul8dsVsKfip2F7K2oniBYhSCUJcQTPJya3M0ACoQeey
         0Z5+er6YBHvmN9X6IjGR94Jl9pS5+6xP3bImnDaP+/HgZMc/9j81cEG0I8Rn5u7rT52f
         0ybzGGT+adSGhr9MRUARHr5o7QM/R94paB51UjcUUl6NPX9ceEfVYBe4/7R/G34re4b9
         6VSIDsxb8YMl5lKSGYaBsXMzex61UP0B4G4+CfqdOc1K9yVUGeXSL4sqncpOFhFjgyfq
         PT7g==
X-Forwarded-Encrypted: i=1; AJvYcCXA51+eImoj97IzyG73Wg4N1U3JnOlyQg1XqDkX38gGBZ4dgW+w0m7FpNsM+Nr6HqODt0vXXz/8tf+XhQefjw4lZlDn
X-Gm-Message-State: AOJu0YwWUOyj6vkkh6cLfMCOl5LjO2Y//3zjmL6JCjiqCi/4SeBvNIr8
	j+wXy8v6f2+aIzEL7oFclBOp2K9e3AleAiIaqFOwia5w4LHsDydAFI5aZco0ZTE=
X-Google-Smtp-Source: AGHT+IG3pBFiuYE5/mN8gIAvHfHwu7YSneojcKffB7ch1odqlQSiPGmtPn5o31/xvxfFahUJ8Dp24w==
X-Received: by 2002:a05:600c:154e:b0:420:112e:6c1 with SMTP id 5b1f17b1804b1-4212781b016mr5472785e9.13.1717020589514;
        Wed, 29 May 2024 15:09:49 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557dcf0740sm15801060f8f.107.2024.05.29.15.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:09:49 -0700 (PDT)
Date: Wed, 29 May 2024 23:09:47 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20240529220947.mocxiiugpvf4u4no@airbuntu>
References: <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <ZjgWzhruwo8euPC0@slm.duckdns.org>
 <20240513080359.GI30852@noisy.programming.kicks-ass.net>
 <20240513142646.4dc5484d@rorschach.local.home>
 <20240514000715.4765jfpwi5ovlizj@airbuntu>
 <20240514213402.GB295811@maniforge>
 <20240527212540.u66l3svj3iigj7ig@airbuntu>
 <ZlZsyFl79Zk074eK@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlZsyFl79Zk074eK@slm.duckdns.org>

On 05/28/24 13:46, Tejun Heo wrote:
> Hello,
> 
> BTW, David is off for the week and might be a bit slow to respond. I just
> want to comment on one part.
> 
> On Mon, May 27, 2024 at 10:25:40PM +0100, Qais Yousef wrote:
> ...
> > And I can only share my experience, I don't think the algorithm itself is the
> > bottleneck here. The devil is in the corner cases. And these are hard to deal
> > with without explicit hints.
> 
> Our perceptions of the scope of the problem space seem very different. To
> me, it seems pretty unexplored. Here's just one area: Constantly increasing
> number of cores and popularization of more complex cache hierarchies.
> 
> Over a hundred CPUs in a system is fairly normal now with a couple layers of
> cache hierarchy. Once we have so many, things can look a bit different from
> the days when we had a few. Flipping the approach so that we can dynamically
> assign close-by CPUs to related groups of threads becomes attractive.

I had this use case in mind actually for sched-qos [1] idea I am trying to
develop. There are workloads that can benefit if 2 or 3 tasks are kept withing
the closest cache. And I think we can describe that with a hint.

I was thinking to borrow from core scheduling concept of cookie to tag a group
of task via the hint and try to find reasonable higher level behavior that we
can translate correctly into different systems.

> 
> e.g. If you have a bunch of services which aren't latency critical but are
> needed to maintain system integrity (updates, monitoring, security and so
> on), soft-affining them to a number of CPUs while allowing some CPU headroom
> can give you noticeable gain both in performance (partly from cleaner
> caches) and power consumption while not adding that much to latency. This is
> something the scheduler can and, I believe, should do transparently.

This looks similar to what I am trying to do with uclamp_max and extending load
balancer to allow to balance workloads based on power - keeping in mind freeing
resources for tasks that need performance too. I don't think we can fix this
problem on wake up balance only. The system is in a constant flux and we need
load balancer to do corrections when other things wake up and we need better
decisions to be made.

Generally if we have EAS type of behavior available for SMP systems where we
don't distribute by default but try to pack based on compute demand - and
a hint to tell us that some tasks really want to be spread as an exception for
those that packing really hurts them, I think we'd be in a much better place to
be able to distribute resources like you describe.

> 
> It's not obvious how to do it though. It doesn't quite fit the current LB
> model. cgroup hierarchy seems to provide some hints on how threads can be
> grouped but the boundaries might not match that well. Even if we figure out

cgroups is too aggressive IMHO. We really need per-task hints. It's coarse vs
fine grained hinting. There's only so much classification you can give to
a larger group of tasks. Especially if you can't control the codebase of this
group of tasks.

Some people can get invested in tuning specific apps. But this is not
scalable and fragile.

> how to define these groups, figuring out group-vs-group competition isn't
> trivial (naive load-sums don't work when comparing across groups spanning
> multiple CPUs).

I think the implementation is trickier than the definition. There's lots of
demands to keep the fast path as fast as possible. To do smarter decisions this
will get expensive. Personally I think today we have abundant of compute power
and the challenge is how to smartly distribute resources, which justify slowing
things down in favour of making better choices. But I don't know how much we
can afford to be honest.

Generally as I was telling David, people who tend to come forward more to
support or complain are those who have pure throughput in mind. Maybe I am
wrong, but from my perception a lot of decisions were biased this way. We need
to be more vocal about our needs to make sure that things move in the right
direction. It's hard to help a use case or fix a problem when you don't know
about it.

> 
> Also, what about the threads with oddball cpumasks? Should we begin to treat
> CPUs more like other resources, e.g., memory? We don't generally allow
> applications to specify which specific physical pages they get because that
> doesn't buy anything while adding a lot of constraints. If we have dozens
> and hundreds of CPUs, are there fundamental reason to view them differently
> from other resources which are treated fungible?

I'd be more than happy to see affinity and cpuset disappear :) But I fear it
might be a little too late..

Can't some selinux rule or some syscall filter be used to block userspace from
playing with affinity?

I'm assuming you're not referring to in-kernel usage of affinity. Which might
be worth scrutinizing. But we have more control over that in general to make it
better when a problem arises.

> 
> The claim that the current scheduler has the fundamentals all figured out
> and it's mostly about handling edge cases and educating users seems wildly
> off mark to me.

I don't think anyone claimed that. But EEVDF or CFS is about how tasks enqueued
on the CPU will be ordered and run. It's not about selecting which CPU to run
the task on.

EAS modifies the selection algorithm (which is not what David was talking about
IIUC). It seems your problems are more with CPU selection then?

> 
> Maybe we can develop all that in the current framework in a gradual fashion,
> but when the problem space is so wide open, that is not a good approach to
> take. The cost of constricting is likely significantly higher than the
> benefits of having a single code base. Imagine having to develop all the
> features of btrfs in the ext2 code base. It's probably doable, at least
> theoretically, but that would have been massively stifling, maybe to the
> point of most of it not happening.
> 
> To the above particular problem of soft-affinity, scx_layered has something

What layered refers to here? Is it akin to different sched classes?

> really simple and dumb implemented and we're testing and deploying it in the
> fleet with noticeable perf gains, and there are early efforts to see whether
> we can automatically figure out grouping based on the cgroup hierarchy and
> possibly minimal xattr hints on them.
> 
> I don't yet know what generic form soft-affinity should take eventually,
> but, with sched_ext, we have a way to try out different ideas in production
> and iterate on them learning each step of the way. Given how generic both
> the problem and benefits from solving it are, we'll have to reach some
> generic solution at one point. Maybe it will come from sched_ext or maybe it
> will come from people working on fair like yourself. Either way, sched_ext
> is already showing us what can be achieved and prodding people towards
> solving it.

To be honest this doesn't look any different to all the hacks out there that do
the same. The path I see this is going into is the same as I mentioned above
where some people manually tune for specific usage. I really struggle to see
how this is going to be applicable later and all I see a divergence and
parallel universes - which ultimately will hurt the user as Linux behavior is
just not predictable.

This Linus rant [2] is relevant to the situation. In this case people who write
applications will just find that Linux is not reliable because every system
doesn't behave the same.

[1] https://lore.kernel.org/lkml/20230916213316.p36nhgnibsidoggt@airbuntu/
[2] https://lore.kernel.org/lkml/CAHk-=wgtb7y-bEh7tPDvDWru7ZKQ8-KMjZ53Tsk37zsPPdwXbA@mail.gmail.com/


Thanks!

--
Qais Yousef

