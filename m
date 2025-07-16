Return-Path: <bpf+bounces-63406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D88B06CBC
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 06:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA5C560CDF
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44DD25394A;
	Wed, 16 Jul 2025 04:39:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146FC2E3715;
	Wed, 16 Jul 2025 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752640765; cv=none; b=sPT3cUbO+/b2uWSHL+/wpmOuWe+G0PAq2CHNsxwMfkFNPJCgIT+QDEo373YeHXfynVzByU+HMcCXkyOBOyeIA6NJ+HPJkjI0uMUn5MtFS5vWkxhIFogKsFqILsdgsQcB2ejGD0aAZ4omeezPKdpoejF/GlQrn/GAAI1QmpznQoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752640765; c=relaxed/simple;
	bh=7HDOCBc6V6kKoG+jOtt6yyv5DEob+bLWWJqp9Btf4n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pe3Ld7M6apNtHslSaWW4qdKRm1pQaJgJQNH3jQFjFgcgw0sLYK1yj4H6rD7vZO0DxGnd5OvZCFY3zuVwr9Jsqw6gLk/WYkxl3Mq11melqsWxveg0QPqrkWi708T39jO+SKkjafkMt5XJ2oOaCHyoaX4hUQq/dnp9XSdmFLTswYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxaWr3LHdoluoqAQ--.27156S3;
	Wed, 16 Jul 2025 12:39:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxVOTzLHdonVQZAA--.5847S2;
	Wed, 16 Jul 2025 12:39:16 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] LoongArch: BPF: Add struct ops support for trampoline
Date: Wed, 16 Jul 2025 12:39:15 +0800
Message-ID: <20250716043915.15034-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxVOTzLHdonVQZAA--.5847S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtrWxKry3XryDJrWkCFyxtFc_yoWxGFy3pr
	yqkF48CFyUK3W2gF4kJr1j9r1rXFsakasxKayUJrZ5KrZxZFyrWF1UKr13WFW3X3WDZryx
	uwnYyw4vvF1xArcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

Use BPF_TRAMP_F_INDIRECT flag to detect struct ops and emit proper
prologue and epilogue for this case.

With this patch, all of the struct_ops related testcases (except
struct_ops_multi_pages) passed on LoongArch.

The testcase struct_ops_multi_pages failed is because the actual
image_pages_cnt is 40 which is bigger than MAX_TRAMP_IMAGE_PAGES.

Before:

  $ sudo ./test_progs -t struct_ops -d struct_ops_multi_pages
  ...
  WATCHDOG: test case struct_ops_module/struct_ops_load executes for 10 seconds...

After:

  $ sudo ./test_progs -t struct_ops -d struct_ops_multi_pages
  ...
  #15      bad_struct_ops:OK
  ...
  #399     struct_ops_autocreate:OK
  ...
  #400     struct_ops_kptr_return:OK
  ...
  #401     struct_ops_maybe_null:OK
  ...
  #402     struct_ops_module:OK
  ...
  #404     struct_ops_no_cfi:OK
  ...
  #405     struct_ops_private_stack:SKIP
  ...
  #406     struct_ops_refcounted:OK
  Summary: 8/25 PASSED, 3 SKIPPED, 0 FAILED

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

This is a RFC patch, based on 6.16-rc6 and the following series:

[PATCH v3 0/5] Support trampoline for LoongArch
https://lore.kernel.org/loongarch/20250709055029.723243-1-duanchenghao@kylinos.cn/

 arch/loongarch/net/bpf_jit.c | 71 ++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 6820558afce5..7663b84a4ff1 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1599,6 +1599,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
+	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
 	int ret, save_ret;
 	void *orig_call = func_addr;
 	u32 **branches = NULL;
@@ -1674,18 +1675,31 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 
 	stack_size = round_up(stack_size, 16);
 
-	/* For the trampoline called from function entry */
-	/* RA and FP for parent function*/
-	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -16);
-	emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
-	emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
-	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 16);
-
-	/* RA and FP for traced function*/
-	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_size);
-	emit_insn(ctx, std, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
-	emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
-	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size);
+	if (!is_struct_ops) {
+		/*
+		 * For the trampoline called from function entry,
+		 * the frame of traced function and the frame of
+		 * trampoline need to be considered.
+		 */
+		emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -16);
+		emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
+		emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
+		emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 16);
+
+		emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_size);
+		emit_insn(ctx, std, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
+		emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
+		emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size);
+	} else {
+		/*
+		 * For the trampoline called directly, just handle
+		 * the frame of trampoline.
+		 */
+		emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_size);
+		emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, stack_size - 8);
+		emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
+		emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size);
+	}
 
 	/* callee saved register S1 to pass start time */
 	emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
@@ -1772,21 +1786,30 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 
 	emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
 
-	/* trampoline called from function entry */
-	emit_insn(ctx, ldd, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
-	emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
-	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_size);
+	if (!is_struct_ops) {
+		/* trampoline called from function entry */
+		emit_insn(ctx, ldd, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
+		emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
+		emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_size);
+
+		emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
+		emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
+		emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, 16);
 
-	emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
-	emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
-	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, 16);
+		if (flags & BPF_TRAMP_F_SKIP_FRAME)
+			/* return to parent function */
+			emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
+		else
+			/* return to traced function */
+			emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T0, 0);
+	} else {
+		/* trampoline called directly */
+		emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, stack_size - 8);
+		emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
+		emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_size);
 
-	if (flags & BPF_TRAMP_F_SKIP_FRAME)
-		/* return to parent function */
 		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
-	else
-		/* return to traced function */
-		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T0, 0);
+	}
 
 	ret = ctx->idx;
 out:
-- 
2.42.0


