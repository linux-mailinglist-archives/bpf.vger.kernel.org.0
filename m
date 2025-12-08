Return-Path: <bpf+bounces-76306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C4FCADE91
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 607403099A03
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D273195F5;
	Mon,  8 Dec 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GSlVmxsj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1953148A8;
	Mon,  8 Dec 2025 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214207; cv=none; b=DOfBKqQ9GMgO+UDAWnkkhZqa05pH/o/62fiysr9cgwCaZzCJ0SMq4OBOtHBxBGyE782jL1WbIf8r+MrktY0xxjVvxLCb/Y/EOPo/qyjeu2JBebRtNV1fIeGu9jqI21Ro4ITAbEVr8dUJ9Z9aL3Y2ypsDTSYZWxkwLYOE4xiALtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214207; c=relaxed/simple;
	bh=yltrjhIGJ7HS+wjrruyRHfyMCbcnORydhV9U9I20LBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWyLbQvwStS9R1xtAPfUGm5D9JNl0QWeRslxLfUeBTg3JAR7QvguyFbRIGveE1pXU7auQnGVjnF/kgQUA97Ha/UMHLEnW0w15FDLqYD6RVcnd16FKti2+jh5Mk4CEjEv0jXUGRx6Mhb1Rm91EATLbrYMyw9IPU578KcCp2Kcezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GSlVmxsj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8E18ll006746;
	Mon, 8 Dec 2025 17:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nQgOZ+bDADUiR3Ynt
	G0xn8e9CinrTQX7CPDM9ldJA5k=; b=GSlVmxsj/rgXvkrk7DSMs/QhHcDEpY8kp
	/yY1gqCai9SAp24VPGVts/GpooswCrPtc+d/f4DI4qnV4gq3Nv0SKrendMnZdwJD
	IObrU/EVAKmAYCCh9Gqpdi6xbICRoCWGlq4N7Ww83cz8KNaODMXAcRNNEsdwpKUp
	vj4na1i+C7tDM9hB8Npqvrx2oXz3zISVZyyRa9N2I8F+Dwz9q7u4hJMFq4EPLw6l
	E47oI+ZqrpTTQUvoLD6U7v8Y1Ize35kwTM+zr3eR4XGq+3F1AZRzfYhfzMJsiBgZ
	xZgThc5b9co2WGM2Y62Rpyuju5/cryvuXEsQt6A6s1HYy3Wh13C4Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvgqd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:11 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8GlVCQ011132;
	Mon, 8 Dec 2025 17:16:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvgqd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8EsSTj008447;
	Mon, 8 Dec 2025 17:16:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytmpsqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG6MG44827090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D60B2004B;
	Mon,  8 Dec 2025 17:16:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E50392004E;
	Mon,  8 Dec 2025 17:16:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 17:16:05 +0000 (GMT)
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
Subject: [RFC PATCH v3 11/17] unwind_user: Enable archs that save RA/FP in other registers
Date: Mon,  8 Dec 2025 18:15:53 +0100
Message-ID: <20251208171559.2029709-12-jremus@linux.ibm.com>
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
X-Proofpoint-GUID: G-R65yOj-nr7pPW8wQTZm1ZlLMUaWRfP
X-Proofpoint-ORIG-GUID: Fq24udxWE1_jpmfHWPegkv1A0HnkQCb2
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=693707db cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=-jCn-aex0Ddyt886wV4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX7cZxRWCVYHJV
 vZ/zBA1FwVH5VrNrcTdZVYs0wGdJpnuFjj2TiIKH6xd9i0HfYiCTfo64n0AgRjjUB6b5NF0/u7X
 6JvH85ANFDtJq5DvFKg8YJoHQwv6WIv2WDjAQvVReDwiidlopoQ13ZOUrVAl2MVXErLVwr58Of6
 OVg4jB3E+4fK8RREYZBLmbLXQ4h/HSuehu8gi0VJ1wja1QxmDJQqWDqDSNkL28fhIZjJQS5SCWT
 Qw9JVf9oI7dgAirIkZwgJLDwtX5+nrQuv2MUrIh+2IDGlCHv/HPES1f+ju714sQ/plpKIBMCPRT
 QnuVXJZp9/yiwSoGi+cj9zNVtgWTTG/6MkrVWgsaPngtTCQRBti9RuWYMDoPcd22+wuyZgMT7mp
 nbgpVbUKaEnuIch/sFwdpbnXDxouNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000

Enable unwinding of user space for architectures, such as s390, that
save the return address (RA) and/or frame pointer (FP) in other
registers.  This is only valid in the topmost frame, for instance when
in a leaf function.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v3:
    - Rename UNWIND_USER_LOC_NONE to UNWIND_USER_LOC_RETAIN to better
      disambiguate from new UNWIND_USER_LOC_UNKNOWN to be introduced for
      for back chain unwinding on s390.
      Other naming options: IDENTITY, KEEP, PRESERVE, SAME, UNCHANGED.
    
    Changes in RFC v2:
    - Reword HAVE_UNWIND_USER_LOC_REG help text.
    - Rename struct unwind_user_reginfo field frame_off to offset. (Josh)
    - Move dummy unwind_user_get_reg() from asm-generic/unwind_user.h
      to linux/unwind_user.h, drop its function comment, warn once,
      return -EINVAL, and guard by !HAVE_UNWIND_USER_LOC_REG. (Josh)
    - Rename generic_sframe_set_frame_reginfo() to sframe_init_reginfo()
      and drop its function comment. (Josh)
    - Do not check FP/RA offset for zero for UNWIND_USER_LOC_STACK. (Josh)
    - Do not check for !IS_ENABLED(CONFIG_HAVE_UNWIND_USER_LOC_REG), as
      the dummy implementation of unwind_user_get_reg() returns -EINVAL.
    - Drop config option HAVE_UNWIND_USER_LOC_REG, as it is no longer of
      any value.
    - Keep checking for topmost for UNWIND_USER_LOC_REG. (Jens)
    - Explicitly preserve FP if UNWIND_USER_LOC_NONE and drop later test
      for frame->fp.loc != UNWIND_USER_LOC_NONE. (Josh)
    
    Would it make sense to rename UNWIND_USER_LOC_NONE to one of the
    following to clarify its meaning for the unwinder?
    - UNWIND_USER_LOC_UNCHANGED
    - UNWIND_USER_LOC_RETAIN
    - UNWIND_USER_LOC_PRESERVED
    - UNWIND_USER_LOC_IDENTITY

 arch/x86/include/asm/unwind_user.h       | 21 +++++++++++---
 include/asm-generic/unwind_user_sframe.h | 15 ++++++++++
 include/linux/unwind_user.h              |  9 ++++++
 include/linux/unwind_user_types.h        | 18 ++++++++++--
 kernel/unwind/sframe.c                   |  4 +--
 kernel/unwind/user.c                     | 37 +++++++++++++++++++-----
 6 files changed, 89 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index d70ffd7bbdb7..2480d86a405e 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -22,16 +22,27 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 #define ARCH_INIT_USER_FP_FRAME(ws)			\
 	.cfa_off	=  2*(ws),			\
 	.sp_off		= 0,				\
-	.ra_off		= -1*(ws),			\
-	.fp_off		= -2*(ws),			\
+	.ra		= {				\
+		.loc		= UNWIND_USER_LOC_STACK,\
+		.offset		= -1*(ws),		\
+			},				\
+	.fp		= {				\
+		.loc		= UNWIND_USER_LOC_STACK,\
+		.offset		= -2*(ws),		\
+			},				\
 	.use_fp		= true,				\
 	.outermost	= false,
 
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
 	.cfa_off	=  1*(ws),			\
 	.sp_off		= 0,				\
-	.ra_off		= -1*(ws),			\
-	.fp_off		= 0,				\
+	.ra		= {				\
+		.loc		= UNWIND_USER_LOC_STACK,\
+		.offset		= -1*(ws),		\
+			},				\
+	.fp		= {				\
+		.loc		= UNWIND_USER_LOC_RETAIN,\
+			},				\
 	.use_fp		= false,			\
 	.outermost	= false,
 
@@ -43,4 +54,6 @@ static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 
 #endif /* CONFIG_HAVE_UNWIND_USER_FP */
 
+#include <asm-generic/unwind_user.h>
+
 #endif /* _ASM_X86_UNWIND_USER_H */
diff --git a/include/asm-generic/unwind_user_sframe.h b/include/asm-generic/unwind_user_sframe.h
index 8c9ac47bc8bd..fd71d6b1916b 100644
--- a/include/asm-generic/unwind_user_sframe.h
+++ b/include/asm-generic/unwind_user_sframe.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_GENERIC_UNWIND_USER_SFRAME_H
 #define _ASM_GENERIC_UNWIND_USER_SFRAME_H
 
+#include <linux/unwind_user_types.h>
 #include <linux/types.h>
 
 #ifndef SFRAME_SP_OFFSET
@@ -9,4 +10,18 @@
 #define SFRAME_SP_OFFSET 0
 #endif
 
+#ifndef sframe_init_reginfo
+static inline void
+sframe_init_reginfo(struct unwind_user_reginfo *reginfo, s32 offset)
+{
+	if (offset) {
+		reginfo->loc = UNWIND_USER_LOC_STACK;
+		reginfo->offset = offset;
+	} else {
+		reginfo->loc = UNWIND_USER_LOC_RETAIN;
+	}
+}
+#define sframe_init_reginfo sframe_init_reginfo
+#endif
+
 #endif /* _ASM_GENERIC_UNWIND_USER_SFRAME_H */
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index bc2edae39955..61fd5c05d0f0 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -32,6 +32,15 @@ static inline int unwind_user_get_ra_reg(unsigned long *val)
 #define unwind_user_get_ra_reg unwind_user_get_ra_reg
 #endif
 
+#ifndef unwind_user_get_reg
+static inline int unwind_user_get_reg(unsigned long *val, int regnum)
+{
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+#define unwind_user_get_reg unwind_user_get_reg
+#endif
+
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
 
 #endif /* _LINUX_UNWIND_USER_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 4656aa08a7db..4f78999a0750 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -27,11 +27,25 @@ struct unwind_stacktrace {
 	unsigned long	*entries;
 };
 
+enum unwind_user_loc {
+	UNWIND_USER_LOC_RETAIN,
+	UNWIND_USER_LOC_STACK,
+	UNWIND_USER_LOC_REG,
+};
+
+struct unwind_user_reginfo {
+	enum unwind_user_loc loc;
+	union {
+		s32 offset;
+		int regnum;
+	};
+};
+
 struct unwind_user_frame {
 	s32 cfa_off;
 	s32 sp_off;
-	s32 ra_off;
-	s32 fp_off;
+	struct unwind_user_reginfo ra;
+	struct unwind_user_reginfo fp;
 	bool use_fp;
 	bool outermost;
 };
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 38b3577f5253..45cd7380ac38 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -307,8 +307,8 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 
 	frame->cfa_off = fre->cfa_off;
 	frame->sp_off  = SFRAME_SP_OFFSET;
-	frame->ra_off  = fre->ra_off;
-	frame->fp_off  = fre->fp_off;
+	sframe_init_reginfo(&frame->ra, fre->ra_off);
+	sframe_init_reginfo(&frame->fp, fre->fp_off);
 	frame->use_fp  = SFRAME_FRE_CFA_BASE_REG_ID(fre->info) == SFRAME_BASE_REG_FP;
 	frame->outermost = fre->ra_undefined;
 
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 58e1549cd9f4..45f82ed28fcb 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -62,22 +62,45 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 		return -EINVAL;
 
 	/* Get the Return Address (RA) */
-	if (frame->ra_off) {
-		if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
-			return -EINVAL;
-	} else {
+	switch (frame->ra.loc) {
+	case UNWIND_USER_LOC_RETAIN:
 		if (!state->topmost || unwind_user_get_ra_reg(&ra))
 			return -EINVAL;
+		break;
+	case UNWIND_USER_LOC_STACK:
+		if (get_user_word(&ra, cfa, frame->ra.offset, state->ws))
+			return -EINVAL;
+		break;
+	case UNWIND_USER_LOC_REG:
+		if (!state->topmost || unwind_user_get_reg(&ra, frame->ra.regnum))
+			return -EINVAL;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
 
 	/* Get the Frame Pointer (FP) */
-	if (frame->fp_off && get_user_word(&fp, cfa, frame->fp_off, state->ws))
+	switch (frame->fp.loc) {
+	case UNWIND_USER_LOC_RETAIN:
+		fp = state->fp;
+		break;
+	case UNWIND_USER_LOC_STACK:
+		if (get_user_word(&fp, cfa, frame->fp.offset, state->ws))
+			return -EINVAL;
+		break;
+	case UNWIND_USER_LOC_REG:
+		if (!state->topmost || unwind_user_get_reg(&fp, frame->fp.regnum))
+			return -EINVAL;
+		break;
+	default:
+		WARN_ON_ONCE(1);
 		return -EINVAL;
+	}
 
 	state->ip = ra;
 	state->sp = sp;
-	if (frame->fp_off)
-		state->fp = fp;
+	state->fp = fp;
 	state->topmost = false;
 	return 0;
 }
-- 
2.51.0


