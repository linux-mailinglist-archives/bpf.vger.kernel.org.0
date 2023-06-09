Return-Path: <bpf+bounces-2219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 351B772960E
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 11:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E032F2818D1
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7FB14A86;
	Fri,  9 Jun 2023 09:57:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5497313AE9
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 09:57:24 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEE17AB5;
	Fri,  9 Jun 2023 02:57:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-653bed78635so1172530b3a.0;
        Fri, 09 Jun 2023 02:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686304626; x=1688896626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crp08FOLgFvZnpAjUWNQfC7YZ3uDv9qVkOafGIbXOmc=;
        b=Smb8m1uIPGvu+9/rI1RV7KsRjkbz3obLfvopVGmch4HO34+2L5cVmeqUvwT14H9XJ0
         ppMoPMoGIgUMmErqqQVf/X4hV3gXp7w5ZazODxV3j/71+LI1JhIRM6VQtqDNAB9HQocr
         mK6woCwCJqUykOdrHqVgTg0X31rCzfZjQ0IOxOWarwNpReZZarn7sG3E3yTe+TntYSLu
         K2Lkk1QisQh9bTbma2hc4QzLi5Wf9+AgOTtiuml1GXpzsrmpsimuF00QSs45YNtJRpWp
         SvSsXFxVAIyiCyDEzZK5ZGyL4YZPuXyBBDhE+8zti3grnsImeIhyt8wKJf+1mj+c5SEk
         yibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686304626; x=1688896626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Crp08FOLgFvZnpAjUWNQfC7YZ3uDv9qVkOafGIbXOmc=;
        b=I75IBPRVJrxP9c2RK4V68VQwj9Tvm1iLSUWww9AllrvGIvykR2tMe+tUSYnJKNBIna
         OpDhpyzpnsiaCw87L8sMiU7p1vn8pLL9B2NvQeb15hmJfTQr7gZibDYUEXj4H4tUQ0p6
         eyiczDODkpNJJCMTS6zkX465i7Yw2Fv8TDMxMLv8f91/0c7BbWUOV4Ndke7j1xLBENPg
         MpxtBGARAgXwF37yrnG+3A7lw7rf2vlQx5iFVlMOM7cNXPGl/iBfRAToNZz6RwlmfBb7
         gmqkR119ByiEsypqPaX+m1mVd6X1EEZt2gH5AvDaSrgNLbUYVOOr+nVWnuDOZhtpN3MN
         r87w==
X-Gm-Message-State: AC+VfDwYvBzVEU+pG8kSV6N+fo4sl2ZbegPZh51iimIWvSJxh/xZSRra
	Mzcw1KyEaorE8yMOLiKJeao=
X-Google-Smtp-Source: ACHHUZ5klU42zeWXEXFhJ/lUf4IP7IYmKkj0UbDbcezZANyrqtfrx9FeHnNSut6VACtE9beXzChGBA==
X-Received: by 2002:a05:6a21:99a0:b0:117:4d57:d3ad with SMTP id ve32-20020a056a2199a000b001174d57d3admr5350154pzb.3.1686304626199;
        Fri, 09 Jun 2023 02:57:06 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.114])
        by smtp.gmail.com with ESMTPSA id 26-20020a63175a000000b0053f3797fc4asm2603369pgx.0.2023.06.09.02.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:57:05 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v4 1/3] bpf, x86: allow function arguments up to 12 for TRACING
Date: Fri,  9 Jun 2023 17:56:51 +0800
Message-Id: <20230609095653.1406173-2-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609095653.1406173-1-imagedong@tencent.com>
References: <20230609095653.1406173-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Menglong Dong <imagedong@tencent.com>

For now, the BPF program of type BPF_PROG_TYPE_TRACING can only be used
on the kernel functions whose arguments count less than 6. This is not
friendly at all, as too many functions have arguments count more than 6.

According to the current kernel version, below is a statistics of the
function arguments count:

argument count | function count
7              | 704
8              | 270
9              | 84
10             | 47
11             | 47
12             | 27
13             | 22
14             | 5
15             | 0
16             | 1

Therefore, let's enhance it by increasing the function arguments count
allowed in arch_prepare_bpf_trampoline(), for now, only x86_64.

For the case that we don't need to call origin function, which means
without BPF_TRAMP_F_CALL_ORIG, we need only copy the function arguments
that stored in the frame of the caller to current frame. The arguments
of arg6-argN are stored in "$rbp + 0x18", we need copy them to
"$rbp - regs_off + (6 * 8)".

For the case with BPF_TRAMP_F_CALL_ORIG, we need prepare the arguments
in stack before call origin function, which means we need alloc extra
"8 * (arg_count - 6)" memory in the top of the stack. Note, there should
not be any data be pushed to the stack before call the origin function.
Then, we have to store rbx with 'mov' instead of 'push'.

We use EMIT3_off32() or EMIT4() for "lea" and "sub". The range of the
imm in "lea" and "sub" is [-128, 127] if EMIT4() is used. Therefore,
we use EMIT3_off32() instead if the imm out of the range.

It works well for the FENTRY/FEXIT/MODIFY_RETURN, I'm not sure if there
are other complicated cases.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v4:
- make the stack 16-byte aligned if passing args on-stack is needed
- add the function arguments statistics to the commit log
v3:
- use EMIT3_off32() for "lea" and "sub" only on necessary
- make 12 as the maximum arguments count
v2:
- instead EMIT4 with EMIT3_off32 for "lea" to prevent overflow
- make MAX_BPF_FUNC_ARGS as the maximum argument count
---
 arch/x86/net/bpf_jit_comp.c | 125 ++++++++++++++++++++++++++++++++----
 1 file changed, 111 insertions(+), 14 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1056bbf55b17..a767e13c8c85 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1868,7 +1868,7 @@ static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 	 * mov QWORD PTR [rbp-0x10],rdi
 	 * mov QWORD PTR [rbp-0x8],rsi
 	 */
-	for (i = 0, j = 0; i < min(nr_regs, 6); i++) {
+	for (i = 0, j = 0; i < min(nr_regs, MAX_BPF_FUNC_ARGS); i++) {
 		/* The arg_size is at most 16 bytes, enforced by the verifier. */
 		arg_size = m->arg_size[j];
 		if (arg_size > 8) {
@@ -1876,10 +1876,31 @@ static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 			next_same_struct = !next_same_struct;
 		}
 
-		emit_stx(prog, bytes_to_bpf_size(arg_size),
-			 BPF_REG_FP,
-			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
-			 -(stack_size - i * 8));
+		if (i <= 5) {
+			/* copy function arguments from regs into stack */
+			emit_stx(prog, bytes_to_bpf_size(arg_size),
+				 BPF_REG_FP,
+				 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
+				 -(stack_size - i * 8));
+		} else {
+			/* copy function arguments from origin stack frame
+			 * into current stack frame.
+			 *
+			 * The starting address of the arguments on-stack
+			 * is:
+			 *   rbp + 8(push rbp) +
+			 *   8(return addr of origin call) +
+			 *   8(return addr of the caller)
+			 * which means: rbp + 24
+			 */
+			emit_ldx(prog, bytes_to_bpf_size(arg_size),
+				 BPF_REG_0, BPF_REG_FP,
+				 (i - 6) * 8 + 0x18);
+			emit_stx(prog, bytes_to_bpf_size(arg_size),
+				 BPF_REG_FP,
+				 BPF_REG_0,
+				 -(stack_size - i * 8));
+		}
 
 		j = next_same_struct ? j : j + 1;
 	}
@@ -1913,6 +1934,41 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 	}
 }
 
+static void prepare_origin_stack(const struct btf_func_model *m, u8 **prog,
+				 int nr_regs, int stack_size)
+{
+	int i, j, arg_size;
+	bool next_same_struct = false;
+
+	if (nr_regs <= 6)
+		return;
+
+	/* Prepare the function arguments in stack before call origin
+	 * function. These arguments must be stored in the top of the
+	 * stack.
+	 */
+	for (i = 0, j = 0; i < min(nr_regs, MAX_BPF_FUNC_ARGS); i++) {
+		/* The arg_size is at most 16 bytes, enforced by the verifier. */
+		arg_size = m->arg_size[j];
+		if (arg_size > 8) {
+			arg_size = 8;
+			next_same_struct = !next_same_struct;
+		}
+
+		if (i > 5) {
+			emit_ldx(prog, bytes_to_bpf_size(arg_size),
+				 BPF_REG_0, BPF_REG_FP,
+				 (i - 6) * 8 + 0x18);
+			emit_stx(prog, bytes_to_bpf_size(arg_size),
+				 BPF_REG_FP,
+				 BPF_REG_0,
+				 -(stack_size - (i - 6) * 8));
+		}
+
+		j = next_same_struct ? j : j + 1;
+	}
+}
+
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 			   struct bpf_tramp_link *l, int stack_size,
 			   int run_ctx_off, bool save_ret)
@@ -1938,7 +1994,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	/* arg1: mov rdi, progs[i] */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
 	/* arg2: lea rsi, [rbp - ctx_cookie_off] */
-	EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
+	if (!is_imm8(-run_ctx_off))
+		EMIT3_off32(0x48, 0x8D, 0xB5, -run_ctx_off);
+	else
+		EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
 
 	if (emit_rsb_call(&prog, bpf_trampoline_enter(p), prog))
 		return -EINVAL;
@@ -1954,7 +2013,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	emit_nops(&prog, 2);
 
 	/* arg1: lea rdi, [rbp - stack_size] */
-	EMIT4(0x48, 0x8D, 0x7D, -stack_size);
+	if (!is_imm8(-stack_size))
+		EMIT3_off32(0x48, 0x8D, 0xBD, -stack_size);
+	else
+		EMIT4(0x48, 0x8D, 0x7D, -stack_size);
 	/* arg2: progs[i]->insnsi for interpreter */
 	if (!p->jited)
 		emit_mov_imm64(&prog, BPF_REG_2,
@@ -1984,7 +2046,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	/* arg2: mov rsi, rbx <- start time in nsec */
 	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
 	/* arg3: lea rdx, [rbp - run_ctx_off] */
-	EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
+	if (!is_imm8(-run_ctx_off))
+		EMIT3_off32(0x48, 0x8D, 0x95, -run_ctx_off);
+	else
+		EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
 	if (emit_rsb_call(&prog, bpf_trampoline_exit(p), prog))
 		return -EINVAL;
 
@@ -2136,7 +2201,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 				void *func_addr)
 {
 	int i, ret, nr_regs = m->nr_args, stack_size = 0;
-	int regs_off, nregs_off, ip_off, run_ctx_off;
+	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -2150,8 +2215,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
 			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
 
-	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
-	if (nr_regs > 6)
+	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
+	 * are passed through regs, the remains are through stack.
+	 */
+	if (nr_regs > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
 
 	/* Generated trampoline stack layout:
@@ -2170,7 +2237,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	 *
 	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
 	 *
+	 * RBP - rbx_off   [ rbx value       ]  always
+	 *
 	 * RBP - run_ctx_off [ bpf_tramp_run_ctx ]
+	 *
+	 *                     [ stack_argN ]  BPF_TRAMP_F_CALL_ORIG
+	 *                     [ ...        ]
+	 *                     [ stack_arg2 ]
+	 * RBP - arg_stack_off [ stack_arg1 ]
 	 */
 
 	/* room for return value of orig_call or fentry prog */
@@ -2190,9 +2264,25 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 
 	ip_off = stack_size;
 
+	stack_size += 8;
+	rbx_off = stack_size;
+
 	stack_size += (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
 	run_ctx_off = stack_size;
 
+	if (nr_regs > 6 && (flags & BPF_TRAMP_F_CALL_ORIG)) {
+		stack_size += (nr_regs - 6) * 8;
+		/* make sure the stack pointer is 16-byte aligned if we
+		 * need pass arguments on stack, which means
+		 *  [stack_size + 8(rbp) + 8(rip) + 8(origin rip)]
+		 * should be 16-byte aligned. Following code depend on
+		 * that stack_size is already 8-byte aligned.
+		 */
+		stack_size += (stack_size % 16) ? 0 : 8;
+	}
+
+	arg_stack_off = stack_size;
+
 	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
@@ -2212,8 +2302,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	x86_call_depth_emit_accounting(&prog, NULL);
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
-	EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */
-	EMIT1(0x53);		 /* push rbx */
+	if (!is_imm8(stack_size))
+		/* sub rsp, stack_size */
+		EMIT3_off32(0x48, 0x81, 0xEC, stack_size);
+	else
+		/* sub rsp, stack_size */
+		EMIT4(0x48, 0x83, 0xEC, stack_size);
+	/* mov QWORD PTR [rbp - rbx_off], rbx */
+	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
 	/* Store number of argument registers of the traced function:
 	 *   mov rax, nr_regs
@@ -2262,6 +2358,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		restore_regs(m, &prog, nr_regs, regs_off);
+		prepare_origin_stack(m, &prog, nr_regs, arg_stack_off);
 
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
 			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
@@ -2321,7 +2418,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	if (save_ret)
 		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
 
-	EMIT1(0x5B); /* pop rbx */
+	emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
 	EMIT1(0xC9); /* leave */
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
 		/* skip our return address and return to parent */
-- 
2.40.1


