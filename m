Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACFA31F243
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 23:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBRWXX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 17:23:23 -0500
Received: from mail.efficios.com ([167.114.26.124]:43956 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhBRWXE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Feb 2021 17:23:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C51FD29EE94;
        Thu, 18 Feb 2021 17:21:44 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ngh7VIrYHSQT; Thu, 18 Feb 2021 17:21:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2F69029EBE6;
        Thu, 18 Feb 2021 17:21:44 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2F69029EBE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1613686904;
        bh=jSJ+dbRp3dxNG29UdSxpjbejLYT/egi7+9YCbVCSAjg=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=f+DpBLsGAQCjAAhwRNvqUMJFiKSLcJZMDkl08WF5w+gNXmec5toJ1G3S7fVXTo4Kx
         asV5Nm9wTQzGEyLJNn7FTeBw8bw+gS7rHSeOmO8hyWTdkAlAqvrXXO6T4FVooYnBpl
         gNYGya1DSQKP0rOVn9EddnOjKX2p60G8pCScSXcbUqUV4QRpjqLppcTAjoEPM9HlnH
         RXAxUYKwYNfA0NiXLe6SPCofSfso/qH6wDhfTr8qUj5/Z/wv8H3/qie7Q8lvi6kIQj
         cerD85gG69TpJjM64Pda0ynTYJZ4GqRbIxek553jWyynA++VVfIDpv78Ij0uzjnBj1
         OpZJBf8S7AeaQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8FDw49Ju-c19; Thu, 18 Feb 2021 17:21:44 -0500 (EST)
Received: from localhost.localdomain (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id E03C629EBE4;
        Thu, 18 Feb 2021 17:21:43 -0500 (EST)
From:   Michael Jeanson <mjeanson@efficios.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [RFC PATCH 5/6] tracing: convert sys_enter/exit to faultable tracepoints
Date:   Thu, 18 Feb 2021 17:21:24 -0500
Message-Id: <20210218222125.46565-6-mjeanson@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218222125.46565-1-mjeanson@efficios.com>
References: <20210218222125.46565-1-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert the definition of the system call enter/exit tracepoints to
faultable tracepoints now that all upstream tracers handle it.

Co-developed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/trace/events/syscalls.h |  4 +-
 kernel/trace/trace_syscalls.c   | 84 +++++++++++++++++++++++----------
 2 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/include/trace/events/syscalls.h b/include/trace/events/sysca=
lls.h
index b6e0cbc2c71f..2bd2d94563a2 100644
--- a/include/trace/events/syscalls.h
+++ b/include/trace/events/syscalls.h
@@ -15,7 +15,7 @@
=20
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
=20
-TRACE_EVENT_FN(sys_enter,
+TRACE_EVENT_FN_MAYFAULT(sys_enter,
=20
 	TP_PROTO(struct pt_regs *regs, long id),
=20
@@ -41,7 +41,7 @@ TRACE_EVENT_FN(sys_enter,
=20
 TRACE_EVENT_FLAGS(sys_enter, TRACE_EVENT_FL_CAP_ANY)
=20
-TRACE_EVENT_FN(sys_exit,
+TRACE_EVENT_FN_MAYFAULT(sys_exit,
=20
 	TP_PROTO(struct pt_regs *regs, long ret),
=20
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.=
c
index d85a2f0f316b..4ca9190e26b2 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -304,21 +304,27 @@ static void ftrace_syscall_enter(void *data, struct=
 pt_regs *regs, long id)
 	int syscall_nr;
 	int size;
=20
+	/*
+	 * Probe called with preemption enabled (mayfault), but ring buffer and
+	 * per-cpu data require preemption to be disabled.
+	 */
+	preempt_disable_notrace();
+
 	syscall_nr =3D trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >=3D NR_syscalls)
-		return;
+		goto end;
=20
 	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE) */
 	trace_file =3D rcu_dereference_sched(tr->enter_syscall_files[syscall_nr=
]);
 	if (!trace_file)
-		return;
+		goto end;
=20
 	if (trace_trigger_soft_disabled(trace_file))
-		return;
+		goto end;
=20
 	sys_data =3D syscall_nr_to_meta(syscall_nr);
 	if (!sys_data)
-		return;
+		goto end;
=20
 	size =3D sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
=20
@@ -329,7 +335,7 @@ static void ftrace_syscall_enter(void *data, struct p=
t_regs *regs, long id)
 	event =3D trace_buffer_lock_reserve(buffer,
 			sys_data->enter_event->event.type, size, irq_flags, pc);
 	if (!event)
-		return;
+		goto end;
=20
 	entry =3D ring_buffer_event_data(event);
 	entry->nr =3D syscall_nr;
@@ -338,6 +344,8 @@ static void ftrace_syscall_enter(void *data, struct p=
t_regs *regs, long id)
=20
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
 				    irq_flags, pc);
+end:
+	preempt_enable_notrace();
 }
=20
 static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long r=
et)
@@ -352,21 +360,27 @@ static void ftrace_syscall_exit(void *data, struct =
pt_regs *regs, long ret)
 	int pc;
 	int syscall_nr;
=20
+	/*
+	 * Probe called with preemption enabled (mayfault), but ring buffer and
+	 * per-cpu data require preemption to be disabled.
+	 */
+	preempt_disable_notrace();
+
 	syscall_nr =3D trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >=3D NR_syscalls)
-		return;
+		goto end;
=20
 	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE()) */
 	trace_file =3D rcu_dereference_sched(tr->exit_syscall_files[syscall_nr]=
);
 	if (!trace_file)
-		return;
+		goto end;
=20
 	if (trace_trigger_soft_disabled(trace_file))
-		return;
+		goto end;
=20
 	sys_data =3D syscall_nr_to_meta(syscall_nr);
 	if (!sys_data)
-		return;
+		goto end;
=20
 	local_save_flags(irq_flags);
 	pc =3D preempt_count();
@@ -376,7 +390,7 @@ static void ftrace_syscall_exit(void *data, struct pt=
_regs *regs, long ret)
 			sys_data->exit_event->event.type, sizeof(*entry),
 			irq_flags, pc);
 	if (!event)
-		return;
+		goto end;
=20
 	entry =3D ring_buffer_event_data(event);
 	entry->nr =3D syscall_nr;
@@ -384,6 +398,8 @@ static void ftrace_syscall_exit(void *data, struct pt=
_regs *regs, long ret)
=20
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
 				    irq_flags, pc);
+end:
+	preempt_enable_notrace();
 }
=20
 static int reg_event_syscall_enter(struct trace_event_file *file,
@@ -398,7 +414,7 @@ static int reg_event_syscall_enter(struct trace_event=
_file *file,
 		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
 	if (!tr->sys_refcount_enter)
-		ret =3D register_trace_sys_enter(ftrace_syscall_enter, tr);
+		ret =3D register_trace_mayfault_sys_enter(ftrace_syscall_enter, tr);
 	if (!ret) {
 		rcu_assign_pointer(tr->enter_syscall_files[num], file);
 		tr->sys_refcount_enter++;
@@ -436,7 +452,7 @@ static int reg_event_syscall_exit(struct trace_event_=
file *file,
 		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
 	if (!tr->sys_refcount_exit)
-		ret =3D register_trace_sys_exit(ftrace_syscall_exit, tr);
+		ret =3D register_trace_mayfault_sys_exit(ftrace_syscall_exit, tr);
 	if (!ret) {
 		rcu_assign_pointer(tr->exit_syscall_files[num], file);
 		tr->sys_refcount_exit++;
@@ -600,20 +616,26 @@ static void perf_syscall_enter(void *ignore, struct=
 pt_regs *regs, long id)
 	int rctx;
 	int size;
=20
+	/*
+	 * Probe called with preemption enabled (mayfault), but ring buffer and
+	 * per-cpu data require preemption to be disabled.
+	 */
+	preempt_disable_notrace();
+
 	syscall_nr =3D trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >=3D NR_syscalls)
-		return;
+		goto end;
 	if (!test_bit(syscall_nr, enabled_perf_enter_syscalls))
-		return;
+		goto end;
=20
 	sys_data =3D syscall_nr_to_meta(syscall_nr);
 	if (!sys_data)
-		return;
+		goto end;
=20
 	head =3D this_cpu_ptr(sys_data->enter_event->perf_events);
 	valid_prog_array =3D bpf_prog_array_valid(sys_data->enter_event);
 	if (!valid_prog_array && hlist_empty(head))
-		return;
+		goto end;
=20
 	/* get the size after alignment with the u32 buffer size field */
 	size =3D sizeof(unsigned long) * sys_data->nb_args + sizeof(*rec);
@@ -622,7 +644,7 @@ static void perf_syscall_enter(void *ignore, struct p=
t_regs *regs, long id)
=20
 	rec =3D perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!rec)
-		return;
+		goto end;
=20
 	rec->nr =3D syscall_nr;
 	syscall_get_arguments(current, regs, args);
@@ -632,12 +654,14 @@ static void perf_syscall_enter(void *ignore, struct=
 pt_regs *regs, long id)
 	     !perf_call_bpf_enter(sys_data->enter_event, regs, sys_data, rec)) =
||
 	    hlist_empty(head)) {
 		perf_swevent_put_recursion_context(rctx);
-		return;
+		goto end;
 	}
=20
 	perf_trace_buf_submit(rec, size, rctx,
 			      sys_data->enter_event->event.type, 1, regs,
 			      head, NULL);
+end:
+	preempt_enable_notrace();
 }
=20
 static int perf_sysenter_enable(struct trace_event_call *call)
@@ -649,7 +673,7 @@ static int perf_sysenter_enable(struct trace_event_ca=
ll *call)
=20
 	mutex_lock(&syscall_trace_lock);
 	if (!sys_perf_refcount_enter)
-		ret =3D register_trace_sys_enter(perf_syscall_enter, NULL);
+		ret =3D register_trace_mayfault_sys_enter(perf_syscall_enter, NULL);
 	if (ret) {
 		pr_info("event trace: Could not activate syscall entry trace point");
 	} else {
@@ -699,20 +723,26 @@ static void perf_syscall_exit(void *ignore, struct =
pt_regs *regs, long ret)
 	int rctx;
 	int size;
=20
+	/*
+	 * Probe called with preemption enabled (mayfault), but ring buffer and
+	 * per-cpu data require preemption to be disabled.
+	 */
+	preempt_disable_notrace();
+
 	syscall_nr =3D trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >=3D NR_syscalls)
-		return;
+		goto end;
 	if (!test_bit(syscall_nr, enabled_perf_exit_syscalls))
-		return;
+		goto end;
=20
 	sys_data =3D syscall_nr_to_meta(syscall_nr);
 	if (!sys_data)
-		return;
+		goto end;
=20
 	head =3D this_cpu_ptr(sys_data->exit_event->perf_events);
 	valid_prog_array =3D bpf_prog_array_valid(sys_data->exit_event);
 	if (!valid_prog_array && hlist_empty(head))
-		return;
+		goto end;
=20
 	/* We can probably do that at build time */
 	size =3D ALIGN(sizeof(*rec) + sizeof(u32), sizeof(u64));
@@ -720,7 +750,7 @@ static void perf_syscall_exit(void *ignore, struct pt=
_regs *regs, long ret)
=20
 	rec =3D perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!rec)
-		return;
+		goto end;
=20
 	rec->nr =3D syscall_nr;
 	rec->ret =3D syscall_get_return_value(current, regs);
@@ -729,11 +759,13 @@ static void perf_syscall_exit(void *ignore, struct =
pt_regs *regs, long ret)
 	     !perf_call_bpf_exit(sys_data->exit_event, regs, rec)) ||
 	    hlist_empty(head)) {
 		perf_swevent_put_recursion_context(rctx);
-		return;
+		goto end;
 	}
=20
 	perf_trace_buf_submit(rec, size, rctx, sys_data->exit_event->event.type=
,
 			      1, regs, head, NULL);
+end:
+	preempt_enable_notrace();
 }
=20
 static int perf_sysexit_enable(struct trace_event_call *call)
@@ -745,7 +777,7 @@ static int perf_sysexit_enable(struct trace_event_cal=
l *call)
=20
 	mutex_lock(&syscall_trace_lock);
 	if (!sys_perf_refcount_exit)
-		ret =3D register_trace_sys_exit(perf_syscall_exit, NULL);
+		ret =3D register_trace_mayfault_sys_exit(perf_syscall_exit, NULL);
 	if (ret) {
 		pr_info("event trace: Could not activate syscall exit trace point");
 	} else {
--=20
2.25.1

