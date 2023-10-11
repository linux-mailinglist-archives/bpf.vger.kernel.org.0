Return-Path: <bpf+bounces-11924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA6C7C5812
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CC6282386
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 15:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B89208BE;
	Wed, 11 Oct 2023 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjJCVm7/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50765208A5
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:27:45 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B315698
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 08:27:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9b70b9656so14438995ad.1
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697038062; x=1697642862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sb6y+LqvKR8cNpY7OhH023xfl4L6jCAH3jFd8OiIdsI=;
        b=ZjJCVm7/QF2opt8Ei6cx7gspioX37lsVgLzYRrpimAA3qGvvFBB+rsAOzY+ZXUZhnd
         vhjgHYiuFJ1PI7K8Vy6QA1GCuqRR1sOiyAlMnSw9MXprJGB8wW+FYIfV1L7ZHqgsEuC6
         IjdYEuw1CgOKXnpdEIpqhwwImdn2fdSbWeDqSNynMbJBHr9rOPKPe8/0z7MO+nsXbteP
         pvx1Vy6Zkrgbgj3g8j7Ui2AMcN27FP7VvkRzGloKHtD+JcbUjleUyMO3XwkF78M7pYMV
         xX3jNnKKFhDHE+4WmlOqXzFSNyvaq1wlkTbSSmeM3KuXRb6g01B2MmsZt8raZCAHSJng
         MF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697038062; x=1697642862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sb6y+LqvKR8cNpY7OhH023xfl4L6jCAH3jFd8OiIdsI=;
        b=FN4uyrbxxxZbC4QtBoINyQsaS5hHeq1pJHTRfUegxUYffFyD/VABMzkV4KwTV3ZtW9
         u5kHl20JIHvyFnayIu0MMstY8azKi0ZGM7WYpoQnhN4Cwv5jP75poFKtzXtxH1KC/Rjk
         zOd4eVdGhz8cM/xpWmrU8Or8qC1WjJYRczhzoy4o7yrOYWU0LfRCS+Mp7PVOmsIaAd3t
         mmvlWR4dkJynYJ7AYl56YiPe31kZ87J8K8Ospun9abcXdjAArMMXjoVJyTHI4/DwSWTn
         YZg8HG1q/zI2A4WdPC2Ph+y46iVrRsIS0EMw0Q21tW667dKxyifiWyUya/n0+25Xtldc
         hc6A==
X-Gm-Message-State: AOJu0Yz2piJgKrZKLwwJyZSsdlxfwasZXDHfPBKgxNf4HylFptusUQ+m
	RvCChbRMRz+UA3JdyFbF5hoPr3YBdxHM3w==
X-Google-Smtp-Source: AGHT+IEld9NkS3R5Baila4eWFHi9GC/MVXuoM5ZIMEAJHcv+ppz/3dan4Y9Os2rOtFyE/JMKU6X1DQ==
X-Received: by 2002:a17:902:d34b:b0:1c3:7628:fca8 with SMTP id l11-20020a170902d34b00b001c37628fca8mr18142938plk.49.1697038062604;
        Wed, 11 Oct 2023 08:27:42 -0700 (PDT)
Received: from localhost.localdomain (bb119-74-148-123.singnet.com.sg. [119.74.148.123])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b001c755810f89sm14092070plb.181.2023.10.11.08.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:27:42 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	iii@linux.ibm.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com
Subject: [RFC PATCH bpf-next v2 2/4] bpf, x64: Fix tailcall hierarchy
Date: Wed, 11 Oct 2023 23:27:23 +0800
Message-ID: <20231011152725.95895-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011152725.95895-1-hffilwlqm@gmail.com>
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
handling in JIT"), the tailcall on x64 works better than before.

From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
for x64 JIT"), tailcall is able to run in BPF subprograms on x64.

How about:

1. More than 1 subprograms are called in a bpf program.
2. The tailcalls in the subprograms call the bpf program.

Because of missing tail_call_cnt back-propagation, a tailcall hierarchy
comes up. And MAX_TAIL_CALL_CNT limit does not work for this case.

As we know, in tail call context, the tail_call_cnt propagates by stack
and rax register between BPF subprograms. So, propagating tail_call_cnt
pointer by stack and rax register makes tail_call_cnt as like a global
variable, in order to make MAX_TAIL_CALL_CNT limit works for tailcall
hierarchy cases.

Before jumping to other bpf prog, load tail_call_cnt from the pointer
and then compare with MAX_TAIL_CALL_CNT. Finally, increment
tail_call_cnt by its pointer.

But, where does tail_call_cnt store?

It stores on the stack of bpf prog's caller, like

    |  STACK  |
    |         |
    |   rip   |
 +->|   tcc   |
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ RBP
 |  |         |
 |  |         |
 |  |         |
 +--| tcc_ptr |
    |   rbx   |
    +---------+ RSP

And tcc_ptr is unnecessary to be popped from stack at the epilogue of bpf
prog, like the way of commit d207929d97ea028f ("bpf, x64: Drop "pop %rcx"
instruction on BPF JIT epilogue").

Why not back-propagate tail_call_cnt?

It's because it's vulnerable to back-propagate it. It's unable to work
well with the following case.

int prog1();
int prog2();

prog1 is tail caller, and prog2 is tail callee. If we do back-propagate
tail_call_cnt at the epilogue of prog2, can prog2 run standalone at the
same time? The answer is NO. Otherwise, there will be a register to be
polluted, which will make kernel crash.

Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 40 ++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c2a0465d37da4..36631129cc800 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -256,7 +256,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(22 + ENDBR_INSN_SIZE)
 
 static void push_r12(u8 **pprog)
 {
@@ -340,14 +340,21 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	EMIT_ENDBR();
 	emit_nops(&prog, X86_PATCH_SIZE);
 	if (!ebpf_from_cbpf) {
-		if (tail_call_reachable && !is_subprog)
+		if (tail_call_reachable && !is_subprog) {
 			/* When it's the entry of the whole tailcall context,
 			 * zeroing rax means initialising tail_call_cnt.
 			 */
-			EMIT2(0x31, 0xC0); /* xor eax, eax */
-		else
-			/* Keep the same instruction layout. */
-			EMIT2(0x66, 0x90); /* nop2 */
+			EMIT2(0x31, 0xC0);       /* xor eax, eax */
+			EMIT1(0x50);             /* push rax */
+			/* Make rax as ptr that points to tail_call_cnt. */
+			EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
+			EMIT1_off32(0xE8, 2);    /* call main prog */
+			EMIT1(0x59);             /* pop rcx, get rid of tail_call_cnt */
+			EMIT1(0xC3);             /* ret */
+		} else {
+			/* Keep the same instruction size. */
+			emit_nops(&prog, 13);
+		}
 	}
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
@@ -373,6 +380,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
 	if (tail_call_reachable)
+		/* Here, rax is tail_call_cnt_ptr. */
 		EMIT1(0x50);         /* push rax */
 	*pprog = prog;
 }
@@ -528,7 +536,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 					u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;
 
@@ -553,13 +561,12 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
-	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
+	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off); /* mov rax, qword ptr [rbp - tcc_ptr_off] */
+	EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);     /* cmp dword ptr [rax], MAX_TAIL_CALL_CNT */
 
 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                   /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
+	EMIT3(0x83, 0x00, 0x01);                  /* add dword ptr [rax], 1 */
 
 	/* prog = array->ptrs[index]; */
 	EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 + offsetof(...)] */
@@ -581,6 +588,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}
 
+	/* pop tail_call_cnt_ptr */
 	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
@@ -609,7 +617,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 				      bool *callee_regs_used, u32 stack_depth,
 				      struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;
 
@@ -617,13 +625,12 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr [rbp - tcc_off] */
-	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_TAIL_CALL_CNT */
+	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off);   /* mov rax, qword ptr [rbp - tcc_ptr_off] */
+	EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);         /* cmp dword ptr [rax], MAX_TAIL_CALL_CNT */
 
 	offset = ctx->tail_call_direct_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                       /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp - tcc_off], eax */
+	EMIT3(0x83, 0x00, 0x01);                      /* add dword ptr [rax], 1 */
 
 	poke->tailcall_bypass = ip + (prog - start);
 	poke->adj_off = X86_TAIL_CALL_OFFSET;
@@ -640,6 +647,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}
 
+	/* pop tail_call_cnt_ptr */
 	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
-- 
2.41.0


