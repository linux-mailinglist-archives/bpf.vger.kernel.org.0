Return-Path: <bpf+bounces-41766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA199AA8C
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515DF28423C
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103EF1CFED5;
	Fri, 11 Oct 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sm2Yv2Ih"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C251C7B6F;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668373; cv=none; b=JxeKvSjalUCkUQRINOgRpjj2XIvD6+PvI9stlmLMfHNWzSKUwl3Zj9VL2p8gY36PNNmCMdI5JZi0npM5AgAlSUX8v2vesWedKOr7NY9cGdoRyyzATyvSYHONYHnD4vsQbwcZb7Afzh6rG0VLtlWVIUpdYRsJMmp0EBrnrm1X9wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668373; c=relaxed/simple;
	bh=LFRisZMxRbIMr0KIalT12nZOMI5l1WeI4c/6S81vXZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRcz4Nm+h1S9e8M3cVGpUJoKawdHeYu8Q1BThi+MAUDr2ARETIw1P17x6fwVdJpw4YE9bH0KFmlhUCR4AMM2sWde+GWZzRsvFX3yVY+CSDjXQuIt29UCQsFxWMAxWH/lz4YbHp8rWDY8644BJofgfBt0kOYWKwYFcKNoSkT8wbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sm2Yv2Ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEF5C4CEDC;
	Fri, 11 Oct 2024 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728668373;
	bh=LFRisZMxRbIMr0KIalT12nZOMI5l1WeI4c/6S81vXZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sm2Yv2IhK9/MC9wYy2QAb6Q7iUpUqYCTlMv2o//0E8M7YnLcH3NXGHIyIDWqC8Qlb
	 l8YJg7KAV/hH5WRaUbPaA3+ZZ1XDPTR17XtzvUDsRP60DKUbUeBZluQv0Dqg0pMCBH
	 lX+JSs35wqPRGGhIBwubWS/YfF7HoMidcVIEGd+Q3tO2F9p7L2Ri/v0N5OvIF8IyGq
	 6kXZC3Ry5/ZNHRHC1YfiszeLZmmSxz2bOtuAYZM1reqkuI6GHSLaciGNcuI7a4cASq
	 0/6GD7kZ7Rol+QY/UuG7H2mS2NT+cLDWUCSqqtAne9YPxecIBjPhhfNTOsgx78I3DH
	 ptT8HZb/rwZWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A76ECCE0F52; Fri, 11 Oct 2024 10:39:32 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH v2 rcu 06/13] srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()
Date: Fri, 11 Oct 2024 10:39:24 -0700
Message-Id: <20241011173931.2050422-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
References: <3b82ac1a-8786-4a27-8eff-ecc67b50dfb6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds srcu_read_lock_lite() and srcu_read_unlock_lite(), which
dispense with the read-side smp_mb() but also are restricted to code
regions that RCU is watching.  If a given srcu_struct structure uses
srcu_read_lock_lite() and srcu_read_unlock_lite(), it is not permitted
to use any other SRCU read-side marker, before, during, or after.

Another price of light-weight readers is heavier weight grace periods.
Such readers mean that SRCU grace periods on srcu_struct structures
used by light-weight readers will incur at least two calls to
synchronize_rcu().  In addition, normal SRCU grace periods for
light-weight-reader srcu_struct structures never auto-expedite.
Note that expedited SRCU grace periods for light-weight-reader
srcu_struct structures still invoke synchronize_rcu(), not
synchronize_srcu_expedited().  Something about wishing to keep
the IPIs down to a dull roar.

The srcu_read_lock_lite() and srcu_read_unlock_lite() functions may not
(repeat, *not*) be used from NMI handlers, but if this is needed, an
additional flavor of SRCU reader can be added by some future commit.

[ paulmck: Apply Alexei Starovoitov expediting feedback. ]
[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 51 ++++++++++++++++++++++++-
 include/linux/srcutree.h |  1 +
 kernel/rcu/srcutree.c    | 82 ++++++++++++++++++++++++++++++++++------
 3 files changed, 122 insertions(+), 12 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 84daaa33ea0ab..4ba96e2cfa405 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -56,6 +56,13 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
 void cleanup_srcu_struct(struct srcu_struct *ssp);
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
+#ifdef CONFIG_TINY_SRCU
+#define __srcu_read_lock_lite __srcu_read_lock
+#define __srcu_read_unlock_lite __srcu_read_unlock
+#else // #ifdef CONFIG_TINY_SRCU
+int __srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp);
+void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx) __releases(ssp);
+#endif // #else // #ifdef CONFIG_TINY_SRCU
 void synchronize_srcu(struct srcu_struct *ssp);
 
 #define SRCU_GET_STATE_COMPLETED 0x1
@@ -179,7 +186,7 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
 #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TREE_SRCU)
 void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
 #else
-static inline void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor) { }
+#define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
 #endif
 
 
@@ -249,6 +256,32 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 	return retval;
 }
 
+/**
+ * srcu_read_lock_lite - register a new reader for an SRCU-protected structure.
+ * @ssp: srcu_struct in which to register the new reader.
+ *
+ * Enter an SRCU read-side critical section, but for a light-weight
+ * smp_mb()-free reader.  See srcu_read_lock() for more information.
+ *
+ * If srcu_read_lock_lite() is ever used on an srcu_struct structure,
+ * then none of the other flavors may be used, whether before, during,
+ * or after.  Note that grace-period auto-expediting is disabled for _lite
+ * srcu_struct structures because auto-expedited grace periods invoke
+ * synchronize_rcu_expedited(), IPIs and all.
+ *
+ * Note that srcu_read_lock_lite() can be invoked only from those contexts
+ * where RCU is watching.  Otherwise, lockdep will complain.
+ */
+static inline int srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp)
+{
+	int retval;
+
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
+	retval = __srcu_read_lock_lite(ssp);
+	rcu_try_lock_acquire(&ssp->dep_map);
+	return retval;
+}
+
 /**
  * srcu_read_lock_nmisafe - register a new reader for an SRCU-protected structure.
  * @ssp: srcu_struct in which to register the new reader.
@@ -325,6 +358,22 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	__srcu_read_unlock(ssp, idx);
 }
 
+/**
+ * srcu_read_unlock_lite - unregister a old reader from an SRCU-protected structure.
+ * @ssp: srcu_struct in which to unregister the old reader.
+ * @idx: return value from corresponding srcu_read_lock().
+ *
+ * Exit a light-weight SRCU read-side critical section.
+ */
+static inline void srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
+	__releases(ssp)
+{
+	WARN_ON_ONCE(idx & ~0x1);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
+	srcu_lock_release(&ssp->dep_map);
+	__srcu_read_unlock(ssp, idx);
+}
+
 /**
  * srcu_read_unlock_nmisafe - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 79ad809c7f035..8074138cbd624 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -46,6 +46,7 @@ struct srcu_data {
 /* Values for ->srcu_reader_flavor. */
 #define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
 #define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
+#define SRCU_READ_FLAVOR_LITE	0x4		// srcu_read_lock_lite().
 
 /*
  * Node in SRCU combining tree, similar in function to rcu_data.
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 4c51be484b48a..bf51758cf4a64 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -429,20 +429,29 @@ static bool srcu_gp_is_expedited(struct srcu_struct *ssp)
 }
 
 /*
- * Returns approximate total of the readers' ->srcu_lock_count[] values
- * for the rank of per-CPU counters specified by idx.
+ * Computes approximate total of the readers' ->srcu_lock_count[] values
+ * for the rank of per-CPU counters specified by idx, and returns true if
+ * the caller did the proper barrier (gp), and if the count of the locks
+ * matches that of the unlocks passed in.
  */
-static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
+static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, unsigned long unlocks)
 {
 	int cpu;
+	unsigned long mask = 0;
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
 		sum += atomic_long_read(&sdp->srcu_lock_count[idx]);
+		if (IS_ENABLED(CONFIG_PROVE_RCU))
+			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
 	}
-	return sum;
+	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
+		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
+	if (mask & SRCU_READ_FLAVOR_LITE && !gp)
+		return false;
+	return sum == unlocks;
 }
 
 /*
@@ -473,6 +482,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
  */
 static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 {
+	bool did_gp = !!(raw_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
 	unsigned long unlocks;
 
 	unlocks = srcu_readers_unlock_idx(ssp, idx);
@@ -482,13 +492,16 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 	 * unlock is counted. Needs to be a smp_mb() as the read side may
 	 * contain a read from a variable that is written to before the
 	 * synchronize_srcu() in the write side. In this case smp_mb()s
-	 * A and B act like the store buffering pattern.
+	 * A and B (or X and Y) act like the store buffering pattern.
 	 *
-	 * This smp_mb() also pairs with smp_mb() C to prevent accesses
-	 * after the synchronize_srcu() from being executed before the
-	 * grace period ends.
+	 * This smp_mb() also pairs with smp_mb() C (or, in the case of X,
+	 * Z) to prevent accesses after the synchronize_srcu() from being
+	 * executed before the grace period ends.
 	 */
-	smp_mb(); /* A */
+	if (!did_gp)
+		smp_mb(); /* A */
+	else
+		synchronize_rcu(); /* X */
 
 	/*
 	 * If the locks are the same as the unlocks, then there must have
@@ -546,7 +559,7 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 	 * which are unlikely to be configured with an address space fully
 	 * populated with memory, at least not anytime soon.
 	 */
-	return srcu_readers_lock_idx(ssp, idx) == unlocks;
+	return srcu_readers_lock_idx(ssp, idx, did_gp, unlocks);
 }
 
 /**
@@ -750,6 +763,47 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
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
+int __srcu_read_lock_lite(struct srcu_struct *ssp)
+{
+	int idx;
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
+	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
+	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter); /* Y */
+	barrier(); /* Avoid leaking the critical section. */
+	return idx;
+}
+EXPORT_SYMBOL_GPL(__srcu_read_lock_lite);
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
+void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
+{
+	barrier();  /* Avoid leaking the critical section. */
+	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);  /* Z */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
+}
+EXPORT_SYMBOL_GPL(__srcu_read_unlock_lite);
+
 #ifdef CONFIG_NEED_SRCU_NMI_SAFE
 
 /*
@@ -1134,6 +1188,8 @@ static void srcu_flip(struct srcu_struct *ssp)
 	 * it stays until either (1) Compilers learn about this sort of
 	 * control dependency or (2) Some production workload running on
 	 * a production system is unduly delayed by this slowpath smp_mb().
+	 * Except for _lite() readers, where it is inoperative, which
+	 * means that it is a good thing that it is redundant.
 	 */
 	smp_mb(); /* E */  /* Pairs with B and C. */
 
@@ -1152,7 +1208,8 @@ static void srcu_flip(struct srcu_struct *ssp)
 
 /*
  * If SRCU is likely idle, in other words, the next SRCU grace period
- * should be expedited, return true, otherwise return false.
+ * should be expedited, return true, otherwise return false.  Except that
+ * in the presence of _lite() readers, always return false.
  *
  * Note that it is OK for several current from-idle requests for a new
  * grace period from idle to specify expediting because they will all end
@@ -1181,6 +1238,9 @@ static bool srcu_should_expedite(struct srcu_struct *ssp)
 	unsigned long tlast;
 
 	check_init_srcu_struct(ssp);
+	/* If _lite() readers, don't do unsolicited expediting. */
+	if (this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE)
+		return false;
 	/* If the local srcu_data structure has callbacks, not idle.  */
 	sdp = raw_cpu_ptr(ssp->sda);
 	spin_lock_irqsave_rcu_node(sdp, flags);
-- 
2.40.1


