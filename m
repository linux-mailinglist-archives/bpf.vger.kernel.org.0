Return-Path: <bpf+bounces-61370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04907AE649E
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 14:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B6B189BD32
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 12:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499D4298CB5;
	Tue, 24 Jun 2025 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EvsGu3OV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9B2989BA
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767324; cv=none; b=MyjHILmPhZkjvkccW4PmGQpM5O0sqaT2WD99YBZAXMtb+N+Wx7ZTNc1OCCpLYptwzLC+fJ0SZz8Url4XRSLtoOPqX+QROPUTif1c9ywoMRIQfNeXqqk07U4lJ+ET2SBf1CxD3Np7VrSJO/a6UQeTkc+o0DSbsN1Is9UFvxstzfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767324; c=relaxed/simple;
	bh=leAmUHl7YaaJCWFGKmnChq2n1rHvLvL09ZVT1WBBF2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iB5Om/WzHRSOzX4Y/N3lmpxTj1PQjGC8EuV7SfUgVbVocE1VVOHSiR7yB4rGJojvDTlP7iFImpt98jFl9Gf/sVYTmSv1lzoAEI3aoqsdLu4bffiPlfIZf99Dp0nxTntJO9WhI5Tfc9fLeHuH5hZQ3huG2i7Dv3lk08daz/Ru6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EvsGu3OV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O9VhsX018896;
	Tue, 24 Jun 2025 12:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DeHwxNBZf98Yf3Yml
	EyPWPHrcfpCawTX51byvRb6aUc=; b=EvsGu3OV/X/8VpBqRiP889dpr1cTxmlzR
	h4VhrP33ef6b4bo+f7aOHJYzfblAS2/aoV3YVUR+r3RY8fLobSTIHlSUAdHmeP3D
	ySnkhyxWJ1kyL1pvhT009e13PYQZ8Z9nyc2/hKIEmGd+OyN0LXeUEO0GhE8D3MYe
	ORzYbVRRKPvzx3kx/WJzkuvpNw8QBBwkHc4G7xZ+UVLgANWiwNuF2Fv/NuNVqJM0
	CCqWgA2MBwN3yNfsBFxDv/3uLsuyjUB3Qr+7LgWLFUdlwzMEWRGpU9n0NZPFKj7/
	j3eeIXO4mcOPxOAS1sFxHYnsShfzPTyrpM9DFuj5FjwRSzxLdZ10w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme18e1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 12:15:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55OAxYON002908;
	Tue, 24 Jun 2025 12:15:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jm3rnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 12:15:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55OCF48D30474534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 12:15:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B7C320049;
	Tue, 24 Jun 2025 12:15:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0C0B20040;
	Tue, 24 Jun 2025 12:15:03 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.5.146])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Jun 2025 12:15:03 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 2/2] s390/bpf: Describe the frame using a struct instead of constants
Date: Tue, 24 Jun 2025 14:04:28 +0200
Message-ID: <20250624121501.50536-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624121501.50536-1-iii@linux.ibm.com>
References: <20250624121501.50536-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=685a96cd cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=04KB4t3DcwN-hSm8:21 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=3Mzdi6lvbL40coBWrpEA:9
X-Proofpoint-GUID: nehwJPXfjqn8h_izujR34F2kpYIkXJe_
X-Proofpoint-ORIG-GUID: nehwJPXfjqn8h_izujR34F2kpYIkXJe_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA5OSBTYWx0ZWRfX+AoTvyZ5rAAb tGORDmi8fU7PyG2AFedyTwVs8bRgpptyBaeDcQzaPP1960za4/69Tm82JLWLHsBUKVimtip5Nhe zY+ZdZs1YTlUNQPPtFwT1DcQObqw8F/Q/R8yLsiEAUjbwTm8bhbpefHsyMHlpGPTaiLl4flKamq
 nu9rb9JmMId8zLYdRVk+kwSFplf1X99q4AK2Qfj5ECcvFtliHwvaPgWcS9MPHRR14eGoA+0UINc hMGBx3YM+GgKTMuiF+17mtNIrrspc/as4wvNVEnABedpT1Bev94JSbAHPJbRc/P53ChY0mZnRED gMc7GSnKyKypZzRxqxu2kB9IJogeWj+IcpNj4Jw2bwk1RGWYefRO0MxxgdKwvvsXf5LltWWeVkL
 slWDs9YNtU0mM49B7MzZ969R1ZnMgTKC1SLtP9JxyuAqcMpCutw77QReSvg35KmF5nF1365s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240099

Currently the caller-allocated portion of the stack frame is described
using constants, hardcoded values, and an ASCII drawing, making it
harder than necessary to ensure that everything is in sync.

Declare a struct and use offsetof() and offsetofend() macros to refer
to various values stored within the frame.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit.h      | 55 ----------------------------
 arch/s390/net/bpf_jit_comp.c | 69 ++++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 77 deletions(-)
 delete mode 100644 arch/s390/net/bpf_jit.h

diff --git a/arch/s390/net/bpf_jit.h b/arch/s390/net/bpf_jit.h
deleted file mode 100644
index 7822ea92e54a..000000000000
--- a/arch/s390/net/bpf_jit.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * BPF Jit compiler defines
- *
- * Copyright IBM Corp. 2012,2015
- *
- * Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
- *	      Michael Holzheu <holzheu@linux.vnet.ibm.com>
- */
-
-#ifndef __ARCH_S390_NET_BPF_JIT_H
-#define __ARCH_S390_NET_BPF_JIT_H
-
-#ifndef __ASSEMBLY__
-
-#include <linux/filter.h>
-#include <linux/types.h>
-
-#endif /* __ASSEMBLY__ */
-
-/*
- * Stackframe layout (packed stack):
- *
- *				    ^ high
- *	      +---------------+     |
- *	      | old backchain |     |
- *	      +---------------+     |
- *	      |   r15 - r6    |     |
- *	      +---------------+     |
- *	      | 4 byte align  |     |
- *	      | tail_call_cnt |     |
- * BFP	   -> +===============+     |
- *	      |		      |     |
- *	      |   BPF stack   |     |
- *	      |		      |     |
- * R15+160 -> +---------------+     |
- *	      | new backchain |     |
- * R15+152 -> +---------------+     |
- *	      | + 152 byte SA |     |
- * R15	   -> +---------------+     + low
- *
- * We get 160 bytes stack space from calling function, but only use
- * 12 * 8 byte for old backchain, r15..r6, and tail_call_cnt.
- *
- * The stack size used by the BPF program ("BPF stack" above) is passed
- * via "aux->stack_depth".
- */
-#define STK_SPACE_ADD	(160)
-#define STK_160_UNUSED	(160 - 12 * 8)
-#define STK_OFF		(STK_SPACE_ADD - STK_160_UNUSED)
-
-#define STK_OFF_R6	(160 - 11 * 8)	/* Offset of r6 on stack */
-#define STK_OFF_TCCNT	(160 - 12 * 8)	/* Offset of tail_call_cnt on stack */
-
-#endif /* __ARCH_S390_NET_BPF_JIT_H */
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 76ad52a24444..8bb738f1b1b6 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -32,7 +32,6 @@
 #include <asm/set_memory.h>
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
-#include "bpf_jit.h"
 
 struct bpf_jit {
 	u32 seen;		/* Flags to remember seen eBPF instructions */
@@ -54,7 +53,7 @@ struct bpf_jit {
 	int prologue_plt;	/* Start of prologue hotpatch PLT */
 	int kern_arena;		/* Pool offset of kernel arena address */
 	u64 user_arena;		/* User arena address */
-	u32 frame_off;		/* Offset of frame from %r15 */
+	u32 frame_off;		/* Offset of struct bpf_prog from %r15 */
 };
 
 #define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
@@ -426,12 +425,26 @@ static void jit_fill_hole(void *area, unsigned int size)
 	memset(area, 0, size);
 }
 
+/*
+ * Caller-allocated part of the frame.
+ * Thanks to packed stack, its otherwise unused initial part can be used for
+ * the BPF stack and for the next frame.
+ */
+struct prog_frame {
+	u64 unused[8];
+	/* BPF stack starts here and grows towards 0 */
+	u32 tail_call_cnt;
+	u32 pad;
+	u64 r6[10];  /* r6 - r15 */
+	u64 backchain;
+} __packed;
+
 /*
  * Save registers from "rs" (register start) to "re" (register end) on stack
  */
 static void save_regs(struct bpf_jit *jit, u32 rs, u32 re)
 {
-	u32 off = STK_OFF_R6 + (rs - 6) * 8;
+	u32 off = offsetof(struct prog_frame, r6) + (rs - 6) * 8;
 
 	if (rs == re)
 		/* stg %rs,off(%r15) */
@@ -446,7 +459,7 @@ static void save_regs(struct bpf_jit *jit, u32 rs, u32 re)
  */
 static void restore_regs(struct bpf_jit *jit, u32 rs, u32 re)
 {
-	u32 off = jit->frame_off + STK_OFF_R6 + (rs - 6) * 8;
+	u32 off = jit->frame_off + offsetof(struct prog_frame, r6) + (rs - 6) * 8;
 
 	if (rs == re)
 		/* lg %rs,off(%r15) */
@@ -570,10 +583,12 @@ static void bpf_jit_plt(struct bpf_plt *plt, void *ret, void *target)
  * Emit function prologue
  *
  * Save registers and create stack frame if necessary.
- * See stack frame layout description in "bpf_jit.h"!
+ * Stack frame layout is described by struct prog_frame.
  */
 static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp)
 {
+	BUILD_BUG_ON(sizeof(struct prog_frame) != STACK_FRAME_OVERHEAD);
+
 	/* No-op for hotpatching */
 	/* brcl 0,prologue_plt */
 	EMIT6_PCREL_RILC(0xc0040000, 0, jit->prologue_plt);
@@ -581,8 +596,9 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp)
 
 	if (!bpf_is_subprog(fp)) {
 		/* Initialize the tail call counter in the main program. */
-		/* xc STK_OFF_TCCNT(4,%r15),STK_OFF_TCCNT(%r15) */
-		_EMIT6(0xd703f000 | STK_OFF_TCCNT, 0xf000 | STK_OFF_TCCNT);
+		/* xc tail_call_cnt(4,%r15),tail_call_cnt(%r15) */
+		_EMIT6(0xd703f000 | offsetof(struct prog_frame, tail_call_cnt),
+		       0xf000 | offsetof(struct prog_frame, tail_call_cnt));
 	} else {
 		/*
 		 * Skip the tail call counter initialization in subprograms.
@@ -625,13 +641,15 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp)
 	if (is_first_pass(jit) || (jit->seen & SEEN_STACK)) {
 		/* lgr %w1,%r15 (backchain) */
 		EMIT4(0xb9040000, REG_W1, REG_15);
-		/* la %bfp,STK_160_UNUSED(%r15) (BPF frame pointer) */
-		EMIT4_DISP(0x41000000, BPF_REG_FP, REG_15, STK_160_UNUSED);
+		/* la %bfp,unused_end(%r15) (BPF frame pointer) */
+		EMIT4_DISP(0x41000000, BPF_REG_FP, REG_15,
+			   offsetofend(struct prog_frame, unused));
 		/* aghi %r15,-frame_off */
 		EMIT4_IMM(0xa70b0000, REG_15, -jit->frame_off);
-		/* stg %w1,152(%r15) (backchain) */
+		/* stg %w1,backchain(%r15) */
 		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W1, REG_0,
-			      REG_15, 152);
+			      REG_15,
+			      offsetof(struct prog_frame, backchain));
 	}
 }
 
@@ -1774,9 +1792,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		 * Note 2: We assume that the verifier does not let us call the
 		 * main program, which clears the tail call counter on entry.
 		 */
-		/* mvc STK_OFF_TCCNT(4,%r15),frame_off+STK_OFF_TCCNT(%r15) */
-		_EMIT6(0xd203f000 | STK_OFF_TCCNT,
-		       0xf000 | (jit->frame_off + STK_OFF_TCCNT));
+		/* mvc tail_call_cnt(4,%r15),frame_off+tail_call_cnt(%r15) */
+		_EMIT6(0xd203f000 | offsetof(struct prog_frame, tail_call_cnt),
+		       0xf000 | (jit->frame_off +
+				 offsetof(struct prog_frame, tail_call_cnt)));
 
 		/* Sign-extend the kfunc arguments. */
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
@@ -1827,7 +1846,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		 *         goto out;
 		 */
 
-		off = jit->frame_off + STK_OFF_TCCNT;
+		off = jit->frame_off +
+		      offsetof(struct prog_frame, tail_call_cnt);
 		/* lhi %w0,1 */
 		EMIT4_IMM(0xa7080000, REG_W0, 1);
 		/* laal %w1,%w0,off(%r15) */
@@ -2160,7 +2180,9 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	jit->prg = 0;
 	jit->excnt = 0;
 	if (is_first_pass(jit) || (jit->seen & SEEN_STACK))
-		jit->frame_off = STK_OFF + round_up(fp->aux->stack_depth, 8);
+		jit->frame_off = sizeof(struct prog_frame) -
+				 offsetofend(struct prog_frame, unused) +
+				 round_up(fp->aux->stack_depth, 8);
 	else
 		jit->frame_off = 0;
 
@@ -2642,9 +2664,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	/* stg %r1,backchain_off(%r15) */
 	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_1, REG_0, REG_15,
 		      tjit->backchain_off);
-	/* mvc tccnt_off(4,%r15),stack_size+STK_OFF_TCCNT(%r15) */
+	/* mvc tccnt_off(4,%r15),stack_size+tail_call_cnt(%r15) */
 	_EMIT6(0xd203f000 | tjit->tccnt_off,
-	       0xf000 | (tjit->stack_size + STK_OFF_TCCNT));
+	       0xf000 | (tjit->stack_size +
+			 offsetof(struct prog_frame, tail_call_cnt)));
 	/* stmg %r2,%rN,fwd_reg_args_off(%r15) */
 	if (nr_reg_args)
 		EMIT6_DISP_LH(0xeb000000, 0x0024, REG_2,
@@ -2781,8 +2804,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 				       (nr_stack_args * sizeof(u64) - 1) << 16 |
 				       tjit->stack_args_off,
 			       0xf000 | tjit->orig_stack_args_off);
-		/* mvc STK_OFF_TCCNT(4,%r15),tccnt_off(%r15) */
-		_EMIT6(0xd203f000 | STK_OFF_TCCNT, 0xf000 | tjit->tccnt_off);
+		/* mvc tail_call_cnt(4,%r15),tccnt_off(%r15) */
+		_EMIT6(0xd203f000 | offsetof(struct prog_frame, tail_call_cnt),
+		       0xf000 | tjit->tccnt_off);
 		/* lgr %r1,%r8 */
 		EMIT4(0xb9040000, REG_1, REG_8);
 		/* %r1() */
@@ -2839,8 +2863,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET))
 		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_2, REG_0, REG_15,
 			      tjit->retval_off);
-	/* mvc stack_size+STK_OFF_TCCNT(4,%r15),tccnt_off(%r15) */
-	_EMIT6(0xd203f000 | (tjit->stack_size + STK_OFF_TCCNT),
+	/* mvc stack_size+tail_call_cnt(4,%r15),tccnt_off(%r15) */
+	_EMIT6(0xd203f000 | (tjit->stack_size +
+			     offsetof(struct prog_frame, tail_call_cnt)),
 	       0xf000 | tjit->tccnt_off);
 	/* aghi %r15,stack_size */
 	EMIT4_IMM(0xa70b0000, REG_15, tjit->stack_size);
-- 
2.49.0


