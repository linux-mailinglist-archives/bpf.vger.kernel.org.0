Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3484AD0D7
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 06:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiBHFcs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 00:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiBHFRI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 00:17:08 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CC3C0401E9
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 21:17:06 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21844QNP024668;
        Tue, 8 Feb 2022 05:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RlgzrrSc1bi6IEHhXxDTXeYaJzKc+9zY44gue3N+N6E=;
 b=HAYueCiNCHZL1hk2osoAXhIxmA1cpye+Lv55vw5NXdcAvJSeSWafHu9utUmFAAW1Nu9a
 nt5Oe+D8Wyd/dMIuBAyzNc3UeZnt4t6hXD9oOKas7gp/8aLaMryKjVWZr/WnHTGhiaCn
 XASMvmY1JvR0o9NkAjx071qmWQLMIOkuM+8H2MpKJbVeC9MrXwUHiac7wu3ZCDSLMGU2
 i8fe56dmUmAM+jNWVtQqmK7cCo3eAVv+vWsgEgeGeopQsAu52fRkl5+i4kPdP/op3Ljp
 04bsPn19EpuDOBMhERYafh/4C6hPHuUjJZZmgZBg7Lua4Y3jC/UZ78UtncbhLoBPUllJ +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22vm7jvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:48 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2185GmgL010569;
        Tue, 8 Feb 2022 05:16:48 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22vm7jv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:47 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2185Cpn9003673;
        Tue, 8 Feb 2022 05:16:46 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3e1gv92ean-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 05:16:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2185GfCh43843846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Feb 2022 05:16:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2185F11C052;
        Tue,  8 Feb 2022 05:16:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72E2211C04A;
        Tue,  8 Feb 2022 05:16:40 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Feb 2022 05:16:40 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v4 03/14] selftests/bpf: Compile bpf_syscall_macro test also with user headers
Date:   Tue,  8 Feb 2022 06:16:24 +0100
Message-Id: <20220208051635.2160304-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208051635.2160304-1-iii@linux.ibm.com>
References: <20220208051635.2160304-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RsqGNcD4z-O5-zK-zRvf2lhZr36q8bVA
X-Proofpoint-ORIG-GUID: qsXDDj5rQX4kD3MbYG_kKz5kjZmSVUXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Verify that using linux/ptrace.h instead of vmlinux.h works fine.
Since without vmlinux.h and with CO-RE it's not possible to access the
first syscall argument on arm64 and s390x, and any syscall arguments on
Intel, skip the corresponding checks.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 ...call_macro.c => test_bpf_syscall_macro_common.h} |  8 +++++++-
 .../bpf/prog_tests/test_bpf_syscall_macro_kernel.c  | 13 +++++++++++++
 .../bpf/prog_tests/test_bpf_syscall_macro_user.c    | 13 +++++++++++++
 ...f_syscall_macro.c => bpf_syscall_macro_common.h} |  8 ++++++--
 .../selftests/bpf/progs/bpf_syscall_macro_kernel.c  |  4 ++++
 .../selftests/bpf/progs/bpf_syscall_macro_user.c    | 10 ++++++++++
 6 files changed, 53 insertions(+), 3 deletions(-)
 rename tools/testing/selftests/bpf/prog_tests/{test_bpf_syscall_macro.c => test_bpf_syscall_macro_common.h} (89%)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_kernel.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_user.c
 rename tools/testing/selftests/bpf/progs/{bpf_syscall_macro.c => bpf_syscall_macro_common.h} (87%)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_syscall_macro_kernel.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_syscall_macro_user.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_common.h
similarity index 89%
rename from tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
rename to tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_common.h
index f5f4c8adf539..9f2a395abff7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_common.h
@@ -2,7 +2,6 @@
 /* Copyright 2022 Sony Group Corporation */
 #include <sys/prctl.h>
 #include <test_progs.h>
-#include "bpf_syscall_macro.skel.h"
 
 void test_bpf_syscall_macro(void)
 {
@@ -46,7 +45,13 @@ void test_bpf_syscall_macro(void)
 	ASSERT_EQ(skel->bss->arg5, exp_arg5, "syscall_arg5");
 
 	/* check whether args of syscall are copied correctly for CORE variants */
+#if defined(__BPF_SYSCALL_MACRO_KERNEL_SKEL_H__) || \
+		(!defined(__s390__) && !defined(__aarch64__) && \
+		 !defined(__i386__) && !defined(__x86_64__))
 	ASSERT_EQ(skel->bss->arg1_core, exp_arg1, "syscall_arg1_core_variant");
+#endif
+#if defined(__BPF_SYSCALL_MACRO_KERNEL_SKEL_H__) || \
+		(!defined(__i386__) && !defined(__x86_64__))
 	ASSERT_EQ(skel->bss->arg2_core, exp_arg2, "syscall_arg2_core_variant");
 	ASSERT_EQ(skel->bss->arg3_core, exp_arg3, "syscall_arg3_core_variant");
 	/* it cannot copy arg4 when uses PT_REGS_PARM4_CORE on x86_64 */
@@ -57,6 +62,7 @@ void test_bpf_syscall_macro(void)
 #endif
 	ASSERT_EQ(skel->bss->arg4_core, exp_arg4, "syscall_arg4_core_variant");
 	ASSERT_EQ(skel->bss->arg5_core, exp_arg5, "syscall_arg5_core_variant");
+#endif
 
 cleanup:
 	bpf_syscall_macro__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_kernel.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_kernel.c
new file mode 100644
index 000000000000..7ceabd62bb0f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_kernel.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "bpf_syscall_macro_kernel.skel.h"
+
+void test_bpf_syscall_macro_kernel(void);
+
+#define test_bpf_syscall_macro test_bpf_syscall_macro_kernel
+#define bpf_syscall_macro bpf_syscall_macro_kernel
+#define bpf_syscall_macro__open bpf_syscall_macro_kernel__open
+#define bpf_syscall_macro__load bpf_syscall_macro_kernel__load
+#define bpf_syscall_macro__attach bpf_syscall_macro_kernel__attach
+#define bpf_syscall_macro__destroy bpf_syscall_macro_kernel__destroy
+
+#include "test_bpf_syscall_macro_common.h"
diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_user.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_user.c
new file mode 100644
index 000000000000..f31558f14e7e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_user.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "bpf_syscall_macro_user.skel.h"
+
+void test_bpf_syscall_macro_user(void);
+
+#define test_bpf_syscall_macro test_bpf_syscall_macro_user
+#define bpf_syscall_macro bpf_syscall_macro_user
+#define bpf_syscall_macro__open bpf_syscall_macro_user__open
+#define bpf_syscall_macro__load bpf_syscall_macro_user__load
+#define bpf_syscall_macro__attach bpf_syscall_macro_user__attach
+#define bpf_syscall_macro__destroy bpf_syscall_macro_user__destroy
+
+#include "test_bpf_syscall_macro_common.h"
diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_common.h
similarity index 87%
rename from tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
rename to tools/testing/selftests/bpf/progs/bpf_syscall_macro_common.h
index f5c6ef2ff6d1..8717605358d3 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_common.h
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2022 Sony Group Corporation */
-#include <vmlinux.h>
-
 #include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
@@ -46,12 +44,18 @@ int BPF_KPROBE(handle_sys_prctl)
 	bpf_probe_read_kernel(&arg5, sizeof(arg5), &PT_REGS_PARM5_SYSCALL(real_regs));
 
 	/* test for the CORE variant of PT_REGS_PARM */
+#if defined(__KERNEL__) || defined(__VMLINUX_H__) || \
+		(!defined(bpf_target_s390) && !defined(bpf_target_arm64) && \
+		 !defined(bpf_target_x86))
 	arg1_core = PT_REGS_PARM1_CORE_SYSCALL(real_regs);
+#endif
+#if defined(__KERNEL__) || defined(__VMLINUX_H__) || !defined(bpf_target_x86)
 	arg2_core = PT_REGS_PARM2_CORE_SYSCALL(real_regs);
 	arg3_core = PT_REGS_PARM3_CORE_SYSCALL(real_regs);
 	arg4_core_cx = PT_REGS_PARM4_CORE(real_regs);
 	arg4_core = PT_REGS_PARM4_CORE_SYSCALL(real_regs);
 	arg5_core = PT_REGS_PARM5_CORE_SYSCALL(real_regs);
+#endif
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro_kernel.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_kernel.c
new file mode 100644
index 000000000000..1affac21266d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_kernel.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+
+#include "bpf_syscall_macro_common.h"
diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro_user.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_user.c
new file mode 100644
index 000000000000..1c078d528e8c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_user.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ptrace.h>
+#include <linux/types.h>
+#include <sys/types.h>
+
+#include "bpf_syscall_macro_common.h"
+
+#if defined(__KERNEL__) || defined(__VMLINUX_H__)
+#error This test must be compiled with userspace headers
+#endif
-- 
2.34.1

