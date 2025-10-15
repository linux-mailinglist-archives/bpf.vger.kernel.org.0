Return-Path: <bpf+bounces-71004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B98BDEF7B
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3710480A08
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0722641C6;
	Wed, 15 Oct 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia3QWWBN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93023FC49
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537880; cv=none; b=IncuNR38kBZrdaOYz/VyK+UsSU53QJnjkSZ5MKcyG+j+CObUin4tSFawGJ/7kg5MMEVEVcI4Js5qpXXNBqQo7L2M2Uu+5HSP4Uc8l16+xpipFZ6hE24UqBQLPbC9YJ4GXL0EY0E48nszEpOU92X188I9M8UPrpLHAEH1MMZ/D6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537880; c=relaxed/simple;
	bh=pC8uOHWSMt1hXt+Sh8GxekUGvDw0s7PG72UHJYWYOCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgcvtXKifRAE13QPR6GPpxPIhTwyPwaM0snBPcu9nS+GC4wciVrdPSZrmBWPUt+hASjD5nAWCvXboqa7VvVmsoPlXbcDIVWnfBmcwYPcJL2rti54TjaqMrsSBEerkMzJvzmr0UlPbX0K2OuAf/1Ai8UK0xvhPQWYfZFIXAaEFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia3QWWBN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so8501374a91.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537876; x=1761142676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7qP30YuscvXl/NsExNoZv6tgYV2hHaM3n9ZCz1kVmk=;
        b=Ia3QWWBNTVgxaOjEIoY7/AIaumQ+KNuBUHrINdrzxBbEweIx3MrVXU8x7tLathV0Vc
         2ZjObAhzGSkAsVgv5WOVTSxCj1J00+A1IBtvRZmB3acgE24VTQTDTGodrTUoG83qUF8H
         kkt2JGh9GsSsl+UbValU7JhAV3YrY93v1Yy6jk4NC19ziEW8YK36aFc8DoPkVWnegHW/
         2qzF95b6QBiI3K2JdRx/WtIWwo9Jm6qwpqF3e1qvH8ADaVLB+m+jp/qAm0+L1W99Srs+
         zqbi1sEsqOM9HdrfgP4d3xlWKfzFzV0Z+Vo+boF1iZ/vyoIRY7b21/cbEoQ0yLhOI+Va
         XAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537876; x=1761142676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7qP30YuscvXl/NsExNoZv6tgYV2hHaM3n9ZCz1kVmk=;
        b=rJz4pKtF1CVZMPEIMkI0JRQUq8rm3RV9oKJwYe3GRv1o2B6eO8F5ASdtWr/PHuaFRT
         FK9Bza6jf1ETztJz8kL1HIEzpMxhFV/h8rB92dht+a5nKqhC7dLAIjGFRZeBHmkpkwLS
         bwokagrZj0varuLRHrOOBgzAcM9JN8wwRECvYVhhwvB171VSwEMJsSDke1sAVTcpG0Yp
         XsNQnH72lqObojDcSsruvgEnXEOflmxQ2cvLCCWd1Y/dYsIUnMx4RotOM1G8L+zEM1Il
         8XEy3bU+qQ9NVEFq6HdQD+Yyw7HhV9o1Dp1k/sHUS2iSksE4/j5rIQGmOqjOdjTpdcs0
         fOdQ==
X-Gm-Message-State: AOJu0Yz626nWB8Ejyrj5H7lKSYvAZ4Bn5uSDB77um1ucJej3D8K+NvlH
	uC5+GqAHBz/wKBlFxykHPk3Hwlyhqbe1sk8B695nqZbIJylioVzjF410
X-Gm-Gg: ASbGncvz+lRchLjkXrMX3f1w1bi8l4VPA0F7FlWTXblOXZe9omRe7jqhE3tuSPrMJZC
	7t30UyFu52w+gu/vU4zqexa2Qr7/RMsZy2vNaDqzDBJg3bXuQ3XsI85gEgXfva5YpJNM3UPkgEL
	LQ4mLVfUQ12QX5qjdloy0Gugqn9xExmCQmEzJXwoSc2vTZeIyQ5VFQXqdn77ZJV+79lXPRfMEZr
	JHFeqxjh0Jw1FvqbXP3bOGWXozZuDIOQjeOQT5n1rA+79gEbPHdNroWEuG/rjvH7q2IMfuojrTN
	Sg7hr8LbKfOA8bay8G0YPqmRIdZFLmAHFFKXVlh2zUyAFvtTz6WPlHy5uJO8zOOAF+q03U9QuIq
	AMAQQfhkbGk0dBPzifBCMG2qFYI/3RMnbGS790nZh1SsDPQLQtTJhoSmhB1gZ/Pu0ggholb6jo7
	B7rp4evhv4riMHRA7P/nIck0ULZZw=
X-Google-Smtp-Source: AGHT+IEZicTnAISK8MJWpWR+oAxwLSGeKmpYRt6FsHplpjvtISrx8Sv7/ANXu99FGY43F4YolcV5hw==
X-Received: by 2002:a17:903:2405:b0:267:8049:7c7f with SMTP id d9443c01a7336-29027356377mr399915235ad.7.1760537876046;
        Wed, 15 Oct 2025 07:17:56 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1b80:80c6:cd21:3ff9:2bca:36d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f32d6fsm199561445ad.96.2025.10.15.07.17.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Oct 2025 07:17:55 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v10 mm-new 3/9] mm: thp: add support for BPF based THP order selection
Date: Wed, 15 Oct 2025 22:17:10 +0800
Message-Id: <20251015141716.887-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251015141716.887-1-laoar.shao@gmail.com>
References: <20251015141716.887-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
THP tuning. It includes a hook bpf_hook_thp_get_order(), allowing BPF
programs to influence THP order selection based on factors such as:
- Workload identity
  For example, workloads running in specific containers or cgroups.
- Allocation context
  Whether the allocation occurs during a page fault, khugepaged, swap or
  other paths.
- VMA's memory advice settings
  MADV_HUGEPAGE or MADV_NOHUGEPAGE
- Memory pressure
  PSI system data or associated cgroup PSI metrics

The kernel API of this new BPF hook is as follows,

/**
 * thp_order_fn_t: Get the suggested THP order from a BPF program for allocation
 * @vma: vm_area_struct associated with the THP allocation
 * @type: TVA type for current @vma
 * @orders: Bitmask of available THP orders for this allocation
 *
 * Return: The suggested THP order for allocation from the BPF program. Must be
 *         a valid, available order.
 */
typedef int thp_order_fn_t(struct vm_area_struct *vma,
			   enum tva_type type,
			   unsigned long orders);

Only a single BPF program can be attached at any given time, though it can
be dynamically updated to adjust the policy. The implementation supports
anonymous THP, shmem THP, and mTHP, with future extensions planned for
file-backed THP.

This functionality is only active when system-wide THP is configured to
madvise or always mode. It remains disabled in never mode. Additionally,
if THP is explicitly disabled for a specific task via prctl(), this BPF
functionality will also be unavailable for that task.

This BPF hook enables the implementation of flexible THP allocation
policies at the system, per-cgroup, or per-task level.

This feature requires CONFIG_BPF_THP (EXPERIMENTAL) to be enabled. Note
that this capability is currently unstable and may undergo significant
changes—including potential removal—in future kernel versions.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 MAINTAINERS              |   1 +
 fs/exec.c                |   1 +
 include/linux/huge_mm.h  |  40 +++++
 include/linux/mm_types.h |  18 +++
 kernel/fork.c            |   1 +
 mm/Kconfig               |  22 +++
 mm/Makefile              |   1 +
 mm/huge_memory_bpf.c     | 306 +++++++++++++++++++++++++++++++++++++++
 mm/mmap.c                |   1 +
 9 files changed, 391 insertions(+)
 create mode 100644 mm/huge_memory_bpf.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ca8e3d18eedd..7be34b2a64fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16257,6 +16257,7 @@ F:	include/linux/huge_mm.h
 F:	include/linux/khugepaged.h
 F:	include/trace/events/huge_memory.h
 F:	mm/huge_memory.c
+F:	mm/huge_memory_bpf.c
 F:	mm/khugepaged.c
 F:	mm/mm_slot.h
 F:	tools/testing/selftests/mm/khugepaged.c
diff --git a/fs/exec.c b/fs/exec.c
index dbac0e84cc3e..9500aafb7eb5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -890,6 +890,7 @@ static int exec_mmap(struct mm_struct *mm)
 	activate_mm(active_mm, mm);
 	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
+	bpf_thp_retain_mm(mm, old_mm);
 	lru_gen_add_mm(mm);
 	task_unlock(tsk);
 	lru_gen_use_mm(mm);
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a635dcbb2b99..5ecc95f35453 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -269,6 +269,41 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 enum tva_type type,
 					 unsigned long orders);
 
+#ifdef CONFIG_BPF_THP
+
+unsigned long
+bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type type,
+			unsigned long orders);
+
+void bpf_thp_exit_mm(struct mm_struct *mm);
+void bpf_thp_retain_mm(struct mm_struct *mm, struct mm_struct *old_mm);
+void bpf_thp_fork(struct mm_struct *mm, struct mm_struct *old_mm);
+
+#else
+
+static inline unsigned long
+bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type type,
+			unsigned long orders)
+{
+	return orders;
+}
+
+static inline void bpf_thp_ops_exit(struct mm_struct *mm)
+{
+}
+
+static inline void
+bpf_thp_retain_mm(struct mm_struct *mm, struct mm_struct *old_mm)
+{
+}
+
+static inline void
+bpf_thp_fork(struct mm_struct *mm, struct mm_struct *old_mm)
+{
+}
+
+#endif
+
 /**
  * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
  * @vma:  the vm area to check
@@ -290,6 +325,11 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 {
 	vm_flags_t vm_flags = vma->vm_flags;
 
+	/* The BPF-specified order overrides which order is selected. */
+	orders &= bpf_hook_thp_get_orders(vma, type, orders);
+	if (!orders)
+		return 0;
+
 	/*
 	 * Optimization to check if required orders are enabled early. Only
 	 * forced collapse ignores sysfs configs.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 394d50fd3c65..835fbfdf7657 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -33,6 +33,7 @@
 struct address_space;
 struct futex_private_hash;
 struct mem_cgroup;
+struct bpf_mm_ops;
 
 typedef struct {
 	unsigned long f;
@@ -976,6 +977,19 @@ struct mm_cid {
 };
 #endif
 
+#ifdef CONFIG_BPF_THP
+struct bpf_thp_ops;
+#endif
+
+#ifdef CONFIG_BPF_MM
+struct bpf_mm_ops {
+#ifdef CONFIG_BPF_THP
+	struct bpf_thp_ops __rcu *bpf_thp;
+	struct list_head bpf_thp_list;
+#endif
+};
+#endif
+
 /*
  * Opaque type representing current mm_struct flag state. Must be accessed via
  * mm_flags_xxx() helper functions.
@@ -1268,6 +1282,10 @@ struct mm_struct {
 #ifdef CONFIG_MM_ID
 		mm_id_t mm_id;
 #endif /* CONFIG_MM_ID */
+
+#ifdef CONFIG_BPF_MM
+		struct bpf_mm_ops bpf_mm;
+#endif
 	} __randomize_layout;
 
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index 157612fd669a..6b7d56ecb19a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1130,6 +1130,7 @@ static inline void __mmput(struct mm_struct *mm)
 	exit_aio(mm);
 	ksm_exit(mm);
 	khugepaged_exit(mm); /* must run before exit_mmap */
+	bpf_thp_exit_mm(mm);
 	exit_mmap(mm);
 	mm_put_huge_zero_folio(mm);
 	set_mm_exe_file(mm, NULL);
diff --git a/mm/Kconfig b/mm/Kconfig
index bde9f842a4a8..18a83c0cbb51 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1371,6 +1371,28 @@ config PT_RECLAIM
 config FIND_NORMAL_PAGE
 	def_bool n
 
+menuconfig BPF_MM
+	bool "BPF-based Memory Management (EXPERIMENTAL)"
+	depends on BPF_SYSCALL
+
+	help
+	  Enable BPF-based Memory Management Policy. This feature is currently
+	  experimental.
+
+	  WARNING: This feature is unstable and may change in future kernel
+
+if BPF_MM
+config BPF_THP
+	bool "BPF-based THP Policy (EXPERIMENTAL)"
+	depends on TRANSPARENT_HUGEPAGE && BPF_MM
+
+	help
+	  Enable dynamic THP policy adjustment using BPF programs. This feature
+	  is currently experimental.
+
+	  WARNING: This feature is unstable and may change in future kernel
+endif # BPF_MM
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 21abb3353550..4efca1c8a919 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
+obj-$(CONFIG_BPF_THP) += huge_memory_bpf.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
new file mode 100644
index 000000000000..24ab432cbbaa
--- /dev/null
+++ b/mm/huge_memory_bpf.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF-based THP policy management
+ *
+ * Author: Yafang Shao <laoar.shao@gmail.com>
+ */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/huge_mm.h>
+#include <linux/khugepaged.h>
+
+/**
+ * @thp_order_fn_t: Get the suggested THP order from a BPF program for allocation
+ * @vma: vm_area_struct associated with the THP allocation
+ * @type: TVA type for current @vma
+ * @orders: Bitmask of available THP orders for this allocation
+ *
+ * Return: The suggested THP order for allocation from the BPF program. Must be
+ *         a valid, available order.
+ */
+typedef int thp_order_fn_t(struct vm_area_struct *vma,
+			   enum tva_type type,
+			   unsigned long orders);
+
+struct bpf_thp_mm_list {
+	struct list_head list;
+};
+
+struct bpf_thp_ops {
+	pid_t pid; /* The pid to attach */
+	thp_order_fn_t *thp_get_order;
+
+	/* private*/
+	/* The list of mm_struct this ops is operated on */
+	struct bpf_thp_mm_list mm_list;
+};
+
+static DEFINE_SPINLOCK(thp_ops_lock);
+
+void bpf_thp_exit_mm(struct mm_struct *mm)
+{
+	if (!rcu_access_pointer(mm->bpf_mm.bpf_thp))
+		return;
+
+	spin_lock(&thp_ops_lock);
+	if (!rcu_access_pointer(mm->bpf_mm.bpf_thp)) {
+		spin_unlock(&thp_ops_lock);
+		return;
+	}
+	list_del(&mm->bpf_mm.bpf_thp_list);
+	RCU_INIT_POINTER(mm->bpf_mm.bpf_thp, NULL);
+	spin_unlock(&thp_ops_lock);
+
+}
+
+void bpf_thp_retain_mm(struct mm_struct *mm, struct mm_struct *old_mm)
+{
+	struct bpf_thp_ops *bpf_thp;
+
+	if (!old_mm || !rcu_access_pointer(old_mm->bpf_mm.bpf_thp))
+		return;
+
+	spin_lock(&thp_ops_lock);
+	bpf_thp = rcu_dereference_protected(old_mm->bpf_mm.bpf_thp,
+					    lockdep_is_held(&thp_ops_lock));
+	if (!bpf_thp) {
+		spin_unlock(&thp_ops_lock);
+		return;
+	}
+
+	/* The new mm is still under initilization */
+	RCU_INIT_POINTER(mm->bpf_mm.bpf_thp, bpf_thp);
+
+	/* The old mm is destroying */
+	RCU_INIT_POINTER(old_mm->bpf_mm.bpf_thp, NULL);
+	list_replace(&old_mm->bpf_mm.bpf_thp_list, &mm->bpf_mm.bpf_thp_list);
+	spin_unlock(&thp_ops_lock);
+}
+
+void bpf_thp_fork(struct mm_struct *mm, struct mm_struct *old_mm)
+{
+	struct bpf_thp_mm_list *mm_list;
+	struct bpf_thp_ops *bpf_thp;
+
+	if (!rcu_access_pointer(old_mm->bpf_mm.bpf_thp))
+		return;
+
+	spin_lock(&thp_ops_lock);
+	bpf_thp = rcu_dereference_protected(old_mm->bpf_mm.bpf_thp,
+					    lockdep_is_held(&thp_ops_lock));
+	if (!bpf_thp) {
+		spin_unlock(&thp_ops_lock);
+		return;
+	}
+
+	/* The new mm is still under initilization */
+	RCU_INIT_POINTER(mm->bpf_mm.bpf_thp, bpf_thp);
+
+	mm_list = &bpf_thp->mm_list;
+	list_add_tail(&mm->bpf_mm.bpf_thp_list, &mm_list->list);
+	spin_unlock(&thp_ops_lock);
+}
+
+unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
+				      enum tva_type type,
+				      unsigned long orders)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct bpf_thp_ops *bpf_thp;
+	int bpf_order;
+
+	if (!mm)
+		return orders;
+
+	rcu_read_lock();
+	bpf_thp = rcu_dereference(mm->bpf_mm.bpf_thp);
+	if (!bpf_thp || !bpf_thp->thp_get_order)
+		goto out;
+
+	bpf_order = bpf_thp->thp_get_order(vma, type, orders);
+	orders &= BIT(bpf_order);
+
+out:
+	rcu_read_unlock();
+	return orders;
+}
+
+static bool bpf_thp_ops_is_valid_access(int off, int size,
+					enum bpf_access_type type,
+					const struct bpf_prog *prog,
+					struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static const struct bpf_func_proto *
+bpf_thp_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return bpf_base_func_proto(func_id, prog);
+}
+
+static const struct bpf_verifier_ops thp_bpf_verifier_ops = {
+	.get_func_proto = bpf_thp_get_func_proto,
+	.is_valid_access = bpf_thp_ops_is_valid_access,
+};
+
+static int bpf_thp_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int bpf_thp_check_member(const struct btf_type *t,
+				const struct btf_member *member,
+				const struct bpf_prog *prog)
+{
+	/* The call site operates under RCU protection. */
+	if (prog->sleepable)
+		return -EINVAL;
+	return 0;
+}
+
+static int bpf_thp_init_member(const struct btf_type *t,
+			       const struct btf_member *member,
+			       void *kdata, const void *udata)
+{
+	const struct bpf_thp_ops *ubpf_thp;
+	struct bpf_thp_ops *kbpf_thp;
+	u32 moff;
+
+	ubpf_thp = (const struct bpf_thp_ops *)udata;
+	kbpf_thp = (struct bpf_thp_ops *)kdata;
+
+	moff = __btf_member_bit_offset(t, member) / 8;
+	switch (moff) {
+	case offsetof(struct bpf_thp_ops, pid):
+		kbpf_thp->pid = ubpf_thp->pid;
+		return 1;
+	}
+	return 0;
+}
+
+static int bpf_thp_reg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *bpf_thp = kdata;
+	struct bpf_thp_mm_list *mm_list;
+	struct task_struct *p;
+	struct mm_struct *mm;
+	int err = -EINVAL;
+	pid_t pid;
+
+	pid = bpf_thp->pid;
+	p = find_get_task_by_vpid(pid);
+	if (!p || p->flags & PF_EXITING)
+		return -EINVAL;
+
+	mm = get_task_mm(p);
+	put_task_struct(p);
+	if (!mm)
+		goto out;
+
+	err = -EBUSY;
+	spin_lock(&thp_ops_lock);
+	if (rcu_access_pointer(mm->bpf_mm.bpf_thp))
+		goto out_lock;
+	err = 0;
+	rcu_assign_pointer(mm->bpf_mm.bpf_thp, bpf_thp);
+
+	mm_list = &bpf_thp->mm_list;
+	INIT_LIST_HEAD(&mm_list->list);
+	list_add_tail(&mm->bpf_mm.bpf_thp_list, &mm_list->list);
+out_lock:
+	spin_unlock(&thp_ops_lock);
+out:
+	mmput(mm);
+	return err;
+}
+
+
+static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *bpf_thp = kdata;
+	struct bpf_mm_ops *bpf_mm;
+	struct list_head *pos, *n;
+
+	spin_lock(&thp_ops_lock);
+	list_for_each_safe(pos, n, &bpf_thp->mm_list.list) {
+		bpf_mm = list_entry(pos, struct bpf_mm_ops, bpf_thp_list);
+		WARN_ON_ONCE(!bpf_mm);
+		rcu_replace_pointer(bpf_mm->bpf_thp, NULL, lockdep_is_held(&thp_ops_lock));
+		list_del(pos);
+	}
+	spin_unlock(&thp_ops_lock);
+
+	synchronize_rcu();
+}
+
+static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *old_bpf_thp = old_kdata;
+	struct bpf_thp_ops *bpf_thp = kdata;
+	struct bpf_mm_ops *bpf_mm;
+	struct list_head *pos, *n;
+
+	INIT_LIST_HEAD(&bpf_thp->mm_list.list);
+
+	spin_lock(&thp_ops_lock);
+	list_for_each_safe(pos, n, &old_bpf_thp->mm_list.list) {
+		bpf_mm = list_entry(pos, struct bpf_mm_ops, bpf_thp_list);
+		WARN_ON_ONCE(!bpf_mm);
+		rcu_replace_pointer(bpf_mm->bpf_thp, bpf_thp, lockdep_is_held(&thp_ops_lock));
+		list_del(pos);
+		list_add_tail(&bpf_mm->bpf_thp_list, &bpf_thp->mm_list.list);
+	}
+	spin_unlock(&thp_ops_lock);
+
+	synchronize_rcu();
+	return 0;
+}
+
+static int bpf_thp_validate(void *kdata)
+{
+	struct bpf_thp_ops *ops = kdata;
+
+	if (!ops->thp_get_order) {
+		pr_err("bpf_thp: required ops isn't implemented\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int bpf_thp_get_order(struct vm_area_struct *vma,
+			     enum tva_type type,
+			     unsigned long orders)
+{
+	return -1;
+}
+
+static struct bpf_thp_ops __bpf_thp_ops = {
+	.thp_get_order = (thp_order_fn_t __rcu *)bpf_thp_get_order,
+};
+
+static struct bpf_struct_ops bpf_bpf_thp_ops = {
+	.verifier_ops = &thp_bpf_verifier_ops,
+	.init = bpf_thp_init,
+	.check_member = bpf_thp_check_member,
+	.init_member = bpf_thp_init_member,
+	.reg = bpf_thp_reg,
+	.unreg = bpf_thp_unreg,
+	.update = bpf_thp_update,
+	.validate = bpf_thp_validate,
+	.cfi_stubs = &__bpf_thp_ops,
+	.owner = THIS_MODULE,
+	.name = "bpf_thp_ops",
+};
+
+static int __init bpf_thp_ops_init(void)
+{
+	int err;
+
+	err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
+	if (err)
+		pr_err("bpf_thp: Failed to register struct_ops (%d)\n", err);
+	return err;
+}
+late_initcall(bpf_thp_ops_init);
diff --git a/mm/mmap.c b/mm/mmap.c
index 5fd3b80fda1d..8ac7d3046a33 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1844,6 +1844,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	vma_iter_free(&vmi);
 	if (!retval) {
 		mt_set_in_rcu(vmi.mas.tree);
+		bpf_thp_fork(mm, oldmm);
 		ksm_fork(mm, oldmm);
 		khugepaged_fork(mm, oldmm);
 	} else {
-- 
2.47.3


