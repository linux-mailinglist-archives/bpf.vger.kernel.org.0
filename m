Return-Path: <bpf+bounces-68769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8FFB8413E
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 12:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B3C1B2140B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C742F5A23;
	Thu, 18 Sep 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvBA8nrq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AFE2773F0;
	Thu, 18 Sep 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191207; cv=none; b=mpkJvcDObtpwP0UWGOPryLJKk7W7mP0Hfpbg4xJQv2ZLDMmPiS1qBlHlO7U3euze2VI8ApDQQV2CGjkjM+YaOeEDaaw3IGQOKLwpEuwcm8UUskTehSL3fYvQvhdGA5G9I3UhnUdYNtVw+8Ot32xVdncFKCO8+bTNJpYRZ6IGzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191207; c=relaxed/simple;
	bh=v7iUSj7Qthedvqy0Qh8t0G4dno7vMWETYPwH31KRU0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=csdbJypnU2bb+QZHwdlTtosXHPbnpSlqjVgvj66dFfb8Cq+fmykzzKEO/faN36jz2oqA3utera0YDs8Jn46A/dYr74sXERwR1irWmDYtyH56QGe2a3TK8vSbOmanp1LQ6xfrbt48lMZ/vohq3zqmP9DJ0ld0YjcOKLnB2uKX8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvBA8nrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D85C4CEFA;
	Thu, 18 Sep 2025 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191207;
	bh=v7iUSj7Qthedvqy0Qh8t0G4dno7vMWETYPwH31KRU0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvBA8nrquF9CBjPb4mvzgD8sMOShsLDvoIFoeV9Nkk+U0MigU8AFrqo5WfaFyPM/y
	 1hbFl9S+CLbEsaTZ5dan/3dqUHbqIfE1J4+iVLTNtlUI6Ts4AvRO62QxaTkRU+rLUH
	 EJ8JPv34HGX8QT/CwLXvYKbc2Jz5YQBKFZquCx+Qg+LoXDK+ZNZGJ+XDyQxvyixIYJ
	 ObFeLPxkG0GpZ0PerYnT5TV2pMpBRktnEcsh21xjpTbAoqtIFN0AxDmUhZzqoUYjt3
	 8H7Et6OowIgPCu6/V/sIB2T2xlt8ayIb0PVI+yPNaP+Mi8N+rJa+DvOJ1eduqKYbnH
	 aiQoOc1jJ/jDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EC4BCCE0F82; Thu, 18 Sep 2025 03:26:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 4/6] srcu: Document __srcu_read_{,un}lock_fast() implicit RCU readers
Date: Thu, 18 Sep 2025 03:26:44 -0700
Message-Id: <20250918102646.2592821-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <89b6f92e-2aa6-4869-ad4f-47bb3fbadfbb@paulmck-laptop>
References: <89b6f92e-2aa6-4869-ad4f-47bb3fbadfbb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit documents the implicit RCU readers that are implied by the
this_cpu_inc() and atomic_long_inc() operations in __srcu_read_lock_fast()
and __srcu_read_unlock_fast().  While in the area, fix the documentation
of the memory pairing of atomic_long_inc() in __srcu_read_lock_fast().

[ paulmck: Apply Joel Fernandes feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcutree.h | 42 ++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 4d2fee4d38289f..42098e0fa0b7dd 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -232,9 +232,27 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
  * srcu_read_unlock_fast().
  *
  * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
- * critical sections either because they disables interrupts, because they
- * are a single instruction, or because they are a read-modify-write atomic
- * operation, depending on the whims of the architecture.
+ * critical sections either because they disables interrupts, because
+ * they are a single instruction, or because they are read-modify-write
+ * atomic operations, depending on the whims of the architecture.
+ * This matters because the SRCU-fast grace-period mechanism uses either
+ * synchronize_rcu() or synchronize_rcu_expedited(), that is, RCU,
+ * *not* SRCU, in order to eliminate the need for the read-side smp_mb()
+ * invocations that are used by srcu_read_lock() and srcu_read_unlock().
+ * The __srcu_read_unlock_fast() function also relies on this same RCU
+ * (again, *not* SRCU) trick to eliminate the need for smp_mb().
+ *
+ * The key point behind this RCU trick is that if any part of a given
+ * RCU reader precedes the beginning of a given RCU grace period, then
+ * the entirety of that RCU reader and everything preceding it happens
+ * before the end of that same RCU grace period.  Similarly, if any part
+ * of a given RCU reader follows the end of a given RCU grace period,
+ * then the entirety of that RCU reader and everything following it
+ * happens after the beginning of that same RCU grace period.  Therefore,
+ * the operations labeled Y in __srcu_read_lock_fast() and those labeled Z
+ * in __srcu_read_unlock_fast() are ordered against the corresponding SRCU
+ * read-side critical section from the viewpoint of the SRCU grace period.
+ * This is all the ordering that is required, hence no calls to smp_mb().
  *
  * This means that __srcu_read_lock_fast() is not all that fast
  * on architectures that support NMIs but do not supply NMI-safe
@@ -245,9 +263,9 @@ static inline struct srcu_ctr __percpu notrace *__srcu_read_lock_fast(struct src
 	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
 	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		this_cpu_inc(scp->srcu_locks.counter); /* Y */
+		this_cpu_inc(scp->srcu_locks.counter); // Y, and implicit RCU reader.
 	else
-		atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  /* Z */
+		atomic_long_inc(raw_cpu_ptr(&scp->srcu_locks));  // Y, and implicit RCU reader.
 	barrier(); /* Avoid leaking the critical section. */
 	return scp;
 }
@@ -258,23 +276,17 @@ static inline struct srcu_ctr __percpu notrace *__srcu_read_lock_fast(struct src
  * different CPU than that which was incremented by the corresponding
  * srcu_read_lock_fast(), but it must be within the same task.
  *
- * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
- * critical sections either because they disables interrupts, because they
- * are a single instruction, or because they are a read-modify-write atomic
- * operation, depending on the whims of the architecture.
- *
- * This means that __srcu_read_unlock_fast() is not all that fast
- * on architectures that support NMIs but do not supply NMI-safe
- * implementations of this_cpu_inc().
+ * Please see the __srcu_read_lock_fast() function's header comment for
+ * information on implicit RCU readers and NMI safety.
  */
 static inline void notrace
 __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
 {
 	barrier();  /* Avoid leaking the critical section. */
 	if (!IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
+		this_cpu_inc(scp->srcu_unlocks.counter);  // Z, and implicit RCU reader.
 	else
-		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  /* Z */
+		atomic_long_inc(raw_cpu_ptr(&scp->srcu_unlocks));  // Z, and implicit RCU reader.
 }
 
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
-- 
2.40.1


