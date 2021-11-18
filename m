Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1BB4562E8
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 19:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhKRSve (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 13:51:34 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17196 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232543AbhKRSve (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 13:51:34 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIIbfKj002368
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 10:48:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=FAxWdwWQsrktRMFgbK+/55xuZOUT4Tpw+PkKhDbiN+Q=;
 b=Kn2Tg81LhLgRwBKlqmuufQQh6LOsQvNacw5QH121n7Srh8ibQBBMpVEeuAZ9sQSjCvdR
 +VF86ocUMGQqrC1dmxMbmjWRBEPoDVF9sXFCKjAKp/0MK9kyrwvrBq0TdQoTnAZD0dra
 5SPmFwzsD83WpVF9r9J4ME2j5tJronseXbE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cdmp0ks3y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 10:48:33 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 10:48:31 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id AA71C29A3F74; Thu, 18 Nov 2021 10:48:26 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next v2 3/3] selftests/bpf: add a selftest with __user tag
Date:   Thu, 18 Nov 2021 10:48:26 -0800
Message-ID: <20211118184826.1849860-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211118184810.1846996-1-yhs@fb.com>
References: <20211118184810.1846996-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: j6kLrwomeCI-9HYTNkpcvj2SN8NmYPNG
X-Proofpoint-ORIG-GUID: j6kLrwomeCI-9HYTNkpcvj2SN8NmYPNG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added a selftest where the argument is a pointer with __user tag.
Directly accessing its field without helper will result
verification failure.
  $ ./test_progs -v -n 21/3
  ...
  Successfully loaded bpf_testmod.ko.
  test_btf_type_tag_user:PASS:btf_type_tag_user 0 nsec
  libbpf: load bpf program failed: Permission denied
  libbpf: -- BEGIN DUMP LOG ---
  libbpf:
  R1 type=3Dctx expected=3Dfp
  ; int BPF_PROG(sub, struct bpf_testmod_btf_type_tag *arg)
  0: (79) r1 =3D *(u64 *)(r1 +0)
  func 'bpf_testmod_test_btf_type_tag_user' arg0 accesses user memory
  invalid bpf_context access off=3D0 size=3D8
  processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
  ...
  test_btf_type_tag_user:PASS:btf_type_tag_user 0 nsec
  #21/3 btf_tag/btf_type_tag_user:OK
  #21 btf_tag:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
  Successfully unloaded bpf_testmod.ko.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c                         |  1 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  9 +++++++
 .../selftests/bpf/prog_tests/btf_tag.c        | 23 ++++++++++++++++++
 .../selftests/bpf/progs/btf_type_tag_user.c   | 24 +++++++++++++++++++
 4 files changed, 57 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag_user.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 07ba7c8f6aa3..71fd66b53026 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4372,6 +4372,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 		enum bpf_reg_type reg_type =3D SCALAR_VALUE;
 		struct btf *btf =3D NULL;
 		u32 btf_id =3D 0;
+		bool is_user;
=20
 		if (t =3D=3D BPF_WRITE && value_regno >=3D 0 &&
 		    is_pointer_value(env, value_regno)) {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 5d52ea2768df..5377dd2959bb 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -21,6 +21,15 @@ bpf_testmod_test_mod_kfunc(int i)
 	*(int *)this_cpu_ptr(&bpf_testmod_ksym_percpu) =3D i;
 }
=20
+struct bpf_testmod_btf_type_tag {
+	int a;
+};
+
+noinline int
+bpf_testmod_test_btf_type_tag_user(struct bpf_testmod_btf_type_tag __use=
r *arg) {
+	return arg->a;
+}
+
 noinline int bpf_testmod_loop_test(int n)
 {
 	int i, sum =3D 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_tag.c b/tools/tes=
ting/selftests/bpf/prog_tests/btf_tag.c
index 88d63e23e35f..1e4003fa7cd0 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_tag.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
@@ -8,6 +8,7 @@ struct btf_type_tag_test {
         int **p;
 };
 #include "btf_type_tag.skel.h"
+#include "btf_type_tag_user.skel.h"
=20
 static void test_btf_decl_tag(void)
 {
@@ -41,10 +42,32 @@ static void test_btf_type_tag(void)
 	btf_type_tag__destroy(skel);
 }
=20
+static void test_btf_type_tag_user(void)
+{
+	struct btf_type_tag_user *skel;
+	int err;
+
+	skel =3D btf_type_tag_user__open();
+	if (!ASSERT_OK_PTR(skel, "btf_type_tag_user"))
+		return;
+
+	if (skel->rodata->skip_tests) {
+		printf("%s:SKIP: btf_type_tag attribute not supported", __func__);
+		test__skip();
+	} else {
+		err =3D btf_type_tag_user__load(skel);
+		ASSERT_ERR(err, "btf_type_tag_user");
+	}
+
+	btf_type_tag_user__destroy(skel);
+}
+
 void test_btf_tag(void)
 {
 	if (test__start_subtest("btf_decl_tag"))
 		test_btf_decl_tag();
 	if (test__start_subtest("btf_type_tag"))
 		test_btf_type_tag();
+	if (test__start_subtest("btf_type_tag_user"))
+		test_btf_type_tag_user();
 }
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_user.c b/tool=
s/testing/selftests/bpf/progs/btf_type_tag_user.c
new file mode 100644
index 000000000000..41ab1ddd2cf5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_user.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#if __has_attribute(btf_type_tag)
+volatile const bool skip_tests =3D false;
+#else
+volatile const bool skip_tests =3D true;
+#endif
+
+struct bpf_testmod_btf_type_tag {
+	int a;
+};
+
+int g;
+
+SEC("fentry/bpf_testmod_test_btf_type_tag_user")
+int BPF_PROG(sub, struct bpf_testmod_btf_type_tag *arg)
+{
+  g =3D arg->a;
+  return 0;
+}
--=20
2.30.2

