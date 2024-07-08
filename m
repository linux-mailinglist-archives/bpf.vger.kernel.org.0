Return-Path: <bpf+bounces-34167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3AC92AC6F
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 01:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7171C212B5
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 23:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64B01527A9;
	Mon,  8 Jul 2024 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTmweUVh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F578152537;
	Mon,  8 Jul 2024 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480300; cv=none; b=FqzKYx1BIa+YTObH5iVekjD+q93PVeGhlvEt6SNhbN1r86NLfzs6kNSXUUfRy4T3Iqjb7cg3B3ve8uazUdrT/FIy9Goqw6cnhKvs203yZsm8VtObg/lYcDWm+AKgms808E6r4fvZeBnbBhRdwy4VzPX2TB948PwL/TqOM4rEIt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480300; c=relaxed/simple;
	bh=DdmKJ8cyJRaKktRQcB/n8k2HkaWTT1vMXmfpVgv1gKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GyxPQKt5VSbVsLiWMAxQ9oWzd/a5yl5TLqDClqn7GH0SVhKJ1N50C6GR5h1MdtuHtoeudv3gVs/uwn/c6rNQi1N0pKd6w23y9ZscNxrw67qNGrsrJ/WtT4viukvApviS/MxYfqHfIvP39/8z3eqPDA3EiJX7e9OlUsGO1DvRvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTmweUVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92C2C116B1;
	Mon,  8 Jul 2024 23:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720480299;
	bh=DdmKJ8cyJRaKktRQcB/n8k2HkaWTT1vMXmfpVgv1gKw=;
	h=From:To:Cc:Subject:Date:From;
	b=CTmweUVh5ytN2mIgtHxq1K3NK5QK8m3OT+DXOgiXQAwqKk87udm8bJdQHpSzbfdpU
	 e26t6vwHrxtc/35GDHFsl2yLfBAv+ujvACgX3YAk9G6hPvoKBiSux7WDSdhe50Z55H
	 v+4FNZx2FPo0eSraDF4Xwk5xkudpbKgzrPDX33u8K9BQtax5+3tnd/ZO41ISA7GmJZ
	 Pjx8FLBE8tJHrT0b8UEs98vbaY2EXc2xG1wBmBFSPB5fw5uRqawGv+oxvlorNSkoZb
	 MJ+6DLZkwsZOioqF9gEqjCJusibS3Ml9GPCP+R642KBuMLpaHZ0Hk3OInsOblSa4Eg
	 MLMdz5rtkQIQA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: x86@kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	jpoimboe@redhat.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	rihams@fb.com,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4] perf,x86: avoid missing caller address in stack traces captured in uprobe
Date: Mon,  8 Jul 2024 16:11:27 -0700
Message-ID: <20240708231127.1055083-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tracing user functions with uprobe functionality, it's common to
install the probe (e.g., a BPF program) at the first instruction of the
function. This is often going to be `push %rbp` instruction in function
preamble, which means that within that function frame pointer hasn't
been established yet. This leads to consistently missing an actual
caller of the traced function, because perf_callchain_user() only
records current IP (capturing traced function) and then following frame
pointer chain (which would be caller's frame, containing the address of
caller's caller).

So when we have target_1 -> target_2 -> target_3 call chain and we are
tracing an entry to target_3, captured stack trace will report
target_1 -> target_3 call chain, which is wrong and confusing.

This patch proposes a x86-64-specific heuristic to detect `push %rbp`
(`push %ebp` on 32-bit architecture) instruction being traced. Given
entire kernel implementation of user space stack trace capturing works
under assumption that user space code was compiled with frame pointer
register (%rbp/%ebp) preservation, it seems pretty reasonable to use
this instruction as a strong indicator that this is the entry to the
function. In that case, return address is still pointed to by %rsp/%esp,
so we fetch it and add to stack trace before proceeding to unwind the
rest using frame pointer-based logic.

We also check for `endbr64` (for 64-bit modes) as another common pattern
for function entry, as suggested by Josh Poimboeuf. Even if we get this
wrong sometimes for uprobes attached not at the function entry, it's OK
because stack trace will still be overall meaningful, just with one
extra bogus entry. If we don't detect this, we end up with guaranteed to
be missing caller function entry in the stack trace, which is worse
overall.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
v3->v4:
  - use get_user() instead of __get_user(), given untrusted input (Josh);
  - reduced #ifdef-ery (Josh);
v2->v3:
  - added endr64 detection and extracted heuristics into a function (Josh);
v1->v2:
  - use native unsigned long for ret_addr (Peter);
  - add same logic for compat logic in perf_callchain_user32 (Peter).

 arch/x86/events/core.c  | 62 +++++++++++++++++++++++++++++++++++++++++
 include/linux/uprobes.h |  2 ++
 kernel/events/uprobes.c |  2 ++
 3 files changed, 66 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5b0dd07b1ef1..c09603d769a2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -41,6 +41,7 @@
 #include <asm/desc.h>
 #include <asm/ldt.h>
 #include <asm/unwind.h>
+#include <asm/uprobes.h>
 
 #include "perf_event.h"
 
@@ -2813,6 +2814,46 @@ static unsigned long get_segment_base(unsigned int segment)
 	return get_desc_base(desc);
 }
 
+#ifdef CONFIG_UPROBES
+/*
+ * Heuristic-based check if uprobe is installed at the function entry.
+ *
+ * Under assumption of user code being compiled with frame pointers,
+ * `push %rbp/%ebp` is a good indicator that we indeed are.
+ *
+ * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
+ * If we get this wrong, captured stack trace might have one extra bogus
+ * entry, but the rest of stack trace will still be meaningful.
+ */
+static bool is_uprobe_at_func_entry(struct pt_regs *regs)
+{
+	struct arch_uprobe *auprobe;
+
+	if (!current->utask)
+		return false;
+
+	auprobe = current->utask->auprobe;
+	if (!auprobe)
+		return false;
+
+	/* push %rbp/%ebp */
+	if (auprobe->insn[0] == 0x55)
+		return true;
+
+	/* endbr64 (64-bit only) */
+	if (user_64bit_mode(regs) && *(u32 *)auprobe->insn == 0xfa1e0ff3)
+		return true;
+
+	return false;
+}
+
+#else
+static bool is_uprobe_at_func_entry(struct pt_regs *regs)
+{
+	return false;
+}
+#endif /* CONFIG_UPROBES */
+
 #ifdef CONFIG_IA32_EMULATION
 
 #include <linux/compat.h>
@@ -2824,6 +2865,7 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	unsigned long ss_base, cs_base;
 	struct stack_frame_ia32 frame;
 	const struct stack_frame_ia32 __user *fp;
+	u32 ret_addr;
 
 	if (user_64bit_mode(regs))
 		return 0;
@@ -2833,6 +2875,12 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 
 	fp = compat_ptr(ss_base + regs->bp);
 	pagefault_disable();
+
+	/* see perf_callchain_user() below for why we do this */
+	if (is_uprobe_at_func_entry(regs) &&
+	    !get_user(ret_addr, (const u32 __user *)regs->sp))
+		perf_callchain_store(entry, ret_addr);
+
 	while (entry->nr < entry->max_stack) {
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
@@ -2861,6 +2909,7 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 {
 	struct stack_frame frame;
 	const struct stack_frame __user *fp;
+	unsigned long ret_addr;
 
 	if (perf_guest_state()) {
 		/* TODO: We don't support guest os callchain now */
@@ -2884,6 +2933,19 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 		return;
 
 	pagefault_disable();
+
+	/*
+	 * If we are called from uprobe handler, and we are indeed at the very
+	 * entry to user function (which is normally a `push %rbp` instruction,
+	 * under assumption of application being compiled with frame pointers),
+	 * we should read return address from *regs->sp before proceeding
+	 * to follow frame pointers, otherwise we'll skip immediate caller
+	 * as %rbp is not yet setup.
+	 */
+	if (is_uprobe_at_func_entry(regs) &&
+	    !get_user(ret_addr, (const unsigned long __user *)regs->sp))
+		perf_callchain_store(entry, ret_addr);
+
 	while (entry->nr < entry->max_stack) {
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b503fafb7fb3..a270a5892ab4 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -76,6 +76,8 @@ struct uprobe_task {
 	struct uprobe			*active_uprobe;
 	unsigned long			xol_vaddr;
 
+	struct arch_uprobe              *auprobe;
+
 	struct return_instance		*return_instances;
 	unsigned int			depth;
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 99be2adedbc0..6e22e4d80f1e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2082,6 +2082,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	bool need_prep = false; /* prepare return uprobe, when needed */
 
 	down_read(&uprobe->register_rwsem);
+	current->utask->auprobe = &uprobe->arch;
 	for (uc = uprobe->consumers; uc; uc = uc->next) {
 		int rc = 0;
 
@@ -2096,6 +2097,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 
 		remove &= rc;
 	}
+	current->utask->auprobe = NULL;
 
 	if (need_prep && !remove)
 		prepare_uretprobe(uprobe, regs); /* put bp at return */
-- 
2.43.0


