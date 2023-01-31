Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2446F683499
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjAaSCx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjAaSCp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:02:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D143959ED
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:02:44 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VGRxxD021343
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:02:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=eAJc6FgT6OgM/OzG+DHDoVba5vDUkd53z2X434/k4Wc=;
 b=j7FUoUgqeMNHngPBU+1+7+XIdOC2mWd4KrRyhLpFwaG9ba3EGWR0hq/j3pOPNl8OyNIf
 vR5JsP9AwVICsrO9C6RvYGTaAGzS7iIHDlfprBrRiwNZr7B/2LPjgqlPNh90+yNk9s0g
 r/ylK+JnYDBBieDGXt0QK1SeMiN20bV+1Uc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nf4c619dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:02:44 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 31 Jan 2023 10:02:43 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id C08D815D5BB67; Tue, 31 Jan 2023 10:00:19 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next 03/11] selftests/bpf: Update linked_list tests for non-owning ref semantics
Date:   Tue, 31 Jan 2023 10:00:08 -0800
Message-ID: <20230131180016.3368305-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230131180016.3368305-1-davemarchevsky@fb.com>
References: <20230131180016.3368305-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fRjO2-nMMn745qvw20R6YYhhzxKlE9cT
X-Proofpoint-ORIG-GUID: fRjO2-nMMn745qvw20R6YYhhzxKlE9cT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Current linked_list semantics for release_on_unlock node refs are almost
exactly the same as newly-introduced "non-owning reference" concept. The
only difference: writes to a release_on_unlock node ref are not allowed,
while writes to non-owning reference pointees are.

As a result the linked_list "write after push" failure tests are no
longer scenarios that should fail.

The test##_missing_lock_##op and test##_incorrect_lock_##op
macro-generated failure tests need to have a valid node argument in
order to have the same error output as before. Otherwise verification
will fail early and the expected error output won't be seen.

Some other tests have minor changes in error output, but fail for the
same reason.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/prog_tests/linked_list.c    |  10 +-
 .../testing/selftests/bpf/progs/linked_list.c |   2 +-
 .../selftests/bpf/progs/linked_list_fail.c    | 100 +++++++++++-------
 3 files changed, 68 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
index 9a7d4c47af63..a8091a0c0831 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -78,18 +78,18 @@ static struct {
 	{ "direct_write_head", "direct access to bpf_list_head is disallowed" }=
,
 	{ "direct_read_node", "direct access to bpf_list_node is disallowed" },
 	{ "direct_write_node", "direct access to bpf_list_node is disallowed" }=
,
-	{ "write_after_push_front", "only read is supported" },
-	{ "write_after_push_back", "only read is supported" },
 	{ "use_after_unlock_push_front", "invalid mem access 'scalar'" },
 	{ "use_after_unlock_push_back", "invalid mem access 'scalar'" },
-	{ "double_push_front", "arg#1 expected pointer to allocated object" },
-	{ "double_push_back", "arg#1 expected pointer to allocated object" },
+	{ "double_push_front",
+	  "release kernel function bpf_list_push_front expects refcounted PTR_T=
O_BTF_ID" },
+	{ "double_push_back",
+	  "release kernel function bpf_list_push_back expects refcounted PTR_TO=
_BTF_ID" },
 	{ "no_node_value_type", "bpf_list_node not found at offset=3D0" },
 	{ "incorrect_value_type",
 	  "operation on bpf_list_head expects arg#1 bpf_list_node at offset=3D0=
 in struct foo, "
 	  "but arg is at offset=3D0 in struct bar" },
 	{ "incorrect_node_var_off", "variable ptr_ access var_off=3D(0x0; 0xfff=
fffff) disallowed" },
-	{ "incorrect_node_off1", "bpf_list_node not found at offset=3D1" },
+	{ "incorrect_node_off1", "No graph node or root found at R2 type:foo of=
f:1" },
 	{ "incorrect_node_off2", "arg#1 offset=3D40, but expected bpf_list_node=
 at offset=3D0 in struct foo" },
 	{ "no_head_type", "bpf_list_head not found at offset=3D0" },
 	{ "incorrect_head_var_off1", "R1 doesn't have constant offset" },
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/test=
ing/selftests/bpf/progs/linked_list.c
index 4ad88da5cda2..4fa4a9b01bde 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -260,7 +260,7 @@ int test_list_push_pop_multiple(struct bpf_spin_lock =
*lock, struct bpf_list_head
 {
 	int ret;
=20
-	ret =3D list_push_pop_multiple(lock ,head, false);
+	ret =3D list_push_pop_multiple(lock, head, false);
 	if (ret)
 		return ret;
 	return list_push_pop_multiple(lock, head, true);
diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools=
/testing/selftests/bpf/progs/linked_list_fail.c
index 1d9017240e19..69cdc07cba13 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -54,28 +54,44 @@
 		return 0;                                   \
 	}
=20
-CHECK(kptr, push_front, &f->head);
-CHECK(kptr, push_back, &f->head);
 CHECK(kptr, pop_front, &f->head);
 CHECK(kptr, pop_back, &f->head);
=20
-CHECK(global, push_front, &ghead);
-CHECK(global, push_back, &ghead);
 CHECK(global, pop_front, &ghead);
 CHECK(global, pop_back, &ghead);
=20
-CHECK(map, push_front, &v->head);
-CHECK(map, push_back, &v->head);
 CHECK(map, pop_front, &v->head);
 CHECK(map, pop_back, &v->head);
=20
-CHECK(inner_map, push_front, &iv->head);
-CHECK(inner_map, push_back, &iv->head);
 CHECK(inner_map, pop_front, &iv->head);
 CHECK(inner_map, pop_back, &iv->head);
=20
 #undef CHECK
=20
+#define CHECK(test, op, hexpr, nexpr)					\
+	SEC("?tc")							\
+	int test##_missing_lock_##op(void *ctx)				\
+	{								\
+		INIT;							\
+		void (*p)(void *, void *) =3D (void *)&bpf_list_##op;	\
+		p(hexpr, nexpr);					\
+		return 0;						\
+	}
+
+CHECK(kptr, push_front, &f->head, b);
+CHECK(kptr, push_back, &f->head, b);
+
+CHECK(global, push_front, &ghead, f);
+CHECK(global, push_back, &ghead, f);
+
+CHECK(map, push_front, &v->head, f);
+CHECK(map, push_back, &v->head, f);
+
+CHECK(inner_map, push_front, &iv->head, f);
+CHECK(inner_map, push_back, &iv->head, f);
+
+#undef CHECK
+
 #define CHECK(test, op, lexpr, hexpr)                       \
 	SEC("?tc")                                          \
 	int test##_incorrect_lock_##op(void *ctx)           \
@@ -108,11 +124,47 @@ CHECK(inner_map, pop_back, &iv->head);
 	CHECK(inner_map_global, op, &iv->lock, &ghead);        \
 	CHECK(inner_map_map, op, &iv->lock, &v->head);
=20
-CHECK_OP(push_front);
-CHECK_OP(push_back);
 CHECK_OP(pop_front);
 CHECK_OP(pop_back);
=20
+#undef CHECK
+#undef CHECK_OP
+
+#define CHECK(test, op, lexpr, hexpr, nexpr)				\
+	SEC("?tc")							\
+	int test##_incorrect_lock_##op(void *ctx)			\
+	{								\
+		INIT;							\
+		void (*p)(void *, void*) =3D (void *)&bpf_list_##op;	\
+		bpf_spin_lock(lexpr);					\
+		p(hexpr, nexpr);					\
+		return 0;						\
+	}
+
+#define CHECK_OP(op)							\
+	CHECK(kptr_kptr, op, &f1->lock, &f2->head, b);			\
+	CHECK(kptr_global, op, &f1->lock, &ghead, f);			\
+	CHECK(kptr_map, op, &f1->lock, &v->head, f);			\
+	CHECK(kptr_inner_map, op, &f1->lock, &iv->head, f);		\
+									\
+	CHECK(global_global, op, &glock2, &ghead, f);			\
+	CHECK(global_kptr, op, &glock, &f1->head, b);			\
+	CHECK(global_map, op, &glock, &v->head, f);			\
+	CHECK(global_inner_map, op, &glock, &iv->head, f);		\
+									\
+	CHECK(map_map, op, &v->lock, &v2->head, f);			\
+	CHECK(map_kptr, op, &v->lock, &f2->head, b);			\
+	CHECK(map_global, op, &v->lock, &ghead, f);			\
+	CHECK(map_inner_map, op, &v->lock, &iv->head, f);		\
+									\
+	CHECK(inner_map_inner_map, op, &iv->lock, &iv2->head, f);	\
+	CHECK(inner_map_kptr, op, &iv->lock, &f2->head, b);		\
+	CHECK(inner_map_global, op, &iv->lock, &ghead, f);		\
+	CHECK(inner_map_map, op, &iv->lock, &v->head, f);
+
+CHECK_OP(push_front);
+CHECK_OP(push_back);
+
 #undef CHECK
 #undef CHECK_OP
 #undef INIT
@@ -303,34 +355,6 @@ int direct_write_node(void *ctx)
 	return 0;
 }
=20
-static __always_inline
-int write_after_op(void (*push_op)(void *head, void *node))
-{
-	struct foo *f;
-
-	f =3D bpf_obj_new(typeof(*f));
-	if (!f)
-		return 0;
-	bpf_spin_lock(&glock);
-	push_op(&ghead, &f->node);
-	f->data =3D 42;
-	bpf_spin_unlock(&glock);
-
-	return 0;
-}
-
-SEC("?tc")
-int write_after_push_front(void *ctx)
-{
-	return write_after_op((void *)bpf_list_push_front);
-}
-
-SEC("?tc")
-int write_after_push_back(void *ctx)
-{
-	return write_after_op((void *)bpf_list_push_back);
-}
-
 static __always_inline
 int use_after_unlock(void (*op)(void *head, void *node))
 {
--=20
2.30.2

