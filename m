Return-Path: <bpf+bounces-64214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6871B0FB71
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 22:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E39797B835C
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 20:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EC223814C;
	Wed, 23 Jul 2025 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKOJ7H/J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD7230D1E;
	Wed, 23 Jul 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302484; cv=none; b=VXRgaFmTJboK7SBXYUSFsyZkcE2aBEI+okrTpJwhiuDFM3TDiVNJuV9pADNae7vaFG0NgWg8drwTzHQaA1PbZ/3+QXEIYNGDead9zM5c9q5J04/f3fJMFfscMZgT06U+AhCP2ZyKNPgGHVUup9di6D/k6yE/sTcA/f0cY/JeQCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302484; c=relaxed/simple;
	bh=B72QdzJwtONRhRvW5/jVEQT6uL4Kvid6Z1j8Kvnv3hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGEkeC8+Vjt4zjYVyolPUb7O/S++l8p3rTzU7Ux2FIJrF68ZhYNcZKCUD4oOd+aER15zuOk0DZFz32dkrBC7HKFVN4s0wb3brR0bnEL+05PisjFG6Wp3s7UYSO2Ejy+y8C6sAVrPNaW6cp9qTBqj/LokTZnYtqAbdrKpcFmi8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKOJ7H/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F867C4CEF8;
	Wed, 23 Jul 2025 20:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753302484;
	bh=B72QdzJwtONRhRvW5/jVEQT6uL4Kvid6Z1j8Kvnv3hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKOJ7H/JnDJLonx5BHAgJYDxOj5fegWwXnFRbwweKT/BVqa7PWX49o8AbuU6mMfL8
	 VaklSQ+iAFTI3k9p2sMgaSjxKEDD0sl89cLIhCeJ7QDMEqUS3Pz66wIGXJ5eDjo9Ns
	 YEpkrM1awkhdgHOQEBtvDI10aoPKV0L1jqWaMcGUr+o/hAsHkvhZFDN59rJ4PS5Oxv
	 NZzlRVsaV1sUgaMHJsk+mFS6tqenzpSaNVXjTV2wbmIZdiAxY6UvvR0h2c0gj2DCR9
	 lQ5P+XXm8R7Ho+9SgEyBhOWgCgyseUKl91oJXNjKTCl0IQ0JcEaJkftba3OwgiC1TF
	 KRzqmPrguvL6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0E077CE0B66; Wed, 23 Jul 2025 13:28:04 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v4 4/6] tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast
Date: Wed, 23 Jul 2025 13:27:58 -0700
Message-Id: <20250723202800.2094614-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
References: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
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
commit.

Link: https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/tracepoint.h |  6 ++++--
 kernel/tracepoint.c        | 21 ++++++++++++++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 826ce3f8e1f85..a22c1ab88560b 100644
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
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 62719d2941c90..e19973015cbd7 100644
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


