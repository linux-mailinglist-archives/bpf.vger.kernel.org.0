Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A804B404222
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 02:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbhIIAPt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 20:15:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43608 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241998AbhIIAPt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Sep 2021 20:15:49 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1890DD81015360
        for <bpf@vger.kernel.org>; Wed, 8 Sep 2021 17:14:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=w7TRqPAqerFjyTTGg5raUwBZ8EjFkcDn6a7yo46EgWw=;
 b=j0tdoxIHf9ghsLQ9bklKOLfgN8KSNGsEXo1jZb/Qq0ewEEkTzFxLg5DRYf4vVmEHysPg
 cHqOaZ0fdP4LbPSRwmsCYzjL81AMUpyNp5V4Lp5YREcCgjJDN2SjlofaDpor5agJuSNu
 QD6k2ocMcVR1olxltXrmeysi5KTe2MtlWT4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3axcny3s1p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 17:14:40 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 8 Sep 2021 17:14:38 -0700
Received: by devbig577.ftw3.facebook.com (Postfix, from userid 187975)
        id B11B47EF009E; Wed,  8 Sep 2021 17:14:31 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next] bpf,x64 Emit IMUL instead of MUL for x86-64
Date:   Wed, 8 Sep 2021 17:14:21 -0700
Message-ID: <20210909001421.4002107-1-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: wvublH9_91Fv8QO9HXUPZmwyivriEtZK
X-Proofpoint-ORIG-GUID: wvublH9_91Fv8QO9HXUPZmwyivriEtZK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_10:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 phishscore=0 mlxlogscore=960 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

IMUL allows for multiple operands and saving and storing rax/rdx is no
longer needed. Signedness of the operands doesn't matter here because
the we only keep the lower 32/64 bit of the product for 32/64 bit
multiplications.

Signed-off-by: Jie Meng <jmeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c                | 53 ++++++++++------------
 tools/testing/selftests/bpf/verifier/jit.c | 16 +++++++
 2 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 0fe6aacef3db..8580bc8f9b01 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1070,41 +1070,34 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image,
 			break;
=20
 		case BPF_ALU | BPF_MUL | BPF_K:
-		case BPF_ALU | BPF_MUL | BPF_X:
 		case BPF_ALU64 | BPF_MUL | BPF_K:
-		case BPF_ALU64 | BPF_MUL | BPF_X:
-		{
-			bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_ALU64;
+			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
+				EMIT1(add_2mod(0x48, dst_reg, dst_reg));
+			else if (is_ereg(dst_reg))
+				EMIT1(add_2mod(0x40, dst_reg, dst_reg));
=20
-			if (dst_reg !=3D BPF_REG_0)
-				EMIT1(0x50); /* push rax */
-			if (dst_reg !=3D BPF_REG_3)
-				EMIT1(0x52); /* push rdx */
+			if (is_imm8(imm32))
+				/* imul dst_reg, dst_reg, imm8 */
+				EMIT3(0x6B, add_2reg(0xC0, dst_reg, dst_reg),
+				      imm32);
+			else
+				/* imul dst_reg, dst_reg, imm32 */
+				EMIT2_off32(0x69,
+					    add_2reg(0xC0, dst_reg, dst_reg),
+					    imm32);
+			break;
=20
-			/* mov r11, dst_reg */
-			EMIT_mov(AUX_REG, dst_reg);
+		case BPF_ALU | BPF_MUL | BPF_X:
+		case BPF_ALU64 | BPF_MUL | BPF_X:
+			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
+				EMIT1(add_2mod(0x48, dst_reg, src_reg));
+			else if (is_ereg(dst_reg) || is_ereg(src_reg))
+				EMIT1(add_2mod(0x40, dst_reg, src_reg));
=20
-			if (BPF_SRC(insn->code) =3D=3D BPF_X)
-				emit_mov_reg(&prog, is64, BPF_REG_0, src_reg);
-			else
-				emit_mov_imm32(&prog, is64, BPF_REG_0, imm32);
-
-			if (is64)
-				EMIT1(add_1mod(0x48, AUX_REG));
-			else if (is_ereg(AUX_REG))
-				EMIT1(add_1mod(0x40, AUX_REG));
-			/* mul(q) r11 */
-			EMIT2(0xF7, add_1reg(0xE0, AUX_REG));
-
-			if (dst_reg !=3D BPF_REG_3)
-				EMIT1(0x5A); /* pop rdx */
-			if (dst_reg !=3D BPF_REG_0) {
-				/* mov dst_reg, rax */
-				EMIT_mov(dst_reg, BPF_REG_0);
-				EMIT1(0x58); /* pop rax */
-			}
+			/* imul dst_reg, src_reg */
+			EMIT3(0x0F, 0xAF, add_2reg(0xC0, src_reg, dst_reg));
 			break;
-		}
+
 			/* Shifts */
 		case BPF_ALU | BPF_LSH | BPF_K:
 		case BPF_ALU | BPF_RSH | BPF_K:
diff --git a/tools/testing/selftests/bpf/verifier/jit.c b/tools/testing/s=
elftests/bpf/verifier/jit.c
index df215e004566..641811b955a4 100644
--- a/tools/testing/selftests/bpf/verifier/jit.c
+++ b/tools/testing/selftests/bpf/verifier/jit.c
@@ -62,6 +62,11 @@
 	BPF_JMP_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
+	BPF_LD_IMM64(BPF_REG_3, 0xfefefeULL),
+	BPF_ALU64_IMM(BPF_MUL, BPF_REG_3, 0xefefef),
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
 	BPF_MOV32_REG(BPF_REG_2, BPF_REG_2),
 	BPF_LD_IMM64(BPF_REG_0, 0xfefefeULL),
 	BPF_ALU32_REG(BPF_MUL, BPF_REG_0, BPF_REG_1),
@@ -73,6 +78,17 @@
 	BPF_JMP_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
+	BPF_LD_IMM64(BPF_REG_3, 0xfefefeULL),
+	BPF_ALU32_IMM(BPF_MUL, BPF_REG_3, 0xefefef),
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_3, BPF_REG_2, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LD_IMM64(BPF_REG_0, 0xfefefeULL),
+	BPF_LD_IMM64(BPF_REG_2, 0x2ad4d4aaULL),
+	BPF_ALU32_IMM(BPF_MUL, BPF_REG_0, 0x2b),
+	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
 	BPF_LD_IMM64(BPF_REG_0, 0x952a7bbcULL),
 	BPF_LD_IMM64(BPF_REG_1, 0xfefefeULL),
 	BPF_LD_IMM64(BPF_REG_2, 0xeeff0d413122ULL),
--=20
2.30.2

