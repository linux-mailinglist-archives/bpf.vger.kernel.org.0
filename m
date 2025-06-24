Return-Path: <bpf+bounces-61371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADE4AE648D
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 14:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1624B4A73E6
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 12:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0750F298CC0;
	Tue, 24 Jun 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QTaK8khD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E12882A9
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767325; cv=none; b=Pk4Knj07GniNcKtT7E3nrgmk63macEwgSl4n96zF0/rFBNeQZtKJ1Qz5wnKdq+DgHnSiXdinliA9A+T5LtFMCN0EoaHBkmUHvrPAwyi/1E5n4XSwxlRFJCAu5gtGvweoo4RcEXnG4kwiQkL23cGejJNo9RZCPJKR6pwXqjXjMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767325; c=relaxed/simple;
	bh=pPMD19xVzjOkpQGf2WRG9VFlUW1JsbgsWIUoJKGAZvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jum1tqQv0mOX+ZdTL5jTvHLR6jOyigRC4MB+7KIwz1LfxD50LfL/Qv6W9AK9zFEwuU6o1quXmBvnPBx42yy4WW3y9cH/EMtNwu1nAfc3e5Wkb+bnfiGhHd/ss4aBphwwK93E2LGnLGDcr1THejWOkkKta5XqYvLmn1nrpzUQh1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QTaK8khD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O7XdqT012599;
	Tue, 24 Jun 2025 12:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hEAdFyuHG9RuqDCpt
	NcDc1RfFL8ijniF+4hXUkJoJ50=; b=QTaK8khD9s8VHF8GjrzXOw+LaF8qWH5Bc
	dJIf5Kvvb+Qe8IY1jg2X1NC+m7WKowPBHNnuygefye6kkR2TSDoWdaJXwrEOx/tA
	f7hMW+zSr2LekFptUU9G9gOqN/zgkz9cOt7XfGl020dy6T8SJsCK94Qf+dsumBh/
	0YwPMxRaHCZa5bnWB/Y5maF3JI9dGOAYOzZQATNFNuouRoOtqZsroOddUSEFAsmw
	hCnv0XbN3OeMX3bcroZ8bpxYUEio1l0bKw9DChKkBZE0WSWDoAYMl1lUlXRkgCeN
	Lj+ouN0ZBzXVu1+WTxjtwwYZQbDd0VP0V0r4hdaXA31z8RDLm3gbg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf305e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 12:15:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55OBaSdc014710;
	Tue, 24 Jun 2025 12:15:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s2bhue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 12:15:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55OCF3Nb17367344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 12:15:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D83B520049;
	Tue, 24 Jun 2025 12:15:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A24820040;
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
Subject: [PATCH bpf-next 1/2] s390/bpf: Centralize frame offset calculations
Date: Tue, 24 Jun 2025 14:04:27 +0200
Message-ID: <20250624121501.50536-2-iii@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=685a96cc cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=C_EnXsFpZ2zRFtAUtMgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA5OSBTYWx0ZWRfX9vFVJTumfF3w 8u+Cw7mRy83dHIeGXeHgOXvPLn6xBAsbuwkojAc+nVhvIJKD8cVuWTJ/NPBtYiIxkrxKfJ6QoDx 4HK/8QYGNeM+41LrYznne2R35uyJXQG+APX7oB7d3rIMKoLdCo6dw1HWReYYVMWXdNznXbGoaUg
 hs1hZ9prng+2MXJlLCeN8GhffByA1xF3+CWi3P6aUITCE4Q0EVbhkWmMCVqh3EyRg0C/FEQHBFT r1HNof+Ri6F6aLLkDyNqTKv4y+HyIktPfeiCbhdVfkLPiRnpAGjhJk3PMH4QCKCETx5UB42v5JA id0l3ayES5Ia9JcfVQAL+6vtWHZx36DmgTJcXtY4kKGjq9iPgB4MdnISkkjT0ojRHN3xMjKanJt
 eJh4poP1qNMlZYTIOrRZ2MNGugDmULEAjMJfsapx/O7UE+QccQYPJON7TODZwPdyH7L/ReMk
X-Proofpoint-GUID: 1Ky9N1kSWMKAiP2Z53t1oa5aU-Rk0l2u
X-Proofpoint-ORIG-GUID: 1Ky9N1kSWMKAiP2Z53t1oa5aU-Rk0l2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240099

The calculation of the distance from %r15 to the caller-allocated
portion of the stack frame is copy-pasted into multiple places in the
JIT code.

Move it to bpf_jit_prog() and save the result into bpf_jit::frame_off,
so that the other parts of the JIT can use it.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 56 +++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index c7f8313ba449..76ad52a24444 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -54,6 +54,7 @@ struct bpf_jit {
 	int prologue_plt;	/* Start of prologue hotpatch PLT */
 	int kern_arena;		/* Pool offset of kernel arena address */
 	u64 user_arena;		/* User arena address */
+	u32 frame_off;		/* Offset of frame from %r15 */
 };
 
 #define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
@@ -443,12 +444,9 @@ static void save_regs(struct bpf_jit *jit, u32 rs, u32 re)
 /*
  * Restore registers from "rs" (register start) to "re" (register end) on stack
  */
-static void restore_regs(struct bpf_jit *jit, u32 rs, u32 re, u32 stack_depth)
+static void restore_regs(struct bpf_jit *jit, u32 rs, u32 re)
 {
-	u32 off = STK_OFF_R6 + (rs - 6) * 8;
-
-	if (jit->seen & SEEN_STACK)
-		off += STK_OFF + stack_depth;
+	u32 off = jit->frame_off + STK_OFF_R6 + (rs - 6) * 8;
 
 	if (rs == re)
 		/* lg %rs,off(%r15) */
@@ -492,8 +490,7 @@ static int get_end(u16 seen_regs, int start)
  * Save and restore clobbered registers (6-15) on stack.
  * We save/restore registers in chunks with gap >= 2 registers.
  */
-static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth,
-			      u16 extra_regs)
+static void save_restore_regs(struct bpf_jit *jit, int op, u16 extra_regs)
 {
 	u16 seen_regs = jit->seen_regs | extra_regs;
 	const int last = 15, save_restore_size = 6;
@@ -516,7 +513,7 @@ static void save_restore_regs(struct bpf_jit *jit, int op, u32 stack_depth,
 		if (op == REGS_SAVE)
 			save_regs(jit, rs, re);
 		else
-			restore_regs(jit, rs, re, stack_depth);
+			restore_regs(jit, rs, re);
 		re++;
 	} while (re <= last);
 }
@@ -575,8 +572,7 @@ static void bpf_jit_plt(struct bpf_plt *plt, void *ret, void *target)
  * Save registers and create stack frame if necessary.
  * See stack frame layout description in "bpf_jit.h"!
  */
-static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
-			     u32 stack_depth)
+static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp)
 {
 	/* No-op for hotpatching */
 	/* brcl 0,prologue_plt */
@@ -609,7 +605,7 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 		jit->seen_regs |= NVREGS;
 	} else {
 		/* Save registers */
-		save_restore_regs(jit, REGS_SAVE, stack_depth,
+		save_restore_regs(jit, REGS_SAVE,
 				  fp->aux->exception_boundary ? NVREGS : 0);
 	}
 	/* Setup literal pool */
@@ -631,8 +627,8 @@ static void bpf_jit_prologue(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT4(0xb9040000, REG_W1, REG_15);
 		/* la %bfp,STK_160_UNUSED(%r15) (BPF frame pointer) */
 		EMIT4_DISP(0x41000000, BPF_REG_FP, REG_15, STK_160_UNUSED);
-		/* aghi %r15,-STK_OFF */
-		EMIT4_IMM(0xa70b0000, REG_15, -(STK_OFF + stack_depth));
+		/* aghi %r15,-frame_off */
+		EMIT4_IMM(0xa70b0000, REG_15, -jit->frame_off);
 		/* stg %w1,152(%r15) (backchain) */
 		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W1, REG_0,
 			      REG_15, 152);
@@ -669,13 +665,13 @@ static void call_r1(struct bpf_jit *jit)
 /*
  * Function epilogue
  */
-static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
+static void bpf_jit_epilogue(struct bpf_jit *jit)
 {
 	jit->exit_ip = jit->prg;
 	/* Load exit code: lgr %r2,%b0 */
 	EMIT4(0xb9040000, REG_2, BPF_REG_0);
 	/* Restore registers */
-	save_restore_regs(jit, REGS_RESTORE, stack_depth, 0);
+	save_restore_regs(jit, REGS_RESTORE, 0);
 	EMIT_JUMP_REG(14);
 
 	jit->prg = ALIGN(jit->prg, 8);
@@ -857,7 +853,7 @@ static int sign_extend(struct bpf_jit *jit, int r, u8 size, u8 flags)
  * stack space for the large switch statement.
  */
 static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
-				 int i, bool extra_pass, u32 stack_depth)
+				 int i, bool extra_pass)
 {
 	struct bpf_insn *insn = &fp->insnsi[i];
 	s32 branch_oc_off = insn->off;
@@ -1778,9 +1774,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		 * Note 2: We assume that the verifier does not let us call the
 		 * main program, which clears the tail call counter on entry.
 		 */
-		/* mvc STK_OFF_TCCNT(4,%r15),N(%r15) */
+		/* mvc STK_OFF_TCCNT(4,%r15),frame_off+STK_OFF_TCCNT(%r15) */
 		_EMIT6(0xd203f000 | STK_OFF_TCCNT,
-		       0xf000 | (STK_OFF_TCCNT + STK_OFF + stack_depth));
+		       0xf000 | (jit->frame_off + STK_OFF_TCCNT));
 
 		/* Sign-extend the kfunc arguments. */
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
@@ -1831,10 +1827,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		 *         goto out;
 		 */
 
-		if (jit->seen & SEEN_STACK)
-			off = STK_OFF_TCCNT + STK_OFF + stack_depth;
-		else
-			off = STK_OFF_TCCNT;
+		off = jit->frame_off + STK_OFF_TCCNT;
 		/* lhi %w0,1 */
 		EMIT4_IMM(0xa7080000, REG_W0, 1);
 		/* laal %w1,%w0,off(%r15) */
@@ -1864,7 +1857,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/*
 		 * Restore registers before calling function
 		 */
-		save_restore_regs(jit, REGS_RESTORE, stack_depth, 0);
+		save_restore_regs(jit, REGS_RESTORE, 0);
 
 		/*
 		 * goto *(prog->bpf_func + tail_call_start);
@@ -2157,7 +2150,7 @@ static int bpf_set_addr(struct bpf_jit *jit, int i)
  * Compile eBPF program into s390x code
  */
 static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
-			bool extra_pass, u32 stack_depth)
+			bool extra_pass)
 {
 	int i, insn_count, lit32_size, lit64_size;
 	u64 kern_arena;
@@ -2166,24 +2159,28 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	jit->lit64 = jit->lit64_start;
 	jit->prg = 0;
 	jit->excnt = 0;
+	if (is_first_pass(jit) || (jit->seen & SEEN_STACK))
+		jit->frame_off = STK_OFF + round_up(fp->aux->stack_depth, 8);
+	else
+		jit->frame_off = 0;
 
 	kern_arena = bpf_arena_get_kern_vm_start(fp->aux->arena);
 	if (kern_arena)
 		jit->kern_arena = _EMIT_CONST_U64(kern_arena);
 	jit->user_arena = bpf_arena_get_user_vm_start(fp->aux->arena);
 
-	bpf_jit_prologue(jit, fp, stack_depth);
+	bpf_jit_prologue(jit, fp);
 	if (bpf_set_addr(jit, 0) < 0)
 		return -1;
 	for (i = 0; i < fp->len; i += insn_count) {
-		insn_count = bpf_jit_insn(jit, fp, i, extra_pass, stack_depth);
+		insn_count = bpf_jit_insn(jit, fp, i, extra_pass);
 		if (insn_count < 0)
 			return -1;
 		/* Next instruction address */
 		if (bpf_set_addr(jit, i + insn_count) < 0)
 			return -1;
 	}
-	bpf_jit_epilogue(jit, stack_depth);
+	bpf_jit_epilogue(jit);
 
 	lit32_size = jit->lit32 - jit->lit32_start;
 	lit64_size = jit->lit64 - jit->lit64_start;
@@ -2259,7 +2256,6 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
  */
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 {
-	u32 stack_depth = round_up(fp->aux->stack_depth, 8);
 	struct bpf_prog *tmp, *orig_fp = fp;
 	struct bpf_binary_header *header;
 	struct s390_jit_data *jit_data;
@@ -2312,7 +2308,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	 *   - 3:   Calculate program size and addrs array
 	 */
 	for (pass = 1; pass <= 3; pass++) {
-		if (bpf_jit_prog(&jit, fp, extra_pass, stack_depth)) {
+		if (bpf_jit_prog(&jit, fp, extra_pass)) {
 			fp = orig_fp;
 			goto free_addrs;
 		}
@@ -2326,7 +2322,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		goto free_addrs;
 	}
 skip_init_ctx:
-	if (bpf_jit_prog(&jit, fp, extra_pass, stack_depth)) {
+	if (bpf_jit_prog(&jit, fp, extra_pass)) {
 		bpf_jit_binary_free(header);
 		fp = orig_fp;
 		goto free_addrs;
-- 
2.49.0


