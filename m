Return-Path: <bpf+bounces-68028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225E1B51CF0
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 18:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D874568382
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344E8255F53;
	Wed, 10 Sep 2025 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="csSiJTW1"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFA53164A9;
	Wed, 10 Sep 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520118; cv=none; b=PTyTNC9P9+S2gbzbQoSC1YnwaiNuvai8eIe2k2O/yyOM5+8UGHF369xj5/yP6gkTjV3Srp2F1zeni35O8bjFIIworDDrn48g3G/1eLVcvRuTDI8P11sVdnXhQwHKOmBrPz6KUJVvhfbpLJicZFp0xpSC2QTorFVpny+tBECtzkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520118; c=relaxed/simple;
	bh=npz/Yr+Bw8qoxYgqMpb/2domnNHGtmZPEz2N9itH4TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7GpMfgkzVNcEY3qADn1oKPEWbloawgd/rXJSx3ZNZ7gSDZXcJcipGtAhfWJR7dl3iACXrr0KTQcNYJEh+whT5TLINGrQ4krmItDJmBb+b8BtpvZkqZS2eMz66XmsuiN/bNTERB3wqWxrxFWmHejlW8mbaCxRmETR/uhCYCb+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=csSiJTW1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=USzoxe2aN/UtzmUtNrM82r1HuFi67PhC3AMt/L2dzwA=; b=csSiJTW1VDKCm+YTTmkXo//fiw
	0YbOyugSS0418HkdmkVpnazY/NFrFnPyY1aQ6B3fSiOvxfUbnDnGM7WePTdiBUI2PcxKQwVDrJmWt
	PjcnAJ9wbBBcjP0CBu5w9GZxAbU3GTru76rhhMB2wEhqT58ux+7y1f6DUpdqCwiPoYomkdLiVSzfg
	cyPnBKf1sCleJBA4Z+uR8mSKV0LgyrY3hEjnGSfa8190cCzXVEaU3NT56krfdxLdIzsI3cdyQbY1n
	cfk+IhpG2iZH2DJm3wgi+TtUAvWiEdau0Qpzs8szENSeZA2m294d5N/CSwCb3MUjSHjvEoJ6s2EZ3
	7CU3QcNw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNGZ-00000005ui6-2RWT;
	Wed, 10 Sep 2025 16:01:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0888730050D; Wed, 10 Sep 2025 18:01:51 +0200 (CEST)
Date: Wed, 10 Sep 2025 18:01:50 +0200
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
Message-ID: <20250910160150.GV3245006@noisy.programming.kicks-ass.net>
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

So task_sched_runtime() only cares about 'current' tasks, those will
never be on a dsq.

But yes, things like task_call_func() and sched_setaffinity() will have
subtle race conditions :/

Still, this seems fixable, and fixing this should get rid of a lot of
current and proposed ugly.

( while poking at all this, I noticed that I forgot to apply this:
  https://lkml.kernel.org/r/20241030151255.300069509@infradead.org
  so I've rebased that and included it in the tree)

/me removes most of the babbling and redirects to the just posted
series:

  https://lkml.kernel.org/r/20250910154409.446470175@infradead.org

