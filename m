Return-Path: <bpf+bounces-45815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 737DD9DB2B7
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 07:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BAE166F9B
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 06:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE0D145348;
	Thu, 28 Nov 2024 06:11:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DF13FD4;
	Thu, 28 Nov 2024 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732774280; cv=none; b=vDGfiecLEUqOX/yd1mciFK8EpF/Q7CaFMmZ8ac+90o1IhR3YrfSfqL1SysuUlTsOI3cXWf8zSIWa6APUdpjGLUGt2KbO2tvAeqxuRVnnYENGHTGO9K4mGWLvZ/JWc5BNR62qJuGHup9tkgTV2jzvxOvfd8cFFi/6sunMN1trTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732774280; c=relaxed/simple;
	bh=I2CXWTjsvZTyCr81KW+aP5rn44bPx8jzUM9/VIJgLUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dB8SOohdwSqLN0c1gWJIyvtHYwpUHEyI2Wuzqla+Q2rlNAPby5j0FhppFjaKuFx9tn3JpB6eqoABNpk6TVWu2l709YAv62nfbort/MOXPHIUK/crlorO9zI/j/FcYb1gdkmgvJtWspbxomGMfnzBKXeFJ1pB18+VUDjhmmHKy5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx++GBCUhnSXFKAA--.13840S3;
	Thu, 28 Nov 2024 14:11:13 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxfcJ_CUhnJw9rAA--.8752S2;
	Thu, 28 Nov 2024 14:11:11 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: BPF: Adjust the parameter of emit_jirl()
Date: Thu, 28 Nov 2024 14:11:10 +0800
Message-ID: <20241128061110.5204-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxfcJ_CUhnJw9rAA--.8752S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4rGr18tF4fKrWxKFWDJrc_yoW5tw43pr
	ZFyrs5GrW0gryfGFyDJrW5ur13Jan3GrWagasrArZ7Cr1Yq34Fq3WkKrnxWFs8Xan5XFsY
	9F1Fyw12vF1UJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ36c02F40EFcxC0VAKzVAqx4xG6I80ewCIccxYrVCFb4Uv73VFW2AGmfu7
	bjvjm3AaLaJ3UjIYCTnIWjp_UUUYw7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4
	CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0
	c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2
	jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWU
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIccxYrV
	CFb41lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07b2ID7UUUUU=

The branch instructions beq, bne, blt, bge, bltu, bgeu and jirl belong
to the format reg2i16, but the sequence of oprand is different for the
instruction jirl, adjust the parameter of emit_jirl() to make it more
readable correspond with the Instruction Set Architecture manual.

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
---

This patch is based on the following commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=73c359d1d356

 arch/loongarch/include/asm/inst.h | 12 +++++++++++-
 arch/loongarch/kernel/inst.c      |  2 +-
 arch/loongarch/net/bpf_jit.c      |  6 +++---
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 944482063f14..3089785ca97e 100644
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
index 3050329556d1..14d7d700bcb9 100644
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
index dd350cba1252..ea357a3edc09 100644
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
2.42.0


