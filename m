Return-Path: <bpf+bounces-8620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FDA788BF9
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FDA1C20B2D
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7EC101CA;
	Fri, 25 Aug 2023 14:52:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3EDFBF1
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 14:52:33 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A982125
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 07:52:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a42d06d02so857432b3a.0
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692975152; x=1693579952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgE5ZEclVoQYDbnH6ppT8do8f9FeX9xDAE7AkXyu3Lw=;
        b=e9SWhIshRXKd/+Sri0StUA/pyR7JmL613RDxgyQvbNWnOlwHzROWimXxP3rhhroDLB
         /VYwsbbU74Lgc7VNouBQ0jx1nUE+KCbwnJtptO240AAa5YAtarJCrzX8sC1N9nV/BtKr
         0hkR+OEqxsr7kWyPz8MDjsyYgZD25iQ6TrvZaAuWjZLUDoIt89kn2UPWeMDI6W8DdROr
         dCXmRrBHE3eNF+x4WjuK4/yxL1O3IbZ0LE80biaTR1/pzMnURWvedO7Zb/hcVDA86fX3
         Li1Jfh1s6YOaPogkI/zO+WzBE4LWxdmnMmJK2Hw0/SypJY8O7Q34yPufUP4fsH66hQk6
         cgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692975152; x=1693579952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgE5ZEclVoQYDbnH6ppT8do8f9FeX9xDAE7AkXyu3Lw=;
        b=P/C9+I4ZMyFisP8KwJkUxBz9+fyMzfrKU+1yIBkuccYqPt6EUp1HcygiXRtyhPyCgW
         vIRS/pT7VN1T18tAMqedEUgs5ip6fOYSlDrOV50+jR98LGLwkUiV82nMNBUXiONuGbRJ
         ZkbsYDFPEv0KexfjZ9vbrhpfvVVdkhA2T1uKDvAkN7jYaxDTFhugGRV0BTc2wGbCmGKn
         ZEuhata0mddXUFIOt9cG7a4a3BBfbHHeC+tLQQ/W+1LQE0/AeKpYON/RjKnbyPupvIxt
         D/cS77yBG3lCbrA0SpYHbJsQU3mUfqIiC6UC/oCNdxnMYQsZzDrDGs8jC4POP6+elJwi
         7NVA==
X-Gm-Message-State: AOJu0YwmepD8wJ9AjbtMXplQNjC7f/W0Lhy+Vmb4VtwzwalOOB7KfjDd
	p0P7nO1eSP4q3pQZtB4wRGY=
X-Google-Smtp-Source: AGHT+IGa24M5tRfVY/OqKI+qa+Vc/NulmPkXbCLYzU97oJmcirB3Bphj0QHrNzNQiTtyMquWJ2n3uA==
X-Received: by 2002:a05:6a20:431d:b0:12d:a04c:7e8b with SMTP id h29-20020a056a20431d00b0012da04c7e8bmr18646215pzk.40.1692975151794;
        Fri, 25 Aug 2023 07:52:31 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id iy4-20020a170903130400b001b016313b1dsm1806638plb.86.2023.08.25.07.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:52:31 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com
Cc: song@kernel.org,
	hffilwlqm@gmail.com,
	bpf@vger.kernel.org
Subject: [RFC PATCH bpf-next v3 1/2] bpf, x64: Fix tailcall infinite loop
Date: Fri, 25 Aug 2023 22:52:15 +0800
Message-ID: <20230825145216.56660-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825145216.56660-1-hffilwlqm@gmail.com>
References: <20230825145216.56660-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
handling in JIT"), the tailcall on x64 works better than before.

From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
for x64 JIT"), tailcall is able to run in BPF subprograms on x64.

From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF program
to other BPF programs"), BPF program is able to trace other BPF programs.

How about combining them all together?

1. FENTRY/FEXIT on a BPF subprogram.
2. A tailcall runs in the BPF subprogram.
3. The tailcall calls itself.

As a result, a tailcall infinite loop comes up. And the loop would halt
the machine.

As we know, in tail call context, the tail_call_cnt propagates by stack
and rax register between BPF subprograms. So do it in trampolines.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 32 ++++++++++++++++++++++++++------
 include/linux/bpf.h         |  5 +++++
 kernel/bpf/trampoline.c     |  4 ++--
 kernel/bpf/verifier.c       | 30 +++++++++++++++++++++++-------
 4 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a5930042139d3..2846c21d75bfa 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -303,8 +303,12 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	prog += X86_PATCH_SIZE;
 	if (!ebpf_from_cbpf) {
 		if (tail_call_reachable && !is_subprog)
+			/* When it's the entry of the whole tailcall context,
+			 * zeroing rax means initialising tail_call_cnt.
+			 */
 			EMIT2(0x31, 0xC0); /* xor eax, eax */
 		else
+			/* Keep the same instruction layout. */
 			EMIT2(0x66, 0x90); /* nop2 */
 	}
 	EMIT1(0x55);             /* push rbp */
@@ -1018,6 +1022,10 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
+/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
+#define RESTORE_TAIL_CALL_CNT(stack)				\
+	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
+
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -1623,9 +1631,7 @@ st:			if (is_imm8(insn->off))
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
-				EMIT3_off32(0x48, 0x8B, 0x85,
-					    -round_up(bpf_prog->aux->stack_depth, 8) - 8);
+				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
 				if (!imm32)
 					return -EINVAL;
 				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
@@ -2400,6 +2406,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
 	 * RBP - arg_stack_off [ stack_arg1 ]
+	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
 	 */
 
 	/* room for return value of orig_call or fentry prog */
@@ -2464,6 +2471,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	else
 		/* sub rsp, stack_size */
 		EMIT4(0x48, 0x83, 0xEC, stack_size);
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+		EMIT1(0x50);		/* push rax */
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
@@ -2516,9 +2525,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		restore_regs(m, &prog, regs_off);
 		save_args(m, &prog, arg_stack_off, true);
 
+		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+			/* Before calling the original function, restore the
+			 * tail_call_cnt from stack to rax.
+			 */
+			RESTORE_TAIL_CALL_CNT(stack_size);
+
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
-			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
-			EMIT2(0xff, 0xd0); /* call *rax */
+			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
+			EMIT2(0xff, 0xd3); /* call *rbx */
 		} else {
 			/* call original function */
 			if (emit_rsb_call(&prog, orig_call, prog)) {
@@ -2569,7 +2584,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 			ret = -EINVAL;
 			goto cleanup;
 		}
-	}
+	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+		/* Before running the original function, restore the
+		 * tail_call_cnt from stack to rax.
+		 */
+		RESTORE_TAIL_CALL_CNT(stack_size);
+
 	/* restore return value of orig_call or fentry prog back into RAX */
 	if (save_ret)
 		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cfabbcf47bdb8..c8df257ea435d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1028,6 +1028,11 @@ struct btf_func_model {
  */
 #define BPF_TRAMP_F_SHARE_IPMODIFY	BIT(6)
 
+/* Indicate that current trampoline is in a tail call context. Then, it has to
+ * cache and restore tail_call_cnt to avoid infinite tail call loop.
+ */
+#define BPF_TRAMP_F_TAIL_CALL_CTX	BIT(7)
+
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
  * bytes on x86.
  */
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 78acf28d48732..16ab5da7161f2 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -415,8 +415,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		goto out;
 	}
 
-	/* clear all bits except SHARE_IPMODIFY */
-	tr->flags &= BPF_TRAMP_F_SHARE_IPMODIFY;
+	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
+	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX);
 
 	if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
 	    tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ccca1f6c9981..6f290bc6f5f19 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19246,6 +19246,21 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
 }
 
+static inline int find_subprog_index(const struct bpf_prog *prog,
+				     u32 btf_id)
+{
+	struct bpf_prog_aux *aux = prog->aux;
+	int i, subprog = -1;
+
+	for (i = 0; i < aux->func_info_cnt; i++)
+		if (aux->func_info[i].type_id == btf_id) {
+			subprog = i;
+			break;
+		}
+
+	return subprog;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -19254,9 +19269,9 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 {
 	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
 	const char prefix[] = "btf_trace_";
-	int ret = 0, subprog = -1, i;
 	const struct btf_type *t;
 	bool conservative = true;
+	int ret = 0, subprog;
 	const char *tname;
 	struct btf *btf;
 	long addr = 0;
@@ -19291,11 +19306,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			return -EINVAL;
 		}
 
-		for (i = 0; i < aux->func_info_cnt; i++)
-			if (aux->func_info[i].type_id == btf_id) {
-				subprog = i;
-				break;
-			}
+		subprog = find_subprog_index(tgt_prog, btf_id);
 		if (subprog == -1) {
 			bpf_log(log, "Subprog %s doesn't exist\n", tname);
 			return -EINVAL;
@@ -19559,7 +19570,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	struct bpf_attach_target_info tgt_info = {};
 	u32 btf_id = prog->aux->attach_btf_id;
 	struct bpf_trampoline *tr;
-	int ret;
+	int ret, subprog;
 	u64 key;
 
 	if (prog->type == BPF_PROG_TYPE_SYSCALL) {
@@ -19629,6 +19640,11 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	if (!tr)
 		return -ENOMEM;
 
+	if (tgt_prog && tgt_prog->aux->tail_call_reachable) {
+		subprog = find_subprog_index(tgt_prog, btf_id);
+		tr->flags = subprog > 0 ? BPF_TRAMP_F_TAIL_CALL_CTX : 0;
+	}
+
 	prog->aux->dst_trampoline = tr;
 	return 0;
 }
-- 
2.41.0


