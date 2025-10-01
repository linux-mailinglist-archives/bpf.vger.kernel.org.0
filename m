Return-Path: <bpf+bounces-70094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C66BB0D01
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470353B48B2
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA5B3043DA;
	Wed,  1 Oct 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ2bspef"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B9303A21;
	Wed,  1 Oct 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330119; cv=none; b=MVNP40sLZgVTTC/s6muF/TcnBqetVQPEu2rVEC8eusREzh8BJG7qy8GcrO4wezZtk23mRJsN0zzdWejZJ7I6S/ruARjjAzd8fBvYAOAatRYJUihy5Eru2AhcGzq1Sqaey88eVep8UBJeet8Gn17rrY9xrUp4urnIlYaBHdXpM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330119; c=relaxed/simple;
	bh=MKbdfKwt7gETlTpQcusETrFaTqFUQmuaJ62gW5Sy6jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pS+Qm/6szNEVDIBVoMvR0xxpwoiba8pKZ/nWECk1Pz0WofeJnwY8mktDTdNMMfkK8TY32t/3uNsIsB/NTP4qbYmkAWfJBhBlnqN8UepeSKg7FqGQwYv0wa8TQTcwlXHfxx/i8U6OxIQPJjSadz2O0Q4qNavkVqMKXjYjqIyMDdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ2bspef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C7BC4CEF5;
	Wed,  1 Oct 2025 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330119;
	bh=MKbdfKwt7gETlTpQcusETrFaTqFUQmuaJ62gW5Sy6jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RJ2bspefEOoYwaLOhz3VsRwtSg17mm5cx1VGVIVZwh+9T+JW8vY+CHTpvzIyJgCLY
	 NjbjoDdFaN3acRpjF8dTMH0jFZ49dINaNrR1tpT1O89GSwxlMNqqaLsW20+2H2VIX0
	 mJjQN+3VGdOMAc6b0WIz2Njblhij4gug9zp2dQORwZt8+c9vTDHfmQO6CpfmUn+pkr
	 S8aa/+SXpgEy2GHmgclekOOX8Q0snV0xiCAaPbpM5JzbpETTGGLthR5k3HPpnqGvjO
	 g0abQWr1iPK/SJw/QFr0/ymsdTEK02sbV1sYAgelvSplrVVotbUnt5U9QqcWK01+j1
	 EvQPOYwqlBjHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 75647CE125B; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH v2 08/21] rcu: Add noinstr-fast rcu_read_{,un}lock_tasks_trace() APIs
Date: Wed,  1 Oct 2025 07:48:19 -0700
Message-Id: <20251001144832.631770-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When expressing RCU Tasks Trace in terms of SRCU-fast, it was
necessary to keep a nesting count and per-CPU srcu_ctr structure
pointer in the task_struct structure, which is slow to access.
But an alternative is to instead make rcu_read_lock_tasks_trace() and
rcu_read_unlock_tasks_trace(), which match the underlying SRCU-fast
semantics, avoiding the task_struct accesses.

When all callers have switched to the new API, the previous
rcu_read_lock_trace() and rcu_read_unlock_trace() APIs will be removed.

The rcu_read_{,un}lock_{,tasks_}trace() functions need to use smp_mb()
only if invoked where RCU is not watching, that is, from locations where
a call to rcu_is_watching() would return false.  In architectures that
define the ARCH_WANTS_NO_INSTR Kconfig option, use of noinstr and friends
ensures that tracing happens only where RCU is watching, so those
architectures can dispense entirely with the read-side calls to smp_mb().

Other architectures include these read-side calls by default, but in many
installations there might be either larger than average tolerance for
risk, prohibition of removing tracing on a running system, or careful
review and approval of removing of tracing.  Such installations can
build their kernels with CONFIG_TASKS_TRACE_RCU_NO_MB=y to avoid those
read-side calls to smp_mb(), thus accepting responsibility for run-time
removal of tracing from code regions that RCU is not watching.

Those wishing to disable read-side memory barriers for an entire
architecture can select this TASKS_TRACE_RCU_NO_MB Kconfig option,
hence the polarity.

[ paulmck: Apply Peter Zijlstra feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/rcupdate_trace.h | 65 +++++++++++++++++++++++++++++-----
 kernel/rcu/Kconfig             | 23 ++++++++++++
 kernel/rcu/tasks.h             |  7 +++-
 3 files changed, 86 insertions(+), 9 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 0bd47f12ecd17b..f47ba9c074601c 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -34,6 +34,53 @@ static inline int rcu_read_lock_trace_held(void)
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 
+/**
+ * rcu_read_lock_tasks_trace - mark beginning of RCU-trace read-side critical section
+ *
+ * When synchronize_rcu_tasks_trace() is invoked by one task, then that
+ * task is guaranteed to block until all other tasks exit their read-side
+ * critical sections.  Similarly, if call_rcu_trace() is invoked on one
+ * task while other tasks are within RCU read-side critical sections,
+ * invocation of the corresponding RCU callback is deferred until after
+ * the all the other tasks exit their critical sections.
+ *
+ * For more details, please see the documentation for
+ * srcu_read_lock_fast().  For a description of how implicit RCU
+ * readers provide the needed ordering for architectures defining the
+ * ARCH_WANTS_NO_INSTR Kconfig option (and thus promising never to trace
+ * code where RCU is not watching), please see the __srcu_read_lock_fast()
+ * (non-kerneldoc) header comment.  Otherwise, the smp_mb() below provided
+ * the needed ordering.
+ */
+static inline struct srcu_ctr __percpu *rcu_read_lock_tasks_trace(void)
+{
+	struct srcu_ctr __percpu *ret = __srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
+
+	rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
+	if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
+		smp_mb(); // Provide ordering on noinstr-incomplete architectures.
+	return ret;
+}
+
+/**
+ * rcu_read_unlock_tasks_trace - mark end of RCU-trace read-side critical section
+ * @scp: return value from corresponding rcu_read_lock_tasks_trace().
+ *
+ * Pairs with the preceding call to rcu_read_lock_tasks_trace() that
+ * returned the value passed in via scp.
+ *
+ * For more details, please see the documentation for rcu_read_unlock().
+ * For memory-ordering information, please see the header comment for the
+ * rcu_read_lock_tasks_trace() function.
+ */
+static inline void rcu_read_unlock_tasks_trace(struct srcu_ctr __percpu *scp)
+{
+	if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
+		smp_mb(); // Provide ordering on noinstr-incomplete architectures.
+	__srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
+	srcu_lock_release(&rcu_tasks_trace_srcu_struct.dep_map);
+}
+
 /**
  * rcu_read_lock_trace - mark beginning of RCU-trace read-side critical section
  *
@@ -50,14 +97,15 @@ static inline void rcu_read_lock_trace(void)
 {
 	struct task_struct *t = current;
 
+	rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
 	if (t->trc_reader_nesting++) {
 		// In case we interrupted a Tasks Trace RCU reader.
-		rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
 		return;
 	}
 	barrier();  // nesting before scp to protect against interrupt handler.
-	t->trc_reader_scp = srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
-	smp_mb(); // Placeholder for more selective ordering
+	t->trc_reader_scp = __srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
+	if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
+		smp_mb(); // Placeholder for more selective ordering
 }
 
 /**
@@ -74,13 +122,14 @@ static inline void rcu_read_unlock_trace(void)
 	struct srcu_ctr __percpu *scp;
 	struct task_struct *t = current;
 
-	smp_mb(); // Placeholder for more selective ordering
 	scp = t->trc_reader_scp;
 	barrier();  // scp before nesting to protect against interrupt handler.
-	if (!--t->trc_reader_nesting)
-		srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
-	else
-		srcu_lock_release(&rcu_tasks_trace_srcu_struct.dep_map);
+	if (!--t->trc_reader_nesting) {
+		if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
+			smp_mb(); // Placeholder for more selective ordering
+		__srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
+	}
+	srcu_lock_release(&rcu_tasks_trace_srcu_struct.dep_map);
 }
 
 /**
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 73a6cc364628b5..6a319e2926589f 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -142,6 +142,29 @@ config TASKS_TRACE_RCU
 	default n
 	select IRQ_WORK
 
+config TASKS_TRACE_RCU_NO_MB
+	bool "Override RCU Tasks Trace inclusion of read-side memory barriers"
+	depends on RCU_EXPERT && TASKS_TRACE_RCU
+	default ARCH_WANTS_NO_INSTR
+	help
+	  This option prevents the use of read-side memory barriers in
+	  rcu_read_lock_tasks_trace() and rcu_read_unlock_tasks_trace()
+	  even in kernels built with CONFIG_ARCH_WANTS_NO_INSTR=n, that is,
+	  in kernels that do not have noinstr set up in entry/exit code.
+	  By setting this option, you are promising to carefully review
+	  use of ftrace, BPF, and friends to ensure that no tracing
+	  operation is attached to a function that runs in that portion
+	  of the entry/exit code that RCU does not watch, that is,
+	  where rcu_is_watching() returns false.  Alternatively, you
+	  might choose to never remove traces except by rebooting.
+
+	  Those wishing to disable read-side memory barriers for an entire
+	  architecture can select this Kconfig option, hence the polarity.
+
+	  Say Y here if you need speed and will review use of tracing.
+	  Say N here for certain esoteric testing of RCU itself.
+	  Take the default if you are unsure.
+
 config RCU_STALL_COMMON
 	def_bool TREE_RCU
 	help
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 833e180db744f2..bf1226834c9423 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1600,8 +1600,13 @@ static inline void rcu_tasks_bootup_oddness(void) {}
 // Tracing variant of Tasks RCU.  This variant is designed to be used
 // to protect tracing hooks, including those of BPF.  This variant
 // is implemented via a straightforward mapping onto SRCU-fast.
+// DEFINE_SRCU_FAST() is required because rcu_read_lock_trace() must
+// use __srcu_read_lock_fast() in order to bypass the rcu_is_watching()
+// checks in kernels built with CONFIG_TASKS_TRACE_RCU_NO_MB=n, which also
+// bypasses the srcu_check_read_flavor_force() that would otherwise mark
+// rcu_tasks_trace_srcu_struct as needing SRCU-fast readers.
 
-DEFINE_SRCU(rcu_tasks_trace_srcu_struct);
+DEFINE_SRCU_FAST(rcu_tasks_trace_srcu_struct);
 EXPORT_SYMBOL_GPL(rcu_tasks_trace_srcu_struct);
 
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
-- 
2.40.1


