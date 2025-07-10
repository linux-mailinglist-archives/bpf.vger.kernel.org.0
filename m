Return-Path: <bpf+bounces-62939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29748B008E2
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B2416D039
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D32B2F0C54;
	Thu, 10 Jul 2025 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KMrnC4AS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746812EA75D;
	Thu, 10 Jul 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165355; cv=none; b=s88O9k0zXTnvWuVHcSriYfTVtaGmObRhzqf+WAxx4gdMVCqqwaoJEreG7+JKPIheGAxyAWl9xe5tW720zDJi2LNzaSqGh354fVR6FyenBPJ7W+ORMiVUfXkqeuXGOOZnFtOhkIinALHzpUjcXcKLANtGMK9qQ+78G2OkO9Qs+lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165355; c=relaxed/simple;
	bh=GGGqBykxmPKNbFLbbNLu5/UXUc4cBSMzmQzN8nKLNqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+16r8fbsrOs/wQ4M5R8uNwiFf4IxD7YujyYVgKJ6GVJ7IY00jh/CqEGxL2dMJZOEYnmS6rHQBKpfZWShqyasNq236+z+w7d6U5aWX1VvZRgFdqUrYYgSWpMkoq3uLTO2qfk4OBr0S5MzrRE1nhpW93RNUwJ3FN1liWQVsf2AcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KMrnC4AS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEmt9l010501;
	Thu, 10 Jul 2025 16:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xDNNFrWOHVtkRntgQ
	YJ4X4jcEUv8xSxxWAxiZhUQMl4=; b=KMrnC4ASoRufg17i/ox/kfnH9zaMWaLCM
	U9XIotMdUzggSYkPRI9Y12tyFTwfHdn/sZQMbfcC12DLQYeccoz3AIJpkVbd6yC9
	QNNMCiFpJ4M6FqoUWDMT70pZ+WHnCR6lnTwyzH6nXY1HZJ1W3zaf8a5AjnauVUGW
	gmoj7nboXjUznpP4EbhmcUDatxQYyTeVrrWCZGiDm9OVgQXtUsJO8JQsem2A7iUb
	MoxqwoJxB0DCj0QObtSl9dm+MEWV8Zr2RCpup0BdDj1tl71YnZKtXCEBIVZbIf7Q
	/9sdKmcLjuEyJRCY6XT3ll35bHgz9b8/fXBl5At4kxj3l8vFov6uQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb26atk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AG1dOt024678;
	Thu, 10 Jul 2025 16:35:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32p8mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZROT35062192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D231E2004B;
	Thu, 10 Jul 2025 16:35:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9224E2004E;
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
Subject: [RFC PATCH v1 13/16] s390/unwind_user/backchain: Enable HAVE_UNWIND_USER_BACKCHAIN
Date: Thu, 10 Jul 2025 18:35:19 +0200
Message-ID: <20250710163522.3195293-14-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX9BjtxvQxsv7N MwfarMQIZA/zSK97sJXAOWC7QwfsJns/OqybuEashRiqv7gcf2YyTPlGLHuR6x9E2U1I7nE4spN eeAqfTyz72ZY0iEIlMUY0PlrTSZGINEyhzrVwGvd5r+ARfyvYISEt5V0GWTQeOOOX2CZLmmmW3N
 yV0IWNpBSxxAwwRSMaDci9zIRICJJ4WdyHWyGeqy+vNIOz8n37b8/NdyGDvT0vQMGE7iqPDT1cA KyjbW4qWyZ3+eESf13pI70wJt7CaV0sRP1d0zr5sREjAYBJ0unui+7a9GdW/NZRjfjKImzAvpS6 jaImvXBIEOq5jdD8B9TXIqtbqj5eHSotmlGLcggMjyq1QYAzr4WVUI6kcnf+tkQ6z9JDJwjviG6
 oTa9Nd4yvx8uIBnkTWHuAK8kPllNsRDbkChN2aetTGirWA6UcVqFroEijNBRoQWoTcdTIUaA
X-Authority-Analysis: v=2.4 cv=Y774sgeN c=1 sm=1 tr=0 ts=686febd4 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=Paj0-Z-736eVyoMAdw0A:9
X-Proofpoint-ORIG-GUID: XZblb3XbvUWysOM4LG_V39skfnzDmK8u
X-Proofpoint-GUID: XZblb3XbvUWysOM4LG_V39skfnzDmK8u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=563 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

Enable unwinding of user space using back chain on s390.  Based on
arch_stack_walk_user_common() in arch/s390/kernel/stacktrace.c.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/s390/Kconfig                             |   1 +
 arch/s390/include/asm/unwind_user_backchain.h | 127 ++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 arch/s390/include/asm/unwind_user_backchain.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8b29a8f0f9c3..49f231123040 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -239,6 +239,7 @@ config S390
 	select HAVE_SETUP_PER_CPU_AREA
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_UNWIND_USER_BACKCHAIN
 	select HAVE_UNWIND_USER_LOC_REG
 	select HAVE_UNWIND_USER_SFRAME
 	select HAVE_USER_RA_REG
diff --git a/arch/s390/include/asm/unwind_user_backchain.h b/arch/s390/include/asm/unwind_user_backchain.h
new file mode 100644
index 000000000000..ceb56b9d8411
--- /dev/null
+++ b/arch/s390/include/asm/unwind_user_backchain.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_UNWIND_USER_BACKCHAIN_H
+#define _ASM_S390_UNWIND_USER_BACKCHAIN_H
+
+#include <linux/security.h>
+#ifndef ASM_OFFSETS_C
+#include <asm/asm-offsets.h>
+#endif
+
+struct stack_frame_user {
+	unsigned long backchain;
+	unsigned long unused;
+	/* Argument register save area. */
+	unsigned long r2;
+	unsigned long r3;
+	unsigned long r4;
+	unsigned long r5;
+	unsigned long r6;
+	/* Other register save area. */
+	unsigned long r7;
+	unsigned long r8;
+	unsigned long r9;
+	unsigned long r10;
+	unsigned long r11;
+	unsigned long r12;
+	unsigned long r13;
+	unsigned long r14;
+	unsigned long r15;
+	/* FP argument register save area. */
+	unsigned long f0;
+	unsigned long f2;
+	unsigned long f4;
+	unsigned long f6;
+};
+
+struct stack_frame_vdso_wrapper {
+	struct stack_frame_user sf;
+	unsigned long return_address;
+};
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
+ * arch_unwind_user_backchain_next - Unwind one frame using backchain
+ * @state: The unwind user state
+ *
+ * returns zero when successful, otherwise -EINVAL.
+ */
+static inline int arch_unwind_user_backchain_next(struct unwind_user_state *state)
+{
+	struct stack_frame_user __user *sf;
+	unsigned long sp, ra;
+
+	sf = (void __user *)state->sp;
+	if (__get_user(sp, (unsigned long __user *)&sf->backchain))
+		return -EINVAL;
+
+	/*
+	 * vDSO entry code on s390 has a non-standard stack frame layout.
+	 * See vDSO user wrapper code for details.
+	 */
+	if (!sp && ip_within_vdso(state->ip)) {
+		struct stack_frame_vdso_wrapper *sf_vdso = (void __user *)sf;
+
+		if (__get_user(ra, (unsigned long __user *)&sf_vdso->return_address))
+			return -EINVAL;
+		sf = (void __user *)((unsigned long)sf + STACK_FRAME_VDSO_OVERHEAD);
+		if (__get_user(sp, (unsigned long __user *)&sf->backchain))
+			return -EINVAL;
+	} else {
+		sf = (void __user *)sp;
+		if (__get_user(ra, (unsigned long __user *)&sf->r14))
+			return -EINVAL;
+	}
+
+	/* ABI requires SP to be 8-byte aligned. */
+	if (sp & 0x7)
+		return -EINVAL;
+
+	/*
+	 * If the IP is invalid and this is the topmost frame,
+	 * assume the RA register has not been saved yet.
+	 */
+	if (ip_invalid(ra)) {
+		if (!state->topmost || !IS_ENABLED(CONFIG_HAVE_USER_RA_REG))
+			return -EINVAL;
+
+		ra = user_return_address(task_pt_regs(current));
+		if (ip_invalid(ra))
+			return -EINVAL;
+	}
+
+	state->sp = sp;
+	state->ip = ra;
+	state->fp = 0;
+
+	return 0;
+}
+
+#endif /* _ASM_S390_UNWIND_USER_BACKCHAIN_H */
-- 
2.48.1


