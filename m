Return-Path: <bpf+bounces-9828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EEE79DCAC
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF9A1C212A8
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490B314A9B;
	Tue, 12 Sep 2023 23:32:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E917C2
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:21 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2505710FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:21 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so789451a12.0
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561539; x=1695166339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ21yuVoz7wiPdHAcyvrcUWYh9xWXZBQttp6kj1ZBwo=;
        b=sivt6lPyZY/n7oI3pZfZSTHjCzg+boSIy8uiJbX9UjvW0+sKy4lSXKrOGpWLCPOjze
         8AmIsomeG1w37AO3cp7yRC/bjEvNdNzVwEYlBgIOVf9j1bVRKaLsDOKw0mfIl2aMkquS
         ZxRS13x4MzuquR5haWgIWGOcnpemmwQl5IjUKA3l4QyHjva7ulkiEVaTFiaQXeY6ITou
         eri8LWWfkOmmaCoD6968u9sdAfS9Sp4S2RkgarokApLm3K8Lje0T3DB66cg4VnxgqZCr
         UQJ5gGSbT74VPSDkZEMBhrcHSAbwe9O41bghzGQJ2xkOJniVBSrRb0QA4+9yps0ZtbqK
         7zKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561539; x=1695166339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ21yuVoz7wiPdHAcyvrcUWYh9xWXZBQttp6kj1ZBwo=;
        b=ibVg88nEiiCix+i45JpXAspV0N407RgL4AioXO6i+bc4wJXaUgSccx2+kkctztwJXR
         K/EPk+jctQq3GKkxPb63WScNVVBjUn165jmdm4wp8l4/z7soyWhN2XjLIbLOYWEW4y+B
         LHFXKoWoZ7EpJRD9ZGN7yG+14veb0lmUbeC1zXPFo5DRS9jKi1eYg5OLQ66SAoYxr4PJ
         8c5VkPWqWgloX1ZKrHO/WwNZgSVaRypG9xEXQD+HG6G+Z41D5oYQ2rs8LpKA9RSG5mBb
         su/h861933cS3si3MEdLxD2PsSVJJYQA8EBSvUi7rwaouTLs4ndC3VSneKBHp9dip9Sy
         fBzQ==
X-Gm-Message-State: AOJu0YxnDMBH1df9xKeZLERqbE0NX92l4PtkNf2a3iqnCXb2txq+M5IU
	t5X8fZQLv4/gLi4dNEuaDA16HmA1vGbfVA==
X-Google-Smtp-Source: AGHT+IHkDC7og1nV7UDcQ/MLZZrddrLeltuD0oMJ9XUE1jTDYrCd3cbpbkQCQO53PMkvX2iJdDWVSw==
X-Received: by 2002:aa7:d8d0:0:b0:523:b37e:b83b with SMTP id k16-20020aa7d8d0000000b00523b37eb83bmr1621715eds.13.1694561538998;
        Tue, 12 Sep 2023 16:32:18 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id m21-20020a50ef15000000b005232ea6a330sm6470428eds.2.2023.09.12.16.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:18 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 04/17] bpf: Implement BPF exceptions
Date: Wed, 13 Sep 2023 01:32:01 +0200
Message-ID: <20230912233214.1518551-5-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=25872; i=memxor@gmail.com; h=from:subject; bh=haq9dFiLNXTn+v6xsXQzWfZbt4kHIpUdng66Xk64EOI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPSszYVUD8edRz1EGJF9jwcyYQROOHCHkWQ37 +lXeM/x6haJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rAAKCRBM4MiGSL8R ypQfEACZpIv+eSsut61HjyrpdwhZfenGSJzSWqYIpYORDpF5nGFjUxBcSOWbDfl5xVMBvJ6XQlo t7jiQ0darTIHxGJTFv/rhyZ3h2imvbtDdKYvhDMgPWexJbnPgExODWQ+YTVG9TA81VOprTqYehD NXCbmKuFR0F28oHTnPC5ZZYYGUrMWCDlt4j5aAYny9FukH7mWdeR1G+HXHRTqYv912d+KxTMq7E GzR8CkpsR58K6BeTB6G62aZQ6TuYxaDF2qxDJm4GtYc8KFu7IwFGPYLcONPh66k1JtA8/aJq1IE +Yts/B1A/q8nKWh8NGNGn9vORM6zjYQkEbV7FfP3BbOx3bPFiu7+9rUY9pPdNwyOCfZoTCCnZyd DwOVlQpgXG1bTR3GihjBHVt3JzyoJt4yN22txGjqLelAHQ8k0zvwdw2OS3EQj0RQWqeuo23zEm3 CrIM89KWcxINB01Jhd9CjW/0mdVXJCdcjecK7RQNBw6WJr0Az3PWLtbD66m7InDCSn5b2ut4Kd7 aruuLhVm/l5sflUY8/AMHoS9JQnqZdGCkesk9/eQIqZvco7vvx2YCRsbKdCXU9S+4hK+ftqH7n6 R0MWAMjC3goaMFhMMgEmwJ8p36lbsaeoRa1ojScwsy10xucSc9+bG+qwTxLHmOKAVoJJWl1hs1p a7EKOrNJUdMyHjA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This patch implements BPF exceptions, and introduces a bpf_throw kfunc
to allow programs to throw exceptions during their execution at runtime.
A bpf_throw invocation is treated as an immediate termination of the
program, returning back to its caller within the kernel, unwinding all
stack frames.

This allows the program to simplify its implementation, by testing for
runtime conditions which the verifier has no visibility into, and assert
that they are true. In case they are not, the program can simply throw
an exception from the other branch.

BPF exceptions are explicitly *NOT* an unlikely slowpath error handling
primitive, and this objective has guided design choices of the
implementation of the them within the kernel (with the bulk of the cost
for unwinding the stack offloaded to the bpf_throw kfunc).

The implementation of this mechanism requires use of add_hidden_subprog
mechanism introduced in the previous patch, which generates a couple of
instructions to move R1 to R0 and exit. The JIT then rewrites the
prologue of this subprog to take the stack pointer and frame pointer as
inputs and reset the stack frame, popping all callee-saved registers
saved by the main subprog. The bpf_throw function then walks the stack
at runtime, and invokes this exception subprog with the stack and frame
pointers as parameters.

Reviewers must take note that currently the main program is made to save
all callee-saved registers on x86_64 during entry into the program. This
is because we must do an equivalent of a lightweight context switch when
unwinding the stack, therefore we need the callee-saved registers of the
caller of the BPF program to be able to return with a sane state.

Note that we have to additionally handle r12, even though it is not used
by the program, because when throwing the exception the program makes an
entry into the kernel which could clobber r12 after saving it on the
stack. To be able to preserve the value we received on program entry, we
push r12 and restore it from the generated subprogram when unwinding the
stack.

For now, bpf_throw invocation fails when lingering resources or locks
exist in that path of the program. In a future followup, bpf_throw will
be extended to perform frame-by-frame unwinding to release lingering
resources for each stack frame, removing this limitation.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c                   |  89 ++++++++++++--
 include/linux/bpf.h                           |   3 +
 include/linux/bpf_verifier.h                  |   4 +
 include/linux/filter.h                        |   6 +
 kernel/bpf/core.c                             |   2 +-
 kernel/bpf/helpers.c                          |  38 ++++++
 kernel/bpf/verifier.c                         | 116 +++++++++++++++---
 .../testing/selftests/bpf/bpf_experimental.h  |  16 +++
 8 files changed, 247 insertions(+), 27 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d0c24b5a6abb..84005f2114e0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -18,6 +18,8 @@
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
 
+static bool all_callee_regs_used[4] = {true, true, true, true};
+
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 {
 	if (len == 1)
@@ -256,6 +258,14 @@ struct jit_context {
 /* Number of bytes that will be skipped on tailcall */
 #define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
 
+static void push_r12(u8 **pprog)
+{
+	u8 *prog = *pprog;
+
+	EMIT2(0x41, 0x54);   /* push r12 */
+	*pprog = prog;
+}
+
 static void push_callee_regs(u8 **pprog, bool *callee_regs_used)
 {
 	u8 *prog = *pprog;
@@ -271,6 +281,14 @@ static void push_callee_regs(u8 **pprog, bool *callee_regs_used)
 	*pprog = prog;
 }
 
+static void pop_r12(u8 **pprog)
+{
+	u8 *prog = *pprog;
+
+	EMIT2(0x41, 0x5C);   /* pop r12 */
+	*pprog = prog;
+}
+
 static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
 {
 	u8 *prog = *pprog;
@@ -292,7 +310,8 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
  * while jumping to another program
  */
 static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
-			  bool tail_call_reachable, bool is_subprog)
+			  bool tail_call_reachable, bool is_subprog,
+			  bool is_exception_cb)
 {
 	u8 *prog = *pprog;
 
@@ -312,8 +331,22 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 			/* Keep the same instruction layout. */
 			EMIT2(0x66, 0x90); /* nop2 */
 	}
-	EMIT1(0x55);             /* push rbp */
-	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
+	/* Exception callback receives FP as third parameter */
+	if (is_exception_cb) {
+		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
+		EMIT3(0x48, 0x89, 0xD5); /* mov rbp, rdx */
+		/* The main frame must have exception_boundary as true, so we
+		 * first restore those callee-saved regs from stack, before
+		 * reusing the stack frame.
+		 */
+		pop_callee_regs(&prog, all_callee_regs_used);
+		pop_r12(&prog);
+		/* Reset the stack frame. */
+		EMIT3(0x48, 0x89, 0xEC); /* mov rsp, rbp */
+	} else {
+		EMIT1(0x55);             /* push rbp */
+		EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
+	}
 
 	/* X86_TAIL_CALL_OFFSET is here */
 	EMIT_ENDBR();
@@ -472,7 +505,8 @@ static void emit_return(u8 **pprog, u8 *ip)
  *   goto *(prog->bpf_func + prologue_size);
  * out:
  */
-static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
+static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
+					u8 **pprog, bool *callee_regs_used,
 					u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
@@ -522,7 +556,12 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JE, offset);                    /* je out */
 
-	pop_callee_regs(&prog, callee_regs_used);
+	if (bpf_prog->aux->exception_boundary) {
+		pop_callee_regs(&prog, all_callee_regs_used);
+		pop_r12(&prog);
+	} else {
+		pop_callee_regs(&prog, callee_regs_used);
+	}
 
 	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
@@ -546,7 +585,8 @@ static void emit_bpf_tail_call_indirect(u8 **pprog, bool *callee_regs_used,
 	*pprog = prog;
 }
 
-static void emit_bpf_tail_call_direct(struct bpf_jit_poke_descriptor *poke,
+static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
+				      struct bpf_jit_poke_descriptor *poke,
 				      u8 **pprog, u8 *ip,
 				      bool *callee_regs_used, u32 stack_depth,
 				      struct jit_context *ctx)
@@ -575,7 +615,13 @@ static void emit_bpf_tail_call_direct(struct bpf_jit_poke_descriptor *poke,
 	emit_jump(&prog, (u8 *)poke->tailcall_target + X86_PATCH_SIZE,
 		  poke->tailcall_bypass);
 
-	pop_callee_regs(&prog, callee_regs_used);
+	if (bpf_prog->aux->exception_boundary) {
+		pop_callee_regs(&prog, all_callee_regs_used);
+		pop_r12(&prog);
+	} else {
+		pop_callee_regs(&prog, callee_regs_used);
+	}
+
 	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
@@ -1050,8 +1096,20 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 
 	emit_prologue(&prog, bpf_prog->aux->stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
-		      bpf_is_subprog(bpf_prog));
-	push_callee_regs(&prog, callee_regs_used);
+		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
+	/* Exception callback will clobber callee regs for its own use, and
+	 * restore the original callee regs from main prog's stack frame.
+	 */
+	if (bpf_prog->aux->exception_boundary) {
+		/* We also need to save r12, which is not mapped to any BPF
+		 * register, as we throw after entry into the kernel, which may
+		 * overwrite r12.
+		 */
+		push_r12(&prog);
+		push_callee_regs(&prog, all_callee_regs_used);
+	} else {
+		push_callee_regs(&prog, callee_regs_used);
+	}
 
 	ilen = prog - temp;
 	if (rw_image)
@@ -1648,13 +1706,15 @@ st:			if (is_imm8(insn->off))
 
 		case BPF_JMP | BPF_TAIL_CALL:
 			if (imm32)
-				emit_bpf_tail_call_direct(&bpf_prog->aux->poke_tab[imm32 - 1],
+				emit_bpf_tail_call_direct(bpf_prog,
+							  &bpf_prog->aux->poke_tab[imm32 - 1],
 							  &prog, image + addrs[i - 1],
 							  callee_regs_used,
 							  bpf_prog->aux->stack_depth,
 							  ctx);
 			else
-				emit_bpf_tail_call_indirect(&prog,
+				emit_bpf_tail_call_indirect(bpf_prog,
+							    &prog,
 							    callee_regs_used,
 							    bpf_prog->aux->stack_depth,
 							    image + addrs[i - 1],
@@ -1907,7 +1967,12 @@ st:			if (is_imm8(insn->off))
 			seen_exit = true;
 			/* Update cleanup_addr */
 			ctx->cleanup_addr = proglen;
-			pop_callee_regs(&prog, callee_regs_used);
+			if (bpf_prog->aux->exception_boundary) {
+				pop_callee_regs(&prog, all_callee_regs_used);
+				pop_r12(&prog);
+			} else {
+				pop_callee_regs(&prog, callee_regs_used);
+			}
 			EMIT1(0xC9);         /* leave */
 			emit_return(&prog, image + addrs[i - 1] + (prog - temp));
 			break;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c3667e95af59..16740ee82082 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1410,6 +1410,8 @@ struct bpf_prog_aux {
 	bool sleepable;
 	bool tail_call_reachable;
 	bool xdp_has_frags;
+	bool exception_cb;
+	bool exception_boundary;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
@@ -1432,6 +1434,7 @@ struct bpf_prog_aux {
 	int cgroup_atype; /* enum cgroup_bpf_attach_type */
 	struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 	char name[BPF_OBJ_NAME_LEN];
+	unsigned int (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp);
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3c2a8636ab29..da21a3ec5027 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -541,7 +541,9 @@ struct bpf_subprog_info {
 	bool has_tail_call;
 	bool tail_call_reachable;
 	bool has_ld_abs;
+	bool is_cb;
 	bool is_async_cb;
+	bool is_exception_cb;
 };
 
 struct bpf_verifier_env;
@@ -589,6 +591,7 @@ struct bpf_verifier_env {
 	u32 used_btf_cnt;		/* number of used BTF objects */
 	u32 id_gen;			/* used to generate unique reg IDs */
 	u32 hidden_subprog_cnt;		/* number of hidden subprogs */
+	int exception_callback_subprog;
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
 	bool allow_uninit_stack;
@@ -596,6 +599,7 @@ struct bpf_verifier_env {
 	bool bypass_spec_v1;
 	bool bypass_spec_v4;
 	bool seen_direct_write;
+	bool seen_exception;
 	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9fd8f0dc4077..389e550a6a25 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1129,6 +1129,7 @@ const char *__bpf_address_lookup(unsigned long addr, unsigned long *size,
 bool is_bpf_text_address(unsigned long addr);
 int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		    char *sym);
+struct bpf_prog *bpf_prog_ksym_find(unsigned long addr);
 
 static inline const char *
 bpf_address_lookup(unsigned long addr, unsigned long *size,
@@ -1196,6 +1197,11 @@ static inline int bpf_get_kallsym(unsigned int symnum, unsigned long *value,
 	return -ERANGE;
 }
 
+static inline struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
+{
+	return NULL;
+}
+
 static inline const char *
 bpf_address_lookup(unsigned long addr, unsigned long *size,
 		   unsigned long *off, char **modname, char *sym)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 840ba952702d..7849b9cca749 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -733,7 +733,7 @@ bool is_bpf_text_address(unsigned long addr)
 	return ret;
 }
 
-static struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
+struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
 {
 	struct bpf_ksym *ksym = bpf_ksym_find(addr);
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b0a9834f1051..78e8f4de6750 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2449,6 +2449,43 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
 	rcu_read_unlock();
 }
 
+struct bpf_throw_ctx {
+	struct bpf_prog_aux *aux;
+	u64 sp;
+	u64 bp;
+	int cnt;
+};
+
+static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
+{
+	struct bpf_throw_ctx *ctx = cookie;
+	struct bpf_prog *prog;
+
+	if (!is_bpf_text_address(ip))
+		return !ctx->cnt;
+	prog = bpf_prog_ksym_find(ip);
+	ctx->cnt++;
+	if (bpf_is_subprog(prog))
+		return true;
+	ctx->aux = prog->aux;
+	ctx->sp = sp;
+	ctx->bp = bp;
+	return false;
+}
+
+__bpf_kfunc void bpf_throw(u64 cookie)
+{
+	struct bpf_throw_ctx ctx = {};
+
+	arch_bpf_stack_walk(bpf_stack_walker, &ctx);
+	WARN_ON_ONCE(!ctx.aux);
+	if (ctx.aux)
+		WARN_ON_ONCE(!ctx.aux->exception_boundary);
+	WARN_ON_ONCE(!ctx.bp);
+	WARN_ON_ONCE(!ctx.cnt);
+	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -2478,6 +2515,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_throw)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 39548e326d53..9baa6f187b38 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -543,6 +543,7 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 }
 
 static bool is_callback_calling_kfunc(u32 btf_id);
+static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
 static bool is_callback_calling_function(enum bpf_func_id func_id)
 {
@@ -1748,7 +1749,9 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 		return -ENOMEM;
 	dst_state->jmp_history_cnt = src->jmp_history_cnt;
 
-	/* if dst has more stack frames then src frame, free them */
+	/* if dst has more stack frames then src frame, free them, this is also
+	 * necessary in case of exceptional exits using bpf_throw.
+	 */
 	for (i = src->curframe + 1; i <= dst_state->curframe; i++) {
 		free_func_state(dst_state->frame[i]);
 		dst_state->frame[i] = NULL;
@@ -2868,7 +2871,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		if (i == subprog_end - 1) {
 			/* to avoid fall-through from one subprog into another
 			 * the last insn of the subprog should be either exit
-			 * or unconditional jump back
+			 * or unconditional jump back or bpf_throw call
 			 */
 			if (code != (BPF_JMP | BPF_EXIT) &&
 			    code != (BPF_JMP32 | BPF_JA) &&
@@ -5661,6 +5664,27 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx)
 	for (; i < subprog_end; i++) {
 		int next_insn, sidx;
 
+		if (bpf_pseudo_kfunc_call(insn + i) && !insn[i].off) {
+			bool err = false;
+
+			if (!is_bpf_throw_kfunc(insn + i))
+				continue;
+			if (subprog[idx].is_cb)
+				err = true;
+			for (int c = 0; c < frame && !err; c++) {
+				if (subprog[ret_prog[c]].is_cb) {
+					err = true;
+					break;
+				}
+			}
+			if (!err)
+				continue;
+			verbose(env,
+				"bpf_throw kfunc (insn %d) cannot be called from callback subprog %d\n",
+				i, idx);
+			return -EINVAL;
+		}
+
 		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
 			continue;
 		/* remember insn and function to return to */
@@ -8919,6 +8943,7 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	 * callbacks
 	 */
 	if (set_callee_state_cb != set_callee_state) {
+		env->subprog_info[subprog].is_cb = true;
 		if (bpf_pseudo_kfunc_call(insn) &&
 		    !is_callback_calling_kfunc(insn->imm)) {
 			verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
@@ -9308,7 +9333,8 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		verbose(env, "to caller at %d:\n", *insn_idx);
 		print_verifier_state(env, caller, true);
 	}
-	/* clear everything in the callee */
+	/* clear everything in the callee. In case of exceptional exits using
+	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
 	free_func_state(callee);
 	state->frame[state->curframe--] = NULL;
 	return 0;
@@ -9432,17 +9458,17 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	return 0;
 }
 
-static int check_reference_leak(struct bpf_verifier_env *env)
+static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
 {
 	struct bpf_func_state *state = cur_func(env);
 	bool refs_lingering = false;
 	int i;
 
-	if (state->frameno && !state->in_callback_fn)
+	if (!exception_exit && state->frameno && !state->in_callback_fn)
 		return 0;
 
 	for (i = 0; i < state->acquired_refs; i++) {
-		if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
+		if (!exception_exit && state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
@@ -9697,7 +9723,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	switch (func_id) {
 	case BPF_FUNC_tail_call:
-		err = check_reference_leak(env);
+		err = check_reference_leak(env, false);
 		if (err) {
 			verbose(env, "tail_call would lead to reference leak\n");
 			return err;
@@ -10332,6 +10358,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_clone,
 	KF_bpf_percpu_obj_new_impl,
 	KF_bpf_percpu_obj_drop_impl,
+	KF_bpf_throw,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -10354,6 +10381,7 @@ BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
+BTF_ID(func, bpf_throw)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -10378,6 +10406,7 @@ BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
+BTF_ID(func, bpf_throw)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -10695,6 +10724,12 @@ static bool is_callback_calling_kfunc(u32 btf_id)
 	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
 }
 
+static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
+{
+	return bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
+	       insn->imm == special_kfunc_list[KF_bpf_throw];
+}
+
 static bool is_rbtree_lock_required_kfunc(u32 btf_id)
 {
 	return is_bpf_rbtree_api_kfunc(btf_id);
@@ -11480,6 +11515,15 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
+		if (!bpf_jit_supports_exceptions()) {
+			verbose(env, "JIT does not support calling kfunc %s#%d\n",
+				func_name, meta.func_id);
+			return -ENOTSUPP;
+		}
+		env->seen_exception = true;
+	}
+
 	for (i = 0; i < CALLER_SAVED_REGS; i++)
 		mark_reg_not_init(env, regs, caller_saved[i]);
 
@@ -14525,7 +14569,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	 * gen_ld_abs() may terminate the program at runtime, leading to
 	 * reference leak.
 	 */
-	err = check_reference_leak(env);
+	err = check_reference_leak(env, false);
 	if (err) {
 		verbose(env, "BPF_LD_[ABS|IND] cannot be mixed with socket references\n");
 		return err;
@@ -16539,6 +16583,7 @@ static int do_check(struct bpf_verifier_env *env)
 	int prev_insn_idx = -1;
 
 	for (;;) {
+		bool exception_exit = false;
 		struct bpf_insn *insn;
 		u8 class;
 		int err;
@@ -16753,12 +16798,17 @@ static int do_check(struct bpf_verifier_env *env)
 						return -EINVAL;
 					}
 				}
-				if (insn->src_reg == BPF_PSEUDO_CALL)
+				if (insn->src_reg == BPF_PSEUDO_CALL) {
 					err = check_func_call(env, insn, &env->insn_idx);
-				else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL)
+				} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 					err = check_kfunc_call(env, insn, &env->insn_idx);
-				else
+					if (!err && is_bpf_throw_kfunc(insn)) {
+						exception_exit = true;
+						goto process_bpf_exit_full;
+					}
+				} else {
 					err = check_helper_call(env, insn, &env->insn_idx);
+				}
 				if (err)
 					return err;
 
@@ -16788,7 +16838,7 @@ static int do_check(struct bpf_verifier_env *env)
 					verbose(env, "BPF_EXIT uses reserved fields\n");
 					return -EINVAL;
 				}
-
+process_bpf_exit_full:
 				if (env->cur_state->active_lock.ptr &&
 				    !in_rbtree_lock_required_cb(env)) {
 					verbose(env, "bpf_spin_unlock is missing\n");
@@ -16807,10 +16857,23 @@ static int do_check(struct bpf_verifier_env *env)
 				 * function, for which reference_state must
 				 * match caller reference state when it exits.
 				 */
-				err = check_reference_leak(env);
+				err = check_reference_leak(env, exception_exit);
 				if (err)
 					return err;
 
+				/* The side effect of the prepare_func_exit
+				 * which is being skipped is that it frees
+				 * bpf_func_state. Typically, process_bpf_exit
+				 * will only be hit with outermost exit.
+				 * copy_verifier_state in pop_stack will handle
+				 * freeing of any extra bpf_func_state left over
+				 * from not processing all nested function
+				 * exits. We also skip return code checks as
+				 * they are not needed for exceptional exits.
+				 */
+				if (exception_exit)
+					goto process_bpf_exit;
+
 				if (state->curframe) {
 					/* exit from nested function */
 					err = prepare_func_exit(env, &env->insn_idx);
@@ -18113,6 +18176,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		}
 		func[i]->aux->num_exentries = num_exentries;
 		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
+		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
+		if (!i)
+			func[i]->aux->exception_boundary = env->seen_exception;
 		func[i] = bpf_int_jit_compile(func[i]);
 		if (!func[i]->jited) {
 			err = -ENOTSUPP;
@@ -18201,6 +18267,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->aux->func = func;
 	prog->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
 	prog->aux->real_func_cnt = env->subprog_cnt;
+	prog->aux->bpf_exception_cb = (void *)func[env->exception_callback_subprog]->bpf_func;
+	prog->aux->exception_boundary = func[0]->aux->exception_boundary;
 	bpf_prog_jit_attempt_done(prog);
 	return 0;
 out_free:
@@ -18437,7 +18505,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 }
 
 /* The function requires that first instruction in 'patch' is insnsi[prog->len - 1] */
-static __maybe_unused int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
+static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
 {
 	struct bpf_subprog_info *info = env->subprog_info;
 	int cnt = env->subprog_cnt;
@@ -18481,6 +18549,26 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	struct bpf_map *map_ptr;
 	int i, ret, cnt, delta = 0;
 
+	if (env->seen_exception && !env->exception_callback_subprog) {
+		struct bpf_insn patch[] = {
+			env->prog->insnsi[insn_cnt - 1],
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		};
+
+		ret = add_hidden_subprog(env, patch, ARRAY_SIZE(patch));
+		if (ret < 0)
+			return ret;
+		prog = env->prog;
+		insn = prog->insnsi;
+
+		env->exception_callback_subprog = env->subprog_cnt - 1;
+		/* Don't update insn_cnt, as add_hidden_subprog always appends insns */
+		env->subprog_info[env->exception_callback_subprog].is_cb = true;
+		env->subprog_info[env->exception_callback_subprog].is_async_cb = true;
+		env->subprog_info[env->exception_callback_subprog].is_exception_cb = true;
+	}
+
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		/* Make divide-by-zero exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4494eaa9937e..333b54a86e3a 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -162,4 +162,20 @@ extern void bpf_percpu_obj_drop_impl(void *kptr, void *meta) __ksym;
 /* Convenience macro to wrap over bpf_obj_drop_impl */
 #define bpf_percpu_obj_drop(kptr) bpf_percpu_obj_drop_impl(kptr, NULL)
 
+/* Description
+ *	Throw a BPF exception from the program, immediately terminating its
+ *	execution and unwinding the stack. The supplied 'cookie' parameter
+ *	will be the return value of the program when an exception is thrown.
+ *
+ *	Note that throwing an exception with lingering resources (locks,
+ *	references, etc.) will lead to a verification error.
+ *
+ *	Note that callbacks *cannot* call this helper.
+ * Returns
+ *	Never.
+ * Throws
+ *	An exception with the specified 'cookie' value.
+ */
+extern void bpf_throw(u64 cookie) __ksym;
+
 #endif
-- 
2.41.0


