Return-Path: <bpf+bounces-22653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC434862AF8
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9EF1F21777
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AFE14276;
	Sun, 25 Feb 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlFA7jb7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73214265;
	Sun, 25 Feb 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874110; cv=none; b=jnYEIQW+o+ugJi7zwtadxdDEdLS1H66YMNvW5ExcYd2nnqTnUda3frmfRoKOREiyEgSQ/lcsswSwnWp1VMlsoCiqzGcjnmBePXZ4lFTQOSQ4+AJuWu9jO9qp9elQglMX87Lqf5AqmSRzlUi8KNGaFa8DpBEhlVlbbbLKCdp1dRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874110; c=relaxed/simple;
	bh=GcAHLIR+YuDRk9uOUnDu0Rv206UEIX4FvjIbI7AZHss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uHziXB8Y0/wAFTuzErq7tlKZclUoolh6aczc1uACapNSwWTox51DYbkX0upJ3iVqXQak0A9S5Kuu/VuTzn6y4HrGbOJ0/uPuBk2KQjAhYAfchumSBA2bfch+4zlb/KEvuIdRkFf8+C7OvioN5kFyDI07V/I18rqQlSbf0hgNuZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlFA7jb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ADBC433C7;
	Sun, 25 Feb 2024 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708874110;
	bh=GcAHLIR+YuDRk9uOUnDu0Rv206UEIX4FvjIbI7AZHss=;
	h=From:To:Cc:Subject:Date:From;
	b=SlFA7jb71PUIeVt7t44Ll0xdu5heeUcI1hmf0CN6JMdeYONz8diJR0E2wJPxcLiGP
	 lAWiRHq3f7b0E/KQPG0G2vH2Cj7X/gI1J+O/q2fCHF0BqPQ4yBNm5NQ8sUd1+JuY44
	 yo2CtlUAuiEuYpN+vQL86XjomMhMeOkV9MMjgI53naYo+RLO9nOGtpnyYiAI5u2Pu/
	 flT1Hf9m8DRr6FjNpezsI2nf7MEY1T6tU9hM9Y+oLMzQpa3IaGv3NdWYLFaZX10TMN
	 ETRixaULHzw/aYRU687/jdQZqh91BtLsMdTSfjPeF8mtrgqsLZ7zRCR7pvLjYSpjMG
	 vHHMtrgru/xmg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>
Subject: [PATCH v8 00/35] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
Date: Mon, 26 Feb 2024 00:15:04 +0900
Message-Id: <170887410337.564249.6360118840946697039.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 8th version of the series to re-implement the fprobe on
function-graph tracer. The previous version is;

https://lore.kernel.org/all/170723204881.502590.11906735097521170661.stgit@devnote2/

In this version, I droped very rare case pop operation fix. This also
drops x86/arm64 HAVE_FUNCTION_GRAPH_FREGS patches, but instead of that,
this replaces fgraph_ret_regs with ftrace_regs directly(of course that
does not save extra registers, only return values and frame pointers as
fgraph_ret_regs did)[22/35].
Another updates are:
 - Update the comment about ftrace_regs which saves partial registers
   depends on the context.[1/35]
 - Fix loongarch and riscv implementation of ftrace_graph_func().[12/35]
 - Adjust WARN_ON_ONCE() check places and release index if failed to
   register.[13/35]
 - Remove DIV_ROUND_UP() from hotpath.[18/35]
 - Add a selftest for multiple fgraph tracer with different storage
   size on the same function.[20/35]
 - Pass ftrace_regs to entryfunc/retfunc instead of adding
   *regfunc.[21/35][23/35]
 - Update changelog to explain why.[26/35]
 - Add CONFIG_HAVE_FTRACE_GRAPH_FUNC kconfig.[30/35]
 - Update fprobe using entryfunc/retfunc and kconfig dependency, also
   introduce ftrace_regs_get_return_address().[31/35]

Now the Fprobe will be enabled on arm64, loongarch, and x86.
(Others need to implement ftrace_graph_func(), 
 ftrace_regs_get_return_address() and FTRACE_WITH_ARGS)


Overview
--------
This series does major 2 changes, enable multiple function-graphs on
the ftrace (e.g. allow function-graph on sub instances) and rewrite the
fprobe on this function-graph.

The former changes had been sent from Steven Rostedt 4 years ago (*),
which allows users to set different setting function-graph tracer (and
other tracers based on function-graph) in each trace-instances at the
same time.

(*) https://lore.kernel.org/all/20190525031633.811342628@goodmis.org/

The purpose of latter change are;

 1) Remove dependency of the rethook from fprobe so that we can reduce
   the return hook code and shadow stack.

 2) Make 'ftrace_regs' the common trace interface for the function
   boundary.

1) Currently we have 2(or 3) different function return hook codes,
 the function-graph tracer and rethook (and legacy kretprobe).
 But since this  is redundant and needs double maintenance cost,
 I would like to unify those. From the user's viewpoint, function-
 graph tracer is very useful to grasp the execution path. For this
 purpose, it is hard to use the rethook in the function-graph
 tracer, but the opposite is possible. (Strictly speaking, kretprobe
 can not use it because it requires 'pt_regs' for historical reasons.)

2) Now the fprobe provides the 'pt_regs' for its handler, but that is
 wrong for the function entry and exit. Moreover, depending on the
 architecture, there is no way to accurately reproduce 'pt_regs'
 outside of interrupt or exception handlers. This means fprobe should
 not use 'pt_regs' because it does not use such exceptions.
 (Conversely, kprobe should use 'pt_regs' because it is an abstract
  interface of the software breakpoint exception.)

This series changes fprobe to use function-graph tracer for tracing
function entry and exit, instead of mixture of ftrace and rethook.
Unlike the rethook which is a per-task list of system-wide allocated
nodes, the function graph's ret_stack is a per-task shadow stack.
Thus it does not need to set 'nr_maxactive' (which is the number of
pre-allocated nodes).
Also the handlers will get the 'ftrace_regs' instead of 'pt_regs'.
Since eBPF mulit_kprobe/multi_kretprobe events still use 'pt_regs' as
their register interface, this changes it to convert 'ftrace_regs' to
'pt_regs'. Of course this conversion makes an incomplete 'pt_regs',
so users must access only registers for function parameters or
return value. 

Design
------
Instead of using ftrace's function entry hook directly, the new fprobe
is built on top of the function-graph's entry and return callbacks
with 'ftrace_regs'.

Since the fprobe requires access to 'ftrace_regs', the architecture
must support CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS and
CONFIG_HAVE_FTRACE_GRAPH_FUNC, which enables to call function-graph
entry callback with 'ftrace_regs', and also
CONFIG_HAVE_FUNCTION_GRAPH_FREGS, which passes the ftrace_regs to
return_to_handler.

All fprobes share a single function-graph ops (means shares a common
ftrace filter) similar to the kprobe-on-ftrace. This needs another
layer to find corresponding fprobe in the common function-graph
callbacks, but has much better scalability, since the number of
registered function-graph ops is limited.

In the entry callback, the fprobe runs its entry_handler and saves the
address of 'fprobe' on the function-graph's shadow stack as data. The
return callback decodes the data to get the 'fprobe' address, and runs
the exit_handler.

The fprobe introduces two hash-tables, one is for entry callback which
searches fprobes related to the given function address passed by entry
callback. The other is for a return callback which checks if the given
'fprobe' data structure pointer is still valid. Note that it is
possible to unregister fprobe before the return callback runs. Thus
the address validation must be done before using it in the return
callback.

This series can be applied against the v6.8-rc4 kernel.

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph

Thank you,

---

Masami Hiramatsu (Google) (20):
      tracing: Add a comment about ftrace_regs definition
      tracing: Rename ftrace_regs_return_value to ftrace_regs_get_return_value
      x86: tracing: Add ftrace_regs definition in the header
      function_graph: Use a simple LRU for fgraph_array index number
      ftrace: Add multiple fgraph storage selftest
      function_graph: Pass ftrace_regs to entryfunc
      function_graph: Replace fgraph_ret_regs with ftrace_regs
      function_graph: Pass ftrace_regs to retfunc
      fprobe: Use ftrace_regs in fprobe entry handler
      fprobe: Use ftrace_regs in fprobe exit handler
      tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
      tracing: Add ftrace_fill_perf_regs() for perf event
      tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
      bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
      ftrace: Add CONFIG_HAVE_FTRACE_GRAPH_FUNC
      fprobe: Rewrite fprobe on function-graph tracer
      tracing/fprobe: Remove nr_maxactive from fprobe
      selftests: ftrace: Remove obsolate maxactive syntax check
      selftests/ftrace: Add a test case for repeating register/unregister fprobe
      Documentation: probes: Update fprobe on function-graph tracer

Steven Rostedt (VMware) (15):
      function_graph: Convert ret_stack to a series of longs
      fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
      function_graph: Add an array structure that will allow multiple callbacks
      function_graph: Allow multiple users to attach to function graph
      function_graph: Remove logic around ftrace_graph_entry and return
      ftrace/function_graph: Pass fgraph_ops to function graph callbacks
      ftrace: Allow function_graph tracer to be enabled in instances
      ftrace: Allow ftrace startup flags exist without dynamic ftrace
      function_graph: Have the instances use their own ftrace_ops for filtering
      function_graph: Add "task variables" per task for fgraph_ops
      function_graph: Move set_graph_function tests to shadow stack global var
      function_graph: Move graph depth stored data to shadow stack global var
      function_graph: Move graph notrace bit to shadow stack global var
      function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
      function_graph: Add selftest for passing local variables


 Documentation/trace/fprobe.rst                     |   42 +
 arch/arm64/Kconfig                                 |    3 
 arch/arm64/include/asm/ftrace.h                    |   47 +
 arch/arm64/kernel/asm-offsets.c                    |   12 
 arch/arm64/kernel/entry-ftrace.S                   |   32 -
 arch/arm64/kernel/ftrace.c                         |   21 
 arch/loongarch/Kconfig                             |    4 
 arch/loongarch/include/asm/ftrace.h                |   32 -
 arch/loongarch/kernel/asm-offsets.c                |   12 
 arch/loongarch/kernel/ftrace_dyn.c                 |   15 
 arch/loongarch/kernel/mcount.S                     |   17 
 arch/loongarch/kernel/mcount_dyn.S                 |   14 
 arch/powerpc/Kconfig                               |    1 
 arch/powerpc/include/asm/ftrace.h                  |   15 
 arch/powerpc/kernel/trace/ftrace.c                 |    3 
 arch/powerpc/kernel/trace/ftrace_64_pg.c           |   10 
 arch/riscv/Kconfig                                 |    3 
 arch/riscv/include/asm/ftrace.h                    |   21 
 arch/riscv/kernel/ftrace.c                         |   15 
 arch/riscv/kernel/mcount.S                         |   24 
 arch/s390/Kconfig                                  |    3 
 arch/s390/include/asm/ftrace.h                     |   39 -
 arch/s390/kernel/asm-offsets.c                     |    6 
 arch/s390/kernel/mcount.S                          |    9 
 arch/x86/Kconfig                                   |    4 
 arch/x86/include/asm/ftrace.h                      |   43 -
 arch/x86/kernel/ftrace.c                           |   51 +
 arch/x86/kernel/ftrace_32.S                        |   15 
 arch/x86/kernel/ftrace_64.S                        |   17 
 include/linux/fprobe.h                             |   58 +
 include/linux/ftrace.h                             |  175 +++-
 include/linux/sched.h                              |    2 
 include/linux/trace_recursion.h                    |   39 -
 kernel/trace/Kconfig                               |   23 
 kernel/trace/bpf_trace.c                           |   14 
 kernel/trace/fgraph.c                              |  969 ++++++++++++++++----
 kernel/trace/fprobe.c                              |  636 +++++++++----
 kernel/trace/ftrace.c                              |   13 
 kernel/trace/ftrace_internal.h                     |    2 
 kernel/trace/trace.h                               |   96 ++
 kernel/trace/trace_fprobe.c                        |  114 +-
 kernel/trace/trace_functions.c                     |    8 
 kernel/trace/trace_functions_graph.c               |   98 +-
 kernel/trace/trace_irqsoff.c                       |   12 
 kernel/trace/trace_probe_tmpl.h                    |    2 
 kernel/trace/trace_sched_wakeup.c                  |   12 
 kernel/trace/trace_selftest.c                      |  262 +++++
 lib/test_fprobe.c                                  |   51 -
 samples/fprobe/fprobe_example.c                    |    4 
 .../test.d/dynevent/add_remove_fprobe_repeat.tc    |   19 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 51 files changed, 2263 insertions(+), 880 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

