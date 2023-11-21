Return-Path: <bpf+bounces-15536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF907F32C2
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79874282E89
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 15:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBCE58133;
	Tue, 21 Nov 2023 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m93MnOeH"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B67D185;
	Tue, 21 Nov 2023 07:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w97cVJb/aQInQREnjHpwi7QFE9oxzcwBFUlRXyXpLTM=; b=m93MnOeHJp3JuYMNkSzI0h+sh5
	z10+8KAVJ91/7rNYnQBsLhrTDLx1pyFHMrAJfaMKirCS4WjNaxwUJvyCrzY/NG0ig0b//FNRDdupH
	VyDa1SgQ7G53XY5K7EfMksqVhEdxhd2Yix8bmQ99JaiPJJWOBWOeOi15EslMK7oOFvwWZbr/IyqsU
	I1Oir5kkvhZDF9P3Bn4fT58qS+rf2UZj91HCtCjGpuAwOa6j8KdSniVISY8dE8GB8r9Ttezlnnvry
	N1ECNDQXgVkUrnkVr3O0Xn4RAm+o7ZO876ARb3WHUNomBPAqXcuPOqcfOPvUf7rSjUWG+1sukH7Jn
	HMqwGzZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r5T3a-005icl-2G; Tue, 21 Nov 2023 15:52:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 242B6300338; Tue, 21 Nov 2023 16:52:56 +0100 (CET)
Date: Tue, 21 Nov 2023 16:52:56 +0100
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
Message-ID: <20231121155256.GN4779@noisy.programming.kicks-ass.net>
References: <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120214742.GC8262@noisy.programming.kicks-ass.net>
 <62c6e37c-88cc-43f7-ac3f-1c14059277cc@paulmck-laptop>
 <20231120222311.GE8262@noisy.programming.kicks-ass.net>
 <cfc4b94e-8076-4e44-a8a7-2fd42dd9f2f2@paulmck-laptop>
 <20231121084706.GF8262@noisy.programming.kicks-ass.net>
 <a0ac5f77-411e-4562-9863-81196238f3f5@efficios.com>
 <20231121143647.GI8262@noisy.programming.kicks-ass.net>
 <6f503545-9c42-4d10-aca4-5332fd1097f3@efficios.com>
 <20231121144643.GJ8262@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121144643.GJ8262@noisy.programming.kicks-ass.net>

On Tue, Nov 21, 2023 at 03:46:43PM +0100, Peter Zijlstra wrote:

> Why is this such a hard question?

Anyway, recapping from IRC:

preemptible, SRCU:
  counter-array based, GP advances by increasing array index
  and waiting for previous index to drop to 0.

  notably, a GP can pass while a task is preempted but not within a
  critical section.

  SRCU has smp_mb() in the critical sections to improve GP.

tasks:
  waits for every task to pass schedule()

  ensures that any pieces of text rendered unreachable before, is
  actually unused after.

tasks-rude:
  like tasks, but different? build to handle tracing while rcu-idle,
  even though that was already deemed bad?

tasks-tracing-rcu:
  extention of tasks to have critical-sections ? Should this simply be
  tasks?


Can someone complete, please?




