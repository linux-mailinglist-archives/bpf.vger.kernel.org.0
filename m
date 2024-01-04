Return-Path: <bpf+bounces-18986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DBC823A48
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 02:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A3CB21DD5
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 01:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40C71847;
	Thu,  4 Jan 2024 01:39:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF221FB3
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GiLdK020285
	for <bpf@vger.kernel.org>; Wed, 3 Jan 2024 17:39:16 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vda7m3vf3-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 17:39:15 -0800
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 17:39:13 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 805EB3DFAFEB9; Wed,  3 Jan 2024 17:39:10 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 9/9] selftests/bpf: add __arg_ctx BTF rewrite test
Date: Wed, 3 Jan 2024 17:38:47 -0800
Message-ID: <20240104013847.3875810-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104013847.3875810-1-andrii@kernel.org>
References: <20240104013847.3875810-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NkaUzKRCTAnrK6ZSDueAZDoCp5HZGp3D
X-Proofpoint-ORIG-GUID: NkaUzKRCTAnrK6ZSDueAZDoCp5HZGp3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_10,2024-01-03_01,2023-05-22_02

Add a test validating that libbpf uploads BTF and func_info with
rewritten type information for arguments of global subprogs that are
marked with __arg_ctx tag.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/test_global_funcs.c        | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b=
/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index e0879df38639..67d4ef9e62b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -20,6 +20,109 @@
 #include "test_global_func17.skel.h"
 #include "test_global_func_ctx_args.skel.h"
=20
+#include "bpf/libbpf_internal.h"
+#include "btf_helpers.h"
+
+static void check_ctx_arg_type(const struct btf *btf, const struct btf_p=
aram *p)
+{
+	const struct btf_type *t;
+	const char *s;
+
+	t =3D btf__type_by_id(btf, p->type);
+	if (!ASSERT_EQ(btf_kind(t), BTF_KIND_PTR, "ptr_t"))
+		return;
+
+	s =3D btf_type_raw_dump(btf, t->type);
+	if (!ASSERT_HAS_SUBSTR(s, "STRUCT 'bpf_perf_event_data' size=3D0 vlen=3D=
0",
+			       "ctx_struct_t"))
+		return;
+}
+
+static void subtest_ctx_arg_rewrite(void)
+{
+	struct test_global_func_ctx_args *skel =3D NULL;
+	struct bpf_prog_info info;
+	char func_info_buf[1024] __attribute__((aligned(8)));
+	struct bpf_func_info_min *rec;
+	struct btf *btf =3D NULL;
+	__u32 info_len =3D sizeof(info);
+	int err, fd, i;
+
+	skel =3D test_global_func_ctx_args__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.arg_tag_ctx_perf, true);
+
+	err =3D test_global_func_ctx_args__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto out;
+
+	memset(&info, 0, sizeof(info));
+	info.func_info =3D ptr_to_u64(&func_info_buf);
+	info.nr_func_info =3D 3;
+	info.func_info_rec_size =3D sizeof(struct bpf_func_info_min);
+
+	fd =3D bpf_program__fd(skel->progs.arg_tag_ctx_perf);
+	err =3D bpf_prog_get_info_by_fd(fd, &info, &info_len);
+	if (!ASSERT_OK(err, "prog_info"))
+		goto out;
+
+	if (!ASSERT_EQ(info.nr_func_info, 3, "nr_func_info"))
+		goto out;
+
+	btf =3D btf__load_from_kernel_by_id(info.btf_id);
+	if (!ASSERT_OK_PTR(btf, "obj_kern_btf"))
+		goto out;
+
+	rec =3D (struct bpf_func_info_min *)func_info_buf;
+	for (i =3D 0; i < info.nr_func_info; i++, rec =3D (void *)rec + info.fu=
nc_info_rec_size) {
+		const struct btf_type *fn_t, *proto_t;
+		const char *name;
+
+		if (rec->insn_off =3D=3D 0)
+			continue; /* main prog, skip */
+
+		fn_t =3D btf__type_by_id(btf, rec->type_id);
+		if (!ASSERT_OK_PTR(fn_t, "fn_type"))
+			goto out;
+		if (!ASSERT_EQ(btf_kind(fn_t), BTF_KIND_FUNC, "fn_type_kind"))
+			goto out;
+		proto_t =3D btf__type_by_id(btf, fn_t->type);
+		if (!ASSERT_OK_PTR(proto_t, "proto_type"))
+			goto out;
+
+		name =3D btf__name_by_offset(btf, fn_t->name_off);
+		if (strcmp(name, "subprog_ctx_tag") =3D=3D 0) {
+			/* int subprog_ctx_tag(void *ctx __arg_ctx) */
+			if (!ASSERT_EQ(btf_vlen(proto_t), 1, "arg_cnt"))
+				goto out;
+
+			/* arg 0 is PTR -> STRUCT bpf_perf_event_data */
+			check_ctx_arg_type(btf, &btf_params(proto_t)[0]);
+		} else if (strcmp(name, "subprog_multi_ctx_tags") =3D=3D 0) {
+			/* int subprog_multi_ctx_tags(void *ctx1 __arg_ctx,
+			 *			      struct my_struct *mem,
+			 *			      void *ctx2 __arg_ctx)
+			 */
+			if (!ASSERT_EQ(btf_vlen(proto_t), 3, "arg_cnt"))
+				goto out;
+
+			/* arg 0 is PTR -> STRUCT bpf_perf_event_data */
+			check_ctx_arg_type(btf, &btf_params(proto_t)[0]);
+			/* arg 2 is PTR -> STRUCT bpf_perf_event_data */
+			check_ctx_arg_type(btf, &btf_params(proto_t)[2]);
+		} else {
+			ASSERT_FAIL("unexpected subprog %s", name);
+			goto out;
+		}
+	}
+
+out:
+	btf__free(btf);
+	test_global_func_ctx_args__destroy(skel);
+}
+
 void test_test_global_funcs(void)
 {
 	RUN_TESTS(test_global_func1);
@@ -40,4 +143,7 @@ void test_test_global_funcs(void)
 	RUN_TESTS(test_global_func16);
 	RUN_TESTS(test_global_func17);
 	RUN_TESTS(test_global_func_ctx_args);
+
+	if (test__start_subtest("ctx_arg_rewrite"))
+		subtest_ctx_arg_rewrite();
 }
--=20
2.34.1


