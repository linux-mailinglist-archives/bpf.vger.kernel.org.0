Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB694E7E91
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 03:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiCZC3O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 22:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiCZC3M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 22:29:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B1817587A;
        Fri, 25 Mar 2022 19:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EC0FB829F2;
        Sat, 26 Mar 2022 02:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7EEC004DD;
        Sat, 26 Mar 2022 02:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648261655;
        bh=1GFhgKeS6KUc1WQ7GIRpaFxQts0n1D1CDBHsDOitUy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNd+veJjTdiHnNwa6bJOiNvrp4vFrplbLFG7jtdP0RBJVQOK15sQvyKYs1dYFlQdK
         SNIMhOwxxCJlyZGqwsWcBS3m5/1A9+GXb7upC/EdxtCGHLgOhZ5pBGqupXyisY+Mvv
         MGGmJBYm3YReJYO+5TygGlUuWJdxuWJc3J1wuinG3HxYs4WsRAFMn70dHLj8fBY8UQ
         hDATUaLtm6F9Yutg16e2FwtwiffuWQRVIg4ZhoCjyJ2KvAIYMB59m/hZjmeRcFEElR
         n2uordJrOmJ2VB7LnbUcmaBXWP7NWaTG/LuOS72j8Pw7kCYwUR//dPWGS6/LaKwom9
         WlPC51xHGeZiQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/4] x86,rethook: Fix arch_rethook_trampoline() to generate a complete pt_regs
Date:   Sat, 26 Mar 2022 11:27:28 +0900
Message-Id: <164826164851.2455864.17272661073069737350.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164826160914.2455864.505359679001055158.stgit@devnote2>
References: <164826160914.2455864.505359679001055158.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Currently arch_rethook_trampoline() generates an almost complete
pt_regs on-stack, everything except regs->ss that is, that currently
points to the fake return address, which is not a valid segment
descriptor.

Since interpretation of regs->[sb]p should be done in the context of
regs->ss, and we have code actually doing that (see
arch/x86/lib/insn-eval.c for instance), complete the job by also
pushing ss.

This ensures that anybody who does do look at regs->ss doesn't
mysteriously malfunction, avoiding much future pain.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/rethook.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
index af7e6713a07a..8a1c0111ae79 100644
--- a/arch/x86/kernel/rethook.c
+++ b/arch/x86/kernel/rethook.c
@@ -29,29 +29,31 @@ asm(
 	/* Push a fake return address to tell the unwinder it's a rethook. */
 	"	pushq $arch_rethook_trampoline\n"
 	UNWIND_HINT_FUNC
-	/* Save the 'sp - 8', this will be fixed later. */
+	"       pushq $" __stringify(__KERNEL_DS) "\n"
+	/* Save the 'sp - 16', this will be fixed later. */
 	"	pushq %rsp\n"
 	"	pushfq\n"
 	SAVE_REGS_STRING
 	"	movq %rsp, %rdi\n"
 	"	call arch_rethook_trampoline_callback\n"
 	RESTORE_REGS_STRING
-	/* In the callback function, 'regs->flags' is copied to 'regs->sp'. */
-	"	addq $8, %rsp\n"
+	/* In the callback function, 'regs->flags' is copied to 'regs->ss'. */
+	"	addq $16, %rsp\n"
 	"	popfq\n"
 #else
 	/* Push a fake return address to tell the unwinder it's a rethook. */
 	"	pushl $arch_rethook_trampoline\n"
 	UNWIND_HINT_FUNC
-	/* Save the 'sp - 4', this will be fixed later. */
+	"	pushl %ss\n"
+	/* Save the 'sp - 8', this will be fixed later. */
 	"	pushl %esp\n"
 	"	pushfl\n"
 	SAVE_REGS_STRING
 	"	movl %esp, %eax\n"
 	"	call arch_rethook_trampoline_callback\n"
 	RESTORE_REGS_STRING
-	/* In the callback function, 'regs->flags' is copied to 'regs->sp'. */
-	"	addl $4, %esp\n"
+	/* In the callback function, 'regs->flags' is copied to 'regs->ss'. */
+	"	addl $8, %esp\n"
 	"	popfl\n"
 #endif
 	ASM_RET
@@ -73,8 +75,8 @@ __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
 #endif
 	regs->ip = (unsigned long)&arch_rethook_trampoline;
 	regs->orig_ax = ~0UL;
-	regs->sp += sizeof(long);
-	frame_pointer = &regs->sp + 1;
+	regs->sp += 2*sizeof(long);
+	frame_pointer = (long *)(regs + 1);
 
 	/*
 	 * The return address at 'frame_pointer' is recovered by the
@@ -84,10 +86,10 @@ __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
 	rethook_trampoline_handler(regs, (unsigned long)frame_pointer);
 
 	/*
-	 * Copy FLAGS to 'pt_regs::sp' so that arch_rethook_trapmoline()
+	 * Copy FLAGS to 'pt_regs::ss' so that arch_rethook_trapmoline()
 	 * can do RET right after POPF.
 	 */
-	regs->sp = regs->flags;
+	*(unsigned long *)&regs->ss = regs->flags;
 }
 NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
 
@@ -105,7 +107,7 @@ STACK_FRAME_NON_STANDARD_FP(arch_rethook_trampoline);
 void arch_rethook_fixup_return(struct pt_regs *regs,
 			       unsigned long correct_ret_addr)
 {
-	unsigned long *frame_pointer = &regs->sp + 1;
+	unsigned long *frame_pointer = (void *)(regs + 1);
 
 	/* Replace fake return address with real one. */
 	*frame_pointer = correct_ret_addr;

