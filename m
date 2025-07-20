Return-Path: <bpf+bounces-63842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0724CB0B57D
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 13:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4645C17428B
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86080202C2D;
	Sun, 20 Jul 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSrf2XUF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BCD1FBC8E;
	Sun, 20 Jul 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753010615; cv=none; b=rc8Yx4zsCAkmjjnAEBi8cTwQPOY4hQfuQb7FITquULDiOu/Vn1CQG1Yn5Y8fYSF0R+YKyzurNSxJJRVpPxQbyVDFi+yuseujYQXyrnUT7J3DmZn5jfQ3vxZFgbmChe3yt1emSwz612KLvvrAPsi0PAve8F4UuuhNv4DKbwKhJHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753010615; c=relaxed/simple;
	bh=EJUcDzMG1Alh7XsuVsqN9fQGoAxP2V8khYbcq/apU/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFcvkEHGdzLlOCjiteH+amyaKV2z67XmIkADpjEbdFegqQNRuq46TPnxWsAZHrVa8Bjm9rmI8x0+hRuylhKFp5tkQPpksQPFIOKck/EHnC86ux7Bq+vYsQh31VLHt5OYAL4bzPQKCA5+/22Amuv3RX+dG6SZELSvhCZcpqJ0HGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSrf2XUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83314C4CEE7;
	Sun, 20 Jul 2025 11:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753010614;
	bh=EJUcDzMG1Alh7XsuVsqN9fQGoAxP2V8khYbcq/apU/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSrf2XUFNBK3cnWRhHdqAMZAQnBMR/h6DnSsVVV/lMxZRJV8fzO3G/aV9dWUMDorP
	 Z2EQsBrhVz3QQOi874MG9cTLgbm5T8xDMHGEkSgEyv94QLhBXx7ip4oHdJhdfCcRO3
	 UPlBq1+MFGfdajt9VOuvfyNywzDy2b8lI2X1lrZd2BrPkAwPs6v9LeMrPt9ylc2STD
	 DdHeHg7Oo2JEe+u/Nwzm7OTe1HoqT2ubosMMNQTK6px/6uHVv5Nf0vmc8vZ6uE9pzG
	 CbGp8aAKGIOmwrIk96R2z8etn+vEVBqkBCO8k2RhDBYw+kky9lLipCk2OnkdXT04cF
	 nkYpfh3SPwz3Q==
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
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize uprobes
Date: Sun, 20 Jul 2025 13:21:20 +0200
Message-ID: <20250720112133.244369-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250720112133.244369-1-jolsa@kernel.org>
References: <20250720112133.244369-1-jolsa@kernel.org>
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

The optimized uprobe path does following:

  - checks the original instruction is 5-byte nop (plus other checks)
  - adds (or uses existing) user space trampoline with uprobe syscall
  - overwrites original instruction (5-byte nop) with call to user space
    trampoline
  - the user space trampoline executes uprobe syscall that calls related uprobe
    consumers
  - trampoline returns back to next instruction

This approach won't speed up all uprobes as it's limited to using nop5 as
original instruction, but we plan to use nop5 as USDT probe instruction
(which currently uses single byte nop) and speed up the USDT probes.

The arch_uprobe_optimize triggers the uprobe optimization and is called after
first uprobe hit. I originally had it called on uprobe installation but then
it clashed with elf loader, because the user space trampoline was added in a
place where loader might need to put elf segments, so I decided to do it after
first uprobe hit when loading is done.

The uprobe is un-optimized in arch specific set_orig_insn call.

The instruction overwrite is x86 arch specific and needs to go through 3 updates:
(on top of nop5 instruction)

  - write int3 into 1st byte
  - write last 4 bytes of the call instruction
  - update the call instruction opcode

And cleanup goes though similar reverse stages:

  - overwrite call opcode with breakpoint (int3)
  - write last 4 bytes of the nop5 instruction
  - write the nop5 first instruction byte

We do not unmap and release uprobe trampoline when it's no longer needed,
because there's no easy way to make sure none of the threads is still
inside the trampoline. But we do not waste memory, because there's just
single page for all the uprobe trampoline mappings.

We do waste frame on page mapping for every 4GB by keeping the uprobe
trampoline page mapped, but that seems ok.

We take the benefit from the fact that set_swbp and set_orig_insn are
called under mmap_write_lock(mm), so we can use the current instruction
as the state the uprobe is in - nop5/breakpoint/call trampoline -
and decide the needed action (optimize/un-optimize) based on that.

Attaching the speed up from benchs/run_bench_uprobes.sh script:

current:
        usermode-count :  152.604 ± 0.044M/s
        syscall-count  :   13.359 ± 0.042M/s
-->     uprobe-nop     :    3.229 ± 0.002M/s
        uprobe-push    :    3.086 ± 0.004M/s
        uprobe-ret     :    1.114 ± 0.004M/s
        uprobe-nop5    :    1.121 ± 0.005M/s
        uretprobe-nop  :    2.145 ± 0.002M/s
        uretprobe-push :    2.070 ± 0.001M/s
        uretprobe-ret  :    0.931 ± 0.001M/s
        uretprobe-nop5 :    0.957 ± 0.001M/s

after the change:
        usermode-count :  152.448 ± 0.244M/s
        syscall-count  :   14.321 ± 0.059M/s
        uprobe-nop     :    3.148 ± 0.007M/s
        uprobe-push    :    2.976 ± 0.004M/s
        uprobe-ret     :    1.068 ± 0.003M/s
-->     uprobe-nop5    :    7.038 ± 0.007M/s
        uretprobe-nop  :    2.109 ± 0.004M/s
        uretprobe-push :    2.035 ± 0.001M/s
        uretprobe-ret  :    0.908 ± 0.001M/s
        uretprobe-nop5 :    3.377 ± 0.009M/s

I see bit more speed up on Intel (above) compared to AMD. The big nop5
speed up is partly due to emulating nop5 and partly due to optimization.

The key speed up we do this for is the USDT switch from nop to nop5:
        uprobe-nop     :    3.148 ± 0.007M/s
        uprobe-nop5    :    7.038 ± 0.007M/s

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/uprobes.h |   7 +
 arch/x86/kernel/uprobes.c      | 283 ++++++++++++++++++++++++++++++++-
 include/linux/uprobes.h        |   6 +-
 kernel/events/uprobes.c        |  16 +-
 4 files changed, 305 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index 678fb546f0a7..1ee2e5115955 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -20,6 +20,11 @@ typedef u8 uprobe_opcode_t;
 #define UPROBE_SWBP_INSN		0xcc
 #define UPROBE_SWBP_INSN_SIZE		   1
 
+enum {
+	ARCH_UPROBE_FLAG_CAN_OPTIMIZE   = 0,
+	ARCH_UPROBE_FLAG_OPTIMIZE_FAIL  = 1,
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
index d18e1ae59901..209ce74ab93f 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -18,6 +18,7 @@
 #include <asm/processor.h>
 #include <asm/insn.h>
 #include <asm/mmu_context.h>
+#include <asm/nops.h>
 
 /* Post-execution fixups. */
 
@@ -702,7 +703,6 @@ static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
 	return tramp;
 }
 
-__maybe_unused
 static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, bool *new)
 {
 	struct uprobes_state *state = &current->mm->uprobes_state;
@@ -891,6 +891,280 @@ static int __init arch_uprobes_init(void)
 
 late_initcall(arch_uprobes_init);
 
+enum {
+	EXPECT_SWBP,
+	EXPECT_CALL,
+};
+
+struct write_opcode_ctx {
+	unsigned long base;
+	int expect;
+};
+
+static int is_call_insn(uprobe_opcode_t *insn)
+{
+	return *insn == CALL_INSN_OPCODE;
+}
+
+/*
+ * Verification callback used by int3_update uprobe_write calls to make sure
+ * the underlying instruction is as expected - either int3 or call.
+ */
+static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode,
+		       int nbytes, void *data)
+{
+	struct write_opcode_ctx *ctx = data;
+	uprobe_opcode_t old_opcode[5];
+
+	uprobe_copy_from_page(page, ctx->base, (uprobe_opcode_t *) &old_opcode, 5);
+
+	switch (ctx->expect) {
+	case EXPECT_SWBP:
+		if (is_swbp_insn(&old_opcode[0]))
+			return 1;
+		break;
+	case EXPECT_CALL:
+		if (is_call_insn(&old_opcode[0]))
+			return 1;
+		break;
+	}
+
+	return -1;
+}
+
+/*
+ * Modify multi-byte instructions by using INT3 breakpoints on SMP.
+ * We completely avoid using stop_machine() here, and achieve the
+ * synchronization using INT3 breakpoints and SMP cross-calls.
+ * (borrowed comment from smp_text_poke_batch_finish)
+ *
+ * The way it is done:
+ *   - Add an INT3 trap to the address that will be patched
+ *   - SMP sync all CPUs
+ *   - Update all but the first byte of the patched range
+ *   - SMP sync all CPUs
+ *   - Replace the first byte (INT3) by the first byte of the replacing opcode
+ *   - SMP sync all CPUs
+ */
+static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+		       unsigned long vaddr, char *insn, bool optimize)
+{
+	uprobe_opcode_t int3 = UPROBE_SWBP_INSN;
+	struct write_opcode_ctx ctx = {
+		.base = vaddr,
+	};
+	int err;
+
+	/*
+	 * Write int3 trap.
+	 *
+	 * The swbp_optimize path comes with breakpoint already installed,
+	 * so we can skip this step for optimize == true.
+	 */
+	if (!optimize) {
+		ctx.expect = EXPECT_CALL;
+		err = uprobe_write(auprobe, vma, vaddr, &int3, 1, verify_insn,
+				   true /* is_register */, false /* do_update_ref_ctr */,
+				   &ctx);
+		if (err)
+			return err;
+	}
+
+	smp_text_poke_sync_each_cpu();
+
+	/* Write all but the first byte of the patched range. */
+	ctx.expect = EXPECT_SWBP;
+	err = uprobe_write(auprobe, vma, vaddr + 1, insn + 1, 4, verify_insn,
+			   true /* is_register */, false /* do_update_ref_ctr */,
+			   &ctx);
+	if (err)
+		return err;
+
+	smp_text_poke_sync_each_cpu();
+
+	/*
+	 * Write first byte.
+	 *
+	 * The swbp_unoptimize needs to finish uprobe removal together
+	 * with ref_ctr update, using uprobe_write with proper flags.
+	 */
+	err = uprobe_write(auprobe, vma, vaddr, insn, 1, verify_insn,
+			   optimize /* is_register */, !optimize /* do_update_ref_ctr */,
+			   &ctx);
+	if (err)
+		return err;
+
+	smp_text_poke_sync_each_cpu();
+	return 0;
+}
+
+static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+			 unsigned long vaddr, unsigned long tramp)
+{
+	u8 call[5];
+
+	__text_gen_insn(call, CALL_INSN_OPCODE, (const void *) vaddr,
+			(const void *) tramp, CALL_INSN_SIZE);
+	return int3_update(auprobe, vma, vaddr, call, true /* optimize */);
+}
+
+static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+			   unsigned long vaddr)
+{
+	return int3_update(auprobe, vma, vaddr, auprobe->insn, false /* optimize */);
+}
+
+static int copy_from_vaddr(struct mm_struct *mm, unsigned long vaddr, void *dst, int len)
+{
+	unsigned int gup_flags = FOLL_FORCE|FOLL_SPLIT_PMD;
+	struct vm_area_struct *vma;
+	struct page *page;
+
+	page = get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+	uprobe_copy_from_page(page, vaddr, dst, len);
+	put_page(page);
+	return 0;
+}
+
+static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
+{
+	struct __packed __arch_relative_insn {
+		u8 op;
+		s32 raddr;
+	} *call = (struct __arch_relative_insn *) insn;
+
+	if (!is_call_insn(insn))
+		return false;
+	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
+}
+
+static int is_optimized(struct mm_struct *mm, unsigned long vaddr, bool *optimized)
+{
+	uprobe_opcode_t insn[5];
+	int err;
+
+	err = copy_from_vaddr(mm, vaddr, &insn, 5);
+	if (err)
+		return err;
+	*optimized = __is_optimized((uprobe_opcode_t *)&insn, vaddr);
+	return 0;
+}
+
+static bool should_optimize(struct arch_uprobe *auprobe)
+{
+	return !test_bit(ARCH_UPROBE_FLAG_OPTIMIZE_FAIL, &auprobe->flags) &&
+		test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
+}
+
+int set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+	     unsigned long vaddr)
+{
+	if (should_optimize(auprobe)) {
+		bool optimized = false;
+		int err;
+
+		/*
+		 * We could race with another thread that already optimized the probe,
+		 * so let's not overwrite it with int3 again in this case.
+		 */
+		err = is_optimized(vma->vm_mm, vaddr, &optimized);
+		if (err)
+			return err;
+		if (optimized)
+			return 0;
+	}
+	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN,
+				   true /* is_register */);
+}
+
+int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+		  unsigned long vaddr)
+{
+	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
+		struct mm_struct *mm = vma->vm_mm;
+		bool optimized = false;
+		int err;
+
+		err = is_optimized(mm, vaddr, &optimized);
+		if (err)
+			return err;
+		if (optimized) {
+			err = swbp_unoptimize(auprobe, vma, vaddr);
+			WARN_ON_ONCE(err);
+			return err;
+		}
+	}
+	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn,
+				   false /* is_register */);
+}
+
+static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
+				  unsigned long vaddr)
+{
+	struct uprobe_trampoline *tramp;
+	struct vm_area_struct *vma;
+	bool new = false;
+	int err = 0;
+
+	vma = find_vma(mm, vaddr);
+	if (!vma)
+		return -EINVAL;
+	tramp = get_uprobe_trampoline(vaddr, &new);
+	if (!tramp)
+		return -EINVAL;
+	err = swbp_optimize(auprobe, vma, vaddr, tramp->vaddr);
+	if (WARN_ON_ONCE(err) && new)
+		destroy_uprobe_trampoline(tramp);
+	return err;
+}
+
+void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	struct mm_struct *mm = current->mm;
+	uprobe_opcode_t insn[5];
+
+	/*
+	 * Do not optimize if shadow stack is enabled, the return address hijack
+	 * code in arch_uretprobe_hijack_return_addr updates wrong frame when
+	 * the entry uprobe is optimized and the shadow stack crashes the app.
+	 */
+	if (shstk_is_enabled())
+		return;
+
+	if (!should_optimize(auprobe))
+		return;
+
+	mmap_write_lock(mm);
+
+	/*
+	 * Check if some other thread already optimized the uprobe for us,
+	 * if it's the case just go away silently.
+	 */
+	if (copy_from_vaddr(mm, vaddr, &insn, 5))
+		goto unlock;
+	if (!is_swbp_insn((uprobe_opcode_t*) &insn))
+		goto unlock;
+
+	/*
+	 * If we fail to optimize the uprobe we set the fail bit so the
+	 * above should_optimize will fail from now on.
+	 */
+	if (__arch_uprobe_optimize(auprobe, mm, vaddr))
+		set_bit(ARCH_UPROBE_FLAG_OPTIMIZE_FAIL, &auprobe->flags);
+
+unlock:
+	mmap_write_unlock(mm);
+}
+
+static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	if (memcmp(&auprobe->insn, x86_nops[5], 5))
+		return false;
+	/* We can't do cross page atomic writes yet. */
+	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= 5;
+}
 #else /* 32-bit: */
 /*
  * No RIP-relative addressing on 32-bit
@@ -904,6 +1178,10 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 }
+static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	return false;
+}
 #endif /* CONFIG_X86_64 */
 
 struct uprobe_xol_ops {
@@ -1270,6 +1548,9 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret)
 		return ret;
 
+	if (can_optimize(auprobe, addr))
+		set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
+
 	ret = branch_setup_xol_ops(auprobe, &insn);
 	if (ret != -ENOSYS)
 		return ret;
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b6b077cc7d0f..08ef78439d0d 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -192,7 +192,7 @@ struct uprobes_state {
 };
 
 typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
-				     uprobe_opcode_t *insn, int nbytes);
+				     uprobe_opcode_t *insn, int nbytes, void *data);
 
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct vm_area_struct *vma, unsigned long vaddr);
@@ -204,7 +204,8 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma, unsigned long vaddr, uprobe_opcode_t,
 			       bool is_register);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma, const unsigned long opcode_vaddr,
-			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr,
+			void *data);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
@@ -240,6 +241,7 @@ extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *
 extern void arch_uprobe_clear_state(struct mm_struct *mm);
 extern void arch_uprobe_init_state(struct mm_struct *mm);
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
+extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index cbba31c0495f..e54081beeab9 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -192,7 +192,7 @@ static void copy_to_page(struct page *page, unsigned long vaddr, const void *src
 }
 
 static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *insn,
-			 int nbytes)
+			 int nbytes, void *data)
 {
 	uprobe_opcode_t old_opcode;
 	bool is_swbp;
@@ -492,12 +492,13 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		bool is_register)
 {
 	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_SIZE,
-			    verify_opcode, is_register, true /* do_update_ref_ctr */);
+			    verify_opcode, is_register, true /* do_update_ref_ctr */, NULL);
 }
 
 int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
-		 uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr)
+		 uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr,
+		 void *data)
 {
 	const unsigned long vaddr = insn_vaddr & PAGE_MASK;
 	struct mm_struct *mm = vma->vm_mm;
@@ -531,7 +532,7 @@ int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		goto out;
 	folio = page_folio(page);
 
-	ret = verify(page, insn_vaddr, insn, nbytes);
+	ret = verify(page, insn_vaddr, insn, nbytes, data);
 	if (ret <= 0) {
 		folio_put(folio);
 		goto out;
@@ -2697,6 +2698,10 @@ bool __weak arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check c
 	return true;
 }
 
+void __weak arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+}
+
 /*
  * Run handler and ask thread to singlestep.
  * Ensure all non-fatal signals cannot interrupt thread while it singlesteps.
@@ -2761,6 +2766,9 @@ static void handle_swbp(struct pt_regs *regs)
 
 	handler_chain(uprobe, regs);
 
+	/* Try to optimize after first hit. */
+	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
+
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 
-- 
2.50.1


