Return-Path: <bpf+bounces-16404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8772E8010B6
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0D3281C21
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 17:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FE74D58D;
	Fri,  1 Dec 2023 17:06:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62872F3
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 09:06:37 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1GVrs7017956
	for <bpf@vger.kernel.org>; Fri, 1 Dec 2023 09:06:36 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uqf8shrrq-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 09:06:36 -0800
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 09:06:34 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 42C953C6CCB06; Fri,  1 Dec 2023 09:06:09 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next] selftests/bpf: validate eliminated global subprog is not freplaceable
Date: Fri, 1 Dec 2023 09:06:09 -0800
Message-ID: <20231201170609.1187520-1-andrii@kernel.org>
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
X-Proofpoint-GUID: UnTv5BUNc70BUgRHDtt97VlmaFDLicvV
X-Proofpoint-ORIG-GUID: UnTv5BUNc70BUgRHDtt97VlmaFDLicvV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_15,2023-11-30_01,2023-05-22_02

Add selftest that establishes dead code-eliminated valid global subprog
(global_dead) and makes sure that it's not possible to freplace it, as
it's effectively not there. This test will fail with unexpected success
before 2afae08c9dcb ("bpf: Validate global subprogs lazily").

v1->v2:
  - don't rely on assembly output in verifier log, which changes between
    compiler versions (CI).

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/global_func_dead_code.c    | 60 +++++++++++++++++++
 .../bpf/progs/freplace_dead_global_func.c     | 11 ++++
 .../bpf/progs/verifier_global_subprogs.c      | 33 ++++++----
 3 files changed, 92 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_func_de=
ad_code.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_dead_globa=
l_func.c

diff --git a/tools/testing/selftests/bpf/prog_tests/global_func_dead_code=
.c b/tools/testing/selftests/bpf/prog_tests/global_func_dead_code.c
new file mode 100644
index 000000000000..d873eb20dd7c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/global_func_dead_code.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "verifier_global_subprogs.skel.h"
+#include "freplace_dead_global_func.skel.h"
+
+void test_global_func_dead_code(void)
+{
+	struct verifier_global_subprogs *tgt_skel =3D NULL;
+	struct freplace_dead_global_func *skel =3D NULL;
+	char log_buf[4096];
+	int err, tgt_fd;
+
+	/* first, try to load target with good global subprog */
+	tgt_skel =3D verifier_global_subprogs__open();
+	if (!ASSERT_OK_PTR(tgt_skel, "tgt_skel_good_open"))
+		return;
+
+	bpf_program__set_autoload(tgt_skel->progs.chained_global_func_calls_suc=
cess, true);
+
+	err =3D verifier_global_subprogs__load(tgt_skel);
+	if (!ASSERT_OK(err, "tgt_skel_good_load"))
+		goto out;
+
+	tgt_fd =3D bpf_program__fd(tgt_skel->progs.chained_global_func_calls_su=
ccess);
+
+	/* Attach to good non-eliminated subprog */
+	skel =3D freplace_dead_global_func__open();
+	if (!ASSERT_OK_PTR(skel, "skel_good_open"))
+		goto out;
+
+	bpf_program__set_attach_target(skel->progs.freplace_prog, tgt_fd, "glob=
al_good");
+	ASSERT_OK(err, "attach_target_good");
+
+	err =3D freplace_dead_global_func__load(skel);
+	if (!ASSERT_OK(err, "skel_good_load"))
+		goto out;
+
+	freplace_dead_global_func__destroy(skel);
+
+	/* Try attaching to dead code-eliminated subprog */
+	skel =3D freplace_dead_global_func__open();
+	if (!ASSERT_OK_PTR(skel, "skel_dead_open"))
+		goto out;
+
+	bpf_program__set_log_buf(skel->progs.freplace_prog, log_buf, sizeof(log=
_buf));
+	err =3D bpf_program__set_attach_target(skel->progs.freplace_prog, tgt_f=
d, "global_dead");
+	ASSERT_OK(err, "attach_target_dead");
+
+	err =3D freplace_dead_global_func__load(skel);
+	if (!ASSERT_ERR(err, "skel_dead_load"))
+		goto out;
+
+	ASSERT_HAS_SUBSTR(log_buf, "Subprog global_dead doesn't exist", "dead_s=
ubprog_missing_msg");
+
+out:
+	verifier_global_subprogs__destroy(tgt_skel);
+	freplace_dead_global_func__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/freplace_dead_global_func.=
c b/tools/testing/selftests/bpf/progs/freplace_dead_global_func.c
new file mode 100644
index 000000000000..808738eac578
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_dead_global_func.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("freplace")
+int freplace_prog(int x)
+{
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c=
 b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index a0a5efd1caa1..8ddc2f354be9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -10,50 +10,59 @@
=20
 int arr[1];
 int unkn_idx;
+const volatile bool call_dead_subprog =3D false;
=20
-__noinline long global_bad(void)
+__noinline long global_bad(int x)
 {
-	return arr[unkn_idx]; /* BOOM */
+	return arr[unkn_idx] + x; /* BOOM */
 }
=20
-__noinline long global_good(void)
+__noinline long global_good(int x)
 {
-	return arr[0];
+	return arr[0] + x;
 }
=20
-__noinline long global_calls_bad(void)
+__noinline long global_calls_bad(int x)
 {
-	return global_good() + global_bad() /* does BOOM indirectly */;
+	return global_good(x) + global_bad(x) /* does BOOM indirectly */;
 }
=20
-__noinline long global_calls_good_only(void)
+__noinline long global_calls_good_only(int x)
 {
-	return global_good();
+	return global_good(x);
+}
+
+__noinline long global_dead(int x)
+{
+	return x * 2;
 }
=20
 SEC("?raw_tp")
 __success __log_level(2)
 /* main prog is validated completely first */
 __msg("('global_calls_good_only') is global and assumed valid.")
-__msg("1: (95) exit")
 /* eventually global_good() is transitively validated as well */
 __msg("Validating global_good() func")
 __msg("('global_good') is safe for any args that match its prototype")
 int chained_global_func_calls_success(void)
 {
-	return global_calls_good_only();
+	int sum =3D 0;
+
+	if (call_dead_subprog)
+		sum +=3D global_dead(42);
+	return global_calls_good_only(42) + sum;
 }
=20
 SEC("?raw_tp")
 __failure __log_level(2)
 /* main prog validated successfully first */
-__msg("1: (95) exit")
+__msg("('global_calls_bad') is global and assumed valid.")
 /* eventually we validate global_bad() and fail */
 __msg("Validating global_bad() func")
 __msg("math between map_value pointer and register") /* BOOM */
 int chained_global_func_calls_bad(void)
 {
-	return global_calls_bad();
+	return global_calls_bad(13);
 }
=20
 /* do out of bounds access forcing verifier to fail verification if this
--=20
2.34.1


