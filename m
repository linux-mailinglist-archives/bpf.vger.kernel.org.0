Return-Path: <bpf+bounces-5159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E66C7576C3
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 10:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8393281395
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 08:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207C7C157;
	Tue, 18 Jul 2023 08:38:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0FA932
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 08:38:30 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DECEE49
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 01:38:28 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 36HI9BJ4007139
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 01:38:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=SYqrpggv1cMFub08b67S1RL4x+Bsms+evnU648xndQw=;
 b=TKVtaQmglWqc1yKG0ZeR1ppBDnZ0C4RTNJKXrLPTLWexorz4tcTPMUnZdvIWXHvxYmCt
 4tfr6SX+dyRJu+0Hm4vflVXkSJ1+dESg3s0OEzFJzYCxH2+ar20l9cWipOmgM146zkzH
 9b+rcpxCMOy6vYowb4I1X01j3MCkBPmtfkw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3rwansca54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 01:38:27 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 01:38:26 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 7347F214366BD; Tue, 18 Jul 2023 01:38:22 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH v2 bpf-next 3/6] bpf: Add 'owner' field to bpf_{list,rb}_node
Date: Tue, 18 Jul 2023 01:38:10 -0700
Message-ID: <20230718083813.3416104-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718083813.3416104-1-davemarchevsky@fb.com>
References: <20230718083813.3416104-1-davemarchevsky@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: j6zx5acwZS9Zq1RpRQ107XViQLxo6dlg
X-Proofpoint-ORIG-GUID: j6zx5acwZS9Zq1RpRQ107XViQLxo6dlg
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As described by Kumar in [0], in shared ownership scenarios it is
necessary to do runtime tracking of {rb,list} node ownership - and
synchronize updates using this ownership information - in order to
prevent races. This patch adds an 'owner' field to struct bpf_list_node
and bpf_rb_node to implement such runtime tracking.

The owner field is a void * that describes the ownership state of a
node. It can have the following values:

  NULL           - the node is not owned by any data structure
  BPF_PTR_POISON - the node is in the process of being added to a data
                   structure
  ptr_to_root    - the pointee is a data structure 'root'
                   (bpf_rb_root / bpf_list_head) which owns this node

The field is initially NULL (set by bpf_obj_init_field default behavior)
and transitions states in the following sequence:

  Insertion: NULL -> BPF_PTR_POISON -> ptr_to_root
  Removal:   ptr_to_root -> NULL

Before a node has been successfully inserted, it is not protected by any
root's lock, and therefore two programs can attempt to add the same node
to different roots simultaneously. For this reason the intermediate
BPF_PTR_POISON state is necessary. For removal, the node is protected
by some root's lock so this intermediate hop isn't necessary.

Note that bpf_list_pop_{front,back} helpers don't need to check owner
before removing as the node-to-be-removed is not passed in as input and
is instead taken directly from the list. Do the check anyways and
WARN_ON_ONCE in this unexpected scenario.

Selftest changes in this patch are entirely mechanical: some BTF
tests have hardcoded struct sizes for structs that contain
bpf_{list,rb}_node fields, those were adjusted to account for the new
sizes. Selftest additions to validate the owner field are added in a
further patch in the series.

  [0]: https://lore.kernel.org/bpf/d7hyspcow5wtjcmw4fugdgyp3fwhljwuscp3xyut=
5qnwivyeru@ysdq543otzv2

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |  2 +
 include/uapi/linux/bpf.h                      |  2 +
 kernel/bpf/helpers.c                          | 29 ++++++-
 .../selftests/bpf/prog_tests/linked_list.c    | 78 +++++++++----------
 4 files changed, 68 insertions(+), 43 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 511ed49c3fe9..ceaa8c23287f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -231,11 +231,13 @@ struct btf_record {
 /* Non-opaque version of bpf_rb_node in uapi/linux/bpf.h */
 struct bpf_rb_node_kern {
 	struct rb_node rb_node;
+	void *owner;
 } __attribute__((aligned(8)));
=20
 /* Non-opaque version of bpf_list_node in uapi/linux/bpf.h */
 struct bpf_list_node_kern {
 	struct list_head list_head;
+	void *owner;
 } __attribute__((aligned(8)));
=20
 struct bpf_map {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 600d0caebbd8..9ed59896ebc5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7052,6 +7052,7 @@ struct bpf_list_head {
 struct bpf_list_node {
 	__u64 :64;
 	__u64 :64;
+	__u64 :64;
 } __attribute__((aligned(8)));
=20
 struct bpf_rb_root {
@@ -7063,6 +7064,7 @@ struct bpf_rb_node {
 	__u64 :64;
 	__u64 :64;
 	__u64 :64;
+	__u64 :64;
 } __attribute__((aligned(8)));
=20
 struct bpf_refcount {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d564ff97de0b..bcff584985e7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1953,13 +1953,18 @@ static int __bpf_list_add(struct bpf_list_node_kern=
 *node,
 	 */
 	if (unlikely(!h->next))
 		INIT_LIST_HEAD(h);
-	if (!list_empty(n)) {
+
+	/* node->owner !=3D NULL implies !list_empty(n), no need to separately
+	 * check the latter
+	 */
+	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
 		/* Only called from BPF prog, no need to migrate_disable */
 		__bpf_obj_drop_impl((void *)n - off, rec);
 		return -EINVAL;
 	}
=20
 	tail ? list_add_tail(n, h) : list_add(n, h);
+	WRITE_ONCE(node->owner, head);
=20
 	return 0;
 }
@@ -1987,6 +1992,7 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_li=
st_head *head,
 static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bo=
ol tail)
 {
 	struct list_head *n, *h =3D (void *)head;
+	struct bpf_list_node_kern *node;
=20
 	/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
 	 * called on its fields, so init here
@@ -1995,8 +2001,14 @@ static struct bpf_list_node *__bpf_list_del(struct b=
pf_list_head *head, bool tai
 		INIT_LIST_HEAD(h);
 	if (list_empty(h))
 		return NULL;
+
 	n =3D tail ? h->prev : h->next;
+	node =3D container_of(n, struct bpf_list_node_kern, list_head);
+	if (WARN_ON_ONCE(READ_ONCE(node->owner) !=3D head))
+		return NULL;
+
 	list_del_init(n);
+	WRITE_ONCE(node->owner, NULL);
 	return (struct bpf_list_node *)n;
 }
=20
@@ -2013,14 +2025,19 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back=
(struct bpf_list_head *head)
 __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
 						  struct bpf_rb_node *node)
 {
+	struct bpf_rb_node_kern *node_internal =3D (struct bpf_rb_node_kern *)nod=
e;
 	struct rb_root_cached *r =3D (struct rb_root_cached *)root;
-	struct rb_node *n =3D &((struct bpf_rb_node_kern *)node)->rb_node;
+	struct rb_node *n =3D &node_internal->rb_node;
=20
-	if (RB_EMPTY_NODE(n))
+	/* node_internal->owner !=3D root implies either RB_EMPTY_NODE(n) or
+	 * n is owned by some other tree. No need to check RB_EMPTY_NODE(n)
+	 */
+	if (READ_ONCE(node_internal->owner) !=3D root)
 		return NULL;
=20
 	rb_erase_cached(n, r);
 	RB_CLEAR_NODE(n);
+	WRITE_ONCE(node_internal->owner, NULL);
 	return (struct bpf_rb_node *)n;
 }
=20
@@ -2036,7 +2053,10 @@ static int __bpf_rbtree_add(struct bpf_rb_root *root,
 	bpf_callback_t cb =3D (bpf_callback_t)less;
 	bool leftmost =3D true;
=20
-	if (!RB_EMPTY_NODE(n)) {
+	/* node->owner !=3D NULL implies !RB_EMPTY_NODE(n), no need to separately
+	 * check the latter
+	 */
+	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
 		/* Only called from BPF prog, no need to migrate_disable */
 		__bpf_obj_drop_impl((void *)n - off, rec);
 		return -EINVAL;
@@ -2054,6 +2074,7 @@ static int __bpf_rbtree_add(struct bpf_rb_root *root,
=20
 	rb_link_node(n, parent, link);
 	rb_insert_color_cached(n, (struct rb_root_cached *)root, leftmost);
+	WRITE_ONCE(node->owner, root);
 	return 0;
 }
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/t=
esting/selftests/bpf/prog_tests/linked_list.c
index f63309fd0e28..18cf7b17463d 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -23,7 +23,7 @@ static struct {
 	  "bpf_spin_lock at off=3D" #off " must be held for bpf_list_head" }, \
 	{ #test "_missing_lock_pop_back", \
 	  "bpf_spin_lock at off=3D" #off " must be held for bpf_list_head" },
-	TEST(kptr, 32)
+	TEST(kptr, 40)
 	TEST(global, 16)
 	TEST(map, 0)
 	TEST(inner_map, 0)
@@ -31,7 +31,7 @@ static struct {
 #define TEST(test, op) \
 	{ #test "_kptr_incorrect_lock_" #op, \
 	  "held lock and object are not in the same allocation\n" \
-	  "bpf_spin_lock at off=3D32 must be held for bpf_list_head" }, \
+	  "bpf_spin_lock at off=3D40 must be held for bpf_list_head" }, \
 	{ #test "_global_incorrect_lock_" #op, \
 	  "held lock and object are not in the same allocation\n" \
 	  "bpf_spin_lock at off=3D16 must be held for bpf_list_head" }, \
@@ -84,23 +84,23 @@ static struct {
 	{ "double_push_back", "arg#1 expected pointer to allocated object" },
 	{ "no_node_value_type", "bpf_list_node not found at offset=3D0" },
 	{ "incorrect_value_type",
-	  "operation on bpf_list_head expects arg#1 bpf_list_node at offset=3D40 =
in struct foo, "
+	  "operation on bpf_list_head expects arg#1 bpf_list_node at offset=3D48 =
in struct foo, "
 	  "but arg is at offset=3D0 in struct bar" },
 	{ "incorrect_node_var_off", "variable ptr_ access var_off=3D(0x0; 0xfffff=
fff) disallowed" },
-	{ "incorrect_node_off1", "bpf_list_node not found at offset=3D41" },
-	{ "incorrect_node_off2", "arg#1 offset=3D0, but expected bpf_list_node at=
 offset=3D40 in struct foo" },
+	{ "incorrect_node_off1", "bpf_list_node not found at offset=3D49" },
+	{ "incorrect_node_off2", "arg#1 offset=3D0, but expected bpf_list_node at=
 offset=3D48 in struct foo" },
 	{ "no_head_type", "bpf_list_head not found at offset=3D0" },
 	{ "incorrect_head_var_off1", "R1 doesn't have constant offset" },
 	{ "incorrect_head_var_off2", "variable ptr_ access var_off=3D(0x0; 0xffff=
ffff) disallowed" },
-	{ "incorrect_head_off1", "bpf_list_head not found at offset=3D17" },
+	{ "incorrect_head_off1", "bpf_list_head not found at offset=3D25" },
 	{ "incorrect_head_off2", "bpf_list_head not found at offset=3D1" },
 	{ "pop_front_off",
-	  "15: (bf) r1 =3D r6                      ; R1_w=3Dptr_or_null_foo(id=3D=
4,ref_obj_id=3D4,off=3D40,imm=3D0) "
-	  "R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D40,imm=3D0) refs=3D=
2,4\n"
+	  "15: (bf) r1 =3D r6                      ; R1_w=3Dptr_or_null_foo(id=3D=
4,ref_obj_id=3D4,off=3D48,imm=3D0) "
+	  "R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D=
2,4\n"
 	  "16: (85) call bpf_this_cpu_ptr#154\nR1 type=3Dptr_or_null_ expected=3D=
percpu_ptr_" },
 	{ "pop_back_off",
-	  "15: (bf) r1 =3D r6                      ; R1_w=3Dptr_or_null_foo(id=3D=
4,ref_obj_id=3D4,off=3D40,imm=3D0) "
-	  "R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D40,imm=3D0) refs=3D=
2,4\n"
+	  "15: (bf) r1 =3D r6                      ; R1_w=3Dptr_or_null_foo(id=3D=
4,ref_obj_id=3D4,off=3D48,imm=3D0) "
+	  "R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D=
2,4\n"
 	  "16: (85) call bpf_this_cpu_ptr#154\nR1 type=3Dptr_or_null_ expected=3D=
percpu_ptr_" },
 };
=20
@@ -257,7 +257,7 @@ static struct btf *init_btf(void)
 	hid =3D btf__add_struct(btf, "bpf_list_head", 16);
 	if (!ASSERT_EQ(hid, LIST_HEAD, "btf__add_struct bpf_list_head"))
 		goto end;
-	nid =3D btf__add_struct(btf, "bpf_list_node", 16);
+	nid =3D btf__add_struct(btf, "bpf_list_node", 24);
 	if (!ASSERT_EQ(nid, LIST_NODE, "btf__add_struct bpf_list_node"))
 		goto end;
 	return btf;
@@ -276,7 +276,7 @@ static void list_and_rb_node_same_struct(bool refcount_=
field)
 	if (!ASSERT_OK_PTR(btf, "init_btf"))
 		return;
=20
-	bpf_rb_node_btf_id =3D btf__add_struct(btf, "bpf_rb_node", 24);
+	bpf_rb_node_btf_id =3D btf__add_struct(btf, "bpf_rb_node", 32);
 	if (!ASSERT_GT(bpf_rb_node_btf_id, 0, "btf__add_struct bpf_rb_node"))
 		return;
=20
@@ -286,17 +286,17 @@ static void list_and_rb_node_same_struct(bool refcoun=
t_field)
 			return;
 	}
=20
-	id =3D btf__add_struct(btf, "bar", refcount_field ? 44 : 40);
+	id =3D btf__add_struct(btf, "bar", refcount_field ? 60 : 56);
 	if (!ASSERT_GT(id, 0, "btf__add_struct bar"))
 		return;
 	err =3D btf__add_field(btf, "a", LIST_NODE, 0, 0);
 	if (!ASSERT_OK(err, "btf__add_field bar::a"))
 		return;
-	err =3D btf__add_field(btf, "c", bpf_rb_node_btf_id, 128, 0);
+	err =3D btf__add_field(btf, "c", bpf_rb_node_btf_id, 192, 0);
 	if (!ASSERT_OK(err, "btf__add_field bar::c"))
 		return;
 	if (refcount_field) {
-		err =3D btf__add_field(btf, "ref", bpf_refcount_btf_id, 320, 0);
+		err =3D btf__add_field(btf, "ref", bpf_refcount_btf_id, 448, 0);
 		if (!ASSERT_OK(err, "btf__add_field bar::ref"))
 			return;
 	}
@@ -527,7 +527,7 @@ static void test_btf(void)
 		btf =3D init_btf();
 		if (!ASSERT_OK_PTR(btf, "init_btf"))
 			break;
-		id =3D btf__add_struct(btf, "foo", 36);
+		id =3D btf__add_struct(btf, "foo", 44);
 		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_HEAD, 0, 0);
@@ -536,7 +536,7 @@ static void test_btf(void)
 		err =3D btf__add_field(btf, "b", LIST_NODE, 128, 0);
 		if (!ASSERT_OK(err, "btf__add_field foo::b"))
 			break;
-		err =3D btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		err =3D btf__add_field(btf, "c", SPIN_LOCK, 320, 0);
 		if (!ASSERT_OK(err, "btf__add_field foo::c"))
 			break;
 		id =3D btf__add_decl_tag(btf, "contains:foo:b", 5, 0);
@@ -553,7 +553,7 @@ static void test_btf(void)
 		btf =3D init_btf();
 		if (!ASSERT_OK_PTR(btf, "init_btf"))
 			break;
-		id =3D btf__add_struct(btf, "foo", 36);
+		id =3D btf__add_struct(btf, "foo", 44);
 		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_HEAD, 0, 0);
@@ -562,13 +562,13 @@ static void test_btf(void)
 		err =3D btf__add_field(btf, "b", LIST_NODE, 128, 0);
 		if (!ASSERT_OK(err, "btf__add_field foo::b"))
 			break;
-		err =3D btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		err =3D btf__add_field(btf, "c", SPIN_LOCK, 320, 0);
 		if (!ASSERT_OK(err, "btf__add_field foo::c"))
 			break;
 		id =3D btf__add_decl_tag(btf, "contains:bar:b", 5, 0);
 		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:bar:b"))
 			break;
-		id =3D btf__add_struct(btf, "bar", 36);
+		id =3D btf__add_struct(btf, "bar", 44);
 		if (!ASSERT_EQ(id, 7, "btf__add_struct bar"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_HEAD, 0, 0);
@@ -577,7 +577,7 @@ static void test_btf(void)
 		err =3D btf__add_field(btf, "b", LIST_NODE, 128, 0);
 		if (!ASSERT_OK(err, "btf__add_field bar::b"))
 			break;
-		err =3D btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		err =3D btf__add_field(btf, "c", SPIN_LOCK, 320, 0);
 		if (!ASSERT_OK(err, "btf__add_field bar::c"))
 			break;
 		id =3D btf__add_decl_tag(btf, "contains:foo:b", 7, 0);
@@ -594,19 +594,19 @@ static void test_btf(void)
 		btf =3D init_btf();
 		if (!ASSERT_OK_PTR(btf, "init_btf"))
 			break;
-		id =3D btf__add_struct(btf, "foo", 20);
+		id =3D btf__add_struct(btf, "foo", 28);
 		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_HEAD, 0, 0);
 		if (!ASSERT_OK(err, "btf__add_field foo::a"))
 			break;
-		err =3D btf__add_field(btf, "b", SPIN_LOCK, 128, 0);
+		err =3D btf__add_field(btf, "b", SPIN_LOCK, 192, 0);
 		if (!ASSERT_OK(err, "btf__add_field foo::b"))
 			break;
 		id =3D btf__add_decl_tag(btf, "contains:bar:a", 5, 0);
 		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:bar:a"))
 			break;
-		id =3D btf__add_struct(btf, "bar", 16);
+		id =3D btf__add_struct(btf, "bar", 24);
 		if (!ASSERT_EQ(id, 7, "btf__add_struct bar"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_NODE, 0, 0);
@@ -623,19 +623,19 @@ static void test_btf(void)
 		btf =3D init_btf();
 		if (!ASSERT_OK_PTR(btf, "init_btf"))
 			break;
-		id =3D btf__add_struct(btf, "foo", 20);
+		id =3D btf__add_struct(btf, "foo", 28);
 		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_HEAD, 0, 0);
 		if (!ASSERT_OK(err, "btf__add_field foo::a"))
 			break;
-		err =3D btf__add_field(btf, "b", SPIN_LOCK, 128, 0);
+		err =3D btf__add_field(btf, "b", SPIN_LOCK, 192, 0);
 		if (!ASSERT_OK(err, "btf__add_field foo::b"))
 			break;
 		id =3D btf__add_decl_tag(btf, "contains:bar:b", 5, 0);
 		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:bar:b"))
 			break;
-		id =3D btf__add_struct(btf, "bar", 36);
+		id =3D btf__add_struct(btf, "bar", 44);
 		if (!ASSERT_EQ(id, 7, "btf__add_struct bar"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_HEAD, 0, 0);
@@ -644,13 +644,13 @@ static void test_btf(void)
 		err =3D btf__add_field(btf, "b", LIST_NODE, 128, 0);
 		if (!ASSERT_OK(err, "btf__add_field bar::b"))
 			break;
-		err =3D btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		err =3D btf__add_field(btf, "c", SPIN_LOCK, 320, 0);
 		if (!ASSERT_OK(err, "btf__add_field bar::c"))
 			break;
 		id =3D btf__add_decl_tag(btf, "contains:baz:a", 7, 0);
 		if (!ASSERT_EQ(id, 8, "btf__add_decl_tag contains:baz:a"))
 			break;
-		id =3D btf__add_struct(btf, "baz", 16);
+		id =3D btf__add_struct(btf, "baz", 24);
 		if (!ASSERT_EQ(id, 9, "btf__add_struct baz"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_NODE, 0, 0);
@@ -667,7 +667,7 @@ static void test_btf(void)
 		btf =3D init_btf();
 		if (!ASSERT_OK_PTR(btf, "init_btf"))
 			break;
-		id =3D btf__add_struct(btf, "foo", 36);
+		id =3D btf__add_struct(btf, "foo", 44);
 		if (!ASSERT_EQ(id, 5, "btf__add_struct foo"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_HEAD, 0, 0);
@@ -676,13 +676,13 @@ static void test_btf(void)
 		err =3D btf__add_field(btf, "b", LIST_NODE, 128, 0);
 		if (!ASSERT_OK(err, "btf__add_field foo::b"))
 			break;
-		err =3D btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		err =3D btf__add_field(btf, "c", SPIN_LOCK, 320, 0);
 		if (!ASSERT_OK(err, "btf__add_field foo::c"))
 			break;
 		id =3D btf__add_decl_tag(btf, "contains:bar:b", 5, 0);
 		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:bar:b"))
 			break;
-		id =3D btf__add_struct(btf, "bar", 36);
+		id =3D btf__add_struct(btf, "bar", 44);
 		if (!ASSERT_EQ(id, 7, "btf__add_struct bar"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_HEAD, 0, 0);
@@ -691,13 +691,13 @@ static void test_btf(void)
 		err =3D btf__add_field(btf, "b", LIST_NODE, 128, 0);
 		if (!ASSERT_OK(err, "btf__add_field bar:b"))
 			break;
-		err =3D btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		err =3D btf__add_field(btf, "c", SPIN_LOCK, 320, 0);
 		if (!ASSERT_OK(err, "btf__add_field bar:c"))
 			break;
 		id =3D btf__add_decl_tag(btf, "contains:baz:a", 7, 0);
 		if (!ASSERT_EQ(id, 8, "btf__add_decl_tag contains:baz:a"))
 			break;
-		id =3D btf__add_struct(btf, "baz", 16);
+		id =3D btf__add_struct(btf, "baz", 24);
 		if (!ASSERT_EQ(id, 9, "btf__add_struct baz"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_NODE, 0, 0);
@@ -726,7 +726,7 @@ static void test_btf(void)
 		id =3D btf__add_decl_tag(btf, "contains:bar:b", 5, 0);
 		if (!ASSERT_EQ(id, 6, "btf__add_decl_tag contains:bar:b"))
 			break;
-		id =3D btf__add_struct(btf, "bar", 36);
+		id =3D btf__add_struct(btf, "bar", 44);
 		if (!ASSERT_EQ(id, 7, "btf__add_struct bar"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_HEAD, 0, 0);
@@ -735,13 +735,13 @@ static void test_btf(void)
 		err =3D btf__add_field(btf, "b", LIST_NODE, 128, 0);
 		if (!ASSERT_OK(err, "btf__add_field bar::b"))
 			break;
-		err =3D btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		err =3D btf__add_field(btf, "c", SPIN_LOCK, 320, 0);
 		if (!ASSERT_OK(err, "btf__add_field bar::c"))
 			break;
 		id =3D btf__add_decl_tag(btf, "contains:baz:b", 7, 0);
 		if (!ASSERT_EQ(id, 8, "btf__add_decl_tag"))
 			break;
-		id =3D btf__add_struct(btf, "baz", 36);
+		id =3D btf__add_struct(btf, "baz", 44);
 		if (!ASSERT_EQ(id, 9, "btf__add_struct baz"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_HEAD, 0, 0);
@@ -750,13 +750,13 @@ static void test_btf(void)
 		err =3D btf__add_field(btf, "b", LIST_NODE, 128, 0);
 		if (!ASSERT_OK(err, "btf__add_field bar::b"))
 			break;
-		err =3D btf__add_field(btf, "c", SPIN_LOCK, 256, 0);
+		err =3D btf__add_field(btf, "c", SPIN_LOCK, 320, 0);
 		if (!ASSERT_OK(err, "btf__add_field bar::c"))
 			break;
 		id =3D btf__add_decl_tag(btf, "contains:bam:a", 9, 0);
 		if (!ASSERT_EQ(id, 10, "btf__add_decl_tag contains:bam:a"))
 			break;
-		id =3D btf__add_struct(btf, "bam", 16);
+		id =3D btf__add_struct(btf, "bam", 24);
 		if (!ASSERT_EQ(id, 11, "btf__add_struct bam"))
 			break;
 		err =3D btf__add_field(btf, "a", LIST_NODE, 0, 0);
--=20
2.34.1


