Return-Path: <bpf+bounces-33740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0623A9257F0
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 12:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B9328C536
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 10:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB3B142654;
	Wed,  3 Jul 2024 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kURAocXA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024DA49644;
	Wed,  3 Jul 2024 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001351; cv=none; b=Kp/EvH0ntN7lWH762Nr88LQN/xMNmXF0fznjRqr1xVTMZ3Qa+PSITHAOU13zirh7eGBGpAj6zWGpxRdm0pHBLaKsKzjRcxjWEYhXFrySDmb92e7LpMEoMMCsdMrN5//9IkPEt7NnN32IQTOVN7x1kXb/pF4YzYqk+Jf0uQaosxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001351; c=relaxed/simple;
	bh=ezfbo0+K+nla+LKnNUm/7nALUdAhHJTB/WUS2esnZcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DUHIjeGE31uE9SwR/TNTlh8RkK2IkTxERhOmyx7sYGaS+plX+sbaTULNeoPFvm0J7lRtOqkBTpUYpiFn0bZKSsgZwjCDp4WZ2OKC/SRXJYM44v04xC7i4EHvZB3+caQl+VOf+O05U4NfY3Zzzcdw7aHNRpsouwUlhjsYshRAUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kURAocXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09540C2BD10;
	Wed,  3 Jul 2024 10:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720001350;
	bh=ezfbo0+K+nla+LKnNUm/7nALUdAhHJTB/WUS2esnZcs=;
	h=From:To:Cc:Subject:Date:From;
	b=kURAocXAHJtbXjszmnTEQLuPngqE0khoQqX4Kq82BMvobCinwoB7quTtNfiafw6FI
	 +Ol+f1u3bGvc7U6jYZZb9qsXguZmku0RmFSynhiKdv9JvZ+n7mP+LWcGBN2lIdorW/
	 Y4Waxv8TA5UbLLCnquGbVUkkPMzDxA8/qj3wzs9p4q1o8i4rlUfa0yu+dJOEcCsJ+7
	 zK2abmRJk6T7yZi225EeUuuC2mgarB+tjeAvT0ILKIuPOXkFk8mHNJYn5CXYAMwNEB
	 Qe1bk8m8YeqzYV6IH4ZaKz301A7ucs1SgJyecik7QrWN2pOw0Vy40XJxlvyimnBQws
	 dVMYerO0ia6Tg==
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
Subject: [PATCH v12 00/19] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
Date: Wed,  3 Jul 2024 19:09:04 +0900
Message-Id: <172000134410.63468.13742222887213469474.stgit@devnote2>
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

Here is the 12th version of the series to re-implement the fprobe on
function-graph tracer. The previous version is;

https://lore.kernel.org/all/171858878797.288820.237119113242007537.stgit@devnote2/

In this version, I added a new performance improvement patch[19/19] and
add some performance numbers to [18/19]. Here is the final result of this
change.

NOTE: I used tools/testing/selftests/bpf/benchs/run_bench_trigger.sh, 
 so kprobe-multi is fprobe entry_handker, kretprobe-multi is fprobe
 exit_handler.

Without this series:
kprobe-multi   :    6.507 ± 0.065M/s 
kretprobe-multi:    3.518 ± 0.002M/s 

With this series:
kprobe-multi   :    6.377 ± 0.054M/s	-2.00%
kretprobe-multi:    4.815 ± 0.007M/s 	*36.87%

So the fprobe entry_handler performance is 2% down, but exit_handler
performance is 37% better.


Overview
--------
This series rewrites the fprobe on this function-graph.
The purposes of this change are;

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

Download
--------
This series can be applied against the ftrace/for-next branch in
linux-trace tree.

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph

Thank you,

---

Masami Hiramatsu (Google) (19):
      tracing: Add a comment about ftrace_regs definition
      tracing: Rename ftrace_regs_return_value to ftrace_regs_get_return_value
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
      fgraph: Skip push operation if no retfunc is registered


 Documentation/trace/fprobe.rst                     |   42 +
 arch/arm64/Kconfig                                 |    3 
 arch/arm64/include/asm/ftrace.h                    |   47 +
 arch/arm64/kernel/asm-offsets.c                    |   12 
 arch/arm64/kernel/entry-ftrace.S                   |   32 +
 arch/arm64/kernel/ftrace.c                         |   20 +
 arch/loongarch/Kconfig                             |    4 
 arch/loongarch/include/asm/ftrace.h                |   32 -
 arch/loongarch/kernel/asm-offsets.c                |   12 
 arch/loongarch/kernel/ftrace_dyn.c                 |   10 
 arch/loongarch/kernel/mcount.S                     |   17 -
 arch/loongarch/kernel/mcount_dyn.S                 |   14 
 arch/powerpc/Kconfig                               |    1 
 arch/powerpc/include/asm/ftrace.h                  |   15 
 arch/powerpc/kernel/trace/ftrace.c                 |    2 
 arch/powerpc/kernel/trace/ftrace_64_pg.c           |   10 
 arch/riscv/Kconfig                                 |    3 
 arch/riscv/include/asm/ftrace.h                    |   26 -
 arch/riscv/kernel/ftrace.c                         |   17 -
 arch/riscv/kernel/mcount.S                         |   24 -
 arch/s390/Kconfig                                  |    3 
 arch/s390/include/asm/ftrace.h                     |   39 +
 arch/s390/kernel/asm-offsets.c                     |    6 
 arch/s390/kernel/mcount.S                          |    9 
 arch/x86/Kconfig                                   |    4 
 arch/x86/include/asm/ftrace.h                      |   37 -
 arch/x86/kernel/ftrace.c                           |   50 +-
 arch/x86/kernel/ftrace_32.S                        |   15 
 arch/x86/kernel/ftrace_64.S                        |   17 -
 include/linux/fprobe.h                             |   57 +-
 include/linux/ftrace.h                             |  137 ++++
 kernel/trace/Kconfig                               |   23 +
 kernel/trace/bpf_trace.c                           |   19 -
 kernel/trace/fgraph.c                              |  119 +++-
 kernel/trace/fprobe.c                              |  661 +++++++++++++++-----
 kernel/trace/ftrace.c                              |    6 
 kernel/trace/trace.h                               |    6 
 kernel/trace/trace_fprobe.c                        |  147 ++--
 kernel/trace/trace_functions_graph.c               |   10 
 kernel/trace/trace_irqsoff.c                       |    6 
 kernel/trace/trace_probe_tmpl.h                    |    2 
 kernel/trace/trace_sched_wakeup.c                  |    6 
 kernel/trace/trace_selftest.c                      |   11 
 lib/test_fprobe.c                                  |   51 --
 samples/fprobe/fprobe_example.c                    |    4 
 .../test.d/dynevent/add_remove_fprobe_repeat.tc    |   19 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 47 files changed, 1190 insertions(+), 621 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

