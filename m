Return-Path: <bpf+bounces-63611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC82B0902D
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED317B5B28
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279C32F85E6;
	Thu, 17 Jul 2025 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPJ2Cijx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111A2BAF9;
	Thu, 17 Jul 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764832; cv=none; b=XufSkSutl8IFPPcOyFlRYM7LjXClhVoMAkE2lm4KX8PoQYhW/PtAgtjyRqE1pbQZSDTg8fbEIIP2RW2bbiQrH/heMddqza9HfCiGcMlSYP80AUta7zzoyxm51kedW3C0NupQu90FcdSGgQEjYqh1eTHqet66KBsW8hZzWn4ePAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764832; c=relaxed/simple;
	bh=2tiJMb29yH3fwdWasu86RnDq284wxM3WjEvwl2rJA1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnShEJj0aL5eSuOA94S+Fv9F0OX1sovdH53F4qDji+v06rAwWQtj4Y1vlz2N+B9ca62uyXgruiiUNSNF0Ip17W3rLLeGUM0m8G6JuOVFZwmQbV611tdMBuaXBhJF95YOp4NN391wvmv8sHE710FpHSFe2g+LrVjZcGNz+D8sFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPJ2Cijx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E77C4CEE3;
	Thu, 17 Jul 2025 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752764832;
	bh=2tiJMb29yH3fwdWasu86RnDq284wxM3WjEvwl2rJA1M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nPJ2CijxfzJ2rBTiKhI3Zgu1dgfV77InkWSLDUodg5dE1fj4xnhJDhVzP9yp92InE
	 P/dLCEqu6XYeErPn2O574xBc/DxnYk+3WBv/K7v8NqNDkh0sFXw8rrWciB6GvhjZGI
	 xXFj52ZssSA6ANPRTdsLGGew0D1JBRILSAEx0fzys46L9qTnSlKjRrqTqXuczDdXJQ
	 BSN5/U1pLReOPgkE226NvOZdRuL0RghBxMz5MxZnpb12dHOc14KQPui9bLyqMJrFsf
	 zeuiPdWVu50j4r988Wj7l0L7ZdezMCB8KjV1C6/Ata0sZulrszQGm3azJ6JqW0z9Cm
	 fq7DKmb/u7/Xg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 98A6BCE09F5; Thu, 17 Jul 2025 08:07:11 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:07:11 -0700
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
Message-ID: <62d91ce9-22b3-435f-b34a-cc2a65ce3b39@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>

On Thu, Jul 17, 2025 at 09:14:41AM -0400, Mathieu Desnoyers wrote:
> On 2025-07-16 18:54, Paul E. McKenney wrote:
> > On Wed, Jul 16, 2025 at 01:35:48PM -0700, Paul E. McKenney wrote:
> > > On Wed, Jul 16, 2025 at 11:09:22AM -0400, Steven Rostedt wrote:
> > > > On Fri, 11 Jul 2025 10:05:26 -0700
> > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > 
> > > > > This trace point will invoke rcu_read_unlock{,_notrace}(), which will
> > > > > note that preemption is disabled.  If rcutree.use_softirq is set and
> > > > > this task is blocking an expedited RCU grace period, it will directly
> > > > > invoke the non-notrace function raise_softirq_irqoff().  Otherwise,
> > > > > it will directly invoke the non-notrace function irq_work_queue_on().
> > > > 
> > > > Just to clarify some things; A function annotated by "notrace" simply
> > > > will not have the ftrace hook to that function, but that function may
> > > > very well have tracing triggered inside of it.
> > > > 
> > > > Functions with "_notrace" in its name (like preempt_disable_notrace())
> > > > should not have any tracing instrumentation (as Mathieu stated)
> > > > inside of it, so that it can be used in the tracing infrastructure.
> > > > 
> > > > raise_softirq_irqoff() has a tracepoint inside of it. If we have the
> > > > tracing infrastructure call that, and we happen to enable that
> > > > tracepoint, we will have:
> > > > 
> > > >    raise_softirq_irqoff()
> > > >       trace_softirq_raise()
> > > >         [..]
> > > >           raise_softirq_irqoff()
> > > >              trace_softirq_raise()
> > > >                 [..]
> > > >                   Ad infinitum!
> > > > 
> > > > I'm not sure if that's what is being proposed or not, but I just wanted
> > > > to make sure everyone is aware of the above.
> > > 
> > > OK, I *think* I might actually understand the problem.  Maybe.
> > > 
> > > I am sure that the usual suspects will not be shy about correcting any
> > > misapprehensions in the following.  ;-)
> > > 
> > > My guess is that some users of real-time Linux would like to use BPF
> > > programs while still getting decent latencies out of their systems.
> > > (Not something I would have predicted, but then again, I was surprised
> > > some years back to see people with a 4096-CPU system complaining about
> > > 200-microsecond latency blows from RCU.)  And the BPF guys (now CCed)
> > > made some changes some years back to support this, perhaps most notably
> > > replacing some uses of preempt_disable() with migrate_disable().
> > > 
> > > Except that the current __DECLARE_TRACE() macro defeats this work
> > > for tracepoints by disabling preemption across the tracepoint call,
> > > which might well be a BPF program.  So we need to do something to
> > > __DECLARE_TRACE() to get the right sort of protection while still leaving
> > > preemption enabled.
> > > 
> > > One way of attacking this problem is to use preemptible RCU.  The problem
> > > with this is that although one could construct a trace-safe version
> > > of rcu_read_unlock(), these would negate some optimizations that Lai
> > > Jiangshan worked so hard to put in place.  Plus those optimizations
> > > also simplified the code quite a bit.  Which is why I was pushing back
> > > so hard, especially given that I did not realize that real-time systems
> > > would be running BPF programs concurrently with real-time applications.
> > > This meant that I was looking for a functional problem with the current
> > > disabling of preemption, and not finding it.
> > > 
> > > So another way of dealing with this is to use SRCU-fast, which is
> > > like SRCU, but dispenses with the smp_mb() calls and the redundant
> > > read-side array indexing.  Plus it is easy to make _notrace variants
> > > srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace(),
> > > along with the requisite guards.
> > > 
> > > Re-introducing SRCU requires reverting most of e53244e2c893 ("tracepoint:
> > > Remove SRCU protection"), and I have hacked together this and the
> > > prerequisites mentioned in the previous paragraph.
> > > 
> > > These are passing ridiculously light testing, but probably have at
> > > least their share of bugs.
> > > 
> > > But first, do I actually finally understand the problem?
> > 
> > OK, they pass somewhat less ridiculously moderate testing, though I have
> > not yet hit them over the head with the ftrace selftests.
> > 
> > So might as well post them.
> > 
> > Thoughts?
> 
> Your explanation of the problem context fits my understanding.
> 
> Note that I've mostly been pulled into this by Sebastian who wanted
> to understand better the how we could make the tracepoint
> instrumentation work with bpf probes that need to sleep due to
> locking. Hence my original somewhat high-level desiderata.
> 
> I'm glad this seems to be converging towards a concrete solution.
> 
> There are two things I'm wondering:
> 
> 1) Would we want to always use srcu-fast (for both preempt and
>    non-preempt kernels ?), or is there any downside compared to
>    preempt-off rcu ? (e.g. overhead ?)

For kernels built with CONFIG_PREEMPT_DYNAMIC=n and either
CONFIG_PREEMPT_NONE=y or CONFIG_PREEMPT_VOLUNTARY=y, non-preemptible
RCU would be faster.  I did consider this, but decided to keep the
initial patch simple.

>    If the overhead is similar when actually used by tracers
>    (I'm talking about actual workload benchmark and not a
>    microbenchmark), I would tend to err towards simplicity
>    and to minimize the number of configurations to test, and
>    use srcu-fast everywhere.

To this point, I was wondering whether it is still necessary to do the
call_rcu() stage, but left it because that is the safe mistake to make.

I am testing a fifth patch that removes the early-boot deferral of
call_srcu() because call_srcu() now does exactly this deferral internally.

> 2) I think I'm late to the party in reviewing srcu-fast, I'll
>    go have a look :)

Looking forward to seeing what you come up with!

I deferred one further optimization, namely statically classifying
srcu_struct structures as intended for vanilla, _nmisafe(), or _fast()
use, or at least doing so at initialization time.  This would get rid
of the call to srcu_check_read_flavor_force() in srcu_read_lock_fast()
srcu_read_unlock_fast(), and friends, or at least to tuck it under
CONFIG_PROVE_RCU.  On my laptop, this saves an additional 25%, though
that 25% amounts to a big half of a nanosecond.

Thoughts?

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

