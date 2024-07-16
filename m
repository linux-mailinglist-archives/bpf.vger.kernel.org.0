Return-Path: <bpf+bounces-34930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D48C9332F1
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 22:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA591F239F2
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 20:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206AA1A01B7;
	Tue, 16 Jul 2024 20:27:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839A249F5;
	Tue, 16 Jul 2024 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721161637; cv=none; b=n7KArkKmNldCmZlDy7dDovLLaTbbJtSQVPz+As2bOI1kuXcaM2U+OoW0IMj06ODVuslOjtkIFcbBwrYEpypcDxY5fz8oEKr7jTjbU0B4MlXKqrnmNIGT5/6izc5b8EodlokIjFe9J/iC5BHgk9IIOdD+u18A4jG46V4boSYFoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721161637; c=relaxed/simple;
	bh=gAOkvFY7OIcSf4xM8Clt7t6DloB+Pnddy9P+bKD4jp0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=k+ryviCY/D4mHU5pCpzpw1oIaWUgBv59W8zMdQh2JgmXsd9ujiAxdI0+sVFomw8UUqr2jDtyje53ZkUTwgJodquWCuv7Vym3zY+AvMSTJk5CRvkRTJOUyF4bEo2XQjGDnmkprzrQZ4vXvTGMdAp0HXTwNuvIdEfMdnny7vzVago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C66C116B1;
	Tue, 16 Jul 2024 20:27:15 +0000 (UTC)
Date: Tue, 16 Jul 2024 16:27:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Marilene A Garcia
 <marilene.agarcia@gmail.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Tatsuya S <tatsuya.s2862@gmail.com>, bpf
 <bpf@vger.kernel.org>
Subject: [GIT PULL] ftrace: Rewrite of function graph to allow multiple
 users
Message-ID: <20240716162714.48febeaf@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

ftrace: Rewrite of function graph tracer

Up until now, the function graph tracer could only have a single user
attached to it. If another user tried to attach to the function graph
tracer while one was already attached, it would fail. Allowing function
graph tracer to have more than one user has been asked for since 2009, but
it required a rewrite to the logic to pull it off so it never happened.
Until now!

There's three systems that trace the return of a function. That is
kretprobes, function graph tracer, and BPF. kretprobes and function graph
tracing both do it similarly. The difference is that kretprobes uses a
shadow stack per callback and function graph tracer creates a shadow stack
for all tasks. The function graph tracer method makes it possible to trace
the return of all functions. As kretprobes now needs that feature too,
allowing it to use function graph tracer was needed. BPF also wants to
trace the return of many probes and its method doesn't scale either.
Having it use function graph tracer would improve that.

By allowing function graph tracer to have multiple users allows both
kretprobes and BPF to use function graph tracer in these cases. This will
allow kretprobes code to be removed in the future as it's version will no
longer be needed. Note, function graph tracer is only limited to 16
simultaneous users, due to shadow stack size and allocated slots.


Please pull the latest ftrace-v6.11 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace-v6.11

Tag SHA1: d370074e4673a7f2dca52f93552a28714e8f65d7
Head SHA1: b576d375b536568c85d42c15a189f6b6fdd75b74


Jiapeng Chong (2):
      fgraph: Remove some unused functions
      fgraph: Use str_plural() in test_graph_storage_single()

Marilene A Garcia (1):
      ftrace: Add missing kerneldoc parameters to unregister_ftrace_direct()

Masami Hiramatsu (Google) (3):
      function_graph: Handle tail calls for stack unwinding
      function_graph: Use a simple LRU for fgraph_array index number
      ftrace: Add multiple fgraph storage selftest

Steven Rostedt (Google) (27):
      ftrace: Add subops logic to allow one ops to manage many
      ftrace: Allow subops filtering to be modified
      function_graph: Add pid tracing back to function graph tracer
      function_graph: Use for_each_set_bit() in __ftrace_return_to_handler()
      function_graph: Use bitmask to loop on fgraph entry
      function_graph: Use static_call and branch to optimize entry function
      function_graph: Use static_call and branch to optimize return function
      selftests/ftrace: Add function_graph tracer to func-filter-pid test
      selftests/ftrace: Add fgraph-multi.tc test
      ftrace: Add back ftrace_update_trampoline() to ftrace_update_pid_func()
      ftrace/selftests: Fix pid test with function graph not showing pids
      ftrace: Rename dup_hash() and comment it
      ftrace: Remove "filter_hash" parameter from __ftrace_hash_rec_update()
      ftrace: Add comments to ftrace_hash_rec_disable/enable()
      ftrace: Convert "inc" parameter to bool in ftrace_hash_rec_update_modify()
      ftrace: Add comments to ftrace_hash_move() and friends
      ftrace: Declare function_trace_op in header to quiet sparse warning
      ftrace: Assign ftrace_list_end to ftrace_ops_list type cast to RCU
      ftrace: Assign RCU list variable with rcu_assign_ptr()
      ftrace: Fix prototypes for ftrace_startup/shutdown_subops()
      function_graph: Make fgraph_do_direct static key static
      function_graph: Do not update pid func if CONFIG_DYNAMIC_FTRACE not enabled
      function_graph: Rename BYTE_NUMBER to CHAR_NUMBER in selftests
      function_graph: Make fgraph_update_pid_func() a stub for !DYNAMIC_FTRACE
      function_graph: Fix up ftrace_graph_ret_addr()
      function_graph: Everyone uses HAVE_FUNCTION_GRAPH_RET_ADDR_PTR, remove it
      function_graph: Add READ_ONCE() when accessing fgraph_array[]

Steven Rostedt (VMware) (15):
      function_graph: Convert ret_stack to a series of longs
      fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
      function_graph: Add an array structure that will allow multiple callbacks
      function_graph: Allow multiple users to attach to function graph
      function_graph: Remove logic around ftrace_graph_entry and return
      ftrace/function_graph: Pass fgraph_ops to function graph callbacks
      ftrace: Allow function_graph tracer to be enabled in instances
      ftrace: Allow ftrace startup flags to exist without dynamic ftrace
      function_graph: Have the instances use their own ftrace_ops for filtering
      function_graph: Add "task variables" per task for fgraph_ops
      function_graph: Move set_graph_function tests to shadow stack global var
      function_graph: Move graph depth stored data to shadow stack global var
      function_graph: Move graph notrace bit to shadow stack global var
      function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
      function_graph: Add selftest for passing local variables

Tatsuya S (1):
      ftrace: Hide one more entry in stack trace when ftrace_pid is enabled

----
 Documentation/trace/ftrace-design.rst              |   12 -
 arch/arm64/include/asm/ftrace.h                    |   11 -
 arch/csky/include/asm/ftrace.h                     |    2 -
 arch/loongarch/include/asm/ftrace.h                |    1 -
 arch/powerpc/include/asm/ftrace.h                  |    2 -
 arch/riscv/include/asm/ftrace.h                    |    1 -
 arch/s390/include/asm/ftrace.h                     |    1 -
 arch/x86/include/asm/ftrace.h                      |    2 -
 include/linux/ftrace.h                             |   48 +-
 include/linux/sched.h                              |    2 +-
 include/linux/trace_recursion.h                    |   39 -
 kernel/trace/fgraph.c                              | 1054 ++++++++++++++++----
 kernel/trace/ftrace.c                              |  688 +++++++++++--
 kernel/trace/ftrace_internal.h                     |   18 +-
 kernel/trace/trace.h                               |   93 +-
 kernel/trace/trace_functions.c                     |   15 +-
 kernel/trace/trace_functions_graph.c               |   96 +-
 kernel/trace/trace_irqsoff.c                       |   10 +-
 kernel/trace/trace_sched_wakeup.c                  |   10 +-
 kernel/trace/trace_selftest.c                      |  259 ++++-
 .../selftests/ftrace/test.d/ftrace/fgraph-multi.tc |  103 ++
 .../ftrace/test.d/ftrace/func-filter-pid.tc        |   29 +-
 22 files changed, 2055 insertions(+), 441 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-multi.tc
---------------------------

