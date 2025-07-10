Return-Path: <bpf+bounces-62950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC68EB00900
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 18:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16A156115E
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B7C2F4319;
	Thu, 10 Jul 2025 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dRidxiDA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AFD2F3C0A;
	Thu, 10 Jul 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165378; cv=none; b=F6Mnv66uQjZO4QBsQcqf98hGuu5P2FIzMLNnKIMojr/X3P/h4KtsBxW554y4Ht6ET4NdJ9wyWEbZ0QAH+u9urK73HSqoatlW5vuZawbbFQbb2xoYmhKc61UscbWIjzQKbxDARPhkV5sNKiIRQDcGNJ8C/Ub65Y4pQzl9ESxO6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165378; c=relaxed/simple;
	bh=UdioYf0z4JVe2wXZvP/BlmlAGkoYzh2BI1YAg26Hbfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4XwRaQ43jERfY9MQabZ69NDc/yfiG1hUZhPkz5etq8crjdnYZni3xZ62ZU7MMlvU3sHa9GBw/s2fvMHHVE8kbSUMbFUkLVgzztineP9EXQakcU8yr4alPSzpOS6s3USexrcD5kNIDVMIYxaseLYvlM9mONrBxrmSrcw5HFCTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dRidxiDA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9r57d021381;
	Thu, 10 Jul 2025 16:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4mp0aqcfM1Kn4YKur
	468ryV/tNEjFl+WQRVzoAREwUU=; b=dRidxiDAJU/FkxPiVuayLKhRonqcmkqAU
	pQrp8lfe7vUG2Tz5y6hS/pLXHRoTXQtcpzUZEA3fS1xQJP56U81iShklBufJa1R7
	a4kSvLVEIcRaaz7z4QCH8B+Ti0njMwXvlCmkD7CSSWehgUQEvIkH7RWdlNqr846t
	dN4KP5QmE/iG6STM3oOZMgeV73bXyiJ7QNj6CNgUodazBGBgeW1yMsaht7TxKGnc
	qG1aY0BVBiFrR3hQbnIX7ZMGz6AL7H5UJfThovUvGvjjYYmFoir5EvegriA5nt4z
	nmGV5CD/FRGoH/8yPLn+eyQB3ykpKOIJXEC/sOGhIZ8fiJlsVUReg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pusse6a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEFv3n025528;
	Thu, 10 Jul 2025 16:35:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcpek04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 16:35:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56AGZQjZ29622824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:35:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83D9F20040;
	Thu, 10 Jul 2025 16:35:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 400C420043;
	Thu, 10 Jul 2025 16:35:26 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 16:35:26 +0000 (GMT)
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
Subject: [RFC PATCH v1 08/16] unwind_user: Enable archs that save RA/FP in other registers
Date: Thu, 10 Jul 2025 18:35:14 +0200
Message-ID: <20250710163522.3195293-9-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686febd3 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=7C_LGUadM1zRbwzA-T8A:9
X-Proofpoint-GUID: LXBNRzcFvCvy3QEhgmZ03k_QwlJiJxy7
X-Proofpoint-ORIG-GUID: LXBNRzcFvCvy3QEhgmZ03k_QwlJiJxy7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX4GJMXdDP+XJh 3t1yPPicdscjvUj6Ttl50LKfsGqVJi0/8UOYfVWY52yc5V640EcPnKIViuwqL0K/e9aaeGqv1+1 P8kGrI1kaFfR/F2BTLI2uMu0RB4xFH+69CGuD9dayC4t9yEJ+hduUU3SD5vEkllAxjkNTc1i9yc
 N3qQB8pIL6MQHN0n2K3WBuviGlKTijAz5tBiOdrjr6Zc5l0fPELdzeq3s6pHdG3UVIksDNnMyZH n8z4Fv8tyXwRIFDyZLKCdjCwt7xSrBMg399wylkQBJSze70R3f+dKuueJ7Ur0OiOD9vDQyOohXo VcU9HUywwWVmfhZS3hOOTYR7tHusYLHtDBXCNC9eCrsrEly9Az1ZeLcgV+wvmdcEI5XCx/F2FCJ
 e1YO9Ge4//uFN0rWBAIe0M7067gcx+/U0A2INuVrdUF2jZiYuKnIPiHA4M49YcEHv14pQbIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=754 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100139

Enable unwinding of user space for architectures, such as s390, that
save the return address (RA) and/or frame pointer (FP) in other
registers.  This is only valid in the topmost frame, for instance when
in a leaf function.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/Kconfig                             |  7 ++++
 arch/x86/include/asm/unwind_user.h       | 24 +++++++++---
 include/asm-generic/unwind_user.h        | 20 ++++++++++
 include/asm-generic/unwind_user_sframe.h | 24 ++++++++++++
 include/linux/unwind_user_types.h        | 18 ++++++++-
 kernel/unwind/sframe.c                   |  4 +-
 kernel/unwind/user.c                     | 47 ++++++++++++++++++++----
 7 files changed, 126 insertions(+), 18 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 367eaf7e62e0..9e28dffe42cb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -455,6 +455,13 @@ config HAVE_USER_RA_REG
 	help
 	  The arch passes the return address (RA) in user space in a register.
 
+config HAVE_UNWIND_USER_LOC_REG
+	bool
+	help
+	  The arch potentially saves the return address (RA) and/or frame
+	  pointer (FP) register values in user space in other registers, when
+	  in the topmost frame (e.g. in leaf function).
+
 config SFRAME_VALIDATION
 	bool "Enable .sframe section debugging"
 	depends on HAVE_UNWIND_USER_SFRAME
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index c2881840adf4..925d208aa39d 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -5,18 +5,30 @@
 #include <linux/unwind_user_types.h>
 
 #define ARCH_INIT_USER_FP_FRAME							\
-	.cfa_off	= (s32)sizeof(long) *  2,				\
-	.ra_off		= (s32)sizeof(long) * -1,				\
-	.fp_off		= (s32)sizeof(long) * -2,				\
+	.cfa_off	= (s32)sizeof(long) * 2,				\
+	.ra		= {							\
+		.loc = UNWIND_USER_LOC_STACK,					\
+		.frame_off = (s32)sizeof(long) * -1,				\
+	},									\
+	.fp		= {							\
+		.loc = UNWIND_USER_LOC_STACK,					\
+		.frame_off = (s32)sizeof(long) * -2,				\
+	},									\
 	.sp_val_off	= (s32)0,						\
 	.use_fp		= true,
 
 #ifdef CONFIG_IA32_EMULATION
 
 #define ARCH_INIT_USER_COMPAT_FP_FRAME						\
-	.cfa_off	= (s32)sizeof(u32)  *  2,				\
-	.ra_off		= (s32)sizeof(u32)  * -1,				\
-	.fp_off		= (s32)sizeof(u32)  * -2,				\
+	.cfa_off	= (s32)sizeof(u32) * 2,					\
+	.ra		= {							\
+		.loc = UNWIND_USER_LOC_STACK,					\
+		.frame_off = (s32)sizeof(u32) * -1,				\
+	},									\
+	.fp		= {							\
+		.loc = UNWIND_USER_LOC_STACK,					\
+		.frame_off = (s32)sizeof(u32) * -2,				\
+	},									\
 	.sp_val_off	= (s32)0,						\
 	.use_fp		= true,
 
diff --git a/include/asm-generic/unwind_user.h b/include/asm-generic/unwind_user.h
index b8882b909944..3891b7cfe3b8 100644
--- a/include/asm-generic/unwind_user.h
+++ b/include/asm-generic/unwind_user.h
@@ -2,4 +2,24 @@
 #ifndef _ASM_GENERIC_UNWIND_USER_H
 #define _ASM_GENERIC_UNWIND_USER_H
 
+#include <asm/unwind_user_types.h>
+
+#ifndef unwind_user_get_reg
+
+/**
+ * generic_unwind_user_get_reg - Get register value.
+ * @val: Register value.
+ * @regnum: DWARF register number to obtain the value from.
+ *
+ * Returns zero if successful. Otherwise -EINVAL.
+ */
+static inline int generic_unwind_user_get_reg(unsigned long *val, int regnum)
+{
+	return -EINVAL;
+}
+
+#define unwind_user_get_reg generic_unwind_user_get_reg
+
+#endif /* !unwind_user_get_reg */
+
 #endif /* _ASM_GENERIC_UNWIND_USER_H */
diff --git a/include/asm-generic/unwind_user_sframe.h b/include/asm-generic/unwind_user_sframe.h
index 6c87a7f29861..8cef3e0857b6 100644
--- a/include/asm-generic/unwind_user_sframe.h
+++ b/include/asm-generic/unwind_user_sframe.h
@@ -2,8 +2,31 @@
 #ifndef _ASM_GENERIC_UNWIND_USER_SFRAME_H
 #define _ASM_GENERIC_UNWIND_USER_SFRAME_H
 
+#include <linux/unwind_user_types.h>
 #include <linux/types.h>
 
+/**
+ * generic_sframe_set_frame_reginfo - Populate info to unwind FP/RA register
+ * from SFrame offset.
+ * @reginfo: Unwind info for FP/RA register.
+ * @offset: SFrame offset value.
+ *
+ * A non-zero offset value denotes a stack offset from CFA and indicates
+ * that the register is saved on the stack. A zero offset value indicates
+ * that the register is not saved.
+ */
+static inline void generic_sframe_set_frame_reginfo(
+	struct unwind_user_reginfo *reginfo,
+	s32 offset)
+{
+	if (offset) {
+		reginfo->loc = UNWIND_USER_LOC_STACK;
+		reginfo->frame_off = offset;
+	} else {
+		reginfo->loc = UNWIND_USER_LOC_NONE;
+	}
+}
+
 /**
  * generic_sframe_sp_val_off - Get generic SP value offset from CFA.
  *
@@ -25,6 +48,7 @@ static inline s32 generic_sframe_sp_val_off(void)
 	return 0;
 }
 
+#define sframe_set_frame_reginfo generic_sframe_set_frame_reginfo
 #define sframe_sp_val_off generic_sframe_sp_val_off
 
 #endif /* _ASM_GENERIC_UNWIND_USER_SFRAME_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index adef01698bb3..57fd16e314cf 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -21,10 +21,24 @@ struct unwind_stacktrace {
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
+		s32 frame_off;
+		int regnum;
+	};
+};
+
 struct unwind_user_frame {
 	s32 cfa_off;
-	s32 ra_off;
-	s32 fp_off;
+	struct unwind_user_reginfo ra;
+	struct unwind_user_reginfo fp;
 	s32 sp_val_off;
 	bool use_fp;
 };
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 5bfaf06e6cd2..43ef3a8c4c26 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -314,8 +314,8 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	}
 
 	frame->cfa_off = fre->cfa_off;
-	frame->ra_off  = fre->ra_off;
-	frame->fp_off  = fre->fp_off;
+	sframe_set_frame_reginfo(&frame->ra, fre->ra_off);
+	sframe_set_frame_reginfo(&frame->fp, fre->fp_off);
 	frame->use_fp  = SFRAME_FRE_CFA_BASE_REG_ID(fre->info) == SFRAME_BASE_REG_FP;
 	frame->sp_val_off = sframe_sp_val_off();
 
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 03a6da36192f..ee00d39d2a8e 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -98,26 +98,57 @@ static int unwind_user_next(struct unwind_user_state *state)
 
 
 	/* Get the Return Address (RA) */
-	if (frame->ra_off) {
+	switch (frame->ra.loc) {
+	case UNWIND_USER_LOC_NONE:
+		if (!IS_ENABLED(CONFIG_HAVE_USER_RA_REG) || !topmost)
+			goto done;
+		ra = user_return_address(task_pt_regs(current));
+		break;
+	case UNWIND_USER_LOC_STACK:
+		if (!frame->ra.frame_off)
+			goto done;
 		/* Make sure that the address is word aligned */
 		shift = sizeof(long) == 4 || compat_fp_state(state) ? 2 : 3;
-		if ((cfa + frame->ra_off) & ((1 << shift) - 1))
+		if ((cfa + frame->ra.frame_off) & ((1 << shift) - 1))
 			goto done;
-		if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
+		if (unwind_get_user_long(ra, cfa + frame->ra.frame_off, state))
 			goto done;
-	} else {
-		if (!IS_ENABLED(CONFIG_HAVE_USER_RA_REG) || !topmost)
+		break;
+	case UNWIND_USER_LOC_REG:
+		if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_LOC_REG) || !topmost)
 			goto done;
-		ra = user_return_address(task_pt_regs(current));
+		if (unwind_user_get_reg(&ra, frame->ra.regnum))
+			goto done;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		goto done;
 	}
 
 	/* Get the Frame Pointer (FP) */
-	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off, state))
+	switch (frame->fp.loc) {
+	case UNWIND_USER_LOC_NONE:
+		break;
+	case UNWIND_USER_LOC_STACK:
+		if (!frame->fp.frame_off)
+			goto done;
+		if (unwind_get_user_long(fp, cfa + frame->fp.frame_off, state))
+			goto done;
+		break;
+	case UNWIND_USER_LOC_REG:
+		if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_LOC_REG) || !topmost)
+			goto done;
+		if (unwind_user_get_reg(&fp, frame->fp.regnum))
+			goto done;
+		break;
+	default:
+		WARN_ON_ONCE(1);
 		goto done;
+	}
 
 	state->ip = ra;
 	state->sp = sp;
-	if (frame->fp_off)
+	if (frame->fp.loc != UNWIND_USER_LOC_NONE)
 		state->fp = fp;
 
 	arch_unwind_user_next(state);
-- 
2.48.1


