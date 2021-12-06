Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD86469F44
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 16:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356576AbhLFPqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 10:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388104AbhLFPcT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 10:32:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF65C08E84B
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 07:19:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90FCA6132E
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 15:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB251C341C9;
        Mon,  6 Dec 2021 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638803956;
        bh=r+QAzEuNCaxQ97dCWPbIqDOvqrnOkXpYspHiGBKtmI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGCaxctmr1c/0zTtUuqtEfchYjBCga0yBqAjUhEJ55Mnk6YY/sKvePMPV+FyKuXDc
         aqpoS2eW0guiynR8TbMrucv1EJQsR/XJwZMV1KHnra+68M6bJGZKAa3CYxmPxYsuxv
         /7jv7EJDBd0n14IMinsgU4eQriwiPnXRtI1dZKDw0TR0HSGVf0acLkIqPDYy+rAu52
         TxwklDQUx1PgtdGRtvH3E3qT5NEFxKNLibza65WETH3k3vbX173lx9uIwGPfFRdDWJ
         srXtmITTAl7oX8dAjH5SdWDA5n/wUPjQ/DERvv734X6BhRWdwqrnKvzI3GaRdNk3fo
         TYhj6TDvgBNBg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH v2 bpf-next 1/2] bpf: Allow bpf_local_storage to be used by sleepable programs
Date:   Mon,  6 Dec 2021 15:19:08 +0000
Message-Id: <20211206151909.951258-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211206151909.951258-1-kpsingh@kernel.org>
References: <20211206151909.951258-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Other maps like hashmaps are already available to sleepable programs.
Sleepable BPF programs run under trace RCU. Allow task, sk and inode
storage to be used from sleepable programs. This allows sleepable and
non-sleepable programs to provide shareable annotations on kernel
objects.

Sleepable programs run in trace RCU where as non-sleepable programs run
in a normal RCU critical section i.e.  __bpf_prog_enter{_sleepable}
and __bpf_prog_exit{_sleepable}) (rcu_read_lock or rcu_read_lock_trace).

In order to make the local storage maps accessible to both sleepable
and non-sleepable programs, one needs to call both
call_rcu_tasks_trace and call_rcu to wait for both trace and classical
RCU grace periods to expire before freeing memory.

Paul's work on call_rcu_tasks_trace allows us to have per CPU queueing
for call_rcu_tasks_trace. This behaviour can be achieved by setting
rcupdate.rcu_task_enqueue_lim=<num_cpus> boot parameter.

In light of these new performance changes and to keep the local storage
code simple, avoid adding a new flag for sleepable maps / local storage
to select the RCU synchronization (trace / classical).

Also, update the dereferencing of the pointers to use
rcu_derference_check (with either the trace or normal RCU locks held)
with a common bpf_rcu_lock_held helper method.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf_local_storage.h |  5 +++
 kernel/bpf/bpf_inode_storage.c    |  9 ++++--
 kernel/bpf/bpf_local_storage.c    | 51 ++++++++++++++++++++++---------
 kernel/bpf/bpf_task_storage.c     |  9 ++++--
 kernel/bpf/verifier.c             |  3 ++
 net/core/bpf_sk_storage.c         |  8 ++++-
 6 files changed, 66 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 24496bc28e7b..475431a36a62 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -16,6 +16,9 @@
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
 
+#define bpf_rcu_lock_held()                                                    \
+	(rcu_read_lock_held() || rcu_read_lock_trace_held() ||                 \
+	 rcu_read_lock_bh_held())
 struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
 	raw_spinlock_t lock;
@@ -161,4 +164,6 @@ struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 			 void *value, u64 map_flags);
 
+void bpf_local_storage_free_rcu(struct rcu_head *rcu);
+
 #endif /* _BPF_LOCAL_STORAGE_H */
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 96ceed0e0fb5..20604d904d14 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -17,6 +17,7 @@
 #include <linux/bpf_lsm.h>
 #include <linux/btf_ids.h>
 #include <linux/fdtable.h>
+#include <linux/rcupdate_trace.h>
 
 DEFINE_BPF_STORAGE_CACHE(inode_cache);
 
@@ -44,7 +45,8 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
 	if (!bsb)
 		return NULL;
 
-	inode_storage = rcu_dereference(bsb->storage);
+	inode_storage =
+		rcu_dereference_check(bsb->storage, bpf_rcu_lock_held());
 	if (!inode_storage)
 		return NULL;
 
@@ -97,7 +99,8 @@ void bpf_inode_storage_free(struct inode *inode)
 	 * local_storage->list was non-empty.
 	 */
 	if (free_inode_storage)
-		kfree_rcu(local_storage, rcu);
+		call_rcu_tasks_trace(&local_storage->rcu,
+				     bpf_local_storage_free_rcu);
 }
 
 static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
@@ -172,6 +175,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
 {
 	struct bpf_local_storage_data *sdata;
 
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
 		return (unsigned long)NULL;
 
@@ -204,6 +208,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
 BPF_CALL_2(bpf_inode_storage_delete,
 	   struct bpf_map *, map, struct inode *, inode)
 {
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (!inode)
 		return -EINVAL;
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b305270b7a4b..ff65d3711d3a 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -11,6 +11,9 @@
 #include <net/sock.h>
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
+#include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
+#include <linux/rcupdate_wait.h>
 
 #define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
 
@@ -81,6 +84,22 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	return NULL;
 }
 
+void bpf_local_storage_free_rcu(struct rcu_head *rcu)
+{
+	struct bpf_local_storage *local_storage;
+
+	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
+	kfree_rcu(local_storage, rcu);
+}
+
+static void bpf_selem_free_rcu(struct rcu_head *rcu)
+{
+	struct bpf_local_storage_elem *selem;
+
+	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
+	kfree_rcu(selem, rcu);
+}
+
 /* local_storage->lock must be held and selem->local_storage == local_storage.
  * The caller must ensure selem->smap is still valid to be
  * dereferenced for its smap->elem_size and smap->cache_idx.
@@ -93,7 +112,7 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
 	bool free_local_storage;
 	void *owner;
 
-	smap = rcu_dereference(SDATA(selem)->smap);
+	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	owner = local_storage->owner;
 
 	/* All uncharging on the owner must be done first.
@@ -118,12 +137,12 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
 		 *
 		 * Although the unlock will be done under
 		 * rcu_read_lock(),  it is more intutivie to
-		 * read if kfree_rcu(local_storage, rcu) is done
+		 * read if the freeing of the storage is done
 		 * after the raw_spin_unlock_bh(&local_storage->lock).
 		 *
 		 * Hence, a "bool free_local_storage" is returned
-		 * to the caller which then calls the kfree_rcu()
-		 * after unlock.
+		 * to the caller which then calls then frees the storage after
+		 * all the RCU grace periods have expired.
 		 */
 	}
 	hlist_del_init_rcu(&selem->snode);
@@ -131,8 +150,7 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
 	    SDATA(selem))
 		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
-	kfree_rcu(selem, rcu);
-
+	call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
 	return free_local_storage;
 }
 
@@ -146,7 +164,8 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
 		/* selem has already been unlinked from sk */
 		return;
 
-	local_storage = rcu_dereference(selem->local_storage);
+	local_storage = rcu_dereference_check(selem->local_storage,
+					      bpf_rcu_lock_held());
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
 	if (likely(selem_linked_to_storage(selem)))
 		free_local_storage = bpf_selem_unlink_storage_nolock(
@@ -154,7 +173,8 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	if (free_local_storage)
-		kfree_rcu(local_storage, rcu);
+		call_rcu_tasks_trace(&local_storage->rcu,
+				     bpf_local_storage_free_rcu);
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
@@ -174,7 +194,7 @@ void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 		/* selem has already be unlinked from smap */
 		return;
 
-	smap = rcu_dereference(SDATA(selem)->smap);
+	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	b = select_bucket(smap, selem);
 	raw_spin_lock_irqsave(&b->lock, flags);
 	if (likely(selem_linked_to_map(selem)))
@@ -213,7 +233,8 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 	struct bpf_local_storage_elem *selem;
 
 	/* Fast path (cache hit) */
-	sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
+	sdata = rcu_dereference_check(local_storage->cache[smap->cache_idx],
+				      bpf_rcu_lock_held());
 	if (sdata && rcu_access_pointer(sdata->smap) == smap)
 		return sdata;
 
@@ -306,7 +327,8 @@ int bpf_local_storage_alloc(void *owner,
 		 * bucket->list, first_selem can be freed immediately
 		 * (instead of kfree_rcu) because
 		 * bpf_local_storage_map_free() does a
-		 * synchronize_rcu() before walking the bucket->list.
+		 * synchronize_rcu_mult (waiting for both sleepable and
+		 * normal programs) before walking the bucket->list.
 		 * Hence, no one is accessing selem from the
 		 * bucket->list under rcu_read_lock().
 		 */
@@ -342,7 +364,8 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		     !map_value_has_spin_lock(&smap->map)))
 		return ERR_PTR(-EINVAL);
 
-	local_storage = rcu_dereference(*owner_storage(smap, owner));
+	local_storage = rcu_dereference_check(*owner_storage(smap, owner),
+					      bpf_rcu_lock_held());
 	if (!local_storage || hlist_empty(&local_storage->list)) {
 		/* Very first elem for the owner */
 		err = check_flags(NULL, map_flags);
@@ -486,7 +509,7 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
 	 * RCU read section to finish before proceeding. New RCU
 	 * read sections should be prevented via bpf_map_inc_not_zero.
 	 */
-	synchronize_rcu();
+	synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
 
 	/* bpf prog and the userspace can no longer access this map
 	 * now.  No new selem (of this map) can be added
@@ -530,7 +553,7 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
 	 *
 	 * Hence, wait another rcu grace period for the storage to be freed.
 	 */
-	synchronize_rcu();
+	synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
 
 	kvfree(smap->buckets);
 	kfree(smap);
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index bb69aea1a777..1def13ad5c72 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -17,6 +17,7 @@
 #include <uapi/linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/fdtable.h>
+#include <linux/rcupdate_trace.h>
 
 DEFINE_BPF_STORAGE_CACHE(task_cache);
 
@@ -59,7 +60,8 @@ task_storage_lookup(struct task_struct *task, struct bpf_map *map,
 	struct bpf_local_storage *task_storage;
 	struct bpf_local_storage_map *smap;
 
-	task_storage = rcu_dereference(task->bpf_storage);
+	task_storage =
+		rcu_dereference_check(task->bpf_storage, bpf_rcu_lock_held());
 	if (!task_storage)
 		return NULL;
 
@@ -77,7 +79,8 @@ void bpf_task_storage_free(struct task_struct *task)
 
 	rcu_read_lock();
 
-	local_storage = rcu_dereference(task->bpf_storage);
+	local_storage =
+		rcu_dereference_check(task->bpf_storage, bpf_rcu_lock_held());
 	if (!local_storage) {
 		rcu_read_unlock();
 		return;
@@ -229,6 +232,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
 {
 	struct bpf_local_storage_data *sdata;
 
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
 		return (unsigned long)NULL;
 
@@ -260,6 +264,7 @@ BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
 {
 	int ret;
 
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (!task)
 		return -EINVAL;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1126b75fe650..b6cc8c129579 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11791,6 +11791,9 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 			}
 			break;
 		case BPF_MAP_TYPE_RINGBUF:
+		case BPF_MAP_TYPE_INODE_STORAGE:
+		case BPF_MAP_TYPE_SK_STORAGE:
+		case BPF_MAP_TYPE_TASK_STORAGE:
 			break;
 		default:
 			verbose(env,
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 68d2cbf8331a..b6c725f30fd4 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -13,6 +13,7 @@
 #include <net/sock.h>
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
+#include <linux/rcupdate_trace.h>
 
 DEFINE_BPF_STORAGE_CACHE(sk_cache);
 
@@ -22,7 +23,8 @@ bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
 	struct bpf_local_storage *sk_storage;
 	struct bpf_local_storage_map *smap;
 
-	sk_storage = rcu_dereference(sk->sk_bpf_storage);
+	sk_storage =
+		rcu_dereference_check(sk->sk_bpf_storage, bpf_rcu_lock_held());
 	if (!sk_storage)
 		return NULL;
 
@@ -258,6 +260,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 {
 	struct bpf_local_storage_data *sdata;
 
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (!sk || !sk_fullsock(sk) || flags > BPF_SK_STORAGE_GET_F_CREATE)
 		return (unsigned long)NULL;
 
@@ -288,6 +291,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 
 BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 {
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (!sk || !sk_fullsock(sk))
 		return -EINVAL;
 
@@ -416,6 +420,7 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
 	   void *, value, u64, flags)
 {
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (in_hardirq() || in_nmi())
 		return (unsigned long)NULL;
 
@@ -425,6 +430,7 @@ BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
 BPF_CALL_2(bpf_sk_storage_delete_tracing, struct bpf_map *, map,
 	   struct sock *, sk)
 {
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (in_hardirq() || in_nmi())
 		return -EPERM;
 
-- 
2.34.1.400.ga245620fadb-goog

