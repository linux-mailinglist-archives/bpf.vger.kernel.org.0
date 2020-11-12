Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9726B2B0FDE
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 22:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgKLVNY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 16:13:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64598 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727236AbgKLVNY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 16:13:24 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACL1fMX032101
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 13:13:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vxjF9aPze9Ekfgh2QRPykTiyMSIae+TKFCA1FACUAok=;
 b=JSmEhJX82InsCmYNiHscYexd+UJ1n6/MUUCeuNguMSIzQO0qm4BQ6t/f7SuGiwTlRoMc
 VLJPI1kVahu22HvyZddjN/Y0TpT0zkQ8ee+xgyR6Narr8A/ZrcVEw2Fi4XhbYrzF7rto
 dgD9Q3HU/nF9SCqGOHJS4kvjvgbZF3deuSI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34rf8sssnh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 13:13:23 -0800
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 12 Nov 2020 13:13:19 -0800
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id CAC8229469C4; Thu, 12 Nov 2020 13:13:13 -0800 (PST)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 3/4] bpf: Allow using bpf_sk_storage in FENTRY/FEXIT/RAW_TP
Date:   Thu, 12 Nov 2020 13:13:13 -0800
Message-ID: <20201112211313.2587383-1-kafai@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201112211255.2585961-1-kafai@fb.com>
References: <20201112211255.2585961-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_12:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 adultscore=0
 impostorscore=0 suspectscore=38 phishscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch enables the FENTRY/FEXIT/RAW_TP tracing program to use
the bpf_sk_storage_(get|delete) helper, so those tracing programs
can access the sk's bpf_local_storage and the later selftest
will show some examples.

The bpf_sk_storage is currently used in bpf-tcp-cc, tc,
cg sockops...etc which is running either in softirq or
task context.

This patch adds bpf_sk_storage_get_tracing_proto and
bpf_sk_storage_delete_tracing_proto.  They will check
in runtime that the helpers can only be called when serving
softirq or running in a task context.  That should enable
most common tracing use cases on sk.

During the load time, the new tracing_allowed() function
will ensure the tracing prog using the bpf_sk_storage_(get|delete)
helper is not tracing any bpf_sk_storage*() function itself.
The sk is passed as "void *" when calling into bpf_local_storage.

This patch only allows tracing a kernel function.

Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 include/net/bpf_sk_storage.h |  2 +
 kernel/trace/bpf_trace.c     |  5 +++
 net/core/bpf_sk_storage.c    | 74 ++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 3c516dd07caf..0e85713f56df 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -20,6 +20,8 @@ void bpf_sk_storage_free(struct sock *sk);
=20
 extern const struct bpf_func_proto bpf_sk_storage_get_proto;
 extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
+extern const struct bpf_func_proto bpf_sk_storage_get_tracing_proto;
+extern const struct bpf_func_proto bpf_sk_storage_delete_tracing_proto;
=20
 struct bpf_local_storage_elem;
 struct bpf_sk_storage_diag;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e4515b0f62a8..cfce60ad1cb5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -16,6 +16,7 @@
 #include <linux/syscalls.h>
 #include <linux/error-injection.h>
 #include <linux/btf_ids.h>
+#include <net/bpf_sk_storage.h>
=20
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/btf.h>
@@ -1735,6 +1736,10 @@ tracing_prog_func_proto(enum bpf_func_id func_id, =
const struct bpf_prog *prog)
 		return &bpf_skc_to_tcp_request_sock_proto;
 	case BPF_FUNC_skc_to_udp6_sock:
 		return &bpf_skc_to_udp6_sock_proto;
+	case BPF_FUNC_sk_storage_get:
+		return &bpf_sk_storage_get_tracing_proto;
+	case BPF_FUNC_sk_storage_delete:
+		return &bpf_sk_storage_delete_tracing_proto;
 #endif
 	case BPF_FUNC_seq_printf:
 		return prog->expected_attach_type =3D=3D BPF_TRACE_ITER ?
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index fd416678f236..359908a7d3c1 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/bpf.h>
+#include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_local_storage.h>
 #include <net/bpf_sk_storage.h>
@@ -378,6 +379,79 @@ const struct bpf_func_proto bpf_sk_storage_delete_pr=
oto =3D {
 	.arg2_type	=3D ARG_PTR_TO_BTF_ID_SOCK_COMMON,
 };
=20
+static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
+{
+	const struct btf *btf_vmlinux;
+	const struct btf_type *t;
+	const char *tname;
+	u32 btf_id;
+
+	if (prog->aux->dst_prog)
+		return false;
+
+	/* Ensure the tracing program is not tracing
+	 * any bpf_sk_storage*() function and also
+	 * use the bpf_sk_storage_(get|delete) helper.
+	 */
+	switch (prog->expected_attach_type) {
+	case BPF_TRACE_RAW_TP:
+		/* bpf_sk_storage has no trace point */
+		return true;
+	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FEXIT:
+		btf_vmlinux =3D bpf_get_btf_vmlinux();
+		btf_id =3D prog->aux->attach_btf_id;
+		t =3D btf_type_by_id(btf_vmlinux, btf_id);
+		tname =3D btf_name_by_offset(btf_vmlinux, t->name_off);
+		return !!strncmp(tname, "bpf_sk_storage",
+				 strlen("bpf_sk_storage"));
+	default:
+		return false;
+	}
+
+	return false;
+}
+
+BPF_CALL_4(bpf_sk_storage_get_tracing, struct bpf_map *, map, struct soc=
k *, sk,
+	   void *, value, u64, flags)
+{
+	if (!in_serving_softirq() && !in_task())
+		return (unsigned long)NULL;
+
+	return (unsigned long)____bpf_sk_storage_get(map, sk, value, flags);
+}
+
+BPF_CALL_2(bpf_sk_storage_delete_tracing, struct bpf_map *, map,
+	   struct sock *, sk)
+{
+	if (!in_serving_softirq() && !in_task())
+		return -EPERM;
+
+	return ____bpf_sk_storage_delete(map, sk);
+}
+
+const struct bpf_func_proto bpf_sk_storage_get_tracing_proto =3D {
+	.func		=3D bpf_sk_storage_get_tracing,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type	=3D ARG_CONST_MAP_PTR,
+	.arg2_type	=3D ARG_PTR_TO_BTF_ID,
+	.arg2_btf_id	=3D &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
+	.arg3_type	=3D ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type	=3D ARG_ANYTHING,
+	.allowed	=3D bpf_sk_storage_tracing_allowed,
+};
+
+const struct bpf_func_proto bpf_sk_storage_delete_tracing_proto =3D {
+	.func		=3D bpf_sk_storage_delete_tracing,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_CONST_MAP_PTR,
+	.arg2_type	=3D ARG_PTR_TO_BTF_ID,
+	.arg2_btf_id	=3D &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
+	.allowed	=3D bpf_sk_storage_tracing_allowed,
+};
+
 struct bpf_sk_storage_diag {
 	u32 nr_maps;
 	struct bpf_map *maps[];
--=20
2.24.1

