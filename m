Return-Path: <bpf+bounces-10709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D62A7AC84F
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 15:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 37E98B209B6
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49A53A6;
	Sun, 24 Sep 2023 13:16:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320128FD
	for <bpf@vger.kernel.org>; Sun, 24 Sep 2023 13:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6657CC433CA;
	Sun, 24 Sep 2023 13:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695561364;
	bh=kH9tYJfLDNWp4co3XrGfkCZhKTEkmdUJhMPJdmFvdkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+A73fP88roZ/a9s+OYu7xpgmt4ySRlibwnpsz+UZ/bqz41/4Cu/dUT8LVOWAeekK
	 65SjZjhBdSTo3etkfTUbR+NstvV63MZwTNgHQC6VYx60BeLpZ0KifP2hXBcnENezD5
	 NYgTY3tGctYy1iCWLdGtMMByNambXjWp8M4o2KO5Dl0rVQPIgrWtlrfQW+T+2yD/1V
	 HvyfSq9UL8jQC9fkB2YtOpDH3JeGs8DsCgBGlvRPFaAAeat5o5MRChQokYto6mm2tO
	 nlA2ANhgcgZ5YalZayIaj+z2goJpmhhnzc0xXUBJcaN7LOFoJFtdAm3R9WJmJsL2NT
	 h4mTeoKa76vEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 13/41] btrfs: do not block starts waiting on previous transaction commit
Date: Sun, 24 Sep 2023 09:15:01 -0400
Message-Id: <20230924131529.1275335-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 77d20c685b6baeb942606a93ed861c191381b73e ]

Internally I got a report of very long stalls on normal operations like
creating a new file when auto relocation was running.  The reporter used
the 'bpf offcputime' tracer to show that we would get stuck in
start_transaction for 5 to 30 seconds, and were always being woken up by
the transaction commit.

Using my timing-everything script, which times how long a function takes
and what percentage of that total time is taken up by its children, I
saw several traces like this

1083 took 32812902424 ns
        29929002926 ns 91.2110% wait_for_commit_duration
        25568 ns 7.7920e-05% commit_fs_roots_duration
        1007751 ns 0.00307% commit_cowonly_roots_duration
        446855602 ns 1.36182% btrfs_run_delayed_refs_duration
        271980 ns 0.00082% btrfs_run_delayed_items_duration
        2008 ns 6.1195e-06% btrfs_apply_pending_changes_duration
        9656 ns 2.9427e-05% switch_commit_roots_duration
        1598 ns 4.8700e-06% btrfs_commit_device_sizes_duration
        4314 ns 1.3147e-05% btrfs_free_log_root_tree_duration

Here I was only tracing functions that happen where we are between
START_COMMIT and UNBLOCKED in order to see what would be keeping us
blocked for so long.  The wait_for_commit() we do is where we wait for a
previous transaction that hasn't completed it's commit.  This can
include all of the unpin work and other cleanups, which tends to be the
longest part of our transaction commit.

There is no reason we should be blocking new things from entering the
transaction at this point, it just adds to random latency spikes for no
reason.

Fix this by adding a PREP stage.  This allows us to properly deal with
multiple committers coming in at the same time, we retain the behavior
that the winner waits on the previous transaction and the losers all
wait for this transaction commit to occur.  Nothing else is blocked
during the PREP stage, and then once the wait is complete we switch to
COMMIT_START and all of the same behavior as before is maintained.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c     |  8 ++++----
 fs/btrfs/locking.h     |  2 +-
 fs/btrfs/transaction.c | 39 ++++++++++++++++++++++++---------------
 fs/btrfs/transaction.h |  1 +
 4 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4494883a19abc..93554f8aef8cf 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1552,7 +1552,7 @@ static int transaction_kthread(void *arg)
 
 		delta = ktime_get_seconds() - cur->start_time;
 		if (!test_and_clear_bit(BTRFS_FS_COMMIT_TRANS, &fs_info->flags) &&
-		    cur->state < TRANS_STATE_COMMIT_START &&
+		    cur->state < TRANS_STATE_COMMIT_PREP &&
 		    delta < fs_info->commit_interval) {
 			spin_unlock(&fs_info->trans_lock);
 			delay -= msecs_to_jiffies((delta - 1) * 1000);
@@ -2689,8 +2689,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_extwriters);
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_pending_ordered);
 	btrfs_lockdep_init_map(fs_info, btrfs_ordered_extent);
-	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_commit_start,
-				     BTRFS_LOCKDEP_TRANS_COMMIT_START);
+	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_commit_prep,
+				     BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_unblocked,
 				     BTRFS_LOCKDEP_TRANS_UNBLOCKED);
 	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_super_committed,
@@ -4892,7 +4892,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 	while (!list_empty(&fs_info->trans_list)) {
 		t = list_first_entry(&fs_info->trans_list,
 				     struct btrfs_transaction, list);
-		if (t->state >= TRANS_STATE_COMMIT_START) {
+		if (t->state >= TRANS_STATE_COMMIT_PREP) {
 			refcount_inc(&t->use_count);
 			spin_unlock(&fs_info->trans_lock);
 			btrfs_wait_for_commit(fs_info, t->transid);
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index edb9b4a0dba15..7d6ee1e609bf2 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -79,7 +79,7 @@ enum btrfs_lock_nesting {
 };
 
 enum btrfs_lockdep_trans_states {
-	BTRFS_LOCKDEP_TRANS_COMMIT_START,
+	BTRFS_LOCKDEP_TRANS_COMMIT_PREP,
 	BTRFS_LOCKDEP_TRANS_UNBLOCKED,
 	BTRFS_LOCKDEP_TRANS_SUPER_COMMITTED,
 	BTRFS_LOCKDEP_TRANS_COMPLETED,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5bbd288b9cb54..942cfa906ed48 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -56,12 +56,17 @@ static struct kmem_cache *btrfs_trans_handle_cachep;
  * |  Call btrfs_commit_transaction() on any trans handle attached to
  * |  transaction N
  * V
- * Transaction N [[TRANS_STATE_COMMIT_START]]
+ * Transaction N [[TRANS_STATE_COMMIT_PREP]]
+ * |
+ * | If there are simultaneous calls to btrfs_commit_transaction() one will win
+ * | the race and the rest will wait for the winner to commit the transaction.
+ * |
+ * | The winner will wait for previous running transaction to completely finish
+ * | if there is one.
  * |
- * | Will wait for previous running transaction to completely finish if there
- * | is one
+ * Transaction N [[TRANS_STATE_COMMIT_START]]
  * |
- * | Then one of the following happes:
+ * | Then one of the following happens:
  * | - Wait for all other trans handle holders to release.
  * |   The btrfs_commit_transaction() caller will do the commit work.
  * | - Wait for current transaction to be committed by others.
@@ -112,6 +117,7 @@ static struct kmem_cache *btrfs_trans_handle_cachep;
  */
 static const unsigned int btrfs_blocked_trans_types[TRANS_STATE_MAX] = {
 	[TRANS_STATE_RUNNING]		= 0U,
+	[TRANS_STATE_COMMIT_PREP]	= 0U,
 	[TRANS_STATE_COMMIT_START]	= (__TRANS_START | __TRANS_ATTACH),
 	[TRANS_STATE_COMMIT_DOING]	= (__TRANS_START |
 					   __TRANS_ATTACH |
@@ -1980,7 +1986,7 @@ void btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
 	 * Wait for the current transaction commit to start and block
 	 * subsequent transaction joins
 	 */
-	btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
+	btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 	wait_event(fs_info->transaction_blocked_wait,
 		   cur_trans->state >= TRANS_STATE_COMMIT_START ||
 		   TRANS_ABORTED(cur_trans));
@@ -2127,7 +2133,7 @@ static void add_pending_snapshot(struct btrfs_trans_handle *trans)
 		return;
 
 	lockdep_assert_held(&trans->fs_info->trans_lock);
-	ASSERT(cur_trans->state >= TRANS_STATE_COMMIT_START);
+	ASSERT(cur_trans->state >= TRANS_STATE_COMMIT_PREP);
 
 	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots);
 }
@@ -2151,7 +2157,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	ktime_t interval;
 
 	ASSERT(refcount_read(&trans->use_count) == 1);
-	btrfs_trans_state_lockdep_acquire(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
+	btrfs_trans_state_lockdep_acquire(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 
 	clear_bit(BTRFS_FS_NEED_TRANS_COMMIT, &fs_info->flags);
 
@@ -2211,7 +2217,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	}
 
 	spin_lock(&fs_info->trans_lock);
-	if (cur_trans->state >= TRANS_STATE_COMMIT_START) {
+	if (cur_trans->state >= TRANS_STATE_COMMIT_PREP) {
 		enum btrfs_trans_state want_state = TRANS_STATE_COMPLETED;
 
 		add_pending_snapshot(trans);
@@ -2223,7 +2229,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 			want_state = TRANS_STATE_SUPER_COMMITTED;
 
 		btrfs_trans_state_lockdep_release(fs_info,
-						  BTRFS_LOCKDEP_TRANS_COMMIT_START);
+						  BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 		ret = btrfs_end_transaction(trans);
 		wait_for_commit(cur_trans, want_state);
 
@@ -2235,9 +2241,9 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		return ret;
 	}
 
-	cur_trans->state = TRANS_STATE_COMMIT_START;
+	cur_trans->state = TRANS_STATE_COMMIT_PREP;
 	wake_up(&fs_info->transaction_blocked_wait);
-	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
+	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 
 	if (cur_trans->list.prev != &fs_info->trans_list) {
 		enum btrfs_trans_state want_state = TRANS_STATE_COMPLETED;
@@ -2258,11 +2264,9 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 			btrfs_put_transaction(prev_trans);
 			if (ret)
 				goto lockdep_release;
-		} else {
-			spin_unlock(&fs_info->trans_lock);
+			spin_lock(&fs_info->trans_lock);
 		}
 	} else {
-		spin_unlock(&fs_info->trans_lock);
 		/*
 		 * The previous transaction was aborted and was already removed
 		 * from the list of transactions at fs_info->trans_list. So we
@@ -2270,11 +2274,16 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		 * corrupt state (pointing to trees with unwritten nodes/leafs).
 		 */
 		if (BTRFS_FS_ERROR(fs_info)) {
+			spin_unlock(&fs_info->trans_lock);
 			ret = -EROFS;
 			goto lockdep_release;
 		}
 	}
 
+	cur_trans->state = TRANS_STATE_COMMIT_START;
+	wake_up(&fs_info->transaction_blocked_wait);
+	spin_unlock(&fs_info->trans_lock);
+
 	/*
 	 * Get the time spent on the work done by the commit thread and not
 	 * the time spent waiting on a previous commit
@@ -2584,7 +2593,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	goto cleanup_transaction;
 
 lockdep_trans_commit_start_release:
-	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_START);
+	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMMIT_PREP);
 	btrfs_end_transaction(trans);
 	return ret;
 }
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 8e9fa23bd7fed..6b309f8a99a86 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -14,6 +14,7 @@
 
 enum btrfs_trans_state {
 	TRANS_STATE_RUNNING,
+	TRANS_STATE_COMMIT_PREP,
 	TRANS_STATE_COMMIT_START,
 	TRANS_STATE_COMMIT_DOING,
 	TRANS_STATE_UNBLOCKED,
-- 
2.40.1


