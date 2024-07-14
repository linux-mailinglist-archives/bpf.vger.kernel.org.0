Return-Path: <bpf+bounces-34773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6C29309F3
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 14:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FB21C20C86
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687B867A0D;
	Sun, 14 Jul 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYQqw4/c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CA021A0B
	for <bpf@vger.kernel.org>; Sun, 14 Jul 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960765; cv=none; b=AhSw05E05J2l1bCtOyewG9BdnZ4NE0NlNKv3o4VA6QDeSrAAvEit4ALNwwwHOK1kDeYA6N6oykJEWyNfRc1FEo8/P1jAwnYOwGjFv859FI86+c79/YNI+6XftdGTlHUBzBwPbUnvxar78vWv7y27rXZ+GaBHFbD8OSg3JCvYVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960765; c=relaxed/simple;
	bh=5dyQ7nPVnQY1tEMhehuUpO8lrIieffQEW9nRO1im3l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1zSUDALFxTH55eGMKHI7ld9+Dy5ltLYpY7dL7+QVwH9pPU3G2PqpM5gyYlANiaZNvaFalj6VNrhc127JyMRHfEVRvlTX/4jNv2f7M6Y83Ve7Zcr/yI4AUIv2OP6GOvfPfSZ1AkRdgLIQZfgXzoZFqPBdkvvu4An5iSwbqnaFBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYQqw4/c; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb72eb3143so23782125ad.1
        for <bpf@vger.kernel.org>; Sun, 14 Jul 2024 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720960762; x=1721565562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld0JIcsJ8ySOOqEg1Y+w8sMLCORYgXrAe2lyYuNLTvg=;
        b=jYQqw4/csELdTtdg+hdkhm9vCqZZD7x18Gs+bucg3bJhXm18ASQBjMquzq4N9OZRRR
         HcO/lA7KAbiVQiZA4RmQ6V56uYZ07OuDBdKRWkVsoQ6SShSTH4OvOyr7BYWnyzf+OIo7
         SaeCSrwSzwcOgGAV3oMQ1bPN+ACS+wlMHN1dk6lREP+B3iBexeVuES14sB5mk4v1RSQv
         toaBfpwJ4UcXPSUi6m1PfDlhs5zmS2h6ToclyQuN9TgFKvig6KwqQiAMqFTnD/vpMtVF
         6BmIqaeXo2sbecQPNh7KLGReWcN0UH627fIf+7kK5Ii7yV1EeTgv/7nEMr0Du9llgWdw
         3sAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720960762; x=1721565562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ld0JIcsJ8ySOOqEg1Y+w8sMLCORYgXrAe2lyYuNLTvg=;
        b=gSFekJdvBXI5Wbl6b0wtXeCg7LXNLsmxoVv7gTtTE1O81GO5V7oITbl8T8gFR3CcCs
         7fR8fLSFBaINzZds58uqQcEM3JeJQBIdmPkQrSPe/76CmRxxpJ0cNano7emXWgFkBhEE
         jPhLA3Nusb0qKA0SDUmaeWArW3fuJdVgSlvwwn9nsOY2th1Y2/BUstDW6vy+HN3kaA5j
         zVMBSYfnGJLrya5dlH8qTL0T2xdt3XyjsqkJ6ATj14Ecq9LN4d87EnJHCN9zKl71sefd
         7IdMDu7i0h4otV6uRaUOkHzVe9OGoX39ebAMBwjJdWAUArcWUuD6qFpPlgWF+T75JIu4
         zMgQ==
X-Gm-Message-State: AOJu0YxGFapKrCyXAcXY1dIfRbpceoB1zJbjkAMYkgZSmPOIwQVhHDkL
	ala5e5+wk4ngIyDCRVgZyZKBb4AM5Tl6huoSo1jfEfomwreey3IG8Q+ofA==
X-Google-Smtp-Source: AGHT+IFqWeByrQvN4ltJaP+ZW0jjkRfzIn5vjsT9eARyAsOQ8rUwfMx7JX3wvMnlb6Pyp+5KeDRZ4w==
X-Received: by 2002:a17:903:110c:b0:1fa:d491:a472 with SMTP id d9443c01a7336-1fc0b4fd6e9mr57559115ad.11.1720960761971;
        Sun, 14 Jul 2024 05:39:21 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-23-111.singnet.com.sg. [219.74.23.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc4e4edsm22994635ad.266.2024.07.14.05.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:39:21 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	eddyz87@gmail.com,
	puranjay@kernel.org,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH v6 bpf-next 2/3] bpf, arm64: Fix tailcall hierarchy
Date: Sun, 14 Jul 2024 20:39:01 +0800
Message-ID: <20240714123902.32305-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240714123902.32305-1-hffilwlqm@gmail.com>
References: <20240714123902.32305-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a tailcall issue caused by abusing the tailcall in
bpf2bpf feature on arm64 like the way of "bpf, x64: Fix tailcall
hierarchy".

On arm64, when a tail call happens, it uses tail_call_cnt_ptr to
increment tail_call_cnt, too.

At the prologue of main prog, it has to initialize tail_call_cnt and
prepare tail_call_cnt_ptr.

At the prologue of subprog, it pushes x26 register twice, and does not
initialize tail_call_cnt.

At the epilogue, it pops x26 twice, no matter whether it is main prog or
subprog.

Fixes: d4609a5d8c70 ("bpf, arm64: Keep tail call count across bpf2bpf calls")
Acked-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 57 +++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index dd0bb069df4bb..59e05a7aea56a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -26,7 +26,7 @@
 
 #define TMP_REG_1 (MAX_BPF_JIT_REG + 0)
 #define TMP_REG_2 (MAX_BPF_JIT_REG + 1)
-#define TCALL_CNT (MAX_BPF_JIT_REG + 2)
+#define TCCNT_PTR (MAX_BPF_JIT_REG + 2)
 #define TMP_REG_3 (MAX_BPF_JIT_REG + 3)
 #define FP_BOTTOM (MAX_BPF_JIT_REG + 4)
 #define ARENA_VM_START (MAX_BPF_JIT_REG + 5)
@@ -63,8 +63,8 @@ static const int bpf2a64[] = {
 	[TMP_REG_1] = A64_R(10),
 	[TMP_REG_2] = A64_R(11),
 	[TMP_REG_3] = A64_R(12),
-	/* tail_call_cnt */
-	[TCALL_CNT] = A64_R(26),
+	/* tail_call_cnt_ptr */
+	[TCCNT_PTR] = A64_R(26),
 	/* temporary register for blinding constants */
 	[BPF_REG_AX] = A64_R(9),
 	[FP_BOTTOM] = A64_R(27),
@@ -282,13 +282,35 @@ static bool is_lsi_offset(int offset, int scale)
  *      mov x29, sp
  *      stp x19, x20, [sp, #-16]!
  *      stp x21, x22, [sp, #-16]!
- *      stp x25, x26, [sp, #-16]!
+ *      stp x26, x25, [sp, #-16]!
+ *      stp x26, x25, [sp, #-16]!
  *      stp x27, x28, [sp, #-16]!
  *      mov x25, sp
  *      mov tcc, #0
  *      // PROLOGUE_OFFSET
  */
 
+static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx)
+{
+	const struct bpf_prog *prog = ctx->prog;
+	const bool is_main_prog = !bpf_is_subprog(prog);
+	const u8 ptr = bpf2a64[TCCNT_PTR];
+	const u8 fp = bpf2a64[BPF_REG_FP];
+	const u8 tcc = ptr;
+
+	emit(A64_PUSH(ptr, fp, A64_SP), ctx);
+	if (is_main_prog) {
+		/* Initialize tail_call_cnt. */
+		emit(A64_MOVZ(1, tcc, 0, 0), ctx);
+		emit(A64_PUSH(tcc, fp, A64_SP), ctx);
+		emit(A64_MOV(1, ptr, A64_SP), ctx);
+	} else {
+		emit(A64_PUSH(ptr, fp, A64_SP), ctx);
+		emit(A64_NOP, ctx);
+		emit(A64_NOP, ctx);
+	}
+}
+
 #define BTI_INSNS (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) ? 1 : 0)
 #define PAC_INSNS (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL) ? 1 : 0)
 
@@ -296,7 +318,7 @@ static bool is_lsi_offset(int offset, int scale)
 #define POKE_OFFSET (BTI_INSNS + 1)
 
 /* Tail call offset to jump into */
-#define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
+#define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 10)
 
 static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 			  bool is_exception_cb, u64 arena_vm_start)
@@ -308,7 +330,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 	const u8 r8 = bpf2a64[BPF_REG_8];
 	const u8 r9 = bpf2a64[BPF_REG_9];
 	const u8 fp = bpf2a64[BPF_REG_FP];
-	const u8 tcc = bpf2a64[TCALL_CNT];
 	const u8 fpb = bpf2a64[FP_BOTTOM];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
 	const int idx0 = ctx->idx;
@@ -359,7 +380,7 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 		/* Save callee-saved registers */
 		emit(A64_PUSH(r6, r7, A64_SP), ctx);
 		emit(A64_PUSH(r8, r9, A64_SP), ctx);
-		emit(A64_PUSH(fp, tcc, A64_SP), ctx);
+		prepare_bpf_tail_call_cnt(ctx);
 		emit(A64_PUSH(fpb, A64_R(28), A64_SP), ctx);
 	} else {
 		/*
@@ -372,18 +393,15 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 		 * callee-saved registers. The exception callback will not push
 		 * anything and re-use the main program's stack.
 		 *
-		 * 10 registers are on the stack
+		 * 12 registers are on the stack
 		 */
-		emit(A64_SUB_I(1, A64_SP, A64_FP, 80), ctx);
+		emit(A64_SUB_I(1, A64_SP, A64_FP, 96), ctx);
 	}
 
 	/* Set up BPF prog stack base register */
 	emit(A64_MOV(1, fp, A64_SP), ctx);
 
 	if (!ebpf_from_cbpf && is_main_prog) {
-		/* Initialize tail_call_cnt */
-		emit(A64_MOVZ(1, tcc, 0, 0), ctx);
-
 		cur_offset = ctx->idx - idx0;
 		if (cur_offset != PROLOGUE_OFFSET) {
 			pr_err_once("PROLOGUE_OFFSET = %d, expected %d!\n",
@@ -432,7 +450,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 prg = bpf2a64[TMP_REG_2];
-	const u8 tcc = bpf2a64[TCALL_CNT];
+	const u8 tcc = bpf2a64[TMP_REG_3];
+	const u8 ptr = bpf2a64[TCCNT_PTR];
 	const int idx0 = ctx->idx;
 #define cur_offset (ctx->idx - idx0)
 #define jmp_offset (out_offset - (cur_offset))
@@ -449,11 +468,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	emit(A64_B_(A64_COND_CS, jmp_offset), ctx);
 
 	/*
-	 * if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
+	 * if ((*tail_call_cnt_ptr) >= MAX_TAIL_CALL_CNT)
 	 *     goto out;
-	 * tail_call_cnt++;
+	 * (*tail_call_cnt_ptr)++;
 	 */
 	emit_a64_mov_i64(tmp, MAX_TAIL_CALL_CNT, ctx);
+	emit(A64_LDR64I(tcc, ptr, 0), ctx);
 	emit(A64_CMP(1, tcc, tmp), ctx);
 	emit(A64_B_(A64_COND_CS, jmp_offset), ctx);
 	emit(A64_ADD_I(1, tcc, tcc, 1), ctx);
@@ -469,6 +489,9 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	emit(A64_LDR64(prg, tmp, prg), ctx);
 	emit(A64_CBZ(1, prg, jmp_offset), ctx);
 
+	/* Update tail_call_cnt if the slot is populated. */
+	emit(A64_STR64I(tcc, ptr, 0), ctx);
+
 	/* goto *(prog->bpf_func + prologue_offset); */
 	off = offsetof(struct bpf_prog, bpf_func);
 	emit_a64_mov_i64(tmp, off, ctx);
@@ -721,6 +744,7 @@ static void build_epilogue(struct jit_ctx *ctx, bool is_exception_cb)
 	const u8 r8 = bpf2a64[BPF_REG_8];
 	const u8 r9 = bpf2a64[BPF_REG_9];
 	const u8 fp = bpf2a64[BPF_REG_FP];
+	const u8 ptr = bpf2a64[TCCNT_PTR];
 	const u8 fpb = bpf2a64[FP_BOTTOM];
 
 	/* We're done with BPF stack */
@@ -738,7 +762,8 @@ static void build_epilogue(struct jit_ctx *ctx, bool is_exception_cb)
 	/* Restore x27 and x28 */
 	emit(A64_POP(fpb, A64_R(28), A64_SP), ctx);
 	/* Restore fs (x25) and x26 */
-	emit(A64_POP(fp, A64_R(26), A64_SP), ctx);
+	emit(A64_POP(ptr, fp, A64_SP), ctx);
+	emit(A64_POP(ptr, fp, A64_SP), ctx);
 
 	/* Restore callee-saved register */
 	emit(A64_POP(r8, r9, A64_SP), ctx);
-- 
2.44.0


