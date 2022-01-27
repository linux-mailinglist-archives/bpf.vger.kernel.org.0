Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F0649E689
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 16:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbiA0Pqa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 10:46:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59810 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242292AbiA0Pq1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 10:46:27 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RFTXRM021647
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 07:46:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=hXBWyxRKUb8fiEqaUGy2IDN+1r2siIlLS8qu92PnZrE=;
 b=e+PJS5iio5pDBhpNqIAnoIAdZQ7LpQVW9vkqDIsMXuXHnXt9/BaUcrrPBxMNSJjhvQFU
 j/IQ7dCNoENYU6bh3UpYZHJkBul114NCzFPOu5jkQBrFa8oAXw3O7fW+TcFdpFq1nvgf
 y0d5UvGZWB0ptO7Mhi8r9/qzHxPu7q8eZko= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dujrsbdp9-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 07:46:27 -0800
Received: from twshared0654.04.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 07:46:22 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D9BCD5A22B9A; Thu, 27 Jan 2022 07:46:16 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next v3 4/6] selftests/bpf: add a selftest with __user tag
Date:   Thu, 27 Jan 2022 07:46:16 -0800
Message-ID: <20220127154616.659314-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127154555.650886-1-yhs@fb.com>
References: <20220127154555.650886-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PK5nePAHvCDMMvxZrx1e3i7a0KZ0luuj
X-Proofpoint-GUID: PK5nePAHvCDMMvxZrx1e3i7a0KZ0luuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added a selftest with three__user usages: a __user pointer-type argument
in bpf_testmod, a __user pointer-type struct member in bpf_testmod,
and a __user pointer-type struct member in vmlinux. In all cases,
directly accessing the user memory will result verification failure.

  $ ./test_progs -v -n 22/3
  ...
  libbpf: prog 'test_user1': BPF program load failed: Permission denied
  libbpf: prog 'test_user1': -- BEGIN PROG LOAD LOG --
  R1 type=3Dctx expected=3Dfp
  0: R1=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
  ; int BPF_PROG(test_user1, struct bpf_testmod_btf_type_tag_1 *arg)
  0: (79) r1 =3D *(u64 *)(r1 +0)
  func 'bpf_testmod_test_btf_type_tag_user_1' arg0 has btf_id 136561 type=
 STRUCT 'bpf_testmod_btf_type_tag_1'
  1: R1_w=3Duser_ptr_bpf_testmod_btf_type_tag_1(id=3D0,off=3D0,imm=3D0)
  ; g =3D arg->a;
  1: (61) r1 =3D *(u32 *)(r1 +0)
  R1 invalid mem access 'user_ptr_'
  ...
  #22/3 btf_tag/btf_type_tag_user_mod1:OK

  $ ./test_progs -v -n 22/4
  ...
  libbpf: prog 'test_user2': BPF program load failed: Permission denied
  libbpf: prog 'test_user2': -- BEGIN PROG LOAD LOG --
  R1 type=3Dctx expected=3Dfp
  0: R1=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
  ; int BPF_PROG(test_user2, struct bpf_testmod_btf_type_tag_2 *arg)
  0: (79) r1 =3D *(u64 *)(r1 +0)
  func 'bpf_testmod_test_btf_type_tag_user_2' arg0 has btf_id 136563 type=
 STRUCT 'bpf_testmod_btf_type_tag_2'
  1: R1_w=3Dptr_bpf_testmod_btf_type_tag_2(id=3D0,off=3D0,imm=3D0)
  ; g =3D arg->p->a;
  1: (79) r1 =3D *(u64 *)(r1 +0)          ; R1_w=3Duser_ptr_bpf_testmod_b=
tf_type_tag_1(id=3D0,off=3D0,imm=3D0)
  ; g =3D arg->p->a;
  2: (61) r1 =3D *(u32 *)(r1 +0)
  R1 invalid mem access 'user_ptr_'
  ...
  #22/4 btf_tag/btf_type_tag_user_mod2:OK

  $ ./test_progs -v -n 22/5
  ...
  libbpf: prog 'test_sys_getsockname': BPF program load failed: Permissio=
n denied
  libbpf: prog 'test_sys_getsockname': -- BEGIN PROG LOAD LOG --
  R1 type=3Dctx expected=3Dfp
  0: R1=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
  ; int BPF_PROG(test_sys_getsockname, int fd, struct sockaddr *usockaddr=
,
  0: (79) r1 =3D *(u64 *)(r1 +8)
  func '__sys_getsockname' arg1 has btf_id 2319 type STRUCT 'sockaddr'
  1: R1_w=3Duser_ptr_sockaddr(id=3D0,off=3D0,imm=3D0)
  ; g =3D usockaddr->sa_family;
  1: (69) r1 =3D *(u16 *)(r1 +0)
  R1 invalid mem access 'user_ptr_'
  ...
  #22/5 btf_tag/btf_type_tag_user_vmlinux:OK

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 18 ++++
 .../selftests/bpf/prog_tests/btf_tag.c        | 93 +++++++++++++++++++
 .../selftests/bpf/progs/btf_type_tag_user.c   | 40 ++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag_user.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index bdbacf5adcd2..595d32ab285a 100644
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
index c4cf27777ff7..f7560b54a6bb 100644
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
@@ -41,10 +43,101 @@ static void test_btf_type_tag(void)
 	btf_type_tag__destroy(skel);
 }
=20
+static void test_btf_type_tag_mod_user(bool load_test_user1)
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
+	/* skip the test if the module does not have __user tags */
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
+	bpf_program__set_autoload(skel->progs.test_sys_getsockname, false);
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
+static void test_btf_type_tag_vmlinux_user(void)
+{
+	struct btf_type_tag_user *skel;
+	struct btf *vmlinux_btf;
+	__s32 type_id;
+	int err;
+
+	/* skip the test if the vmlinux does not have __user tags */
+	vmlinux_btf =3D btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(vmlinux_btf, "could not load vmlinux BTF"))
+		return;
+
+	type_id =3D btf__find_by_name_kind(vmlinux_btf, "user", BTF_KIND_TYPE_T=
AG);
+	if (type_id <=3D 0) {
+		printf("%s:SKIP: btf_type_tag attribute not in vmlinux btf", __func__)=
;
+		test__skip();
+		goto free_vmlinux_btf;
+	}
+
+	skel =3D btf_type_tag_user__open();
+	if (!ASSERT_OK_PTR(skel, "btf_type_tag_user"))
+		goto free_vmlinux_btf;
+
+	bpf_program__set_autoload(skel->progs.test_user2, false);
+	bpf_program__set_autoload(skel->progs.test_user1, false);
+
+	err =3D btf_type_tag_user__load(skel);
+	ASSERT_ERR(err, "btf_type_tag_user");
+
+	btf_type_tag_user__destroy(skel);
+
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
+	if (test__start_subtest("btf_type_tag_user_mod1"))
+		test_btf_type_tag_mod_user(true);
+	if (test__start_subtest("btf_type_tag_user_mod2"))
+		test_btf_type_tag_mod_user(false);
+	if (test__start_subtest("btf_type_tag_sys_user_vmlinux"))
+		test_btf_type_tag_vmlinux_user();
 }
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_user.c b/tool=
s/testing/selftests/bpf/progs/btf_type_tag_user.c
new file mode 100644
index 000000000000..5523f77c5a44
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_user.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Facebook */
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
+
+/* int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
+ *                       int __user *usockaddr_len);
+ */
+SEC("fentry/__sys_getsockname")
+int BPF_PROG(test_sys_getsockname, int fd, struct sockaddr *usockaddr,
+	     int *usockaddr_len)
+{
+	g =3D usockaddr->sa_family;
+	return 0;
+}
--=20
2.30.2

