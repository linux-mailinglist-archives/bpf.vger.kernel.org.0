Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 444A9100B12
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2019 19:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKRSEA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 13:04:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbfKRSD7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Nov 2019 13:03:59 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAII2eSp021370
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:03:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2way303pww-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:03:58 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 18 Nov 2019 18:03:56 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Nov 2019 18:03:54 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAII3rmo52101312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 18:03:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E50CDAE045;
        Mon, 18 Nov 2019 18:03:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 924A9AE055;
        Mon, 18 Nov 2019 18:03:52 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.97.207])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Nov 2019 18:03:52 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/6] s390/bpf: use relative long branches
Date:   Mon, 18 Nov 2019 19:03:35 +0100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118180340.68373-1-iii@linux.ibm.com>
References: <20191118180340.68373-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111818-0016-0000-0000-000002C713AE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111818-0017-0000-0000-00003328C67F
Message-Id: <20191118180340.68373-2-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_05:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180154
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently maximum JITed code size is limited to 64k, because JIT can
emit only relative short branches, whose range is limited by 64k in both
directions.

Teach JIT to use relative long branches. There are no compare+branch
relative long instructions, so using relative long branches consumes
more space due to having to having to emit an explicit comparison
instruction. Therefore do this only when relative short branch is not
enough.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 158 ++++++++++++++++++++++++++++-------
 1 file changed, 126 insertions(+), 32 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 7bddb27c81e3..5ee1ebc6e448 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -189,6 +189,12 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 	_EMIT4((op) | __pcrel);					\
 })
 
+#define EMIT4_PCREL_RIC(op, mask, target)			\
+({								\
+	int __rel = ((target) - jit->prg) / 2;			\
+	_EMIT4((op) | (mask) << 20 | (__rel & 0xffff));		\
+})
+
 #define _EMIT6(op1, op2)					\
 ({								\
 	if (jit->prg_buf) {					\
@@ -250,17 +256,22 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 
 #define EMIT6_PCREL_RILB(op, b, target)				\
 ({								\
-	int rel = ((target) - jit->prg) / 2;			\
+	unsigned int rel = (int)((target) - jit->prg) / 2;	\
 	_EMIT6((op) | reg_high(b) << 16 | rel >> 16, rel & 0xffff);\
 	REG_SET_SEEN(b);					\
 })
 
 #define EMIT6_PCREL_RIL(op, target)				\
 ({								\
-	int rel = ((target) - jit->prg) / 2;			\
+	unsigned int rel = (int)((target) - jit->prg) / 2;	\
 	_EMIT6((op) | rel >> 16, rel & 0xffff);			\
 })
 
+#define EMIT6_PCREL_RILC(op, mask, target)			\
+({								\
+	EMIT6_PCREL_RIL((op) | (mask) << 20, (target));		\
+})
+
 #define _EMIT6_IMM(op, imm)					\
 ({								\
 	unsigned int __imm = (imm);				\
@@ -322,6 +333,22 @@ static bool is_codegen_pass(struct bpf_jit *jit)
 	return jit->prg_buf;
 }
 
+/*
+ * Return whether "rel" can be encoded as a short PC-relative offset
+ */
+static bool is_valid_rel(int rel)
+{
+	return rel >= -65536 && rel <= 65534;
+}
+
+/*
+ * Return whether "off" can be reached using a short PC-relative offset
+ */
+static bool can_use_rel(struct bpf_jit *jit, int off)
+{
+	return is_valid_rel(off - jit->prg);
+}
+
 /*
  * Fill whole space with illegal instructions
  */
@@ -525,9 +552,9 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 				 int i, bool extra_pass)
 {
 	struct bpf_insn *insn = &fp->insnsi[i];
-	int jmp_off, last, insn_count = 1;
 	u32 dst_reg = insn->dst_reg;
 	u32 src_reg = insn->src_reg;
+	int last, insn_count = 1;
 	u32 *addrs = jit->addrs;
 	s32 imm = insn->imm;
 	s16 off = insn->off;
@@ -1071,9 +1098,17 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		/* llgf %w1,map.max_entries(%b2) */
 		EMIT6_DISP_LH(0xe3000000, 0x0016, REG_W1, REG_0, BPF_REG_2,
 			      offsetof(struct bpf_array, map.max_entries));
-		/* clrj %b3,%w1,0xa,label0: if (u32)%b3 >= (u32)%w1 goto out */
-		EMIT6_PCREL_LABEL(0xec000000, 0x0077, BPF_REG_3,
-				  REG_W1, 0, 0xa);
+		/* if ((u32)%b3 >= (u32)%w1) goto out; */
+		if (!is_first_pass(jit) && can_use_rel(jit, jit->labels[0])) {
+			/* clrj %b3,%w1,0xa,label0 */
+			EMIT6_PCREL_LABEL(0xec000000, 0x0077, BPF_REG_3,
+					  REG_W1, 0, 0xa);
+		} else {
+			/* clr %b3,%w1 */
+			EMIT2(0x1500, BPF_REG_3, REG_W1);
+			/* brcl 0xa,label0 */
+			EMIT6_PCREL_RILC(0xc0040000, 0xa, jit->labels[0]);
+		}
 
 		/*
 		 * if (tail_call_cnt++ > MAX_TAIL_CALL_CNT)
@@ -1088,9 +1123,16 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT4_IMM(0xa7080000, REG_W0, 1);
 		/* laal %w1,%w0,off(%r15) */
 		EMIT6_DISP_LH(0xeb000000, 0x00fa, REG_W1, REG_W0, REG_15, off);
-		/* clij %w1,MAX_TAIL_CALL_CNT,0x2,label0 */
-		EMIT6_PCREL_IMM_LABEL(0xec000000, 0x007f, REG_W1,
-				      MAX_TAIL_CALL_CNT, 0, 0x2);
+		if (!is_first_pass(jit) && can_use_rel(jit, jit->labels[0])) {
+			/* clij %w1,MAX_TAIL_CALL_CNT,0x2,label0 */
+			EMIT6_PCREL_IMM_LABEL(0xec000000, 0x007f, REG_W1,
+					      MAX_TAIL_CALL_CNT, 0, 0x2);
+		} else {
+			/* clfi %w1,MAX_TAIL_CALL_CNT */
+			EMIT6_IMM(0xc20f0000, REG_W1, MAX_TAIL_CALL_CNT);
+			/* brcl 0x2,label0 */
+			EMIT6_PCREL_RILC(0xc0040000, 0x2, jit->labels[0]);
+		}
 
 		/*
 		 * prog = array->ptrs[index];
@@ -1102,11 +1144,16 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT4(0xb9160000, REG_1, BPF_REG_3);
 		/* sllg %r1,%r1,3: %r1 *= 8 */
 		EMIT6_DISP_LH(0xeb000000, 0x000d, REG_1, REG_1, REG_0, 3);
-		/* lg %r1,prog(%b2,%r1) */
-		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_1, BPF_REG_2,
+		/* ltg %r1,prog(%b2,%r1) */
+		EMIT6_DISP_LH(0xe3000000, 0x0002, REG_1, BPF_REG_2,
 			      REG_1, offsetof(struct bpf_array, ptrs));
-		/* clgij %r1,0,0x8,label0 */
-		EMIT6_PCREL_IMM_LABEL(0xec000000, 0x007d, REG_1, 0, 0, 0x8);
+		if (!is_first_pass(jit) && can_use_rel(jit, jit->labels[0])) {
+			/* brc 0x8,label0 */
+			EMIT4_PCREL_RIC(0xa7040000, 0x8, jit->labels[0]);
+		} else {
+			/* brcl 0x8,label0 */
+			EMIT6_PCREL_RILC(0xc0040000, 0x8, jit->labels[0]);
+		}
 
 		/*
 		 * Restore registers before calling function
@@ -1263,36 +1310,83 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		goto branch_oc;
 branch_ks:
 		is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
-		/* lgfi %w1,imm (load sign extend imm) */
-		EMIT6_IMM(0xc0010000, REG_W1, imm);
-		/* crj or cgrj %dst,%w1,mask,off */
-		EMIT6_PCREL(0xec000000, (is_jmp32 ? 0x0076 : 0x0064),
-			    dst_reg, REG_W1, i, off, mask);
+		/* cfi or cgfi %dst,imm */
+		EMIT6_IMM(is_jmp32 ? 0xc20d0000 : 0xc20c0000,
+			  dst_reg, imm);
+		if (!is_first_pass(jit) &&
+		    can_use_rel(jit, addrs[i + off + 1])) {
+			/* brc mask,off */
+			EMIT4_PCREL_RIC(0xa7040000,
+					mask >> 12, addrs[i + off + 1]);
+		} else {
+			/* brcl mask,off */
+			EMIT6_PCREL_RILC(0xc0040000,
+					 mask >> 12, addrs[i + off + 1]);
+		}
 		break;
 branch_ku:
 		is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
-		/* lgfi %w1,imm (load sign extend imm) */
-		EMIT6_IMM(0xc0010000, REG_W1, imm);
-		/* clrj or clgrj %dst,%w1,mask,off */
-		EMIT6_PCREL(0xec000000, (is_jmp32 ? 0x0077 : 0x0065),
-			    dst_reg, REG_W1, i, off, mask);
+		/* clfi or clgfi %dst,imm */
+		EMIT6_IMM(is_jmp32 ? 0xc20f0000 : 0xc20e0000,
+			  dst_reg, imm);
+		if (!is_first_pass(jit) &&
+		    can_use_rel(jit, addrs[i + off + 1])) {
+			/* brc mask,off */
+			EMIT4_PCREL_RIC(0xa7040000,
+					mask >> 12, addrs[i + off + 1]);
+		} else {
+			/* brcl mask,off */
+			EMIT6_PCREL_RILC(0xc0040000,
+					 mask >> 12, addrs[i + off + 1]);
+		}
 		break;
 branch_xs:
 		is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
-		/* crj or cgrj %dst,%src,mask,off */
-		EMIT6_PCREL(0xec000000, (is_jmp32 ? 0x0076 : 0x0064),
-			    dst_reg, src_reg, i, off, mask);
+		if (!is_first_pass(jit) &&
+		    can_use_rel(jit, addrs[i + off + 1])) {
+			/* crj or cgrj %dst,%src,mask,off */
+			EMIT6_PCREL(0xec000000, (is_jmp32 ? 0x0076 : 0x0064),
+				    dst_reg, src_reg, i, off, mask);
+		} else {
+			/* cr or cgr %dst,%src */
+			if (is_jmp32)
+				EMIT2(0x1900, dst_reg, src_reg);
+			else
+				EMIT4(0xb9200000, dst_reg, src_reg);
+			/* brcl mask,off */
+			EMIT6_PCREL_RILC(0xc0040000,
+					 mask >> 12, addrs[i + off + 1]);
+		}
 		break;
 branch_xu:
 		is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
-		/* clrj or clgrj %dst,%src,mask,off */
-		EMIT6_PCREL(0xec000000, (is_jmp32 ? 0x0077 : 0x0065),
-			    dst_reg, src_reg, i, off, mask);
+		if (!is_first_pass(jit) &&
+		    can_use_rel(jit, addrs[i + off + 1])) {
+			/* clrj or clgrj %dst,%src,mask,off */
+			EMIT6_PCREL(0xec000000, (is_jmp32 ? 0x0077 : 0x0065),
+				    dst_reg, src_reg, i, off, mask);
+		} else {
+			/* clr or clgr %dst,%src */
+			if (is_jmp32)
+				EMIT2(0x1500, dst_reg, src_reg);
+			else
+				EMIT4(0xb9210000, dst_reg, src_reg);
+			/* brcl mask,off */
+			EMIT6_PCREL_RILC(0xc0040000,
+					 mask >> 12, addrs[i + off + 1]);
+		}
 		break;
 branch_oc:
-		/* brc mask,jmp_off (branch instruction needs 4 bytes) */
-		jmp_off = addrs[i + off + 1] - (addrs[i + 1] - 4);
-		EMIT4_PCREL(0xa7040000 | mask << 8, jmp_off);
+		if (!is_first_pass(jit) &&
+		    can_use_rel(jit, addrs[i + off + 1])) {
+			/* brc mask,off */
+			EMIT4_PCREL_RIC(0xa7040000,
+					mask >> 12, addrs[i + off + 1]);
+		} else {
+			/* brcl mask,off */
+			EMIT6_PCREL_RILC(0xc0040000,
+					 mask >> 12, addrs[i + off + 1]);
+		}
 		break;
 	}
 	default: /* too complex, give up */
-- 
2.23.0

