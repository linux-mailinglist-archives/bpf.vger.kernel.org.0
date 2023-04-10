Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C06DCB4E
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 21:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDJTJD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 15:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDJTJC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 15:09:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9811BE3
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:59 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AFVpXW031758
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nxhuC13p1jXXH88iev/e3EftRHu0mJWyEGTxoOGBDSI=;
 b=HDr+c35DICrDHf9YsBV0bB/XTBi34Ij2d4yQYn1E5lkqyrku/DOK8nam2R9arYC7lr4K
 ygDsCWw3pnjzeJh2lu6CvtnFz4ABFuvIfIgJsKiESP6RwLspl9f0ctQJEsQNBStZsATu
 2iwYD1giN7bzkAhPggZP76KZt5Z6bQBYvHI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pu5t22ghw-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:58 -0700
Received: from twshared8612.02.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 10 Apr 2023 12:08:55 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id CD2451BB3FCE7; Mon, 10 Apr 2023 12:08:43 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 6/9] selftests/bpf: Modify linked_list tests to work with macro-ified inserts
Date:   Mon, 10 Apr 2023 12:07:50 -0700
Message-ID: <20230410190753.2012798-7-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410190753.2012798-1-davemarchevsky@fb.com>
References: <20230410190753.2012798-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3MyQCwtJOkt--AF8NPAoFa6yNe4gR2ek
X-Proofpoint-GUID: 3MyQCwtJOkt--AF8NPAoFa6yNe4gR2ek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_14,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The linked_list tests use macros and function pointers to reduce code
duplication. Earlier in the series, bpf_list_push_{front,back} were
modified to be macros, expanding to invoke actual kfuncs
bpf_list_push_{front,back}_impl. Due to this change, a code snippet
like:

  void (*p)(void *, void *) =3D (void *)&bpf_list_##op;
  p(hexpr, nexpr);

meant to do bpf_list_push_{front,back}(hexpr, nexpr), will no longer
work as it's no longer valid to do &bpf_list_push_{front,back} since
they're no longer functions.

This patch fixes issues of this type, along with two other minor changes
- one improvement and one fix - both related to the node argument to
list_push_{front,back}.

  * The fix: migration of list_push tests away from (void *, void *)
    func ptr uncovered that some tests were incorrectly passing pointer
    to node, not pointer to struct bpf_list_node within the node. This
    patch fixes such issues (CHECK(..., f) -> CHECK(..., &f->node))

  * The improvement: In linked_list tests, the struct foo type has two
    list_node fields: node and node2, at byte offsets 0 and 40 within
    the struct, respectively. Currently node is used in ~all tests
    involving struct foo and lists. The verifier needs to do some work
    to account for the offset of bpf_list_node within the node type, so
    using node2 instead of node exercises that logic more in the tests.
    This patch migrates linked_list tests to use node2 instead of node.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/prog_tests/linked_list.c    |  6 +-
 .../testing/selftests/bpf/progs/linked_list.c | 34 +++----
 .../testing/selftests/bpf/progs/linked_list.h |  4 +-
 .../selftests/bpf/progs/linked_list_fail.c    | 96 ++++++++++---------
 4 files changed, 73 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
index 0ed8132ce1c3..872e4bd500fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -84,11 +84,11 @@ static struct {
 	{ "double_push_back", "arg#1 expected pointer to allocated object" },
 	{ "no_node_value_type", "bpf_list_node not found at offset=3D0" },
 	{ "incorrect_value_type",
-	  "operation on bpf_list_head expects arg#1 bpf_list_node at offset=3D0=
 in struct foo, "
+	  "operation on bpf_list_head expects arg#1 bpf_list_node at offset=3D4=
0 in struct foo, "
 	  "but arg is at offset=3D0 in struct bar" },
 	{ "incorrect_node_var_off", "variable ptr_ access var_off=3D(0x0; 0xfff=
fffff) disallowed" },
-	{ "incorrect_node_off1", "bpf_list_node not found at offset=3D1" },
-	{ "incorrect_node_off2", "arg#1 offset=3D40, but expected bpf_list_node=
 at offset=3D0 in struct foo" },
+	{ "incorrect_node_off1", "bpf_list_node not found at offset=3D41" },
+	{ "incorrect_node_off2", "arg#1 offset=3D0, but expected bpf_list_node =
at offset=3D40 in struct foo" },
 	{ "no_head_type", "bpf_list_head not found at offset=3D0" },
 	{ "incorrect_head_var_off1", "R1 doesn't have constant offset" },
 	{ "incorrect_head_var_off2", "variable ptr_ access var_off=3D(0x0; 0xff=
ffffff) disallowed" },
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/test=
ing/selftests/bpf/progs/linked_list.c
index 53ded51a3abb..57440a554304 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -25,7 +25,7 @@ int list_push_pop(struct bpf_spin_lock *lock, struct bp=
f_list_head *head, bool l
 	n =3D bpf_list_pop_front(head);
 	bpf_spin_unlock(lock);
 	if (n) {
-		bpf_obj_drop(container_of(n, struct foo, node));
+		bpf_obj_drop(container_of(n, struct foo, node2));
 		bpf_obj_drop(f);
 		return 3;
 	}
@@ -34,7 +34,7 @@ int list_push_pop(struct bpf_spin_lock *lock, struct bp=
f_list_head *head, bool l
 	n =3D bpf_list_pop_back(head);
 	bpf_spin_unlock(lock);
 	if (n) {
-		bpf_obj_drop(container_of(n, struct foo, node));
+		bpf_obj_drop(container_of(n, struct foo, node2));
 		bpf_obj_drop(f);
 		return 4;
 	}
@@ -42,7 +42,7 @@ int list_push_pop(struct bpf_spin_lock *lock, struct bp=
f_list_head *head, bool l
=20
 	bpf_spin_lock(lock);
 	f->data =3D 42;
-	bpf_list_push_front(head, &f->node);
+	bpf_list_push_front(head, &f->node2);
 	bpf_spin_unlock(lock);
 	if (leave_in_map)
 		return 0;
@@ -51,7 +51,7 @@ int list_push_pop(struct bpf_spin_lock *lock, struct bp=
f_list_head *head, bool l
 	bpf_spin_unlock(lock);
 	if (!n)
 		return 5;
-	f =3D container_of(n, struct foo, node);
+	f =3D container_of(n, struct foo, node2);
 	if (f->data !=3D 42) {
 		bpf_obj_drop(f);
 		return 6;
@@ -59,14 +59,14 @@ int list_push_pop(struct bpf_spin_lock *lock, struct =
bpf_list_head *head, bool l
=20
 	bpf_spin_lock(lock);
 	f->data =3D 13;
-	bpf_list_push_front(head, &f->node);
+	bpf_list_push_front(head, &f->node2);
 	bpf_spin_unlock(lock);
 	bpf_spin_lock(lock);
 	n =3D bpf_list_pop_front(head);
 	bpf_spin_unlock(lock);
 	if (!n)
 		return 7;
-	f =3D container_of(n, struct foo, node);
+	f =3D container_of(n, struct foo, node2);
 	if (f->data !=3D 13) {
 		bpf_obj_drop(f);
 		return 8;
@@ -77,7 +77,7 @@ int list_push_pop(struct bpf_spin_lock *lock, struct bp=
f_list_head *head, bool l
 	n =3D bpf_list_pop_front(head);
 	bpf_spin_unlock(lock);
 	if (n) {
-		bpf_obj_drop(container_of(n, struct foo, node));
+		bpf_obj_drop(container_of(n, struct foo, node2));
 		return 9;
 	}
=20
@@ -85,7 +85,7 @@ int list_push_pop(struct bpf_spin_lock *lock, struct bp=
f_list_head *head, bool l
 	n =3D bpf_list_pop_back(head);
 	bpf_spin_unlock(lock);
 	if (n) {
-		bpf_obj_drop(container_of(n, struct foo, node));
+		bpf_obj_drop(container_of(n, struct foo, node2));
 		return 10;
 	}
 	return 0;
@@ -119,8 +119,8 @@ int list_push_pop_multiple(struct bpf_spin_lock *lock=
, struct bpf_list_head *hea
 		f[i + 1]->data =3D i + 1;
=20
 		bpf_spin_lock(lock);
-		bpf_list_push_front(head, &f[i]->node);
-		bpf_list_push_front(head, &f[i + 1]->node);
+		bpf_list_push_front(head, &f[i]->node2);
+		bpf_list_push_front(head, &f[i + 1]->node2);
 		bpf_spin_unlock(lock);
 	}
=20
@@ -130,13 +130,13 @@ int list_push_pop_multiple(struct bpf_spin_lock *lo=
ck, struct bpf_list_head *hea
 		bpf_spin_unlock(lock);
 		if (!n)
 			return 3;
-		pf =3D container_of(n, struct foo, node);
+		pf =3D container_of(n, struct foo, node2);
 		if (pf->data !=3D (ARRAY_SIZE(f) - i - 1)) {
 			bpf_obj_drop(pf);
 			return 4;
 		}
 		bpf_spin_lock(lock);
-		bpf_list_push_back(head, &pf->node);
+		bpf_list_push_back(head, &pf->node2);
 		bpf_spin_unlock(lock);
 	}
=20
@@ -149,7 +149,7 @@ int list_push_pop_multiple(struct bpf_spin_lock *lock=
, struct bpf_list_head *hea
 		bpf_spin_unlock(lock);
 		if (!n)
 			return 5;
-		pf =3D container_of(n, struct foo, node);
+		pf =3D container_of(n, struct foo, node2);
 		if (pf->data !=3D i) {
 			bpf_obj_drop(pf);
 			return 6;
@@ -160,7 +160,7 @@ int list_push_pop_multiple(struct bpf_spin_lock *lock=
, struct bpf_list_head *hea
 	n =3D bpf_list_pop_back(head);
 	bpf_spin_unlock(lock);
 	if (n) {
-		bpf_obj_drop(container_of(n, struct foo, node));
+		bpf_obj_drop(container_of(n, struct foo, node2));
 		return 7;
 	}
=20
@@ -168,7 +168,7 @@ int list_push_pop_multiple(struct bpf_spin_lock *lock=
, struct bpf_list_head *hea
 	n =3D bpf_list_pop_front(head);
 	bpf_spin_unlock(lock);
 	if (n) {
-		bpf_obj_drop(container_of(n, struct foo, node));
+		bpf_obj_drop(container_of(n, struct foo, node2));
 		return 8;
 	}
 	return 0;
@@ -199,7 +199,7 @@ int list_in_list(struct bpf_spin_lock *lock, struct b=
pf_list_head *head, bool le
=20
 	bpf_spin_lock(lock);
 	f->data =3D 42;
-	bpf_list_push_front(head, &f->node);
+	bpf_list_push_front(head, &f->node2);
 	bpf_spin_unlock(lock);
=20
 	if (leave_in_map)
@@ -210,7 +210,7 @@ int list_in_list(struct bpf_spin_lock *lock, struct b=
pf_list_head *head, bool le
 	bpf_spin_unlock(lock);
 	if (!n)
 		return 4;
-	f =3D container_of(n, struct foo, node);
+	f =3D container_of(n, struct foo, node2);
 	if (f->data !=3D 42) {
 		bpf_obj_drop(f);
 		return 5;
diff --git a/tools/testing/selftests/bpf/progs/linked_list.h b/tools/test=
ing/selftests/bpf/progs/linked_list.h
index 3fb2412552fc..c0f3609a7ffa 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.h
+++ b/tools/testing/selftests/bpf/progs/linked_list.h
@@ -22,7 +22,7 @@ struct foo {
 struct map_value {
 	struct bpf_spin_lock lock;
 	int data;
-	struct bpf_list_head head __contains(foo, node);
+	struct bpf_list_head head __contains(foo, node2);
 };
=20
 struct array_map {
@@ -50,7 +50,7 @@ struct {
 #define private(name) SEC(".bss." #name) __hidden __attribute__((aligned=
(8)))
=20
 private(A) struct bpf_spin_lock glock;
-private(A) struct bpf_list_head ghead __contains(foo, node);
+private(A) struct bpf_list_head ghead __contains(foo, node2);
 private(B) struct bpf_spin_lock glock2;
=20
 #endif
diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools=
/testing/selftests/bpf/progs/linked_list_fail.c
index 41978b46f58e..f4c63daba229 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -73,22 +73,21 @@ CHECK(inner_map, pop_back, &iv->head);
 	int test##_missing_lock_##op(void *ctx)				\
 	{								\
 		INIT;							\
-		void (*p)(void *, void *) =3D (void *)&bpf_list_##op;	\
-		p(hexpr, nexpr);					\
+		bpf_list_##op(hexpr, nexpr);				\
 		return 0;						\
 	}
=20
-CHECK(kptr, push_front, &f->head, b);
-CHECK(kptr, push_back, &f->head, b);
+CHECK(kptr, push_front, &f->head, &b->node);
+CHECK(kptr, push_back, &f->head, &b->node);
=20
-CHECK(global, push_front, &ghead, f);
-CHECK(global, push_back, &ghead, f);
+CHECK(global, push_front, &ghead, &f->node2);
+CHECK(global, push_back, &ghead, &f->node2);
=20
-CHECK(map, push_front, &v->head, f);
-CHECK(map, push_back, &v->head, f);
+CHECK(map, push_front, &v->head, &f->node2);
+CHECK(map, push_back, &v->head, &f->node2);
=20
-CHECK(inner_map, push_front, &iv->head, f);
-CHECK(inner_map, push_back, &iv->head, f);
+CHECK(inner_map, push_front, &iv->head, &f->node2);
+CHECK(inner_map, push_back, &iv->head, &f->node2);
=20
 #undef CHECK
=20
@@ -135,32 +134,31 @@ CHECK_OP(pop_back);
 	int test##_incorrect_lock_##op(void *ctx)			\
 	{								\
 		INIT;							\
-		void (*p)(void *, void*) =3D (void *)&bpf_list_##op;	\
 		bpf_spin_lock(lexpr);					\
-		p(hexpr, nexpr);					\
+		bpf_list_##op(hexpr, nexpr);				\
 		return 0;						\
 	}
=20
 #define CHECK_OP(op)							\
-	CHECK(kptr_kptr, op, &f1->lock, &f2->head, b);			\
-	CHECK(kptr_global, op, &f1->lock, &ghead, f);			\
-	CHECK(kptr_map, op, &f1->lock, &v->head, f);			\
-	CHECK(kptr_inner_map, op, &f1->lock, &iv->head, f);		\
+	CHECK(kptr_kptr, op, &f1->lock, &f2->head, &b->node);		\
+	CHECK(kptr_global, op, &f1->lock, &ghead, &f->node2);		\
+	CHECK(kptr_map, op, &f1->lock, &v->head, &f->node2);		\
+	CHECK(kptr_inner_map, op, &f1->lock, &iv->head, &f->node2);	\
 									\
-	CHECK(global_global, op, &glock2, &ghead, f);			\
-	CHECK(global_kptr, op, &glock, &f1->head, b);			\
-	CHECK(global_map, op, &glock, &v->head, f);			\
-	CHECK(global_inner_map, op, &glock, &iv->head, f);		\
+	CHECK(global_global, op, &glock2, &ghead, &f->node2);		\
+	CHECK(global_kptr, op, &glock, &f1->head, &b->node);		\
+	CHECK(global_map, op, &glock, &v->head, &f->node2);		\
+	CHECK(global_inner_map, op, &glock, &iv->head, &f->node2);	\
 									\
-	CHECK(map_map, op, &v->lock, &v2->head, f);			\
-	CHECK(map_kptr, op, &v->lock, &f2->head, b);			\
-	CHECK(map_global, op, &v->lock, &ghead, f);			\
-	CHECK(map_inner_map, op, &v->lock, &iv->head, f);		\
+	CHECK(map_map, op, &v->lock, &v2->head, &f->node2);		\
+	CHECK(map_kptr, op, &v->lock, &f2->head, &b->node);		\
+	CHECK(map_global, op, &v->lock, &ghead, &f->node2);		\
+	CHECK(map_inner_map, op, &v->lock, &iv->head, &f->node2);	\
 									\
-	CHECK(inner_map_inner_map, op, &iv->lock, &iv2->head, f);	\
-	CHECK(inner_map_kptr, op, &iv->lock, &f2->head, b);		\
-	CHECK(inner_map_global, op, &iv->lock, &ghead, f);		\
-	CHECK(inner_map_map, op, &iv->lock, &v->head, f);
+	CHECK(inner_map_inner_map, op, &iv->lock, &iv2->head, &f->node2);\
+	CHECK(inner_map_kptr, op, &iv->lock, &f2->head, &b->node);	\
+	CHECK(inner_map_global, op, &iv->lock, &ghead, &f->node2);	\
+	CHECK(inner_map_map, op, &iv->lock, &v->head, &f->node2);
=20
 CHECK_OP(push_front);
 CHECK_OP(push_back);
@@ -340,7 +338,7 @@ int direct_read_node(void *ctx)
 	f =3D bpf_obj_new(typeof(*f));
 	if (!f)
 		return 0;
-	return *(int *)&f->node;
+	return *(int *)&f->node2;
 }
=20
 SEC("?tc")
@@ -351,12 +349,12 @@ int direct_write_node(void *ctx)
 	f =3D bpf_obj_new(typeof(*f));
 	if (!f)
 		return 0;
-	*(int *)&f->node =3D 0;
+	*(int *)&f->node2 =3D 0;
 	return 0;
 }
=20
 static __always_inline
-int use_after_unlock(void (*op)(void *head, void *node))
+int use_after_unlock(bool push_front)
 {
 	struct foo *f;
=20
@@ -365,7 +363,10 @@ int use_after_unlock(void (*op)(void *head, void *no=
de))
 		return 0;
 	bpf_spin_lock(&glock);
 	f->data =3D 42;
-	op(&ghead, &f->node);
+	if (push_front)
+		bpf_list_push_front(&ghead, &f->node2);
+	else
+		bpf_list_push_back(&ghead, &f->node2);
 	bpf_spin_unlock(&glock);
=20
 	return f->data;
@@ -374,17 +375,17 @@ int use_after_unlock(void (*op)(void *head, void *n=
ode))
 SEC("?tc")
 int use_after_unlock_push_front(void *ctx)
 {
-	return use_after_unlock((void *)bpf_list_push_front);
+	return use_after_unlock(true);
 }
=20
 SEC("?tc")
 int use_after_unlock_push_back(void *ctx)
 {
-	return use_after_unlock((void *)bpf_list_push_back);
+	return use_after_unlock(false);
 }
=20
 static __always_inline
-int list_double_add(void (*op)(void *head, void *node))
+int list_double_add(bool push_front)
 {
 	struct foo *f;
=20
@@ -392,8 +393,13 @@ int list_double_add(void (*op)(void *head, void *nod=
e))
 	if (!f)
 		return 0;
 	bpf_spin_lock(&glock);
-	op(&ghead, &f->node);
-	op(&ghead, &f->node);
+	if (push_front) {
+		bpf_list_push_front(&ghead, &f->node2);
+		bpf_list_push_front(&ghead, &f->node2);
+	} else {
+		bpf_list_push_back(&ghead, &f->node2);
+		bpf_list_push_back(&ghead, &f->node2);
+	}
 	bpf_spin_unlock(&glock);
=20
 	return 0;
@@ -402,13 +408,13 @@ int list_double_add(void (*op)(void *head, void *no=
de))
 SEC("?tc")
 int double_push_front(void *ctx)
 {
-	return list_double_add((void *)bpf_list_push_front);
+	return list_double_add(true);
 }
=20
 SEC("?tc")
 int double_push_back(void *ctx)
 {
-	return list_double_add((void *)bpf_list_push_back);
+	return list_double_add(false);
 }
=20
 SEC("?tc")
@@ -450,7 +456,7 @@ int incorrect_node_var_off(struct __sk_buff *ctx)
 	if (!f)
 		return 0;
 	bpf_spin_lock(&glock);
-	bpf_list_push_front(&ghead, (void *)&f->node + ctx->protocol);
+	bpf_list_push_front(&ghead, (void *)&f->node2 + ctx->protocol);
 	bpf_spin_unlock(&glock);
=20
 	return 0;
@@ -465,7 +471,7 @@ int incorrect_node_off1(void *ctx)
 	if (!f)
 		return 0;
 	bpf_spin_lock(&glock);
-	bpf_list_push_front(&ghead, (void *)&f->node + 1);
+	bpf_list_push_front(&ghead, (void *)&f->node2 + 1);
 	bpf_spin_unlock(&glock);
=20
 	return 0;
@@ -480,7 +486,7 @@ int incorrect_node_off2(void *ctx)
 	if (!f)
 		return 0;
 	bpf_spin_lock(&glock);
-	bpf_list_push_front(&ghead, &f->node2);
+	bpf_list_push_front(&ghead, &f->node);
 	bpf_spin_unlock(&glock);
=20
 	return 0;
@@ -510,7 +516,7 @@ int incorrect_head_var_off1(struct __sk_buff *ctx)
 	if (!f)
 		return 0;
 	bpf_spin_lock(&glock);
-	bpf_list_push_front((void *)&ghead + ctx->protocol, &f->node);
+	bpf_list_push_front((void *)&ghead + ctx->protocol, &f->node2);
 	bpf_spin_unlock(&glock);
=20
 	return 0;
@@ -525,7 +531,7 @@ int incorrect_head_var_off2(struct __sk_buff *ctx)
 	if (!f)
 		return 0;
 	bpf_spin_lock(&glock);
-	bpf_list_push_front((void *)&f->head + ctx->protocol, &f->node);
+	bpf_list_push_front((void *)&f->head + ctx->protocol, &f->node2);
 	bpf_spin_unlock(&glock);
=20
 	return 0;
@@ -563,7 +569,7 @@ int incorrect_head_off2(void *ctx)
 		return 0;
=20
 	bpf_spin_lock(&glock);
-	bpf_list_push_front((void *)&ghead + 1, &f->node);
+	bpf_list_push_front((void *)&ghead + 1, &f->node2);
 	bpf_spin_unlock(&glock);
=20
 	return 0;
--=20
2.34.1

