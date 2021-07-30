Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B711A3DB2DD
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 07:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhG3Fej convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 30 Jul 2021 01:34:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53016 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230149AbhG3Fei (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Jul 2021 01:34:38 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16U5UBCK024443
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 22:34:34 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3a37bfcp3y-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 22:34:34 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 22:34:32 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 8BE4B3D405B3; Thu, 29 Jul 2021 22:34:28 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 bpf-next 06/14] bpf: add bpf_get_attach_cookie() BPF helper to access bpf_cookie value
Date:   Thu, 29 Jul 2021 22:34:05 -0700
Message-ID: <20210730053413.1090371-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730053413.1090371-1-andrii@kernel.org>
References: <20210730053413.1090371-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WSwnvpUaaJ8oEDNYouLRRCSD13qVD5H8
X-Proofpoint-GUID: WSwnvpUaaJ8oEDNYouLRRCSD13qVD5H8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_03:2021-07-29,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new BPF helper, bpf_get_attach_cookie(), which can be used by BPF programs
to get access to a user-provided bpf_cookie value, specified during BPF
program attachment (BPF link creation) time.

Naming is hard, though. With the concept being named "BPF cookie", I've
considered calling the helper:
  - bpf_get_cookie() -- seems too unspecific and easily mistaken with socket
    cookie;
  - bpf_get_bpf_cookie() -- too much tautology;
  - bpf_get_link_cookie() -- would be ok, but while we create a BPF link to
    attach BPF program to BPF hook, it's still an "attachment" and the
    bpf_cookie is associated with BPF program attachment to a hook, not a BPF
    link itself. Technically, we could support bpf_cookie with old-style
    cgroup programs.So I ultimately rejected it in favor of
    bpf_get_attach_cookie().

Currently all perf_event-backed BPF program types support
bpf_get_attach_cookie() helper. Follow-up patches will add support for
fentry/fexit programs as well.

While at it, mark bpf_tracing_func_proto() as static to make it obvious that
it's only used from within the kernel/trace/bpf_trace.c.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  3 ---
 include/uapi/linux/bpf.h       | 16 ++++++++++++++++
 kernel/trace/bpf_trace.c       | 35 +++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h | 16 ++++++++++++++++
 4 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7da3826eeae5..e04ae3b94112 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2110,9 +2110,6 @@ extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
 extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
 extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
 
-const struct bpf_func_proto *bpf_tracing_func_proto(
-	enum bpf_func_id func_id, const struct bpf_prog *prog);
-
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 63ee482d50e1..c4f7892edb2b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4856,6 +4856,21 @@ union bpf_attr {
  * 		Get address of the traced function (for tracing and kprobe programs).
  * 	Return
  * 		Address of the traced function.
+ *
+ * u64 bpf_get_attach_cookie(void *ctx)
+ * 	Description
+ * 		Get bpf_cookie value provided (optionally) during the program
+ * 		attachment. It might be different for each individual
+ * 		attachment, even if BPF program itself is the same.
+ * 		Expects BPF program context *ctx* as a first argument.
+ *
+ * 		Supported for the following program types:
+ *			- kprobe/uprobe;
+ *			- tracepoint;
+ *			- perf_event.
+ * 	Return
+ *		Value specified by user at BPF link creation/attachment time
+ *		or 0, if it was not specified.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5032,6 +5047,7 @@ union bpf_attr {
 	FN(timer_start),		\
 	FN(timer_cancel),		\
 	FN(get_func_ip),		\
+	FN(get_attach_cookie),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b6c30aa0173c..afbc8be9653f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -975,7 +975,34 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_kprobe = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
-const struct bpf_func_proto *
+BPF_CALL_1(bpf_get_attach_cookie_trace, void *, ctx)
+{
+	struct bpf_trace_run_ctx *run_ctx;
+
+	run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, run_ctx);
+	return run_ctx->bpf_cookie;
+}
+
+static const struct bpf_func_proto bpf_get_attach_cookie_proto_trace = {
+	.func		= bpf_get_attach_cookie_trace,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+};
+
+BPF_CALL_1(bpf_get_attach_cookie_pe, struct bpf_perf_event_data_kern *, ctx)
+{
+	return ctx->event->bpf_cookie;
+}
+
+static const struct bpf_func_proto bpf_get_attach_cookie_proto_pe = {
+	.func		= bpf_get_attach_cookie_pe,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+};
+
+static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
@@ -1108,6 +1135,8 @@ kprobe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #endif
 	case BPF_FUNC_get_func_ip:
 		return &bpf_get_func_ip_proto_kprobe;
+	case BPF_FUNC_get_attach_cookie:
+		return &bpf_get_attach_cookie_proto_trace;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
@@ -1218,6 +1247,8 @@ tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_stackid_proto_tp;
 	case BPF_FUNC_get_stack:
 		return &bpf_get_stack_proto_tp;
+	case BPF_FUNC_get_attach_cookie:
+		return &bpf_get_attach_cookie_proto_trace;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
@@ -1325,6 +1356,8 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_perf_prog_read_value_proto;
 	case BPF_FUNC_read_branch_records:
 		return &bpf_read_branch_records_proto;
+	case BPF_FUNC_get_attach_cookie:
+		return &bpf_get_attach_cookie_proto_pe;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 63ee482d50e1..c4f7892edb2b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4856,6 +4856,21 @@ union bpf_attr {
  * 		Get address of the traced function (for tracing and kprobe programs).
  * 	Return
  * 		Address of the traced function.
+ *
+ * u64 bpf_get_attach_cookie(void *ctx)
+ * 	Description
+ * 		Get bpf_cookie value provided (optionally) during the program
+ * 		attachment. It might be different for each individual
+ * 		attachment, even if BPF program itself is the same.
+ * 		Expects BPF program context *ctx* as a first argument.
+ *
+ * 		Supported for the following program types:
+ *			- kprobe/uprobe;
+ *			- tracepoint;
+ *			- perf_event.
+ * 	Return
+ *		Value specified by user at BPF link creation/attachment time
+ *		or 0, if it was not specified.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5032,6 +5047,7 @@ union bpf_attr {
 	FN(timer_start),		\
 	FN(timer_cancel),		\
 	FN(get_func_ip),		\
+	FN(get_attach_cookie),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.30.2

