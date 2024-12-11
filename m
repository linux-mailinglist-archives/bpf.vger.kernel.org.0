Return-Path: <bpf+bounces-46664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6279ED57E
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 20:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F1A1883284
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE36248353;
	Wed, 11 Dec 2024 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz7hVOrs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2F24953E;
	Wed, 11 Dec 2024 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943162; cv=none; b=DuJSwMpD32/79D59pZxSEju+m/vNHY0a0oIJqjmDpYTdER1kPPEUUo5KPf4T03r3iocNqzV7jJtHgtXnhD8Zmf4zgIONUhx6qVZ1wAwUKlLlVB7q14pd01CXqZ+I8Ip1U9MWsyIxmZDS62eJQOsAkYsBKsToICVaJj3L/3dYLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943162; c=relaxed/simple;
	bh=DhQWIhCHT7+bo6xMT/3tBuVZmITlX74nTga6wJ1INBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KV4gxtWKrlg1HedrOYxd2zy5eDRRmhMW6dO9+6gZntgVL4J2/jYE2xY6p0DZoDbeDw466UmpCpsIDNX/wtET1nNqR3eYH/vboBUH7ki3kAA3VBIJBOHOaPbtyFuD5KCsi3xPPZfzMvnpFD9OcspjyqciKBsrypxlCCwH2jdztrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz7hVOrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDCCC4CED2;
	Wed, 11 Dec 2024 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943162;
	bh=DhQWIhCHT7+bo6xMT/3tBuVZmITlX74nTga6wJ1INBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sz7hVOrsKdRzs5MNghUHT8XC2H2Xka6Z9bays3fl3XaX4IgOomcj7sYRb/ug9bUui
	 gh47sUyNzMlAxiqnD/WYLPxG0bJX+KKtbMb5a1jCC9vNM6ZBakfdSn6ZOdjreg0Y99
	 5Tf6bQFvinZP6o+pQXZkqvb7yi5CJxehDDfRYexAxYhwk56JLmvkwXGBpGCPQYY6Uc
	 ie+NGTJ8OWCo7UorQD/AhMNqqI2PJcO5Ru3Y+bPp7UUzCDadUVmwQ97m13kpmvmUZD
	 Qd+cZBdidOpCCOrZorlkDYFcyXaY7fkGEE6mWYFl08Ysj9IjFiOqfAxE8z8J6X6e3U
	 41pe7G2BxlRdA==
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
Subject: [PATCH AUTOSEL 6.6 12/23] LoongArch: BPF: Adjust the parameter of emit_jirl()
Date: Wed, 11 Dec 2024 13:51:49 -0500
Message-ID: <20241211185214.3841978-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185214.3841978-1-sashal@kernel.org>
References: <20241211185214.3841978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.65
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
index 71e1ed4165c80..4fa53ad82efb3 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -655,7 +655,17 @@ DEF_EMIT_REG2I16_FORMAT(blt, blt_op)
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
index 497f8b0a5f1ef..6595e992fda85 100644
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
 
@@ -841,7 +841,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			return ret;
 
 		move_addr(ctx, t1, func_addr);
-		emit_insn(ctx, jirl, t1, LOONGARCH_GPR_RA, 0);
+		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
 		move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
 		break;
 
-- 
2.43.0


