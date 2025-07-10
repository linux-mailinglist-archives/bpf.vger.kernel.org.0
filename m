Return-Path: <bpf+bounces-62948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DCEB008FA
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A901CA2B2B
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB70B2F3650;
	Thu, 10 Jul 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FwszoUsv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D047E2EFDB6;
	Thu, 10 Jul 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165375; cv=none; b=J7MWv1mCCQ5aVPC81S7+rDPZwiz8R4qaFHtxr/H9UaXIEZb5DwcIRPkrLnSsNK5OPWKjbv5SSQrYhUTabsy9CT8Tb4gvaeNhc48niIff5ETJ17bv+5E4jFeSWGZhH/an76ERM2fUp8uTqj0gbiVHvzVttICKh+SrUfeF/GHRBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165375; c=relaxed/simple;
	bh=tlHRS/3dt5vPHNG7TOjoA/M9EqsgRoiFmsUModFlv+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIKm4uoy3aCKzS36VqXo9X5iicXrulg5B6KQp0YoGNK/UI8yN66HkTqnlI1dX9BtLqYeA82pWANkTZFMEndyrowprRHkjbJmwxUCWobt4olFzFoONmeiYxWKzjZA8GsCWpwnIllJg4jX3d4IreBWGBdj832mgHj0jR6Z8DxIAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FwszoUsv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AC0FgV001435;
	Thu, 10 Jul 2025 16:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QAhNw+3PmjnJqXWn4
	rXxvRrX6iP/uIyWxAm1aAO/TlI=; b=FwszoUsv0OZayXeLnPgXkTy0k3N6VlDqd
	CgsEo7HSysyowbkTH/Qx1qRsPqB72mAdQbpm1m+PQACbMG1ioXo86DD+Xu8GitNM
	Qz9NowIKahs3viwakfJqa3+Yu1HHlTKO1XJinrf8K8vx3ZXdFxcHsNQynCf+LQX2
	mldTqNoR/KgYOq1nwr7cPUeG3q7VZLRDqO7K7RSobrxhN+JtMAst7SPPudbve5zE
	aI4xscvZ1Zk6BqGd+ha06e5X+8DNtB7AoAPuDHKKMsooeOoXLVdn/YoVb8zSKe+A
	3IRCuVJ1a03pgopoq4wzggq/KXL5IDkhpnRS69T/TB4PbZoKuhczg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pusse6a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56ADuSbL010799;
	Thu, 10 Jul 2025 16:35:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qes0eqta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZQG726935998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E503A20043;
	Thu, 10 Jul 2025 16:35:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA7D12004B;
	Thu, 10 Jul 2025 16:35:25 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:25 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 06/16] unwind_user: Enable archs that define CFA = SP_callsite + offset
Date: Thu, 10 Jul 2025 18:35:12 +0200
Message-ID: <20250710163522.3195293-7-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250710163522.3195293-1-jremus@linux.ibm.com>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686febd3 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=D-3WH5monn3MMgO2UeQA:9
X-Proofpoint-GUID: u41CYhcIwMbRZ4l0KPS3Lv9yXfOHmsHn
X-Proofpoint-ORIG-GUID: u41CYhcIwMbRZ4l0KPS3Lv9yXfOHmsHn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfXxpR7Ce40CS1q qjSY9skIuztPq21MiiMpV4NPDQ9rCQ6O8juCBFwUdHhoFvHglGZBxT0tVqP3veFgCWAKp8KNE0V LlWBB/VoVJhkmAuq5hjWWPvHhqEDKEceaX2Zh/zGiH72rJpBU/uElJ/5jRW/VoH3y0CbgQwVMDr
 myRfX240ZqcjedMZRnsf6Woz5I9HPPGr9kUqdI5WJatUekD8ii0hRGtxJhRdJd6UCwZAeiHxqOL a+NIGlDL9c7beW8OyQMHIaxK7uD4TmD4NYLzbZvVx09I+AU/u5dlsInEjGHRFVogCkJ9rd2Ah27 zgnOA8Yx4KD1t2ghHj2BCgx8vg2HhHkB8jJFzvV/yqresPjaVK2kf/bvKCv1Hejbe+X5ddqJjcl
 ofl6MWN0yPsJj/1UyInAWEoSL1CZwbVwZY9Zm6ovauu7zv2gexu+pp/BN8Yuo/5qkXPMcm4L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=812 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

Most architectures define their CFA as the value of the stack pointer
(SP) at the call site in the previous frame, as suggested by the DWARF
standard:

  CFA = <SP at call site>

Enable unwinding of user space for architectures, such as s390, which
define their CFA as the value of the SP at the call site in the previous
frame with an offset:

  CFA = <SP at call site> + offset

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Alternatively the conditional definition of generic_sframe_sp_val_off()
    could be moved into kernel/unwind/sframe.c.

 arch/x86/include/asm/unwind_user.h       |  2 ++
 include/asm-generic/Kbuild               |  1 +
 include/asm-generic/unwind_user_sframe.h | 30 ++++++++++++++++++++++++
 include/linux/unwind_user_types.h        |  1 +
 kernel/unwind/sframe.c                   |  2 ++
 kernel/unwind/user.c                     |  8 ++++---
 6 files changed, 41 insertions(+), 3 deletions(-)
 create mode 100644 include/asm-generic/unwind_user_sframe.h

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 19634a73612d..c2881840adf4 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -8,6 +8,7 @@
 	.cfa_off	= (s32)sizeof(long) *  2,				\
 	.ra_off		= (s32)sizeof(long) * -1,				\
 	.fp_off		= (s32)sizeof(long) * -2,				\
+	.sp_val_off	= (s32)0,						\
 	.use_fp		= true,
 
 #ifdef CONFIG_IA32_EMULATION
@@ -16,6 +17,7 @@
 	.cfa_off	= (s32)sizeof(u32)  *  2,				\
 	.ra_off		= (s32)sizeof(u32)  * -1,				\
 	.fp_off		= (s32)sizeof(u32)  * -2,				\
+	.sp_val_off	= (s32)0,						\
 	.use_fp		= true,
 
 #define in_compat_mode(regs) !user_64bit_mode(regs)
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index b797a2434396..64a15cde776c 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -60,6 +60,7 @@ mandatory-y += topology.h
 mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
 mandatory-y += unwind_user.h
+mandatory-y += unwind_user_sframe.h
 mandatory-y += unwind_user_types.h
 mandatory-y += vermagic.h
 mandatory-y += vga.h
diff --git a/include/asm-generic/unwind_user_sframe.h b/include/asm-generic/unwind_user_sframe.h
new file mode 100644
index 000000000000..6c87a7f29861
--- /dev/null
+++ b/include/asm-generic/unwind_user_sframe.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_UNWIND_USER_SFRAME_H
+#define _ASM_GENERIC_UNWIND_USER_SFRAME_H
+
+#include <linux/types.h>
+
+/**
+ * generic_sframe_sp_val_off - Get generic SP value offset from CFA.
+ *
+ * During unwinding the stack pointer (SP) at call site can be derived
+ * from the Canonical Frame Address (CFA) as follows:
+ *
+ *   SP = CFA + SP_val_off
+ *
+ * Most architectures define the CFA as value of SP at call site, as
+ * suggested by DWARF. For those architectures the SP value offset
+ * from CFA is 0, so that the SP at call site computes as:
+ *
+ *   SP = CFA
+ *
+ * Returns the generic SP value offset from CFA of 0.
+ */
+static inline s32 generic_sframe_sp_val_off(void)
+{
+	return 0;
+}
+
+#define sframe_sp_val_off generic_sframe_sp_val_off
+
+#endif /* _ASM_GENERIC_UNWIND_USER_SFRAME_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 4d50476e950e..8050a3237a03 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -25,6 +25,7 @@ struct unwind_user_frame {
 	s32 cfa_off;
 	s32 ra_off;
 	s32 fp_off;
+	s32 sp_val_off;
 	bool use_fp;
 };
 
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 6159f072bdb6..acbf791e713b 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
 #include <linux/sframe.h>
+#include <asm/unwind_user_sframe.h>
 #include <linux/unwind_user_types.h>
 
 #include "sframe.h"
@@ -313,6 +314,7 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	frame->ra_off  = fre->ra_off;
 	frame->fp_off  = fre->fp_off;
 	frame->use_fp  = SFRAME_FRE_CFA_BASE_REG_ID(fre->info) == SFRAME_BASE_REG_FP;
+	frame->sp_val_off = sframe_sp_val_off();
 
 	return 0;
 }
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index d0181c636c6b..45c8c6932ba6 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -52,7 +52,7 @@ static int unwind_user_next(struct unwind_user_state *state)
 {
 	struct unwind_user_frame *frame;
 	struct unwind_user_frame _frame;
-	unsigned long cfa = 0, fp, ra = 0;
+	unsigned long cfa = 0, sp, fp, ra = 0;
 	unsigned int shift;
 
 	if (state->done)
@@ -84,8 +84,10 @@ static int unwind_user_next(struct unwind_user_state *state)
 	}
 	cfa += frame->cfa_off;
 
+	/* Get the Stack Pointer (SP) */
+	sp = cfa + frame->sp_val_off;
 	/* Make sure that stack is not going in wrong direction */
-	if (cfa <= state->sp)
+	if (sp <= state->sp)
 		goto done;
 
 	/* Make sure that the address is word aligned */
@@ -102,7 +104,7 @@ static int unwind_user_next(struct unwind_user_state *state)
 		goto done;
 
 	state->ip = ra;
-	state->sp = cfa;
+	state->sp = sp;
 	if (frame->fp_off)
 		state->fp = fp;
 
-- 
2.48.1


