Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5061507D94
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 02:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbiDTAZV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 20:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiDTAZQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 20:25:16 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC172ED7F
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:22:31 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23JMJ9Cm006796
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:22:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8kq9rir/sXrKs6kIYJLWJy2y/WXp+nLtJyebx+EG6oM=;
 b=LiNAkRKBeFzU39qKForJqD7p7gQM8q0uioVJRn0Zcoo2rg4VTE7XTYKL4f08KmyQiLUR
 Tli5vUCeUbq5QO+Z3qUST777KstDXDxmZfdmR+bTsPhAhbpG3UXdMUJdPLXZRh0ZkD2D
 IJWgznvMquUmRUYRn986NyM6YDECqPpgbpQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fhub759pb-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 17:22:30 -0700
Received: from twshared27284.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 17:22:04 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 633F610F66426; Tue, 19 Apr 2022 17:21:58 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 1/3] bpf: Introduce local_storage exclusive caching option
Date:   Tue, 19 Apr 2022 17:21:41 -0700
Message-ID: <20220420002143.1096548-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420002143.1096548-1-davemarchevsky@fb.com>
References: <20220420002143.1096548-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: y7Bi1kFYMXPWzmK0WOOCijpit4-GHHtZ
X-Proofpoint-ORIG-GUID: y7Bi1kFYMXPWzmK0WOOCijpit4-GHHtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_08,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow local_storage maps to claim exclusive use of a cache slot in
struct bpf_local_storage's cache. When a local_storage map claims a
slot and is cached in via bpf_local_storage_lookup, it will not be
replaced until the map is free'd. As a result, after a local_storage map
is alloc'd for a specific bpf_local_storage, lookup calls after the
first will quickly find the correct map.

When requesting an exclusive cache slot, bpf_local_storage_cache_idx_get
can now fail if all slots are already claimed. Because a map's cache_idx
is assigned when the bpf_map is allocated - which occurs before the
program runs - the map load and subsequent prog load will fail.

A bit in struct bpf_map's map_extra is used to designate whether a map
would like to claim an exclusive slot. Similarly, bitmap idx_exclusive
is added to bpf_local_storage_cache to track whether a slot is
exclusively claimed. Functions that manipulate the cache are modified to
test for BPF_LOCAL_STORAGE_FORCE_CACHE bit and test/set idx_exclusive
where necessary.

When a map exclusively claims a cache slot, non-exclusive local_storage
maps which were previously assigned the same cache_idx are not
migrated to unclaimed cache_idx. Such a migration would require full
iteration of the cache list and necessitate a reverse migration on map
free to even things out. Since a used cache slot will only be
exclusively claimed if no empty slot exists, the additional complexity
was deemed unnecessary.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf_local_storage.h |  6 +++--
 include/uapi/linux/bpf.h          | 14 +++++++++++
 kernel/bpf/bpf_inode_storage.c    | 16 +++++++++---
 kernel/bpf/bpf_local_storage.c    | 42 +++++++++++++++++++++++++------
 kernel/bpf/bpf_task_storage.c     | 16 +++++++++---
 kernel/bpf/syscall.c              |  7 ++++--
 net/core/bpf_sk_storage.c         | 15 ++++++++---
 7 files changed, 95 insertions(+), 21 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
index 493e63258497..d87405a1b65d 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -109,6 +109,7 @@ struct bpf_local_storage {
 struct bpf_local_storage_cache {
 	spinlock_t idx_lock;
 	u64 idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
+	DECLARE_BITMAP(idx_exclusive, BPF_LOCAL_STORAGE_CACHE_SIZE);
 };
=20
 #define DEFINE_BPF_STORAGE_CACHE(name)				\
@@ -116,9 +117,10 @@ static struct bpf_local_storage_cache name =3D {			\
 	.idx_lock =3D __SPIN_LOCK_UNLOCKED(name.idx_lock),	\
 }
=20
-u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cach=
e);
+int bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cach=
e,
+				    u64 flags);
 void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *ca=
che,
-				      u16 idx);
+				       u16 idx, u64 flags);
=20
 /* Helper functions for bpf_local_storage */
 int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d14b10b85e51..566035bc2f08 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1257,6 +1257,18 @@ enum bpf_stack_build_id_status {
 	BPF_STACK_BUILD_ID_IP =3D 2,
 };
=20
+/* Flags passed in map_extra when creating local_storage maps
+ * of types: BPF_MAP_TYPE_INODE_STORAGE
+ *           BPF_MAP_TYPE_TASK_STORAGE
+ *           BPF_MAP_TYPE_SK_STORAGE
+ */
+enum bpf_local_storage_extra_flags {
+	/* Give the map exclusive use of a local_storage cache slot
+	 * or fail map alloc
+	 */
+	BPF_LOCAL_STORAGE_FORCE_CACHE =3D (1U << 0),
+};
+
 #define BPF_BUILD_ID_SIZE 20
 struct bpf_stack_build_id {
 	__s32		status;
@@ -1296,6 +1308,8 @@ union bpf_attr {
 		 * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate the
 		 * number of hash functions (if 0, the bloom filter will default
 		 * to using 5 hash functions).
+		 * BPF_MAP_TYPE_{INODE,TASK,SK}_STORAGE - local_storage specific
+		 * flags (see bpf_local_storage_extra_flags)
 		 */
 		__u64	map_extra;
 	};
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storag=
e.c
index 96be8d518885..8b32adc23fc3 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -227,12 +227,21 @@ static int notsupp_get_next_key(struct bpf_map *map=
, void *key,
 static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
+	int cache_idx_or_err;
+
+	cache_idx_or_err =3D bpf_local_storage_cache_idx_get(&inode_cache,
+							   attr->map_extra);
+	if (cache_idx_or_err < 0)
+		return ERR_PTR(cache_idx_or_err);
=20
 	smap =3D bpf_local_storage_map_alloc(attr);
-	if (IS_ERR(smap))
+	if (IS_ERR(smap)) {
+		bpf_local_storage_cache_idx_free(&inode_cache, (u16)cache_idx_or_err,
+						 attr->map_extra);
 		return ERR_CAST(smap);
+	}
=20
-	smap->cache_idx =3D bpf_local_storage_cache_idx_get(&inode_cache);
+	smap->cache_idx =3D (u16)cache_idx_or_err;
 	return &smap->map;
 }
=20
@@ -241,7 +250,8 @@ static void inode_storage_map_free(struct bpf_map *ma=
p)
 	struct bpf_local_storage_map *smap;
=20
 	smap =3D (struct bpf_local_storage_map *)map;
-	bpf_local_storage_cache_idx_free(&inode_cache, smap->cache_idx);
+	bpf_local_storage_cache_idx_free(&inode_cache, smap->cache_idx,
+					 map->map_extra);
 	bpf_local_storage_map_free(smap, NULL);
 }
=20
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
index 01aa2b51ec4d..b23080247bef 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -231,12 +231,19 @@ bpf_local_storage_lookup(struct bpf_local_storage *=
local_storage,
 {
 	struct bpf_local_storage_data *sdata;
 	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *cached;
+	bool cached_exclusive =3D false;
=20
 	/* Fast path (cache hit) */
 	sdata =3D rcu_dereference_check(local_storage->cache[smap->cache_idx],
 				      bpf_rcu_lock_held());
-	if (sdata && rcu_access_pointer(sdata->smap) =3D=3D smap)
-		return sdata;
+	if (sdata) {
+		if (rcu_access_pointer(sdata->smap) =3D=3D smap)
+			return sdata;
+
+		cached =3D rcu_dereference_check(sdata->smap, bpf_rcu_lock_held());
+		cached_exclusive =3D cached->map.map_extra & BPF_LOCAL_STORAGE_FORCE_C=
ACHE;
+	}
=20
 	/* Slow path (cache miss) */
 	hlist_for_each_entry_rcu(selem, &local_storage->list, snode,
@@ -248,7 +255,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *lo=
cal_storage,
 		return NULL;
=20
 	sdata =3D SDATA(selem);
-	if (cacheit_lockit) {
+	if (cacheit_lockit && !cached_exclusive) {
 		unsigned long flags;
=20
 		/* spinlock is needed to avoid racing with the
@@ -482,15 +489,27 @@ bpf_local_storage_update(void *owner, struct bpf_lo=
cal_storage_map *smap,
 	return ERR_PTR(err);
 }
=20
-u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cach=
e)
+int bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cach=
e,
+				    u64 flags)
 {
+	bool exclusive =3D flags & BPF_LOCAL_STORAGE_FORCE_CACHE;
+	bool adding_to_full =3D false;
 	u64 min_usage =3D U64_MAX;
-	u16 i, res =3D 0;
+	int res =3D 0;
+	u16 i;
=20
 	spin_lock(&cache->idx_lock);
=20
+	if (bitmap_full(cache->idx_exclusive, BPF_LOCAL_STORAGE_CACHE_SIZE)) {
+		res =3D -ENOMEM;
+		adding_to_full =3D true;
+		if (exclusive)
+			goto out;
+	}
+
 	for (i =3D 0; i < BPF_LOCAL_STORAGE_CACHE_SIZE; i++) {
-		if (cache->idx_usage_counts[i] < min_usage) {
+		if ((adding_to_full || !test_bit(i, cache->idx_exclusive)) &&
+		    cache->idx_usage_counts[i] < min_usage) {
 			min_usage =3D cache->idx_usage_counts[i];
 			res =3D i;
=20
@@ -499,17 +518,23 @@ u16 bpf_local_storage_cache_idx_get(struct bpf_loca=
l_storage_cache *cache)
 				break;
 		}
 	}
+
+	if (exclusive)
+		set_bit(res, cache->idx_exclusive);
 	cache->idx_usage_counts[res]++;
=20
+out:
 	spin_unlock(&cache->idx_lock);
=20
 	return res;
 }
=20
 void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *ca=
che,
-				      u16 idx)
+				      u16 idx, u64 flags)
 {
 	spin_lock(&cache->idx_lock);
+	if (flags & BPF_LOCAL_STORAGE_FORCE_CACHE)
+		clear_bit(idx, cache->idx_exclusive);
 	cache->idx_usage_counts[idx]--;
 	spin_unlock(&cache->idx_lock);
 }
@@ -583,7 +608,8 @@ int bpf_local_storage_map_alloc_check(union bpf_attr =
*attr)
 	    attr->max_entries ||
 	    attr->key_size !=3D sizeof(int) || !attr->value_size ||
 	    /* Enforce BTF for userspace sk dumping */
-	    !attr->btf_key_type_id || !attr->btf_value_type_id)
+	    !attr->btf_key_type_id || !attr->btf_value_type_id ||
+	    attr->map_extra & ~BPF_LOCAL_STORAGE_FORCE_CACHE)
 		return -EINVAL;
=20
 	if (!bpf_capable())
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.=
c
index 6638a0ecc3d2..bf7b098d15c9 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -289,12 +289,21 @@ static int notsupp_get_next_key(struct bpf_map *map=
, void *key, void *next_key)
 static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
+	int cache_idx_or_err;
+
+	cache_idx_or_err =3D bpf_local_storage_cache_idx_get(&task_cache,
+							   attr->map_extra);
+	if (cache_idx_or_err < 0)
+		return ERR_PTR(cache_idx_or_err);
=20
 	smap =3D bpf_local_storage_map_alloc(attr);
-	if (IS_ERR(smap))
+	if (IS_ERR(smap)) {
+		bpf_local_storage_cache_idx_free(&task_cache, (u16)cache_idx_or_err,
+						 attr->map_extra);
 		return ERR_CAST(smap);
+	}
=20
-	smap->cache_idx =3D bpf_local_storage_cache_idx_get(&task_cache);
+	smap->cache_idx =3D (u16)cache_idx_or_err;
 	return &smap->map;
 }
=20
@@ -303,7 +312,8 @@ static void task_storage_map_free(struct bpf_map *map=
)
 	struct bpf_local_storage_map *smap;
=20
 	smap =3D (struct bpf_local_storage_map *)map;
-	bpf_local_storage_cache_idx_free(&task_cache, smap->cache_idx);
+	bpf_local_storage_cache_idx_free(&task_cache, smap->cache_idx,
+					 map->map_extra);
 	bpf_local_storage_map_free(smap, &bpf_task_storage_busy);
 }
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e9621cfa09f2..9fd610e53840 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -847,8 +847,11 @@ static int map_create(union bpf_attr *attr)
 		return -EINVAL;
 	}
=20
-	if (attr->map_type !=3D BPF_MAP_TYPE_BLOOM_FILTER &&
-	    attr->map_extra !=3D 0)
+	if (!(attr->map_type =3D=3D BPF_MAP_TYPE_BLOOM_FILTER ||
+	      attr->map_type =3D=3D BPF_MAP_TYPE_INODE_STORAGE ||
+	      attr->map_type =3D=3D BPF_MAP_TYPE_TASK_STORAGE ||
+	      attr->map_type =3D=3D BPF_MAP_TYPE_SK_STORAGE) &&
+	     attr->map_extra !=3D 0)
 		return -EINVAL;
=20
 	f_flags =3D bpf_get_file_flag(attr->map_flags);
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index e3ac36380520..f6a95f525f50 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -90,19 +90,28 @@ static void bpf_sk_storage_map_free(struct bpf_map *m=
ap)
 	struct bpf_local_storage_map *smap;
=20
 	smap =3D (struct bpf_local_storage_map *)map;
-	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
+	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx, map->map_e=
xtra);
 	bpf_local_storage_map_free(smap, NULL);
 }
=20
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
+	int cache_idx_or_err;
+
+	cache_idx_or_err =3D bpf_local_storage_cache_idx_get(&sk_cache,
+							   attr->map_extra);
+	if (cache_idx_or_err < 0)
+		return ERR_PTR(cache_idx_or_err);
=20
 	smap =3D bpf_local_storage_map_alloc(attr);
-	if (IS_ERR(smap))
+	if (IS_ERR(smap)) {
+		bpf_local_storage_cache_idx_free(&sk_cache, (u16)cache_idx_or_err,
+						 attr->map_extra);
 		return ERR_CAST(smap);
+	}
=20
-	smap->cache_idx =3D bpf_local_storage_cache_idx_get(&sk_cache);
+	smap->cache_idx =3D (u16)cache_idx_or_err;
 	return &smap->map;
 }
=20
--=20
2.30.2

