Return-Path: <bpf+bounces-76148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3E5CA888C
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30239302B137
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E893634B402;
	Fri,  5 Dec 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aqOUGcpK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1C34B426;
	Fri,  5 Dec 2025 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954931; cv=none; b=QSDD0UVBQZgxebBv6/JpJ9Yvxm4OHorAYwbkXr8FGE1d5v4XN2yJpBcbl25f6my2zGcjI0PDKxnJlIOyD+B+dvX5Fy31uTkn5ebk4dTOiNbRxUzYsBJ1JsCe+hsqeC0MNEl5gK3dZSwvI/F/KB27QfBrRIuJNPPHS3PuC3rst3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954931; c=relaxed/simple;
	bh=HBCyKAoA65FFXNpzph30OSPt55chhPw8iKxAUaVC4dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgyhXJVt3X/i0DFXq19RYTeBu0a4TT4N2hSqXFpKE66vtwY26x0031Cz1/PtSB4z8ejLRNZwIdgygT58aHOh2+ksp3ASqB/b1wttxq2kLlW+6Y+jdJv9KxdMdQ5Cw4wTOEnIPHS2CCtEEX8yaX/bMGDoYpQSrHMKQYSny+LP6NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aqOUGcpK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B58Tblq006115;
	Fri, 5 Dec 2025 17:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RGUGmb81k/upQMUHk
	zVbqvFouk7RSTWlms+ka3S7kHM=; b=aqOUGcpK9AtQ29UIhucxljR9whixRAVTP
	zCSwhgNvvses0Dg6hj8x/16SKWfUqbxnq4F9Sv1lW3nnVlHSM1xUdTWPbOGI9DZr
	U1G2PMDg9hAUSVO6YujZj5u2NGcZQPF0OuBj9h8T2/k9RxzB2FBmhEcUakHALKmR
	1l0jJrzvBywLNLT3afsOqZEZfUhfNzVgMtd7evy8/XA2iftXt10j6eZrXqYPAc7T
	ELurEXAdktAXPaO/MxSqotf5uv4gxg+9DyBk2A4+ng4edis6UZJ074Vc1NTKgFcx
	nstxfwq7WqvaxKr6YQj57mMUCpFVVzQNZxcl5ci6WkV4BtJgYoLXw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg5x3c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:58 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5HDNQA015566;
	Fri, 5 Dec 2025 17:14:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg5x3br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5G794b021504;
	Fri, 5 Dec 2025 17:14:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4at8c6qj4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5HEr1D15401368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 17:14:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23E5720043;
	Fri,  5 Dec 2025 17:14:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6F162005A;
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
Subject: [RFC PATCH v2 15/15] s390/unwind_user/backchain: Enable HAVE_UNWIND_USER_BACKCHAIN
Date: Fri,  5 Dec 2025 18:14:46 +0100
Message-ID: <20251205171446.2814872-16-jremus@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 1jo5pWau_LBs9yTaqt7mzvhYz3fWWAxy
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=69331312 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=3bOCESsrY8nbLZwxsYcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX1RgK7csGZO/+
 oTpnAdWMvXg9qvixPltY1x4UvcTrEDSvQkqsBxul1a/MLNNN9zQOSwRRWlDlqAXddpUIGDdP1mx
 2i/cO0cDKhIwHhYbJyORsvNfkYJZQZv/BnPOUtWkf1Y1bWQ7KR32KtfEbXPIuJVnFp/c82DxvYY
 ht31XYx30QpR1oFNsuYoahBMq8pANzjCqXHx9uj0j5YyoF5EOzmKYbVB2gp07Ok11w6y9aswEHH
 np5gE8jY6jjx3d87Fkrh8hmNeHmyV4L9YziCnwDJO/NSF1HReD7zjeD/QVz0hm4rbPcwfFCUFbS
 4APUBJgI3sBrkOOyNonVGuAS+twwP/QV36Em9FzKzLd0MwW4QI3p84FBiNxqzkSejboJDz4Ebhg
 YvusOUpvla+2wpHWntNrTouKi0ixPA==
X-Proofpoint-GUID: I1CWD7Dl6WYB5hea1O3PRbZ_-STnTtSh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290020

Enable unwinding of user space using back chain on s390.  Based on
arch_stack_walk_user_common() in arch/s390/kernel/stacktrace.c.

Note that an invalid RA obtained from the stack frame pointed to by the
back chain is not a valid indication that the IP is still early in the
function prologue and a fallback to the RA and SP register r14 and r15
contents should be made.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Adjusted to latest unwind user changes.
    - Use struct stack_frame_user and struct stack_frame_vdso_wrapper from
      asm/stacktrace.h.
    - In topmost frame do not fallback to RA (and SP) register values if
      RA is invalid.  This is not a valid indication for early prologue.
    - In topmost frame use RA and SP register values if they match those
      saved in the frame.  This indicates early prologue.

 arch/s390/Kconfig                        |   1 +
 arch/s390/kernel/Makefile                |   2 +
 arch/s390/kernel/unwind_user_backchain.c | 112 +++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 arch/s390/kernel/unwind_user_backchain.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 52d3f3b3e086..5aeb2abd390f 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -246,6 +246,7 @@ config S390
 	select HAVE_SETUP_PER_CPU_AREA
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_UNWIND_USER_BACKCHAIN
 	select HAVE_UNWIND_USER_SFRAME
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index eb06ff888314..eb662e95c5fd 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -83,6 +83,8 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_pai_crypto.o perf_pai_ext.o
 
 obj-$(CONFIG_TRACEPOINTS)	+= trace.o
 
+obj-$(CONFIG_HAVE_UNWIND_USER_BACKCHAIN)	+= unwind_user_backchain.o
+
 # vdso
 obj-y				+= vdso64/
 obj-$(CONFIG_COMPAT)		+= vdso32/
diff --git a/arch/s390/kernel/unwind_user_backchain.c b/arch/s390/kernel/unwind_user_backchain.c
new file mode 100644
index 000000000000..4e10ca43ea36
--- /dev/null
+++ b/arch/s390/kernel/unwind_user_backchain.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt)	"backchain: " fmt
+
+#include <asm/asm-offsets.h>
+#include <asm/stacktrace.h>
+#include <linux/security.h>
+#include <linux/unwind_user.h>
+#include <linux/unwind_user_backchain.h>
+
+/**
+ * ip_invalid - Perform some basic checks whether an instruction pointer (IP)
+ * taken from an unreliable source is invalid
+ * @ip: The instruction pointer to be validated
+ *
+ * returns whether the instruction pointer is invalid
+ */
+static inline bool ip_invalid(unsigned long ip)
+{
+	/* Architecture requires IP to be 2-byte aligned. */
+	if (ip & 1)
+		return true;
+	if (ip < mmap_min_addr)
+		return true;
+	if (ip >= current->mm->context.asce_limit)
+		return true;
+	return false;
+}
+
+/**
+ * ip_within_vdso - Check whether an instruction pointer (IP) is within vDSO
+ * @ip: The instruction pointer
+ *
+ * returns whether the instruction pointer is within vDSO
+ */
+static inline bool ip_within_vdso(unsigned long ip)
+{
+	return in_range(ip, current->mm->context.vdso_base, vdso_text_size());
+}
+
+/**
+ * arch_unwind_user_next_backchain - Unwind one frame using s390 back chain
+ * @state: The unwind user state
+ *
+ * returns zero when successful, otherwise -EINVAL.
+ */
+int arch_unwind_user_next_backchain(struct unwind_user_state *state)
+{
+	struct stack_frame_user __user *sf;
+	unsigned long sp, ra;
+
+	sf = (void __user *)state->sp;
+
+	/*
+	 * In topmost frame check whether IP in early prologue, RA and SP
+	 * registers saved, and no new stack frame allocated.
+	 */
+	if (state->topmost) {
+		unsigned long ra_reg;
+
+		if (__get_user(ra, (unsigned long __user *)&sf->gprs[8]))
+			return -EINVAL;
+		if (__get_user(sp, (unsigned long __user *)&sf->gprs[9]))
+			return -EINVAL;
+		if (unwind_user_get_ra_reg(&ra_reg))
+			return -EINVAL;
+		if (ra == ra_reg && sp == state->sp)
+			goto done;
+	}
+
+	if (__get_user(sp, (unsigned long __user *)&sf->back_chain))
+		return -EINVAL;
+	if (!sp && ip_within_vdso(state->ip)) {
+		/*
+		 * Assume non-standard vDSO user wrapper stack frame.
+		 * See vDSO user wrapper code for details.
+		 */
+		struct stack_frame_vdso_wrapper *sf_vdso = (void __user *)sf;
+
+		if (__get_user(ra, (unsigned long __user *)&sf_vdso->return_address))
+			return -EINVAL;
+		sf = (void __user *)((unsigned long)sf + STACK_FRAME_VDSO_OVERHEAD);
+		if (__get_user(sp, (unsigned long __user *)&sf->back_chain))
+			return -EINVAL;
+	} else if (!sp) {
+		/* Assume outermost frame reached. */
+		state->done = true;
+		return 0;
+	} else {
+		/*
+		 * Assume IP past prologue and new stack frame allocated.
+		 * Follow back chain, which then equals the SP at entry.
+		 * Skips caller if wrong in topmost frame.
+		 */
+		sf = (void __user *)sp;
+		if (__get_user(ra, (unsigned long __user *)&sf->gprs[8]))
+			return -EINVAL;
+		/* Skip validation: ABI requires SP to be saved as well. */
+	}
+
+done:
+	/* Validate SP and RA (ABI requires SP to be 8-byte aligned). */
+	if (sp & 7 || ip_invalid(ra))
+		return -EINVAL;
+
+	state->ip = ra;
+	state->sp = sp;
+	state->fp = 0;		/* Cannot unwind FP. */
+	state->topmost = false;
+
+	return 0;
+}
-- 
2.51.0


