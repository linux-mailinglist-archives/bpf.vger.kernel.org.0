Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D864826399E
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 03:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgIJB64 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 21:58:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729161AbgIJBk1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 21:40:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089N39FT093847;
        Wed, 9 Sep 2020 19:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0ObmlIaqZCCPTCEiq1V4O0N6iHP+bfImgDug7JXh0rw=;
 b=R22iXF94MadTHojVA0JAb+NVUdqEFRpwvYiK9/6LuXWPy/haWhBHTy3c3XEtTQLURNJT
 QxBtgb6m45d/YPU5pCOeQ+OzikVHrIRhYzLM1IKI/xceD2UVch/rRu7DIp4VmHJ5HoKa
 rRpqSQvMmGwcNmHAAyYwc4bAZMxNxh6FkxoyvcjjmDm8lleSSu/IaJx+Fc0hniIEVzXX
 m8sXV4aKLOSO8LcLcVjpdqleBA+7h9TDePzudzlPSywib04jSNBzWAwa2CdrrqZPL5gn
 mgxizITqtv1h0FIgaP0SoCzdMPLai0iqiotKCJmZfQ5PD6KGbPhVEa9TcSopUN2FSl9x rA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f7nhh9h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:21:50 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089NHK7v030452;
        Wed, 9 Sep 2020 23:21:48 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 33dxdr2ggg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 23:21:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089NLjXQ29622600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 23:21:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42EA95204F;
        Wed,  9 Sep 2020 23:21:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.5.224])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DF2C752051;
        Wed,  9 Sep 2020 23:21:44 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] s390/bpf: Fix multiple tail calls
Date:   Thu, 10 Sep 2020 01:21:41 +0200
Message-Id: <20200909232141.3099367-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090202
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to branch around tail calls (due to out-of-bounds index,
exceeding tail call count or missing tail call target), JIT uses
label[0] field, which contains the address of the instruction following
the tail call. When there are multiple tail calls, label[0] value comes
from handling of a previous tail call, which is incorrect.

Fix by getting rid of label array and resolving the label address
locally: for all 3 branches that jump to it, emit 0 offsets at the
beginning, and then backpatch them with the correct value.

Also, do not use the long jump infrastructure: the tail call sequence
is known to be short, so make all 3 jumps short.

Fixes: 6651ee070b31 ("s390/bpf: implement bpf_tail_call() helper")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 61 ++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index be4b8532dd3c..0a4182792876 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -50,7 +50,6 @@ struct bpf_jit {
 	int r14_thunk_ip;	/* Address of expoline thunk for 'br %r14' */
 	int tail_call_start;	/* Tail call start offset */
 	int excnt;		/* Number of exception table entries */
-	int labels[1];		/* Labels for local jumps */
 };
 
 #define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
@@ -229,18 +228,18 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 	REG_SET_SEEN(b3);					\
 })
 
-#define EMIT6_PCREL_LABEL(op1, op2, b1, b2, label, mask)	\
+#define EMIT6_PCREL_RIEB(op1, op2, b1, b2, mask, target)	\
 ({								\
-	int rel = (jit->labels[label] - jit->prg) >> 1;		\
+	unsigned int rel = (int)((target) - jit->prg) / 2;	\
 	_EMIT6((op1) | reg(b1, b2) << 16 | (rel & 0xffff),	\
 	       (op2) | (mask) << 12);				\
 	REG_SET_SEEN(b1);					\
 	REG_SET_SEEN(b2);					\
 })
 
-#define EMIT6_PCREL_IMM_LABEL(op1, op2, b1, imm, label, mask)	\
+#define EMIT6_PCREL_RIEC(op1, op2, b1, imm, mask, target)	\
 ({								\
-	int rel = (jit->labels[label] - jit->prg) >> 1;		\
+	unsigned int rel = (int)((target) - jit->prg) / 2;	\
 	_EMIT6((op1) | (reg_high(b1) | (mask)) << 16 |		\
 		(rel & 0xffff), (op2) | ((imm) & 0xff) << 8);	\
 	REG_SET_SEEN(b1);					\
@@ -1282,7 +1281,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT4(0xb9040000, BPF_REG_0, REG_2);
 		break;
 	}
-	case BPF_JMP | BPF_TAIL_CALL:
+	case BPF_JMP | BPF_TAIL_CALL: {
+		int patch_1_clrj, patch_2_clij, patch_3_brc;
+
 		/*
 		 * Implicit input:
 		 *  B1: pointer to ctx
@@ -1300,16 +1301,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT6_DISP_LH(0xe3000000, 0x0016, REG_W1, REG_0, BPF_REG_2,
 			      offsetof(struct bpf_array, map.max_entries));
 		/* if ((u32)%b3 >= (u32)%w1) goto out; */
-		if (!is_first_pass(jit) && can_use_rel(jit, jit->labels[0])) {
-			/* clrj %b3,%w1,0xa,label0 */
-			EMIT6_PCREL_LABEL(0xec000000, 0x0077, BPF_REG_3,
-					  REG_W1, 0, 0xa);
-		} else {
-			/* clr %b3,%w1 */
-			EMIT2(0x1500, BPF_REG_3, REG_W1);
-			/* brcl 0xa,label0 */
-			EMIT6_PCREL_RILC(0xc0040000, 0xa, jit->labels[0]);
-		}
+		/* clrj %b3,%w1,0xa,out */
+		patch_1_clrj = jit->prg;
+		EMIT6_PCREL_RIEB(0xec000000, 0x0077, BPF_REG_3, REG_W1, 0xa,
+				 jit->prg);
 
 		/*
 		 * if (tail_call_cnt++ > MAX_TAIL_CALL_CNT)
@@ -1324,16 +1319,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT4_IMM(0xa7080000, REG_W0, 1);
 		/* laal %w1,%w0,off(%r15) */
 		EMIT6_DISP_LH(0xeb000000, 0x00fa, REG_W1, REG_W0, REG_15, off);
-		if (!is_first_pass(jit) && can_use_rel(jit, jit->labels[0])) {
-			/* clij %w1,MAX_TAIL_CALL_CNT,0x2,label0 */
-			EMIT6_PCREL_IMM_LABEL(0xec000000, 0x007f, REG_W1,
-					      MAX_TAIL_CALL_CNT, 0, 0x2);
-		} else {
-			/* clfi %w1,MAX_TAIL_CALL_CNT */
-			EMIT6_IMM(0xc20f0000, REG_W1, MAX_TAIL_CALL_CNT);
-			/* brcl 0x2,label0 */
-			EMIT6_PCREL_RILC(0xc0040000, 0x2, jit->labels[0]);
-		}
+		/* clij %w1,MAX_TAIL_CALL_CNT,0x2,out */
+		patch_2_clij = jit->prg;
+		EMIT6_PCREL_RIEC(0xec000000, 0x007f, REG_W1, MAX_TAIL_CALL_CNT,
+				 2, jit->prg);
 
 		/*
 		 * prog = array->ptrs[index];
@@ -1348,13 +1337,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* ltg %r1,prog(%b2,%r1) */
 		EMIT6_DISP_LH(0xe3000000, 0x0002, REG_1, BPF_REG_2,
 			      REG_1, offsetof(struct bpf_array, ptrs));
-		if (!is_first_pass(jit) && can_use_rel(jit, jit->labels[0])) {
-			/* brc 0x8,label0 */
-			EMIT4_PCREL_RIC(0xa7040000, 0x8, jit->labels[0]);
-		} else {
-			/* brcl 0x8,label0 */
-			EMIT6_PCREL_RILC(0xc0040000, 0x8, jit->labels[0]);
-		}
+		/* brc 0x8,out */
+		patch_3_brc = jit->prg;
+		EMIT4_PCREL_RIC(0xa7040000, 8, jit->prg);
 
 		/*
 		 * Restore registers before calling function
@@ -1371,8 +1356,16 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* bc 0xf,tail_call_start(%r1) */
 		_EMIT4(0x47f01000 + jit->tail_call_start);
 		/* out: */
-		jit->labels[0] = jit->prg;
+		if (jit->prg_buf) {
+			*(u16 *)(jit->prg_buf + patch_1_clrj + 2) =
+				(jit->prg - patch_1_clrj) >> 1;
+			*(u16 *)(jit->prg_buf + patch_2_clij + 2) =
+				(jit->prg - patch_2_clij) >> 1;
+			*(u16 *)(jit->prg_buf + patch_3_brc + 2) =
+				(jit->prg - patch_3_brc) >> 1;
+		}
 		break;
+	}
 	case BPF_JMP | BPF_EXIT: /* return b0 */
 		last = (i == fp->len - 1) ? 1 : 0;
 		if (last)
-- 
2.25.4

