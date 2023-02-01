Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB92686BE2
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 17:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjBAQfz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 11:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjBAQfr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 11:35:47 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C96677A6
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 08:35:34 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n13so6114202wmr.4
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 08:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbHY+Gmtwa2HHtiXzFaehEcw/QkGNqN5J6j1VumLZ5w=;
        b=B5Kk5qpWjq/NWChUoJdLAZ15WLm2v1L//Jj1sE7X8MZC3AVQVVYby77BqsgXYZk/qt
         b8j//orYYdKgUmjIVviXcRXUnAipPwUDBe7ZWqHGBPP1TTVK+p6qMOTArnZw+wO7ZigT
         3gGskC/gE5tLjsWGLwCN3/IVdjIhSxpQLR9bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbHY+Gmtwa2HHtiXzFaehEcw/QkGNqN5J6j1VumLZ5w=;
        b=e/rpWLblYvbMoF8an9UU8X85kbgR70O2UFDl68dT55IHG965Ij6BTj9f+InaFBauS3
         GalY/hkv5608RBdHLqJwq7ApJZipW6pMSXPA+mwrHqCDlIsUfdO3cxhc6ODF7LdW5yhh
         pBryY4tAFc6NGJGTBSxdGPyWiN4jLAzygAlwwZ22hRgbZU8W+BvgSeh1kSnAs9VgdsBb
         73p9WaXh2i2+8nH3nT9ySa4WJ+G1X+7Q6Fmy+vGqjhYu36qIV2QG8u2MZvz65lyBIucz
         TXvABzl13tUno2691NIUIAvlahEWmUbv1S/biV49R4rkv0ofcFnDgErqAnS8WlKglkxU
         3iJQ==
X-Gm-Message-State: AO0yUKXIqh5JdSNcSU6nwt0jpSi6ImXmTX7tx0bfMSdNDkfS9/QHOv/D
        w8R+p53y+oWpZL79rQcGc6sS4JJkGN7o9UhHDSQ=
X-Google-Smtp-Source: AK7set9M34kub5/FQQZ2rEhTdT78awUB8bbp7/omx+W0n7FyqEelSYMdNpH/uDndWUi0UrY9espvyQ==
X-Received: by 2002:a7b:c5ca:0:b0:3dd:e38b:a12f with SMTP id n10-20020a7bc5ca000000b003dde38ba12fmr5384458wmk.40.1675269332734;
        Wed, 01 Feb 2023 08:35:32 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4399:89a1:4a86:9630])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003dd7edcc960sm2058522wmp.45.2023.02.01.08.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:35:32 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH 7/8] arm64: ftrace: Add direct call support
Date:   Wed,  1 Feb 2023 17:34:19 +0100
Message-Id: <20230201163420.1579014-8-revest@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230201163420.1579014-1-revest@chromium.org>
References: <20230201163420.1579014-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
Suggested-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/Kconfig               |  2 ++
 arch/arm64/include/asm/ftrace.h  | 17 +++++++++
 arch/arm64/kernel/asm-offsets.c  |  6 ++++
 arch/arm64/kernel/entry-ftrace.S | 60 +++++++++++++++++++++++---------
 arch/arm64/kernel/ftrace.c       | 36 ++++++++++++++++---
 5 files changed, 100 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6f6f37161cf6..7deafd653c42 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -188,6 +188,8 @@ config ARM64
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
 		if $(cc-option,-fpatchable-function-entry=2)
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
+		if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
 		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG)
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index cf6d9c42ff36..9fb95966b6d5 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -80,6 +80,10 @@ struct ftrace_regs {
 
 	unsigned long sp;
 	unsigned long pc;
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	unsigned long custom_tramp;
+#endif
 };
 
 static __always_inline unsigned long
@@ -136,6 +140,19 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
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
+	fregs->custom_tramp = addr;
+}
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 #endif
 
 #define ftrace_return_address(n) return_address(n)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index ae345b06e9f7..c67f0373b88c 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -93,6 +93,9 @@ int main(void)
   DEFINE(FREGS_LR,		offsetof(struct ftrace_regs, lr));
   DEFINE(FREGS_SP,		offsetof(struct ftrace_regs, sp));
   DEFINE(FREGS_PC,		offsetof(struct ftrace_regs, pc));
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+  DEFINE(FREGS_CUSTOM_TRAMP,	offsetof(struct ftrace_regs, custom_tramp));
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
index 9869debd22fb..0576f38e6362 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -36,6 +36,30 @@
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
+	/* If the op has a direct call address, return to it */
+	ldr	x12, [x11, #FTRACE_OPS_DIRECT_CALL]		// op->direct_call
+	cbz	x12, 1f
+	ret	x12
+1:
+#endif
+#endif
+
 	/* Save original SP */
 	mov	x10, sp
 
@@ -57,6 +81,11 @@ SYM_CODE_START(ftrace_caller)
 	/* Save the PC after the ftrace callsite */
 	str	x30, [sp, #FREGS_PC]
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	/* Set custom_tramp to zero  */
+	str	xzr, [sp, #FREGS_CUSTOM_TRAMP]
+#endif
+
 	/* Create a frame record for the callsite above the ftrace regs */
 	stp	x29, x9, [sp, #FREGS_SIZE + 16]
 	add	x29, sp, #FREGS_SIZE + 16
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
 
@@ -110,12 +126,24 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	/* Restore the callsite's FP, LR, PC */
 	ldr	x29, [sp, #FREGS_FP]
 	ldr	x30, [sp, #FREGS_LR]
-	ldr	x9,  [sp, #FREGS_PC]
+	ldr	x10, [sp, #FREGS_PC]
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	ldr	x11, [sp, #FREGS_CUSTOM_TRAMP]
+	cbz	x11, 1f
+	/* Set x9 to parent ip before jump to custom trampoline */
+	mov	x9,  x30
+	/* Set lr to self ip */
+	ldr	x30, [sp, #FREGS_PC]
+	/* Set x10 (used for return address) to custom trampoline */
+	mov	x10, x11
+1:
+#endif
 
 	/* Restore the callsite's SP */
 	add	sp, sp, #FREGS_SIZE + 32
 
-	ret	x9
+	ret	x10
 SYM_CODE_END(ftrace_caller)
 
 #if defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS) && \
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
2.39.1.519.gcb327c4b5f-goog

