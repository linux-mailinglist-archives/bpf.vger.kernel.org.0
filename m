Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089B45A3B22
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 04:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiH1CzT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 22:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiH1CzS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 22:55:18 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67324949
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:55:16 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27S2t2A4010423
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:55:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=M5n3Rikr1uZuNWpuqYHV6VQnheZnj89RgmNEMGSYDjg=;
 b=quFTurAC6gdE3P3LLoNi7dOZBFH+SubuYpFSLQm5VKyK11v9Gj896h0SfWsbCdPDlcfi
 fibwaWIDYsdUXb8mJP6uGHrQUYVX4BnV2otvGHYwK+uk5WJoM89bHBzVru41biztDIEu
 1zCV+0G8k1Q3KCZqmX/w4N6g1CwL0MK2WRg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7h0ytv8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:55:15 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 27 Aug 2022 19:55:14 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id DC196EA74845; Sat, 27 Aug 2022 19:55:09 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 6/7] selftests/bpf: Add struct argument tests with fentry/fexit programs.
Date:   Sat, 27 Aug 2022 19:55:09 -0700
Message-ID: <20220828025509.145209-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220828025438.142798-1-yhs@fb.com>
References: <20220828025438.142798-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aNXmbPzSqnBC0GORivr6duUf9BDZZ7Rs
X-Proofpoint-ORIG-GUID: aNXmbPzSqnBC0GORivr6duUf9BDZZ7Rs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add various struct argument tests with fentry/fexit programs.
Also add one test with a kernel func which does not have any
argument to test BPF_PROG2 macro in such situation.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  48 ++++++++
 .../selftests/bpf/prog_tests/tracing_struct.c |  63 ++++++++++
 .../selftests/bpf/progs/tracing_struct.c      | 114 ++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_struct=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 792cb15bac40..a6021d6117b5 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -18,6 +18,46 @@ typedef int (*func_proto_typedef_nested1)(func_proto_t=
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
+noinline int
+bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int b, =
int c) {
+	bpf_testmod_test_struct_arg_result =3D a.a + a.b  + b + c;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_test_struct_arg_2(int a, struct bpf_testmod_struct_arg_2 b, =
int c) {
+	bpf_testmod_test_struct_arg_result =3D a + b.a + b.b + c;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_test_struct_arg_3(int a, int b, struct bpf_testmod_struct_ar=
g_2 c) {
+	bpf_testmod_test_struct_arg_result =3D a + b + c.a + c.b;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_test_struct_arg_4(struct bpf_testmod_struct_arg_1 a, int b,
+			      int c, int d, struct bpf_testmod_struct_arg_2 e) {
+	bpf_testmod_test_struct_arg_result =3D a.a + b + c + d + e.a + e.b;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+noinline int
+bpf_testmod_test_struct_arg_5(void) {
+	bpf_testmod_test_struct_arg_result =3D 1;
+	return bpf_testmod_test_struct_arg_result;
+}
=20
 noinline void
 bpf_testmod_test_mod_kfunc(int i)
@@ -98,11 +138,19 @@ bpf_testmod_test_read(struct file *file, struct kobj=
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
+	(void)bpf_testmod_test_struct_arg_1(struct_arg2, 1, 4);
+	(void)bpf_testmod_test_struct_arg_2(1, struct_arg2, 4);
+	(void)bpf_testmod_test_struct_arg_3(1, 4, struct_arg2);
+	(void)bpf_testmod_test_struct_arg_4(struct_arg1, 1, 2, 3, struct_arg2);
+	(void)bpf_testmod_test_struct_arg_5();
+
 	/* This is always true. Use the check to make sure the compiler
 	 * doesn't remove bpf_testmod_loop_test.
 	 */
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/to=
ols/testing/selftests/bpf/prog_tests/tracing_struct.c
new file mode 100644
index 000000000000..d5022b91d1e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -0,0 +1,63 @@
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
+	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
+
+	ASSERT_EQ(skel->bss->t1_a_a, 2, "t1:a.a");
+	ASSERT_EQ(skel->bss->t1_a_b, 3, "t1:a.b");
+	ASSERT_EQ(skel->bss->t1_b, 1, "t1:b");
+	ASSERT_EQ(skel->bss->t1_c, 4, "t1:c");
+
+	ASSERT_EQ(skel->bss->t1_nregs, 4, "t1 nregs");
+	ASSERT_EQ(skel->bss->t1_reg0, 2, "t1 reg0");
+	ASSERT_EQ(skel->bss->t1_reg1, 3, "t1 reg1");
+	ASSERT_EQ(skel->bss->t1_reg2, 1, "t1 reg2");
+	ASSERT_EQ(skel->bss->t1_reg3, 4, "t1 reg3");
+	ASSERT_EQ(skel->bss->t1_ret, 10, "t1 ret");
+
+	ASSERT_EQ(skel->bss->t2_a, 1, "t2:a");
+	ASSERT_EQ(skel->bss->t2_b_a, 2, "t2:b.a");
+	ASSERT_EQ(skel->bss->t2_b_b, 3, "t2:b.b");
+	ASSERT_EQ(skel->bss->t2_c, 4, "t2:c");
+	ASSERT_EQ(skel->bss->t2_ret, 10, "t2 ret");
+
+	ASSERT_EQ(skel->bss->t3_a, 1, "t3:a");
+	ASSERT_EQ(skel->bss->t3_b, 4, "t3:b");
+	ASSERT_EQ(skel->bss->t3_c_a, 2, "t3:c.a");
+	ASSERT_EQ(skel->bss->t3_c_b, 3, "t3:c.b");
+	ASSERT_EQ(skel->bss->t3_ret, 10, "t3 ret");
+
+	ASSERT_EQ(skel->bss->t4_a_a, 10, "t4:a.a");
+	ASSERT_EQ(skel->bss->t4_b, 1, "t4:b");
+	ASSERT_EQ(skel->bss->t4_c, 2, "t4:c");
+	ASSERT_EQ(skel->bss->t4_d, 3, "t4:d");
+	ASSERT_EQ(skel->bss->t4_e_a, 2, "t4:e.a");
+	ASSERT_EQ(skel->bss->t4_e_b, 3, "t4:e.b");
+	ASSERT_EQ(skel->bss->t4_ret, 21, "t4 ret");
+
+	ASSERT_EQ(skel->bss->t5_ret, 1, "t5 ret");
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
index 000000000000..26d47a0ab616
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_struct.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+struct bpf_testmod_struct_arg_1 {
+	int a;
+};
+struct bpf_testmod_struct_arg_2 {
+	long a;
+	long b;
+};
+
+long t1_a_a, t1_a_b, t1_b, t1_c, t1_ret, t1_nregs;
+__u64 t1_reg0, t1_reg1, t1_reg2, t1_reg3;
+long t2_a, t2_b_a, t2_b_b, t2_c, t2_ret;
+long t3_a, t3_b, t3_c_a, t3_c_b, t3_ret;
+long t4_a_a, t4_b, t4_c, t4_d, t4_e_a, t4_e_b, t4_ret;
+long t5_ret;
+
+SEC("fentry/bpf_testmod_test_struct_arg_1")
+int BPF_PROG2(test_struct_arg_1, struct bpf_testmod_struct_arg_2, a, int=
, b, int, c)
+{
+	t1_a_a =3D a.a;
+	t1_a_b =3D a.b;
+	t1_b =3D b;
+	t1_c =3D c;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_struct_arg_1")
+int BPF_PROG2(test_struct_arg_2, struct bpf_testmod_struct_arg_2, a, int=
, b, int, c, int, ret)
+{
+	t1_nregs =3D  bpf_get_func_arg_cnt(ctx);
+	bpf_get_func_arg(ctx, 0, &t1_reg0);
+	bpf_get_func_arg(ctx, 1, &t1_reg1);
+	bpf_get_func_arg(ctx, 2, &t1_reg2);
+	bpf_get_func_arg(ctx, 3, &t1_reg3);
+
+	t1_ret =3D ret;
+	return 0;
+}
+
+SEC("fentry/bpf_testmod_test_struct_arg_2")
+int BPF_PROG2(test_struct_arg_3, int, a, struct bpf_testmod_struct_arg_2=
, b, int, c)
+{
+	t2_a =3D a;
+	t2_b_a =3D b.a;
+	t2_b_b =3D b.b;
+	t2_c =3D c;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_struct_arg_2")
+int BPF_PROG2(test_struct_arg_4, int, a, struct bpf_testmod_struct_arg_2=
, b, int, c, int, ret)
+{
+	t2_ret =3D ret;
+	return 0;
+}
+
+SEC("fentry/bpf_testmod_test_struct_arg_3")
+int BPF_PROG2(test_struct_arg_5, int, a, int, b, struct bpf_testmod_stru=
ct_arg_2, c)
+{
+	t3_a =3D a;
+	t3_b =3D b;
+	t3_c_a =3D c.a;
+	t3_c_b =3D c.b;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_struct_arg_3")
+int BPF_PROG2(test_struct_arg_6, int, a, int, b, struct bpf_testmod_stru=
ct_arg_2, c, int, ret)
+{
+	t3_ret =3D ret;
+	return 0;
+}
+
+SEC("fentry/bpf_testmod_test_struct_arg_4")
+int BPF_PROG2(test_struct_arg_7, struct bpf_testmod_struct_arg_1, a, int=
, b,
+	     int, c, int, d, struct bpf_testmod_struct_arg_2, e)
+{
+	t4_a_a =3D a.a;
+	t4_b =3D b;
+	t4_c =3D c;
+	t4_d =3D d;
+	t4_e_a =3D e.a;
+	t4_e_b =3D e.b;
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_struct_arg_4")
+int BPF_PROG2(test_struct_arg_8, struct bpf_testmod_struct_arg_1, a, int=
, b,
+	     int, c, int, d, struct bpf_testmod_struct_arg_2, e, int, ret)
+{
+	t4_ret =3D ret;
+	return 0;
+}
+
+SEC("fentry/bpf_testmod_test_struct_arg_5")
+int BPF_PROG2(test_struct_arg_9)
+{
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_struct_arg_5")
+int BPF_PROG2(test_struct_arg_10, int, ret)
+{
+	t5_ret =3D ret;
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

