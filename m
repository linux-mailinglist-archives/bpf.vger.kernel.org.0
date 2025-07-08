Return-Path: <bpf+bounces-62668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283E4AFCC02
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CCE17B130
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85F72DF3FB;
	Tue,  8 Jul 2025 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgZcGZ8d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493412DCF53;
	Tue,  8 Jul 2025 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981131; cv=none; b=On4SN2rNiTeWFCB1NOjpiJ+a9U5G4xu0293J7Ow3XJUVyjqxXoHtimMw5rkMYHM41zbSqtvKoujaDBCnjqnZHyuVRctAZbctJeoRL3yG9XNfOHJqks0A4YosrEF+acSeBUEe5da0DFm76Yi3Mz5bnjc3P4R9dUx9meyHlT8t6ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981131; c=relaxed/simple;
	bh=0y6W8HHrnBbyQnIKAx2+cewzgFGIymmmZRGIDFUowNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QT+3N0p/xKNXisDP6A8TjVMBZKfARQH6S2fPleh4ipuMSEN99XmFe5X+UhRMrHEGkd6yzRikEzeUAbSF7xCAG5nt7UCy3d9awnqH+8dpbhzm3GJklcLUBRwOTWIybxHXtMEjnD+ISte13qaED8yUjq338rFvSrWgicQfIUbx3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgZcGZ8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B177CC4CEED;
	Tue,  8 Jul 2025 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751981130;
	bh=0y6W8HHrnBbyQnIKAx2+cewzgFGIymmmZRGIDFUowNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EgZcGZ8dXfVFe5MerGs5ekRZg8UsoJ5Di6xX80GX7qVsjDwF6C0znc7GxbGlF6RU7
	 j2H94gcgULYjd8YFuXbU5OwdEbwV7+2bKdbKPrbM5sl3daqQQnq2X0JdePbmbptmae
	 io0ERb98qkeTyU5ECHma5JVD5WG/VvSCsGndimKBVi7aWreFVQUTGKNB3OOPwg8B2k
	 ZnUChqFugS/8H7OegdLp7RWOdihimrHa+HpNXUsxJwGfAjJGMYo4eWhL4/OpoT7Dzy
	 IQn0fnS3QJpHN6p8APnlA2DcD6Zvo2MpAtvqhHM7lcYNXczcryjc+KI/4M+5u64D5q
	 tEkRvGyk3k5PQ==
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
Subject: [PATCHv4 perf/core 09/22] uprobes/x86: Add uprobe syscall to speed up uprobe
Date: Tue,  8 Jul 2025 15:23:18 +0200
Message-ID: <20250708132333.2739553-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708132333.2739553-1-jolsa@kernel.org>
References: <20250708132333.2739553-1-jolsa@kernel.org>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
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
index 6336bb961907..9b0dcef04cbe 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -777,6 +777,128 @@ void arch_uprobe_clear_state(struct mm_struct *mm)
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
index b40d33aae016..b6b077cc7d0f 100644
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
index acec91a676b7..cbba31c0495f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2772,6 +2772,23 @@ static void handle_swbp(struct pt_regs *regs)
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
2.50.0


