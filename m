Return-Path: <bpf+bounces-33232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E8B91A237
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116E7B21190
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42D313A3E4;
	Thu, 27 Jun 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MMtAUPTW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC5139568
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479366; cv=none; b=JjJWUrOFQA3cVufcgTWKf2VHlt1PNdCiROBWSqL47NLiJhet73+E3uoBM9MEDVgh0gyFo9qKPoCMGW11k7sXphbSi7CccAjtEq8l0j9gIfnm+hhhuPfwGdmG2U+WTUviPQzTdlBM+AZb5BaeU9qFxEnqHdWE7S6osZuGXOfIf7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479366; c=relaxed/simple;
	bh=Ffnk2hnEq3iyMJwjgWXOy12DcTrsJB0dQof8gtQ7y/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFxYdNSmh+QM5h2ijqvB7MVlPMgUNtEDaOb/xG/2zwhFpmseUzNRjh3ZM6mLk0CZ2kRqNdIrNvjWdVskpge2BZRME/DsTsetc7zKuEjV53I5woSsXTUU2dgRWcb0TBcMrGfXKLAGteLyree8h+h2ImEb2wErOZIUnZrNLOwvwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MMtAUPTW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R8SNmp006576;
	Thu, 27 Jun 2024 09:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=OZJgdvap6RejD
	C2FzpnNBkCKdzEUVS7hHzbtvz+kL/E=; b=MMtAUPTWzEpi/k2JTmEOU1fID90cG
	Nq2dygWevl2OGvCYV7dSwvYJg3m+1jYAY6bNHBa4wlYMYmRiQbJofsxfiNaOjzKd
	YKwYVvC6v3u1OWdE3Kk85nM+u/PuPI8b0ZMBFkC/qRdLw0ZFLPO+Go9LjMFPy9I9
	fOGXzg61419dPIv7NznZgAH84uhl3Piad28uSwV/9jEyIAIl5+9dnPI3e2KdotJE
	KBdWZ8tBDDPIt0hVjhA0A2uCbeKJRYt4iTJLmc1KmV4BZxr9XEftayxZHqvANmy7
	9Mihe+/mM+al21/3UNUgeG1VUqWaE1pIoUlPdKfR/I8cyaSJtMuXhDzGg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4014kmg3dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R7kxG8019557;
	Thu, 27 Jun 2024 09:09:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xq9x8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R994sq54591766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:09:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF9D02005A;
	Thu, 27 Jun 2024 09:09:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B11B2004D;
	Thu, 27 Jun 2024 09:09:04 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.16.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 09:09:04 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 02/10] s390/bpf: Get rid of get_probe_mem_regno()
Date: Thu, 27 Jun 2024 11:07:05 +0200
Message-ID: <20240627090900.20017-3-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: wfkJ6nixIs5cVk_GLJe-EzJhQEC0FCbY
X-Proofpoint-GUID: wfkJ6nixIs5cVk_GLJe-EzJhQEC0FCbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxlogscore=989 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270067

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


