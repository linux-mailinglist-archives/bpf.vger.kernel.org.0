Return-Path: <bpf+bounces-15558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B861B7F3437
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28951C21AE9
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE454FA2;
	Tue, 21 Nov 2023 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kg63EaZj"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7893D110;
	Tue, 21 Nov 2023 08:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6odFJeiXcQD3LfuiM3sCn8ULJICyJcyaRaylnyp1q5U=; b=kg63EaZjq/SCXMrF+Q3WDSW7sP
	Fp7ixQBxsr9IqTxEqnmzSaEvkgBs1agdu70Tam4ja/im1QIJ7VuhTUbQeSDgTIYTUpVOt06U6hmIu
	OTkcxULSDfFgbMkplWILqAmb9WFh9bAKo3NJ+9yG48l6eq/A2WnPEt8PoZ0oFnbUCp9qFfsIgLGUI
	tsXnOh8Fm1QD3vQCrl5RUgd+fXYuv86vPDqYSf3E74zzUHbjcpksPeE7XBsBjP3Q1A/LsjER39hpY
	gVW2i7Tt7+4hUgmTc6dRLBu2jcvx2F2YSiRbQqjP/LGJ/p6wNjAi6GkCZaQ+BdVxQyg87rUgIc7V5
	IVXi6+zQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r5TxG-00BV8m-09;
	Tue, 21 Nov 2023 16:50:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 48B1B300338; Tue, 21 Nov 2023 17:50:29 +0100 (CET)
Date: Tue, 21 Nov 2023 17:50:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20231121165029.GL8262@noisy.programming.kicks-ass.net>
References: <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <6f503545-9c42-4d10-aca4-5332fd1097f3@efficios.com>
 <20231121144643.GJ8262@noisy.programming.kicks-ass.net>
 <20231121155256.GN4779@noisy.programming.kicks-ass.net>
 <dd48866e-782e-4362-aa20-1c7a3be5a2fc@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd48866e-782e-4362-aa20-1c7a3be5a2fc@efficios.com>

On Tue, Nov 21, 2023 at 11:00:13AM -0500, Mathieu Desnoyers wrote:
> On 2023-11-21 10:52, Peter Zijlstra wrote:
> > On Tue, Nov 21, 2023 at 03:46:43PM +0100, Peter Zijlstra wrote:
> > 
> > > Why is this such a hard question?
> > 
> > Anyway, recapping from IRC:
> > 
> > preemptible, SRCU:
> >    counter-array based, GP advances by increasing array index
> >    and waiting for previous index to drop to 0.
> > 
> >    notably, a GP can pass while a task is preempted but not within a
> >    critical section.
> > 
> >    SRCU has smp_mb() in the critical sections to improve GP.
> 
> Also:
> 
> preemptible only allows blocking when priority inheritance is
> guarantees, which excludes doing I/O, and thus page faults.
> Otherwise a long I/O could cause the system to OOM.
> 
> SRCU allows all kind of blocking, as long as the entire SRCU
> domain does not mind waiting for a while before readers complete.

Well, no. Fundamentally both SRCU and preemptible (and many other
flavours) are just a counter-array. The non-blocking for preempt comes
from the fact that it is the main global rcu instance and allowing all
that would make GPs too rare and cause you memory trouble.

But that's not because of how it's implemented, but because of it being
the main global instance.

> > tasks:
> >    waits for every task to pass schedule()
> > 
> >    ensures that any pieces of text rendered unreachable before, is
> >    actually unused after.
> > 
> > tasks-rude:
> >    like tasks, but different? build to handle tracing while rcu-idle,
> >    even though that was already deemed bad?
> > 
> > tasks-tracing-rcu:
> >    extention of tasks to have critical-sections ? Should this simply be
> >    tasks?
> 
> tasks-trace-rcu is meant to allow tasks to block/take a page fault within
> the read-side. It is specialized for tracing and has a single domain. It
> does not need the smp_mb on the read-side, which makes it lower-overhead
> than SRCU.

That's what it's meant for, not what it is.

Turns out that tasks-tracing is a per-task counter based thing, and as
such does not require all tasks to pass through schedule() and does not
imply the tasks flavour (nor the tasks-rude) despite the similarity in
naming.

But now I am again left wondering what the fundamental difference is
between a per-task counter and a per-cpu counter.

At the end of the day, you still have to wait for the thing to hit 0.

So I'm once again confused, ...

