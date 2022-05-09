Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3D751F264
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 03:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiEIBbN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 8 May 2022 21:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiEIAqG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 20:46:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BDC6430
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 17:42:14 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 248L0AE9010450
        for <bpf@vger.kernel.org>; Sun, 8 May 2022 17:42:13 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fxhwws2bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 08 May 2022 17:42:13 -0700
Received: from twshared0725.22.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 8 May 2022 17:42:12 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8E98419A4AD5A; Sun,  8 May 2022 17:42:03 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 7/9] libbpf: provide barrier() and barrier_var() in bpf_helpers.h
Date:   Sun, 8 May 2022 17:41:46 -0700
Message-ID: <20220509004148.1801791-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220509004148.1801791-1-andrii@kernel.org>
References: <20220509004148.1801791-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SWIVyP9ulMQX5kbj2SJx9EJ4n6ZSCOhd
X-Proofpoint-ORIG-GUID: SWIVyP9ulMQX5kbj2SJx9EJ4n6ZSCOhd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add barrier() and barrier_var() macros into bpf_helpers.h to be used by
end users. While a bit advanced and specialized instruments, they are
sometimes indispensable. Instead of requiring each user to figure out
exact asm volatile incantations for themselves, provide them from
bpf_helpers.h.

Also remove conflicting definitions from selftests. Some tests rely on
barrier_var() definition being nothing, those will still work as libbpf
does the #ifndef/#endif guarding for barrier() and barrier_var(),
allowing users to redefine them, if necessary.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h                   | 24 +++++++++++++++++++
 .../selftests/bpf/progs/exhandler_kern.c      |  2 --
 tools/testing/selftests/bpf/progs/loop5.c     |  1 -
 tools/testing/selftests/bpf/progs/profiler1.c |  1 -
 tools/testing/selftests/bpf/progs/pyperf.h    |  2 --
 .../selftests/bpf/progs/test_pkt_access.c     |  2 --
 6 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index bbae9a057bc8..fb04eaf367f1 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -75,6 +75,30 @@
 	})
 #endif
 
+/*
+ * Compiler (optimization) barrier.
+ */
+#ifndef barrier
+#define barrier() asm volatile("" ::: "memory")
+#endif
+
+/* Variable-specific compiler (optimization) barrier. It's a no-op which makes
+ * compiler believe that there is some black box modification of a given
+ * variable and thus prevents compiler from making extra assumption about its
+ * value and potential simplifications and optimizations on this variable.
+ *
+ * E.g., compiler might often delay or even omit 32-bit to 64-bit casting of
+ * a variable, making some code patterns unverifiable. Putting barrier_var()
+ * in place will ensure that cast is performed before the barrier_var()
+ * invocation, because compiler has to pessimistically assume that embedded
+ * asm section might perform some extra operations on that variable.
+ *
+ * This is a variable-specific variant of more global barrier().
+ */
+#ifndef barrier_var
+#define barrier_var(var) asm volatile("" : "=r"(var) : "0"(var))
+#endif
+
 /*
  * Helper macro to throw a compilation error if __bpf_unreachable() gets
  * built into the resulting code. This works given BPF back end does not
diff --git a/tools/testing/selftests/bpf/progs/exhandler_kern.c b/tools/testing/selftests/bpf/progs/exhandler_kern.c
index dd9b30a0f0fc..20d009e2d266 100644
--- a/tools/testing/selftests/bpf/progs/exhandler_kern.c
+++ b/tools/testing/selftests/bpf/progs/exhandler_kern.c
@@ -7,8 +7,6 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
-#define barrier_var(var) asm volatile("" : "=r"(var) : "0"(var))
-
 char _license[] SEC("license") = "GPL";
 
 unsigned int exception_triggered;
diff --git a/tools/testing/selftests/bpf/progs/loop5.c b/tools/testing/selftests/bpf/progs/loop5.c
index 913791923fa3..1b13f37f85ec 100644
--- a/tools/testing/selftests/bpf/progs/loop5.c
+++ b/tools/testing/selftests/bpf/progs/loop5.c
@@ -2,7 +2,6 @@
 // Copyright (c) 2019 Facebook
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
-#define barrier() __asm__ __volatile__("": : :"memory")
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/profiler1.c b/tools/testing/selftests/bpf/progs/profiler1.c
index 4df9088bfc00..fb6b13522949 100644
--- a/tools/testing/selftests/bpf/progs/profiler1.c
+++ b/tools/testing/selftests/bpf/progs/profiler1.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
-#define barrier_var(var) asm volatile("" : "=r"(var) : "0"(var))
 #define UNROLL
 #define INLINE __always_inline
 #include "profiler.inc.h"
diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/selftests/bpf/progs/pyperf.h
index 5d3dc4d66d47..6c7b1fb268d6 100644
--- a/tools/testing/selftests/bpf/progs/pyperf.h
+++ b/tools/testing/selftests/bpf/progs/pyperf.h
@@ -171,8 +171,6 @@ struct process_frame_ctx {
 	bool done;
 };
 
-#define barrier_var(var) asm volatile("" : "=r"(var) : "0"(var))
-
 static int process_frame_callback(__u32 i, struct process_frame_ctx *ctx)
 {
 	int zero = 0;
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index 0558544e1ff0..5cd7c096f62d 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -14,8 +14,6 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
-#define barrier() __asm__ __volatile__("": : :"memory")
-
 /* llvm will optimize both subprograms into exactly the same BPF assembly
  *
  * Disassembly of section .text:
-- 
2.30.2

