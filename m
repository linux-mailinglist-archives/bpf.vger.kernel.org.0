Return-Path: <bpf+bounces-15535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAA37F32B4
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2157D1F21E73
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E825D54F86;
	Tue, 21 Nov 2023 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYFhZuQW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD754F89
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 15:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C36C433C8;
	Tue, 21 Nov 2023 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700581912;
	bh=WwKdR5EpIuoPyTiF9l91qy2/U/TA9wpVWOK/oMQGTTA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tYFhZuQWeZs0lWDOpEMMrTsTZOk9FNIxy7sRunS70HvJkwJcc2Q7c9Vm+f8+yH2kb
	 pIVOrRKjevNbzvaQuvNHfNIjaN/dDZ7BgYVHdatmXFDVYBzTYIJEnU0QqFjDNOIpdC
	 oul2a9CuXx8CN2c6km9nADrsGY5R5UTE61JMZJxWElPVz2DUyBDb/znP2CBIRYTt5i
	 PmcepSKVAffPnNst6hXbM4mzCQ9SlKZtMYbhNkHPenxW7j+OZSXpM5tKWaFLttlGt5
	 wrdRtgSYxEc70QU16iWwFpM2OuavpjPxMXNgyAiGKaoEaQh80CE7kmnXDikohc8/Q0
	 994pzEV1A6Lyw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 61131CE04BD; Tue, 21 Nov 2023 07:51:52 -0800 (PST)
Date: Tue, 21 Nov 2023 07:51:52 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Jeanson <mjeanson@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Message-ID: <ba543d44-9302-4115-ac4f-d4e9f8d98a90@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <6f503545-9c42-4d10-aca4-5332fd1097f3@efficios.com>
 <20231121144643.GJ8262@noisy.programming.kicks-ass.net>
 <0364d2c5-e5af-4bb5-b650-124a90f3d220@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0364d2c5-e5af-4bb5-b650-124a90f3d220@efficios.com>

On Tue, Nov 21, 2023 at 09:56:55AM -0500, Mathieu Desnoyers wrote:
> On 2023-11-21 09:46, Peter Zijlstra wrote:
> > On Tue, Nov 21, 2023 at 09:40:24AM -0500, Mathieu Desnoyers wrote:
> > > On 2023-11-21 09:36, Peter Zijlstra wrote:
> > > > On Tue, Nov 21, 2023 at 09:06:18AM -0500, Mathieu Desnoyers wrote:
> > > > > Task trace RCU fits a niche that has the following set of requirements/tradeoffs:
> > > > > 
> > > > > - Allow page faults within RCU read-side (like SRCU),
> > > > > - Has a low-overhead read lock-unlock (without the memory barrier overhead of SRCU),
> > > > > - The tradeoff: Has a rather slow synchronize_rcu(), but tracers should not care about
> > > > >     that. Hence, this is not meant to be a generic replacement for SRCU.
> > > > > 
> > > > > Based on my reading of https://lwn.net/Articles/253651/ , preemptible RCU is not a good
> > > > > fit for the following reasons:
> > > > > 
> > > > > - It disallows blocking within a RCU read-side on non-CONFIG_PREEMPT kernels,
> > > > 
> > > > Your counter points are confused, we simply don't build preemptible RCU
> > > > unless PREEMPT=y, but that could surely be fixed and exposed as a
> > > > separate flavour.
> > > > 
> > > > > - AFAIU the mmap_sem used within the page fault handler does not have priority inheritance.
> > > > 
> > > > What's that got to do with anything?

Preemptible RCU allows blocking/preemption only in those cases where
priority inheritance applies.  As Mathieu says below, this prevents
indefinite postponement of a global grace period.  Such postponement is
especially problematic in kernels built with PREEMPT_RCU=y.  For but one
example, consider a situation where someone maps a file served by NFS.
We can debate the wisdom of creating such a map, but having the kernel
OOM would be a completely unacceptable "error message".

> > > > Still utterly confused about what task-tracing rcu is and how it is
> > > > different from preemptible rcu.

Task Trace RCU allows general blocking, which it tolerates by stringent
restrictions on what exactly it is used for (tracing in cases where the
memory to be included in the tracing might page fault).  Preemptible RCU
does not permit general blocking.

Tasks Trace RCU is a very specialized tool for a very specific use case.

> > > In addition to taking the mmap_sem, the page fault handler need to block
> > > until its requested pages are faulted in, which may depend on disk I/O.
> > > Is it acceptable to wait for I/O while holding preemptible RCU read-side?
> > 
> > I don't know, preemptible rcu already needs to track task state anyway,
> > it needs to ensure all tasks have passed through a safe spot etc.. vs regular
> > RCU which only needs to ensure all CPUs have passed through start.
> > 
> > Why is this such a hard question?

It is not a hard question.  Nor is the answer, which is that preemptible
RCU is not a good fit for this task for all the reasons that Mathieu has
laid out.

> Personally what I am looking for is a clear documentation of preemptible rcu
> with respect to whether it is possible to block on I/O (take a page fault,
> call schedule() explicitly) from within a preemptible rcu critical section.
> I guess this is a hard question because there is no clear statement to that
> effect in the kernel documentation.
> 
> If it is allowed (which I doubt), then I wonder about the effect of those
> long readers on grace period delays. Things like expedited grace periods may
> suffer.
> 
> Based on Documentation/RCU/rcu.rst:
> 
>   Preemptible variants of RCU (CONFIG_PREEMPT_RCU) get the
>   same effect, but require that the readers manipulate CPU-local
>   counters.  These counters allow limited types of blocking within
>   RCU read-side critical sections.  SRCU also uses CPU-local
>   counters, and permits general blocking within RCU read-side
>   critical sections.  These variants of RCU detect grace periods
>   by sampling these counters.
> 
> Then we just have to find a definition of "limited types of blocking"
> vs "general blocking".

The key point is that you are not allowed to place any source code in
a preemptible RCU reader that would not be legal in a non-preemptible
RCU reader.  The rationale again is that the cases in which preemptible
RCU readers call schedule are cases to which priority boosting applies.

It is quite possible that the documentation needs upgrading.  ;-)

							Thanx, Paul

