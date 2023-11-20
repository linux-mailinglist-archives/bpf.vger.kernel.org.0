Return-Path: <bpf+bounces-15421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1AA7F202B
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8734C1F26263
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD09839865;
	Mon, 20 Nov 2023 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JiNJJw1e"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53FBA2;
	Mon, 20 Nov 2023 14:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y/JajRYmQ+h2cb3Gyfto2dmvsOFVpvsOEjip8jRBOVk=; b=JiNJJw1egbrWkoPgw2BOaR185l
	fjrLRFf6vjCinRkBKhhMg9n8qQhyGDzdQOHCObo9cc3x4oUsCmdlfSVoy5vbo/jsI55CAdGRxqMO4
	ZI/uBo4zx0NsbLwlmyAL09cV5NZz9OZhU4Y14e3UVrTmTgN4r2NV66t8sb+UB6mKKlDeFSddt9PgP
	mluxO2cet9nSO3/G7JDm/qrqVniTRe8wT2JAUCUBgOebY00o9jVfgeY8bSnWlOgeMciZ2cQAbyN6J
	L6AW91r5CxBB3GX6SK7oY4l8Kev11uQNQp0GWNvsV24pwEiA554S03HhDZotYMCZvzQ1VuCyq35I3
	+AmK9y2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Cfg-00B9Pw-2T;
	Mon, 20 Nov 2023 22:23:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0829A300419; Mon, 20 Nov 2023 23:23:12 +0100 (CET)
Date: Mon, 20 Nov 2023 23:23:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Message-ID: <20231120222311.GE8262@noisy.programming.kicks-ass.net>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>

On Mon, Nov 20, 2023 at 02:18:29PM -0800, Paul E. McKenney wrote:
> On Mon, Nov 20, 2023 at 10:47:42PM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 20, 2023 at 03:54:14PM -0500, Mathieu Desnoyers wrote:
> > > When invoked from system call enter/exit instrumentation, accessing
> > > user-space data is a common use-case for tracers. However, tracepoints
> > > currently disable preemption around iteration on the registered
> > > tracepoint probes and invocation of the probe callbacks, which prevents
> > > tracers from handling page faults.
> > > 
> > > Extend the tracepoint and trace event APIs to allow defining a faultable
> > > tracepoint which invokes its callback with preemption enabled.
> > > 
> > > Also extend the tracepoint API to allow tracers to request specific
> > > probes to be connected to those faultable tracepoints. When the
> > > TRACEPOINT_MAY_FAULT flag is provided on registration, the probe
> > > callback will be called with preemption enabled, and is allowed to take
> > > page faults. Faultable probes can only be registered on faultable
> > > tracepoints and non-faultable probes on non-faultable tracepoints.
> > > 
> > > The tasks trace rcu mechanism is used to synchronize read-side
> > > marshalling of the registered probes with respect to faultable probes
> > > unregistration and teardown.
> > 
> > What is trace-trace rcu and why is it needed here? What's wrong with
> > SRCU ?
> 
> Tasks Trace RCU avoids SRCU's full barriers and the array accesses in the
> read-side primitives.  This can be important when tracing low-overhead
> components of fast paths.

So why wasn't SRCU improved? That is, the above doesn't much explain.

What is the trade-off made to justify adding yet another RCU flavour?

