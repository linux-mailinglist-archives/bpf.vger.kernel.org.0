Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D771D22D38C
	for <lists+bpf@lfdr.de>; Sat, 25 Jul 2020 03:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgGYBb3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 21:31:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14340 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726962AbgGYBb3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jul 2020 21:31:29 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06P1VP8P023818
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 18:31:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=RENzZVbCCHiiFap/DWLtdtoD728LymhxM6cTHbeXLIk=;
 b=KMG5pX3lYDeapuvFU3gfjKMVBwHgvmXAUs9nwccdtyrw4A9L3ND+pghkuCEgYYz1ZRiZ
 ediggeJ01WPZ1NWdatZ/T4JR4seqIBK4BsH1sL/ujTPuXbNHyMW/ypHrd68LgOdc4zv6
 +vqKUUNjBRL9+OWXYp30GplUOG3s66WitV0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32etbgceu7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 18:31:27 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 24 Jul 2020 18:30:54 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 4934929459FC; Fri, 24 Jul 2020 18:30:47 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Hostname: devbig005.ftw2.facebook.com
To:     KP Singh <kpsingh@chromium.org>, KP Singh <kpsingh@google.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC PATCH bpf-next] bpf: POC on local_storage charge and uncharge map_ops
Date:   Fri, 24 Jul 2020 18:30:47 -0700
Message-ID: <20200725013047.4006241-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200723115032.460770-4-kpsingh@chromium.org>
References: <20200723115032.460770-4-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-25_01:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007250009
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is a direct replacement of the patch 3 in discussion [1]
and to test out the idea on adding
map_local_storage_charge, map_local_storage_uncharge,
and map_owner_storage_ptr.

It is only compiler tested to demo the idea.

[1]: https://patchwork.ozlabs.org/project/netdev/patch/20200723115032.460=
770-4-kpsingh@chromium.org/

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h            |  10 ++
 include/net/bpf_sk_storage.h   |  51 +++++++
 include/uapi/linux/bpf.h       |   8 +-
 net/core/bpf_sk_storage.c      | 250 +++++++++++++++++++++------------
 tools/include/uapi/linux/bpf.h |   8 +-
 5 files changed, 236 insertions(+), 91 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 72221aea1c60..d4eab7ccbb51 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -33,6 +33,9 @@ struct btf;
 struct btf_type;
 struct exception_table_entry;
 struct seq_operations;
+struct bpf_local_storage;
+struct bpf_local_storage_map;
+struct bpf_local_storage_elem;
=20
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -93,6 +96,13 @@ struct bpf_map_ops {
 	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
 			     struct poll_table_struct *pts);
=20
+	/* Functions called by bpf_local_storage maps */
+	int (*map_local_storage_charge)(struct bpf_local_storage_map *smap,
+					void *owner, u32 size);
+	void (*map_local_storage_uncharge)(struct bpf_local_storage_map *smap,
+					   void *owner, u32 size);
+	struct bpf_local_storage __rcu ** (*map_owner_storage_ptr)(struct bpf_l=
ocal_storage_map *smap,
+								   void *owner);
 	/* BTF name and id of struct allocated by map_alloc */
 	const char * const map_btf_name;
 	int *map_btf_id;
diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 950c5aaba15e..05b777950eb3 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -3,8 +3,15 @@
 #ifndef _BPF_SK_STORAGE_H
 #define _BPF_SK_STORAGE_H
=20
+#include <linux/rculist.h>
+#include <linux/list.h>
+#include <linux/hash.h>
 #include <linux/types.h>
 #include <linux/spinlock.h>
+#include <linux/bpf.h>
+#include <net/sock.h>
+#include <uapi/linux/sock_diag.h>
+#include <uapi/linux/btf.h>
=20
 struct sock;
=20
@@ -34,6 +41,50 @@ u16 bpf_local_storage_cache_idx_get(struct bpf_local_s=
torage_cache *cache);
 void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *ca=
che,
 				      u16 idx);
=20
+/* Helper functions for bpf_local_storage */
+int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
+
+struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr=
 *attr);
+
+struct bpf_local_storage_data *
+bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
+			 struct bpf_local_storage_map *smap,
+			 bool cacheit_lockit);
+
+void bpf_local_storage_map_free(struct bpf_local_storage_map *smap);
+
+int bpf_local_storage_map_check_btf(const struct bpf_map *map,
+				    const struct btf *btf,
+				    const struct btf_type *key_type,
+				    const struct btf_type *value_type);
+
+void bpf_selem_link_storage(struct bpf_local_storage *local_storage,
+			    struct bpf_local_storage_elem *selem);
+
+bool bpf_selem_unlink_storage(struct bpf_local_storage *local_storage,
+			      struct bpf_local_storage_elem *selem,
+			      bool uncharge_omem);
+
+void bpf_selem_unlink(struct bpf_local_storage_elem *selem);
+
+void bpf_selem_link_map(struct bpf_local_storage_map *smap,
+			struct bpf_local_storage_elem *selem);
+
+void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem);
+
+struct bpf_local_storage_elem *
+bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *v=
alue,
+		bool charge_mem);
+
+int
+bpf_local_storage_alloc(void *owner,
+			struct bpf_local_storage_map *smap,
+			struct bpf_local_storage_elem *first_selem);
+
+struct bpf_local_storage_data *
+bpf_local_storage_update(void *owner, struct bpf_map *map, void *value,
+			 u64 map_flags);
+
 #ifdef CONFIG_BPF_SYSCALL
 int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk);
 struct bpf_sk_storage_diag *
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 54d0c886e3ba..b9d2e4792d08 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3630,9 +3630,13 @@ enum {
 	BPF_F_SYSCTL_BASE_NAME		=3D (1ULL << 0),
 };
=20
-/* BPF_FUNC_sk_storage_get flags */
+/* BPF_FUNC_<local>_storage_get flags */
 enum {
-	BPF_SK_STORAGE_GET_F_CREATE	=3D (1ULL << 0),
+	BPF_LOCAL_STORAGE_GET_F_CREATE	=3D (1ULL << 0),
+	/* BPF_SK_STORAGE_GET_F_CREATE is only kept for backward compatibility
+	 * and BPF_LOCAL_STORAGE_GET_F_CREATE must be used instead.
+	 */
+	BPF_SK_STORAGE_GET_F_CREATE  =3D BPF_LOCAL_STORAGE_GET_F_CREATE,
 };
=20
 /* BPF_FUNC_read_branch_records flags. */
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index aa3e3a47acb5..ec54b9d424c8 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -83,7 +83,7 @@ struct bpf_local_storage_elem {
 struct bpf_local_storage {
 	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE=
];
 	struct hlist_head list; /* List of bpf_local_storage_elem */
-	struct sock *owner;	/* The object that owns the the above "list" of
+	void *owner;		/* The object that owns the the above "list" of
 				 * bpf_local_storage_elem.
 				 */
 	struct rcu_head rcu;
@@ -109,6 +109,33 @@ static int omem_charge(struct sock *sk, unsigned int=
 size)
 	return -ENOMEM;
 }
=20
+static int mem_charge(struct bpf_local_storage_map *smap, void *owner, u=
32 size)
+{
+	struct bpf_map *map =3D &smap->map;
+
+	if (!map->ops->map_local_storage_charge)
+		return 0;
+
+	return map->ops->map_local_storage_charge(smap, owner, size);
+}
+
+static void mem_uncharge(struct bpf_local_storage_map *smap, void *owner=
,
+			 u32 size)
+{
+	struct bpf_map *map =3D &smap->map;
+
+	if (map->ops->map_local_storage_uncharge)
+		map->ops->map_local_storage_uncharge(smap, owner, size);
+}
+
+static struct bpf_local_storage __rcu **
+owner_storage(struct bpf_local_storage_map *smap, void *owner)
+{
+	struct bpf_map *map =3D &smap->map;
+
+	return map->ops->map_owner_storage_ptr(smap, owner);
+}
+
 static bool selem_linked_to_storage(const struct bpf_local_storage_elem =
*selem)
 {
 	return !hlist_unhashed(&selem->snode);
@@ -119,13 +146,13 @@ static bool selem_linked_to_map(const struct bpf_lo=
cal_storage_elem *selem)
 	return !hlist_unhashed(&selem->map_node);
 }
=20
-static struct bpf_local_storage_elem *
-bpf_selem_alloc(struct bpf_local_storage_map *smap, struct sock *sk,
-		void *value, bool charge_omem)
+struct bpf_local_storage_elem *
+bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
+		void *value, bool charge_mem)
 {
 	struct bpf_local_storage_elem *selem;
=20
-	if (charge_omem && omem_charge(sk, smap->elem_size))
+	if (charge_mem && mem_charge(smap, owner, smap->elem_size))
 		return NULL;
=20
 	selem =3D kzalloc(smap->elem_size, GFP_ATOMIC | __GFP_NOWARN);
@@ -135,40 +162,42 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap,=
 struct sock *sk,
 		return selem;
 	}
=20
-	if (charge_omem)
-		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
+	if (charge_mem)
+		mem_uncharge(smap, owner, smap->elem_size);
=20
 	return NULL;
 }
=20
-/* sk_storage->lock must be held and selem->sk_storage =3D=3D sk_storage=
.
+/* local_storage->lock must be held and selem->sk_storage =3D=3D sk_stor=
age.
  * The caller must ensure selem->smap is still valid to be
  * dereferenced for its smap->elem_size and smap->cache_idx.
  */
-static bool bpf_selem_unlink_storage(struct bpf_local_storage *local_sto=
rage,
-				     struct bpf_local_storage_elem *selem,
-				     bool uncharge_omem)
+bool bpf_selem_unlink_storage(struct bpf_local_storage *local_storage,
+			      struct bpf_local_storage_elem *selem,
+			      bool uncharge_mem)
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
-	struct sock *sk;
+	void *owner;
=20
 	smap =3D rcu_dereference(SDATA(selem)->smap);
-	sk =3D local_storage->owner;
+	owner =3D local_storage->owner;
=20
-	/* All uncharging on sk->sk_omem_alloc must be done first.
-	 * sk may be freed once the last selem is unlinked from local_storage.
+	/* All uncharging on owner must be done first.
+	 * The owner may be freed once the last selem is unlinked from
+	 * local_storage.
 	 */
-	if (uncharge_omem)
-		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
+	if (uncharge_mem)
+		mem_uncharge(smap, owner, smap->elem_size);
=20
 	free_local_storage =3D hlist_is_singular_node(&selem->snode,
 						    &local_storage->list);
 	if (free_local_storage) {
-		atomic_sub(sizeof(struct bpf_local_storage), &sk->sk_omem_alloc);
+		mem_uncharge(smap, owner, sizeof(struct bpf_local_storage));
 		local_storage->owner =3D NULL;
-		/* After this RCU_INIT, sk may be freed and cannot be used */
-		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
+
+		/* After this RCU_INIT, owner may be freed and cannot be used */
+		RCU_INIT_POINTER(*owner_storage(smap, owner), NULL);
=20
 		/* local_storage is not freed now.  local_storage->lock is
 		 * still held and raw_spin_unlock_bh(&local_storage->lock)
@@ -214,14 +243,14 @@ static void __bpf_selem_unlink_storage(struct bpf_l=
ocal_storage_elem *selem)
 		kfree_rcu(local_storage, rcu);
 }
=20
-static void bpf_selem_link_storage(struct bpf_local_storage *local_stora=
ge,
-				   struct bpf_local_storage_elem *selem)
+void bpf_selem_link_storage(struct bpf_local_storage *local_storage,
+			    struct bpf_local_storage_elem *selem)
 {
 	RCU_INIT_POINTER(selem->local_storage, local_storage);
 	hlist_add_head(&selem->snode, &local_storage->list);
 }
=20
-static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
+void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
@@ -238,8 +267,8 @@ static void bpf_selem_unlink_map(struct bpf_local_sto=
rage_elem *selem)
 	raw_spin_unlock_bh(&b->lock);
 }
=20
-static void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			       struct bpf_local_storage_elem *selem)
+void bpf_selem_link_map(struct bpf_local_storage_map *smap,
+			struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map_bucket *b =3D select_bucket(smap, selem);
=20
@@ -249,7 +278,7 @@ static void bpf_selem_link_map(struct bpf_local_stora=
ge_map *smap,
 	raw_spin_unlock_bh(&b->lock);
 }
=20
-static void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
+void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 {
 	/* Always unlink from map before unlinking from local_storage
 	 * because selem will be freed after successfully unlinked from
@@ -259,7 +288,7 @@ static void bpf_selem_unlink(struct bpf_local_storage=
_elem *selem)
 	__bpf_selem_unlink_storage(selem);
 }
=20
-static struct bpf_local_storage_data *
+struct bpf_local_storage_data *
 bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 			 struct bpf_local_storage_map *smap,
 			 bool cacheit_lockit)
@@ -325,40 +354,45 @@ static int check_flags(const struct bpf_local_stora=
ge_data *old_sdata,
 	return 0;
 }
=20
-static int sk_storage_alloc(struct sock *sk,
+int bpf_local_storage_alloc(void *owner,
 			    struct bpf_local_storage_map *smap,
 			    struct bpf_local_storage_elem *first_selem)
 {
-	struct bpf_local_storage *prev_sk_storage, *sk_storage;
+	struct bpf_local_storage *prev_storage, *storage;
+	struct bpf_local_storage **owner_storage_ptr;
 	int err;
=20
-	err =3D omem_charge(sk, sizeof(*sk_storage));
+	err =3D mem_charge(smap, owner, sizeof(*storage));
 	if (err)
 		return err;
=20
-	sk_storage =3D kzalloc(sizeof(*sk_storage), GFP_ATOMIC | __GFP_NOWARN);
-	if (!sk_storage) {
+	storage =3D kzalloc(sizeof(*storage), GFP_ATOMIC | __GFP_NOWARN);
+	if (!storage) {
 		err =3D -ENOMEM;
 		goto uncharge;
 	}
-	INIT_HLIST_HEAD(&sk_storage->list);
-	raw_spin_lock_init(&sk_storage->lock);
-	sk_storage->owner =3D sk;
=20
-	bpf_selem_link_storage(sk_storage, first_selem);
+	INIT_HLIST_HEAD(&storage->list);
+	raw_spin_lock_init(&storage->lock);
+	storage->owner =3D owner;
+
+	bpf_selem_link_storage(storage, first_selem);
 	bpf_selem_link_map(smap, first_selem);
-	/* Publish sk_storage to sk.  sk->sk_lock cannot be acquired.
-	 * Hence, atomic ops is used to set sk->sk_bpf_storage
-	 * from NULL to the newly allocated sk_storage ptr.
+
+	owner_storage_ptr =3D
+		(struct bpf_local_storage **)owner_storage(smap, owner);
+	/* Publish storage to the owner.
+	 * Instead of using any lock of the kernel object (i.e. owner),
+	 * cmpxchg will work with any kernel object regardless what
+	 * the running context is, bh, irq...etc.
 	 *
-	 * From now on, the sk->sk_bpf_storage pointer is protected
-	 * by the sk_storage->lock.  Hence,  when freeing
-	 * the sk->sk_bpf_storage, the sk_storage->lock must
-	 * be held before setting sk->sk_bpf_storage to NULL.
+	 * From now on, the owner->storage pointer (e.g. sk->sk_bpf_storage)
+	 * is protected by the storage->lock.  Hence, when freeing
+	 * the owner->storage, the storage->lock must be held before
+	 * setting owner->storage ptr to NULL.
 	 */
-	prev_sk_storage =3D cmpxchg((struct bpf_local_storage **)&sk->sk_bpf_st=
orage,
-				  NULL, sk_storage);
-	if (unlikely(prev_sk_storage)) {
+	prev_storage =3D cmpxchg(owner_storage_ptr, NULL, storage);
+	if (unlikely(prev_storage)) {
 		bpf_selem_unlink_map(first_selem);
 		err =3D -EAGAIN;
 		goto uncharge;
@@ -366,7 +400,7 @@ static int sk_storage_alloc(struct sock *sk,
 		/* Note that even first_selem was linked to smap's
 		 * bucket->list, first_selem can be freed immediately
 		 * (instead of kfree_rcu) because
-		 * bpf_sk_storage_map_free() does a
+		 * bpf_local_storage_map_free() does a
 		 * synchronize_rcu() before walking the bucket->list.
 		 * Hence, no one is accessing selem from the
 		 * bucket->list under rcu_read_lock().
@@ -376,8 +410,8 @@ static int sk_storage_alloc(struct sock *sk,
 	return 0;
=20
 uncharge:
-	kfree(sk_storage);
-	atomic_sub(sizeof(*sk_storage), &sk->sk_omem_alloc);
+	kfree(storage);
+	mem_uncharge(smap, owner, sizeof(*storage));
 	return err;
 }
=20
@@ -386,9 +420,9 @@ static int sk_storage_alloc(struct sock *sk,
  * Otherwise, it will become a leak (and other memory issues
  * during map destruction).
  */
-static struct bpf_local_storage_data *
-bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *val=
ue,
-			 u64 map_flags)
+struct bpf_local_storage_data *
+bpf_local_storage_update(void *owner, struct bpf_map *map,
+			 void *value, u64 map_flags)
 {
 	struct bpf_local_storage_data *old_sdata =3D NULL;
 	struct bpf_local_storage_elem *selem;
@@ -403,21 +437,21 @@ bpf_local_storage_update(struct sock *sk, struct bp=
f_map *map, void *value,
 		return ERR_PTR(-EINVAL);
=20
 	smap =3D (struct bpf_local_storage_map *)map;
-	local_storage =3D rcu_dereference(sk->sk_bpf_storage);
+	local_storage =3D rcu_dereference(*owner_storage(smap, owner));
 	if (!local_storage || hlist_empty(&local_storage->list)) {
-		/* Very first elem for this object */
+		/* Very first elem for the owner */
 		err =3D check_flags(NULL, map_flags);
 		if (err)
 			return ERR_PTR(err);
=20
-		selem =3D bpf_selem_alloc(smap, sk, value, true);
+		selem =3D bpf_selem_alloc(smap, owner, value, true);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
=20
-		err =3D sk_storage_alloc(sk, smap, selem);
+		err =3D bpf_local_storage_alloc(owner, smap, selem);
 		if (err) {
 			kfree(selem);
-			atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
+			mem_uncharge(smap, owner, smap->elem_size);
 			return ERR_PTR(err);
 		}
=20
@@ -429,8 +463,8 @@ bpf_local_storage_update(struct sock *sk, struct bpf_=
map *map, void *value,
 		 * such that it can avoid taking the local_storage->lock
 		 * and changing the lists.
 		 */
-		old_sdata =3D
-			bpf_local_storage_lookup(local_storage, smap, false);
+		old_sdata =3D bpf_local_storage_lookup(local_storage, smap,
+						     false);
 		err =3D check_flags(old_sdata, map_flags);
 		if (err)
 			return ERR_PTR(err);
@@ -474,7 +508,7 @@ bpf_local_storage_update(struct sock *sk, struct bpf_=
map *map, void *value,
 	 * old_sdata will not be uncharged later during
 	 * bpf_selem_unlink_storage().
 	 */
-	selem =3D bpf_selem_alloc(smap, sk, value, !old_sdata);
+	selem =3D bpf_selem_alloc(smap, owner, value, !old_sdata);
 	if (!selem) {
 		err =3D -ENOMEM;
 		goto unlock_err;
@@ -566,7 +600,7 @@ void bpf_sk_storage_free(struct sock *sk)
 	 * Thus, no elem can be added-to or deleted-from the
 	 * sk_storage->list by the bpf_prog or by the bpf-map's syscall.
 	 *
-	 * It is racing with bpf_sk_storage_map_free() alone
+	 * It is racing with bpf_local_storage_map_free() alone
 	 * when unlinking elem from the sk_storage->list and
 	 * the map's bucket->list.
 	 */
@@ -586,17 +620,12 @@ void bpf_sk_storage_free(struct sock *sk)
 		kfree_rcu(sk_storage, rcu);
 }
=20
-static void bpf_local_storage_map_free(struct bpf_map *map)
+void bpf_local_storage_map_free(struct bpf_local_storage_map *smap)
 {
 	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned int i;
=20
-	smap =3D (struct bpf_local_storage_map *)map;
-
-	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
-
 	/* Note that this map might be concurrently cloned from
 	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
 	 * RCU read section to finish before proceeding. New RCU
@@ -606,11 +635,12 @@ static void bpf_local_storage_map_free(struct bpf_m=
ap *map)
=20
 	/* bpf prog and the userspace can no longer access this map
 	 * now.  No new selem (of this map) can be added
-	 * to the sk->sk_bpf_storage or to the map bucket's list.
+	 * to the bpf_local_storage or to the map bucket's list.
 	 *
 	 * The elem of this map can be cleaned up here
 	 * or
-	 * by bpf_sk_storage_free() during __sk_destruct().
+	 * by bpf_local_storage_free() during the destruction of the
+	 * owner object. eg. __sk_destruct.
 	 */
 	for (i =3D 0; i < (1U << smap->bucket_log); i++) {
 		b =3D &smap->buckets[i];
@@ -626,22 +656,31 @@ static void bpf_local_storage_map_free(struct bpf_m=
ap *map)
 		rcu_read_unlock();
 	}
=20
-	/* bpf_sk_storage_free() may still need to access the map.
-	 * e.g. bpf_sk_storage_free() has unlinked selem from the map
+	/* bpf_local_storage_free() may still need to access the map.
+	 * e.g. bpf_local_storage_free() has unlinked selem from the map
 	 * which then made the above while((selem =3D ...)) loop
 	 * exited immediately.
 	 *
-	 * However, the bpf_sk_storage_free() still needs to access
+	 * However, the bpf_local_storage_free() still needs to access
 	 * the smap->elem_size to do the uncharging in
 	 * bpf_selem_unlink_storage().
 	 *
 	 * Hence, wait another rcu grace period for the
-	 * bpf_sk_storage_free() to finish.
+	 * bpf_local_storage_free() to finish.
 	 */
 	synchronize_rcu();
=20
 	kvfree(smap->buckets);
-	kfree(map);
+	kfree(smap);
+}
+
+static void sk_storage_map_free(struct bpf_map *map)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap =3D (struct bpf_local_storage_map *)map;
+	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
+	bpf_local_storage_map_free(smap);
 }
=20
 /* U16_MAX is much more than enough for sk local storage
@@ -653,7 +692,7 @@ static void bpf_local_storage_map_free(struct bpf_map=
 *map)
 	       sizeof(struct bpf_local_storage_elem)),			\
 	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
=20
-static int bpf_sk_storage_map_alloc_check(union bpf_attr *attr)
+int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
 	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
@@ -672,7 +711,7 @@ static int bpf_sk_storage_map_alloc_check(union bpf_a=
ttr *attr)
 	return 0;
 }
=20
-static struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
+struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr=
 *attr)
 {
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
@@ -710,9 +749,21 @@ static struct bpf_map *bpf_local_storage_map_alloc(u=
nion bpf_attr *attr)
 		raw_spin_lock_init(&smap->buckets[i].lock);
 	}
=20
-	smap->elem_size =3D sizeof(struct bpf_local_storage_elem) + attr->value=
_size;
-	smap->cache_idx =3D bpf_local_storage_cache_idx_get(&sk_cache);
+	smap->elem_size =3D
+		sizeof(struct bpf_local_storage_elem) + attr->value_size;
+
+	return smap;
+}
+
+static struct bpf_map *sk_storage_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_local_storage_map *smap;
=20
+	smap =3D bpf_local_storage_map_alloc(attr);
+	if (IS_ERR(smap))
+		return ERR_CAST(smap);
+
+	smap->cache_idx =3D bpf_local_storage_cache_idx_get(&sk_cache);
 	return &smap->map;
 }
=20
@@ -722,10 +773,10 @@ static int notsupp_get_next_key(struct bpf_map *map=
, void *key,
 	return -ENOTSUPP;
 }
=20
-static int bpf_sk_storage_map_check_btf(const struct bpf_map *map,
-					const struct btf *btf,
-					const struct btf_type *key_type,
-					const struct btf_type *value_type)
+int bpf_local_storage_map_check_btf(const struct bpf_map *map,
+				    const struct btf *btf,
+				    const struct btf_type *key_type,
+				    const struct btf_type *value_type)
 {
 	u32 int_data;
=20
@@ -856,7 +907,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struc=
t sock *newsk)
 			bpf_selem_link_map(smap, copy_selem);
 			bpf_selem_link_storage(new_sk_storage, copy_selem);
 		} else {
-			ret =3D sk_storage_alloc(newsk, smap, copy_selem);
+			ret =3D bpf_local_storage_alloc(newsk, smap, copy_selem);
 			if (ret) {
 				kfree(copy_selem);
 				atomic_sub(smap->elem_size,
@@ -925,18 +976,43 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *,=
 map, struct sock *, sk)
 	return -ENOENT;
 }
=20
+static int sk_storage_charge(struct bpf_local_storage_map *smap,
+			     void *owner, u32 size)
+{
+	return omem_charge(owner, size);
+}
+
+static void sk_storage_uncharge(struct bpf_local_storage_map *smap,
+				void *owner, u32 size)
+{
+	struct sock *sk =3D owner;
+
+	atomic_sub(size, &sk->sk_omem_alloc);
+}
+
+static struct bpf_local_storage __rcu **
+sk_storage_ptr(struct bpf_local_storage_map *smap, void *owner)
+{
+	struct sock *sk =3D owner;
+
+	return &sk->sk_bpf_storage;
+}
+
 static int sk_storage_map_btf_id;
 const struct bpf_map_ops sk_storage_map_ops =3D {
-	.map_alloc_check =3D bpf_sk_storage_map_alloc_check,
-	.map_alloc =3D bpf_local_storage_map_alloc,
-	.map_free =3D bpf_local_storage_map_free,
+	.map_alloc_check =3D bpf_local_storage_map_alloc_check,
+	.map_alloc =3D sk_storage_map_alloc,
+	.map_free =3D sk_storage_map_free,
 	.map_get_next_key =3D notsupp_get_next_key,
 	.map_lookup_elem =3D bpf_fd_sk_storage_lookup_elem,
 	.map_update_elem =3D bpf_fd_sk_storage_update_elem,
 	.map_delete_elem =3D bpf_fd_sk_storage_delete_elem,
-	.map_check_btf =3D bpf_sk_storage_map_check_btf,
+	.map_check_btf =3D bpf_local_storage_map_check_btf,
 	.map_btf_name =3D "bpf_local_storage_map",
 	.map_btf_id =3D &sk_storage_map_btf_id,
+	.map_local_storage_charge =3D sk_storage_charge,
+	.map_local_storage_uncharge =3D sk_storage_uncharge,
+	.map_owner_storage_ptr =3D sk_storage_ptr,
 };
=20
 const struct bpf_func_proto bpf_sk_storage_get_proto =3D {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 54d0c886e3ba..b9d2e4792d08 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3630,9 +3630,13 @@ enum {
 	BPF_F_SYSCTL_BASE_NAME		=3D (1ULL << 0),
 };
=20
-/* BPF_FUNC_sk_storage_get flags */
+/* BPF_FUNC_<local>_storage_get flags */
 enum {
-	BPF_SK_STORAGE_GET_F_CREATE	=3D (1ULL << 0),
+	BPF_LOCAL_STORAGE_GET_F_CREATE	=3D (1ULL << 0),
+	/* BPF_SK_STORAGE_GET_F_CREATE is only kept for backward compatibility
+	 * and BPF_LOCAL_STORAGE_GET_F_CREATE must be used instead.
+	 */
+	BPF_SK_STORAGE_GET_F_CREATE  =3D BPF_LOCAL_STORAGE_GET_F_CREATE,
 };
=20
 /* BPF_FUNC_read_branch_records flags. */
--=20
2.24.1

