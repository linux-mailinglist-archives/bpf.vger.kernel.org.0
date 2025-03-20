Return-Path: <bpf+bounces-54450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8356AA6A539
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA1D19C4464
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617BF221D82;
	Thu, 20 Mar 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqFPFHUM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860921C9EB;
	Thu, 20 Mar 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471027; cv=none; b=fNsIN9a4RjeyyEymxOSgFq4gnY2f35NYQ0PyNBBQoPmI/RM788EWDV5sCsToYxsoDSMsVR5utFgyg61HD+rLEugVbZ36iwDuYRNNdZm3I54a3whlkrDp2DO8h+1TmVM3GSFtweP86PepavLUuButLZpQnEYusfaeLJNGAEmfPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471027; c=relaxed/simple;
	bh=x27U7Ss5PyOwovmggHbntsdXgvgqCagPQvPv8hvGwrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPh8roASaExYvkToFN/rpgSvcFQMSkDzQPgjgWPNnRG3WMP86v3hAZrHfdhLpM89/Xz72oD542VNuxNjO5p9lGx8xG8ty7HkdhF5HrxPM+SLQBHVK64jeTxk5cLMWKPhp2gX/8mIo07KrXC1md0/cTVMFxWxmbwS+rGurRJ6wzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqFPFHUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B6FC4CEDD;
	Thu, 20 Mar 2025 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471027;
	bh=x27U7Ss5PyOwovmggHbntsdXgvgqCagPQvPv8hvGwrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UqFPFHUMoG2Md9tUpzqv0JAJNK7XJpWbZq1ZhnW2LTlSGcigkR1kCyO8jv1/hNWXG
	 rhGxLWy7eHJmQ/c1vQDF3re2KbwNO2/AYFR8RkLvLNbAimb9ZV5TzMXkAgATWGtpFr
	 1GvMcDvl59/ODcrcQ9E6jeBFnbF2rzdGCjyfRcYwvJmKya4BNHv2nmajtO0oSVClWo
	 ZIHGtszSGU5VbexmKQ/dknEfqT614YIkprHe6x6mb35hSxHnccq8fPCmQxL3Ed0Xis
	 nCwxCOCpjheG2MQLazDQAm4/P6/7XYP5IyUp6x11JCd2AX88elfWcbfTaLrcoJL+iF
	 GrdcY2tSbNNAg==
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
Subject: [PATCH RFCv3 09/23] uprobes/x86: Add mapping for optimized uprobe trampolines
Date: Thu, 20 Mar 2025 12:41:44 +0100
Message-ID: <20250320114200.14377-10-jolsa@kernel.org>
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

Adding support to add special mapping for for user space trampoline
with following functions:

  uprobe_trampoline_get - find or add related uprobe_trampoline
  uprobe_trampoline_put - remove ref or destroy uprobe_trampoline

The user space trampoline is exported as architecture specific user space
special mapping, which is provided by arch_uprobe_trampoline_mapping
function.

The uprobe trampoline needs to be callable/reachable from the probe address,
so while searching for available address we use uprobe_is_callable function
to decide if the uprobe trampoline is callable from the probe address.

All uprobe_trampoline objects are stored in uprobes_state object and are
cleaned up when the process mm_struct goes down. Adding new arch hooks
for that, because this change is x86_64 specific.

Locking is provided by callers in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 123 ++++++++++++++++++++++++++++++++++++++
 include/linux/uprobes.h   |   6 ++
 kernel/events/uprobes.c   |  10 ++++
 kernel/fork.c             |   1 +
 4 files changed, 140 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index b11dcd47edaa..5ee2cce4c63e 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -742,6 +742,129 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 		*sr = utask->autask.saved_scratch_register;
 	}
 }
+
+struct uprobe_trampoline {
+	struct hlist_node	node;
+	unsigned long		vaddr;
+	atomic64_t		ref;
+};
+
+static bool is_reachable_by_call(unsigned long vtramp, unsigned long vaddr)
+{
+	long delta = (long)(vaddr + 5 - vtramp);
+
+	return delta >= INT_MIN && delta <= INT_MAX;
+}
+
+static unsigned long find_nearest_page(unsigned long vaddr)
+{
+	struct vm_area_struct *vma, *prev = NULL;
+	unsigned long prev_vm_end = PAGE_SIZE;
+	VMA_ITERATOR(vmi, current->mm, 0);
+
+	vma = vma_next(&vmi);
+	while (vma) {
+		if (prev)
+			prev_vm_end = prev->vm_end;
+		if (vma->vm_start - prev_vm_end  >= PAGE_SIZE) {
+			if (is_reachable_by_call(prev_vm_end, vaddr))
+				return prev_vm_end;
+			if (is_reachable_by_call(vma->vm_start - PAGE_SIZE, vaddr))
+				return vma->vm_start - PAGE_SIZE;
+		}
+		prev = vma;
+		vma = vma_next(&vmi);
+	}
+
+	return 0;
+}
+
+static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	const struct vm_special_mapping *mapping;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct uprobe_trampoline *tramp;
+
+	mapping = user_64bit_mode(regs) ? &tramp_mapping : NULL;
+	if (!mapping)
+		return NULL;
+
+	vaddr = find_nearest_page(vaddr);
+	if (!vaddr)
+		return NULL;
+
+	tramp = kzalloc(sizeof(*tramp), GFP_KERNEL);
+	if (unlikely(!tramp))
+		return NULL;
+
+	atomic64_set(&tramp->ref, 1);
+	tramp->vaddr = vaddr;
+
+	vma = _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,
+				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
+				mapping);
+	if (IS_ERR(vma))
+		goto free_area;
+	return tramp;
+
+ free_area:
+	kfree(tramp);
+	return NULL;
+}
+
+__maybe_unused
+static struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr)
+{
+	struct uprobes_state *state = &current->mm->uprobes_state;
+	struct uprobe_trampoline *tramp = NULL;
+
+	hlist_for_each_entry(tramp, &state->head_tramps, node) {
+		if (is_reachable_by_call(tramp->vaddr, vaddr)) {
+			atomic64_inc(&tramp->ref);
+			return tramp;
+		}
+	}
+
+	tramp = create_uprobe_trampoline(vaddr);
+	if (!tramp)
+		return NULL;
+
+	hlist_add_head(&tramp->node, &state->head_tramps);
+	return tramp;
+}
+
+static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
+{
+	hlist_del(&tramp->node);
+	kfree(tramp);
+}
+
+__maybe_unused
+static void uprobe_trampoline_put(struct uprobe_trampoline *tramp)
+{
+	if (tramp == NULL)
+		return;
+
+	if (atomic64_dec_and_test(&tramp->ref))
+		destroy_uprobe_trampoline(tramp);
+}
+
+void arch_uprobe_init_state(struct mm_struct *mm)
+{
+	INIT_HLIST_HEAD(&mm->uprobes_state.head_tramps);
+}
+
+void arch_uprobe_clear_state(struct mm_struct *mm)
+{
+	struct uprobes_state *state = &mm->uprobes_state;
+	struct uprobe_trampoline *tramp;
+	struct hlist_node *n;
+
+	hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
+		destroy_uprobe_trampoline(tramp);
+}
 #else /* 32-bit: */
 /*
  * No RIP-relative addressing on 32-bit
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 4a2b950beefd..7bde68871150 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -17,6 +17,7 @@
 #include <linux/wait.h>
 #include <linux/timer.h>
 #include <linux/seqlock.h>
+#include <linux/mutex.h>
 
 struct uprobe;
 struct vm_area_struct;
@@ -185,6 +186,9 @@ struct xol_area;
 
 struct uprobes_state {
 	struct xol_area		*xol_area;
+#ifdef CONFIG_X86_64
+	struct hlist_head	head_tramps;
+#endif
 };
 
 typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr, uprobe_opcode_t *opcode, int nbytes);
@@ -233,6 +237,8 @@ extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
+extern void arch_uprobe_clear_state(struct mm_struct *mm);
+extern void arch_uprobe_init_state(struct mm_struct *mm);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4de04075576c..9370df47ec71 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1793,6 +1793,14 @@ static struct xol_area *get_xol_area(void)
 	return area;
 }
 
+void __weak arch_uprobe_clear_state(struct mm_struct *mm)
+{
+}
+
+void __weak arch_uprobe_init_state(struct mm_struct *mm)
+{
+}
+
 /*
  * uprobe_clear_state - Free the area allocated for slots.
  */
@@ -1804,6 +1812,8 @@ void uprobe_clear_state(struct mm_struct *mm)
 	delayed_uprobe_remove(NULL, mm);
 	mutex_unlock(&delayed_uprobe_lock);
 
+	arch_uprobe_clear_state(mm);
+
 	if (!area)
 		return;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index e27fe5d5a15c..36a0f073b913 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1260,6 +1260,7 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
 	mm->uprobes_state.xol_area = NULL;
+	arch_uprobe_init_state(mm);
 #endif
 }
 
-- 
2.49.0


