Return-Path: <bpf+bounces-18792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6830A8221A9
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA74B22666
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662B716427;
	Tue,  2 Jan 2024 19:01:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC5816418
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402IZtuJ003343
	for <bpf@vger.kernel.org>; Tue, 2 Jan 2024 11:01:30 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vcmyy1ker-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 11:01:30 -0800
Received: from twshared10507.42.prn1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 2 Jan 2024 11:01:26 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id D15F23DF01675; Tue,  2 Jan 2024 11:01:20 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 bpf-next 9/9] selftests/bpf: add arg:ctx cases to test_global_funcs tests
Date: Tue, 2 Jan 2024 11:00:55 -0800
Message-ID: <20240102190055.1602698-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102190055.1602698-1-andrii@kernel.org>
References: <20240102190055.1602698-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UFjAZyw8ni7Hjp7tw2ssoz6YJ_mQAk2W
X-Proofpoint-GUID: UFjAZyw8ni7Hjp7tw2ssoz6YJ_mQAk2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_06,2024-01-02_01,2023-05-22_02

Add a few extra cases of global funcs with context arguments. This time
rely on "arg:ctx" decl_tag (__arg_ctx macro), but put it next to
"classic" cases where context argument has to be of an exact type that
BPF verifier expects (e.g., bpf_user_pt_regs_t for kprobe/uprobe).

Colocating all these cases separately from other global func args that
rely on arg:xxx decl tags (in verifier_global_subprogs.c) allows for
simpler backwards compatibility testing on old kernels. All the cases in
test_global_func_ctx_args.c are supposed to work on older kernels, which
was manually validated during development.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/progs/test_global_func_ctx_args.c     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.=
c b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
index 7faa8eef0598..9a06e5eb1fbe 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
@@ -102,3 +102,52 @@ int perf_event_ctx(void *ctx)
 {
 	return perf_event_ctx_subprog(ctx);
 }
+
+/* this global subprog can be now called from many types of entry progs,=
 each
+ * with different context type
+ */
+__weak int subprog_ctx_tag(void *ctx __arg_ctx)
+{
+	return bpf_get_stack(ctx, stack, sizeof(stack), 0);
+}
+
+struct my_struct { int x; };
+
+__weak int subprog_multi_ctx_tags(void *ctx1 __arg_ctx,
+				  struct my_struct *mem,
+				  void *ctx2 __arg_ctx)
+{
+	if (!mem)
+		return 0;
+
+	return bpf_get_stack(ctx1, stack, sizeof(stack), 0) +
+	       mem->x +
+	       bpf_get_stack(ctx2, stack, sizeof(stack), 0);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+int arg_tag_ctx_raw_tp(void *ctx)
+{
+	struct my_struct x =3D { .x =3D 123 };
+
+	return subprog_ctx_tag(ctx) + subprog_multi_ctx_tags(ctx, &x, ctx);
+}
+
+SEC("?perf_event")
+__success __log_level(2)
+int arg_tag_ctx_perf(void *ctx)
+{
+	struct my_struct x =3D { .x =3D 123 };
+
+	return subprog_ctx_tag(ctx) + subprog_multi_ctx_tags(ctx, &x, ctx);
+}
+
+SEC("?kprobe")
+__success __log_level(2)
+int arg_tag_ctx_kprobe(void *ctx)
+{
+	struct my_struct x =3D { .x =3D 123 };
+
+	return subprog_ctx_tag(ctx) + subprog_multi_ctx_tags(ctx, &x, ctx);
+}
--=20
2.34.1


