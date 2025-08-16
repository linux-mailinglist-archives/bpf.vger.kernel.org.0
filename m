Return-Path: <bpf+bounces-65801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A59B4B28910
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 02:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F6916F300
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 00:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470821EB5B;
	Sat, 16 Aug 2025 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgNbBXrv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC8EAD24;
	Sat, 16 Aug 2025 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302761; cv=none; b=IU4vvbewKHSnr+5GPEW+/YS7U9HAbzzrsFYbwGif8p3WxnsSUxU/KfcWif/X8sjN2cSuD1BBBHLcww4CWW1uZxLNSWuWzrR+4knb8tpfOqvvbltvHMfxMzKs9J5Uj1rlyJtPP1t4Gt4vMCq7lL3H4SguhLOhxCRawGCE7cuA8qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302761; c=relaxed/simple;
	bh=Psrmv3HmCJPePj1DKWtPeo1mfeO4KSEh8kCtaDMB2GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTfoXCR+941T352i9eqfrgqB9N6+HdbbHiQuX5j517Fgh1F1os42PteFDc+wFh7EdRnEoirLCuufpqkfWrh34ECA+BUmrWhf0/KfaZFjy+pCKzgkyFzp6aVVXq66MoHqoCeoMNQHF2CwCo1j2ePVhHGI4bSJE5CyWPPcteKwphs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgNbBXrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FEAC4CEF5;
	Sat, 16 Aug 2025 00:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302761;
	bh=Psrmv3HmCJPePj1DKWtPeo1mfeO4KSEh8kCtaDMB2GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DgNbBXrvfy69vBlpGhBpJ1qdV1wRgolCGYc2T6MqhVrwzNwnrLfU0WL3brk1kHYYv
	 dEJr2KLXYiJeNTMwFftqZ7b0RUaWAYQBvJ+w/YQZiP6D+lNU1B2809sQibGN/b/5Vx
	 XyLgqXwaqi30MLB5hvOWwkejBwqPc3tsEHl12YMTeyrYb5Lqmwg7rdB8jRuG+5qIA8
	 fp5tC8dZB+4GLrEyWY/ZHYJ8Bvm00i8BvKyuQ5LJ3tJaLyB9ZRPCV5NXfaYGazUwEF
	 Z30RatPah7laH12cdp4cOY/B7GjT3x7gWU1ISjNoZm9xVRcgMT4LzpRoA5qIcK91mN
	 nt8vBCLoNlMzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8B7DACE0B6D; Fri, 15 Aug 2025 17:06:00 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v6 4/6] tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast
Date: Fri, 15 Aug 2025 17:05:57 -0700
Message-Id: <20250816000559.2622626-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b592a936-fd9e-4aef-a2af-9d40ae19511d@paulmck-laptop>
References: <b592a936-fd9e-4aef-a2af-9d40ae19511d@paulmck-laptop>
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
out by Steven Rostedt (thank you, Steven!).

[ Apply kernel test robot feedback. ]

Link: https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/tracepoint.h   |  6 ++++--
 include/trace/perf.h         |  2 ++
 include/trace/trace_events.h |  2 ++
 kernel/tracepoint.c          | 21 ++++++++++++++++++++-
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 826ce3f8e1f851..a22c1ab88560b8 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -33,6 +33,8 @@ struct trace_eval_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
+extern struct srcu_struct tracepoint_srcu;
+
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
@@ -115,7 +117,7 @@ void for_each_tracepoint_in_module(struct module *mod,
 static inline void tracepoint_synchronize_unregister(void)
 {
 	synchronize_rcu_tasks_trace();
-	synchronize_rcu();
+	synchronize_srcu(&tracepoint_srcu);
 }
 static inline bool tracepoint_is_faultable(struct tracepoint *tp)
 {
@@ -271,7 +273,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static inline void __do_trace_##name(proto)			\
 	{								\
 		if (cond) {						\
-			guard(preempt_notrace)();			\
+			guard(srcu_fast_notrace)(&tracepoint_srcu);	\
 			__DO_TRACE_CALL(name, TP_ARGS(args));		\
 		}							\
 	}								\
diff --git a/include/trace/perf.h b/include/trace/perf.h
index a1754b73a8f55b..1b7925a859665f 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -71,7 +71,9 @@ perf_trace_##call(void *__data, proto)					\
 	u64 __count __attribute__((unused));				\
 	struct task_struct *__task __attribute__((unused));		\
 									\
+	preempt_disable_notrace();					\
 	do_perf_trace_##call(__data, args);				\
+	preempt_enable_notrace();					\
 }
 
 #undef DECLARE_EVENT_SYSCALL_CLASS
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 4f22136fd4656c..0504a423ca2539 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -436,7 +436,9 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
 static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
 {									\
+	preempt_disable_notrace();					\
 	do_trace_event_raw_event_##call(__data, args);			\
+	preempt_enable_notrace();					\
 }
 
 #undef DECLARE_EVENT_SYSCALL_CLASS
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 62719d2941c900..e19973015cbd73 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -25,6 +25,9 @@ enum tp_func_state {
 extern tracepoint_ptr_t __start___tracepoints_ptrs[];
 extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
 
+DEFINE_SRCU(tracepoint_srcu);
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


