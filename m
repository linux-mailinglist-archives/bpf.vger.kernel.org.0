Return-Path: <bpf+bounces-73911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69BC3DF05
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 01:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCBF188705F
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 00:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD53217A2E8;
	Fri,  7 Nov 2025 00:03:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA6B2C9D;
	Fri,  7 Nov 2025 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473810; cv=none; b=XzY52MWz8AV4tHxmKRxhQ076sV6MmuLJgqn0Ah2HoR3lcGoVeEaTVj0WI3hl6ynV+9ULY8PTUYUb3q/0CY8QgaI8VJj7zV+pyczI7x6Pmgizuh2/ksAMdwFJG02fW4e0jkrjChAOkT/bZs4USqox7iT/B++ZDTRIWeeAKfe7YZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473810; c=relaxed/simple;
	bh=XkEqAbpWK1F/QeROk/YoCWEbTvCPTwUtq06/WbExako=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aI0a2/r4kx3jsVBqMY0jYY5pSPioumAnZ+PWJmun48WnyTadeGtXbxjOtAU1osNYske+cRZHqMjnU+ANBmE61HBT6d7cspay0Y0iV0tsrjICDmqDypzqfeUC6x36kTfF47GAJstST94h2znoUkMq0fzg8+qpk1SYoHcQTv23JQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 5855B1602E9;
	Fri,  7 Nov 2025 00:03:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 4B30B2000E;
	Fri,  7 Nov 2025 00:03:17 +0000 (UTC)
Date: Thu, 6 Nov 2025 19:03:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org, frederic@kernel.org
Subject: Re: [PATCH v2 10/16] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20251106190314.5a43cc10@gandalf.local.home>
In-Reply-To: <eb59555d-f3e8-47c9-b519-a7b628e68885@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
	<20251105203216.2701005-10-paulmck@kernel.org>
	<20251106110230.08e877ff@batman.local.home>
	<522b01cf-0cb6-4766-9102-2d08a3983d8a@paulmck-laptop>
	<20251106121005.76087677@gandalf.local.home>
	<eb59555d-f3e8-47c9-b519-a7b628e68885@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4B30B2000E
X-Stat-Signature: zc9e6rgd5xusdweu4gb5fnogzic9p9h1
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/L/2veC7BunS4aMCWe1Jwr0caXYicMHjY=
X-HE-Tag: 1762473797-145445
X-HE-Meta: U2FsdGVkX1//rXLqd7SwHVeLbChXQu+QgxB/IQabZfGLCd1QZW9hSE98HtOahPCyZF8QP5pHU3MlgIUG2DP23H+MBDUbBlZ14Wd2A9y5sPGJyf83fz5BmjNZqqaZvqqFUswnh0cvktsVfLj1wFi/PoiCqj3pf+yoTAILbA1sOUEsN0FLuVyIBB+O6/gB/XFDaWvNUFdD7bdwJBYfnLrFmNhxKGK2f6b5mMjt+6H/hJf7mEBqsiHC6S3eVL9IFY6Q+WaqROvf4Gm2X+3sYws3PnVkLL0OVtutjTrwf/PxIr6pqGTgb8raiX01lbOttRiI+dGsGNLqplN9YhKSMQiXYm1KXKpm22CE

On Thu, 6 Nov 2025 09:52:28 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Ah, thank you for the clarification!  Will do.

Actually, I was looking to get rid of that preempt disable in that syscall
code. You could use this patch instead. I made the necessary updates. It
still needs preemption disabled when PREEMPT_RT is not set, but this should
be fine, and hopefully doesn't conflict too badly with my own changes.

To get an idea, by blindly adding the preempt disable on non-RT we have this:

         chronyd-544     [006] ...1.   110.216639: lock_release: 0000000099631762 &mm->mmap_lock
         chronyd-544     [006] ...1.   110.216640: lock_acquire: 000000003660b68f read rcu_read_lock_trace
         chronyd-544     [006] ...1.   110.216641: lock_acquire: 0000000099631762 read &mm->mmap_lock
         chronyd-544     [006] ...1.   110.216641: lock_release: 0000000099631762 &mm->mmap_lock
         chronyd-544     [006] .....   110.216642: sys_exit: NR 270 = 0
         chronyd-544     [006] ...1.   110.216642: lock_acquire: 0000000099631762 read &mm->mmap_lock
         chronyd-544     [006] ...1.   110.216643: lock_release: 0000000099631762 &mm->mmap_lock
         chronyd-544     [006] .....   110.216643: sys_pselect6 -> 0x0
         chronyd-544     [006] ...1.   110.216644: lock_release: 000000003660b68f rcu_read_lock_trace
         chronyd-544     [006] d..1.   110.216644: irq_disable: caller=do_syscall_64+0x37a/0x9a0 parent=0x0
         chronyd-544     [006] d..1.   110.216645: irq_enable: caller=exit_to_user_mode_loop+0x57/0x140 parent=0x0
         chronyd-544     [006] ...1.   110.216646: lock_acquire: 0000000099631762 read &mm->mmap_lock

All those "...1." is the tracer saying that preempt was disabled when it
was not. The two without it ("....") are the syscall routines (which didn't
change).

Now with RT enabled:

 systemd-journal-435     [006] d..2.    63.884924: lock_release: 00000000ee02c684 &lock->wait_lock
 systemd-journal-435     [006] d..2.    63.884924: irq_enable: caller=_raw_spin_unlock_irqrestore+0x44/0x70 parent=0x0
 systemd-journal-435     [006] ....1    63.884926: lock_acquire: 00000000501e1144 read &mm->mmap_lock
 systemd-journal-435     [006] ....1    63.884926: lock_release: 00000000501e1144 &mm->mmap_lock
 systemd-journal-435     [006] ....1    63.884927: lock_acquire: 0000000000a1d734 read rcu_read_lock_trace
 systemd-journal-435     [006] ....1    63.884928: lock_acquire: 00000000501e1144 read &mm->mmap_lock
 systemd-journal-435     [006] ....1    63.884929: lock_release: 00000000501e1144 &mm->mmap_lock
 systemd-journal-435     [006] .....    63.884929: sys_exit: NR 232 = 1
 systemd-journal-435     [006] ....1    63.884929: lock_acquire: 00000000501e1144 read &mm->mmap_lock
 systemd-journal-435     [006] ....1    63.884930: lock_release: 00000000501e1144 &mm->mmap_lock
 systemd-journal-435     [006] .....    63.884930: sys_epoll_wait -> 0x1
 systemd-journal-435     [006] ....1    63.884931: lock_release: 0000000000a1d734 rcu_read_lock_trace
 systemd-journal-435     [006] d..1.    63.884931: irq_disable: caller=do_syscall_64+0x37a/0x9a0 parent=0x0
 systemd-journal-435     [006] d..1.    63.884932: irq_enable: caller=exit_to_user_mode_loop+0x57/0x140 parent=0x0
 systemd-journal-435     [006] ....1    63.884933: lock_acquire: 00000000501e1144 read &mm->mmap_lock
 systemd-journal-435     [006] ....1    63.884933: lock_release: 00000000501e1144 &mm->mmap_lock
 systemd-journal-435     [006] ....1    63.884934: lock_acquire: 00000000501e1144 read &mm->mmap_lock
 systemd-journal-435     [006] ....1    63.884935: lock_release: 00000000501e1144 &mm->mmap_lock
 systemd-journal-435     [006] ....1    63.884935: rseq_update: cpu_id=6 node_id=0 mm_cid=0
 systemd-journal-435     [006] d..1.    63.884936: irq_disable: caller=exit_to_user_mode_loop+0x3d/0x140 parent=0x0
 systemd-journal-435     [006] d..1.    63.884937: x86_fpu_regs_activated: x86/fpu: 00000000e86f3727 load: 1 xfeatures: 3 xcomp_bv: 0
 systemd-journal-435     [006] d..1.    63.884938: irq_enable: caller=do_syscall_64+0x167/0x9a0 parent=0x0
 systemd-journal-435     [006] d..1.    63.884944: irq_disable: caller=do_syscall_64+0x35/0x9a0 parent=0x0

It gets a bit more confusing. We see "migrate disabled" (the last number)
except when preemption is enabled. That's because in your code, we only do
the migrate dance when preemption is disabled:

> +			if (IS_ENABLED(CONFIG_PREEMPT_RT) && preemptible()) {	\
> +				guard(srcu_fast_notrace)(&tracepoint_srcu);	\
> +				guard(migrate)();				\
> +				__DO_TRACE_CALL(name, TP_ARGS(args));		\
> +			} else {						\
> +				guard(preempt_notrace)();			\
> +				__DO_TRACE_CALL(name, TP_ARGS(args));		\
> +			}

And that will make accounting in the trace event callback much more
difficult, when it's sometimes disabling migration and sometimes disabling
preemption. It must do one or the other. It can't be conditional like that.

With my update below, it goes back to normal:

            bash-1040    [004] d..2.    49.339890: lock_release: 000000001d24683a tasklist_lock
            bash-1040    [004] d..2.    49.339890: irq_enable: caller=_raw_write_unlock_irq+0x28/0x50 parent=0x0
            bash-1040    [004] ...1.    49.339891: lock_release: 00000000246b21a5 rcu_read_lock
            bash-1040    [004] .....    49.339891: lock_acquire: 0000000084e3738a read &mm->mmap_lock
            bash-1040    [004] .....    49.339892: lock_release: 0000000084e3738a &mm->mmap_lock
            bash-1040    [004] .....    49.339892: lock_acquire: 00000000f5b22878 read rcu_read_lock_trace
            bash-1040    [004] .....    49.339892: lock_acquire: 0000000084e3738a read &mm->mmap_lock
            bash-1040    [004] .....    49.339893: lock_release: 0000000084e3738a &mm->mmap_lock
            bash-1040    [004] .....    49.339893: sys_exit: NR 109 = 0
            bash-1040    [004] .....    49.339893: lock_acquire: 0000000084e3738a read &mm->mmap_lock
            bash-1040    [004] .....    49.339894: lock_release: 0000000084e3738a &mm->mmap_lock
            bash-1040    [004] .....    49.339894: sys_setpgid -> 0x0
            bash-1040    [004] .....    49.339895: lock_release: 00000000f5b22878 rcu_read_lock_trace
            bash-1040    [004] d....    49.339895: irq_disable: caller=do_syscall_64+0x37a/0x9a0 parent=0x0
            bash-1040    [004] d....    49.339895: irq_enable: caller=do_syscall_64+0x167/0x9a0 parent=0x0
            bash-1040    [004] d....    49.339897: irq_disable: caller=irqentry_enter+0x57/0x60 parent=0x0

I did some minor testing of this patch both with and without PREEMPT_RT
enabled. This replaces this current patch. Feel free to use it.

-- Steve

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 04307a19cde3..0a276e51d855 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -221,6 +221,26 @@ static inline unsigned int tracing_gen_ctx_dec(void)
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
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 826ce3f8e1f8..5294110c3e84 100644
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
@@ -266,12 +285,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		return static_branch_unlikely(&__tracepoint_##name.key);\
 	}
 
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto)			\
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
 	static inline void __do_trace_##name(proto)			\
 	{								\
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
index e00da4182deb..000665649fcb 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -659,13 +659,7 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
 	    trace_event_ignore_this_pid(trace_file))
 		return NULL;
 
-	/*
-	 * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
-	 * preemption (adding one to the preempt_count). Since we are
-	 * interested in the preempt_count at the time the tracepoint was
-	 * hit, we need to subtract one to offset the increment.
-	 */
-	fbuffer->trace_ctx = tracing_gen_ctx_dec();
+	fbuffer->trace_ctx = tracing_gen_ctx_dec_cond();
 	fbuffer->trace_file = trace_file;
 
 	fbuffer->event =
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 0f932b22f9ec..3f699b198c56 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -28,6 +28,18 @@ syscall_get_enter_fields(struct trace_event_call *call)
 	return &entry->enter_fields;
 }
 
+/*
+ * When PREEMPT_RT is enabled, it disables migration instead
+ * of preemption. The pseudo syscall trace events need to match
+ * so that the counter logic recorded into he ring buffer by
+ * trace_event_buffer_reserve() still matches what it expects.
+ */
+#ifdef CONFIG_PREEMPT_RT
+# define preempt_rt_guard()  guard(migrate)()
+#else
+# define preempt_rt_guard()
+#endif
+
 extern struct syscall_metadata *__start_syscalls_metadata[];
 extern struct syscall_metadata *__stop_syscalls_metadata[];
 
@@ -310,6 +322,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	 * buffer and per-cpu data require preemption to be disabled.
 	 */
 	might_fault();
+	preempt_rt_guard();
 	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
@@ -355,6 +368,7 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	 * buffer and per-cpu data require preemption to be disabled.
 	 */
 	might_fault();
+	preempt_rt_guard();
 	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
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

