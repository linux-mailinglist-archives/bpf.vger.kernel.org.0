Return-Path: <bpf+bounces-27819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2E08B24BD
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 17:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F21E1F225E3
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4B714A61B;
	Thu, 25 Apr 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuoQZu0J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE673BBE6;
	Thu, 25 Apr 2024 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057831; cv=none; b=ncpkcUnrlt67KYNCvgdywJS3HLkYsxfXDXDsWT8YlshH5L9XiPA9VVnSUxtGVHJ0hswXLi8zbXjZ7l9HOVPBN8gHcHIwoe+x83MvCpiquvhrhVR0lwed3T+sqmw/2qZJGGzOkX1JItOgXMJuYq5mN11VdpnQo9pj85wMl3IIHW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057831; c=relaxed/simple;
	bh=2Db1Shz87nAKBkdDZh6XepNpCXuOG6oRUL9z0q7jbjc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vth2J+VtmuA0RcEEfuxa8tjyv5VN//mpHEWvcld9UCiipVIt1Ymxals4TfNFRcvA5gKvNkBkTwwP1kmxvXfXvyGIfibyqbslsdajpQQlYYxJJcrXunqEDj4pv1xgNikCj1qLhDGwqpMlcPJFwgf0MyX/TjleDReval0tqTEyOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuoQZu0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE044C113CC;
	Thu, 25 Apr 2024 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714057831;
	bh=2Db1Shz87nAKBkdDZh6XepNpCXuOG6oRUL9z0q7jbjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LuoQZu0Jf760K5w7GBjYLnUkIoge5P9JK4AEDVXDxxP5oTWdr/X3qh2vU/BcyQnwT
	 o/lVhs3kJ3yP8Cs3WEd99CHml01arIIhvOOshOiqYQy690SdSObKMd5fMWUzpglYyT
	 HXP9EMwe/+B152PNMc0wjHKiLw4X2booTuAR4atubuefD6XCywZGBzmi8HUH3n3VDq
	 Jx3GxogXNw+Yk/z428+JVMPX+nDMXcSLf78cFVyF8v1DijrSKxXYN3MCfqYD259Spu
	 jWxUTpg6DvaSgFBN6yRndX3mrFBaORPwW42+7z/Xp5Hxh2C1ESZUz+pYxzaJf0K+XR
	 VYqDX9UhrgThQ==
Date: Fri, 26 Apr 2024 00:10:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Florent Revest <revest@chromium.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v9 00/36] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240426001025.7bdaa1ae66cfda111b1bfe71@kernel.org>
In-Reply-To: <CABRcYmK7CpV5zZiPXubcp_XrxR_c7Lm11gAfpCw_Q5oezX6q_Q@mail.gmail.com>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
	<CABRcYmK7CpV5zZiPXubcp_XrxR_c7Lm11gAfpCw_Q5oezX6q_Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 24 Apr 2024 15:35:15 +0200
Florent Revest <revest@chromium.org> wrote:

> Neat! :) I had a look at mostly the "high level" part (fprobe and
> arm64 specific bits) and this seems to be in a good state to me.
> 

Thanks for the review this long series!

> Thanks for all that work, that is quite a refactoring :)
> 
> On Mon, Apr 15, 2024 at 2:49 PM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > Hi,
> >
> > Here is the 9th version of the series to re-implement the fprobe on
> > function-graph tracer. The previous version is;
> >
> > https://lore.kernel.org/all/170887410337.564249.6360118840946697039.stgit@devnote2/
> >
> > This version is ported on the latest kernel (v6.9-rc3 + probes/for-next)
> > and fixed some bugs + performance optimization patch[36/36].
> >  - [12/36] Fix to clear fgraph_array entry in registration failure, also
> >            return -ENOSPC when fgraph_array is full.
> >  - [28/36] Add new store_fprobe_entry_data() for fprobe.
> >  - [31/36] Remove DIV_ROUND_UP() and fix entry data address calculation.
> >  - [36/36] Add new flag to skip timestamp recording.
> >
> > Overview
> > --------
> > This series does major 2 changes, enable multiple function-graphs on
> > the ftrace (e.g. allow function-graph on sub instances) and rewrite the
> > fprobe on this function-graph.
> >
> > The former changes had been sent from Steven Rostedt 4 years ago (*),
> > which allows users to set different setting function-graph tracer (and
> > other tracers based on function-graph) in each trace-instances at the
> > same time.
> >
> > (*) https://lore.kernel.org/all/20190525031633.811342628@goodmis.org/
> >
> > The purpose of latter change are;
> >
> >  1) Remove dependency of the rethook from fprobe so that we can reduce
> >    the return hook code and shadow stack.
> >
> >  2) Make 'ftrace_regs' the common trace interface for the function
> >    boundary.
> >
> > 1) Currently we have 2(or 3) different function return hook codes,
> >  the function-graph tracer and rethook (and legacy kretprobe).
> >  But since this  is redundant and needs double maintenance cost,
> >  I would like to unify those. From the user's viewpoint, function-
> >  graph tracer is very useful to grasp the execution path. For this
> >  purpose, it is hard to use the rethook in the function-graph
> >  tracer, but the opposite is possible. (Strictly speaking, kretprobe
> >  can not use it because it requires 'pt_regs' for historical reasons.)
> >
> > 2) Now the fprobe provides the 'pt_regs' for its handler, but that is
> >  wrong for the function entry and exit. Moreover, depending on the
> >  architecture, there is no way to accurately reproduce 'pt_regs'
> >  outside of interrupt or exception handlers. This means fprobe should
> >  not use 'pt_regs' because it does not use such exceptions.
> >  (Conversely, kprobe should use 'pt_regs' because it is an abstract
> >   interface of the software breakpoint exception.)
> >
> > This series changes fprobe to use function-graph tracer for tracing
> > function entry and exit, instead of mixture of ftrace and rethook.
> > Unlike the rethook which is a per-task list of system-wide allocated
> > nodes, the function graph's ret_stack is a per-task shadow stack.
> > Thus it does not need to set 'nr_maxactive' (which is the number of
> > pre-allocated nodes).
> > Also the handlers will get the 'ftrace_regs' instead of 'pt_regs'.
> > Since eBPF mulit_kprobe/multi_kretprobe events still use 'pt_regs' as
> > their register interface, this changes it to convert 'ftrace_regs' to
> > 'pt_regs'. Of course this conversion makes an incomplete 'pt_regs',
> > so users must access only registers for function parameters or
> > return value.
> >
> > Design
> > ------
> > Instead of using ftrace's function entry hook directly, the new fprobe
> > is built on top of the function-graph's entry and return callbacks
> > with 'ftrace_regs'.
> >
> > Since the fprobe requires access to 'ftrace_regs', the architecture
> > must support CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS and
> > CONFIG_HAVE_FTRACE_GRAPH_FUNC, which enables to call function-graph
> > entry callback with 'ftrace_regs', and also
> > CONFIG_HAVE_FUNCTION_GRAPH_FREGS, which passes the ftrace_regs to
> > return_to_handler.
> >
> > All fprobes share a single function-graph ops (means shares a common
> > ftrace filter) similar to the kprobe-on-ftrace. This needs another
> > layer to find corresponding fprobe in the common function-graph
> > callbacks, but has much better scalability, since the number of
> > registered function-graph ops is limited.
> >
> > In the entry callback, the fprobe runs its entry_handler and saves the
> > address of 'fprobe' on the function-graph's shadow stack as data. The
> > return callback decodes the data to get the 'fprobe' address, and runs
> > the exit_handler.
> >
> > The fprobe introduces two hash-tables, one is for entry callback which
> > searches fprobes related to the given function address passed by entry
> > callback. The other is for a return callback which checks if the given
> > 'fprobe' data structure pointer is still valid. Note that it is
> > possible to unregister fprobe before the return callback runs. Thus
> > the address validation must be done before using it in the return
> > callback.
> >
> > This series can be applied against the probes/for-next branch, which
> > is based on v6.9-rc3.
> >
> > This series can also be found below branch.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph
> >
> > Thank you,
> >
> > ---
> >
> > Masami Hiramatsu (Google) (21):
> >       tracing: Add a comment about ftrace_regs definition
> >       tracing: Rename ftrace_regs_return_value to ftrace_regs_get_return_value
> >       x86: tracing: Add ftrace_regs definition in the header
> >       function_graph: Use a simple LRU for fgraph_array index number
> >       ftrace: Add multiple fgraph storage selftest
> >       function_graph: Pass ftrace_regs to entryfunc
> >       function_graph: Replace fgraph_ret_regs with ftrace_regs
> >       function_graph: Pass ftrace_regs to retfunc
> >       fprobe: Use ftrace_regs in fprobe entry handler
> >       fprobe: Use ftrace_regs in fprobe exit handler
> >       tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
> >       tracing: Add ftrace_fill_perf_regs() for perf event
> >       tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> >       bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
> >       ftrace: Add CONFIG_HAVE_FTRACE_GRAPH_FUNC
> >       fprobe: Rewrite fprobe on function-graph tracer
> >       tracing/fprobe: Remove nr_maxactive from fprobe
> >       selftests: ftrace: Remove obsolate maxactive syntax check
> >       selftests/ftrace: Add a test case for repeating register/unregister fprobe
> >       Documentation: probes: Update fprobe on function-graph tracer
> >       fgraph: Skip recording calltime/rettime if it is not nneeded
> >
> > Steven Rostedt (VMware) (15):
> >       function_graph: Convert ret_stack to a series of longs
> >       fgraph: Use BUILD_BUG_ON() to make sure we have structures divisible by long
> >       function_graph: Add an array structure that will allow multiple callbacks
> >       function_graph: Allow multiple users to attach to function graph
> >       function_graph: Remove logic around ftrace_graph_entry and return
> >       ftrace/function_graph: Pass fgraph_ops to function graph callbacks
> >       ftrace: Allow function_graph tracer to be enabled in instances
> >       ftrace: Allow ftrace startup flags exist without dynamic ftrace
> >       function_graph: Have the instances use their own ftrace_ops for filtering
> >       function_graph: Add "task variables" per task for fgraph_ops
> >       function_graph: Move set_graph_function tests to shadow stack global var
> >       function_graph: Move graph depth stored data to shadow stack global var
> >       function_graph: Move graph notrace bit to shadow stack global var
> >       function_graph: Implement fgraph_reserve_data() and fgraph_retrieve_data()
> >       function_graph: Add selftest for passing local variables
> >
> >
> >  Documentation/trace/fprobe.rst                     |   42 +
> >  arch/arm64/Kconfig                                 |    3
> >  arch/arm64/include/asm/ftrace.h                    |   47 +
> >  arch/arm64/kernel/asm-offsets.c                    |   12
> >  arch/arm64/kernel/entry-ftrace.S                   |   32 -
> >  arch/arm64/kernel/ftrace.c                         |   21
> >  arch/loongarch/Kconfig                             |    4
> >  arch/loongarch/include/asm/ftrace.h                |   32 -
> >  arch/loongarch/kernel/asm-offsets.c                |   12
> >  arch/loongarch/kernel/ftrace_dyn.c                 |   15
> >  arch/loongarch/kernel/mcount.S                     |   17
> >  arch/loongarch/kernel/mcount_dyn.S                 |   14
> >  arch/powerpc/Kconfig                               |    1
> >  arch/powerpc/include/asm/ftrace.h                  |   15
> >  arch/powerpc/kernel/trace/ftrace.c                 |    3
> >  arch/powerpc/kernel/trace/ftrace_64_pg.c           |   10
> >  arch/riscv/Kconfig                                 |    3
> >  arch/riscv/include/asm/ftrace.h                    |   21
> >  arch/riscv/kernel/ftrace.c                         |   15
> >  arch/riscv/kernel/mcount.S                         |   24
> >  arch/s390/Kconfig                                  |    3
> >  arch/s390/include/asm/ftrace.h                     |   39 -
> >  arch/s390/kernel/asm-offsets.c                     |    6
> >  arch/s390/kernel/mcount.S                          |    9
> >  arch/x86/Kconfig                                   |    4
> >  arch/x86/include/asm/ftrace.h                      |   43 -
> >  arch/x86/kernel/ftrace.c                           |   51 +
> >  arch/x86/kernel/ftrace_32.S                        |   15
> >  arch/x86/kernel/ftrace_64.S                        |   17
> >  include/linux/fprobe.h                             |   57 +
> >  include/linux/ftrace.h                             |  170 +++
> >  include/linux/sched.h                              |    2
> >  include/linux/trace_recursion.h                    |   39 -
> >  kernel/trace/Kconfig                               |   23
> >  kernel/trace/bpf_trace.c                           |   14
> >  kernel/trace/fgraph.c                              | 1005 ++++++++++++++++----
> >  kernel/trace/fprobe.c                              |  637 +++++++++----
> >  kernel/trace/ftrace.c                              |   13
> >  kernel/trace/ftrace_internal.h                     |    2
> >  kernel/trace/trace.h                               |   96 ++
> >  kernel/trace/trace_fprobe.c                        |  147 ++-
> >  kernel/trace/trace_functions.c                     |    8
> >  kernel/trace/trace_functions_graph.c               |   98 +-
> >  kernel/trace/trace_irqsoff.c                       |   12
> >  kernel/trace/trace_probe_tmpl.h                    |    2
> >  kernel/trace/trace_sched_wakeup.c                  |   12
> >  kernel/trace/trace_selftest.c                      |  262 +++++
> >  lib/test_fprobe.c                                  |   51 -
> >  samples/fprobe/fprobe_example.c                    |    4
> >  .../test.d/dynevent/add_remove_fprobe_repeat.tc    |   19
> >  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4
> >  51 files changed, 2325 insertions(+), 882 deletions(-)
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

