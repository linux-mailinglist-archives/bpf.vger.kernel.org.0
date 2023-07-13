Return-Path: <bpf+bounces-4938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B16A75189E
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 08:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BCC281ADF
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38166104;
	Thu, 13 Jul 2023 06:09:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88075679
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 06:09:05 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0D72115
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:56 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D4bTho015088
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=y3SNw5TDjd9JLMxPJmOz/8qnOgMYZzIsDfXO6/lwOOo=;
 b=MQQj4NofiKHZKsGeKVWmIsUw5b/b6DCaVQEn5sw34lNVW1RoMnNYnl5mdcFE9WCC8+Pa
 lQic0XTAvB6Y3OOSe9W8qDNkeRAGbrEMipTZmfKuXLRi/Y7yJ/kb4H/DycitHbz+k4RG
 GTYHLOfQcWnj5pJpkKNintJ5qmchwoPDLtY= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rtad8ghfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:55 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 23:08:54 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 45C9F22EFA4B9; Wed, 12 Jul 2023 23:08:41 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 14/15] selftests/bpf: Test ldsx with more complex cases
Date: Wed, 12 Jul 2023 23:08:41 -0700
Message-ID: <20230713060841.397183-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713060718.388258-1-yhs@fb.com>
References: <20230713060718.388258-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HnoCPRFOlYEDH1Bi80ltSni-ds4iB_4C
X-Proofpoint-ORIG-GUID: HnoCPRFOlYEDH1Bi80ltSni-ds4iB_4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_03,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Test reading signed rdonly map value, read/write map value,
probed memory and ctx field. Without proper verifier/git handling,
the test will fail.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  9 +-
 .../selftests/bpf/prog_tests/test_ldsx_insn.c | 88 +++++++++++++++++++
 .../selftests/bpf/progs/test_ldsx_insn.c      | 75 ++++++++++++++++
 3 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ldsx_insn=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ldsx_insn.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index aaf6ef1201c7..e14c9c6f69eb 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -75,6 +75,12 @@ bpf_testmod_test_struct_arg_6(struct bpf_testmod_struc=
t_arg_3 *a) {
 	return bpf_testmod_test_struct_arg_result;
 }
=20
+noinline int
+bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmod_struct_arg_1 *a) {
+	bpf_testmod_test_struct_arg_result =3D a->a;
+	return bpf_testmod_test_struct_arg_result;
+}
+
 __bpf_kfunc void
 bpf_testmod_test_mod_kfunc(int i)
 {
@@ -203,7 +209,7 @@ bpf_testmod_test_read(struct file *file, struct kobje=
ct *kobj,
 		.off =3D off,
 		.len =3D len,
 	};
-	struct bpf_testmod_struct_arg_1 struct_arg1 =3D {10};
+	struct bpf_testmod_struct_arg_1 struct_arg1 =3D {10}, struct_arg1_2 =3D=
 {-1};
 	struct bpf_testmod_struct_arg_2 struct_arg2 =3D {2, 3};
 	struct bpf_testmod_struct_arg_3 *struct_arg3;
 	int i =3D 1;
@@ -216,6 +222,7 @@ bpf_testmod_test_read(struct file *file, struct kobje=
ct *kobj,
 	(void)bpf_testmod_test_struct_arg_3(1, 4, struct_arg2);
 	(void)bpf_testmod_test_struct_arg_4(struct_arg1, 1, 2, 3, struct_arg2);
 	(void)bpf_testmod_test_struct_arg_5();
+	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
=20
 	struct_arg3 =3D kmalloc((sizeof(struct bpf_testmod_struct_arg_3) +
 				sizeof(int)), GFP_KERNEL);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_ldsx_insn.c b/to=
ols/testing/selftests/bpf/prog_tests/test_ldsx_insn.c
new file mode 100644
index 000000000000..d18138ebd8f0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_ldsx_insn.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates.*/
+
+#include <test_progs.h>
+#include "test_ldsx_insn.skel.h"
+
+static void test_map_val_and_probed_memory(void)
+{
+	struct test_ldsx_insn *skel;
+	int err;
+
+	skel =3D test_ldsx_insn__open();
+	if (!ASSERT_OK_PTR(skel, "test_ldsx_insn__open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.rdonly_map_prog, true);
+	bpf_program__set_autoload(skel->progs.map_val_prog, true);
+	bpf_program__set_autoload(skel->progs.test_ptr_struct_arg, true);
+
+	err =3D test_ldsx_insn__load(skel);
+	if (!ASSERT_OK(err, "test_ldsx_insn__load"))
+		goto out;
+
+	err =3D test_ldsx_insn__attach(skel);
+	if (!ASSERT_OK(err, "test_ldsx_insn__attach"))
+		goto out;
+
+	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
+
+	ASSERT_EQ(skel->bss->done1, 1, "done1");
+	ASSERT_EQ(skel->bss->ret1, 1, "ret1");
+	ASSERT_EQ(skel->bss->done2, 1, "done2");
+	ASSERT_EQ(skel->bss->ret2, 1, "ret2");
+	ASSERT_EQ(skel->bss->int_member, -1, "int_member");
+out:
+	test_ldsx_insn__destroy(skel);
+}
+
+static void test_ctx_member(void)
+{
+	struct test_ldsx_insn *skel;
+	int err, fd, cgroup_fd;
+	char buf[16] =3D {0};
+	socklen_t optlen;
+
+	cgroup_fd =3D test__join_cgroup("/ldsx_test");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /ldsx_test"))
+		return;
+
+	skel =3D test_ldsx_insn__open();
+	if (!ASSERT_OK_PTR(skel, "test_ldsx_insn__open"))
+		goto close_cgroup_fd;
+
+	bpf_program__set_autoload(skel->progs._getsockopt, true);
+
+	err =3D test_ldsx_insn__load(skel);
+	if (!ASSERT_OK(err, "test_ldsx_insn__load"))
+		goto destroy_skel;
+
+	skel->links._getsockopt =3D
+		bpf_program__attach_cgroup(skel->progs._getsockopt, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links._getsockopt, "getsockopt_link"))
+		goto destroy_skel;
+
+	fd =3D socket(AF_INET, SOCK_STREAM, 0);
+	if (!ASSERT_GE(fd, 0, "socket"))
+		goto destroy_skel;
+
+	optlen =3D sizeof(buf);
+	(void)getsockopt(fd, SOL_IP, IP_TTL, buf, &optlen);
+
+	ASSERT_EQ(skel->bss->set_optlen, -1, "optlen");
+	ASSERT_EQ(skel->bss->set_retval, -1, "retval");
+
+	close(fd);
+destroy_skel:
+	test_ldsx_insn__destroy(skel);
+close_cgroup_fd:
+	close(cgroup_fd);
+}
+
+void test_ldsx_insn(void)
+{
+	if (test__start_subtest("map_val and probed_memory"))
+		test_map_val_and_probed_memory();
+	if (test__start_subtest("ctx_member"))
+		test_ctx_member();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c b/tools/t=
esting/selftests/bpf/progs/test_ldsx_insn.c
new file mode 100644
index 000000000000..22befbfb02b9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+volatile const short val1 =3D -1;
+volatile const int val2 =3D -1;
+short val3 =3D -1;
+int val4 =3D -1;
+int done1, done2, ret1, ret2;
+
+SEC("?raw_tp/sys_enter")
+int rdonly_map_prog(const void *ctx)
+{
+	if (done1)
+		return 0;
+
+	done1 =3D 1;
+	if (val1 =3D=3D val2)
+		ret1 =3D 1;
+	return 0;
+
+}
+
+SEC("?raw_tp/sys_enter")
+int map_val_prog(const void *ctx)
+{
+	if (done2)
+		return 0;
+
+	done2 =3D 1;
+	if (val3 =3D=3D val4)
+		ret2 =3D 1;
+	return 0;
+
+}
+
+struct bpf_testmod_struct_arg_1 {
+	int a;
+};
+
+long long int_member;
+
+SEC("?fentry/bpf_testmod_test_arg_ptr_to_struct")
+int BPF_PROG2(test_ptr_struct_arg, struct bpf_testmod_struct_arg_1 *, p)
+{
+	int_member =3D p->a;
+        return 0;
+}
+
+long long set_optlen, set_retval;
+
+SEC("?cgroup/getsockopt")
+int _getsockopt(volatile struct bpf_sockopt *ctx)
+{
+	int old_optlen, old_retval;
+
+	old_optlen =3D ctx->optlen;
+	old_retval =3D ctx->retval;
+
+	ctx->optlen =3D -1;
+	ctx->retval =3D -1;
+
+	set_optlen =3D ctx->optlen;
+	set_retval =3D ctx->retval;
+
+	ctx->optlen =3D old_optlen;
+	ctx->retval =3D old_retval;
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


