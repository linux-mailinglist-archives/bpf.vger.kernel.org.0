Return-Path: <bpf+bounces-37002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA3194FCC3
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 06:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386B31F237A9
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 04:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEAB13C3DD;
	Tue, 13 Aug 2024 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr7HBheG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745052374E;
	Tue, 13 Aug 2024 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523423; cv=none; b=tnMBquM39Pxb4xX/O+jdAeAgNEhsoLnBVwZ8YDYAspr1nc8Skpzd+zx7raGu7kYPpgvh4u/APrWe2lOoZ1+5aQt4BE4MTOXfVPdoLEg5fePeQkxf7JtPdVYwE5v1pUmiDc2BDqzlkV6IAtX7EZcO++9y+fPApcjVYWjT53dD7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523423; c=relaxed/simple;
	bh=gSE54BiJY1Pn94Uq6hz2zx0T4YWVk3mFY2vRRT7eELk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgo2j6OTSvmYftlLvSaE/fo05pSpdjz9Fmxm4vI89aPGZXM2ozJn4YZueNIPUP+6jWr/HBPIczT398pjCweWH7Z87os5m0i6rLJunGm4P3WWuXVherjIggUBph0+esWOLJCDARVeYXp5KXbyx6F37FG3xqo8ww+9IaM5ISNRuNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr7HBheG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD99FC4AF09;
	Tue, 13 Aug 2024 04:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723523423;
	bh=gSE54BiJY1Pn94Uq6hz2zx0T4YWVk3mFY2vRRT7eELk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tr7HBheG7ZVaxH5fDPNe9zvs9bISHt+ID/Fx9j140YrSfEHywcfelhc1Z7RuY/bsk
	 74BJkhS/NFMe5g1AKIgczJVWU3hHl3titiTkJO2DW0JesMP4jgP6a+TbdBuuXw2FQE
	 lonD4ojRh/qFsbknKwHa4JCCXnqO3bRNXEWC1OhPeti3PFddopMCTnnTv1eNSMkC9K
	 dtdCqz4umOkd8FzZkWAosT/JuZ/Skh/NO+ZJ00Sie2dfJ96wVNkhbZB7CZ/XgDcbg/
	 //k+fL/Yrt6qOqC+L/l+6MWX9siS1kS2UmNrG0VUqVHFqNtaCz0r6jKMZWPk8l9I3x
	 YAy9iDqTC4JEw==
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
Subject: [PATCH RFC v3 13/13] uprobes: add speculative lockless VMA to inode resolution
Date: Mon, 12 Aug 2024 21:29:17 -0700
Message-ID: <20240813042917.506057-14-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813042917.506057-1-andrii@kernel.org>
References: <20240813042917.506057-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that files_cachep is SLAB_TYPESAFE_BY_RCU, we can safely access
vma->vm_file->f_inode lockless only under rcu_read_lock() protection,
attempting uprobe look up speculatively.

We rely on newly added mmap_lock_speculation_{start,end}() helpers to
validate that mm_struct stays intact for entire duration of this
speculation. If not, we fall back to mmap_lock-protected lookup.

This allows to avoid contention on mmap_lock in absolutely majority of
cases, nicely improving uprobe/uretprobe scalability.

BEFORE
======
uprobe-nop            ( 1 cpus):    3.417 ± 0.013M/s  (  3.417M/s/cpu)
uprobe-nop            ( 2 cpus):    5.724 ± 0.006M/s  (  2.862M/s/cpu)
uprobe-nop            ( 3 cpus):    8.543 ± 0.012M/s  (  2.848M/s/cpu)
uprobe-nop            ( 4 cpus):   11.094 ± 0.004M/s  (  2.774M/s/cpu)
uprobe-nop            ( 5 cpus):   13.703 ± 0.006M/s  (  2.741M/s/cpu)
uprobe-nop            ( 6 cpus):   16.350 ± 0.010M/s  (  2.725M/s/cpu)
uprobe-nop            ( 7 cpus):   19.100 ± 0.031M/s  (  2.729M/s/cpu)
uprobe-nop            ( 8 cpus):   20.138 ± 0.029M/s  (  2.517M/s/cpu)
uprobe-nop            (10 cpus):   20.161 ± 0.020M/s  (  2.016M/s/cpu)
uprobe-nop            (12 cpus):   15.129 ± 0.011M/s  (  1.261M/s/cpu)
uprobe-nop            (14 cpus):   15.013 ± 0.013M/s  (  1.072M/s/cpu)
uprobe-nop            (16 cpus):   13.352 ± 0.007M/s  (  0.834M/s/cpu)
uprobe-nop            (24 cpus):   12.470 ± 0.005M/s  (  0.520M/s/cpu)
uprobe-nop            (32 cpus):   11.252 ± 0.042M/s  (  0.352M/s/cpu)
uprobe-nop            (40 cpus):   10.308 ± 0.001M/s  (  0.258M/s/cpu)
uprobe-nop            (48 cpus):   11.037 ± 0.007M/s  (  0.230M/s/cpu)
uprobe-nop            (56 cpus):   12.055 ± 0.002M/s  (  0.215M/s/cpu)
uprobe-nop            (64 cpus):   12.895 ± 0.004M/s  (  0.201M/s/cpu)
uprobe-nop            (72 cpus):   13.995 ± 0.005M/s  (  0.194M/s/cpu)
uprobe-nop            (80 cpus):   15.224 ± 0.030M/s  (  0.190M/s/cpu)

AFTER
=====
uprobe-nop            ( 1 cpus):    3.562 ± 0.006M/s  (  3.562M/s/cpu)
uprobe-nop            ( 2 cpus):    6.751 ± 0.007M/s  (  3.376M/s/cpu)
uprobe-nop            ( 3 cpus):   10.121 ± 0.007M/s  (  3.374M/s/cpu)
uprobe-nop            ( 4 cpus):   13.100 ± 0.007M/s  (  3.275M/s/cpu)
uprobe-nop            ( 5 cpus):   16.321 ± 0.008M/s  (  3.264M/s/cpu)
uprobe-nop            ( 6 cpus):   19.612 ± 0.004M/s  (  3.269M/s/cpu)
uprobe-nop            ( 7 cpus):   22.910 ± 0.037M/s  (  3.273M/s/cpu)
uprobe-nop            ( 8 cpus):   24.705 ± 0.011M/s  (  3.088M/s/cpu)
uprobe-nop            (10 cpus):   30.772 ± 0.020M/s  (  3.077M/s/cpu)
uprobe-nop            (12 cpus):   33.614 ± 0.009M/s  (  2.801M/s/cpu)
uprobe-nop            (14 cpus):   39.166 ± 0.004M/s  (  2.798M/s/cpu)
uprobe-nop            (16 cpus):   41.692 ± 0.014M/s  (  2.606M/s/cpu)
uprobe-nop            (24 cpus):   64.802 ± 0.048M/s  (  2.700M/s/cpu)
uprobe-nop            (32 cpus):   84.226 ± 0.223M/s  (  2.632M/s/cpu)
uprobe-nop            (40 cpus):  102.071 ± 0.067M/s  (  2.552M/s/cpu)
uprobe-nop            (48 cpus):  106.603 ± 1.198M/s  (  2.221M/s/cpu)
uprobe-nop            (56 cpus):  117.695 ± 0.059M/s  (  2.102M/s/cpu)
uprobe-nop            (64 cpus):  124.291 ± 0.485M/s  (  1.942M/s/cpu)
uprobe-nop            (72 cpus):  135.527 ± 0.134M/s  (  1.882M/s/cpu)
uprobe-nop            (80 cpus):  146.195 ± 0.230M/s  (  1.827M/s/cpu)

Previously total throughput was maxing out at 20mln/s with 8-10 cores,
declining afterwards. With this change, it now keeps growing with each
added CPU, reaching 146mln/s at 80 CPUs (this was measured on a 80-core
Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz).

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 713824c8ca77..12f3edf2ffb1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2286,6 +2286,53 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	return is_trap_insn(&opcode);
 }
 
+static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
+{
+	const vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
+	struct mm_struct *mm = current->mm;
+	struct uprobe *uprobe;
+	struct vm_area_struct *vma;
+	struct file *vm_file;
+	struct inode *vm_inode;
+	unsigned long vm_pgoff, vm_start;
+	int seq;
+	loff_t offset;
+
+	if (!mmap_lock_speculation_start(mm, &seq))
+		return NULL;
+
+	rcu_read_lock();
+
+	vma = vma_lookup(mm, bp_vaddr);
+	if (!vma)
+		goto bail;
+
+	vm_file = data_race(vma->vm_file);
+	if (!vm_file || (vma->vm_flags & flags) != VM_MAYEXEC)
+		goto bail;
+
+	vm_inode = data_race(vm_file->f_inode);
+	vm_pgoff = data_race(vma->vm_pgoff);
+	vm_start = data_race(vma->vm_start);
+
+	offset = (loff_t)(vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm_start);
+	uprobe = find_uprobe_rcu(vm_inode, offset);
+	if (!uprobe)
+		goto bail;
+
+	/* now double check that nothing about MM changed */
+	if (!mmap_lock_speculation_end(mm, seq))
+		goto bail;
+
+	rcu_read_unlock();
+
+	/* happy case, we speculated successfully */
+	return uprobe;
+bail:
+	rcu_read_unlock();
+	return NULL;
+}
+
 /* assumes being inside RCU protected region */
 static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swbp)
 {
@@ -2293,6 +2340,10 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb
 	struct uprobe *uprobe = NULL;
 	struct vm_area_struct *vma;
 
+	uprobe = find_active_uprobe_speculative(bp_vaddr);
+	if (uprobe)
+		return uprobe;
+
 	mmap_read_lock(mm);
 	vma = vma_lookup(mm, bp_vaddr);
 	if (vma) {
-- 
2.43.5


