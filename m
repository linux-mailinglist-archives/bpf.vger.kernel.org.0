Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40D358182C
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 19:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbiGZRMP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbiGZRMP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 13:12:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5037213F85
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:12:14 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QErNoi003532
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:12:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=n1qkqjGz2nD2gbhJGByhz3AjB3log17vijfwdZH2b70=;
 b=Oobrd7qrB1MnNZXHiQKs5q0xZ3umuiNvWUffQYalLC8cGNfpo26PSCoDJWrdtKHGlTQU
 iSDWvMuqmdYm/N5o+xiYrLFaOATg7nNQhX7YFJybXuPnsSYRqIxS3AXzO/scZ+w8qgVC
 GLKf1BfjjTJZPkA+AAI5Tz1osaYZsfXtiHY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hj1uspcey-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:12:13 -0700
Received: from twshared7556.02.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 10:12:12 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 4E2FDD40EBAA; Tue, 26 Jul 2022 10:12:07 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 7/7] selftests/bpf: Add struct value tests with fentry programs.
Date:   Tue, 26 Jul 2022 10:12:07 -0700
Message-ID: <20220726171207.715361-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726171129.708371-1-yhs@fb.com>
References: <20220726171129.708371-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gbG7cjzb_3HkKJURh8RvXLWf1apYhLxx
X-Proofpoint-ORIG-GUID: gbG7cjzb_3HkKJURh8RvXLWf1apYhLxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_05,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The fexit tests will be added later.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 37 +++++++++++
 .../selftests/bpf/prog_tests/tracing_struct.c | 51 +++++++++++++++
 .../selftests/bpf/progs/tracing_struct.c      | 64 +++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_struct=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 792cb15bac40..8ba5391023df 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -18,6 +18,36 @@ typedef int (*func_proto_typedef_nested1)(func_proto_t=
ypedef);
 typedef int (*func_proto_typedef_nested2)(func_proto_typedef_nested1);
=20
 DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) =3D 123;
+long bpf_testmod_test_struct_arg_result;
+
+struct bpf_testmod_struct_arg_1 {
+	int a;
+};
+struct bpf_testmod_struct_arg_2 {
+	long a;
+	long b;
+};
+
+noinline void
+bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int b, =
int c) {
+	bpf_testmod_test_struct_arg_result =3D a.a + a.b  + b + c;
+}
+
+noinline void
+bpf_testmod_test_struct_arg_2(int a, struct bpf_testmod_struct_arg_2 b, =
int c) {
+	bpf_testmod_test_struct_arg_result =3D a + b.a + b.b + c;
+}
+
+noinline void
+bpf_testmod_test_struct_arg_3(int a, int b, struct bpf_testmod_struct_ar=
g_2 c) {
+	bpf_testmod_test_struct_arg_result =3D a + b + c.a + c.b;
+}
+
+noinline void
+bpf_testmod_test_struct_arg_4(struct bpf_testmod_struct_arg_1 a, int b,
+			      int c, int d, struct bpf_testmod_struct_arg_2 e) {
+	bpf_testmod_test_struct_arg_result =3D a.a + b + c + d + e.a + e.b;
+}
=20
 noinline void
 bpf_testmod_test_mod_kfunc(int i)
@@ -98,11 +128,18 @@ bpf_testmod_test_read(struct file *file, struct kobj=
ect *kobj,
 		.off =3D off,
 		.len =3D len,
 	};
+	struct bpf_testmod_struct_arg_1 struct_arg1 =3D {10};
+	struct bpf_testmod_struct_arg_2 struct_arg2 =3D {2, 3};
 	int i =3D 1;
=20
 	while (bpf_testmod_return_ptr(i))
 		i++;
=20
+	bpf_testmod_test_struct_arg_1(struct_arg2, 1, 4);
+	bpf_testmod_test_struct_arg_2(1, struct_arg2, 4);
+	bpf_testmod_test_struct_arg_3(1, 4, struct_arg2);
+	bpf_testmod_test_struct_arg_4(struct_arg1, 1, 2, 3, struct_arg2);
+
 	/* This is always true. Use the check to make sure the compiler
 	 * doesn't remove bpf_testmod_loop_test.
 	 */
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/to=
ols/testing/selftests/bpf/prog_tests/tracing_struct.c
new file mode 100644
index 000000000000..7c0ee156644f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "tracing_struct.skel.h"
+
+static void test_fentry(void)
+{
+	struct tracing_struct *skel;
+	int err;
+
+	skel =3D tracing_struct__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_struct__open_and_load"))
+		return;
+
+	err =3D tracing_struct__attach(skel);
+	if (!ASSERT_OK(err, "tracing_struct__attach"))
+		return;
+
+        ASSERT_OK(trigger_module_test_read(256), "trigger_read");
+
+	ASSERT_EQ(skel->bss->t1_a_a, 2, "t1:a.a");
+	ASSERT_EQ(skel->bss->t1_a_b, 3, "t1:a.b");
+	ASSERT_EQ(skel->bss->t1_b, 1, "t1:b");
+	ASSERT_EQ(skel->bss->t1_c, 4, "t1:c");
+
+	ASSERT_EQ(skel->bss->t2_a, 1, "t2:a");
+	ASSERT_EQ(skel->bss->t2_b_a, 2, "t2:b.a");
+	ASSERT_EQ(skel->bss->t2_b_b, 3, "t2:b.b");
+	ASSERT_EQ(skel->bss->t2_c, 4, "t2:c");
+
+	ASSERT_EQ(skel->bss->t3_a, 1, "t3:a");
+	ASSERT_EQ(skel->bss->t3_b, 4, "t3:b");
+	ASSERT_EQ(skel->bss->t3_c_a, 2, "t3:c.a");
+	ASSERT_EQ(skel->bss->t3_c_b, 3, "t3:c.b");
+
+	ASSERT_EQ(skel->bss->t4_a_a, 10, "t4:a.a");
+	ASSERT_EQ(skel->bss->t4_b, 1, "t4:b");
+	ASSERT_EQ(skel->bss->t4_c, 2, "t4:c");
+	ASSERT_EQ(skel->bss->t4_d, 3, "t4:d");
+	ASSERT_EQ(skel->bss->t4_e_a, 2, "t4:e.a");
+	ASSERT_EQ(skel->bss->t4_e_b, 3, "t4:e.b");
+
+	tracing_struct__detach(skel);
+	tracing_struct__destroy(skel);
+}
+
+void test_tracing_struct(void)
+{
+	test_fentry();
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct.c b/tools/t=
esting/selftests/bpf/progs/tracing_struct.c
new file mode 100644
index 000000000000..8c2591aa93c3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_struct.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+struct bpf_testmod_struct_arg_1 {
+        int a;
+};
+struct bpf_testmod_struct_arg_2 {
+        long a;
+        long b;
+};
+
+long t1_a_a, t1_a_b, t1_b, t1_c;
+long t2_a, t2_b_a, t2_b_b, t2_c;
+long t3_a, t3_b, t3_c_a, t3_c_b;
+long t4_a_a, t4_b, t4_c, t4_d, t4_e_a, t4_e_b;
+
+SEC("fentry/bpf_testmod_test_struct_arg_1")
+int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 *a, int =
b, int c)
+{
+	t1_a_a =3D a->a;
+	t1_a_b =3D a->b;
+	t1_b =3D b;
+	t1_c =3D c;
+	return 0;
+}
+
+SEC("fentry/bpf_testmod_test_struct_arg_2")
+int BPF_PROG(test_struct_arg_2, int a, struct bpf_testmod_struct_arg_2 *=
b, int c)
+{
+	t2_a =3D a;
+	t2_b_a =3D b->a;
+	t2_b_b =3D b->b;
+	t2_c =3D c;
+	return 0;
+}
+
+SEC("fentry/bpf_testmod_test_struct_arg_3")
+int BPF_PROG(test_struct_arg_3, int a, int b, struct bpf_testmod_struct_=
arg_2 *c)
+{
+	t3_a =3D a;
+	t3_b =3D b;
+	t3_c_a =3D c->a;
+	t3_c_b =3D c->b;
+	return 0;
+}
+
+SEC("fentry/bpf_testmod_test_struct_arg_4")
+int BPF_PROG(test_struct_arg_4, struct bpf_testmod_struct_arg_1 *a, int =
b,
+	     int c, int d, struct bpf_testmod_struct_arg_2 *e)
+{
+	t4_a_a =3D a->a;
+	t4_b =3D b;
+	t4_c =3D c;
+	t4_d =3D d;
+	t4_e_a =3D e->a;
+	t4_e_b =3D e->b;
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

