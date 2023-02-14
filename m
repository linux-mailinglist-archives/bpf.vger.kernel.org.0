Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2F7695587
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 01:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBNArz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 19:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBNAry (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 19:47:54 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CED0AD08
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 16:47:51 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DLuIOM013611
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 16:47:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=tO5denjBGJAyniLednS49uu0FyAgzlZ9NRi/Zz/zjgE=;
 b=FMA3YHIRdjQVosOfg1xWf0phIEGN8FD9Y0GVpcqOq94Dkq+xiJYSw1k08wcyzz70/ERI
 CeOzJhlBiw2RCMsjAuindxndbpLHALyp4XAC+m8L+9ytznRkRSjpOSef9Ijx2LwKDllc
 h3sJlgI9nwTKLEKqP7MFgdmV8AZXjVjXoYY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3np9e5gapp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 16:47:50 -0800
Received: from twshared24176.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 13 Feb 2023 16:47:49 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 127ED16ED5DA8; Mon, 13 Feb 2023 16:40:34 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v6 bpf-next 7/8] selftests/bpf: Add rbtree selftests
Date:   Mon, 13 Feb 2023 16:40:16 -0800
Message-ID: <20230214004017.2534011-8-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230214004017.2534011-1-davemarchevsky@fb.com>
References: <20230214004017.2534011-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fd5IMBbDfdFPMhkC2A0qNAZvV3MKO5ZN
X-Proofpoint-ORIG-GUID: fd5IMBbDfdFPMhkC2A0qNAZvV3MKO5ZN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds selftests exercising the logic changed/added in the
previous patches in the series. A variety of successful and unsuccessful
rbtree usages are validated:

Success:
  * Add some nodes, let map_value bpf_rbtree_root destructor clean them
    up
  * Add some nodes, remove one using the non-owning ref leftover by
    successful rbtree_add() call
  * Add some nodes, remove one using the non-owning ref returned by
    rbtree_first() call

Failure:
  * BTF where bpf_rb_root owns bpf_list_node should fail to load
  * BTF where node of type X is added to tree containing nodes of type Y
    should fail to load
  * No calling rbtree api functions in 'less' callback for rbtree_add
  * No releasing lock in 'less' callback for rbtree_add
  * No removing a node which hasn't been added to any tree
  * No adding a node which has already been added to a tree
  * No escaping of non-owning references past their lock's
    critical section
  * No escaping of non-owning references past other invalidation points
    (rbtree_remove)

These tests mostly focus on rbtree-specific additions, but some of the
failure cases revalidate scenarios common to both linked_list and rbtree
which are covered in the former's tests. Better to be a bit redundant in
case linked_list and rbtree semantics deviate over time.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../testing/selftests/bpf/prog_tests/rbtree.c | 117 +++++++
 tools/testing/selftests/bpf/progs/rbtree.c    | 176 ++++++++++
 .../progs/rbtree_btf_fail__add_wrong_type.c   |  52 +++
 .../progs/rbtree_btf_fail__wrong_node_type.c  |  49 +++
 .../testing/selftests/bpf/progs/rbtree_fail.c | 322 ++++++++++++++++++
 5 files changed, 716 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rbtree.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_btf_fail__ad=
d_wrong_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_btf_fail__wr=
ong_node_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/rbtree.c b/tools/test=
ing/selftests/bpf/prog_tests/rbtree.c
new file mode 100644
index 000000000000..156fa95c42f6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rbtree.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "rbtree.skel.h"
+#include "rbtree_fail.skel.h"
+#include "rbtree_btf_fail__wrong_node_type.skel.h"
+#include "rbtree_btf_fail__add_wrong_type.skel.h"
+
+static void test_rbtree_add_nodes(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in =3D &pkt_v4,
+		    .data_size_in =3D sizeof(pkt_v4),
+		    .repeat =3D 1,
+	);
+	struct rbtree *skel;
+	int ret;
+
+	skel =3D rbtree__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "rbtree__open_and_load"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_add_n=
odes), &opts);
+	ASSERT_OK(ret, "rbtree_add_nodes run");
+	ASSERT_OK(opts.retval, "rbtree_add_nodes retval");
+	ASSERT_EQ(skel->data->less_callback_ran, 1, "rbtree_add_nodes less_call=
back_ran");
+
+	rbtree__destroy(skel);
+}
+
+static void test_rbtree_add_and_remove(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in =3D &pkt_v4,
+		    .data_size_in =3D sizeof(pkt_v4),
+		    .repeat =3D 1,
+	);
+	struct rbtree *skel;
+	int ret;
+
+	skel =3D rbtree__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "rbtree__open_and_load"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_add_a=
nd_remove), &opts);
+	ASSERT_OK(ret, "rbtree_add_and_remove");
+	ASSERT_OK(opts.retval, "rbtree_add_and_remove retval");
+	ASSERT_EQ(skel->data->removed_key, 5, "rbtree_add_and_remove first remo=
ved key");
+
+	rbtree__destroy(skel);
+}
+
+static void test_rbtree_first_and_remove(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in =3D &pkt_v4,
+		    .data_size_in =3D sizeof(pkt_v4),
+		    .repeat =3D 1,
+	);
+	struct rbtree *skel;
+	int ret;
+
+	skel =3D rbtree__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "rbtree__open_and_load"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_first=
_and_remove), &opts);
+	ASSERT_OK(ret, "rbtree_first_and_remove");
+	ASSERT_OK(opts.retval, "rbtree_first_and_remove retval");
+	ASSERT_EQ(skel->data->first_data[0], 2, "rbtree_first_and_remove first =
rbtree_first()");
+	ASSERT_EQ(skel->data->removed_key, 1, "rbtree_first_and_remove first re=
moved key");
+	ASSERT_EQ(skel->data->first_data[1], 4, "rbtree_first_and_remove second=
 rbtree_first()");
+
+	rbtree__destroy(skel);
+}
+
+void test_rbtree_success(void)
+{
+	if (test__start_subtest("rbtree_add_nodes"))
+		test_rbtree_add_nodes();
+	if (test__start_subtest("rbtree_add_and_remove"))
+		test_rbtree_add_and_remove();
+	if (test__start_subtest("rbtree_first_and_remove"))
+		test_rbtree_first_and_remove();
+}
+
+#define BTF_FAIL_TEST(suffix)									\
+void test_rbtree_btf_fail__##suffix(void)							\
+{												\
+	struct rbtree_btf_fail__##suffix *skel;							\
+												\
+	skel =3D rbtree_btf_fail__##suffix##__open_and_load();					\
+	if (!ASSERT_ERR_PTR(skel,								\
+			    "rbtree_btf_fail__" #suffix "__open_and_load unexpected success")=
)	\
+		rbtree_btf_fail__##suffix##__destroy(skel);					\
+}
+
+#define RUN_BTF_FAIL_TEST(suffix)				\
+	if (test__start_subtest("rbtree_btf_fail__" #suffix))	\
+		test_rbtree_btf_fail__##suffix();
+
+BTF_FAIL_TEST(wrong_node_type);
+BTF_FAIL_TEST(add_wrong_type);
+
+void test_rbtree_btf_fail(void)
+{
+	RUN_BTF_FAIL_TEST(wrong_node_type);
+	RUN_BTF_FAIL_TEST(add_wrong_type);
+}
+
+void test_rbtree_fail(void)
+{
+	RUN_TESTS(rbtree_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/rbtree.c b/tools/testing/s=
elftests/bpf/progs/rbtree.c
new file mode 100644
index 000000000000..e5db1a4287e5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rbtree.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+
+struct node_data {
+	long key;
+	long data;
+	struct bpf_rb_node node;
+};
+
+long less_callback_ran =3D -1;
+long removed_key =3D -1;
+long first_data[2] =3D {-1, -1};
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligne=
d(8)))
+private(A) struct bpf_spin_lock glock;
+private(A) struct bpf_rb_root groot __contains(node_data, node);
+
+static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a =3D container_of(a, struct node_data, node);
+	node_b =3D container_of(b, struct node_data, node);
+	less_callback_ran =3D 1;
+
+	return node_a->key < node_b->key;
+}
+
+static long __add_three(struct bpf_rb_root *root, struct bpf_spin_lock *=
lock)
+{
+	struct node_data *n, *m;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+	n->key =3D 5;
+
+	m =3D bpf_obj_new(typeof(*m));
+	if (!m) {
+		bpf_obj_drop(n);
+		return 2;
+	}
+	m->key =3D 1;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less);
+	bpf_rbtree_add(&groot, &m->node, less);
+	bpf_spin_unlock(&glock);
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 3;
+	n->key =3D 3;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less);
+	bpf_spin_unlock(&glock);
+	return 0;
+}
+
+SEC("tc")
+long rbtree_add_nodes(void *ctx)
+{
+	return __add_three(&groot, &glock);
+}
+
+SEC("tc")
+long rbtree_add_and_remove(void *ctx)
+{
+	struct bpf_rb_node *res =3D NULL;
+	struct node_data *n, *m;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		goto err_out;
+	n->key =3D 5;
+
+	m =3D bpf_obj_new(typeof(*m));
+	if (!m)
+		goto err_out;
+	m->key =3D 3;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less);
+	bpf_rbtree_add(&groot, &m->node, less);
+	res =3D bpf_rbtree_remove(&groot, &n->node);
+	bpf_spin_unlock(&glock);
+
+	n =3D container_of(res, struct node_data, node);
+	removed_key =3D n->key;
+
+	bpf_obj_drop(n);
+
+	return 0;
+err_out:
+	if (n)
+		bpf_obj_drop(n);
+	if (m)
+		bpf_obj_drop(m);
+	return 1;
+}
+
+SEC("tc")
+long rbtree_first_and_remove(void *ctx)
+{
+	struct bpf_rb_node *res =3D NULL;
+	struct node_data *n, *m, *o;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+	n->key =3D 3;
+	n->data =3D 4;
+
+	m =3D bpf_obj_new(typeof(*m));
+	if (!m)
+		goto err_out;
+	m->key =3D 5;
+	m->data =3D 6;
+
+	o =3D bpf_obj_new(typeof(*o));
+	if (!o)
+		goto err_out;
+	o->key =3D 1;
+	o->data =3D 2;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less);
+	bpf_rbtree_add(&groot, &m->node, less);
+	bpf_rbtree_add(&groot, &o->node, less);
+
+	res =3D bpf_rbtree_first(&groot);
+	if (!res) {
+		bpf_spin_unlock(&glock);
+		return 2;
+	}
+
+	o =3D container_of(res, struct node_data, node);
+	first_data[0] =3D o->data;
+
+	res =3D bpf_rbtree_remove(&groot, &o->node);
+	bpf_spin_unlock(&glock);
+
+	o =3D container_of(res, struct node_data, node);
+	removed_key =3D o->key;
+
+	bpf_obj_drop(o);
+
+	bpf_spin_lock(&glock);
+	res =3D bpf_rbtree_first(&groot);
+	if (!res) {
+		bpf_spin_unlock(&glock);
+		return 3;
+	}
+
+	o =3D container_of(res, struct node_data, node);
+	first_data[1] =3D o->data;
+	bpf_spin_unlock(&glock);
+
+	return 0;
+err_out:
+	if (n)
+		bpf_obj_drop(n);
+	if (m)
+		bpf_obj_drop(m);
+	return 1;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/rbtree_btf_fail__add_wrong=
_type.c b/tools/testing/selftests/bpf/progs/rbtree_btf_fail__add_wrong_ty=
pe.c
new file mode 100644
index 000000000000..60079b202c07
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rbtree_btf_fail__add_wrong_type.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+
+struct node_data {
+	int key;
+	int data;
+	struct bpf_rb_node node;
+};
+
+struct node_data2 {
+	int key;
+	struct bpf_rb_node node;
+	int data;
+};
+
+static bool less2(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct node_data2 *node_a;
+	struct node_data2 *node_b;
+
+	node_a =3D container_of(a, struct node_data2, node);
+	node_b =3D container_of(b, struct node_data2, node);
+
+	return node_a->key < node_b->key;
+}
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligne=
d(8)))
+private(A) struct bpf_spin_lock glock;
+private(A) struct bpf_rb_root groot __contains(node_data, node);
+
+SEC("tc")
+long rbtree_api_add__add_wrong_type(void *ctx)
+{
+	struct node_data2 *n;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less2);
+	bpf_spin_unlock(&glock);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/rbtree_btf_fail__wrong_nod=
e_type.c b/tools/testing/selftests/bpf/progs/rbtree_btf_fail__wrong_node_=
type.c
new file mode 100644
index 000000000000..340f97da1084
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rbtree_btf_fail__wrong_node_type.=
c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+
+/* BTF load should fail as bpf_rb_root __contains this type and points t=
o
+ * 'node', but 'node' is not a bpf_rb_node
+ */
+struct node_data {
+	int key;
+	int data;
+	struct bpf_list_node node;
+};
+
+static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a =3D container_of(a, struct node_data, node);
+	node_b =3D container_of(b, struct node_data, node);
+
+	return node_a->key < node_b->key;
+}
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligne=
d(8)))
+private(A) struct bpf_spin_lock glock;
+private(A) struct bpf_rb_root groot __contains(node_data, node);
+
+SEC("tc")
+long rbtree_api_add__wrong_node_type(void *ctx)
+{
+	struct node_data *n;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_first(&groot);
+	bpf_spin_unlock(&glock);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/test=
ing/selftests/bpf/progs/rbtree_fail.c
new file mode 100644
index 000000000000..bf3cba115897
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+struct node_data {
+	long key;
+	long data;
+	struct bpf_rb_node node;
+};
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligne=
d(8)))
+private(A) struct bpf_spin_lock glock;
+private(A) struct bpf_rb_root groot __contains(node_data, node);
+private(A) struct bpf_rb_root groot2 __contains(node_data, node);
+
+static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a =3D container_of(a, struct node_data, node);
+	node_b =3D container_of(b, struct node_data, node);
+
+	return node_a->key < node_b->key;
+}
+
+SEC("?tc")
+__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_root"=
)
+long rbtree_api_nolock_add(void *ctx)
+{
+	struct node_data *n;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	bpf_rbtree_add(&groot, &n->node, less);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_root"=
)
+long rbtree_api_nolock_remove(void *ctx)
+{
+	struct node_data *n;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less);
+	bpf_spin_unlock(&glock);
+
+	bpf_rbtree_remove(&groot, &n->node);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_root"=
)
+long rbtree_api_nolock_first(void *ctx)
+{
+	bpf_rbtree_first(&groot);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("rbtree_remove node input must be non-owning ref")
+long rbtree_api_remove_unadded_node(void *ctx)
+{
+	struct node_data *n, *m;
+	struct bpf_rb_node *res;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	m =3D bpf_obj_new(typeof(*m));
+	if (!m) {
+		bpf_obj_drop(n);
+		return 1;
+	}
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less);
+
+	/* This remove should pass verifier */
+	res =3D bpf_rbtree_remove(&groot, &n->node);
+	n =3D container_of(res, struct node_data, node);
+
+	/* This remove shouldn't, m isn't in an rbtree */
+	res =3D bpf_rbtree_remove(&groot, &m->node);
+	m =3D container_of(res, struct node_data, node);
+	bpf_spin_unlock(&glock);
+
+	if (n)
+		bpf_obj_drop(n);
+	if (m)
+		bpf_obj_drop(m);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("Unreleased reference id=3D2 alloc_insn=3D11")
+long rbtree_api_remove_no_drop(void *ctx)
+{
+	struct bpf_rb_node *res;
+	struct node_data *n;
+
+	bpf_spin_lock(&glock);
+	res =3D bpf_rbtree_first(&groot);
+	if (!res)
+		goto unlock_err;
+
+	res =3D bpf_rbtree_remove(&groot, res);
+
+	n =3D container_of(res, struct node_data, node);
+	bpf_spin_unlock(&glock);
+
+	/* bpf_obj_drop(n) is missing here */
+	return 0;
+
+unlock_err:
+	bpf_spin_unlock(&glock);
+	return 1;
+}
+
+SEC("?tc")
+__failure __msg("arg#1 expected pointer to allocated object")
+long rbtree_api_add_to_multiple_trees(void *ctx)
+{
+	struct node_data *n;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less);
+
+	/* This add should fail since n already in groot's tree */
+	bpf_rbtree_add(&groot2, &n->node, less);
+	bpf_spin_unlock(&glock);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("rbtree_remove node input must be non-owning ref")
+long rbtree_api_add_release_unlock_escape(void *ctx)
+{
+	struct node_data *n;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less);
+	bpf_spin_unlock(&glock);
+
+	bpf_spin_lock(&glock);
+	/* After add() in previous critical section, n should be
+	 * release_on_unlock and released after previous spin_unlock,
+	 * so should not be possible to use it here
+	 */
+	bpf_rbtree_remove(&groot, &n->node);
+	bpf_spin_unlock(&glock);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("rbtree_remove node input must be non-owning ref")
+long rbtree_api_release_aliasing(void *ctx)
+{
+	struct node_data *n, *m, *o;
+	struct bpf_rb_node *res;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, less);
+	bpf_spin_unlock(&glock);
+
+	bpf_spin_lock(&glock);
+
+	/* m and o point to the same node,
+	 * but verifier doesn't know this
+	 */
+	res =3D bpf_rbtree_first(&groot);
+	if (!res)
+		return 1;
+	o =3D container_of(res, struct node_data, node);
+
+	res =3D bpf_rbtree_first(&groot);
+	if (!res)
+		return 1;
+	m =3D container_of(res, struct node_data, node);
+
+	bpf_rbtree_remove(&groot, &m->node);
+	/* This second remove shouldn't be possible. Retval of previous
+	 * remove returns owning reference to m, which is the same
+	 * node o's non-owning ref is pointing at
+	 *
+	 * In order to preserve property
+	 *   * owning ref must not be in rbtree
+	 *   * non-owning ref must be in rbtree
+	 *
+	 * o's ref must be invalidated after previous remove. Otherwise
+	 * we'd have non-owning ref to node that isn't in rbtree, and
+	 * verifier wouldn't be able to use type system to prevent remove
+	 * of ref that already isn't in any tree. Would have to do runtime
+	 * checks in that case.
+	 */
+	bpf_rbtree_remove(&groot, &o->node);
+
+	bpf_spin_unlock(&glock);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("rbtree_remove node input must be non-owning ref")
+long rbtree_api_first_release_unlock_escape(void *ctx)
+{
+	struct bpf_rb_node *res;
+	struct node_data *n;
+
+	bpf_spin_lock(&glock);
+	res =3D bpf_rbtree_first(&groot);
+	if (res)
+		n =3D container_of(res, struct node_data, node);
+	bpf_spin_unlock(&glock);
+
+	bpf_spin_lock(&glock);
+	/* After first() in previous critical section, n should be
+	 * release_on_unlock and released after previous spin_unlock,
+	 * so should not be possible to use it here
+	 */
+	bpf_rbtree_remove(&groot, &n->node);
+	bpf_spin_unlock(&glock);
+	return 0;
+}
+
+static bool less__bad_fn_call_add(struct bpf_rb_node *a, const struct bp=
f_rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a =3D container_of(a, struct node_data, node);
+	node_b =3D container_of(b, struct node_data, node);
+	bpf_rbtree_add(&groot, &node_a->node, less);
+
+	return node_a->key < node_b->key;
+}
+
+static bool less__bad_fn_call_remove(struct bpf_rb_node *a, const struct=
 bpf_rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a =3D container_of(a, struct node_data, node);
+	node_b =3D container_of(b, struct node_data, node);
+	bpf_rbtree_remove(&groot, &node_a->node);
+
+	return node_a->key < node_b->key;
+}
+
+static bool less__bad_fn_call_first_unlock_after(struct bpf_rb_node *a, =
const struct bpf_rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a =3D container_of(a, struct node_data, node);
+	node_b =3D container_of(b, struct node_data, node);
+	bpf_rbtree_first(&groot);
+	bpf_spin_unlock(&glock);
+
+	return node_a->key < node_b->key;
+}
+
+static __always_inline
+long add_with_cb(bool (cb)(struct bpf_rb_node *a, const struct bpf_rb_no=
de *b))
+{
+	struct node_data *n;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n)
+		return 1;
+
+	bpf_spin_lock(&glock);
+	bpf_rbtree_add(&groot, &n->node, cb);
+	bpf_spin_unlock(&glock);
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("arg#1 expected pointer to allocated object")
+long rbtree_api_add_bad_cb_bad_fn_call_add(void *ctx)
+{
+	return add_with_cb(less__bad_fn_call_add);
+}
+
+SEC("?tc")
+__failure __msg("rbtree_remove not allowed in rbtree cb")
+long rbtree_api_add_bad_cb_bad_fn_call_remove(void *ctx)
+{
+	return add_with_cb(less__bad_fn_call_remove);
+}
+
+SEC("?tc")
+__failure __msg("can't spin_{lock,unlock} in rbtree cb")
+long rbtree_api_add_bad_cb_bad_fn_call_first_unlock_after(void *ctx)
+{
+	return add_with_cb(less__bad_fn_call_first_unlock_after);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

