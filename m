Return-Path: <bpf+bounces-28837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 632EF8BE53B
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52991F21CA0
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A4F15F314;
	Tue,  7 May 2024 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhQMW7kR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39515E1FF;
	Tue,  7 May 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090887; cv=none; b=l0dGBML6mwvYJqEG6yBnPM9HiZFfo1NL6MLQJmILPqs0oGUavWYUAkoxcoNF/XhENj1Yr5rJQ+s3snrB5ejUJCSLoHw0pryuGKvETkO4CRpcJ0/NPBtVp3lPd51Uzb8uYUpsxmWrD4L2undM9lx54eDYuqopeDAS8dyLqLXqXGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090887; c=relaxed/simple;
	bh=bJdyXAcvI36jGzx00sgILjx6z851hk8F1hrlH6JPH1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lR4HBU9PB9OmXydKphrA7di2sHvaKhXKH6VgX6Vfep9IZflVSbOreO387NslU062pdrhpqdwj0tszuOIfnm29mWgpUnj7LHrfUV2KBHoYLo/DyO5xlRigHHhNaL0MCjNbwh3FdZ/JfAwR/VyIShHZjDgP81Ry35zBDwsUyujFAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhQMW7kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2C8C4AF66;
	Tue,  7 May 2024 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715090886;
	bh=bJdyXAcvI36jGzx00sgILjx6z851hk8F1hrlH6JPH1M=;
	h=From:To:Cc:Subject:Date:From;
	b=fhQMW7kRQtaBnfveU+tTLEe5H3HkVhtC6OuYdNQhLrdWwghHSLhbrJ7/iKwS9UYDq
	 nXWItCm2ZpDhzi2/uNNKRvbmVEdEL/0mOmRtB+zV3nvqA1XlNxwQCDETSUd4AIVJhp
	 HgvFrQI2rpkcaKUBav1oI4GQ+YAB5M2O/Xm1XHw+v1LiPA5v1ZA+oC9SJnbGnrtMLw
	 P4QbCo5NgHVOk64eFMeK1mYbgwbPIBfbPv98uyI2vma4Ds4auVsjX9KTk3Bfn6UmOj
	 If+iQmiqfmYIMaSWHiVifC0VvRqq4rjWj5qqr5wZ0ADXAiZR1qe/6VZJi2RIiY0Oh2
	 HlA6MOPLG45OA==
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
Subject: [PATCH v10 00/36] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
Date: Tue,  7 May 2024 23:08:00 +0900
Message-Id: <171509088006.162236.7227326999861366050.stgit@devnote2>
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

Here is the 10th version of the series to re-implement the fprobe on
function-graph tracer. The previous version is;

https://lore.kernel.org/all/171318533841.254850.15841395205784342850.stgit@devnote2/

This version is ported on the latest kernel (v6.9-rc6 + probes/for-next)
and fixed some bugs + performance optimizations.
 - [7/36] Fix terminology in comments and code. Use "offset" instead
          of "index" for shadow stack. This also update macros.
 - [18/36] Fix supported data size bug.
 - [29/36] Define bpf_kprobe_multi_pt_regs only if it is used.
 - [36/36] Add likely() to skip timestamp.

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

This series can be applied against the probes/for-next branch, which
is based on v6.9-rc6.

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph

Thank you,

---

Masami Hiramatsu (Google) (21):
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
      fgraph: Skip recording calltime/rettime if it is not nneeded

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
 include/linux/fprobe.h                             |   57 +
 include/linux/ftrace.h                             |  172 +++
 include/linux/sched.h                              |    2 
 include/linux/trace_recursion.h                    |   39 -
 kernel/trace/Kconfig                               |   23 
 kernel/trace/bpf_trace.c                           |   19 
 kernel/trace/fgraph.c                              | 1024 ++++++++++++++++----
 kernel/trace/fprobe.c                              |  637 +++++++++---
 kernel/trace/ftrace.c                              |   13 
 kernel/trace/ftrace_internal.h                     |    2 
 kernel/trace/trace.h                               |   96 ++
 kernel/trace/trace_fprobe.c                        |  147 +--
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
 51 files changed, 2347 insertions(+), 886 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

