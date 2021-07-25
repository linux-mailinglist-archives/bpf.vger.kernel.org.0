Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5843D4F2A
	for <lists+bpf@lfdr.de>; Sun, 25 Jul 2021 19:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhGYQ7D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 25 Jul 2021 12:59:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15558 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231189AbhGYQ7D (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 25 Jul 2021 12:59:03 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16PHXtZp032339
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 10:39:32 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3a0ej0nuhf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 10:39:32 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Jul 2021 10:39:31 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 9C52C3D405B6; Sun, 25 Jul 2021 10:39:21 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH bpf-next 13/14] selftests/bpf: extract uprobe-related helpers into trace_helpers.{c,h}
Date:   Sun, 25 Jul 2021 10:38:44 -0700
Message-ID: <20210725173845.2593626-14-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210725173845.2593626-1-andrii@kernel.org>
References: <20210725173845.2593626-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: csT5Zt9eMpHoVDfYbV_yZKm5igiPJmxd
X-Proofpoint-GUID: csT5Zt9eMpHoVDfYbV_yZKm5igiPJmxd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-25_05:2021-07-23,2021-07-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107250126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extract two helpers used for working with uprobes into trace_helpers.{c,h} to
be re-used between multiple uprobe-using selftests. Also rename get_offset()
into more appropriate get_uprobe_offset().

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 61 +----------------
 tools/testing/selftests/bpf/trace_helpers.c   | 66 +++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |  3 +
 3 files changed, 70 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index ec11e20d2b92..e40b41c44f8b 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -2,65 +2,6 @@
 #include <test_progs.h>
 #include "test_attach_probe.skel.h"
 
-#if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF == 2
-
-#define OP_RT_RA_MASK   0xffff0000UL
-#define LIS_R2          0x3c400000UL
-#define ADDIS_R2_R12    0x3c4c0000UL
-#define ADDI_R2_R2      0x38420000UL
-
-static ssize_t get_offset(ssize_t addr, ssize_t base)
-{
-	u32 *insn = (u32 *) addr;
-
-	/*
-	 * A PPC64 ABIv2 function may have a local and a global entry
-	 * point. We need to use the local entry point when patching
-	 * functions, so identify and step over the global entry point
-	 * sequence.
-	 *
-	 * The global entry point sequence is always of the form:
-	 *
-	 * addis r2,r12,XXXX
-	 * addi  r2,r2,XXXX
-	 *
-	 * A linker optimisation may convert the addis to lis:
-	 *
-	 * lis   r2,XXXX
-	 * addi  r2,r2,XXXX
-	 */
-	if ((((*insn & OP_RT_RA_MASK) == ADDIS_R2_R12) ||
-	     ((*insn & OP_RT_RA_MASK) == LIS_R2)) &&
-	    ((*(insn + 1) & OP_RT_RA_MASK) == ADDI_R2_R2))
-		return (ssize_t)(insn + 2) - base;
-	else
-		return addr - base;
-}
-#else
-#define get_offset(addr, base) (addr - base)
-#endif
-
-ssize_t get_base_addr() {
-	size_t start, offset;
-	char buf[256];
-	FILE *f;
-
-	f = fopen("/proc/self/maps", "r");
-	if (!f)
-		return -errno;
-
-	while (fscanf(f, "%zx-%*x %s %zx %*[^\n]\n",
-		      &start, buf, &offset) == 3) {
-		if (strcmp(buf, "r-xp") == 0) {
-			fclose(f);
-			return start - offset;
-		}
-	}
-
-	fclose(f);
-	return -EINVAL;
-}
-
 void test_attach_probe(void)
 {
 	int duration = 0;
@@ -74,7 +15,7 @@ void test_attach_probe(void)
 	if (CHECK(base_addr < 0, "get_base_addr",
 		  "failed to find base addr: %zd", base_addr))
 		return;
-	uprobe_offset = get_offset((size_t)&get_base_addr, base_addr);
+	uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
 
 	skel = test_attach_probe__open_and_load();
 	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 1bbd1d9830c8..381dafce1d8f 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -136,3 +136,69 @@ void read_trace_pipe(void)
 		}
 	}
 }
+
+#if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF == 2
+
+#define OP_RT_RA_MASK   0xffff0000UL
+#define LIS_R2          0x3c400000UL
+#define ADDIS_R2_R12    0x3c4c0000UL
+#define ADDI_R2_R2      0x38420000UL
+
+ssize_t get_uprobe_offset(const void *addr, ssize_t base)
+{
+	u32 *insn = (u32 *)(uintptr_t)addr;
+
+	/*
+	 * A PPC64 ABIv2 function may have a local and a global entry
+	 * point. We need to use the local entry point when patching
+	 * functions, so identify and step over the global entry point
+	 * sequence.
+	 *
+	 * The global entry point sequence is always of the form:
+	 *
+	 * addis r2,r12,XXXX
+	 * addi  r2,r2,XXXX
+	 *
+	 * A linker optimisation may convert the addis to lis:
+	 *
+	 * lis   r2,XXXX
+	 * addi  r2,r2,XXXX
+	 */
+	if ((((*insn & OP_RT_RA_MASK) == ADDIS_R2_R12) ||
+	     ((*insn & OP_RT_RA_MASK) == LIS_R2)) &&
+	    ((*(insn + 1) & OP_RT_RA_MASK) == ADDI_R2_R2))
+		return (ssize_t)(insn + 2) - base;
+	else
+		return (uintptr_t)addr - base;
+}
+
+#else
+
+ssize_t get_uprobe_offset(const void *addr, ssize_t base)
+{
+	return (uintptr_t)addr - base;
+}
+
+#endif
+
+ssize_t get_base_addr(void)
+{
+	size_t start, offset;
+	char buf[256];
+	FILE *f;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f)
+		return -errno;
+
+	while (fscanf(f, "%zx-%*x %s %zx %*[^\n]\n",
+		      &start, buf, &offset) == 3) {
+		if (strcmp(buf, "r-xp") == 0) {
+			fclose(f);
+			return start - offset;
+		}
+	}
+
+	fclose(f);
+	return -EINVAL;
+}
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index f62fdef9e589..3d9435b3dd3b 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -18,4 +18,7 @@ int kallsyms_find(const char *sym, unsigned long long *addr);
 
 void read_trace_pipe(void);
 
+ssize_t get_uprobe_offset(const void *addr, ssize_t base);
+ssize_t get_base_addr(void);
+
 #endif
-- 
2.30.2

