Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5328E675E9E
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjATUJv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 Jan 2023 15:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjATUJu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:50 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E117A199B
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:49 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K8RA68008139
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:49 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n702vk0ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:49 -0800
Received: from twshared25383.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 12:09:45 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 412B125B4B0EB; Fri, 20 Jan 2023 12:09:38 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 bpf-next 11/25] selftests/bpf: validate arch-specific argument registers limits
Date:   Fri, 20 Jan 2023 12:09:00 -0800
Message-ID: <20230120200914.3008030-12-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230120200914.3008030-1-andrii@kernel.org>
References: <20230120200914.3008030-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4SDqj2HCeq7sePx9Mycqth_bXUITgtUv
X-Proofpoint-ORIG-GUID: 4SDqj2HCeq7sePx9Mycqth_bXUITgtUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_10,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update uprobe_autoattach selftest to validate architecture-specific
argument passing through registers. Use new BPF_UPROBE and
BPF_URETPROBE, and construct both BPF-side and user-space side in such
a way that for different architectures we are fetching and checking
different number of arguments, matching architecture-specific limit of
how many registers are available for argument passing.

Tested-by: Alan Maguire <alan.maguire@oracle.com> # arm64
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com> # s390x
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/uprobe_autoattach.c        | 33 +++++++++++--
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 25 ++++++++++
 .../bpf/progs/test_uprobe_autoattach.c        | 48 ++++++++++++++++++-
 3 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
index 35b87c7ba5be..82807def0d24 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
@@ -3,18 +3,21 @@
 
 #include <test_progs.h>
 #include "test_uprobe_autoattach.skel.h"
+#include "progs/bpf_misc.h"
 
 /* uprobe attach point */
-static noinline int autoattach_trigger_func(int arg)
+static noinline int autoattach_trigger_func(int arg1, int arg2, int arg3,
+					    int arg4, int arg5, int arg6,
+					    int arg7, int arg8)
 {
 	asm volatile ("");
-	return arg + 1;
+	return arg1 + arg2 + arg3 + arg4 + arg5 + arg6 + arg7 + arg8 + 1;
 }
 
 void test_uprobe_autoattach(void)
 {
 	struct test_uprobe_autoattach *skel;
-	int trigger_val = 100, trigger_ret;
+	int trigger_ret;
 	size_t malloc_sz = 1;
 	char *mem;
 
@@ -28,22 +31,42 @@ void test_uprobe_autoattach(void)
 	skel->bss->test_pid = getpid();
 
 	/* trigger & validate uprobe & uretprobe */
-	trigger_ret = autoattach_trigger_func(trigger_val);
+	trigger_ret = autoattach_trigger_func(1, 2, 3, 4, 5, 6, 7, 8);
 
 	skel->bss->test_pid = getpid();
 
 	/* trigger & validate shared library u[ret]probes attached by name */
 	mem = malloc(malloc_sz);
 
-	ASSERT_EQ(skel->bss->uprobe_byname_parm1, trigger_val, "check_uprobe_byname_parm1");
+	ASSERT_EQ(skel->bss->uprobe_byname_parm1, 1, "check_uprobe_byname_parm1");
 	ASSERT_EQ(skel->bss->uprobe_byname_ran, 1, "check_uprobe_byname_ran");
 	ASSERT_EQ(skel->bss->uretprobe_byname_rc, trigger_ret, "check_uretprobe_byname_rc");
+	ASSERT_EQ(skel->bss->uretprobe_byname_ret, trigger_ret, "check_uretprobe_byname_ret");
 	ASSERT_EQ(skel->bss->uretprobe_byname_ran, 2, "check_uretprobe_byname_ran");
 	ASSERT_EQ(skel->bss->uprobe_byname2_parm1, malloc_sz, "check_uprobe_byname2_parm1");
 	ASSERT_EQ(skel->bss->uprobe_byname2_ran, 3, "check_uprobe_byname2_ran");
 	ASSERT_EQ(skel->bss->uretprobe_byname2_rc, mem, "check_uretprobe_byname2_rc");
 	ASSERT_EQ(skel->bss->uretprobe_byname2_ran, 4, "check_uretprobe_byname2_ran");
 
+	ASSERT_EQ(skel->bss->a[0], 1, "arg1");
+	ASSERT_EQ(skel->bss->a[1], 2, "arg2");
+	ASSERT_EQ(skel->bss->a[2], 3, "arg3");
+#if FUNC_REG_ARG_CNT > 3
+	ASSERT_EQ(skel->bss->a[3], 4, "arg4");
+#endif
+#if FUNC_REG_ARG_CNT > 4
+	ASSERT_EQ(skel->bss->a[4], 5, "arg5");
+#endif
+#if FUNC_REG_ARG_CNT > 5
+	ASSERT_EQ(skel->bss->a[5], 6, "arg6");
+#endif
+#if FUNC_REG_ARG_CNT > 6
+	ASSERT_EQ(skel->bss->a[6], 7, "arg7");
+#endif
+#if FUNC_REG_ARG_CNT > 7
+	ASSERT_EQ(skel->bss->a[7], 8, "arg8");
+#endif
+
 	free(mem);
 cleanup:
 	test_uprobe_autoattach__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 4a01ea9113bf..ecce51404f57 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -21,4 +21,29 @@
 #define SYS_PREFIX "__se_"
 #endif
 
+/* How many arguments are passed to function in register */
+#if defined(__TARGET_ARCH_x86) || defined(__x86_64__)
+#define FUNC_REG_ARG_CNT 6
+#elif defined(__i386__)
+#define FUNC_REG_ARG_CNT 3
+#elif defined(__TARGET_ARCH_s390) || defined(__s390x__)
+#define FUNC_REG_ARG_CNT 5
+#elif defined(__TARGET_ARCH_arm) || defined(__arm__)
+#define FUNC_REG_ARG_CNT 4
+#elif defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
+#define FUNC_REG_ARG_CNT 8
+#elif defined(__TARGET_ARCH_mips) || defined(__mips__)
+#define FUNC_REG_ARG_CNT 8
+#elif defined(__TARGET_ARCH_powerpc) || defined(__powerpc__) || defined(__powerpc64__)
+#define FUNC_REG_ARG_CNT 8
+#elif defined(__TARGET_ARCH_sparc) || defined(__sparc__)
+#define FUNC_REG_ARG_CNT 6
+#elif defined(__TARGET_ARCH_riscv) || defined(__riscv__)
+#define FUNC_REG_ARG_CNT 8
+#else
+/* default to 5 for others */
+#define FUNC_REG_ARG_CNT 5
+#endif
+
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
index ab75522e2eeb..774ddeb45898 100644
--- a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
+++ b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
@@ -6,10 +6,12 @@
 #include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
 
 int uprobe_byname_parm1 = 0;
 int uprobe_byname_ran = 0;
 int uretprobe_byname_rc = 0;
+int uretprobe_byname_ret = 0;
 int uretprobe_byname_ran = 0;
 size_t uprobe_byname2_parm1 = 0;
 int uprobe_byname2_ran = 0;
@@ -18,6 +20,8 @@ int uretprobe_byname2_ran = 0;
 
 int test_pid;
 
+int a[8];
+
 /* This program cannot auto-attach, but that should not stop other
  * programs from attaching.
  */
@@ -28,18 +32,58 @@ int handle_uprobe_noautoattach(struct pt_regs *ctx)
 }
 
 SEC("uprobe//proc/self/exe:autoattach_trigger_func")
-int handle_uprobe_byname(struct pt_regs *ctx)
+int BPF_UPROBE(handle_uprobe_byname
+	       , int arg1
+	       , int arg2
+	       , int arg3
+#if FUNC_REG_ARG_CNT > 3
+	       , int arg4
+#endif
+#if FUNC_REG_ARG_CNT > 4
+	       , int arg5
+#endif
+#if FUNC_REG_ARG_CNT > 5
+	       , int arg6
+#endif
+#if FUNC_REG_ARG_CNT > 6
+	       , int arg7
+#endif
+#if FUNC_REG_ARG_CNT > 7
+	       , int arg8
+#endif
+)
 {
 	uprobe_byname_parm1 = PT_REGS_PARM1_CORE(ctx);
 	uprobe_byname_ran = 1;
+
+	a[0] = arg1;
+	a[1] = arg2;
+	a[2] = arg3;
+#if FUNC_REG_ARG_CNT > 3
+	a[3] = arg4;
+#endif
+#if FUNC_REG_ARG_CNT > 4
+	a[4] = arg5;
+#endif
+#if FUNC_REG_ARG_CNT > 5
+	a[5] = arg6;
+#endif
+#if FUNC_REG_ARG_CNT > 6
+	a[6] = arg7;
+#endif
+#if FUNC_REG_ARG_CNT > 7
+	a[7] = arg8;
+#endif
 	return 0;
 }
 
 SEC("uretprobe//proc/self/exe:autoattach_trigger_func")
-int handle_uretprobe_byname(struct pt_regs *ctx)
+int BPF_URETPROBE(handle_uretprobe_byname, int ret)
 {
 	uretprobe_byname_rc = PT_REGS_RC_CORE(ctx);
+	uretprobe_byname_ret = ret;
 	uretprobe_byname_ran = 2;
+
 	return 0;
 }
 
-- 
2.30.2

