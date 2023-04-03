Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4746D4355
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 13:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjDCLVe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 07:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjDCLVb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 07:21:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA07CA09
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 04:21:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m2so28954482wrh.6
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 04:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680520883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQn2yzEyL2A0VMnRSEc8PdRzNc8jB1uumH4iv+faAK8=;
        b=eytrtE1vJcUZSOX3O3iCd0iubX7/PORqcQyztaSpURK3+gk+ATWw0XDaEyCV/krp9q
         /8RxpMdr4QmY+BDwpprJPI8iphoKwnlFNqaQ7Wd8ps70XxETPvL21lpbvSkGj6ZF1sr+
         W4YxdztO3pU2ECxivfoZ3K6qZdK2Yg0Rat8TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680520883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQn2yzEyL2A0VMnRSEc8PdRzNc8jB1uumH4iv+faAK8=;
        b=vWPzpPAlobPHA4j9F3ObPTxlU57SlRX+8ZcwkBpW1hlgypOECZSz4FllKqiO/Fmilf
         8L+oFKs0TbGXWo18xTIfiAdQ65gFU54/R+bOOQmt4u4xnHo3SX0IV6DNPUa8YylV4Wsm
         cChVhV5t0QmUoFzFXt/8AkJwFA+/hEwyxYw2EiRFFXakh6F6s/gCkP5mAllTSdycg3Pg
         CU9bp2XTZdUPQnjNeCPeSPtf1hTzqeonv+esu/iw36AbuDJLc4kGrkHNaf0LasJZMJ/R
         UQfgfFrbtFC/cis2PCPuM+UQMmjJPnxUxnsRsdxfb445AdZHZ5SyT1rxmm0vRyjHkxaC
         L2jw==
X-Gm-Message-State: AAQBX9dye1cjr2rBXoZ0uIcSJk8rQPWW0UHC5M5m+Egnek+0Mw42OjiP
        oFePmfAzFylYAo6AGaTRWddIxA==
X-Google-Smtp-Source: AKy350YzPKegNjWnxyQ02cbiW8DJW9KW9laWGvDP39/pgWyK0n4CjW/LV0N8cAIULmr6YMMsSymVqA==
X-Received: by 2002:a5d:4603:0:b0:2d0:8ed9:5ab4 with SMTP id t3-20020a5d4603000000b002d08ed95ab4mr27871140wrq.60.1680520883107;
        Mon, 03 Apr 2023 04:21:23 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:b5a2:4ffd:8524:ac1])
        by smtp.gmail.com with ESMTPSA id u13-20020adfeb4d000000b002daeb108304sm9510031wrn.33.2023.04.03.04.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 04:21:22 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v4 1/4] arm64: ftrace: Add direct call support
Date:   Mon,  3 Apr 2023 13:20:56 +0200
Message-Id: <20230403112059.2749695-2-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.423.gd6c402a77b-goog
In-Reply-To: <20230403112059.2749695-1-revest@chromium.org>
References: <20230403112059.2749695-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This builds up on the CALL_OPS work which extends the ftrace patchsite
on arm64 with an ops pointer usable by the ftrace trampoline.

This ops pointer is valid at all time. Indeed, it is either pointing to
ftrace_list_ops or to the single ops which should be called from that
patchsite.

There are a few cases to distinguish:
- If a direct call ops is the only one tracing a function:
  - If the direct called trampoline is within the reach of a BL
    instruction
     -> the ftrace patchsite jumps to the trampoline
  - Else
     -> the ftrace patchsite jumps to the ftrace_caller trampoline which
        reads the ops pointer in the patchsite and jumps to the direct
        call address stored in the ops
- Else
  -> the ftrace patchsite jumps to the ftrace_caller trampoline and its
     ops literal points to ftrace_list_ops so it iterates over all
     registered ftrace ops, including the direct call ops and calls its
     call_direct_funcs handler which stores the direct called
     trampoline's address in the ftrace_regs and the ftrace_caller
     trampoline will return to that address instead of returning to the
     traced function

Signed-off-by: Florent Revest <revest@chromium.org>
Co-developed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/Kconfig               |  4 ++
 arch/arm64/include/asm/ftrace.h  | 22 ++++++++
 arch/arm64/kernel/asm-offsets.c  |  6 +++
 arch/arm64/kernel/entry-ftrace.S | 90 ++++++++++++++++++++++++++------
 arch/arm64/kernel/ftrace.c       | 36 +++++++++++--
 5 files changed, 138 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1023e896d46b..f3503d0cc1b8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -185,6 +185,10 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
+		if $(cc-option,-fpatchable-function-entry=2)
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
+		if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
 		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG && \
 		    !CC_OPTIMIZE_FOR_SIZE)
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 1c2672bbbf37..b87d70b693c6 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -70,10 +70,19 @@ struct ftrace_ops;
 
 #define arch_ftrace_get_regs(regs) NULL
 
+/*
+ * Note: sizeof(struct ftrace_regs) must be a multiple of 16 to ensure correct
+ * stack alignment
+ */
 struct ftrace_regs {
 	/* x0 - x8 */
 	unsigned long regs[9];
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	unsigned long direct_tramp;
+#else
 	unsigned long __unused;
+#endif
 
 	unsigned long fp;
 	unsigned long lr;
@@ -136,6 +145,19 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
 #define ftrace_graph_func ftrace_graph_func
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
+						 unsigned long addr)
+{
+	/*
+	 * The ftrace trampoline will return to this address instead of the
+	 * instrumented function.
+	 */
+	fregs->direct_tramp = addr;
+}
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 #endif
 
 #define ftrace_return_address(n) return_address(n)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index ae345b06e9f7..0996094b0d22 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -93,6 +93,9 @@ int main(void)
   DEFINE(FREGS_LR,		offsetof(struct ftrace_regs, lr));
   DEFINE(FREGS_SP,		offsetof(struct ftrace_regs, sp));
   DEFINE(FREGS_PC,		offsetof(struct ftrace_regs, pc));
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+  DEFINE(FREGS_DIRECT_TRAMP,	offsetof(struct ftrace_regs, direct_tramp));
+#endif
   DEFINE(FREGS_SIZE,		sizeof(struct ftrace_regs));
   BLANK();
 #endif
@@ -197,6 +200,9 @@ int main(void)
 #endif
 #ifdef CONFIG_FUNCTION_TRACER
   DEFINE(FTRACE_OPS_FUNC,		offsetof(struct ftrace_ops, func));
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+  DEFINE(FTRACE_OPS_DIRECT_CALL,	offsetof(struct ftrace_ops, direct_call));
+#endif
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 350ed81324ac..1c38a60575aa 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -36,6 +36,31 @@
 SYM_CODE_START(ftrace_caller)
 	bti	c
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+	/*
+	 * The literal pointer to the ops is at an 8-byte aligned boundary
+	 * which is either 12 or 16 bytes before the BL instruction in the call
+	 * site. See ftrace_call_adjust() for details.
+	 *
+	 * Therefore here the LR points at `literal + 16` or `literal + 20`,
+	 * and we can find the address of the literal in either case by
+	 * aligning to an 8-byte boundary and subtracting 16. We do the
+	 * alignment first as this allows us to fold the subtraction into the
+	 * LDR.
+	 */
+	bic	x11, x30, 0x7
+	ldr	x11, [x11, #-(4 * AARCH64_INSN_SIZE)]		// op
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	/*
+	 * If the op has a direct call, handle it immediately without
+	 * saving/restoring registers.
+	 */
+	ldr	x17, [x11, #FTRACE_OPS_DIRECT_CALL]		// op->direct_call
+	cbnz	x17, ftrace_caller_direct
+#endif
+#endif
+
 	/* Save original SP */
 	mov	x10, sp
 
@@ -49,6 +74,10 @@ SYM_CODE_START(ftrace_caller)
 	stp	x6, x7, [sp, #FREGS_X6]
 	str	x8,     [sp, #FREGS_X8]
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	str	xzr, [sp, #FREGS_DIRECT_TRAMP]
+#endif
+
 	/* Save the callsite's FP, LR, SP */
 	str	x29, [sp, #FREGS_FP]
 	str	x9,  [sp, #FREGS_LR]
@@ -71,20 +100,7 @@ SYM_CODE_START(ftrace_caller)
 	mov	x3, sp					// regs
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
-	/*
-	 * The literal pointer to the ops is at an 8-byte aligned boundary
-	 * which is either 12 or 16 bytes before the BL instruction in the call
-	 * site. See ftrace_call_adjust() for details.
-	 *
-	 * Therefore here the LR points at `literal + 16` or `literal + 20`,
-	 * and we can find the address of the literal in either case by
-	 * aligning to an 8-byte boundary and subtracting 16. We do the
-	 * alignment first as this allows us to fold the subtraction into the
-	 * LDR.
-	 */
-	bic	x2, x30, 0x7
-	ldr	x2, [x2, #-16]				// op
-
+	mov	x2, x11					// op
 	ldr	x4, [x2, #FTRACE_OPS_FUNC]		// op->func
 	blr	x4					// op->func(ip, parent_ip, op, regs)
 
@@ -107,8 +123,15 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	ldp	x6, x7, [sp, #FREGS_X6]
 	ldr	x8,     [sp, #FREGS_X8]
 
-	/* Restore the callsite's FP, LR, PC */
+	/* Restore the callsite's FP */
 	ldr	x29, [sp, #FREGS_FP]
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	ldr	x17, [sp, #FREGS_DIRECT_TRAMP]
+	cbnz	x17, ftrace_caller_direct_late
+#endif
+
+	/* Restore the callsite's LR and PC */
 	ldr	x30, [sp, #FREGS_LR]
 	ldr	x9,  [sp, #FREGS_PC]
 
@@ -116,8 +139,45 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	add	sp, sp, #FREGS_SIZE + 32
 
 	ret	x9
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+SYM_INNER_LABEL(ftrace_caller_direct_late, SYM_L_LOCAL)
+	/*
+	 * Head to a direct trampoline in x17 after having run other tracers.
+	 * The ftrace_regs are live, and x0-x8 and FP have been restored. The
+	 * LR, PC, and SP have not been restored.
+	 */
+
+	/*
+	 * Restore the callsite's LR and PC matching the trampoline calling
+	 * convention.
+	 */
+	ldr	x9,  [sp, #FREGS_LR]
+	ldr	x30, [sp, #FREGS_PC]
+
+	/* Restore the callsite's SP */
+	add	sp, sp, #FREGS_SIZE + 32
+
+SYM_INNER_LABEL(ftrace_caller_direct, SYM_L_LOCAL)
+	/*
+	 * Head to a direct trampoline in x17.
+	 *
+	 * We use `BR X17` as this can safely land on a `BTI C` or `PACIASP` in
+	 * the trampoline, and will not unbalance any return stack.
+	 */
+	br	x17
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 SYM_CODE_END(ftrace_caller)
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+SYM_CODE_START(ftrace_stub_direct_tramp)
+	bti	c
+	mov	x10, x30
+	mov	x30, x9
+	ret	x10
+SYM_CODE_END(ftrace_stub_direct_tramp)
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 
 /*
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 5545fe1a9012..758436727fba 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -206,6 +206,13 @@ static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
 	return NULL;
 }
 
+static bool reachable_by_bl(unsigned long addr, unsigned long pc)
+{
+	long offset = (long)addr - (long)pc;
+
+	return offset >= -SZ_128M && offset < SZ_128M;
+}
+
 /*
  * Find the address the callsite must branch to in order to reach '*addr'.
  *
@@ -220,14 +227,21 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
 				      unsigned long *addr)
 {
 	unsigned long pc = rec->ip;
-	long offset = (long)*addr - (long)pc;
 	struct plt_entry *plt;
 
+	/*
+	 * If a custom trampoline is unreachable, rely on the ftrace_caller
+	 * trampoline which knows how to indirectly reach that trampoline
+	 * through ops->direct_call.
+	 */
+	if (*addr != FTRACE_ADDR && !reachable_by_bl(*addr, pc))
+		*addr = FTRACE_ADDR;
+
 	/*
 	 * When the target is within range of the 'BL' instruction, use 'addr'
 	 * as-is and branch to that directly.
 	 */
-	if (offset >= -SZ_128M && offset < SZ_128M)
+	if (reachable_by_bl(*addr, pc))
 		return true;
 
 	/*
@@ -330,12 +344,24 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
 {
-	if (WARN_ON_ONCE(old_addr != (unsigned long)ftrace_caller))
+	unsigned long pc = rec->ip;
+	u32 old, new;
+	int ret;
+
+	ret = ftrace_rec_set_ops(rec, arm64_rec_get_ops(rec));
+	if (ret)
+		return ret;
+
+	if (!ftrace_find_callable_addr(rec, NULL, &old_addr))
 		return -EINVAL;
-	if (WARN_ON_ONCE(addr != (unsigned long)ftrace_caller))
+	if (!ftrace_find_callable_addr(rec, NULL, &addr))
 		return -EINVAL;
 
-	return ftrace_rec_update_ops(rec);
+	old = aarch64_insn_gen_branch_imm(pc, old_addr,
+					  AARCH64_INSN_BRANCH_LINK);
+	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
+
+	return ftrace_modify_code(pc, old, new, true);
 }
 #endif
 
-- 
2.40.0.423.gd6c402a77b-goog

