Return-Path: <bpf+bounces-8216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 059F57838F7
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 07:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B785C280FE5
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 05:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4301FCC;
	Tue, 22 Aug 2023 05:01:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CB41FA1
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 05:01:11 +0000 (UTC)
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC79711C
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 22:01:10 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 87051252EEC29; Mon, 21 Aug 2023 22:00:58 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add a failure test for bpf_kptr_xchg() with local kptr
Date: Mon, 21 Aug 2023 22:00:58 -0700
Message-Id: <20230822050058.2887354-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822050053.2886960-1-yonghong.song@linux.dev>
References: <20230822050053.2886960-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For a bpf_kptr_xchg() with local kptr, if the map value kptr type and
allocated local obj type does not match, with the previous patch,
the below verifier error message will be logged:
  R2 is of type <allocated local obj type> but <map value kptr type> is e=
xpected

Without the previous patch, the test will have unexpected success.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/local_kptr_stash.c         | 10 ++-
 .../bpf/progs/local_kptr_stash_fail.c         | 65 +++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/local_kptr_stash_fa=
il.c

diff --git a/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c b/=
tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
index 76f1da877f81..158616c94658 100644
--- a/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
@@ -5,6 +5,7 @@
 #include <network_helpers.h>
=20
 #include "local_kptr_stash.skel.h"
+#include "local_kptr_stash_fail.skel.h"
 static void test_local_kptr_stash_simple(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts,
@@ -51,10 +52,17 @@ static void test_local_kptr_stash_unstash(void)
 	local_kptr_stash__destroy(skel);
 }
=20
-void test_local_kptr_stash_success(void)
+static void test_local_kptr_stash_fail(void)
+{
+	RUN_TESTS(local_kptr_stash_fail);
+}
+
+void test_local_kptr_stash(void)
 {
 	if (test__start_subtest("local_kptr_stash_simple"))
 		test_local_kptr_stash_simple();
 	if (test__start_subtest("local_kptr_stash_unstash"))
 		test_local_kptr_stash_unstash();
+	if (test__start_subtest("local_kptr_stash_fail"))
+		test_local_kptr_stash_fail();
 }
diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c b/=
tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
new file mode 100644
index 000000000000..5484d1e9801d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash_fail.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "../bpf_experimental.h"
+#include "bpf_misc.h"
+
+struct node_data {
+	long key;
+	long data;
+	struct bpf_rb_node node;
+};
+
+struct map_value {
+	struct node_data __kptr *node;
+};
+
+struct node_data2 {
+	long key[4];
+};
+
+/* This is necessary so that LLVM generates BTF for node_data struct
+ * If it's not included, a fwd reference for node_data will be generated=
 but
+ * no struct. Example BTF of "node" field in map_value when not included=
:
+ *
+ * [10] PTR '(anon)' type_id=3D35
+ * [34] FWD 'node_data' fwd_kind=3Dstruct
+ * [35] TYPE_TAG 'kptr_ref' type_id=3D34
+ */
+struct node_data *just_here_because_btf_bug;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 2);
+} some_nodes SEC(".maps");
+
+SEC("tc")
+__failure __msg("invalid kptr access, R2 type=3Dptr_node_data2 expected=3D=
ptr_node_data")
+long stash_rb_nodes(void *ctx)
+{
+	struct map_value *mapval;
+	struct node_data2 *res;
+	int idx =3D 0;
+
+	mapval =3D bpf_map_lookup_elem(&some_nodes, &idx);
+	if (!mapval)
+		return 1;
+
+	res =3D bpf_obj_new(typeof(*res));
+	if (!res)
+		return 1;
+	res->key[0] =3D 40;
+
+	res =3D bpf_kptr_xchg(&mapval->node, res);
+	if (res)
+		bpf_obj_drop(res);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


