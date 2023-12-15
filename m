Return-Path: <bpf+bounces-17922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27B4813F12
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4811F22CC0
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B315390;
	Fri, 15 Dec 2023 01:14:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDFD7E4
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEMD3fp028286
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 17:14:15 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uynm6gugu-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 17:14:14 -0800
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 14 Dec 2023 17:14:09 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id D247A3D2CCFCD; Thu, 14 Dec 2023 17:13:55 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 10/10] selftests/bpf: add freplace of BTF-unreliable main prog test
Date: Thu, 14 Dec 2023 17:13:34 -0800
Message-ID: <20231215011334.2307144-11-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215011334.2307144-1-andrii@kernel.org>
References: <20231215011334.2307144-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nJd6LU_ExIFqIoNh7aUUAeR0Qet3uwc7
X-Proofpoint-ORIG-GUID: nJd6LU_ExIFqIoNh7aUUAeR0Qet3uwc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_17,2023-12-14_01,2023-05-22_02

Add a test validating that freplace'ing another main (entry) BPF program
fails if the target BPF program doesn't have valid/expected func proto BT=
F.

We extend fexit_bpf2bpf test to allow to specify expected log message
for negative test cases (where freplace program is expected to fail to
load).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 30 +++++++++++++++++--
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../bpf/progs/freplace_unreliable_prog.c      | 20 +++++++++++++
 .../bpf/progs/verifier_btf_unreliable_prog.c  | 20 +++++++++++++
 4 files changed, 69 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_unreliable=
_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_btf_unreli=
able_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 8ec73fdfcdab..f29fc789c14b 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -348,7 +348,8 @@ static void test_func_sockmap_update(void)
 }
=20
 static void test_obj_load_failure_common(const char *obj_file,
-					 const char *target_obj_file)
+					 const char *target_obj_file,
+					 const char *exp_msg)
 {
 	/*
 	 * standalone test that asserts failure to load freplace prog
@@ -356,6 +357,7 @@ static void test_obj_load_failure_common(const char *=
obj_file,
 	 */
 	struct bpf_object *obj =3D NULL, *pkt_obj;
 	struct bpf_program *prog;
+	char log_buf[64 * 1024];
 	int err, pkt_fd;
 	__u32 duration =3D 0;
=20
@@ -374,11 +376,21 @@ static void test_obj_load_failure_common(const char=
 *obj_file,
 	err =3D bpf_program__set_attach_target(prog, pkt_fd, NULL);
 	ASSERT_OK(err, "set_attach_target");
=20
+	log_buf[0] =3D '\0';
+	if (exp_msg)
+		bpf_program__set_log_buf(prog, log_buf, sizeof(log_buf));
+	if (env.verbosity > VERBOSE_NONE)
+		bpf_program__set_log_level(prog, 2);
+
 	/* It should fail to load the program */
 	err =3D bpf_object__load(obj);
+	if (env.verbosity > VERBOSE_NONE && exp_msg) /* we overtook log */
+		printf("VERIFIER LOG:\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
\n%s\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n", log_buf);
 	if (CHECK(!err, "bpf_obj_load should fail", "err %d\n", err))
 		goto close_prog;
=20
+	if (exp_msg)
+		ASSERT_HAS_SUBSTR(log_buf, exp_msg, "fail_msg");
 close_prog:
 	bpf_object__close(obj);
 	bpf_object__close(pkt_obj);
@@ -388,14 +400,24 @@ static void test_func_replace_return_code(void)
 {
 	/* test invalid return code in the replaced program */
 	test_obj_load_failure_common("./freplace_connect_v4_prog.bpf.o",
-				     "./connect4_prog.bpf.o");
+				     "./connect4_prog.bpf.o", NULL);
 }
=20
 static void test_func_map_prog_compatibility(void)
 {
 	/* test with spin lock map value in the replaced program */
 	test_obj_load_failure_common("./freplace_attach_probe.bpf.o",
-				     "./test_attach_probe.bpf.o");
+				     "./test_attach_probe.bpf.o", NULL);
+}
+
+static void test_func_replace_unreliable(void)
+{
+	/* freplace'ing unreliable main prog should fail with error
+	 * "Cannot replace static functions"
+	 */
+	test_obj_load_failure_common("freplace_unreliable_prog.bpf.o",
+				     "./verifier_btf_unreliable_prog.bpf.o",
+				     "Cannot replace static functions");
 }
=20
 static void test_func_replace_global_func(void)
@@ -563,6 +585,8 @@ void serial_test_fexit_bpf2bpf(void)
 		test_func_replace_return_code();
 	if (test__start_subtest("func_map_prog_compatibility"))
 		test_func_map_prog_compatibility();
+	if (test__start_subtest("func_replace_unreliable"))
+		test_func_replace_unreliable();
 	if (test__start_subtest("func_replace_multi"))
 		test_func_replace_multi();
 	if (test__start_subtest("fmod_ret_freplace"))
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index ac49ec25211d..d62c5bf00e71 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -14,6 +14,7 @@
 #include "verifier_bpf_get_stack.skel.h"
 #include "verifier_bswap.skel.h"
 #include "verifier_btf_ctx_access.skel.h"
+#include "verifier_btf_unreliable_prog.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
 #include "verifier_cgroup_skb.skel.h"
@@ -125,6 +126,7 @@ void test_verifier_bounds_mix_sign_unsign(void) { RUN=
(verifier_bounds_mix_sign_u
 void test_verifier_bpf_get_stack(void)        { RUN(verifier_bpf_get_sta=
ck); }
 void test_verifier_bswap(void)                { RUN(verifier_bswap); }
 void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_acc=
ess); }
+void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unrelia=
ble_prog); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_=
retcode); }
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb)=
; }
diff --git a/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c=
 b/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
new file mode 100644
index 000000000000..624078abf3de
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("freplace/btf_unreliable_kprobe")
+/* context type is what BPF verifier expects for kprobe context, but tar=
get
+ * program has `stuct whatever *ctx` argument, so freplace operation wil=
l be
+ * rejected with the following message:
+ *
+ * arg0 replace_btf_unreliable_kprobe(struct pt_regs *) doesn't match bt=
f_unreliable_kprobe(struct whatever *)
+ */
+int replace_btf_unreliable_kprobe(bpf_user_pt_regs_t *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_unreliable_pr=
og.c b/tools/testing/selftests/bpf/progs/verifier_btf_unreliable_prog.c
new file mode 100644
index 000000000000..36e033a2e02c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_unreliable_prog.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Facebook
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+struct whatever {};
+
+SEC("kprobe")
+__success __log_level(2)
+/* context type is wrong, making it impossible to freplace this program =
*/
+int btf_unreliable_kprobe(struct whatever *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


