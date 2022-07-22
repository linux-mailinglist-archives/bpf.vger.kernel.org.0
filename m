Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AE257E69E
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 20:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiGVSfQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 14:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbiGVSfP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 14:35:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2B2222A7
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:13 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M6LSkC011327
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vWJ04e9HlRIugBxVyk5DZsLK/c/mhW8RV268HwXg76A=;
 b=ddT5W0rZ1pHh/+L3rmzt2RETlcJHPigdf1BtkN4kfVlUTwNxPx98zaNsB84ieC6BP+eV
 l+7T/Nwbywgoz7N364BmGlDiDMePaybK3Y49Z4yOw/gjX6YSlqQZ51as42C4bAmkX4/2
 dsIwm7zlW7+dFQ/r0/JNNsZHAw4MGIo6g0Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hfphrbkut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:13 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 11:35:12 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 480DAAB6F1AD; Fri, 22 Jul 2022 11:34:52 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 11/11] selftests/bpf: Add rbtree map tests
Date:   Fri, 22 Jul 2022 11:34:38 -0700
Message-ID: <20220722183438.3319790-12-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220722183438.3319790-1-davemarchevsky@fb.com>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ldDKxP-4pYW3dnpEVLIzUFYbEywDLCpo
X-Proofpoint-GUID: ldDKxP-4pYW3dnpEVLIzUFYbEywDLCpo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests demonstrating happy path of rbtree map usage as well as
exercising numerous failure paths and conditions. Structure of failing
test runner is based on dynptr tests.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/prog_tests/rbtree_map.c     | 164 ++++++++++++
 .../testing/selftests/bpf/progs/rbtree_map.c  | 111 ++++++++
 .../selftests/bpf/progs/rbtree_map_fail.c     | 236 ++++++++++++++++++
 .../bpf/progs/rbtree_map_load_fail.c          |  24 ++
 4 files changed, 535 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/rbtree_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/rbtree_map_load_fai=
l.c

diff --git a/tools/testing/selftests/bpf/prog_tests/rbtree_map.c b/tools/=
testing/selftests/bpf/prog_tests/rbtree_map.c
new file mode 100644
index 000000000000..17cadcd05ee4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/rbtree_map.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include "rbtree_map.skel.h"
+#include "rbtree_map_fail.skel.h"
+#include "rbtree_map_load_fail.skel.h"
+
+static size_t log_buf_sz =3D 1048576; /* 1 MB */
+static char obj_log_buf[1048576];
+
+static struct {
+	const char *prog_name;
+	const char *expected_err_msg;
+} rbtree_prog_load_fail_tests[] =3D {
+	{"rb_node__field_store", "only read is supported"},
+	{"rb_node__alloc_no_add", "Unreleased reference id=3D2 alloc_insn=3D3"}=
,
+	{"rb_node__two_alloc_one_add", "Unreleased reference id=3D2 alloc_insn=3D=
3"},
+	{"rb_node__remove_no_free", "Unreleased reference id=3D5 alloc_insn=3D2=
8"},
+	{"rb_tree__add_wrong_type", "rbtree: R2 is of type task_struct but node=
_data is expected"},
+	{"rb_tree__conditional_release_helper_usage",
+		"R2 type=3Dptr_cond_rel_ expected=3Dptr_"},
+};
+
+void test_rbtree_map_load_fail(void)
+{
+	struct rbtree_map_load_fail *skel;
+
+	skel =3D rbtree_map_load_fail__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "rbtree_map_load_fail__open_and_load"))
+		rbtree_map_load_fail__destroy(skel);
+}
+
+static void verify_fail(const char *prog_name, const char *expected_err_=
msg)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct rbtree_map_fail *skel;
+	struct bpf_program *prog;
+	int err;
+
+	opts.kernel_log_buf =3D obj_log_buf;
+	opts.kernel_log_size =3D log_buf_sz;
+	opts.kernel_log_level =3D 1;
+
+	skel =3D rbtree_map_fail__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "rbtree_map_fail__open_opts"))
+		goto cleanup;
+
+	prog =3D bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	bpf_program__set_autoload(prog, true);
+	err =3D rbtree_map_fail__load(skel);
+	if (!ASSERT_ERR(err, "unexpected load success"))
+		goto cleanup;
+
+	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err=
_msg")) {
+		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
+		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
+	}
+
+cleanup:
+	rbtree_map_fail__destroy(skel);
+}
+
+void test_rbtree_map_alloc_node__size_too_small(void)
+{
+	struct rbtree_map_fail *skel;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	int err;
+
+	skel =3D rbtree_map_fail__open();
+	if (!ASSERT_OK_PTR(skel, "rbtree_map_fail__open"))
+		goto cleanup;
+
+	prog =3D skel->progs.alloc_node__size_too_small;
+	bpf_program__set_autoload(prog, true);
+
+	err =3D rbtree_map_fail__load(skel);
+	if (!ASSERT_OK(err, "unexpected load fail"))
+		goto cleanup;
+
+	link =3D bpf_program__attach(skel->progs.alloc_node__size_too_small);
+	if (!ASSERT_OK_PTR(link, "link"))
+		goto cleanup;
+
+	syscall(SYS_getpgid);
+
+	ASSERT_EQ(skel->bss->size_too_small__alloc_fail, 1, "alloc_fail");
+
+	bpf_link__destroy(link);
+cleanup:
+	rbtree_map_fail__destroy(skel);
+}
+
+void test_rbtree_map_add_node__no_lock(void)
+{
+	struct rbtree_map_fail *skel;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	int err;
+
+	skel =3D rbtree_map_fail__open();
+	if (!ASSERT_OK_PTR(skel, "rbtree_map_fail__open"))
+		goto cleanup;
+
+	prog =3D skel->progs.add_node__no_lock;
+	bpf_program__set_autoload(prog, true);
+
+	err =3D rbtree_map_fail__load(skel);
+	if (!ASSERT_OK(err, "unexpected load fail"))
+		goto cleanup;
+
+	link =3D bpf_program__attach(skel->progs.add_node__no_lock);
+	if (!ASSERT_OK_PTR(link, "link"))
+		goto cleanup;
+
+	syscall(SYS_getpgid);
+
+	ASSERT_EQ(skel->bss->no_lock_add__fail, 1, "alloc_fail");
+
+	bpf_link__destroy(link);
+cleanup:
+	rbtree_map_fail__destroy(skel);
+}
+
+void test_rbtree_map_prog_load_fail(void)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(rbtree_prog_load_fail_tests); i++) {
+		if (!test__start_subtest(rbtree_prog_load_fail_tests[i].prog_name))
+			continue;
+
+		verify_fail(rbtree_prog_load_fail_tests[i].prog_name,
+			    rbtree_prog_load_fail_tests[i].expected_err_msg);
+	}
+}
+
+void test_rbtree_map(void)
+{
+	struct rbtree_map *skel;
+	struct bpf_link *link;
+
+	skel =3D rbtree_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "rbtree_map__open_and_load"))
+		goto cleanup;
+
+	link =3D bpf_program__attach(skel->progs.check_rbtree);
+	if (!ASSERT_OK_PTR(link, "link"))
+		goto cleanup;
+
+	for (int i =3D 0; i < 100; i++)
+		syscall(SYS_getpgid);
+
+	ASSERT_EQ(skel->bss->calls, 100, "calls_equal");
+
+	bpf_link__destroy(link);
+cleanup:
+	rbtree_map__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/rbtree_map.c b/tools/testi=
ng/selftests/bpf/progs/rbtree_map.c
new file mode 100644
index 000000000000..0cd467838f6e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rbtree_map.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct node_data {
+	struct rb_node node;
+	__u32 one;
+	__u32 two;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RBTREE);
+	__type(value, struct node_data);
+} rbtree SEC(".maps");
+
+long calls;
+
+static bool less(struct rb_node *a, const struct rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a =3D container_of(a, struct node_data, node);
+	node_b =3D container_of(b, struct node_data, node);
+
+	return node_a->one < node_b->one;
+}
+
+// Key =3D node_datq
+static int cmp(const void *key, const struct rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a =3D container_of(key, struct node_data, node);
+	node_b =3D container_of(b, struct node_data, node);
+
+	return node_b->one - node_a->one;
+}
+
+// Key =3D just node_data.one
+static int cmp2(const void *key, const struct rb_node *b)
+{
+	__u32 one;
+	struct node_data *node_b;
+
+	one =3D *(__u32 *)key;
+	node_b =3D container_of(b, struct node_data, node);
+
+	return node_b->one - one;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int check_rbtree(void *ctx)
+{
+	struct node_data *node, *found, *ret;
+	struct node_data popped;
+	struct node_data search;
+	__u32 search2;
+
+	node =3D bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
+	if (!node)
+		return 0;
+
+	node->one =3D calls;
+	node->two =3D 6;
+	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+
+	ret =3D (struct node_data *)bpf_rbtree_add(&rbtree, node, less);
+	if (!ret) {
+		bpf_rbtree_free_node(&rbtree, node);
+		goto unlock_ret;
+	}
+
+	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+
+	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+
+	search.one =3D calls;
+	found =3D (struct node_data *)bpf_rbtree_find(&rbtree, &search, cmp);
+	if (!found)
+		goto unlock_ret;
+
+	int node_ct =3D 0;
+	struct node_data *iter =3D (struct node_data *)bpf_rbtree_first(&rbtree=
);
+
+	while (iter) {
+		node_ct++;
+		iter =3D (struct node_data *)bpf_rbtree_next(&rbtree, iter);
+	}
+
+	ret =3D (struct node_data *)bpf_rbtree_remove(&rbtree, found);
+	if (!ret)
+		goto unlock_ret;
+
+	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+
+	bpf_rbtree_free_node(&rbtree, ret);
+
+	__sync_fetch_and_add(&calls, 1);
+	return 0;
+
+unlock_ret:
+	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/rbtree_map_fail.c b/tools/=
testing/selftests/bpf/progs/rbtree_map_fail.c
new file mode 100644
index 000000000000..287c8db080d8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rbtree_map_fail.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct node_data {
+	struct rb_node node;
+	__u32 one;
+	__u32 two;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RBTREE);
+	__type(value, struct node_data);
+} rbtree SEC(".maps");
+
+long calls;
+
+static bool less(struct rb_node *a, const struct rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a =3D container_of(a, struct node_data, node);
+	node_b =3D container_of(b, struct node_data, node);
+
+	return node_a->one < node_b->one;
+}
+
+// Key =3D node_datq
+static int cmp(const void *key, const struct rb_node *b)
+{
+	struct node_data *node_a;
+	struct node_data *node_b;
+
+	node_a =3D container_of(key, struct node_data, node);
+	node_b =3D container_of(b, struct node_data, node);
+
+	return node_b->one - node_a->one;
+}
+
+long size_too_small__alloc_fail;
+
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+int alloc_node__size_too_small(void *ctx)
+{
+	struct node_data *node, *ret;
+
+	node =3D bpf_rbtree_alloc_node(&rbtree, sizeof(char));
+	if (!node) {
+		size_too_small__alloc_fail++;
+		return 0;
+	}
+
+	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+	/* will never execute, alloc_node should fail */
+	node->one =3D 1;
+	ret =3D bpf_rbtree_add(&rbtree, node, less);
+	if (!ret) {
+		bpf_rbtree_free_node(&rbtree, node);
+		goto unlock_ret;
+	}
+
+unlock_ret:
+	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	return 0;
+}
+
+long no_lock_add__fail;
+
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+int add_node__no_lock(void *ctx)
+{
+	struct node_data *node, *ret;
+
+	node =3D bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
+	if (!node)
+		return 0;
+
+	node->one =3D 1;
+	ret =3D bpf_rbtree_add(&rbtree, node, less);
+	if (!ret) {
+		no_lock_add__fail++;
+		/* will always execute, rbtree_add should fail
+		 * because no lock held
+		 */
+		bpf_rbtree_free_node(&rbtree, node);
+	}
+
+unlock_ret:
+	return 0;
+}
+
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+int rb_node__field_store(void *ctx)
+{
+	struct node_data *node;
+
+	node =3D bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
+	if (!node)
+		return 0;
+
+	/* Only rbtree_map helpers can modify rb_node field */
+	node->node.rb_left =3D NULL;
+	return 0;
+}
+
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+int rb_node__alloc_no_add(void *ctx)
+{
+	struct node_data *node;
+
+	node =3D bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
+	if (!node)
+		return 0;
+	/* The node alloc'd above is never added to the rbtree. It must be
+	 * added or free'd before prog terminates.
+	 */
+
+	node->one =3D 42;
+	return 0;
+}
+
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+int rb_node__two_alloc_one_add(void *ctx)
+{
+	struct node_data *node, *ret;
+
+	node =3D bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
+	if (!node)
+		return 0;
+	node->one =3D 1;
+	/* The node alloc'd above is never added to the rbtree. It must be
+	 * added or free'd before prog terminates.
+	 */
+
+	node =3D bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
+	if (!node)
+		return 0;
+	node->one =3D 42;
+
+	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+
+	ret =3D bpf_rbtree_add(&rbtree, node, less);
+	if (!ret) {
+		bpf_rbtree_free_node(&rbtree, node);
+		goto unlock_ret;
+	}
+
+unlock_ret:
+	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	return 0;
+}
+
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+int rb_node__remove_no_free(void *ctx)
+{
+	struct node_data *node, *ret;
+
+	node =3D bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
+	if (!node)
+		return 0;
+	node->one =3D 42;
+
+	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+
+	ret =3D bpf_rbtree_add(&rbtree, node, less);
+	if (!ret) {
+		bpf_rbtree_free_node(&rbtree, node);
+		goto unlock_ret;
+	}
+
+	ret =3D bpf_rbtree_remove(&rbtree, ret);
+	if (!ret)
+		goto unlock_ret;
+	/* At this point we've successfully acquired a reference from
+	 * bpf_rbtree_remove. It must be released via rbtree_add or
+	 * rbtree_free_node before prog terminates.
+	 */
+
+unlock_ret:
+	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	return 0;
+}
+
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+int rb_tree__add_wrong_type(void *ctx)
+{
+	/* Can't add a task_struct to rbtree
+	 */
+	struct task_struct *task;
+	struct node_data *ret;
+
+	task =3D bpf_get_current_task_btf();
+
+	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+
+	ret =3D bpf_rbtree_add(&rbtree, task, less);
+	/* Verifier should fail at bpf_rbtree_add, so don't bother handling
+	 * failure.
+	 */
+
+	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	return 0;
+}
+
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+int rb_tree__conditional_release_helper_usage(void *ctx)
+{
+	struct node_data *node, *ret;
+
+	node =3D bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
+	if (!node)
+		return 0;
+	node->one =3D 42;
+
+	bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
+
+	ret =3D bpf_rbtree_add(&rbtree, node, less);
+	/* Verifier should fail when trying to use CONDITIONAL_RELEASE
+	 * type in a helper
+	 */
+	bpf_rbtree_free_node(&rbtree, node);
+	if (!ret) {
+		bpf_rbtree_free_node(&rbtree, node);
+		goto unlock_ret;
+	}
+
+unlock_ret:
+	bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/rbtree_map_load_fail.c b/t=
ools/testing/selftests/bpf/progs/rbtree_map_load_fail.c
new file mode 100644
index 000000000000..036558eedd66
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rbtree_map_load_fail.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct node_data_no_rb_node {
+	__u64 one;
+	__u64 two;
+	__u64 three;
+	__u64 four;
+	__u64 five;
+	__u64 six;
+	__u64 seven;
+};
+
+/* Should fail because value struct has no rb_node
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_RBTREE);
+	__type(value, struct node_data_no_rb_node);
+} rbtree_fail_no_rb_node SEC(".maps");
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

