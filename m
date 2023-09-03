Return-Path: <bpf+bounces-9158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834A2790CBA
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 17:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805871C20823
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 15:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F3C3FE3;
	Sun,  3 Sep 2023 15:15:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD143D60
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 15:15:39 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D55910F9
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 08:15:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68c0d4cc3a4so359921b3a.1
        for <bpf@vger.kernel.org>; Sun, 03 Sep 2023 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693754104; x=1694358904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMSA0+Ahr7SMC7wKOypbl3UJZkEliH/UYw5GFr/znq0=;
        b=AJuK9GhrpKDd/8NABHQJX4sywKNfKWtnMQaCiQI5IoDuyiKP3THlN3j01L7UR80+BE
         GgabTlPrZHBKPQmiKYBrp1D7yB3b20eGi3xzxOZAf8fO548HFGpjbcMTyTDO/iju1YkN
         jouAkW48E8Ep94Md36PsXGQc5mxzRcvCxmYzaHl+krlGWXU/7+XC+ytvBHsAeTkAfBzN
         J0UdbZqID4prPzluuXuaItpHFOeYzDzkIjiFtYWLsZqY+20XPul19Z3mujfotLaJ9c8A
         u1tbh+PaaU9BMZzF4jS+npHcIKvFGMnu+DgG3NhGXmiRsLB5VvFkjEf6zrCQHTtXbwGi
         CXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754104; x=1694358904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMSA0+Ahr7SMC7wKOypbl3UJZkEliH/UYw5GFr/znq0=;
        b=PnvIUEOB/TqXPpzRvaTVBWIsjFFxx5Xy8+7VBfkSk3TSx1mQBoLBFZKEuUASmu6OyP
         OWLqEmpiJRncKNdKBeoahULQhYq3cD3fivuweFM0/1yvecQ+N7So9LljRAJTTCjbzlYv
         rm6YmJWni6XGkDmZiBRqZswRGPFM/G2+OhW29I0imy+6NqEukm6kGC0Na2bZS6AYJ6u7
         AXkcW3jPADoOorkP3NEKsERH+RhyB1MCTCok42aRR46w6tvGWFsj1LWbJzJQlwEfI9Ie
         DQSWj0UsSbfJUF7NdABejRg8IuExC01Clbdak8Aqjm+wceWWkXuaQhjEALYnEF0NVkB4
         /9+A==
X-Gm-Message-State: AOJu0YwBidg122FwTDUOT/CTao78X0l3z4zwHYChgk8hCyvka/aHK5V3
	J2v2E94zMHYd4WYXsF5Wez3rKljCsWU=
X-Google-Smtp-Source: AGHT+IEPMd1RYyGWFWXDJ15xO7sVdz6rCvVFY1ElTXpuE3QOosYUA5sTIA79GK9ottE0gBumsfgiZQ==
X-Received: by 2002:a05:6a00:1952:b0:68a:4261:ab7f with SMTP id s18-20020a056a00195200b0068a4261ab7fmr6786826pfk.31.1693754104126;
        Sun, 03 Sep 2023 08:15:04 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id x17-20020aa784d1000000b00686940bfb77sm5882268pfn.71.2023.09.03.08.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:15:03 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com
Cc: song@kernel.org,
	iii@linux.ibm.com,
	jakub@cloudflare.com,
	hffilwlqm@gmail.com,
	bpf@vger.kernel.org
Subject: [RFC PATCH bpf-next v4 2/4] bpf, x64: Fix tailcall infinite loop
Date: Sun,  3 Sep 2023 23:14:46 +0800
Message-ID: <20230903151448.61696-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230903151448.61696-1-hffilwlqm@gmail.com>
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
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
3. The tailcall calls the subprogram's caller.

As a result, a tailcall infinite loop comes up. And the loop would halt
the machine.

As we know, in tail call context, the tail_call_cnt propagates by stack
and rax register between BPF subprograms. So do in trampolines.

Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 28 ++++++++++++++++++++++------
 include/linux/bpf.h         |  5 +++++
 kernel/bpf/trampoline.c     |  4 ++--
 kernel/bpf/verifier.c       |  3 +++
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index bcca1c9b9a027..2846c21d75bfa 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1022,6 +1022,10 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
+/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
+#define RESTORE_TAIL_CALL_CNT(stack)				\
+	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
+
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -1627,9 +1631,7 @@ st:			if (is_imm8(insn->off))
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
-				EMIT3_off32(0x48, 0x8B, 0x85,
-					    -round_up(bpf_prog->aux->stack_depth, 8) - 8);
+				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
 				if (!imm32)
 					return -EINVAL;
 				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
@@ -2404,6 +2406,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
 	 * RBP - arg_stack_off [ stack_arg1 ]
+	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
 	 */
 
 	/* room for return value of orig_call or fentry prog */
@@ -2468,6 +2471,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	else
 		/* sub rsp, stack_size */
 		EMIT4(0x48, 0x83, 0xEC, stack_size);
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+		EMIT1(0x50);		/* push rax */
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
@@ -2520,9 +2525,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
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
@@ -2573,7 +2584,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
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
index 4ccca1f6c9981..765da3007106a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19629,6 +19629,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	if (!tr)
 		return -ENOMEM;
 
+	if (tgt_prog && tgt_prog->aux->tail_call_reachable)
+		tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX;
+
 	prog->aux->dst_trampoline = tr;
 	return 0;
 }
-- 
2.41.0


