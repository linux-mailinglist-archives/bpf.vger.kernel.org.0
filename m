Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E925B6A0077
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 02:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjBWBMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 20:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjBWBMy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 20:12:54 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0DD44AA
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:12:51 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 31N0L8Rg028753
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:12:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Zbd/te8usnZP0uNPZmt1i2+H89k3iv3PDQU7aFpxgkc=;
 b=e+BwYBIAolrdnOWe3cQhLd3NHPBXycC1B57JE4uTt1xoEzTnzZNcxBrVddJou/Im7qEC
 NjTOst93jLZCdnjc9DMFUW7ENaXFS9AVJZsTSRS1qLs+wULHnpRkvwx69anCE2xOniha
 kUHEr+cv1a6GDhXK+O9JBo3ZXnCq2VEY/t/IVyzH7iC/gCJCVwnndMTIv9eRiREjU9De
 Nv1+lZ3gmx/7uPRlHAtAtl1UrfzkZr2lPT05zXDnwYPPHm/d7tTPvzFCbInsuIpqIFsc
 0yK/jaP1ITk8qTOXSxw5RuMoN8suq9t0QTBCM3VPj1XNMpD5T5OZLN6d5blbp7iPLFmb jQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3nwdy9xs6n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 17:12:50 -0800
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Feb 2023 17:12:48 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 7A3935BD8CBD; Wed, 22 Feb 2023 17:12:40 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v2 1/6] bpf: Create links for BPF struct_ops maps.
Date:   Wed, 22 Feb 2023 17:12:33 -0800
Message-ID: <20230223011238.12313-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230223011238.12313-1-kuifeng@meta.com>
References: <20230223011238.12313-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dGx3afYLazaIbLlxrdG9TAyox3sYT_hI
X-Proofpoint-ORIG-GUID: dGx3afYLazaIbLlxrdG9TAyox3sYT_hI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_12,2023-02-22_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF struct_ops maps are employed directly to register TCP Congestion
Control algorithms. Unlike other BPF programs that terminate when
their links gone, the struct_ops program reduces its refcount solely
upon death of its FD. The link of a BPF struct_ops map provides a
uniform experience akin to other types of BPF programs.

bpf_links are responsible for registering their associated
struct_ops. You can only use a struct_ops that has the BPF_F_LINK flag
set to create a bpf_link, while a structs without this flag behaves in
the same manner as before and is registered upon updating its value.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf.h            |  11 +
 include/uapi/linux/bpf.h       |  12 +-
 kernel/bpf/bpf_struct_ops.c    | 376 ++++++++++++++++++++++++++++++---
 kernel/bpf/syscall.c           |  26 ++-
 tools/include/uapi/linux/bpf.h |  12 +-
 5 files changed, 402 insertions(+), 35 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8b5d0b4c4ada..9d6fd874e5ee 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1395,6 +1395,11 @@ struct bpf_link {
 	struct work_struct work;
 };
=20
+struct bpf_struct_ops_link {
+	struct bpf_link link;
+	struct bpf_map __rcu *map;
+};
+
 struct bpf_link_ops {
 	void (*release)(struct bpf_link *link);
 	void (*dealloc)(struct bpf_link *link);
@@ -1961,6 +1966,7 @@ int bpf_link_new_fd(struct bpf_link *link);
 struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
+int bpf_struct_ops_link_create(union bpf_attr *attr);
=20
 int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
 int bpf_obj_get_user(const char __user *pathname, int flags);
@@ -2305,6 +2311,11 @@ static inline void bpf_link_put(struct bpf_link *l=
ink)
 {
 }
=20
+static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int bpf_obj_get_user(const char __user *pathname, int flag=
s)
 {
 	return -EOPNOTSUPP;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 17afd2b35ee5..cd0ff39981e8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1033,6 +1033,7 @@ enum bpf_attach_type {
 	BPF_PERF_EVENT,
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
+	BPF_STRUCT_OPS,
 	__MAX_BPF_ATTACH_TYPE
 };
=20
@@ -1266,6 +1267,9 @@ enum {
=20
 /* Create a map that is suitable to be an inner map with dynamic max ent=
ries */
 	BPF_F_INNER_MAP		=3D (1U << 12),
+
+/* Create a map that will be registered/unregesitered by the backed bpf_=
link */
+	BPF_F_LINK		=3D (1U << 13),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
@@ -1507,7 +1511,10 @@ union bpf_attr {
 	} task_fd_query;
=20
 	struct { /* struct used by BPF_LINK_CREATE command */
-		__u32		prog_fd;	/* eBPF program to attach */
+		union {
+			__u32		prog_fd;	/* eBPF program to attach */
+			__u32		map_fd;		/* eBPF struct_ops to attach */
+		};
 		union {
 			__u32		target_fd;	/* object to attach to */
 			__u32		target_ifindex; /* target ifindex */
@@ -6354,6 +6361,9 @@ struct bpf_link_info {
 		struct {
 			__u32 ifindex;
 		} xdp;
+		struct {
+			__u32 map_id;
+		} struct_ops;
 	};
 } __attribute__((aligned(8)));
=20
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index ece9870cab68..cfc69033c1b8 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -14,8 +14,10 @@
=20
 enum bpf_struct_ops_state {
 	BPF_STRUCT_OPS_STATE_INIT,
+	BPF_STRUCT_OPS_STATE_UNREG,
 	BPF_STRUCT_OPS_STATE_INUSE,
 	BPF_STRUCT_OPS_STATE_TOBEFREE,
+	BPF_STRUCT_OPS_STATE_TOBEUNREG,
 };
=20
 #define BPF_STRUCT_OPS_COMMON_VALUE			\
@@ -58,6 +60,8 @@ struct bpf_struct_ops_map {
 	struct bpf_struct_ops_value kvalue;
 };
=20
+static DEFINE_MUTEX(update_mutex);
+
 #define VALUE_PREFIX "bpf_struct_ops_"
 #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
=20
@@ -253,22 +257,23 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_m=
ap *map, void *key,
 	if (unlikely(*(u32 *)key !=3D 0))
 		return -ENOENT;
=20
+	mutex_lock(&st_map->lock);
+
 	kvalue =3D &st_map->kvalue;
-	/* Pair with smp_store_release() during map_update */
 	state =3D smp_load_acquire(&kvalue->state);
 	if (state =3D=3D BPF_STRUCT_OPS_STATE_INIT) {
 		memset(value, 0, map->value_size);
+		mutex_unlock(&st_map->lock);
 		return 0;
 	}
=20
-	/* No lock is needed.  state and refcnt do not need
-	 * to be updated together under atomic context.
-	 */
 	uvalue =3D value;
 	memcpy(uvalue, st_map->uvalue, map->value_size);
 	uvalue->state =3D state;
 	refcount_set(&uvalue->refcnt, refcount_read(&kvalue->refcnt));
=20
+	mutex_unlock(&st_map->lock);
+
 	return 0;
 }
=20
@@ -349,6 +354,150 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tr=
amp_links *tlinks,
 					   model, flags, tlinks, NULL);
 }
=20
+/*
+ * Maintain the state of kvalue.
+ *
+ * For a struct_ops that has no link, its state diagram is
+ *
+ *   INIT ----> INUSE --> TOBEFREE
+ *     ^                     |
+ *     |     (refcnt =3D=3D 0)   |
+ *     +---------------------+
+ *
+ * For a struct_ops that has a link (BPF_F_LINK), its state diagram is
+ *
+ *                   (refcnt =3D=3D 0)
+ *              +-----------------------+
+ *              |                       |
+ *              V                       |
+ *   INIT ---> UNREG -+--> INUSE --> TOBEUNREG
+ *     ^              |
+ *     |              V
+ *     +---------- TOBEFREE
+ *     (refcnt =3D=3D 0)
+ *
+ * After transiting to the INUSE state of a struct_ops, the refcnt of
+ * its kvalue is set to 1.
+ *
+ * After transiting from the INUSE state of a struct_ops, the caller
+ * should decrease the refcnt of its kvalue by 1 by calling
+ * bpf_struct_ops_put().
+ *
+ * TOBEFREE and TOBEUNREG are in a grace period, waiting for other
+ * tasks holding references of the struct_ops.  When the refcnt drops
+ * from 1 to 0, TOBEFREE and TOBEUNREG are transited to INIT and UNREG
+ * respectively.
+ *
+ * It is safe to assume that there will be no registration race
+ * conditions after a task transits the same struct_ops to INUSE,
+ * TOBEFREE and TOBEUNREG states.  The task is able to register or
+ * unregister the struct_ops without the need for any additional
+ * synchronization.
+ */
+static int bpf_struct_ops_transit_state(struct bpf_struct_ops_map *st_ma=
p,
+					enum bpf_struct_ops_state src,
+					enum bpf_struct_ops_state dst)
+{
+	int old_state;
+
+	switch (src) {
+	case BPF_STRUCT_OPS_STATE_INIT:
+		if (dst !=3D BPF_STRUCT_OPS_STATE_INUSE &&
+		    dst !=3D BPF_STRUCT_OPS_STATE_UNREG)
+			return -EINVAL;
+
+		old_state =3D cmpxchg(&st_map->kvalue.state, src, dst);
+		if (old_state !=3D src)
+			break;
+
+		if (dst =3D=3D BPF_STRUCT_OPS_STATE_INUSE)
+			refcount_set(&st_map->kvalue.refcnt, 1);
+		break;
+
+	case BPF_STRUCT_OPS_STATE_UNREG:
+		if (dst !=3D BPF_STRUCT_OPS_STATE_INUSE &&
+		    dst !=3D BPF_STRUCT_OPS_STATE_TOBEFREE)
+			return -EINVAL;
+
+		old_state =3D cmpxchg(&st_map->kvalue.state, src, dst);
+		if (old_state !=3D src)
+			break;
+
+		if (dst =3D=3D BPF_STRUCT_OPS_STATE_INUSE)
+			refcount_set(&st_map->kvalue.refcnt, 1);
+		else if (dst =3D=3D BPF_STRUCT_OPS_STATE_TOBEFREE)
+			cmpxchg(&st_map->kvalue.state, dst, BPF_STRUCT_OPS_STATE_INIT);
+		break;
+
+	case BPF_STRUCT_OPS_STATE_INUSE:
+		if (dst !=3D BPF_STRUCT_OPS_STATE_TOBEFREE &&
+		    dst !=3D BPF_STRUCT_OPS_STATE_TOBEUNREG)
+			return -EINVAL;
+
+		old_state =3D cmpxchg(&st_map->kvalue.state, src, dst);
+		break;
+
+	case BPF_STRUCT_OPS_STATE_TOBEFREE:
+		/*
+		 * This transition should only be performed when the
+		 * refcnt drops to 0 from 1.
+		 */
+		if (dst !=3D BPF_STRUCT_OPS_STATE_INIT)
+			return -EINVAL;
+		old_state =3D cmpxchg(&st_map->kvalue.state, src, dst);
+		if (old_state !=3D src)
+			break;
+		break;
+
+	case BPF_STRUCT_OPS_STATE_TOBEUNREG:
+		/*
+		 * This transition should only be performed when the
+		 * refcnt drops to 0 from 1.
+		 */
+		if (dst !=3D BPF_STRUCT_OPS_STATE_UNREG)
+			return -EINVAL;
+		old_state =3D cmpxchg(&st_map->kvalue.state, src, dst);
+		if (old_state !=3D src)
+			return old_state;
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return old_state;
+}
+
+static int bpf_struct_ops_transit_state_check(struct bpf_struct_ops_map =
*st_map,
+					      enum bpf_struct_ops_state src,
+					      enum bpf_struct_ops_state dst)
+{
+	int err;
+
+	err =3D bpf_struct_ops_transit_state(st_map, src, dst);
+	if (err < 0)
+		return err;
+	if (err !=3D src)
+		return -EINVAL;
+	return 0;
+}
+
+/*
+ * Restore the state of a struct_ops to UNREG from INUSE.
+ *
+ * It handles the case which a struct_ops transited to INUSE from
+ * UNREG successfully; somehow, need to rollback the struct_ops state.
+ */
+static void bpf_struct_ops_restore_unreg(struct bpf_struct_ops_map *st_m=
ap)
+{
+	struct bpf_struct_ops_value *kvalue;
+
+	kvalue =3D &st_map->kvalue;
+	refcount_set(&kvalue->refcnt, 0);
+	/* Make sure the above change is seen before the state change. */
+	smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_UNREG);
+}
+
 static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key=
,
 					  void *value, u64 flags)
 {
@@ -390,7 +539,11 @@ static int bpf_struct_ops_map_update_elem(struct bpf=
_map *map, void *key,
=20
 	mutex_lock(&st_map->lock);
=20
-	if (kvalue->state !=3D BPF_STRUCT_OPS_STATE_INIT) {
+	/* Make sure that all following changes are seen after the
+	 * state value here.
+	 */
+	if (smp_load_acquire(&kvalue->state) >=3D BPF_STRUCT_OPS_STATE_INUSE ||
+	    refcount_read(&kvalue->refcnt)) {
 		err =3D -EBUSY;
 		goto unlock;
 	}
@@ -491,17 +644,21 @@ static int bpf_struct_ops_map_update_elem(struct bp=
f_map *map, void *key,
 		*(unsigned long *)(udata + moff) =3D prog->aux->id;
 	}
=20
-	refcount_set(&kvalue->refcnt, 1);
+	if (st_map->map.map_flags & BPF_F_LINK) {
+		/* Let bpf_link handle registration & unregistration. */
+		err =3D bpf_struct_ops_transit_state_check(st_map, BPF_STRUCT_OPS_STAT=
E_INIT,
+							 BPF_STRUCT_OPS_STATE_UNREG);
+		goto unlock;
+	}
+
 	bpf_map_inc(map);
=20
 	set_memory_rox((long)st_map->image, 1);
 	err =3D st_ops->reg(kdata);
 	if (likely(!err)) {
-		/* Pair with smp_load_acquire() during lookup_elem().
-		 * It ensures the above udata updates (e.g. prog->aux->id)
-		 * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
-		 */
-		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
+		/* Infallible */
+		bpf_struct_ops_transit_state(st_map, BPF_STRUCT_OPS_STATE_INIT,
+					     BPF_STRUCT_OPS_STATE_INUSE);
 		goto unlock;
 	}
=20
@@ -526,28 +683,49 @@ static int bpf_struct_ops_map_update_elem(struct bp=
f_map *map, void *key,
=20
 static int bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key=
)
 {
-	enum bpf_struct_ops_state prev_state;
 	struct bpf_struct_ops_map *st_map;
+	int old_state;
+	int err =3D 0;
=20
 	st_map =3D (struct bpf_struct_ops_map *)map;
-	prev_state =3D cmpxchg(&st_map->kvalue.state,
-			     BPF_STRUCT_OPS_STATE_INUSE,
-			     BPF_STRUCT_OPS_STATE_TOBEFREE);
-	switch (prev_state) {
+
+	old_state =3D bpf_struct_ops_transit_state(st_map,
+						 (st_map->map.map_flags & BPF_F_LINK ?
+						  BPF_STRUCT_OPS_STATE_UNREG :
+						  BPF_STRUCT_OPS_STATE_INUSE),
+						 BPF_STRUCT_OPS_STATE_TOBEFREE);
+
+	if (old_state < 0)
+		return old_state;
+
+	switch (old_state) {
+	case BPF_STRUCT_OPS_STATE_UNREG:
+		break;
 	case BPF_STRUCT_OPS_STATE_INUSE:
-		st_map->st_ops->unreg(&st_map->kvalue.data);
-		if (refcount_dec_and_test(&st_map->kvalue.refcnt))
-			bpf_map_put(map);
-		return 0;
+		if (st_map->map.map_flags & BPF_F_LINK)
+			err =3D -EBUSY;
+		else {
+			st_map->st_ops->unreg(&st_map->kvalue.data);
+			bpf_struct_ops_put(&st_map->kvalue.data);
+		}
+		break;
 	case BPF_STRUCT_OPS_STATE_TOBEFREE:
-		return -EINPROGRESS;
+		err =3D -EINPROGRESS;
+		break;
+	case BPF_STRUCT_OPS_STATE_TOBEUNREG:
+		err =3D -EBUSY;
+		break;
 	case BPF_STRUCT_OPS_STATE_INIT:
-		return -ENOENT;
+		err =3D -ENOENT;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		/* Should never happen.  Treat it as not found. */
-		return -ENOENT;
+		err =3D -ENOENT;
+		break;
 	}
+
+	return err;
 }
=20
 static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *=
key,
@@ -585,7 +763,7 @@ static void bpf_struct_ops_map_free(struct bpf_map *m=
ap)
 static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->key_size !=3D sizeof(unsigned int) || attr->max_entries !=3D =
1 ||
-	    attr->map_flags || !attr->btf_vmlinux_value_type_id)
+	    (attr->map_flags & ~BPF_F_LINK) || !attr->btf_vmlinux_value_type_id=
)
 		return -EINVAL;
 	return 0;
 }
@@ -671,6 +849,15 @@ static void bpf_struct_ops_put_rcu(struct rcu_head *=
head)
 	struct bpf_struct_ops_map *st_map;
=20
 	st_map =3D container_of(head, struct bpf_struct_ops_map, rcu);
+
+	/* The struct_ops can be reused after a rcu grace period. */
+	if (st_map->kvalue.state =3D=3D BPF_STRUCT_OPS_STATE_TOBEFREE)
+		bpf_struct_ops_transit_state(st_map, BPF_STRUCT_OPS_STATE_TOBEFREE,
+					     BPF_STRUCT_OPS_STATE_INIT);
+	else if (st_map->kvalue.state =3D=3D BPF_STRUCT_OPS_STATE_TOBEUNREG)
+		bpf_struct_ops_transit_state(st_map, BPF_STRUCT_OPS_STATE_TOBEUNREG,
+					     BPF_STRUCT_OPS_STATE_UNREG);
+
 	bpf_map_put(&st_map->map);
 }
=20
@@ -684,6 +871,7 @@ void bpf_struct_ops_put(const void *kdata)
=20
 		st_map =3D container_of(kvalue, struct bpf_struct_ops_map,
 				      kvalue);
+
 		/* The struct_ops's function may switch to another struct_ops.
 		 *
 		 * For example, bpf_tcp_cc_x->init() may switch to
@@ -698,3 +886,143 @@ void bpf_struct_ops_put(const void *kdata)
 		call_rcu(&st_map->rcu, bpf_struct_ops_put_rcu);
 	}
 }
+
+static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_struct_ops_link *st_link;
+	struct bpf_struct_ops_map *st_map;
+
+	st_link =3D container_of(link, struct bpf_struct_ops_link, link);
+	if (st_link->map) {
+		st_map =3D (struct bpf_struct_ops_map *)st_link->map;
+		bpf_struct_ops_transit_state(st_map, BPF_STRUCT_OPS_STATE_INUSE,
+					     (st_map->map.map_flags & BPF_F_LINK ?
+					      BPF_STRUCT_OPS_STATE_TOBEUNREG :
+					      BPF_STRUCT_OPS_STATE_TOBEFREE));
+		st_map->st_ops->unreg(&st_map->kvalue.data);
+		bpf_struct_ops_put(&st_map->kvalue.data);
+	}
+	kfree(st_link);
+}
+
+static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
+{
+	struct bpf_struct_ops_link *st_link;
+	struct bpf_struct_ops_map *st_map;
+
+	mutex_lock(&update_mutex);
+	st_link =3D container_of(link, struct bpf_struct_ops_link, link);
+	st_map =3D container_of(st_link->map, struct bpf_struct_ops_map, map);
+	if (st_map) {
+		/*
+		 * All chaning on st_link->map are protected by
+		 * update_mutex.  This ensures that the struct_ops is
+		 * INUSE, and the state transition always success.
+		 */
+		rcu_assign_pointer(st_link->map, NULL);
+		bpf_struct_ops_transit_state(st_map, BPF_STRUCT_OPS_STATE_INUSE,
+					     (st_map->map.map_flags & BPF_F_LINK ?
+					      BPF_STRUCT_OPS_STATE_TOBEUNREG :
+					      BPF_STRUCT_OPS_STATE_TOBEFREE));
+		st_map->st_ops->unreg(&st_map->kvalue.data);
+		bpf_struct_ops_put(&st_map->kvalue.data);
+	}
+	mutex_unlock(&update_mutex);
+
+	return 0;
+}
+
+static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *l=
ink,
+					    struct seq_file *seq)
+{
+	struct bpf_struct_ops_link *st_link;
+	struct bpf_map *map;
+
+	st_link =3D container_of(link, struct bpf_struct_ops_link, link);
+	rcu_read_lock_trace();
+	map =3D rcu_dereference(st_link->map);
+	if (map)
+		seq_printf(seq, "map_id:\t%d\n", map->id);
+	rcu_read_unlock_trace();
+}
+
+static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link =
*link,
+					       struct bpf_link_info *info)
+{
+	struct bpf_struct_ops_link *st_link;
+	struct bpf_map *map;
+
+	st_link =3D container_of(link, struct bpf_struct_ops_link, link);
+	rcu_read_lock_trace();
+	map =3D rcu_dereference(st_link->map);
+	if (map)
+		info->struct_ops.map_id =3D map->id;
+	rcu_read_unlock_trace();
+	return 0;
+}
+
+static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
+	.dealloc =3D bpf_struct_ops_map_link_dealloc,
+	.detach =3D bpf_struct_ops_map_link_detach,
+	.show_fdinfo =3D bpf_struct_ops_map_link_show_fdinfo,
+	.fill_link_info =3D bpf_struct_ops_map_link_fill_link_info,
+};
+
+int bpf_struct_ops_link_create(union bpf_attr *attr)
+{
+	struct bpf_struct_ops_link *link =3D NULL;
+	struct bpf_link_primer link_primer;
+	struct bpf_struct_ops_map *st_map;
+	struct bpf_map *map;
+	int err;
+
+	map =3D bpf_map_get(attr->link_create.map_fd);
+	if (!map)
+		return -EINVAL;
+
+	if (map->map_type !=3D BPF_MAP_TYPE_STRUCT_OPS || !(map->map_flags & BP=
F_F_LINK)) {
+		err =3D -EINVAL;
+		goto err_out;
+	}
+
+	link =3D kzalloc(sizeof(*link), GFP_USER);
+	if (!link) {
+		err =3D -ENOMEM;
+		goto err_out;
+	}
+	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_ma=
p_lops, NULL);
+	link->map =3D map;
+
+	st_map =3D (struct bpf_struct_ops_map *)map;
+
+	err =3D bpf_struct_ops_transit_state_check(st_map, BPF_STRUCT_OPS_STATE=
_UNREG,
+						 BPF_STRUCT_OPS_STATE_INUSE);
+	if (err)
+		goto err_out;
+
+	err =3D bpf_link_prime(&link->link, &link_primer);
+	if (err) {
+		bpf_struct_ops_restore_unreg(st_map);
+		goto err_out;
+	}
+
+	set_memory_rox((long)st_map->image, 1);
+	err =3D st_map->st_ops->reg(st_map->kvalue.data);
+	if (err) {
+		bpf_struct_ops_restore_unreg(st_map);
+		bpf_link_cleanup(&link_primer);
+
+		set_memory_nx((long)st_map->image, 1);
+		set_memory_rw((long)st_map->image, 1);
+		goto err_out;
+	}
+
+
+	return bpf_link_settle(&link_primer);
+
+err_out:
+	bpf_map_put(map);
+	kfree(link);
+	return err;
+}
+
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cda8d00f3762..2670de8dd0d4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2735,10 +2735,11 @@ void bpf_link_inc(struct bpf_link *link)
 static void bpf_link_free(struct bpf_link *link)
 {
 	bpf_link_free_id(link->id);
+	/* detach BPF program, clean up used resources */
 	if (link->prog) {
-		/* detach BPF program, clean up used resources */
 		link->ops->release(link);
 		bpf_prog_put(link->prog);
+		/* The struct_ops links clean up map by them-selves. */
 	}
 	/* free bpf_link and its containing memory */
 	link->ops->dealloc(link);
@@ -2794,16 +2795,19 @@ static void bpf_link_show_fdinfo(struct seq_file =
*m, struct file *filp)
 	const struct bpf_prog *prog =3D link->prog;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] =3D { };
=20
-	bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
 	seq_printf(m,
 		   "link_type:\t%s\n"
-		   "link_id:\t%u\n"
-		   "prog_tag:\t%s\n"
-		   "prog_id:\t%u\n",
+		   "link_id:\t%u\n",
 		   bpf_link_type_strs[link->type],
-		   link->id,
-		   prog_tag,
-		   prog->aux->id);
+		   link->id);
+	if (prog) {
+		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
+		seq_printf(m,
+			   "prog_tag:\t%s\n"
+			   "prog_id:\t%u\n",
+			   prog_tag,
+			   prog->aux->id);
+	}
 	if (link->ops->show_fdinfo)
 		link->ops->show_fdinfo(link, m);
 }
@@ -4278,7 +4282,8 @@ static int bpf_link_get_info_by_fd(struct file *fil=
e,
=20
 	info.type =3D link->type;
 	info.id =3D link->id;
-	info.prog_id =3D link->prog->aux->id;
+	if (link->prog)
+		info.prog_id =3D link->prog->aux->id;
=20
 	if (link->ops->fill_link_info) {
 		err =3D link->ops->fill_link_info(link, &info);
@@ -4541,6 +4546,9 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
 	if (CHECK_ATTR(BPF_LINK_CREATE))
 		return -EINVAL;
=20
+	if (attr->link_create.attach_type =3D=3D BPF_STRUCT_OPS)
+		return bpf_struct_ops_link_create(attr);
+
 	prog =3D bpf_prog_get(attr->link_create.prog_fd);
 	if (IS_ERR(prog))
 		return PTR_ERR(prog);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 17afd2b35ee5..cd0ff39981e8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1033,6 +1033,7 @@ enum bpf_attach_type {
 	BPF_PERF_EVENT,
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
+	BPF_STRUCT_OPS,
 	__MAX_BPF_ATTACH_TYPE
 };
=20
@@ -1266,6 +1267,9 @@ enum {
=20
 /* Create a map that is suitable to be an inner map with dynamic max ent=
ries */
 	BPF_F_INNER_MAP		=3D (1U << 12),
+
+/* Create a map that will be registered/unregesitered by the backed bpf_=
link */
+	BPF_F_LINK		=3D (1U << 13),
 };
=20
 /* Flags for BPF_PROG_QUERY. */
@@ -1507,7 +1511,10 @@ union bpf_attr {
 	} task_fd_query;
=20
 	struct { /* struct used by BPF_LINK_CREATE command */
-		__u32		prog_fd;	/* eBPF program to attach */
+		union {
+			__u32		prog_fd;	/* eBPF program to attach */
+			__u32		map_fd;		/* eBPF struct_ops to attach */
+		};
 		union {
 			__u32		target_fd;	/* object to attach to */
 			__u32		target_ifindex; /* target ifindex */
@@ -6354,6 +6361,9 @@ struct bpf_link_info {
 		struct {
 			__u32 ifindex;
 		} xdp;
+		struct {
+			__u32 map_id;
+		} struct_ops;
 	};
 } __attribute__((aligned(8)));
=20
--=20
2.30.2

