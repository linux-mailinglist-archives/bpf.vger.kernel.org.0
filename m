Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEAB2BB6EF
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 21:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbgKTUa1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 15:30:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:10342 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730982AbgKTUaC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 15:30:02 -0500
IronPort-SDR: qNoiMpM0py60yXGsxFgMF2HEvEqkBlz2h5XHGkx2FGsdwOi6LEypv3c5d4eQ299JOZO/A0B9F5
 WKvtOEaWRghg==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="235683271"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="235683271"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:01 -0800
IronPort-SDR: dAe5oTws0poBfSLk4kjl9AcE0urnr2caDZLch0+CDP8DOUTygKloKA0cixjo5rjNeCqyOi9QHs
 0bCDmiUZNaQg==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="342163272"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.105.214])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 12:30:00 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org, jeyu@kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, luto@kernel.org,
        dave.hansen@linux.intel.com, peterz@infradead.org, x86@kernel.org,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Cc:     elena.reshetova@intel.com, ira.weiny@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 01/10] vmalloc: Add basic perm alloc implementation
Date:   Fri, 20 Nov 2020 12:24:17 -0800
Message-Id: <20201120202426.18009-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to allow for future arch specific optimizations for vmalloc
permissions, first add an implementation of a new interface that will
work cross arch by using the existing set_memory_() functions.

When allocating some memory that will be RO, for example it should be used
like:

/* Reserve va */
struct perm_allocation *alloc = perm_alloc(vstart, vend, page_cnt, PERM_R);
unsigned long ro = (unsigned long)perm_alloc_address(alloc);

/* Write to writable address */
strcpy((char *)perm_writable_addr(alloc, ro), "Some data to be RO");
/* Signal that writing is done and mapping should be live */
perm_writable_finish(alloc);
/* Print from RO address */
printk("Read only data is: %s\n", (char *)ro);

Create some new flags to handle the memory permissions currently defined
cross-architectually in the set_memory_() function names themselves. The
PAGE_ defines are not uniform across the architectures, so couldn't be used
without unifying them. However in the future there may also be some other
flags, for example requesting to try to allocate into part of a 2MB page
for longer lived allocations.

Have the default implementation use the primary address for loading the
data as is done today for special kernel permission usages. However, make
the interface compatible with having the writable data loaded at a
separate address or via some PKS backed solution. Allocate using
module_alloc() in the default implementation in order to allocate from
each arch's chosen place for executable code.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/Kconfig            |   3 +
 include/linux/vmalloc.h |  82 ++++++++++++++++++++++++
 mm/nommu.c              |  66 ++++++++++++++++++++
 mm/vmalloc.c            | 135 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 286 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..0fa42f76548d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -259,6 +259,9 @@ config ARCH_HAS_SET_MEMORY
 config ARCH_HAS_SET_DIRECT_MAP
 	bool
 
+config ARCH_HAS_PERM_ALLOC_IMPLEMENTATION
+	bool
+
 #
 # Select if the architecture provides the arch_dma_set_uncached symbol to
 # either provide an uncached segement alias for a DMA allocation, or
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 938eaf9517e2..4a6b30014fff 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -248,4 +248,86 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 int register_vmap_purge_notifier(struct notifier_block *nb);
 int unregister_vmap_purge_notifier(struct notifier_block *nb);
 
+#define PERM_R	1
+#define PERM_W	2
+#define PERM_X	4
+#define PERM_RWX	(PERM_R | PERM_W | PERM_X)
+#define PERM_RW		(PERM_R | PERM_W)
+#define PERM_RX		(PERM_R | PERM_X)
+
+typedef u8 virtual_perm;
+
+struct perm_allocation {
+	struct page **pages;
+	virtual_perm cur_perm;
+	virtual_perm orig_perm;
+	struct vm_struct *area;
+	unsigned long offset;
+	unsigned long size;
+	void *writable;
+};
+
+/*
+ * Allocate a special permission kva region. The region may not be mapped
+ * until a call to perm_writable_finish(). A writable region will be mapped
+ * immediately at the address returned by perm_writable_addr(). The allocation
+ * will be made between the start and end virtual addresses.
+ */
+struct perm_allocation *perm_alloc(unsigned long vstart, unsigned long vend, unsigned long page_cnt,
+				   virtual_perm perms);
+
+/* The writable address for data to be loaded into the allocation */
+unsigned long perm_writable_addr(struct perm_allocation *alloc, unsigned long addr);
+
+/* The writable address for data to be loaded into the allocation */
+bool perm_writable_finish(struct perm_allocation *alloc);
+
+/* Change the permission of an allocation that is already live */
+bool perm_change(struct perm_allocation *alloc, virtual_perm perms);
+
+/* Free an allocation */
+void perm_free(struct perm_allocation *alloc);
+
+/* Helper for memsetting an allocation. Should be called before perm_writable_finish() */
+void perm_memset(struct perm_allocation *alloc, char val);
+
+/* The final address of the allocation */
+static inline unsigned long perm_alloc_address(const struct perm_allocation *alloc)
+{
+	return (unsigned long)alloc->area->addr + alloc->offset;
+}
+
+/* The size of the allocation */
+static inline unsigned long perm_alloc_size(const struct perm_allocation *alloc)
+{
+	return alloc->size;
+}
+
+static inline unsigned long within_perm_alloc(const struct perm_allocation *alloc,
+					      unsigned long addr)
+{
+	unsigned long base, size;
+
+	if (!alloc)
+		return false;
+
+	base = perm_alloc_address(alloc);
+	size = perm_alloc_size(alloc);
+
+	return base <= addr && addr < base + size;
+}
+
+static inline unsigned long perm_writable_base(struct perm_allocation *alloc)
+{
+	return perm_writable_addr(alloc, perm_alloc_address(alloc));
+}
+
+static inline bool perm_is_writable(struct perm_allocation *alloc)
+{
+	if (!alloc)
+		return false;
+
+	return (alloc->cur_perm & PERM_W) || alloc->writable;
+}
+
 #endif /* _LINUX_VMALLOC_H */
diff --git a/mm/nommu.c b/mm/nommu.c
index 0faf39b32cdb..6458bd23de3e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1810,6 +1810,72 @@ int nommu_shrink_inode_mappings(struct inode *inode, size_t size,
 	return 0;
 }
 
+struct perm_allocation *perm_alloc(unsigned long vstart, unsigned long vend, unsigned long page_cnt,
+				   virtual_perm perms)
+{
+	struct perm_allocation *alloc;
+	struct vm_struct *area;
+	unsigned long size = page_cnt << PAGE_SHIFT;
+	void *ptr;
+
+	if (!size)
+		return NULL;
+
+	alloc = kmalloc(sizeof(*alloc), GFP_KERNEL | __GFP_ZERO);
+
+	if (!alloc)
+		return NULL;
+
+	area = kmalloc(sizeof(*area), GFP_KERNEL | __GFP_ZERO);
+
+	if (!area)
+		goto free_alloc;
+
+	alloc->area = area;
+
+	ptr = vmalloc(size);
+
+	if (!ptr)
+		goto free_area;
+
+	alloc->size = size;
+	alloc->cur_perm = PERM_RWX;
+
+	return alloc;
+
+free_area:
+	kfree(area);
+free_alloc:
+	kfree(alloc);
+	return NULL;
+}
+
+unsigned long perm_writable_addr(struct perm_allocation *alloc, unsigned long addr)
+{
+	return addr;
+}
+
+bool perm_writable_finish(struct perm_allocation *alloc)
+{
+	return true;
+}
+
+bool perm_change(struct perm_allocation *alloc, virtual_perm perms)
+{
+	return true;
+}
+
+void perm_free(struct perm_allocation *alloc)
+{
+	if (!alloc)
+		return;
+
+	kfree(alloc->area);
+	kfree(alloc);
+}
+
+void perm_memset(struct perm_allocation *alloc, char val) {}
+
 /*
  * Initialise sysctl_user_reserve_kbytes.
  *
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6ae491a8b210..3e8e54a75dfc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -34,6 +34,7 @@
 #include <linux/bitops.h>
 #include <linux/rbtree_augmented.h>
 #include <linux/overflow.h>
+#include <linux/moduleloader.h>
 
 #include <linux/uaccess.h>
 #include <asm/tlbflush.h>
@@ -3088,6 +3089,140 @@ void free_vm_area(struct vm_struct *area)
 }
 EXPORT_SYMBOL_GPL(free_vm_area);
 
+#ifndef CONFIG_ARCH_HAS_PERM_ALLOC_IMPLEMENTATION
+
+#ifndef CONFIG_MODULES
+/* If modules is not configured, provide stubs so perm_alloc() could use fallback logic. */
+void *module_alloc(unsigned long size)
+{
+	return NULL;
+}
+
+void module_memfree(void *module_region) { }
+#endif /* !CONFIG_MODULES */
+
+struct perm_allocation *perm_alloc(unsigned long vstart, unsigned long vend, unsigned long page_cnt,
+				   virtual_perm perms)
+{
+	struct perm_allocation *alloc;
+	unsigned long size = page_cnt << PAGE_SHIFT;
+	void *ptr;
+
+	if (!size)
+		return NULL;
+
+	alloc = kmalloc(sizeof(*alloc), GFP_KERNEL | __GFP_ZERO);
+
+	if (!alloc)
+		return NULL;
+
+	ptr = module_alloc(size);
+
+	if (!ptr) {
+		kfree(alloc);
+		return NULL;
+	}
+
+	/*
+	 * In order to work with all arch's we call the arch's module_alloc() which is the only
+	 * cross-arch place where information about where an executable allocation should go is
+	 * located. If the caller passed in a different range they want for the allocation...we
+	 * could try a vmalloc_node_range() at this point, but just return NULL for now.
+	 */
+	if ((unsigned long)ptr < vstart || (unsigned long)ptr >= vend) {
+		module_memfree(ptr);
+		kfree(alloc);
+		return NULL;
+	}
+
+	alloc->area = find_vm_area(ptr);
+	alloc->size = size;
+
+	if (IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_X86))
+		alloc->cur_perm = PERM_RW;
+	else
+		alloc->cur_perm = PERM_RWX;
+
+	alloc->orig_perm = perms;
+
+	return alloc;
+}
+
+unsigned long perm_writable_addr(struct perm_allocation *alloc, unsigned long addr)
+{
+	return addr;
+}
+
+bool perm_writable_finish(struct perm_allocation *alloc)
+{
+	if (!alloc)
+		return false;
+
+	return perm_change(alloc, alloc->orig_perm);
+}
+
+bool perm_change(struct perm_allocation *alloc, virtual_perm perm)
+{
+	unsigned long start, npages;
+	virtual_perm unset, set;
+
+	if (!alloc)
+		return false;
+
+	npages = alloc->size >> PAGE_SHIFT;
+
+	start = perm_alloc_address(alloc);
+
+	set = ~alloc->cur_perm & perm;
+	unset = alloc->cur_perm & ~perm;
+
+	if (set & PERM_W)
+		set_memory_rw(start, npages);
+
+	if (unset & PERM_W)
+		set_memory_ro(start, npages);
+
+	if (set & PERM_X)
+		set_memory_x(start, npages);
+
+	if (unset & PERM_X)
+		set_memory_nx(start, npages);
+
+	alloc->cur_perm = perm;
+
+	return false;
+}
+
+static inline bool perms_need_reset(struct perm_allocation *alloc)
+{
+	return (alloc->cur_perm & PERM_X) || (~alloc->cur_perm & PERM_W);
+}
+
+void perm_free(struct perm_allocation *alloc)
+{
+	unsigned long addr;
+
+	if (!alloc)
+		return;
+
+	addr = perm_alloc_address(alloc);
+
+	if (perms_need_reset(alloc))
+		set_vm_flush_reset_perms((void *)addr);
+
+	module_memfree((void *)addr);
+
+	kfree(alloc);
+}
+
+void perm_memset(struct perm_allocation *alloc, char val)
+{
+	if (!alloc)
+		return;
+	memset((void *)perm_writable_base(alloc), val, perm_alloc_size(alloc));
+}
+#endif /* CONFIG_ARCH_HAS_PERM_ALLOC_IMPLEMENTATION */
+
 #ifdef CONFIG_SMP
 static struct vmap_area *node_to_va(struct rb_node *n)
 {
-- 
2.20.1

