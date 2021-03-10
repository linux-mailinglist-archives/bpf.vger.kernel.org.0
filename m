Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFCF33422F
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 16:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhCJPzT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 10:55:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232931AbhCJPzP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 10:55:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 864F564EE2;
        Wed, 10 Mar 2021 15:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615391714;
        bh=QtRqnPG3+9xFfFGCN0rirFY06vcXQqoEqJvNIFEzYZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MLa8xaNLb04mYNN4mI8mR6xPmSGPMveBVxonlhBvQItN5k5dhm/nlc6mgJV9Pyg7c
         TZlEnhm4FPyyCeQK5t1NesypDMBYRgsCr7kyVehXMz23LX+tIalln7jKPcAPWfC3GC
         0NeVPAR5jp1M8LFNRs57C3vF7WtQ9NjhHpPnHqAFrWvGGv16QqKSd9h3wZAISbSjVW
         6ey1B//VxeutIyiOt98nwwwbTLqIgmFPlAulDo7VCJgfdFyCdqdUbF1nG73zfA1XPD
         6osPtUKxGdUQEJxiDIwrwfQCegluVWsc5jURQcNJurE55/HM2u9XQfv5Bc3ALY+k/3
         Iand9Onl4A5fg==
Date:   Thu, 11 Mar 2021 00:55:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
        mingo@redhat.com, ast@kernel.org, tglx@linutronix.de,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Message-Id: <20210311005509.0a1a65df0d2d6c7da73a9288@kernel.org>
In-Reply-To: <20210310150845.7kctaox34yrfyjxt@treble>
References: <161495873696.346821.10161501768906432924.stgit@devnote2>
        <20210305191645.njvrsni3ztvhhvqw@maharaja.localdomain>
        <20210306101357.6f947b063a982da9c949f1ba@kernel.org>
        <20210307212333.7jqmdnahoohpxabn@maharaja.localdomain>
        <20210308115210.732f2c42bf347c15fbb2a828@kernel.org>
        <20210309011945.ky7v3pnbdpxhmxkh@treble>
        <20210310185734.332d9d52a26780ba02d09197@kernel.org>
        <20210310150845.7kctaox34yrfyjxt@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Josh and Daniel,

On Wed, 10 Mar 2021 09:08:45 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, Mar 10, 2021 at 06:57:34PM +0900, Masami Hiramatsu wrote:
> > > If I understand correctly, for #1 you need an unwind hint which treats
> > > the instruction *after* the "pushq %rsp" as the beginning of the
> > > function.
> > 
> > Thanks for the patch. In that case, should I still change the stack allocation?
> > Or can I continue to use a series of "push/pop" ?
> 
> You can continue to use push/pop.  Objtool is only getting confused by
> the unbalanced stack of the function (more pushes than pops).  The
> unwind hint should fix that.

With you patch, I made a fix for ORC unwinder. I confirmed it works with
2 multiple kretprobes on the call path like this ;

cd /sys/kernel/debug/tracing/
echo r vfs_read >> kprobe_events
echo r full_proxy_read >> kprobe_events
echo traceoff:1 > events/kprobes/r_vfs_read_0/trigger
echo stacktrace:1 > events/kprobes/r_full_proxy_read_0/trigger
echo 1 > events/kprobes/enable
echo 1 > options/sym-offset
cat /sys/kernel/debug/kprobes/list
echo 0 > events/kprobes/enable
cat trace

# tracer: nop
#
# entries-in-buffer/entries-written: 3/3   #P:8
#
#                                _-----=> irqs-off
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| /     delay
#           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
#              | |         |   ||||      |         |
           <...>-136     [004] ...1   648.481281: r_full_proxy_read_0: (vfs_read+0xab/0x1a0 <- full_proxy_read)
           <...>-136     [004] ...1   648.481310: <stack trace>
 => kretprobe_trace_func+0x209/0x2f0
 => kretprobe_dispatcher+0x4a/0x70
 => __kretprobe_trampoline_handler+0xcd/0x170
 => trampoline_handler+0x3d/0x50
 => kretprobe_trampoline+0x25/0x50
 => vfs_read+0xab/0x1a0
 => ksys_read+0x5f/0xe0
 => do_syscall_64+0x33/0x40
 => entry_SYSCALL_64_after_hwframe+0x44/0xae
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0

I didn't tested it with bpftrace, but this also handles 
regs->ip == kretprobe_trampoline case. So it should work.

commit aa452d999b524b1851f69cc947be3e1a2f3ca1ec
Author: Masami Hiramatsu <mhiramat@kernel.org>
Date:   Sat Mar 6 08:34:51 2021 +0900

    x86/unwind/orc: Fixup kretprobe trampoline entry
    
    Since the kretprobe replaces the function return address with
    the kretprobe_trampoline on the stack, the ORC unwinder can not
    continue the stack unwinding at that point.
    
    To fix this issue, correct state->ip as like as function-graph
    tracer in the unwind_next_frame().
    
    Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

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
index 2a1d47f47eee..94869516cfc0 100644
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
@@ -414,6 +415,30 @@ static bool get_reg(struct unwind_state *state, unsigned int reg_off,
 	return false;
 }
 
+#ifdef CONFIG_KRETPROBES
+static unsigned long orc_kretprobe_correct_ip(struct unwind_state *state)
+{
+	return kretprobe_find_ret_addr(
+			(unsigned long)kretprobe_trampoline_addr(),
+			state->task, &state->kr_iter);
+}
+
+static bool is_kretprobe_trampoline_address(unsigned long ip)
+{
+	return ip == (unsigned long)kretprobe_trampoline_addr();
+}
+#else
+static unsigned long orc_kretprobe_correct_ip(struct unwind_state *state)
+{
+	return state->ip;
+}
+
+static bool is_kretprobe_trampoline_address(unsigned long ip)
+{
+	return false;
+}
+#endif
+
 bool unwind_next_frame(struct unwind_state *state)
 {
 	unsigned long ip_p, sp, tmp, orig_ip = state->ip, prev_sp = state->sp;
@@ -536,6 +561,18 @@ bool unwind_next_frame(struct unwind_state *state)
 
 		state->ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
 						  state->ip, (void *)ip_p);
+		/*
+		 * There are special cases when the stack unwinder is called
+		 * from the kretprobe handler or the interrupt handler which
+		 * occurs in the kretprobe trampoline code. In those cases,
+		 * %sp is shown on the stack instead of the return address.
+		 * Or, when the unwinder find the return address is replaced
+		 * by kretprobe_trampoline.
+		 * In those cases, correct address can be found in kretprobe.
+		 */
+		if (state->ip == sp ||
+		    is_kretprobe_trampoline_address(state->ip))
+			state->ip = orc_kretprobe_correct_ip(state);
 
 		state->sp = sp;
 		state->regs = NULL;
@@ -649,6 +686,12 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		state->full_regs = true;
 		state->signal = true;
 
+		/*
+		 * When the unwinder called with regs from kretprobe handler,
+		 * the regs->ip starts from kretprobe_trampoline address.
+		 */
+		if (is_kretprobe_trampoline_address(state->ip))
+			state->ip = orc_kretprobe_correct_ip(state);
 	} else if (task == current) {
 		asm volatile("lea (%%rip), %0\n\t"
 			     "mov %%rsp, %1\n\t"
-- 
Masami Hiramatsu <mhiramat@kernel.org>
