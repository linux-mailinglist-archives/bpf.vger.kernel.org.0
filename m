Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274C23911EE
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 10:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhEZIGB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 04:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233238AbhEZIGA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 04:06:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B26BD613B4;
        Wed, 26 May 2021 08:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622016269;
        bh=zHgGf+J9R2KJWdm0E1kc2aXiEeqSmAci5E8/Yg36PtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KqdukoZpB3011YdRVNndQ6gJoV2vFJYfZ7gl92y1r060VFkXPolIMqX183z4HKkB7
         VXRxarHbIcViaEGcKmKTzhtrmFrOOTvaN3ZM3XB/QTYqOHMURQYTxUIK7xSALytgSD
         TDGDZXRhOeDcV6nNP2+HZBfoTunt7GsTDq6kHIx0sCCZ2QONbTpaJAWKpTqwDRvuj9
         2gmz6vI05eYzCMJBA0DxLe92a9IT3JpBipLUNu+S6feI00v7zeL4OrTmAPeEZI3n3V
         2tF7jO/UzhIo0tzpbU2gyFR67Nd5m/52ALb81X4CQRHk39hPZzDs6cxq7mWeg7jn6b
         uHfT+x7NapRSw==
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
Subject: [PATCH -tip v6 13/13] x86/kprobes: Fixup return address in generic trampoline handler
Date:   Wed, 26 May 2021 17:04:25 +0900
Message-Id: <162201626487.278331.9722092310737938059.stgit@devnote2>
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

In x86, kretprobe trampoline address on the stack frame will
be replaced with the real return address after returning from
trampoline_handler. Before fixing the return address, the real
return address can be found in the current->kretprobe_instances.

However, since there is a window between updating the
current->kretprobe_instances and fixing the address on the stack,
if an interrupt caused at that timing and the interrupt handler
does stacktrace, it may fail to unwind because it can not get
the correct return address from current->kretprobe_instances.

This will minimize that window by fixing the return address
right before updating current->kretprobe_instances.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |   15 +++++++++++++--
 kernel/kprobes.c               |    8 ++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4f3567a9974f..3dec85ca5d9e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1032,6 +1032,7 @@ STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
 #undef UNWIND_HINT_FUNC
 #define UNWIND_HINT_FUNC
 #endif
+
 /*
  * When a retprobed function returns, this code saves registers and
  * calls trampoline_handler() runs, which calls the kretprobe's handler.
@@ -1073,6 +1074,17 @@ asm(
 );
 NOKPROBE_SYMBOL(kretprobe_trampoline);
 
+void arch_kretprobe_fixup_return(struct pt_regs *regs,
+				 unsigned long correct_ret_addr)
+{
+	unsigned long *frame_pointer;
+
+	frame_pointer = ((unsigned long *)&regs->sp) + 1;
+
+	/* Replace fake return address with real one. */
+	*frame_pointer = correct_ret_addr;
+}
+
 /*
  * Called from kretprobe_trampoline
  */
@@ -1090,8 +1102,7 @@ __used __visible void trampoline_handler(struct pt_regs *regs)
 	regs->sp += sizeof(long);
 	frame_pointer = ((unsigned long *)&regs->sp) + 1;
 
-	/* Replace fake return address with real one. */
-	*frame_pointer = kretprobe_trampoline_handler(regs, frame_pointer);
+	kretprobe_trampoline_handler(regs, frame_pointer);
 	/*
 	 * Move flags to sp so that kretprobe_trapmoline can return
 	 * right after popf.
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 1598aca375c9..d5869664bb61 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1899,6 +1899,12 @@ unsigned long kretprobe_find_ret_addr(struct task_struct *tsk, void *fp,
 }
 NOKPROBE_SYMBOL(kretprobe_find_ret_addr);
 
+void __weak arch_kretprobe_fixup_return(struct pt_regs *regs,
+					unsigned long correct_ret_addr)
+{
+	/* Do nothing by default. */
+}
+
 unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 					     void *frame_pointer)
 {
@@ -1940,6 +1946,8 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 		first = first->next;
 	}
 
+	arch_kretprobe_fixup_return(regs, (unsigned long)correct_ret_addr);
+
 	/* Unlink all nodes for this frame. */
 	first = current->kretprobe_instances.first;
 	current->kretprobe_instances.first = node->next;

