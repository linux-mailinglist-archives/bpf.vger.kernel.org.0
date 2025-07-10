Return-Path: <bpf+bounces-62940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F06B008EC
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D9318950AA
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EE92F0E3D;
	Thu, 10 Jul 2025 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tTiTEq+N"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763C2F002D;
	Thu, 10 Jul 2025 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165356; cv=none; b=QJvCUD9beyBMKSE7FqNK1zaTPtbOJI5jlE3zh5ZbHA6Wt51QPR+PzOYFBen0Tlkv96Y48DkMrRwYbuJkxNCvEh+8kqIcXtFFmk7NoAz+lHROavGAAcHBsihkwBN0UUFyQCEA0w8w8AxDlD9xysr0y07GXMPaIsOFCnjDzRtoLwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165356; c=relaxed/simple;
	bh=n2itvvYUlCn5rgqIWxDID7RATFS5DLZ9PhmNJ3gj1Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvStBKUIFrOPs5Zj8oI7R72LYNxAguHXPkoM3lxZKA8qV2bihQq9Q2NgT9jDC4rR8Cvpv3DHLk1v+VVdsCMF1RfRvSoT3a6938umzoPrjm4CSAuMnsBP4pjIydEThN01V9XFWEtvJzTciOx3f/COwTE0iNryUZ1WFoyvEZd/Wh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tTiTEq+N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEKlkn017806;
	Thu, 10 Jul 2025 16:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ox5LynZ1Gk1k/gXvB
	MjGHkBXTN4Op7+eW6pteOyVnRk=; b=tTiTEq+NqOps46//OqNpRezVgEKBxZkZP
	SDCipor3oZgNiF3sSBJThSjFlGW/8NRtyhSDKB2XZjeb5RxVbJsggqChpi7EbvxE
	oQhbX6npPQPaIR6og/49nBuVN+LvMKgutz+/zh+wk3sCPyUMA1fUNSxTPYEFz6Lf
	IKYz911foELLqtc1D29uA645+zAriMVy1vk429EmposcFEn5+pdLdnQSq23bCaJh
	i8menPzdM0SNIcPDLIUZWqS0TCtaiKJOSqUrIDO5ReAoXIT3/1GqnUHG0QxHd2oZ
	KWiBfSuBikJa5BspH73KOB9L+5czeNP3C1Q2IElEiPXRgaoxs+ooQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqnmyru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEd7nW002855;
	Thu, 10 Jul 2025 16:35:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmpeng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZRZ835062186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E29C20040;
	Thu, 10 Jul 2025 16:35:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 138F72004D;
	Thu, 10 Jul 2025 16:35:27 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:27 +0000 (GMT)
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
Subject: [RFC PATCH v1 11/16] s390/unwind_user/sframe: Enable HAVE_UNWIND_USER_SFRAME
Date: Thu, 10 Jul 2025 18:35:17 +0200
Message-ID: <20250710163522.3195293-12-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FZ43xI+6 c=1 sm=1 tr=0 ts=686febd4 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=qHp_k-hexZ09bc3ecLAA:9
X-Proofpoint-GUID: Xx2EcqiWmTC3hCxCkIdaNByd1b0R4iNU
X-Proofpoint-ORIG-GUID: Xx2EcqiWmTC3hCxCkIdaNByd1b0R4iNU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfXybDdb6T2sG4Y ONAEAoN7Je5r+hAcp6RL5cGu+u8dqnxUuosQG+JOE6aIg9sBtzJvzWHflqg4T7REdRI4kWuXWsI mKJ48ScVaV/qqwd4WmnRHcYCKSHtJ7xrH/pPNFpq/aWbMYfRDRs9+oxIXDv7FShUPBFnzti2KYL
 /jXwTENkAkPW+j8T/kYpM38/CFNSX3ono5srg67NgQZ4FjaLo6t3AC5J/EramZCgO5mKLVjOvwo q+l8bg5PZhvOOq34bBD59FsMjA5xWNX8DrUN9TQUPezA4ZeHlWlZU3J3Zp2+hgq9/7VgEXI8HII Ptm4i5sZGjI/91iwrcW3inhO8z0qmptb4B1/CP2bShWqM+m2X49jq2C/p5zdZYnoLoIviC4qc6n
 mE7rC+wBEUi8LA6/S+xw0QCYY/2GWiO/gMTbQyIgsKhJXR1DU5/y2WjOU1jaoKzWXsj8QYdN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

Add s390 support for unwinding of user space using SFrame.  This
leverages the previous commits to address the following s390
particularities:

- The CFA is defined as the value of the stack pointer (SP) at call
  site in the previous frame + 160.  Therefore the SP unwinds as
  SP = CFA - 160.  Therefore use a SP value offset from CFA of -160.

- The return address (RA) is not saved on the stack at function entry.
  It is also not saved in the function prologue, when in leaf functions.
  Therefore the RA does not necessarily need to be unwound in the first
  unwinding step for the topmost frame.

- The frame pointer (FP) and/or return address (RA) may be saved in
  other registers when in leaf functions.  GCC effectively uses
  floating-point registers (FPR) for this purpose.  Therefore DWARF
  register numbers may be encoded in the SFrame FP/RA offsets.

- To make use of the signed 8-bit SFrame offset size and effectively
  reduce the .sframe section size the SFrame CFA offset values are
  encoded as (CFA - 160) / 8.  This is because the lowest CFA offset
  value on s390 is by definition +160 (= value at function entry),
  which does not fit into a signed 8-bit SFrame offset.  Therefore
  the CFA offset values are stored adjusted by -160.  Additionally
  they are scaled by the s390-specific DWARF data scaling factor of 8.
  The s390x ELF ABI [1] guarantees that the CFA offset values are
  always aligned on an 8-byte boundary.

[1]: s390x ELF ABI,
     https://github.com/IBM/s390x-abi/releases

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/s390/Kconfig                          |  2 +
 arch/s390/include/asm/unwind_user.h        | 83 ++++++++++++++++++++++
 arch/s390/include/asm/unwind_user_sframe.h | 37 ++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 arch/s390/include/asm/unwind_user.h
 create mode 100644 arch/s390/include/asm/unwind_user_sframe.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index f4ea52c1f0ba..8b29a8f0f9c3 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -239,6 +239,8 @@ config S390
 	select HAVE_SETUP_PER_CPU_AREA
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_UNWIND_USER_LOC_REG
+	select HAVE_UNWIND_USER_SFRAME
 	select HAVE_USER_RA_REG
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
diff --git a/arch/s390/include/asm/unwind_user.h b/arch/s390/include/asm/unwind_user.h
new file mode 100644
index 000000000000..daae1545e203
--- /dev/null
+++ b/arch/s390/include/asm/unwind_user.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_UNWIND_USER_H
+#define _ASM_S390_UNWIND_USER_H
+
+#include <linux/sched/task_stack.h>
+#include <linux/types.h>
+#include <asm/fpu-insn.h>
+
+static inline void __s390_get_dwarf_fpr(unsigned long *val, int regnum)
+{
+	switch (regnum) {
+	case 16:
+		fpu_std(0, (freg_t *)val);
+		break;
+	case 17:
+		fpu_std(2, (freg_t *)val);
+		break;
+	case 18:
+		fpu_std(4, (freg_t *)val);
+		break;
+	case 19:
+		fpu_std(6, (freg_t *)val);
+		break;
+	case 20:
+		fpu_std(1, (freg_t *)val);
+		break;
+	case 21:
+		fpu_std(3, (freg_t *)val);
+		break;
+	case 22:
+		fpu_std(5, (freg_t *)val);
+		break;
+	case 23:
+		fpu_std(7, (freg_t *)val);
+		break;
+	case 24:
+		fpu_std(8, (freg_t *)val);
+		break;
+	case 25:
+		fpu_std(10, (freg_t *)val);
+		break;
+	case 26:
+		fpu_std(12, (freg_t *)val);
+		break;
+	case 27:
+		fpu_std(14, (freg_t *)val);
+		break;
+	case 28:
+		fpu_std(9, (freg_t *)val);
+		break;
+	case 29:
+		fpu_std(11, (freg_t *)val);
+		break;
+	case 30:
+		fpu_std(13, (freg_t *)val);
+		break;
+	case 31:
+		fpu_std(15, (freg_t *)val);
+		break;
+	default:
+		*val = 0;
+	}
+}
+
+static inline int s390_unwind_user_get_reg(unsigned long *val, int regnum)
+{
+	if (0 <= regnum && regnum <= 15) {
+		struct pt_regs *regs = task_pt_regs(current);
+		*val = regs->gprs[regnum];
+	} else if (16 <= regnum && regnum <= 31) {
+		__s390_get_dwarf_fpr(val, regnum);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#define unwind_user_get_reg s390_unwind_user_get_reg
+
+#include <asm-generic/unwind_user.h>
+
+#endif /* _ASM_S390_UNWIND_USER_H */
diff --git a/arch/s390/include/asm/unwind_user_sframe.h b/arch/s390/include/asm/unwind_user_sframe.h
new file mode 100644
index 000000000000..2216e6921fd8
--- /dev/null
+++ b/arch/s390/include/asm/unwind_user_sframe.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_UNWIND_USER_SFRAME_H
+#define _ASM_S390_UNWIND_USER_SFRAME_H
+
+#include <linux/unwind_user.h>
+#include <linux/types.h>
+
+static inline s32 arch_sframe_cfa_offset_decode(s32 offset)
+{
+	return (offset << 3) + 160;
+}
+
+static inline void arch_sframe_set_frame_reginfo(
+	struct unwind_user_reginfo *reginfo,
+	s32 offset)
+{
+	if (offset & 1) {
+		reginfo->loc = UNWIND_USER_LOC_REG;
+		reginfo->regnum = offset >> 1;
+	} else if (offset) {
+		reginfo->loc = UNWIND_USER_LOC_STACK;
+		reginfo->frame_off = offset;
+	} else {
+		reginfo->loc = UNWIND_USER_LOC_NONE;
+	}
+}
+
+static inline s32 arch_sframe_sp_val_off(void)
+{
+	return -160;
+}
+
+#define sframe_cfa_offset_decode arch_sframe_cfa_offset_decode
+#define sframe_set_frame_reginfo arch_sframe_set_frame_reginfo
+#define sframe_sp_val_off arch_sframe_sp_val_off
+
+#endif /* _ASM_S390_UNWIND_USER_SFRAME_H */
-- 
2.48.1


