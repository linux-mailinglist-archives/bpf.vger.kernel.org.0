Return-Path: <bpf+bounces-29192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6928C11A6
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBE61C215F0
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE1415278F;
	Thu,  9 May 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8Idcvkr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174012FF9B
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267170; cv=none; b=NsVfPrkWoHcRcqPuUUCIxhovvHKWr2z19DDYDbUQjkUEbyC9elh9Yj1Nm//HVG1dx4oZ9sQvx5SrhFKUR/sONOU5wCplBU7ubdwbmTaRgXa23H3p8/XrQgOJU4tvU+zhgYkHo0ES+9a1/nfx4tNSjr1TY7utREidBJ2LJ6fpIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267170; c=relaxed/simple;
	bh=tbTWIzMQfW4BrBsa6tWF1GOiRNZs+NluG8PHk1sb6m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jraWnHm5JiH9HSyRrpjM0KaDbr0wdyKmrCaEvokjcNZ/La0jlSgdikhlMTRxEH5SwEyV/B6G2GyoST5EuOWVT/U/OWsYviL+8+gN6P8WGzpqipPp81k6DVAu2aeZxYC/MVIbI9/Qamt8SxIEIIle4NVdemGU20DBTxNZeu4I6oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8Idcvkr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec92e355bfso8358445ad.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715267168; x=1715871968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUC+O+AdzwILI8n44Y+wqIuEoIYHWT3atfnTPUwPz6U=;
        b=g8IdcvkrTrNQ3nbW4T8xd8yGPNx+fqHyV4FLL3eo0FJiCdp1jeGXCGWqEaR2BhBI1E
         OGSRUg1gWW316ZKZpmPrVAnTk+d1o1G0NSas6YIw7pBbq7dq1qfYUz4eGmwPW11y1SWQ
         j7cqO8b4SZD7wR6rswPpbnC0sDhS/oJbrh2kyIrALcdrjHxLnG8kc5MwLrRvffbnJ2JV
         ELkmSu6Yo9ieB5fSn1W6SN1tO9Kj+AYtAMO4d+tf9Rm5o+9N615iOJtt/wpivSNxXxR+
         /WYOX3ovbX6N2PePO8vdKVQrXIFexnjHmaYQtCw0QwGjKjNxfrWU9kYiHkVP5ZPeBGNp
         QwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715267168; x=1715871968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUC+O+AdzwILI8n44Y+wqIuEoIYHWT3atfnTPUwPz6U=;
        b=aUlBr700MMHiYbvMAgsGJ8IkKpTuvCUywq4xmD1JkUzZrq+BqpjRIJNCDk7Y92FAsI
         HK8SkmH9hsKLN8KnhCGlCQUDz7K8fw95NAqhuScYYKCDiQai+zsZBV1PB5yhY4P64ctC
         aQN2Qh9uP34A5E57xsaeU+KuC2XN9KUBm7nOxbFUBE1zTKv7Vlj+c7WEFZ/SrBavUVTz
         fmGhhjMFwVy9ktudSnU/ZmIi2lSlxPMPnA7ra88/WsGymwyDWdu73Sc+KzRNbPNVQerw
         J4ZbAWXDjsMgf+MsE+I0D+woOntPP3lFjhHuMc+WPx+L/JKjIrzsHN3zL0AfjJCPMs5F
         6zZw==
X-Gm-Message-State: AOJu0YwpglWBc3Q6jRxgxdF2xz+38JGZLoO5W2k7OfSJyRyDNX23/95a
	6jEvohUwA4TRK1c+ePprOyT7FgvMRVwcChuMVH3xzebtXzQHTDXAvo8u0Q==
X-Google-Smtp-Source: AGHT+IFslqKUu+Y+Deae119udpjma2SEvHgc6S8Rq2hK7f88A1iUesP4e6ZyRkowUqf3mjgvEAsr8g==
X-Received: by 2002:a17:903:22ce:b0:1e0:b62c:460d with SMTP id d9443c01a7336-1eeb058fee4mr64054085ad.38.1715267166783;
        Thu, 09 May 2024 08:06:06 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1642sm15376135ad.31.2024.05.09.08.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 08:06:06 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 4/5] bpf, arm64: Fix tailcall hierarchy
Date: Thu,  9 May 2024 23:05:40 +0800
Message-ID: <20240509150541.81799-5-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509150541.81799-1-hffilwlqm@gmail.com>
References: <20240509150541.81799-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like the way of "bpf, x64: Fix tailcall hierarchy", this patch fixes
this issue on arm64.

At prologue, it loads tail_call_cnt_ptr from bpf_tail_call_run_ctx to
TCCNT_PTR register, and restores the original ctx from
bpf_tail_call_run_ctx to X0 register meanwhile.

Then, when a tailcall runs:
1. load tail_call_cnt from tail_call_cnt_ptr
2. compare tail_call_cnt with MAX_TAIL_CALL_CNT
3. increment tail_call_cnt
4. store tail_call_cnt by tail_call_cnt_ptr

Furthermore, when trampoline is the caller of bpf prog, it is required
to prepare tail_call_cnt and tail call run ctx on the stack of the
trampoline.

Finally, enable bpf_jit_supports_tail_call_cnt_ptr() to use
bpf_tail_call_run_ctx in __bpf_prog_run().

Fixes: d4609a5d8c70 ("bpf, arm64: Keep tail call count across bpf2bpf calls")
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 63 +++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 53347d4217f4b..1160b3619f821 100644
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
@@ -296,19 +296,20 @@ static bool is_lsi_offset(int offset, int scale)
 #define POKE_OFFSET (BTI_INSNS + 1)
 
 /* Tail call offset to jump into */
-#define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
+#define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 9)
 
 static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 			  bool is_exception_cb, u64 arena_vm_start)
 {
 	const struct bpf_prog *prog = ctx->prog;
 	const bool is_main_prog = !bpf_is_subprog(prog);
+	const u8 r1 = bpf2a64[BPF_REG_1];
 	const u8 r6 = bpf2a64[BPF_REG_6];
 	const u8 r7 = bpf2a64[BPF_REG_7];
 	const u8 r8 = bpf2a64[BPF_REG_8];
 	const u8 r9 = bpf2a64[BPF_REG_9];
 	const u8 fp = bpf2a64[BPF_REG_FP];
-	const u8 tcc = bpf2a64[TCALL_CNT];
+	const u8 ptr = bpf2a64[TCCNT_PTR];
 	const u8 fpb = bpf2a64[FP_BOTTOM];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
 	const int idx0 = ctx->idx;
@@ -359,7 +360,7 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 		/* Save callee-saved registers */
 		emit(A64_PUSH(r6, r7, A64_SP), ctx);
 		emit(A64_PUSH(r8, r9, A64_SP), ctx);
-		emit(A64_PUSH(fp, tcc, A64_SP), ctx);
+		emit(A64_PUSH(fp, ptr, A64_SP), ctx);
 		emit(A64_PUSH(fpb, A64_R(28), A64_SP), ctx);
 	} else {
 		/*
@@ -381,8 +382,15 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 	emit(A64_MOV(1, fp, A64_SP), ctx);
 
 	if (!ebpf_from_cbpf && is_main_prog) {
-		/* Initialize tail_call_cnt */
-		emit(A64_MOVZ(1, tcc, 0, 0), ctx);
+		if (prog->aux->tail_call_reachable) {
+			/* Cache tcc_ptr. */
+			emit(A64_LDR64I(ptr, r1, 8), ctx);
+			/* Restore the original ctx. */
+			emit(A64_LDR64I(r1, r1, 0), ctx);
+		} else {
+			emit(A64_NOP, ctx);
+			emit(A64_NOP, ctx);
+		}
 
 		cur_offset = ctx->idx - idx0;
 		if (cur_offset != PROLOGUE_OFFSET) {
@@ -432,7 +440,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 prg = bpf2a64[TMP_REG_2];
-	const u8 tcc = bpf2a64[TCALL_CNT];
+	const u8 ptr = bpf2a64[TCCNT_PTR];
+	const u8 tcc = bpf2a64[TMP_REG_3];
 	const int idx0 = ctx->idx;
 #define cur_offset (ctx->idx - idx0)
 #define jmp_offset (out_offset - (cur_offset))
@@ -449,14 +458,16 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	emit(A64_B_(A64_COND_CS, jmp_offset), ctx);
 
 	/*
-	 * if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
+	 * if ((*tcc_ptr) >= MAX_TAIL_CALL_CNT)
 	 *     goto out;
-	 * tail_call_cnt++;
+	 * (*tcc_ptr)++;
 	 */
 	emit_a64_mov_i64(tmp, MAX_TAIL_CALL_CNT, ctx);
+	emit(A64_LDR32I(tcc, ptr, 0), ctx);
 	emit(A64_CMP(1, tcc, tmp), ctx);
 	emit(A64_B_(A64_COND_CS, jmp_offset), ctx);
 	emit(A64_ADD_I(1, tcc, tcc, 1), ctx);
+	emit(A64_STR32I(tcc, ptr, 0), ctx);
 
 	/* prog = array->ptrs[index];
 	 * if (prog == NULL)
@@ -1890,15 +1901,28 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+/* Indicate the JIT backend supports tail call count pointer in tailcall context. */
+bool bpf_jit_supports_tail_call_cnt_ptr(void)
+{
+	return true;
+}
+
 static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 			    int args_off, int retval_off, int run_ctx_off,
 			    bool save_ret)
 {
+	int tail_call_run_ctx_off = offsetof(struct bpf_tramp_run_ctx, tail_call_run_ctx);
+	int tcc_ptr_off = tail_call_run_ctx_off + offsetof(struct bpf_tail_call_run_ctx,
+							   tail_call_cnt_ptr);
+	int tail_call_cnt_off = offsetof(struct bpf_tramp_run_ctx, tail_call_cnt);
+	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
+	struct bpf_prog *p = l->link.prog;
+	const u8 tmp = bpf2a64[TMP_REG_1];
+	const u8 r1 = bpf2a64[BPF_REG_1];
+	const u8 sp = A64_SP;
 	__le32 *branch;
 	u64 enter_prog;
 	u64 exit_prog;
-	struct bpf_prog *p = l->link.prog;
-	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 
 	enter_prog = (u64)bpf_trampoline_enter(p);
 	exit_prog = (u64)bpf_trampoline_exit(p);
@@ -1936,6 +1960,19 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 	emit(A64_ADD_I(1, A64_R(0), A64_SP, args_off), ctx);
 	if (!p->jited)
 		emit_addr_mov_i64(A64_R(1), (const u64)p->insnsi, ctx);
+	if (p->aux->use_tail_call_run_ctx) {
+		/* Cache the original ctx. */
+		emit(A64_STR64I(r1, sp, run_ctx_off + tail_call_run_ctx_off), ctx);
+		/* Update r1 as tcc_ptr. */
+		emit(A64_ADD_I(1, r1, sp, run_ctx_off + tail_call_cnt_off), ctx);
+		/* Clear tail_call_cnt. */
+		emit_a64_mov_i(0, tmp, 0, ctx);
+		emit(A64_STR32I(tmp, r1, 0), ctx);
+		/* Cache tcc_ptr. */
+		emit(A64_STR64I(r1, sp, run_ctx_off + tcc_ptr_off), ctx);
+		/* Update r1 as tail call run ctx. */
+		emit(A64_ADD_I(1, r1, sp, run_ctx_off + tail_call_run_ctx_off), ctx);
+	}
 
 	emit_call((const u64)p->bpf_func, ctx);
 
-- 
2.44.0


