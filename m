Return-Path: <bpf+bounces-15383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F9B7F1BD3
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 18:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8A0282241
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7133E2FE2F;
	Mon, 20 Nov 2023 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qjblR0nW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDABA4
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 09:59:45 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKHt7io021267
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 09:59:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nTkv5AgwVJZIcb5WfkdA3pBswRVpp5QAEUyU3nLIegs=;
 b=qjblR0nWTGV3nrAB6ifqF7WlFuL8kJjSkVbj638pmnAD5PNGA56xQnjoaWKs97uVfw1q
 dl7RLdmkvLN5j+SfCniDVEAJlkO9GrbUWobcppRisrMmRnNQJVNLduqbQgM8LHHIVhyo
 sPbVpMHXdkGrtRFQRCYLmFhxxWr49pTqq/E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ugajcs0dm-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 09:59:44 -0800
Received: from twshared4397.08.ash8.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 09:59:39 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id ADF7E2792C0FF; Mon, 20 Nov 2023 09:59:27 -0800 (PST)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner
	<hannes@cmpxchg.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_MMAPABLE task_local storage
Date: Mon, 20 Nov 2023 09:59:24 -0800
Message-ID: <20231120175925.733167-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120175925.733167-1-davemarchevsky@fb.com>
References: <20231120175925.733167-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9gUEXguDYtHN-MYHVRr3o0LG2Piz6g90
X-Proofpoint-GUID: 9gUEXguDYtHN-MYHVRr3o0LG2Piz6g90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_18,2023-11-20_01,2023-05-22_02

This patch modifies the generic bpf_local_storage infrastructure to
support mmapable map values and adds mmap() handling to task_local
storage leveraging this new functionality. A userspace task which
mmap's a task_local storage map will receive a pointer to the map_value
corresponding to that tasks' key - mmap'ing in other tasks' mapvals is
not supported in this patch.

Currently, struct bpf_local_storage_elem contains both bookkeeping
information as well as a struct bpf_local_storage_data with additional
bookkeeping information and the actual mapval data. We can't simply map
the page containing this struct into userspace. Instead, mmapable
local_storage uses bpf_local_storage_data's data field to point to the
actual mapval, which is allocated separately such that it can be
mmapped. Only the mapval lives on the page(s) allocated for it.

The lifetime of the actual_data mmapable region is tied to the
bpf_local_storage_elem which points to it. This doesn't necessarily mean
that the pages go away when the bpf_local_storage_elem is free'd - if
they're mapped into some userspace process they will remain until
unmapped, but are no longer the task_local storage's mapval.

Implementation details:

  * A few small helpers are added to deal with bpf_local_storage_data's
    'data' field having different semantics when the local_storage map
    is mmapable. With their help, many of the changes to existing code
    are purely mechanical (e.g. sdata->data becomes sdata_mapval(sdata),
    selem->elem_size becomes selem_bytes_used(selem)).

  * The map flags are copied into bpf_local_storage_data when its
    containing bpf_local_storage_elem is alloc'd, since the
    bpf_local_storage_map associated with them may be gone when
    bpf_local_storage_data is free'd, and testing flags for
    BPF_F_MMAPABLE is necessary when free'ing to ensure that the
    mmapable region is free'd.
    * The extra field doesn't change bpf_local_storage_elem's size.
      There were 48 bytes of padding after the bpf_local_storage_data
      field, now there are 40.

  * Currently, bpf_local_storage_update always creates a new
    bpf_local_storage_elem for the 'updated' value - the only exception
    being if the map_value has a bpf_spin_lock field, in which case the
    spin lock is grabbed instead of the less granular bpf_local_storage
    lock, and the value updated in place. This inplace update behavior
    is desired for mmapable local_storage map_values as well, since
    creating a new selem would result in new mmapable pages.

  * The size of the mmapable pages are accounted for when calling
    mem_{charge,uncharge}. If the pages are mmap'd into a userspace task
    mem_uncharge may be called before they actually go away.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf_local_storage.h |  14 ++-
 kernel/bpf/bpf_local_storage.c    | 145 ++++++++++++++++++++++++------
 kernel/bpf/bpf_task_storage.c     |  35 ++++++--
 kernel/bpf/syscall.c              |   2 +-
 4 files changed, 163 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
index 173ec7f43ed1..114973f925ea 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -69,7 +69,17 @@ struct bpf_local_storage_data {
 	 * the number of cachelines accessed during the cache hit case.
 	 */
 	struct bpf_local_storage_map __rcu *smap;
-	u8 data[] __aligned(8);
+	/* Need to duplicate smap's map_flags as smap may be gone when
+	 * it's time to free bpf_local_storage_data
+	 */
+	u64 smap_map_flags;
+	/* If BPF_F_MMAPABLE, this is a void * to separately-alloc'd data
+	 * Otherwise the actual mapval data lives here
+	 */
+	union {
+		DECLARE_FLEX_ARRAY(u8, data) __aligned(8);
+		void *actual_data __aligned(8);
+	};
 };
=20
 /* Linked to bpf_local_storage and bpf_local_storage_map */
@@ -124,6 +134,8 @@ static struct bpf_local_storage_cache name =3D {			\
 /* Helper functions for bpf_local_storage */
 int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
=20
+void *sdata_mapval(struct bpf_local_storage_data *data);
+
 struct bpf_map *
 bpf_local_storage_map_alloc(union bpf_attr *attr,
 			    struct bpf_local_storage_cache *cache,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
index 146824cc9689..9b3becbcc1a3 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -15,7 +15,8 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/rcupdate_wait.h>
=20
-#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CL=
ONE)
+#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK \
+	(BPF_F_NO_PREALLOC | BPF_F_CLONE | BPF_F_MMAPABLE)
=20
 static struct bpf_local_storage_map_bucket *
 select_bucket(struct bpf_local_storage_map *smap,
@@ -24,6 +25,51 @@ select_bucket(struct bpf_local_storage_map *smap,
 	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
 }
=20
+struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map);
+
+void *alloc_mmapable_selem_value(struct bpf_local_storage_map *smap)
+{
+	struct mem_cgroup *memcg, *old_memcg;
+	void *ptr;
+
+	memcg =3D bpf_map_get_memcg(&smap->map);
+	old_memcg =3D set_active_memcg(memcg);
+	ptr =3D bpf_map_area_mmapable_alloc(PAGE_ALIGN(smap->map.value_size),
+					  NUMA_NO_NODE);
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+
+	return ptr;
+}
+
+void *sdata_mapval(struct bpf_local_storage_data *data)
+{
+	if (data->smap_map_flags & BPF_F_MMAPABLE)
+		return data->actual_data;
+	return &data->data;
+}
+
+static size_t sdata_data_field_size(struct bpf_local_storage_map *smap,
+				    struct bpf_local_storage_data *data)
+{
+	if (smap->map.map_flags & BPF_F_MMAPABLE)
+		return sizeof(void *);
+	return (size_t)smap->map.value_size;
+}
+
+static u32 selem_bytes_used(struct bpf_local_storage_map *smap)
+{
+	if (smap->map.map_flags & BPF_F_MMAPABLE)
+		return smap->elem_size + PAGE_ALIGN(smap->map.value_size);
+	return smap->elem_size;
+}
+
+static bool can_update_existing_selem(struct bpf_local_storage_map *smap=
,
+				      u64 flags)
+{
+	return flags & BPF_F_LOCK || smap->map.map_flags & BPF_F_MMAPABLE;
+}
+
 static int mem_charge(struct bpf_local_storage_map *smap, void *owner, u=
32 size)
 {
 	struct bpf_map *map =3D &smap->map;
@@ -76,10 +122,19 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, =
void *owner,
 		void *value, bool charge_mem, gfp_t gfp_flags)
 {
 	struct bpf_local_storage_elem *selem;
+	void *mmapable_value =3D NULL;
+	u32 selem_mem;
=20
-	if (charge_mem && mem_charge(smap, owner, smap->elem_size))
+	selem_mem =3D selem_bytes_used(smap);
+	if (charge_mem && mem_charge(smap, owner, selem_mem))
 		return NULL;
=20
+	if (smap->map.map_flags & BPF_F_MMAPABLE) {
+		mmapable_value =3D alloc_mmapable_selem_value(smap);
+		if (!mmapable_value)
+			goto err_out;
+	}
+
 	if (smap->bpf_ma) {
 		migrate_disable();
 		selem =3D bpf_mem_cache_alloc_flags(&smap->selem_ma, gfp_flags);
@@ -92,22 +147,28 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, =
void *owner,
 			 * only does bpf_mem_cache_free when there is
 			 * no other bpf prog is using the selem.
 			 */
-			memset(SDATA(selem)->data, 0, smap->map.value_size);
+			memset(SDATA(selem)->data, 0,
+			       sdata_data_field_size(smap, SDATA(selem)));
 	} else {
 		selem =3D bpf_map_kzalloc(&smap->map, smap->elem_size,
 					gfp_flags | __GFP_NOWARN);
 	}
=20
-	if (selem) {
-		if (value)
-			copy_map_value(&smap->map, SDATA(selem)->data, value);
-		/* No need to call check_and_init_map_value as memory is zero init */
-		return selem;
-	}
-
+	if (!selem)
+		goto err_out;
+
+	selem->sdata.smap_map_flags =3D smap->map.map_flags;
+	if (smap->map.map_flags & BPF_F_MMAPABLE)
+		selem->sdata.actual_data =3D mmapable_value;
+	if (value)
+		copy_map_value(&smap->map, sdata_mapval(SDATA(selem)), value);
+	/* No need to call check_and_init_map_value as memory is zero init */
+	return selem;
+err_out:
+	if (mmapable_value)
+		bpf_map_area_free(mmapable_value);
 	if (charge_mem)
-		mem_uncharge(smap, owner, smap->elem_size);
-
+		mem_uncharge(smap, owner, selem_mem);
 	return NULL;
 }
=20
@@ -184,6 +245,21 @@ static void bpf_local_storage_free(struct bpf_local_=
storage *local_storage,
 	}
 }
=20
+static void __bpf_selem_kfree(struct bpf_local_storage_elem *selem)
+{
+	if (selem->sdata.smap_map_flags & BPF_F_MMAPABLE)
+		bpf_map_area_free(selem->sdata.actual_data);
+	kfree(selem);
+}
+
+static void __bpf_selem_kfree_rcu(struct rcu_head *rcu)
+{
+	struct bpf_local_storage_elem *selem;
+
+	selem =3D container_of(rcu, struct bpf_local_storage_elem, rcu);
+	__bpf_selem_kfree(selem);
+}
+
 /* rcu tasks trace callback for bpf_ma =3D=3D false */
 static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 {
@@ -191,9 +267,9 @@ static void __bpf_selem_free_trace_rcu(struct rcu_hea=
d *rcu)
=20
 	selem =3D container_of(rcu, struct bpf_local_storage_elem, rcu);
 	if (rcu_trace_implies_rcu_gp())
-		kfree(selem);
+		__bpf_selem_kfree(selem);
 	else
-		kfree_rcu(selem, rcu);
+		call_rcu(rcu, __bpf_selem_kfree_rcu);
 }
=20
 /* Handle bpf_ma =3D=3D false */
@@ -201,7 +277,7 @@ static void __bpf_selem_free(struct bpf_local_storage=
_elem *selem,
 			     bool vanilla_rcu)
 {
 	if (vanilla_rcu)
-		kfree_rcu(selem, rcu);
+		call_rcu(&selem->rcu, __bpf_selem_kfree_rcu);
 	else
 		call_rcu_tasks_trace(&selem->rcu, __bpf_selem_free_trace_rcu);
 }
@@ -209,8 +285,12 @@ static void __bpf_selem_free(struct bpf_local_storag=
e_elem *selem,
 static void bpf_selem_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *smap;
=20
 	selem =3D container_of(rcu, struct bpf_local_storage_elem, rcu);
+	smap =3D selem->sdata.smap;
+	if (selem->sdata.smap_map_flags & BPF_F_MMAPABLE)
+		bpf_map_area_free(selem->sdata.actual_data);
 	bpf_mem_cache_raw_free(selem);
 }
=20
@@ -241,6 +321,8 @@ void bpf_selem_free(struct bpf_local_storage_elem *se=
lem,
 		 * immediately.
 		 */
 		migrate_disable();
+		if (smap->map.map_flags & BPF_F_MMAPABLE)
+			bpf_map_area_free(selem->sdata.actual_data);
 		bpf_mem_cache_free(&smap->selem_ma, selem);
 		migrate_enable();
 	}
@@ -266,7 +348,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bp=
f_local_storage *local_stor
 	 * from local_storage.
 	 */
 	if (uncharge_mem)
-		mem_uncharge(smap, owner, smap->elem_size);
+		mem_uncharge(smap, owner, selem_bytes_used(smap));
=20
 	free_local_storage =3D hlist_is_singular_node(&selem->snode,
 						    &local_storage->list);
@@ -583,14 +665,14 @@ bpf_local_storage_update(void *owner, struct bpf_lo=
cal_storage_map *smap,
 		err =3D bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
 		if (err) {
 			bpf_selem_free(selem, smap, true);
-			mem_uncharge(smap, owner, smap->elem_size);
+			mem_uncharge(smap, owner, selem_bytes_used(smap));
 			return ERR_PTR(err);
 		}
=20
 		return SDATA(selem);
 	}
=20
-	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
+	if (can_update_existing_selem(smap, map_flags) && !(map_flags & BPF_NOE=
XIST)) {
 		/* Hoping to find an old_sdata to do inline update
 		 * such that it can avoid taking the local_storage->lock
 		 * and changing the lists.
@@ -601,8 +683,13 @@ bpf_local_storage_update(void *owner, struct bpf_loc=
al_storage_map *smap,
 		if (err)
 			return ERR_PTR(err);
 		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
-			copy_map_value_locked(&smap->map, old_sdata->data,
-					      value, false);
+			if (map_flags & BPF_F_LOCK)
+				copy_map_value_locked(&smap->map,
+						      sdata_mapval(old_sdata),
+						      value, false);
+			else
+				copy_map_value(&smap->map, sdata_mapval(old_sdata),
+					       value);
 			return old_sdata;
 		}
 	}
@@ -633,8 +720,8 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
 		goto unlock;
=20
 	if (old_sdata && (map_flags & BPF_F_LOCK)) {
-		copy_map_value_locked(&smap->map, old_sdata->data, value,
-				      false);
+		copy_map_value_locked(&smap->map, sdata_mapval(old_sdata),
+				      value, false);
 		selem =3D SELEM(old_sdata);
 		goto unlock;
 	}
@@ -656,7 +743,7 @@ bpf_local_storage_update(void *owner, struct bpf_loca=
l_storage_map *smap,
 unlock:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 	if (alloc_selem) {
-		mem_uncharge(smap, owner, smap->elem_size);
+		mem_uncharge(smap, owner, selem_bytes_used(smap));
 		bpf_selem_free(alloc_selem, smap, true);
 	}
 	return err ? ERR_PTR(err) : SDATA(selem);
@@ -707,6 +794,10 @@ int bpf_local_storage_map_alloc_check(union bpf_attr=
 *attr)
 	if (attr->value_size > BPF_LOCAL_STORAGE_MAX_VALUE_SIZE)
 		return -E2BIG;
=20
+	if ((attr->map_flags & BPF_F_MMAPABLE) &&
+	    attr->map_type !=3D BPF_MAP_TYPE_TASK_STORAGE)
+		return -EINVAL;
+
 	return 0;
 }
=20
@@ -820,8 +911,12 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 		raw_spin_lock_init(&smap->buckets[i].lock);
 	}
=20
-	smap->elem_size =3D offsetof(struct bpf_local_storage_elem,
-				   sdata.data[attr->value_size]);
+	if (attr->map_flags & BPF_F_MMAPABLE)
+		smap->elem_size =3D offsetof(struct bpf_local_storage_elem,
+					   sdata.data[sizeof(void *)]);
+	else
+		smap->elem_size =3D offsetof(struct bpf_local_storage_elem,
+					   sdata.data[attr->value_size]);
=20
 	smap->bpf_ma =3D bpf_ma;
 	if (bpf_ma) {
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.=
c
index adf6dfe0ba68..ce75c8d8b2ce 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -90,6 +90,7 @@ void bpf_task_storage_free(struct task_struct *task)
 static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void =
*key)
 {
 	struct bpf_local_storage_data *sdata;
+	struct bpf_local_storage_map *smap;
 	struct task_struct *task;
 	unsigned int f_flags;
 	struct pid *pid;
@@ -114,7 +115,8 @@ static void *bpf_pid_task_storage_lookup_elem(struct =
bpf_map *map, void *key)
 	sdata =3D task_storage_lookup(task, map, true);
 	bpf_task_storage_unlock();
 	put_pid(pid);
-	return sdata ? sdata->data : NULL;
+	smap =3D (struct bpf_local_storage_map *)map;
+	return sdata ? sdata_mapval(sdata) : NULL;
 out:
 	put_pid(pid);
 	return ERR_PTR(err);
@@ -209,18 +211,19 @@ static void *__bpf_task_storage_get(struct bpf_map =
*map,
 				    u64 flags, gfp_t gfp_flags, bool nobusy)
 {
 	struct bpf_local_storage_data *sdata;
+	struct bpf_local_storage_map *smap;
=20
+	smap =3D (struct bpf_local_storage_map *)map;
 	sdata =3D task_storage_lookup(task, map, nobusy);
 	if (sdata)
-		return sdata->data;
+		return sdata_mapval(sdata);
=20
 	/* only allocate new storage, when the task is refcounted */
 	if (refcount_read(&task->usage) &&
 	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy) {
-		sdata =3D bpf_local_storage_update(
-			task, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, gfp_flags);
-		return IS_ERR(sdata) ? NULL : sdata->data;
+		sdata =3D bpf_local_storage_update(task, smap, value,
+						 BPF_NOEXIST, gfp_flags);
+		return IS_ERR(sdata) ? NULL : sdata_mapval(sdata);
 	}
=20
 	return NULL;
@@ -317,6 +320,25 @@ static void task_storage_map_free(struct bpf_map *ma=
p)
 	bpf_local_storage_map_free(map, &task_cache, &bpf_task_storage_busy);
 }
=20
+static int task_storage_map_mmap(struct bpf_map *map, struct vm_area_str=
uct *vma)
+{
+	void *data;
+
+	if (!(map->map_flags & BPF_F_MMAPABLE) || vma->vm_pgoff ||
+	    (vma->vm_end - vma->vm_start) < map->value_size)
+		return -EINVAL;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	bpf_task_storage_lock();
+	data =3D __bpf_task_storage_get(map, current, NULL, BPF_LOCAL_STORAGE_G=
ET_F_CREATE,
+				      0, true);
+	bpf_task_storage_unlock();
+	if (!data)
+		return -EINVAL;
+
+	return remap_vmalloc_range(vma, data, vma->vm_pgoff);
+}
+
 BTF_ID_LIST_GLOBAL_SINGLE(bpf_local_storage_map_btf_id, struct, bpf_loca=
l_storage_map)
 const struct bpf_map_ops task_storage_map_ops =3D {
 	.map_meta_equal =3D bpf_map_meta_equal,
@@ -331,6 +353,7 @@ const struct bpf_map_ops task_storage_map_ops =3D {
 	.map_mem_usage =3D bpf_local_storage_map_mem_usage,
 	.map_btf_id =3D &bpf_local_storage_map_btf_id[0],
 	.map_owner_storage_ptr =3D task_storage_ptr,
+	.map_mmap =3D task_storage_map_mmap,
 };
=20
 const struct bpf_func_proto bpf_task_storage_get_recur_proto =3D {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5e43ddd1b83f..d7c05a509870 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -404,7 +404,7 @@ static void bpf_map_release_memcg(struct bpf_map *map=
)
 		obj_cgroup_put(map->objcg);
 }
=20
-static struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map)
+struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map)
 {
 	if (map->objcg)
 		return get_mem_cgroup_from_objcg(map->objcg);
--=20
2.34.1


