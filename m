Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EA9437601
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 13:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhJVLgi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 07:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhJVLgh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 07:36:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30E5C061764;
        Fri, 22 Oct 2021 04:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tH5pIJOI/U+2eQ7NqII0xmIw4ZMpa5kckPLZ0Q7TFzg=; b=K7rwG2J8X1clgQ3RxlB272x61g
        6iDu5xotu93EYLHiYWx1r3BVk6cw9UYqHb/w4X0E2hCiJWNBkjjadus0T332fUnfXUNHbRqC1EpmL
        BUtCtrM5aP8bwebUBERXLQMiFCZqWLwJPqEMHifrMnwO71hirO+p1ugTZlYEW3ylOP+WrW2Yy3O2v
        2yJNJo3ZXUyvoTwMFb4F2NA2hGSORAfXZA/LvKqkcLSRuCo9X7aOUHUa6vzImIe9m1xMTE5P0oq8O
        i9bP6kKcMiFuyamnEabSEFUwE5r2ApRWTeeR4sD5X6wDCL4khIKrA6t/7Xu+gi/adFoo6kjbMQ7J+
        FvQcg5JQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdsmG-00DsIh-Im; Fri, 22 Oct 2021 11:32:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E8601300233;
        Fri, 22 Oct 2021 13:31:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B62E22C4AE69D; Fri, 22 Oct 2021 13:31:59 +0200 (CEST)
Date:   Fri, 22 Oct 2021 13:31:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <YXKhLzd/DtkjURpc@hirez.programming.kicks-ass.net>
References: <20211020104442.021802560@infradead.org>
 <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net>
 <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
 <CAADnVQKD6=HwmnTw=Shup7Rav-+OTWJERRYSAn-as6iikqoHEA@mail.gmail.com>
 <20211021223719.GY174703@worktop.programming.kicks-ass.net>
 <CAADnVQ+cJLYL-r6S8TixJxH1JEXXaNojVoewB3aKcsi7Y8XPdQ@mail.gmail.com>
 <20211021233852.gbkyl7wpunyyq4y5@treble>
 <CAADnVQ+iMysKSKBGzx7Wa+ygpr9nTJbRo4eGYADLFDE4PmtjOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+iMysKSKBGzx7Wa+ygpr9nTJbRo4eGYADLFDE4PmtjOQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 04:42:12PM -0700, Alexei Starovoitov wrote:

> Ahh. Right. It's potentially a different offset for every prog.
> Let's put it into struct jit_context then.

Something like this...

---
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -225,6 +225,14 @@ static void jit_fill_hole(void *area, un
 
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
@@ -380,22 +388,6 @@ int bpf_arch_text_poke(void *ip, enum bp
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
@@ -411,29 +403,12 @@ static int get_pop_bytes(bool *callee_re
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
@@ -448,8 +423,9 @@ static void emit_bpf_tail_call_indirect(
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
@@ -457,8 +433,9 @@ static void emit_bpf_tail_call_indirect(
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
 
@@ -471,12 +448,11 @@ static void emit_bpf_tail_call_indirect(
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
@@ -496,38 +472,18 @@ static void emit_bpf_tail_call_indirect(
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
@@ -535,28 +491,30 @@ static void emit_bpf_tail_call_direct(st
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
@@ -1405,13 +1363,16 @@ st:			if (is_imm8(insn->off))
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
