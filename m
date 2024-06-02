Return-Path: <bpf+bounces-31110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C68D7343
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 05:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F9B281AF8
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 03:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22C1BA5E;
	Sun,  2 Jun 2024 03:37:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8711712;
	Sun,  2 Jun 2024 03:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299444; cv=none; b=qg6R80zdPX2YsGlYFjfz9D+Ox3c/wXlXEcD02iqcvMmYcr5fKcxqHjdvwF0wAPIabE9nQg9T5sgv9evZ6pf1GFoSOOIXP/IBY9T5Z9q9guVx359pA6AwD5AqWneRE3cCwdL8G1dygtWh73YMh9RWfLGvr0Pe1LPs0HR/3SWEhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299444; c=relaxed/simple;
	bh=o6pCTeFxqRUBIZAPxPfqyRNbjqPbTPyf32oB9WTLbbA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=CTwsTdf3MqCIn99MP79qKSU1E30jKnqOkd0ps7XvX+cfGyIXGWbKcoBXu7w4wdGVGDFxpZo2iIbvnpSPahWRorus34kIBWc/usz6rwVMwTZ9aRY0+xNaDjaBxKDADR2DIBCZtlqUS5cbV1MJqVv90BZdxJa+NJiK6JiY2Kmk78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E5BC3277B;
	Sun,  2 Jun 2024 03:37:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sDc3D-000000094J0-0veg;
	Sat, 01 Jun 2024 23:38:31 -0400
Message-ID: <20240602033744.563858532@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Jun 2024 23:37:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: [PATCH v2 00/27] function_graph: Allow multiple users for function graph tracing 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>


This is a continuation of the function graph multi user code.
I wrote a proof of concept back in 2019 of this code[1] and
Masami started cleaning it up. I started from Masami's work v10
that can be found here:

 https://lore.kernel.org/linux-trace-kernel/171509088006.162236.7227326999861366050.stgit@devnote2/

This is *only* the code that allows multiple users of function
graph tracing. This is not the fprobe work that Masami is working
to add on top of it. As Masami took my proof of concept, there
was still several things I disliked about that code. Instead of
having Masami clean it up even more, I decided to take over on just
my code and change it up a bit.

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240525023652.903909489@goodmis.org/

- Added ftrace helpers to allow an ftrace_ops to be a subop of a
  managing ftrace_op. That is, the managing ftrace_op will enable
  functions based off of the filters of the subops beneath it.
  This could be extended for kprobes and fprobes, as the managing
  ops does the multiplexing for the subops. This allows for only
  adding a single callback to ftrace but have multiple ops that
  represent many users.

- At the end, I added static branch which also speeds up the
  code quite a bit.

Masami Hiramatsu (Google) (3):
      function_graph: Handle tail calls for stack unwinding
      function_graph: Use a simple LRU for fgraph_array index number
      ftrace: Add multiple fgraph storage selftest

Steven Rostedt (Google) (8):
      ftrace: Allow subops filtering to be modified
      function_graph: Add pid tracing back to function graph tracer
      function_graph: Use for_each_set_bit() in __ftrace_return_to_handler()
      function_graph: Use bitmask to loop on fgraph entry
      function_graph: Use static_call and branch to optimize entry function
      function_graph: Use static_call and branch to optimize return function
      selftests/ftrace: Add function_graph tracer to func-filter-pid test
      selftests/ftrace: Add fgraph-multi.tc test

Steven Rostedt (VMware) (16):
      function_graph: Convert ret_stack to a series of longs
      fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
      function_graph: Add an array structure that will allow multiple callbacks
      function_graph: Allow multiple users to attach to function graph
      function_graph: Remove logic around ftrace_graph_entry and return
      ftrace/function_graph: Pass fgraph_ops to function graph callbacks
      ftrace: Allow function_graph tracer to be enabled in instances
      ftrace: Allow ftrace startup flags to exist without dynamic ftrace
      ftrace: Add subops logic to allow one ops to manage many
      function_graph: Have the instances use their own ftrace_ops for filtering
      function_graph: Add "task variables" per task for fgraph_ops
      function_graph: Move set_graph_function tests to shadow stack global var
      function_graph: Move graph depth stored data to shadow stack global var
      function_graph: Move graph notrace bit to shadow stack global var
      function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
      function_graph: Add selftest for passing local variables

----
 include/linux/ftrace.h                             |   43 +-
 include/linux/sched.h                              |    2 +-
 include/linux/trace_recursion.h                    |   39 -
 kernel/trace/fgraph.c                              | 1044 ++++++++++++++++----
 kernel/trace/ftrace.c                              |  482 ++++++++-
 kernel/trace/ftrace_internal.h                     |    5 +-
 kernel/trace/trace.h                               |   94 +-
 kernel/trace/trace_functions.c                     |    8 +
 kernel/trace/trace_functions_graph.c               |   96 +-
 kernel/trace/trace_irqsoff.c                       |   10 +-
 kernel/trace/trace_sched_wakeup.c                  |   10 +-
 kernel/trace/trace_selftest.c                      |  259 ++++-
 .../selftests/ftrace/test.d/ftrace/fgraph-multi.tc |  103 ++
 .../ftrace/test.d/ftrace/func-filter-pid.tc        |   27 +-
 14 files changed, 1916 insertions(+), 306 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc

