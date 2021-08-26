Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1303F9120
	for <lists+bpf@lfdr.de>; Fri, 27 Aug 2021 01:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhHZXw2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 19:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhHZXw2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 19:52:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7F3060F45;
        Thu, 26 Aug 2021 23:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630021900;
        bh=orGazhP7yJMztKdjMghQlC4kn9etEqOM9FcoWsSDCug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSkA9nGrnQRAs0DiDWbnykXgSv5RkJccs6R58TYql6eg9OfV93LyY5YWb3dPMVVm0
         /kfkHK6STxV4OSUXTGzh5iDmDT/QTUfZqhodLhpW7MfDsKrUsMol/3OU6XW8GwJ8Np
         OLHjoAuF2bZhaGXJGp9YBtyf0nAaTIEjBrvZ6a0LJHoZUDeEpjQZ60k7eImiXoHiMt
         k94xXcDM8nVKzqkzlW4uVh7+p5hkzMBVJ9ObFJZ3Lql9DTNDTt+Wz1s9ReUHq7D+7P
         zxeBicZfMS8IpRym9ItUFuWVS8Ke36WGKikPlygfHd24Ggy+ES3W9pL1BKpeVnGd4s
         SSOuB/YFl4/eA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by sleepable programs
Date:   Thu, 26 Aug 2021 23:51:26 +0000
Message-Id: <20210826235127.303505-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
In-Reply-To: <20210826235127.303505-1-kpsingh@kernel.org>
References: <20210826235127.303505-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Other maps like hashmaps are already available to sleepable programs.
Sleepable BPF programs run under trace RCU. Allow task, local and inode
storage to be used from sleepable programs.

The local storage code mostly runs under the programs RCU read section
(in __bpf_prog_enter{_sleepable} and __bpf_prog_exit{_sleepable})
(rcu_read_lock or rcu_read_lock_trace) with the exception the logic
where the map is freed.

After some discussions and help from Jann Horn, the following changes
were made:

bpf_local_storage{_elem} are freed with a kfree_rcu
wrapped with a call_rcu_tasks_trace callback instead of a direct
kfree_rcu which does not respect the trace RCU grace periods. The
callback frees the storage/selem with kfree_rcu which handles the normal
RCU grace period similar to BPF trampolines.

Update the synchronise_rcu to synchronize_rcu_mult in the map freeing
code to wait for trace RCU and normal RCU grace periods.
While this is an expensive operation, bpf_local_storage_map_free
is not called from within a BPF program, rather only called when the
owning object is being freed.

Update the dereferencing of the pointers to use rcu_derference_protected
(with either the trace or normal RCU locks held) and add warnings in the
beginning of the get and delete helpers.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf_local_storage.h |  5 ++++
 kernel/bpf/bpf_inode_storage.c    |  9 +++++--
 kernel/bpf/bpf_local_storage.c    | 43 ++++++++++++++++++++++++-------
 kernel/bpf/bpf_task_storage.c     |  6 ++++-
 kernel/bpf/verifier.c             |  3 +++
 net/core/bpf_sk_storage.c         |  8 +++++-
 6 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 24496bc28e7b..8453488b334d 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -16,6 +16,9 @@
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
 
+#define bpf_local_storage_rcu_lock_held()			\
+	(rcu_read_lock_held() || rcu_read_lock_trace_held() ||	\
+		rcu_read_lock_bh_held())
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
index 96ceed0e0fb5..409ef5d3efee 100644
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
+	inode_storage = rcu_dereference_protected(bsb->storage,
+						  bpf_local_storage_rcu_lock_held());
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
 
+	WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
 		return (unsigned long)NULL;
 
@@ -204,6 +208,7 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
 BPF_CALL_2(bpf_inode_storage_delete,
 	   struct bpf_map *, map, struct inode *, inode)
 {
+	WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
 	if (!inode)
 		return -EINVAL;
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b305270b7a4b..7760bc4e9565 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -11,6 +11,8 @@
 #include <net/sock.h>
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
+#include <linux/rcupdate_trace.h>
+#include <linux/rcupdate_wait.h>
 
 #define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
 
@@ -81,6 +83,22 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
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
@@ -118,12 +136,12 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
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
@@ -131,7 +149,7 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
 	    SDATA(selem))
 		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
-	kfree_rcu(selem, rcu);
+	call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
 
 	return free_local_storage;
 }
@@ -154,7 +172,8 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	if (free_local_storage)
-		kfree_rcu(local_storage, rcu);
+		call_rcu_tasks_trace(&local_storage->rcu,
+				     bpf_local_storage_free_rcu);
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
@@ -213,7 +232,8 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 	struct bpf_local_storage_elem *selem;
 
 	/* Fast path (cache hit) */
-	sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
+	sdata = rcu_dereference_protected(local_storage->cache[smap->cache_idx],
+					  bpf_local_storage_rcu_lock_held());
 	if (sdata && rcu_access_pointer(sdata->smap) == smap)
 		return sdata;
 
@@ -306,7 +326,8 @@ int bpf_local_storage_alloc(void *owner,
 		 * bucket->list, first_selem can be freed immediately
 		 * (instead of kfree_rcu) because
 		 * bpf_local_storage_map_free() does a
-		 * synchronize_rcu() before walking the bucket->list.
+		 * synchronize_rcu_mult (waiting for both sleepable and
+		 * normal programs) before walking the bucket->list.
 		 * Hence, no one is accessing selem from the
 		 * bucket->list under rcu_read_lock().
 		 */
@@ -485,8 +506,12 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
 	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
 	 * RCU read section to finish before proceeding. New RCU
 	 * read sections should be prevented via bpf_map_inc_not_zero.
+	 *
+	 * A call_rcu_tasks_trace is an expensive operation but
+	 * bpf_local_storage_map_free is not called from the BPF program or
+	 * hotpaths. It's called when the owning object is freed.
 	 */
-	synchronize_rcu();
+	synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
 
 	/* bpf prog and the userspace can no longer access this map
 	 * now.  No new selem (of this map) can be added
@@ -530,7 +555,7 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
 	 *
 	 * Hence, wait another rcu grace period for the storage to be freed.
 	 */
-	synchronize_rcu();
+	synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);
 
 	kvfree(smap->buckets);
 	kfree(smap);
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 3ce75758d394..87f0daeff314 100644
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
+	task_storage = rcu_dereference_protected(task->bpf_storage,
+						 bpf_local_storage_rcu_lock_held());
 	if (!task_storage)
 		return NULL;
 
@@ -229,6 +231,7 @@ BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
 {
 	struct bpf_local_storage_data *sdata;
 
+	WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
 	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
 		return (unsigned long)NULL;
 
@@ -260,6 +263,7 @@ BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
 {
 	int ret;
 
+	WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
 	if (!task)
 		return -EINVAL;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 206c221453cf..4e0b807a0104 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11457,6 +11457,9 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
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
index 68d2cbf8331a..b56578579a0d 100644
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
+	sk_storage = rcu_dereference_protected(sk->sk_bpf_storage,
+					       bpf_local_storage_rcu_lock_held());
 	if (!sk_storage)
 		return NULL;
 
@@ -258,6 +260,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 {
 	struct bpf_local_storage_data *sdata;
 
+	WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
 	if (!sk || !sk_fullsock(sk) || flags > BPF_SK_STORAGE_GET_F_CREATE)
 		return (unsigned long)NULL;
 
@@ -288,6 +291,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 
 BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 {
+	WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
 	if (!sk || !sk_fullsock(sk))
 		return -EINVAL;
 
@@ -416,6 +420,7 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
 	   void *, value, u64, flags)
 {
+	WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
 	if (in_hardirq() || in_nmi())
 		return (unsigned long)NULL;
 
@@ -425,6 +430,7 @@ BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct sock *, sk,
 BPF_CALL_2(bpf_sk_storage_delete_tracing, struct bpf_map *, map,
 	   struct sock *, sk)
 {
+	WARN_ON_ONCE(!bpf_local_storage_rcu_lock_held());
 	if (in_hardirq() || in_nmi())
 		return -EPERM;
 
-- 
2.33.0.259.gc128427fd7-goog

