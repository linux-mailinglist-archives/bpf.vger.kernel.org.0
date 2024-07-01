Return-Path: <bpf+bounces-33487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2099A91E0C8
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4277B1C2146B
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED9B15ECC4;
	Mon,  1 Jul 2024 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IVNthVPc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83616EB4C
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840897; cv=none; b=Cngr3PXw3ocWbyM6njqJ/Z/N3OJfKYMIaH3DStKjPM51u8z+naMXZOFY8mCjDu1KW/9tsTRWDI3rLINhOScwUyzIFIvqho4clL5elUixwUCrQzn9YB8AAForJmMaq55lHiG01cCOa0cUomU7x2bS1nudSj2zAIlJjOoEh98juOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840897; c=relaxed/simple;
	bh=7vUFpdXKxcptrM2tclmEQfIuuHbOk1MbfSyCLdfmYUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mg4KAf50fjJyvAmYQK/rx+Pe9Afuqf1T6XsHlBTizV/k4+7hNxDKmsKcLQg6vBIzczKNGuhYi4/HMPzL6edt0Y5cPcYWEJ4pZc243uqNX6kyVgOIu72uYK1Dlec8KP3SF7GRymqPn30lT2jspe+HAqQ8zwCv+G913KlOZd4gh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IVNthVPc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461DQ39Z015596;
	Mon, 1 Jul 2024 13:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=buLkbpIBzE25b
	1vaxtzm68BWFHVhO+sceqfrPUWlQRk=; b=IVNthVPcKEe5ni+ydTrVigFiNUjK0
	kqvkIsbl38K95pWuA8h0js1rVV6KiQomYbO6IbUATWSu8HOKBEImRhHP2Ler5pvK
	ux9xX6sh0iA7hueg7CfYkzM2hiAgwoVzp0YBpZjTr83SIgZ7+JY/OOqOvKz+X0gI
	rY70gd/Y97mJ6Ih6pCW07QvgOjnTCX1F39tdyYLO21g6CUWs9de9YQcBRnM5rrSp
	UZKECU6NEEe48Ip95cqlBNs+x+qixioLgRFD3CsH6lK2qfTXQtNOoPbcnOM0JYbo
	3fudaI3pKiGxXVu4JQ7yq2jTMfIQtEZrLt4ld+OyrFT7PlAuMH8q6RzTQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403vx6r2x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461Aqbmm005942;
	Mon, 1 Jul 2024 13:34:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 402vktypwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461DYZZR52625802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 13:34:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB1762004E;
	Mon,  1 Jul 2024 13:34:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 428BE20040;
	Mon,  1 Jul 2024 13:34:35 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.5.21])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 13:34:35 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 02/11] s390/bpf: Factor out emitting probe nops
Date: Mon,  1 Jul 2024 15:24:40 +0200
Message-ID: <20240701133432.3883-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701133432.3883-1-iii@linux.ibm.com>
References: <20240701133432.3883-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N8I2qQW25-6P7OT0FwZp_GvR8oB79LRt
X-Proofpoint-ORIG-GUID: N8I2qQW25-6P7OT0FwZp_GvR8oB79LRt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010103

The upcoming arena support for the loop-based BPF_XCHG implementation
requires emitting nop and extable entries separately. Move nop handling
into a separate function, and keep track of the nop offset.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 62 +++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 4be8f5cadd02..260e7009784b 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -693,24 +693,52 @@ bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 	return true;
 }
 
+/*
+ * A single BPF probe instruction
+ */
+struct bpf_jit_probe {
+	int prg;	/* JITed instruction offset */
+	int nop_prg;	/* JITed nop offset */
+};
+
+static void bpf_jit_probe_init(struct bpf_jit_probe *probe)
+{
+	probe->prg = -1;
+	probe->nop_prg = -1;
+}
+
+/*
+ * Handlers of certain exceptions leave psw.addr pointing to the instruction
+ * directly after the failing one. Therefore, create two exception table
+ * entries and also add a nop in case two probing instructions come directly
+ * after each other.
+ */
+static void bpf_jit_probe_emit_nop(struct bpf_jit *jit,
+				   struct bpf_jit_probe *probe)
+{
+	probe->nop_prg = jit->prg;
+	/* bcr 0,%0 */
+	_EMIT2(0x0700);
+}
+
 static int bpf_jit_probe_mem(struct bpf_jit *jit, struct bpf_prog *fp,
-			     int probe_prg, int nop_prg)
+			     struct bpf_jit_probe *probe)
 {
 	struct exception_table_entry *ex;
-	int reg, prg;
+	int i, prg, reg;
 	s64 delta;
 	u8 *insn;
-	int i;
 
+	bpf_jit_probe_emit_nop(jit, probe);
 	if (!fp->aux->extable)
 		/* Do nothing during early JIT passes. */
 		return 0;
-	insn = jit->prg_buf + probe_prg;
+	insn = jit->prg_buf + probe->prg;
 	reg = get_probe_mem_regno(insn);
 	if (WARN_ON_ONCE(reg < 0))
 		/* JIT bug - unexpected probe instruction. */
 		return -1;
-	if (WARN_ON_ONCE(probe_prg + insn_length(*insn) != nop_prg))
+	if (WARN_ON_ONCE(probe->prg + insn_length(*insn) != probe->nop_prg))
 		/* JIT bug - gap between probe and nop instructions. */
 		return -1;
 	for (i = 0; i < 2; i++) {
@@ -719,7 +747,7 @@ static int bpf_jit_probe_mem(struct bpf_jit *jit, struct bpf_prog *fp,
 			return -1;
 		ex = &fp->aux->extable[jit->excnt];
 		/* Add extable entries for probe and nop instructions. */
-		prg = i == 0 ? probe_prg : nop_prg;
+		prg = i == 0 ? probe->prg : probe->nop_prg;
 		delta = jit->prg_buf + prg - (u8 *)&ex->insn;
 		if (WARN_ON_ONCE(delta < INT_MIN || delta > INT_MAX))
 			/* JIT bug - code and extable must be close. */
@@ -729,7 +757,7 @@ static int bpf_jit_probe_mem(struct bpf_jit *jit, struct bpf_prog *fp,
 		 * Always land on the nop. Note that extable infrastructure
 		 * ignores fixup field, it is handled by ex_handler_bpf().
 		 */
-		delta = jit->prg_buf + nop_prg - (u8 *)&ex->fixup;
+		delta = jit->prg_buf + probe->nop_prg - (u8 *)&ex->fixup;
 		if (WARN_ON_ONCE(delta < INT_MIN || delta > INT_MAX))
 			/* JIT bug - landing pad and extable must be close. */
 			return -1;
@@ -782,19 +810,19 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	s32 branch_oc_off = insn->off;
 	u32 dst_reg = insn->dst_reg;
 	u32 src_reg = insn->src_reg;
+	struct bpf_jit_probe probe;
 	int last, insn_count = 1;
 	u32 *addrs = jit->addrs;
 	s32 imm = insn->imm;
 	s16 off = insn->off;
-	int probe_prg = -1;
 	unsigned int mask;
-	int nop_prg;
 	int err;
 
+	bpf_jit_probe_init(&probe);
 	if (BPF_CLASS(insn->code) == BPF_LDX &&
 	    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
 	     BPF_MODE(insn->code) == BPF_PROBE_MEMSX))
-		probe_prg = jit->prg;
+		probe.prg = jit->prg;
 
 	switch (insn->code) {
 	/*
@@ -1897,18 +1925,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		return -1;
 	}
 
-	if (probe_prg != -1) {
-		/*
-		 * Handlers of certain exceptions leave psw.addr pointing to
-		 * the instruction directly after the failing one. Therefore,
-		 * create two exception table entries and also add a nop in
-		 * case two probing instructions come directly after each
-		 * other.
-		 */
-		nop_prg = jit->prg;
-		/* bcr 0,%0 */
-		_EMIT2(0x0700);
-		err = bpf_jit_probe_mem(jit, fp, probe_prg, nop_prg);
+	if (probe.prg != -1) {
+		err = bpf_jit_probe_mem(jit, fp, &probe);
 		if (err < 0)
 			return err;
 	}
-- 
2.45.2


