Return-Path: <bpf+bounces-17423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2D780D446
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 18:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FA92820FB
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A48B4E633;
	Mon, 11 Dec 2023 17:41:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93409E8
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 09:41:46 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBEMpE2006734
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 09:41:46 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uvmepdn2a-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 09:41:45 -0800
Received: from twshared19982.14.prn3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 11 Dec 2023 09:41:42 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B196E3CF72064; Mon, 11 Dec 2023 09:41:32 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next] selftests/bpf: validate eliminated global subprog is not freplaceable
Date: Mon, 11 Dec 2023 09:41:31 -0800
Message-ID: <20231211174131.2324306-1-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: Ha30t2o5qmE7AsIg3B2_SmZ5Rcp10Pkp
X-Proofpoint-GUID: Ha30t2o5qmE7AsIg3B2_SmZ5Rcp10Pkp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_07,2023-12-07_01,2023-05-22_02

Add selftest that establishes dead code-eliminated valid global subprog
(global_dead) and makes sure that it's not possible to freplace it, as
it's effectively not there. This test will fail with unexpected success
before 2afae08c9dcb ("bpf: Validate global subprogs lazily").

v2->v3:
  - add missing err assignment (Alan);
  - undo unnecessary signature changes in verifier_global_subprogs.c (Edu=
ard);
v1->v2:
  - don't rely on assembly output in verifier log, which changes between
    compiler versions (CI).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/global_func_dead_code.c    | 60 +++++++++++++++++++
 .../bpf/progs/freplace_dead_global_func.c     | 11 ++++
 .../bpf/progs/verifier_global_subprogs.c      | 15 ++++-
 3 files changed, 83 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_func_de=
ad_code.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_dead_globa=
l_func.c

diff --git a/tools/testing/selftests/bpf/prog_tests/global_func_dead_code=
.c b/tools/testing/selftests/bpf/prog_tests/global_func_dead_code.c
new file mode 100644
index 000000000000..65309894b27a
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
+	err =3D bpf_program__set_attach_target(skel->progs.freplace_prog, tgt_f=
d, "global_good");
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
index 000000000000..e6a75f86cac6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_dead_global_func.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("freplace")
+int freplace_prog(void)
+{
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c=
 b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index a0a5efd1caa1..bd696a431244 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -10,6 +10,7 @@
=20
 int arr[1];
 int unkn_idx;
+const volatile bool call_dead_subprog =3D false;
=20
 __noinline long global_bad(void)
 {
@@ -31,23 +32,31 @@ __noinline long global_calls_good_only(void)
 	return global_good();
 }
=20
+__noinline long global_dead(void)
+{
+	return arr[0] * 2;
+}
+
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
+		sum +=3D global_dead();
+	return global_calls_good_only() + sum;
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
--=20
2.34.1


