Return-Path: <bpf+bounces-16667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BB28042B1
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780C21F21387
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DBA364D1;
	Mon,  4 Dec 2023 23:40:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E80210F
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:40:19 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4KGl7X008058
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 15:40:19 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3urr81bfe2-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:40:19 -0800
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 15:40:17 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id CE1B13C972752; Mon,  4 Dec 2023 15:40:04 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 13/13] selftests/bpf: add global subprog annotation tests
Date: Mon, 4 Dec 2023 15:39:31 -0800
Message-ID: <20231204233931.49758-14-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204233931.49758-1-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: sWhzJL7-AkzlcQavp9CEyqHDwCoZh8ea
X-Proofpoint-ORIG-GUID: sWhzJL7-AkzlcQavp9CEyqHDwCoZh8ea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02

Add test cases to validate semantics of global subprog argument
annotations:
  - non-null pointers;
  - context argument;
  - const dynptr passing;
  - packet pointers (data, metadata, end).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/progs/verifier_global_subprogs.c      | 134 +++++++++++++++++-
 1 file changed, 130 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c=
 b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index a0a5efd1caa1..9883d3e47130 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
=20
-#include <stdbool.h>
-#include <errno.h>
-#include <string.h>
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include "xdp_metadata.h"
+#include "bpf_kfuncs.h"
=20
 int arr[1];
 int unkn_idx;
@@ -89,4 +88,131 @@ int unguarded_unsupp_global_called(void)
 	return global_unsupp(&x);
 }
=20
+long stack[128];
+
+__weak int subprog_nullable_ptr_bad(int *p)
+{
+	return (*p) * 2; /* bad, missing null check */
+}
+
+SEC("?raw_tp")
+__failure __log_level(2)
+__msg("invalid mem access 'mem_or_null'")
+int arg_tag_nullable_ptr_fail(void *ctx)
+{
+	int x =3D 42;
+
+	return subprog_nullable_ptr_bad(&x);
+}
+
+__noinline __weak int subprog_nonnull_ptr_good(int *p1 __arg_nonnull, in=
t *p2 __arg_nonnull)
+{
+	return (*p1) * (*p2); /* good, no need for NULL checks */
+}
+
+int x =3D 47;
+
+SEC("?raw_tp")
+__success __log_level(2)
+int arg_tag_nonnull_ptr_good(void *ctx)
+{
+	int y =3D 74;
+
+	return subprog_nonnull_ptr_good(&x, &y);
+}
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
+SEC("?raw_tp")
+__success __log_level(2)
+int arg_tag_ctx_raw_tp(void *ctx)
+{
+	return subprog_ctx_tag(ctx);
+}
+
+SEC("?tp")
+__success __log_level(2)
+int arg_tag_ctx_tp(void *ctx)
+{
+	return subprog_ctx_tag(ctx);
+}
+
+SEC("?kprobe")
+__success __log_level(2)
+int arg_tag_ctx_kprobe(void *ctx)
+{
+	return subprog_ctx_tag(ctx);
+}
+
+__weak int subprog_pkt(void *ctx __arg_ctx,
+		       void *pkt_meta __arg_pkt_meta,
+		       void *pkt_data __arg_pkt_data,
+		       void *pkt_end __arg_pkt_end)
+{
+	struct xdp_meta *meta;
+
+	/* use pkt_data + pkt_end */
+	if (pkt_data + 64 > pkt_end)
+		return XDP_DROP;
+
+	if (*(u8 *)(pkt_data + 63) > 0)
+		return XDP_DROP;
+
+	/* use pkt_meta + pkt_data */
+	if (pkt_meta + sizeof(*meta) > pkt_data)
+		return XDP_DROP;
+
+	meta =3D pkt_meta;
+	meta->rx_timestamp =3D 1;
+
+	return XDP_PASS;
+}
+
+SEC("?xdp")
+__success __log_level(2)
+int arg_tag_pkt_pointers(struct xdp_md *ctx)
+{
+	void *pkt_meta =3D (void *)(long)ctx->data_meta;
+	void *pkt_data =3D (void *)(long)ctx->data;
+	void *pkt_end =3D (void *)(long)ctx->data_end;
+
+	return subprog_pkt(ctx, pkt_meta, pkt_data, pkt_end);
+}
+
+__weak int subprog_dynptr(struct bpf_dynptr *dptr __arg_dynptr)
+{
+	long *d, t, buf[1] =3D {};
+
+	d =3D bpf_dynptr_data(dptr, 0, sizeof(long));
+	if (!d)
+		return 0;
+
+	t =3D *d + 1;
+
+	d =3D bpf_dynptr_slice(dptr, 0, &buf, sizeof(long));
+	if (!d)
+		return t;
+
+	t =3D *d + 2;
+
+	return t;
+}
+
+SEC("?xdp")
+__success __log_level(2)
+int arg_tag_dynptr(struct xdp_md *ctx)
+{
+	struct bpf_dynptr dptr;
+
+	bpf_dynptr_from_xdp(ctx, 0, &dptr);
+
+	return subprog_dynptr(&dptr);
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


