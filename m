Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9056569728F
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 01:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBOAO6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 14 Feb 2023 19:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBOAO4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 19:14:56 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DBB2FCE9
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 16:14:55 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 31F03Igs005560
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 16:14:55 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3nqxkc8eex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 16:14:55 -0800
Received: from twshared22948.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 16:14:53 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A3724278768CD; Tue, 14 Feb 2023 16:14:48 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: add global subprog context passing tests
Date:   Tue, 14 Feb 2023 16:14:39 -0800
Message-ID: <20230215001439.748696-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230215001439.748696-1-andrii@kernel.org>
References: <20230215001439.748696-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pDYToa1FZKL_WPayCPGwcAb5i4a3QAPb
X-Proofpoint-ORIG-GUID: pDYToa1FZKL_WPayCPGwcAb5i4a3QAPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_16,2023-02-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests validating that it's possible to pass context arguments into
global subprogs for various types of programs, including a particularly
tricky KPROBE programs (which cover kprobes, uprobes, USDTs, a vast and
important class of programs).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/test_global_funcs.c        |   2 +
 .../bpf/progs/test_global_func_ctx_args.c     | 105 ++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index 2ff4d5c7abfc..e0879df38639 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -18,6 +18,7 @@
 #include "test_global_func15.skel.h"
 #include "test_global_func16.skel.h"
 #include "test_global_func17.skel.h"
+#include "test_global_func_ctx_args.skel.h"
 
 void test_test_global_funcs(void)
 {
@@ -38,4 +39,5 @@ void test_test_global_funcs(void)
 	RUN_TESTS(test_global_func15);
 	RUN_TESTS(test_global_func16);
 	RUN_TESTS(test_global_func17);
+	RUN_TESTS(test_global_func_ctx_args);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
new file mode 100644
index 000000000000..4b765f117180
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+static long stack[256];
+
+/*
+ * KPROBE contexts
+ */
+
+__weak int kprobe_typedef_ctx_subprog(bpf_user_pt_regs_t *ctx)
+{
+	return bpf_get_stack(ctx, &stack, sizeof(stack), 0);
+}
+
+SEC("?kprobe")
+__success
+int kprobe_typedef_ctx(void *ctx)
+{
+	return kprobe_typedef_ctx_subprog(ctx);
+}
+
+#define pt_regs_struct_t typeof(*(__PT_REGS_CAST((struct pt_regs *)NULL)))
+
+__weak int kprobe_struct_ctx_subprog(pt_regs_struct_t *ctx)
+{
+	return bpf_get_stack(ctx, &stack, sizeof(stack), 0);
+}
+
+SEC("?kprobe")
+__success
+int kprobe_resolved_ctx(void *ctx)
+{
+	return kprobe_struct_ctx_subprog(ctx);
+}
+
+/* this is current hack to make this work on old kernels */
+struct bpf_user_pt_regs_t {};
+
+__weak int kprobe_workaround_ctx_subprog(struct bpf_user_pt_regs_t *ctx)
+{
+	return bpf_get_stack(ctx, &stack, sizeof(stack), 0);
+}
+
+SEC("?kprobe")
+__success
+int kprobe_workaround_ctx(void *ctx)
+{
+	return kprobe_workaround_ctx_subprog(ctx);
+}
+
+/*
+ * RAW_TRACEPOINT contexts
+ */
+
+__weak int raw_tp_ctx_subprog(struct bpf_raw_tracepoint_args *ctx)
+{
+	return bpf_get_stack(ctx, &stack, sizeof(stack), 0);
+}
+
+SEC("?raw_tp")
+__success
+int raw_tp_ctx(void *ctx)
+{
+	return raw_tp_ctx_subprog(ctx);
+}
+
+/*
+ * RAW_TRACEPOINT_WRITABLE contexts
+ */
+
+__weak int raw_tp_writable_ctx_subprog(struct bpf_raw_tracepoint_args *ctx)
+{
+	return bpf_get_stack(ctx, &stack, sizeof(stack), 0);
+}
+
+SEC("?raw_tp")
+__success
+int raw_tp_writable_ctx(void *ctx)
+{
+	return raw_tp_writable_ctx_subprog(ctx);
+}
+
+/*
+ * PERF_EVENT contexts
+ */
+
+__weak int perf_event_ctx_subprog(struct bpf_perf_event_data *ctx)
+{
+	return bpf_get_stack(ctx, &stack, sizeof(stack), 0);
+}
+
+SEC("?perf_event")
+__success
+int perf_event_ctx(void *ctx)
+{
+	return perf_event_ctx_subprog(ctx);
+}
+
-- 
2.30.2

