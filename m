Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FDD6A8E99
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 02:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCCBVq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 20:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCCBVp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 20:21:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CD9521D7
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 17:21:43 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 322KUwX4013155
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 17:21:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=PJ1Ill0KOWt5nEwoei1oXzD7tLiQRPmzs9DNVJZJjLE=;
 b=TanpPUqkdjQKSiZJQNOEUAMgczp/bSAdnLKiO/68IwGRkhCAuBWs4xB+bqJRmeEIw3vn
 HdY58buFOv3M1ZYVNchspRovV1FH14rJ/c9wQzQbKi+iU3L3w/WsHVkYcxyLJXsqGDt0
 0NgjmlqyItVAdld7EFWLERT7wXrfTdTJLRwbdqUyhmOpN5rCPTZguQw5HUANDNIK4iyM
 GVQh1a7hbtwI4rydWNN4yj2pWCkIDHo+V39HVCjppSEEWc6K73CeeZLbyesL74s1682J
 uKeyosy33nwScyqR/PjXo/U7PxIH/YFsL3RyqMZR/Hvm1j8mHy60tiF3ovHu32pljfbI gw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p2uad57y9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 17:21:42 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 17:21:41 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 17:21:41 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id A264E6644D81; Thu,  2 Mar 2023 17:21:30 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v3 1/8] bpf: Maintain the refcount of struct_ops maps directly.
Date:   Thu, 2 Mar 2023 17:21:15 -0800
Message-ID: <20230303012122.852654-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230303012122.852654-1-kuifeng@meta.com>
References: <20230303012122.852654-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iAZgEZMfzjkny2NCFA77MHFmDuhZpXNQ
X-Proofpoint-GUID: iAZgEZMfzjkny2NCFA77MHFmDuhZpXNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The refcount of the kvalue for struct_ops was quite intricate to keep
track of. By no longer utilizing it and replacing it with the refcount
from the struct_ops map, this process became more transparent and
uncomplicated.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf.h         |  3 ++
 kernel/bpf/bpf_struct_ops.c | 84 ++++++++++++++++++++++---------------
 kernel/bpf/syscall.c        | 22 ++++++----
 3 files changed, 68 insertions(+), 41 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8b5d0b4c4ada..cb837f42b99d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -78,6 +78,7 @@ struct bpf_map_ops {
 	struct bpf_map *(*map_alloc)(union bpf_attr *attr);
 	void (*map_release)(struct bpf_map *map, struct file *map_file);
 	void (*map_free)(struct bpf_map *map);
+	void (*map_free_rcu)(struct bpf_map *map);
 	int (*map_get_next_key)(struct bpf_map *map, void *key, void *next_key)=
;
 	void (*map_release_uref)(struct bpf_map *map);
 	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
@@ -1869,8 +1870,10 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd);
 struct bpf_map *__bpf_map_get(struct fd f);
 void bpf_map_inc(struct bpf_map *map);
 void bpf_map_inc_with_uref(struct bpf_map *map);
+struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
 struct bpf_map * __must_check bpf_map_inc_not_zero(struct bpf_map *map);
 void bpf_map_put_with_uref(struct bpf_map *map);
+void bpf_map_free_deferred(struct work_struct *work);
 void bpf_map_put(struct bpf_map *map);
 void *bpf_map_area_alloc(u64 size, int numa_node);
 void *bpf_map_area_mmapable_alloc(u64 size, int numa_node);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index ece9870cab68..bba03b6b010b 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -58,6 +58,8 @@ struct bpf_struct_ops_map {
 	struct bpf_struct_ops_value kvalue;
 };
=20
+static DEFINE_MUTEX(update_mutex);
+
 #define VALUE_PREFIX "bpf_struct_ops_"
 #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
=20
@@ -249,6 +251,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map=
 *map, void *key,
 	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
 	struct bpf_struct_ops_value *uvalue, *kvalue;
 	enum bpf_struct_ops_state state;
+	s64 refcnt;
=20
 	if (unlikely(*(u32 *)key !=3D 0))
 		return -ENOENT;
@@ -261,13 +264,13 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_m=
ap *map, void *key,
 		return 0;
 	}
=20
-	/* No lock is needed.  state and refcnt do not need
-	 * to be updated together under atomic context.
-	 */
 	uvalue =3D value;
 	memcpy(uvalue, st_map->uvalue, map->value_size);
 	uvalue->state =3D state;
-	refcount_set(&uvalue->refcnt, refcount_read(&kvalue->refcnt));
+
+	refcnt =3D atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
+	refcount_set(&uvalue->refcnt,
+		     refcnt > 0 ? refcnt : 0);
=20
 	return 0;
 }
@@ -491,7 +494,6 @@ static int bpf_struct_ops_map_update_elem(struct bpf_=
map *map, void *key,
 		*(unsigned long *)(udata + moff) =3D prog->aux->id;
 	}
=20
-	refcount_set(&kvalue->refcnt, 1);
 	bpf_map_inc(map);
=20
 	set_memory_rox((long)st_map->image, 1);
@@ -536,8 +538,7 @@ static int bpf_struct_ops_map_delete_elem(struct bpf_=
map *map, void *key)
 	switch (prev_state) {
 	case BPF_STRUCT_OPS_STATE_INUSE:
 		st_map->st_ops->unreg(&st_map->kvalue.data);
-		if (refcount_dec_and_test(&st_map->kvalue.refcnt))
-			bpf_map_put(map);
+		bpf_map_put(map);
 		return 0;
 	case BPF_STRUCT_OPS_STATE_TOBEFREE:
 		return -EINPROGRESS;
@@ -582,6 +583,38 @@ static void bpf_struct_ops_map_free(struct bpf_map *=
map)
 	bpf_map_area_free(st_map);
 }
=20
+static void bpf_struct_ops_map_free_wq(struct rcu_head *head)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	st_map =3D container_of(head, struct bpf_struct_ops_map, rcu);
+
+	/* bpf_map_free_deferred should not be called in a RCU callback. */
+	INIT_WORK(&st_map->map.work, bpf_map_free_deferred);
+	queue_work(system_unbound_wq, &st_map->map.work);
+}
+
+static void bpf_struct_ops_map_free_rcu(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
+
+	/* Wait for a grace period of RCU. Then, post the map_free
+	 * work to the system_unbound_wq workqueue to free resources.
+	 *
+	 * The struct_ops's function may switch to another struct_ops.
+	 *
+	 * For example, bpf_tcp_cc_x->init() may switch to
+	 * another tcp_cc_y by calling
+	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
+	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
+	 * and its refcount may reach 0 which then free its
+	 * trampoline image while tcp_cc_x is still running.
+	 *
+	 * Thus, a rcu grace period is needed here.
+	 */
+	call_rcu(&st_map->rcu, bpf_struct_ops_map_free_wq);
+}
+
 static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->key_size !=3D sizeof(unsigned int) || attr->max_entries !=3D =
1 ||
@@ -646,6 +679,7 @@ const struct bpf_map_ops bpf_struct_ops_map_ops =3D {
 	.map_alloc_check =3D bpf_struct_ops_map_alloc_check,
 	.map_alloc =3D bpf_struct_ops_map_alloc,
 	.map_free =3D bpf_struct_ops_map_free,
+	.map_free_rcu =3D bpf_struct_ops_map_free_rcu,
 	.map_get_next_key =3D bpf_struct_ops_map_get_next_key,
 	.map_lookup_elem =3D bpf_struct_ops_map_lookup_elem,
 	.map_delete_elem =3D bpf_struct_ops_map_delete_elem,
@@ -660,41 +694,23 @@ const struct bpf_map_ops bpf_struct_ops_map_ops =3D=
 {
 bool bpf_struct_ops_get(const void *kdata)
 {
 	struct bpf_struct_ops_value *kvalue;
+	struct bpf_struct_ops_map *st_map;
+	struct bpf_map *map;
=20
 	kvalue =3D container_of(kdata, struct bpf_struct_ops_value, data);
+	st_map =3D container_of(kvalue, struct bpf_struct_ops_map, kvalue);
=20
-	return refcount_inc_not_zero(&kvalue->refcnt);
-}
-
-static void bpf_struct_ops_put_rcu(struct rcu_head *head)
-{
-	struct bpf_struct_ops_map *st_map;
-
-	st_map =3D container_of(head, struct bpf_struct_ops_map, rcu);
-	bpf_map_put(&st_map->map);
+	map =3D __bpf_map_inc_not_zero(&st_map->map, false);
+	return !IS_ERR(map);
 }
=20
 void bpf_struct_ops_put(const void *kdata)
 {
 	struct bpf_struct_ops_value *kvalue;
+	struct bpf_struct_ops_map *st_map;
=20
 	kvalue =3D container_of(kdata, struct bpf_struct_ops_value, data);
-	if (refcount_dec_and_test(&kvalue->refcnt)) {
-		struct bpf_struct_ops_map *st_map;
-
-		st_map =3D container_of(kvalue, struct bpf_struct_ops_map,
-				      kvalue);
-		/* The struct_ops's function may switch to another struct_ops.
-		 *
-		 * For example, bpf_tcp_cc_x->init() may switch to
-		 * another tcp_cc_y by calling
-		 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
-		 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
-		 * and its map->refcnt may reach 0 which then free its
-		 * trampoline image while tcp_cc_x is still running.
-		 *
-		 * Thus, a rcu grace period is needed here.
-		 */
-		call_rcu(&st_map->rcu, bpf_struct_ops_put_rcu);
-	}
+	st_map =3D container_of(kvalue, struct bpf_struct_ops_map, kvalue);
+
+	bpf_map_put(&st_map->map);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cda8d00f3762..358a0e40555e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -684,7 +684,7 @@ void bpf_obj_free_fields(const struct btf_record *rec=
, void *obj)
 }
=20
 /* called from workqueue */
-static void bpf_map_free_deferred(struct work_struct *work)
+void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map =3D container_of(work, struct bpf_map, work);
 	struct btf_field_offs *foffs =3D map->field_offs;
@@ -715,6 +715,15 @@ static void bpf_map_put_uref(struct bpf_map *map)
 	}
 }
=20
+static void bpf_map_put_wq(struct bpf_map *map)
+{
+	INIT_WORK(&map->work, bpf_map_free_deferred);
+	/* Avoid spawning kworkers, since they all might contend
+	 * for the same mutex like slab_mutex.
+	 */
+	queue_work(system_unbound_wq, &map->work);
+}
+
 /* decrement map refcnt and schedule it for freeing via workqueue
  * (underlying map implementation ops->map_free() might sleep)
  */
@@ -724,11 +733,10 @@ void bpf_map_put(struct bpf_map *map)
 		/* bpf_map_free_id() must be called first */
 		bpf_map_free_id(map);
 		btf_put(map->btf);
-		INIT_WORK(&map->work, bpf_map_free_deferred);
-		/* Avoid spawning kworkers, since they all might contend
-		 * for the same mutex like slab_mutex.
-		 */
-		queue_work(system_unbound_wq, &map->work);
+		if (map->ops->map_free_rcu)
+			map->ops->map_free_rcu(map);
+		else
+			bpf_map_put_wq(map);
 	}
 }
 EXPORT_SYMBOL_GPL(bpf_map_put);
@@ -1276,7 +1284,7 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd)
 }
=20
 /* map_idr_lock should have been held */
-static struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool =
uref)
+struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref)
 {
 	int refold;
=20
--=20
2.30.2

