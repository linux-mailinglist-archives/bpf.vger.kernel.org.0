Return-Path: <bpf+bounces-44637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D632A9C5B00
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 15:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661011F22858
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61568201254;
	Tue, 12 Nov 2024 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbZ6uZg4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96BB20110A;
	Tue, 12 Nov 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423166; cv=none; b=JndNwrO7awSG+eAgadsiX8bcLxavdcONW/pDzcC0cUmnJKVdRJhLKEtelPXEky4neUDQxgmunkOKi4KuEktEJjk+Sl544xH/KpOi2SRz+xtPTF6IDGSqEPOoZswtrylJACCFUndwwiPhxLiFj00EVVvlxcNj/9FsXVVWCVWrGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423166; c=relaxed/simple;
	bh=bGavktbS0y6IOUlaxf8zrMDlcwBDfIwStxF+Yf1IcC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SM9hlWRH8/NxuauPTWCjG6OVNIsSU5z99JUC/ngS3J9XS/dqgWBVarCvziSKDjTt/PsG72WnMxoG6YY+3ZqI5BX8p2U2npiIjlOtflKddg9ZsVtKphrqaSzLRQCpo/KK8ISt9KIod7xvXZQWjx4graWtScUIky8dIdAv8HyqdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbZ6uZg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993A5C4CED5;
	Tue, 12 Nov 2024 14:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423166;
	bh=bGavktbS0y6IOUlaxf8zrMDlcwBDfIwStxF+Yf1IcC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbZ6uZg4jKJq2uakfy+DBQf0EhEaBBtaiLkatmDhtTqAFVa+uKno7yqcmgKPkpsYp
	 yl73xNOy6jd/kTPOBO6/fbFE/yZmIQ+wOnxTrXKjyDjEyIxPOrpj4uUUFaoMwbXU6W
	 YBFWdr8ejxCKrGrQN4nag3FEVKJTSlp1iIwaWwIhIg4el3yeVfEUIjbxVSNb4EyUxQ
	 yVn92ZVDZVG2VoQIZE+dhaLQwjfRBx6MD2H9I4tIp1yu7S7p8XggORLfk7RF5qwJja
	 xVk0eX3qwrD+AGxFcZRmGjUcoAzRUpIzxpwFVyPBMBTogdQrytgUkPVz8EXED1KjlV
	 emOke24XiZuuQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 10/16] srcu: Allow inlining of __srcu_read_{,un}lock_lite()
Date: Tue, 12 Nov 2024 15:51:53 +0100
Message-ID: <20241112145159.23032-11-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112145159.23032-1-frederic@kernel.org>
References: <20241112145159.23032-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit moves __srcu_read_lock_lite() and __srcu_read_unlock_lite()
into include/linux/srcu.h and marks them "static inline" so that they
can be inlined into srcu_read_lock_lite() and srcu_read_unlock_lite(),
respectively.  They are not hand-inlined due to Tree SRCU and Tiny SRCU
having different implementations.

The earlier removal of smp_mb() combined with the inlining produce
significant single-percentage performance wins.

Link: https://lore.kernel.org/all/CAEf4BzYgiNmSb=ZKQ65tm6nJDi1UX2Gq26cdHSH1mPwXJYZj5g@mail.gmail.com/

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/srcutree.h | 39 ++++++++++++++++++++++++++++++++++++++
 kernel/rcu/srcutree.c    | 41 ----------------------------------------
 2 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 8074138cbd62..778eb61542e1 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -209,4 +209,43 @@ void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
 
+/*
+ * Counts the new reader in the appropriate per-CPU element of the
+ * srcu_struct.  Returns an index that must be passed to the matching
+ * srcu_read_unlock_lite().
+ *
+ * Note that this_cpu_inc() is an RCU read-side critical section either
+ * because it disables interrupts, because it is a single instruction,
+ * or because it is a read-modify-write atomic operation, depending on
+ * the whims of the architecture.
+ */
+static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
+{
+	int idx;
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
+	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
+	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter); /* Y */
+	barrier(); /* Avoid leaking the critical section. */
+	return idx;
+}
+
+/*
+ * Removes the count for the old reader from the appropriate
+ * per-CPU element of the srcu_struct.  Note that this may well be a
+ * different CPU than that which was incremented by the corresponding
+ * srcu_read_lock_lite(), but it must be within the same task.
+ *
+ * Note that this_cpu_inc() is an RCU read-side critical section either
+ * because it disables interrupts, because it is a single instruction,
+ * or because it is a read-modify-write atomic operation, depending on
+ * the whims of the architecture.
+ */
+static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
+{
+	barrier();  /* Avoid leaking the critical section. */
+	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);  /* Z */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
+}
+
 #endif
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 8632a3caeb33..d3a0c76ce590 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -763,47 +763,6 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
-/*
- * Counts the new reader in the appropriate per-CPU element of the
- * srcu_struct.  Returns an index that must be passed to the matching
- * srcu_read_unlock_lite().
- *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
- */
-int __srcu_read_lock_lite(struct srcu_struct *ssp)
-{
-	int idx;
-
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter); /* Y */
-	barrier(); /* Avoid leaking the critical section. */
-	return idx;
-}
-EXPORT_SYMBOL_GPL(__srcu_read_lock_lite);
-
-/*
- * Removes the count for the old reader from the appropriate
- * per-CPU element of the srcu_struct.  Note that this may well be a
- * different CPU than that which was incremented by the corresponding
- * srcu_read_lock_lite(), but it must be within the same task.
- *
- * Note that this_cpu_inc() is an RCU read-side critical section either
- * because it disables interrupts, because it is a single instruction,
- * or because it is a read-modify-write atomic operation, depending on
- * the whims of the architecture.
- */
-void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
-{
-	barrier();  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);  /* Z */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
-}
-EXPORT_SYMBOL_GPL(__srcu_read_unlock_lite);
-
 #ifdef CONFIG_NEED_SRCU_NMI_SAFE
 
 /*
-- 
2.46.0


