Return-Path: <bpf+bounces-72221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C30C0A5C7
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 11:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 003594E49B4
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F525C809;
	Sun, 26 Oct 2025 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsN4FOKC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA6825291B
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761472968; cv=none; b=OcVDxaZiIlwwyN60l65Hf9AK6VpsOiLBKWOYjVfXBISjX7ru/Y7xd5S7fOp50zNK2lpAuK9Nim3tf4zXUKHdTvxqRhUmzZgScvFYe8vy91UzY7QKMrQkgUDKcGHF/WaaUMN2QWi9maJlBpUUtQdaSnsJ9KWKHGFoRG841MJMDJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761472968; c=relaxed/simple;
	bh=K89A2yf5y5J06wTEETx0xDKzudBAi6MHlqwFz4ao8G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzhMzFYXUb44sN0ffflekWd+3EvKR7yTPOao0i5SyNgwJuNc00tci2F4JdMEgs5/nrM3GukTxfIEk81jGKijXxeEX8rL0cVfJBB4ZDw5HMa3Sdjbbeq/rD6V9qgNiupaeGkiIlSN1fX/OcksHGBN57Q1Yzlwm3bSr54tS7dbCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsN4FOKC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso3406484b3a.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761472966; x=1762077766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PF80wY+6f9zS/8Mmu7EkeRXBI6Ih5rRYihiNKAuvyqs=;
        b=LsN4FOKCX0yA5OvlE1nxJnYswGU1BudhGc1nU7ySxYeAO5plOG/R9fkb5Lh260sT1u
         Bfra6iCk0Z+B5zFgz0FA3LmgI3Ojd/P4m78Xp1g8BN9pQ8oPSxyvxBDvbJXDSvygtT1o
         qNE2vfOQtc+r7Odeca3DNQD9+SBET0g98wprjMtXCxXQ6uU+WHWHZ6qz2uEhXuH3jmfl
         Ge0yGVtw9PnmUfo+mEnGweifLxc7WoO6wEnbouLpZpJyEIuaJNi8aIZidh7Cg5FFTJvN
         qjxrypU+iZ66C+JnfuugwMWfIxVgmGZt2tRKYi7FcDvQCIxtsruL13XDhq5a7sJT2iNX
         Zs/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761472966; x=1762077766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PF80wY+6f9zS/8Mmu7EkeRXBI6Ih5rRYihiNKAuvyqs=;
        b=k0tqe7HZu7xe48/WV69bsUh3VeB5O0L5YuaNhhfyOWa8/1RFTT4X2709ccXmOfqhs3
         loBTzyxW8Pto0geVRJw1+SDCLkn3KTRno0FAeuxUVqw6g3Y17fl+c7pg1GqcQciASRV2
         Rs7lp2V9cFm4tw5YHPgLi/ORRUD+Ui89ol9iL7cLlYvp8taYVUTkz/VKigAvdrXBv2zp
         qmz+7EoLlVs6s5lF79+MpgqccCEqJOkNPaC3ZL7nGbc5TZwN3btPB5fqX0FbUiKlvIl+
         JDuANIeDS83CZSRGCveLRnc+eqrp88BuNjhvEDCm/OFM74skYTwbgGj606Lhbd7ioJk7
         G31Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPY0iZeQuYWkkajOqyCnCBvQH5mK6U2XYt+64KWl7XaEgsYeLPXfI/TjOMiuYgOssCX0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YypfEU3O9Iz1kNQBzsyuNtyuB10c5UPO0JkDSj3JD8Lvhs6rCh/
	6HfJvfIL9io2eUj/+LLwJHxkqcLRpHS7I3cByeBvJtLqM2SdtTaybJXr
X-Gm-Gg: ASbGncsiAu5rLDRtOee6mmOu2FQJojBfqs1noDk2uwvJ7cSUwolWGbyoWyg5pN3QBi+
	/uesvs4yOSJR1EwiVyDKWu0KBQmgyDr76lP0jiu/H/BrsMO3M2l4Xl2QCnrIWVsP9SPlO/rM/yv
	OHsqJsEVOpW5gzI0MgLIAX86ClAKwpnJZCFF101/Hn0kd4Z8EgurtTeB5eGbn1EJz5F2O3WJeD9
	itnkgvG+fl8i3RaVV66a8rcs5Qf4JZD7E9DprodBORtYUDXHktml1LDvfYClmyg3PozhDcx1UBG
	vfKaZHSUwxZsLIW6GKgeELgMjF7plrqZm2z3eO78tGJjD4rHHmpsiOIT7ysg6tJtF2oik/cQbA2
	Mj5RU9zJPmENKxTwAddS3FFTpR9q9rDEEMdMjNDOT41SS+YALVZfjX2DuMWFWCaDBbZ7xn7vkAK
	BpSdcAoZNPn88GGYhDIgTpEapxSQwdAJeK8z0=
X-Google-Smtp-Source: AGHT+IGp0Rjlq2zrhnxyc3J/CBOgBztHysuuoAmJfBv0zmIFKSuQwVknuGe3ZmxLHKU/iFYQ0vyqNQ==
X-Received: by 2002:a05:6a21:32a8:b0:33d:7c76:5d68 with SMTP id adf61e73a8af0-33deb36e3e0mr10084650637.46.1761472965257;
        Sun, 26 Oct 2025 03:02:45 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1a84:d:452e:d344:ffb:662b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm4824966a91.5.2025.10.26.03.02.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 03:02:44 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	ziy@nvidia.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org,
	clm@meta.com,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v12 mm-new 03/10] mm: thp: add support for BPF based THP order selection
Date: Sun, 26 Oct 2025 18:01:52 +0800
Message-Id: <20251026100159.6103-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251026100159.6103-1-laoar.shao@gmail.com>
References: <20251026100159.6103-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Motivation
==============

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

The BPF-THP Interface
=====================

The kernel API of this new BPF hook is as follows,

/**
 * thp_get_order: Get the suggested THP order from a BPF program for allocation
 * @vma: vm_area_struct associated with the THP allocation
 * @type: TVA type for current @vma
 * @orders: Bitmask of available THP orders for this allocation
 *
 * Return: The suggested THP order for allocation from the BPF program.
 *         Returns a negative value to preserve the original available @orders,
 *         which is useful in specific cases—for example, when only a particular
 *         @type is handled and others are ignored.
 */
int thp_get_order(struct vm_area_struct *vma,
		  enum tva_type type,
		  unsigned long orders);

This functionality is only active when system-wide THP is configured to
madvise or always mode. It remains disabled in never mode. Additionally,
if THP is explicitly disabled for a specific task via prctl(), this BPF
functionality will also be unavailable for that task.

The Design of Per Process BPF-THP
=================================

As suggested by Alexei, we need to scoping the BPF-THP [0].

Scoping BPF-THP to cgroup is not acceptible
-------------------------------------------

As explained by Gutierrez: [1]

1. It breaks the cgroup hierarchy when 2 siblings have different THP policies
2. Cgroup was designed for resource management not for grouping processes and
   une those processes
3. We set a precedent for other people adding new flags to cgroup and
   potentially polluting cgroups. We may end up with cgroups having tens of
   different flags, making sysadmin's job more complex

Scoping BPF-THP to process
--------------------------

To eliminate potential conflicts among competing BPF-THP instances, we
enforce that each process is exclusively managed by a single BPF-THP. This
approach has received agreement from David [2].

When registering a BPF-THP, we specify the PID of a target task. The
BPF-THP is then installed in the task's `mm_struct`

  struct mm_struct {
      struct bpf_thp_ops __rcu *thp_thp;
  };

Inheritance Behavior:

- Existing child processes are unaffected
- Newly forked children inherit the BPF-THP from their parent
- The BPF-THP persists across execve() calls

A new linked list tracks all tasks managed by each BPF-THP instance:

- Newly managed tasks are added to the list
- Exiting tasks are automatically removed from the list
- During BPF-THP unregistration (e.g., when the BPF link is removed), all
  managed tasks have their bpf_thp pointer set to NULL
- BPF-THP instances can be dynamically updated, with all tracked tasks
  automatically migrating to the new version.

This design simplifies BPF-THP management in production environments by
providing clear lifecycle management and preventing conflicts between
multiple BPF-THP instances.

WARNING
=======

This feature requires CONFIG_BPF_THP (EXPERIMENTAL) to be enabled. Note
that this capability is currently unstable and may undergo significant
changes—including potential removal—in future kernel versions.

Link: https://lore.kernel.org/linux-mm/CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com/ [0]
Link: https://lore.kernel.org/linux-mm/1940d681-94a6-48fb-b889-cd8f0b91b330@huawei-partners.com/ [1]
Link: https://lore.kernel.org/linux-mm/3577f7fd-429a-49c5-973b-38174a67be15@redhat.com/ [2]
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 MAINTAINERS              |   1 +
 fs/exec.c                |   1 +
 include/linux/huge_mm.h  |  39 +++++
 include/linux/mm_types.h |  17 +++
 kernel/fork.c            |   1 +
 mm/Kconfig               |  22 +++
 mm/Makefile              |   1 +
 mm/huge_memory_bpf.c     | 316 +++++++++++++++++++++++++++++++++++++++
 mm/mmap.c                |   1 +
 9 files changed, 399 insertions(+)
 create mode 100644 mm/huge_memory_bpf.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c1a1732df7b1..e8eeb7c89431 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16521,6 +16521,7 @@ F:	include/linux/huge_mm.h
 F:	include/linux/khugepaged.h
 F:	include/trace/events/huge_memory.h
 F:	mm/huge_memory.c
+F:	mm/huge_memory_bpf.c
 F:	mm/khugepaged.c
 F:	mm/mm_slot.h
 F:	tools/testing/selftests/mm/khugepaged.c
diff --git a/fs/exec.c b/fs/exec.c
index 6b70c6726d31..41d7703368e9 100644
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
index f73c72d58620..49050455f793 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -274,6 +274,40 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 enum tva_type type,
 					 unsigned long orders);
 
+#ifdef CONFIG_BPF_THP
+
+unsigned long
+bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type type,
+			unsigned long orders);
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
+static inline void bpf_thp_exit_mm(struct mm_struct *mm)
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
@@ -295,6 +329,11 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
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
index 5021047485a9..e0c89ca9f6f7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -983,6 +983,19 @@ struct mm_cid {
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
@@ -1280,6 +1293,10 @@ struct mm_struct {
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
index 3da0f08615a9..dc24f3d012df 100644
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
index a5a90b169435..12a2fbdc0909 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1457,6 +1457,28 @@ config PT_RECLAIM
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
index 000000000000..f69c5851ea61
--- /dev/null
+++ b/mm/huge_memory_bpf.c
@@ -0,0 +1,316 @@
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
+ * Return: The suggested THP order for allocation from the BPF program.
+ *         Returns a negative value to preserve the original available @orders,
+ *         which is useful in specific cases—for example, when only a particular
+ *         @type is handled and others are ignored.
+ */
+typedef int thp_order_fn_t(struct vm_area_struct *vma,
+			   enum tva_type type,
+			   unsigned long orders);
+
+struct bpf_thp_ops {
+	pid_t pid; /* The pid to attach */
+	thp_order_fn_t *thp_get_order;
+
+	/* private */
+	/* The list of mm_struct objects managed by this BPF-THP instance. */
+	struct list_head mm_list;
+};
+
+static DEFINE_SPINLOCK(thp_ops_lock);
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
+	if (bpf_order < 0)
+		goto out;
+	orders &= BIT(bpf_order);
+
+out:
+	rcu_read_unlock();
+	return orders;
+}
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
+	/* The new mm_struct is under initialization. */
+	RCU_INIT_POINTER(mm->bpf_mm.bpf_thp, bpf_thp);
+
+	/* The old mm_struct is being destroyed. */
+	RCU_INIT_POINTER(old_mm->bpf_mm.bpf_thp, NULL);
+	list_replace(&old_mm->bpf_mm.bpf_thp_list, &mm->bpf_mm.bpf_thp_list);
+	spin_unlock(&thp_ops_lock);
+}
+
+void bpf_thp_fork(struct mm_struct *mm, struct mm_struct *old_mm)
+{
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
+	/* The new mm_struct is under initialization. */
+	RCU_INIT_POINTER(mm->bpf_mm.bpf_thp, bpf_thp);
+
+	list_add_tail(&mm->bpf_mm.bpf_thp_list, &bpf_thp->mm_list);
+	spin_unlock(&thp_ops_lock);
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
+		/* bpf_struct_ops only handles func ptrs and zero-ed members.
+		 * Return 1 to bypass the default handler.
+		 */
+		kbpf_thp->pid = ubpf_thp->pid;
+		return 1;
+	}
+	return 0;
+}
+
+static int bpf_thp_reg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *bpf_thp = kdata;
+	struct list_head *mm_list;
+	struct task_struct *p;
+	struct mm_struct *mm;
+	int err = 0;
+	pid_t pid;
+
+	pid = bpf_thp->pid;
+	p = find_get_task_by_vpid(pid);
+	if (!p)
+		return -ESRCH;
+
+	if (p->flags & PF_EXITING) {
+		put_task_struct(p);
+		return -ESRCH;
+	}
+
+	mm = get_task_mm(p);
+	put_task_struct(p);
+	if (!mm)
+		return -EINVAL;
+
+	/* To prevent conflicts, use this lock when multiple BPF-THP instances
+	 * might register this task simultaneously.
+	 */
+	spin_lock(&thp_ops_lock);
+	/* Each process is exclusively managed by a single BPF-THP. */
+	if (rcu_access_pointer(mm->bpf_mm.bpf_thp)) {
+		err = -EBUSY;
+		goto out;
+	}
+	rcu_assign_pointer(mm->bpf_mm.bpf_thp, bpf_thp);
+
+	mm_list = &bpf_thp->mm_list;
+	INIT_LIST_HEAD(mm_list);
+	list_add_tail(&mm->bpf_mm.bpf_thp_list, mm_list);
+
+out:
+	spin_unlock(&thp_ops_lock);
+	mmput(mm);
+	return err;
+}
+
+static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *bpf_thp = kdata;
+	struct bpf_mm_ops *bpf_mm;
+	struct list_head *pos, *n;
+
+	spin_lock(&thp_ops_lock);
+	list_for_each_safe(pos, n, &bpf_thp->mm_list) {
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
+	INIT_LIST_HEAD(&bpf_thp->mm_list);
+
+	/* Could be optimized to a per-instance lock if this lock becomes a bottleneck. */
+	spin_lock(&thp_ops_lock);
+	list_for_each_safe(pos, n, &old_bpf_thp->mm_list) {
+		bpf_mm = list_entry(pos, struct bpf_mm_ops, bpf_thp_list);
+		WARN_ON_ONCE(!bpf_mm);
+		rcu_replace_pointer(bpf_mm->bpf_thp, bpf_thp, lockdep_is_held(&thp_ops_lock));
+		list_del(pos);
+		list_add_tail(&bpf_mm->bpf_thp_list, &bpf_thp->mm_list);
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
+	.thp_get_order = (thp_order_fn_t *)bpf_thp_get_order,
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
index 644f02071a41..cf811e6678e3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1841,6 +1841,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	vma_iter_free(&vmi);
 	if (!retval) {
 		mt_set_in_rcu(vmi.mas.tree);
+		bpf_thp_fork(mm, oldmm);
 		ksm_fork(mm, oldmm);
 		khugepaged_fork(mm, oldmm);
 	} else {
-- 
2.47.3


