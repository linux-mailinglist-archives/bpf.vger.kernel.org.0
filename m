Return-Path: <bpf+bounces-33239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E152C91A23F
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B88283CC0
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838E213AD1D;
	Thu, 27 Jun 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FuEosSYs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870A13A24B
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479370; cv=none; b=PscekSaHj+AkStXEN/quRmrPBbU9fZv7pUuVjWeYDOOkmD9zXNQRVVKefes9akeGhrawYl+V5u4Nx14GTAADRRHCrdIT4uDr8Sjafu0CDEz1ggNvdd10AQD6eeI69xIdjVzjEQP1np03KXjf0TNlpISdtT5T6dzfda0dOX9LkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479370; c=relaxed/simple;
	bh=KHVyuiOOWdckOtvGuhTwIM8ou5RGdTIF3tMG7u8bB1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgDch3wQzSV8qu76zUjXxznwC186w7YmwXBCvbboC+Zpe9g3ma+2aZvSG1kNAMPQ0JrQlPBvz8ZChfam3PjhriOwQx+ZcAt0OlELR5mnA2UqHcFgt80FztUij75fL8V5Fh6vmNL6uXvROlsNvqwPsaCzrYJpd1/MXuWTld1r2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FuEosSYs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7QRlv011873;
	Thu, 27 Jun 2024 09:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=6sdU39n/bDTEu
	PRQAPm7XeXqsPWCN0GouOvlMW9e1J4=; b=FuEosSYs3HtZnZeqzqetdcaE4fsaL
	917JZQ/vfW5r18S0G+OmTIhWRG+p7FO9mlSyh12FHEm3v2n3ZdJPabrnihCcm3yJ
	E8sISG1uUrIOzlSaPeF8R4IJHClXVBYtGnXr7qrg9z/mdWD/F3h9pSQKhlD4pvjD
	toahii6Ee2uYoqJi3SmvF/UjVapUcqEwcltzGl/T71uS6PiyuMnQgdCwjunkr3yo
	VY1LiEp1IvZdJA3XDgnhmSVN3/lWFYu6ksfws/aNVRVSU13/sbRbNU1wpDJs0pjY
	b+5sCfMxy6mjRlTLPNwK+tzuaqXt74Ije9gdCVT3P/D58pcc1jv3wSrFg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4010n2gq4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R8oeKt019800;
	Thu, 27 Jun 2024 09:09:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxb5msn09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 09:09:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45R998ah33227442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 09:09:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99DD32004E;
	Thu, 27 Jun 2024 09:09:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 113392004D;
	Thu, 27 Jun 2024 09:09:08 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.16.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 09:09:07 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 08/10] s390/bpf: Support arena atomics
Date: Thu, 27 Jun 2024 11:07:11 +0200
Message-ID: <20240627090900.20017-9-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: E9RhM7tr4vIlyqYHtUGJqd-I4wEbJTPB
X-Proofpoint-GUID: E9RhM7tr4vIlyqYHtUGJqd-I4wEbJTPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406270067

s390x supports most BPF atomics using single instructions, which
makes implementing arena support a matter of adding arena address to
the base register (unfortunately atomics do not support index
registers), and wrapping the respective native instruction in probing
sequences.

An exception is BPF_XCHG, which is implemented using two different
memory accesses and a loop. Make sure there is enough extable entries
for both instructions. Compute the base address once for both memory
accesses. Since on exception we need to land after the loop, emit the
nops manually.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 100 +++++++++++++++++++++++++++++++----
 1 file changed, 91 insertions(+), 9 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 1dd359c25ada..12293689ad60 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -704,6 +704,10 @@ static void bpf_jit_probe_init(struct bpf_jit_probe *probe)
 static void bpf_jit_probe_emit_nop(struct bpf_jit *jit,
 				   struct bpf_jit_probe *probe)
 {
+	if (probe->prg == -1 || probe->nop_prg != -1)
+		/* The probe is not armed or nop is already emitted. */
+		return;
+
 	probe->nop_prg = jit->prg;
 	/* bcr 0,%0 */
 	_EMIT2(0x0700);
@@ -738,6 +742,21 @@ static void bpf_jit_probe_store_pre(struct bpf_jit *jit, struct bpf_insn *insn,
 	probe->prg = jit->prg;
 }
 
+static void bpf_jit_probe_atomic_pre(struct bpf_jit *jit,
+				     struct bpf_insn *insn,
+				     struct bpf_jit_probe *probe)
+{
+	if (BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
+		return;
+
+	/* lgrl %r1,kern_arena */
+	EMIT6_PCREL_RILB(0xc4080000, REG_W1, jit->kern_arena);
+	/* agr %r1,%dst */
+	EMIT4(0xb9080000, REG_W1, insn->dst_reg);
+	probe->arena_reg = REG_W1;
+	probe->prg = jit->prg;
+}
+
 static int bpf_jit_probe_post(struct bpf_jit *jit, struct bpf_prog *fp,
 			      struct bpf_jit_probe *probe)
 {
@@ -1523,15 +1542,30 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	 */
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
 	{
 		bool is32 = BPF_SIZE(insn->code) == BPF_W;
 
+		/*
+		 * Unlike loads and stores, atomics have only a base register,
+		 * but no index register. For the non-arena case, simply use
+		 * %dst as a base. For the arena case, use the work register
+		 * %r1: first, load the arena base into it, and then add %dst
+		 * to it.
+		 */
+		probe.arena_reg = dst_reg;
+
 		switch (insn->imm) {
-/* {op32|op64} {%w0|%src},%src,off(%dst) */
 #define EMIT_ATOMIC(op32, op64) do {					\
+	bpf_jit_probe_atomic_pre(jit, insn, &probe);			\
+	/* {op32|op64} {%w0|%src},%src,off(%arena) */			\
 	EMIT6_DISP_LH(0xeb000000, is32 ? (op32) : (op64),		\
 		      (insn->imm & BPF_FETCH) ? src_reg : REG_W0,	\
-		      src_reg, dst_reg, off);				\
+		      src_reg, probe.arena_reg, off);			\
+	err = bpf_jit_probe_post(jit, fp, &probe);			\
+	if (err < 0)							\
+		return err;						\
 	if (insn->imm & BPF_FETCH) {					\
 		/* bcr 14,0 - see atomic_fetch_{add,and,or,xor}() */	\
 		_EMIT2(0x07e0);						\
@@ -1560,25 +1594,48 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			EMIT_ATOMIC(0x00f7, 0x00e7);
 			break;
 #undef EMIT_ATOMIC
-		case BPF_XCHG:
-			/* {ly|lg} %w0,off(%dst) */
+		case BPF_XCHG: {
+			struct bpf_jit_probe load_probe = probe;
+
+			bpf_jit_probe_atomic_pre(jit, insn, &load_probe);
+			/* {ly|lg} %w0,off(%arena) */
 			EMIT6_DISP_LH(0xe3000000,
 				      is32 ? 0x0058 : 0x0004, REG_W0, REG_0,
-				      dst_reg, off);
-			/* 0: {csy|csg} %w0,%src,off(%dst) */
+				      load_probe.arena_reg, off);
+			bpf_jit_probe_emit_nop(jit, &load_probe);
+			/* Reuse {ly|lg}'s arena_reg for {csy|csg}. */
+			if (load_probe.prg != -1) {
+				probe.prg = jit->prg;
+				probe.arena_reg = load_probe.arena_reg;
+			}
+			/* 0: {csy|csg} %w0,%src,off(%arena) */
 			EMIT6_DISP_LH(0xeb000000, is32 ? 0x0014 : 0x0030,
-				      REG_W0, src_reg, dst_reg, off);
+				      REG_W0, src_reg, probe.arena_reg, off);
+			bpf_jit_probe_emit_nop(jit, &probe);
 			/* brc 4,0b */
 			EMIT4_PCREL_RIC(0xa7040000, 4, jit->prg - 6);
 			/* {llgfr|lgr} %src,%w0 */
 			EMIT4(is32 ? 0xb9160000 : 0xb9040000, src_reg, REG_W0);
+			/* Both probes should land here on exception. */
+			err = bpf_jit_probe_post(jit, fp, &load_probe);
+			if (err < 0)
+				return err;
+			err = bpf_jit_probe_post(jit, fp, &probe);
+			if (err < 0)
+				return err;
 			if (is32 && insn_is_zext(&insn[1]))
 				insn_count = 2;
 			break;
+		}
 		case BPF_CMPXCHG:
-			/* 0: {csy|csg} %b0,%src,off(%dst) */
+			bpf_jit_probe_atomic_pre(jit, insn, &probe);
+			/* 0: {csy|csg} %b0,%src,off(%arena) */
 			EMIT6_DISP_LH(0xeb000000, is32 ? 0x0014 : 0x0030,
-				      BPF_REG_0, src_reg, dst_reg, off);
+				      BPF_REG_0, src_reg,
+				      probe.arena_reg, off);
+			err = bpf_jit_probe_post(jit, fp, &probe);
+			if (err < 0)
+				return err;
 			break;
 		default:
 			pr_err("Unknown atomic operation %02x\n", insn->imm);
@@ -2142,9 +2199,25 @@ static struct bpf_binary_header *bpf_jit_alloc(struct bpf_jit *jit,
 					       struct bpf_prog *fp)
 {
 	struct bpf_binary_header *header;
+	struct bpf_insn *insn;
 	u32 extable_size;
 	u32 code_size;
+	int i;
 
+	for (i = 0; i < fp->len; i++) {
+		insn = &fp->insnsi[i];
+
+		if (BPF_CLASS(insn->code) == BPF_STX &&
+		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC &&
+		    (BPF_SIZE(insn->code) == BPF_DW ||
+		     BPF_SIZE(insn->code) == BPF_W) &&
+		    insn->imm == BPF_XCHG)
+			/*
+			 * bpf_jit_insn() emits a load and a compare-and-swap,
+			 * both of which need to be probed.
+			 */
+			fp->aux->num_exentries += 1;
+	}
 	/* We need two entries per insn. */
 	fp->aux->num_exentries *= 2;
 
@@ -2825,3 +2898,12 @@ bool bpf_jit_supports_arena(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
+{
+	/*
+	 * Currently the verifier uses this function only to check which
+	 * atomic stores to arena are supported, and they all are.
+	 */
+	return true;
+}
-- 
2.45.2


