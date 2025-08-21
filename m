Return-Path: <bpf+bounces-66182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CFEB2F563
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724AE584C84
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348CB305060;
	Thu, 21 Aug 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a3XNRWVO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183542FAC0E
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772401; cv=none; b=RhxCLM/T/UY5/mWKyfQNFLd2SevrK4M7/2irPFahvht1277IcM+K6SEKlEkkFuyO6S4ZkBwMGlSkGcl4RnUGidrcUGH9lJLlE88kc8BuqqGAVFgGmiqiVPLKWNjG18O/VVz3Nx+pteo7B/7ZrzXukB8E0+3cEy/PNzhB+RP8NZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772401; c=relaxed/simple;
	bh=IbRllNalbIR18N/Ppz1MwdGO1bLLa61BKUNIphaVaPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBf9w/plsShKIvgFIJ/Pkj/iCm7PGbbnSQQ+3FvE/lPEaZPWL2al9rpZe9cllyWUDyC6HzOOdZ8srjSTbK1GHTEe3q4CuSNGLA4hLqYrY5eQlgPVvsKokPIzeDnw1e6buHJKG2wHmBlKim370Z3AwxgxyNIrtXBFaG/L1B+L6A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a3XNRWVO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L8CWfp002071;
	Thu, 21 Aug 2025 10:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TMTnHwpxV93AUbG0Q
	s1kr0lEkX5duA/99dMizA1YMWM=; b=a3XNRWVOwkoxMJlPDs7lwm7+6W66OC0jd
	U92mqNWpa0iLEGCvMBqqzM9zseqwnw2jcLHcM6jJ2hbmMi86utvtv3si6n2Hiqin
	D/i4qJ/Zpvc1EtUgCsVe5DvmodBPvVof3KqlYPn1FX9Ty5cm1b3YarS9MJrht5/6
	gUYUozRLmCxK1liUuCKmA3KUmVD7Vfq7nmWuZeEWV8407ih2ZsjyQ6Tt6ipAFtk1
	FW1HZqGYF6lJukbCx9K2Kvf3SJOZWJGM5wVVkHFHtjO5dOUB1dtLOgPO3tme6GCD
	HGraMrp129Oq9moMeD7roB0Cmt1erEiX1yXDOMsVW0Og4+7DIxvNg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w7xub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:33:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6n7iM032003;
	Thu, 21 Aug 2025 10:33:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5y7v71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 10:33:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LAWxwS43844078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:33:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC4C120049;
	Thu, 21 Aug 2025 10:32:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FE3920040;
	Thu, 21 Aug 2025 10:32:59 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.21.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 10:32:59 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/5] s390/bpf: Add s390 JIT support for timed may_goto
Date: Thu, 21 Aug 2025 12:23:37 +0200
Message-ID: <20250821103256.291412-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821103256.291412-1-iii@linux.ibm.com>
References: <20250821103256.291412-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXwrACYDZgObmW
 dUZBLEkpfy6GajJ3mJCFZvO5CVRy19HYD3GVd22g9riEJuAdx/r9tQb+Q+Dx7zDFNNKsMc8cXvk
 Zl1zkZkjiWt15pOZcVcHZ5FEeW9U2ARyehpS3IHJXxgADg3MausA7w7W0p2IkKYNOXxVVmjL4LT
 Yncy0svgLbJTv1hHvyFbSL4oLhqR1KOY8/zDEoQOhxI4qBSt+jUrqw9V1ggQvOPQOJzpA+yTx+R
 pDoB0NdSWy/K0+aD7QqS5fIAkBYUhk5gGJq/8UiD1N8uZ3odTzfNVZ80egwCLVdYnb8QsaFMe2Y
 +JF/jHrFdws++OV2VYtmUzBPQIkBz7wLaTvr9/VmO9hJjEKpMabQ5CJ1gOOSRDlVuNU8lnd/WdH
 6bwcOhwKsNX+05cyOXs8Ds0v4F+N+w==
X-Authority-Analysis: v=2.4 cv=H62CA+Yi c=1 sm=1 tr=0 ts=68a6f5e0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=HY55ynAoVbFXyHn9r_EA:9
X-Proofpoint-ORIG-GUID: OLKs1-nH0GelGhnDqy35dhIiQDHeUeJO
X-Proofpoint-GUID: OLKs1-nH0GelGhnDqy35dhIiQDHeUeJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

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


