Return-Path: <bpf+bounces-14226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A557E1440
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 17:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A7AB20DD2
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6A711734;
	Sun,  5 Nov 2023 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dq5JJW/B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA48487;
	Sun,  5 Nov 2023 16:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86428C433C7;
	Sun,  5 Nov 2023 16:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699200396;
	bh=atjltlHeelRF2nl1QIB8M3dfSzwoG6V15AaHDBeAzeY=;
	h=From:To:Cc:Subject:Date:From;
	b=dq5JJW/BORgG11JMGcLusoskQYDTv6x84NRM4FEJizC6ES4Nu/ABUh0rWK1Qqj4gH
	 MXLr18VEROcntPZWwhIY0bhaUWhliH/WyG2U4I3TqG1mRbIQm8q2ztNC2+lR2bbH+3
	 JXzzBr4UMP65JCZkjt6oOelNY/Z6w89P/8Wmy+xUIQzTQV6MW/DGGrK2nsT06a0F2s
	 BhuC/9FkZ9QMGaR/ULf2H+70K6zPJKpmX6bE1zoxodQD0hga3R0DzMeuGTCNUvFKHA
	 ESLDhnAVg+cgxa8uuDGaeZZ516Qj5l9FR3F3qMe7bk8IxJYfhiMyeG4dIHxU9YADIM
	 QauVMF1HRnBiA==
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
Subject: [RFC PATCH 00/32] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
Date: Mon,  6 Nov 2023 01:06:29 +0900
Message-Id: <169920038849.482486.15796387219966662967.stgit@devnote2>
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

Here is the renewed series to re-implement the fprobe on function-graph
tracer.
Previously it was discussed as the series to use ftrace_regs instead of
pt_regs in fprobe. The previous series is here;

https://lore.kernel.org/all/169556254640.146934.5654329452696494756.stgit@devnote2/

This RFC series does major 2 changes, enable multiple function-graphs on
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

Design:
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

Series:
Patch [1/32] to [16/32] are forward port of the multiple function-graph
sent by Steven Rostedt.
[17/32] to [21/32] are bug fixes for the multiple function-graph series
(These will be merged to the corresponding patches. In this version
 I just split it to show what is fixed/changed).
[22/32] and [24/32] adds new function-graph callbacks with ftrace_regs
and x86-64 implementation.
[25/32] to [28/32] are preparation (adding util functions) of the new
fprobe and its user. [29/32] to [31/32] rewrites fprobes and updates
its users. [32/32] is a documentation update.

This series can be applied against the probes-fixes-v6.6-rc7 on linux-trace tree.

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph

Thank you,

---

Christophe JAILLET (1):
      seq_buf: Export seq_buf_puts()

Masami Hiramatsu (Google) (16):
      function_graph: Fix to update curr_ret_stack with ARRAY entry size
      function_graph: Fix to initalize ftrace_ops for fgraph with ftrace_graph_func
      function_graph: Fix to check the return value of ftrace_pop_return_trace()
      function_graph: Pass the size of reserved data when retrieving it
      function_graph: Expand the max reserved data size
      function_graph: Add a new entry handler with parent_ip and ftrace_regs
      function_graph: Add a new exit handler with parent_ip and ftrace_regs
      x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
      fprobe: Use ftrace_regs in fprobe entry handler
      fprobe: Use ftrace_regs in fprobe exit handler
      tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
      tracing: Add ftrace_fill_perf_regs() for perf event
      fprobe: Rewrite fprobe on function-graph tracer
      tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
      bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
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


 Documentation/trace/fprobe.rst           |   42 +
 arch/arm64/include/asm/ftrace.h          |   18 +
 arch/arm64/kernel/ftrace.c               |    8 
 arch/loongarch/Kconfig                   |    1 
 arch/loongarch/kernel/ftrace_dyn.c       |    6 
 arch/powerpc/include/asm/ftrace.h        |    7 
 arch/powerpc/kernel/trace/ftrace.c       |    2 
 arch/powerpc/kernel/trace/ftrace_64_pg.c |   10 
 arch/s390/Kconfig                        |    1 
 arch/s390/include/asm/ftrace.h           |    5 
 arch/x86/Kconfig                         |    4 
 arch/x86/include/asm/ftrace.h            |    9 
 arch/x86/kernel/ftrace.c                 |   50 +-
 arch/x86/kernel/ftrace_64.S              |   30 +
 include/linux/fprobe.h                   |   58 +-
 include/linux/ftrace.h                   |  132 ++++
 include/linux/sched.h                    |    2 
 include/linux/trace_recursion.h          |   39 -
 kernel/trace/Kconfig                     |   19 -
 kernel/trace/bpf_trace.c                 |   14 
 kernel/trace/fgraph.c                    |  945 ++++++++++++++++++++++++------
 kernel/trace/fprobe.c                    |  631 ++++++++++++++------
 kernel/trace/ftrace.c                    |   13 
 kernel/trace/ftrace_internal.h           |    2 
 kernel/trace/trace.h                     |   93 ++-
 kernel/trace/trace_fprobe.c              |   70 +-
 kernel/trace/trace_functions.c           |    8 
 kernel/trace/trace_functions_graph.c     |   96 ++-
 kernel/trace/trace_irqsoff.c             |   10 
 kernel/trace/trace_probe_tmpl.h          |    2 
 kernel/trace/trace_sched_wakeup.c        |   10 
 kernel/trace/trace_selftest.c            |  176 +++++-
 lib/seq_buf.c                            |    1 
 lib/test_fprobe.c                        |   51 --
 samples/fprobe/fprobe_example.c          |    4 
 35 files changed, 1915 insertions(+), 654 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

