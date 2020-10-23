Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D750C2977E2
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 21:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755056AbgJWTyX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 15:54:23 -0400
Received: from mail.efficios.com ([167.114.26.124]:45730 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463594AbgJWTyW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 15:54:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E6C67279343;
        Fri, 23 Oct 2020 15:54:19 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id c_FZvHWRqXC9; Fri, 23 Oct 2020 15:54:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 650DA27944D;
        Fri, 23 Oct 2020 15:54:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 650DA27944D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603482859;
        bh=7Vr3N2XvQsk9CtvpGKjgfXulzOVMImQL6qNLEXg00vY=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=l+ceucGZRjZT+6y0b++l3MGPBF4q1EAAw7OlOgNWOTIHSm1+0HPHlNeXAe0z0rkOl
         pzxctJxGRSPboBvlpbcHyQA0QBOP4L0/paQmHsCRbLXNid4Xv0J1xc5pH4ojawhlGv
         w9N6RfFndVgWZe+bl8hdEZ7Gr0QkOQpvPMDhnhbwADIQQ4qP4ZvP+t9psBEtsOrgMA
         HEEhAfLzB13DDfFeyRI1QQQ0kXRREPo+QSVs6AGqBv/N8/wLbdCUr1B0fLuEOyGW/Z
         dkX/XprEWHRsBdCgCFHLJXZqRHnecwhJAdp4529Rzn6SdpKJlYd2hucPwaf3smzL+S
         0SdHsFc8lSStA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tPxcqyxcMzra; Fri, 23 Oct 2020 15:54:19 -0400 (EDT)
Received: from localhost.localdomain (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
        by mail.efficios.com (Postfix) with ESMTPSA id 01799279880;
        Fri, 23 Oct 2020 15:54:18 -0400 (EDT)
From:   Michael Jeanson <mjeanson@efficios.com>
To:     linux-kernel@vger.kernel.org
Cc:     mathieu.desnoyers@efficios.com,
        Michael Jeanson <mjeanson@efficios.com>,
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
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, bpf@vger.kernel.org
Subject: [RFC PATCH 5/6] tracing: convert sys_enter/exit to sleepable tracepoints
Date:   Fri, 23 Oct 2020 15:53:51 -0400
Message-Id: <20201023195352.26269-6-mjeanson@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023195352.26269-1-mjeanson@efficios.com>
References: <20201023195352.26269-1-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert the definition of the system call enter/exit tracepoints to
sleepable tracepoints now that all upstream tracers handle it.

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
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: bpf@vger.kernel.org
---
 include/trace/events/syscalls.h |  4 +-
 kernel/trace/trace_syscalls.c   | 68 ++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/include/trace/events/syscalls.h b/include/trace/events/sysca=
lls.h
index b6e0cbc2c71f..fbb8d8b48f81 100644
--- a/include/trace/events/syscalls.h
+++ b/include/trace/events/syscalls.h
@@ -15,7 +15,7 @@
=20
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
=20
-TRACE_EVENT_FN(sys_enter,
+TRACE_EVENT_FN_MAYSLEEP(sys_enter,
=20
 	TP_PROTO(struct pt_regs *regs, long id),
=20
@@ -41,7 +41,7 @@ TRACE_EVENT_FN(sys_enter,
=20
 TRACE_EVENT_FLAGS(sys_enter, TRACE_EVENT_FL_CAP_ANY)
=20
-TRACE_EVENT_FN(sys_exit,
+TRACE_EVENT_FN_MAYSLEEP(sys_exit,
=20
 	TP_PROTO(struct pt_regs *regs, long ret),
=20
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.=
c
index d85a2f0f316b..48d92d59fb92 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -304,21 +304,23 @@ static void ftrace_syscall_enter(void *data, struct=
 pt_regs *regs, long id)
 	int syscall_nr;
 	int size;
=20
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
@@ -329,7 +331,7 @@ static void ftrace_syscall_enter(void *data, struct p=
t_regs *regs, long id)
 	event =3D trace_buffer_lock_reserve(buffer,
 			sys_data->enter_event->event.type, size, irq_flags, pc);
 	if (!event)
-		return;
+		goto end;
=20
 	entry =3D ring_buffer_event_data(event);
 	entry->nr =3D syscall_nr;
@@ -338,6 +340,8 @@ static void ftrace_syscall_enter(void *data, struct p=
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
@@ -352,21 +356,23 @@ static void ftrace_syscall_exit(void *data, struct =
pt_regs *regs, long ret)
 	int pc;
 	int syscall_nr;
=20
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
@@ -376,7 +382,7 @@ static void ftrace_syscall_exit(void *data, struct pt=
_regs *regs, long ret)
 			sys_data->exit_event->event.type, sizeof(*entry),
 			irq_flags, pc);
 	if (!event)
-		return;
+		goto end;
=20
 	entry =3D ring_buffer_event_data(event);
 	entry->nr =3D syscall_nr;
@@ -384,6 +390,8 @@ static void ftrace_syscall_exit(void *data, struct pt=
_regs *regs, long ret)
=20
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
 				    irq_flags, pc);
+end:
+	preempt_enable_notrace();
 }
=20
 static int reg_event_syscall_enter(struct trace_event_file *file,
@@ -398,7 +406,7 @@ static int reg_event_syscall_enter(struct trace_event=
_file *file,
 		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
 	if (!tr->sys_refcount_enter)
-		ret =3D register_trace_sys_enter(ftrace_syscall_enter, tr);
+		ret =3D register_trace_maysleep_sys_enter(ftrace_syscall_enter, tr);
 	if (!ret) {
 		rcu_assign_pointer(tr->enter_syscall_files[num], file);
 		tr->sys_refcount_enter++;
@@ -436,7 +444,7 @@ static int reg_event_syscall_exit(struct trace_event_=
file *file,
 		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
 	if (!tr->sys_refcount_exit)
-		ret =3D register_trace_sys_exit(ftrace_syscall_exit, tr);
+		ret =3D register_trace_maysleep_sys_exit(ftrace_syscall_exit, tr);
 	if (!ret) {
 		rcu_assign_pointer(tr->exit_syscall_files[num], file);
 		tr->sys_refcount_exit++;
@@ -600,20 +608,22 @@ static void perf_syscall_enter(void *ignore, struct=
 pt_regs *regs, long id)
 	int rctx;
 	int size;
=20
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
@@ -622,7 +632,7 @@ static void perf_syscall_enter(void *ignore, struct p=
t_regs *regs, long id)
=20
 	rec =3D perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!rec)
-		return;
+		goto end;
=20
 	rec->nr =3D syscall_nr;
 	syscall_get_arguments(current, regs, args);
@@ -632,12 +642,14 @@ static void perf_syscall_enter(void *ignore, struct=
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
@@ -649,7 +661,7 @@ static int perf_sysenter_enable(struct trace_event_ca=
ll *call)
=20
 	mutex_lock(&syscall_trace_lock);
 	if (!sys_perf_refcount_enter)
-		ret =3D register_trace_sys_enter(perf_syscall_enter, NULL);
+		ret =3D register_trace_maysleep_sys_enter(perf_syscall_enter, NULL);
 	if (ret) {
 		pr_info("event trace: Could not activate syscall entry trace point");
 	} else {
@@ -699,20 +711,22 @@ static void perf_syscall_exit(void *ignore, struct =
pt_regs *regs, long ret)
 	int rctx;
 	int size;
=20
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
@@ -720,7 +734,7 @@ static void perf_syscall_exit(void *ignore, struct pt=
_regs *regs, long ret)
=20
 	rec =3D perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!rec)
-		return;
+		goto end;
=20
 	rec->nr =3D syscall_nr;
 	rec->ret =3D syscall_get_return_value(current, regs);
@@ -729,11 +743,13 @@ static void perf_syscall_exit(void *ignore, struct =
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
@@ -745,7 +761,7 @@ static int perf_sysexit_enable(struct trace_event_cal=
l *call)
=20
 	mutex_lock(&syscall_trace_lock);
 	if (!sys_perf_refcount_exit)
-		ret =3D register_trace_sys_exit(perf_syscall_exit, NULL);
+		ret =3D register_trace_maysleep_sys_exit(perf_syscall_exit, NULL);
 	if (ret) {
 		pr_info("event trace: Could not activate syscall exit trace point");
 	} else {
--=20
2.25.1

