Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD060D65E
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 23:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbiJYVyU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 17:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiJYVyR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 17:54:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95661FF232
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 14:54:16 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PJjifX003671
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 14:54:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=4Ih8rV4TQUOw8RXzuBj4oVesk2mAXMgo1r5JcrxWDI8=;
 b=P0WZUvJ7Bh5EWnq4IGA10vr2uYwgW6kF0hRqzeq18HQaMQQIAOAWgHvwPWG8unevsG9g
 L10P7KFFTWCqBCvvfqqQTpq2CRxKQ7TW0aGW3v+5iwG0oY+B+mP1U20//IyM/zBVD++5
 YkcAjvRb+v6w0NgV/LFGphGUjvpsm++vJqU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ke5sn3890-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 14:54:16 -0700
Received: from twshared3704.02.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 14:54:14 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 34586112E9DB8; Tue, 25 Oct 2022 14:54:03 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v5 2/7] bpf: Refactor some inode/task/sk storage functions for reuse
Date:   Tue, 25 Oct 2022 14:54:03 -0700
Message-ID: <20221025215403.4184996-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025215352.4184578-1-yhs@fb.com>
References: <20221025215352.4184578-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2iyBWYzccS3Co4n72H6iwGL2E7Aq4PR2
X-Proofpoint-GUID: 2iyBWYzccS3Co4n72H6iwGL2E7Aq4PR2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_13,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor codes so that inode/task/sk storage implementation
can maximally share the same code. I also added some comments
in new function bpf_local_storage_unlink_nolock() to make
codes easy to understand. There is no functionality change.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf_local_storage.h |  17 ++-
 kernel/bpf/bpf_inode_storage.c    |  38 +-----
 kernel/bpf/bpf_local_storage.c    | 190 +++++++++++++++++++-----------
 kernel/bpf/bpf_task_storage.c     |  38 +-----
 net/core/bpf_sk_storage.c         |  35 +-----
 5 files changed, 137 insertions(+), 181 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
index 7ea18d4da84b..6d37a40cd90e 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -116,21 +116,22 @@ static struct bpf_local_storage_cache name =3D {			=
\
 	.idx_lock =3D __SPIN_LOCK_UNLOCKED(name.idx_lock),	\
 }
=20
-u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cach=
e);
-void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *ca=
che,
-				      u16 idx);
-
 /* Helper functions for bpf_local_storage */
 int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
=20
-struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr=
 *attr);
+struct bpf_map *
+bpf_local_storage_map_alloc(union bpf_attr *attr,
+			    struct bpf_local_storage_cache *cache);
=20
 struct bpf_local_storage_data *
 bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 			 struct bpf_local_storage_map *smap,
 			 bool cacheit_lockit);
=20
-void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
+bool bpf_local_storage_unlink_nolock(struct bpf_local_storage *local_sto=
rage);
+
+void bpf_local_storage_map_free(struct bpf_map *map,
+				struct bpf_local_storage_cache *cache,
 				int __percpu *busy_counter);
=20
 int bpf_local_storage_map_check_btf(const struct bpf_map *map,
@@ -141,10 +142,6 @@ int bpf_local_storage_map_check_btf(const struct bpf=
_map *map,
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_stora=
ge,
 				   struct bpf_local_storage_elem *selem);
=20
-bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_sto=
rage,
-				     struct bpf_local_storage_elem *selem,
-				     bool uncharge_omem, bool use_trace_rcu);
-
 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_tra=
ce_rcu);
=20
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storag=
e.c
index 5f7683b19199..6a1d4d22816a 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -56,11 +56,9 @@ static struct bpf_local_storage_data *inode_storage_lo=
okup(struct inode *inode,
=20
 void bpf_inode_storage_free(struct inode *inode)
 {
-	struct bpf_local_storage_elem *selem;
 	struct bpf_local_storage *local_storage;
 	bool free_inode_storage =3D false;
 	struct bpf_storage_blob *bsb;
-	struct hlist_node *n;
=20
 	bsb =3D bpf_inode(inode);
 	if (!bsb)
@@ -74,30 +72,11 @@ void bpf_inode_storage_free(struct inode *inode)
 		return;
 	}
=20
-	/* Neither the bpf_prog nor the bpf-map's syscall
-	 * could be modifying the local_storage->list now.
-	 * Thus, no elem can be added-to or deleted-from the
-	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
-	 *
-	 * It is racing with bpf_local_storage_map_free() alone
-	 * when unlinking elem from the local_storage->list and
-	 * the map's bucket->list.
-	 */
 	raw_spin_lock_bh(&local_storage->lock);
-	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
-		/* Always unlink from map before unlinking from
-		 * local_storage.
-		 */
-		bpf_selem_unlink_map(selem);
-		free_inode_storage =3D bpf_selem_unlink_storage_nolock(
-			local_storage, selem, false, false);
-	}
+	free_inode_storage =3D bpf_local_storage_unlink_nolock(local_storage);
 	raw_spin_unlock_bh(&local_storage->lock);
 	rcu_read_unlock();
=20
-	/* free_inoode_storage should always be true as long as
-	 * local_storage->list was non-empty.
-	 */
 	if (free_inode_storage)
 		kfree_rcu(local_storage, rcu);
 }
@@ -226,23 +205,12 @@ static int notsupp_get_next_key(struct bpf_map *map=
, void *key,
=20
 static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap =3D bpf_local_storage_map_alloc(attr);
-	if (IS_ERR(smap))
-		return ERR_CAST(smap);
-
-	smap->cache_idx =3D bpf_local_storage_cache_idx_get(&inode_cache);
-	return &smap->map;
+	return bpf_local_storage_map_alloc(attr, &inode_cache);
 }
=20
 static void inode_storage_map_free(struct bpf_map *map)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap =3D (struct bpf_local_storage_map *)map;
-	bpf_local_storage_cache_idx_free(&inode_cache, smap->cache_idx);
-	bpf_local_storage_map_free(smap, NULL);
+	bpf_local_storage_map_free(map, &inode_cache, NULL);
 }
=20
 BTF_ID_LIST_SINGLE(inode_storage_map_btf_ids, struct,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
index 9dc6de1cf185..108aa17b9a7a 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -113,9 +113,9 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
  * The caller must ensure selem->smap is still valid to be
  * dereferenced for its smap->elem_size and smap->cache_idx.
  */
-bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_sto=
rage,
-				     struct bpf_local_storage_elem *selem,
-				     bool uncharge_mem, bool use_trace_rcu)
+static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *lo=
cal_storage,
+					    struct bpf_local_storage_elem *selem,
+					    bool uncharge_mem, bool use_trace_rcu)
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
@@ -500,7 +500,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
 	return ERR_PTR(err);
 }
=20
-u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cach=
e)
+static u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cach=
e *cache)
 {
 	u64 min_usage =3D U64_MAX;
 	u16 i, res =3D 0;
@@ -524,76 +524,14 @@ u16 bpf_local_storage_cache_idx_get(struct bpf_loca=
l_storage_cache *cache)
 	return res;
 }
=20
-void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *ca=
che,
-				      u16 idx)
+static void bpf_local_storage_cache_idx_free(struct bpf_local_storage_ca=
che *cache,
+					     u16 idx)
 {
 	spin_lock(&cache->idx_lock);
 	cache->idx_usage_counts[idx]--;
 	spin_unlock(&cache->idx_lock);
 }
=20
-void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
-				int __percpu *busy_counter)
-{
-	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage_map_bucket *b;
-	unsigned int i;
-
-	/* Note that this map might be concurrently cloned from
-	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
-	 * RCU read section to finish before proceeding. New RCU
-	 * read sections should be prevented via bpf_map_inc_not_zero.
-	 */
-	synchronize_rcu();
-
-	/* bpf prog and the userspace can no longer access this map
-	 * now.  No new selem (of this map) can be added
-	 * to the owner->storage or to the map bucket's list.
-	 *
-	 * The elem of this map can be cleaned up here
-	 * or when the storage is freed e.g.
-	 * by bpf_sk_storage_free() during __sk_destruct().
-	 */
-	for (i =3D 0; i < (1U << smap->bucket_log); i++) {
-		b =3D &smap->buckets[i];
-
-		rcu_read_lock();
-		/* No one is adding to b->list now */
-		while ((selem =3D hlist_entry_safe(
-				rcu_dereference_raw(hlist_first_rcu(&b->list)),
-				struct bpf_local_storage_elem, map_node))) {
-			if (busy_counter) {
-				migrate_disable();
-				this_cpu_inc(*busy_counter);
-			}
-			bpf_selem_unlink(selem, false);
-			if (busy_counter) {
-				this_cpu_dec(*busy_counter);
-				migrate_enable();
-			}
-			cond_resched_rcu();
-		}
-		rcu_read_unlock();
-	}
-
-	/* While freeing the storage we may still need to access the map.
-	 *
-	 * e.g. when bpf_sk_storage_free() has unlinked selem from the map
-	 * which then made the above while((selem =3D ...)) loop
-	 * exit immediately.
-	 *
-	 * However, while freeing the storage one still needs to access the
-	 * smap->elem_size to do the uncharging in
-	 * bpf_selem_unlink_storage_nolock().
-	 *
-	 * Hence, wait another rcu grace period for the storage to be freed.
-	 */
-	synchronize_rcu();
-
-	kvfree(smap->buckets);
-	bpf_map_area_free(smap);
-}
-
 int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
@@ -613,7 +551,7 @@ int bpf_local_storage_map_alloc_check(union bpf_attr =
*attr)
 	return 0;
 }
=20
-struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr=
 *attr)
+static struct bpf_local_storage_map *__bpf_local_storage_map_alloc(union=
 bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
@@ -663,3 +601,117 @@ int bpf_local_storage_map_check_btf(const struct bp=
f_map *map,
=20
 	return 0;
 }
+
+bool bpf_local_storage_unlink_nolock(struct bpf_local_storage *local_sto=
rage)
+{
+	struct bpf_local_storage_elem *selem;
+	bool free_storage =3D false;
+	struct hlist_node *n;
+
+	/* Neither the bpf_prog nor the bpf_map's syscall
+	 * could be modifying the local_storage->list now.
+	 * Thus, no elem can be added to or deleted from the
+	 * local_storage->list by the bpf_prog or by the bpf_map's syscall.
+	 *
+	 * It is racing with bpf_local_storage_map_free() alone
+	 * when unlinking elem from the local_storage->list and
+	 * the map's bucket->list.
+	 */
+	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
+		/* Always unlink from map before unlinking from
+		 * local_storage.
+		 */
+		bpf_selem_unlink_map(selem);
+		/* If local_storage list has only one element, the
+		 * bpf_selem_unlink_storage_nolock() will return true.
+		 * Otherwise, it will return false. The current loop iteration
+		 * intends to remove all local storage. So the last iteration
+		 * of the loop will set the free_cgroup_storage to true.
+		 */
+		free_storage =3D bpf_selem_unlink_storage_nolock(
+			local_storage, selem, false, false);
+	}
+
+	return free_storage;
+}
+
+struct bpf_map *
+bpf_local_storage_map_alloc(union bpf_attr *attr,
+			    struct bpf_local_storage_cache *cache)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap =3D __bpf_local_storage_map_alloc(attr);
+	if (IS_ERR(smap))
+		return ERR_CAST(smap);
+
+	smap->cache_idx =3D bpf_local_storage_cache_idx_get(cache);
+	return &smap->map;
+}
+
+void bpf_local_storage_map_free(struct bpf_map *map,
+				struct bpf_local_storage_cache *cache,
+				int __percpu *busy_counter)
+{
+	struct bpf_local_storage_map_bucket *b;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *smap;
+	unsigned int i;
+
+	smap =3D (struct bpf_local_storage_map *)map;
+	bpf_local_storage_cache_idx_free(cache, smap->cache_idx);
+
+	/* Note that this map might be concurrently cloned from
+	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
+	 * RCU read section to finish before proceeding. New RCU
+	 * read sections should be prevented via bpf_map_inc_not_zero.
+	 */
+	synchronize_rcu();
+
+	/* bpf prog and the userspace can no longer access this map
+	 * now.  No new selem (of this map) can be added
+	 * to the owner->storage or to the map bucket's list.
+	 *
+	 * The elem of this map can be cleaned up here
+	 * or when the storage is freed e.g.
+	 * by bpf_sk_storage_free() during __sk_destruct().
+	 */
+	for (i =3D 0; i < (1U << smap->bucket_log); i++) {
+		b =3D &smap->buckets[i];
+
+		rcu_read_lock();
+		/* No one is adding to b->list now */
+		while ((selem =3D hlist_entry_safe(
+				rcu_dereference_raw(hlist_first_rcu(&b->list)),
+				struct bpf_local_storage_elem, map_node))) {
+			if (busy_counter) {
+				migrate_disable();
+				this_cpu_inc(*busy_counter);
+			}
+			bpf_selem_unlink(selem, false);
+			if (busy_counter) {
+				this_cpu_dec(*busy_counter);
+				migrate_enable();
+			}
+			cond_resched_rcu();
+		}
+		rcu_read_unlock();
+	}
+
+	/* While freeing the storage we may still need to access the map.
+	 *
+	 * e.g. when bpf_sk_storage_free() has unlinked selem from the map
+	 * which then made the above while((selem =3D ...)) loop
+	 * exit immediately.
+	 *
+	 * However, while freeing the storage one still needs to access the
+	 * smap->elem_size to do the uncharging in
+	 * bpf_selem_unlink_storage_nolock().
+	 *
+	 * Hence, wait another rcu grace period for the storage to be freed.
+	 */
+	synchronize_rcu();
+
+	kvfree(smap->buckets);
+	bpf_map_area_free(smap);
+}
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.=
c
index 6f290623347e..40a92edd6f53 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -71,10 +71,8 @@ task_storage_lookup(struct task_struct *task, struct b=
pf_map *map,
=20
 void bpf_task_storage_free(struct task_struct *task)
 {
-	struct bpf_local_storage_elem *selem;
 	struct bpf_local_storage *local_storage;
 	bool free_task_storage =3D false;
-	struct hlist_node *n;
 	unsigned long flags;
=20
 	rcu_read_lock();
@@ -85,32 +83,13 @@ void bpf_task_storage_free(struct task_struct *task)
 		return;
 	}
=20
-	/* Neither the bpf_prog nor the bpf-map's syscall
-	 * could be modifying the local_storage->list now.
-	 * Thus, no elem can be added-to or deleted-from the
-	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
-	 *
-	 * It is racing with bpf_local_storage_map_free() alone
-	 * when unlinking elem from the local_storage->list and
-	 * the map's bucket->list.
-	 */
 	bpf_task_storage_lock();
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
-	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
-		/* Always unlink from map before unlinking from
-		 * local_storage.
-		 */
-		bpf_selem_unlink_map(selem);
-		free_task_storage =3D bpf_selem_unlink_storage_nolock(
-			local_storage, selem, false, false);
-	}
+	free_task_storage =3D bpf_local_storage_unlink_nolock(local_storage);
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	bpf_task_storage_unlock();
 	rcu_read_unlock();
=20
-	/* free_task_storage should always be true as long as
-	 * local_storage->list was non-empty.
-	 */
 	if (free_task_storage)
 		kfree_rcu(local_storage, rcu);
 }
@@ -288,23 +267,12 @@ static int notsupp_get_next_key(struct bpf_map *map=
, void *key, void *next_key)
=20
 static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap =3D bpf_local_storage_map_alloc(attr);
-	if (IS_ERR(smap))
-		return ERR_CAST(smap);
-
-	smap->cache_idx =3D bpf_local_storage_cache_idx_get(&task_cache);
-	return &smap->map;
+	return bpf_local_storage_map_alloc(attr, &task_cache);
 }
=20
 static void task_storage_map_free(struct bpf_map *map)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap =3D (struct bpf_local_storage_map *)map;
-	bpf_local_storage_cache_idx_free(&task_cache, smap->cache_idx);
-	bpf_local_storage_map_free(smap, &bpf_task_storage_busy);
+	bpf_local_storage_map_free(map, &task_cache, &bpf_task_storage_busy);
 }
=20
 BTF_ID_LIST_SINGLE(task_storage_map_btf_ids, struct, bpf_local_storage_m=
ap)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 94374d529ea4..49884e7de080 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -48,10 +48,8 @@ static int bpf_sk_storage_del(struct sock *sk, struct =
bpf_map *map)
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
 void bpf_sk_storage_free(struct sock *sk)
 {
-	struct bpf_local_storage_elem *selem;
 	struct bpf_local_storage *sk_storage;
 	bool free_sk_storage =3D false;
-	struct hlist_node *n;
=20
 	rcu_read_lock();
 	sk_storage =3D rcu_dereference(sk->sk_bpf_storage);
@@ -60,24 +58,8 @@ void bpf_sk_storage_free(struct sock *sk)
 		return;
 	}
=20
-	/* Netiher the bpf_prog nor the bpf-map's syscall
-	 * could be modifying the sk_storage->list now.
-	 * Thus, no elem can be added-to or deleted-from the
-	 * sk_storage->list by the bpf_prog or by the bpf-map's syscall.
-	 *
-	 * It is racing with bpf_local_storage_map_free() alone
-	 * when unlinking elem from the sk_storage->list and
-	 * the map's bucket->list.
-	 */
 	raw_spin_lock_bh(&sk_storage->lock);
-	hlist_for_each_entry_safe(selem, n, &sk_storage->list, snode) {
-		/* Always unlink from map before unlinking from
-		 * sk_storage.
-		 */
-		bpf_selem_unlink_map(selem);
-		free_sk_storage =3D bpf_selem_unlink_storage_nolock(
-			sk_storage, selem, true, false);
-	}
+	free_sk_storage =3D bpf_local_storage_unlink_nolock(sk_storage);
 	raw_spin_unlock_bh(&sk_storage->lock);
 	rcu_read_unlock();
=20
@@ -87,23 +69,12 @@ void bpf_sk_storage_free(struct sock *sk)
=20
 static void bpf_sk_storage_map_free(struct bpf_map *map)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap =3D (struct bpf_local_storage_map *)map;
-	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
-	bpf_local_storage_map_free(smap, NULL);
+	bpf_local_storage_map_free(map, &sk_cache, NULL);
 }
=20
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap =3D bpf_local_storage_map_alloc(attr);
-	if (IS_ERR(smap))
-		return ERR_CAST(smap);
-
-	smap->cache_idx =3D bpf_local_storage_cache_idx_get(&sk_cache);
-	return &smap->map;
+	return bpf_local_storage_map_alloc(attr, &sk_cache);
 }
=20
 static int notsupp_get_next_key(struct bpf_map *map, void *key,
--=20
2.30.2

