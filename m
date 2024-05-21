Return-Path: <bpf+bounces-30104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE3E8CAC85
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2961F22CB6
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231A371B4B;
	Tue, 21 May 2024 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvmGAKgB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C871754;
	Tue, 21 May 2024 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288551; cv=none; b=SJ+i6G+h7mNnOqmSd7sxdXKWhRGj3AVT71xu5XvIMRENwkJl6FfGJ7md/TYoLre+fZF+D6UjXwtYAwtEGBxwAPCKN3CGw+Ln9QHn4/DL5DpwUUI36yiceDutgAuYs2X913Cg0Fmz6vVxkSZrZtXw3+KK6Bahz5I58OB4k4qMDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288551; c=relaxed/simple;
	bh=T1aGzZCLnTUkeB//lixQ3x0kCUqVyFRJjpxJToZe7vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMiRPUiCsoMSYGpA6+faTbY4zXcxaQEtrZlpOf1t/U7/kizMlbzKVh0VTLyxcoNo/lxolwNk3TtkzQS0gt1tWbQvL/f1ztRxmXNSvf2mHGJ0BuGKpnLg9fuyBAirZCHGKUKYj6a13+BeSWJ9lQiBFX0UOhf+YN9gAaQewWTfGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvmGAKgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED15C2BD11;
	Tue, 21 May 2024 10:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716288551;
	bh=T1aGzZCLnTUkeB//lixQ3x0kCUqVyFRJjpxJToZe7vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cvmGAKgBKJMOgBxSelvt4SUAyQfOxwXwUY1euQeTokNJRy+kDXYaLcCMyV1/ZDRsK
	 QajjdEdQvhIhGVtN1PeaL25vxqHLG7NfuDTXYgw0YUFsS/E2VXny0FpF59M5UUpwI0
	 WBkFPMX+zoyk/bB10AeIkOn08Xk7+vdnp0gWOkAtYID2PsjefTzsuebFJ2soJ2PlP+
	 u4KZrTMcGfBnanafHBFfcEHAamm1bEoyqAegYS+IXVtAAijBvwbID0m/Gwm4NxjZCz
	 MSxFKmcmm/lmQ9RsWQBEfTyo2TfC5UiNT81sFBqvPzC1LaQjmqsQk/nF8u/SO1SGc3
	 +CiZuJgAR/UcQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCHv6 bpf-next 3/9] uprobe: Add uretprobe syscall to speed up return probe
Date: Tue, 21 May 2024 12:48:19 +0200
Message-ID: <20240521104825.1060966-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240521104825.1060966-1-jolsa@kernel.org>
References: <20240521104825.1060966-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adding uretprobe syscall instead of trap to speed up return probe.

At the moment the uretprobe setup/path is:

  - install entry uprobe

  - when the uprobe is hit, it overwrites probed function's return address
    on stack with address of the trampoline that contains breakpoint
    instruction

  - the breakpoint trap code handles the uretprobe consumers execution and
    jumps back to original return address

This patch replaces the above trampoline's breakpoint instruction with new
ureprobe syscall call. This syscall does exactly the same job as the trap
with some more extra work:

  - syscall trampoline must save original value for rax/r11/rcx registers
    on stack - rax is set to syscall number and r11/rcx are changed and
    used by syscall instruction

  - the syscall code reads the original values of those registers and
    restore those values in task's pt_regs area

  - only caller from trampoline exposed in '[uprobes]' is allowed,
    the process will receive SIGILL signal otherwise

Even with some extra work, using the uretprobes syscall shows speed
improvement (compared to using standard breakpoint):

  On Intel (11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz)

  current:
    uretprobe-nop  :    1.498 ± 0.000M/s
    uretprobe-push :    1.448 ± 0.001M/s
    uretprobe-ret  :    0.816 ± 0.001M/s

  with the fix:
    uretprobe-nop  :    1.969 ± 0.002M/s  < 31% speed up
    uretprobe-push :    1.910 ± 0.000M/s  < 31% speed up
    uretprobe-ret  :    0.934 ± 0.000M/s  < 14% speed up

  On Amd (AMD Ryzen 7 5700U)

  current:
    uretprobe-nop  :    0.778 ± 0.001M/s
    uretprobe-push :    0.744 ± 0.001M/s
    uretprobe-ret  :    0.540 ± 0.001M/s

  with the fix:
    uretprobe-nop  :    0.860 ± 0.001M/s  < 10% speed up
    uretprobe-push :    0.818 ± 0.001M/s  < 10% speed up
    uretprobe-ret  :    0.578 ± 0.000M/s  <  7% speed up

The performance test spawns a thread that runs loop which triggers
uprobe with attached bpf program that increments the counter that
gets printed in results above.

The uprobe (and uretprobe) kind is determined by which instruction
is being patched with breakpoint instruction. That's also important
for uretprobes, because uprobe is installed for each uretprobe.

The performance test is part of bpf selftests:
  tools/testing/selftests/bpf/run_bench_uprobes.sh

Note at the moment uretprobe syscall is supported only for native
64-bit process, compat process still uses standard breakpoint.

Note that when shadow stack is enabled the uretprobe syscall returns
via iret, which is slower than return via sysret, but won't cause the
shadow stack violation.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/include/asm/shstk.h |   2 +
 arch/x86/kernel/shstk.c      |   5 ++
 arch/x86/kernel/uprobes.c    | 117 +++++++++++++++++++++++++++++++++++
 include/linux/uprobes.h      |   3 +
 kernel/events/uprobes.c      |  24 ++++---
 5 files changed, 144 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 896909f306e3..4cb77e004615 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -22,6 +22,7 @@ void shstk_free(struct task_struct *p);
 int setup_signal_shadow_stack(struct ksignal *ksig);
 int restore_signal_shadow_stack(void);
 int shstk_update_last_frame(unsigned long val);
+bool shstk_is_enabled(void);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
@@ -33,6 +34,7 @@ static inline void shstk_free(struct task_struct *p) {}
 static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
 static inline int restore_signal_shadow_stack(void) { return 0; }
 static inline int shstk_update_last_frame(unsigned long val) { return 0; }
+static inline bool shstk_is_enabled(void) { return false; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 9797d4cdb78a..059685612362 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -588,3 +588,8 @@ int shstk_update_last_frame(unsigned long val)
 	ssp = get_user_shstk_addr();
 	return write_user_shstk_64((u64 __user *)ssp, (u64)val);
 }
+
+bool shstk_is_enabled(void)
+{
+	return features_enabled(ARCH_SHSTK_SHSTK);
+}
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 6402fb3089d2..5a952c5ea66b 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -12,6 +12,7 @@
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
 #include <linux/uaccess.h>
+#include <linux/syscalls.h>
 
 #include <linux/kdebug.h>
 #include <asm/processor.h>
@@ -308,6 +309,122 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 }
 
 #ifdef CONFIG_X86_64
+
+asm (
+	".pushsection .rodata\n"
+	".global uretprobe_trampoline_entry\n"
+	"uretprobe_trampoline_entry:\n"
+	"pushq %rax\n"
+	"pushq %rcx\n"
+	"pushq %r11\n"
+	"movq $" __stringify(__NR_uretprobe) ", %rax\n"
+	"syscall\n"
+	".global uretprobe_syscall_check\n"
+	"uretprobe_syscall_check:\n"
+	"popq %r11\n"
+	"popq %rcx\n"
+
+	/* The uretprobe syscall replaces stored %rax value with final
+	 * return address, so we don't restore %rax in here and just
+	 * call ret.
+	 */
+	"retq\n"
+	".global uretprobe_trampoline_end\n"
+	"uretprobe_trampoline_end:\n"
+	".popsection\n"
+);
+
+extern u8 uretprobe_trampoline_entry[];
+extern u8 uretprobe_trampoline_end[];
+extern u8 uretprobe_syscall_check[];
+
+void *arch_uprobe_trampoline(unsigned long *psize)
+{
+	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+	struct pt_regs *regs = task_pt_regs(current);
+
+	/*
+	 * At the moment the uretprobe syscall trampoline is supported
+	 * only for native 64-bit process, the compat process still uses
+	 * standard breakpoint.
+	 */
+	if (user_64bit_mode(regs)) {
+		*psize = uretprobe_trampoline_end - uretprobe_trampoline_entry;
+		return uretprobe_trampoline_entry;
+	}
+
+	*psize = UPROBE_SWBP_INSN_SIZE;
+	return &insn;
+}
+
+static unsigned long trampoline_check_ip(void)
+{
+	unsigned long tramp = uprobe_get_trampoline_vaddr();
+
+	return tramp + (uretprobe_syscall_check - uretprobe_trampoline_entry);
+}
+
+SYSCALL_DEFINE0(uretprobe)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	unsigned long err, ip, sp, r11_cx_ax[3];
+
+	if (regs->ip != trampoline_check_ip())
+		goto sigill;
+
+	err = copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof(r11_cx_ax));
+	if (err)
+		goto sigill;
+
+	/* expose the "right" values of r11/cx/ax/sp to uprobe_consumer/s */
+	regs->r11 = r11_cx_ax[0];
+	regs->cx  = r11_cx_ax[1];
+	regs->ax  = r11_cx_ax[2];
+	regs->sp += sizeof(r11_cx_ax);
+	regs->orig_ax = -1;
+
+	ip = regs->ip;
+	sp = regs->sp;
+
+	uprobe_handle_trampoline(regs);
+
+	/*
+	 * Some of the uprobe consumers has changed sp, we can do nothing,
+	 * just return via iret.
+	 * .. or shadow stack is enabled, in which case we need to skip
+	 * return through the user space stack address.
+	 */
+	if (regs->sp != sp || shstk_is_enabled())
+		return regs->ax;
+	regs->sp -= sizeof(r11_cx_ax);
+
+	/* for the case uprobe_consumer has changed r11/cx */
+	r11_cx_ax[0] = regs->r11;
+	r11_cx_ax[1] = regs->cx;
+
+	/*
+	 * ax register is passed through as return value, so we can use
+	 * its space on stack for ip value and jump to it through the
+	 * trampoline's ret instruction
+	 */
+	r11_cx_ax[2] = regs->ip;
+	regs->ip = ip;
+
+	err = copy_to_user((void __user *)regs->sp, r11_cx_ax, sizeof(r11_cx_ax));
+	if (err)
+		goto sigill;
+
+	/* ensure sysret, see do_syscall_64() */
+	regs->r11 = regs->flags;
+	regs->cx  = regs->ip;
+
+	return regs->ax;
+
+sigill:
+	force_sig(SIGILL);
+	return -1;
+}
+
 /*
  * If arch_uprobe->insn doesn't use rip-relative addressing, return
  * immediately.  Otherwise, rewrite the instruction so that it accesses
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c..b503fafb7fb3 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -138,6 +138,9 @@ extern bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check c
 extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
 extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 					 void *src, unsigned long len);
+extern void uprobe_handle_trampoline(struct pt_regs *regs);
+extern void *arch_uprobe_trampoline(unsigned long *psize);
+extern unsigned long uprobe_get_trampoline_vaddr(void);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2c83ba776fc7..2816e65729ac 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1474,11 +1474,20 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	return ret;
 }
 
+void * __weak arch_uprobe_trampoline(unsigned long *psize)
+{
+	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+
+	*psize = UPROBE_SWBP_INSN_SIZE;
+	return &insn;
+}
+
 static struct xol_area *__create_xol_area(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
-	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+	unsigned long insns_size;
 	struct xol_area *area;
+	void *insns;
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
 	if (unlikely(!area))
@@ -1502,7 +1511,8 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
 	atomic_set(&area->slot_count, 1);
-	arch_uprobe_copy_ixol(area->pages[0], 0, &insn, UPROBE_SWBP_INSN_SIZE);
+	insns = arch_uprobe_trampoline(&insns_size);
+	arch_uprobe_copy_ixol(area->pages[0], 0, insns, insns_size);
 
 	if (!xol_add_vma(mm, area))
 		return area;
@@ -1827,7 +1837,7 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
  *
  * Returns -1 in case the xol_area is not allocated.
  */
-static unsigned long get_trampoline_vaddr(void)
+unsigned long uprobe_get_trampoline_vaddr(void)
 {
 	struct xol_area *area;
 	unsigned long trampoline_vaddr = -1;
@@ -1878,7 +1888,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	if (!ri)
 		return;
 
-	trampoline_vaddr = get_trampoline_vaddr();
+	trampoline_vaddr = uprobe_get_trampoline_vaddr();
 	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
 	if (orig_ret_vaddr == -1)
 		goto fail;
@@ -2123,7 +2133,7 @@ static struct return_instance *find_next_ret_chain(struct return_instance *ri)
 	return ri;
 }
 
-static void handle_trampoline(struct pt_regs *regs)
+void uprobe_handle_trampoline(struct pt_regs *regs)
 {
 	struct uprobe_task *utask;
 	struct return_instance *ri, *next;
@@ -2187,8 +2197,8 @@ static void handle_swbp(struct pt_regs *regs)
 	int is_swbp;
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
-	if (bp_vaddr == get_trampoline_vaddr())
-		return handle_trampoline(regs);
+	if (bp_vaddr == uprobe_get_trampoline_vaddr())
+		return uprobe_handle_trampoline(regs);
 
 	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
 	if (!uprobe) {
-- 
2.45.0


