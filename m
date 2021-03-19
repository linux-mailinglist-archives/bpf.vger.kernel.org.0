Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C385A341CCE
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 13:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhCSMXy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 08:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230268AbhCSMX3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 08:23:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DAEE64F6E;
        Fri, 19 Mar 2021 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616156609;
        bh=nqRMt7HfWF4IDIt0k4NM1ml7U8SIpubXRyNN+jZYq1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3CpqxgHAR2iVT5IyvMv5xg7u+IVgga3nWpzvtzarH5j4dM1ZYLcQQ2YC9AJ5IUI5
         0F43sf1CWoE373EQyCe+7nUiExUPxXN3N11nhQqy7018N9SEvLRrlLvYqZOxmzS1yZ
         DY5i0MLw8Y6cXztIIGd0jYwqnQNBkmcpNweZTj88LoxxeOc47BI0MmlRFD1bTTj6PF
         0nl+p21SY5urIsYetpMpvA57uC7neZpTLtKI+hbojrCNj4IUrKgll4C2vY68YzEK9d
         i/BjQbPJW3yU1Yf+BpFlUu1BjWPYT6Jvz3xaw0A8JyJT1lCnS5SB017IRGMb3tMNmK
         Zx6jndGdRncJA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: [PATCH -tip v3 09/11] x86/kprobes: Push a fake return address at kretprobe_trampoline
Date:   Fri, 19 Mar 2021 21:23:23 +0900
Message-Id: <161615660310.306069.8018914961713221579.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161615650355.306069.17260992641363840330.stgit@devnote2>
References: <161615650355.306069.17260992641363840330.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This changes x86/kretprobe stack frame on kretprobe_trampoline
a bit, which now push the kretprobe_trampoline as a fake return
address at the bottom of the stack frame. With this fix, the ORC
unwinder will see the kretprobe_trampoline as a return address.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/kprobes/core.c |   31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index b31058a152b6..7e7b854e0fdf 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -769,28 +769,31 @@ asm(
 	".global kretprobe_trampoline\n"
 	".type kretprobe_trampoline, @function\n"
 	"kretprobe_trampoline:\n"
-	/* We don't bother saving the ss register */
 #ifdef CONFIG_X86_64
-	"	pushq %rsp\n"
+	/* Push fake return address to tell the unwinder it's a kretprobe */
+	"	pushq $kretprobe_trampoline\n"
 	UNWIND_HINT_FUNC
+	/* Save the sp-8, this will be fixed later */
+	"	pushq %rsp\n"
 	"	pushfq\n"
 	SAVE_REGS_STRING
 	"	movq %rsp, %rdi\n"
 	"	call trampoline_handler\n"
-	/* Replace saved sp with true return address. */
-	"	movq %rax, 19*8(%rsp)\n"
 	RESTORE_REGS_STRING
+	"	addq $8, %rsp\n"
 	"	popfq\n"
 #else
-	"	pushl %esp\n"
+	/* Push fake return address to tell the unwinder it's a kretprobe */
+	"	pushl $kretprobe_trampoline\n"
 	UNWIND_HINT_FUNC
+	/* Save the sp-4, this will be fixed later */
+	"	pushl %esp\n"
 	"	pushfl\n"
 	SAVE_REGS_STRING
 	"	movl %esp, %eax\n"
 	"	call trampoline_handler\n"
-	/* Replace saved sp with true return address. */
-	"	movl %eax, 15*4(%esp)\n"
 	RESTORE_REGS_STRING
+	"	addl $4, %esp\n"
 	"	popfl\n"
 #endif
 	"	ret\n"
@@ -802,8 +805,10 @@ NOKPROBE_SYMBOL(kretprobe_trampoline);
 /*
  * Called from kretprobe_trampoline
  */
-__used __visible void *trampoline_handler(struct pt_regs *regs)
+__used __visible void trampoline_handler(struct pt_regs *regs)
 {
+	unsigned long *frame_pointer;
+
 	/* fixup registers */
 	regs->cs = __KERNEL_CS;
 #ifdef CONFIG_X86_32
@@ -811,8 +816,16 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
 #endif
 	regs->ip = (unsigned long)&kretprobe_trampoline;
 	regs->orig_ax = ~0UL;
+	regs->sp += sizeof(long);
+	frame_pointer = ((unsigned long *)&regs->sp) + 1;
 
-	return (void *)kretprobe_trampoline_handler(regs, &regs->sp);
+	/* Replace fake return address with real one. */
+	*frame_pointer = kretprobe_trampoline_handler(regs, frame_pointer);
+	/*
+	 * Move flags to sp so that kretprobe_trapmoline can return
+	 * right after popf.
+	 */
+	regs->sp = regs->flags;
 }
 NOKPROBE_SYMBOL(trampoline_handler);
 

