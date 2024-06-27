Return-Path: <bpf+bounces-33236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9328B91A23D
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E908EB20FED
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22CF13AA27;
	Thu, 27 Jun 2024 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="av+5+Eub"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166A13A3E8
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479368; cv=none; b=p21QHiBpeZqEN/lOEamGvrWvqvcKfxKv3xYlMSZoeb5Cz2yAjC//kLD1MBVQVZy1Z8iXZJJ2JOpciwd9a2BcLAY+ZcS5JCW9yO0hanrz2AlYCR5aq97cpKANh9ufBW2HyOsVlax0H0FZrtRXtxMR+3uaaTllp2gcU9PYUn8ipnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479368; c=relaxed/simple;
	bh=MDbnFZovL79ojtcKxsVHZwmUUOn/vatyxusmiFIwx7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hff5pq+UDzGKJ4IeoC7Aig5CmjAMwSc0SOYQ/jMs+K/FKUcGX2iAC+/nyx13Z9pLx9CMRSqRWc7x52v/RpWqXukT42+HHJ06sb1VC773i6pcmfjsJHh0EKsrG/MIqi8PLQD/gARKryRoD1/E6H6sU05vTNePJeqBVcRYNHlUCMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=av+5+Eub; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R6QpnS031214;
	Thu, 27 Jun 2024 09:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=eiDwbDYihcdr/
	Hy/6VDscVGlE7MC7xYixqCb35PX4xk=; b=av+5+Eub9+4IFLtkSR2sqq8B38Mlc
	nzIkfE1zJEFZ5/yYIOUCkw6gbKCqWLyKhYGO7GOPsUDKlP0qdCnRDfSCUYOR/vIn
	7ISG7FwrNFbJIbbByeyBM0QMOWfz8tLEwdz5Wo7hCMFd23MDx7iRdNplDDSDQKcx
	ydqYwNhrezAIw9xr9elJpxEScBE7bPy4x9lLQzSneJkORxkQhxBXj89kDE0/Z3tt
	M+i9qdjdWTmzUCwocVyl/BFmuPKHPoA5GDnNoRqbfWGVLpCJ3fI6exzANOCDZijw
	QDkNH0Rnt+Wo/QIttIjU0TkE+9USD1wBE4vR/zE/LqWbx2U3DUV7OndYg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4010n2gq4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R8Rpl8000685;
	Thu, 27 Jun 2024 09:09:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaen9tc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R996Le52625698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:09:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CC6420063;
	Thu, 27 Jun 2024 09:09:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 190CA2004D;
	Thu, 27 Jun 2024 09:09:06 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.16.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 09:09:06 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 05/10] s390/bpf: Support BPF_PROBE_MEM32
Date: Thu, 27 Jun 2024 11:07:08 +0200
Message-ID: <20240627090900.20017-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627090900.20017-1-iii@linux.ibm.com>
References: <20240627090900.20017-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3ZfAYC1xZ7vqK97VYUtMtN8tp7KxOnB6
X-Proofpoint-GUID: 3ZfAYC1xZ7vqK97VYUtMtN8tp7KxOnB6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406270067

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


