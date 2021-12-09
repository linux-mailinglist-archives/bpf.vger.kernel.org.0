Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF9046F22D
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 18:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243102AbhLIRjl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 12:39:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58056 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243110AbhLIRjl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Dec 2021 12:39:41 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9DCjGh017247
        for <bpf@vger.kernel.org>; Thu, 9 Dec 2021 09:36:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/0Gkr1k4bz8dvrIGmNRvp1XRwMYA7Ea/xdjPxvUkE1w=;
 b=cDSpsLQ5PpkGUVesYvr2YXuFEWCKzinRsDgNrZV3RAp1XnMawQg2nbKx0hhTB8VWugm/
 p7YJtEF1nwloBaAoc9EYfRN2TKviB3/QaRbJgASzaR7+Sj3qpxCGi+Z+GlZB8pz9d+mj
 A6+MVndlrb20gWRQB49+F1jB5mnCFqBsHzc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cujfx9y5t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 09:36:06 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 09:36:04 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 32BED38B9D73; Thu,  9 Dec 2021 09:35:59 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 4/5] selftests/bpf: add a selftest with __user tag
Date:   Thu, 9 Dec 2021 09:35:59 -0800
Message-ID: <20211209173559.1529291-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209173537.1525283-1-yhs@fb.com>
References: <20211209173537.1525283-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: vdG4xB-dkEQlx0Z-_o1kK50I00uYNDNx
X-Proofpoint-GUID: vdG4xB-dkEQlx0Z-_o1kK50I00uYNDNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_07,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112090090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added a selftest with two __user usages: a __user pointer-type argument
and a __user pointer-type struct member. In both cases,
directly accessing the user memory will result verification failure.

  $ ./test_progs -v -n 22/3
  ...
  libbpf: load bpf program failed: Permission denied
  libbpf: -- BEGIN DUMP LOG ---
  libbpf:
  R1 type=3Dctx expected=3Dfp
  ; int BPF_PROG(test_user1, struct bpf_testmod_btf_type_tag_1 *arg)
  0: (79) r1 =3D *(u64 *)(r1 +0)
  func 'bpf_testmod_test_btf_type_tag_user_1' arg0 has btf_id 143948 addr=
_space 1 type STRUCT 'bpf_testmod_btf_type_tag_1'
  ; g =3D arg->a;
  1: (61) r1 =3D *(u32 *)(r1 +0)
  R1 is ptr_bpf_testmod_btf_type_tag_1 access user memory: off=3D0
  ...
  #22/3 btf_tag/btf_type_tag_user_1:OK

  $ ./test_progs -v -n 22/4
  ...
  libbpf: load bpf program failed: Permission denied
  libbpf: -- BEGIN DUMP LOG ---
  libbpf:
  R1 type=3Dctx expected=3Dfp
  ; int BPF_PROG(test_user2, struct bpf_testmod_btf_type_tag_2 *arg)
  0: (79) r1 =3D *(u64 *)(r1 +0)
  func 'bpf_testmod_test_btf_type_tag_user_2' arg0 has btf_id 143950 addr=
_space 0 type STRUCT 'bpf_testmod_btf_type_tag_2'
  ; g =3D arg->p->a;
  1: (79) r1 =3D *(u64 *)(r1 +0)
  ; g =3D arg->p->a;
  2: (61) r1 =3D *(u32 *)(r1 +0)
  R1 is ptr_bpf_testmod_btf_type_tag_1 access user memory: off=3D0
  ...
  #22/4 btf_tag/btf_type_tag_user_2:OK

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 18 ++++++
 .../selftests/bpf/prog_tests/btf_tag.c        | 55 +++++++++++++++++++
 .../selftests/bpf/progs/btf_type_tag_user.c   | 29 ++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag_user.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 5d52ea2768df..119fd5ba7ce4 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -21,6 +21,24 @@ bpf_testmod_test_mod_kfunc(int i)
 	*(int *)this_cpu_ptr(&bpf_testmod_ksym_percpu) =3D i;
 }
=20
+struct bpf_testmod_btf_type_tag_1 {
+	int a;
+};
+
+struct bpf_testmod_btf_type_tag_2 {
+	struct bpf_testmod_btf_type_tag_1 __user *p;
+};
+
+noinline int
+bpf_testmod_test_btf_type_tag_user_1(struct bpf_testmod_btf_type_tag_1 _=
_user *arg) {
+	return arg->a;
+}
+
+noinline int
+bpf_testmod_test_btf_type_tag_user_2(struct bpf_testmod_btf_type_tag_2 *=
arg) {
+	return arg->p->a;
+}
+
 noinline int bpf_testmod_loop_test(int n)
 {
 	int i, sum =3D 0;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_tag.c b/tools/tes=
ting/selftests/bpf/prog_tests/btf_tag.c
index c4cf27777ff7..794752265ede 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_tag.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
 #include <test_progs.h>
+#include <bpf/btf.h>
 #include "test_btf_decl_tag.skel.h"
=20
 /* struct btf_type_tag_test is referenced in btf_type_tag.skel.h */
@@ -8,6 +9,7 @@ struct btf_type_tag_test {
         int **p;
 };
 #include "btf_type_tag.skel.h"
+#include "btf_type_tag_user.skel.h"
=20
 static void test_btf_decl_tag(void)
 {
@@ -41,10 +43,63 @@ static void test_btf_type_tag(void)
 	btf_type_tag__destroy(skel);
 }
=20
+static void test_btf_type_tag_user(bool load_test_user1)
+{
+	const char *module_name =3D "bpf_testmod";
+	struct btf *vmlinux_btf, *module_btf;
+	struct btf_type_tag_user *skel;
+	__s32 type_id;
+	int err;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	/* skip the test is the module does not have __user tags */
+	vmlinux_btf =3D btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "could not load vmlinux BTF"))
+		return;
+
+	module_btf =3D btf__load_module_btf(module_name, vmlinux_btf);
+	if (!ASSERT_OK_PTR(module_btf, "could not load module BTF"))
+		goto free_vmlinux_btf;
+
+	type_id =3D btf__find_by_name_kind(module_btf, "user", BTF_KIND_TYPE_TA=
G);
+	if (type_id <=3D 0) {
+		printf("%s:SKIP: btf_type_tag attribute not in %s", __func__, module_n=
ame);
+		test__skip();
+		goto free_module_btf;
+	}
+
+	skel =3D btf_type_tag_user__open();
+	if (!ASSERT_OK_PTR(skel, "btf_type_tag_user"))
+		goto free_module_btf;
+
+	if (load_test_user1)
+		bpf_program__set_autoload(skel->progs.test_user2, false);
+	else
+		bpf_program__set_autoload(skel->progs.test_user1, false);
+
+	err =3D btf_type_tag_user__load(skel);
+	ASSERT_ERR(err, "btf_type_tag_user");
+
+	btf_type_tag_user__destroy(skel);
+
+free_module_btf:
+	btf__free(module_btf);
+free_vmlinux_btf:
+	btf__free(vmlinux_btf);
+}
+
 void test_btf_tag(void)
 {
 	if (test__start_subtest("btf_decl_tag"))
 		test_btf_decl_tag();
 	if (test__start_subtest("btf_type_tag"))
 		test_btf_type_tag();
+	if (test__start_subtest("btf_type_tag_user_1"))
+		test_btf_type_tag_user(true);
+	if (test__start_subtest("btf_type_tag_user_2"))
+		test_btf_type_tag_user(false);
 }
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_user.c b/tool=
s/testing/selftests/bpf/progs/btf_type_tag_user.c
new file mode 100644
index 000000000000..e149854f42dd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_user.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct bpf_testmod_btf_type_tag_1 {
+	int a;
+};
+
+struct bpf_testmod_btf_type_tag_2 {
+	struct bpf_testmod_btf_type_tag_1 *p;
+};
+
+int g;
+
+SEC("fentry/bpf_testmod_test_btf_type_tag_user_1")
+int BPF_PROG(test_user1, struct bpf_testmod_btf_type_tag_1 *arg)
+{
+	g =3D arg->a;
+	return 0;
+}
+
+SEC("fentry/bpf_testmod_test_btf_type_tag_user_2")
+int BPF_PROG(test_user2, struct bpf_testmod_btf_type_tag_2 *arg)
+{
+	g =3D arg->p->a;
+	return 0;
+}
--=20
2.30.2

