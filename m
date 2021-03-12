Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82FE338625
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 07:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhCLGoD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Mar 2021 01:44:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231455AbhCLGn3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Mar 2021 01:43:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC47464EB6;
        Fri, 12 Mar 2021 06:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615531408;
        bh=mpvxBHYBzRcmD/WHhPgUBtQsJ0SZN+lEfVNGaJSdsC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opD0oKMoenMnstmi+aFhU1o4daS4YOaELLEXNbtYLDQg8S9yRH4Mgd0d4k96XszVO
         aqyB8j0Dd8jUGJnaJ6QKcAVBYdiEfaxwzs79+F7SYIHhGTqrpAK55YZRF5/fti9FEw
         7aDT83k7/ScNEbLxuRXWRXtBvXWfHUkgGBHCw91P8brHCGi4Hs6omP2dPyc6enrfH7
         rrmnT+v0pHn9Ig44TAD2dTFfEoM8oA+c886g1VxFz8VmccUodmtct8Msf1vXNO7oPs
         ezUkSLA9A+xLMWqX1gTUnI82I/t2foaE3+bEdtcv8tVS4UodonkQ7tnn2cU8HETWg8
         CW9q+v5bzPYxQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH -tip v2 09/10] x86/unwind/orc: Fixup kretprobe trampoline entry
Date:   Fri, 12 Mar 2021 15:43:23 +0900
Message-Id: <161553140351.1038734.4282308401106671492.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161553130371.1038734.7661319550287837734.stgit@devnote2>
References: <161553130371.1038734.7661319550287837734.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since the kretprobe replaces the function return address with
the kretprobe_trampoline on the stack, the ORC unwinder can not
continue the stack unwinding at that point.

To fix this issue, correct state->ip as like as function-graph
tracer in the unwind_next_frame().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v2:
   - Remove kretprobe wrapper functions from unwind_orc.c
   - Do not fixup state->ip when unwinding with regs because
     kretprobe fixup instruction pointer before calling handler.
---
 arch/x86/include/asm/unwind.h |    4 ++++
 arch/x86/kernel/unwind_orc.c  |   16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 70fc159ebe69..ab5e45b848d5 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -4,6 +4,7 @@
 
 #include <linux/sched.h>
 #include <linux/ftrace.h>
+#include <linux/llist.h>
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
 
@@ -20,6 +21,9 @@ struct unwind_state {
 	bool signal, full_regs;
 	unsigned long sp, bp, ip;
 	struct pt_regs *regs, *prev_regs;
+#if defined(CONFIG_KRETPROBES)
+	struct llist_node *kr_iter;
+#endif
 #elif defined(CONFIG_UNWINDER_FRAME_POINTER)
 	bool got_irq;
 	unsigned long *bp, *orig_sp, ip;
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 2a1d47f47eee..1d1b9388a1b1 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -2,6 +2,7 @@
 #include <linux/objtool.h>
 #include <linux/module.h>
 #include <linux/sort.h>
+#include <linux/kprobes.h>
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
@@ -536,6 +537,21 @@ bool unwind_next_frame(struct unwind_state *state)
 
 		state->ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
 						  state->ip, (void *)ip_p);
+		/*
+		 * When the stack unwinder is called from the kretprobe handler
+		 * or the interrupt handler which occurs in the kretprobe
+		 * trampoline code, %sp is shown on the stack instead of the
+		 * return address because kretprobe_trampoline() does
+		 * "push %sp" at first.
+		 * And also the unwinder may find the kretprobe_trampoline
+		 * instead of the real return address on stack.
+		 * In those cases, find the correct return address from
+		 * task->kretprobe_instances list.
+		 */
+		if (state->ip == sp ||
+		    is_kretprobe_trampoline(state->ip))
+			state->ip = kretprobe_find_ret_addr(state->task,
+							    &state->kr_iter);
 
 		state->sp = sp;
 		state->regs = NULL;

