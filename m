Return-Path: <bpf+bounces-52352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A4EA422A2
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960173B84E1
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1AA191F66;
	Mon, 24 Feb 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNmFB7p+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346513959D;
	Mon, 24 Feb 2025 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405818; cv=none; b=ReuftbMtXBF73bAd7Y2LGnMXn2OK0A1bfl+LaTeiKQjNiSacx2XYd3mEQTF4q3JvDf3u4F3uiiJxPoxHBrJPI5NRIpgd4yFhZFLm8E/H4CFgI2gzc5ed7Tiu3gZkusdLh0vR99xPTIFRLeVzNkjTIYjmw50UYxE1vzvN9YMIuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405818; c=relaxed/simple;
	bh=gaBUnD359lHvmKY4GJ5G0ocHaeuA7D+Evm11YnUR/ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcQfFVhN/fDmMjmyB0el+ebEPwK0DQnbX4lRsWjV0S/yTHXgsTVVqiLLzZBbOdTLVpO12KwHhLo+BczLJRL6bTwinjb3qUhEKKPA6m3GFv2Wi15bGx/I/dfwGY26WUaCuzOAmG1hi0ec/rFwe0wOh7KM0Cff39T/N1s0RDHapHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNmFB7p+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B08C4CEE6;
	Mon, 24 Feb 2025 14:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405817;
	bh=gaBUnD359lHvmKY4GJ5G0ocHaeuA7D+Evm11YnUR/ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uNmFB7p+Gyd8mXTS06VRc16N16mCmwflcbQAa3VlOhtNVfeCXPksOYIwH9gncRtOd
	 7pYv7ys95ikYtOMOkD3ZoGBwJcCaJ8KLvr8Gx0r6I9P5AHEKBPxz/tDKoEKkt1SSu4
	 Y0hF7GSjME4GEIbw+UNmV/Hgu3ootFjucDcZ5LC/qys1F7FdSxoCQLGzIjOiGRO+ll
	 EzBqKSSv1qpQb7OGfhskDsWyw/luOVYsECpMLKJwtPC6NJC+BSDH4YuXKQ9uyLYOwa
	 ilUntT2v8HZZwcc6QoVxvX/Lj+hjM6JG16v2sJANKfwaNULeyJ7A5by1TiZ5pKV1bu
	 08EG/XYO4/f8w==
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
Subject: [PATCH RFCv2 09/18] uprobes/x86: Add mapping for optimized uprobe trampolines
Date: Mon, 24 Feb 2025 15:01:41 +0100
Message-ID: <20250224140151.667679-10-jolsa@kernel.org>
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
 arch/x86/kernel/uprobes.c | 121 ++++++++++++++++++++++++++++++++++++++
 include/linux/uprobes.h   |   6 ++
 kernel/events/uprobes.c   |  10 ++++
 kernel/fork.c             |   1 +
 4 files changed, 138 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 3ea682dbeb39..e0c3fb01a43c 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -691,6 +691,127 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
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
+static __maybe_unused struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr)
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
+static __maybe_unused void uprobe_trampoline_put(struct uprobe_trampoline *tramp)
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
index de3631ae1746..05a156750e8d 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -17,6 +17,7 @@
 #include <linux/wait.h>
 #include <linux/timer.h>
 #include <linux/seqlock.h>
+#include <linux/mutex.h>
 
 struct uprobe;
 struct vm_area_struct;
@@ -183,6 +184,9 @@ struct xol_area;
 
 struct uprobes_state {
 	struct xol_area		*xol_area;
+#ifdef CONFIG_X86_64
+	struct hlist_head	head_tramps;
+#endif
 };
 
 typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr, uprobe_opcode_t *opcode, int nbytes);
@@ -232,6 +236,8 @@ extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
+extern void arch_uprobe_clear_state(struct mm_struct *mm);
+extern void arch_uprobe_init_state(struct mm_struct *mm);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6ac691fe5682..c690cde4442c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1784,6 +1784,14 @@ static struct xol_area *get_xol_area(void)
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
@@ -1795,6 +1803,8 @@ void uprobe_clear_state(struct mm_struct *mm)
 	delayed_uprobe_remove(NULL, mm);
 	mutex_unlock(&delayed_uprobe_lock);
 
+	arch_uprobe_clear_state(mm);
+
 	if (!area)
 		return;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 735405a9c5f3..e79baa6dcce6 100644
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
2.48.1


