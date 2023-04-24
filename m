Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA756ED097
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjDXOsn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 10:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjDXOsl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 10:48:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9CB93FF;
        Mon, 24 Apr 2023 07:48:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 290F6614E7;
        Mon, 24 Apr 2023 14:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DAEC433D2;
        Mon, 24 Apr 2023 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682347659;
        bh=WoAJh4fCUnisHNHTylp5LUzEMvv0f3TNiV0COGV/EU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZlLzAXF2mneLG2nStCH1y+tZn25HrKC5P+k5/SnCNq5nJ7f8u1W2sE0E1ToxGlO/b
         pECnrCW5T7D+T1x3a07dBP7Zj11RgIEurAtn5AgIYq0b+eMguu5pS7Q50UGHgrAH8G
         1CS22YRZKlXBEmlI3ARxtFXtWVDrfD6eEiwadnHBedTdZuIXL57DzJ7cIViRjvoJr/
         QLJvuhWU7+OpNmFCH2k0iqGAjXVOrp5h2jlYH2IQXk8xxCyafb4dEhN1LsyrnsEGVB
         hakXksV7GqMwuiHDaiFYWoEy2wwsoqolisx+4P8KZTWVeXqADJhUKVrxf9ROb0CzJT
         LnHAwnIWk6Beg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: [PATCH v6 10/10] Documentation: tracing/probes: Add fprobe event tracing document
Date:   Mon, 24 Apr 2023 23:47:35 +0900
Message-ID:  <168234765514.2210510.16707741720481149771.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To:  <168234755610.2210510.12133559313738141202.stgit@mhiramat.roam.corp.google.com>
References:  <168234755610.2210510.12133559313738141202.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a documentation about fprobe event tracing including
tracepoint probe event and BTF argument.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/fprobetrace.rst |  184 +++++++++++++++++++++++++++++++++++
 Documentation/trace/index.rst       |    1 
 2 files changed, 185 insertions(+)
 create mode 100644 Documentation/trace/fprobetrace.rst

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
new file mode 100644
index 000000000000..e3304d24078f
--- /dev/null
+++ b/Documentation/trace/fprobetrace.rst
@@ -0,0 +1,184 @@
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
+For the details of TYPE, see :file:`Documentation/trace/kprobetrace.rst`.
+
+BTF arguments
+-------------
+BTF (BPF Type Format) argument allows user to trace function and tracepoint
+parameters by its name instead of `$argN`. This feature is available if the
+kernel is configured with CONFIG_BPF_SYSCALL and CONFIG_DEBUG_INFO_BTF.
+If user only specify the BTF argument, the event's argument name is also
+automatically set by the given name. ::
+
+ # echo 'f:myprobe vfs_read count pos' >> dynamic_events
+ # cat dynamic_events
+ f:fprobes/myprobe vfs_read count=count pos=pos
+
+It also chooses the fetch type from BTF information. For example, in the above
+example, the `count` is unsigned long, and the `pos` is a pointer. Thus, both
+are converted to 64bit unsigned long, but only `pos` has `%Lx` print-format ::
+
+ # cat events/fprobes/myprobe/format
+ name: myprobe
+ ID: 1313
+ format:
+ 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
+ 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
+ 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
+ 	field:int common_pid;	offset:4;	size:4;	signed:1;
+
+ 	field:unsigned long __probe_ip;	offset:8;	size:8;	signed:0;
+ 	field:u64 count;	offset:16;	size:8;	signed:0;
+ 	field:u64 pos;	offset:24;	size:8;	signed:0;
+
+ print fmt: "(%lx) count=%Lu pos=0x%Lx", REC->__probe_ip, REC->count, REC->pos
+
+If user unsures the name of arguments, `$$args` will be helpful. The `$$args`
+is expanded to all function arguments of the function or the tracepoint. ::
+
+ # echo 'f:myprobe vfs_read $$args' >> dynamic_events
+ # cat dynamic_events
+ f:fprobes/myprobe vfs_read file=file buf=buf count=count pos=pos
+
+
+Usage examples
+--------------
+Here is an example to add fprobe events on `vfs_read()` function entry
+and exit, with BTF arguments.
+::
+
+  # echo 'f vfs_read $$args' >> dynamic_events
+  # echo 'f vfs_read%return $retval' >> dynamic_events
+  # cat dynamic_events
+ f:fprobes/vfs_read__entry vfs_read file=file buf=buf count=count pos=pos
+ f:fprobes/vfs_read__exit vfs_read%return arg1=$retval
+  # echo 1 > events/fprobes/enable
+  # head -n 20 trace | tail
+ #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+ #              | |         |   |||||     |         |
+               sh-70      [000] ...1.  3627.602898: vfs_read__entry: (vfs_read+0x4/0x340) file=0xffff888005cf9e00 buf=0x7ffe3c8bd429 count=1 pos=0xffffc900005aff08
+               sh-70      [000] .....  3627.602910: vfs_read__exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
+               sh-70      [000] ...1.  3627.727129: vfs_read__entry: (vfs_read+0x4/0x340) file=0xffff888005cf9e00 buf=0x7ffe3c8bd429 count=1 pos=0xffffc900005aff08
+               sh-70      [000] .....  3627.727175: vfs_read__exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
+               sh-70      [000] ...1.  3627.816332: vfs_read__entry: (vfs_read+0x4/0x340) file=0xffff888005cf9e00 buf=0x7ffe3c8bd429 count=1 pos=0xffffc900005aff08
+               sh-70      [000] .....  3627.816344: vfs_read__exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
+               sh-70      [000] ...1.  3627.976995: vfs_read__entry: (vfs_read+0x4/0x340) file=0xffff888005cf9e00 buf=0x7ffe3c8bd429 count=1 pos=0xffffc900005aff08
+               sh-70      [000] .....  3627.977009: vfs_read__exit: (ksys_read+0x75/0x100 <- vfs_read) arg1=0x1
+
+You can see all function arguments and return values are recorded.
+
+Also, here is tracepoint events on `sched_switch` tracepoint. To compare the
+result, this also enables the `sched_switch` traceevent too.
+::
+
+  # echo 't sched_switch $$args' >> dynamic_events
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
+As you can see, the `sched_switch` trace-event shows *cooked* parameters, on
+the other hand, the `sched_switch` tracepoint probe event shows *raw*
+parameters. This means you can dereference any field values in the task
+structure pointed by the `prev` and `next` arguments.
+
+For example, usually `task_struct::start_time` is not traced, but with this
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
+And replace the `%cx` with the `next`.
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

