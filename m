Return-Path: <bpf+bounces-33558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26AE91EB74
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 01:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9C3282B45
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 23:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C37172BCA;
	Mon,  1 Jul 2024 23:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CBY+4Dcy"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15712F29
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877411; cv=none; b=JsoP+5r/LEY0Fs7RmmzGdcfrdynKxjHkF39NJYJA/Hl/J5lSF/aow8UCQyPoauTy3CKEymoMPhNxD5FoK2B/ZTvwE4dyybwJ01CKpf1mqkIjyWKQtDPNGs4dGN03MkWvKZBZjhcye+K372FuWZD+/R6dXNdipo9Hndxji/JlL0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877411; c=relaxed/simple;
	bh=Ffnk2hnEq3iyMJwjgWXOy12DcTrsJB0dQof8gtQ7y/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dV5gYVELmNLzlLMUj0z0Bp81Q4A1gGNOoKDe+yD+Pc4GyblKW0CjA41trTNjdZS9lyxWb1ZmhJtXN4EqjflotS/4F8+jD6vWCB/f+EW6bvD5Js3c5iYa48p8ko+Y+sEnVQlqQhoaVoEpnYQIYYjhC89NBdDfwjrJPMQVuD/QkGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CBY+4Dcy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461MuoUV013429;
	Mon, 1 Jul 2024 23:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=OZJgdvap6RejD
	C2FzpnNBkCKdzEUVS7hHzbtvz+kL/E=; b=CBY+4Dcyo/+0gOBy4cxfQ0l54+qBm
	j+WojI8O5OQCb8D/qe/BRLGAOUEr/ofu9X+5IRFZ+sFe1Po1Wb/wYZe5sKzsXxCI
	l5Uh8R6EC4r17Lt3sfFX5W7mjaqpDrQ2gRiKDjb50+f9FUmeqk3VwC+lVUuJ8DYc
	6eXH2KE07DRa1lXlV5DY8OG0n5mQP8jTX7ABI++w1TRRWayNjOrwvw6dOSVvXLEo
	kXSsBs3kjM/ZtWfM1F4vPQnbD/ZACsyL569kdEjQtvGK9xMwwpiXwwaAAmTBL28V
	e8bqhJ3dEv77aUVj0MdrV8IoSAbSC/r3FL9jPd1X6ggzNywBAeAwAc32w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40459dr3fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461M4uQv009154;
	Mon, 1 Jul 2024 23:43:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402w00j19y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:43:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461Nh91319857704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 23:43:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 142CA2004F;
	Mon,  1 Jul 2024 23:43:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9916420040;
	Mon,  1 Jul 2024 23:43:08 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.65.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 23:43:08 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 03/12] s390/bpf: Get rid of get_probe_mem_regno()
Date: Tue,  2 Jul 2024 01:40:21 +0200
Message-ID: <20240701234304.14336-4-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: WsyQvIbQsg0k_a6DNloe1qtiDNEQEy_z
X-Proofpoint-GUID: WsyQvIbQsg0k_a6DNloe1qtiDNEQEy_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010170

Commit 7fc8c362e782 ("s390/bpf: encode register within extable entry")
introduced explicit passing of the number of the register to be cleared
to ex_handler_bpf(), which replaced deducing it from the respective
native load instruction using get_probe_mem_regno().

Replace the second and last usage in the same manner, and remove this
function.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 260e7009784b..d9d79aa2be1b 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -667,25 +667,6 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 	jit->prg += sizeof(struct bpf_plt);
 }
 
-static int get_probe_mem_regno(const u8 *insn)
-{
-	/*
-	 * insn must point to llgc, llgh, llgf, lg, lgb, lgh or lgf, which have
-	 * destination register at the same position.
-	 */
-	if (insn[0] != 0xe3) /* common prefix */
-		return -1;
-	if (insn[5] != 0x90 && /* llgc */
-	    insn[5] != 0x91 && /* llgh */
-	    insn[5] != 0x16 && /* llgf */
-	    insn[5] != 0x04 && /* lg */
-	    insn[5] != 0x77 && /* lgb */
-	    insn[5] != 0x15 && /* lgh */
-	    insn[5] != 0x14) /* lgf */
-		return -1;
-	return insn[1] >> 4;
-}
-
 bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 {
 	regs->psw.addr = extable_fixup(x);
@@ -699,12 +680,14 @@ bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 struct bpf_jit_probe {
 	int prg;	/* JITed instruction offset */
 	int nop_prg;	/* JITed nop offset */
+	int reg;	/* Register to clear on exception */
 };
 
 static void bpf_jit_probe_init(struct bpf_jit_probe *probe)
 {
 	probe->prg = -1;
 	probe->nop_prg = -1;
+	probe->reg = -1;
 }
 
 /*
@@ -725,7 +708,7 @@ static int bpf_jit_probe_mem(struct bpf_jit *jit, struct bpf_prog *fp,
 			     struct bpf_jit_probe *probe)
 {
 	struct exception_table_entry *ex;
-	int i, prg, reg;
+	int i, prg;
 	s64 delta;
 	u8 *insn;
 
@@ -734,10 +717,6 @@ static int bpf_jit_probe_mem(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* Do nothing during early JIT passes. */
 		return 0;
 	insn = jit->prg_buf + probe->prg;
-	reg = get_probe_mem_regno(insn);
-	if (WARN_ON_ONCE(reg < 0))
-		/* JIT bug - unexpected probe instruction. */
-		return -1;
 	if (WARN_ON_ONCE(probe->prg + insn_length(*insn) != probe->nop_prg))
 		/* JIT bug - gap between probe and nop instructions. */
 		return -1;
@@ -763,7 +742,7 @@ static int bpf_jit_probe_mem(struct bpf_jit *jit, struct bpf_prog *fp,
 			return -1;
 		ex->fixup = delta;
 		ex->type = EX_TYPE_BPF;
-		ex->data = reg;
+		ex->data = probe->reg;
 		jit->excnt++;
 	}
 	return 0;
@@ -821,8 +800,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	bpf_jit_probe_init(&probe);
 	if (BPF_CLASS(insn->code) == BPF_LDX &&
 	    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
-	     BPF_MODE(insn->code) == BPF_PROBE_MEMSX))
+	     BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
 		probe.prg = jit->prg;
+		probe.reg = reg2hex[dst_reg];
+	}
 
 	switch (insn->code) {
 	/*
-- 
2.45.2


