Return-Path: <bpf+bounces-36991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24BE94FCAC
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 06:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262711F21EAB
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 04:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242523759;
	Tue, 13 Aug 2024 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxlOGQ6i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D523741;
	Tue, 13 Aug 2024 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523387; cv=none; b=pe+snLUxONEq4BmqlOx0ObDaGQJKcqpteN54PD9WqqeQLP41GFn3cJM0oaRvo1tsbAUNSnFq2RgPxSP2gSEQEEQCkkkbggpy/BEdfFjvP7PXnolT0CBsBU8QSfLOyidfqmIN5sgxMWCRCeSX+d9BbFNnRuXFlj9vOe8uVTpEszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523387; c=relaxed/simple;
	bh=5HQ56DnZm01JlMtuqxoBg8Kdzw4Qreqv0MmJ/xI2OUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9Ct6yIvGt/fsURSt4X+8043aagiQi6Y9PcFuPb4+D/zivy9WKyXePrVjWP9AcEBiMXW/ZeR1nXuREoVbip4/FCWMmx4NqNpa7whQNr0YLt8B4gSWRODWgXvNttFl2PRfQoJcbdXIj86a1zbpizn526tSpvVBjFxLc92ZtYwZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxlOGQ6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD351C4AF09;
	Tue, 13 Aug 2024 04:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723523387;
	bh=5HQ56DnZm01JlMtuqxoBg8Kdzw4Qreqv0MmJ/xI2OUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxlOGQ6irc19Rwnm0/OGpuIssYfeqF9BmpZHyj7Ww5ppReoD/hQ0PLGNXUzIZgBmv
	 M/85X1nfUmgrJTjHrScmx5HfGyJ6l0nfnTs7e5MZ9wPA4LRrusyvWG49v3FJzQMPur
	 JTAyZxdojxd7vDwgMuyUmYWmA0RGkxpUsgwiEpo+FYktDtLxo+Xsv+Pc6OpnlngzDC
	 QZWa7UH8FC2YT+SUDxX0MMuqTcIrcZ7q7xhvMQHsYQjdUVonGGabCDmBE7SY/AbDEf
	 bePCpBgsdIn29ULHE25eg6EVu6l1lOPNqIwOmGM1rKIwZBSHRsh3xE8wqZg10K27Te
	 GSGoFqay0NgxQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 02/13] uprobes: protected uprobe lifetime with SRCU
Date: Mon, 12 Aug 2024 21:29:06 -0700
Message-ID: <20240813042917.506057-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813042917.506057-1-andrii@kernel.org>
References: <20240813042917.506057-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid unnecessarily taking a (brief) refcount on uprobe during
breakpoint handling in handle_swbp for entry uprobes, make find_uprobe()
not take refcount, but protect the lifetime of a uprobe instance with
RCU. This improves scalability, as refcount gets quite expensive due to
cache line bouncing between multiple CPUs.

Specifically, we utilize our own uprobe-specific SRCU instance for this
RCU protection. put_uprobe() will delay actual kfree() using call_srcu().

For now, uretprobe and single-stepping handling will still acquire
refcount as necessary. We'll address these issues in follow up patches
by making them use SRCU with timeout.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 94 +++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 147561c19d57..3e3595753e2c 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -41,6 +41,8 @@ static struct rb_root uprobes_tree = RB_ROOT;
 
 static DEFINE_RWLOCK(uprobes_treelock);	/* serialize rbtree access */
 
+DEFINE_STATIC_SRCU(uprobes_srcu);
+
 #define UPROBES_HASH_SZ	13
 /* serialize uprobe->pending_list */
 static struct mutex uprobes_mmap_mutex[UPROBES_HASH_SZ];
@@ -59,6 +61,7 @@ struct uprobe {
 	struct list_head	pending_list;
 	struct uprobe_consumer	*consumers;
 	struct inode		*inode;		/* Also hold a ref to inode */
+	struct rcu_head		rcu;
 	loff_t			offset;
 	loff_t			ref_ctr_offset;
 	unsigned long		flags;
@@ -617,6 +620,13 @@ static inline bool uprobe_is_active(struct uprobe *uprobe)
 	return !RB_EMPTY_NODE(&uprobe->rb_node);
 }
 
+static void uprobe_free_rcu(struct rcu_head *rcu)
+{
+	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
+
+	kfree(uprobe);
+}
+
 static void put_uprobe(struct uprobe *uprobe)
 {
 	if (!refcount_dec_and_test(&uprobe->ref))
@@ -638,7 +648,7 @@ static void put_uprobe(struct uprobe *uprobe)
 	delayed_uprobe_remove(uprobe, NULL);
 	mutex_unlock(&delayed_uprobe_lock);
 
-	kfree(uprobe);
+	call_srcu(&uprobes_srcu, &uprobe->rcu, uprobe_free_rcu);
 }
 
 static __always_inline
@@ -680,33 +690,25 @@ static inline int __uprobe_cmp(struct rb_node *a, const struct rb_node *b)
 	return uprobe_cmp(u->inode, u->offset, __node_2_uprobe(b));
 }
 
-static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
+/*
+ * Assumes being inside RCU protected region.
+ * No refcount is taken on returned uprobe.
+ */
+static struct uprobe *find_uprobe_rcu(struct inode *inode, loff_t offset)
 {
 	struct __uprobe_key key = {
 		.inode = inode,
 		.offset = offset,
 	};
-	struct rb_node *node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
-
-	if (node)
-		return try_get_uprobe(__node_2_uprobe(node));
-
-	return NULL;
-}
+	struct rb_node *node;
 
-/*
- * Find a uprobe corresponding to a given inode:offset
- * Acquires uprobes_treelock
- */
-static struct uprobe *find_uprobe(struct inode *inode, loff_t offset)
-{
-	struct uprobe *uprobe;
+	lockdep_assert(srcu_read_lock_held(&uprobes_srcu));
 
 	read_lock(&uprobes_treelock);
-	uprobe = __find_uprobe(inode, offset);
+	node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
 	read_unlock(&uprobes_treelock);
 
-	return uprobe;
+	return node ? __node_2_uprobe(node) : NULL;
 }
 
 /*
@@ -1080,10 +1082,10 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 			goto free;
 		/*
 		 * We take mmap_lock for writing to avoid the race with
-		 * find_active_uprobe() which takes mmap_lock for reading.
+		 * find_active_uprobe_rcu() which takes mmap_lock for reading.
 		 * Thus this install_breakpoint() can not make
-		 * is_trap_at_addr() true right after find_uprobe()
-		 * returns NULL in find_active_uprobe().
+		 * is_trap_at_addr() true right after find_uprobe_rcu()
+		 * returns NULL in find_active_uprobe_rcu().
 		 */
 		mmap_write_lock(mm);
 		vma = find_vma(mm, info->vaddr);
@@ -1885,9 +1887,13 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 		return;
 	}
 
+	/* we need to bump refcount to store uprobe in utask */
+	if (!try_get_uprobe(uprobe))
+		return;
+
 	ri = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
 	if (!ri)
-		return;
+		goto fail;
 
 	trampoline_vaddr = uprobe_get_trampoline_vaddr();
 	orig_ret_vaddr = arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs);
@@ -1914,11 +1920,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 		}
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
-	/*
-	 * uprobe's refcnt is positive, held by caller, so it's safe to
-	 * unconditionally bump it one more time here
-	 */
-	ri->uprobe = get_uprobe(uprobe);
+	ri->uprobe = uprobe;
 	ri->func = instruction_pointer(regs);
 	ri->stack = user_stack_pointer(regs);
 	ri->orig_ret_vaddr = orig_ret_vaddr;
@@ -1929,8 +1931,9 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	utask->return_instances = ri;
 
 	return;
- fail:
+fail:
 	kfree(ri);
+	put_uprobe(uprobe);
 }
 
 /* Prepare to single-step probed instruction out of line. */
@@ -1945,9 +1948,14 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	if (!utask)
 		return -ENOMEM;
 
+	if (!try_get_uprobe(uprobe))
+		return -EINVAL;
+
 	xol_vaddr = xol_get_insn_slot(uprobe);
-	if (!xol_vaddr)
-		return -ENOMEM;
+	if (!xol_vaddr) {
+		err = -ENOMEM;
+		goto err_out;
+	}
 
 	utask->xol_vaddr = xol_vaddr;
 	utask->vaddr = bp_vaddr;
@@ -1955,12 +1963,15 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	err = arch_uprobe_pre_xol(&uprobe->arch, regs);
 	if (unlikely(err)) {
 		xol_free_insn_slot(current);
-		return err;
+		goto err_out;
 	}
 
 	utask->active_uprobe = uprobe;
 	utask->state = UTASK_SSTEP;
 	return 0;
+err_out:
+	put_uprobe(uprobe);
+	return err;
 }
 
 /*
@@ -2043,7 +2054,8 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	return is_trap_insn(&opcode);
 }
 
-static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
+/* assumes being inside RCU protected region */
+static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swbp)
 {
 	struct mm_struct *mm = current->mm;
 	struct uprobe *uprobe = NULL;
@@ -2056,7 +2068,7 @@ static struct uprobe *find_active_uprobe(unsigned long bp_vaddr, int *is_swbp)
 			struct inode *inode = file_inode(vma->vm_file);
 			loff_t offset = vaddr_to_offset(vma, bp_vaddr);
 
-			uprobe = find_uprobe(inode, offset);
+			uprobe = find_uprobe_rcu(inode, offset);
 		}
 
 		if (!uprobe)
@@ -2202,13 +2214,15 @@ static void handle_swbp(struct pt_regs *regs)
 {
 	struct uprobe *uprobe;
 	unsigned long bp_vaddr;
-	int is_swbp;
+	int is_swbp, srcu_idx;
 
 	bp_vaddr = uprobe_get_swbp_addr(regs);
 	if (bp_vaddr == uprobe_get_trampoline_vaddr())
 		return uprobe_handle_trampoline(regs);
 
-	uprobe = find_active_uprobe(bp_vaddr, &is_swbp);
+	srcu_idx = srcu_read_lock(&uprobes_srcu);
+
+	uprobe = find_active_uprobe_rcu(bp_vaddr, &is_swbp);
 	if (!uprobe) {
 		if (is_swbp > 0) {
 			/* No matching uprobe; signal SIGTRAP. */
@@ -2224,7 +2238,7 @@ static void handle_swbp(struct pt_regs *regs)
 			 */
 			instruction_pointer_set(regs, bp_vaddr);
 		}
-		return;
+		goto out;
 	}
 
 	/* change it in advance for ->handler() and restart */
@@ -2259,12 +2273,12 @@ static void handle_swbp(struct pt_regs *regs)
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 
-	if (!pre_ssout(uprobe, regs, bp_vaddr))
-		return;
+	if (pre_ssout(uprobe, regs, bp_vaddr))
+		goto out;
 
-	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
 out:
-	put_uprobe(uprobe);
+	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
+	srcu_read_unlock(&uprobes_srcu, srcu_idx);
 }
 
 /*
-- 
2.43.5


