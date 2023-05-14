Return-Path: <bpf+bounces-471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E0B701DB8
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 16:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54C928109E
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F8B63DA;
	Sun, 14 May 2023 14:11:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050B51876
	for <bpf@vger.kernel.org>; Sun, 14 May 2023 14:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF75C433EF;
	Sun, 14 May 2023 14:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684073468;
	bh=S2g4zli5bmxpb6OCGiYCH5oa3Dkwi0UkUif0ky6+Ekk=;
	h=From:To:Cc:Subject:Date:From;
	b=PQjed/1xBrotkpIQgWdvS2Ben3+renlQWJLX1OHeLTQjAWjlGR52xzYtIK0mD3ph0
	 FLYNj/NopO54+aK71EXnNVfVwN9bLSwEoBwphX1q2MYFS+BRcv5yxHxHCx+VGubnn3
	 4G8k6ai4BQhoWTZuKVL98QS+uSFUBWq/jbww/4JdZW8Ia0XPf6kCf2TF5k4j++UF08
	 +m32Gj/hHH5vaie4f16NwX2XG0Gruhsnty0LrSpb7YqftuBMyUMoazVeP8z3UhzgQ6
	 Edz5ZdZcY1bjOp7QWmp1X4OLz3DN9iv2rfRyzxzD1ZUcG1z4fFageezrM2BtGRRFLL
	 zpNDC4tPcHRkQ==
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
	bpf@vger.kernel.org
Subject: [PATCH v10 00/11] tracing: Add fprobe/tracepoint events
Date: Sun, 14 May 2023 23:11:04 +0900
Message-ID:  <168407346448.941486.15681419068846125595.stgit@mhiramat.roam.corp.google.com>
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

Here is the 10th version of add a basic fprobe event support for
ftrace (tracefs) and perf. Here is the previous version.

https://lore.kernel.org/all/168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com/

The major change is using '$args' instead of '$$args' [7/11].
This version also update description [1/11], cleanup code [2/11], fixes
some test cases[10/11] and document styles [11/11].

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
by name, and all parameters by '$args'.
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
      tracing/probes: Add $args meta argument for all function args
      tracing/probes: Add BTF retval type support
      selftests/ftrace: Add tracepoint probe test case
      selftests/ftrace: Add BTF arguments test cases
      Documentation: tracing/probes: Add fprobe event tracing document


 Documentation/trace/fprobetrace.rst                |  187 +++
 Documentation/trace/index.rst                      |    1 
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
 kernel/trace/trace_probe.c                         |  569 ++++++++--
 kernel/trace/trace_probe.h                         |   44 +
 kernel/trace/trace_uprobe.c                        |    8 
 lib/test_fprobe.c                                  |   10 
 samples/fprobe/fprobe_example.c                    |    6 
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   54 +
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   26 
 .../ftrace/test.d/dynevent/add_remove_tprobe.tc    |   27 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |  101 ++
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |   82 +
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   15 
 29 files changed, 2341 insertions(+), 163 deletions(-)
 create mode 100644 Documentation/trace/fprobetrace.rst
 create mode 100644 kernel/trace/trace_fprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

