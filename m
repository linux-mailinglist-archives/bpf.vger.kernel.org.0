Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9575941D023
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 01:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347705AbhI2XtV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 19:49:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54712 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347704AbhI2XtV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Sep 2021 19:49:21 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TNkD23006608
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 16:47:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=svfjlC5uN8hAiYtSg0l/0+aiFJrDZ5oLzUP3Sapt+HY=;
 b=G7I7bUBXaIN6MgOJ2htVsc/2BAbrBdHROENgnT8dsje5ggM0KiBAgFqAfuGdvupGhEd9
 XBTeGe3wLlWtyq5Glv5ooMxiGOGgP/5Ovhh3iz0P436BhnQySbq+oVr1zqA57EttqJu2
 uTwmQ331D3d43rmJ49khN6cWPceMoIvDVRE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bcvtk2es5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 16:47:39 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 29 Sep 2021 16:47:39 -0700
Received: by devbig577.ftw3.facebook.com (Postfix, from userid 187975)
        id DF6D99131F6E; Wed, 29 Sep 2021 16:47:32 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next] bpf,x64: Save bytes for DIV by reducing reg copies
Date:   Wed, 29 Sep 2021 16:47:02 -0700
Message-ID: <20210929234702.3927503-1-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: SVDRuUHJY_BLNjp47FgNBktNFM2-I1je
X-Proofpoint-ORIG-GUID: SVDRuUHJY_BLNjp47FgNBktNFM2-I1je
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_09,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=834
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of unconditionally performing push/pop on rax/rdx in case of
division/modulo, we can save a few bytes in case of dest register
being either BPF r0 (rax) or r3 (rdx) since the result is written in
there anyway.

Also, we do not need to copy src to r11 unless src is either rax, rdx
or an immediate.

Signed-off-by: Jie Meng <jmeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c                | 71 +++++++++++++---------
 tools/testing/selftests/bpf/verifier/jit.c | 28 +++++++++
 2 files changed, 70 insertions(+), 29 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 20d2d6a1f9de..346b4131d496 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1028,19 +1028,30 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image,
 		case BPF_ALU64 | BPF_MOD | BPF_X:
 		case BPF_ALU64 | BPF_DIV | BPF_X:
 		case BPF_ALU64 | BPF_MOD | BPF_K:
-		case BPF_ALU64 | BPF_DIV | BPF_K:
-			EMIT1(0x50); /* push rax */
-			EMIT1(0x52); /* push rdx */
-
-			if (BPF_SRC(insn->code) =3D=3D BPF_X)
-				/* mov r11, src_reg */
-				EMIT_mov(AUX_REG, src_reg);
-			else
+		case BPF_ALU64 | BPF_DIV | BPF_K: {
+			bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_ALU64;
+
+			if (dst_reg !=3D BPF_REG_0)
+				EMIT1(0x50); /* push rax */
+			if (dst_reg !=3D BPF_REG_3)
+				EMIT1(0x52); /* push rdx */
+
+			if (BPF_SRC(insn->code) =3D=3D BPF_X) {
+				if (src_reg =3D=3D BPF_REG_0 ||
+				    src_reg =3D=3D BPF_REG_3) {
+					/* mov r11, src_reg */
+					EMIT_mov(AUX_REG, src_reg);
+					src_reg =3D AUX_REG;
+				}
+			} else {
 				/* mov r11, imm32 */
 				EMIT3_off32(0x49, 0xC7, 0xC3, imm32);
+				src_reg =3D AUX_REG;
+			}
=20
-			/* mov rax, dst_reg */
-			EMIT_mov(BPF_REG_0, dst_reg);
+			if (dst_reg !=3D BPF_REG_0)
+				/* mov rax, dst_reg */
+				emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
=20
 			/*
 			 * xor edx, edx
@@ -1048,26 +1059,28 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image,
 			 */
 			EMIT2(0x31, 0xd2);
=20
-			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
-				/* div r11 */
-				EMIT3(0x49, 0xF7, 0xF3);
-			else
-				/* div r11d */
-				EMIT3(0x41, 0xF7, 0xF3);
-
-			if (BPF_OP(insn->code) =3D=3D BPF_MOD)
-				/* mov r11, rdx */
-				EMIT3(0x49, 0x89, 0xD3);
-			else
-				/* mov r11, rax */
-				EMIT3(0x49, 0x89, 0xC3);
-
-			EMIT1(0x5A); /* pop rdx */
-			EMIT1(0x58); /* pop rax */
-
-			/* mov dst_reg, r11 */
-			EMIT_mov(dst_reg, AUX_REG);
+			if (is64)
+				EMIT1(add_1mod(0x48, src_reg));
+			else if (is_ereg(src_reg))
+				EMIT1(add_1mod(0x40, src_reg));
+			/* div src_reg */
+			EMIT2(0xF7, add_1reg(0xF0, src_reg));
+
+			if (BPF_OP(insn->code) =3D=3D BPF_MOD &&
+			    dst_reg !=3D BPF_REG_3)
+				/* mov dst_reg, rdx */
+				emit_mov_reg(&prog, is64, dst_reg, BPF_REG_3);
+			else if (BPF_OP(insn->code) =3D=3D BPF_DIV &&
+				 dst_reg !=3D BPF_REG_0)
+				/* mov dst_reg, rax */
+				emit_mov_reg(&prog, is64, dst_reg, BPF_REG_0);
+
+			if (dst_reg !=3D BPF_REG_3)
+				EMIT1(0x5A); /* pop rdx */
+			if (dst_reg !=3D BPF_REG_0)
+				EMIT1(0x58); /* pop rax */
 			break;
+		}
=20
 		case BPF_ALU | BPF_MUL | BPF_K:
 		case BPF_ALU64 | BPF_MUL | BPF_K:
diff --git a/tools/testing/selftests/bpf/verifier/jit.c b/tools/testing/s=
elftests/bpf/verifier/jit.c
index eedcb752bf70..0f2583f0685a 100644
--- a/tools/testing/selftests/bpf/verifier/jit.c
+++ b/tools/testing/selftests/bpf/verifier/jit.c
@@ -102,6 +102,34 @@
 	.result =3D ACCEPT,
 	.retval =3D 2,
 },
+{
+	"jit: various div tests",
+	.insns =3D {
+	BPF_LD_IMM64(BPF_REG_2, 0xefeffeULL),
+	BPF_LD_IMM64(BPF_REG_0, 0xeeff0d413122ULL),
+	BPF_LD_IMM64(BPF_REG_1, 0xfefeeeULL),
+	BPF_ALU64_REG(BPF_DIV, BPF_REG_0, BPF_REG_1),
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LD_IMM64(BPF_REG_2, 0xaa93ULL),
+	BPF_ALU64_IMM(BPF_MOD, BPF_REG_1, 0xbeefULL),
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LD_IMM64(BPF_REG_2, 0x5ee1dULL),
+	BPF_LD_IMM64(BPF_REG_1, 0xfefeeeULL),
+	BPF_LD_IMM64(BPF_REG_3, 0x2bULL),
+	BPF_ALU32_REG(BPF_DIV, BPF_REG_1, BPF_REG_3),
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result =3D ACCEPT,
+	.retval =3D 2,
+},
 {
 	"jit: jsgt, jslt",
 	.insns =3D {
--=20
2.30.2

