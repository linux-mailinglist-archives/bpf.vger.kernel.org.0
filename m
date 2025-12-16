Return-Path: <bpf+bounces-76723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37725CC48AD
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A39AD3007779
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D70329E67;
	Tue, 16 Dec 2025 17:06:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ECF296BBF;
	Tue, 16 Dec 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904814; cv=none; b=Q88egUQt4WBh2948NK44bBxC5s2e3wXBLi55FkwWGeXyCRVOzFJj2RYXg8cqBcR8lnXoMpu7/z5lQjvVJgXzrju0Xj4IO3JlfEzWaxt7svKVZdnCYSV9doe7R0DpWCL0+68t9NfunCZ3yCiTy/3cTj594znfyOjkBZNe0cTcyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904814; c=relaxed/simple;
	bh=gjAtwKp36ISk64gtR66wXK4Mq1NUxmFev0jszkqE6ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HZ9PCXXUJwk/UPLxKCkYrmIk+wod+DRe+ZpoSlVniPAEDL5Ol6m2QzGvew8dTf0W6qdV4n9GZnFHq7gWbEoI5WDQeMyibK4z4URAY9AYN07v3TSTvM/O8HkfnB6MAF8Vxw+E7dg7exhPH8dGq2Ab7ekNbkS02xZWQSKi5oyh6Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 604E3160614;
	Tue, 16 Dec 2025 17:06:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 7DBFE20012;
	Tue, 16 Dec 2025 17:06:45 +0000 (UTC)
Date: Tue, 16 Dec 2025 12:08:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org
Subject: [PATCH] tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL()
 with SRCU-fast
Message-ID: <20251216120819.3499e00e@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8ordyjnys3ojxnt51tm4f1sn1bsctyo1
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 7DBFE20012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+K4NZ7BmoOkS/JGaqUERe9tjD8Rr6RhPI=
X-HE-Tag: 1765904805-759456
X-HE-Meta: U2FsdGVkX1+mn4DCG6ykba6IWAFYfH87yAHP0xtq1zjWbDhyV7qrUPUHwZ15NL/JIiBkYkFjVHM7sb2GVyMcGYF8rrIUWiBfSoGgnKkQV7cRMeaIwfWS2Da2ihhED25EPW1qERqYOSBpRwUEGoDKLV6nvn2KOXP70l4MqyIajap+5XD80fczND8xQCbZG+BSuuWaRRGPV4v/IkoTyGzhZYaUpaBr0YnRiK3s1pWjjQIpiOTviW+1ov74pJ8gBPxI8W1PL6o3Chwwd8uiuVTkk5KiDYLsM/U5C0qQQc8KDQ8XNVr7qLTEio0w+H7dRIFsRvkqg1R4AU7OW69UTdWPnCdWN9CQy+eV8mRdTKmyWd9D3bM9Q3Y+lnsyq5JfIMy4zGBLGRKYGa022CV9Q6f458HYhlZ7SFOJTvu59Vo3YzaH3ztqOJefk+FgKNtyJVz/3x2zZe9aBnX1WZNp8uGsR3NAJuyp8DtXsOwz8aa9MuVV6jXfskb1xuItXKXXahyqDCcVeKhzqxE8OoQInqVZbqAb7ZF0+W6R1f0wL4cGGOU=

From: "Paul E. McKenney" <paulmck@kernel.org>

The current use of guard(preempt_notrace)() within __DECLARE_TRACE()
to protect invocation of __DO_TRACE_CALL() means that BPF programs
attached to tracepoints are non-preemptible.  This is unhelpful in
real-time systems, whose users apparently wish to use BPF while also
achieving low latencies.  (Who knew?)

One option would be to use preemptible RCU, but this introduces
many opportunities for infinite recursion, which many consider to
be counterproductive, especially given the relatively small stacks
provided by the Linux kernel.  These opportunities could be shut down
by sufficiently energetic duplication of code, but this sort of thing
is considered impolite in some circles.

Therefore, use the shiny new SRCU-fast API, which provides somewhat faster
readers than those of preemptible RCU, at least on Paul E. McKenney's
laptop, where task_struct access is more expensive than access to per-CPU
variables.  And SRCU-fast provides way faster readers than does SRCU,
courtesy of being able to avoid the read-side use of smp_mb().  Also,
it is quite straightforward to create srcu_read_{,un}lock_fast_notrace()
functions.

While in the area, SRCU now supports early boot call_srcu().  Therefore,
remove the checks that used to avoid such use from rcu_free_old_probes()
before this commit was applied:

e53244e2c893 ("tracepoint: Remove SRCU protection")

The current commit can be thought of as an approximate revert of that
commit, with some compensating additions of preemption disabling.
This preemption disabling uses guard(preempt_notrace)().

However, Yonghong Song points out that BPF assumes that non-sleepable
BPF programs will remain on the same CPU, which means that migration
must be disabled whenever preemption remains enabled.  In addition,
non-RT kernels have performance expectations that would be violated by
allowing the BPF programs to be preempted.

Therefore, continue to disable preemption in non-RT kernels, and protect
the BPF program with both SRCU and migration disabling for RT kernels,
and even then only if preemption is not already disabled.

Link: https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Steve Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
Changes since v3: https://patch.msgid.link/e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop

- Added a trace_event_buffer_reserve_syscall() interface for system call
  events to use. This will not need to mess with the migrate disable
  counter. It just expects preemption to be disabled.

 include/linux/trace_events.h  | 24 ++++++++++++++++++++++++
 include/linux/tracepoint.h    | 25 ++++++++++++++++++++++---
 include/trace/perf.h          |  4 ++--
 include/trace/trace_events.h  | 21 +++++++++++++++++++--
 kernel/trace/trace_events.c   | 30 ++++++++++++++++++++----------
 kernel/trace/trace_syscalls.c |  4 ++--
 kernel/tracepoint.c           | 33 +++++++++++++++++++++++++++++++++
 7 files changed, 122 insertions(+), 19 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 3690221ba3d8..a2704c35eda8 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -222,6 +222,26 @@ static inline unsigned int tracing_gen_ctx_dec(void)
 	return trace_ctx;
 }
 
+/*
+ * When PREEMPT_RT is enabled, trace events are called with disabled
+ * migration. The trace events need to know if the tracepoint disabled
+ * migration or not so that what is recorded to the ring buffer shows
+ * the state of when the trace event triggered, and not the state caused
+ * by the trace event.
+ */
+#ifdef CONFIG_PREEMPT_RT
+static inline unsigned int tracing_gen_ctx_dec_cond(void)
+{
+	unsigned int trace_ctx;
+
+	trace_ctx = tracing_gen_ctx_dec();
+	/* The migration counter starts at bit 4 */
+	return trace_ctx - (1 << 4);
+}
+#else
+# define tracing_gen_ctx_dec_cond() tracing_gen_ctx_dec()
+#endif
+
 struct trace_event_file;
 
 struct ring_buffer_event *
@@ -313,6 +333,10 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 				  struct trace_event_file *trace_file,
 				  unsigned long len);
 
+void *trace_event_buffer_reserve_syscall(struct trace_event_buffer *fbuffer,
+					 struct trace_event_file *trace_file,
+					 unsigned long len);
+
 void trace_event_buffer_commit(struct trace_event_buffer *fbuffer);
 
 enum {
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 8a56f3278b1b..0563c7d9fcb2 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -100,6 +100,25 @@ void for_each_tracepoint_in_module(struct module *mod,
 }
 #endif /* CONFIG_MODULES */
 
+/*
+ * BPF programs can attach to the tracepoint callbacks. But if the
+ * callbacks are called with preemption disabled, the BPF programs
+ * can cause quite a bit of latency. When PREEMPT_RT is enabled,
+ * instead of disabling preemption, use srcu_fast_notrace() for
+ * synchronization. As BPF programs that are attached to tracepoints
+ * expect to stay on the same CPU, also disable migration.
+ */
+#ifdef CONFIG_PREEMPT_RT
+extern struct srcu_struct tracepoint_srcu;
+# define tracepoint_sync() synchronize_srcu(&tracepoint_srcu);
+# define tracepoint_guard()				\
+	guard(srcu_fast_notrace)(&tracepoint_srcu);	\
+	guard(migrate)()
+#else
+# define tracepoint_sync() synchronize_rcu();
+# define tracepoint_guard() guard(preempt_notrace)()
+#endif
+
 /*
  * tracepoint_synchronize_unregister must be called between the last tracepoint
  * probe unregistration and the end of module exit to make sure there is no
@@ -115,7 +134,7 @@ void for_each_tracepoint_in_module(struct module *mod,
 static inline void tracepoint_synchronize_unregister(void)
 {
 	synchronize_rcu_tasks_trace();
-	synchronize_rcu();
+	tracepoint_sync();
 }
 static inline bool tracepoint_is_faultable(struct tracepoint *tp)
 {
@@ -275,13 +294,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		return static_branch_unlikely(&__tracepoint_##name.key);\
 	}
 
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto)			\
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
 	static inline void __do_trace_##name(proto)			\
 	{								\
 		TRACEPOINT_CHECK(name)					\
 		if (cond) {						\
-			guard(preempt_notrace)();			\
+			tracepoint_guard();				\
 			__DO_TRACE_CALL(name, TP_ARGS(args));		\
 		}							\
 	}								\
diff --git a/include/trace/perf.h b/include/trace/perf.h
index a1754b73a8f5..348ad1d9b556 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -71,6 +71,7 @@ perf_trace_##call(void *__data, proto)					\
 	u64 __count __attribute__((unused));				\
 	struct task_struct *__task __attribute__((unused));		\
 									\
+	guard(preempt_notrace)();					\
 	do_perf_trace_##call(__data, args);				\
 }
 
@@ -85,9 +86,8 @@ perf_trace_##call(void *__data, proto)					\
 	struct task_struct *__task __attribute__((unused));		\
 									\
 	might_fault();							\
-	preempt_disable_notrace();					\
+	guard(preempt_notrace)();					\
 	do_perf_trace_##call(__data, args);				\
-	preempt_enable_notrace();					\
 }
 
 /*
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 4f22136fd465..6fb58387e9f1 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -429,6 +429,22 @@ do_trace_event_raw_event_##call(void *__data, proto)			\
 	trace_event_buffer_commit(&fbuffer);				\
 }
 
+/*
+ * When PREEMPT_RT is enabled, the tracepoint does not disable preemption
+ * but instead disables migration. The callbacks for the trace events
+ * need to have a consistent state so that it can reflect the proper
+ * preempt_disabled counter.
+ */
+#ifdef CONFIG_PREEMPT_RT
+/* disable preemption for RT so that the counters still match */
+# define trace_event_guard() guard(preempt_notrace)()
+/* Have syscalls up the migrate disable counter to emulate non-syscalls */
+# define trace_syscall_event_guard() guard(migrate)()
+#else
+# define trace_event_guard()
+# define trace_syscall_event_guard()
+#endif
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
@@ -436,6 +452,7 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
 static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
 {									\
+	trace_event_guard();						\
 	do_trace_event_raw_event_##call(__data, args);			\
 }
 
@@ -447,9 +464,9 @@ static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
 {									\
 	might_fault();							\
-	preempt_disable_notrace();					\
+	trace_syscall_event_guard();					\
+	guard(preempt_notrace)();					\
 	do_trace_event_raw_event_##call(__data, args);			\
-	preempt_enable_notrace();					\
 }
 
 /*
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b16a5a158040..a5a93d243047 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -649,9 +649,9 @@ bool trace_event_ignore_this_pid(struct trace_event_file *trace_file)
 }
 EXPORT_SYMBOL_GPL(trace_event_ignore_this_pid);
 
-void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
-				 struct trace_event_file *trace_file,
-				 unsigned long len)
+static __always_inline void *buffer_reserve(struct trace_event_buffer *fbuffer,
+					    struct trace_event_file *trace_file,
+					    unsigned long len)
 {
 	struct trace_event_call *event_call = trace_file->event_call;
 
@@ -659,13 +659,6 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 	    trace_event_ignore_this_pid(trace_file))
 		return NULL;
 
-	/*
-	 * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
-	 * preemption (adding one to the preempt_count). Since we are
-	 * interested in the preempt_count at the time the tracepoint was
-	 * hit, we need to subtract one to offset the increment.
-	 */
-	fbuffer->trace_ctx = tracing_gen_ctx_dec();
 	fbuffer->trace_file = trace_file;
 
 	fbuffer->event =
@@ -679,8 +672,25 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 	fbuffer->entry = ring_buffer_event_data(fbuffer->event);
 	return fbuffer->entry;
 }
+
+void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
+				 struct trace_event_file *trace_file,
+				 unsigned long len)
+{
+	fbuffer->trace_ctx = tracing_gen_ctx_dec_cond();
+	return buffer_reserve(fbuffer, trace_file, len);
+}
 EXPORT_SYMBOL_GPL(trace_event_buffer_reserve);
 
+void *trace_event_buffer_reserve_syscall(struct trace_event_buffer *fbuffer,
+					 struct trace_event_file *trace_file,
+					 unsigned long len)
+{
+	fbuffer->trace_ctx = tracing_gen_ctx_dec();
+	return buffer_reserve(fbuffer, trace_file, len);
+}
+
+
 int trace_event_reg(struct trace_event_call *call,
 		    enum trace_reg type, void *data)
 {
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e96d0063cbcf..f330fd22ea78 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -909,7 +909,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	size += sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
 
-	entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
+	entry = trace_event_buffer_reserve_syscall(&fbuffer, trace_file, size);
 	if (!entry)
 		return;
 
@@ -955,7 +955,7 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	if (!sys_data)
 		return;
 
-	entry = trace_event_buffer_reserve(&fbuffer, trace_file, sizeof(*entry));
+	entry = trace_event_buffer_reserve_syscall(&fbuffer, trace_file, sizeof(*entry));
 	if (!entry)
 		return;
 
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 62719d2941c9..6a6bcf86bfbe 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -25,6 +25,12 @@ enum tp_func_state {
 extern tracepoint_ptr_t __start___tracepoints_ptrs[];
 extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
 
+/* In PREEMPT_RT, SRCU is used to protect the tracepoint callbacks */
+#ifdef CONFIG_PREEMPT_RT
+DEFINE_SRCU_FAST(tracepoint_srcu);
+EXPORT_SYMBOL_GPL(tracepoint_srcu);
+#endif
+
 enum tp_transition_sync {
 	TP_TRANSITION_SYNC_1_0_1,
 	TP_TRANSITION_SYNC_N_2_1,
@@ -34,6 +40,7 @@ enum tp_transition_sync {
 
 struct tp_transition_snapshot {
 	unsigned long rcu;
+	unsigned long srcu_gp;
 	bool ongoing;
 };
 
@@ -46,6 +53,9 @@ static void tp_rcu_get_state(enum tp_transition_sync sync)
 
 	/* Keep the latest get_state snapshot. */
 	snapshot->rcu = get_state_synchronize_rcu();
+#ifdef CONFIG_PREEMPT_RT
+	snapshot->srcu_gp = start_poll_synchronize_srcu(&tracepoint_srcu);
+#endif
 	snapshot->ongoing = true;
 }
 
@@ -56,6 +66,10 @@ static void tp_rcu_cond_sync(enum tp_transition_sync sync)
 	if (!snapshot->ongoing)
 		return;
 	cond_synchronize_rcu(snapshot->rcu);
+#ifdef CONFIG_PREEMPT_RT
+	if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu_gp))
+		synchronize_srcu(&tracepoint_srcu);
+#endif
 	snapshot->ongoing = false;
 }
 
@@ -101,10 +115,22 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
+#ifdef CONFIG_PREEMPT_RT
+static void srcu_free_old_probes(struct rcu_head *head)
+{
+	kfree(container_of(head, struct tp_probes, rcu));
+}
+
+static void rcu_free_old_probes(struct rcu_head *head)
+{
+	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
+}
+#else
 static void rcu_free_old_probes(struct rcu_head *head)
 {
 	kfree(container_of(head, struct tp_probes, rcu));
 }
+#endif
 
 static inline void release_probes(struct tracepoint *tp, struct tracepoint_func *old)
 {
@@ -112,6 +138,13 @@ static inline void release_probes(struct tracepoint *tp, struct tracepoint_func
 		struct tp_probes *tp_probes = container_of(old,
 			struct tp_probes, probes[0]);
 
+		/*
+		 * Tracepoint probes are protected by either RCU or
+		 * Tasks Trace RCU and also by SRCU.  By calling the SRCU
+		 * callback in the [Tasks Trace] RCU callback we cover
+		 * both cases. So let us chain the SRCU and [Tasks Trace]
+		 * RCU callbacks to wait for both grace periods.
+		 */
 		if (tracepoint_is_faultable(tp))
 			call_rcu_tasks_trace(&tp_probes->rcu, rcu_free_old_probes);
 		else
-- 
2.51.0


