Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A06DCB50
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 21:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjDJTJF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 15:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDJTJE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 15:09:04 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B848170B
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:09:02 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33AJ0RvC007381
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:09:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=RgGKMyY6RwCophLREc9PwtK523q5z+hOeq/NaCbv5Bs=;
 b=qgGvUisn5WIp73wJqkL+XPqWiOnGemeoWCQfJkQRtzHLpstzyhWK1Na03qQ/5RxfDQfN
 dDPWJngf49KZBYG5Kmxq3sElHrhNpzXgxEAfnjQgkfz931f/W9D50lQnvItLssMbAtrM
 SDHrAvAD0xok4D5cFXbtQcRTjHeJA/JxIWo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3pvdugkk0b-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:09:01 -0700
Received: from twshared21709.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 10 Apr 2023 12:08:59 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 6158F1BB3FD03; Mon, 10 Apr 2023 12:08:46 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 9/9] selftests/bpf: Add refcounted_kptr tests
Date:   Mon, 10 Apr 2023 12:07:53 -0700
Message-ID: <20230410190753.2012798-10-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410190753.2012798-1-davemarchevsky@fb.com>
References: <20230410190753.2012798-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: g32SAtVWyG1IcXJqjG_bKJZ9WUPMJ_ho
X-Proofpoint-ORIG-GUID: g32SAtVWyG1IcXJqjG_bKJZ9WUPMJ_ho
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

Test refcounted local kptr functionality added in previous patches in
the series.

Usecases which pass verification:

* Add refcounted local kptr to both tree and list. Then, read and -
  possibly, depending on test variant - delete from tree, then list.
  * Also test doing read-and-maybe-delete in opposite order
* Stash a refcounted local kptr in a map_value, then add it to a
  rbtree. Read from both, possibly deleting after tree read.
* Add refcounted local kptr to both tree and list. Then, try reading and
  deleting twice from one of the collections.
* bpf_refcount_acquire of just-added non-owning ref should work, as
  should bpf_refcount_acquire of owning ref just out of bpf_obj_new

Usecases which fail verification:

* The simple successful bpf_refcount_acquire cases from above should
  both fail to verify if the newly-acquired owning ref is not dropped

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../bpf/prog_tests/refcounted_kptr.c          |  18 +
 .../selftests/bpf/progs/refcounted_kptr.c     | 410 ++++++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          |  72 +++
 3 files changed, 500 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/refcounted_kpt=
r.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_fai=
l.c

diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/t=
ools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
new file mode 100644
index 000000000000..2ab23832062d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "refcounted_kptr.skel.h"
+#include "refcounted_kptr_fail.skel.h"
+
+void test_refcounted_kptr(void)
+{
+	RUN_TESTS(refcounted_kptr);
+}
+
+void test_refcounted_kptr_fail(void)
+{
+	RUN_TESTS(refcounted_kptr_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/=
testing/selftests/bpf/progs/refcounted_kptr.c
new file mode 100644
index 000000000000..b444e4cb07fb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+struct node_data {
+	long key;
+	long list_data;
+	struct bpf_rb_node r;
+	struct bpf_list_node l;
+	struct bpf_refcount ref;
+};
+
+struct map_value {
+	struct node_data __kptr *node;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} stashed_nodes SEC(".maps");
+
+struct node_acquire {
+	long key;
+	long data;
+	struct bpf_rb_node node;
+	struct bpf_refcount refcount;
+};
+
+#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned=
(8)))
+private(A) struct bpf_spin_lock lock;
+private(A) struct bpf_rb_root root __contains(node_data, r);
+private(A) struct bpf_list_head head __contains(node_data, l);
+
+private(B) struct bpf_spin_lock alock;
+private(B) struct bpf_rb_root aroot __contains(node_acquire, node);
+
+static bool less(struct bpf_rb_node *node_a, const struct bpf_rb_node *n=
ode_b)
+{
+	struct node_data *a;
+	struct node_data *b;
+
+	a =3D container_of(node_a, struct node_data, r);
+	b =3D container_of(node_b, struct node_data, r);
+
+	return a->key < b->key;
+}
+
+static bool less_a(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct node_acquire *node_a;
+	struct node_acquire *node_b;
+
+	node_a =3D container_of(a, struct node_acquire, node);
+	node_b =3D container_of(b, struct node_acquire, node);
+
+	return node_a->key < node_b->key;
+}
+
+static __always_inline
+long __insert_in_tree_and_list(struct bpf_list_head *head,
+			       struct bpf_rb_root *root,
+			       struct bpf_spin_lock *lock)
+{
+	struct node_data *n, *m;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return -1;
+
+	m =3D bpf_refcount_acquire(n);
+	m->key =3D 123;
+	m->list_data =3D 456;
+
+	bpf_spin_lock(lock);
+	if (bpf_rbtree_add(root, &n->r, less)) {
+		/* Failure to insert - unexpected */
+		bpf_spin_unlock(lock);
+		bpf_obj_drop(m);
+		return -2;
+	}
+	bpf_spin_unlock(lock);
+
+	bpf_spin_lock(lock);
+	if (bpf_list_push_front(head, &m->l)) {
+		/* Failure to insert - unexpected */
+		bpf_spin_unlock(lock);
+		return -3;
+	}
+	bpf_spin_unlock(lock);
+	return 0;
+}
+
+static __always_inline
+long __stash_map_insert_tree(int idx, int val, struct bpf_rb_root *root,
+			     struct bpf_spin_lock *lock)
+{
+	struct map_value *mapval;
+	struct node_data *n, *m;
+
+	mapval =3D bpf_map_lookup_elem(&stashed_nodes, &idx);
+	if (!mapval)
+		return -1;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return -2;
+
+	n->key =3D val;
+	m =3D bpf_refcount_acquire(n);
+
+	n =3D bpf_kptr_xchg(&mapval->node, n);
+	if (n) {
+		bpf_obj_drop(n);
+		bpf_obj_drop(m);
+		return -3;
+	}
+
+	bpf_spin_lock(lock);
+	if (bpf_rbtree_add(root, &m->r, less)) {
+		/* Failure to insert - unexpected */
+		bpf_spin_unlock(lock);
+		return -4;
+	}
+	bpf_spin_unlock(lock);
+	return 0;
+}
+
+static __always_inline
+long __read_from_tree(struct bpf_rb_root *root, struct bpf_spin_lock *lo=
ck,
+		      bool remove_from_tree)
+{
+	struct bpf_rb_node *rb;
+	struct node_data *n;
+	long res =3D -99;
+
+	bpf_spin_lock(lock);
+
+	rb =3D bpf_rbtree_first(root);
+	if (!rb) {
+		bpf_spin_unlock(lock);
+		return -1;
+	}
+
+	n =3D container_of(rb, struct node_data, r);
+	res =3D n->key;
+
+	if (!remove_from_tree) {
+		bpf_spin_unlock(lock);
+		return res;
+	}
+
+	rb =3D bpf_rbtree_remove(root, rb);
+	bpf_spin_unlock(lock);
+	if (!rb) {
+		return -2;
+	}
+	n =3D container_of(rb, struct node_data, r);
+	bpf_obj_drop(n);
+	return res;
+}
+
+static __always_inline
+long __read_from_list(struct bpf_list_head *head, struct bpf_spin_lock *=
lock,
+		      bool remove_from_list)
+{
+	struct bpf_list_node *l;
+	struct node_data *n;
+	long res =3D -99;
+
+	bpf_spin_lock(lock);
+
+	l =3D bpf_list_pop_front(head);
+	if (!l) {
+		bpf_spin_unlock(lock);
+		return -1;
+	}
+
+	n =3D container_of(l, struct node_data, l);
+	res =3D n->list_data;
+
+	if (!remove_from_list) {
+		if (bpf_list_push_back(head, &n->l)) {
+			bpf_spin_unlock(lock);
+			return -2;
+		}
+	}
+
+	bpf_spin_unlock(lock);
+
+	if (remove_from_list)
+		bpf_obj_drop(n);
+	return res;
+}
+
+static __always_inline
+long __read_from_unstash(int idx)
+{
+	struct node_data *n =3D NULL;
+	struct map_value *mapval;
+	long val =3D -99;
+
+	mapval =3D bpf_map_lookup_elem(&stashed_nodes, &idx);
+	if (!mapval)
+		return -1;
+
+	n =3D bpf_kptr_xchg(&mapval->node, n);
+	if (!n)
+		return -2;
+
+	val =3D n->key;
+	bpf_obj_drop(n);
+	return val;
+}
+
+#define INSERT_READ_BOTH(rem_tree, rem_list, desc)			\
+SEC("tc")								\
+__description(desc)							\
+__success __retval(579)							\
+long insert_and_remove_tree_##rem_tree##_list_##rem_list(void *ctx)	\
+{									\
+	long err, tree_data, list_data;					\
+									\
+	err =3D __insert_in_tree_and_list(&head, &root, &lock);		\
+	if (err)							\
+		return err;						\
+									\
+	err =3D __read_from_tree(&root, &lock, rem_tree);			\
+	if (err < 0)							\
+		return err;						\
+	else								\
+		tree_data =3D err;					\
+									\
+	err =3D __read_from_list(&head, &lock, rem_list);			\
+	if (err < 0)							\
+		return err;						\
+	else								\
+		list_data =3D err;					\
+									\
+	return tree_data + list_data;					\
+}
+
+/* After successful insert of struct node_data into both collections:
+ *   - it should have refcount =3D 2
+ *   - removing / not removing the node_data from a collection after
+ *     reading should have no effect on ability to read / remove from
+ *     the other collection
+ */
+INSERT_READ_BOTH(true, true, "insert_read_both: remove from tree + list"=
);
+INSERT_READ_BOTH(false, false, "insert_read_both: remove from neither");
+INSERT_READ_BOTH(true, false, "insert_read_both: remove from tree");
+INSERT_READ_BOTH(false, true, "insert_read_both: remove from list");
+
+#undef INSERT_READ_BOTH
+#define INSERT_READ_BOTH(rem_tree, rem_list, desc)			\
+SEC("tc")								\
+__description(desc)							\
+__success __retval(579)							\
+long insert_and_remove_lf_tree_##rem_tree##_list_##rem_list(void *ctx)	\
+{									\
+	long err, tree_data, list_data;					\
+									\
+	err =3D __insert_in_tree_and_list(&head, &root, &lock);		\
+	if (err)							\
+		return err;						\
+									\
+	err =3D __read_from_list(&head, &lock, rem_list);			\
+	if (err < 0)							\
+		return err;						\
+	else								\
+		list_data =3D err;					\
+									\
+	err =3D __read_from_tree(&root, &lock, rem_tree);			\
+	if (err < 0)							\
+		return err;						\
+	else								\
+		tree_data =3D err;					\
+									\
+	return tree_data + list_data;					\
+}
+
+/* Similar to insert_read_both, but list data is read and possibly remov=
ed
+ * first
+ *
+ * Results should be no different than reading and possibly removing rbt=
ree
+ * node first
+ */
+INSERT_READ_BOTH(true, true, "insert_read_both_list_first: remove from t=
ree + list");
+INSERT_READ_BOTH(false, false, "insert_read_both_list_first: remove from=
 neither");
+INSERT_READ_BOTH(true, false, "insert_read_both_list_first: remove from =
tree");
+INSERT_READ_BOTH(false, true, "insert_read_both_list_first: remove from =
list");
+
+#define INSERT_DOUBLE_READ_AND_DEL(read_fn, read_root, desc)		\
+SEC("tc")								\
+__description(desc)							\
+__success __retval(-1)							\
+long insert_double_##read_fn##_and_del_##read_root(void *ctx)		\
+{									\
+	long err, list_data;						\
+									\
+	err =3D __insert_in_tree_and_list(&head, &root, &lock);		\
+	if (err)							\
+		return err;						\
+									\
+	err =3D read_fn(&read_root, &lock, true);				\
+	if (err < 0)							\
+		return err;						\
+	else								\
+		list_data =3D err;					\
+									\
+	err =3D read_fn(&read_root, &lock, true);				\
+	if (err < 0)							\
+		return err;						\
+									\
+	return err + list_data;						\
+}
+
+/* Insert into both tree and list, then try reading-and-removing from ei=
ther twice
+ *
+ * The second read-and-remove should fail on read step since the node ha=
s
+ * already been removed
+ */
+INSERT_DOUBLE_READ_AND_DEL(__read_from_tree, root, "insert_double_del: 2=
x read-and-del from tree");
+INSERT_DOUBLE_READ_AND_DEL(__read_from_list, head, "insert_double_del: 2=
x read-and-del from list");
+
+#define INSERT_STASH_READ(rem_tree, desc)				\
+SEC("tc")								\
+__description(desc)							\
+__success __retval(84)							\
+long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)		\
+{									\
+	long err, tree_data, map_data;					\
+									\
+	err =3D __stash_map_insert_tree(0, 42, &root, &lock);		\
+	if (err)							\
+		return err;						\
+									\
+	err =3D __read_from_tree(&root, &lock, rem_tree);			\
+	if (err < 0)							\
+		return err;						\
+	else								\
+		tree_data =3D err;					\
+									\
+	err =3D __read_from_unstash(0);					\
+	if (err < 0)							\
+		return err;						\
+	else								\
+		map_data =3D err;						\
+									\
+	return tree_data + map_data;					\
+}
+
+/* Stash a refcounted node in map_val, insert same node into tree, then =
try
+ * reading data from tree then unstashed map_val, possibly removing from=
 tree
+ *
+ * Removing from tree should have no effect on map_val kptr validity
+ */
+INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
+INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
+
+SEC("tc")
+__success
+long rbtree_refcounted_node_ref_escapes(void *ctx)
+{
+	struct node_acquire *n, *m;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	bpf_spin_lock(&alock);
+	bpf_rbtree_add(&aroot, &n->node, less_a);
+	m =3D bpf_refcount_acquire(n);
+	bpf_spin_unlock(&alock);
+
+	m->key =3D 2;
+	bpf_obj_drop(m);
+	return 0;
+}
+
+SEC("tc")
+__success
+long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
+{
+	struct node_acquire *n, *m;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	m =3D bpf_refcount_acquire(n);
+	m->key =3D 2;
+
+	bpf_spin_lock(&alock);
+	bpf_rbtree_add(&aroot, &n->node, less_a);
+	bpf_spin_unlock(&alock);
+
+	bpf_obj_drop(m);
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/t=
ools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
new file mode 100644
index 000000000000..efcb308f80ad
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+struct node_acquire {
+	long key;
+	long data;
+	struct bpf_rb_node node;
+	struct bpf_refcount refcount;
+};
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligne=
d(8)))
+private(A) struct bpf_spin_lock glock;
+private(A) struct bpf_rb_root groot __contains(node_acquire, node);
+
+static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct node_acquire *node_a;
+	struct node_acquire *node_b;
+
+	node_a =3D container_of(a, struct node_acquire, node);
+	node_b =3D container_of(b, struct node_acquire, node);
+
+	return node_a->key < node_b->key;
+}
+
+SEC("?tc")
+__failure __msg("Unreleased reference id=3D3 alloc_insn=3D21")
+long rbtree_refcounted_node_ref_escapes(void *ctx)
+{
+	struct node_acquire *n, *m;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less);
+	/* m becomes an owning ref but is never drop'd or added to a tree */
+	m =3D bpf_refcount_acquire(n);
+	bpf_spin_unlock(&glock);
+
+	m->key =3D 2;
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("Unreleased reference id=3D3 alloc_insn=3D9")
+long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
+{
+	struct node_acquire *n, *m;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	/* m becomes an owning ref but is never drop'd or added to a tree */
+	m =3D bpf_refcount_acquire(n);
+	m->key =3D 2;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less);
+	bpf_spin_unlock(&glock);
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1

