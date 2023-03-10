Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7626B5554
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 00:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjCJXIQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 18:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjCJXIO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 18:08:14 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DDD2331B
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:08:10 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AMdYpx001910
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:08:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=meW9fN007JFLBzHsn52WNHiMcEdWC8KNJ2rDF+qdnzU=;
 b=Snmmh8kNV3P91NjqTGgGB8C9z5Q0+vhFr+oydH63O6CiNzdKgJEqN0rGqrtdW7ALb1nJ
 vxCUj8Zw23ALIRbEdUxJztE8iwSuzc3fcC1xV3tcYGkNQ/sBvNRdaLJ3apXCzMFHgIlh
 QAXqXpzaUeraeuNN8IQimr9+zinfQnBCjc4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p86w0k4ue-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:08:10 -0800
Received: from twshared21709.17.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Mar 2023 15:07:58 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id CFCAE1902A211; Fri, 10 Mar 2023 15:07:47 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 3/3] selftests/bpf: Add local kptr stashing test
Date:   Fri, 10 Mar 2023 15:07:43 -0800
Message-ID: <20230310230743.2320707-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310230743.2320707-1-davemarchevsky@fb.com>
References: <20230310230743.2320707-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oxpEt1vw3pMGhsOZF24q_bJxL-4MKNWW
X-Proofpoint-GUID: oxpEt1vw3pMGhsOZF24q_bJxL-4MKNWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new selftest, local_kptr_stash, which uses bpf_kptr_xchg to stash
a bpf_obj_new-allocated object in a map. Test the following scenarios:

  * Stash two rb_nodes in an arraymap, don't unstash them, rely on map
    free to destruct them
  * Stash two rb_nodes in an arraymap, unstash the second one in a
    separate program, rely on map free to destruct first

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../bpf/prog_tests/local_kptr_stash.c         |  60 ++++++++++
 .../selftests/bpf/progs/local_kptr_stash.c    | 108 ++++++++++++++++++
 2 files changed, 168 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/local_kptr_sta=
sh.c
 create mode 100644 tools/testing/selftests/bpf/progs/local_kptr_stash.c

diff --git a/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c b/=
tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
new file mode 100644
index 000000000000..76f1da877f81
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/local_kptr_stash.c
@@ -0,0 +1,60 @@
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
es), &opts);
+	ASSERT_OK(ret, "local_kptr_stash_add_nodes run");
+	ASSERT_OK(opts.retval, "local_kptr_stash_add_nodes retval");
+
+	local_kptr_stash__destroy(skel);
+}
+
+static void test_local_kptr_stash_unstash(void)
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
es), &opts);
+	ASSERT_OK(ret, "local_kptr_stash_add_nodes run");
+	ASSERT_OK(opts.retval, "local_kptr_stash_add_nodes retval");
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.unstash_rb_n=
ode), &opts);
+	ASSERT_OK(ret, "local_kptr_stash_add_nodes run");
+	ASSERT_EQ(opts.retval, 42, "local_kptr_stash_add_nodes retval");
+
+	local_kptr_stash__destroy(skel);
+}
+
+void test_local_kptr_stash_success(void)
+{
+	if (test__start_subtest("local_kptr_stash_simple"))
+		test_local_kptr_stash_simple();
+	if (test__start_subtest("local_kptr_stash_unstash"))
+		test_local_kptr_stash_unstash();
+}
diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools=
/testing/selftests/bpf/progs/local_kptr_stash.c
new file mode 100644
index 000000000000..2e50ac1f64a0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -0,0 +1,108 @@
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
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 2);
+} some_nodes SEC(".maps");
+
+static int create_and_stash(int idx, int val)
+{
+	struct map_value *mapval;
+	struct node_data *res;
+
+	mapval =3D bpf_map_lookup_elem(&some_nodes, &idx);
+	if (!mapval)
+		return 1;
+
+	res =3D bpf_obj_new(typeof(*res));
+	if (!res)
+		return 1;
+	res->key =3D val;
+
+	res =3D bpf_kptr_xchg(&mapval->node, res);
+	if (res)
+		bpf_obj_drop(res);
+	return 0;
+}
+
+SEC("tc")
+long stash_rb_nodes(void *ctx)
+{
+	return create_and_stash(0, 41) ?: create_and_stash(1, 42);
+}
+
+SEC("tc")
+long unstash_rb_node(void *ctx)
+{
+	struct map_value *mapval;
+	struct node_data *res;
+	long retval;
+	int key =3D 1;
+
+	mapval =3D bpf_map_lookup_elem(&some_nodes, &key);
+	if (!mapval)
+		return 1;
+
+	res =3D bpf_kptr_xchg(&mapval->node, NULL);
+	if (res) {
+		retval =3D res->key;
+		bpf_obj_drop(res);
+		return retval;
+	}
+	return 1;
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

