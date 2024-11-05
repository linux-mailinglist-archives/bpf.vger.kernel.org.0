Return-Path: <bpf+bounces-44040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17EC9BCE01
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15D3281F9C
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8851D89E3;
	Tue,  5 Nov 2024 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK1l9NBE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8661D5168;
	Tue,  5 Nov 2024 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813726; cv=none; b=JW60VqjNhQXDYr2yLXJWSxIbf6BrwiOxfGyd+rLq9C80RG8f3jsEducdvM2aedeU4nIZOJJO+khb38cuNCt2dOYG0HNOaHO8f9jMOrFRvRjNFowUaL88OAlxt9m/2vVfiAOk1c4FlSdp+mEzu+iYqDH2FMqxnIOTqprtCAO8FFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813726; c=relaxed/simple;
	bh=EtJfWq9duQ7ZZR4ixiYEYXsxTJTZs998UR8FdU9uC1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXGlTH5p2kD6VugzGnLAk1nXARlYjLqSbcJhNIElZu1cLLrOGHtU/xWR1TWCMRLOatsvOagacnm0zOsNdfttU9GqlX1fa1Vl9w4XhnJLqnqS8Nrzy99Tp5/lqsOJKGCXxST5rODiPksdK/wyCxhY2DTo8v6GaetEMjjkEWig2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK1l9NBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E46C4CECF;
	Tue,  5 Nov 2024 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730813726;
	bh=EtJfWq9duQ7ZZR4ixiYEYXsxTJTZs998UR8FdU9uC1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bK1l9NBEdWbq8Q7iISKA2JKj0dfN7xAVEpOlcuFU5NN7eAoc0nqoI8045HrCH8MBP
	 hQpn9j2gr4K78MXmjDWfqXe4C3YsU5SGUtSgNBLUSBQoyQzqUqF9Ad/tOT0O8xHcB0
	 uTrs4lLBCA0CBJGR5thUoht5kKwYkJdq6i3q/9746v8PSyL/i+KGqNqRaXssdZySra
	 7JaIyECrOmRbKD3JCmlLelfVZ/Ms4WgvV5R7AYQpPS/tWHaOprfiQKwIf6joZ4bc1m
	 6TIhAewHBJDZfAExn1N9SK6YP/m/rDkEs+A63Vg+q7zBV01GDdoOPp/6TLDBPR0iZl
	 XeBs8vgrBxiuQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC perf/core 07/11] uprobes/x86: Add support to optimize uprobes
Date: Tue,  5 Nov 2024 14:34:01 +0100
Message-ID: <20241105133405.2703607-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105133405.2703607-1-jolsa@kernel.org>
References: <20241105133405.2703607-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Putting together all the previously added pieces to support optimized
uprobes on top of 5-byte nop instruction.

The current uprobe execution goes through following:
  - installs breakpoint instruction over original instruction
  - exception handler hit and calls related uprobe consumers
  - and either simulates original instruction or does out of line single step
    execution of it
  - returns to user space

The optimized uprobe path

  - checks the original instruction is 5-byte nop (plus other checks)
  - adds (or uses existing) user space trampoline and overwrites original
    instruction (5-byte nop) with call to user space trampoline
  - the user space trampoline executes uprobe syscall that calls related uprobe
    consumers
  - trampoline returns back to next instruction

This approach won't speed up all uprobes as it's limited to using nop5 as
original instruction, but we could use nop5 as USDT probe instruction (which
uses single byte nop ATM) and speed up the USDT probes.

This patch overloads related arch functions in uprobe_write_opcode and
set_orig_insn so they can install call instruction if needed.

The arch_uprobe_optimize triggers the uprobe optimization and is called after
first uprobe hit. I originally had it called on uprobe installation but then
it clashed with elf loader, because the user space trampoline was added in a
place where loader might need to put elf segments, so I decided to do it after
first uprobe hit when loading is done.

TODO release uprobe trampoline when it's no longer needed.. we might need to
stop all cpus to make sure no user space thread is in the trampoline.. or we
might just keep it, because there's just one 4GB memory region?

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/uprobes.h |   7 ++
 arch/x86/kernel/uprobes.c      | 130 +++++++++++++++++++++++++++++++++
 include/linux/uprobes.h        |   1 +
 kernel/events/uprobes.c        |   3 +
 4 files changed, 141 insertions(+)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index 678fb546f0a7..84a75ed748f0 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -20,6 +20,11 @@ typedef u8 uprobe_opcode_t;
 #define UPROBE_SWBP_INSN		0xcc
 #define UPROBE_SWBP_INSN_SIZE		   1
 
+enum {
+	ARCH_UPROBE_FLAG_CAN_OPTIMIZE	= 0,
+	ARCH_UPROBE_FLAG_OPTIMIZED	= 1,
+};
+
 struct uprobe_xol_ops;
 
 struct arch_uprobe {
@@ -45,6 +50,8 @@ struct arch_uprobe {
 			u8	ilen;
 		}			push;
 	};
+
+	unsigned long flags;
 };
 
 struct arch_uprobe_task {
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 02aa4519b677..50ccf24ff42c 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -18,6 +18,7 @@
 #include <asm/processor.h>
 #include <asm/insn.h>
 #include <asm/mmu_context.h>
+#include <asm/nops.h>
 
 /* Post-execution fixups. */
 
@@ -877,6 +878,33 @@ static const struct uprobe_xol_ops push_xol_ops = {
 	.emulate  = push_emulate_op,
 };
 
+static int is_nop5_insns(uprobe_opcode_t *insn)
+{
+	return !memcmp(insn, x86_nops[5], 5);
+}
+
+static int is_call_insns(uprobe_opcode_t *insn)
+{
+	return *insn == 0xe8;
+}
+
+static void relative_insn(void *dest, void *from, void *to, u8 op)
+{
+	struct __arch_relative_insn {
+		u8 op;
+		s32 raddr;
+	} __packed *insn;
+
+	insn = (struct __arch_relative_insn *)dest;
+	insn->raddr = (s32)((long)(to) - ((long)(from) + 5));
+	insn->op = op;
+}
+
+static void relative_call(void *dest, void *from, void *to)
+{
+	relative_insn(dest, from, to, CALL_INSN_OPCODE);
+}
+
 /* Returns -ENOSYS if branch_xol_ops doesn't handle this insn */
 static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 {
@@ -896,6 +924,10 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 		break;
 
 	case 0x0f:
+		if (is_nop5_insns((uprobe_opcode_t *) &auprobe->insn)) {
+			set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
+			break;
+		}
 		if (insn->opcode.nbytes != 2)
 			return -ENOSYS;
 		/*
@@ -1267,3 +1299,101 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
 	else
 		return regs->sp <= ret->stack;
 }
+
+int arch_uprobe_verify_opcode(struct page *page, unsigned long vaddr,
+			      uprobe_opcode_t *new_opcode, void *opt)
+{
+	if (opt) {
+		uprobe_opcode_t old_opcode[5];
+		bool is_call;
+
+		uprobe_copy_from_page(page, vaddr, (uprobe_opcode_t *) &old_opcode, 5);
+		is_call = is_call_insns((uprobe_opcode_t *) &old_opcode);
+
+		if (is_call_insns(new_opcode)) {
+			if (is_call)		/* register: already installed? */
+				return 0;
+		} else {
+			if (!is_call)		/* unregister: was it changed by us? */
+				return 0;
+		}
+
+		return 1;
+	}
+
+	return uprobe_verify_opcode(page, vaddr, new_opcode);
+}
+
+bool arch_uprobe_is_register(uprobe_opcode_t *insn, int len, void *data)
+{
+	return data ? len == 5 && is_call_insns(insn) : is_swbp_insn(insn);
+}
+
+static void __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
+				   unsigned long vaddr)
+{
+	struct tramp_area *area = NULL;
+	char call[5];
+
+	/* We can't do cross page atomic writes yet. */
+	if (PAGE_SIZE - (vaddr & ~PAGE_MASK) < 5)
+		goto fail;
+
+	area = get_tramp_area(vaddr);
+	if (!area)
+		goto fail;
+
+	relative_call(call, (void *) vaddr, (void *) area->vaddr);
+	if (uprobe_write_opcode(auprobe, mm, vaddr, call, 5, (void *) 1))
+		goto fail;
+
+	set_bit(ARCH_UPROBE_FLAG_OPTIMIZED, &auprobe->flags);
+	return;
+
+fail:
+	/* Once we fail we never try again. */
+	put_tramp_area(area);
+	clear_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
+}
+
+static bool should_optimize(struct arch_uprobe *auprobe)
+{
+	if (!test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))
+		return false;
+	if (test_bit(ARCH_UPROBE_FLAG_OPTIMIZED, &auprobe->flags))
+		return false;
+	return true;
+}
+
+void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	struct mm_struct *mm = current->mm;
+
+	if (!should_optimize(auprobe))
+		return;
+
+	mmap_write_lock(mm);
+	if (should_optimize(auprobe))
+		__arch_uprobe_optimize(auprobe, mm, vaddr);
+	mmap_write_unlock(mm);
+}
+
+int set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
+{
+	uprobe_opcode_t *insn = (uprobe_opcode_t *) auprobe->insn;
+
+	if (test_bit(ARCH_UPROBE_FLAG_OPTIMIZED, &auprobe->flags))
+		return uprobe_write_opcode(auprobe, mm, vaddr, insn, 5, (void *) 1);
+
+	return uprobe_write_opcode(auprobe, mm, vaddr, insn, UPROBE_SWBP_INSN_SIZE, NULL);
+}
+
+bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr)
+{
+	unsigned long delta;
+
+	/* call instructions size */
+	vaddr += 5;
+	delta = vaddr < vtramp ? vtramp - vaddr : vaddr - vtramp;
+	return delta < 0xffffffff;
+}
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 4024e6ea52a4..42ab29f80220 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -233,6 +233,7 @@ void put_tramp_area(struct tramp_area *area);
 bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr);
 extern void *arch_uprobe_trampoline(unsigned long *psize);
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
+extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index b8399684231c..efe45fcd5d0a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2759,6 +2759,9 @@ static void handle_swbp(struct pt_regs *regs)
 
 	handler_chain(uprobe, regs);
 
+	/* Try to optimize after first hit. */
+	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
+
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 
-- 
2.47.0


