Return-Path: <bpf+bounces-46630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C6C9ECD4E
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097A3188B913
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3F8233694;
	Wed, 11 Dec 2024 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWLeR9XV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294DC22C363;
	Wed, 11 Dec 2024 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924104; cv=none; b=qyYK7mpbfuhxaDam5A9EaYy83JdNFRaTy5GAGA4z7AyTWlx3TG5Cu9rtSEaiWhfENnXiKsdBipYFJ7Qnv7xnEOJiopU1XtM0pmtRrema5J5cDbgJL8+u3HhEe9v0vMu7JuZFEUl7YOGuYRNNnPNkPR/Hf5klSYVqXZK+EnhZa4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924104; c=relaxed/simple;
	bh=8jQBJMTqI5SGCH3HyoZGPUbDCqZg31PSW38saJQZTcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCzroADtrsSi7VAJMtZJWoFRIqYMY5XS0XfH6llchzJ9P0PWgMDsIO3OjRv1IT/fuC2Z9S0wMAOpSClZr5Uzl4Z5Sya3zFO/nhdvnGYf1tV71xdk4SENPJ3s4pU4Ff0n46jxt52B34K6boIDpSVoVegmOzSH+O+fGlRvhOiSSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWLeR9XV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CC5C4CED2;
	Wed, 11 Dec 2024 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733924104;
	bh=8jQBJMTqI5SGCH3HyoZGPUbDCqZg31PSW38saJQZTcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWLeR9XVPcag6gwCl+YJ8qb8cBu9XPv9ohkYqnBSEYI5YqQREFsCjPbYKx2Hy1srC
	 9JrgmTaRTldzL/hxnqgl76d49mWPGHptGTnlGWldIMJDV1y/5XTOvs6Ie3HWVIuwV8
	 8K9ec6QkVX518yRj5hyCGv+0TJJR6UpoRJqY1SdY/AOLOkEyVUVNBkj+efi6XlzG/p
	 U5uQe6ts0JKObq/EFGZLa8S3kjj0ilFBOWnuqd2q/wn9CU41uzufRprulFgfxlwqOo
	 wSOG7tKbSfi/PQ6Ys4xygiqV3WSh7PkgSGEskoji+VjED9vadLdDVFvvznBNQ1gqMg
	 DSRyVmX40mxQg==
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
Subject: [PATCH bpf-next 05/13] uprobes: Add mapping for optimized uprobe trampolines
Date: Wed, 11 Dec 2024 14:33:54 +0100
Message-ID: <20241211133403.208920-6-jolsa@kernel.org>
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

Adding support to add special mapping for for user space trampoline
with following functions:

  uprobe_trampoline_get - find or add related uprobe_trampoline
  uprobe_trampoline_put - remove ref or destroy uprobe_trampoline

The user space trampoline is exported as architecture specific user space
special mapping, which is provided by arch_uprobe_trampoline_mapping
function.

The uprobe trampoline needs to be callable/reachable from the probe address,
so while searching for available address we use arch_uprobe_is_callable
function to decide if the uprobe trampoline is callable from the probe address.

All uprobe_trampoline objects are stored in uprobes_state object and
are cleaned up when the process mm_struct goes down.

Locking is provided by callers in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  12 +++++
 kernel/events/uprobes.c | 114 ++++++++++++++++++++++++++++++++++++++++
 kernel/fork.c           |   1 +
 3 files changed, 127 insertions(+)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 8843b7f99ed0..c4ee755ca2a1 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <linux/timer.h>
+#include <linux/mutex.h>
 
 struct uprobe;
 struct vm_area_struct;
@@ -172,6 +173,13 @@ struct xol_area;
 
 struct uprobes_state {
 	struct xol_area		*xol_area;
+	struct hlist_head	tramp_head;
+};
+
+struct uprobe_trampoline {
+	struct hlist_node	node;
+	unsigned long		vaddr;
+	atomic64_t		ref;
 };
 
 extern void __init uprobes_init(void);
@@ -220,6 +228,10 @@ extern int arch_uprobe_verify_opcode(struct arch_uprobe *auprobe, struct page *p
 				     unsigned long vaddr, uprobe_opcode_t *new_opcode,
 				     int nbytes);
 extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int nbytes);
+extern struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr);
+extern void uprobe_trampoline_put(struct uprobe_trampoline *area);
+extern bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr);
+extern const struct vm_special_mapping *arch_uprobe_trampoline_mapping(void);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8068f91de9e3..f57918c624da 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -615,6 +615,118 @@ set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long v
 			(uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_INSN_SIZE);
 }
 
+bool __weak arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr)
+{
+	return false;
+}
+
+const struct vm_special_mapping * __weak arch_uprobe_trampoline_mapping(void)
+{
+	return NULL;
+}
+
+static unsigned long find_nearest_page(unsigned long vaddr)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma, *prev;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	prev = vma_next(&vmi);
+	vma = vma_next(&vmi);
+	while (vma) {
+		if (vma->vm_start - prev->vm_end  >= PAGE_SIZE) {
+			if (arch_uprobe_is_callable(prev->vm_end, vaddr))
+				return prev->vm_end;
+			if (arch_uprobe_is_callable(vma->vm_start - PAGE_SIZE, vaddr))
+				return vma->vm_start - PAGE_SIZE;
+		}
+
+		prev = vma;
+		vma = vma_next(&vmi);
+	}
+
+	return 0;
+}
+
+static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
+{
+	const struct vm_special_mapping *mapping;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct uprobe_trampoline *tramp;
+
+	mapping = arch_uprobe_trampoline_mapping();
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
+struct uprobe_trampoline *uprobe_trampoline_get(unsigned long vaddr)
+{
+	struct uprobes_state *state = &current->mm->uprobes_state;
+	struct uprobe_trampoline *tramp = NULL;
+
+	hlist_for_each_entry(tramp, &state->tramp_head, node) {
+		if (arch_uprobe_is_callable(tramp->vaddr, vaddr)) {
+			atomic64_inc(&tramp->ref);
+			return tramp;
+		}
+	}
+
+	tramp = create_uprobe_trampoline(vaddr);
+	if (!tramp)
+		return NULL;
+
+	hlist_add_head(&tramp->node, &state->tramp_head);
+	return tramp;
+}
+
+static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
+{
+	hlist_del(&tramp->node);
+	kfree(tramp);
+}
+
+void uprobe_trampoline_put(struct uprobe_trampoline *tramp)
+{
+	if (tramp == NULL)
+		return;
+
+	if (atomic64_dec_and_test(&tramp->ref))
+		destroy_uprobe_trampoline(tramp);
+}
+
+static void clear_tramp_head(struct mm_struct *mm)
+{
+	struct uprobes_state *state = &mm->uprobes_state;
+	struct uprobe_trampoline *tramp;
+	struct hlist_node *n;
+
+	hlist_for_each_entry_safe(tramp, n, &state->tramp_head, node)
+		destroy_uprobe_trampoline(tramp);
+}
+
 /* uprobe should have guaranteed positive refcount */
 static struct uprobe *get_uprobe(struct uprobe *uprobe)
 {
@@ -1787,6 +1899,8 @@ void uprobe_clear_state(struct mm_struct *mm)
 	delayed_uprobe_remove(NULL, mm);
 	mutex_unlock(&delayed_uprobe_lock);
 
+	clear_tramp_head(mm);
+
 	if (!area)
 		return;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 1450b461d196..b734a172fd6e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1254,6 +1254,7 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
 	mm->uprobes_state.xol_area = NULL;
+	INIT_HLIST_HEAD(&mm->uprobes_state.tramp_head);
 #endif
 }
 
-- 
2.47.0


