Return-Path: <bpf+bounces-76314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1689ACADE79
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 18:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84653301FF34
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990AF31B131;
	Mon,  8 Dec 2025 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aRDWi8o3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2E31961E;
	Mon,  8 Dec 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765214220; cv=none; b=seI061cGPnVE92vG7sKm29amFnSOqovctWwnIf2QWRfmCqZomAApN1KHxEu43HOowAb74Mo4wveTThpCXsvC9TWVM19jS5BAB7lP/KucATyb8X45Rcn4zMnNsnKCInyHhw0PLj2OOMhfd8pUaFheECgejzpBLM4bNU06dpnOcI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765214220; c=relaxed/simple;
	bh=DBnHOk4FK1UKNjbxJwy+IMIhairhdYg7BZrfu3QAvRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5PnEG6s1j76EFxB6W4OM2A42dTF6zFrV0A3TbMBLmT4gg+g1e0VaQCzvMl3OFEW9KA6nhEaiER4oAZxo/8IQLlpwLx+yd3Wp7NUF/NZc8t63FHzB043Wj16opRlodW3/Fbob1urMljVr5hRI1ZiMQDijJyy5EtcyBiZZl7UKSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aRDWi8o3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8CvGmX030454;
	Mon, 8 Dec 2025 17:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wmFgRAYKPW9QzlHor
	sY1AItZKu/9q8ZTL2MmwlFJcbU=; b=aRDWi8o3QThPaC9+ae3SqMgSjmhGu5e7v
	6+gFxAzCEJtbnPy/MBnpKYVVFLbSdChVBUa7f9qFBIC+SeumptmqxuO1HKwK5Rgv
	u3lvvFb1/YDh5oben8tZld1Ozh68CLJ/A9WdP/d74CAN0RrQ4w3i7oNTERWlHjgX
	H+Ey4JqDb+j+VFH0SkLEGA9Rj1MYCqodQuYLmwhp0LEgouI+98MaQkIDFQcuIKhc
	H0mXj5l9acw3YU2IDL+Ns3ESRQuD49l6XzPVhHEsbDdZ1vjL/vDDVlGI8UNo13N6
	FPOD07YCYcF4BxfCPwD/mI/E6Q0bEG0jrE52BvwciiAh7BDyOJc6Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc538dn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:11 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B8H1lMk029296;
	Mon, 8 Dec 2025 17:16:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc538dmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8FM7LQ002053;
	Mon, 8 Dec 2025 17:16:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11j6kfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 17:16:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8HG5T322676062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 17:16:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8509F20043;
	Mon,  8 Dec 2025 17:16:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30E192004B;
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
Subject: [RFC PATCH v3 09/17] unwind_user: Enable archs that define CFA = SP_callsite + offset
Date: Mon,  8 Dec 2025 18:15:51 +0100
Message-ID: <20251208171559.2029709-10-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX97N2tpdo9EyV
 //R4+nBaZOTb6sa1ZsMsrKr4TqFTIdzvc9h1QuUsLwDUwfO4ndRykLo1QUd0lJyzYKKxzNVBPhy
 Hi+6IF7VCtkXxwai342paXgyd2n7vVGyQ9scL4BlzXS/AQ160ZNyimoG26lz6mx3SZhEuqjqvhR
 Y9Dd+YZekevju8JJ7ze1rrzwcYfxQC3BjiPrVPxXO6qyI90/FcOthZXjITe5EkLxvGOjgbMHWDW
 E9EQ3MP5GoIpbW1WbOafZtASRm0m8ugWzEm4seKTTqlxnjnfsa3AU1vQOSya+epxRbqpvNiTQmV
 zefVdovvIMBUhp1t8KgG12hcW5mT8lb3DgzolSeuCGxi/8Rp4oyIsqJY5/6nV9i3b3ddW/39Ugd
 mGLcGKfl1xErgXX4BIbOLOE7dHOMfA==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=693707db cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=D-3WH5monn3MMgO2UeQA:9
X-Proofpoint-ORIG-GUID: _i2tCZTpHm7OdTqRJeV_F-9KGTsbwyB7
X-Proofpoint-GUID: XLTiHiB5ty0VkxfR_1F7KEJ4xXNAlRMQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

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
index 2dfb5ef11e36..d70ffd7bbdb7 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -21,6 +21,7 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 
 #define ARCH_INIT_USER_FP_FRAME(ws)			\
 	.cfa_off	=  2*(ws),			\
+	.sp_off		= 0,				\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= -2*(ws),			\
 	.use_fp		= true,				\
@@ -28,6 +29,7 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 
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


