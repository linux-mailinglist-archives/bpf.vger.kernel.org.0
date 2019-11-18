Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF839100B16
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2019 19:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfKRSEY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 13:04:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbfKRSEY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Nov 2019 13:04:24 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAII2bNX087849
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:04:23 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2way8mhs7b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:04:23 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 18 Nov 2019 18:04:20 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Nov 2019 18:04:17 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAII4GMD53215482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 18:04:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC9BEAE059;
        Mon, 18 Nov 2019 18:04:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A22ABAE045;
        Mon, 18 Nov 2019 18:04:15 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.97.207])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Nov 2019 18:04:15 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 5/6] s390/bpf: use lg(f)rl when long displacement cannot be used
Date:   Mon, 18 Nov 2019 19:03:39 +0100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118180340.68373-1-iii@linux.ibm.com>
References: <20191118180340.68373-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111818-0020-0000-0000-000003899D20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111818-0021-0000-0000-000021DFC551
Message-Id: <20191118180340.68373-6-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_05:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180154
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If literal pool grows past 524287 mark, it's no longer possible to use
long displacement to reference literal pool entries. In JIT setting
maintaining multiple literal pool registers is next to impossible, since
we operate on one instruction at a time.

Therefore, fall back to loading literal pool entry using PC-relative
addressing, and then using a register-register form of the following
machine instruction.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 96 ++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 15 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 6b3f85e4c5b0..3398cd939496 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -371,6 +371,24 @@ static bool is_valid_ldisp(int disp)
 	return disp >= -524288 && disp <= 524287;
 }
 
+/*
+ * Return whether the next 32-bit literal pool entry can be referenced using
+ * Long-Displacement Facility
+ */
+static bool can_use_ldisp_for_lit32(struct bpf_jit *jit)
+{
+	return is_valid_ldisp(jit->lit32 - jit->base_ip);
+}
+
+/*
+ * Return whether the next 64-bit literal pool entry can be referenced using
+ * Long-Displacement Facility
+ */
+static bool can_use_ldisp_for_lit64(struct bpf_jit *jit)
+{
+	return is_valid_ldisp(jit->lit64 - jit->base_ip);
+}
+
 /*
  * Fill whole space with illegal instructions
  */
@@ -752,9 +770,18 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT4_IMM(0xa7080000, REG_W0, 0);
 		/* lr %w1,%dst */
 		EMIT2(0x1800, REG_W1, dst_reg);
-		/* dl %w0,<d(imm)>(%l) */
-		EMIT6_DISP_LH(0xe3000000, 0x0097, REG_W0, REG_0, REG_L,
-			      EMIT_CONST_U32(imm));
+		if (!is_first_pass(jit) && can_use_ldisp_for_lit32(jit)) {
+			/* dl %w0,<d(imm)>(%l) */
+			EMIT6_DISP_LH(0xe3000000, 0x0097, REG_W0, REG_0, REG_L,
+				      EMIT_CONST_U32(imm));
+		} else {
+			/* lgfrl %dst,imm */
+			EMIT6_PCREL_RILB(0xc40c0000, dst_reg,
+					 _EMIT_CONST_U32(imm));
+			jit->seen |= SEEN_LITERAL;
+			/* dlr %w0,%dst */
+			EMIT4(0xb9970000, REG_W0, dst_reg);
+		}
 		/* llgfr %dst,%rc */
 		EMIT4(0xb9160000, dst_reg, rc_reg);
 		if (insn_is_zext(&insn[1]))
@@ -776,9 +803,18 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT4_IMM(0xa7090000, REG_W0, 0);
 		/* lgr %w1,%dst */
 		EMIT4(0xb9040000, REG_W1, dst_reg);
-		/* dlg %w0,<d(imm)>(%l) */
-		EMIT6_DISP_LH(0xe3000000, 0x0087, REG_W0, REG_0, REG_L,
-			      EMIT_CONST_U64(imm));
+		if (!is_first_pass(jit) && can_use_ldisp_for_lit64(jit)) {
+			/* dlg %w0,<d(imm)>(%l) */
+			EMIT6_DISP_LH(0xe3000000, 0x0087, REG_W0, REG_0, REG_L,
+				      EMIT_CONST_U64(imm));
+		} else {
+			/* lgrl %dst,imm */
+			EMIT6_PCREL_RILB(0xc4080000, dst_reg,
+					 _EMIT_CONST_U64(imm));
+			jit->seen |= SEEN_LITERAL;
+			/* dlgr %w0,%dst */
+			EMIT4(0xb9870000, REG_W0, dst_reg);
+		}
 		/* lgr %dst,%rc */
 		EMIT4(0xb9040000, dst_reg, rc_reg);
 		break;
@@ -801,9 +837,19 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT_ZERO(dst_reg);
 		break;
 	case BPF_ALU64 | BPF_AND | BPF_K: /* dst = dst & imm */
-		/* ng %dst,<d(imm)>(%l) */
-		EMIT6_DISP_LH(0xe3000000, 0x0080, dst_reg, REG_0, REG_L,
-			      EMIT_CONST_U64(imm));
+		if (!is_first_pass(jit) && can_use_ldisp_for_lit64(jit)) {
+			/* ng %dst,<d(imm)>(%l) */
+			EMIT6_DISP_LH(0xe3000000, 0x0080,
+				      dst_reg, REG_0, REG_L,
+				      EMIT_CONST_U64(imm));
+		} else {
+			/* lgrl %w0,imm */
+			EMIT6_PCREL_RILB(0xc4080000, REG_W0,
+					 _EMIT_CONST_U64(imm));
+			jit->seen |= SEEN_LITERAL;
+			/* ngr %dst,%w0 */
+			EMIT4(0xb9800000, dst_reg, REG_W0);
+		}
 		break;
 	/*
 	 * BPF_OR
@@ -823,9 +869,19 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT_ZERO(dst_reg);
 		break;
 	case BPF_ALU64 | BPF_OR | BPF_K: /* dst = dst | imm */
-		/* og %dst,<d(imm)>(%l) */
-		EMIT6_DISP_LH(0xe3000000, 0x0081, dst_reg, REG_0, REG_L,
-			      EMIT_CONST_U64(imm));
+		if (!is_first_pass(jit) && can_use_ldisp_for_lit64(jit)) {
+			/* og %dst,<d(imm)>(%l) */
+			EMIT6_DISP_LH(0xe3000000, 0x0081,
+				      dst_reg, REG_0, REG_L,
+				      EMIT_CONST_U64(imm));
+		} else {
+			/* lgrl %w0,imm */
+			EMIT6_PCREL_RILB(0xc4080000, REG_W0,
+					 _EMIT_CONST_U64(imm));
+			jit->seen |= SEEN_LITERAL;
+			/* ogr %dst,%w0 */
+			EMIT4(0xb9810000, dst_reg, REG_W0);
+		}
 		break;
 	/*
 	 * BPF_XOR
@@ -847,9 +903,19 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		EMIT_ZERO(dst_reg);
 		break;
 	case BPF_ALU64 | BPF_XOR | BPF_K: /* dst = dst ^ imm */
-		/* xg %dst,<d(imm)>(%l) */
-		EMIT6_DISP_LH(0xe3000000, 0x0082, dst_reg, REG_0, REG_L,
-			      EMIT_CONST_U64(imm));
+		if (!is_first_pass(jit) && can_use_ldisp_for_lit64(jit)) {
+			/* xg %dst,<d(imm)>(%l) */
+			EMIT6_DISP_LH(0xe3000000, 0x0082,
+				      dst_reg, REG_0, REG_L,
+				      EMIT_CONST_U64(imm));
+		} else {
+			/* lgrl %w0,imm */
+			EMIT6_PCREL_RILB(0xc4080000, REG_W0,
+					 _EMIT_CONST_U64(imm));
+			jit->seen |= SEEN_LITERAL;
+			/* xgr %dst,%w0 */
+			EMIT4(0xb9820000, dst_reg, REG_W0);
+		}
 		break;
 	/*
 	 * BPF_LSH
-- 
2.23.0

