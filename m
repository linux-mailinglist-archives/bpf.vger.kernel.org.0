Return-Path: <bpf+bounces-63620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20654B0909D
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE2D586526
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FAE2F9487;
	Thu, 17 Jul 2025 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfItBHQi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45F2F7D18;
	Thu, 17 Jul 2025 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766219; cv=none; b=HwG96j47bkihNmputQPU2P9tsfbd1ncp5ppVsL9Cp5JpMcWcxEWOt+KScvwaOhgWLgp/RNx4/2h9sVo9T4gKorSDk9qNlq2NHOc52xGSARP77vrpF8/hP6WjYD5ViddeACfN0z4pEQ6AHT3FpUy+umofGymRXq/6nn/KG0518Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766219; c=relaxed/simple;
	bh=+Uo5z3GI60wRQMyDig+cCLdS1x45i/ACASbRLV6ML6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEmFwPf9+k5/aVY2jKL7J2jMSeIrbi6OuRiuPFhVbGxoBpk9AY/2qBIlTOriaZ0JMiru5wkLu+JcYcFRCLwZRZCuc/9w35WjfFZg2NxNhZoSI9BcZvyDwNzx+ScpdmFSGJxhjS9dHHDlbPZ+ceylT4Ga55tQovAt488dqJFTLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfItBHQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA556C4CEE3;
	Thu, 17 Jul 2025 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752766218;
	bh=+Uo5z3GI60wRQMyDig+cCLdS1x45i/ACASbRLV6ML6g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JfItBHQiONOKrUQC2r7MQ3GFE58hCt+o+WQvoYaojVC8sKM8CP0rxpQBSCsiba8An
	 AN8ML3Qx+mj6dOVW1ykSYUEaf9w7uqEkwZ9X4j/DhB0Ycnobbme0dwQ+ZyWkJOx0sY
	 0EqjVkQs6R5WbzPI8Tv8WUhYEROeTuqWTu1036KfI0FwmnmBt//zZspiGF0fzqqfc8
	 hXiKQRseXLkXAlMStdj834YvbYqib/fG1U8rnz7OuoRiBls6fckl6EiAKdSEN6/mHp
	 hT1seecD8ZJpx6+PxDcdTxM8YOPFA2wBie/n7TehLcwWuLDNeoctGSb/RXsYZh2WsB
	 Cz3D8K5f06w4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 383CFCE09F5; Thu, 17 Jul 2025 08:30:13 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:30:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
	rcu@vger.kernel.org,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
Message-ID: <f8baf05d-2472-4184-a154-805b0a818531@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
 <CAADnVQL7gz3OwUVCzt7dbJHvZzOK1zC4AOgMDu5mg6ssKuYU6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQL7gz3OwUVCzt7dbJHvZzOK1zC4AOgMDu5mg6ssKuYU6Q@mail.gmail.com>

On Thu, Jul 17, 2025 at 07:57:27AM -0700, Alexei Starovoitov wrote:
> On Thu, Jul 17, 2025 at 6:14 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > On 2025-07-16 18:54, Paul E. McKenney wrote:
> > > On Wed, Jul 16, 2025 at 01:35:48PM -0700, Paul E. McKenney wrote:
> > >> On Wed, Jul 16, 2025 at 11:09:22AM -0400, Steven Rostedt wrote:
> > >>> On Fri, 11 Jul 2025 10:05:26 -0700
> > >>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >>>
> > >>>> This trace point will invoke rcu_read_unlock{,_notrace}(), which will
> > >>>> note that preemption is disabled.  If rcutree.use_softirq is set and
> > >>>> this task is blocking an expedited RCU grace period, it will directly
> > >>>> invoke the non-notrace function raise_softirq_irqoff().  Otherwise,
> > >>>> it will directly invoke the non-notrace function irq_work_queue_on().
> > >>>
> > >>> Just to clarify some things; A function annotated by "notrace" simply
> > >>> will not have the ftrace hook to that function, but that function may
> > >>> very well have tracing triggered inside of it.
> > >>>
> > >>> Functions with "_notrace" in its name (like preempt_disable_notrace())
> > >>> should not have any tracing instrumentation (as Mathieu stated)
> > >>> inside of it, so that it can be used in the tracing infrastructure.
> > >>>
> > >>> raise_softirq_irqoff() has a tracepoint inside of it. If we have the
> > >>> tracing infrastructure call that, and we happen to enable that
> > >>> tracepoint, we will have:
> > >>>
> > >>>    raise_softirq_irqoff()
> > >>>       trace_softirq_raise()
> > >>>         [..]
> > >>>           raise_softirq_irqoff()
> > >>>              trace_softirq_raise()
> > >>>                 [..]
> > >>>                   Ad infinitum!
> > >>>
> > >>> I'm not sure if that's what is being proposed or not, but I just wanted
> > >>> to make sure everyone is aware of the above.
> > >>
> > >> OK, I *think* I might actually understand the problem.  Maybe.
> > >>
> > >> I am sure that the usual suspects will not be shy about correcting any
> > >> misapprehensions in the following.  ;-)
> > >>
> > >> My guess is that some users of real-time Linux would like to use BPF
> > >> programs while still getting decent latencies out of their systems.
> > >> (Not something I would have predicted, but then again, I was surprised
> > >> some years back to see people with a 4096-CPU system complaining about
> > >> 200-microsecond latency blows from RCU.)  And the BPF guys (now CCed)
> > >> made some changes some years back to support this, perhaps most notably
> > >> replacing some uses of preempt_disable() with migrate_disable().
> > >>
> > >> Except that the current __DECLARE_TRACE() macro defeats this work
> > >> for tracepoints by disabling preemption across the tracepoint call,
> > >> which might well be a BPF program.  So we need to do something to
> > >> __DECLARE_TRACE() to get the right sort of protection while still leaving
> > >> preemption enabled.
> > >>
> > >> One way of attacking this problem is to use preemptible RCU.  The problem
> > >> with this is that although one could construct a trace-safe version
> > >> of rcu_read_unlock(), these would negate some optimizations that Lai
> > >> Jiangshan worked so hard to put in place.  Plus those optimizations
> > >> also simplified the code quite a bit.  Which is why I was pushing back
> > >> so hard, especially given that I did not realize that real-time systems
> > >> would be running BPF programs concurrently with real-time applications.
> > >> This meant that I was looking for a functional problem with the current
> > >> disabling of preemption, and not finding it.
> > >>
> > >> So another way of dealing with this is to use SRCU-fast, which is
> > >> like SRCU, but dispenses with the smp_mb() calls and the redundant
> > >> read-side array indexing.  Plus it is easy to make _notrace variants
> > >> srcu_read_lock_fast_notrace() and srcu_read_unlock_fast_notrace(),
> > >> along with the requisite guards.
> > >>
> > >> Re-introducing SRCU requires reverting most of e53244e2c893 ("tracepoint:
> > >> Remove SRCU protection"), and I have hacked together this and the
> > >> prerequisites mentioned in the previous paragraph.
> > >>
> > >> These are passing ridiculously light testing, but probably have at
> > >> least their share of bugs.
> > >>
> > >> But first, do I actually finally understand the problem?
> > >
> > > OK, they pass somewhat less ridiculously moderate testing, though I have
> > > not yet hit them over the head with the ftrace selftests.
> > >
> > > So might as well post them.
> > >
> > > Thoughts?
> >
> > Your explanation of the problem context fits my understanding.
> >
> > Note that I've mostly been pulled into this by Sebastian who wanted
> > to understand better the how we could make the tracepoint
> > instrumentation work with bpf probes that need to sleep due to
> > locking. Hence my original somewhat high-level desiderata.
> 
> I still don't understand what problem is being solved.
> As current tracepoint code stands there is no issue with it at all
> on PREEMPT_RT from bpf pov.
> bpf progs that attach to tracepoints are not sleepable.
> They don't call rt_spinlock either.
> Recognizing tracepoints that can sleep/fault and allow
> sleepable bpf progs there is on our to do list,
> but afaik it doesn't need any changes to tracepoint infra.
> There is no need to replace existing preempt_disable wrappers
> with sleepable srcu_fast or anything else.

As I understand it, functionally there is no problem.

And if the BPF program has been attached to preemption-disabled code,
there is also no unnecessary damage to real-time latency.  Preemption is
presumably disabled for a reason, and that reason must be respected.
Presumably, people using BPF in real-time systems are careful to either
avoid attaching BPF programs to non-preemptible code on the one hand or
carefully limit the runtime of those BPF programs.

But if the BPF program has been attached to code having preemption
enabled, then the current call to guard(preempt_notrace)() within
__DECLARE_TRACE() means that the entire BPF program is running with
preemption disabled, and for no good reason.

Although this is not a functional issue, it is a first-class bug in
terms of needlessly degrading real-time latency.

And even though it isn't what Sebastian originally asked Mathieu for
help with, it still needs to be fixed.

My current offer is replacing that guard(preempt_notrace)() with its
SRCU-fast counterpart of guard(srcu_fast_notrace)(&tracepoint_srcu).

Light testing is going well thus far, though I clearly need the real-time
guys to both review and test.

I am sure that Mathieu, Sebastian, and the rest won't be shy about
correcting any confusion on my part.  ;-)

							Thanx, Paul

