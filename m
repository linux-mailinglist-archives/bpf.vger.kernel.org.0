Return-Path: <bpf+bounces-33560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAC091EB76
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4C81C212E7
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 23:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B60172BD5;
	Mon,  1 Jul 2024 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N/Gcz2vt"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5A171652
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877412; cv=none; b=Gg7qUm3i0xGhD/gzs40sKST17zGfxIHSaoly4vgepruZnPyp1rZnO6Z0r4swpqIz6+ni8loJxnt/5Yicm0AqWxcn9UeagZ5fg0ATMxevkHBD5gJul+7dx9eFISp/5vlrRTqAAFfocVarqsRxxti6xhuruz3AXjtrfDIeBp+oKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877412; c=relaxed/simple;
	bh=QHzT5BWkXXxyEISDPlHFqxf+bFfTZdX0GiZjPvMfexQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaLiPhcdZd54q6NrMTFwftkh3r5symSJKPFt+C/EpPbAfSpMB6+Z5hrQKy0YAG6X3pITxkQxp5c2B1EAyEUlko5A36YyHimy8G4OyFrwVTjRCJjVUzrRdysEy43e/6MWj+hdY2+XqhVsT3DChHBOUPNHd3qMPoK1Kzy/iA7dpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N/Gcz2vt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461N0GS9025314;
	Mon, 1 Jul 2024 23:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=oBCW7ApJhpCFX
	4EyNprymqi7a4pIqPmVdokLSSJpoi8=; b=N/Gcz2vt5LCk1PkoGM17U5K2EHNLn
	RDPQJZe6Xwq0/MZfleR4gksgPRtJ5nxNPBdRQo24nCU2QMdAbzACP2Z/OW2z7T6E
	oFiqzehD55/RknZdf82wTeyTzTubVMsYfr1kkSnFCNEX452+1dNnabOCq4tRM55K
	QhzM9YvZg0hvrGrSdYQYyE/QI+X2jErp2hZQw2BSLdivZySmwqFAZ3YORNju7FXj
	i3GMULsW2n50htw71gUjNeuPIwQqMlHSDVdu/NWcTdHbXOVMGlq6EHqocW1uSJ3B
	DyROtZdVYkTJG09LxfSciLsL7WzWSHlOOm7AAFv/p90LHaA/HQHRtb4yA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4045qf02hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461KVLL2024095;
	Mon, 1 Jul 2024 23:43:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya39f9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461NhB7s37945602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 23:43:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AB6220040;
	Mon,  1 Jul 2024 23:43:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C19892004E;
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
Subject: [PATCH bpf-next v3 07/12] s390/bpf: Support address space cast instruction
Date: Tue,  2 Jul 2024 01:40:25 +0200
Message-ID: <20240701234304.14336-8-iii@linux.ibm.com>
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
X-Proofpoint-GUID: YIaMG4eyGgLOJOZd8nvoeWFuAH3mi43g
X-Proofpoint-ORIG-GUID: YIaMG4eyGgLOJOZd8nvoeWFuAH3mi43g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010174

The new address cast instruction translates arena offsets to userspace
addresses. NULL pointers must not be translated.

The common code sets up the mappings in such a way that it's enough to
replace the higher 32 bits to achieve the desired result. s390x has
just an instruction for this: INSERT IMMEDIATE.

Implement the sequence using 3 instruction: LOAD AND TEST, BRANCH
RELATIVE ON CONDITION and INSERT IMMEDIATE.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 4b62b5162dfb..39c1d9aa7f1e 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -54,6 +54,7 @@ struct bpf_jit {
 	int prologue_plt_ret;	/* Return address for prologue hotpatch PLT */
 	int prologue_plt;	/* Start of prologue hotpatch PLT */
 	int kern_arena;		/* Pool offset of kernel arena address */
+	u64 user_arena;		/* User arena address */
 };
 
 #define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
@@ -863,6 +864,22 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		}
 		break;
 	case BPF_ALU64 | BPF_MOV | BPF_X:
+		if (insn_is_cast_user(insn)) {
+			int patch_brc;
+
+			/* ltgr %dst,%src */
+			EMIT4(0xb9020000, dst_reg, src_reg);
+			/* brc 8,0f */
+			patch_brc = jit->prg;
+			EMIT4_PCREL_RIC(0xa7040000, 8, 0);
+			/* iihf %dst,user_arena>>32 */
+			EMIT6_IMM(0xc0080000, dst_reg, jit->user_arena >> 32);
+			/* 0: */
+			if (jit->prg_buf)
+				*(u16 *)(jit->prg_buf + patch_brc + 2) =
+					(jit->prg - patch_brc) >> 1;
+			break;
+		}
 		switch (insn->off) {
 		case 0: /* DST = SRC */
 			/* lgr %dst,%src */
@@ -2076,6 +2093,7 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
 	kern_arena = bpf_arena_get_kern_vm_start(fp->aux->arena);
 	if (kern_arena)
 		jit->kern_arena = _EMIT_CONST_U64(kern_arena);
+	jit->user_arena = bpf_arena_get_user_vm_start(fp->aux->arena);
 
 	bpf_jit_prologue(jit, fp, stack_depth);
 	if (bpf_set_addr(jit, 0) < 0)
-- 
2.45.2


