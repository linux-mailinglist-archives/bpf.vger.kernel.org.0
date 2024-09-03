Return-Path: <bpf+bounces-38795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E5796A486
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9552885DB
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419A8190462;
	Tue,  3 Sep 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRgx8+Ak"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077218DF85;
	Tue,  3 Sep 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381200; cv=none; b=X6ZrsITNDolo0LKuKpjwigtBMEHxnpN3Nh20jE0Rp9dddCBRPaOtmqV7dsC56iHA5JGdsffX0e3zypG26cynnliIzcJ/mQAPrB5mAFbMxT9kFTgbKsRa6fhOXPkalsi44XkkEBUrIfps06ADzJF4FbZI5/ZpOxyE7WudJjgZFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381200; c=relaxed/simple;
	bh=Eg2edctDPVnZINnYuetE1e7nQc0Cm1VLVZhlC0S8nos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NK6600Vfs3U/XpD9hof3JZKoIp4guOlopYSMNglTL9yXNjj7z+77ILvtCfpyoRnpR9yPrc1/zG37Ol2HUA5WubxZAbynCyk0vmqrw2rrmUY7yIoK80lxpfPLei1/0sqFlhOSBlCoAKNSxyVwI/G86dGG6WsUW6d1c10Y6ZnHT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRgx8+Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF11EC4CED8;
	Tue,  3 Sep 2024 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381200;
	bh=Eg2edctDPVnZINnYuetE1e7nQc0Cm1VLVZhlC0S8nos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRgx8+AkrwHrM385eGt0J5D/ok1+mKLqMYIBjzEeatsZpcwM19TQ05xK2C6npdDkP
	 Wi4rtmLsIRWgiXOV2wf7ZsuQa34c0QhoTi60XSFPS/7z7iNtJvWJwaQ5gNeELK3GSx
	 0e+6vdjMakfJV4ozPyUIS8MaQvkZLOmyFLhR66Y0qVKBpVNWC6KGGa64ZHru+Tv6yg
	 3yDPv18bmU/yXsXBm5CHjI3Ly2Jeh5ihhI3PqaI9IE/zdsTIeGH/ZamNlk8aaxMAsS
	 CiFgBp2reqT65Wzuaz7DUq93pAbv3DNqdWKOBvr0p8OG3uY3nDW6yWI5xH3SarB+kh
	 DWoih8xolV/TQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4D173CE260F; Tue,  3 Sep 2024 09:33:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/11] srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()
Date: Tue,  3 Sep 2024 09:33:14 -0700
Message-Id: <20240903163318.480678-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
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
index 602b4b8c4b891..bab888e86b9bb 100644
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
+	bool did_gp = !!(__this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
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


