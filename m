Return-Path: <bpf+bounces-5404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFEB75A319
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39F3281BBA
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17D37D;
	Thu, 20 Jul 2023 00:04:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E357F
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:04:59 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA47D172D
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:04:57 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JMLwf8015237
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:04:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=n4FvbXqeZ3MsHgMWdNP/FWH4Yj2AXEHTzwX0AvdRU2k=;
 b=RxE+JODdE1Nw42Wz3ViaZzRCdIVkN1UDNlsM09klWMDCse9ePJJRyqyGP6W2f89hsltb
 AWVmwQiCpXUh7h4S9584hcouG11MpY8hMg5pMxjyaur3VCos8NwMUm9c68M/D/nTLC6b
 TS/DXT48x/W35MXiUtMn+LrtzBHa5FskJhQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rx7svrcvs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:04:57 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:04:56 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2F5372354EAA2; Wed, 19 Jul 2023 17:02:28 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song
	<maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 16/17] selftests/bpf: Test ldsx with more complex cases
Date: Wed, 19 Jul 2023 17:02:28 -0700
Message-ID: <20230720000228.112746-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720000103.99949-1-yhs@fb.com>
References: <20230720000103.99949-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KNdsUnzhDWErr-yUNy5NgE-7sCXdbRDR
X-Proofpoint-ORIG-GUID: KNdsUnzhDWErr-yUNy5NgE-7sCXdbRDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following ldsx cases are tested:
  - signed readonly map value
  - read/write map value
  - probed memory
  - not-narrowed ctx field access
  - narrowed ctx field access.

Without previous proper verifier/git handling, the test will fail.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   9 +-
 .../selftests/bpf/prog_tests/test_ldsx_insn.c | 124 ++++++++++++++++++
 .../selftests/bpf/progs/test_ldsx_insn.c      | 112 ++++++++++++++++
 3 files changed, 244 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ldsx_insn=
.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ldsx_insn.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index a6f991b56345..cefc5dd72573 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -98,6 +98,12 @@ bpf_testmod_test_struct_arg_8(u64 a, void *b, short c,=
 int d, void *e,
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
@@ -240,7 +246,7 @@ bpf_testmod_test_read(struct file *file, struct kobje=
ct *kobj,
 		.off =3D off,
 		.len =3D len,
 	};
-	struct bpf_testmod_struct_arg_1 struct_arg1 =3D {10};
+	struct bpf_testmod_struct_arg_1 struct_arg1 =3D {10}, struct_arg1_2 =3D=
 {-1};
 	struct bpf_testmod_struct_arg_2 struct_arg2 =3D {2, 3};
 	struct bpf_testmod_struct_arg_3 *struct_arg3;
 	struct bpf_testmod_struct_arg_4 struct_arg4 =3D {21, 22};
@@ -259,6 +265,7 @@ bpf_testmod_test_read(struct file *file, struct kobje=
ct *kobj,
 	(void)bpf_testmod_test_struct_arg_8(16, (void *)17, 18, 19,
 					    (void *)20, struct_arg4, 23);
=20
+	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
=20
 	struct_arg3 =3D kmalloc((sizeof(struct bpf_testmod_struct_arg_3) +
 				sizeof(int)), GFP_KERNEL);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_ldsx_insn.c b/to=
ols/testing/selftests/bpf/prog_tests/test_ldsx_insn.c
new file mode 100644
index 000000000000..8180a3bb3b52
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_ldsx_insn.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates.*/
+
+#include <test_progs.h>
+#include <network_helpers.h>
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
+
+out:
+	test_ldsx_insn__destroy(skel);
+}
+
+static void test_ctx_member_sign_ext(void)
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
+static void test_ctx_member_narrow_sign_ext(void)
+{
+	struct test_ldsx_insn *skel;
+	struct __sk_buff skb =3D {};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in =3D &pkt_v4,
+		    .data_size_in =3D sizeof(pkt_v4),
+		    .ctx_in =3D &skb,
+		    .ctx_size_in =3D sizeof(skb),
+	);
+	int err, prog_fd;
+
+	skel =3D test_ldsx_insn__open();
+	if (!ASSERT_OK_PTR(skel, "test_ldsx_insn__open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs._tc, true);
+
+	err =3D test_ldsx_insn__load(skel);
+	if (!ASSERT_OK(err, "test_ldsx_insn__load"))
+		goto destroy_skel;
+
+	prog_fd =3D bpf_program__fd(skel->progs._tc);
+	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	ASSERT_EQ(skel->bss->set_mark, -2, "set_mark");
+
+destroy_skel:
+	test_ldsx_insn__destroy(skel);
+}
+
+void test_ldsx_insn(void)
+{
+	if (test__start_subtest("map_val and probed_memory"))
+		test_map_val_and_probed_memory();
+	if (test__start_subtest("ctx_member_sign_ext"))
+		test_ctx_member_sign_ext();
+	if (test__start_subtest("ctx_member_narrow_sign_ext"))
+		test_ctx_member_narrow_sign_ext();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c b/tools/t=
esting/selftests/bpf/progs/test_ldsx_insn.c
new file mode 100644
index 000000000000..92394fe939f4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
@@ -0,0 +1,112 @@
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
+	/* val1/val2 readonly map */
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
+	/* val1/val2 regular read/write map */
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
+	/* probed memory access */
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
+	/* sign extension for ctx member */
+	set_optlen =3D ctx->optlen;
+	set_retval =3D ctx->retval;
+
+	ctx->optlen =3D old_optlen;
+	ctx->retval =3D old_retval;
+
+	return 0;
+}
+
+long long set_mark;
+
+SEC("?tc")
+int _tc(volatile struct __sk_buff *skb)
+{
+	long long tmp_mark;
+	int old_mark;
+
+	old_mark =3D skb->mark;
+
+	skb->mark =3D 0xf6fe;
+
+	/* narrowed sign extension for ctx member */
+#if defined(__TARGET_ARCH_x86)
+	/* force narrow one-byte signed load. Otherwise, compiler may
+	 * generate a 32-bit unsigned load followed by an s8 movsx.
+	 */
+	asm volatile ("r1 =3D *(s8 *)(%[ctx] + %[off_mark])\n\t"
+		      "%[tmp_mark] =3D r1"
+		      : [tmp_mark]"=3Dr"(tmp_mark)
+		      : [ctx]"r"(skb),
+			[off_mark]"i"(offsetof(struct __sk_buff, mark))
+		      : "r1");
+#else
+	tmp_mark =3D (char)skb->mark;
+#endif
+	set_mark =3D tmp_mark;
+
+	skb->mark =3D old_mark;
+
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


