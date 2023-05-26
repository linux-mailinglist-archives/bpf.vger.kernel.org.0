Return-Path: <bpf+bounces-1268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DF7711EBA
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 06:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8F71C20F4C
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 04:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C632116;
	Fri, 26 May 2023 04:17:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE41C26
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 04:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAAFC433D2;
	Fri, 26 May 2023 04:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685074671;
	bh=8JGNVNj1EZHAjY1/R8ICZ76vyLFmaEpzZTmWDtrVlC0=;
	h=From:To:Cc:Subject:Date:From;
	b=oPN5PdenUgoVwo6zExqG8iPaAKMZT+MKDH/hXA7xgRWUIR4rZ0iOziM0p9TzbR2Sx
	 E8mWBsliNDtAjxDjstOGjvRAYicdWIUkJ5qjQyh9AArXjO0yO52w7rXHOmeoyI4aat
	 R9vEUMYek12wM/M1cL+WTkmiTebRJRxEu2mbE4R5ve/e3wKRgLe9UjWOWISPFQYymn
	 bO8ZMz56lXZHP4Cs0KqWKxbwBOyCnbSSQczlSa0QBOiCGkgu4C45lJKl3TR0p6l6wO
	 /wzMkH2NiH0O1gZUVqinY+ZgWM6Pi6awBcHCSb4umWshMQZXga5OhvhT+dkDxB0zfD
	 ydotz3qn8AHJQ==
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
Subject: [PATCH v13 00/12] tracing: Add fprobe/tracepoint events
Date: Fri, 26 May 2023 12:17:46 +0800
Message-ID:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
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

Here is the 13th version of add a basic fprobe event support for
ftrace (tracefs) and perf. Here is the previous version.

https://lore.kernel.org/all/168438749373.1517340.14083401972478496211.stgit@mhiramat.roam.corp.google.com/

This version fixes some minor issues in the previous version.
I found that TPARG_FL_FPROBE was not set and TPARG_FL_FENTRY and
TPARG_FL_RETURN were not mutually exclusive, so fix it in [2/12] (new patch)
and [3/12].
I also fixed the fprobe-event selftest because it didn't found the syntax
error that fprobe-event shouldn't access %reg [4/12].
For the BTF var name feature, there is a bug that the BTF var name is used
with fetch_type (e.g. varname:u8), it failed to apply the BTF var name as
the event argument name. So fixed that in [7/12]. In [8/12], if user specified
only '$argN' the kernel crashed, and if BTF is not there, it returned an error.
So I fixed both bugs. [8/12] also had another bug that it convert $argN to
$argN+1, that is also fixed.

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

Masami Hiramatsu (Google) (12):
      fprobe: Pass return address to the handlers
      tracing/probes: Avoid setting TPARG_FL_FENTRY and TPARG_FL_RETURN
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
 kernel/trace/trace_fprobe.c                        | 1199 ++++++++++++++++++++
 kernel/trace/trace_kprobe.c                        |   35 -
 kernel/trace/trace_probe.c                         |  652 +++++++++--
 kernel/trace/trace_probe.h                         |   49 +
 kernel/trace/trace_uprobe.c                        |    8 
 lib/test_fprobe.c                                  |   10 
 samples/fprobe/fprobe_example.c                    |    6 
 .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   58 +
 .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |   26 
 .../ftrace/test.d/dynevent/add_remove_tprobe.tc    |   27 
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |  111 ++
 .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |   82 +
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   16 
 30 files changed, 2450 insertions(+), 164 deletions(-)
 create mode 100644 Documentation/trace/fprobetrace.rst
 create mode 100644 kernel/trace/trace_fprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

