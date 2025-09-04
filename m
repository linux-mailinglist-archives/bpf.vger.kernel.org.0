Return-Path: <bpf+bounces-67509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D542B448FD
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 00:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD080A4530E
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F652D73A8;
	Thu,  4 Sep 2025 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oi0Wl36p"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970942857F8;
	Thu,  4 Sep 2025 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023347; cv=none; b=g3O1cDHtWHUUSiY7134uJm7HO6IRZ5upijbPFXZu8CjaYOsN0jYC5Po8+kea8lGdC+vhSTpDhoUpM2ccmj+ebvMtk38ogWH/NbfJS27zQyxdHfoJ0TNn1TlY02hdKXl1zsK0X9Muc4VuWk/m5xs1h82LEtmFhxLKg3KqkHJgl7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023347; c=relaxed/simple;
	bh=h7IL8BxWrdOW+yOwf1b00Bh8pl/Z4Lrq2TAiijwMumk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVRTp0NiSVwKaQzDMdPt43bEtItiviNOdIRhS8qzZLbXjux7J1mbPt90ddyYGVb1eQJEFQKS3bUxbInsblAHl2QdklCacjHFgsUVRdsv39C44ReLRB8Aj3n83UHOPvhqMcG4ygys/qTFm+g0+7zAWGUbUsvUPNk+uw/sW/u3+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oi0Wl36p; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PgAxJ6qYG6jFQyK0yTKMM5oVnK/RmutQxy4iOqYUHvk=; b=oi0Wl36pA6MMcWep9ogbt4VUQ1
	vRkPwua8PqJxBcF/sWE1dvDnmQlRuQn4j1aYgl1Qx9K9ANa/SCn55E+oxnfu3O3GPVzcC/SjloY5i
	YA5dBBnQrkIOvLrPih/NWodus/4tQ0IrQd+lsTeOkUc6Dr2o8q6TqoQYw46mAMuNoaM4nqG1jcqA2
	XLECrXUSdhSueinDHSWe6kQWG9SSnK3EVtSvP1GfFmXhYTV/iqOuakeeGZzuQdjI6afXb/MVGVyuE
	BvG1w1Kau1iHUBY0eww45/z/WFHZ5eZMr8DUA7YNYYmHO7VKBNvXeZHMIpfxe38vAp5R9GfJxqf7I
	48ugg5ww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuI27-00000007fkq-1AhT;
	Thu, 04 Sep 2025 22:02:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7731A300220; Fri, 05 Sep 2025 00:02:19 +0200 (CEST)
Date: Fri, 5 Sep 2025 00:02:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 07/16] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <20250904220219.GS3245006@noisy.programming.kicks-ass.net>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-8-arighi@nvidia.com>
 <aLidEvX41Xie5kwY@slm.duckdns.org>
 <20250903200822.GO4067720@noisy.programming.kicks-ass.net>
 <aLin8VayVsYyKXze@slm.duckdns.org>
 <20250903205646.GR4067720@noisy.programming.kicks-ass.net>
 <20250904202858.GN4068168@noisy.programming.kicks-ass.net>
 <aLoH_5TfiTGgQsb0@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLoH_5TfiTGgQsb0@slm.duckdns.org>

On Thu, Sep 04, 2025 at 11:43:27AM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Thu, Sep 04, 2025 at 10:28:58PM +0200, Peter Zijlstra wrote:
> ...
> >   RUNNABLE:
> >   1) hold both source and target rq->lock.
> ...
> > Now, assuming you have a locking order like:
> > 
> >  p->pi_lock
> >    rq->lock
> >      dsq->lock
> > 
> > When you do something like:
> > 
> >   __schedule()
> >     raw_spin_lock(rq->lock);
> >     next = pick_next_task() -> pick_task_scx()
> >       raw_spin_lock(dsq->lock);
> > 
> > Then you are, in effect, in the RUNNABLE 1) case above. You hold both
> > locks. Nothing is going to move your task around while you hold that
> > dsq->lock. That task is on the dsq, anybody else wanting to also do
> > anything with that task, will have to first take dsq->lock.
> >
> > Therefore, at this point, it is perfectly fine to do:
> > 
> > 	set_task_cpu(cpu_of(rq)); // move task here
> > 
> > There is no actual concurrency. The only thing there is is
> > set_task_cpu() complaining you're not following the rules -- but you
> > are, it just doesn't know -- and we can fix that.
> 
> I can't convince myself this is safe. For example, when task_rq_lock()
> returns, it should guarantee that the rq that the task is currently
> associated with is locked and the task can't go anywhere. However, as
> task_rq_lock() isn't interlocked with dsq lock, this won't hold true. I
> think this will break multiple things subtly - e.g. the assumptions that
> task_call_func() makes in the comment wouldn't hold anymore,
> task_sched_runtime()'s test of task_on_rq_queued() would be racy, and so on.
> 
> ie. Operations protected by deq/enq pair would be fine but anything which is
> protected only by task_rq_lock/unlock() would become racy, right?

Yeah, let me go audit all that in the morning. Because it would save a
lot of pain if we can make this work.

