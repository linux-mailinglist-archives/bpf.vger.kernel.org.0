Return-Path: <bpf+bounces-65991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B112B2BECE
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 12:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88EC3A845A
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 10:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D85427A12D;
	Tue, 19 Aug 2025 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fcGUZcH0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C23451D2
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598903; cv=none; b=OA+l3/6YvcPCIaHNsg0her1z+m8Q+vKP8QBM8iP8A01yZT+lJcTXSyaVt4S9neNwy2vEUKt74C7t9FJR+M7l4uvirEQFaoXSG/JBrIGGnMMbaa1dAM5E/XQ0BywKVvystnOfZHJ1KQfIhyz7Xc4NwpAtsHlZqAHdPrKuF3NH2WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598903; c=relaxed/simple;
	bh=+XIzvrs3z4AXeKprIppqq4htRFogVWmxCyOWL0S18GU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GveOkwBJTkvCRcUcre8e73Q5N/2/Ph1HMbPbMs8zLNff1dxgU23+dXOl379259mtA3qIL1LA/RfHcHLjCcI9ak+rKYmqCcLckdBPm/ms0/Tp1n2iG4iYzZO1/G/TOCtsBx2Tetvi3FxEFWoHcJb+w9Ld5Wv1DPdtXtBQ/rPuLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fcGUZcH0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J5wXId000445;
	Tue, 19 Aug 2025 10:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=z43nx6LMJTEV/X43UGqjFsYaoLYq/f2eUPTPj0t6f
	oE=; b=fcGUZcH040e8OXhUGQXMkc/jCVqRrkXGZbtumqBHsvfZ6p+PJJxkZVj3C
	gmeiyGlZaYHIWiAX20Mc8WHvK/5rUK+wtxFjclCc1HtesUWULnsM44YVXRH+TcD0
	DP4I8/DL4x+zRWcl0KiABC10a26dp32asCw+pul8/r9xaVLLRQt8SSGtF2ActCMV
	7aQrS+eTHmC0/sYvITv31zuNW6MKovQ9PYCBP2lY825+Ofr4e/F4ze5dX51rDijr
	WFUvHDfNKmzzg3vvJDX6jEhk/YPj8BGwURRZyN4ZD9WQxZprQ6Dk8/ymes8tRChI
	UuAccNv8tRl635T0edfy8JcmGlAAA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhq9x71m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 10:21:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J6Haw8003162;
	Tue, 19 Aug 2025 10:21:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k6hm9jr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 10:21:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57JALMET55706030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 10:21:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3A332004F;
	Tue, 19 Aug 2025 10:21:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 298362004E;
	Tue, 19 Aug 2025 10:21:22 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.153.114])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Aug 2025 10:21:22 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2] s390/bpf: Use direct calls and jumps where possible
Date: Tue, 19 Aug 2025 12:20:38 +0200
Message-ID: <20250819102116.252203-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N50pF39B c=1 sm=1 tr=0 ts=68a45027 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=jrmw4pjQCh8f7Ix4FgQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX0FVrb7wZCWLg
 79SrbnIK5g1uiJBNrJE/Q4ikD1SMjfaKrfOEa7qH21a9R5yIsRyUR0nEM66zg9qnqjqnNvSnk6F
 rMBmcSDR5/a3DEMIz2FB/+DQah2XW/PPtxxmfC0UXJcdiBfr71sOUjOBdpRexj8+sxGsMrLEWwx
 xZsT9skAbj9Q02LJuVLEndEQlqXHQDqqxx8NEbVBKIOWG8lXd0bNSBe7NenIPnPeL67cyqhfJHv
 Y+wuq07b8uwbRig7ye18QvgYUr2KvbObvAE0yHYVGyyse+EZKeirFMOkxXE+Qf48S9CnIdoeB7q
 xRfycNDwCU/P4GdZg6Dmn9R8pEOeKsFz8aIjaz/EAGZ9TpdTJ/7kW16rrkKAgzU8YMFatZ6l7U3
 9kUEu2T8
X-Proofpoint-GUID: GE2KjYoV4w2zRrPbsiTBxBRwEz6zTJzQ
X-Proofpoint-ORIG-GUID: GE2KjYoV4w2zRrPbsiTBxBRwEz6zTJzQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027

After the V!=R rework (commit c98d2ecae08f ("s390/mm: Uncouple physical
vs virtual address spaces")), all kernel code and related data are
allocated within a 4G region, making it possible to use relative
addressing in BPF code more extensively.

Convert as many indirect calls and jumps to direct calls as possible,
namely:

* BPF_CALL
* __bpf_tramp_enter()
* __bpf_tramp_exit()
* __bpf_prog_enter()
* __bpf_prog_exit()
* fentry
* fmod_ret
* fexit
* BPF_TRAMP_F_CALL_ORIG without BPF_TRAMP_F_ORIG_STACK
* Trampoline returns without BPF_TRAMP_F_SKIP_FRAME and
  BPF_TRAMP_F_ORIG_STACK

The following indirect calls and jumps remain:

* Prog returns
* Trampoline returns with BPF_TRAMP_F_SKIP_FRAME or
  BPF_TRAMP_F_ORIG_STACK
* BPF_TAIL_CALL
* BPF_TRAMP_F_CALL_ORIG with BPF_TRAMP_F_ORIG_STACK

As a result, only one usage of call_r1() remains, so inline it.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1: https://lore.kernel.org/bpf/20250814124314.185516-1-iii@linux.ibm.com/
v1 -> v2: Rebased.

 arch/s390/net/bpf_jit_comp.c | 80 +++++++++++++++---------------------
 1 file changed, 32 insertions(+), 48 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index b2b8eb62b82e..fd45f03a213c 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -674,20 +674,6 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp)
 		_EMIT2(0x07f0 | reg);					\
 } while (0)
 
-/*
- * Call r1 either directly or via __s390_indirect_jump_r1 thunk
- */
-static void call_r1(struct bpf_jit *jit)
-{
-	if (nospec_uses_trampoline())
-		/* brasl %r14,__s390_indirect_jump_r1 */
-		EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14,
-				     __s390_indirect_jump_r1);
-	else
-		/* basr %r14,%r1 */
-		EMIT2(0x0d00, REG_14, REG_1);
-}
-
 /*
  * Function epilogue
  */
@@ -1820,10 +1806,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			}
 		}
 
-		/* lgrl %w1,func */
-		EMIT6_PCREL_RILB(0xc4080000, REG_W1, _EMIT_CONST_U64(func));
-		/* %r1() */
-		call_r1(jit);
+		/* brasl %r14,func */
+		EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, (void *)func);
 		/* lgr %b0,%r2: load return value into %b0 */
 		EMIT4(0xb9040000, BPF_REG_0, REG_2);
 
@@ -2534,14 +2518,12 @@ static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 	 *         goto skip;
 	 */
 
-	/* %r1 = __bpf_prog_enter */
-	load_imm64(jit, REG_1, (u64)bpf_trampoline_enter(p));
 	/* %r2 = p */
 	load_imm64(jit, REG_2, (u64)p);
 	/* la %r3,run_ctx_off(%r15) */
 	EMIT4_DISP(0x41000000, REG_3, REG_15, tjit->run_ctx_off);
-	/* %r1() */
-	call_r1(jit);
+	/* brasl %r14,__bpf_prog_enter */
+	EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, bpf_trampoline_enter(p));
 	/* ltgr %r7,%r2 */
 	EMIT4(0xb9020000, REG_7, REG_2);
 	/* brcl 8,skip */
@@ -2552,15 +2534,13 @@ static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 	 * retval = bpf_func(args, p->insnsi);
 	 */
 
-	/* %r1 = p->bpf_func */
-	load_imm64(jit, REG_1, (u64)p->bpf_func);
 	/* la %r2,bpf_args_off(%r15) */
 	EMIT4_DISP(0x41000000, REG_2, REG_15, tjit->bpf_args_off);
 	/* %r3 = p->insnsi */
 	if (!p->jited)
 		load_imm64(jit, REG_3, (u64)p->insnsi);
-	/* %r1() */
-	call_r1(jit);
+	/* brasl %r14,p->bpf_func */
+	EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, p->bpf_func);
 	/* stg %r2,retval_off(%r15) */
 	if (save_ret) {
 		if (sign_extend(jit, REG_2, m->ret_size, m->ret_flags))
@@ -2577,16 +2557,14 @@ static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 	 * __bpf_prog_exit(p, start, &run_ctx);
 	 */
 
-	/* %r1 = __bpf_prog_exit */
-	load_imm64(jit, REG_1, (u64)bpf_trampoline_exit(p));
 	/* %r2 = p */
 	load_imm64(jit, REG_2, (u64)p);
 	/* lgr %r3,%r7 */
 	EMIT4(0xb9040000, REG_3, REG_7);
 	/* la %r4,run_ctx_off(%r15) */
 	EMIT4_DISP(0x41000000, REG_4, REG_15, tjit->run_ctx_off);
-	/* %r1() */
-	call_r1(jit);
+	/* brasl %r14,__bpf_prog_exit */
+	EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, bpf_trampoline_exit(p));
 
 	return 0;
 }
@@ -2746,9 +2724,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 		/* lgr %r8,%r0 */
 		EMIT4(0xb9040000, REG_8, REG_0);
-	} else {
-		/* %r8 = func_addr + S390X_PATCH_SIZE */
-		load_imm64(jit, REG_8, (u64)func_addr + S390X_PATCH_SIZE);
 	}
 
 	/*
@@ -2774,12 +2749,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		 * __bpf_tramp_enter(im);
 		 */
 
-		/* %r1 = __bpf_tramp_enter */
-		load_imm64(jit, REG_1, (u64)__bpf_tramp_enter);
 		/* %r2 = im */
 		load_imm64(jit, REG_2, (u64)im);
-		/* %r1() */
-		call_r1(jit);
+		/* brasl %r14,__bpf_tramp_enter */
+		EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, __bpf_tramp_enter);
 	}
 
 	for (i = 0; i < fentry->nr_links; i++)
@@ -2832,10 +2805,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		/* mvc tail_call_cnt(4,%r15),tccnt_off(%r15) */
 		_EMIT6(0xd203f000 | offsetof(struct prog_frame, tail_call_cnt),
 		       0xf000 | tjit->tccnt_off);
-		/* lgr %r1,%r8 */
-		EMIT4(0xb9040000, REG_1, REG_8);
-		/* %r1() */
-		call_r1(jit);
+		if (flags & BPF_TRAMP_F_ORIG_STACK) {
+			if (nospec_uses_trampoline())
+				/* brasl %r14,__s390_indirect_jump_r8 */
+				EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14,
+						     __s390_indirect_jump_r8);
+			else
+				/* basr %r14,%r8 */
+				EMIT2(0x0d00, REG_14, REG_8);
+		} else {
+			/* brasl %r14,func_addr+S390X_PATCH_SIZE */
+			EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14,
+					     func_addr + S390X_PATCH_SIZE);
+		}
 		/* stg %r2,retval_off(%r15) */
 		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_2, REG_0, REG_15,
 			      tjit->retval_off);
@@ -2866,12 +2848,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		 * __bpf_tramp_exit(im);
 		 */
 
-		/* %r1 = __bpf_tramp_exit */
-		load_imm64(jit, REG_1, (u64)__bpf_tramp_exit);
 		/* %r2 = im */
 		load_imm64(jit, REG_2, (u64)im);
-		/* %r1() */
-		call_r1(jit);
+		/* brasl %r14,__bpf_tramp_exit */
+		EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, __bpf_tramp_exit);
 	}
 
 	/* lmg %r2,%rN,reg_args_off(%r15) */
@@ -2880,7 +2860,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 			      REG_2 + (nr_reg_args - 1), REG_15,
 			      tjit->reg_args_off);
 	/* lgr %r1,%r8 */
-	if (!(flags & BPF_TRAMP_F_SKIP_FRAME))
+	if (!(flags & BPF_TRAMP_F_SKIP_FRAME) &&
+	    (flags & BPF_TRAMP_F_ORIG_STACK))
 		EMIT4(0xb9040000, REG_1, REG_8);
 	/* lmg %r7,%r8,r7_r8_off(%r15) */
 	EMIT6_DISP_LH(0xeb000000, 0x0004, REG_7, REG_8, REG_15,
@@ -2899,9 +2880,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	EMIT4_IMM(0xa70b0000, REG_15, tjit->stack_size);
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
 		EMIT_JUMP_REG(14);
-	else
+	else if (flags & BPF_TRAMP_F_ORIG_STACK)
 		EMIT_JUMP_REG(1);
-
+	else
+		/* brcl 0xf,func_addr+S390X_PATCH_SIZE */
+		EMIT6_PCREL_RILC_PTR(0xc0040000, 0xf,
+				     func_addr + S390X_PATCH_SIZE);
 	return 0;
 }
 
-- 
2.50.1


