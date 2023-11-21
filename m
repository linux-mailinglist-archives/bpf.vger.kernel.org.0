Return-Path: <bpf+bounces-15555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 235BD7F341B
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F07B21C69
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E31524DF;
	Tue, 21 Nov 2023 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8hC5oXZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7BE51C3E
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 16:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF75C433C8;
	Tue, 21 Nov 2023 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700585008;
	bh=/U3kd7ywcCF+XCjlFdnVgAtFdH2pvC95gZA5CdP+R7A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=d8hC5oXZovua02aR+GsRCPNBnBonyFe9VF180GnOg9JdJ7SPSAxI0bQ4fwEhCWh72
	 xhpksKXbcEDH4xLBvzqM1z5IQEdfUP76yHcYFcltbYMwznAdnbEueOnp4XWsQlWXuK
	 /SYSb1/i8vhF7DjpEbzgiEdjorLBkdhqQFyGThfhxAJjelB36jmWYTi0vf6kv8E6Jd
	 7K4FZWR5nKax6ZkunDuHjTEZiIZ5OucROcypM0s6NaSSGpB79TwLfT/z8lCqWAy8Ks
	 B9lH/tuSnVCrwEan4oHH4YyOLgzlJ8Zvt1YTCsee6jvaXllE0/M3iCWiHYIjBYI9oy
	 Tdej5ktkV7eew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 83BCBCE04C0; Tue, 21 Nov 2023 08:43:27 -0800 (PST)
Date: Tue, 21 Nov 2023 08:43:27 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <045efa69-f0a4-4f04-b092-96b317865cf3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <6f503545-9c42-4d10-aca4-5332fd1097f3@efficios.com>
 <20231121144643.GJ8262@noisy.programming.kicks-ass.net>
 <20231121155256.GN4779@noisy.programming.kicks-ass.net>
 <dd48866e-782e-4362-aa20-1c7a3be5a2fc@efficios.com>
 <20231121110753.41dc5603@gandalf.local.home>
 <e1d33ff6-bf8d-465f-8626-f692ce4debe5@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d33ff6-bf8d-465f-8626-f692ce4debe5@efficios.com>

On Tue, Nov 21, 2023 at 11:11:57AM -0500, Mathieu Desnoyers wrote:
> On 2023-11-21 11:07, Steven Rostedt wrote:
> > On Tue, 21 Nov 2023 11:00:13 -0500
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> > > > tasks-tracing-rcu:
> > > >     extention of tasks to have critical-sections ? Should this simply be
> > > >     tasks?
> > > 
> > > tasks-trace-rcu is meant to allow tasks to block/take a page fault
> > > within the read-side. It is specialized for tracing and has a single
> > > domain. It does not need the smp_mb on the read-side, which makes it
> > > lower-overhead than SRCU.
> > 
> > IOW, task-trace-rcu allows the call to schedule in its critical section,
> > whereas task-rcu does not?
> 
> Correct.
> 
> And unlike preemptible rcu, tasks-trace-rcu allows calls to schedule which
> do not provide priority inheritance guarantees (such as I/O triggered by
> page faults).

But please keep it to things allowed in vanilla RCU read-side critical
sections and I/O triggered by page faults.  If you need something else,
that is a discussion between all the current users of RCU Tasks Trace.

							Thanx, Paul

