Return-Path: <bpf+bounces-73725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86333C37BE3
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F91F18C5118
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC3F34DB51;
	Wed,  5 Nov 2025 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bdm74BJn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63BC34AB15;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374740; cv=none; b=Q8ntBHSOJiEzXuFZA0udDarUoZt4Cq9pWmVgXsgiGx2fvF8S1Wu4zI+PR/EGf7rgPFMOPrALBbkmJb3ZVoCjR+lYVAyC7jU/rSz4xdpuJ8t1WitgceBEYMBaQkUVQuLDSiV0Cw0GNd5VqAfueo3L6ov8cdISXH03FK5aKtriduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374740; c=relaxed/simple;
	bh=MgE4NzahsQRutiZm/q0L791+QKh3LZkPzHRxKVcKPeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eITdbNE+SHBxzcFxJsWqVUmYivRnCmirYjSTHO0gF0tbOcl/YdoBGzvgf6TPrnpaNm5aXG7OtquwrUKOfpWA+0x30KHCTvxIAslPnTruKBDH/FQxsotFD9OkXolHixYspuyU+DnfbSNXPGLQogeonCYD9M0kBHITNjjjrsih0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bdm74BJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75232C19424;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374740;
	bh=MgE4NzahsQRutiZm/q0L791+QKh3LZkPzHRxKVcKPeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bdm74BJnJcdCtzT7ZQrLeyqf2ipXfd4FAsujMDHxo6fpT59s7FOPa/zQGXDArhxpc
	 h0zlbqYdmqFmrS4BW9ywPa/Rz2b1dPnkhQNpUBi9JTAM2iDv4s2rkFcnPYyG1gLRvy
	 akPdpnEO+EilxC5Dr3kC7HsH3REOE94LiaLqzrnKdicGELIxIvzZm1VA6ONOk5ZAko
	 V5+0WzSnEwB+KyH/4oiWc+QK2fBlEmtFPH6KxfinPKGhsZvN+0tuKbdKLr2E32FW41
	 3SMQzvBt9Fjovu8U7M1fJtRWVzYaAMj4dpLdTxtTmOHTZxXd+4kM24059ZJcXkMiHw
	 TXcqR/BlDQ2rA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9E837CE0F7E; Wed,  5 Nov 2025 12:32:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 10/16] tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast
Date: Wed,  5 Nov 2025 12:32:10 -0800
Message-Id: <20251105203216.2701005-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
readers than those of preemptible RCU, at least on my laptop, where
task_struct access is more expensive than access to per-CPU variables.
And SRCU fast provides way faster readers than does SRCU, courtesy of
being able to avoid the read-side use of smp_mb().  Also, it is quite
straightforward to create srcu_read_{,un}lock_fast_notrace() functions.

While in the area, SRCU now supports early boot call_srcu().  Therefore,
remove the checks that used to avoid such use from rcu_free_old_probes()
before this commit was applied:

e53244e2c893 ("tracepoint: Remove SRCU protection")

The current commit can be thought of as an approximate revert of that
commit, with some compensating additions of preemption disabling pointed
out by Steven Rostedt (thank you, Steven!).  This preemption disabling
uses guard(preempt_notrace)(), and while in the area a couple of other
use cases were also converted to guards.

However, Yonghong Song points out that BPF expects non-sleepable BPF
programs to remain on the same CPU, which means that migration must
be disabled whenever preemption remains enabled.  In addition, non-RT
kernels have performance expectations on BPF that would be violated
by allowing the BPF programs to be preempted.

Therefore, continue to disable preemption in non-RT kernels, and protect
the BPF program with both SRCU and migration disabling for RT kernels,
and even then only if preemption is not already disabled.

[ paulmck: Apply kernel test robot and Yonghong Song feedback. ]

Link: https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/tracepoint.h   | 45 ++++++++++++++++++++++--------------
 include/trace/perf.h         |  4 ++--
 include/trace/trace_events.h |  4 ++--
 kernel/tracepoint.c          | 21 ++++++++++++++++-
 4 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 826ce3f8e1f8..9f8b19cd303a 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -33,6 +33,8 @@ struct trace_eval_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
+extern struct srcu_struct tracepoint_srcu;
+
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
@@ -115,7 +117,10 @@ void for_each_tracepoint_in_module(struct module *mod,
 static inline void tracepoint_synchronize_unregister(void)
 {
 	synchronize_rcu_tasks_trace();
-	synchronize_rcu();
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		synchronize_srcu(&tracepoint_srcu);
+	else
+		synchronize_rcu();
 }
 static inline bool tracepoint_is_faultable(struct tracepoint *tp)
 {
@@ -266,23 +271,29 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		return static_branch_unlikely(&__tracepoint_##name.key);\
 	}
 
-#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto)			\
 	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
-	static inline void __do_trace_##name(proto)			\
-	{								\
-		if (cond) {						\
-			guard(preempt_notrace)();			\
-			__DO_TRACE_CALL(name, TP_ARGS(args));		\
-		}							\
-	}								\
-	static inline void trace_##name(proto)				\
-	{								\
-		if (static_branch_unlikely(&__tracepoint_##name.key))	\
-			__do_trace_##name(args);			\
-		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
-			WARN_ONCE(!rcu_is_watching(),			\
-				  "RCU not watching for tracepoint");	\
-		}							\
+	static inline void __do_trace_##name(proto)				\
+	{									\
+		if (cond) {							\
+			if (IS_ENABLED(CONFIG_PREEMPT_RT) && preemptible()) {	\
+				guard(srcu_fast_notrace)(&tracepoint_srcu);	\
+				guard(migrate)();				\
+				__DO_TRACE_CALL(name, TP_ARGS(args));		\
+			} else {						\
+				guard(preempt_notrace)();			\
+				__DO_TRACE_CALL(name, TP_ARGS(args));		\
+			}							\
+		}								\
+	}									\
+	static inline void trace_##name(proto)					\
+	{									\
+		if (static_branch_unlikely(&__tracepoint_##name.key))		\
+			__do_trace_##name(args);				\
+		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {			\
+			WARN_ONCE(!rcu_is_watching(),				\
+				  "RCU not watching for tracepoint");		\
+		}								\
 	}
 
 #define __DECLARE_TRACE_SYSCALL(name, proto, args, data_proto)		\
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
index 4f22136fd465..fbc07d353be6 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -436,6 +436,7 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
 static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
 {									\
+	guard(preempt_notrace)();					\
 	do_trace_event_raw_event_##call(__data, args);			\
 }
 
@@ -447,9 +448,8 @@ static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
 {									\
 	might_fault();							\
-	preempt_disable_notrace();					\
+	guard(preempt_notrace)();					\
 	do_trace_event_raw_event_##call(__data, args);			\
-	preempt_enable_notrace();					\
 }
 
 /*
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 62719d2941c9..21bb67798214 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -25,6 +25,9 @@ enum tp_func_state {
 extern tracepoint_ptr_t __start___tracepoints_ptrs[];
 extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
 
+DEFINE_SRCU_FAST(tracepoint_srcu);
+EXPORT_SYMBOL_GPL(tracepoint_srcu);
+
 enum tp_transition_sync {
 	TP_TRANSITION_SYNC_1_0_1,
 	TP_TRANSITION_SYNC_N_2_1,
@@ -34,6 +37,7 @@ enum tp_transition_sync {
 
 struct tp_transition_snapshot {
 	unsigned long rcu;
+	unsigned long srcu_gp;
 	bool ongoing;
 };
 
@@ -46,6 +50,7 @@ static void tp_rcu_get_state(enum tp_transition_sync sync)
 
 	/* Keep the latest get_state snapshot. */
 	snapshot->rcu = get_state_synchronize_rcu();
+	snapshot->srcu_gp = start_poll_synchronize_srcu(&tracepoint_srcu);
 	snapshot->ongoing = true;
 }
 
@@ -56,6 +61,8 @@ static void tp_rcu_cond_sync(enum tp_transition_sync sync)
 	if (!snapshot->ongoing)
 		return;
 	cond_synchronize_rcu(snapshot->rcu);
+	if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu_gp))
+		synchronize_srcu(&tracepoint_srcu);
 	snapshot->ongoing = false;
 }
 
@@ -101,17 +108,29 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void rcu_free_old_probes(struct rcu_head *head)
+static void srcu_free_old_probes(struct rcu_head *head)
 {
 	kfree(container_of(head, struct tp_probes, rcu));
 }
 
+static void rcu_free_old_probes(struct rcu_head *head)
+{
+	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
+}
+
 static inline void release_probes(struct tracepoint *tp, struct tracepoint_func *old)
 {
 	if (old) {
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
2.40.1


