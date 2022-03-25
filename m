Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42234E7261
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 12:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351760AbiCYLmU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 07:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345552AbiCYLmT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 07:42:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7D0C559C;
        Fri, 25 Mar 2022 04:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Fw+DBOwDSEC8gESfzuRrIW++n1v7Mx6XYIG14G7w/c=; b=tb1PqS+no+XrmjP72Uq03DEj0k
        u4jpt3oHrj7FIguSxsToaTybpGwFxXxt04e9svRfpzYWiDJ5j/UZ4UN+++gcpWvuLVyG+laUV7/hN
        ZB25AZzJpP2KUdnpV+xgH6bthMjp1PYiDv5PUwXZOTuTfrAQd44+VCoWaM37lKQo5J+B2Ox7YzOnk
        CqkYKzE58leAwSA2bh9EoQgsUXBJ7SAzPdLBuG6D3SlvFbNS9iVelorJAf3xjx7Oz8W2ANbm/2Lvw
        Kt/7lBfskERWcWpimL1wZwPsV6cUdr/ZzlfbIDoq2DNaaDnG952KbxZnVebf7fPhPxnwdPx6MK/DT
        iRr+8JfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXiIh-00EK3j-Ja; Fri, 25 Mar 2022 11:40:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13504987D26; Fri, 25 Mar 2022 12:40:13 +0100 (CET)
Date:   Fri, 25 Mar 2022 12:40:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/2] x86,rethook: Fix arch_rethook_trampoline() to
 generate a complete pt_regs
Message-ID: <20220325114012.GO8939@worktop.programming.kicks-ass.net>
References: <164818251899.2252200.7306353689206167903.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164818251899.2252200.7306353689206167903.stgit@devnote2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


You lost the regs->ss bit again..

Boot tested on tigerlake with IBT enabled -- passed the boot time
kretprobe selftests.

---

Subject: x86,rethook: Fix arch_rethook_trampoline() to generate a complete pt_regs
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Mar 25 10:25:56 CET 2022

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
---
 arch/x86/kernel/rethook.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/rethook.c
+++ b/arch/x86/kernel/rethook.c
@@ -25,29 +25,31 @@ asm(
 	/* Push a fake return address to tell the unwinder it's a kretprobe. */
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
 	/* Push a fake return address to tell the unwinder it's a kretprobe. */
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
@@ -69,8 +71,8 @@ __used __visible void arch_rethook_tramp
 #endif
 	regs->ip = (unsigned long)&arch_rethook_trampoline;
 	regs->orig_ax = ~0UL;
-	regs->sp += sizeof(long);
-	frame_pointer = &regs->sp + 1;
+	regs->sp += 2*sizeof(long);
+	frame_pointer = (long *)(regs + 1);
 
 	/*
 	 * The return address at 'frame_pointer' is recovered by the
@@ -80,10 +82,10 @@ __used __visible void arch_rethook_tramp
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
 
@@ -101,7 +103,7 @@ STACK_FRAME_NON_STANDARD_FP(arch_rethook
 void arch_rethook_fixup_return(struct pt_regs *regs,
 			       unsigned long correct_ret_addr)
 {
-	unsigned long *frame_pointer = &regs->sp + 1;
+	unsigned long *frame_pointer = (void *)(regs + 1);
 
 	/* Replace fake return address with real one. */
 	*frame_pointer = correct_ret_addr;
