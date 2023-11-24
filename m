Return-Path: <bpf+bounces-15795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322E47F6B15
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 05:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8603B2100E
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 04:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51121139D;
	Fri, 24 Nov 2023 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF91D6E
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 19:59:58 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO3Agqf020592
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 19:59:57 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ujkae868q-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 19:59:57 -0800
Received: from twshared4634.37.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 19:59:54 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id E3D953C057954; Thu, 23 Nov 2023 19:59:44 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 3/3] selftests/bpf: add lazy global subprog validation tests
Date: Thu, 23 Nov 2023 19:59:37 -0800
Message-ID: <20231124035937.403208-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124035937.403208-1-andrii@kernel.org>
References: <20231124035937.403208-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -pXiKrbjRQbRHVPpyfZQJcUlsU1aowZg
X-Proofpoint-ORIG-GUID: -pXiKrbjRQbRHVPpyfZQJcUlsU1aowZg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02

Add a few test that validate BPF verifier's lazy approach to validating
global subprogs.

We check that global subprogs that are called transitively through
another global subprog is validated.

We also check that invalid global subprog is not validated, if it's not
called from the main program.

And we also check that main program is always validated first, before
any of the subprogs.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_global_subprogs.c      | 92 +++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_global_sub=
progs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index 5cfa7a6316b6..8d746642cbd7 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -25,6 +25,7 @@
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
 #include "verifier_div_overflow.skel.h"
+#include "verifier_global_subprogs.skel.h"
 #include "verifier_gotol.skel.h"
 #include "verifier_helper_access_var_len.skel.h"
 #include "verifier_helper_packet_access.skel.h"
@@ -134,6 +135,7 @@ void test_verifier_direct_packet_access(void) { RUN(v=
erifier_direct_packet_acces
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_d=
irect_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflo=
w); }
+void test_verifier_global_subprogs(void)      { RUN(verifier_global_subp=
rogs); }
 void test_verifier_gotol(void)                { RUN(verifier_gotol); }
 void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_acc=
ess_var_len); }
 void test_verifier_helper_packet_access(void) { RUN(verifier_helper_pack=
et_access); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c=
 b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
new file mode 100644
index 000000000000..a0a5efd1caa1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <stdbool.h>
+#include <errno.h>
+#include <string.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+int arr[1];
+int unkn_idx;
+
+__noinline long global_bad(void)
+{
+	return arr[unkn_idx]; /* BOOM */
+}
+
+__noinline long global_good(void)
+{
+	return arr[0];
+}
+
+__noinline long global_calls_bad(void)
+{
+	return global_good() + global_bad() /* does BOOM indirectly */;
+}
+
+__noinline long global_calls_good_only(void)
+{
+	return global_good();
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+/* main prog is validated completely first */
+__msg("('global_calls_good_only') is global and assumed valid.")
+__msg("1: (95) exit")
+/* eventually global_good() is transitively validated as well */
+__msg("Validating global_good() func")
+__msg("('global_good') is safe for any args that match its prototype")
+int chained_global_func_calls_success(void)
+{
+	return global_calls_good_only();
+}
+
+SEC("?raw_tp")
+__failure __log_level(2)
+/* main prog validated successfully first */
+__msg("1: (95) exit")
+/* eventually we validate global_bad() and fail */
+__msg("Validating global_bad() func")
+__msg("math between map_value pointer and register") /* BOOM */
+int chained_global_func_calls_bad(void)
+{
+	return global_calls_bad();
+}
+
+/* do out of bounds access forcing verifier to fail verification if this
+ * global func is called
+ */
+__noinline int global_unsupp(const int *mem)
+{
+	if (!mem)
+		return 0;
+	return mem[100]; /* BOOM */
+}
+
+const volatile bool skip_unsupp_global =3D true;
+
+SEC("?raw_tp")
+__success
+int guarded_unsupp_global_called(void)
+{
+	if (!skip_unsupp_global)
+		return global_unsupp(NULL);
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __log_level(2)
+__msg("Func#1 ('global_unsupp') is global and assumed valid.")
+__msg("Validating global_unsupp() func#1...")
+__msg("value is outside of the allowed memory range")
+int unguarded_unsupp_global_called(void)
+{
+	int x =3D 0;
+
+	return global_unsupp(&x);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


