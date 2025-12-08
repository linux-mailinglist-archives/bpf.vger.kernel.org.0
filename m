Return-Path: <bpf+bounces-76309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CCBCADE97
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FF0930A6638
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA41431076A;
	Mon,  8 Dec 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="etZpUWkS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558B323EA8D;
	Mon,  8 Dec 2025 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214213; cv=none; b=sIYznMOkZX44q1ywacgdOVCq5FeoiIaphuVUmNV1Pw5fiHa0gVxVXfC3ivDW1jgSoFF01qH/scgVLF7w0bTxw3cF1rFFgXMpLBZGrxyFal2DsJC14ZfEYQHqhrx4n+8EgcfkUWg1OdSLR1qUmj2V5g8Tov/H1/eS//hTfQz9AR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214213; c=relaxed/simple;
	bh=yQRS6tac/4OJzlnYB0WEzwI8HPZOtNgS2s/K5KfUZfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dj644YMHumKgob165eXnBhokFbsDa0xTsvhQCBj5TrVdUXE7SaxTJRr5anzHR+eZUMNYDcqukUucoop+wPTs0TAEtJaiVnS8PPUiqaTXBUc66pj8Hy01z2MNIAREdKm31Mf0SrDsxeW41vzyl81HuaM0Ot+BTwiuNvJdhjbQqns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=etZpUWkS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8D0hnD019715;
	Mon, 8 Dec 2025 17:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=owDdg04jmLKMozurU
	MIhpz6GGzY1HNqU9ZPAepNfN4k=; b=etZpUWkSjhEioC61cdRL9URjxew771l4z
	f45WJoWHe8zZdfzUiEKNzDAkOop6vfzGc/TWLLarV88gOvGPewrfdPs0Yoq5Tv81
	mvm4bqSxGTOItVIBBFKeYp3l7vN52l8UUxx7mt4YrQIxb1tWp5pqS7OkVpdFGV5B
	Vy90QcorTw0ZIwnXOY4B68WcmpawFDbojqiTJU94OW2oQRp/VcLs01mge0Hs7F0z
	+7g6gLO+3ye3/BNeD+iHe8pNcNHgifpBCDRMOxZz8/fT0bpo0OpUTIh5+EL37bpq
	9SrcqOtUpd2iLcdpH3vA84uVIeG717pAutNwzjhI5Cov0lQllax7g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jrwur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:14 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8HGDbv013940;
	Mon, 8 Dec 2025 17:16:13 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jrwum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8HAOhh030340;
	Mon, 8 Dec 2025 17:16:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4avxtrxxsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG8lQ36700588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9049320040;
	Mon,  8 Dec 2025 17:16:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39AC520043;
	Mon,  8 Dec 2025 17:16:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:08 +0000 (GMT)
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
Subject: [RFC PATCH v3 17/17] s390/unwind_user/fp: Enable back chain unwinding of user space
Date: Mon,  8 Dec 2025 18:15:59 +0100
Message-ID: <20251208171559.2029709-18-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208171559.2029709-1-jremus@linux.ibm.com>
References: <20251208171559.2029709-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=693707de cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=qHp_k-hexZ09bc3ecLAA:9
X-Proofpoint-ORIG-GUID: Vb7HGwVhaqczURcSqNCuk0ttDsehfIsD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfXwdfAAj+2hgMm
 +G9KUPdZdTLvxPSG1YNJUvtYtsg83q6rhIzMbQTFQZCOKp6mRLciV90EsWePdT76rCu+d6ji/ft
 GuAzwK79NcKcrQSQoMDclvBXxJc+/iVJKWkQiSfKCc1MFmnsCXoaVXOPS6T/Vq9wZ9mbuiju1Ai
 +Srg7qhrDreZ+qqT2VqdF+7O57rXvmPR+L/4pXUE7BvDOX0O9IAkyXA1Xn60rJGnMXMhuqhU0dE
 48HSskY24yeHOWOeb9olvFVBth0BZ+owbJaqUJW9TCho1KkOsWgF9PG+jeT4TlU1a5PVZviwswr
 uAolOMtCRoW31e/qJSkY/m3mKhw1p0KS25veqs6hqq/JMTXNxMVOd6JeKxcXPleWc17anfu0ZtL
 1EFqb49Em74zO1Am1i8tUGiG7+dhLQ==
X-Proofpoint-GUID: 62TvOVtr64kHzNGxsO7Sdf4FJ_kPH001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016

Unwinding of user space using frame pointer (FP) is virtually impossible
on s390 for the following reasons:  The s390 64-bit (s390x) ELF ABI [1]
does only designate a "preferred" FP register and does not mandate fixed
FP and return address (RA) stack save slots.  Therefore neither the FP
register nor the FP/RA stack save slot offsets from CFA are known.
Compilers, such as GCC and Clang, do not necessarily setup a FP register
early in the function prologue, even not with compiler option
-fno-omit-frame-pointer.  Therefore the CFA offset from FP register is
not known.

This could be resolved by having compiler option -no-omit-frame-pointer
enforce all of the following:  Use the preferred FP register 11 as frame
pointer, use fixed FP/RA stack slot offsets from CFA (e.g. -72 for FP
and -48 for RA), and setup the FP register immediately after saving the
call saved registers.

Fortunately s390 provides an alternative to frame pointer:  back chain,
which can be enabled using s390-specific compiler option -mbackchain.
The back chain is very similar to a frame pointer on the stack.

Leverage the unwind user fp infrastructure to enable unwinding of user
space using back chain.  Enable HAVE_UNWIND_USER_FP and provide a s390-
specific implementation of unwind_user_fp_get_frame(), which uses the
back chain.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v3:
    - New patch.  Implement unwind user fp using back chain on s390. Reuses
      logic from RFC v2 patch "unwind_user/backchain: Introduce back chain
      user space unwinding". (Josh)

 arch/s390/Kconfig                   |  1 +
 arch/s390/include/asm/unwind_user.h | 83 +++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 52d3f3b3e086..eb6a0fe895bc 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -246,6 +246,7 @@ config S390
 	select HAVE_SETUP_PER_CPU_AREA
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_UNWIND_USER_FP
 	select HAVE_UNWIND_USER_SFRAME
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
diff --git a/arch/s390/include/asm/unwind_user.h b/arch/s390/include/asm/unwind_user.h
index 3a95be1eb886..99cbb83dd248 100644
--- a/arch/s390/include/asm/unwind_user.h
+++ b/arch/s390/include/asm/unwind_user.h
@@ -3,8 +3,12 @@
 #define _ASM_S390_UNWIND_USER_H
 
 #include <linux/sched/task_stack.h>
+#include <linux/security.h>
 #include <linux/types.h>
+#include <asm/asm-offsets.h>
 #include <asm/fpu-insn.h>
+#include <asm/stacktrace.h>
+#include <linux/unwind_user_types.h>
 
 #ifdef CONFIG_UNWIND_USER
 
@@ -95,6 +99,85 @@ static inline int arch_unwind_user_get_reg(unsigned long *val, int regnum)
 
 #endif /* CONFIG_UNWIND_USER */
 
+#ifdef CONFIG_HAVE_UNWIND_USER_FP
+
+static inline bool ip_within_vdso(unsigned long ip)
+{
+	return in_range(ip, current->mm->context.vdso_base, vdso_text_size());
+}
+
+static inline int unwind_user_fp_get_frame(struct unwind_user_state *state,
+					   struct unwind_user_frame *frame)
+{
+	struct stack_frame_user __user *sf;
+	unsigned long __user *ra_addr;
+	unsigned long sp;
+
+	sf = (void __user *)state->sp;
+
+	/*
+	 * In topmost frame check whether IP in early prologue, RA and SP
+	 * registers saved, and no new stack frame allocated.
+	 */
+	if (state->topmost) {
+		unsigned long ra, ra_reg;
+
+		ra_addr = (unsigned long __user *)&sf->gprs[8];
+		if (__get_user(ra, ra_addr))
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
+		ra_addr = (unsigned long __user *)&sf_vdso->return_address;
+		sf = (void __user *)((unsigned long)sf + STACK_FRAME_VDSO_OVERHEAD);
+		if (__get_user(sp, (unsigned long __user *)&sf->back_chain))
+			return -EINVAL;
+	} else if (!sp) {
+		/*
+		 * Assume outermost frame reached. unwind_user_next_common()
+		 * disregards all other fields in outermost frame.
+		 */
+		frame->outermost = false;
+		return 0;
+	} else {
+		/*
+		 * Assume IP past prologue and new stack frame allocated.
+		 * Follow back chain, which then equals the SP at entry.
+		 * Skips caller if wrong in topmost frame.
+		 */
+		sf = (void __user *)sp;
+		ra_addr = (unsigned long __user *)&sf->gprs[8];
+	}
+
+done:
+	frame->cfa_off = sp - state->sp + 160;
+	frame->sp_off = -160;
+	frame->fp.loc = UNWIND_USER_LOC_UNKNOWN;	/* Cannot unwind FP. */
+	frame->use_fp = false;
+	frame->ra.loc = UNWIND_USER_LOC_STACK;
+	frame->ra.offset = (unsigned long)ra_addr - (state->sp + frame->cfa_off);
+	frame->outermost = false;
+
+	return 0;
+}
+#define unwind_user_fp_get_frame unwind_user_fp_get_frame
+
+#endif /* CONFIG_HAVE_UNWIND_USER_FP */
+
 #include <asm-generic/unwind_user.h>
 
 #endif /* _ASM_S390_UNWIND_USER_H */
-- 
2.51.0


