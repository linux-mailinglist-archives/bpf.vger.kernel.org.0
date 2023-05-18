Return-Path: <bpf+bounces-848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA95707986
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 07:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F56281107
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 05:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16771138C;
	Thu, 18 May 2023 05:25:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815DE649
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 05:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DF3C433D2;
	Thu, 18 May 2023 05:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684387498;
	bh=KnUDYWPkRoIVOsC2YPug++2HnnoiLtLdoUJ7TEZLpnM=;
	h=From:To:Cc:Subject:Date:From;
	b=LtTlM9I4sO6xJ7oYgkYJXEEYQKLs1KOKNt4KKBBnPeMdzPsRTamb6AJJo0CeZaHA/
	 hk5bjYm3mstGd6qLmh9kQBwZ3kr78zxkU1LH4g9QQ3264dFolVno9LoNHec6VIHWCu
	 IcOaGfwFIl3l7133r8Gi2tcXBPKQQLzgjnoZ45+5HN3C9kx67JWI8CvbTR9yLrHtoA
	 Pbfyjfm/cvhEvfraEJv8GBeK2h7ZIhJhbuuMC2wajB6jNLMEbmCB7RDo42A8QEHTn6
	 kuf1OtqaSSMPbmnT9CdaVQm1tMAbcbKkKsDHD9psslTVdHxjudxXKqbir9iac1qto/
	 N9LRNMo5fEQLg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	mhiramat@kernel.org,
	Florent Revest <revest@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v12 00/11] tracing: Add fprobe/tracepoint events
Date: Thu, 18 May 2023 14:24:53 +0900
Message-ID:  <168438749373.1517340.14083401972478496211.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
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

Here is the 12th version of add a basic fprobe event support for
ftrace (tracefs) and perf. Here is the previous version.

https://lore.kernel.org/all/168432112492.1351929.9265172785506392923.stgit@mhiramat.roam.corp.google.com/

There are minor fixes on the selftest [09/11] and the document [11/11].
(Thanks Bagas!)

You can also get this series from:

git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext

With this fprobe events, we can continue to trace function entry/exit
even if the CONFIG_KPROBES_ON_FTRACE is not available. Since
CONFIG_KPROBES_ON_FTRACE requires the CONFIG_DYNAMIC_FTRACE_WITH_REGS,
it is not available if the architecture only supports
CONFIG_DYNAMIC_FTRACE_WITH_ARGS (e.g. arm64). And that means kprobe
events can not probe function entry/exit effectively on such architecture.
But this problem can be solved if the dynamic events supports fprobe events
because fprobe events doesn't use kprobe but ftrace via fprobe.

FPROBE EVENTS
=============

Fprobe events allows user to add new events on the entry and exit of kernel
functions (which can be ftraced). Unlike kprobe events, the fprobe events
can only probe the function entry and exit, and it can only trace the
function args, return value, and stacks. (no registers)
For probing function body, users can continue to use the kprobe events.

The tracepoint probe events (tprobe events) also allows user to add new
events dynamically on the tracepoint. Most of the tracepoint already has
trace-events, so this feature is useful if you only want to know a
specific parameter, or trace the tracepoints which has no trace-events
(e.g. sched_*_tp tracepoints only exposes the tracepoints.)

The fprobe events syntax is;

 f[:[GRP/][EVENT]] FUNCTION [FETCHARGS]
 f[MAXACTIVE][:[GRP/][EVENT]] FUNCTION%return [FETCHARGS]

And tracepoint probe events syntax is;

 t[:[GRP/][EVENT]] TRACEPOINT [FETCHARGS]

This series includes BTF argument support for fprobe/tracepoint events,
and kprobe events. This allows us to fetch a specific function parameter
by name, and all parameters by '$arg*'.
Note that enabling this feature, you need to enable CONFIG_BPF_SYSCALL and
confirm that your arch supports CONFIG_HAVE_FUNCTION_ARG_ACCESS_API.

E.g.

 # echo 't kfree ptr' >> dynamic_events
 # echo 'f kfree object' >> dynamic_events
 # cat dynamic_events 
t:tracepoints/kfree kfree ptr=ptr
f:fprobes/kfree__entry kfree object=object
 # echo 1 > events/fprobes/enable
 # echo 1 > events/tracepoints/enable
 # echo > trace
 # head -n 20 trace | tail
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
            tail-84      [000] .....  1324.561958: kfree__entry: (kfree+0x4/0x140) object=0xffff888006383c00
            tail-84      [000] ...1.  1324.561961: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff888006383c00
            tail-84      [000] .....  1324.561988: kfree__entry: (kfree+0x4/0x140) object=0x0
            tail-84      [000] ...1.  1324.561988: kfree: (__probestub_kfree+0x4/0x10) ptr=0x0
            tail-84      [000] .....  1324.561989: kfree__entry: (kfree+0x4/0x140) object=0xffff88800671e600
            tail-84      [000] ...1.  1324.561989: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff88800671e600
            tail-84      [000] .....  1324.562368: kfree__entry: (kfree+0x4/0x140) object=0xffff8880065e0580
            tail-84      [000] ...1.  1324.562369: kfree: (__probestub_kfree+0x4/0x10) ptr=0xffff8880065e0580


Thank you,

---

Masami Hiramatsu (Google) (11):
      fprobe: Pass return address to the handlers
      tracing/probes: Add fprobe events for tracing function entry and exit.
      selftests/ftrace: Add fprobe related testcases
      tracing/probes: Add tracepoint support on fprobe_events
      tracing/probes: Move event parameter fetching code to common parser
      tracing/probes: Support function parameters if BTF is available
      tracing/probes: Add $arg* meta argument for all function args
      tracing/probes: Add BTF retval type support
      selftests/ftrace: Add tracepoint probe test case
      selftests/ftrace: Add BTF arguments test cases
      Documentation: tracing/probes: Add fprobe event tracing document


 Documentation/trace/fprobetrace.rst                |  188 +++
 Documentation/trace/index.rst                      |    1 
 Documentation/trace/kprobetrace.rst                |    2 
 include/linux/fprobe.h                             |   11 
 include/linux/rethook.h                            |    2 
 include/linux/trace_events.h                       |    3 
 include/linux/tracepoint-defs.h                    |    1 
 include/linux/tracepoint.h                         |    5 
 kernel/kprobes.c                                   |    1 
 kernel/trace/Kconfig                               |   26 
 kernel/trace/Makefile                              |    1 
 kernel/trace/bpf_trace.c                           |    6 
 kernel/trace/fprobe.c                              |   17 
 kernel/trace/rethook.c                             |    3 
 kernel/trace/trace.c                               |   13 
 kernel/trace/trace.h                               |   11 
 kernel/trace/trace_eprobe.c                        |   44 -
 kernel/trace/trace_fprobe.c                        | 1197 ++++++++++++++++++++
 kernel/trace/trace_kprobe.c                        |   33 -
 kernel/trace/trace_probe.c                         |  629 +++++++++--
 kernel/trace/trace_probe.h                         |   45 +
 kernel/trace/trace_uprobe.c                        |    8 
 lib/test_fprobe.c                                  |   10 
 samples/fprobe/fprobe_example.c                    |    6 
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   54 +
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   26 
 .../ftrace/test.d/dynevent/add_remove_tprobe.tc    |   27 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |  102 ++
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |   82 +
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   16 
 30 files changed, 2407 insertions(+), 163 deletions(-)
 create mode 100644 Documentation/trace/fprobetrace.rst
 create mode 100644 kernel/trace/trace_fprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

