Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0CB63B1CB
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 20:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiK1TDJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 28 Nov 2022 14:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiK1TDI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 14:03:08 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8203227FE9
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:03:06 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASI0pUn007778
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:03:05 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m3he61f4p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:03:05 -0800
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub203.TheFacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 11:03:04 -0800
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 11:03:03 -0800
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id B6AD91098034C; Mon, 28 Nov 2022 11:02:54 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <x86@kernel.org>,
        <peterz@infradead.org>, <hch@lst.de>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <mcgrof@kernel.org>, Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v5 1/6] vmalloc: introduce execmem_alloc, execmem_free, and execmem_fill
Date:   Mon, 28 Nov 2022 11:02:40 -0800
Message-ID: <20221128190245.2337461-2-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128190245.2337461-1-song@kernel.org>
References: <20221128190245.2337461-1-song@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9CVkp0yh_34DDFwgpzOwirxsWvA9Ni0p
X-Proofpoint-ORIG-GUID: 9CVkp0yh_34DDFwgpzOwirxsWvA9Ni0p
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_16,2022-11-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

execmem_alloc is used to allocate memory to host dynamic kernel text
(modules, BPF programs, etc.) with huge pages. This is similar to the
proposal by Peter in [1].

A new tree of vmap_area, free_text_area_* tree, is introduced in addition
to free_vmap_area_* and vmap_area_*. execmem_alloc allocates pages from
free_text_area_*. When there isn't enough space left in free_text_area_*,
new PMD_SIZE page(s) is allocated from free_vmap_area_* and added to
free_text_area_*. To be more accurate, the vmap_area is first added to
vmap_area_* tree and then moved to free_text_area_*. This extra move
simplifies the logic of execmem_alloc.

vmap_area in free_text_area_* tree are backed with memory, but we need
subtree_max_size for tree operations. Therefore, vm_struct for these
vmap_area are stored in a separate list, all_text_vm.

The new tree allows separate handling of < PAGE_SIZE allocations, as
current vmalloc code mostly assumes PAGE_SIZE aligned allocations. This
version of execmem_alloc can handle bpf programs, which uses 64 byte
aligned allocations), and modules, which uses PAGE_SIZE aligned
allocations.

Memory allocated by execmem_alloc() is set to RO+X before returning to the
caller. Therefore, the caller cannot write directly write to the memory.
Instead, the caller is required to use execmem_fill() to update the memory.
For the safety and security of X memory, execmem_fill() checks the data
being updated always in the memory allocated by one execmem_alloc() call.
execmem_fill() uses text_poke like mechanism and requires arch support.
Specifically, the arch need to implement arch_execmem_fill().

In execmem_free(), the memory is first erased with arch_invalidate_exec().
Then, the memory is added to free_text_area_*. If this free creates big
enough continuous free space (> PMD_SIZE), execmem_free() will try to free
the backing vm_struct.

Hopefully, this will be the first step towards a unified memory allocator
for memory with special permissions.

[1] https://lore.kernel.org/bpf/Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net/

Signed-off-by: Song Liu <song@kernel.org>
---
 include/linux/vmalloc.h |   5 +
 mm/nommu.c              |  12 ++
 mm/vmalloc.c            | 321 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 096d48aa3437..30aa8c187d40 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -154,6 +154,11 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
 		int node, const void *caller) __alloc_size(1);
 void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
+void *execmem_alloc(unsigned long size, unsigned long align) __alloc_size(1);
+void *execmem_fill(void *dst, void *src, size_t len);
+void execmem_free(void *addr);
+void *arch_fill_execmem(void *dst, void *src, size_t len);
+int arch_invalidate_execmem(void *ptr, size_t len);
 
 extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
 extern void *vmalloc_array(size_t n, size_t size) __alloc_size(1, 2);
diff --git a/mm/nommu.c b/mm/nommu.c
index 214c70e1d059..e3039fd4f65b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -371,6 +371,18 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 }
 EXPORT_SYMBOL(vm_map_pages_zero);
 
+void *execmem_alloc(unsigned long size, unsigned long align)
+{
+	return NULL;
+}
+
+void *execmem_fill(void *dst, void *src, size_t len)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+void execmem_free(const void *addr) { }
+
 /*
  *  sys_brk() for the most part doesn't need the global kernel
  *  lock, except when an application is doing something nasty
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ccaa461998f3..1f7f2134f9bd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -72,6 +72,11 @@ early_param("nohugevmalloc", set_nohugevmalloc);
 static const bool vmap_allow_huge = false;
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
 
+#ifndef PMD_ALIGN
+#define PMD_ALIGN(addr) ALIGN(addr, PMD_SIZE)
+#endif
+#define PMD_ALIGN_DOWN(addr) ALIGN_DOWN(addr, PMD_SIZE)
+
 bool is_vmalloc_addr(const void *x)
 {
 	unsigned long addr = (unsigned long)kasan_reset_tag(x);
@@ -769,6 +774,38 @@ static LIST_HEAD(free_vmap_area_list);
  */
 static struct rb_root free_vmap_area_root = RB_ROOT;
 
+/*
+ * free_text_area for execmem_alloc()
+ */
+static DEFINE_SPINLOCK(free_text_area_lock);
+/*
+ * This linked list is used in pair with free_text_area_root.
+ * It gives O(1) access to prev/next to perform fast coalescing.
+ */
+static LIST_HEAD(free_text_area_list);
+
+/*
+ * This augment red-black tree represents the free text space.
+ * All vmap_area objects in this tree are sorted by va->va_start
+ * address. It is used for allocation and merging when a vmap
+ * object is released.
+ *
+ * Each vmap_area node contains a maximum available free block
+ * of its sub-tree, right or left. Therefore it is possible to
+ * find a lowest match of free area.
+ *
+ * vmap_area in this tree are backed by RO+X memory, but they do
+ * not have valid vm pointer (because we need subtree_max_size).
+ * The vm for these vmap_area are stored in all_text_vm.
+ */
+static struct rb_root free_text_area_root = RB_ROOT;
+
+/*
+ * List of vm_struct for free_text_area_root. This list is rarely
+ * accessed, so the O(N) complexity is not likely a real issue.
+ */
+struct vm_struct *all_text_vm;
+
 /*
  * Preload a CPU with one object for "no edge" split case. The
  * aim is to get rid of allocations from the atomic context, thus
@@ -3313,6 +3350,290 @@ void *vmalloc(unsigned long size)
 }
 EXPORT_SYMBOL(vmalloc);
 
+#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
+#define EXEC_MEM_START MODULES_VADDR
+#define EXEC_MEM_END MODULES_END
+#else
+#define EXEC_MEM_START VMALLOC_START
+#define EXEC_MEM_END VMALLOC_END
+#endif
+
+static void move_vmap_to_free_text_tree(void *addr)
+{
+	struct vmap_area *va;
+
+	/* remove from vmap_area_root */
+	spin_lock(&vmap_area_lock);
+	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
+	if (WARN_ON_ONCE(!va)) {
+		spin_unlock(&vmap_area_lock);
+		return;
+	}
+	unlink_va(va, &vmap_area_root);
+	spin_unlock(&vmap_area_lock);
+
+	/* make the memory RO+X */
+	memset(addr, 0, va->va_end - va->va_start);
+	set_memory_ro(va->va_start, (va->va_end - va->va_start) >> PAGE_SHIFT);
+	set_memory_x(va->va_start, (va->va_end - va->va_start) >> PAGE_SHIFT);
+
+	spin_lock(&free_text_area_lock);
+	/* add to all_text_vm */
+	va->vm->next = all_text_vm;
+	all_text_vm = va->vm;
+
+	/* add to free_text_area_root */
+	merge_or_add_vmap_area_augment(va, &free_text_area_root, &free_text_area_list);
+	spin_unlock(&free_text_area_lock);
+}
+
+/**
+ * execmem_alloc - allocate virtually contiguous RO+X memory
+ * @size:    allocation size
+ * @align:   desired alignment
+ *
+ * This is used to allocate dynamic kernel text, such as module text, BPF
+ * programs, etc. User need to use text_poke to update the memory allocated
+ * by execmem_alloc.
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+void *execmem_alloc(unsigned long size, unsigned long align)
+{
+	struct vmap_area *va, *tmp;
+	unsigned long addr;
+	enum fit_type type;
+	int ret;
+
+	va = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, NUMA_NO_NODE);
+	if (unlikely(!va))
+		return NULL;
+
+again:
+	preload_this_cpu_lock(&free_text_area_lock, GFP_KERNEL, NUMA_NO_NODE);
+	tmp = find_vmap_lowest_match(&free_text_area_root, size, align, 1, false);
+
+	if (!tmp) {
+		unsigned long alloc_size;
+		void *ptr;
+
+		spin_unlock(&free_text_area_lock);
+
+		/*
+		 * Not enough continuous space in free_text_area_root, try
+		 * allocate more memory. The memory is first added to
+		 * vmap_area_root, and then moved to free_text_area_root.
+		 */
+		alloc_size = roundup(size, PMD_SIZE * num_online_nodes());
+		ptr = __vmalloc_node_range(alloc_size, PMD_SIZE, EXEC_MEM_START,
+					   EXEC_MEM_END, GFP_KERNEL, PAGE_KERNEL,
+					   VM_ALLOW_HUGE_VMAP | VM_NO_GUARD,
+					   NUMA_NO_NODE, __builtin_return_address(0));
+		if (unlikely(!ptr))
+			goto err_out;
+
+		move_vmap_to_free_text_tree(ptr);
+		goto again;
+	}
+
+	addr = roundup(tmp->va_start, align);
+	type = classify_va_fit_type(tmp, addr, size);
+
+	ret = adjust_va_to_fit_type(&free_text_area_root, &free_text_area_list,
+				    tmp, addr, size);
+	spin_unlock(&free_text_area_lock);
+	if (ret)
+		goto err_out;
+
+	va->va_start = addr;
+	va->va_end = addr + size;
+	va->vm = NULL;
+
+	spin_lock(&vmap_area_lock);
+	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
+	spin_unlock(&vmap_area_lock);
+
+	return (void *)addr;
+
+err_out:
+	kmem_cache_free(vmap_area_cachep, va);
+	return NULL;
+}
+
+void __weak *arch_fill_execmem(void *dst, void *src, size_t len)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+int __weak arch_invalidate_execmem(void *ptr, size_t len)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * execmem_fill - Copy text to RO+X memory allocated by execmem_alloc()
+ * @dst:  pointer to memory allocated by execmem_alloc()
+ * @src:  pointer to data being copied from
+ * @len:  number of bytes to be copied
+ *
+ * execmem_fill() will only update memory allocated by a single execmem_fill()
+ * call. If dst + len goes beyond the boundary of one allocation,
+ * execmem_fill() is aborted.
+ *
+ * If @addr is NULL, no operation is performed.
+ */
+void *execmem_fill(void *dst, void *src, size_t len)
+{
+	struct vmap_area *va;
+
+	spin_lock(&vmap_area_lock);
+	va = __find_vmap_area((unsigned long)dst, &vmap_area_root);
+
+	/*
+	 * If no va, or va has a vm attached, this memory is not allocated
+	 * by execmem_alloc().
+	 */
+	if (WARN_ON_ONCE(!va))
+		goto err_out;
+	if (WARN_ON_ONCE(va->vm))
+		goto err_out;
+
+	/* Disallow filling across execmem_alloc boundaries */
+	if (WARN_ON_ONCE((unsigned long)dst + len > va->va_end))
+		goto err_out;
+
+	spin_unlock(&vmap_area_lock);
+
+	return arch_fill_execmem(dst, src, len);
+
+err_out:
+	spin_unlock(&vmap_area_lock);
+	return ERR_PTR(-EINVAL);
+}
+
+static struct vm_struct *find_and_unlink_text_vm(unsigned long start, unsigned long end)
+{
+	struct vm_struct *vm, *prev_vm;
+
+	lockdep_assert_held(&free_text_area_lock);
+
+	vm = all_text_vm;
+	while (vm) {
+		unsigned long vm_addr = (unsigned long)vm->addr;
+
+		/* vm is within this free space, we can free it */
+		if ((vm_addr >= start) && ((vm_addr + vm->size) <= end))
+			goto unlink_vm;
+		vm = vm->next;
+	}
+	return NULL;
+
+unlink_vm:
+	if (all_text_vm == vm) {
+		all_text_vm = vm->next;
+	} else {
+		prev_vm = all_text_vm;
+		while (prev_vm->next != vm)
+			prev_vm = prev_vm->next;
+		prev_vm->next = vm->next;
+	}
+	return vm;
+}
+
+/**
+ * execmem_free - Release memory allocated by execmem_alloc()
+ * @addr:  Memory base address
+ *
+ * If @addr is NULL, no operation is performed.
+ */
+void execmem_free(void *addr)
+{
+	unsigned long free_start, free_end, free_addr;
+	struct vm_struct *vm;
+	struct vmap_area *va;
+
+	might_sleep();
+
+	if (!addr)
+		return;
+
+	spin_lock(&vmap_area_lock);
+	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
+	if (WARN_ON_ONCE(!va)) {
+		spin_unlock(&vmap_area_lock);
+		return;
+	}
+	WARN_ON_ONCE(va->vm);
+
+	unlink_va(va, &vmap_area_root);
+	spin_unlock(&vmap_area_lock);
+
+	/* Invalidate text in the region */
+	arch_invalidate_execmem(addr, va->va_end - va->va_start);
+
+	spin_lock(&free_text_area_lock);
+	va = merge_or_add_vmap_area_augment(va,
+		&free_text_area_root, &free_text_area_list);
+
+	if (WARN_ON_ONCE(!va))
+		goto out;
+
+	free_start = PMD_ALIGN(va->va_start);
+	free_end = PMD_ALIGN_DOWN(va->va_end);
+
+	/*
+	 * Only try to free vm when there is at least one PMD_SIZE free
+	 * continuous memory.
+	 */
+	if (free_start >= free_end)
+		goto out;
+
+	/*
+	 * TODO: It is possible that multiple vm are ready to be freed
+	 * after one execmem_free(). But we free at most one vm for now.
+	 */
+	vm = find_and_unlink_text_vm(free_start, free_end);
+	if (!vm)
+		goto out;
+
+	va = kmem_cache_alloc_node(vmap_area_cachep, GFP_ATOMIC, NUMA_NO_NODE);
+	if (unlikely(!va))
+		goto out_save_vm;
+
+	free_addr = __alloc_vmap_area(&free_text_area_root, &free_text_area_list,
+				      vm->size, 1, (unsigned long)vm->addr,
+				      (unsigned long)vm->addr + vm->size);
+
+	if (WARN_ON_ONCE(free_addr != (unsigned long)vm->addr))
+		goto out_save_vm;
+
+	va->va_start = (unsigned long)vm->addr;
+	va->va_end = va->va_start + vm->size;
+	va->vm = vm;
+	spin_unlock(&free_text_area_lock);
+
+	set_memory_nx(va->va_start, vm->size >> PAGE_SHIFT);
+	set_memory_rw(va->va_start, vm->size >> PAGE_SHIFT);
+
+	/* put the va to vmap_area_root, and then free it with vfree */
+	spin_lock(&vmap_area_lock);
+	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
+	spin_unlock(&vmap_area_lock);
+
+	vfree(vm->addr);
+	return;
+
+out_save_vm:
+	/*
+	 * vm is removed from all_text_vm, but not freed. Add it back,
+	 * so that we can use or free it later.
+	 */
+	vm->next = all_text_vm;
+	all_text_vm = vm;
+out:
+	spin_unlock(&free_text_area_lock);
+}
+
 /**
  * vmalloc_huge - allocate virtually contiguous memory, allow huge pages
  * @size:      allocation size
-- 
2.30.2

