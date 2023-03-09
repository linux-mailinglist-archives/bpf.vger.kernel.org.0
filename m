Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BA06B2C88
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 19:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCISCL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 13:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCISCK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 13:02:10 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012A1FCBC1
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 10:02:08 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 329GhDWA010037
        for <bpf@vger.kernel.org>; Thu, 9 Mar 2023 10:02:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=uAD05I1+g4vcyw75ThogQlWbuhkfV6ceJsU89ok0syQ=;
 b=EKNdmVtex+HA/zmERCJmnWZ45/cbgYjirLSts7cDUHzlTOkgOC49nZFrYbM29M8GNhcX
 zNHHqGJdxTFF+IvI7cKp3NotoBz6Yw+2nEm+XT6Q3+3eMW/c8KRJWTRYJ9Cr4hn5q6Mx
 yC5qv4sYZADmy0pRCtmpzsmwZZJlqavR6hs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3p7k7k8h5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 10:02:07 -0800
Received: from twshared1938.08.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Mar 2023 10:01:31 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 77DD518E84D5F; Thu,  9 Mar 2023 10:01:17 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 6/6] selftests/bpf: Add local kptr stashing test
Date:   Thu, 9 Mar 2023 10:01:11 -0800
Message-ID: <20230309180111.1618459-7-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309180111.1618459-1-davemarchevsky@fb.com>
References: <20230309180111.1618459-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qXs69gm8qyQ9MOyZDlvnn1t4sKu4pEMq
X-Proofpoint-ORIG-GUID: qXs69gm8qyQ9MOyZDlvnn1t4sKu4pEMq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_09,2023-03-09_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new selftest, local_kptr_stash, which uses bpf_kptr_xchg to stash
a bpf_obj_new-allocated object in a map.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../bpf/prog_tests/local_kptr_stash.c         | 33 +++++++
 .../selftests/bpf/progs/local_kptr_stash.c    | 85 +++++++++++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/local_kptr_sta=
sh.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_kptr_stash.c

diff --git a/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c b/=
tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
new file mode 100644
index 000000000000..98353e602741
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "local_kptr_stash.skel.h"
+static void test_local_kptr_stash_simple(void)
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
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.stash_rb_nod=
e), &opts);
+	ASSERT_OK(ret, "local_kptr_stash_add_nodes run");
+	ASSERT_OK(opts.retval, "local_kptr_stash_add_nodes retval");
+
+	local_kptr_stash__destroy(skel);
+}
+
+void test_local_kptr_stash_success(void)
+{
+	if (test__start_subtest("rbtree_add_nodes"))
+		test_local_kptr_stash_simple();
+}
diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools=
/testing/selftests/bpf/progs/local_kptr_stash.c
new file mode 100644
index 000000000000..df7b419f3dc3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
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
+struct map_value {
+	struct prog_test_ref_kfunc *not_kptr;
+	struct prog_test_ref_kfunc __kptr *val;
+	struct node_data __kptr *node;
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
+ *
+ * (with no node_data struct defined)
+ * Had to do the same w/ bpf_kfunc_call_test_release below
+ */
+struct node_data *just_here_because_btf_bug;
+
+extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) _=
_ksym;
+
+struct {
+        __uint(type, BPF_MAP_TYPE_ARRAY);
+        __type(key, int);
+        __type(value, struct map_value);
+        __uint(max_entries, 1);
+} some_nodes SEC(".maps");
+
+SEC("tc")
+long stash_rb_node(void *ctx)
+{
+	struct map_value *mapval;
+	struct node_data *res;
+	int key =3D 0;
+
+	res =3D bpf_obj_new(typeof(*res));
+	if (!res)
+		return 1;
+	res->key =3D 42;
+
+	mapval =3D bpf_map_lookup_elem(&some_nodes, &key);
+	if (!mapval) {
+		bpf_obj_drop(res);
+		return 1;
+	}
+
+	res =3D bpf_kptr_xchg(&mapval->node, res);
+	if (res)
+		bpf_obj_drop(res);
+	return 0;
+}
+
+SEC("tc")
+long stash_test_ref_kfunc(void *ctx)
+{
+	struct prog_test_ref_kfunc *res;
+	struct map_value *mapval;
+	int key =3D 0;
+
+	mapval =3D bpf_map_lookup_elem(&some_nodes, &key);
+	if (!mapval)
+		return 1;
+
+	res =3D bpf_kptr_xchg(&mapval->val, NULL);
+	if (res)
+		bpf_kfunc_call_test_release(res);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1

