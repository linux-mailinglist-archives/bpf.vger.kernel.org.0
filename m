Return-Path: <bpf+bounces-33234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B09D91A23A
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBDB1B21190
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16CC13A41A;
	Thu, 27 Jun 2024 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R+2I9AKg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E831386D1
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479367; cv=none; b=MometuPDbbF2vG0xAQKJrQs6+ojDyWzorLSnLtyBqp1s1Q/xBpcxi5HtoNW9DG5jrbodLrWUvsAMtHRYzdPPGI3oqUZtlyh+IST4ERD1sBxmR0fQ0cITD1i0VHu/hulK0OGR/jukTfINgFVpIVsZ0LoUGa5/AxHjs0KoOqOsdns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479367; c=relaxed/simple;
	bh=7vUFpdXKxcptrM2tclmEQfIuuHbOk1MbfSyCLdfmYUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ct2Txz/fk7Sit4ZzhmvKetg6rHz10CLrkkMWGptensrDunE7dgV+jWHZsGgdK15x/kEnNl8BnaVUpQKfEn8JSZ+wSI4X4CJ88swo2ktK1LSdXGn51jGvdG1HxCfPa3yq53oJRzinsm2i8VePdwF3AXRrMIXmsoGHuc6bl/O3uS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R+2I9AKg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R5ux5Y003025;
	Thu, 27 Jun 2024 09:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=buLkbpIBzE25b
	1vaxtzm68BWFHVhO+sceqfrPUWlQRk=; b=R+2I9AKg2bthW+/rR6Or9o+UmSaOL
	4BoP8fIwTJ4Z0yE93t7GVKl7siezgVsY1oSU990T5I+dQPoaSfdioAt69ffNTi6/
	EwVjnGTjEeT7rMRHiKT3Bcr1xlwx+4L0fC0SS+O3zBzX0FQ9oKhi/zQYb0XDtfuW
	ELfyOeA5pxkYliSWLYRasN6S0qYVfNacNLAFTyp0tuS6OL3h1VwfGoj6ErVxtb9T
	JMvtB3+yhEqp2hSAC23fgAJFG/Kkkb9jWSngCDhyCCX1xkT5X9BR2+ZbIwMH+pWV
	mP1qYWEQT1lBOaoOEosbePwH/TBmD4g3sfH3yz/u0iYuqs4J6UpVZplQQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4011358mhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R8PxK2000616;
	Thu, 27 Jun 2024 09:09:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaen9tby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R9945328967380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:09:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 121862004F;
	Thu, 27 Jun 2024 09:09:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 814512004D;
	Thu, 27 Jun 2024 09:09:03 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.16.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 09:09:03 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 01/10] s390/bpf: Factor out emitting probe nops
Date: Thu, 27 Jun 2024 11:07:04 +0200
Message-ID: <20240627090900.20017-2-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 95MbQslo3DwlZiP0Hs9ffJZUHlVZpeTp
X-Proofpoint-GUID: 95MbQslo3DwlZiP0Hs9ffJZUHlVZpeTp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270067

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


