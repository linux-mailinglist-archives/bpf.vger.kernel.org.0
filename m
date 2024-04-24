Return-Path: <bpf+bounces-27681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C638B0B38
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998F4B24F17
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826FE15E1E2;
	Wed, 24 Apr 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NTSVptL2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD815D5AB
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965729; cv=none; b=AkEGpvHLUieZGNlH6qiUrYi/yzbg3na1yZnO4rzO5A8sWFmDrAIbuUOMNPmGEOpr4pmkrRsYTxs0FxT7FRWnuC0QXy4Tcl57cZHEWQnNjL04hEMnGWz0nCzunZZPqwh9d5nhYHFLUVCl9tXPyDShG4Dr1vgpDA7Y7+OnHk4J410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965729; c=relaxed/simple;
	bh=BFSUVh+swVaCh+yQoFXdKyP6+9vCuZ4UByaRG3ZzDq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIZWrSlYbu1ERBK+y/KEE7ZkYUvPRnLkYPhMKk0ed0ZKJqhT6h61GSPrKeXcz5fD/GywAU5jGMQEYYkFeYj/yIu7l4qYgavAXfgRe0aD6RwArgQT+rAcD3NJ9PccgmKevPDXBXbbS6TD41/MM6aUrXkffsd1gsmUPje46+x7TUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NTSVptL2; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so4596915a12.2
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713965727; x=1714570527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQwNferAU+vF9ZEsxhjyPKGeJnXxAP0wD8HRovo0HZM=;
        b=NTSVptL2XwXlQwanOkgP8gT2mSFV8VqBf6ampvQMTXz+cncriickHmwFU1dlyXG/3q
         Y9Lv+1a7DfDmGY3N7Mac5bfiwZK1hrm2JlKBx0dk2I+i4I892PlBwcFLxHa+ZJAebwtN
         HiUeF/a7AVC7cuV24qURwVDOkBuvxD6cRicfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713965727; x=1714570527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQwNferAU+vF9ZEsxhjyPKGeJnXxAP0wD8HRovo0HZM=;
        b=AoyR5zjT/YWOF+77wc61tP3eX/wW08V32qiMBz9UaDGhn5J45d4ONg4RJ1VI+3HzGf
         8muw0tcB4IagXwyZNjNJ8wt7P88dAMOkxDh0+CTUWOSyyP/FBSlK0N0Vro2uufTrDVW+
         QdR62mu/yOEVXYnbYGj85Wl1SYw4qbwtZLzIwwXs7vDv+jSGyvuNJSzKrQti4+rg8Vo6
         COXOZ6CLrZiYeMN+P4jYsTctstMgna+inw9g3PUaFgKqmET7QEmAu7QeoeESsq5Ufq3N
         CGc1atyUPygMlAeXj/t0zY8pfyMa3s/FMF0W4sRB+ahuLkWwIP1g0hegAfvbeczy+WG+
         qR0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDmWw91Cgo6BybkUCeY/rpJJdLTFufqvFSjde0G4oNZGtD6zcsvXwBfEOfF3XG4psLx5aTN9fYZJWcWSL1HLN8PljK
X-Gm-Message-State: AOJu0YwkXgy4TL/fmwViSzMxSdxtjhxFnSbkOGhkYGwJfwvKHW8r5efN
	xLT1rvTOn6KyRdKOJFKOou2oVdUtJ3kwSsmyHfGITLwWC/Wy5pKGCwlT6VSlfB14L8yC98rIoFK
	plovE75O3oybEvp9ZK2vOLK3QszJ+JNNDIAZY
X-Google-Smtp-Source: AGHT+IGDzvt2n+Xr7Y2oUML7fNGPI2F5TgPmkJl1JgUENgNg28eJUcGGACdylszeJPWM5+gKfT1uMV+S/yU/UZdEY44=
X-Received: by 2002:a17:90b:4398:b0:2a2:8ed7:da34 with SMTP id
 in24-20020a17090b439800b002a28ed7da34mr2060178pjb.1.1713965726632; Wed, 24
 Apr 2024 06:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
In-Reply-To: <171318533841.254850.15841395205784342850.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Wed, 24 Apr 2024 15:35:15 +0200
Message-ID: <CABRcYmK7CpV5zZiPXubcp_XrxR_c7Lm11gAfpCw_Q5oezX6q_Q@mail.gmail.com>
Subject: Re: [PATCH v9 00/36] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Neat! :) I had a look at mostly the "high level" part (fprobe and
arm64 specific bits) and this seems to be in a good state to me.

Thanks for all that work, that is quite a refactoring :)

On Mon, Apr 15, 2024 at 2:49=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> Hi,
>
> Here is the 9th version of the series to re-implement the fprobe on
> function-graph tracer. The previous version is;
>
> https://lore.kernel.org/all/170887410337.564249.6360118840946697039.stgit=
@devnote2/
>
> This version is ported on the latest kernel (v6.9-rc3 + probes/for-next)
> and fixed some bugs + performance optimization patch[36/36].
>  - [12/36] Fix to clear fgraph_array entry in registration failure, also
>            return -ENOSPC when fgraph_array is full.
>  - [28/36] Add new store_fprobe_entry_data() for fprobe.
>  - [31/36] Remove DIV_ROUND_UP() and fix entry data address calculation.
>  - [36/36] Add new flag to skip timestamp recording.
>
> Overview
> --------
> This series does major 2 changes, enable multiple function-graphs on
> the ftrace (e.g. allow function-graph on sub instances) and rewrite the
> fprobe on this function-graph.
>
> The former changes had been sent from Steven Rostedt 4 years ago (*),
> which allows users to set different setting function-graph tracer (and
> other tracers based on function-graph) in each trace-instances at the
> same time.
>
> (*) https://lore.kernel.org/all/20190525031633.811342628@goodmis.org/
>
> The purpose of latter change are;
>
>  1) Remove dependency of the rethook from fprobe so that we can reduce
>    the return hook code and shadow stack.
>
>  2) Make 'ftrace_regs' the common trace interface for the function
>    boundary.
>
> 1) Currently we have 2(or 3) different function return hook codes,
>  the function-graph tracer and rethook (and legacy kretprobe).
>  But since this  is redundant and needs double maintenance cost,
>  I would like to unify those. From the user's viewpoint, function-
>  graph tracer is very useful to grasp the execution path. For this
>  purpose, it is hard to use the rethook in the function-graph
>  tracer, but the opposite is possible. (Strictly speaking, kretprobe
>  can not use it because it requires 'pt_regs' for historical reasons.)
>
> 2) Now the fprobe provides the 'pt_regs' for its handler, but that is
>  wrong for the function entry and exit. Moreover, depending on the
>  architecture, there is no way to accurately reproduce 'pt_regs'
>  outside of interrupt or exception handlers. This means fprobe should
>  not use 'pt_regs' because it does not use such exceptions.
>  (Conversely, kprobe should use 'pt_regs' because it is an abstract
>   interface of the software breakpoint exception.)
>
> This series changes fprobe to use function-graph tracer for tracing
> function entry and exit, instead of mixture of ftrace and rethook.
> Unlike the rethook which is a per-task list of system-wide allocated
> nodes, the function graph's ret_stack is a per-task shadow stack.
> Thus it does not need to set 'nr_maxactive' (which is the number of
> pre-allocated nodes).
> Also the handlers will get the 'ftrace_regs' instead of 'pt_regs'.
> Since eBPF mulit_kprobe/multi_kretprobe events still use 'pt_regs' as
> their register interface, this changes it to convert 'ftrace_regs' to
> 'pt_regs'. Of course this conversion makes an incomplete 'pt_regs',
> so users must access only registers for function parameters or
> return value.
>
> Design
> ------
> Instead of using ftrace's function entry hook directly, the new fprobe
> is built on top of the function-graph's entry and return callbacks
> with 'ftrace_regs'.
>
> Since the fprobe requires access to 'ftrace_regs', the architecture
> must support CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS and
> CONFIG_HAVE_FTRACE_GRAPH_FUNC, which enables to call function-graph
> entry callback with 'ftrace_regs', and also
> CONFIG_HAVE_FUNCTION_GRAPH_FREGS, which passes the ftrace_regs to
> return_to_handler.
>
> All fprobes share a single function-graph ops (means shares a common
> ftrace filter) similar to the kprobe-on-ftrace. This needs another
> layer to find corresponding fprobe in the common function-graph
> callbacks, but has much better scalability, since the number of
> registered function-graph ops is limited.
>
> In the entry callback, the fprobe runs its entry_handler and saves the
> address of 'fprobe' on the function-graph's shadow stack as data. The
> return callback decodes the data to get the 'fprobe' address, and runs
> the exit_handler.
>
> The fprobe introduces two hash-tables, one is for entry callback which
> searches fprobes related to the given function address passed by entry
> callback. The other is for a return callback which checks if the given
> 'fprobe' data structure pointer is still valid. Note that it is
> possible to unregister fprobe before the return callback runs. Thus
> the address validation must be done before using it in the return
> callback.
>
> This series can be applied against the probes/for-next branch, which
> is based on v6.9-rc3.
>
> This series can also be found below branch.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=
=3Dtopic/fprobe-on-fgraph
>
> Thank you,
>
> ---
>
> Masami Hiramatsu (Google) (21):
>       tracing: Add a comment about ftrace_regs definition
>       tracing: Rename ftrace_regs_return_value to ftrace_regs_get_return_=
value
>       x86: tracing: Add ftrace_regs definition in the header
>       function_graph: Use a simple LRU for fgraph_array index number
>       ftrace: Add multiple fgraph storage selftest
>       function_graph: Pass ftrace_regs to entryfunc
>       function_graph: Replace fgraph_ret_regs with ftrace_regs
>       function_graph: Pass ftrace_regs to retfunc
>       fprobe: Use ftrace_regs in fprobe entry handler
>       fprobe: Use ftrace_regs in fprobe exit handler
>       tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt=
_regs
>       tracing: Add ftrace_fill_perf_regs() for perf event
>       tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WIT=
H_ARGS
>       bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
>       ftrace: Add CONFIG_HAVE_FTRACE_GRAPH_FUNC
>       fprobe: Rewrite fprobe on function-graph tracer
>       tracing/fprobe: Remove nr_maxactive from fprobe
>       selftests: ftrace: Remove obsolate maxactive syntax check
>       selftests/ftrace: Add a test case for repeating register/unregister=
 fprobe
>       Documentation: probes: Update fprobe on function-graph tracer
>       fgraph: Skip recording calltime/rettime if it is not nneeded
>
> Steven Rostedt (VMware) (15):
>       function_graph: Convert ret_stack to a series of longs
>       fgraph: Use BUILD_BUG_ON() to make sure we have structures divisibl=
e by long
>       function_graph: Add an array structure that will allow multiple cal=
lbacks
>       function_graph: Allow multiple users to attach to function graph
>       function_graph: Remove logic around ftrace_graph_entry and return
>       ftrace/function_graph: Pass fgraph_ops to function graph callbacks
>       ftrace: Allow function_graph tracer to be enabled in instances
>       ftrace: Allow ftrace startup flags exist without dynamic ftrace
>       function_graph: Have the instances use their own ftrace_ops for fil=
tering
>       function_graph: Add "task variables" per task for fgraph_ops
>       function_graph: Move set_graph_function tests to shadow stack globa=
l var
>       function_graph: Move graph depth stored data to shadow stack global=
 var
>       function_graph: Move graph notrace bit to shadow stack global var
>       function_graph: Implement fgraph_reserve_data() and fgraph_retrieve=
_data()
>       function_graph: Add selftest for passing local variables
>
>
>  Documentation/trace/fprobe.rst                     |   42 +
>  arch/arm64/Kconfig                                 |    3
>  arch/arm64/include/asm/ftrace.h                    |   47 +
>  arch/arm64/kernel/asm-offsets.c                    |   12
>  arch/arm64/kernel/entry-ftrace.S                   |   32 -
>  arch/arm64/kernel/ftrace.c                         |   21
>  arch/loongarch/Kconfig                             |    4
>  arch/loongarch/include/asm/ftrace.h                |   32 -
>  arch/loongarch/kernel/asm-offsets.c                |   12
>  arch/loongarch/kernel/ftrace_dyn.c                 |   15
>  arch/loongarch/kernel/mcount.S                     |   17
>  arch/loongarch/kernel/mcount_dyn.S                 |   14
>  arch/powerpc/Kconfig                               |    1
>  arch/powerpc/include/asm/ftrace.h                  |   15
>  arch/powerpc/kernel/trace/ftrace.c                 |    3
>  arch/powerpc/kernel/trace/ftrace_64_pg.c           |   10
>  arch/riscv/Kconfig                                 |    3
>  arch/riscv/include/asm/ftrace.h                    |   21
>  arch/riscv/kernel/ftrace.c                         |   15
>  arch/riscv/kernel/mcount.S                         |   24
>  arch/s390/Kconfig                                  |    3
>  arch/s390/include/asm/ftrace.h                     |   39 -
>  arch/s390/kernel/asm-offsets.c                     |    6
>  arch/s390/kernel/mcount.S                          |    9
>  arch/x86/Kconfig                                   |    4
>  arch/x86/include/asm/ftrace.h                      |   43 -
>  arch/x86/kernel/ftrace.c                           |   51 +
>  arch/x86/kernel/ftrace_32.S                        |   15
>  arch/x86/kernel/ftrace_64.S                        |   17
>  include/linux/fprobe.h                             |   57 +
>  include/linux/ftrace.h                             |  170 +++
>  include/linux/sched.h                              |    2
>  include/linux/trace_recursion.h                    |   39 -
>  kernel/trace/Kconfig                               |   23
>  kernel/trace/bpf_trace.c                           |   14
>  kernel/trace/fgraph.c                              | 1005 ++++++++++++++=
++----
>  kernel/trace/fprobe.c                              |  637 +++++++++----
>  kernel/trace/ftrace.c                              |   13
>  kernel/trace/ftrace_internal.h                     |    2
>  kernel/trace/trace.h                               |   96 ++
>  kernel/trace/trace_fprobe.c                        |  147 ++-
>  kernel/trace/trace_functions.c                     |    8
>  kernel/trace/trace_functions_graph.c               |   98 +-
>  kernel/trace/trace_irqsoff.c                       |   12
>  kernel/trace/trace_probe_tmpl.h                    |    2
>  kernel/trace/trace_sched_wakeup.c                  |   12
>  kernel/trace/trace_selftest.c                      |  262 +++++
>  lib/test_fprobe.c                                  |   51 -
>  samples/fprobe/fprobe_example.c                    |    4
>  .../test.d/dynevent/add_remove_fprobe_repeat.tc    |   19
>  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4
>  51 files changed, 2325 insertions(+), 882 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_re=
move_fprobe_repeat.tc
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

