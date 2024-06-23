Return-Path: <bpf+bounces-32851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3501C913CAA
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 18:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B691C2128F
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDB5181338;
	Sun, 23 Jun 2024 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plm7HkT4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C711181D04
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719159364; cv=none; b=LU7mQ6pGXqPYDsJTDBue1lYTiShauUqktgBKvr7v5Flm8pKNYLNKbOnasEaG4bztra3fi+K+p4b/lf71SDJJW+LfI4hxcL7TYsT0+KSYvXsh1JU/3G8I5ddURxBzbnNLDr7ydb8i759p3z/YKuMDxHBboK636rFrUkNpIERk0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719159364; c=relaxed/simple;
	bh=Llu36Hb9hJoMxUDDwXcdtVuYTH99RFnzPyaSj+ewf9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnGwMIIUnlX0eo1+PWCksuB65A4AwH0/DB56h9UbyxhOx+TfBNWcbmUC0JGsZiu8Ur0Vb5f9GJVHL0JBWbCSLGag0mO0347BvnG3MpDTut1j7kBdTh8Z6t7K1yWdAjAHo2320Rpyo9PAPoz1nVlXKHtKj+WbhKIZBP/LgzpWxvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Plm7HkT4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70679845d69so270576b3a.1
        for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 09:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719159362; x=1719764162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Us383lSAc4EWWRfkhs6LuRZRPsTq63gKhvgwGZYqaJw=;
        b=Plm7HkT4iNluY7Eq2Gtwo2HO506GGQkmqjmn9fzZ3UxcHb3dYc/LFfoaTrVfzdHM8t
         SDcr1E6MPYpnBJB76Vrvqd+zvp8LtLB54aWlpLUUKlKZwK/zAKhyKlXOjzgdZkuM1iz4
         5nzjniRjFXWJMI3qzFH1B5PPP03LOLuzuW3TibyX/+bVXgGQsiyO1gMaZVSm8XTNWDCz
         kbcK1I+UByQ+Ksylo7r6qRPoFAA56PfKXy6P5hge6OKHg0EecLUHG4sDDimaHcF+QySS
         y7IwuacZFGjvnBkUU++WHPOtO0bWFnHYQ/uTahezufMR1/2X+SZICt68I03NgIkCF5BT
         sukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719159362; x=1719764162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Us383lSAc4EWWRfkhs6LuRZRPsTq63gKhvgwGZYqaJw=;
        b=SYuYEqOZoy+xWK5h8/yeThygyvQu4yUfvOL+3sMKXBPDJU214XhplyJBziAMKkTIWP
         1SExyx/PPtB6YgtcFlIi9a39dnS2Qr/hUIRA/Jp3TU151eAb9RVWijCa3pSG0K7w2gWX
         ibI8+TmSKDY74NvO/PYUBiZtfX7h09NAW7HknB4QnD7IQf6oJ6c2K3ruAAaNPqDqlVOD
         fHqiFK+aQRunIqtsA/n61FSH6vUFnHytJ9PnfJoNDCWB8KEfJTicWOQxfv32sVaX4zKA
         nY8wUTWCFct4ag3Fbt6u1Yeg4L6TckUxEsIlFXNUxJhazuCTFXBRXEZ3AHH1cV8YYj1F
         iocw==
X-Gm-Message-State: AOJu0YxvoHeSMOcy9SWWXrxbVUIjivoiDTKIv1mKFme3GyEudOdVrmqF
	C0WYryw9+IDi+eBld/C7bix4jDZGvfGWIN3u96lmYu5Y0bPXsZJmuXITkA==
X-Google-Smtp-Source: AGHT+IGGyuxGlVq3UYBQEdOSjQFLMwbD9Pe+Y1xoxMQUFjgdkGlw5y4xqxf7OWTh6SOYGihN7KLgJg==
X-Received: by 2002:aa7:8ecb:0:b0:706:57ce:f042 with SMTP id d2e1a72fcca58-7067455bfd2mr1822299b3a.7.1719159361577;
        Sun, 23 Jun 2024 09:16:01 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651309bdbsm4621255b3a.210.2024.06.23.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 09:16:01 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	puranjay@kernel.org,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH v5 bpf-next 2/3] bpf, arm64: Fix tailcall hierarchy
Date: Mon, 24 Jun 2024 00:15:27 +0800
Message-ID: <20240623161528.68946-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240623161528.68946-1-hffilwlqm@gmail.com>
References: <20240623161528.68946-1-hffilwlqm@gmail.com>
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
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 57 +++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 751331f5ba906..148ba1de29bc4 100644
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


