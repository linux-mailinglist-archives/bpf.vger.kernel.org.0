Return-Path: <bpf+bounces-50142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59993A2344E
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE291632EA
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4674D1F1514;
	Thu, 30 Jan 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWajsGQ8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93441F0E5F;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263799; cv=none; b=bojDdkhfPKFlzTeO3CBJi6aakpnig4nnusx13cI/Fwv1Be6xVnsKffE2U/zXCOLi4u8HYd66clb1rqgntBnOgWFlC61I5lKtj779mBQMoPyx2hHrWlB8zT2ISz40dilKBlgNB+1U4pjmhOHARHl+dh8xZ/nElFtVmYOzX764/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263799; c=relaxed/simple;
	bh=lWWy4k6487uzBfuO+w4i1XCAfqfjIqIw0F9DLP5pYZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UhfT/XSleruoohVrDSRmmZ0Z1IrXSz78FlkDfT3V2u5SoLWfoZK+CJI1mmFvQWiVlMzxNi2s9zT/qxjmuJUulxXhchovAGoA0WsO7PEp+w8lM+AfS3YK+cJREe9lUuuuAuG76rH3MnfpniebL2CLmbkIzqFvjd+WfThuMwt+60s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWajsGQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4900CC4CED3;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=lWWy4k6487uzBfuO+w4i1XCAfqfjIqIw0F9DLP5pYZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWajsGQ8fDn8hbaZXgEPtMRZqT1QJUFkDvGagnOTBl4e3Kt7yliDPaLNXe/3UvI9p
	 J1NxEHqabQ9UHd4l3r3AyoOFomAVNjCkjxniNnujYaZcEEe/N6R7wmOTpjuxegG6yV
	 JxK8lv/O8t+VEX16d2ouZBbVSPdHOQ2syx7G8Vf5dvxpNC5mFduMrwWbo+9cQu1RCp
	 zyp8v1mlYag7ppbdiLpfrS5tSy09VXBzgupBs916oOZov5PUmVScKeEAm04jrl4lWS
	 +lSpucsP9IwARvbOX0Q/g6Zapq6n5wKnx6PHmMZ4f8iCiMj6KXji/bx39JDrgMgwMy
	 cNeRsNNZwHIGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DA9D4CE37DD; Thu, 30 Jan 2025 11:03:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu v2] 04/20] srcu: Pull ->srcu_{un,}lock_count into a new srcu_ctr structure
Date: Thu, 30 Jan 2025 11:03:01 -0800
Message-Id: <20250130190317.1652481-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
References: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit prepares for array-index-free srcu_read_lock*() by moving the
->srcu_{un,}lock_count fields into a new srcu_ctr structure.  This will
permit ->srcu_index to be replaced by a per-CPU pointer to this structure.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcutree.h |  13 +++--
 kernel/rcu/srcutree.c    | 115 +++++++++++++++++++--------------------
 2 files changed, 66 insertions(+), 62 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index b17814c9d1c7..c794d599db5c 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -17,14 +17,19 @@
 struct srcu_node;
 struct srcu_struct;
 
+/* One element of the srcu_data srcu_ctrs array. */
+struct srcu_ctr {
+	atomic_long_t srcu_locks;	/* Locks per CPU. */
+	atomic_long_t srcu_unlocks;	/* Unlocks per CPU. */
+};
+
 /*
  * Per-CPU structure feeding into leaf srcu_node, similar in function
  * to rcu_node.
  */
 struct srcu_data {
 	/* Read-side state. */
-	atomic_long_t srcu_lock_count[2];	/* Locks per CPU. */
-	atomic_long_t srcu_unlock_count[2];	/* Unlocks per CPU. */
+	struct srcu_ctr srcu_ctrs[2];		/* Locks and unlocks per CPU. */
 	int srcu_reader_flavor;			/* Reader flavor for srcu_struct structure? */
 						/* Values: SRCU_READ_FLAVOR_.*  */
 
@@ -221,7 +226,7 @@ static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter); /* Y */
+	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_locks.counter); /* Y */
 	barrier(); /* Avoid leaking the critical section. */
 	return idx;
 }
@@ -240,7 +245,7 @@ static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
 static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
 {
 	barrier();  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);  /* Z */
+	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_unlocks.counter);  /* Z */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_lite().");
 }
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b5bb73c877de..d4e9cd917a69 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -116,8 +116,9 @@ do {										\
 /*
  * Initialize SRCU per-CPU data.  Note that statically allocated
  * srcu_struct structures might already have srcu_read_lock() and
- * srcu_read_unlock() running against them.  So if the is_static parameter
- * is set, don't initialize ->srcu_lock_count[] and ->srcu_unlock_count[].
+ * srcu_read_unlock() running against them.  So if the is_static
+ * parameter is set, don't initialize ->srcu_ctrs[].srcu_locks and
+ * ->srcu_ctrs[].srcu_unlocks.
  */
 static void init_srcu_struct_data(struct srcu_struct *ssp)
 {
@@ -128,8 +129,6 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
 	 * Initialize the per-CPU srcu_data array, which feeds into the
 	 * leaves of the srcu_node tree.
 	 */
-	BUILD_BUG_ON(ARRAY_SIZE(sdp->srcu_lock_count) !=
-		     ARRAY_SIZE(sdp->srcu_unlock_count));
 	for_each_possible_cpu(cpu) {
 		sdp = per_cpu_ptr(ssp->sda, cpu);
 		spin_lock_init(&ACCESS_PRIVATE(sdp, lock));
@@ -429,10 +428,10 @@ static bool srcu_gp_is_expedited(struct srcu_struct *ssp)
 }
 
 /*
- * Computes approximate total of the readers' ->srcu_lock_count[] values
- * for the rank of per-CPU counters specified by idx, and returns true if
- * the caller did the proper barrier (gp), and if the count of the locks
- * matches that of the unlocks passed in.
+ * Computes approximate total of the readers' ->srcu_ctrs[].srcu_locks
+ * values for the rank of per-CPU counters specified by idx, and returns
+ * true if the caller did the proper barrier (gp), and if the count of
+ * the locks matches that of the unlocks passed in.
  */
 static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, unsigned long unlocks)
 {
@@ -443,7 +442,7 @@ static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, uns
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&sdp->srcu_lock_count[idx]);
+		sum += atomic_long_read(&sdp->srcu_ctrs[idx].srcu_locks);
 		if (IS_ENABLED(CONFIG_PROVE_RCU))
 			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
 	}
@@ -455,8 +454,8 @@ static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, uns
 }
 
 /*
- * Returns approximate total of the readers' ->srcu_unlock_count[] values
- * for the rank of per-CPU counters specified by idx.
+ * Returns approximate total of the readers' ->srcu_ctrs[].srcu_unlocks
+ * values for the rank of per-CPU counters specified by idx.
  */
 static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx, unsigned long *rdm)
 {
@@ -467,7 +466,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx, u
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&sdp->srcu_unlock_count[idx]);
+		sum += atomic_long_read(&sdp->srcu_ctrs[idx].srcu_unlocks);
 		mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
 	}
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
@@ -510,9 +509,9 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 	 * been no readers on this index at some point in this function.
 	 * But there might be more readers, as a task might have read
 	 * the current ->srcu_idx but not yet have incremented its CPU's
-	 * ->srcu_lock_count[idx] counter.  In fact, it is possible
+	 * ->srcu_ctrs[idx].srcu_locks counter.  In fact, it is possible
 	 * that most of the tasks have been preempted between fetching
-	 * ->srcu_idx and incrementing ->srcu_lock_count[idx].  And there
+	 * ->srcu_idx and incrementing ->srcu_ctrs[idx].srcu_locks.  And there
 	 * could be almost (ULONG_MAX / sizeof(struct task_struct)) tasks
 	 * in a system whose address space was fully populated with memory.
 	 * Call this quantity Nt.
@@ -521,36 +520,36 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 	 * code for a long time.  That now-preempted updater has already
 	 * flipped ->srcu_idx (possibly during the preceding grace period),
 	 * done an smp_mb() (again, possibly during the preceding grace
-	 * period), and summed up the ->srcu_unlock_count[idx] counters.
+	 * period), and summed up the ->srcu_ctrs[idx].srcu_unlocks counters.
 	 * How many times can a given one of the aforementioned Nt tasks
-	 * increment the old ->srcu_idx value's ->srcu_lock_count[idx]
+	 * increment the old ->srcu_idx value's ->srcu_ctrs[idx].srcu_locks
 	 * counter, in the absence of nesting?
 	 *
 	 * It can clearly do so once, given that it has already fetched
-	 * the old value of ->srcu_idx and is just about to use that value
-	 * to index its increment of ->srcu_lock_count[idx].  But as soon as
-	 * it leaves that SRCU read-side critical section, it will increment
-	 * ->srcu_unlock_count[idx], which must follow the updater's above
-	 * read from that same value.  Thus, as soon the reading task does
-	 * an smp_mb() and a later fetch from ->srcu_idx, that task will be
-	 * guaranteed to get the new index.  Except that the increment of
-	 * ->srcu_unlock_count[idx] in __srcu_read_unlock() is after the
-	 * smp_mb(), and the fetch from ->srcu_idx in __srcu_read_lock()
-	 * is before the smp_mb().  Thus, that task might not see the new
-	 * value of ->srcu_idx until the -second- __srcu_read_lock(),
-	 * which in turn means that this task might well increment
-	 * ->srcu_lock_count[idx] for the old value of ->srcu_idx twice,
-	 * not just once.
+	 * the old value of ->srcu_idx and is just about to use that
+	 * value to index its increment of ->srcu_ctrs[idx].srcu_locks.
+	 * But as soon as it leaves that SRCU read-side critical section,
+	 * it will increment ->srcu_ctrs[idx].srcu_unlocks, which must
+	 * follow the updater's above read from that same value.	Thus,
+	 * as soon the reading task does an smp_mb() and a later fetch from
+	 * ->srcu_idx, that task will be guaranteed to get the new index.
+	 * Except that the increment of ->srcu_ctrs[idx].srcu_unlocks
+	 * in __srcu_read_unlock() is after the smp_mb(), and the fetch
+	 * from ->srcu_idx in __srcu_read_lock() is before the smp_mb().
+	 * Thus, that task might not see the new value of ->srcu_idx until
+	 * the -second- __srcu_read_lock(), which in turn means that this
+	 * task might well increment ->srcu_ctrs[idx].srcu_locks for the
+	 * old value of ->srcu_idx twice, not just once.
 	 *
 	 * However, it is important to note that a given smp_mb() takes
 	 * effect not just for the task executing it, but also for any
 	 * later task running on that same CPU.
 	 *
-	 * That is, there can be almost Nt + Nc further increments of
-	 * ->srcu_lock_count[idx] for the old index, where Nc is the number
-	 * of CPUs.  But this is OK because the size of the task_struct
-	 * structure limits the value of Nt and current systems limit Nc
-	 * to a few thousand.
+	 * That is, there can be almost Nt + Nc further increments
+	 * of ->srcu_ctrs[idx].srcu_locks for the old index, where Nc
+	 * is the number of CPUs.  But this is OK because the size of
+	 * the task_struct structure limits the value of Nt and current
+	 * systems limit Nc to a few thousand.
 	 *
 	 * OK, but what about nesting?  This does impose a limit on
 	 * nesting of half of the size of the task_struct structure
@@ -581,10 +580,10 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&sdp->srcu_lock_count[0]);
-		sum += atomic_long_read(&sdp->srcu_lock_count[1]);
-		sum -= atomic_long_read(&sdp->srcu_unlock_count[0]);
-		sum -= atomic_long_read(&sdp->srcu_unlock_count[1]);
+		sum += atomic_long_read(&sdp->srcu_ctrs[0].srcu_locks);
+		sum += atomic_long_read(&sdp->srcu_ctrs[1].srcu_locks);
+		sum -= atomic_long_read(&sdp->srcu_ctrs[0].srcu_unlocks);
+		sum -= atomic_long_read(&sdp->srcu_ctrs[1].srcu_unlocks);
 	}
 	return sum;
 }
@@ -746,7 +745,7 @@ int __srcu_read_lock(struct srcu_struct *ssp)
 	int idx;
 
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
+	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_locks.counter);
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
 	return idx;
 }
@@ -760,7 +759,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	smp_mb(); /* C */  /* Avoid leaking the critical section. */
-	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);
+	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_unlocks.counter);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
@@ -777,7 +776,7 @@ int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
 	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
 
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	atomic_long_inc(&sdp->srcu_lock_count[idx]);
+	atomic_long_inc(&sdp->srcu_ctrs[idx].srcu_locks);
 	smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
 	return idx;
 }
@@ -793,7 +792,7 @@ void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
 
 	smp_mb__before_atomic(); /* C */  /* Avoid leaking the critical section. */
-	atomic_long_inc(&sdp->srcu_unlock_count[idx]);
+	atomic_long_inc(&sdp->srcu_ctrs[idx].srcu_unlocks);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock_nmisafe);
 
@@ -1123,17 +1122,17 @@ static void srcu_flip(struct srcu_struct *ssp)
 	/*
 	 * Because the flip of ->srcu_idx is executed only if the
 	 * preceding call to srcu_readers_active_idx_check() found that
-	 * the ->srcu_unlock_count[] and ->srcu_lock_count[] sums matched
-	 * and because that summing uses atomic_long_read(), there is
-	 * ordering due to a control dependency between that summing and
-	 * the WRITE_ONCE() in this call to srcu_flip().  This ordering
-	 * ensures that if this updater saw a given reader's increment from
-	 * __srcu_read_lock(), that reader was using a value of ->srcu_idx
-	 * from before the previous call to srcu_flip(), which should be
-	 * quite rare.  This ordering thus helps forward progress because
-	 * the grace period could otherwise be delayed by additional
-	 * calls to __srcu_read_lock() using that old (soon to be new)
-	 * value of ->srcu_idx.
+	 * the ->srcu_ctrs[].srcu_unlocks and ->srcu_ctrs[].srcu_locks sums
+	 * matched and because that summing uses atomic_long_read(),
+	 * there is ordering due to a control dependency between that
+	 * summing and the WRITE_ONCE() in this call to srcu_flip().
+	 * This ordering ensures that if this updater saw a given reader's
+	 * increment from __srcu_read_lock(), that reader was using a value
+	 * of ->srcu_idx from before the previous call to srcu_flip(),
+	 * which should be quite rare.  This ordering thus helps forward
+	 * progress because the grace period could otherwise be delayed
+	 * by additional calls to __srcu_read_lock() using that old (soon
+	 * to be new) value of ->srcu_idx.
 	 *
 	 * This sum-equality check and ordering also ensures that if
 	 * a given call to __srcu_read_lock() uses the new value of
@@ -1918,8 +1917,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 			struct srcu_data *sdp;
 
 			sdp = per_cpu_ptr(ssp->sda, cpu);
-			u0 = data_race(atomic_long_read(&sdp->srcu_unlock_count[!idx]));
-			u1 = data_race(atomic_long_read(&sdp->srcu_unlock_count[idx]));
+			u0 = data_race(atomic_long_read(&sdp->srcu_ctrs[!idx].srcu_unlocks));
+			u1 = data_race(atomic_long_read(&sdp->srcu_ctrs[idx].srcu_unlocks));
 
 			/*
 			 * Make sure that a lock is always counted if the corresponding
@@ -1927,8 +1926,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 			 */
 			smp_rmb();
 
-			l0 = data_race(atomic_long_read(&sdp->srcu_lock_count[!idx]));
-			l1 = data_race(atomic_long_read(&sdp->srcu_lock_count[idx]));
+			l0 = data_race(atomic_long_read(&sdp->srcu_ctrs[!idx].srcu_locks));
+			l1 = data_race(atomic_long_read(&sdp->srcu_ctrs[idx].srcu_locks));
 
 			c0 = l0 - u0;
 			c1 = l1 - u1;
-- 
2.40.1


