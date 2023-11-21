Return-Path: <bpf+bounces-15539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E03147F3313
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCA1B21FA3
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC6959163;
	Tue, 21 Nov 2023 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pxLYa1yv"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E2C12E;
	Tue, 21 Nov 2023 08:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xrV8w2QzC0MyzNqKKokweVMq304wzVwsffOY7txoyDw=; b=pxLYa1yvNDM7PJ4z90aSWcYO8I
	l/UHXMGWJ1cglHpMgDCh0p2U9xJovVfw+drVFc7z2ve2C1zZ5bch4lBgGsmnBo7W1/1boh70Pa/il
	72JF7494XgFbRvJ95WfuzljmOM0xu6FPIhGWyxJOzIu1hHHvDv/cAQ7UolXdwBDXip+lzhPgDYrN5
	b5dFOOTkQhcDaAlszc2U8MgmrXNLe/w9EVT1OQt+EujAKRMboYeXqeoazUEapaarghC+k6LQAOQf0
	oNUqZB933q6t1Bp/q3rnkZCx9CfQD1SKeGTeyAj/1MywbiYJu7ZjqKAE6LbhXwBg200pMewLpmFl6
	IfJxLCGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r5TDJ-00BUZT-2S;
	Tue, 21 Nov 2023 16:03:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 64251300338; Tue, 21 Nov 2023 17:03:00 +0100 (CET)
Date: Tue, 21 Nov 2023 17:03:00 +0100
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
Message-ID: <20231121160300.GK8262@noisy.programming.kicks-ass.net>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <2a41f6cd-971d-4360-aeeb-a9cbf665bb72@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a41f6cd-971d-4360-aeeb-a9cbf665bb72@paulmck-laptop>

On Tue, Nov 21, 2023 at 07:58:40AM -0800, Paul E. McKenney wrote:

> Tasks Trace RCU allows general blocking in its readers, not just the
> subject-to-priority-boosting blocking permitted within preemptible RCU
> readers.  Restrictions on the use of Tasks Trace RCU are in place to allow
> getting away with this general blocking.  Even systems generously endowed
> with memory are not going to do well when the RCU grace period is blocked
> on I/O, especially if that I/O is across a network to a slow file server.
> 
> Which means a separate RCU instance is needed.  Which is Tasks Trace RCU.

Separate instance not a problem, nor really the question.

What is the basic mechanism of task-tracing? Is it really the existing
tasks-rcu extended with read-side critical sections and call_rcu ?

If so, then why not have it be tasks-rcu?

Or is it a variant of the preemptible/SRCU class of RCUs that are
counter-array based? I suspect not.

So once again, what exactly is tasks-tracing ?

