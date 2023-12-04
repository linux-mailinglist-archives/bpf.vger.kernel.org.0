Return-Path: <bpf+bounces-16643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD978040EE
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 22:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481582810EA
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 21:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDEF364D6;
	Mon,  4 Dec 2023 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SPpGYPEa"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2980BAA
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 13:18:28 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4KH4gb011403
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 13:18:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=0Zwehc64oEcwi2269R++Wz/d5uRyy4+/7iEKQpQpXjY=;
 b=SPpGYPEas+A8C/8ZdT/x5Mjt3UeXSYkmgnpnaFxKYoe3s1kHGnCw2R8fpFJxT39ehKHp
 m2lRJJkD5n1AVRXfkSz+6y7fxqGWWj0Swo4By9uLX48luvFoDlPP3hT6W0mXRRUaM6Of
 Oz57RjgjZiUEZdXpmYUiVtVjMw4Dd7BQI7I= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3urm87b1nx-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 13:18:27 -0800
Received: from twshared27564.02.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 13:18:26 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 2BE5B284548A9; Mon,  4 Dec 2023 13:18:12 -0800 (PST)
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
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next] selftests/bpf: Test bpf_kptr_xchg stashing of bpf_rb_root
Date: Mon, 4 Dec 2023 13:17:22 -0800
Message-ID: <20231204211722.571346-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Gnk36UcvhkNqmXZzC6bx4JNDvQck4cys
X-Proofpoint-ORIG-GUID: Gnk36UcvhkNqmXZzC6bx4JNDvQck4cys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_19,2023-12-04_01,2023-05-22_02

There was some confusion amongst Meta sched_ext folks regarding whether
stashing bpf_rb_root - the tree itself, rather than a single node - was
supported. This patch adds a small test which demonstrates this
functionality: a local kptr with rb_root is created, a node is created
and added to the tree, then the tree is kptr_xchg'd into a mapval.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../bpf/prog_tests/local_kptr_stash.c         | 23 ++++++++
 .../selftests/bpf/progs/local_kptr_stash.c    | 53 +++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c b/=
tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
index e6e50a394472..827e713f6cf1 100644
--- a/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
@@ -48,6 +48,27 @@ static void test_local_kptr_stash_plain(void)
 	local_kptr_stash__destroy(skel);
 }
=20
+static void test_local_kptr_stash_local_with_root(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in =3D &pkt_v4,
+		    .data_size_in =3D sizeof(pkt_v4),
+		    .repeat =3D 1,
+	);
+	struct local_kptr_stash *skel;
+	int ret;
+
+	skel =3D local_kptr_stash__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "local_kptr_stash__open_and_load"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.stash_local_=
with_root), &opts);
+	ASSERT_OK(ret, "local_kptr_stash_add_local_with_root run");
+	ASSERT_OK(opts.retval, "local_kptr_stash_add_local_with_root retval");
+
+	local_kptr_stash__destroy(skel);
+}
+
 static void test_local_kptr_stash_unstash(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts,
@@ -115,6 +136,8 @@ void test_local_kptr_stash(void)
 		test_local_kptr_stash_simple();
 	if (test__start_subtest("local_kptr_stash_plain"))
 		test_local_kptr_stash_plain();
+	if (test__start_subtest("local_kptr_stash_local_with_root"))
+		test_local_kptr_stash_local_with_root();
 	if (test__start_subtest("local_kptr_stash_unstash"))
 		test_local_kptr_stash_unstash();
 	if (test__start_subtest("refcount_acquire_without_unstash"))
diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools=
/testing/selftests/bpf/progs/local_kptr_stash.c
index 1769fdff6aea..75043ffc5dad 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -37,11 +37,18 @@ struct plain_local {
 	long data;
 };
=20
+struct local_with_root {
+	long key;
+	struct bpf_spin_lock l;
+	struct bpf_rb_root r __contains(node_data, node);
+};
+
 struct map_value {
 	struct prog_test_ref_kfunc *not_kptr;
 	struct prog_test_ref_kfunc __kptr *val;
 	struct node_data __kptr *node;
 	struct plain_local __kptr *plain;
+	struct local_with_root __kptr *local_root;
 };
=20
 /* This is necessary so that LLVM generates BTF for node_data struct
@@ -65,6 +72,17 @@ struct {
 	__uint(max_entries, 2);
 } some_nodes SEC(".maps");
=20
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
 static int create_and_stash(int idx, int val)
 {
 	struct map_value *mapval;
@@ -113,6 +131,41 @@ long stash_plain(void *ctx)
 	return 0;
 }
=20
+SEC("tc")
+long stash_local_with_root(void *ctx)
+{
+	struct local_with_root *res;
+	struct map_value *mapval;
+	struct node_data *n;
+	int idx =3D 0;
+
+	mapval =3D bpf_map_lookup_elem(&some_nodes, &idx);
+	if (!mapval)
+		return 1;
+
+	res =3D bpf_obj_new(typeof(*res));
+	if (!res)
+		return 2;
+	res->key =3D 41;
+
+	n =3D bpf_obj_new(typeof(*n));
+	if (!n) {
+		bpf_obj_drop(res);
+		return 3;
+	}
+
+	bpf_spin_lock(&res->l);
+	bpf_rbtree_add(&res->r, &n->node, less);
+	bpf_spin_unlock(&res->l);
+
+	res =3D bpf_kptr_xchg(&mapval->local_root, res);
+	if (res) {
+		bpf_obj_drop(res);
+		return 4;
+	}
+	return 0;
+}
+
 SEC("tc")
 long unstash_rb_node(void *ctx)
 {
--=20
2.34.1


