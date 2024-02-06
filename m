Return-Path: <bpf+bounces-21312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A684B8CE
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC98289A10
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C84132C1C;
	Tue,  6 Feb 2024 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1+n6vfa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4C1E866;
	Tue,  6 Feb 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232055; cv=none; b=S/erOGjnsYdSZmazgyPfs7SSwmgo9MbzjUoR11G6BLmwCeKmo8OCLof7IWzp55Xa6iLK5b6uDrCE2e61P2jGFqWR7TgUx/V0HTPkuNcw2KPFy6Rkxstpp8kdKQ3kk9YnGq/Hmt4j9FzlWDPGil8wiaYWpRUNpQKoDZ65QqjDhP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232055; c=relaxed/simple;
	bh=Ii+WcqZDg5A6lf9RNiCFYTT3chrvRJ8xzBmAEQd/9x4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LJBiOrlfKW/ZJoXoflSSqWZhqTNtGeqnt27kuYwbbPilXrNEA1QldB5xYBKBLC0RyXRORYgd74GGeDIsDZFaJ6DrSZsHFBmqdzcHZOsQsSzQAFP3kGAy8u4tRuwLMepkWBCE0IjvNdlhN9dDyUGA79VqQ8elppgQHvlUBWUVixQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1+n6vfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9F9C433F1;
	Tue,  6 Feb 2024 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232055;
	bh=Ii+WcqZDg5A6lf9RNiCFYTT3chrvRJ8xzBmAEQd/9x4=;
	h=From:To:Cc:Subject:Date:From;
	b=i1+n6vfa9B4C/ZJl6O5oTNDHwfvjMdNbYgxpglUy3EuYORgKfoWQyGZpxp9LnEcRG
	 AwzuARqxy4YK6RdbcJwl62sJZThPo40QqqWxHoMirpOz55GvzqbX7WnOaf17OL+yWa
	 zFp2kNn7+q4u30ZeRcF0ROP04JTd3GycggfG7ZSE+xyG6N3WvytzfZIsaoN8RNwqj4
	 FfVYIFikrYYOsB18HZ4DmH1m9+zIWGA26Ho6fjC4nMBJYUrn1g76ncqwF3YVM5moNa
	 u4bBJHE/uU177BwIEhoRzdcoUSJcrUv+zCI20FaEY4L+vMnBMQzOWt64OfOZ0Bqpix
	 zDqn5DNINSKCQ==
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
Subject: [PATCH v7 00/36] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
Date: Wed,  7 Feb 2024 00:07:29 +0900
Message-Id: <170723204881.502590.11906735097521170661.stgit@devnote2>
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

Here is the 7th version of the series to re-implement the fprobe on
function-graph tracer. The previous version is;

https://lore.kernel.org/all/170505424954.459169.10630626365737237288.stgit@devnote2/

This version fixes max-limitation check[8/36] and interrupt while commiting
pop operation bugs [20/36]. Also, I decided to move the FGRAPH_TYPE_BITMAP
part from [13/36] to [8/36] so that it will introduce bitmap type from
the beginning, instead of replacing the FGRAPH_TYPE_ARRAY.
This also updates ftrace_graph_func() on loongarch and powerpc so that
it will call function_graph_enter_ops() directly with fgraph_ops [13/36].

TODOs:
 - Add s390x support to fprobe (this means implementing fgraph call from
   ftrace support).

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

This series can be applied against the linux-trace/trace/urgent 
(based on v6.8-rc1) kernel.

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph

Thank you,

---

Masami Hiramatsu (Google) (21):
      ftrace: Fix DIRECT_CALLS to use SAVE_REGS by default
      tracing: Add a comment about ftrace_regs definition
      tracing: Rename ftrace_regs_return_value to ftrace_regs_get_return_value
      x86: tracing: Add ftrace_regs definition in the header
      function_graph: Use a simple LRU for fgraph_array index number
      function_graph: Improve push operation for several interrupts
      function_graph: Add a new entry handler with parent_ip and ftrace_regs
      function_graph: Add a new exit handler with parent_ip and ftrace_regs
      x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
      arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
      fprobe: Use ftrace_regs in fprobe entry handler
      fprobe: Use ftrace_regs in fprobe exit handler
      tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
      tracing: Add ftrace_fill_perf_regs() for perf event
      tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
      bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
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
 arch/arm64/Kconfig                                 |    2 
 arch/arm64/include/asm/ftrace.h                    |   24 
 arch/arm64/kernel/entry-ftrace.S                   |   28 +
 arch/arm64/kernel/ftrace.c                         |   21 
 arch/loongarch/Kconfig                             |    1 
 arch/loongarch/include/asm/ftrace.h                |    2 
 arch/loongarch/kernel/ftrace_dyn.c                 |    9 
 arch/powerpc/include/asm/ftrace.h                  |    9 
 arch/powerpc/kernel/trace/ftrace.c                 |    3 
 arch/powerpc/kernel/trace/ftrace_64_pg.c           |   10 
 arch/s390/Kconfig                                  |    1 
 arch/s390/include/asm/ftrace.h                     |    7 
 arch/x86/Kconfig                                   |    4 
 arch/x86/include/asm/ftrace.h                      |   17 
 arch/x86/kernel/ftrace.c                           |   51 +
 arch/x86/kernel/ftrace_64.S                        |   37 +
 include/linux/fprobe.h                             |   58 +
 include/linux/ftrace.h                             |  167 +++
 include/linux/sched.h                              |    3 
 include/linux/trace_recursion.h                    |   39 -
 kernel/trace/Kconfig                               |   19 
 kernel/trace/bpf_trace.c                           |   14 
 kernel/trace/fgraph.c                              | 1078 ++++++++++++++++----
 kernel/trace/fprobe.c                              |  631 ++++++++----
 kernel/trace/ftrace.c                              |   21 
 kernel/trace/ftrace_internal.h                     |    2 
 kernel/trace/trace.h                               |   94 +-
 kernel/trace/trace_fprobe.c                        |  114 +-
 kernel/trace/trace_functions.c                     |    8 
 kernel/trace/trace_functions_graph.c               |   96 +-
 kernel/trace/trace_irqsoff.c                       |   10 
 kernel/trace/trace_probe_tmpl.h                    |    2 
 kernel/trace/trace_sched_wakeup.c                  |   10 
 kernel/trace/trace_selftest.c                      |  178 +++
 lib/test_fprobe.c                                  |   51 -
 samples/fprobe/fprobe_example.c                    |    4 
 .../test.d/dynevent/add_remove_fprobe_repeat.tc    |   19 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 39 files changed, 2190 insertions(+), 700 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

