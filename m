Return-Path: <bpf+bounces-9762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F1379D449
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789181C20D52
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910CE18C00;
	Tue, 12 Sep 2023 15:05:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62842A952
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 15:05:01 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FC9CC7
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 08:05:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c35ee3b0d2so39114625ad.2
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694531100; x=1695135900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHTlaHgRQYq4iGS9O2Rgutovx/HNtZyntKoPfx9PGkE=;
        b=SAbtg2nerKiXFS/uTS0Bp/qP5Wsj3QkYWfelH6g9XtDzRpq467eo6t986FQavNBEdt
         7ZUh7cB5NewIckREloaSpwF4xeJlwRjCWE8j2SqPDhMf7OeKif0a0Qq75+mCM/YI0sIs
         /lGlbGz27o15tvTKO0d1GDNJQOMswrX+v/teXQSN0U9SIP3n1szP6J65Jv9LiNXAXRel
         hGmj50fKpkNbIkWOIwq26dvdL6fPPdwGvxOG0x3JXIK0zetae/rkcR4QzXDeEsk5kxKB
         Jjqn/EpR50BSP5srCJbLhdC6j+ArludCBhv4FwWODVlqqztzyG1VT2STHr0f4mVT8ce8
         B7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694531100; x=1695135900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHTlaHgRQYq4iGS9O2Rgutovx/HNtZyntKoPfx9PGkE=;
        b=MeU6GUGJ3uQT0VpdBpZlFWGNkxSvADfTVYv2ufi19CvjeII//pQzHsbCXG1ZO8tV+2
         ZJ1UXxUz7x1VMaJO08sMMT6Lm5iUSW1jjHVXJbmFSCQK3kUAnTAEn8TbTIwEh6SVp8Uy
         h01qBU0YHLpgBpUjKHJ/ZvCwqM7fZpRGB+EOEaz53bw9YsDCKWfCEG66YBmUP1nBb7Fh
         +qCf1VdGqh3lIOZamXcMGkPOUgMxLV98068vBrvn5h6b0CAu6JuniH1VPhyU/QX+CX0s
         x2MJBcIf0Akkw+Lvid6rW+9sZJFob73qFxu1AaX2MFA+MOvuDsJOUz7ryDr2eyiga4rm
         PGJw==
X-Gm-Message-State: AOJu0YyGYKnSISglqEJX9zWo+LuRGvLq2J5xXHVYP8Fwo6eP7Zn2Spcn
	mVZdbvpwLiLXj3HR17tYt+10bjjgs5E=
X-Google-Smtp-Source: AGHT+IEPXIaqCQHDUTSt4sg+6yblgU0DSfQfSYN59I6hx1FyuTZZch3vHhXCFkVlwmAEl4QGARZmjg==
X-Received: by 2002:a17:903:120b:b0:1bd:bba1:be78 with SMTP id l11-20020a170903120b00b001bdbba1be78mr32808plh.23.1694531099423;
        Tue, 12 Sep 2023 08:04:59 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b001b8b26fa6c1sm8526941pli.115.2023.09.12.08.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:04:59 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	song@kernel.org,
	iii@linux.ibm.com,
	xukuohai@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 2/3] bpf, x64: Fix tailcall infinite loop
Date: Tue, 12 Sep 2023 23:04:41 +0800
Message-ID: <20230912150442.2009-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912150442.2009-1-hffilwlqm@gmail.com>
References: <20230912150442.2009-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
index 87eeb3a46a1d5..b9e5731594324 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1035,6 +1035,11 @@ struct btf_func_model {
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
index 53ff50cac61ea..e97aeda3a86b5 100644
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
index dbba2b8060176..18e673c0ac159 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19774,6 +19774,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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


