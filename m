Return-Path: <bpf+bounces-44039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0919BCDFE
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41AB1F22AA4
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A95A1DCB20;
	Tue,  5 Nov 2024 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQMAPlQz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41DE1D63E3;
	Tue,  5 Nov 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813715; cv=none; b=j00fbdOlrHpv++l46CsUS0nNp9i3LRRI4FBJr+AizOA0TBL6eBmos2XGW6figaNiSKc1eswMc7mk4xLzjNluYplrXz81ybpzpMmITJgMva/LvbHya5ahTFEoXKtNmL2rY8MdASk/Clvr22nOtYFeTJB/sKYkbGmll37zkOTZEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813715; c=relaxed/simple;
	bh=kc9co9tk0UA3stprV/3FEsFADBhczA5tg3Mf9cRThwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/XyDWjmlmRQK1t0LCtfwFwQAbdER4P0aw13pRwztOqthDOWwKGt2opSV4BpI9vYxfsiJLK7iiFvPaNIbZ+3RAv9gohF+5BtieQgdbu0u4urKLziCaTdzmRy6zceHh+S3yQXk7SAnBq102RpMfJYfXCZOlBMiN5YBUh4voVQ9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQMAPlQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE60DC4CECF;
	Tue,  5 Nov 2024 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730813715;
	bh=kc9co9tk0UA3stprV/3FEsFADBhczA5tg3Mf9cRThwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQMAPlQzC9g+Pbg/kaV5DQQGw49GDYmUeFc2nvcBTSaKQKZuXkMl/iNw6u2d5zrtm
	 LcsMHi6dwcAVg5HumMOmwp9JlZahUipNeF+ILKXydh+gJbDa0xp0YmG9BGm9U4vdIl
	 qfhZ2EIRiZcUiT77t/GTXek6NJYW0+IFmMq9ggQNGbcVXLgYcxfKzKgNBTEQNkzV10
	 BVfRh86SZp4pBpjxdaI5dZT41iCSV22WtjqzvfN6sSz/hQZ6fjcDdZJRD9bB79YIsj
	 qFYBHSe2u+NZExFdiZMVzysM2jX5HvGZMf6kiFuzKtNbCsosBouLkbvW53JAQtfxSO
	 CaqVf2vZWBRUg==
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
Subject: [RFC perf/core 06/11] uprobes: Add uprobe syscall to speed up uprobe
Date: Tue,  5 Nov 2024 14:34:00 +0100
Message-ID: <20241105133405.2703607-7-jolsa@kernel.org>
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

Adding new uprobe syscall that calls uprobe handlers for given
'breakpoint' address.

The idea is that the 'breakpoint' address calls the user space
trampoline which executes the uprobe syscall.

The syscall handler reads the return address of the initiall call
to retrieve the original 'breakpoint' address.

With this address we find the related uprobe object and call its
consumers.

TODO allow to call uprobe syscall only from uprobe trampoline.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 arch/x86/kernel/uprobes.c              | 48 ++++++++++++++++++++++++++
 include/linux/syscalls.h               |  2 ++
 include/linux/uprobes.h                |  2 ++
 kernel/events/uprobes.c                | 35 +++++++++++++++++++
 kernel/sys_ni.c                        |  1 +
 6 files changed, 89 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7093ee21c0d1..f6299d57afe5 100644
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
index 22a17c149a55..02aa4519b677 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -425,6 +425,54 @@ SYSCALL_DEFINE0(uretprobe)
 	return -1;
 }
 
+SYSCALL_DEFINE0(uprobe)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	unsigned long bp_vaddr;
+	int err;
+
+	err = copy_from_user(&bp_vaddr, (void __user *)regs->sp + 3*8, sizeof(bp_vaddr));
+	if (err) {
+		force_sig(SIGILL);
+		return -1;
+	}
+
+	handle_syscall_uprobe(regs, bp_vaddr - 5);
+	return 0;
+}
+
+asm (
+	".pushsection .rodata\n"
+	".global uprobe_trampoline_entry\n"
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
+	".global uprobe_trampoline_end\n"
+	"uprobe_trampoline_end:\n"
+	".popsection\n"
+);
+
+extern __visible u8 uprobe_trampoline_entry[];
+extern __visible u8 uprobe_trampoline_end[];
+
+void *arch_uprobe_trampoline(unsigned long *psize)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	if (user_64bit_mode(regs)) {
+		*psize = uprobe_trampoline_end - uprobe_trampoline_entry;
+		return uprobe_trampoline_entry;
+	}
+	return NULL;
+}
+
 /*
  * If arch_uprobe->insn doesn't use rip-relative addressing, return
  * immediately.  Otherwise, rewrite the instruction so that it accesses
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 5758104921e6..a2573f9dd248 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -981,6 +981,8 @@ asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 
 asmlinkage long sys_uretprobe(void);
 
+asmlinkage long sys_uprobe(void);
+
 /* pciconfig: alpha, arm, arm64, ia64, sparc */
 asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
 				unsigned long off, unsigned long len,
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 222d8e82cee2..4024e6ea52a4 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -231,6 +231,8 @@ extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int len, void *data);
 struct tramp_area *get_tramp_area(unsigned long vaddr);
 void put_tramp_area(struct tramp_area *area);
 bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr);
+extern void *arch_uprobe_trampoline(unsigned long *psize);
+extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a44305c559a4..b8399684231c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -621,6 +621,11 @@ bool __weak arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr)
 	return false;
 }
 
+void * __weak arch_uprobe_trampoline(unsigned long *psize)
+{
+	return NULL;
+}
+
 static unsigned long find_nearest_page(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
@@ -673,7 +678,13 @@ static struct tramp_area *create_tramp_area(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
+	unsigned long tramp_size;
 	struct tramp_area *area;
+	void *tramp;
+
+	tramp = arch_uprobe_trampoline(&tramp_size);
+	if (!tramp)
+		return NULL;
 
 	vaddr = find_nearest_page(vaddr);
 	if (!vaddr)
@@ -690,6 +701,8 @@ static struct tramp_area *create_tramp_area(unsigned long vaddr)
 	refcount_set(&area->ref, 1);
 	area->vaddr = vaddr;
 
+	arch_uprobe_copy_ixol(area->page, 0, tramp, tramp_size);
+
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
 				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
 				&tramp_mapping);
@@ -2757,6 +2770,28 @@ static void handle_swbp(struct pt_regs *regs)
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
+unlock:
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
2.47.0


