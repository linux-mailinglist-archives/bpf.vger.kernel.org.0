Return-Path: <bpf+bounces-14482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB3A7E58A2
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 15:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3AB1C20B48
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5679219BCC;
	Wed,  8 Nov 2023 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLobGbb1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD4E19BA8;
	Wed,  8 Nov 2023 14:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F64C433C7;
	Wed,  8 Nov 2023 14:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699453466;
	bh=/oUyVsjDTKel8BdMGwQETEhmuxZimn58gjaDy60fhis=;
	h=From:To:Cc:Subject:Date:From;
	b=YLobGbb1DwvBXe+SkW+eqV/xATEwOB5m0BHuKd7p1KQZNJwTZNVXg3GJ2P7VGH3bn
	 j+EOFLZKe5Ab9rlrrRmRnQxWXB01ncUwPuG1w4ddXs6fDj1ydD/A1YwUJYT7DhH802
	 3g2oqlAHnZCw3TQMCRYv563oDdADOWAAkGfTgHWPG4JKO68pHDSfCr/mVXGQTm8IKX
	 nlSwLDrWYviisr2r+pqJrw/VRGC9PwnKnQyPZGTVigxZx7fo/KWsoCwrs+YO5oFmV9
	 3C+Zsu/n4Oeec2OqINkkheb6PtcgZqo/nUVQzej4YZEpEM/7JUhwjQh7P7BDLgeMlQ
	 8qut+ttC/kVrw==
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
Subject: [RFC PATCH v2 00/31] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
Date: Wed,  8 Nov 2023 23:24:19 +0900
Message-Id: <169945345785.55307.5003201137843449313.stgit@devnote2>
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

Here is the 2nd version of the series to re-implement the fprobe on
function-graph tracer. The previous version is;

https://lore.kernel.org/all/169920038849.482486.15796387219966662967.stgit@devnote2/

In this version I merged the fixes to appropriate patches and fix
some typos/bugs, and fix some issues.
I also add some commentary patches for ftrace_regs.

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
- Patch [1/31] and [2/31] are adding a comment for ftrace_regs.
- Patch [3/31] to [18/31] are the multiple function-graph support.
- Patch [19/31] and [21/31] adds new function-graph callbacks with
  ftrace_regs and x86-64 implementation.
- Patch [22/31] to [25/31] are preparation (adding util functions) of
  the new fprobe and its user.
- Patch [26/31] to [30/31] rewrites fprobes and updates its users.
- Patch [31/31] is a documentation update.

This series can be applied against the probes-fixes-v6.6-rc7 on linux-trace tree.

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph

Thank you,

---

Christophe JAILLET (1):
      seq_buf: Export seq_buf_puts()

Masami Hiramatsu (Google) (15):
      tracing: Add a comment about ftrace_regs definition
      x86: tracing: Add ftrace_regs definition in the header
      function_graph: Add a new entry handler with parent_ip and ftrace_regs
      function_graph: Add a new exit handler with parent_ip and ftrace_regs
      x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
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
 arch/arm64/include/asm/ftrace.h                    |   18 
 arch/arm64/kernel/ftrace.c                         |    8 
 arch/loongarch/Kconfig                             |    1 
 arch/loongarch/kernel/ftrace_dyn.c                 |    6 
 arch/powerpc/include/asm/ftrace.h                  |    7 
 arch/powerpc/kernel/trace/ftrace.c                 |    2 
 arch/powerpc/kernel/trace/ftrace_64_pg.c           |   10 
 arch/s390/Kconfig                                  |    1 
 arch/s390/include/asm/ftrace.h                     |    5 
 arch/x86/Kconfig                                   |    4 
 arch/x86/include/asm/ftrace.h                      |   15 
 arch/x86/kernel/ftrace.c                           |   50 +
 arch/x86/kernel/ftrace_64.S                        |   36 +
 include/linux/fprobe.h                             |   58 +
 include/linux/ftrace.h                             |  159 +++
 include/linux/sched.h                              |    2 
 include/linux/trace_recursion.h                    |   39 -
 kernel/trace/Kconfig                               |   19 
 kernel/trace/bpf_trace.c                           |   14 
 kernel/trace/fgraph.c                              |  943 ++++++++++++++++----
 kernel/trace/fprobe.c                              |  637 ++++++++++----
 kernel/trace/ftrace.c                              |   13 
 kernel/trace/ftrace_internal.h                     |    2 
 kernel/trace/trace.h                               |   94 ++
 kernel/trace/trace_fprobe.c                        |  114 +-
 kernel/trace/trace_functions.c                     |    8 
 kernel/trace/trace_functions_graph.c               |   96 +-
 kernel/trace/trace_irqsoff.c                       |   10 
 kernel/trace/trace_probe_tmpl.h                    |    2 
 kernel/trace/trace_sched_wakeup.c                  |   10 
 kernel/trace/trace_selftest.c                      |  178 ++++
 lib/seq_buf.c                                      |    1 
 lib/test_fprobe.c                                  |   51 -
 samples/fprobe/fprobe_example.c                    |    4 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 36 files changed, 1965 insertions(+), 698 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

