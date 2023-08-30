Return-Path: <bpf+bounces-8953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F42478D19A
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 03:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700F61C20A88
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 01:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372F31847;
	Wed, 30 Aug 2023 01:12:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11E15B8
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 01:12:13 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED395
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 18:12:12 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U0pR67007298;
	Wed, 30 Aug 2023 01:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AvzYheTyYU8pd9/ZBWvHXqepWMvrRJ/jS1oNiFuavJ0=;
 b=l4WCkeC7lZVEkWhaO4Pz96ugfqYPpgWm4SZuIo21c0VKX7OfoOvV9rXK7plYTed3HezY
 S3WtGyOiP3x/t7fSO2zSQgT/G1343aPJaMCbfJXS0cFUC08NxRL/yc/4ykIAWtMgOFpy
 y7TqnvjXb4QwX1FCfT/HUJXH1CzW9I6HYyDD1ZS3CHtfxRKX5tastaK0LLmis1aDdAx3
 3wydo0RRNSI4+f9OtmHYFv0D+CUy7AqC711+fRg+/gWScYf7ccGaJG5bh9RUBNZYicSf
 Yvfp0Yl2Y6g4r5x2jm5Cypxqq3FbgawZRnIhKeg3gG2bE0E002broglc9p11vlSHjY4n IA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssukagckg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:11:59 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37U11v4L009966;
	Wed, 30 Aug 2023 01:11:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7kftbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Aug 2023 01:11:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37U1BtDo19071714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Aug 2023 01:11:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76DFB2004B;
	Wed, 30 Aug 2023 01:11:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8E1F20043;
	Wed, 30 Aug 2023 01:11:54 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.5.44])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Aug 2023 01:11:54 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 09/11] s390/bpf: Implement signed division
Date: Wed, 30 Aug 2023 03:07:50 +0200
Message-ID: <20230830011128.1415752-10-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830011128.1415752-1-iii@linux.ibm.com>
References: <20230830011128.1415752-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kOYb38-3vZMcrxe4p_KuJs969RrTTn4m
X-Proofpoint-ORIG-GUID: kOYb38-3vZMcrxe4p_KuJs969RrTTn4m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement the cpuv4 signed division. It is encoded as unsigned
division, but with off field set to 1. s390x has the necessary
instructions: dsgfr, dsgf and dsgr.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 172 +++++++++++++++++++++++++----------
 1 file changed, 125 insertions(+), 47 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index b331ab013cfd..cbbb82a63975 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -949,66 +949,115 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_DIV / BPF_MOD
 	 */
-	case BPF_ALU | BPF_DIV | BPF_X: /* dst = (u32) dst / (u32) src */
-	case BPF_ALU | BPF_MOD | BPF_X: /* dst = (u32) dst % (u32) src */
+	case BPF_ALU | BPF_DIV | BPF_X:
+	case BPF_ALU | BPF_MOD | BPF_X:
 	{
 		int rc_reg = BPF_OP(insn->code) == BPF_DIV ? REG_W1 : REG_W0;
 
-		/* lhi %w0,0 */
-		EMIT4_IMM(0xa7080000, REG_W0, 0);
-		/* lr %w1,%dst */
-		EMIT2(0x1800, REG_W1, dst_reg);
-		/* dlr %w0,%src */
-		EMIT4(0xb9970000, REG_W0, src_reg);
+		switch (off) {
+		case 0: /* dst = (u32) dst {/,%} (u32) src */
+			/* xr %w0,%w0 */
+			EMIT2(0x1700, REG_W0, REG_W0);
+			/* lr %w1,%dst */
+			EMIT2(0x1800, REG_W1, dst_reg);
+			/* dlr %w0,%src */
+			EMIT4(0xb9970000, REG_W0, src_reg);
+			break;
+		case 1: /* dst = (u32) ((s32) dst {/,%} (s32) src) */
+			/* lgfr %r1,%dst */
+			EMIT4(0xb9140000, REG_W1, dst_reg);
+			/* dsgfr %r0,%src */
+			EMIT4(0xb91d0000, REG_W0, src_reg);
+			break;
+		}
 		/* llgfr %dst,%rc */
 		EMIT4(0xb9160000, dst_reg, rc_reg);
 		if (insn_is_zext(&insn[1]))
 			insn_count = 2;
 		break;
 	}
-	case BPF_ALU64 | BPF_DIV | BPF_X: /* dst = dst / src */
-	case BPF_ALU64 | BPF_MOD | BPF_X: /* dst = dst % src */
+	case BPF_ALU64 | BPF_DIV | BPF_X:
+	case BPF_ALU64 | BPF_MOD | BPF_X:
 	{
 		int rc_reg = BPF_OP(insn->code) == BPF_DIV ? REG_W1 : REG_W0;
 
-		/* lghi %w0,0 */
-		EMIT4_IMM(0xa7090000, REG_W0, 0);
-		/* lgr %w1,%dst */
-		EMIT4(0xb9040000, REG_W1, dst_reg);
-		/* dlgr %w0,%dst */
-		EMIT4(0xb9870000, REG_W0, src_reg);
+		switch (off) {
+		case 0: /* dst = dst {/,%} src */
+			/* lghi %w0,0 */
+			EMIT4_IMM(0xa7090000, REG_W0, 0);
+			/* lgr %w1,%dst */
+			EMIT4(0xb9040000, REG_W1, dst_reg);
+			/* dlgr %w0,%src */
+			EMIT4(0xb9870000, REG_W0, src_reg);
+			break;
+		case 1: /* dst = (s64) dst {/,%} (s64) src */
+			/* lgr %w1,%dst */
+			EMIT4(0xb9040000, REG_W1, dst_reg);
+			/* dsgr %w0,%src */
+			EMIT4(0xb90d0000, REG_W0, src_reg);
+			break;
+		}
 		/* lgr %dst,%rc */
 		EMIT4(0xb9040000, dst_reg, rc_reg);
 		break;
 	}
-	case BPF_ALU | BPF_DIV | BPF_K: /* dst = (u32) dst / (u32) imm */
-	case BPF_ALU | BPF_MOD | BPF_K: /* dst = (u32) dst % (u32) imm */
+	case BPF_ALU | BPF_DIV | BPF_K:
+	case BPF_ALU | BPF_MOD | BPF_K:
 	{
 		int rc_reg = BPF_OP(insn->code) == BPF_DIV ? REG_W1 : REG_W0;
 
 		if (imm == 1) {
 			if (BPF_OP(insn->code) == BPF_MOD)
-				/* lhgi %dst,0 */
+				/* lghi %dst,0 */
 				EMIT4_IMM(0xa7090000, dst_reg, 0);
 			else
 				EMIT_ZERO(dst_reg);
 			break;
 		}
-		/* lhi %w0,0 */
-		EMIT4_IMM(0xa7080000, REG_W0, 0);
-		/* lr %w1,%dst */
-		EMIT2(0x1800, REG_W1, dst_reg);
 		if (!is_first_pass(jit) && can_use_ldisp_for_lit32(jit)) {
-			/* dl %w0,<d(imm)>(%l) */
-			EMIT6_DISP_LH(0xe3000000, 0x0097, REG_W0, REG_0, REG_L,
-				      EMIT_CONST_U32(imm));
+			switch (off) {
+			case 0: /* dst = (u32) dst {/,%} (u32) imm */
+				/* xr %w0,%w0 */
+				EMIT2(0x1700, REG_W0, REG_W0);
+				/* lr %w1,%dst */
+				EMIT2(0x1800, REG_W1, dst_reg);
+				/* dl %w0,<d(imm)>(%l) */
+				EMIT6_DISP_LH(0xe3000000, 0x0097, REG_W0, REG_0,
+					      REG_L, EMIT_CONST_U32(imm));
+				break;
+			case 1: /* dst = (s32) dst {/,%} (s32) imm */
+				/* lgfr %r1,%dst */
+				EMIT4(0xb9140000, REG_W1, dst_reg);
+				/* dsgf %r0,<d(imm)>(%l) */
+				EMIT6_DISP_LH(0xe3000000, 0x001d, REG_W0, REG_0,
+					      REG_L, EMIT_CONST_U32(imm));
+				break;
+			}
 		} else {
-			/* lgfrl %dst,imm */
-			EMIT6_PCREL_RILB(0xc40c0000, dst_reg,
-					 _EMIT_CONST_U32(imm));
-			jit->seen |= SEEN_LITERAL;
-			/* dlr %w0,%dst */
-			EMIT4(0xb9970000, REG_W0, dst_reg);
+			switch (off) {
+			case 0: /* dst = (u32) dst {/,%} (u32) imm */
+				/* xr %w0,%w0 */
+				EMIT2(0x1700, REG_W0, REG_W0);
+				/* lr %w1,%dst */
+				EMIT2(0x1800, REG_W1, dst_reg);
+				/* lrl %dst,imm */
+				EMIT6_PCREL_RILB(0xc40d0000, dst_reg,
+						 _EMIT_CONST_U32(imm));
+				jit->seen |= SEEN_LITERAL;
+				/* dlr %w0,%dst */
+				EMIT4(0xb9970000, REG_W0, dst_reg);
+				break;
+			case 1: /* dst = (s32) dst {/,%} (s32) imm */
+				/* lgfr %w1,%dst */
+				EMIT4(0xb9140000, REG_W1, dst_reg);
+				/* lgfrl %dst,imm */
+				EMIT6_PCREL_RILB(0xc40c0000, dst_reg,
+						 _EMIT_CONST_U32(imm));
+				jit->seen |= SEEN_LITERAL;
+				/* dsgr %w0,%dst */
+				EMIT4(0xb90d0000, REG_W0, dst_reg);
+				break;
+			}
 		}
 		/* llgfr %dst,%rc */
 		EMIT4(0xb9160000, dst_reg, rc_reg);
@@ -1016,8 +1065,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 			insn_count = 2;
 		break;
 	}
-	case BPF_ALU64 | BPF_DIV | BPF_K: /* dst = dst / imm */
-	case BPF_ALU64 | BPF_MOD | BPF_K: /* dst = dst % imm */
+	case BPF_ALU64 | BPF_DIV | BPF_K:
+	case BPF_ALU64 | BPF_MOD | BPF_K:
 	{
 		int rc_reg = BPF_OP(insn->code) == BPF_DIV ? REG_W1 : REG_W0;
 
@@ -1027,21 +1076,50 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 				EMIT4_IMM(0xa7090000, dst_reg, 0);
 			break;
 		}
-		/* lghi %w0,0 */
-		EMIT4_IMM(0xa7090000, REG_W0, 0);
-		/* lgr %w1,%dst */
-		EMIT4(0xb9040000, REG_W1, dst_reg);
 		if (!is_first_pass(jit) && can_use_ldisp_for_lit64(jit)) {
-			/* dlg %w0,<d(imm)>(%l) */
-			EMIT6_DISP_LH(0xe3000000, 0x0087, REG_W0, REG_0, REG_L,
-				      EMIT_CONST_U64(imm));
+			switch (off) {
+			case 0: /* dst = dst {/,%} imm */
+				/* lghi %w0,0 */
+				EMIT4_IMM(0xa7090000, REG_W0, 0);
+				/* lgr %w1,%dst */
+				EMIT4(0xb9040000, REG_W1, dst_reg);
+				/* dlg %w0,<d(imm)>(%l) */
+				EMIT6_DISP_LH(0xe3000000, 0x0087, REG_W0, REG_0,
+					      REG_L, EMIT_CONST_U64(imm));
+				break;
+			case 1: /* dst = (s64) dst {/,%} (s64) imm */
+				/* lgr %w1,%dst */
+				EMIT4(0xb9040000, REG_W1, dst_reg);
+				/* dsg %w0,<d(imm)>(%l) */
+				EMIT6_DISP_LH(0xe3000000, 0x000d, REG_W0, REG_0,
+					      REG_L, EMIT_CONST_U64(imm));
+				break;
+			}
 		} else {
-			/* lgrl %dst,imm */
-			EMIT6_PCREL_RILB(0xc4080000, dst_reg,
-					 _EMIT_CONST_U64(imm));
-			jit->seen |= SEEN_LITERAL;
-			/* dlgr %w0,%dst */
-			EMIT4(0xb9870000, REG_W0, dst_reg);
+			switch (off) {
+			case 0: /* dst = dst {/,%} imm */
+				/* lghi %w0,0 */
+				EMIT4_IMM(0xa7090000, REG_W0, 0);
+				/* lgr %w1,%dst */
+				EMIT4(0xb9040000, REG_W1, dst_reg);
+				/* lgrl %dst,imm */
+				EMIT6_PCREL_RILB(0xc4080000, dst_reg,
+						 _EMIT_CONST_U64(imm));
+				jit->seen |= SEEN_LITERAL;
+				/* dlgr %w0,%dst */
+				EMIT4(0xb9870000, REG_W0, dst_reg);
+				break;
+			case 1: /* dst = (s64) dst {/,%} (s64) imm */
+				/* lgr %w1,%dst */
+				EMIT4(0xb9040000, REG_W1, dst_reg);
+				/* lgrl %dst,imm */
+				EMIT6_PCREL_RILB(0xc4080000, dst_reg,
+						 _EMIT_CONST_U64(imm));
+				jit->seen |= SEEN_LITERAL;
+				/* dsgr %w0,%dst */
+				EMIT4(0xb90d0000, REG_W0, dst_reg);
+				break;
+			}
 		}
 		/* lgr %dst,%rc */
 		EMIT4(0xb9040000, dst_reg, rc_reg);
-- 
2.41.0


