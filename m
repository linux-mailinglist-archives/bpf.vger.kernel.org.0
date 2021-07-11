Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70CD3C3D0A
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 15:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhGKNj6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 09:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233186AbhGKNj4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 09:39:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65A55613BE;
        Sun, 11 Jul 2021 13:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626010629;
        bh=EA+8ZaxGT189GQkRT4MyyUpyFhpU0OscBHCXHquT7pY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hW8laBCQicDcEORU6dyr71h2iympcLwMkxaYXh2gF4hBiiqrxPjPFdeDGUktIQwrb
         7F6F6tE529ATwn0o+XEC0q2c9oQX4h/EJBbDgU1vdv86J17r/YLkgaJlcMOikhOEEP
         Z+QEH8M1Qjd05Ac18Yz8V1RXJU9CotL5EVZpJYc7yPYyjc1HAhra+dsxYE+xd7KClg
         nnmpHmj7QQAG4x6Ym4i+TdYaRDhcdJavl3jp+rLWn9KicE7qRv40xPO9q6/cCO1Lg6
         KmkDTBajyv0eEgNyjz5uZLrLS5nJxrdYJoygHC2JCqa75oRtpXqcJxp5b5nlu6Ka86
         sHrBu6aVNN5sg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v9 14/14] x86/kprobes: Fixup return address in generic trampoline handler
Date:   Sun, 11 Jul 2021 22:37:06 +0900
Message-Id: <162601062597.1318837.16157770826588124346.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162601048053.1318837.1550594515476777588.stgit@devnote2>
References: <162601048053.1318837.1550594515476777588.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In x86, the fake return address on the stack saved by
__kretprobe_trampoline() will be replaced with the real return
address after returning from trampoline_handler(). Before fixing
the return address, the real return address can be found in the
'current->kretprobe_instances'.

However, since there is a window between updating the
'current->kretprobe_instances' and fixing the address on the stack,
if an interrupt happens at that timing and the interrupt handler
does stacktrace, it may fail to unwind because it can not get
the correct return address from 'current->kretprobe_instances'.

This will eliminate that window by fixing the return address
right before updating 'current->kretprobe_instances'.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>
---
 Changes in v9:
  - Fixes the changelog. This can eliminate the window.
  - Add more comment how it works.
 Changes in v7:
  - Add a prototype for arch_kretprobe_fixup_return()
---
 arch/x86/kernel/kprobes/core.c |   18 ++++++++++++++++--
 include/linux/kprobes.h        |    3 +++
 kernel/kprobes.c               |   11 +++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 7e1111c19605..fce99e249d61 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1065,6 +1065,16 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline);
  */
 STACK_FRAME_NON_STANDARD_FP(__kretprobe_trampoline);
 
+/* This is called from kretprobe_trampoline_handler(). */
+void arch_kretprobe_fixup_return(struct pt_regs *regs,
+				 kprobe_opcode_t *correct_ret_addr)
+{
+	unsigned long *frame_pointer = &regs->sp + 1;
+
+	/* Replace fake return address with real one. */
+	*frame_pointer = (unsigned long)correct_ret_addr;
+}
+
 /*
  * Called from __kretprobe_trampoline
  */
@@ -1082,8 +1092,12 @@ __used __visible void trampoline_handler(struct pt_regs *regs)
 	regs->sp += sizeof(long);
 	frame_pointer = &regs->sp + 1;
 
-	/* Replace fake return address with real one. */
-	*frame_pointer = kretprobe_trampoline_handler(regs, frame_pointer);
+	/*
+	 * The return address at 'frame_pointer' is recovered by the
+	 * arch_kretprobe_fixup_return() which called from the
+	 * kretprobe_trampoline_handler().
+	 */
+	kretprobe_trampoline_handler(regs, frame_pointer);
 
 	/*
 	 * Copy FLAGS to 'pt_regs::sp' so that __kretprobe_trapmoline()
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 4715a67d39fc..bfd73263496e 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -188,6 +188,9 @@ extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				   struct pt_regs *regs);
 extern int arch_trampoline_kprobe(struct kprobe *p);
 
+void arch_kretprobe_fixup_return(struct pt_regs *regs,
+				 kprobe_opcode_t *correct_ret_addr);
+
 void __kretprobe_trampoline(void);
 /*
  * Since some architecture uses structured function pointer,
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e7c75725934b..ab861b4bd6dd 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1909,6 +1909,15 @@ unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
 }
 NOKPROBE_SYMBOL(kretprobe_find_ret_addr);
 
+void __weak arch_kretprobe_fixup_return(struct pt_regs *regs,
+					kprobe_opcode_t *correct_ret_addr)
+{
+	/*
+	 * Do nothing by default. Please fill this to update the fake return
+	 * address on the stack with the correct one on each arch if possible.
+	 */
+}
+
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 					     void *frame_pointer)
 {
@@ -1954,6 +1963,8 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 		first = first->next;
 	}
 
+	arch_kretprobe_fixup_return(regs, correct_ret_addr);
+
 	/* Unlink all nodes for this frame. */
 	first = current->kretprobe_instances.first;
 	current->kretprobe_instances.first = node->next;

