Return-Path: <bpf+bounces-33569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFB791EB7F
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D94CB21894
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 23:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265AB1741E0;
	Mon,  1 Jul 2024 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QKW53mna"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889517334F
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877417; cv=none; b=elDdyNTiMUXcbkRXTtB4zjeeZLeMgti8Hx9735P7DXCknrG5rZiD+Jr9dyTRbNMPe3bBp9UAuU9TO5vIbCNGHr0JDoUmdiJobQ+0/l4sRHIlXFvuImPOKZtcVdhfWT85CkymYp3Q4KYwNywVpkLlxD1MUpDGvBDnIr8W6ZseKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877417; c=relaxed/simple;
	bh=MDbnFZovL79ojtcKxsVHZwmUUOn/vatyxusmiFIwx7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPrgJU1EcO27PdqyM3yyi3HihAUPU9N+oGW/hgoiVdnZL0787hFEQgtULUD+KTGhbjh1BBgMRi1d1AtLR+tywQbkkcbJmWfGz6CveyI3N9xquppySdKbEfenScCS1XGXMvHq3Oa60dCxSvtXR55FhWE7MSUD2eYsUaiw/SBdfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QKW53mna; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461NR6fV014812;
	Mon, 1 Jul 2024 23:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=eiDwbDYihcdr/
	Hy/6VDscVGlE7MC7xYixqCb35PX4xk=; b=QKW53mnarSa5HItZzmky4NLgqJ+Mc
	5HxM7j1O58dc3Hudbynojdy6l19E0vTUl3xQHqR4qBSzj2OOvrJr/deUb+55YPQH
	HGtftGeGVD6HpLG19MNfsVBTzlrrw+RllOxovbjGKVkXCMyP2MkNRWCIiO6ZWJXi
	cGbUdNSBjHbGSSrOvbc6Ypq2Csb5EAeLiCnWPZ//Q1kJ5FePex+vAAZfeLFgEx0W
	Kex5vwzuaPpBTJvQ9LWkJ7Y7okVQV2gNsu3n0uFQGhQ+wTquc2xRKJ0QtSF9IqKF
	JwkyO0yrfthtkSsjdnf9v2YBYyIoO/hVl2qQFPea/j7i3xS50J2STk5ag==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4044uar529-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461LF140005930;
	Mon, 1 Jul 2024 23:43:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vku24er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461NhAoj48693652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 23:43:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD3CB2004B;
	Mon,  1 Jul 2024 23:43:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D46920040;
	Mon,  1 Jul 2024 23:43:10 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.65.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 23:43:10 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 06/12] s390/bpf: Support BPF_PROBE_MEM32
Date: Tue,  2 Jul 2024 01:40:24 +0200
Message-ID: <20240701234304.14336-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701234304.14336-1-iii@linux.ibm.com>
References: <20240701234304.14336-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FLmehnUd2tTsU636YGC9JLaEBFV8larl
X-Proofpoint-GUID: FLmehnUd2tTsU636YGC9JLaEBFV8larl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407010174

BPF_PROBE_MEM32 is a new mode for LDX, ST and STX instructions. The JIT
is supposed to add the start address of the kernel arena mapping to the
%dst register, and use a probing variant of the respective memory
access.

Reuse the existing probing infrastructure for that. Put the arena
address into the literal pool, load it into %r1 and use that as an
index register. Do not clear any registers in ex_handler_bpf() for
failing ST and STX instructions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 137 ++++++++++++++++++++++++++++-------
 1 file changed, 110 insertions(+), 27 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index ecd53f8f0602..4b62b5162dfb 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -53,6 +53,7 @@ struct bpf_jit {
 	int excnt;		/* Number of exception table entries */
 	int prologue_plt_ret;	/* Return address for prologue hotpatch PLT */
 	int prologue_plt;	/* Start of prologue hotpatch PLT */
+	int kern_arena;		/* Pool offset of kernel arena address */
 };
 
 #define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
@@ -670,7 +671,8 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 {
 	regs->psw.addr = extable_fixup(x);
-	regs->gprs[x->data] = 0;
+	if (x->data != -1)
+		regs->gprs[x->data] = 0;
 	return true;
 }
 
@@ -681,6 +683,7 @@ struct bpf_jit_probe {
 	int prg;	/* JITed instruction offset */
 	int nop_prg;	/* JITed nop offset */
 	int reg;	/* Register to clear on exception */
+	int arena_reg;	/* Register to use for arena addressing */
 };
 
 static void bpf_jit_probe_init(struct bpf_jit_probe *probe)
@@ -688,6 +691,7 @@ static void bpf_jit_probe_init(struct bpf_jit_probe *probe)
 	probe->prg = -1;
 	probe->nop_prg = -1;
 	probe->reg = -1;
+	probe->arena_reg = REG_0;
 }
 
 /*
@@ -708,13 +712,31 @@ static void bpf_jit_probe_load_pre(struct bpf_jit *jit, struct bpf_insn *insn,
 				   struct bpf_jit_probe *probe)
 {
 	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
-	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX)
+	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
+	    BPF_MODE(insn->code) != BPF_PROBE_MEM32)
 		return;
 
+	if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
+		/* lgrl %r1,kern_arena */
+		EMIT6_PCREL_RILB(0xc4080000, REG_W1, jit->kern_arena);
+		probe->arena_reg = REG_W1;
+	}
 	probe->prg = jit->prg;
 	probe->reg = reg2hex[insn->dst_reg];
 }
 
+static void bpf_jit_probe_store_pre(struct bpf_jit *jit, struct bpf_insn *insn,
+				    struct bpf_jit_probe *probe)
+{
+	if (BPF_MODE(insn->code) != BPF_PROBE_MEM32)
+		return;
+
+	/* lgrl %r1,kern_arena */
+	EMIT6_PCREL_RILB(0xc4080000, REG_W1, jit->kern_arena);
+	probe->arena_reg = REG_W1;
+	probe->prg = jit->prg;
+}
+
 static int bpf_jit_probe_post(struct bpf_jit *jit, struct bpf_prog *fp,
 			      struct bpf_jit_probe *probe)
 {
@@ -1384,51 +1406,99 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	 * BPF_ST(X)
 	 */
 	case BPF_STX | BPF_MEM | BPF_B: /* *(u8 *)(dst + off) = src_reg */
-		/* stcy %src,off(%dst) */
-		EMIT6_DISP_LH(0xe3000000, 0x0072, src_reg, dst_reg, REG_0, off);
+	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
+		bpf_jit_probe_store_pre(jit, insn, &probe);
+		/* stcy %src,off(%dst,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0072, src_reg, dst_reg,
+			      probe.arena_reg, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		jit->seen |= SEEN_MEM;
 		break;
 	case BPF_STX | BPF_MEM | BPF_H: /* (u16 *)(dst + off) = src */
-		/* sthy %src,off(%dst) */
-		EMIT6_DISP_LH(0xe3000000, 0x0070, src_reg, dst_reg, REG_0, off);
+	case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
+		bpf_jit_probe_store_pre(jit, insn, &probe);
+		/* sthy %src,off(%dst,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0070, src_reg, dst_reg,
+			      probe.arena_reg, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		jit->seen |= SEEN_MEM;
 		break;
 	case BPF_STX | BPF_MEM | BPF_W: /* *(u32 *)(dst + off) = src */
-		/* sty %src,off(%dst) */
-		EMIT6_DISP_LH(0xe3000000, 0x0050, src_reg, dst_reg, REG_0, off);
+	case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
+		bpf_jit_probe_store_pre(jit, insn, &probe);
+		/* sty %src,off(%dst,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0050, src_reg, dst_reg,
+			      probe.arena_reg, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		jit->seen |= SEEN_MEM;
 		break;
 	case BPF_STX | BPF_MEM | BPF_DW: /* (u64 *)(dst + off) = src */
-		/* stg %src,off(%dst) */
-		EMIT6_DISP_LH(0xe3000000, 0x0024, src_reg, dst_reg, REG_0, off);
+	case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
+		bpf_jit_probe_store_pre(jit, insn, &probe);
+		/* stg %src,off(%dst,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0024, src_reg, dst_reg,
+			      probe.arena_reg, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		jit->seen |= SEEN_MEM;
 		break;
 	case BPF_ST | BPF_MEM | BPF_B: /* *(u8 *)(dst + off) = imm */
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
 		/* lhi %w0,imm */
 		EMIT4_IMM(0xa7080000, REG_W0, (u8) imm);
-		/* stcy %w0,off(dst) */
-		EMIT6_DISP_LH(0xe3000000, 0x0072, REG_W0, dst_reg, REG_0, off);
+		bpf_jit_probe_store_pre(jit, insn, &probe);
+		/* stcy %w0,off(%dst,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0072, REG_W0, dst_reg,
+			      probe.arena_reg, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		jit->seen |= SEEN_MEM;
 		break;
 	case BPF_ST | BPF_MEM | BPF_H: /* (u16 *)(dst + off) = imm */
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
 		/* lhi %w0,imm */
 		EMIT4_IMM(0xa7080000, REG_W0, (u16) imm);
-		/* sthy %w0,off(dst) */
-		EMIT6_DISP_LH(0xe3000000, 0x0070, REG_W0, dst_reg, REG_0, off);
+		bpf_jit_probe_store_pre(jit, insn, &probe);
+		/* sthy %w0,off(%dst,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0070, REG_W0, dst_reg,
+			      probe.arena_reg, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		jit->seen |= SEEN_MEM;
 		break;
 	case BPF_ST | BPF_MEM | BPF_W: /* *(u32 *)(dst + off) = imm */
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
 		/* llilf %w0,imm  */
 		EMIT6_IMM(0xc00f0000, REG_W0, (u32) imm);
-		/* sty %w0,off(%dst) */
-		EMIT6_DISP_LH(0xe3000000, 0x0050, REG_W0, dst_reg, REG_0, off);
+		bpf_jit_probe_store_pre(jit, insn, &probe);
+		/* sty %w0,off(%dst,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0050, REG_W0, dst_reg,
+			      probe.arena_reg, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		jit->seen |= SEEN_MEM;
 		break;
 	case BPF_ST | BPF_MEM | BPF_DW: /* *(u64 *)(dst + off) = imm */
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
 		/* lgfi %w0,imm */
 		EMIT6_IMM(0xc0010000, REG_W0, imm);
-		/* stg %w0,off(%dst) */
-		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W0, dst_reg, REG_0, off);
+		bpf_jit_probe_store_pre(jit, insn, &probe);
+		/* stg %w0,off(%dst,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W0, dst_reg,
+			      probe.arena_reg, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		jit->seen |= SEEN_MEM;
 		break;
 	/*
@@ -1506,9 +1576,11 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	 */
 	case BPF_LDX | BPF_MEM | BPF_B: /* dst = *(u8 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
 		bpf_jit_probe_load_pre(jit, insn, &probe);
-		/* llgc %dst,0(off,%src) */
-		EMIT6_DISP_LH(0xe3000000, 0x0090, dst_reg, src_reg, REG_0, off);
+		/* llgc %dst,off(%src,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0090, dst_reg, src_reg,
+			      probe.arena_reg, off);
 		err = bpf_jit_probe_post(jit, fp, &probe);
 		if (err < 0)
 			return err;
@@ -1519,7 +1591,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	case BPF_LDX | BPF_MEMSX | BPF_B: /* dst = *(s8 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
 		bpf_jit_probe_load_pre(jit, insn, &probe);
-		/* lgb %dst,0(off,%src) */
+		/* lgb %dst,off(%src) */
 		EMIT6_DISP_LH(0xe3000000, 0x0077, dst_reg, src_reg, REG_0, off);
 		err = bpf_jit_probe_post(jit, fp, &probe);
 		if (err < 0)
@@ -1528,9 +1600,11 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		break;
 	case BPF_LDX | BPF_MEM | BPF_H: /* dst = *(u16 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
 		bpf_jit_probe_load_pre(jit, insn, &probe);
-		/* llgh %dst,0(off,%src) */
-		EMIT6_DISP_LH(0xe3000000, 0x0091, dst_reg, src_reg, REG_0, off);
+		/* llgh %dst,off(%src,%arena) */
+		EMIT6_DISP_LH(0xe3000000, 0x0091, dst_reg, src_reg,
+			      probe.arena_reg, off);
 		err = bpf_jit_probe_post(jit, fp, &probe);
 		if (err < 0)
 			return err;
@@ -1541,7 +1615,7 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	case BPF_LDX | BPF_MEMSX | BPF_H: /* dst = *(s16 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
 		bpf_jit_probe_load_pre(jit, insn, &probe);
-		/* lgh %dst,0(off,%src) */
+		/* lgh %dst,off(%src) */
 		EMIT6_DISP_LH(0xe3000000, 0x0015, dst_reg, src_reg, REG_0, off);
 		err = bpf_jit_probe_post(jit, fp, &probe);
 		if (err < 0)
@@ -1550,10 +1624,12 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		break;
 	case BPF_LDX | BPF_MEM | BPF_W: /* dst = *(u32 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
 		bpf_jit_probe_load_pre(jit, insn, &probe);
 		/* llgf %dst,off(%src) */
 		jit->seen |= SEEN_MEM;
-		EMIT6_DISP_LH(0xe3000000, 0x0016, dst_reg, src_reg, REG_0, off);
+		EMIT6_DISP_LH(0xe3000000, 0x0016, dst_reg, src_reg,
+			      probe.arena_reg, off);
 		err = bpf_jit_probe_post(jit, fp, &probe);
 		if (err < 0)
 			return err;
@@ -1572,10 +1648,12 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		break;
 	case BPF_LDX | BPF_MEM | BPF_DW: /* dst = *(u64 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
 		bpf_jit_probe_load_pre(jit, insn, &probe);
-		/* lg %dst,0(off,%src) */
+		/* lg %dst,off(%src,%arena) */
 		jit->seen |= SEEN_MEM;
-		EMIT6_DISP_LH(0xe3000000, 0x0004, dst_reg, src_reg, REG_0, off);
+		EMIT6_DISP_LH(0xe3000000, 0x0004, dst_reg, src_reg,
+			      probe.arena_reg, off);
 		err = bpf_jit_probe_post(jit, fp, &probe);
 		if (err < 0)
 			return err;
@@ -1988,12 +2066,17 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 			bool extra_pass, u32 stack_depth)
 {
 	int i, insn_count, lit32_size, lit64_size;
+	u64 kern_arena;
 
 	jit->lit32 = jit->lit32_start;
 	jit->lit64 = jit->lit64_start;
 	jit->prg = 0;
 	jit->excnt = 0;
 
+	kern_arena = bpf_arena_get_kern_vm_start(fp->aux->arena);
+	if (kern_arena)
+		jit->kern_arena = _EMIT_CONST_U64(kern_arena);
+
 	bpf_jit_prologue(jit, fp, stack_depth);
 	if (bpf_set_addr(jit, 0) < 0)
 		return -1;
-- 
2.45.2


