Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EEF3439C4
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 07:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhCVGmN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 02:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230241AbhCVGlq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 02:41:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBA9561970;
        Mon, 22 Mar 2021 06:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616395306;
        bh=0+MBkE3MCP9qu3e+CtLb8WoQb39qbfkwrEHxIPqK/GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hbu62fHARhMhoHUr7w/DkD8gymVNHk+TZYFR4VLGeaxu5KmjToQJ8b4d96ScJf/c1
         q4vSuGaxqag4tHHftW1DzyxcqJLThSR0D0PZdwa6Dc+7mwkXXG/dRIp8+RH0KyOl1W
         d2HnZm0XHJkbWPilHbRiKIC50fv1nvKEahHAp0mIp6T7mg8bX/qKosegWI0p7kcJ+/
         A8PLCjZ9kjcna6ZyvHVi+vhF4OVT44FVjBMfbQCWDBNCq/t7bWuxVuxBK80FyTrSKF
         6cjUjbsTLiaJJWtPQb6zJhAjRICZRVBbnAjVXDSeWLBwZJ62PlEmXkETzN5XDH/p37
         0QATc2eLbYWNw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: [PATCH -tip v4 10/12] x86/kprobes: Push a fake return address at kretprobe_trampoline
Date:   Mon, 22 Mar 2021 15:41:40 +0900
Message-Id: <161639530062.895304.16962383429668412873.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161639518354.895304.15627519393073806809.stgit@devnote2>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
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
index 23255663c434..d7b90541eda1 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -782,28 +782,31 @@ asm(
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
@@ -814,8 +817,10 @@ NOKPROBE_SYMBOL(kretprobe_trampoline);
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
@@ -823,8 +828,16 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
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
 

