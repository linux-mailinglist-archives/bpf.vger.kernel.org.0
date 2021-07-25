Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB98B3D4F22
	for <lists+bpf@lfdr.de>; Sun, 25 Jul 2021 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhGYQ6n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 25 Jul 2021 12:58:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27690 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230110AbhGYQ6m (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 25 Jul 2021 12:58:42 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16PHaIQZ007554
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 10:39:12 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3a0ece5vfy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 10:39:12 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Jul 2021 10:39:09 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 4FBED3D405B6; Sun, 25 Jul 2021 10:39:07 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH bpf-next 06/14] bpf: add bpf_get_user_ctx() BPF helper to access user_ctx value
Date:   Sun, 25 Jul 2021 10:38:37 -0700
Message-ID: <20210725173845.2593626-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210725173845.2593626-1-andrii@kernel.org>
References: <20210725173845.2593626-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: TFgaE4OeQnUa5aCLDqQ5OT58LjPbbnVp
X-Proofpoint-ORIG-GUID: TFgaE4OeQnUa5aCLDqQ5OT58LjPbbnVp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-25_05:2021-07-23,2021-07-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107250126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new BPF helper, bpf_get_user_ctx(), which can be used by BPF programs to
get access to the user_ctx value, specified during BPF program attachment (BPF
link creation) time.

Currently all perf_event-backed BPF program types support bpf_get_user_ctx()
helper. Follow-up patches will add support for fentry/fexit programs as well.

While at it, mark bpf_tracing_func_proto() as static to make it obvious that
it's only used from within the kernel/trace/bpf_trace.c.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  3 ---
 include/uapi/linux/bpf.h       | 16 ++++++++++++++++
 kernel/trace/bpf_trace.c       | 35 +++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h | 16 ++++++++++++++++
 4 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 74b35faf0b73..94ebedc1e13a 100644
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
index bc1fd54a8f58..96afeced3467 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4856,6 +4856,21 @@ union bpf_attr {
  * 		Get address of the traced function (for tracing and kprobe programs).
  * 	Return
  * 		Address of the traced function.
+ *
+ * u64 bpf_get_user_ctx(void *ctx)
+ * 	Description
+ * 		Get user_ctx value provided (optionally) during the program
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
+	FN(get_user_ctx),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c9cf6a0d0fb3..b14978b3f6fb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -975,7 +975,34 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_kprobe = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
-const struct bpf_func_proto *
+BPF_CALL_1(bpf_get_user_ctx_trace, void *, ctx)
+{
+	struct bpf_trace_run_ctx *run_ctx;
+
+	run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, run_ctx);
+	return run_ctx->user_ctx;
+}
+
+static const struct bpf_func_proto bpf_get_user_ctx_proto_trace = {
+	.func		= bpf_get_user_ctx_trace,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+};
+
+BPF_CALL_1(bpf_get_user_ctx_pe, struct bpf_perf_event_data_kern *, ctx)
+{
+	return ctx->event->user_ctx;
+}
+
+static const struct bpf_func_proto bpf_get_user_ctx_proto_pe = {
+	.func		= bpf_get_user_ctx_pe,
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
+	case BPF_FUNC_get_user_ctx:
+		return &bpf_get_user_ctx_proto_trace;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
@@ -1218,6 +1247,8 @@ tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_stackid_proto_tp;
 	case BPF_FUNC_get_stack:
 		return &bpf_get_stack_proto_tp;
+	case BPF_FUNC_get_user_ctx:
+		return &bpf_get_user_ctx_proto_trace;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
@@ -1325,6 +1356,8 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_perf_prog_read_value_proto;
 	case BPF_FUNC_read_branch_records:
 		return &bpf_read_branch_records_proto;
+	case BPF_FUNC_get_user_ctx:
+		return &bpf_get_user_ctx_proto_pe;
 	default:
 		return bpf_tracing_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bc1fd54a8f58..96afeced3467 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4856,6 +4856,21 @@ union bpf_attr {
  * 		Get address of the traced function (for tracing and kprobe programs).
  * 	Return
  * 		Address of the traced function.
+ *
+ * u64 bpf_get_user_ctx(void *ctx)
+ * 	Description
+ * 		Get user_ctx value provided (optionally) during the program
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
+	FN(get_user_ctx),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.30.2

