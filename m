Return-Path: <bpf+bounces-50145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54BAA23452
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58F03A4DEF
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFA1F193C;
	Thu, 30 Jan 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noN40zdG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6E1F12F9;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=Pqz2S4OgjwCyYcWoaRxvexlKI8s3KJbQ8gc1oPYWl8uFASGt0h4gJpnPtNb5275nj63vxx6wfPPAEkDu7RBmWhwWtK8MEg4M6U0Ehe4QMaohtwVnAlyb1ej4d+K40KN4HibFtKs/C5EyCMpd1tK3YDl8EiC+MF6OgFCWj5/gya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=VnvBTfFZaRqc4OHzxggc8JtrFWQtLaW2mS34YrBTgb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJwUSdTUw7JfsBclzbGvjG1gwdBdcGOrPgKDIssSB8ayM+Fbip7fUBNDpdjsl4NR54EH7ui3ilAukWtBXjOEpH7bGOLtbz8n5RHQDUkGl7mAUKdG/lSbfjuWwtSavnC4bTmhsWT+5x1i0WMsCKHhuLhg4nNLAvhccrK7eY5YvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noN40zdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83551C4CEEF;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=VnvBTfFZaRqc4OHzxggc8JtrFWQtLaW2mS34YrBTgb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=noN40zdGn08CnyzCu5KdKvRAvcDkUTkuTxPFzPtHOpjV6JMhO0e8Jtp3Vij3MzwJp
	 gni/h9Nattl5Ru880vkTjQUaIT9nN2TNDN2iG6ZGJTbS2plH6LDMirW5GuVKxR9zI1
	 KnfB8YlU+Og29G7FwG0utpSI5LXdIu0VOGBRiSr+vbLkcjCazZymCz22LuVVydEMse
	 CvnaN1myZp/H/OTyuDUEmd2OYCUH854rtZjoHLwj5Qx3fyCltBGwm9pPLaQQgyV1qI
	 by4uqfLT1UYvlIbxljSP9dSeyG6hSaiggpUd0ExlSEddcir6WRUVyfu/UacsKsJYqq
	 FnK8+3TDV12Vw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E0D62CE37E0; Thu, 30 Jan 2025 11:03:18 -0800 (PST)
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
Subject: [PATCH rcu v2] 06/20] srcu: Make Tree SRCU updates independent of ->srcu_idx
Date: Thu, 30 Jan 2025 11:03:03 -0800
Message-Id: <20250130190317.1652481-6-paulmck@kernel.org>
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

This commit makes Tree SRCU updates independent of ->srcu_idx, then
drop ->srcu_idx.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcutree.h |  1 -
 kernel/rcu/srcutree.c    | 68 ++++++++++++++++++++--------------------
 2 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 1b01ced61a45..6b7eba59f384 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -100,7 +100,6 @@ struct srcu_usage {
  * Per-SRCU-domain structure, similar in function to rcu_state.
  */
 struct srcu_struct {
-	unsigned int srcu_idx;			/* Current rdr array element. */
 	struct srcu_ctr __percpu *srcu_ctrp;
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
 	struct lockdep_map dep_map;
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9af86ce2dd24..dfc98e69acca 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -246,7 +246,6 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->node = NULL;
 	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
 	mutex_init(&ssp->srcu_sup->srcu_gp_mutex);
-	ssp->srcu_idx = 0;
 	ssp->srcu_sup->srcu_gp_seq = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_barrier_seq = 0;
 	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
@@ -510,38 +509,39 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 	 * If the locks are the same as the unlocks, then there must have
 	 * been no readers on this index at some point in this function.
 	 * But there might be more readers, as a task might have read
-	 * the current ->srcu_idx but not yet have incremented its CPU's
+	 * the current ->srcu_ctrp but not yet have incremented its CPU's
 	 * ->srcu_ctrs[idx].srcu_locks counter.  In fact, it is possible
 	 * that most of the tasks have been preempted between fetching
-	 * ->srcu_idx and incrementing ->srcu_ctrs[idx].srcu_locks.  And there
-	 * could be almost (ULONG_MAX / sizeof(struct task_struct)) tasks
-	 * in a system whose address space was fully populated with memory.
-	 * Call this quantity Nt.
+	 * ->srcu_ctrp and incrementing ->srcu_ctrs[idx].srcu_locks.  And
+	 * there could be almost (ULONG_MAX / sizeof(struct task_struct))
+	 * tasks in a system whose address space was fully populated
+	 * with memory.  Call this quantity Nt.
 	 *
-	 * So suppose that the updater is preempted at this point in the
-	 * code for a long time.  That now-preempted updater has already
-	 * flipped ->srcu_idx (possibly during the preceding grace period),
-	 * done an smp_mb() (again, possibly during the preceding grace
-	 * period), and summed up the ->srcu_ctrs[idx].srcu_unlocks counters.
-	 * How many times can a given one of the aforementioned Nt tasks
-	 * increment the old ->srcu_idx value's ->srcu_ctrs[idx].srcu_locks
-	 * counter, in the absence of nesting?
+	 * So suppose that the updater is preempted at this
+	 * point in the code for a long time.  That now-preempted
+	 * updater has already flipped ->srcu_ctrp (possibly during
+	 * the preceding grace period), done an smp_mb() (again,
+	 * possibly during the preceding grace period), and summed up
+	 * the ->srcu_ctrs[idx].srcu_unlocks counters.  How many times
+	 * can a given one of the aforementioned Nt tasks increment the
+	 * old ->srcu_ctrp value's ->srcu_ctrs[idx].srcu_locks counter,
+	 * in the absence of nesting?
 	 *
 	 * It can clearly do so once, given that it has already fetched
-	 * the old value of ->srcu_idx and is just about to use that
+	 * the old value of ->srcu_ctrp and is just about to use that
 	 * value to index its increment of ->srcu_ctrs[idx].srcu_locks.
 	 * But as soon as it leaves that SRCU read-side critical section,
 	 * it will increment ->srcu_ctrs[idx].srcu_unlocks, which must
-	 * follow the updater's above read from that same value.	Thus,
-	 * as soon the reading task does an smp_mb() and a later fetch from
-	 * ->srcu_idx, that task will be guaranteed to get the new index.
+	 * follow the updater's above read from that same value.  Thus,
+	   as soon the reading task does an smp_mb() and a later fetch from
+	 * ->srcu_ctrp, that task will be guaranteed to get the new index.
 	 * Except that the increment of ->srcu_ctrs[idx].srcu_unlocks
 	 * in __srcu_read_unlock() is after the smp_mb(), and the fetch
-	 * from ->srcu_idx in __srcu_read_lock() is before the smp_mb().
-	 * Thus, that task might not see the new value of ->srcu_idx until
+	 * from ->srcu_ctrp in __srcu_read_lock() is before the smp_mb().
+	 * Thus, that task might not see the new value of ->srcu_ctrp until
 	 * the -second- __srcu_read_lock(), which in turn means that this
 	 * task might well increment ->srcu_ctrs[idx].srcu_locks for the
-	 * old value of ->srcu_idx twice, not just once.
+	 * old value of ->srcu_ctrp twice, not just once.
 	 *
 	 * However, it is important to note that a given smp_mb() takes
 	 * effect not just for the task executing it, but also for any
@@ -1095,7 +1095,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 /*
  * Wait until all readers counted by array index idx complete, but
  * loop an additional time if there is an expedited grace period pending.
- * The caller must ensure that ->srcu_idx is not changed while checking.
+ * The caller must ensure that ->srcu_ctrp is not changed while checking.
  */
 static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 {
@@ -1113,14 +1113,14 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 }
 
 /*
- * Increment the ->srcu_idx counter so that future SRCU readers will
+ * Increment the ->srcu_ctrp counter so that future SRCU readers will
  * use the other rank of the ->srcu_(un)lock_count[] arrays.  This allows
  * us to wait for pre-existing readers in a starvation-free manner.
  */
 static void srcu_flip(struct srcu_struct *ssp)
 {
 	/*
-	 * Because the flip of ->srcu_idx is executed only if the
+	 * Because the flip of ->srcu_ctrp is executed only if the
 	 * preceding call to srcu_readers_active_idx_check() found that
 	 * the ->srcu_ctrs[].srcu_unlocks and ->srcu_ctrs[].srcu_locks sums
 	 * matched and because that summing uses atomic_long_read(),
@@ -1128,15 +1128,15 @@ static void srcu_flip(struct srcu_struct *ssp)
 	 * summing and the WRITE_ONCE() in this call to srcu_flip().
 	 * This ordering ensures that if this updater saw a given reader's
 	 * increment from __srcu_read_lock(), that reader was using a value
-	 * of ->srcu_idx from before the previous call to srcu_flip(),
+	 * of ->srcu_ctrp from before the previous call to srcu_flip(),
 	 * which should be quite rare.  This ordering thus helps forward
 	 * progress because the grace period could otherwise be delayed
 	 * by additional calls to __srcu_read_lock() using that old (soon
-	 * to be new) value of ->srcu_idx.
+	 * to be new) value of ->srcu_ctrp.
 	 *
 	 * This sum-equality check and ordering also ensures that if
 	 * a given call to __srcu_read_lock() uses the new value of
-	 * ->srcu_idx, this updater's earlier scans cannot have seen
+	 * ->srcu_ctrp, this updater's earlier scans cannot have seen
 	 * that reader's increments, which is all to the good, because
 	 * this grace period need not wait on that reader.  After all,
 	 * if those earlier scans had seen that reader, there would have
@@ -1151,7 +1151,6 @@ static void srcu_flip(struct srcu_struct *ssp)
 	 */
 	smp_mb(); /* E */  /* Pairs with B and C. */
 
-	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1); // Flip the counter.
 	WRITE_ONCE(ssp->srcu_ctrp,
 		   &ssp->sda->srcu_ctrs[!(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0])]);
 
@@ -1470,8 +1469,9 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_expedited);
  *
  * Wait for the count to drain to zero of both indexes. To avoid the
  * possible starvation of synchronize_srcu(), it waits for the count of
- * the index=((->srcu_idx & 1) ^ 1) to drain to zero at first,
- * and then flip the srcu_idx and wait for the count of the other index.
+ * the index=!(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0]) to drain to zero
+ * at first, and then flip the ->srcu_ctrp and wait for the count of the
+ * other index.
  *
  * Can block; must be called from process context.
  *
@@ -1697,7 +1697,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 
 	/*
 	 * Because readers might be delayed for an extended period after
-	 * fetching ->srcu_idx for their index, at any point in time there
+	 * fetching ->srcu_ctrp for their index, at any point in time there
 	 * might well be readers using both idx=0 and idx=1.  We therefore
 	 * need to wait for readers to clear from both index values before
 	 * invoking a callback.
@@ -1725,7 +1725,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 	}
 
 	if (rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) == SRCU_STATE_SCAN1) {
-		idx = 1 ^ (ssp->srcu_idx & 1);
+		idx = !(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0]);
 		if (!try_check_zero(ssp, idx, 1)) {
 			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* readers present, retry later. */
@@ -1743,7 +1743,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		 * SRCU read-side critical sections are normally short,
 		 * so check at least twice in quick succession after a flip.
 		 */
-		idx = 1 ^ (ssp->srcu_idx & 1);
+		idx = !(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0]);
 		if (!try_check_zero(ssp, idx, 2)) {
 			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* readers present, retry later. */
@@ -1901,7 +1901,7 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 	int ss_state = READ_ONCE(ssp->srcu_sup->srcu_size_state);
 	int ss_state_idx = ss_state;
 
-	idx = ssp->srcu_idx & 0x1;
+	idx = ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0];
 	if (ss_state < 0 || ss_state >= ARRAY_SIZE(srcu_size_state_name))
 		ss_state_idx = ARRAY_SIZE(srcu_size_state_name) - 1;
 	pr_alert("%s%s Tree SRCU g%ld state %d (%s)",
-- 
2.40.1


