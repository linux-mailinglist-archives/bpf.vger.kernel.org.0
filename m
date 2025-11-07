Return-Path: <bpf+bounces-73924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B25AC3E2AB
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 02:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFE5188830E
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 01:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5D2FBDF2;
	Fri,  7 Nov 2025 01:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puL/7nUR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C11F12E0;
	Fri,  7 Nov 2025 01:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480435; cv=none; b=uG4wlaofNyffhvgH6uayodyh+17pS7ZOTHMkBfLEHKFDNkvEZJ85KaiIGeUyFgD6ysgVzh+1Ixf9VG8Vs5tln89D/OkUY870milFREuWBud7mU0aakPt8x5PXwWjkuagp3GrsMsoxON1Irj4QsyzTMYQFi7UHCUcq05saVJfSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480435; c=relaxed/simple;
	bh=iJycuDH3CYdzmK1MikEhih0s7V6q8ksbe8PiWxo6O6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXjw1hxvyZKvM0cTy+H7uOkqBfaF0hoQe50V7nl44cQz/9DFEbAp2VqIt3DWly9S4PKAEITVadOdZCkyXNiLdoYV+cFBwen61tFZVD1BbOc2y5t/5tOxrFCJPcoAaSoVolwQJjCAQxYvB/ep/cCJrkh+WKfTD8ILP6AcB9Ay0Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puL/7nUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FBCC4CEF7;
	Fri,  7 Nov 2025 01:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762480434;
	bh=iJycuDH3CYdzmK1MikEhih0s7V6q8ksbe8PiWxo6O6w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=puL/7nURx2xx5dHpd3dgrV0lT/3Dl+RRmn7BfvhoCkT+qEXZssd/j7iRRd3URFB+L
	 QiBEc3n++Su0HZzCUXVeYHpmjiR36LDyYSUW+1rJWAOpRx24xT7TBfEjYNc2eKVggn
	 b11NzTnJZ31bWw0m2JjLRD1uGy72zUkNB/aHDVsg+gYpSmALPfPc28SRfjdmlYnpBC
	 LTMoXYDuTIgmyeG89c1mEvI93BF9ANdTdaRSLZJoLkqVty4UFFU3p7Vnn9EpA4DgNq
	 JiSExpE41brwm4x4ZNFInvf5/1PIzIXu3fV/2JBTp9zLdHn20Csd6Ss0Q1sX5Ry3JZ
	 OhiJTDrcMNuKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4CFA5CE0B24; Thu,  6 Nov 2025 17:53:53 -0800 (PST)
Date: Thu, 6 Nov 2025 17:53:53 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org, frederic@kernel.org
Subject: Re: [PATCH v2 10/16] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <827c94b5-f10f-4fa2-a7d5-6f1097808d27@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <20251105203216.2701005-10-paulmck@kernel.org>
 <20251106110230.08e877ff@batman.local.home>
 <522b01cf-0cb6-4766-9102-2d08a3983d8a@paulmck-laptop>
 <20251106121005.76087677@gandalf.local.home>
 <eb59555d-f3e8-47c9-b519-a7b628e68885@paulmck-laptop>
 <20251106190314.5a43cc10@gandalf.local.home>
 <46365769-2b3a-4da1-a926-1b3e489d434a@paulmck-laptop>
 <20251106201644.3eef6a4a@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106201644.3eef6a4a@batman.local.home>

On Thu, Nov 06, 2025 at 08:16:44PM -0500, Steven Rostedt wrote:
> On Thu, 6 Nov 2025 17:04:33 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > 
> > > It gets a bit more confusing. We see "migrate disabled" (the last number)
> > > except when preemption is enabled.  
> > 
> > Huh.  Would something like "...11" indicate that both preemption and
> > migration are disabled?
> 
> Preemption was disabled when coming in.

OK.

> > >                                    That's because in your code, we only do
> > > the migrate dance when preemption is disabled:
> > >   
> > > > +			if (IS_ENABLED(CONFIG_PREEMPT_RT) && preemptible()) {	\  
> > 
> > You lost me on this one.  Wouldn't the "preemptible()" condition in that
> > "if" statement mean that migration is disabled only when preemption
> > is *enabled*?
> > 
> > What am I missing here?
> 
> So preemption is disabled when the event was hit. That would make
> "preemptible()" false, and we will then up the preempt_count again and
> not disable migration.
> 
> The code that records the preempt count expects the tracing code to
> increment the preempt_count, so it decrements it by one. Thus it records;
> 
>   ...1.
> 
> As migrate disable wasn't set.

Ah, thank you for the explanation.

> > > > +				guard(srcu_fast_notrace)(&tracepoint_srcu);	\
> > > > +				guard(migrate)();				\
> > > > +				__DO_TRACE_CALL(name, TP_ARGS(args));		\
> > > > +			} else {						\
> > > > +				guard(preempt_notrace)();			\
> > > > +				__DO_TRACE_CALL(name, TP_ARGS(args));		\
> > > > +			}  
> > > 
> > > And that will make accounting in the trace event callback much more
> > > difficult, when it's sometimes disabling migration and sometimes disabling
> > > preemption. It must do one or the other. It can't be conditional like that.
> > > 
> > > With my update below, it goes back to normal:
> > > 
> > >             bash-1040    [004] d..2.    49.339890: lock_release: 000000001d24683a tasklist_lock
> > >             bash-1040    [004] d..2.    49.339890: irq_enable: caller=_raw_write_unlock_irq+0x28/0x50 parent=0x0
> > >             bash-1040    [004] ...1.    49.339891: lock_release: 00000000246b21a5 rcu_read_lock
> > >             bash-1040    [004] .....    49.339891: lock_acquire: 0000000084e3738a read &mm->mmap_lock
> > >             bash-1040    [004] .....    49.339892: lock_release: 0000000084e3738a &mm->mmap_lock
> > >             bash-1040    [004] .....    49.339892: lock_acquire: 00000000f5b22878 read rcu_read_lock_trace
> > >             bash-1040    [004] .....    49.339892: lock_acquire: 0000000084e3738a read &mm->mmap_lock
> > >             bash-1040    [004] .....    49.339893: lock_release: 0000000084e3738a &mm->mmap_lock
> > >             bash-1040    [004] .....    49.339893: sys_exit: NR 109 = 0
> > >             bash-1040    [004] .....    49.339893: lock_acquire: 0000000084e3738a read &mm->mmap_lock
> > >             bash-1040    [004] .....    49.339894: lock_release: 0000000084e3738a &mm->mmap_lock
> > >             bash-1040    [004] .....    49.339894: sys_setpgid -> 0x0
> > >             bash-1040    [004] .....    49.339895: lock_release: 00000000f5b22878 rcu_read_lock_trace
> > >             bash-1040    [004] d....    49.339895: irq_disable: caller=do_syscall_64+0x37a/0x9a0 parent=0x0
> > >             bash-1040    [004] d....    49.339895: irq_enable: caller=do_syscall_64+0x167/0x9a0 parent=0x0
> > >             bash-1040    [004] d....    49.339897: irq_disable: caller=irqentry_enter+0x57/0x60 parent=0x0
> > > 
> > > I did some minor testing of this patch both with and without PREEMPT_RT
> > > enabled. This replaces this current patch. Feel free to use it.  
> > 
> > OK, I will add it with your SoB and give it a spin.  Thank you!
> 
> Signed-off-by: Steve Rostedt (Google) <rostedt@goodmis.org>

Again, thank you, and I will start up some testing as well.  Please see
below for an attempted commit log.

The SRCU commits that this depends on are slated for the upcoming
merge window, so we can work out the best way to send this upstreeam.
Whatever works.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit b6bf6a9f8b7237152c528ff27af4b17ccd26409f
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Jul 16 12:34:26 2025 -0700

    tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast
    
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
    
    [ paulmck: Apply kernel test robot and Yonghong Song feedback. ]
    
    Link: https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/
    Signed-off-by: Steve Rostedt (Google) <rostedt@goodmis.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Cc: <bpf@vger.kernel.org>

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
index 9f3e9537417d..c62c216aa445 100644
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
index 46aab0ab9350..8c74de83e926 100644
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
 
@@ -304,6 +316,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	 * buffer and per-cpu data require preemption to be disabled.
 	 */
 	might_fault();
+	preempt_rt_guard();
 	guard(preempt_notrace)();
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
@@ -350,6 +363,7 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
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

