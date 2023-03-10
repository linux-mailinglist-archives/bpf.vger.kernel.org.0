Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F716B35A2
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 05:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCJEi3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 23:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCJEi2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 23:38:28 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EFE2686B
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 20:38:24 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32A2rOBj031898
        for <bpf@vger.kernel.org>; Thu, 9 Mar 2023 20:38:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Ae7at/yqRiwV0EFFbvRGyyoC6Duoovht9fBeNHPTYSc=;
 b=W+hJVqnQdAlJi5CqQy3liDmQNma9U67ZJqtMyzR/IijxiS1E6MXuugOuqmmeJgKaZv/w
 Aeja7Ot0GS3i0hQ92NE5f5lC6xH1QyakUevQJ/ZMtz70ZpyxM+LujTPffuKjKcFekuG2
 kUk/QzhTr3rkxhc1/ttPzf3ikmrmEHhGsJooFYhEY1NpINTWFI9RUcgRQnJniF74BBHp
 Jf0Q7Pi/XxG8H8uPvqqy4eUlt8mw+c6QImq1ht/RGC7lqAOiA9S0yec0YedZJb4XDXwH
 ZTbCJEMWUrkNpH6GJJq5n1OSplD1izhyleBENwvsJ2c1u2cWrlpahqoH+pir+ATK4URQ gg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p7cp3xhaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 20:38:23 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Mar 2023 20:38:22 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 5F8096F6BD94; Thu,  9 Mar 2023 20:38:20 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v6 1/8] bpf: Retire the struct_ops map kvalue->refcnt.
Date:   Thu, 9 Mar 2023 20:38:05 -0800
Message-ID: <20230310043812.3087672-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310043812.3087672-1-kuifeng@meta.com>
References: <20230310043812.3087672-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nK0L9O5EpSJgYsRIz6KdiFaltH_hhgKR
X-Proofpoint-ORIG-GUID: nK0L9O5EpSJgYsRIz6KdiFaltH_hhgKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_01,2023-03-09_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
old struct_ops implementation. Moreover, since this function is
exposed through bpf_setsockopt(), it may be accessed by BPF programs
as well. To ensure that the trampoline image belonging to struct_op
can be safely called while its method is in use, struct_ops is
safeguarded with rcu_read_lock(). Doing so prevents any destruction of
the associated images before returning from a trampoline and requires
us to wait for an RCU grace period.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c | 68 ++++++++++++++++++++-----------------
 kernel/bpf/syscall.c        |  6 ++--
 3 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e64ff1e89fb2..00ca92ea6f2e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1938,6 +1938,7 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd);
 struct bpf_map *__bpf_map_get(struct fd f);
 void bpf_map_inc(struct bpf_map *map);
 void bpf_map_inc_with_uref(struct bpf_map *map);
+struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
 struct bpf_map * __must_check bpf_map_inc_not_zero(struct bpf_map *map);
 void bpf_map_put_with_uref(struct bpf_map *map);
 void bpf_map_put(struct bpf_map *map);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 38903fb52f98..ab7811a4c1dd 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -58,6 +58,11 @@ struct bpf_struct_ops_map {
 	struct bpf_struct_ops_value kvalue;
 };
=20
+struct bpf_struct_ops_link {
+	struct bpf_link link;
+	struct bpf_map __rcu *map;
+};
+
 #define VALUE_PREFIX "bpf_struct_ops_"
 #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
=20
@@ -249,6 +254,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map=
 *map, void *key,
 	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
 	struct bpf_struct_ops_value *uvalue, *kvalue;
 	enum bpf_struct_ops_state state;
+	s64 refcnt;
=20
 	if (unlikely(*(u32 *)key !=3D 0))
 		return -ENOENT;
@@ -267,7 +273,14 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_ma=
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
@@ -491,7 +504,6 @@ static int bpf_struct_ops_map_update_elem(struct bpf_=
map *map, void *key,
 		*(unsigned long *)(udata + moff) =3D prog->aux->id;
 	}
=20
-	refcount_set(&kvalue->refcnt, 1);
 	bpf_map_inc(map);
=20
 	set_memory_rox((long)st_map->image, 1);
@@ -536,8 +548,7 @@ static int bpf_struct_ops_map_delete_elem(struct bpf_=
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
@@ -574,6 +585,19 @@ static void bpf_struct_ops_map_free(struct bpf_map *=
map)
 {
 	struct bpf_struct_ops_map *st_map =3D (struct bpf_struct_ops_map *)map;
=20
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
+
 	if (st_map->links)
 		bpf_struct_ops_map_put_progs(st_map);
 	bpf_map_area_free(st_map->links);
@@ -676,41 +700,23 @@ const struct bpf_map_ops bpf_struct_ops_map_ops =3D=
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
index f406dfa13792..ec03f9e450ad 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1287,8 +1287,10 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd)
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

