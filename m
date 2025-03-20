Return-Path: <bpf+bounces-54449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B649BA6A530
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9E29827F5
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D2D21C18D;
	Thu, 20 Mar 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMrIfXvJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28021D5AB;
	Thu, 20 Mar 2025 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471016; cv=none; b=XVRTcubBOXALxq1KGAZsj+KU2V60p2Z1TZj8dbvQin8erqIIy86qpzZTaDe2cInKkYoeHQDpbUuIn2M0DePWbP1czNma25lEI32CKvO+CtQhL3LNpwq/+yDMp60ZLtVEXPZI7RuHRer58PaZ6bDZjWF3t3RAlZqguaToPlBbmrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471016; c=relaxed/simple;
	bh=vdK5iLuaoCCuGne45ZOywQYKLJ1jBxMhtHfpAKOV8Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvMS6eOChMxdwSJ6eE+umuzT0pOdbUvIrTAVvo9r5mlfSqRXnnB2NTExpqGPQ2adFtex+Vnm2l73n8hSURDXIUok1gWCkgU68l0L54Dbv+1x/ipHYJ0JQWLJ7y5jP5lKUKUNfUkdOBeh14jCFjv/T9EMoMs2b+QT0bxgDmOsPe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMrIfXvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3BDC4CEE8;
	Thu, 20 Mar 2025 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471016;
	bh=vdK5iLuaoCCuGne45ZOywQYKLJ1jBxMhtHfpAKOV8Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EMrIfXvJAY0xDAJbBK2vN+HgpFBbgFtSCSN/5cxnQqwu9YdpvNaHWJZWoTKOXymlu
	 qtQI9XoIlMP/dKHy6QGeR0Tm3J6yen3e6UIDh+btmta8AjhmE8x91EXKi1Rf2xx7vF
	 I938Pv3XEHALH3DeDy5onRyR8oMKwwY/L96jmzLijiVxC/02rcZFtUt88qWEPNQCux
	 rYKeBNUWeUCWbbYs5KTAdoB0JApLSjojwvQpVXX4uB26L+LaNMv98ODWk8T8NZFGfa
	 WBOMp2o9WxUR/wuSSGOPMHUpaokPSXimW3Vm0r/myIWLhRgi+qMEWU6pjUBDsjjI3z
	 W7YQ6GqB1Xglg==
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
Subject: [PATCH RFCv3 08/23] uprobes/x86: Add uprobe syscall to speed up uprobe
Date: Thu, 20 Mar 2025 12:41:43 +0100
Message-ID: <20250320114200.14377-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320114200.14377-1-jolsa@kernel.org>
References: <20250320114200.14377-1-jolsa@kernel.org>
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
 arch/x86/kernel/uprobes.c              | 134 +++++++++++++++++++++++++
 include/linux/syscalls.h               |   2 +
 include/linux/uprobes.h                |   1 +
 kernel/events/uprobes.c                |  22 ++++
 kernel/sys_ni.c                        |   1 +
 6 files changed, 161 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 5eb708bff1c7..88e388c7675b 100644
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
index 39521f1c4185..b11dcd47edaa 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -429,6 +429,140 @@ SYSCALL_DEFINE0(uretprobe)
 	return -1;
 }
 
+static int tramp_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
+{
+	return -EPERM;
+}
+
+static struct page *tramp_mapping_pages[2] __ro_after_init;
+
+static struct vm_special_mapping tramp_mapping = {
+	.name   = "[uprobes-trampoline]",
+	.mremap = tramp_mremap,
+	.pages  = tramp_mapping_pages,
+};
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
 /*
  * If arch_uprobe->insn doesn't use rip-relative addressing, return
  * immediately.  Otherwise, rewrite the instruction so that it accesses
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c6333204d451..002f4e1debe5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -994,6 +994,8 @@ asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 
 asmlinkage long sys_uretprobe(void);
 
+asmlinkage long sys_uprobe(void);
+
 /* pciconfig: alpha, arm, arm64, ia64, sparc */
 asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
 				unsigned long off, unsigned long len,
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 1b6a4e2b5464..4a2b950beefd 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -232,6 +232,7 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
+extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bd4bc62f80d7..4de04075576c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2742,6 +2742,28 @@ static void handle_swbp(struct pt_regs *regs)
 	rcu_read_unlock_trace();
 }
 
+void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr)
+{
+	struct uprobe *uprobe;
+	int is_swbp;
+
+	rcu_read_lock_trace();
+	uprobe = find_active_uprobe_rcu(bp_vaddr, &is_swbp);
+	if (!uprobe)
+		goto unlock;
+
+	if (!get_utask())
+		goto unlock;
+
+	if (arch_uprobe_ignore(&uprobe->arch, regs))
+		goto unlock;
+
+	handler_chain(uprobe, regs);
+
+ unlock:
+	rcu_read_unlock_trace();
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


