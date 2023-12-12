Return-Path: <bpf+bounces-17619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA8880FB56
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AC8281103
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99B364CE7;
	Tue, 12 Dec 2023 23:26:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B29DB2
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:26:12 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3BCLfTIR009891
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:26:11 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3uxq0ucsbv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:26:11 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 15:26:09 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2EF613D0C8A6F; Tue, 12 Dec 2023 15:25:58 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 10/10] selftests/bpf: add freplace of BTF-unreliable main prog test
Date: Tue, 12 Dec 2023 15:25:35 -0800
Message-ID: <20231212232535.1875938-11-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212232535.1875938-1-andrii@kernel.org>
References: <20231212232535.1875938-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UnhgE0KkhLTeGHEexe4Fr_oIna1zih1I
X-Proofpoint-ORIG-GUID: UnhgE0KkhLTeGHEexe4Fr_oIna1zih1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02

Add a test validating that freplace'ing another main (entry) BPF program
fails if the target BPF program doesn't have valid/expected func proto BT=
F.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 14 +++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../bpf/progs/freplace_unreliable_prog.c      | 20 +++++++++++++++++++
 .../bpf/progs/verifier_btf_unreliable_prog.c  | 20 +++++++++++++++++++
 4 files changed, 56 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_unreliable=
_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_btf_unreli=
able_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 8ec73fdfcdab..39ce45337e7d 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -374,6 +374,9 @@ static void test_obj_load_failure_common(const char *=
obj_file,
 	err =3D bpf_program__set_attach_target(prog, pkt_fd, NULL);
 	ASSERT_OK(err, "set_attach_target");
=20
+	if (env.verbosity > VERBOSE_NONE)
+		bpf_program__set_log_level(prog, 2);
+
 	/* It should fail to load the program */
 	err =3D bpf_object__load(obj);
 	if (CHECK(!err, "bpf_obj_load should fail", "err %d\n", err))
@@ -398,6 +401,15 @@ static void test_func_map_prog_compatibility(void)
 				     "./test_attach_probe.bpf.o");
 }
=20
+static void test_func_replace_unreliable(void)
+{
+	/* freplace'ing unreliable main prog should fail with error
+	 * "Cannot replace static functions"
+	 */
+	test_obj_load_failure_common("freplace_unreliable_prog.bpf.o",
+				     "./verifier_btf_unreliable_prog.bpf.o");
+}
+
 static void test_func_replace_global_func(void)
 {
 	const char *prog_name[] =3D {
@@ -563,6 +575,8 @@ void serial_test_fexit_bpf2bpf(void)
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
index 8d746642cbd7..1174a303e075 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -13,6 +13,7 @@
 #include "verifier_bpf_get_stack.skel.h"
 #include "verifier_bswap.skel.h"
 #include "verifier_btf_ctx_access.skel.h"
+#include "verifier_btf_unreliable_prog.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
 #include "verifier_cgroup_skb.skel.h"
@@ -123,6 +124,7 @@ void test_verifier_bounds_mix_sign_unsign(void) { RUN=
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


