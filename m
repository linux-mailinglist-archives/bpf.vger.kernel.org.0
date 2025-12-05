Return-Path: <bpf+bounces-76154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E86CA8895
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 18:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6D1E300B6BD
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 17:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1907934F256;
	Fri,  5 Dec 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PJqIhMlF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7FC349B08;
	Fri,  5 Dec 2025 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954934; cv=none; b=uQKH+KSBNM+GYibK8WzWFR111LvKhh3/T6KOFb9x3zx0EYE8FclI5KnDQYtMUOSKU0vWzUADUEq4SK5ZqmYC8xyFXWbgjPCyI97f8qM6wyI47lwpWUMHF56j2cGxeCmgocbWwGJvUjVB7Ud9MiTdqDwu4rCfvWc7GEl5U6XoXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954934; c=relaxed/simple;
	bh=BaaazKY4N/gQqcOAQuMq3hnJYhCcrMeU6NqtFo95EdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQ2Ozl9aRZyxqwTbtXKSVlFdKlqrmdMHvjF7xBUR3uAl9ACB9LfGTuSxCuaSF0j3TXgSQKqnPx13oz/RrWHVusmct7g5vyvFY3gFe0mB/+m3GbFBS9rO5Mt30FNsdP2OEgJU+sQ3YDLQpgsPBTYZ5j3QzYmd4T24DGt/Pi9ASU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PJqIhMlF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5CbnhN029507;
	Fri, 5 Dec 2025 17:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xqV77jlNdGfgAvl7u
	ClQOa17ALUwsCcaS1Mv50ZA9CI=; b=PJqIhMlF+oVb6fch22SHxkH1B+b5GtcOW
	rNOjUsQ9qsm05vkiw5VNRkQG7PpOMx8hZRajpsSiDkjWhH/WvUXkzoai7qCN6KK6
	hqfTNT4MdSEGNDZObZBn0XbB7/eYHxEVHrnqxFv1jbm49mbUtawXAomgpc9QwGJf
	ebfdisUT5Lr3j7dTRm+d1Zx23tWp2FCI5/sGQRzJrlPlWiJpiS4DXowe4UREN9Tw
	+uhfMAYQMNXVMjZBu1Ni83vG1MxQzpjyGqSzrLSXCbIljeYGF8PwhJR3paLd4y38
	L8W/RUxjbM/UU+4yd8yb3HyE1zZulx5i8cMX1MY7opcNd65N8USHw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8v664w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B5H7RIH021565;
	Fri, 5 Dec 2025 17:14:56 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8v664r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5Eb9Tp010240;
	Fri, 5 Dec 2025 17:14:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnkpb58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 17:14:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B5HEpxF26214784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 17:14:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2A942004E;
	Fri,  5 Dec 2025 17:14:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5429820063;
	Fri,  5 Dec 2025 17:14:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Dec 2025 17:14:51 +0000 (GMT)
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
Subject: [RFC PATCH v2 10/15] unwind_user: Enable archs that save RA/FP in other registers
Date: Fri,  5 Dec 2025 18:14:41 +0100
Message-ID: <20251205171446.2814872-11-jremus@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 6pSAVqgkRWaR6NSOf0v0jLVZro9nB8W8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfXzHkjNdTEuIJO
 qwyZXR/LEV/0Ma77q5VWJEK2xxl7YF3raYUlk9u+/B7rJQeX6qoF2IoCz3CbGi/ixYrSLiSkAvm
 1GVk8v9PWcOPjxOOl5s/E96QH/L9BpMo7tJ/G3f84toJThXRvK65ItVLM0BquQc7xd5kUYK97JN
 QhF6H3L+RAa/FSD//B8gdLvHIHTfwW6pDeqVKX6XaoKogF9UahJRw2KLdcTCaDbb6NEE36h5Ow7
 eC4/WcJTOoYQPYLYZbHXirrG1//lKnTEFoHE+D2EBvXjscXabO/xiLwvjchqXXpTCHh5W1rXPTo
 EghCUAdsV7SNgnqCyrAOnNPiWaUUKxA1w9Rwtu80j+/BQHfGW9AZnuaUBVZXr4B3A3iYMRsB4Li
 AGEtUgGBZLvUSc8aEDPmHtRL1+AbYQ==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=69331311 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=-jCn-aex0Ddyt886wV4A:9
X-Proofpoint-GUID: 5nhX3_gGauAHjq09AvhKfodUzaFNN60l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290008

Enable unwinding of user space for architectures, such as s390, that
save the return address (RA) and/or frame pointer (FP) in other
registers.  This is only valid in the topmost frame, for instance when
in a leaf function.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
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
index dbdbad0beaf9..61a9ae9b07ea 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -26,16 +26,27 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
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
+		.loc		= UNWIND_USER_LOC_NONE,	\
+			},				\
 	.use_fp		= false,			\
 	.outermost	= false,
 
@@ -47,4 +58,6 @@ static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 
 #endif /* CONFIG_HAVE_UNWIND_USER_FP */
 
+#include <asm-generic/unwind_user.h>
+
 #endif /* _ASM_X86_UNWIND_USER_H */
diff --git a/include/asm-generic/unwind_user_sframe.h b/include/asm-generic/unwind_user_sframe.h
index 8c9ac47bc8bd..163961ca5252 100644
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
+		reginfo->loc = UNWIND_USER_LOC_NONE;
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
index 4656aa08a7db..6efc12b6e831 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -27,11 +27,25 @@ struct unwind_stacktrace {
 	unsigned long	*entries;
 };
 
+enum unwind_user_loc {
+	UNWIND_USER_LOC_NONE,
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
index 58e1549cd9f4..122045cb411f 100644
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
+	case UNWIND_USER_LOC_NONE:
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
+	case UNWIND_USER_LOC_NONE:
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


