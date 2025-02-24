Return-Path: <bpf+bounces-52355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C062A4227F
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CB2188F1F7
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DF714B976;
	Mon, 24 Feb 2025 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAfZnQxR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB08078F4E;
	Mon, 24 Feb 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405851; cv=none; b=cW5KxqWMlINgV3Dt88oapKna06bzCvOzkM6QYx5fKouIpIdebpprEk9LNn3rz0SdIrgniHWHQysZ0gjwS6oVyJl766XXlG+uJjZOf58tR3lLUy2RDwSCmwf5PgbcjhRaTsw5c53yS6QS5Lyx9eDV91GLMrOo+eCnKTRHgsX9zAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405851; c=relaxed/simple;
	bh=Y97et2dSlq5/aqfWGwD60r+q1qqkgnIZEFjGi+Q8F7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPkIzqTzwtyKuDfVZiFFQ92IQljLSD/WwSUoCPd4vtABQ6jzbBxy2/iostX2li8GFA8wAj3/9AQaDjCmkpLE22CQGWZ10y+kxO1gFTZaVk6D8DWZkYUiVbe722fHnrTiyYPxE850jarGYx5Xqt5tBunIkU4yYa9S7RtbiAaO3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAfZnQxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24591C4CED6;
	Mon, 24 Feb 2025 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405851;
	bh=Y97et2dSlq5/aqfWGwD60r+q1qqkgnIZEFjGi+Q8F7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rAfZnQxR+p0lCpEy9qTMXo2GjPU77xCT5zKY8iucx9OXrleM7/qNt6ddMugUdDMZS
	 Pa7pGqm5KKKBJYjnrm9DeSZJrGm37gejjXEJWwMenNztz7aJAWR092ZWh5vHnhvdqS
	 ZAOi9gjxiOYFTu/ypRuTtyPVFuDu1r40JARPcGy3oOZL3bjblIDV/B6RwPfWet3+xz
	 /jr9F0oVh1TpqAuTmExJjiH2gZ7MDHKUqTbKBDm1j0BiAt9bqCkq0/4Ss0Wl6NqgBt
	 LD9sGL4rD+5DKGwAohl3sMwE+Tl4n9jxpUtU9dL9eDjpaRZM8SrcXYRtka9kK3xubJ
	 wR3/p6ESs/haw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFCv2 12/18] uprobes/x86: Add support to optimize uprobes
Date: Mon, 24 Feb 2025 15:01:44 +0100
Message-ID: <20250224140151.667679-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224140151.667679-1-jolsa@kernel.org>
References: <20250224140151.667679-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We do not unmap and release uprobe trampoline when it's no longer needed,
because there's no easy way to make sure none of the threads is still
inside the trampoline. But we do not waste memory, because there's just
single page for all the uprobe trampoline mappings.

We do waste frmae on page mapping for every 4GB by keeping the uprobe
trampoline page mapped, but that seems ok.

Attaching the speed up from benchs/run_bench_uprobes.sh script:

current:
        usermode-count :  818.836 ± 2.842M/s
        syscall-count  :    8.917 ± 0.003M/s
        uprobe-nop     :    3.056 ± 0.013M/s
        uprobe-push    :    2.903 ± 0.002M/s
        uprobe-ret     :    1.533 ± 0.001M/s
-->     uprobe-nop5    :    1.492 ± 0.000M/s
        uretprobe-nop  :    1.783 ± 0.000M/s
        uretprobe-push :    1.672 ± 0.001M/s
        uretprobe-ret  :    1.067 ± 0.002M/s
-->     uretprobe-nop5 :    1.052 ± 0.000M/s

after the change:

        usermode-count :  818.386 ± 1.886M/s
        syscall-count  :    8.923 ± 0.003M/s
        uprobe-nop     :    3.086 ± 0.005M/s
        uprobe-push    :    2.751 ± 0.001M/s
        uprobe-ret     :    1.481 ± 0.000M/s
-->     uprobe-nop5    :    4.016 ± 0.002M/s
        uretprobe-nop  :    1.712 ± 0.008M/s
        uretprobe-push :    1.616 ± 0.001M/s
        uretprobe-ret  :    1.052 ± 0.000M/s
-->     uretprobe-nop5 :    2.015 ± 0.000M/s

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/uprobes.h |   6 ++
 arch/x86/kernel/uprobes.c      | 191 ++++++++++++++++++++++++++++++++-
 include/linux/uprobes.h        |   6 +-
 kernel/events/uprobes.c        |  16 ++-
 4 files changed, 209 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index 678fb546f0a7..7d4df920bb59 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -20,6 +20,10 @@ typedef u8 uprobe_opcode_t;
 #define UPROBE_SWBP_INSN		0xcc
 #define UPROBE_SWBP_INSN_SIZE		   1
 
+enum {
+	ARCH_UPROBE_FLAG_CAN_OPTIMIZE   = 0,
+};
+
 struct uprobe_xol_ops;
 
 struct arch_uprobe {
@@ -45,6 +49,8 @@ struct arch_uprobe {
 			u8	ilen;
 		}			push;
 	};
+
+	unsigned long flags;
 };
 
 struct arch_uprobe_task {
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index e8aebbda83bc..73ddff823904 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -18,6 +18,7 @@
 #include <asm/processor.h>
 #include <asm/insn.h>
 #include <asm/mmu_context.h>
+#include <asm/nops.h>
 
 /* Post-execution fixups. */
 
@@ -768,7 +769,7 @@ static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
 	return NULL;
 }
 
-static __maybe_unused struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr)
+static struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr)
 {
 	struct uprobes_state *state = &current->mm->uprobes_state;
 	struct uprobe_trampoline *tramp = NULL;
@@ -794,7 +795,7 @@ static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
 	kfree(tramp);
 }
 
-static __maybe_unused void uprobe_trampoline_put(struct uprobe_trampoline *tramp)
+static void uprobe_trampoline_put(struct uprobe_trampoline *tramp)
 {
 	if (tramp == NULL)
 		return;
@@ -807,6 +808,7 @@ struct mm_uprobe {
 	struct rb_node rb_node;
 	unsigned long auprobe;
 	unsigned long vaddr;
+	bool optimized;
 };
 
 #define __node_2_mm_uprobe(node) rb_entry((node), struct mm_uprobe, rb_node)
@@ -874,6 +876,7 @@ static struct mm_uprobe *insert_mm_uprobe(struct mm_struct *mm, struct arch_upro
 	if (mmu) {
 		mmu->auprobe = (unsigned long) auprobe;
 		mmu->vaddr = vaddr;
+		mmu->optimized = false;
 		RB_CLEAR_NODE(&mmu->rb_node);
 		rb_add(&mmu->rb_node, &mm->uprobes_state.root_uprobes, __mm_uprobe_less);
 	}
@@ -886,6 +889,134 @@ static void destroy_mm_uprobe(struct mm_uprobe *mmu, struct rb_root *root)
 	kfree(mmu);
 }
 
+enum {
+	OPT_PART,
+	OPT_INSN,
+	UNOPT_INT3,
+	UNOPT_PART,
+};
+
+struct write_opcode_ctx {
+	unsigned long base;
+	int update;
+};
+
+static int is_call_insn(uprobe_opcode_t *insn)
+{
+	return *insn == CALL_INSN_OPCODE;
+}
+
+static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode,
+		       int nbytes, void *data)
+{
+	struct write_opcode_ctx *ctx = data;
+	uprobe_opcode_t old_opcode[5];
+
+	uprobe_copy_from_page(page, ctx->base, (uprobe_opcode_t *) &old_opcode, 5);
+
+	switch (ctx->update) {
+	case OPT_PART:
+	case OPT_INSN:
+		if (is_swbp_insn(&old_opcode[0]))
+			return 1;
+		break;
+	case UNOPT_INT3:
+		if (is_call_insn(&old_opcode[0]))
+			return 1;
+		break;
+	case UNOPT_PART:
+		if (is_swbp_insn(&old_opcode[0]))
+			return 1;
+		break;
+	}
+
+	return -1;
+}
+
+static int write_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
+		      uprobe_opcode_t *insn, int nbytes, void *ctx)
+{
+	return uprobe_write(auprobe, mm, vaddr, insn, nbytes, verify_insn, false, ctx);
+}
+
+static void relative_call(void *dest, long from, long to)
+{
+	struct __packed __arch_relative_insn {
+		u8 op;
+		s32 raddr;
+	} *insn;
+
+	insn = (struct __arch_relative_insn *)dest;
+	insn->raddr = (s32)(to - (from + 5));
+	insn->op = CALL_INSN_OPCODE;
+}
+
+static int swbp_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
+			 unsigned long tramp)
+{
+	struct write_opcode_ctx ctx = {
+		.base = vaddr,
+	};
+	char call[5];
+	int err;
+
+	relative_call(call, vaddr, tramp);
+
+	/*
+	 * We are in state where breakpoint (int3) is installed on top of first
+	 * byte of the nop5 instruction. We will do following steps to overwrite
+	 * this to call instruction:
+	 *
+	 * - sync cores
+	 * - write last 4 bytes of the call instruction
+	 * - sync cores
+	 * - update the call instruction opcode
+	 */
+	text_poke_sync();
+
+	ctx.update = OPT_PART;
+	err = write_insn(auprobe, mm, vaddr + 1, call + 1, 4, &ctx);
+	if (err)
+		return err;
+
+	text_poke_sync();
+
+	ctx.update = OPT_INSN;
+	return write_insn(auprobe, mm, vaddr, call, 1, &ctx);
+}
+
+static int swbp_unoptimize(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
+{
+	uprobe_opcode_t int3 = UPROBE_SWBP_INSN;
+	struct write_opcode_ctx ctx = {
+		.base = vaddr,
+	};
+	int err;
+
+	/*
+	 * We need to overwrite call instruction into nop5 instruction with
+	 * breakpoint (int3) installed on top of its first byte. We will:
+	 *
+	 * - overwrite call opcode with breakpoint (int3)
+	 * - sync cores
+	 * - write last 4 bytes of the nop5 instruction
+	 * - sync cores
+	 */
+
+	ctx.update = UNOPT_INT3;
+	err = write_insn(auprobe, mm, vaddr, &int3, 1, &ctx);
+	if (err)
+		return err;
+
+	text_poke_sync();
+
+	ctx.update = UNOPT_PART;
+	err = write_insn(auprobe, mm, vaddr + 1, (uprobe_opcode_t *) auprobe->insn + 1, 4, &ctx);
+
+	text_poke_sync();
+	return err;
+}
+
 int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
 {
 	struct mm_uprobe *mmu;
@@ -905,6 +1036,8 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned lo
 	mmu = find_mm_uprobe(mm, auprobe, vaddr);
 	if (!mmu)
 		return 0;
+	if (mmu->optimized)
+		WARN_ON_ONCE(swbp_unoptimize(auprobe, mm, vaddr));
 	destroy_mm_uprobe(mmu, &mm->uprobes_state.root_uprobes);
 	return uprobe_write_opcode(auprobe, mm, vaddr, *(uprobe_opcode_t *)&auprobe->insn, true);
 }
@@ -937,6 +1070,41 @@ static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
 {
 	return is_nop5_insn((uprobe_opcode_t *) &auprobe->insn);
 }
+
+void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	struct mm_struct *mm = current->mm;
+	struct uprobe_trampoline *tramp;
+	struct mm_uprobe *mmu;
+
+	if (!test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))
+		return;
+
+	mmap_write_lock(mm);
+	mmu = find_mm_uprobe(mm, auprobe, vaddr);
+	if (!mmu || mmu->optimized)
+		goto unlock;
+
+	tramp = uprobe_trampoline_get(vaddr);
+	if (!tramp)
+		goto unlock;
+
+	if (WARN_ON_ONCE(swbp_optimize(auprobe, mm, vaddr, tramp->vaddr)))
+		uprobe_trampoline_put(tramp);
+	else
+		mmu->optimized = true;
+
+unlock:
+	mmap_write_unlock(mm);
+}
+
+static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	if (!is_nop5_insn((uprobe_opcode_t *) &auprobe->insn))
+		return false;
+	/* We can't do cross page atomic writes yet. */
+	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= 5;
+}
 #else /* 32-bit: */
 /*
  * No RIP-relative addressing on 32-bit
@@ -954,6 +1122,10 @@ static bool emulate_nop5_insn(struct arch_uprobe *auprobe)
 {
 	return false;
 }
+static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	return false;
+}
 #endif /* CONFIG_X86_64 */
 
 struct uprobe_xol_ops {
@@ -1317,6 +1489,9 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret)
 		return ret;
 
+	if (can_optimize(auprobe, addr))
+		set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
+
 	ret = branch_setup_xol_ops(auprobe, &insn);
 	if (ret != -ENOSYS)
 		return ret;
@@ -1523,15 +1698,23 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs
 {
 	int rasize = sizeof_long(regs), nleft;
 	unsigned long orig_ret_vaddr = 0; /* clear high bits for 32-bit apps */
+	unsigned long off = 0;
+
+	/*
+	 * Optimized uprobe goes through uprobe trampoline which adds 4 8-byte
+	 * values on stack, check uprobe_trampoline_entry for details.
+	 */
+	if (!swbp)
+		off = 4*8;
 
-	if (copy_from_user(&orig_ret_vaddr, (void __user *)regs->sp, rasize))
+	if (copy_from_user(&orig_ret_vaddr, (void __user *)regs->sp + off, rasize))
 		return -1;
 
 	/* check whether address has been already hijacked */
 	if (orig_ret_vaddr == trampoline_vaddr)
 		return orig_ret_vaddr;
 
-	nleft = copy_to_user((void __user *)regs->sp, &trampoline_vaddr, rasize);
+	nleft = copy_to_user((void __user *)regs->sp + off, &trampoline_vaddr, rasize);
 	if (likely(!nleft)) {
 		if (shstk_update_last_frame(trampoline_vaddr)) {
 			force_sig(SIGSEGV);
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index bd726daa4428..22c79905754c 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -190,7 +190,8 @@ struct uprobes_state {
 #endif
 };
 
-typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr, uprobe_opcode_t *opcode, int nbytes);
+typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr, uprobe_opcode_t *opcode,
+				     int nbytes, void *data);
 
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
@@ -202,7 +203,7 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
 			       uprobe_opcode_t, bool);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr,
-			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool orig);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool orig, void *data);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
@@ -239,6 +240,7 @@ extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
 extern void arch_uprobe_clear_state(struct mm_struct *mm);
 extern void arch_uprobe_init_state(struct mm_struct *mm);
+extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c690cde4442c..ba4f18bac73e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -264,7 +264,8 @@ static void uprobe_copy_to_page(struct page *page, unsigned long vaddr, const vo
 	kunmap_atomic(kaddr);
 }
 
-static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode, int nbytes)
+static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode,
+			 int nbytes, void *data)
 {
 	uprobe_opcode_t old_opcode;
 	bool is_swbp;
@@ -473,12 +474,12 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
 int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 			unsigned long vaddr, uprobe_opcode_t opcode, bool orig)
 {
-	return uprobe_write(auprobe, mm, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode, orig);
+	return uprobe_write(auprobe, mm, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, verify_opcode, orig, NULL);
 }
 
 int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		 unsigned long vaddr, uprobe_opcode_t *insn,
-		 int nbytes, uprobe_write_verify_t verify, bool orig)
+		 int nbytes, uprobe_write_verify_t verify, bool orig, void *data)
 {
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
@@ -494,7 +495,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (IS_ERR(old_page))
 		return PTR_ERR(old_page);
 
-	ret = verify(old_page, vaddr, insn, nbytes);
+	ret = verify(old_page, vaddr, insn, nbytes, data);
 	if (ret <= 0)
 		goto put_old;
 
@@ -2668,6 +2669,10 @@ bool __weak arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check c
 	return true;
 }
 
+void __weak arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+}
+
 /*
  * Run handler and ask thread to singlestep.
  * Ensure all non-fatal signals cannot interrupt thread while it singlesteps.
@@ -2732,6 +2737,9 @@ static void handle_swbp(struct pt_regs *regs)
 
 	handler_chain(uprobe, regs, true);
 
+	/* Try to optimize after first hit. */
+	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
+
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 
-- 
2.48.1


