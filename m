Return-Path: <bpf+bounces-69416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEB8B963AE
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16A53A6048
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1A3328565;
	Tue, 23 Sep 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OApka8aa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52C7327A17;
	Tue, 23 Sep 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637314; cv=none; b=IpUIQz5AhLI040GhK+kcYMITGhCLbK6Ycx+G10RfPebjhBYaI97jfwEfW9U58SAn5SNV8arpCXPJnEZuvGy9BszT2unvZaUv2w3fzG4DxkETshzOikyIcj39BICQuJ/0xZDJeAEsngk9Umt6aPIgUbWeMDsnI+Z/asKXZu5cQC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637314; c=relaxed/simple;
	bh=BRVx7fQjFG64Qiug5K5umKC5WWCM8o4bRG4z4HvlEEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bcgK5FImLL0dhGpk3GNwtwqiszMebHGQK1UaQ8yJoule3zp1Eri0D4KOzKMUJXFePXgAvLfidkjkbUqxRtcfjpVX0d25yrZloPxtoj2ELSkNvdfhiVD7rT7dpkhKqRDthN/qBa1nCTgN5NsRxMrIIr42PtB418ELXBDPL0kBpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OApka8aa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E3CC113D0;
	Tue, 23 Sep 2025 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637314;
	bh=BRVx7fQjFG64Qiug5K5umKC5WWCM8o4bRG4z4HvlEEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OApka8aalsFuqOpnme+RbDp7WChtnhdTjYyBgRE2zvyTWJ6IZiPLjICSoWiQARijg
	 H96sIbe7E7FRvaoYXORN1vX3CSy+J/13+drt/c/9TYi8ydnd6XYCW6S3JtaUm/mZWN
	 S4unj1Zg1c7tDTNxoRIjk1WCnEjImBHz77zizHFd2hz0N1aaLrrMXd00u4PfhzYZD1
	 k8SkCjaI6FiBDvo8utS/PhWuXivizSoC+TZhbY95q2qB4hrzFi7XUQtfc/k37lb3Ro
	 rleizDmIKCoMF/NNt4jp7c66ayD0WghxHeyYeHBnXz247jqMZYpuSEI8loD6+n+V2m
	 IAOKHf3GFuxHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E5447CE1538; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
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
Subject: [PATCH 18/34] rcu: Use smp_mb() only when necessary in RCU Tasks Trace readers
Date: Tue, 23 Sep 2025 07:20:20 -0700
Message-Id: <20250923142036.112290-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/rcupdate_trace.h | 32 ++++++++++++++++++--------------
 kernel/rcu/Kconfig             | 23 +++++++++++++++++++++++
 kernel/rcu/tasks.h             |  7 ++++++-
 3 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index b87151e6b23881..7f7977fb56aca5 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -48,10 +48,11 @@ static inline int rcu_read_lock_trace_held(void)
  */
 static inline struct srcu_ctr __percpu *rcu_read_lock_tasks_trace(void)
 {
-	struct srcu_ctr __percpu *ret = srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
+	struct srcu_ctr __percpu *ret = __srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
 
-	if (IS_ENABLED(CONFIG_ARCH_WANTS_NO_INSTR))
-		smp_mb();
+	rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
+	if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
+		smp_mb(); // Provide ordering on noinstr-incomplete architectures.
 	return ret;
 }
 
@@ -66,9 +67,10 @@ static inline struct srcu_ctr __percpu *rcu_read_lock_tasks_trace(void)
  */
 static inline void rcu_read_unlock_tasks_trace(struct srcu_ctr __percpu *scp)
 {
-	if (!IS_ENABLED(CONFIG_ARCH_WANTS_NO_INSTR))
-		smp_mb();
-	srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
+	if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
+		smp_mb(); // Provide ordering on noinstr-incomplete architectures.
+	__srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
+	srcu_lock_release(&rcu_tasks_trace_srcu_struct.dep_map);
 }
 
 /**
@@ -87,14 +89,15 @@ static inline void rcu_read_lock_trace(void)
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
@@ -111,13 +114,14 @@ static inline void rcu_read_unlock_trace(void)
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


