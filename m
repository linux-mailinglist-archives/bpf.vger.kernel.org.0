Return-Path: <bpf+bounces-41604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2160998F03
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34B61C20C74
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8C619D084;
	Thu, 10 Oct 2024 17:56:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D711991B8
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583008; cv=none; b=uxWzh9+ORuQW9TbkmPDWmLXp0HhgC7cJuh3QABTlxJBXEXXGTD1UKLeSVmJ/T53DCKSAe9DWFN7W1Ysi5I16c7s/1tAMu86lhC5AQoulPtHwO/euS3rX9eculQ4ib7q5DLe3dkl8Y+RMSdzO5+T1I18TSuBZ9WoegHv92e8+gqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583008; c=relaxed/simple;
	bh=cdO3x/5+pwKmXtQSyktuFEi8F1Obvkt9YjT61msxgW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDzAZj2HEoLFK+HX3aymgVU9ZkrT1x4YokrP27byCkBCuJ3nvtbhP5mlVElTtI7+TyCMhQCv4X7FJ3uPSdityWoorMmPBZiSpin6LMMIjcUi9XWxZo2Hgwribp3FNIamyXO7eZUV2LoUSM41ExaO0nsJicQ98QTHP+6jWWk3Qvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 79E639F27C2F; Thu, 10 Oct 2024 10:56:33 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v4 08/10] bpf, x86: Create two helpers for some arith operations
Date: Thu, 10 Oct 2024 10:56:33 -0700
Message-ID: <20241010175633.1898994-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241010175552.1895980-1-yonghong.song@linux.dev>
References: <20241010175552.1895980-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Two helpers are extracted from bpf/x86 jit:
  - a helper to handle 'reg1 <op>=3D reg2' where <op> is add/sub/and/or/x=
or
  - a helper to handle 'reg *=3D imm'

Both helpers will be used in the subsequent patch.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 51 ++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a6ba85cec49a..297dd64f4b6a 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1475,6 +1475,37 @@ static void emit_alu_helper_1(u8 **pprog, u8 insn_=
code, u32 dst_reg, s32 imm32)
 	*pprog =3D prog;
 }
=20
+/* emit ADD/SUB/AND/OR/XOR 'reg1 <op>=3D reg2' operations */
+static void emit_alu_helper_2(u8 **pprog, u8 insn_code, u32 dst_reg, u32=
 src_reg)
+{
+	u8 b2 =3D 0;
+	u8 *prog =3D *pprog;
+
+	maybe_emit_mod(&prog, dst_reg, src_reg,
+		       BPF_CLASS(insn_code) =3D=3D BPF_ALU64);
+	b2 =3D simple_alu_opcodes[BPF_OP(insn_code)];
+	EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
+
+	*pprog =3D prog;
+}
+
+/* emit 'reg *=3D imm' operations */
+static void emit_alu_helper_3(u8 **pprog, u8 insn_code, u32 dst_reg, s32=
 imm32)
+{
+	u8 *prog =3D *pprog;
+
+	maybe_emit_mod(&prog, dst_reg, dst_reg, BPF_CLASS(insn_code) =3D=3D BPF=
_ALU64);
+
+	if (is_imm8(imm32))
+		/* imul dst_reg, dst_reg, imm8 */
+		EMIT3(0x6B, add_2reg(0xC0, dst_reg, dst_reg), imm32);
+	else
+		/* imul dst_reg, dst_reg, imm32 */
+		EMIT2_off32(0x69, add_2reg(0xC0, dst_reg, dst_reg), imm32);
+
+	*pprog =3D prog;
+}
+
 static void emit_root_priv_frame_ptr(u8 **pprog, struct bpf_prog *bpf_pr=
og,
 				     u32 orig_stack_depth)
 {
@@ -1578,7 +1609,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 		const s32 imm32 =3D insn->imm;
 		u32 dst_reg =3D insn->dst_reg;
 		u32 src_reg =3D insn->src_reg;
-		u8 b2 =3D 0, b3 =3D 0;
+		u8 b3 =3D 0;
 		u8 *start_of_ldx;
 		s64 jmp_offset;
 		s16 insn_off;
@@ -1606,10 +1637,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 		case BPF_ALU64 | BPF_AND | BPF_X:
 		case BPF_ALU64 | BPF_OR | BPF_X:
 		case BPF_ALU64 | BPF_XOR | BPF_X:
-			maybe_emit_mod(&prog, dst_reg, src_reg,
-				       BPF_CLASS(insn->code) =3D=3D BPF_ALU64);
-			b2 =3D simple_alu_opcodes[BPF_OP(insn->code)];
-			EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
+			emit_alu_helper_2(&prog, insn->code, dst_reg, src_reg);
 			break;
=20
 		case BPF_ALU64 | BPF_MOV | BPF_X:
@@ -1772,18 +1800,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
=20
 		case BPF_ALU | BPF_MUL | BPF_K:
 		case BPF_ALU64 | BPF_MUL | BPF_K:
-			maybe_emit_mod(&prog, dst_reg, dst_reg,
-				       BPF_CLASS(insn->code) =3D=3D BPF_ALU64);
-
-			if (is_imm8(imm32))
-				/* imul dst_reg, dst_reg, imm8 */
-				EMIT3(0x6B, add_2reg(0xC0, dst_reg, dst_reg),
-				      imm32);
-			else
-				/* imul dst_reg, dst_reg, imm32 */
-				EMIT2_off32(0x69,
-					    add_2reg(0xC0, dst_reg, dst_reg),
-					    imm32);
+			emit_alu_helper_3(&prog, insn->code, dst_reg, imm32);
 			break;
=20
 		case BPF_ALU | BPF_MUL | BPF_X:
--=20
2.43.5


