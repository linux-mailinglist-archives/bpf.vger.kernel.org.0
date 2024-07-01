Return-Path: <bpf+bounces-33495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4691A91E0D4
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 15:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E5F1C2152E
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 13:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D9715EFB9;
	Mon,  1 Jul 2024 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l9mWOujH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EED15EFAE
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840903; cv=none; b=Kq1sncML2coAQ6m6yCUb9qwfuFOKJF+GFV3+e65zngWnVWxuUoM5vY9w3t8Wo0SRK9jNkA0eXwGyuXuQipW/OEOVUmoWxMO/TUpSvtVQ8zUq0vxOdbQRkinZWfBFjKXJfSZchElocZl+j8ctDPpcyQ67tyGD5ncbq4sID+eb1Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840903; c=relaxed/simple;
	bh=tDfbsJr2Wj4l/V/O0HNh+rtfb9JY7HWBj9lNkaGq3HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTCu20+3u9/04iVw0bl1W3u/pW4Ri0IlHXYjvXFQTS8Ik98bok/aNzsPN0gGE3U4zTu1S5X+7pgsl388ZsUB99ObyqPmBH3Q5RqtQ0jr7sOOYqnS/0q64JL42SBZ3GvGycuMcLF7uvNjKo6oDmQvWG1QfvG67NWUDF9esCziFj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l9mWOujH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461DU5Ii006511;
	Mon, 1 Jul 2024 13:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=tGmcXuCEj7NPl
	lKyx0NUh4Kli92yqGFjz0BVeoEnw7M=; b=l9mWOujHuYA1UWRl8AEeisaar5KhV
	YTsBibiVpciGfOmSBQ2HNN0BNz3yevyCsv2KPquUM6Ujj914cLMFdPbjp7bQcTsB
	ZI0pudfcOdh5fPAh+R3AFnO+sxuaWyIta3fbym4UBCfmLnoU9LU5tzr2j5Y25etW
	7vWUKi7KvQ+hV4bmSEnCCZ5/hDsNhJDS6b13wQNtOpZ8kB6vHFY9V26C5MOhQWxC
	hKIzlbprpOC+dDFeuny4DGIbXR9Re2xkPlsZRLIhWKZ6FJbkym8/4V8mX/yAyTLL
	025K+4bd42PCEK40pbjHGAVr52hv580aXwmMDH6eheeoldnnEhwmQMYFg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403wcgr0gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 461C05f9026393;
	Mon, 1 Jul 2024 13:34:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkpqerb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 13:34:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461DYbjq53150148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 13:34:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 139592004B;
	Mon,  1 Jul 2024 13:34:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F1CD20040;
	Mon,  1 Jul 2024 13:34:36 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.5.21])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 13:34:36 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 04/11] s390/bpf: Introduce pre- and post- probe functions
Date: Mon,  1 Jul 2024 15:24:42 +0200
Message-ID: <20240701133432.3883-5-iii@linux.ibm.com>
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
X-Proofpoint-GUID: mJ75fvbM8BLQ9kO6uM7hyaQzkqlJ7zdH
X-Proofpoint-ORIG-GUID: mJ75fvbM8BLQ9kO6uM7hyaQzkqlJ7zdH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010103

Currently probe insns are handled by two "if" statements at the
beginning and at the end of bpf_jit_insn(). The first one needs to be
in sync with the huge insn->code statement that follows it, which was
not a problem so far, since the check is small.

The introduction of arena will make it significantly larger, and it
will no longer be obvious whether it is in sync with the opcode switch.

Move these statements to the new bpf_jit_probe_load_pre() and
bpf_jit_probe_post() functions, and call them only from cases that need
them.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 58 +++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index d9d79aa2be1b..582fa3830772 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -704,14 +704,28 @@ static void bpf_jit_probe_emit_nop(struct bpf_jit *jit,
 	_EMIT2(0x0700);
 }
 
-static int bpf_jit_probe_mem(struct bpf_jit *jit, struct bpf_prog *fp,
-			     struct bpf_jit_probe *probe)
+static void bpf_jit_probe_load_pre(struct bpf_jit *jit, struct bpf_insn *insn,
+				   struct bpf_jit_probe *probe)
+{
+	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
+	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX)
+		return;
+
+	probe->prg = jit->prg;
+	probe->reg = reg2hex[insn->dst_reg];
+}
+
+static int bpf_jit_probe_post(struct bpf_jit *jit, struct bpf_prog *fp,
+			      struct bpf_jit_probe *probe)
 {
 	struct exception_table_entry *ex;
 	int i, prg;
 	s64 delta;
 	u8 *insn;
 
+	if (probe->prg == -1)
+		/* The probe is not armed. */
+		return 0;
 	bpf_jit_probe_emit_nop(jit, probe);
 	if (!fp->aux->extable)
 		/* Do nothing during early JIT passes. */
@@ -798,12 +812,6 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	int err;
 
 	bpf_jit_probe_init(&probe);
-	if (BPF_CLASS(insn->code) == BPF_LDX &&
-	    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
-	     BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
-		probe.prg = jit->prg;
-		probe.reg = reg2hex[dst_reg];
-	}
 
 	switch (insn->code) {
 	/*
@@ -1497,51 +1505,79 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	 */
 	case BPF_LDX | BPF_MEM | BPF_B: /* dst = *(u8 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEM | BPF_B:
+		bpf_jit_probe_load_pre(jit, insn, &probe);
 		/* llgc %dst,0(off,%src) */
 		EMIT6_DISP_LH(0xe3000000, 0x0090, dst_reg, src_reg, REG_0, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		jit->seen |= SEEN_MEM;
 		if (insn_is_zext(&insn[1]))
 			insn_count = 2;
 		break;
 	case BPF_LDX | BPF_MEMSX | BPF_B: /* dst = *(s8 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
+		bpf_jit_probe_load_pre(jit, insn, &probe);
 		/* lgb %dst,0(off,%src) */
 		EMIT6_DISP_LH(0xe3000000, 0x0077, dst_reg, src_reg, REG_0, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		jit->seen |= SEEN_MEM;
 		break;
 	case BPF_LDX | BPF_MEM | BPF_H: /* dst = *(u16 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEM | BPF_H:
+		bpf_jit_probe_load_pre(jit, insn, &probe);
 		/* llgh %dst,0(off,%src) */
 		EMIT6_DISP_LH(0xe3000000, 0x0091, dst_reg, src_reg, REG_0, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		jit->seen |= SEEN_MEM;
 		if (insn_is_zext(&insn[1]))
 			insn_count = 2;
 		break;
 	case BPF_LDX | BPF_MEMSX | BPF_H: /* dst = *(s16 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
+		bpf_jit_probe_load_pre(jit, insn, &probe);
 		/* lgh %dst,0(off,%src) */
 		EMIT6_DISP_LH(0xe3000000, 0x0015, dst_reg, src_reg, REG_0, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		jit->seen |= SEEN_MEM;
 		break;
 	case BPF_LDX | BPF_MEM | BPF_W: /* dst = *(u32 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEM | BPF_W:
+		bpf_jit_probe_load_pre(jit, insn, &probe);
 		/* llgf %dst,off(%src) */
 		jit->seen |= SEEN_MEM;
 		EMIT6_DISP_LH(0xe3000000, 0x0016, dst_reg, src_reg, REG_0, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		if (insn_is_zext(&insn[1]))
 			insn_count = 2;
 		break;
 	case BPF_LDX | BPF_MEMSX | BPF_W: /* dst = *(s32 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
+		bpf_jit_probe_load_pre(jit, insn, &probe);
 		/* lgf %dst,off(%src) */
 		jit->seen |= SEEN_MEM;
 		EMIT6_DISP_LH(0xe3000000, 0x0014, dst_reg, src_reg, REG_0, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		break;
 	case BPF_LDX | BPF_MEM | BPF_DW: /* dst = *(u64 *)(ul) (src + off) */
 	case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
+		bpf_jit_probe_load_pre(jit, insn, &probe);
 		/* lg %dst,0(off,%src) */
 		jit->seen |= SEEN_MEM;
 		EMIT6_DISP_LH(0xe3000000, 0x0004, dst_reg, src_reg, REG_0, off);
+		err = bpf_jit_probe_post(jit, fp, &probe);
+		if (err < 0)
+			return err;
 		break;
 	/*
 	 * BPF_JMP / CALL
@@ -1906,12 +1942,6 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		return -1;
 	}
 
-	if (probe.prg != -1) {
-		err = bpf_jit_probe_mem(jit, fp, &probe);
-		if (err < 0)
-			return err;
-	}
-
 	return insn_count;
 }
 
-- 
2.45.2


