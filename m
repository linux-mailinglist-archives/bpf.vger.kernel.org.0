Return-Path: <bpf+bounces-44038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 517549BCDFC
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 14:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173982834A4
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824461D88C1;
	Tue,  5 Nov 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOvBOjHc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021181D362B;
	Tue,  5 Nov 2024 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813705; cv=none; b=WaEFz+aGzBNWSIByfQllXMs878oVJIgZbTZjtBUMyTCr5txkRoqaIOt4d254RT37tnRMmcs4ax+rnKhr45RT5J0dT4NhYTsGbRjUJGkJza3BSj+6tufyNkl9TPusCSJf0tyx+e1bSxy3di9Gn46uk/RaRihuoDDH0NTtV5aMWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813705; c=relaxed/simple;
	bh=I1y0BuXthi+rHhswQatOYfSek/3hTV8+LS5gYMFqRu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+VRg9/5nxkCOgG3XSRjcLsaInXxYTBgg9Gm7QEHL1wdecWwwvTop/XVrO4n3o12SgSww0zpEBQ2748GlrEyiBm8AF7u4nDtsG2T3XNkDrGpQ2IytukRRd28ekME3uRfiOhLPFSn88sue5MuKrugu2zXS3wnej/EVQp3JPi8Pyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOvBOjHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F706C4CECF;
	Tue,  5 Nov 2024 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730813704;
	bh=I1y0BuXthi+rHhswQatOYfSek/3hTV8+LS5gYMFqRu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aOvBOjHcCiPYpk3cjZcc+/WX5HImRKZP8408IMUNNBIGIIKRn/gGL6BKhOoOKjPTF
	 gGCfz6ghBC2sL1WKeV0MaZk7WOWkOcoF8fFwQVTmG7ZHrfHJNTiagHb52okE5huVDd
	 4OlO866jbYtLIUAFncsc3IhNst4vSSI7auAMa5zh12otRr1dK2a81McnYocI3xg5ZJ
	 EysQcRRblaXeMPk7eAQxVLep6/UcczxC01MY+v6hPhDFVhnDY+2im5fq2lh5Kgqsud
	 2JkfyjLfWt8BC621CKTyEmfqXFvTa5jB29rWSzlf3ekf4PNVb6gQiQiAzMG+U2X1sT
	 SGcdFldm7FwsA==
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
Subject: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe trampolines
Date: Tue,  5 Nov 2024 14:33:59 +0100
Message-ID: <20241105133405.2703607-6-jolsa@kernel.org>
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

Adding interface to add special mapping for user space page that will be
used as place holder for uprobe trampoline in following changes.

The get_tramp_area(vaddr) function either finds 'callable' page or create
new one.  The 'callable' means it's reachable by call instruction (from
vaddr argument) and is decided by each arch via new arch_uprobe_is_callable
function.

The put_tramp_area function either drops refcount or destroys the special
mapping and all the maps are clean up when the process goes down.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/uprobes.h |  12 ++++
 kernel/events/uprobes.c | 141 ++++++++++++++++++++++++++++++++++++++++
 kernel/fork.c           |   2 +
 3 files changed, 155 insertions(+)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index be306028ed59..222d8e82cee2 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -172,6 +172,15 @@ struct xol_area;
 
 struct uprobes_state {
 	struct xol_area		*xol_area;
+	struct hlist_head	tramp_head;
+	struct mutex		tramp_mutex;
+};
+
+struct tramp_area {
+	unsigned long		vaddr;
+	struct page		*page;
+	struct hlist_node	node;
+	refcount_t		ref;
 };
 
 extern void __init uprobes_init(void);
@@ -219,6 +228,9 @@ extern int uprobe_verify_opcode(struct page *page, unsigned long vaddr, uprobe_o
 extern int arch_uprobe_verify_opcode(struct page *page, unsigned long vaddr,
 				     uprobe_opcode_t *new_opcode, void *data);
 extern bool arch_uprobe_is_register(uprobe_opcode_t *insn, int len, void *data);
+struct tramp_area *get_tramp_area(unsigned long vaddr);
+void put_tramp_area(struct tramp_area *area);
+bool arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 944d9df1f081..a44305c559a4 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -616,6 +616,145 @@ set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long v
 			(uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_INSN_SIZE, NULL);
 }
 
+bool __weak arch_uprobe_is_callable(unsigned long vtramp, unsigned long vaddr)
+{
+	return false;
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
+		if (vma->vm_start - prev->vm_end  >= PAGE_SIZE &&
+		    arch_uprobe_is_callable(prev->vm_end, vaddr))
+			return prev->vm_end;
+
+		prev = vma;
+		vma = vma_next(&vmi);
+	}
+
+	return 0;
+}
+
+static vm_fault_t tramp_fault(const struct vm_special_mapping *sm,
+			      struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct hlist_head *head = &vma->vm_mm->uprobes_state.tramp_head;
+	struct tramp_area *area;
+
+	hlist_for_each_entry(area, head, node) {
+		if (vma->vm_start == area->vaddr) {
+			vmf->page = area->page;
+			get_page(vmf->page);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int tramp_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
+{
+	return -EPERM;
+}
+
+static const struct vm_special_mapping tramp_mapping = {
+	.name = "[uprobes-trampoline]",
+	.fault = tramp_fault,
+	.mremap = tramp_mremap,
+};
+
+static struct tramp_area *create_tramp_area(unsigned long vaddr)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct tramp_area *area;
+
+	vaddr = find_nearest_page(vaddr);
+	if (!vaddr)
+		return NULL;
+
+	area = kzalloc(sizeof(*area), GFP_KERNEL);
+	if (unlikely(!area))
+		return NULL;
+
+	area->page = alloc_page(GFP_HIGHUSER);
+	if (!area->page)
+		goto free_area;
+
+	refcount_set(&area->ref, 1);
+	area->vaddr = vaddr;
+
+	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
+				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
+				&tramp_mapping);
+	if (!IS_ERR(vma))
+		return area;
+
+	__free_page(area->page);
+ free_area:
+	kfree(area);
+	return NULL;
+}
+
+struct tramp_area *get_tramp_area(unsigned long vaddr)
+{
+	struct uprobes_state *state = &current->mm->uprobes_state;
+	struct tramp_area *area = NULL;
+
+	mutex_lock(&state->tramp_mutex);
+	hlist_for_each_entry(area, &state->tramp_head, node) {
+		if (arch_uprobe_is_callable(area->vaddr, vaddr)) {
+			refcount_inc(&area->ref);
+			goto unlock;
+		}
+	}
+
+	area = create_tramp_area(vaddr);
+	if (area)
+		hlist_add_head(&area->node, &state->tramp_head);
+
+unlock:
+	mutex_unlock(&state->tramp_mutex);
+	return area;
+}
+
+static void destroy_tramp_area(struct tramp_area *area)
+{
+	hlist_del(&area->node);
+	put_page(area->page);
+	kfree(area);
+}
+
+void put_tramp_area(struct tramp_area *area)
+{
+	struct mm_struct *mm = current->mm;
+	struct uprobes_state *state = &mm->uprobes_state;
+
+	if (area == NULL)
+		return;
+
+	mutex_lock(&state->tramp_mutex);
+	if (refcount_dec_and_test(&area->ref))
+		destroy_tramp_area(area);
+	mutex_unlock(&state->tramp_mutex);
+}
+
+static void clear_tramp_head(struct mm_struct *mm)
+{
+	struct uprobes_state *state = &mm->uprobes_state;
+	struct tramp_area *area;
+	struct hlist_node *n;
+
+	hlist_for_each_entry_safe(area, n, &state->tramp_head, node)
+		destroy_tramp_area(area);
+}
+
 /* uprobe should have guaranteed positive refcount */
 static struct uprobe *get_uprobe(struct uprobe *uprobe)
 {
@@ -1788,6 +1927,8 @@ void uprobe_clear_state(struct mm_struct *mm)
 	delayed_uprobe_remove(NULL, mm);
 	mutex_unlock(&delayed_uprobe_lock);
 
+	clear_tramp_head(mm);
+
 	if (!area)
 		return;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 89ceb4a68af2..b1fe431e5cce 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1248,6 +1248,8 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 {
 #ifdef CONFIG_UPROBES
 	mm->uprobes_state.xol_area = NULL;
+	mutex_init(&mm->uprobes_state.tramp_mutex);
+	INIT_HLIST_HEAD(&mm->uprobes_state.tramp_head);
 #endif
 }
 
-- 
2.47.0


