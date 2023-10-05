Return-Path: <bpf+bounces-11449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 251F37BA1C3
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 16:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 95D8C282069
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9692E621;
	Thu,  5 Oct 2023 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0LD4pEM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F052374C
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 14:58:55 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB3826A53
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 07:58:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c87e55a6baso7563275ad.3
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696517932; x=1697122732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffQ3SlMsuh6JVcz2jUUw+P58EKLFWVJQbhH4F0zHOs8=;
        b=Z0LD4pEMWouZDfzPtGiGykQAb3RMTXKvFCEFmS7UUfRrcqhbr2YJmTa+7Xu/Fz1ng4
         ksIQPve03gpNcNrMlb3+poOw0bW8SRo3tLFmPOOQ2ql+z2FeuY0CUq2ptQl341LQL+e3
         5cNziUN3aYiC4bM3+sqhlt/Gas3t61V2hBBrywbY8EjB8z8Pp91MwRzfMMaJnLGVDZ5V
         uQga0yhONAKMkxZjhLbJlzmjbOA0emLuMZ/tSd0OILkaUWjYrH7xtZHsF5XFH0ZehIFH
         tUUIXbLKm4K700Ks+z2t4SmXYrvbp31Mhlzyf2+W3oOgZHyFBFAB1gA0MWlnKCg5CCQt
         i/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517932; x=1697122732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffQ3SlMsuh6JVcz2jUUw+P58EKLFWVJQbhH4F0zHOs8=;
        b=MLd03GxOaI22nqaWb1J6MBDgI+JEGj1MZJkJjxKkirzvA5nSftg4AEUym72K5kbP3M
         F3JiUWQPGxnbNG6rLN+EedKBGPq/QXgHFTKxOYo+t8Dtd+G5w4oDL9sy2O5IvaL+m8ND
         ANAeK6/6xUbDPeBgRRrJ/BcuzxOrOlnEA865pdDRnEtE0imvAnw91DzKVxgY3HQ/IMiP
         xbsLWInphzijqxLhNMTV10HwjcL+q+Pufg4GC4jL5TBgb4ucaJx0KBSdD96Xu9o/tZox
         O7z86nHlZerlj33kxArRaKNh9EjKpWiXATuuEcUNyqnW7sA0pi/ZDF1PNKyipRkLuJCE
         Si6g==
X-Gm-Message-State: AOJu0Yw7pfIUdnTAoUJ/EJUIsOBTwPozKYqk0PvcdtORd0pTV27/XvYy
	kD9VlNcG4IGteAE7aT32O0Lrco73EtQBCg==
X-Google-Smtp-Source: AGHT+IG37bFSr/veO9BBsduhDwaHG9p5ou5CFKWr2PIZjcbFewyLSbNvf/bKdsx9KEIMHSgQbYRZIg==
X-Received: by 2002:a17:902:ce8a:b0:1c5:ecfb:b69e with SMTP id f10-20020a170902ce8a00b001c5ecfbb69emr5735065plg.56.1696517932135;
        Thu, 05 Oct 2023 07:58:52 -0700 (PDT)
Received: from localhost.localdomain (bb119-74-148-123.singnet.com.sg. [119.74.148.123])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902a3c100b001c61512f2a6sm1819930plb.220.2023.10.05.07.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 07:58:51 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 1/3] bpf, x64: Fix tailcall hierarchy
Date: Thu,  5 Oct 2023 22:58:12 +0800
Message-ID: <20231005145814.83122-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005145814.83122-1-hffilwlqm@gmail.com>
References: <20231005145814.83122-1-hffilwlqm@gmail.com>
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
tail_call_cnt by the pointer.

But, where does tail_call_cnt store?

It stores on the stack of uppest-hierarchy-layer bpf prog, like

 |  STACK  |
 +---------+ RBP
 |         |
 |         |
 |         |
 | tcc_ptr |
 |   tcc   |
 |   rbx   |
 +---------+ RSP

Why not back-propagate tail_call_cnt?

It's because it's vulnerable to back-propagate it. It's unable to work
well with the following case.

int prog1();
int prog2();

prog1 is tail caller, and prog2 is tail callee. If we do back-propagate
tail_call_cnt at the epilogue of prog2, can prog2 run standalone at the
same time? The answer is NO. Otherwise, there will be a register to be
polluted, which will make kernel crash.

Can tail_call_cnt store at other place instead of the stack of bpf prog?

I'm not able to infer a better place to store tail_call_cnt. It's not a
working inference to store it at ctx or on the stack of bpf prog's
caller.

Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 120 +++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 44 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8c10d9abc2394..8ad6368353c2b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -256,7 +256,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(24 + ENDBR_INSN_SIZE)
 
 static void push_r12(u8 **pprog)
 {
@@ -304,6 +304,25 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
 	*pprog = prog;
 }
 
+static void emit_nops(u8 **pprog, int len)
+{
+	u8 *prog = *pprog;
+	int i, noplen;
+
+	while (len > 0) {
+		noplen = len;
+
+		if (noplen > ASM_NOP_MAX)
+			noplen = ASM_NOP_MAX;
+
+		for (i = 0; i < noplen; i++)
+			EMIT1(x86_nops[noplen][i]);
+		len -= noplen;
+	}
+
+	*pprog = prog;
+}
+
 /*
  * Emit x86-64 prologue code for BPF program.
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
@@ -313,24 +332,15 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 			  bool tail_call_reachable, bool is_subprog,
 			  bool is_exception_cb)
 {
+	int tcc_ptr_off = round_up(stack_depth, 8) + 8;
+	int tcc_off = tcc_ptr_off + 8;
 	u8 *prog = *pprog;
 
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
 	EMIT_ENDBR();
-	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
-	prog += X86_PATCH_SIZE;
-	if (!ebpf_from_cbpf) {
-		if (tail_call_reachable && !is_subprog)
-			/* When it's the entry of the whole tailcall context,
-			 * zeroing rax means initialising tail_call_cnt.
-			 */
-			EMIT2(0x31, 0xC0); /* xor eax, eax */
-		else
-			/* Keep the same instruction layout. */
-			EMIT2(0x66, 0x90); /* nop2 */
-	}
+	emit_nops(&prog, X86_PATCH_SIZE);
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
 		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
@@ -347,15 +357,52 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 		EMIT1(0x55);             /* push rbp */
 		EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
 	}
+	if (!ebpf_from_cbpf) {
+		if (tail_call_reachable && !is_subprog) {
+			/* Make rax as ptr that points to tail_call_cnt. */
+			EMIT3(0x48, 0x89, 0xE8);          /* mov rax, rbp */
+			EMIT2_off32(0x48, 0x2D, tcc_off); /* sub rax, tcc_off */
+			/* When it's the entry of the whole tail call context,
+			 * storing 0 means initialising tail_call_cnt.
+			 */
+			EMIT2_off32(0xC7, 0x00, 0);       /* mov dword ptr [rax], 0 */
+		} else {
+			/* Keep the same instruction layout. */
+			emit_nops(&prog, 3);
+			emit_nops(&prog, 6);
+			emit_nops(&prog, 6);
+		}
+	}
 
 	/* X86_TAIL_CALL_OFFSET is here */
 	EMIT_ENDBR();
 
+	if (tail_call_reachable) {
+		/* Here, rax is tail_call_cnt_ptr. */
+		if (!is_subprog) {
+			/* Because pushing tail_call_cnt_ptr may cover tail_call_cnt,
+			 * it's required to store tail_call_cnt before storing
+			 * tail_call_cnt_ptr.
+			 */
+			EMIT1(0x50);                       /* push rax */
+			EMIT2(0x8B, 0x00);                 /* mov eax, dword ptr [rax] */
+			EMIT2_off32(0x89, 0x85, -tcc_off); /* mov dword ptr [rbp - tcc_off], eax */
+			EMIT1(0x58);                       /* pop rax */
+			/* mov qword ptr [rbp - tcc_ptr_off], rax */
+			EMIT3_off32(0x48, 0x89, 0x85, -tcc_ptr_off);
+		} else {
+			/* As for subprog, tail_call_cnt is meaningless. Storing
+			 * tail_call_cnt_ptr is enough.
+			 */
+			/* mov qword ptr [rbp - tcc_ptr_off], rax */
+			EMIT3_off32(0x48, 0x89, 0x85, -tcc_ptr_off);
+		}
+		/* Reserve 16 bytes for tail_call_cnt_ptr and tail_call_cnt. */
+		stack_depth += 16;
+	}
 	/* sub rsp, rounded_stack_depth */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
-	if (tail_call_reachable)
-		EMIT1(0x50);         /* push rax */
 	*pprog = prog;
 }
 
@@ -510,7 +557,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 					u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;
 
@@ -535,13 +582,12 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
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
@@ -563,6 +609,9 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}
 
+	/* pop tail_call_cnt */
+	EMIT1(0x58);                              /* pop rax */
+	/* pop tail_call_cnt_ptr */
 	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
@@ -591,7 +640,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 				      bool *callee_regs_used, u32 stack_depth,
 				      struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;
 
@@ -599,13 +648,12 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
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
@@ -622,6 +670,9 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}
 
+	/* pop tail_call_cnt */
+	EMIT1(0x58);                                  /* pop rax */
+	/* pop tail_call_cnt_ptr */
 	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
@@ -989,25 +1040,6 @@ static void detect_reg_usage(struct bpf_insn *insn, int insn_cnt,
 	}
 }
 
-static void emit_nops(u8 **pprog, int len)
-{
-	u8 *prog = *pprog;
-	int i, noplen;
-
-	while (len > 0) {
-		noplen = len;
-
-		if (noplen > ASM_NOP_MAX)
-			noplen = ASM_NOP_MAX;
-
-		for (i = 0; i < noplen; i++)
-			EMIT1(x86_nops[noplen][i]);
-		len -= noplen;
-	}
-
-	*pprog = prog;
-}
-
 /* emit the 3-byte VEX prefix
  *
  * r: same as rex.r, extra bit for ModRM reg field
-- 
2.41.0


