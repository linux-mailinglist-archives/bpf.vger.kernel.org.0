Return-Path: <bpf+bounces-8072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34C780EBE
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE11228242E
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E2B18C2A;
	Fri, 18 Aug 2023 15:12:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E06E18B09
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 15:12:49 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C6D4226
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:12:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6889078ee66so861918b3a.0
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692371556; x=1692976356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLAZBLjQ6o2XyZzEVO1U4fGSznZpBS3jvDEYzkrz+6o=;
        b=Rptg9ZjomkHR5Vqii1s7x98VItIF0dW0MNX2lP+uyTQriQeJAr1u6HP9OUWbCLiHOd
         jRvnVgTkqpTN4sbOH8DYmK7Ze4w+ALck4QgXJhlHVu/YJuaRL9DPG3j/Wvrs+HAFF9Ac
         2KKZk/ZczLw2Zv7pFxEpTTUQnaDWi4or/Xpn7ZcTV6WI1LA5ucO9dYXzxs7apM86WxyJ
         73Jscj1vPq7+7b3UMMspVhHsEcc8FZ2j2QMlLJ9p5sA9BE0IGajI+MdHWDvCK78f3xeb
         NBoaUxrpp+IKMKpsJZLu09XOIiW0htvSzjITg3JWgCeQw09wpfDGogltAcWgyjB/B/xi
         U/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371556; x=1692976356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLAZBLjQ6o2XyZzEVO1U4fGSznZpBS3jvDEYzkrz+6o=;
        b=eZvlomD4HFFIjrWdirD2w5MsMNzlXzK/Lgb56sqy7LVzIM8Zm18FW1nfxsBsY2GaBt
         FQvJIyq8y1y1MgOMsCDmgfEl9i6/qXHNEg7u4lbJukxw3RjpinFkiKlWHhW1OA4HzB/v
         exIAD2ex5ABR/xDFDcEYjNQ5KwTwpTeDokgb1xFwnFGH0blQ69Gos0pyfEIMVh/OSjpq
         k3fiZw+aXrXN/KARze7GrkJWB3ORj+2zqaXfcxHoE+dkT0XDTRem1si7YL5OlJWZWwlm
         qcOlYI9hhRX5W7WJpFpaAxTzW589hm3vcYMfHMY3YwGcYy48zw4EOI9MXZjzt1wv2ot4
         dzAA==
X-Gm-Message-State: AOJu0YyNXf1qs6I9pd1PAA5ZKkL+NmQdHZYUnV7PoI8Trvg1n3OOMgsz
	f/Qa0N4yVDGqv8lGAXj0v87K81gLRWLF1w==
X-Google-Smtp-Source: AGHT+IGgBiOw3DAPKmmW49Il/U+w7HZkQSybD2Vdv09sBuPBpEnx/v46E5/0ygv8UyHh1OTVY4LUpA==
X-Received: by 2002:a05:6a00:b86:b0:666:a25b:3788 with SMTP id g6-20020a056a000b8600b00666a25b3788mr3887606pfj.34.1692371556249;
        Fri, 18 Aug 2023 08:12:36 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id j19-20020a62b613000000b00686dd062207sm1650967pff.150.2023.08.18.08.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:12:35 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com
Cc: song@kernel.org,
	hffilwlqm@gmail.com,
	bpf@vger.kernel.org
Subject: [RFC PATCH bpf-next v2 1/2] bpf, x64: Fix tailcall infinite loop
Date: Fri, 18 Aug 2023 23:12:15 +0800
Message-ID: <20230818151216.7686-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818151216.7686-1-hffilwlqm@gmail.com>
References: <20230818151216.7686-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
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
and RAX register between BPF subprograms. So do it in trampolines.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 40 +++++++++++++++++++++++++++++--------
 include/linux/bpf.h         |  5 +++++
 kernel/bpf/trampoline.c     |  4 ++--
 kernel/bpf/verifier.c       | 31 +++++++++++++++++++++-------
 4 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a5930042139d3..1ad17d7de5eee 100644
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
+			// Keep the same instruction layout.
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
@@ -2298,7 +2304,9 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
  * push rbp
  * mov rbp, rsp
  * sub rsp, 16                     // space for skb and dev
- * push rbx                        // temp regs to pass start time
+ * mov qword ptr [rbp - 40], rbx   // temp regs to pass start time
+ * mov rax, 2                      // cache number of argument to rax
+ * mov qword ptr [rbp - 32], rax   // save number of argument to stack
  * mov qword ptr [rbp - 16], rdi   // save skb pointer to stack
  * mov qword ptr [rbp - 8], rsi    // save dev pointer to stack
  * call __bpf_prog_enter           // rcu_read_lock and preempt_disable
@@ -2323,7 +2331,9 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
  * push rbp
  * mov rbp, rsp
  * sub rsp, 24                     // space for skb, dev, return value
- * push rbx                        // temp regs to pass start time
+ * mov qword ptr [rbp - 40], rbx   // temp regs to pass start time
+ * mov rax, 2                      // cache number of argument to rax
+ * mov qword ptr [rbp - 32], rax   // save number of argument to stack
  * mov qword ptr [rbp - 24], rdi   // save skb pointer to stack
  * mov qword ptr [rbp - 16], rsi   // save dev pointer to stack
  * call __bpf_prog_enter           // rcu_read_lock and preempt_disable
@@ -2400,6 +2410,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
 	 * RBP - arg_stack_off [ stack_arg1 ]
+	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
 	 */
 
 	/* room for return value of orig_call or fentry prog */
@@ -2464,6 +2475,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	else
 		/* sub rsp, stack_size */
 		EMIT4(0x48, 0x83, 0xEC, stack_size);
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+		EMIT1(0x50);		/* push rax */
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
@@ -2516,9 +2529,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
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
+			EMIT2(0xff, 0xd3); /* call *rbx */ // FIXME: Confirm 0xd3?
 		} else {
 			/* call original function */
 			if (emit_rsb_call(&prog, orig_call, prog)) {
@@ -2569,7 +2588,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
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
index 4ccca1f6c9981..52ba9b043f16e 100644
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
@@ -19629,6 +19640,12 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	if (!tr)
 		return -ENOMEM;
 
+	if (tgt_prog && tgt_prog->aux->tail_call_reachable) {
+		subprog = find_subprog_index(tgt_prog, btf_id);
+		tr->flags = subprog > 0 && tgt_prog->aux->func[subprog]->is_func ?
+			    BPF_TRAMP_F_TAIL_CALL_CTX : 0;
+	}
+
 	prog->aux->dst_trampoline = tr;
 	return 0;
 }
-- 
2.41.0


