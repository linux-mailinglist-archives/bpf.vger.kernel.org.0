Return-Path: <bpf+bounces-1280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354FB711ECF
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 06:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87EB1C20F5F
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 04:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67072116;
	Fri, 26 May 2023 04:20:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072D210C
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 04:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07735C433D2;
	Fri, 26 May 2023 04:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685074798;
	bh=8MRjZRiswdJA7BkVmwwwg6IT4p9+fB1e3FMsiIY4h0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PTHaUTstR/AtgyMdNL8aU2w0sl3hScvUdG4IKk5VBKuYEeltmo4uEUt+198sqqxNG
	 a1hPFH0YMPjUUpfRSMIjcF4br7nAT/sZgOqJBrIWt8QcGODGG/oFtAAm5rsTi3K9Bc
	 aHLSNCqHKxUbffO/uGA0RwLNZNqjzuOp2iI9IMmtcJAFO+lCOduzIQVA9Skrc17jwF
	 qlZeIxERwcdJ7eBgsFJMNW8qgqbpbm+9Oo9FfNgRdLkSr6cyj8VwbeLHuBE/0hV6az
	 pkn1OuP0EY9MTZKM8I+dObJzrp+FMNHzwbqtzaVEqK0t4lB3B38Yh6QAF1ErTQ78Kd
	 JCUpW9dV8RkyQ==
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
Subject: [PATCH v13 12/12] Documentation: tracing/probes: Add fprobe event tracing document
Date: Fri, 26 May 2023 12:19:53 +0800
Message-ID:  <168507479345.913472.2804569685436422001.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
References:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a documentation about fprobe event tracing including
tracepoint probe event and BTF argument.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes in v12:
 - Use double backquotes for keywords and identifiers.
 - Use the ref link instead of file.
Changes in v11:
 - Fix $$args to $arg*.
 - Update the document.
Changes in v10:
 - Fix space before tab.
Changes in v7:
 - Update about BTF auto type casting for $retval.
---
 Documentation/trace/fprobetrace.rst |  188 +++++++++++++++++++++++++++++++++++
 Documentation/trace/index.rst       |    1 
 Documentation/trace/kprobetrace.rst |    2 
 3 files changed, 191 insertions(+)
 create mode 100644 Documentation/trace/fprobetrace.rst

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
new file mode 100644
index 000000000000..e949bc0cff05
--- /dev/null
+++ b/Documentation/trace/fprobetrace.rst
@@ -0,0 +1,188 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Fprobe-based Event Tracing
+==========================
+
+.. Author: Masami Hiramatsu <mhiramat@kernel.org>
+
+Overview
+--------
+
+Fprobe event is similar to the kprobe event, but limited to probe on
+the function entry and exit only. It is good enough for many use cases
+which only traces some specific functions.
+
+This document also covers tracepoint probe events (tprobe) since this
+is also works only on the tracepoint entry. User can trace a part of
+tracepoint argument, or the tracepoint without trace-event, which is
+not exposed on tracefs.
+
+As same as other dynamic events, fprobe events and tracepoint probe
+events are defined via `dynamic_events` interface file on tracefs.
+
+Synopsis of fprobe-events
+-------------------------
+::
+
+  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]                       : Probe on function entry
+  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]     : Probe on function exit
+  t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]                : Probe on tracepoint
+
+ GRP1           : Group name for fprobe. If omitted, use "fprobes" for it.
+ GRP2           : Group name for tprobe. If omitted, use "tracepoints" for it.
+ EVENT1         : Event name for fprobe. If omitted, the event name is
+                  "SYM__entry" or "SYM__exit".
+ EVENT2         : Event name for tprobe. If omitted, the event name is
+                  the same as "TRACEPOINT", but if the "TRACEPOINT" starts
+                  with a digit character, "_TRACEPOINT" is used.
+ MAXACTIVE      : Maximum number of instances of the specified function that
+                  can be probed simultaneously, or 0 for the default value
+                  as defined in Documentation/trace/fprobes.rst
+
+ FETCHARGS      : Arguments. Each probe can have up to 128 args.
+  ARG           : Fetch "ARG" function argument using BTF (only for function
+                  entry or tracepoint.) (\*1)
+  @ADDR         : Fetch memory at ADDR (ADDR should be in kernel)
+  @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)
+  $stackN       : Fetch Nth entry of stack (N >= 0)
+  $stack        : Fetch stack address.
+  $argN         : Fetch the Nth function argument. (N >= 1) (\*2)
+  $retval       : Fetch return value.(\*3)
+  $comm         : Fetch current task comm.
+  +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*4)(\*5)
+  \IMM          : Store an immediate value to the argument.
+  NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
+  FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
+                  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
+                  (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
+                  and bitfield are supported.
+
+  (\*1) This is available only when BTF is enabled.
+  (\*2) only for the probe on function entry (offs == 0).
+  (\*3) only for return probe.
+  (\*4) this is useful for fetching a field of data structures.
+  (\*5) "u" means user-space dereference.
+
+For the details of TYPE, see :ref:`kprobetrace documentation <kprobetrace_types>`.
+
+BTF arguments
+-------------
+BTF (BPF Type Format) argument allows user to trace function and tracepoint
+parameters by its name instead of ``$argN``. This feature is available if the
+kernel is configured with CONFIG_BPF_SYSCALL and CONFIG_DEBUG_INFO_BTF.
+If user only specify the BTF argument, the event's argument name is also
+automatically set by the given name. ::
+
+ # echo 'f:myprobe vfs_read count pos' >> dynamic_events
+ # cat dynamic_events
+ f:fprobes/myprobe vfs_read count=count pos=pos
+
+It also chooses the fetch type from BTF information. For example, in the above
+example, the ``count`` is unsigned long, and the ``pos`` is a pointer. Thus, both
+are converted to 64bit unsigned long, but only ``pos`` has "%Lx" print-format as
+below ::
+
+ # cat events/fprobes/myprobe/format
+ name: myprobe
+ ID: 1313
+ format:
+	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
+	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
+	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
+	field:int common_pid;	offset:4;	size:4;	signed:1;
+
+	field:unsigned long __probe_ip;	offset:8;	size:8;	signed:0;
+	field:u64 count;	offset:16;	size:8;	signed:0;
+	field:u64 pos;	offset:24;	size:8;	signed:0;
+
+ print fmt: "(%lx) count=%Lu pos=0x%Lx", REC->__probe_ip, REC->count, REC->pos
+
+If user unsures the name of arguments, ``$arg*`` will be helpful. The ``$arg*``
+is expanded to all function arguments of the function or the tracepoint. ::
+
+ # echo 'f:myprobe vfs_read $arg*' >> dynamic_events
+ # cat dynamic_events
+ f:fprobes/myprobe vfs_read file=file buf=buf count=count pos=pos
+
+BTF also affects the ``$retval``. If user doesn't set any type, the retval type is
+automatically picked from the BTF. If the function returns ``void``, ``$retval``
+is rejected.
+
+Usage examples
+--------------
+Here is an example to add fprobe events on ``vfs_read()`` function entry
+and exit, with BTF arguments.
+::
+
+  # echo 'f vfs_read $arg*' >> dynamic_events
+  # echo 'f vfs_read%return $retval' >> dynamic_events
+  # cat dynamic_events
+ f:fprobes/vfs_read__entry vfs_read file=file buf=buf count=count pos=pos
+ f:fprobes/vfs_read__exit vfs_read%return arg1=$retval
+  # echo 1 > events/fprobes/enable
+  # head -n 20 trace | tail
+ #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+ #              | |         |   |||||     |         |
+               sh-70      [000] ...1.   335.883195: vfs_read__entry: (vfs_read+0x4/0x340) file=0xffff888005cf9a80 buf=0x7ffef36c6879 count=1 pos=0xffffc900005aff08
+               sh-70      [000] .....   335.883208: vfs_read__exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=1
+               sh-70      [000] ...1.   335.883220: vfs_read__entry: (vfs_read+0x4/0x340) file=0xffff888005cf9a80 buf=0x7ffef36c6879 count=1 pos=0xffffc900005aff08
+               sh-70      [000] .....   335.883224: vfs_read__exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=1
+               sh-70      [000] ...1.   335.883232: vfs_read__entry: (vfs_read+0x4/0x340) file=0xffff888005cf9a80 buf=0x7ffef36c687a count=1 pos=0xffffc900005aff08
+               sh-70      [000] .....   335.883237: vfs_read__exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=1
+               sh-70      [000] ...1.   336.050329: vfs_read__entry: (vfs_read+0x4/0x340) file=0xffff888005cf9a80 buf=0x7ffef36c6879 count=1 pos=0xffffc900005aff08
+               sh-70      [000] .....   336.050343: vfs_read__exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=1
+
+You can see all function arguments and return values are recorded as signed int.
+
+Also, here is an example of tracepoint events on ``sched_switch`` tracepoint.
+To compare the result, this also enables the ``sched_switch`` traceevent too.
+::
+
+  # echo 't sched_switch $arg*' >> dynamic_events
+  # echo 1 > events/sched/sched_switch/enable
+  # echo 1 > events/tracepoints/sched_switch/enable
+  # echo > trace
+  # head -n 20 trace | tail
+ #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+ #              | |         |   |||||     |         |
+               sh-70      [000] d..2.  3912.083993: sched_switch: prev_comm=sh prev_pid=70 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
+               sh-70      [000] d..3.  3912.083995: sched_switch: (__probestub_sched_switch+0x4/0x10) preempt=0 prev=0xffff88800664e100 next=0xffffffff828229c0 prev_state=1
+           <idle>-0       [000] d..2.  3912.084183: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_preempt next_pid=16 next_prio=120
+           <idle>-0       [000] d..3.  3912.084184: sched_switch: (__probestub_sched_switch+0x4/0x10) preempt=0 prev=0xffffffff828229c0 next=0xffff888004208000 prev_state=0
+      rcu_preempt-16      [000] d..2.  3912.084196: sched_switch: prev_comm=rcu_preempt prev_pid=16 prev_prio=120 prev_state=I ==> next_comm=swapper/0 next_pid=0 next_prio=120
+      rcu_preempt-16      [000] d..3.  3912.084196: sched_switch: (__probestub_sched_switch+0x4/0x10) preempt=0 prev=0xffff888004208000 next=0xffffffff828229c0 prev_state=1026
+           <idle>-0       [000] d..2.  3912.085191: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_preempt next_pid=16 next_prio=120
+           <idle>-0       [000] d..3.  3912.085191: sched_switch: (__probestub_sched_switch+0x4/0x10) preempt=0 prev=0xffffffff828229c0 next=0xffff888004208000 prev_state=0
+
+As you can see, the ``sched_switch`` trace-event shows *cooked* parameters, on
+the other hand, the ``sched_switch`` tracepoint probe event shows *raw*
+parameters. This means you can access any field values in the task
+structure pointed by the ``prev`` and ``next`` arguments.
+
+For example, usually ``task_struct::start_time`` is not traced, but with this
+traceprobe event, you can trace it as below.
+::
+
+  # echo 't sched_switch comm=+1896(next):string start_time=+1728(next):u64' > dynamic_events
+  # head -n 20 trace | tail
+ #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+ #              | |         |   |||||     |         |
+               sh-70      [000] d..3.  5606.686577: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="rcu_preempt" usage=1 start_time=245000000
+      rcu_preempt-16      [000] d..3.  5606.686602: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="sh" usage=1 start_time=1596095526
+               sh-70      [000] d..3.  5606.686637: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="swapper/0" usage=2 start_time=0
+           <idle>-0       [000] d..3.  5606.687190: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="rcu_preempt" usage=1 start_time=245000000
+      rcu_preempt-16      [000] d..3.  5606.687202: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="swapper/0" usage=2 start_time=0
+           <idle>-0       [000] d..3.  5606.690317: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="kworker/0:1" usage=1 start_time=137000000
+      kworker/0:1-14      [000] d..3.  5606.690339: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="swapper/0" usage=2 start_time=0
+           <idle>-0       [000] d..3.  5606.692368: sched_switch: (__probestub_sched_switch+0x4/0x10) comm="kworker/0:1" usage=1 start_time=137000000
+
+Currently, to find the offset of a specific field in the data structure,
+you need to build kernel with debuginfo and run `perf probe` command with
+`-D` option. e.g.
+::
+
+ # perf probe -D "__probestub_sched_switch next->comm:string next->start_time"
+ p:probe/__probestub_sched_switch __probestub_sched_switch+0 comm=+1896(%cx):string start_time=+1728(%cx):u64
+
+And replace the ``%cx`` with the ``next``.
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index ea25a9220f92..5092d6c13af5 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -13,6 +13,7 @@ Linux Tracing Technologies
    kprobes
    kprobetrace
    uprobetracer
+   fprobetrace
    tracepoints
    events
    events-kmem
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 651f9ab53f3e..8a2dfee38145 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -66,6 +66,8 @@ Synopsis of kprobe_events
   (\*3) this is useful for fetching a field of data structures.
   (\*4) "u" means user-space dereference. See :ref:`user_mem_access`.
 
+.. _kprobetrace_types:
+
 Types
 -----
 Several types are supported for fetchargs. Kprobe tracer will access memory


