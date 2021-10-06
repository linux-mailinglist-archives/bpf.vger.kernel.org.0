Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48562424757
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 21:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbhJFTnr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 15:43:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3226 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239658AbhJFTnk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 15:43:40 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196JVGrs031470
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 12:41:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=kgxqvcV15zocba8bbgkK7zlAYT5SNN/7XAfHPyNrhzA=;
 b=egNDmmBaChFvLJvLqqFiPMp+hAikjYOxsm7T2yl0CvRzbMrHlkmjhXc5Ok3S3xVYQrVQ
 dsqztTG3ExblmmSJp2BUegm06VT+JWXstuQMCsJ23Fy4GRUx/eWn8NWXinQwZFOBGmMS
 DG7bLDUXEy3Ee3mqVLmjPiR/IpJD63sxjJw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhetf9wgh-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 12:41:47 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 12:41:45 -0700
Received: by devbig577.ftw3.facebook.com (Postfix, from userid 187975)
        id 7944297DF19D; Wed,  6 Oct 2021 12:41:41 -0700 (PDT)
From:   Jie Meng <jmeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Jie Meng <jmeng@fb.com>
Subject: [PATCH bpf-next] bpf,x64: Factor out emission of REX byte in more cases
Date:   Wed, 6 Oct 2021 12:41:35 -0700
Message-ID: <20211006194135.608932-1-jmeng@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: jG8mkWr6TYlhler9xLRoswCKzqZKpnNP
X-Proofpoint-ORIG-GUID: jG8mkWr6TYlhler9xLRoswCKzqZKpnNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=937 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a single reg version of maybe_emit_mod() and factor out
common code in more cases.

Signed-off-by: Jie Meng <jmeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 67 +++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5a0edea3cc2e..e474718d152b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -721,6 +721,20 @@ static void maybe_emit_mod(u8 **pprog, u32 dst_reg, =
u32 src_reg, bool is64)
 	*pprog =3D prog;
 }
=20
+/*
+ * Similar version of maybe_emit_mod() for a single register
+ */
+static void maybe_emit_1mod(u8 **pprog, u32 reg, bool is64)
+{
+	u8 *prog =3D *pprog;
+
+	if (is64)
+		EMIT1(add_1mod(0x48, reg));
+	else if (is_ereg(reg))
+		EMIT1(add_1mod(0x40, reg));
+	*pprog =3D prog;
+}
+
 /* LDX: dst_reg =3D *(u8*)(src_reg + off) */
 static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int=
 off)
 {
@@ -951,10 +965,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *ad=
drs, u8 *image,
 			/* neg dst */
 		case BPF_ALU | BPF_NEG:
 		case BPF_ALU64 | BPF_NEG:
-			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
-				EMIT1(add_1mod(0x48, dst_reg));
-			else if (is_ereg(dst_reg))
-				EMIT1(add_1mod(0x40, dst_reg));
+			maybe_emit_1mod(&prog, dst_reg,
+					BPF_CLASS(insn->code) =3D=3D BPF_ALU64);
 			EMIT2(0xF7, add_1reg(0xD8, dst_reg));
 			break;
=20
@@ -968,10 +980,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *ad=
drs, u8 *image,
 		case BPF_ALU64 | BPF_AND | BPF_K:
 		case BPF_ALU64 | BPF_OR | BPF_K:
 		case BPF_ALU64 | BPF_XOR | BPF_K:
-			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
-				EMIT1(add_1mod(0x48, dst_reg));
-			else if (is_ereg(dst_reg))
-				EMIT1(add_1mod(0x40, dst_reg));
+			maybe_emit_1mod(&prog, dst_reg,
+					BPF_CLASS(insn->code) =3D=3D BPF_ALU64);
=20
 			/*
 			 * b3 holds 'normal' opcode, b2 short form only valid
@@ -1059,11 +1069,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image,
 			 */
 			EMIT2(0x31, 0xd2);
=20
-			if (is64)
-				EMIT1(add_1mod(0x48, src_reg));
-			else if (is_ereg(src_reg))
-				EMIT1(add_1mod(0x40, src_reg));
 			/* div src_reg */
+			maybe_emit_1mod(&prog, src_reg, is64);
 			EMIT2(0xF7, add_1reg(0xF0, src_reg));
=20
 			if (BPF_OP(insn->code) =3D=3D BPF_MOD &&
@@ -1084,10 +1091,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image,
=20
 		case BPF_ALU | BPF_MUL | BPF_K:
 		case BPF_ALU64 | BPF_MUL | BPF_K:
-			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
-				EMIT1(add_2mod(0x48, dst_reg, dst_reg));
-			else if (is_ereg(dst_reg))
-				EMIT1(add_2mod(0x40, dst_reg, dst_reg));
+			maybe_emit_mod(&prog, dst_reg, dst_reg,
+				       BPF_CLASS(insn->code) =3D=3D BPF_ALU64);
=20
 			if (is_imm8(imm32))
 				/* imul dst_reg, dst_reg, imm8 */
@@ -1102,10 +1107,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image,
=20
 		case BPF_ALU | BPF_MUL | BPF_X:
 		case BPF_ALU64 | BPF_MUL | BPF_X:
-			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
-				EMIT1(add_2mod(0x48, src_reg, dst_reg));
-			else if (is_ereg(dst_reg) || is_ereg(src_reg))
-				EMIT1(add_2mod(0x40, src_reg, dst_reg));
+			maybe_emit_mod(&prog, src_reg, dst_reg,
+				       BPF_CLASS(insn->code) =3D=3D BPF_ALU64);
=20
 			/* imul dst_reg, src_reg */
 			EMIT3(0x0F, 0xAF, add_2reg(0xC0, src_reg, dst_reg));
@@ -1118,10 +1121,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image,
 		case BPF_ALU64 | BPF_LSH | BPF_K:
 		case BPF_ALU64 | BPF_RSH | BPF_K:
 		case BPF_ALU64 | BPF_ARSH | BPF_K:
-			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
-				EMIT1(add_1mod(0x48, dst_reg));
-			else if (is_ereg(dst_reg))
-				EMIT1(add_1mod(0x40, dst_reg));
+			maybe_emit_1mod(&prog, dst_reg,
+					BPF_CLASS(insn->code) =3D=3D BPF_ALU64);
=20
 			b3 =3D simple_alu_opcodes[BPF_OP(insn->code)];
 			if (imm32 =3D=3D 1)
@@ -1152,10 +1153,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image,
 			}
=20
 			/* shl %rax, %cl | shr %rax, %cl | sar %rax, %cl */
-			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
-				EMIT1(add_1mod(0x48, dst_reg));
-			else if (is_ereg(dst_reg))
-				EMIT1(add_1mod(0x40, dst_reg));
+			maybe_emit_1mod(&prog, dst_reg,
+					BPF_CLASS(insn->code) =3D=3D BPF_ALU64);
=20
 			b3 =3D simple_alu_opcodes[BPF_OP(insn->code)];
 			EMIT2(0xD3, add_1reg(b3, dst_reg));
@@ -1465,10 +1464,8 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_JSET | BPF_K:
 		case BPF_JMP32 | BPF_JSET | BPF_K:
 			/* test dst_reg, imm32 */
-			if (BPF_CLASS(insn->code) =3D=3D BPF_JMP)
-				EMIT1(add_1mod(0x48, dst_reg));
-			else if (is_ereg(dst_reg))
-				EMIT1(add_1mod(0x40, dst_reg));
+			maybe_emit_1mod(&prog, dst_reg,
+					BPF_CLASS(insn->code) =3D=3D BPF_JMP);
 			EMIT2_off32(0xF7, add_1reg(0xC0, dst_reg), imm32);
 			goto emit_cond_jmp;
=20
@@ -1501,10 +1498,8 @@ st:			if (is_imm8(insn->off))
 			}
=20
 			/* cmp dst_reg, imm8/32 */
-			if (BPF_CLASS(insn->code) =3D=3D BPF_JMP)
-				EMIT1(add_1mod(0x48, dst_reg));
-			else if (is_ereg(dst_reg))
-				EMIT1(add_1mod(0x40, dst_reg));
+			maybe_emit_1mod(&prog, dst_reg,
+					BPF_CLASS(insn->code) =3D=3D BPF_JMP);
=20
 			if (is_imm8(imm32))
 				EMIT3(0x83, add_1reg(0xF8, dst_reg), imm32);
--=20
2.30.2

