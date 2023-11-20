Return-Path: <bpf+bounces-15405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD27F1E48
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3641F2613C
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 20:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B95225CD;
	Mon, 20 Nov 2023 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dQb6s5nO"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555C3E7;
	Mon, 20 Nov 2023 12:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1700513681;
	bh=gzqVrF2HW4E6ZSO3Uvr5o3XrzMWnpKg+s2vm1djRgJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQb6s5nOoxjKf21ZJDHu1gXmBPZBiQ5ybxukjIAKdlvlS0UkwvOL/5j9k6H8OeeXx
	 8MX3SIXzYUaaHh6H6EGNUYOzpj4pQEIyJ9K70LiUuztHl7NJh+cu0aty18lSHlN589
	 uhee8wdZEKFOGZ97hNkDQFls1GvpCBqH6jRnT7bouGTtyt4NTYQnjWXD4yQcrNuCEJ
	 4adkDFtQGEWWHvgwCdsmxcnhEIvWuqaVwYcFgHIX/oWyQ+RHACOFF2tf+r7RDkiSTB
	 jrpS2AkTPFyaUxzxqqbY/+SLvr/ShJKATDCgTqW/ToLCmVSb+eWH7ZLmSHqLCgvELH
	 4K9l/kVztkkgQ==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SZ0B86pWRz1cmG;
	Mon, 20 Nov 2023 15:54:40 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
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
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v4 5/5] tracing: convert sys_enter/exit to faultable tracepoints
Date: Mon, 20 Nov 2023 15:54:18 -0500
Message-Id: <20231120205418.334172-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the definition of the system call enter/exit tracepoints to
faultable tracepoints now that all upstream tracers handle it.

This allows tracers to fault-in userspace system call arguments such as
path strings within their probe callbacks.

Link: https://lore.kernel.org/lkml/20231002202531.3160-1-mathieu.desnoyers@efficios.com/
Co-developed-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
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
 kernel/trace/trace_syscalls.c   | 92 +++++++++++++++++++++++----------
 2 files changed, 68 insertions(+), 28 deletions(-)

diff --git a/include/trace/events/syscalls.h b/include/trace/events/syscalls.h
index b6e0cbc2c71f..dc30e3004818 100644
--- a/include/trace/events/syscalls.h
+++ b/include/trace/events/syscalls.h
@@ -15,7 +15,7 @@
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 
-TRACE_EVENT_FN(sys_enter,
+TRACE_EVENT_FN_MAY_FAULT(sys_enter,
 
 	TP_PROTO(struct pt_regs *regs, long id),
 
@@ -41,7 +41,7 @@ TRACE_EVENT_FN(sys_enter,
 
 TRACE_EVENT_FLAGS(sys_enter, TRACE_EVENT_FL_CAP_ANY)
 
-TRACE_EVENT_FN(sys_exit,
+TRACE_EVENT_FN_MAY_FAULT(sys_exit,
 
 	TP_PROTO(struct pt_regs *regs, long ret),
 
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index de753403cdaf..718a0723a0bc 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -299,27 +299,33 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	int syscall_nr;
 	int size;
 
+	/*
+	 * Probe called with preemption enabled (may_fault), but ring buffer and
+	 * per-cpu data require preemption to be disabled.
+	 */
+	preempt_disable_notrace();
+
 	syscall_nr = trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
-		return;
+		goto end;
 
 	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE) */
 	trace_file = rcu_dereference_sched(tr->enter_syscall_files[syscall_nr]);
 	if (!trace_file)
-		return;
+		goto end;
 
 	if (trace_trigger_soft_disabled(trace_file))
-		return;
+		goto end;
 
 	sys_data = syscall_nr_to_meta(syscall_nr);
 	if (!sys_data)
-		return;
+		goto end;
 
 	size = sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
 	if (!entry)
-		return;
+		goto end;
 
 	entry = ring_buffer_event_data(fbuffer.event);
 	entry->nr = syscall_nr;
@@ -327,6 +333,8 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	trace_event_buffer_commit(&fbuffer);
+end:
+	preempt_enable_notrace();
 }
 
 static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
@@ -338,31 +346,39 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	struct trace_event_buffer fbuffer;
 	int syscall_nr;
 
+	/*
+	 * Probe called with preemption enabled (may_fault), but ring buffer and
+	 * per-cpu data require preemption to be disabled.
+	 */
+	preempt_disable_notrace();
+
 	syscall_nr = trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
-		return;
+		goto end;
 
 	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE()) */
 	trace_file = rcu_dereference_sched(tr->exit_syscall_files[syscall_nr]);
 	if (!trace_file)
-		return;
+		goto end;
 
 	if (trace_trigger_soft_disabled(trace_file))
-		return;
+		goto end;
 
 	sys_data = syscall_nr_to_meta(syscall_nr);
 	if (!sys_data)
-		return;
+		goto end;
 
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file, sizeof(*entry));
 	if (!entry)
-		return;
+		goto end;
 
 	entry = ring_buffer_event_data(fbuffer.event);
 	entry->nr = syscall_nr;
 	entry->ret = syscall_get_return_value(current, regs);
 
 	trace_event_buffer_commit(&fbuffer);
+end:
+	preempt_enable_notrace();
 }
 
 static int reg_event_syscall_enter(struct trace_event_file *file,
@@ -377,7 +393,9 @@ static int reg_event_syscall_enter(struct trace_event_file *file,
 		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
 	if (!tr->sys_refcount_enter)
-		ret = register_trace_sys_enter(ftrace_syscall_enter, tr);
+		ret = register_trace_prio_flags_sys_enter(ftrace_syscall_enter, tr,
+							  TRACEPOINT_DEFAULT_PRIO,
+							  TRACEPOINT_MAY_FAULT);
 	if (!ret) {
 		rcu_assign_pointer(tr->enter_syscall_files[num], file);
 		tr->sys_refcount_enter++;
@@ -415,7 +433,9 @@ static int reg_event_syscall_exit(struct trace_event_file *file,
 		return -ENOSYS;
 	mutex_lock(&syscall_trace_lock);
 	if (!tr->sys_refcount_exit)
-		ret = register_trace_sys_exit(ftrace_syscall_exit, tr);
+		ret = register_trace_prio_flags_sys_exit(ftrace_syscall_exit, tr,
+							 TRACEPOINT_DEFAULT_PRIO,
+							 TRACEPOINT_MAY_FAULT);
 	if (!ret) {
 		rcu_assign_pointer(tr->exit_syscall_files[num], file);
 		tr->sys_refcount_exit++;
@@ -582,20 +602,26 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	int rctx;
 	int size;
 
+	/*
+	 * Probe called with preemption enabled (may_fault), but ring buffer and
+	 * per-cpu data require preemption to be disabled.
+	 */
+	preempt_disable_notrace();
+
 	syscall_nr = trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
-		return;
+		goto end;
 	if (!test_bit(syscall_nr, enabled_perf_enter_syscalls))
-		return;
+		goto end;
 
 	sys_data = syscall_nr_to_meta(syscall_nr);
 	if (!sys_data)
-		return;
+		goto end;
 
 	head = this_cpu_ptr(sys_data->enter_event->perf_events);
 	valid_prog_array = bpf_prog_array_valid(sys_data->enter_event);
 	if (!valid_prog_array && hlist_empty(head))
-		return;
+		goto end;
 
 	/* get the size after alignment with the u32 buffer size field */
 	size = sizeof(unsigned long) * sys_data->nb_args + sizeof(*rec);
@@ -604,7 +630,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 
 	rec = perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!rec)
-		return;
+		goto end;
 
 	rec->nr = syscall_nr;
 	syscall_get_arguments(current, regs, args);
@@ -614,12 +640,14 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	     !perf_call_bpf_enter(sys_data->enter_event, regs, sys_data, rec)) ||
 	    hlist_empty(head)) {
 		perf_swevent_put_recursion_context(rctx);
-		return;
+		goto end;
 	}
 
 	perf_trace_buf_submit(rec, size, rctx,
 			      sys_data->enter_event->event.type, 1, regs,
 			      head, NULL);
+end:
+	preempt_enable_notrace();
 }
 
 static int perf_sysenter_enable(struct trace_event_call *call)
@@ -631,7 +659,9 @@ static int perf_sysenter_enable(struct trace_event_call *call)
 
 	mutex_lock(&syscall_trace_lock);
 	if (!sys_perf_refcount_enter)
-		ret = register_trace_sys_enter(perf_syscall_enter, NULL);
+		ret = register_trace_prio_flags_sys_enter(perf_syscall_enter, NULL,
+							  TRACEPOINT_DEFAULT_PRIO,
+							  TRACEPOINT_MAY_FAULT);
 	if (ret) {
 		pr_info("event trace: Could not activate syscall entry trace point");
 	} else {
@@ -682,20 +712,26 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	int rctx;
 	int size;
 
+	/*
+	 * Probe called with preemption enabled (may_fault), but ring buffer and
+	 * per-cpu data require preemption to be disabled.
+	 */
+	preempt_disable_notrace();
+
 	syscall_nr = trace_get_syscall_nr(current, regs);
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
-		return;
+		goto end;
 	if (!test_bit(syscall_nr, enabled_perf_exit_syscalls))
-		return;
+		goto end;
 
 	sys_data = syscall_nr_to_meta(syscall_nr);
 	if (!sys_data)
-		return;
+		goto end;
 
 	head = this_cpu_ptr(sys_data->exit_event->perf_events);
 	valid_prog_array = bpf_prog_array_valid(sys_data->exit_event);
 	if (!valid_prog_array && hlist_empty(head))
-		return;
+		goto end;
 
 	/* We can probably do that at build time */
 	size = ALIGN(sizeof(*rec) + sizeof(u32), sizeof(u64));
@@ -703,7 +739,7 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 
 	rec = perf_trace_buf_alloc(size, NULL, &rctx);
 	if (!rec)
-		return;
+		goto end;
 
 	rec->nr = syscall_nr;
 	rec->ret = syscall_get_return_value(current, regs);
@@ -712,11 +748,13 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	     !perf_call_bpf_exit(sys_data->exit_event, regs, rec)) ||
 	    hlist_empty(head)) {
 		perf_swevent_put_recursion_context(rctx);
-		return;
+		goto end;
 	}
 
 	perf_trace_buf_submit(rec, size, rctx, sys_data->exit_event->event.type,
 			      1, regs, head, NULL);
+end:
+	preempt_enable_notrace();
 }
 
 static int perf_sysexit_enable(struct trace_event_call *call)
@@ -728,7 +766,9 @@ static int perf_sysexit_enable(struct trace_event_call *call)
 
 	mutex_lock(&syscall_trace_lock);
 	if (!sys_perf_refcount_exit)
-		ret = register_trace_sys_exit(perf_syscall_exit, NULL);
+		ret = register_trace_prio_flags_sys_exit(perf_syscall_exit, NULL,
+							 TRACEPOINT_DEFAULT_PRIO,
+							 TRACEPOINT_MAY_FAULT);
 	if (ret) {
 		pr_info("event trace: Could not activate syscall exit trace point");
 	} else {
-- 
2.25.1


