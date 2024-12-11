Return-Path: <bpf+bounces-46633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D33EC9ECD55
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C221F283F77
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639E623369E;
	Wed, 11 Dec 2024 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2e8uhzh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402423236C;
	Wed, 11 Dec 2024 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924136; cv=none; b=cd3mbNEOoQ904HyndqImFU0TTtZVzgWfbdjZAJgWRfs6T9mCoMA73W3nYo5NpPn+bTegD1PLT5xkkpbt2Jd4djCH55mFs2jqgOjI75ookSMvct1sr7/cn5QmecJUeTih0KV2hKCQgtkN801t2SUdfaNzrMsmGHcGfApwt7wKAX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924136; c=relaxed/simple;
	bh=tU0ZW+9hsH2/3lQywbTok4TSpnaoCEWQXqU1idcN8nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRqFxiFw9eBQn6fx9it8L0h+d0kCWJVDvJ2JlFBkYki2IdfjIPImRLk3gyaACFrl41sJ00WYGF36GwTsNPfNil0/ls71e15Bh0eFX6Kd6lUZBBJzcTJR8oPlHmx0d6ciqzyj7JYGKZePq5+RdiHNw8Tih8c/1gfFez0AuRAbN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2e8uhzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CDAC4CED2;
	Wed, 11 Dec 2024 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733924136;
	bh=tU0ZW+9hsH2/3lQywbTok4TSpnaoCEWQXqU1idcN8nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2e8uhzhiL+Au/9oOddSrCGBxgmXJq8GQrQsEV6ZrLNj5ys42qfIiMPwSy9SgGQu6
	 EYGIjEb2AawEFRa8lgrTL+ho0HOJbYMtB4braG7KcSO0m/GJwhq8cpHpG3v2vixBlU
	 z5xdL63NG7fnxi7o83JO4pnSDwEAoA4FGU7HBb4S42cblOKLTIXh5GL7JZiPoW5Eli
	 w7iIFcOtbtT+tAJZeyBIzyh4XjkF/rmFwcompJI7sBnrTDAIjfYMtajz+/5vaf1UpC
	 goBRFjMFqOci7/w/0XcL2rC2z8PA9+C7KRdHKE8ycgwZ3+Au1Zf1uurqX6lID7jfwy
	 U2SFdCgQsKr0g==
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
Subject: [PATCH bpf-next 08/13] uprobes/x86: Add support to optimize uprobes
Date: Wed, 11 Dec 2024 14:33:57 +0100
Message-ID: <20241211133403.208920-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211133403.208920-1-jolsa@kernel.org>
References: <20241211133403.208920-1-jolsa@kernel.org>
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

     uprobe-nop     :    3.281 ± 0.003M/s
     uprobe-push    :    3.085 ± 0.003M/s
     uprobe-ret     :    1.130 ± 0.000M/s
 --> uprobe-nop5    :    3.276 ± 0.007M/s
     uretprobe-nop  :    1.716 ± 0.016M/s
     uretprobe-push :    1.651 ± 0.017M/s
     uretprobe-ret  :    0.846 ± 0.006M/s
 --> uretprobe-nop5 :    3.279 ± 0.002M/s

after the change:

     uprobe-nop     :    3.246 ± 0.004M/s
     uprobe-push    :    3.057 ± 0.000M/s
     uprobe-ret     :    1.113 ± 0.003M/s
 --> uprobe-nop5    :    6.751 ± 0.037M/s
     uretprobe-nop  :    1.740 ± 0.015M/s
     uretprobe-push :    1.677 ± 0.018M/s
     uretprobe-ret  :    0.852 ± 0.005M/s
 --> uretprobe-nop5 :    6.769 ± 0.040M/s

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/uprobes.h |   7 ++
 arch/x86/kernel/uprobes.c      | 168 ++++++++++++++++++++++++++++++++-
 include/linux/uprobes.h        |   1 +
 kernel/events/uprobes.c        |   8 ++
 4 files changed, 181 insertions(+), 3 deletions(-)

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
index cdea97f8cd39..b2420eeee23a 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -18,6 +18,7 @@
 #include <asm/processor.h>
 #include <asm/insn.h>
 #include <asm/mmu_context.h>
+#include <asm/nops.h>
 
 /* Post-execution fixups. */
 
@@ -914,8 +915,37 @@ static int is_nop5_insn(uprobe_opcode_t *insn)
 	return !memcmp(insn, x86_nops[5], 5);
 }
 
+static int is_call_insn(uprobe_opcode_t *insn)
+{
+	return *insn == CALL_INSN_OPCODE;
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
+static bool can_optimize_vaddr(unsigned long vaddr)
+{
+	/* We can't do cross page atomic writes yet. */
+	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >= 5;
+}
+
 /* Returns -ENOSYS if branch_xol_ops doesn't handle this insn */
-static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
+static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn,
+				unsigned long vaddr)
 {
 	u8 opc1 = OPCODE1(insn);
 	insn_byte_t p;
@@ -933,8 +963,11 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 		break;
 
 	case 0x0f:
-		if (is_nop5_insn((uprobe_opcode_t *) &auprobe->insn))
+		if (is_nop5_insn((uprobe_opcode_t *) &auprobe->insn)) {
+			if (can_optimize_vaddr(vaddr))
+				set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
 			goto setup;
+		}
 		if (insn->opcode.nbytes != 2)
 			return -ENOSYS;
 		/*
@@ -1065,7 +1098,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret)
 		return ret;
 
-	ret = branch_setup_xol_ops(auprobe, &insn);
+	ret = branch_setup_xol_ops(auprobe, &insn, addr);
 	if (ret != -ENOSYS)
 		return ret;
 
@@ -1306,3 +1339,132 @@ bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
 	else
 		return regs->sp <= ret->stack;
 }
+
+int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, struct page *page,
+			      unsigned long vaddr, uprobe_opcode_t *new_opcode,
+			      int nbytes)
+{
+	uprobe_opcode_t old_opcode[5];
+	bool is_call, is_swbp, is_nop5;
+
+	if (!test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))
+		return uprobe_verify_opcode(page, vaddr, new_opcode);
+
+	/*
+	 * The ARCH_UPROBE_FLAG_CAN_OPTIMIZE flag guarantees the following
+	 * 5 bytes read won't cross the page boundary.
+	 */
+	uprobe_copy_from_page(page, vaddr, (uprobe_opcode_t *) &old_opcode, 5);
+	is_call = is_call_insn((uprobe_opcode_t *) &old_opcode);
+	is_swbp = is_swbp_insn((uprobe_opcode_t *) &old_opcode);
+	is_nop5 = is_nop5_insn((uprobe_opcode_t *) &old_opcode);
+
+	/*
+	 * We allow following trasitions for optimized uprobes:
+	 *
+	 *   nop5 -> swbp -> call
+	 *   ||      |       |
+	 *   |'--<---'       |
+	 *   '---<-----------'
+	 *
+	 * We return 1 to ack the write, 0 to do nothing, -1 to fail write.
+	 *
+	 * If the current opcode (old_opcode) has already desired value,
+	 * we do nothing, because we are racing with another thread doing
+	 * the update.
+	 */
+	switch (nbytes) {
+	case 5:
+		if (is_call_insn(new_opcode)) {
+			if (is_swbp)
+				return 1;
+			if (is_call && !memcmp(new_opcode, &old_opcode, 5))
+				return 0;
+		} else {
+			if (is_call || is_swbp)
+				return 1;
+			if (is_nop5)
+				return 0;
+		}
+		break;
+	case 1:
+		if (is_swbp_insn(new_opcode)) {
+			if (is_nop5)
+				return 1;
+			if (is_swbp || is_call)
+				return 0;
+		} else {
+			if (is_swbp || is_call)
+				return 1;
+			if (is_nop5)
+				return 0;
+		}
+	}
+	return -1;
+}
+
+bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes)
+{
+	return nbytes == 5 ? is_call_insn(insn) : is_swbp_insn(insn);
+}
+
+static void __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
+				   unsigned long vaddr)
+{
+	struct uprobe_trampoline *tramp;
+	char call[5];
+
+	tramp = uprobe_trampoline_get(vaddr);
+	if (!tramp)
+		goto fail;
+
+	relative_call(call, (void *) vaddr, (void *) tramp->vaddr);
+	if (uprobe_write_opcode(auprobe, mm, vaddr, call, 5))
+		goto fail;
+
+	set_bit(ARCH_UPROBE_FLAG_OPTIMIZED, &auprobe->flags);
+	return;
+
+fail:
+	/* Once we fail we never try again. */
+	clear_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
+	uprobe_trampoline_put(tramp);
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
+		return uprobe_write_opcode(auprobe, mm, vaddr, insn, 5);
+
+	return uprobe_write_opcode(auprobe, mm, vaddr, insn, UPROBE_SWBP_INSN_SIZE);
+}
+
+bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr)
+{
+	long delta = (long)(vaddr + 5 - vtramp);
+	return delta >= INT_MIN && delta <= INT_MAX;
+}
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 5e9a33bfb747..1b14b9f2f8d0 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -233,6 +233,7 @@ extern void uprobe_trampoline_put(struct uprobe_trampoline *area);
 extern bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr);
 extern const struct vm_special_mapping *arch_uprobe_trampoline_mapping(void);
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
+extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 52f38d1ef276..a7a3eeec9e51 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2654,6 +2654,11 @@ bool __weak arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check c
 	return true;
 }
 
+void __weak arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	return;
+}
+
 /*
  * Run handler and ask thread to singlestep.
  * Ensure all non-fatal signals cannot interrupt thread while it singlesteps.
@@ -2718,6 +2723,9 @@ static void handle_swbp(struct pt_regs *regs)
 
 	handler_chain(uprobe, regs);
 
+	/* Try to optimize after first hit. */
+	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
+
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 
-- 
2.47.0


