Return-Path: <bpf+bounces-66187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 696BCB2F6CE
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 13:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C171CC2698
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4FE30F7E1;
	Thu, 21 Aug 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DDPsMdCd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F102ECEA6
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776041; cv=none; b=Is4nR1nmtMQtVQ/ttuV5wrzNZH4efAaSQIXMs7pN8+J+TmwB6gF8pLzbt3aBcJgdZn6EwuqqqWKiFOUMVduc9tALvPf83vJ05/4YKi9V3NpI2Vwk1i4BG2ATFwWFlD4Qboa89RgiNL2UglnyJZSKSHQpM3M2L0HhkWOSCpQtjHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776041; c=relaxed/simple;
	bh=IbRllNalbIR18N/Ppz1MwdGO1bLLa61BKUNIphaVaPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fU2rfyN5IJ08f80nBNbVMxLuQskY02KiLzH4VuknDUGXLfG6eYzAOGuv6KvB4ntSwb6T3jY2UjVUxHFDmGNvBh+7yw6BlAMLNWCSXI4cfVDBXVi3cpKHbfeRHE/fICLHIlStYTFBiZyMoT2hHme2B9AvpLK4Psy0HLbL4Jnq1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DDPsMdCd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAeCsg017418;
	Thu, 21 Aug 2025 11:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TMTnHwpxV93AUbG0Q
	s1kr0lEkX5duA/99dMizA1YMWM=; b=DDPsMdCdCeKvRHCmt4UU8ucc4+nqP497z
	bT0Dyhi5Nrw8EsSDIYJJnamAfAINpj2eZP1LhX2s06rVXJMeRsJjrcZ51PjaJYdX
	/9bmyfYP2Yilgyis9CSaJIf5StEoCdPvx9Uz1/BPabNBn8w7QrWSffCSGv6hMWaU
	ooyPOxEUN0a97677RLB0u8pIQbI7zHaYXQmS/z8zpuRVma5uEiKpOC8fouYnksiq
	XwEo3CszGZmCFPlr5abCIkHF7VoFxN/YcySJtFLHJhxa9eVF5g8kS6pUEQg0eOwY
	cvexzDYLsOvzkyXRETUhqqbvCYASE+/bOLjPWnQlt4kqrMU1FjlMA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vramf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:33:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57LB338N024219;
	Thu, 21 Aug 2025 11:33:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my43r27u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 11:33:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LBXgsu34341180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 11:33:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 318392004B;
	Thu, 21 Aug 2025 11:33:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6BE020040;
	Thu, 21 Aug 2025 11:33:41 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 11:33:41 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 1/5] s390/bpf: Add s390 JIT support for timed may_goto
Date: Thu, 21 Aug 2025 13:25:55 +0200
Message-ID: <20250821113339.292434-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821113339.292434-1-iii@linux.ibm.com>
References: <20250821113339.292434-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CH7irwSLKVeA-ur3t6XqSLBcUnRst7Jb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX2I+aGTueDMmR
 K4stq38oRX3X8i1artzWJRgYNhEPbiBc1UBkPecsACFbhcafIsIoP++y87cbDf0R32V24DjuVAK
 ZXD0lg2m3j9Yx4LOYj/xyfJFLHQ1pqJFGcitS4VNxdqTzxRIH289YYyHTVniywjfTSYYKF8qkDh
 f6lbCptCTT/uR/lBuBRQ+8Apg8Kr538v1ZHKJxUrDElIrCk0qaP98xie6BXGJV+1T5F+Nuhx0Ar
 d01VsEJvPwk2fUe8NBpFs3FcFtY0toEDRlbBwJw4bCSKuxcfmWSPqnvO/q69Wc/9KwCeDSHM+8I
 iFsv3YLtFnT96lzXpqwJ0W87/YwsfFeil5zMOro3tEYideMMg3FXpyt7cTV18yH3LFcbgyzkt7h
 op/RlFfhouVjl0DxvNymukzw8I9Jcw==
X-Proofpoint-GUID: CH7irwSLKVeA-ur3t6XqSLBcUnRst7Jb
X-Authority-Analysis: v=2.4 cv=KPwDzFFo c=1 sm=1 tr=0 ts=68a7041b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=HY55ynAoVbFXyHn9r_EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

The verifier provides an architecture-independent implementation of the
may_goto instruction, which is currently used on s390x, but it has a
downside: there is no way to prevent progs using it from running for a
very long time.

The solution to this problem is an alternative timed implementation,
which requires architecture-specific bits. Its availability is signaled
to the verifier by bpf_jit_supports_timed_may_goto() returning true.

The verifier then emits a call to arch_bpf_timed_may_goto() using a
non-standard calling convention. This function must act as a trampoline
for bpf_check_timed_may_goto().

Implement bpf_jit_supports_timed_may_goto(), account for the special
calling convention in the BPF_CALL implementation, and implement
arch_bpf_timed_may_goto().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/Makefile             |  2 +-
 arch/s390/net/bpf_jit_comp.c       | 25 ++++++++++++++---
 arch/s390/net/bpf_timed_may_goto.S | 45 ++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 5 deletions(-)
 create mode 100644 arch/s390/net/bpf_timed_may_goto.S

diff --git a/arch/s390/net/Makefile b/arch/s390/net/Makefile
index 8cab6deb0403..9275cf63192a 100644
--- a/arch/s390/net/Makefile
+++ b/arch/s390/net/Makefile
@@ -2,5 +2,5 @@
 #
 # Arch-specific network modules
 #
-obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o
+obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_timed_may_goto.o
 obj-$(CONFIG_HAVE_PNETID) += pnet.o
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index fd45f03a213c..8b57d8532f36 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1806,10 +1806,22 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			}
 		}
 
-		/* brasl %r14,func */
-		EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, (void *)func);
-		/* lgr %b0,%r2: load return value into %b0 */
-		EMIT4(0xb9040000, BPF_REG_0, REG_2);
+		if ((void *)func == arch_bpf_timed_may_goto) {
+			/*
+			 * arch_bpf_timed_may_goto() has a special ABI: the
+			 * parameters are in BPF_REG_AX and BPF_REG_10; the
+			 * return value is in BPF_REG_AX; and all GPRs except
+			 * REG_W0, REG_W1, and BPF_REG_AX are callee-saved.
+			 */
+
+			/* brasl %r0,func */
+			EMIT6_PCREL_RILB_PTR(0xc0050000, REG_0, (void *)func);
+		} else {
+			/* brasl %r14,func */
+			EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, (void *)func);
+			/* lgr %b0,%r2: load return value into %b0 */
+			EMIT4(0xb9040000, BPF_REG_0, REG_2);
+		}
 
 		/*
 		 * Copy the potentially updated tail call counter back.
@@ -2993,3 +3005,8 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *, u64, u64, u64),
 		prev_addr = addr;
 	}
 }
+
+bool bpf_jit_supports_timed_may_goto(void)
+{
+	return true;
+}
diff --git a/arch/s390/net/bpf_timed_may_goto.S b/arch/s390/net/bpf_timed_may_goto.S
new file mode 100644
index 000000000000..06f567a460d7
--- /dev/null
+++ b/arch/s390/net/bpf_timed_may_goto.S
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/export.h>
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/nospec-insn.h>
+
+#define R2_OFF 0
+#define R5_OFF (R2_OFF + (5 - 2 + 1) * 8)
+#define R14_OFF (R5_OFF + 8)
+#define RETADDR_OFF (R14_OFF + 8)
+#define R15_OFF (RETADDR_OFF + 8)
+#define BACKCHAIN_OFF (R15_OFF + 8)
+#define FRAME_SIZE (BACKCHAIN_OFF + 8)
+#define FRAME_OFF (STACK_FRAME_OVERHEAD - FRAME_SIZE)
+#if (FRAME_OFF + BACKCHAIN_OFF) != __SF_BACKCHAIN
+#error Stack frame layout calculation is broken
+#endif
+
+	GEN_BR_THUNK %r1
+
+SYM_FUNC_START(arch_bpf_timed_may_goto)
+	/*
+	 * This function has a special ABI: the parameters are in %r12 and
+	 * %r13; the return value is in %r12; all GPRs except %r0, %r1, and
+	 * %r12 are callee-saved; and the return address is in %r0.
+	 */
+	stmg %r2,%r5,FRAME_OFF+R2_OFF(%r15)
+	stg %r14,FRAME_OFF+R14_OFF(%r15)
+	stg %r0,FRAME_OFF+RETADDR_OFF(%r15)
+	stg %r15,FRAME_OFF+R15_OFF(%r15)
+	lgr %r1,%r15
+	lay %r15,-FRAME_SIZE(%r15)
+	stg %r1,__SF_BACKCHAIN(%r15)
+
+	lay %r2,0(%r12,%r13)
+	brasl %r14,bpf_check_timed_may_goto
+	lgr %r12,%r2
+
+	lg %r15,FRAME_SIZE+FRAME_OFF+R15_OFF(%r15)
+	lmg %r2,%r5,FRAME_OFF+R2_OFF(%r15)
+	lg %r14,FRAME_OFF+R14_OFF(%r15)
+	lg %r1,FRAME_OFF+RETADDR_OFF(%r15)
+	BR_EX %r1
+SYM_FUNC_END(arch_bpf_timed_may_goto)
-- 
2.50.1


