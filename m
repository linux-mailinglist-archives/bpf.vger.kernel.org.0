Return-Path: <bpf+bounces-63484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961CBB07F02
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 22:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890984E3E76
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 20:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253882C15B5;
	Wed, 16 Jul 2025 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDmmk/YH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FCC28C85D;
	Wed, 16 Jul 2025 20:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698149; cv=none; b=lUNfScU82j8as/fx6WyMjn48r8HH6RZflfOdC8geTjLLeGUvut6f5ckqXjc5jMFok/Zo0cfy+pwLY11ypAgucYjCLzydWmVYRGzaHR55YLC8GG5EaRMVESH8aJxEsUs3TZrHqVBkD3TL9zePA3X5APBZwgThxC1D9IerKqk+S3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698149; c=relaxed/simple;
	bh=9qLLJHRCEGmna5JNT8zOmYMkNsoVPnmFYCZsFjxeYm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4m1p4RDhJR2UAvuxzXWxhcmM5z/lnSphHSg8nSLpwBESOp0qljXgYotH5umILKKTyZGAGmXox0fK++RVaGHsXZsv6vLZ1ZGjvTw/OEOFFXo+rbIRGi8/chdsqm6PQGGODNj8rX+fR5mdbppnigCgVkWPtH1t9kE3rDaFTGpu9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDmmk/YH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06610C4CEE7;
	Wed, 16 Jul 2025 20:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752698149;
	bh=9qLLJHRCEGmna5JNT8zOmYMkNsoVPnmFYCZsFjxeYm4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZDmmk/YHzHkxFofmJ2qeCq9Rk1rUhNUylsE8YRmWFok/wk4KvB3sHujJ7QLvPRumU
	 8UnCqzQmh5vX2isWbz4ChNYe1BYw5dWatSd0fybxy9KL1Y7Y+QiLCaZO2RFC1uj8ob
	 rtY+MfSwRAekKvJjfH6VD5z2Puicnu9qY2BXuxs9bkLTQ01BuqdcJVreqGQ6kMtG+I
	 Li1lBwZS2LhY1sxljLRQ9fYyWLm0PTz++mJk1PNa0iiAaaNFKRI3DCLTvsG37oSbZX
	 KQaJBeojk8sRxfmRc2KAszVZfnPLGQHBNHPvnm5h3SwopV+3HZpWJ5gVnTd2AqW0b/
	 loQpUQqQdz24A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9D0EBCE09C2; Wed, 16 Jul 2025 13:35:48 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:35:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Message-ID: <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250623104941.WxOQtAmV@linutronix.de>
 <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716110922.0dadc4ec@batman.local.home>

On Wed, Jul 16, 2025 at 11:09:22AM -0400, Steven Rostedt wrote:
> On Fri, 11 Jul 2025 10:05:26 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > This trace point will invoke rcu_read_unlock{,_notrace}(), which will
> > note that preemption is disabled.  If rcutree.use_softirq is set and
> > this task is blocking an expedited RCU grace period, it will directly
> > invoke the non-notrace function raise_softirq_irqoff().  Otherwise,
> > it will directly invoke the non-notrace function irq_work_queue_on().
> 
> Just to clarify some things; A function annotated by "notrace" simply
> will not have the ftrace hook to that function, but that function may
> very well have tracing triggered inside of it.
> 
> Functions with "_notrace" in its name (like preempt_disable_notrace())
> should not have any tracing instrumentation (as Mathieu stated)
> inside of it, so that it can be used in the tracing infrastructure.
> 
> raise_softirq_irqoff() has a tracepoint inside of it. If we have the
> tracing infrastructure call that, and we happen to enable that
> tracepoint, we will have:
> 
>   raise_softirq_irqoff()
>      trace_softirq_raise()
>        [..]
>          raise_softirq_irqoff()
>             trace_softirq_raise()
>                [..]
>                  Ad infinitum!
> 
> I'm not sure if that's what is being proposed or not, but I just wanted
> to make sure everyone is aware of the above.

OK, I *think* I might actually understand the problem.  Maybe.

I am sure that the usual suspects will not be shy about correcting any
misapprehensions in the following.  ;-)

My guess is that some users of real-time Linux would like to use BPF
programs while still getting decent latencies out of their systems.
(Not something I would have predicted, but then again, I was surprised
some years back to see people with a 4096-CPU system complaining about
200-microsecond latency blows from RCU.)  And the BPF guys (now CCed)
made some changes some years back to support this, perhaps most notably
replacing some uses of preempt_disable() with migrate_disable().

Except that the current __DECLARE_TRACE() macro defeats this work
for tracepoints by disabling preemption across the tracepoint call,
which might well be a BPF program.  So we need to do something to
__DECLARE_TRACE() to get the right sort of protection while still leaving
preemption enabled.

One way of attacking this problem is to use preemptible RCU.  The problem
with this is that although one could construct a trace-safe version
of rcu_read_unlock(), these would negate some optimizations that Lai
Jiangshan worked so hard to put in place.  Plus those optimizations
also simplified the code quite a bit.  Which is why I was pushing back
so hard, especially given that I did not realize that real-time systems
would be running BPF programs concurrently with real-time applications.
This meant that I was looking for a functional problem with the current
disabling of preemption, and not finding it.

So another way of dealing with this is to use SRCU-fast, which is
like SRCU, but dispenses with the smp_mb() calls and the redundant
read-side array indexing.  Plus it is easy to make _notrace variants
srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace(),
along with the requisite guards.

Re-introducing SRCU requires reverting most of e53244e2c893 ("tracepoint:
Remove SRCU protection"), and I have hacked together this and the
prerequisites mentioned in the previous paragraph.

These are passing ridiculously light testing, but probably have at
least their share of bugs.

But first, do I actually finally understand the problem?

							Thanx, Paul

