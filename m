Return-Path: <bpf+bounces-67500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561D5B44751
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D3DA03D84
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BA527C17F;
	Thu,  4 Sep 2025 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ONLaCKNt"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE732189BB6;
	Thu,  4 Sep 2025 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017847; cv=none; b=DK+0gW73a1hsBFo4b5XeLL6wwqKk5BUYTWjV00sAzmBywGJZkl2bm/DuP8Bjp2QkSq8t5osS8DHNDsoHbrmsSh3bT1FZp1D/0lc9zh1gCZaX/p6kG8Ju8wkmwodTfhI3ayFnNAZKD4iYzaUzpYPGL/WXoLLL/NoIJyv84hU+xOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017847; c=relaxed/simple;
	bh=L766kVxO9bbTh/SmGmeQQeNTUq8GvnfoXyTjFRwS4m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjVbjo1QDO/yDQ+cURxGxmvKoHqmYsM3roTYX86ngoRGzlqAxBrYMoVd+KhIg8uz+7zqBq3QHd5g3nDDUmEAabh5CIdn06UiPDyGL9wXXgLTTGNtgpbIBtpl7tMa/AHJuCtxMSwfjIkjfxiJ3uevQJoXkjC6/TV2+Pfl1Oo6lZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ONLaCKNt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TwrWiKBtSgzrh15YMDMuIGvc6gG2LpA6lfs1IoQCxTY=; b=ONLaCKNtpDTf3+7kWAmiVAtX56
	T2n/pem3DsnX95VASO1LE9v2n6qEI7X7hnxMzN9U3LGTfO/VmDroeYDhdVOLr/moI6Jz8W2ovI1Fe
	TV3EIx3wTv1ZukCwyq9mVBl++KPhcsr4clSLqkmV8ixRO+BHMYcyntxTuAgo7iOLxcwN8qjG3ZQM9
	oihCd6m9wlsCGslUexxqLZR0xF9D8pN/5/zQjv7HMPgT11sQ4C82DkSz5nyr4i5xlvzonBijf+g6U
	b179FMyj6hWNTnwla+nu6oes7KBDpkgq6I+X/JnZ6320LIXl0fPFpbsePHe7t1T+rcrrTq6RPtIYr
	7hhEfU6A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuGa4-00000004Plm-0cys;
	Thu, 04 Sep 2025 20:30:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AA39E300220; Thu, 04 Sep 2025 22:28:58 +0200 (CEST)
Date: Thu, 4 Sep 2025 22:28:58 +0200
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
Message-ID: <20250904202858.GN4068168@noisy.programming.kicks-ass.net>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-8-arighi@nvidia.com>
 <aLidEvX41Xie5kwY@slm.duckdns.org>
 <20250903200822.GO4067720@noisy.programming.kicks-ass.net>
 <aLin8VayVsYyKXze@slm.duckdns.org>
 <20250903205646.GR4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903205646.GR4067720@noisy.programming.kicks-ass.net>

On Wed, Sep 03, 2025 at 10:56:46PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 03, 2025 at 10:41:21AM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > On Wed, Sep 03, 2025 at 10:08:22PM +0200, Peter Zijlstra wrote:
> > > > I'm a bit confused. This series doesn't have prep patches to add @rf to
> > > > dl_server_pick_f. Is this the right patch?
> > > 
> > > Patch 14 seems to be the proposed alternative, and I'm not liking that
> > > at all.
> > > 
> > > That rf passing was very much also needed for that other issue; I'm not
> > > sure why that's gone away.
> > 
> > Using balance() was my suggestion to stay within the current framework. If
> > we want to add @rf to pick_task(), that's more fundamental change. We
> > dropped the discussion in the other thread but I found it odd to add @rf to
> > pick_task() while disallowing the use of @rf in non-dl-server pick path and
> > if we want to allow that, we gotta solve the race between pick_task()
> > dropping rq lock and the ttwu inserting high pri task.
> 
> I thought the idea was to add rf unconditionally, dl-server or not, it
> is needed in both cases.
> 
> Yes, that race needs dealing with. We have this existing pattern that
> checks if a higher class has runnable tasks and restarting the pick.
> This is currently only done for pick_next_task_fair() but that can
> easily be extended.
> 
> You suggested maybe moving this to the ttwu side -- but up to this point
> I thought we were in agreement. I'm not sure moving it to the ttwu side
> makes things better; it would need ttwu to know a pick is in progress
> and for which class. The existing restart pick is simpler, I think.
> 
> Yes, the restart is somewhat more complicated if we want to deal with
> the dl-server, but not terribly so. It could just store a snapshot of
> rq->dl.dl_nr_running from before the pick and only restart if that went
> up.

Stepping back one step; per here:

  https://lore.kernel.org/all/20250819100838.GH3245006@noisy.programming.kicks-ass.net/T/#mf8f95d1c2637a2ac9d9ec8f71fffe064a5718fff

the reason for dropping rq->lock is having to migrate a task from the
global dispatch queue.


Now, the current rules for migrating tasks are:

  WAKEUP:
  hold p->pi_lock, this serializes against ttwu() and if found blocked
  after taking the lock, you're sure it will stay blocked and you can
  call set_task_cpu(), then you can lock the target rq, enqueue the
  thing and call it a day.

  RUNNABLE:
  1) hold both source and target rq->lock.
  2) hold source rq->lock, set p->on_rq = TASK_ON_RQ_MIGRATING, dequeue, call
  set_task_cpu(), drop source rq->lock, take target rq->lock, enqueue,
  set p->on_rq = TASK_ON_RQ_QUEUED, drop target rq->lock.

set_task_cpu() has a pile of assertions trying to make sure these rules
are followed.

Of concern here is the RUNNABLE thing -- if you want to strictly follow
those rules, you're going to have to drop rq->lock in order to acquire
the source rq->lock and all that.

However, the actual reason we need to acquire the source rq->lock, is
because that lock protects the data structures the task is on. Without
taking the source rq->lock you're not protected from concurrent use, it
could get scheduled in, or migrated elsewhere at the same time --
obviously bad things.


Now, assuming you have a locking order like:

 p->pi_lock
   rq->lock
     dsq->lock

When you do something like:

  __schedule()
    raw_spin_lock(rq->lock);
    next = pick_next_task() -> pick_task_scx()
      raw_spin_lock(dsq->lock);

Then you are, in effect, in the RUNNABLE 1) case above. You hold both
locks. Nothing is going to move your task around while you hold that
dsq->lock. That task is on the dsq, anybody else wanting to also do
anything with that task, will have to first take dsq->lock.

Therefore, at this point, it is perfectly fine to do:

	set_task_cpu(cpu_of(rq)); // move task here

There is no actual concurrency. The only thing there is is
set_task_cpu() complaining you're not following the rules -- but you
are, it just doesn't know -- and we can fix that.


Or am I still missing something?

