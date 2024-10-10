Return-Path: <bpf+bounces-41601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275ED998F00
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92441F25CA1
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C5B1CCEE0;
	Thu, 10 Oct 2024 17:56:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5E1C9B79
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582982; cv=none; b=cy8vm2bQKLSe21NaPpiSmT0IxtgoCyVDi9hN/qw8GR2PpAwqHB0YAoqsF0JGQCfKIB0cFwm730CpAMST/jSsVquD7VOY5bP8umDqSxFJSSu6Ol+loLzofmiN7S//BlKcjGwn9EwFwBQwvps60S0PKZ4T1a/A7lrNF+UhTJYe9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582982; c=relaxed/simple;
	bh=tS4hrzTzbITzK7AMbjKeYryNPGy1TisYbJstcZAz5cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsF0gIJQM2coSB8HBamwIQH3WvPuBxjBqVHBsNxmkpRrzq2SuwvrrM0A086nG8pE5GkYKns4HL2oh35Abaa9X/t2PPGJUNohM/C68UOqtHDXF1cTPvQzKk6mlpUZyLYwHdrbXDdl0Ozme/JIWm+l2kE8l/TOx7aAkuOy/HEbaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 0AFC69F27BAC; Thu, 10 Oct 2024 10:56:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v4 04/10] bpf, x86: Create a helper for certain "reg <op>= imm" operations
Date: Thu, 10 Oct 2024 10:56:13 -0700
Message-ID: <20241010175613.1897761-1-yonghong.song@linux.dev>
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

Create a helper to generate jited codes for certain "reg <op>=3D imm"
operations where operations are for add/sub/and/or/xor. This helper
will be used in the subsequent patch.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 82 +++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6d24389e58a1..f01fdabf786e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1406,6 +1406,51 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u=
8 src_reg, bool is64, u8 op)
 	*pprog =3D prog;
 }
=20
+/* emit ADD/SUB/AND/OR/XOR 'reg <op>=3D imm' operations */
+static void emit_alu_helper_1(u8 **pprog, u8 insn_code, u32 dst_reg, s32=
 imm32)
+{
+	u8 b2 =3D 0, b3 =3D 0;
+	u8 *prog =3D *pprog;
+
+	maybe_emit_1mod(&prog, dst_reg, BPF_CLASS(insn_code) =3D=3D BPF_ALU64);
+
+	/*
+	 * b3 holds 'normal' opcode, b2 short form only valid
+	 * in case dst is eax/rax.
+	 */
+	switch (BPF_OP(insn_code)) {
+	case BPF_ADD:
+		b3 =3D 0xC0;
+		b2 =3D 0x05;
+		break;
+	case BPF_SUB:
+		b3 =3D 0xE8;
+		b2 =3D 0x2D;
+		break;
+	case BPF_AND:
+		b3 =3D 0xE0;
+		b2 =3D 0x25;
+		break;
+	case BPF_OR:
+		b3 =3D 0xC8;
+		b2 =3D 0x0D;
+		break;
+	case BPF_XOR:
+		b3 =3D 0xF0;
+		b2 =3D 0x35;
+		break;
+	}
+
+	if (is_imm8(imm32))
+		EMIT3(0x83, add_1reg(b3, dst_reg), imm32);
+	else if (is_axreg(dst_reg))
+		EMIT1_off32(b2, imm32);
+	else
+		EMIT2_off32(0x81, add_1reg(b3, dst_reg), imm32);
+
+	*pprog =3D prog;
+}
+
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
=20
 #define __LOAD_TCC_PTR(off)			\
@@ -1567,42 +1612,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 		case BPF_ALU64 | BPF_AND | BPF_K:
 		case BPF_ALU64 | BPF_OR | BPF_K:
 		case BPF_ALU64 | BPF_XOR | BPF_K:
-			maybe_emit_1mod(&prog, dst_reg,
-					BPF_CLASS(insn->code) =3D=3D BPF_ALU64);
-
-			/*
-			 * b3 holds 'normal' opcode, b2 short form only valid
-			 * in case dst is eax/rax.
-			 */
-			switch (BPF_OP(insn->code)) {
-			case BPF_ADD:
-				b3 =3D 0xC0;
-				b2 =3D 0x05;
-				break;
-			case BPF_SUB:
-				b3 =3D 0xE8;
-				b2 =3D 0x2D;
-				break;
-			case BPF_AND:
-				b3 =3D 0xE0;
-				b2 =3D 0x25;
-				break;
-			case BPF_OR:
-				b3 =3D 0xC8;
-				b2 =3D 0x0D;
-				break;
-			case BPF_XOR:
-				b3 =3D 0xF0;
-				b2 =3D 0x35;
-				break;
-			}
-
-			if (is_imm8(imm32))
-				EMIT3(0x83, add_1reg(b3, dst_reg), imm32);
-			else if (is_axreg(dst_reg))
-				EMIT1_off32(b2, imm32);
-			else
-				EMIT2_off32(0x81, add_1reg(b3, dst_reg), imm32);
+			emit_alu_helper_1(&prog, insn->code, dst_reg, imm32);
 			break;
=20
 		case BPF_ALU64 | BPF_MOV | BPF_K:
--=20
2.43.5


