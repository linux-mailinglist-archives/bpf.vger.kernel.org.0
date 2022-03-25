Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497F74E74FD
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 15:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245131AbiCYOZV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 10:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245164AbiCYOZJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 10:25:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A222C10C;
        Fri, 25 Mar 2022 07:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 652CD61B44;
        Fri, 25 Mar 2022 14:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CBBC340EE;
        Fri, 25 Mar 2022 14:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648218212;
        bh=LVTdVot2Vfc0Z3LeVm3nBjyEznpKnnARS40oYYwl3Fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mIzwjbJ+pdZ2AGKFEzLdXf85JDdTsYZxTnrrcXkwyLCuKThr8QFnf91pjoBr5aeTA
         Sp/XA32DErGXd/6k9J1K+iuq5P+3U5+C5alTEB248lH9/unJhL+Ye1Ch+x2zzLPxiN
         GN8TUYsK2dWpRqIqzm0rEZRAcsGjgT24b1f1Q70ZYkR4irM2fydElyHBNM/SMMv747
         bSwsZ8DDrPZgdeq6Kch27sKuJ0T4bvA3oK4hG2zAUqDNV/GOBxqWhIKzL2yRMk8dKT
         Y2ewJVwENalBY5IVjX1fR1A7jGRAHTYij4TK3wTx9PaFHXblvWCwKgBl3Q4f6GUdIZ
         Ukw8wR22UOF7w==
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
Subject: [PATCH bpf-next v2 3/4] Subject: x86,rethook: Fix arch_rethook_trampoline() to generate a complete pt_regs
Date:   Fri, 25 Mar 2022 23:23:27 +0900
Message-Id: <164821820699.2373735.13989291258858782853.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164821817332.2373735.12048266953420821089.stgit@devnote2>
References: <164821817332.2373735.12048266953420821089.stgit@devnote2>
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
index 56275540eeea..b080c020d528 100644
--- a/arch/x86/kernel/rethook.c
+++ b/arch/x86/kernel/rethook.c
@@ -25,29 +25,31 @@ asm(
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
@@ -69,8 +71,8 @@ __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
 #endif
 	regs->ip = (unsigned long)&arch_rethook_trampoline;
 	regs->orig_ax = ~0UL;
-	regs->sp += sizeof(long);
-	frame_pointer = &regs->sp + 1;
+	regs->sp += 2*sizeof(long);
+	frame_pointer = (long *)(regs + 1);
 
 	/*
 	 * The return address at 'frame_pointer' is recovered by the
@@ -80,10 +82,10 @@ __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
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
 
@@ -101,7 +103,7 @@ STACK_FRAME_NON_STANDARD_FP(arch_rethook_trampoline);
 void arch_rethook_fixup_return(struct pt_regs *regs,
 			       unsigned long correct_ret_addr)
 {
-	unsigned long *frame_pointer = &regs->sp + 1;
+	unsigned long *frame_pointer = (void *)(regs + 1);
 
 	/* Replace fake return address with real one. */
 	*frame_pointer = correct_ret_addr;

