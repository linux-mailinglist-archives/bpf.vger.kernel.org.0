Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E07C3911E5
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 10:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhEZIF3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 04:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232614AbhEZIF3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 04:05:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9617613D3;
        Wed, 26 May 2021 08:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622016238;
        bh=YoSuzmD4HYDIR1nxiMTmGqdnaU88RgVp1FEKUAPIIT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYlicS6/iDFBAvmAn9Gu2xJRK7jrGs/rm+lWraQ9PdELYQVhTKlZBjdSFfqnbp01T
         i1LrrGfaiQ/syIXYrfZixfBFDUfqpsVr9QTsjAhQsjNQnBDnpUvxCq0PgPBGU4JfhC
         dGkn8yv+9ZGXsvSao/4UwzyhvZiAMNi/JnmIyiUQjXT4QtYMXO10DfJU656KC0Q8Lu
         y9jo6luKCRV+R3BgYS4xqn+Wtn1qeaDdKwMl8P7KTR067n4JU8DbO6IB1Ng+DZB5Kr
         tDBaKBczqsb8k/o5KaWffh6hZe1HSA9BeCzbIoG9WJ+tCGf9NmVxml8WIzvtqfaU65
         N7va3YPUqeYYQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v6 10/13] x86/kprobes: Push a fake return address at kretprobe_trampoline
Date:   Wed, 26 May 2021 17:03:52 +0900
Message-Id: <162201623241.278331.4061034283741994264.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162201612941.278331.5293566981784464165.stgit@devnote2>
References: <162201612941.278331.5293566981784464165.stgit@devnote2>
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
index 9a6763fd066e..4f3567a9974f 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1041,28 +1041,31 @@ asm(
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
@@ -1073,8 +1076,10 @@ NOKPROBE_SYMBOL(kretprobe_trampoline);
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
@@ -1082,8 +1087,16 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
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
 

