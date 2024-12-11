Return-Path: <bpf+bounces-46631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D7D9ECD53
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E3C188B957
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FAD2368E0;
	Wed, 11 Dec 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRPVIdlM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF92336AF;
	Wed, 11 Dec 2024 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924115; cv=none; b=O1d53SdFGCrXhfXqiJc/MEM24CvlcLCA9HqJlBhklhjZfE+WU/YmHmUl/AdKSsbMaZs/j/6hgVn37QQ95jilKELJdqXmJARfx7u75oW8nmTngwxAmHY/sroWrU1nHAPOAUzqrR9hT5E1snPsuVr3+GrblX4Dk9wYBWqA27ylUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924115; c=relaxed/simple;
	bh=VIt9RfxU3t70Tz8wlMWKsiA5ewmGYP2mYGpmu4K6NcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNenlUTnITmT6xsX7Dw6dP8KtlgRhZboMQtzYqWr5yJ4b+GeAZ64zM8RylyoayFC75su28Uib9G/h7TaB6r4dAduN6B5e1IcNlS98vjQFJj0npZtyvC1+JjEoluRgCIfekIt2GBb583eyMvE+yure97gMvVMqX4LQgMda73iOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRPVIdlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865E6C4CED2;
	Wed, 11 Dec 2024 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733924114;
	bh=VIt9RfxU3t70Tz8wlMWKsiA5ewmGYP2mYGpmu4K6NcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRPVIdlMS8l0qIH/hPJSddv+/QbWdk8PFUmsx0rF3/iEA82vMuRYUWQWXYLCu15e/
	 g4XCnyTsbZFBstrNNqjfC+ak1iS/OqN5KM6FgcsszgxJWo8N75BC6sRVqn7699L7wD
	 D3iggJvFg3vPAQ0P7oltqdK4TO4VdaOPSl70TDfihYcASJALYsGOCjuLlbixYS5b7U
	 hfnvGVNTh9Dh04PGdj1C2rkIA0B2QMEqKLRzu8x635fMaEh6Do1m/i/YGSGjYLpfFS
	 0vRQczPr7L4q49Mm980mX62sQL58/W0IaSr1tBlNyJd6LB5lxmpCi08D/LZx3ryIuu
	 rvZaNiR/kH3eg==
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
Subject: [PATCH bpf-next 06/13] uprobes/x86: Add uprobe syscall to speed up uprobe
Date: Wed, 11 Dec 2024 14:33:55 +0100
Message-ID: <20241211133403.208920-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211133403.208920-1-jolsa@kernel.org>
References: <20241211133403.208920-1-jolsa@kernel.org>
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 arch/x86/kernel/uprobes.c              | 80 ++++++++++++++++++++++++++
 include/linux/syscalls.h               |  2 +
 include/linux/uprobes.h                |  1 +
 kernel/events/uprobes.c                | 22 +++++++
 kernel/sys_ni.c                        |  1 +
 6 files changed, 107 insertions(+)

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
index 22a17c149a55..23e4f2821cff 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -425,6 +425,86 @@ SYSCALL_DEFINE0(uretprobe)
 	return -1;
 }
 
+static int tramp_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
+{
+	return -EPERM;
+}
+
+static struct vm_special_mapping tramp_mapping = {
+	.name   = "[uprobes-trampoline]",
+	.mremap = tramp_mremap,
+};
+
+SYSCALL_DEFINE0(uprobe)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	struct vm_area_struct *vma;
+	unsigned long bp_vaddr;
+	int err;
+
+	err = copy_from_user(&bp_vaddr, (void __user *)regs->sp + 3*8, sizeof(bp_vaddr));
+	if (err) {
+		force_sig(SIGILL);
+		return -1;
+	}
+
+	/* Allow execution only from uprobe trampolines. */
+	vma = vma_lookup(current->mm, regs->ip);
+	if (!vma || vma->vm_private_data != (void *) &tramp_mapping) {
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
+	"endbr64\n"
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
+const struct vm_special_mapping *arch_uprobe_trampoline_mapping(void)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+
+	return user_64bit_mode(regs) ? &tramp_mapping : NULL;
+}
+
+static int __init arch_uprobes_init(void)
+{
+	unsigned long size = uprobe_trampoline_end - uprobe_trampoline_entry;
+	static struct page *pages[2];
+	struct page *page;
+
+	page = alloc_page(GFP_HIGHUSER);
+	if (!page)
+		return -ENOMEM;
+	pages[0] = page;
+	tramp_mapping.pages = (struct page **) &pages;
+	arch_uprobe_copy_ixol(page, 0, uprobe_trampoline_entry, size);
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
index c4ee755ca2a1..5e9a33bfb747 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -232,6 +232,7 @@ extern struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr);
 extern void uprobe_trampoline_put(struct uprobe_trampoline *area);
 extern bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr);
 extern const struct vm_special_mapping *arch_uprobe_trampoline_mapping(void);
+extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f57918c624da..52f38d1ef276 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2729,6 +2729,28 @@ static void handle_swbp(struct pt_regs *regs)
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
2.47.0


