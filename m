Return-Path: <bpf+bounces-76151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29537CA889E
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1591302CBD6
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FE534D4CB;
	Fri,  5 Dec 2025 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UsojbQ0l"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9470145B16;
	Fri,  5 Dec 2025 17:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954932; cv=none; b=WgXbmITJCqZ8As/k8DbLF3+8sdEWoItt1E9/8sJZihd/e/2FxWYfQ7d1m67n5EbMpFE5R9wq/V0O+lU5uDozT8E/N72gYG/Ik3oVrLFmqhNy1plrC6WDHHBRtJ1ejGMdKCp5x7pzOlzrWPQqLj7WrRib2j6NGX7vHm4vKnRe2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954932; c=relaxed/simple;
	bh=gOP+6UJLT+iBPjibPLic1b9SePLoITAw3L4gviO+6pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOtsF08L8Fwk+gpoTgMO9bKa6+/k9OPVH8xoL1arpjC2C8BWBcLCTkiaWmO8deSPKyfmrEyKyL/ztnymS0yGYafSWoBwOIy/baUlF2MUVFxVkc9r53nxKT5zUpAFscl9SyVAqOk/bV63yoSYhpLVnkZ8PSc4rHrebEh16H2VG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UsojbQ0l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5Drf0R010288;
	Fri, 5 Dec 2025 17:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YWOOUB0UikvbXJWWs
	3TrXD+M01rnArWa5OIhg9O+1+o=; b=UsojbQ0lILkjlgKmwO3dMOJ3voUvVJ8Fj
	XlZJUNuuhfXu7HJ+jjvl1zIdWyH6Kf+Zft6mH8Q1D9wG7J6gis9FXXlG94vCMEzO
	0jfdPdUmp7AOVJ8QbQlezJTt4j2iRekuBn5MA9/lIrRinjkZjWX9oIm6+3Nk9Kbq
	XBUy2DWo1zjZwVDELfkBgBG3M5EE/GJz17evNMa6nQT1DVPzIeNoIyzmtq7ohTcs
	+h8G4WhoMINVUoOhhgtRUAZVeggOsh9pbiEVn+G4VnYXIwdYZDZdjuoWJr44K8LC
	Qb/qwwHnKH0c1Z0PIiO71E7/lJcne40OEcWyiXujiNdfN4IJAXzPw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8qeb4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5HBdjr010497;
	Fri, 5 Dec 2025 17:14:57 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8qeb4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5FhDmK003847;
	Fri, 5 Dec 2025 17:14:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardck65pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5HEqTB47644990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 17:14:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8852F20043;
	Fri,  5 Dec 2025 17:14:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E1E32004F;
	Fri,  5 Dec 2025 17:14:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Dec 2025 17:14:52 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [RFC PATCH v2 13/15] s390/unwind_user/sframe: Enable HAVE_UNWIND_USER_SFRAME
Date: Fri,  5 Dec 2025 18:14:44 +0100
Message-ID: <20251205171446.2814872-14-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205171446.2814872-1-jremus@linux.ibm.com>
References: <20251205171446.2814872-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfXzl6Zx9Kx7iip
 VFCp2CBJhZHAyd22AID9uhRFDShsOcUo1MDIL+e+dmZugP7vYQJGb32SFdQBl09ZSJtsqk+jZbc
 wB670/gwgonolxWvGZU6s9gKA2DDTd2lUNvrOFEK3xf/NfYiF+/J8o5wEkOv2w/VFMNQTSFaJcw
 /zcr8W86Gotr+k4rK9dHfzwJZFIcjNNy9y+Yn+vxItOmw5NhNsnDS7hKWWeBrXdOUOWt65Eb8H1
 0s/Vm9K4sgu+GsuA9VXu4mjF5Ep4BCm/QzgZgCpcODkmSGZY/C1TC0QquDMgsdIDVvJH+y3M5rN
 in6vCrESvAwlnXf1p80VbWS8ZtBczuvygZjCr4sYb7VAm8YborWo7RGk+TiFc87/K4go4oOsAd6
 XN9gr42UBO6l+HVhStp6VWbqPpnJow==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=69331312 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=SgTjFYeX4wDDoTrxqN8A:9
X-Proofpoint-ORIG-GUID: 89x2jJ5rrpBhQ2TMQPiWwYJ-3vCAEGNF
X-Proofpoint-GUID: Cmq_Odn8seEpYJfkDP58i_G5vhbKrONt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

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

Add s390-specific SFrame format definitions.  Note that SFRAME_ABI_*
(and thus SFRAME_ABI_S390_ENDIAN_BIG) is currently unused.

Include <asm/unwind_user_sframe.h> after "sframe.h" to make those
s390-specific definitions available to architecture-specific unwind
user sframe code, particularly the s390-specific one.

[1]: s390x ELF ABI, https://github.com/IBM/s390x-abi/releases

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Provide unwind_user_word_size() to satisfy new unwind user need.  Note
      that support for COMPAT has not been implemented as s390 support for
      COMPAT is expected to be removed with v6.19:
      https://lore.kernel.org/all/20251201102713.22472A5b-hca@linux.ibm.com/
    - Adjust to changes in preceding patches in this series that enable
      support in unwind user (sframe) for s390 particularities.
    
    Alternatively the s390-specific definitions could also be added to the
    s390-specific unwind user sframe header.  The current implementation
    follows Binutils approach to have all SFrame format definitions in one
    central header file.

 arch/s390/Kconfig                          |   1 +
 arch/s390/include/asm/unwind_user.h        | 100 +++++++++++++++++++++
 arch/s390/include/asm/unwind_user_sframe.h |  33 +++++++
 kernel/unwind/sframe.c                     |   2 +-
 kernel/unwind/sframe.h                     |  14 +++
 5 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/include/asm/unwind_user.h
 create mode 100644 arch/s390/include/asm/unwind_user_sframe.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index df22b10d9141..52d3f3b3e086 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -246,6 +246,7 @@ config S390
 	select HAVE_SETUP_PER_CPU_AREA
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_UNWIND_USER_SFRAME
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
 	select HOTPLUG_SMT
diff --git a/arch/s390/include/asm/unwind_user.h b/arch/s390/include/asm/unwind_user.h
new file mode 100644
index 000000000000..38dff49d5f86
--- /dev/null
+++ b/arch/s390/include/asm/unwind_user.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_UNWIND_USER_H
+#define _ASM_S390_UNWIND_USER_H
+
+#include <linux/sched/task_stack.h>
+#include <linux/types.h>
+#include <asm/fpu-insn.h>
+
+#ifdef CONFIG_UNWIND_USER
+
+static inline int unwind_user_word_size(struct pt_regs *regs)
+{
+	return sizeof(long);
+}
+
+static inline int arch_unwind_user_get_ra_reg(unsigned long *val)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	*val = regs->gprs[14];
+	return 0;
+}
+#define unwind_user_get_ra_reg arch_unwind_user_get_ra_reg
+
+static inline int __s390_get_dwarf_fpr(unsigned long *val, int regnum)
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
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline int arch_unwind_user_get_reg(unsigned long *val, int regnum)
+{
+	if (0 <= regnum && regnum <= 15) {
+		struct pt_regs *regs = task_pt_regs(current);
+		*val = regs->gprs[regnum];
+		return 0;
+	} else if (16 <= regnum && regnum <= 31) {
+		return __s390_get_dwarf_fpr(val, regnum);
+	}
+
+	return -EINVAL;
+}
+#define unwind_user_get_reg arch_unwind_user_get_reg
+
+#endif /* CONFIG_UNWIND_USER */
+
+#include <asm-generic/unwind_user.h>
+
+#endif /* _ASM_S390_UNWIND_USER_H */
diff --git a/arch/s390/include/asm/unwind_user_sframe.h b/arch/s390/include/asm/unwind_user_sframe.h
new file mode 100644
index 000000000000..e3b80c48f326
--- /dev/null
+++ b/arch/s390/include/asm/unwind_user_sframe.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_UNWIND_USER_SFRAME_H
+#define _ASM_S390_UNWIND_USER_SFRAME_H
+
+#include <linux/unwind_user.h>
+#include <linux/types.h>
+
+#define SFRAME_SP_OFFSET SFRAME_S390X_SP_VAL_OFFSET
+
+static inline s32 arch_sframe_cfa_offset_decode(s32 offset)
+{
+	return SFRAME_V2_S390X_CFA_OFFSET_DECODE(offset);
+}
+#define sframe_cfa_offset_decode arch_sframe_cfa_offset_decode
+
+static inline void
+arch_sframe_init_reginfo(struct unwind_user_reginfo *reginfo, s32 offset)
+{
+	if (SFRAME_V2_S390X_OFFSET_IS_REGNUM(offset)) {
+		reginfo->loc = UNWIND_USER_LOC_REG;
+		reginfo->regnum = SFRAME_V2_S390X_OFFSET_DECODE_REGNUM(offset);
+	} else if (offset) {
+		reginfo->loc = UNWIND_USER_LOC_STACK;
+		reginfo->offset = offset;
+	} else {
+		reginfo->loc = UNWIND_USER_LOC_NONE;
+	}
+}
+#define sframe_init_reginfo arch_sframe_init_reginfo
+
+#include <asm-generic/unwind_user_sframe.h>
+
+#endif /* _ASM_S390_UNWIND_USER_SFRAME_H */
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 92f770fc21f6..bd446d55b552 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -12,11 +12,11 @@
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
 #include <linux/sframe.h>
-#include <asm/unwind_user_sframe.h>
 #include <linux/unwind_user_types.h>
 
 #include "sframe.h"
 #include "sframe_debug.h"
+#include <asm/unwind_user_sframe.h>
 
 struct sframe_fde_internal {
 	unsigned long	func_start_addr;
diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
index 69ce0d5b9694..c09f25fbaa2f 100644
--- a/kernel/unwind/sframe.h
+++ b/kernel/unwind/sframe.h
@@ -18,6 +18,7 @@
 #define SFRAME_ABI_AARCH64_ENDIAN_BIG		1
 #define SFRAME_ABI_AARCH64_ENDIAN_LITTLE	2
 #define SFRAME_ABI_AMD64_ENDIAN_LITTLE		3
+#define SFRAME_ABI_S390X_ENDIAN_BIG		4	/* s390 64-bit (s390x) */
 
 #define SFRAME_FDE_TYPE_PCINC			0
 #define SFRAME_FDE_TYPE_PCMASK			1
@@ -69,4 +70,17 @@ struct sframe_fde {
 #define SFRAME_FRE_OFFSET_SIZE(data)		((data >> 5) & 0x3)
 #define SFRAME_FRE_MANGLED_RA_P(data)		((data >> 7) & 0x1)
 
+/* s390 64-bit (s390x) */
+
+#define SFRAME_S390X_SP_VAL_OFFSET			(-160)
+
+#define SFRAME_S390X_CFA_OFFSET_ADJUSTMENT		SFRAME_S390X_SP_VAL_OFFSET
+#define SFRAME_S390X_CFA_OFFSET_ALIGNMENT_FACTOR	8
+#define SFRAME_V2_S390X_CFA_OFFSET_DECODE(offset) \
+	(((offset) * SFRAME_S390X_CFA_OFFSET_ALIGNMENT_FACTOR) \
+	- SFRAME_S390X_CFA_OFFSET_ADJUSTMENT)
+
+#define SFRAME_V2_S390X_OFFSET_IS_REGNUM(offset)	((offset) & 1)
+#define SFRAME_V2_S390X_OFFSET_DECODE_REGNUM(offset)	((offset) >> 1)
+
 #endif /* _SFRAME_H */
-- 
2.51.0


