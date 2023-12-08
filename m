Return-Path: <bpf+bounces-17135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47D980A098
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1CB281954
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611B714F77;
	Fri,  8 Dec 2023 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHfBMWiZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96914008;
	Fri,  8 Dec 2023 10:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61317C433C8;
	Fri,  8 Dec 2023 10:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702031062;
	bh=AbXWhwaHZjGBblilfPN9RBN+R9mqoytPii3caQypaKE=;
	h=From:To:Cc:Subject:Date:From;
	b=qHfBMWiZMLkYYyGnpR0FFdkm3BSPPqJkmoPstC2j0s8l+dKu/cAWLWWxIwGeX1EHQ
	 LcVwZN6f5PG5UosfYN3YCDxJihWTptVO5zoYD2qkU/+t+OP/JUE3ilGVTpXL1478ZX
	 EcdLPREFZFq19W7Ym+a5rHj8g80WdOsR/MAW8yDfLCCeQ049U30oGaVGqwAhHqJKTL
	 Xeq6NZVgT/FoIXSxPC9qUtnry4qdq1RTjG3m4dKTnD/a9674YlvHnLO5aAD5W4PeZG
	 Bp2uBB+4NJMV1DK9G+ErwwmQ0EBpB9EAzG5dFy7ebpEPcPZBe4PTgRXghScZELpweH
	 6YM54n/RLAQJw==
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
Subject: [PATCH v4 00/33] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
Date: Fri,  8 Dec 2023 19:24:15 +0900
Message-Id: <170203105427.579004.8033550792660734570.stgit@devnote2>
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

Here is the 4th version of the series to re-implement the fprobe on
function-graph tracer. The previous version is;

https://lore.kernel.org/all/170109317214.343914.4784420430328654397.stgit@devnote2/

This version is rebased on "trace-v6.7-rc4" tag on linux-trace tree
and fix some issues on the new multiple function graph tracer
implementation[11/33].  I also add a simple LRU so that the recently 
released fgraph_array index is not reused soon [12/33].


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
must support CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS, which enables to
call function-graph entry callback with 'ftrace_regs', and also
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

Series
------
- Patch [1/33] and [2/33] are adding a comment for ftrace_regs.
- Patch [3/33] to [18/33] are the multiple function-graph support.
- Patch [19/33] and [20/33] adds new function-graph callbacks with
  ftrace_regs and x86-64 implementation.
- Patch [21/33] to [27/33] are preparation (adding util functions) of
  the new fprobe and its user.
- Patch [28/33] to [32/33] rewrites fprobes and updates its users.
- Patch [33/33] is a documentation update.

This series can be applied against the trace-v6.7-rc4 on linux-trace tree.

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph

Thank you,

---

Masami Hiramatsu (Google) (18):
      tracing: Add a comment about ftrace_regs definition
      x86: tracing: Add ftrace_regs definition in the header
      function_graph: Use a simple LRU for fgraph_array index number
      function_graph: Add a new entry handler with parent_ip and ftrace_regs
      function_graph: Add a new exit handler with parent_ip and ftrace_regs
      x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
      tracing: Rename ftrace_regs_return_value to ftrace_regs_get_return_value
      arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
      fprobe: Use ftrace_regs in fprobe entry handler
      fprobe: Use ftrace_regs in fprobe exit handler
      tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
      tracing: Add ftrace_fill_perf_regs() for perf event
      fprobe: Rewrite fprobe on function-graph tracer
      tracing/fprobe: Remove nr_maxactive from fprobe
      tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
      bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
      selftests: ftrace: Remove obsolate maxactive syntax check
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
 arch/arm64/Kconfig                                 |    2 
 arch/arm64/include/asm/ftrace.h                    |   24 
 arch/arm64/kernel/entry-ftrace.S                   |   28 +
 arch/arm64/kernel/ftrace.c                         |   19 
 arch/loongarch/Kconfig                             |    1 
 arch/loongarch/include/asm/ftrace.h                |    2 
 arch/loongarch/kernel/ftrace_dyn.c                 |    6 
 arch/powerpc/include/asm/ftrace.h                  |    9 
 arch/powerpc/kernel/trace/ftrace.c                 |    2 
 arch/powerpc/kernel/trace/ftrace_64_pg.c           |   10 
 arch/s390/Kconfig                                  |    1 
 arch/s390/include/asm/ftrace.h                     |    7 
 arch/x86/Kconfig                                   |    4 
 arch/x86/include/asm/ftrace.h                      |   17 
 arch/x86/kernel/ftrace.c                           |   51 +
 arch/x86/kernel/ftrace_64.S                        |   37 +
 include/linux/fprobe.h                             |   58 +
 include/linux/ftrace.h                             |  167 +++
 include/linux/sched.h                              |    2 
 include/linux/trace_recursion.h                    |   39 -
 kernel/trace/Kconfig                               |   19 
 kernel/trace/bpf_trace.c                           |   14 
 kernel/trace/fgraph.c                              | 1003 ++++++++++++++++----
 kernel/trace/fprobe.c                              |  631 +++++++++----
 kernel/trace/ftrace.c                              |   13 
 kernel/trace/ftrace_internal.h                     |    2 
 kernel/trace/trace.h                               |   94 ++
 kernel/trace/trace_fprobe.c                        |  114 +-
 kernel/trace/trace_functions.c                     |    8 
 kernel/trace/trace_functions_graph.c               |   96 +-
 kernel/trace/trace_irqsoff.c                       |   10 
 kernel/trace/trace_probe_tmpl.h                    |    2 
 kernel/trace/trace_sched_wakeup.c                  |   10 
 kernel/trace/trace_selftest.c                      |  178 +++-
 lib/test_fprobe.c                                  |   51 -
 samples/fprobe/fprobe_example.c                    |    4 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 38 files changed, 2082 insertions(+), 699 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

