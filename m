Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332746BC3DA
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 03:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCPChh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 22:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCPChg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 22:37:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E2CA729B
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 19:37:29 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G1mhpf008529
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 19:37:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=KvnUX9zXItlqxi2HSSSkbR0LhsR8oKskhjEvW29453U=;
 b=Dk4to9tgwURdwtdO/jkYNCnBBvTcf+laZEos3Rf8SXADdx0rXY/Siq+FrSs2h8Dfp69r
 2GUiTIZN1nzuxQ7gT6iMAhm0ABbuqM7q4owqdoRugK8kMtWk15s4rrolzsWqImkNJs5f
 pt2nZZh3KDdTIEs0TB4UhY3/J6OYe5WpU0vMzqMXfyI2p8ZTzOMsqo7tsG099Jn5A7+b
 hTXueudNBbeSl7oR/PBEp546dOwPD37qbsN1HhlNfVQSeNQH+NKfvOUWSPHqlPW24eaL
 atd/ehNQWeMcqLn2JFjfWvT/+oJUx+mULhrTprSK+BV/kn6DY9DFyjnAAt1fNG7d28wl FQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pbpw811rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 19:37:29 -0700
Received: from twshared33736.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Mar 2023 19:37:28 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 013B677000C5; Wed, 15 Mar 2023 19:37:15 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v7 1/8] bpf: Retire the struct_ops map kvalue->refcnt.
Date:   Wed, 15 Mar 2023 19:36:34 -0700
Message-ID: <20230316023641.2092778-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316023641.2092778-1-kuifeng@meta.com>
References: <20230316023641.2092778-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ofg_defy4h-IwQDIleTUSkPI2kDapyPg
X-Proofpoint-ORIG-GUID: ofg_defy4h-IwQDIleTUSkPI2kDapyPg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_02,2023-03-15_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We have replaced kvalue-refcnt with synchronize_rcu() to wait for an
RCU grace period.

Maintenance of kvalue->refcnt was a complicated task, as we had to
simultaneously keep track of two reference counts: one for the
reference count of bpf_map. When the kvalue->refcnt reaches zero, we
also have to reduce the reference count on bpf_map - yet these steps
are not performed in an atomic manner and require us to be vigilant
when managing them. By eliminating kvalue->refcnt, we can make our
maintenance more straightforward as the refcount of bpf_map is now
solely managed!

To prevent the trampoline image of a struct_ops from being released
while it is still in use, we wait for an RCU grace period. The
setsockopt(TCP_CONGESTION, "...") command allows you to change your
socket's congestion control algorithm and can result in releasing the
old struct_ops implementation. It is fine. However, this function is
exposed through bpf_setsockopt(), it may be accessed by BPF programs
as well. To ensure that the trampoline image belonging to struct_op
can be safely called while its method is in use, the trampoline
safeguarde the BPF program with rcu_read_lock(). Doing so prevents any
destruction of the associated images before returning from a
trampoline and requires us to wait for an RCU grace period.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c | 75 +++++++++++++++++++++----------------
 kernel/bpf/syscall.c        |  6 ++-
 3 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 71cc92a4ba48..f4f923c19692 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1943,6 +1943,7 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd);
 struct bpf_map *__bpf_map_get(struct fd f);
 void bpf_map_inc(struct bpf_map *map);
 void bpf_map_inc_with_uref(struct bpf_map *map);
+struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
 struct bpf_map * __must_check bpf_map_inc_not_zero(struct bpf_map *map);
 void bpf_map_put_with_uref(struct bpf_map *map);
 void bpf_map_put(struct bpf_map *map);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 38903fb52f98..2a854e9cee52 100644
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
@@ -267,7 +270,14 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_ma=
p *map, void *key,
 	uvalue =3D value;
 	memcpy(uvalue, st_map->uvalue, map->value_size);
 	uvalue->state =3D state;
-	refcount_set(&uvalue->refcnt, refcount_read(&kvalue->refcnt));
+
+	/* This value offers the user space a general estimate of how
+	 * many sockets are still utilizing this struct_ops for TCP
+	 * congestion control. The number might not be exact, but it
+	 * should sufficiently meet our present goals.
+	 */
+	refcnt =3D atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
+	refcount_set(&uvalue->refcnt, max_t(s64, refcnt, 0));
=20
 	return 0;
 }
@@ -491,7 +501,6 @@ static int bpf_struct_ops_map_update_elem(struct bpf_=
map *map, void *key,
 		*(unsigned long *)(udata + moff) =3D prog->aux->id;
 	}
=20
-	refcount_set(&kvalue->refcnt, 1);
 	bpf_map_inc(map);
=20
 	set_memory_rox((long)st_map->image, 1);
@@ -536,8 +545,7 @@ static int bpf_struct_ops_map_delete_elem(struct bpf_=
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
@@ -570,7 +578,7 @@ static void bpf_struct_ops_map_seq_show_elem(struct b=
pf_map *map, void *key,
 	kfree(value);
 }
=20
-static void bpf_struct_ops_map_free(struct bpf_map *map)
+static void bpf_struct_ops_map_free_nosync(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
=20
@@ -582,6 +590,25 @@ static void bpf_struct_ops_map_free(struct bpf_map *=
map)
 	bpf_map_area_free(st_map);
 }
=20
+static void bpf_struct_ops_map_free(struct bpf_map *map)
+{
+	/* The struct_ops's function may switch to another struct_ops.
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
+	synchronize_rcu();
+	synchronize_rcu_tasks();
+
+	bpf_struct_ops_map_free_nosync(map);
+}
+
 static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->key_size !=3D sizeof(unsigned int) || attr->max_entries !=3D =
1 ||
@@ -630,7 +657,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union=
 bpf_attr *attr)
 				   NUMA_NO_NODE);
 	st_map->image =3D bpf_jit_alloc_exec(PAGE_SIZE);
 	if (!st_map->uvalue || !st_map->links || !st_map->image) {
-		bpf_struct_ops_map_free(map);
+		bpf_struct_ops_map_free_nosync(map);
 		return ERR_PTR(-ENOMEM);
 	}
=20
@@ -676,41 +703,23 @@ const struct bpf_map_ops bpf_struct_ops_map_ops =3D=
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
index 5b88301a2ae0..8f6eb22f53a7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1303,8 +1303,10 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd)
 	return map;
 }
=20
-/* map_idr_lock should have been held */
-static struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool =
uref)
+/* map_idr_lock should have been held or the map should have been
+ * protected by rcu read lock.
+ */
+struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref)
 {
 	int refold;
=20
--=20
2.34.1

