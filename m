Return-Path: <bpf+bounces-63674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92277B09658
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 23:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26E6566787
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63C1230BCE;
	Thu, 17 Jul 2025 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8Z9mVB1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C523211A05;
	Thu, 17 Jul 2025 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752787680; cv=none; b=VIE4acjqiRQz4fmDTNRzN1Ivi+LsgNTZX8ugOoDELe+RBs7FqiI85bIROw2PBNniklA8hPfT29dCMVpJ/gtXKG2/RbQJsajyqtOjyttlwuQXVe8/A7uxzGvr+hsk0EwrWro/vekDPnBXIcig8jEA9jxCMDAYw6RAptrGs+cjBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752787680; c=relaxed/simple;
	bh=gA0nSPy8l+XNErJYOBLcTBpx09X1LiAAr1kbtOU4eNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yx2GfQ3fSKPTaGfpbKC+M8wnLLeEEZ24FDjGm/TF1P/ym2anFzMOKg2eDGfXnMbI7xRCnitjdUJKsQJiHVbCauEuhjCuPO3xH0pS5zWYd/Q28cQYLlNCXHo2jF94DLRRjb7w7TX7tpTd+nWn13vs7480h8emYiLFlOuWEKjv6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8Z9mVB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0FBC4CEE3;
	Thu, 17 Jul 2025 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752787679;
	bh=gA0nSPy8l+XNErJYOBLcTBpx09X1LiAAr1kbtOU4eNc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=l8Z9mVB1lx3ywq/WN3mdNPaO9lRQydb/skPT13JQAFJP2kvAy7l1aPt3Nz5o8nQR1
	 cC9J0fxAdEQBSTf2UtMgqd1P2gs15tWwjF4kYMZjWl5qorTroj+YDo0B5e5qnReZy8
	 8VGzdZTe/rhfUjjmkn3R4o4loh+nPfRNH24L5vwIVoXQQIh/fYavNzdTBMcq2T5gBi
	 tn1zNKn+vGdfugEBW5KNsfR+6Y8KI5i3m0F7vrA7QEq8ibtBd+jj5vVyLlRsr/sL6f
	 7nqQuDi7X88B2ii5spg+ph/MSqRZFxQfuSheD1EgJp8Qo3fser8HqBFHq8fi+6uqEL
	 /s3vU13TTnBWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 35693CE13CD; Thu, 17 Jul 2025 14:27:59 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:27:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <a087b008-3204-4cc3-9062-92bcf93b2c96@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
 <2d9eb910-f880-4966-ba40-9b1e0835279c@efficios.com>
 <2f8bb8bb-320e-480f-9a56-8eb5cbd4438a@paulmck-laptop>
 <5dc49f5a-ddda-422b-a8af-c662ee53d503@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dc49f5a-ddda-422b-a8af-c662ee53d503@efficios.com>

On Thu, Jul 17, 2025 at 03:36:46PM -0400, Mathieu Desnoyers wrote:
> On 2025-07-17 11:18, Paul E. McKenney wrote:
> > On Thu, Jul 17, 2025 at 10:46:46AM -0400, Mathieu Desnoyers wrote:
> > > On 2025-07-17 09:14, Mathieu Desnoyers wrote:
> > > > On 2025-07-16 18:54, Paul E. McKenney wrote:
> > > [...]
> > > > 
> > > > 2) I think I'm late to the party in reviewing srcu-fast, I'll
> > > >      go have a look :)
> > > 
> > > OK, I'll bite. :) Please let me know where I'm missing something:
> > > 
> > > Looking at srcu-lite and srcu-fast, I understand that they fundamentally
> > > depend on a trick we published here https://lwn.net/Articles/573497/
> > > "The RCU-barrier menagerie" that allows turning, e.g. this Dekker:
> > > 
> > > volatile int x = 0, y = 0
> > > 
> > > CPU 0              CPU 1
> > > 
> > > x = 1              y = 1
> > > smp_mb             smp_mb
> > > r2 = y             r4 = x
> > > 
> > > BUG_ON(r2 == 0 && r4 == 0)
> > > 
> > > into
> > > 
> > > volatile int x = 0, y = 0
> > > 
> > > CPU 0            CPU 1
> > > 
> > > rcu_read_lock()
> > > x = 1              y = 1
> > >                     synchronize_rcu()
> > > r2 = y             r4 = x
> > > rcu_read_unlock()
> > > 
> > > BUG_ON(r2 == 0 && r4 == 0)
> > > 
> > > So looking at srcu-fast, we have:
> > > 
> > >   * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
> > >   * critical sections either because they disables interrupts, because they
> > >   * are a single instruction, or because they are a read-modify-write atomic
> > >   * operation, depending on the whims of the architecture.
> > > 
> > > It appears to be pairing, as RCU read-side:
> > > 
> > > - irq off/on implied by this_cpu_inc
> > > - atomic
> > > - single instruction
> > > 
> > > with synchronize_rcu within the grace period, and hope that this behaves as a
> > > smp_mb pairing preventing the srcu read-side critical section from leaking
> > > out of the srcu read lock/unlock.
> > > 
> > > I note that there is a validation that rcu_is_watching() within
> > > __srcu_read_lock_fast, but it's one thing to have rcu watching, but
> > > another to have an actual read-side critical section. Note that
> > > preemption, irqs, softirqs can very well be enabled when calling
> > > __srcu_read_lock_fast.
> > > 
> > > My understanding of the how memory barriers implemented with RCU
> > > work is that we need to surround the memory accesses on the fast-path
> > > (where we turn smp_mb into barrier) with an RCU read-side critical
> > > section to make sure it does not spawn across a synchronize_rcu.
> > > 
> > > What I am missing here is how can a RCU side-side that only consist
> > > of the irq off/on or atomic or single instruction cover all memory
> > > accesses we are trying to order, namely those within the srcu
> > > critical section after the compiler barrier() ? Is having RCU
> > > watching sufficient to guarantee this ?
> > 
> > Good eyes!!!
> > 
> > The trick is that this "RCU read-side critical section" consists only of
> > either this_cpu_inc() or atomic_long_inc(), with the latter only happening
> > in systems that have NMIs, but don't have NMI-safe per-CPU operations.
> > Neither this_cpu_inc() nor atomic_long_inc() can be interrupted, and
> > thus both act as an interrupts-disabled RCU read-side critical section.
> > 
> > Therefore, if the SRCU grace-period computation fails to see an
> > srcu_read_lock_fast() increment, its earlier code is guaranteed to
> > happen before the corresponding critical section.  Similarly, if the SRCU
> > grace-period computation sees an srcu_read_unlock_fast(), its subsequent
> > code is guaranteed to happen after the corresponding critical section.
> > 
> > Does that help?  If so, would you be interested and nominating a comment?
> > 
> > Or am I missing something subtle here?
> 
> Here is the root of my concern: considering a single instruction
> as an RCU-barrier "read-side" for a classic Dekker would not work,
> because the read-side would not cover both memory accesses that need
> to be ordered.

You would have a pair of RCU read-side critical sections, and if the
second one was waited on by a given call to synchronize_rcu(), then the
beginning of the first RCU reader would also have preceded that call,
and thus the synchronize_rcu() full-memory-barrier would apply to both
of those RCU read-side critical sections..

But please see below for more detail.

> I cannot help but notice the similarity between this pattern of
> barrier vs synchronize_rcu and what we allow userspace to do with
> barrier vs sys_membarrier, which has one implementation
> based on synchronize_rcu (except for TICK_NOHZ_FULL). Originally
> when membarrier was introduced, this was based on synchronize_sched(),
> and I recall that this was OK because userspace execution acted as
> a read-side critical section from the perspective of synchronize_sched().
> As commented in kernel v4.10 near synchronize_sched():
> 
>  * Note that this guarantee implies further memory-ordering guarantees.
>  * On systems with more than one CPU, when synchronize_sched() returns,
>  * each CPU is guaranteed to have executed a full memory barrier since the
>  * end of its last RCU-sched read-side critical section whose beginning
>  * preceded the call to synchronize_sched().  In addition, each CPU having
>  * an RCU read-side critical section that extends beyond the return from
>  * synchronize_sched() is guaranteed to have executed a full memory barrier
>  * after the beginning of synchronize_sched() and before the beginning of
>  * that RCU read-side critical section.  Note that these guarantees include
>  * CPUs that are offline, idle, or executing in user mode, as well as CPUs
>  * that are executing in the kernel.
> 
> So even though I see how synchronize_rcu() nowadays is still a good
> choice to implement sys_membarrier, it only apply to RCU read side
> critical sections, which covers userspace code and the specific
> read-side critical sections in the kernel.

Yes, it does only apply to RCU read-side critical sections, but the
synchronize_rcu() comment header explicitly states that, given a region
of code across which interrupts are disabled, that region of code also
acts as an RCU read-side critical section:

 * RCU read-side critical sections are delimited by rcu_read_lock()
 * and rcu_read_unlock(), and may be nested.  In addition, but only in
 * v5.0 and later, regions of code across which interrupts, preemption,
 * or softirqs have been disabled also serve as RCU read-side critical
 * sections.  This includes hardware interrupt handlers, softirq handlers,
 * and NMI handlers.

Interrupts cannot happen in the midst of either this_cpu_inc() or
atomic_long_inc(), so these do act as tiny RCU readers.

And just to be painfully clear, synchronize_rcu() guarantees full barriers
associated with any reader that stick out of the synchronize_rcu()
in either direction:

 * Note that this guarantee implies further memory-ordering guarantees.
 * On systems with more than one CPU, when synchronize_rcu() returns,
 * each CPU is guaranteed to have executed a full memory barrier since
 * the end of its last RCU read-side critical section whose beginning
 * preceded the call to synchronize_rcu().  In addition, each CPU having
 * an RCU read-side critical section that extends beyond the return from
 * synchronize_rcu() is guaranteed to have executed a full memory barrier
 * after the beginning of synchronize_rcu() and before the beginning of
 * that RCU read-side critical section.  Note that these guarantees include
 * CPUs that are offline, idle, or executing in user mode, as well as CPUs
 * that are executing in the kernel.

> But what I don't get is how synchronize_rcu() can help us promote
> the barrier() in SRCU-fast to smp_mb when outside of any RCU read-side
> critical section tracked by the synchronize_rcu grace period,
> mainly because unlike the sys_membarrier scenario, this is *not*
> userspace code.

Just for those following along, there is a barrier() call at the
end of __srcu_read_lock_fast() and another at the beginning of
__srcu_read_unlock_fast(), so that is covered.

And then let's take look at this barrier() form of your store-buffering
litmus test:

	volatile int x = 0, y = 0

	CPU 0              CPU 1

	WRITE_ONCE(x, 1)   WRITE_ONCE(y, 1)
	barrier()          synchronize_rcu()
	r2 = READ_ONCE(y)  r4 = READ_ONCE(x)

	BUG_ON(r2 == 0 && r4 == 0)

Each of CPU 0's _ONCE() accesses is implemented with a single instruction,
and each therefore cannot be interrupted.  Each therefore acts as a tiny
RCU read-side critical section.

Now, if you put this into an LKMM litmus test, herd7 will in fact say
"Sometimes".  But that is because LKMM does not know about interrupts,
let alone the possibility that they might be disabled, and let alone the
fact that atomic operations act like tiny regions of interrupt-disabled
code, let alone the fact that regions of interrupt-disabled code act as
RCU read-side critical sections.

But we can help LKMM out by manually placing the tiny RCU read-side
critical sections, like this:

	C C-SB-o-b-o+o-sr-o

	{
	}

	P0(int *x, int *y)
	{
		rcu_read_lock();
		WRITE_ONCE(*x, 1);
		rcu_read_unlock();
		barrier();
		rcu_read_lock();
		r2 = READ_ONCE(*y);
		rcu_read_unlock();
	}

	P1(int *x, int *y)
	{
		WRITE_ONCE(*y, 1);
		synchronize_rcu();
		r4 = READ_ONCE(*x);
	}

	exists (0:r2=0 /\ 1:r4=0)

And if we do this, here is what LKMM has to say about it:

$ herd7 -conf linux-kernel.cfg /tmp/C-SB-o-b-o+o-sr-o.litmus

	Test C-SB-o-b-o+o-sr-o Allowed
	States 3
	0:r2=0; 1:r4=1;
	0:r2=1; 1:r4=0;
	0:r2=1; 1:r4=1;
	No
	Witnesses
	Positive: 0 Negative: 3
	Condition exists (0:r2=0 /\ 1:r4=0)
	Observation C-SB-o-b-o+o-sr-o Never 0 3
	Time C-SB-o-b-o+o-sr-o 0.01
	Hash=f607a3688b66756d2e85042c75d8c1fa

It says "Never", so SRCU-fast should be good from this memory-ordering
viewpoint.

Or am I missing your point?

> And what we want to order here on the read-side is the lock/unlock
> increments vs the memory accesses within the critical section, but
> there is no RCU read-side that contain all those memory accesses
> that match those synchronize_rcu calls, so the promotion from barrier
> to smp_mb don't appear to be valid.
> 
> But perhaps there is something more that is specific to the SRCU
> algorithm that I missing here ?

Again, the RCU reader implied by the tiny interrupts-disabled region of
code implied by an atomic operation should do the trick.

If you are instead accusing me of using a very subtle and tricky
synchronization technique, then I plead guilty to charges as read.
On the other hand, this is the Linux-kernel RCU implementation, so it is
not like people reading this code haven't been at least implicitly warned.

I did provide comments attempting to describe this, for example,
for __srcu_read_lock_fast():

 * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
 * critical sections either because they disables interrupts, because they
 * are a single instruction, or because they are a read-modify-write atomic
 * operation, depending on the whims of the architecture.

I would welcome upgrades that more clearly describe this trick.
The s/disables/disable/ would be one step in the right direction.  :-/

And again, many thanks for digging into this!!!

And again, am I missing your point?

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> > Either way, many thanks for digging into this!!!
> > 
> > 							Thanx, Paul
> > 
> > > Thanks,
> > > 
> > > Mathieu
> > > 
> > > -- 
> > > Mathieu Desnoyers
> > > EfficiOS Inc.
> > > https://www.efficios.com
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

