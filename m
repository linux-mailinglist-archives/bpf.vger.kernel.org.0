Return-Path: <bpf+bounces-46662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 474109ED51A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 19:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D743162CA8
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 18:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1F623E6DC;
	Wed, 11 Dec 2024 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxCvJRqW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4E42288DF;
	Wed, 11 Dec 2024 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943072; cv=none; b=H1KVxYSjnX+JPJQVtwVnwTaN6QoWQBqrx13gq/4ZuojdqhN+Ly3E7t30lIQcfj6iOwLz2s3lYsCBXZMCoO+ckwDqLRnlVkpMIQ3FQbgV80xQeFnO6H3WaZHBI6anqRbBwPcNO5nf9Cy4XqFaXsC9JdD5FOM8xYagUF4+3ArkP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943072; c=relaxed/simple;
	bh=5ScjjV1pvieNUfFpmzR/q8gCM1VBAvlSOEXdPXJS4hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5z1WdNn5hZXOugXXjKSI/b6JCXjp9yO0X5jojwvPutI8BpIydzbOPtLPQOxexdyV3/2Oj8pfsftifCwpdoDCxxWZeZXF/znuOcp6jvX35MD0GeBxHTV+hGPlUIcAfiLHglpHURNDUd3pmJrmkG/kZxz8UwgIa5/ErDr3KFPtxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxCvJRqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F6FC4CED2;
	Wed, 11 Dec 2024 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943071;
	bh=5ScjjV1pvieNUfFpmzR/q8gCM1VBAvlSOEXdPXJS4hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxCvJRqWR4WF7sV6ENHWexH0xRHnx7FsV1rat+QWlHHk7bmCebwETIRLXedJgVK19
	 zgH/FEtHjQzP2J+FMJvrWxk9lkjclHcjKcAVy06jwRV2IYcDrQSz1ZJy1nKge+5VNL
	 MP3DNNJntlRyau6ZAH7x74hMwWmDR9J/IA2jFYZuDz/OgvS3AP3Gkub88gqyCoB569
	 h7Mm+DggQjW5UNLR2qxo/qGqrU6x2fNWlfmig0z0illhcKB2g0SDqw2E+tCJhFzpL8
	 NeBxB/tGhEhq9g7lPgt+bY+MYi5R5gL5gFfoxRU7ZdVYIqYkkBg7ZmB18ZuLBsudW5
	 tTr+lQEZJAj/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maobibo@loongson.cn,
	oleg@redhat.com,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 19/36] LoongArch: BPF: Adjust the parameter of emit_jirl()
Date: Wed, 11 Dec 2024 13:49:35 -0500
Message-ID: <20241211185028.3841047-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
Content-Transfer-Encoding: 8bit

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit c1474bb0b7cff4e8481095bd0618b8f6c2f0aeb4 ]

The branch instructions beq, bne, blt, bge, bltu, bgeu and jirl belong
to the format reg2i16, but the sequence of oprand is different for the
instruction jirl. So adjust the parameter order of emit_jirl() to make
it more readable correspond with the Instruction Set Architecture manual.

Here are the instruction formats:

  beq     rj, rd, offs16
  bne     rj, rd, offs16
  blt     rj, rd, offs16
  bge     rj, rd, offs16
  bltu    rj, rd, offs16
  bgeu    rj, rd, offs16
  jirl    rd, rj, offs16

Link: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#branch-instructions
Suggested-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/inst.h | 12 +++++++++++-
 arch/loongarch/kernel/inst.c      |  2 +-
 arch/loongarch/net/bpf_jit.c      |  6 +++---
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 944482063f14e..3089785ca97e7 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -683,7 +683,17 @@ DEF_EMIT_REG2I16_FORMAT(blt, blt_op)
 DEF_EMIT_REG2I16_FORMAT(bge, bge_op)
 DEF_EMIT_REG2I16_FORMAT(bltu, bltu_op)
 DEF_EMIT_REG2I16_FORMAT(bgeu, bgeu_op)
-DEF_EMIT_REG2I16_FORMAT(jirl, jirl_op)
+
+static inline void emit_jirl(union loongarch_instruction *insn,
+			     enum loongarch_gpr rd,
+			     enum loongarch_gpr rj,
+			     int offset)
+{
+	insn->reg2i16_format.opcode = jirl_op;
+	insn->reg2i16_format.immediate = offset;
+	insn->reg2i16_format.rd = rd;
+	insn->reg2i16_format.rj = rj;
+}
 
 #define DEF_EMIT_REG2BSTRD_FORMAT(NAME, OP)				\
 static inline void emit_##NAME(union loongarch_instruction *insn,	\
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 3050329556d11..14d7d700bcb98 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -332,7 +332,7 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
 		return INSN_BREAK;
 	}
 
-	emit_jirl(&insn, rj, rd, imm >> 2);
+	emit_jirl(&insn, rd, rj, imm >> 2);
 
 	return insn.word;
 }
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index dd350cba1252f..ea357a3edc094 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -181,13 +181,13 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 		/* Set return value */
 		emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_0], 0);
 		/* Return to the caller */
-		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, LOONGARCH_GPR_ZERO, 0);
+		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
 	} else {
 		/*
 		 * Call the next bpf prog and skip the first instruction
 		 * of TCC initialization.
 		 */
-		emit_insn(ctx, jirl, LOONGARCH_GPR_T3, LOONGARCH_GPR_ZERO, 1);
+		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T3, 1);
 	}
 }
 
@@ -904,7 +904,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			return ret;
 
 		move_addr(ctx, t1, func_addr);
-		emit_insn(ctx, jirl, t1, LOONGARCH_GPR_RA, 0);
+		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
 		move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
 		break;
 
-- 
2.43.0


