Return-Path: <bpf+bounces-52351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BA4A4226C
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41D6188DA9E
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B33B16F288;
	Mon, 24 Feb 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaOsGk/B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134C770FE;
	Mon, 24 Feb 2025 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405807; cv=none; b=s+fgDPJJi7UlpvtYoddJYpsdL7EJ4Fr9G4znbumhQ7iRG1GQKhBGUTVrZX9QgUxEKxhKTxoZHCBIyhs4TcqGWpab1J0B+maq7SA5jbfxrl10yyq3KYEayIAAgyqlXwDirdfv9gzfviMn4RsMqPabGuTtf+hogpOsJP/1DRILhZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405807; c=relaxed/simple;
	bh=3ymEFKK4a1qn/AIglmbrAJ8uCQ2CSQdIEgw7gp+H4nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3W1k1gPKs8jn4DWLkirsq9FPBkE17ZWHXCeoCYd/IB1hngypGkzdtTWGtsJfmzRDyxw/zqTm//6CIroQiJGAdZEBuw9k/bE5ZtYSNm+CxtYgyhop9f9tvCLQ9RLIffeFN48kMP/6voGiDqnas4c6YnOPqCvidxLLz3pTT2sq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaOsGk/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD37C4CED6;
	Mon, 24 Feb 2025 14:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405806;
	bh=3ymEFKK4a1qn/AIglmbrAJ8uCQ2CSQdIEgw7gp+H4nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OaOsGk/B/R9kFeXmdbfvaElDfQRwg5fH2Jclr2uK8MQ1AbrqtZvrpROpJHqrzTMOD
	 6+YlDgwx8IGgGFH/LgQNzWdKqDZk3i48XiKRDl5LqB5gFqUGfqMpWpnk1tq3sihS27
	 JmmUx61VJfaMzuKcTsj/G2hnXQlVyHqofQ9fOXbSOkhLC3kh8AKEUXRDQz3rHRZ1Qr
	 c3/SQgDQ2YbNQtEmOH8hhS0ZEZlu69r9R/AryhPFBBiQsWF0DkYoKSv95Sr4yAJCdf
	 /5D13BMqf8Ocsaa/thHhOwQTRUnUv+BuuPPKgk409M9ZJYAMsrbuLjlUzcSYsznyhA
	 Zd57wjo4OKIUw==
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
Subject: [PATCH RFCv2 08/18] uprobes/x86: Add uprobe syscall to speed up uprobe
Date: Mon, 24 Feb 2025 15:01:40 +0100
Message-ID: <20250224140151.667679-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224140151.667679-1-jolsa@kernel.org>
References: <20250224140151.667679-1-jolsa@kernel.org>
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
 arch/x86/kernel/uprobes.c              | 87 ++++++++++++++++++++++++++
 include/linux/syscalls.h               |  2 +
 include/linux/uprobes.h                |  1 +
 kernel/events/uprobes.c                | 22 +++++++
 kernel/sys_ni.c                        |  1 +
 6 files changed, 114 insertions(+)

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
index b06f3cd7551a..3ea682dbeb39 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -425,6 +425,93 @@ SYSCALL_DEFINE0(uretprobe)
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
+static bool in_uprobe_trampoline(unsigned long ip)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	bool found, retry = true;
+	unsigned int seq;
+
+	rcu_read_lock();
+	if (mmap_lock_speculate_try_begin(mm, &seq)) {
+		vma = vma_lookup(current->mm, ip);
+		found = vma && vma_is_special_mapping(vma, &tramp_mapping);
+		retry = mmap_lock_speculate_retry(mm, seq);
+	}
+	rcu_read_unlock();
+
+	if (retry) {
+		mmap_read_lock(mm);
+		vma = vma_lookup(current->mm, ip);
+		found = vma && vma_is_special_mapping(vma, &tramp_mapping);
+		mmap_read_unlock(mm);
+	}
+	return found;
+}
+
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
+	/* Allow execution only from uprobe trampolines. */
+	if (!in_uprobe_trampoline(regs->ip)) {
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
+	".balign " __stringify(PAGE_SIZE) "\n"
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
index 6c3c90a0d110..de3631ae1746 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -231,6 +231,7 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
+extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index cfcde7295e15..6ac691fe5682 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2733,6 +2733,28 @@ static void handle_swbp(struct pt_regs *regs)
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
+	handler_chain(uprobe, regs, false);
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
2.48.1


