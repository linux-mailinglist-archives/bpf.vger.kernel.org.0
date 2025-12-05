Return-Path: <bpf+bounces-76157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC6CCA89ED
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8C9932811F0
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2234234FF4D;
	Fri,  5 Dec 2025 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RVl5usaW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4ED1FF7C5;
	Fri,  5 Dec 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954937; cv=none; b=QWDI13nQW/N27i2XjMgw/Y4d8D7YjdI8j6eQSGjCqBAjl4Ft4mg30lfiD4cn0qxVsdV26dl/Ax2kZx6mUfMZ3NAH0Jv5ddBMiq0nRFajbMQKUmm3MzImBxZVz+3x21ZTNzFi2mr3/doOn0N7+44tNRl7G7O6KJF2ET8RCnEUYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954937; c=relaxed/simple;
	bh=MCWyQETxtvllGFIFKl6xSPoQZhSeiVvaKl1pfQKbFGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THMCc4+kVZNTyY4LTF+s/SAjU6ymglGD0ZxeKLqR3NgKjjYu4gA3CxJr+M6PT91pyxKa6UXoDPN9rYCViEQMxLb0KO4zcbCiyn4Q9nLMO9BX50NDKGeLPs4RkhzmAhcPEIay5aaY79BPyNPRa3+O2X+rYHBRvnuJt5MiBVh+2yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RVl5usaW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5Dmi46010190;
	Fri, 5 Dec 2025 17:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lWzs9539f/hn3ssMI
	KjEpfKR/q0Qojbj3UelDuXSlec=; b=RVl5usaWzUofIND9oCTdlR/ADLIXpIo5C
	fPuDDAb75lCv5zkTRcMb/EbUcQqQRWJLLSuqrzMxdsF9eeW8C0zr767Cc7g/IvzR
	DGyYc145gxId4HhHKs2dZ0ERQig+V7fYTXmMY/Ji8WWN3QQ8u5IG91DOGEAP6Bpw
	5LGF2vB4hIYhUeBzEFYLCKjYskoZ9QEkxowz8SXDqihUSREDVbZkBxSveeFEIaG6
	R8IGp+FofeR4fY9WC0WT7siAe+9/B4BNm4t6pIgOETJipSGQ//QEaPriXkrcLaKb
	0q+cK2GrcgJryKTlUakDloFy80jlw//8DSOaUXi6OersL96zPReyA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8qeb4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:56 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5HEtxK017482;
	Fri, 5 Dec 2025 17:14:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8qeb4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5FxERo029361;
	Fri, 5 Dec 2025 17:14:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv1x357-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5HEpGI11993368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 17:14:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06A4020043;
	Fri,  5 Dec 2025 17:14:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B60A42004B;
	Fri,  5 Dec 2025 17:14:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Dec 2025 17:14:50 +0000 (GMT)
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
Subject: [RFC PATCH v2 08/15] unwind_user: Enable archs that define CFA = SP_callsite + offset
Date: Fri,  5 Dec 2025 18:14:39 +0100
Message-ID: <20251205171446.2814872-9-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfXygSk4+VdmqiU
 orH4e5PHWs6FyEG2L6wMRo+SanEayBoMKU6veus/Ogkjj6A32D9bpdFojMyRwyzknmneSDftwyg
 kGE7rd7gG5pYaQ81x55b832c5vNQe0/6Cnc5UI83wHzy+2yf63NcwUi4q8ov4DmMJgnUpTIg02C
 Hj7dyoF5wxVLpY79QwRI0V7IWQAadAJOlUSih/Yd2jAswbsGQgG/k02Yl6X7yAKYkLGL3nenRqq
 9qm/6Xbqau4M4MxIJaqnb9E5vowERWyDjlJFFjCiif2C7R66lKr0TNQccy0bKpa3HWApCvBhfR/
 VYbwm6BPeMX+IRzkUiaWB4dO6SCbyFk48hedpY4vpCqpYRK2nbcu+4MmnjM95GB2oNvrT1dGLex
 HCGxnNjpQJ9/NwhXhqM/Xu+XUXgr6A==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=69331310 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=D-3WH5monn3MMgO2UeQA:9
X-Proofpoint-ORIG-GUID: eQsmupYaf2RzB4oO1mvCIAA8S8CXYDFE
X-Proofpoint-GUID: y2RqEz9HuHi3DuxRi0COcZI6oXEgs71M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

Most architectures define their CFA as the value of the stack pointer
(SP) at the call site in the previous frame, as suggested by the DWARF
standard.  Therefore the SP at call site can be unwound using an
implicitly assumed value offset from CFA rule with an offset of zero:

  .cfi_val_offset <SP>, 0

As a result the SP at call site computes as follows:

  SP = CFA

Enable unwinding of user space for architectures, such as s390, which
define their CFA as the value of the SP at the call site in the previous
frame with an offset.  Do so by enabling architectures to override the
default SP value offset from CFA of zero with an architecture-specific
one:

  .cfi_val_offset <SP>, offset

So that the SP at call site computes as follows:

  SP = CFA + offset

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Reword commit message. (Josh)
    - Use term "sp_off" instead of "sp_val_off". (Josh)
    - Move definition, initialization, and setting of sp_off field to
      happen right after the cfa_off field.
    - Use SFRAME_SP_OFFSET macro instead of sframe_sp_off() function,
      which can be overridden by an architecture, such as s390.
    - Drop lengthy sframe_sp_[val_]off() comment.

 arch/x86/include/asm/unwind_user.h       |  2 ++
 include/asm-generic/Kbuild               |  1 +
 include/asm-generic/unwind_user_sframe.h | 12 ++++++++++++
 include/linux/unwind_user_types.h        |  1 +
 kernel/unwind/sframe.c                   |  2 ++
 kernel/unwind/user.c                     | 11 ++++++-----
 6 files changed, 24 insertions(+), 5 deletions(-)
 create mode 100644 include/asm-generic/unwind_user_sframe.h

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 4d699e4954ed..dbdbad0beaf9 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -25,6 +25,7 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 
 #define ARCH_INIT_USER_FP_FRAME(ws)			\
 	.cfa_off	=  2*(ws),			\
+	.sp_off		= 0,				\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= -2*(ws),			\
 	.use_fp		= true,				\
@@ -32,6 +33,7 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
 	.cfa_off	=  1*(ws),			\
+	.sp_off		= 0,				\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= 0,				\
 	.use_fp		= false,			\
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 295c94a3ccc1..b1d448ef4a50 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -60,6 +60,7 @@ mandatory-y += topology.h
 mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
 mandatory-y += unwind_user.h
+mandatory-y += unwind_user_sframe.h
 mandatory-y += vermagic.h
 mandatory-y += vga.h
 mandatory-y += video.h
diff --git a/include/asm-generic/unwind_user_sframe.h b/include/asm-generic/unwind_user_sframe.h
new file mode 100644
index 000000000000..8c9ac47bc8bd
--- /dev/null
+++ b/include/asm-generic/unwind_user_sframe.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_UNWIND_USER_SFRAME_H
+#define _ASM_GENERIC_UNWIND_USER_SFRAME_H
+
+#include <linux/types.h>
+
+#ifndef SFRAME_SP_OFFSET
+/* Most archs/ABIs define CFA as SP at call site, so that SP = CFA + 0. */
+#define SFRAME_SP_OFFSET 0
+#endif
+
+#endif /* _ASM_GENERIC_UNWIND_USER_SFRAME_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 616cc5ee4586..4656aa08a7db 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -29,6 +29,7 @@ struct unwind_stacktrace {
 
 struct unwind_user_frame {
 	s32 cfa_off;
+	s32 sp_off;
 	s32 ra_off;
 	s32 fp_off;
 	bool use_fp;
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 6465e7a315bc..7952b041dd23 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
 #include <linux/sframe.h>
+#include <asm/unwind_user_sframe.h>
 #include <linux/unwind_user_types.h>
 
 #include "sframe.h"
@@ -307,6 +308,7 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	fre = prev_fre;
 
 	frame->cfa_off = fre->cfa_off;
+	frame->sp_off  = SFRAME_SP_OFFSET;
 	frame->ra_off  = fre->ra_off;
 	frame->fp_off  = fre->fp_off;
 	frame->use_fp  = SFRAME_FRE_CFA_BASE_REG_ID(fre->info) == SFRAME_BASE_REG_FP;
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index fdb1001e3750..6c75a7411871 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -30,7 +30,7 @@ get_user_word(unsigned long *word, unsigned long base, int off, unsigned int ws)
 static int unwind_user_next_common(struct unwind_user_state *state,
 				   const struct unwind_user_frame *frame)
 {
-	unsigned long cfa, fp, ra;
+	unsigned long cfa, sp, fp, ra;
 
 	/* Stop unwinding when reaching an outermost frame. */
 	if (frame->outermost) {
@@ -48,12 +48,13 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 	}
 	cfa += frame->cfa_off;
 
+	/* Get the Stack Pointer (SP) */
+	sp = cfa + frame->sp_off;
 	/* Make sure that stack is not going in wrong direction */
-	if (cfa <= state->sp)
+	if (sp <= state->sp)
 		return -EINVAL;
-
 	/* Make sure that the address is word aligned */
-	if (cfa & (state->ws - 1))
+	if (sp & (state->ws - 1))
 		return -EINVAL;
 
 	/* Get the Return Address (RA) */
@@ -65,7 +66,7 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 		return -EINVAL;
 
 	state->ip = ra;
-	state->sp = cfa;
+	state->sp = sp;
 	if (frame->fp_off)
 		state->fp = fp;
 	state->topmost = false;
-- 
2.51.0


