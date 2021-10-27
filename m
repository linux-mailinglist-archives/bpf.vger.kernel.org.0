Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23ED43C5E7
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 11:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbhJ0JC3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 05:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241150AbhJ0JC2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 05:02:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676DEC061745
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=puoZu7p9N+KXOmVqW8fmIuq/VnNO6u9m1U0/aCFiXlc=; b=Ro/2E3PieqKw2KyWhJzUK/fVdD
        bpASHaNIQtBLM1R64t50trLHngJFQPfUJP4szcPohUBsMvzQE6lVm9Bjwa9Uq+a8usIpHd+YOEaYc
        Ev3iFtE2H/cePbqMD8Y8hyyRrNWucHL759JtCtqWOvll214QeqK5GqmL52HJYoiGwAIUltIhzLJRb
        uzCISPsutngyDuqMXUfZScXKG1qleoUKtO15DFljJNXyl1XZLY+vTzS1CVG4CKtWkSpAlzG16Comv
        n/kLCvMWb3eA6x3M/1Ii6nEG99neplLM3MzTjb2fb06SVGMRYnc9/tLk9w5xe5GiipL/+IDG/NGMV
        00YoQvxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfelT-00HWU3-7S
        for bpf@vger.kernel.org; Wed, 27 Oct 2021 08:58:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C0BB230281E
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B10FF236E43D7; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Message-ID: <20211027085521.137194306@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 10:52:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 16/17] bpf, x86: Simplify computing label offsets
References: <20211027085243.008677168@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Take an idea from the 32bit JIT, which uses the multi-pass nature of
the JIT to compute the instruction offsets on a prior pass in order to
compute the relative jump offsets on a later pass.

Application to the x86_64 JIT is slightly more involved because the
offsets depend on program variables (such as callee_regs_used and
stack_depth) and hence the computed offsets need to be kept in the
context of the JIT.

This removes, IMO quite fragile, code that hard-codes the offsets and
tries to compute the length of variable parts of it.

Convert both emit_bpf_tail_call_*() functions which have an out: label
at the end. Additionally emit_bpt_tail_call_direct() also has a poke
table entry, for which it computes the offset from the end (and thus
already relies on the previous pass to have computed addrs[i]), also
convert this to be a forward based offset.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/net/bpf_jit_comp.c |  123 +++++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 81 deletions(-)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -224,6 +224,14 @@ static void jit_fill_hole(void *area, un
 
 struct jit_context {
 	int cleanup_addr; /* Epilogue code offset */
+
+	/*
+	 * Program specific offsets of labels in the code; these rely on the
+	 * JIT doing at least 2 passes, recording the position on the first
+	 * pass, only to generate the correct offset on the second pass.
+	 */
+	int tail_call_direct_label;
+	int tail_call_indirect_label;
 };
 
 /* Maximum number of bytes emitted while JITing one eBPF insn */
@@ -379,22 +387,6 @@ int bpf_arch_text_poke(void *ip, enum bp
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr, true);
 }
 
-static int get_pop_bytes(bool *callee_regs_used)
-{
-	int bytes = 0;
-
-	if (callee_regs_used[3])
-		bytes += 2;
-	if (callee_regs_used[2])
-		bytes += 2;
-	if (callee_regs_used[1])
-		bytes += 2;
-	if (callee_regs_used[0])
-		bytes += 1;
-
-	return bytes;
-}
-
 /*
  * Generate the following code:
  *
@@ -410,29 +402,12 @@ static int get_pop_bytes(bool *callee_re
  * out:
  */
 static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
-					u32 stack_depth)
+					u32 stack_depth, u8 *ip,
+					struct jit_context *ctx)
 {
 	int tcc_off = -4 - round_up(stack_depth, 8);
-	u8 *prog = *pprog;
-	int pop_bytes = 0;
-	int off1 = 42;
-	int off2 = 31;
-	int off3 = 9;
-
-	/* count the additional bytes used for popping callee regs from stack
-	 * that need to be taken into account for each of the offsets that
-	 * are used for bailing out of the tail call
-	 */
-	pop_bytes = get_pop_bytes(callee_regs_used);
-	off1 += pop_bytes;
-	off2 += pop_bytes;
-	off3 += pop_bytes;
-
-	if (stack_depth) {
-		off1 += 7;
-		off2 += 7;
-		off3 += 7;
-	}
+	u8 *prog = *pprog, *start = *pprog;
+	int offset;
 
 	/*
 	 * rdi - pointer to ctx
@@ -447,8 +422,9 @@ static void emit_bpf_tail_call_indirect(
 	EMIT2(0x89, 0xD2);                        /* mov edx, edx */
 	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx */
 	      offsetof(struct bpf_array, map.max_entries));
-#define OFFSET1 (off1 + RETPOLINE_RCX_BPF_JIT_SIZE) /* Number of bytes to jump */
-	EMIT2(X86_JBE, OFFSET1);                  /* jbe out */
+
+	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
+	EMIT2(X86_JBE, offset);                   /* jbe out */
 
 	/*
 	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
@@ -456,8 +432,9 @@ static void emit_bpf_tail_call_indirect(
 	 */
 	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
-#define OFFSET2 (off2 + RETPOLINE_RCX_BPF_JIT_SIZE)
-	EMIT2(X86_JA, OFFSET2);                   /* ja out */
+
+	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
+	EMIT2(X86_JA, offset);                    /* ja out */
 	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
 	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
 
@@ -470,12 +447,11 @@ static void emit_bpf_tail_call_indirect(
 	 *	goto out;
 	 */
 	EMIT3(0x48, 0x85, 0xC9);                  /* test rcx,rcx */
-#define OFFSET3 (off3 + RETPOLINE_RCX_BPF_JIT_SIZE)
-	EMIT2(X86_JE, OFFSET3);                   /* je out */
 
-	*pprog = prog;
-	pop_callee_regs(pprog, callee_regs_used);
-	prog = *pprog;
+	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
+	EMIT2(X86_JE, offset);                    /* je out */
+
+	pop_callee_regs(&prog, callee_regs_used);
 
 	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
@@ -495,38 +471,18 @@ static void emit_bpf_tail_call_indirect(
 	RETPOLINE_RCX_BPF_JIT();
 
 	/* out: */
+	ctx->tail_call_indirect_label = prog - start;
 	*pprog = prog;
 }
 
 static void emit_bpf_tail_call_direct(struct bpf_jit_poke_descriptor *poke,
-				      u8 **pprog, int addr, u8 *image,
-				      bool *callee_regs_used, u32 stack_depth)
+				      u8 **pprog, u8 *ip,
+				      bool *callee_regs_used, u32 stack_depth,
+				      struct jit_context *ctx)
 {
 	int tcc_off = -4 - round_up(stack_depth, 8);
-	u8 *prog = *pprog;
-	int pop_bytes = 0;
-	int off1 = 20;
-	int poke_off;
-
-	/* count the additional bytes used for popping callee regs to stack
-	 * that need to be taken into account for jump offset that is used for
-	 * bailing out from of the tail call when limit is reached
-	 */
-	pop_bytes = get_pop_bytes(callee_regs_used);
-	off1 += pop_bytes;
-
-	/*
-	 * total bytes for:
-	 * - nop5/ jmpq $off
-	 * - pop callee regs
-	 * - sub rsp, $val if depth > 0
-	 * - pop rax
-	 */
-	poke_off = X86_PATCH_SIZE + pop_bytes + 1;
-	if (stack_depth) {
-		poke_off += 7;
-		off1 += 7;
-	}
+	u8 *prog = *pprog, *start = *pprog;
+	int offset;
 
 	/*
 	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
@@ -534,28 +490,30 @@ static void emit_bpf_tail_call_direct(st
 	 */
 	EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr [rbp - tcc_off] */
 	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_TAIL_CALL_CNT */
-	EMIT2(X86_JA, off1);                          /* ja out */
+
+	offset = ctx->tail_call_direct_label - (prog + 2 - start);
+	EMIT2(X86_JA, offset);                        /* ja out */
 	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
 	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp - tcc_off], eax */
 
-	poke->tailcall_bypass = image + (addr - poke_off - X86_PATCH_SIZE);
+	poke->tailcall_bypass = ip + (prog - start);
 	poke->adj_off = X86_TAIL_CALL_OFFSET;
-	poke->tailcall_target = image + (addr - X86_PATCH_SIZE);
+	poke->tailcall_target = ip + ctx->tail_call_direct_label - X86_PATCH_SIZE;
 	poke->bypass_addr = (u8 *)poke->tailcall_target + X86_PATCH_SIZE;
 
 	emit_jump(&prog, (u8 *)poke->tailcall_target + X86_PATCH_SIZE,
 		  poke->tailcall_bypass);
 
-	*pprog = prog;
-	pop_callee_regs(pprog, callee_regs_used);
-	prog = *pprog;
+	pop_callee_regs(&prog, callee_regs_used);
 	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
 
 	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
 	prog += X86_PATCH_SIZE;
+
 	/* out: */
+	ctx->tail_call_direct_label = prog - start;
 
 	*pprog = prog;
 }
@@ -1404,13 +1362,16 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_TAIL_CALL:
 			if (imm32)
 				emit_bpf_tail_call_direct(&bpf_prog->aux->poke_tab[imm32 - 1],
-							  &prog, addrs[i], image,
+							  &prog, image + addrs[i - 1],
 							  callee_regs_used,
-							  bpf_prog->aux->stack_depth);
+							  bpf_prog->aux->stack_depth,
+							  ctx);
 			else
 				emit_bpf_tail_call_indirect(&prog,
 							    callee_regs_used,
-							    bpf_prog->aux->stack_depth);
+							    bpf_prog->aux->stack_depth,
+							    image + addrs[i - 1],
+							    ctx);
 			break;
 
 			/* cond jump */


