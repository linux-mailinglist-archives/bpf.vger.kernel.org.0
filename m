Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C3634F85A
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 07:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhCaFpY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 01:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233716AbhCaFpC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 01:45:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAC42619D7;
        Wed, 31 Mar 2021 05:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617169501;
        bh=sSF71qlnI974wAy+ZMYm8N/K3MKLmeAecrOWanR5chM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o17jHD7Wq2FySlhs4u73r/iKdAdAnMzfjGtvz7bjSB6d3vDeTbVREJLcHynV0aiIm
         ExogATKA1g2qN5qvBaIR2kVSle/QjHWdFLfMxaoj9JpC+mypKWUUyFQHIk2/9YRpn1
         6ZgyifbMrdGaa57DBXx9Z/BbIhnLIogLPGeY7+dw98jk1CFfqwViqZPsbyStc0S8ZP
         rcSLW46ehTGG9sv+zMYBQzmPfz8K+b+0gTbeXho28Vkh8zwqA5p8uIfO2zsNNt2QJU
         c0Eu8XtefNUCULDDpHKxkAy7k8uOhrXYJtpODxir48ZY153DXCSsteVDWokRPqsC19
         Cv6t6O/sW5pPA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH -tip 3/3] x86/kprobes,orc: Unwind optprobe trampoline correctly
Date:   Wed, 31 Mar 2021 14:44:56 +0900
Message-Id: <161716949640.721514.14252504351086671126.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161716946413.721514.4057380464113663840.stgit@devnote2>
References: <161716946413.721514.4057380464113663840.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ORC Unwinder can not unwind if an optprobe trampoline is on the
stack because optprobe trampoline code has no ORC information.

This uses the ORC information on the template code of the
trampoline to adjust the sp register by ORC information and
extract the correct probed address from the optprobe trampoline
address.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/kprobes.h |    6 ++++
 arch/x86/kernel/kprobes/opt.c  |   54 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/unwind_orc.c   |   15 +++++++++--
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 71ea2eab43d5..9bbc45fcb3f1 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -119,9 +119,15 @@ extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);
 extern int kprobe_int3_handler(struct pt_regs *regs);
 
+unsigned long recover_optprobe_trampoline(unsigned long addr, unsigned long *sp);
 #else
 
 static inline int kprobe_debug_handler(struct pt_regs *regs) { return 0; }
+static inline unsigned long recover_optprobe_trampoline(unsigned long addr,
+							unsigned long *sp)
+{
+	return addr;
+}
 
 #endif /* CONFIG_KPROBES */
 #endif /* _ASM_X86_KPROBES_H */
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 6d26e5cf2ba2..f91922ba4844 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -30,6 +30,9 @@
 #include <asm/set_memory.h>
 #include <asm/sections.h>
 #include <asm/nospec-branch.h>
+#include <asm/orc_types.h>
+
+struct orc_entry *orc_find(unsigned long ip);
 
 #include "common.h"
 
@@ -100,6 +103,21 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 	*(unsigned long *)addr = val;
 }
 
+/* Extract mov operand */
+static unsigned long extract_set_arg1(kprobe_opcode_t *addr)
+{
+#ifdef CONFIG_X86_64
+	if (addr[0] != 0x48 || addr[1] != 0xbf)
+		return 0;
+	addr += 2;
+#else
+	if (*addr != 0xb8)
+		return 0;
+	addr++;
+#endif
+	return *(unsigned long *)addr;
+}
+
 static void
 optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs);
 
@@ -483,6 +501,42 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
 	goto out;
 }
 
+#ifdef CONFIG_UNWINDER_ORC
+unsigned long recover_optprobe_trampoline(unsigned long addr, unsigned long *sp)
+{
+	unsigned long offset, entry, probe_addr;
+	struct optimized_kprobe *op;
+	struct orc_entry *orc;
+
+	entry = find_kprobe_optinsn_slot_entry(addr);
+	if (!entry)
+		return addr;
+
+	offset = addr - entry;
+
+	/* Decode arg1 and get the optprobe */
+	op = (void *)extract_set_arg1((void *)(entry + TMPL_MOVE_IDX));
+	if (!op)
+		return addr;
+
+	probe_addr = (unsigned long)op->kp.addr;
+
+	if (offset < TMPL_END_IDX) {
+		orc = orc_find((unsigned long)optprobe_template_func + offset);
+		if (!orc || orc->sp_reg != ORC_REG_SP)
+			return addr;
+		/*
+		 * Since optprobe trampoline doesn't push caller on the stack,
+		 * need to decrement 1 stack entry size
+		 */
+		*sp += orc->sp_offset - sizeof(long);
+		return probe_addr;
+	} else {
+		return probe_addr + offset - TMPL_END_IDX;
+	}
+}
+#endif
+
 /*
  * Replace breakpoints (INT3) with relative jumps (JMP.d32).
  * Caller must call with locking kprobe_mutex and text_mutex.
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index c70dfeea4552..9f685f9c2358 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -79,7 +79,7 @@ static struct orc_entry *orc_module_find(unsigned long ip)
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-static struct orc_entry *orc_find(unsigned long ip);
+struct orc_entry *orc_find(unsigned long ip);
 
 /*
  * Ftrace dynamic trampolines do not have orc entries of their own.
@@ -142,7 +142,7 @@ static struct orc_entry orc_fp_entry = {
 	.end		= 0,
 };
 
-static struct orc_entry *orc_find(unsigned long ip)
+struct orc_entry *orc_find(unsigned long ip)
 {
 	static struct orc_entry *orc;
 
@@ -537,6 +537,7 @@ bool unwind_next_frame(struct unwind_state *state)
 
 		state->ip = unwind_recover_ret_addr(state, state->ip,
 						    (unsigned long *)ip_p);
+		state->ip = recover_optprobe_trampoline(state->ip, &sp);
 		state->sp = sp;
 		state->regs = NULL;
 		state->prev_regs = NULL;
@@ -558,6 +559,14 @@ bool unwind_next_frame(struct unwind_state *state)
 		 */
 		state->ip = unwind_recover_kretprobe(state, state->ip,
 				(unsigned long *)(state->sp - sizeof(long)));
+
+		/*
+		 * The optprobe trampoline has a unique stackframe. It has
+		 * no caller (probed) address on the stack, Thus it has to
+		 * decode the trampoline code and change the stack pointer
+		 * for the next frame, but not change the pt_regs.
+		 */
+		state->ip = recover_optprobe_trampoline(state->ip, &state->sp);
 		state->regs = (struct pt_regs *)sp;
 		state->prev_regs = NULL;
 		state->full_regs = true;
@@ -573,7 +582,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		/* See UNWIND_HINT_TYPE_REGS case comment. */
 		state->ip = unwind_recover_kretprobe(state, state->ip,
 				(unsigned long *)(state->sp - sizeof(long)));
-
+		state->ip = recover_optprobe_trampoline(state->ip, &state->sp);
 		if (state->full_regs)
 			state->prev_regs = state->regs;
 		state->regs = (void *)sp - IRET_FRAME_OFFSET;

