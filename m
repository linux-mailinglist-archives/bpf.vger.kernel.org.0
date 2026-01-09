Return-Path: <bpf+bounces-78276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACDCD06EA3
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 04:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BEFF30248A3
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 03:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318533195EA;
	Fri,  9 Jan 2026 03:05:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732101A9FB4;
	Fri,  9 Jan 2026 03:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767927957; cv=none; b=tq9CLTV5b+z0MvgFhyB9mOHMyyTui+zfoD1qndbG0qen7rBwhATfRpC7FeCfPbKCbnfpMfUYUurVtlEVFO4dKql1D8Hc+65YlaURvwkkuqKetS4w2+pAKwrr5/U+s+16GDxWF87Yc3e3tDPacWIp6+YxnsBr1AC0fpViPL/QeBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767927957; c=relaxed/simple;
	bh=+rEWV//8mME6tOSh2kmdANAoQVF+s2aJ3Vmbr4Kh3QA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=McBMqDsp1FAqwVo8jLn2WBTUWaN7yZAOVxJWS589iDj1bEJX9mY7az1AtdkdpvZNecskUKRhYezx6iVdzGdc6+Kn2Wq7+V7Rfk0Dk3L0eXUokZ29KRu7MgOhVGPZu2JTVKSb0yBaKwsqR5bFFp6rA7OJUa5HsQsVb3B6oj+gimU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 1AC9E1A0354;
	Fri,  9 Jan 2026 03:05:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 360682000D;
	Fri,  9 Jan 2026 03:05:52 +0000 (UTC)
Date: Thu, 8 Jan 2026 22:05:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20260108220550.2f6638f3@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ibfda1c8g7g1pxr1nb5d4w8zggcweubb
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 360682000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18imiyAyTL5j4Yi0Esz8fsl+ueqFmZJjm0=
X-HE-Tag: 1767927952-392533
X-HE-Meta: U2FsdGVkX19GUiWOAyC/jD/fGdWyjgPG+rMoFeiD3mre3vRvXgdVUiCr7OfWj5HmJmpA3inpiLP4RZ9ck8VssfloKfLcvvONmwfGqs0FVff4BeC7Z8J+p52QkygAMnh+0priVQYOmbW3V+AXZVvH4X3h9vBnJl46qav1MF6wBpoGrxjVKozEaBwIe1bmSFQdoPdm/mSXZpZYkbntD2YzqiC3ucnuhHfU8MvELkEZHtOIhD8xwYEcbliRPCQ4Co7DBtECVa/N9daOP3MA0/tpshK+aiTi8m5gvei9i9URSCyRuNWPflsUHepalsmFa7XVI7KPiQW2A+Ll5eUmoGYw5bZ+YxnFoyHNefllS9kFu5C50XUrMXKVD9S03IV7Fj2qRjgPyJYV853JBN+bjmzjSw==

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

Co-developed-by: Steve Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v4: https://lore.kernel.org/all/20251216120819.3499e00e@gandalf.local.home/

- Added kerneldoc to trace_event_buffer_reserve{_syscall}

- Restructured the tracepoint.c code to not have #ifdef within functions

 include/linux/trace_events.h  | 24 ++++++++++++++
 include/linux/tracepoint.h    | 25 ++++++++++++--
 include/trace/perf.h          |  4 +--
 include/trace/trace_events.h  | 21 ++++++++++--
 kernel/trace/trace_events.c   | 61 +++++++++++++++++++++++++++++------
 kernel/trace/trace_syscalls.c |  4 +--
 kernel/tracepoint.c           | 44 +++++++++++++++++++++++++
 7 files changed, 164 insertions(+), 19 deletions(-)

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
index 137b4d9bb116..758c8a4ec7c2 100644
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
@@ -679,8 +672,56 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 	fbuffer->entry = ring_buffer_event_data(fbuffer->event);
 	return fbuffer->entry;
 }
+
+/**
+ * trace_event_buffer_reserve - reserve space on the ring buffer for an event
+ * @fbuffer: information about how to save the event
+ * @trace_file: the instance file descriptor for the event
+ * @len: The length of the event
+ *
+ * The @fbuffer has information about the ring buffer and data will
+ * be added to it to be used by the call to trace_event_buffer_commit().
+ * The @trace_file is the desrciptor with information about the status
+ * of the given event for a specific trace_array instance.
+ * The @len is the length of data to save for the event.
+ *
+ * Returns a pointer to the data on the ring buffer or NULL if the
+ *   event was not reserved (event was filtered, too big, or the buffer
+ *   simply was disabled for write).
+ */
+void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
+				 struct trace_event_file *trace_file,
+				 unsigned long len)
+{
+	fbuffer->trace_ctx = tracing_gen_ctx_dec_cond();
+	return buffer_reserve(fbuffer, trace_file, len);
+}
 EXPORT_SYMBOL_GPL(trace_event_buffer_reserve);
 
+/**
+ * trace_event_buffer_reserve_syscall - reserve space for a syscall event
+ * @fbuffer: information about how to save the event
+ * @trace_file: the instance file descriptor for the event
+ * @len: The length of the event
+ *
+ * This behaves exactly the same as trace_event_buffer_reserve(), but
+ * needs to act slightly different for system call events when PREEMPT_RT
+ * is enabled. The way the preempt count and migration disabled are
+ * set is different than trace_event_buffer_reserve(), as normal events
+ * have migration disabled instead of preemption in PREEMPT_RT, system
+ * call events do not disable migrating but still disable preemption.
+ *
+ * Returns the same as trace_event_buffer_reserve().
+ */
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
index 62719d2941c9..17e11d91d029 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -34,9 +34,32 @@ enum tp_transition_sync {
 
 struct tp_transition_snapshot {
 	unsigned long rcu;
+	unsigned long srcu_gp;
 	bool ongoing;
 };
 
+/* In PREEMPT_RT, SRCU is used to protect the tracepoint callbacks */
+#ifdef CONFIG_PREEMPT_RT
+DEFINE_SRCU_FAST(tracepoint_srcu);
+EXPORT_SYMBOL_GPL(tracepoint_srcu);
+static inline void start_rt_synchronize(struct tp_transition_snapshot *snapshot)
+{
+	snapshot->srcu_gp = start_poll_synchronize_srcu(&tracepoint_srcu);
+}
+static inline void poll_rt_synchronize(struct tp_transition_snapshot *snapshot)
+{
+	if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu_gp))
+		synchronize_srcu(&tracepoint_srcu);
+}
+#else
+static inline void start_rt_synchronize(struct tp_transition_snapshot *snapshot)
+{
+}
+static inline void poll_rt_synchronize(struct tp_transition_snapshot *snapshot)
+{
+}
+#endif
+
 /* Protected by tracepoints_mutex */
 static struct tp_transition_snapshot tp_transition_snapshot[_NR_TP_TRANSITION_SYNC];
 
@@ -46,6 +69,7 @@ static void tp_rcu_get_state(enum tp_transition_sync sync)
 
 	/* Keep the latest get_state snapshot. */
 	snapshot->rcu = get_state_synchronize_rcu();
+	start_rt_synchronize(snapshot);
 	snapshot->ongoing = true;
 }
 
@@ -56,6 +80,7 @@ static void tp_rcu_cond_sync(enum tp_transition_sync sync)
 	if (!snapshot->ongoing)
 		return;
 	cond_synchronize_rcu(snapshot->rcu);
+	poll_rt_synchronize(snapshot);
 	snapshot->ongoing = false;
 }
 
@@ -101,10 +126,22 @@ static inline void *allocate_probes(int count)
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
@@ -112,6 +149,13 @@ static inline void release_probes(struct tracepoint *tp, struct tracepoint_func
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


