Return-Path: <bpf+bounces-56338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCCAA95840
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DF23B42B6
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD0321B9D9;
	Mon, 21 Apr 2025 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt9Duniv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F31E5B71;
	Mon, 21 Apr 2025 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271981; cv=none; b=Y8l/wDFDpOpXkES636fVpmx2nNHDcnHUZVg+FVySv6DLWwHtzzuZua76RkYQbnr/dkSkYAUoYFHzF4Kdj2DRYWOqrQ6IRXkT7qYTwtF066X9loWZMk5lZYuRBzYghp2N7HP6rgw9xHyauQCxwazYjuwcoAnAZrqtTB/POgd/i/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271981; c=relaxed/simple;
	bh=gos/eCQQ6g+MQoN29cxGRcV0jPzVNlfLhiU25yTdcvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEsPE6fy8JJ+y+5ywmd3gfgdVTxyXZrLQrP5K0yToBkacAlWzC1fF/dJz7yxGyokl+dhOldn//xHv6RKh/kwfWdT7/HwhnyCHAuZC7tv3j6XRF9mEmWyjSzjRQPDQv9twC/WQuPCYVC4+UxC2nUZVe5KIqA8f2nyVv+BmkdbCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt9Duniv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C381C4CEE4;
	Mon, 21 Apr 2025 21:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745271981;
	bh=gos/eCQQ6g+MQoN29cxGRcV0jPzVNlfLhiU25yTdcvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tt9Duniv6YSgQskEH3ao0IoIkU8a0esqFXQjyyc42pGfHIgGNbp9FQtPi6KOvQIj7
	 3nqBOPewumLBEgGyxF8q3mjNnKeFIpLqlkWkds/yk620UVTI1d+M+YqOxH5Rc2i4WQ
	 cbQeQ1CbijRfmFBFrIeBhxDM3v1LYI3+t25A5UlRUtt5TLHOZOxIwiI+Bb8cfyDZ2p
	 AfcnTx18FEMfp/I7MHkxvlOFqRydYuoFetXe//9SvTLSq5ICKqtq7luyKDDT8BgUf0
	 0i4c/Q6AXnfQKTP2FLpw7zHH7P5m4Jzpepc6RROoT4NeW1n8xtxOnlL9INYhmEFlcx
	 lmpPrYkWLWOJQ==
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
Subject: [PATCH perf/core 09/22] uprobes/x86: Add uprobe syscall to speed up uprobe
Date: Mon, 21 Apr 2025 23:44:09 +0200
Message-ID: <20250421214423.393661-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421214423.393661-1-jolsa@kernel.org>
References: <20250421214423.393661-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding new uprobe syscall that calls uprobe handlers for given
'breakpoint' address.

The idea is that the 'breakpoint' address calls the user space
trampoline which executes the uprobe syscall.

The syscall handler reads the return address of the initial call
to retrieve the original 'breakpoint' address. With this address
we find the related uprobe object and call its consumers.

Adding the arch_uprobe_trampoline_mapping function that provides
uprobe trampoline mapping. This mapping is backed with one global
page initialized at __init time and shared by the all the mapping
instances.

We do not allow to execute uprobe syscall if the caller is not
from uprobe trampoline mapping.

The uprobe syscall ensures the consumer (bpf program) sees registers
values in the state before the trampoline was called.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 arch/x86/kernel/uprobes.c              | 122 +++++++++++++++++++++++++
 include/linux/syscalls.h               |   2 +
 include/linux/uprobes.h                |   1 +
 kernel/events/uprobes.c                |  17 ++++
 kernel/sys_ni.c                        |   1 +
 6 files changed, 144 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index cfb5ca41e30d..9fd1291e7bdf 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -345,6 +345,7 @@
 333	common	io_pgetevents		sys_io_pgetevents
 334	common	rseq			sys_rseq
 335	common	uretprobe		sys_uretprobe
+336	common	uprobe			sys_uprobe
 # don't use numbers 387 through 423, add new calls after the last
 # 'common' entry
 424	common	pidfd_send_signal	sys_pidfd_send_signal
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 023c55d52138..01b3035e01ea 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -739,6 +739,128 @@ void arch_uprobe_clear_state(struct mm_struct *mm)
 	hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
 		destroy_uprobe_trampoline(tramp);
 }
+
+static bool __in_uprobe_trampoline(unsigned long ip)
+{
+	struct vm_area_struct *vma = vma_lookup(current->mm, ip);
+
+	return vma && vma_is_special_mapping(vma, &tramp_mapping);
+}
+
+static bool in_uprobe_trampoline(unsigned long ip)
+{
+	struct mm_struct *mm = current->mm;
+	bool found, retry = true;
+	unsigned int seq;
+
+	rcu_read_lock();
+	if (mmap_lock_speculate_try_begin(mm, &seq)) {
+		found = __in_uprobe_trampoline(ip);
+		retry = mmap_lock_speculate_retry(mm, seq);
+	}
+	rcu_read_unlock();
+
+	if (retry) {
+		mmap_read_lock(mm);
+		found = __in_uprobe_trampoline(ip);
+		mmap_read_unlock(mm);
+	}
+	return found;
+}
+
+SYSCALL_DEFINE0(uprobe)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	unsigned long ip, sp, ax_r11_cx_ip[4];
+	int err;
+
+	/* Allow execution only from uprobe trampolines. */
+	if (!in_uprobe_trampoline(regs->ip))
+		goto sigill;
+
+	err = copy_from_user(ax_r11_cx_ip, (void __user *)regs->sp, sizeof(ax_r11_cx_ip));
+	if (err)
+		goto sigill;
+
+	ip = regs->ip;
+
+	/*
+	 * expose the "right" values of ax/r11/cx/ip/sp to uprobe_consumer/s, plus:
+	 * - adjust ip to the probe address, call saved next instruction address
+	 * - adjust sp to the probe's stack frame (check trampoline code)
+	 */
+	regs->ax  = ax_r11_cx_ip[0];
+	regs->r11 = ax_r11_cx_ip[1];
+	regs->cx  = ax_r11_cx_ip[2];
+	regs->ip  = ax_r11_cx_ip[3] - 5;
+	regs->sp += sizeof(ax_r11_cx_ip);
+	regs->orig_ax = -1;
+
+	sp = regs->sp;
+
+	handle_syscall_uprobe(regs, regs->ip);
+
+	/*
+	 * Some of the uprobe consumers has changed sp, we can do nothing,
+	 * just return via iret.
+	 */
+	if (regs->sp != sp)
+		return regs->ax;
+
+	regs->sp -= sizeof(ax_r11_cx_ip);
+
+	/* for the case uprobe_consumer has changed ax/r11/cx */
+	ax_r11_cx_ip[0] = regs->ax;
+	ax_r11_cx_ip[1] = regs->r11;
+	ax_r11_cx_ip[2] = regs->cx;
+
+	/* keep return address unless we are instructed otherwise */
+	if (ax_r11_cx_ip[3] - 5 != regs->ip)
+		ax_r11_cx_ip[3] = regs->ip;
+
+	regs->ip = ip;
+
+	err = copy_to_user((void __user *)regs->sp, ax_r11_cx_ip, sizeof(ax_r11_cx_ip));
+	if (err)
+		goto sigill;
+
+	/* ensure sysret, see do_syscall_64() */
+	regs->r11 = regs->flags;
+	regs->cx  = regs->ip;
+	return 0;
+
+sigill:
+	force_sig(SIGILL);
+	return -1;
+}
+
+asm (
+	".pushsection .rodata\n"
+	".balign " __stringify(PAGE_SIZE) "\n"
+	"uprobe_trampoline_entry:\n"
+	"push %rcx\n"
+	"push %r11\n"
+	"push %rax\n"
+	"movq $" __stringify(__NR_uprobe) ", %rax\n"
+	"syscall\n"
+	"pop %rax\n"
+	"pop %r11\n"
+	"pop %rcx\n"
+	"ret\n"
+	".balign " __stringify(PAGE_SIZE) "\n"
+	".popsection\n"
+);
+
+extern u8 uprobe_trampoline_entry[];
+
+static int __init arch_uprobes_init(void)
+{
+	tramp_mapping_pages[0] = virt_to_page(uprobe_trampoline_entry);
+	return 0;
+}
+
+late_initcall(arch_uprobes_init);
+
 #else /* 32-bit: */
 /*
  * No RIP-relative addressing on 32-bit
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e5603cc91963..b0cc60f1c458 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -998,6 +998,8 @@ asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 
 asmlinkage long sys_uretprobe(void);
 
+asmlinkage long sys_uprobe(void);
+
 /* pciconfig: alpha, arm, arm64, ia64, sparc */
 asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
 				unsigned long off, unsigned long len,
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index bc532d086813..bbe218ff16cc 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -239,6 +239,7 @@ extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
 extern void arch_uprobe_clear_state(struct mm_struct *mm);
 extern void arch_uprobe_init_state(struct mm_struct *mm);
+extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a3107f63f295..97a7b9f0c7ca 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2782,6 +2782,23 @@ static void handle_swbp(struct pt_regs *regs)
 	rcu_read_unlock_trace();
 }
 
+void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr)
+{
+	struct uprobe *uprobe;
+	int is_swbp;
+
+	guard(rcu_tasks_trace)();
+
+	uprobe = find_active_uprobe_rcu(bp_vaddr, &is_swbp);
+	if (!uprobe)
+		return;
+	if (!get_utask())
+		return;
+	if (arch_uprobe_ignore(&uprobe->arch, regs))
+		return;
+	handler_chain(uprobe, regs);
+}
+
 /*
  * Perform required fix-ups and disable singlestep.
  * Allow pending signals to take effect.
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index c00a86931f8c..bf5d05c635ff 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -392,3 +392,4 @@ COND_SYSCALL(setuid16);
 COND_SYSCALL(rseq);
 
 COND_SYSCALL(uretprobe);
+COND_SYSCALL(uprobe);
-- 
2.49.0


