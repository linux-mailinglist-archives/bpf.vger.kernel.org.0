Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEA2556F76
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 02:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiFWAcl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 20:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbiFWAck (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 20:32:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501FE41635
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 17:32:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so989741pjr.0
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 17:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ucyEHucarrsO8YiUMSd/dUDVTGwsVMH1bAyNaSQGLDU=;
        b=QuZkDvieHGiVTgq1UeX4M5a79u/SlEPdzfzjLDR8ZyaeqZ/00xE97+zYNZjfrNWs6W
         Dz/R7WVXJvGt5X6t5CnGwQ3T7PX95AYpUCM7gcRHs2sPX14faxR0sSF7aX1/l3IGlP8D
         xYlukeMFK0P2sErH/8BrPvz1paXenZuju7JWaYa98WXWMjoFnFQSO87hkvkNy51xB0tE
         PAjkdp/LCFpfnqAtaPh0SsYtNeW4Zp7LxLfG1RaArv6DOM/pgDFx+tPk3KjGM/wE8Spv
         zzr4hS0CtU2GLlC3xQg3lECbnN8WysqOY7/JBzSOewyDE4zMaC7EugcwiWp7iPJhDojJ
         UNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ucyEHucarrsO8YiUMSd/dUDVTGwsVMH1bAyNaSQGLDU=;
        b=0Varba7UHdxYmT0uYL4A8K8wOcG7hGo0EcCgN7OgUKCW1kRVsHNaGOMHtbMnE16kXF
         1/So+YUQhapG6JNPgOgZO7GiGHtwEk6zuf2ByST7YVgvtxkfRhHnc0tzmloO25i17791
         fL/Kn7/eTLz/yQPajjn92auqVqWlOVkb0Qswt6jYdR7DQ8Y3eth9xuhtb3te08xBehuI
         CPMa+nwPBREeQJBSvRXrbJ4IeHmHounhgF/d5RhFWg4aV+ri88C8WpLmtCURQnjLZq9k
         Wht56nvgzr1gBhsRALdOB3ZiXMNPSQ/ppq1YtsqzgJtGiJEnMQtTrFNJ8MLpNAxWg0sU
         /IWw==
X-Gm-Message-State: AJIora//QMGwlqquKi6an4DXaLtJpzUmWOR47kMar7932+40F8i8keur
        Efmclo/cv2sGgUOiFb2oSmsxPj2DtRQ=
X-Google-Smtp-Source: AGRyM1vTDd73BWdb8GSGlIQXMGr1biUbC40rBU/7eFay/JEPrmVjkCZyeRXkbQgFN/OHCHFsEO54wA==
X-Received: by 2002:a17:902:8e86:b0:168:d6d6:660f with SMTP id bg6-20020a1709028e8600b00168d6d6660fmr35766190plb.35.1655944358608;
        Wed, 22 Jun 2022 17:32:38 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:29cb])
        by smtp.gmail.com with ESMTPSA id j25-20020a62e919000000b0051baeb06c0bsm2545178pfh.168.2022.06.22.17.32.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jun 2022 17:32:38 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 1/5] bpf: Introduce any context BPF specific memory allocator.
Date:   Wed, 22 Jun 2022 17:32:26 -0700
Message-Id: <20220623003230.37497-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Tracing BPF programs can attach to kprobe and fentry. Hence they
run in unknown context where calling plain kmalloc() might not be safe.

Front-end kmalloc() with per-cpu per-bucket cache of free elements.
Refill this cache asynchronously from irq_work.

BPF programs always run with migration disabled.
It's safe to allocate from cache of the current cpu with irqs disabled.
Free-ing is always done into bucket of the current cpu as well.
irq_work trims extra free elements from buckets with kfree
and refills them with kmalloc, so global kmalloc logic takes care
of freeing objects allocated by one cpu and freed on another.

struct bpf_mem_alloc supports two modes:
- When size != 0 create kmem_cache and bpf_mem_cache for each cpu.
  This is typical bpf hash map use case when all elements have equal size.
- When size == 0 allocate 11 bpf_mem_cache-s for each cpu, then rely on
  kmalloc/kfree. Max allocation size is 4096 in this case.
  This is bpf_dynptr and bpf_kptr use case.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_mem_alloc.h |  26 ++
 kernel/bpf/Makefile           |   2 +-
 kernel/bpf/memalloc.c         | 512 ++++++++++++++++++++++++++++++++++
 3 files changed, 539 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/bpf_mem_alloc.h
 create mode 100644 kernel/bpf/memalloc.c

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
new file mode 100644
index 000000000000..804733070f8d
--- /dev/null
+++ b/include/linux/bpf_mem_alloc.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#ifndef _BPF_MEM_ALLOC_H
+#define _BPF_MEM_ALLOC_H
+#include <linux/compiler_types.h>
+
+struct bpf_mem_cache;
+struct bpf_mem_caches;
+
+struct bpf_mem_alloc {
+	struct bpf_mem_caches __percpu *caches;
+	struct bpf_mem_cache __percpu *cache;
+};
+
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size);
+void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
+
+/* kmalloc/kfree equivalent: */
+void *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size);
+void bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr);
+
+/* kmem_cache_alloc/free equivalent: */
+void *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma);
+void bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr);
+
+#endif /* _BPF_MEM_ALLOC_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 057ba8e01e70..11fb9220909b 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
-obj-$(CONFIG_BPF_SYSCALL) += btf.o
+obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o
 obj-$(CONFIG_BPF_JIT) += dispatcher.o
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_BPF_SYSCALL) += devmap.o
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
new file mode 100644
index 000000000000..01b041563fe1
--- /dev/null
+++ b/kernel/bpf/memalloc.c
@@ -0,0 +1,512 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include <linux/mm.h>
+#include <linux/llist.h>
+#include <linux/bpf.h>
+#include <linux/irq_work.h>
+#include <linux/bpf_mem_alloc.h>
+#include <linux/memcontrol.h>
+
+/* Any context (including NMI) BPF specific memory allocator.
+ *
+ * Tracing BPF programs can attach to kprobe and fentry. Hence they
+ * run in unknown context where calling plain kmalloc() might not be safe.
+ *
+ * Front-end kmalloc() with per-cpu per-bucket cache of free elements.
+ * Refill this cache asynchronously from irq_work.
+ *
+ * CPU_0 buckets
+ * 16 32 64 96 128 196 256 512 1024 2048 4096
+ * ...
+ * CPU_N buckets
+ * 16 32 64 96 128 196 256 512 1024 2048 4096
+ *
+ * The buckets are prefilled at the start.
+ * BPF programs always run with migration disabled.
+ * It's safe to allocate from cache of the current cpu with irqs disabled.
+ * Free-ing is always done into bucket of the current cpu as well.
+ * irq_work trims extra free elements from buckets with kfree
+ * and refills them with kmalloc, so global kmalloc logic takes care
+ * of freeing objects allocated by one cpu and freed on another.
+ *
+ * Every allocated objected is padded with extra 8 bytes that contains
+ * struct llist_node.
+ */
+
+/* similar to kmalloc, but sizeof == 8 bucket is gone */
+static u8 size_index[24] __ro_after_init = {
+	3,	/* 8 */
+	3,	/* 16 */
+	4,	/* 24 */
+	4,	/* 32 */
+	5,	/* 40 */
+	5,	/* 48 */
+	5,	/* 56 */
+	5,	/* 64 */
+	1,	/* 72 */
+	1,	/* 80 */
+	1,	/* 88 */
+	1,	/* 96 */
+	6,	/* 104 */
+	6,	/* 112 */
+	6,	/* 120 */
+	6,	/* 128 */
+	2,	/* 136 */
+	2,	/* 144 */
+	2,	/* 152 */
+	2,	/* 160 */
+	2,	/* 168 */
+	2,	/* 176 */
+	2,	/* 184 */
+	2	/* 192 */
+};
+
+static int bpf_mem_cache_idx(size_t size)
+{
+	if (size <= 192) {
+		if (!size)
+			return -1;
+
+		return size_index[(size - 1) / 8] - 1;
+	} else {
+		if (size > PAGE_SIZE)
+			return -1;
+
+		return fls(size - 1) - 1;
+	}
+}
+
+#define NUM_CACHES 11
+
+struct bpf_mem_cache {
+	/* per-cpu list of free objects of size 'unit_size'.
+	 * All accesses are done with preemption disabled
+	 * with __llist_add() and __llist_del_first().
+	 */
+	struct llist_head free_llist;
+
+	/* NMI only free list.
+	 * All accesses are NMI-safe llist_add() and llist_del_first().
+	 *
+	 * Each allocated object is either on free_llist or on free_llist_nmi.
+	 * One cpu can allocate it from NMI by doing llist_del_first() from
+	 * free_llist_nmi, while another might free it back from non-NMI by
+	 * doing llist_add() into free_llist.
+	 */
+	struct llist_head free_llist_nmi;
+	/* kmem_cache != NULL when bpf_mem_alloc was created for specific
+	 * element size.
+	 */
+	struct kmem_cache *kmem_cache;
+	struct irq_work refill_work;
+	struct mem_cgroup *memcg;
+	int unit_size;
+	/* count of objects in free_llist */
+	int free_cnt;
+	/* count of objects in free_llist_nmi */
+	atomic_t free_cnt_nmi;
+	/* flag to refill nmi list too */
+	bool refill_nmi_list;
+};
+
+struct bpf_mem_caches {
+	struct bpf_mem_cache cache[NUM_CACHES];
+};
+
+static struct llist_node notrace *__llist_del_first(struct llist_head *head)
+{
+	struct llist_node *entry, *next;
+
+	entry = head->first;
+	if (!entry)
+		return NULL;
+	next = entry->next;
+	head->first = next;
+	return entry;
+}
+
+#define BATCH 48
+#define LOW_WATERMARK 32
+#define HIGH_WATERMARK 96
+/* Assuming the average number of elements per bucket is 64, when all buckets
+ * are used the total memory will be: 64*16*32 + 64*32*32 + 64*64*32 + ... +
+ * 64*4096*32 ~ 20Mbyte
+ */
+
+/* extra macro useful for testing by randomizing in_nmi condition */
+#define bpf_in_nmi() in_nmi()
+
+static void *__alloc(struct bpf_mem_cache *c, int node)
+{
+	/* Allocate, but don't deplete atomic reserves that typical
+	 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
+	 * will allocate from the current numa node which is what we
+	 * want here.
+	 */
+	gfp_t flags = GFP_ATOMIC | __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_ACCOUNT;
+
+	if (c->kmem_cache)
+		return kmem_cache_alloc_node(c->kmem_cache, flags, node);
+
+	return kmalloc_node(c->unit_size, flags, node);
+}
+/* Mostly runs from irq_work except __init phase. */
+static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
+{
+	struct mem_cgroup *old_memcg;
+	unsigned long flags;
+	void *obj;
+	int i;
+
+	old_memcg = set_active_memcg(c->memcg);
+	for (i = 0; i < cnt; i++) {
+		obj = __alloc(c, node);
+		if (!obj)
+			break;
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			/* In RT irq_work runs in per-cpu kthread, so we have
+			 * to disable interrupts to avoid race with
+			 * bpf_mem_alloc/free. Note the read of free_cnt in
+			 * bpf_mem_refill is racy in RT. It's ok to do.
+			 */
+			local_irq_save(flags);
+		__llist_add(obj, &c->free_llist);
+		c->free_cnt++;
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_restore(flags);
+	}
+	set_active_memcg(old_memcg);
+}
+
+/* Refill NMI specific llist. Mostly runs from irq_work except __init phase. */
+static void alloc_bulk_nmi(struct bpf_mem_cache *c, int cnt, int node)
+{
+	struct mem_cgroup *old_memcg;
+	void *obj;
+	int i;
+
+	old_memcg = set_active_memcg(c->memcg);
+	for (i = 0; i < cnt; i++) {
+		obj = __alloc(c, node);
+		if (!obj)
+			break;
+		llist_add(obj, &c->free_llist_nmi);
+		atomic_inc(&c->free_cnt_nmi);
+	}
+	set_active_memcg(old_memcg);
+}
+
+static void __free(struct bpf_mem_cache *c, void *obj)
+{
+	if (c->kmem_cache)
+		kmem_cache_free(c->kmem_cache, obj);
+	else
+		kfree(obj);
+}
+
+static void free_bulk(struct bpf_mem_cache *c)
+{
+	struct llist_node *llnode;
+	unsigned long flags;
+	int cnt;
+
+	do {
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_save(flags);
+		llnode = __llist_del_first(&c->free_llist);
+		if (llnode)
+			cnt = --c->free_cnt;
+		else
+			cnt = 0;
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_restore(flags);
+		__free(c, llnode);
+	} while (cnt > (HIGH_WATERMARK + LOW_WATERMARK) / 2);
+}
+
+static void free_bulk_nmi(struct bpf_mem_cache *c)
+{
+	struct llist_node *llnode;
+	int cnt;
+
+	do {
+		llnode = llist_del_first(&c->free_llist_nmi);
+		if (llnode)
+			cnt = atomic_dec_return(&c->free_cnt_nmi);
+		else
+			cnt = 0;
+		__free(c, llnode);
+	} while (cnt > (HIGH_WATERMARK + LOW_WATERMARK) / 2);
+}
+
+static void bpf_mem_refill(struct irq_work *work)
+{
+	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work);
+	int cnt;
+
+	cnt = c->free_cnt;
+	if (cnt < LOW_WATERMARK)
+		/* irq_work runs on this cpu and kmalloc will allocate
+		 * from the current numa node which is what we want here.
+		 */
+		alloc_bulk(c, BATCH, NUMA_NO_NODE);
+	else if (cnt > HIGH_WATERMARK)
+		free_bulk(c);
+
+	if (!c->refill_nmi_list)
+		/* don't refill NMI specific freelist
+		 * until alloc/free from NMI.
+		 */
+		return;
+	cnt = atomic_read(&c->free_cnt_nmi);
+	if (cnt < LOW_WATERMARK)
+		alloc_bulk_nmi(c, BATCH, NUMA_NO_NODE);
+	else if (cnt > HIGH_WATERMARK)
+		free_bulk_nmi(c);
+	c->refill_nmi_list = false;
+}
+
+static void notrace irq_work_raise(struct bpf_mem_cache *c, bool in_nmi)
+{
+	c->refill_nmi_list = in_nmi;
+	irq_work_queue(&c->refill_work);
+}
+
+static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
+{
+	init_irq_work(&c->refill_work, bpf_mem_refill);
+	/* To avoid consuming memory assume that 1st run of bpf
+	 * prog won't be doing more than 4 map_update_elem from
+	 * irq disabled region
+	 */
+	alloc_bulk(c, c->unit_size < 256 ? 4 : 1, cpu_to_node(cpu));
+
+	/* NMI progs are rare. Assume they have one map_update
+	 * per prog at the very beginning.
+	 */
+	alloc_bulk_nmi(c, 1, cpu_to_node(cpu));
+}
+
+/* When size != 0 create kmem_cache and bpf_mem_cache for each cpu.
+ * This is typical bpf hash map use case when all elements have equal size.
+ *
+ * When size == 0 allocate 11 bpf_mem_cache-s for each cpu, then rely on
+ * kmalloc/kfree. Max allocation size is 4096 in this case.
+ * This is bpf_dynptr and bpf_kptr use case.
+ */
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
+{
+	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
+	struct bpf_mem_caches *cc, __percpu *pcc;
+	struct bpf_mem_cache *c, __percpu *pc;
+	struct kmem_cache *kmem_cache;
+	struct mem_cgroup *memcg;
+	char buf[32];
+	int cpu, i;
+
+	if (size) {
+		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
+		if (!pc)
+			return -ENOMEM;
+		size += 8; /* room for llist_node */
+		snprintf(buf, sizeof(buf), "bpf-%u", size);
+		kmem_cache = kmem_cache_create(buf, size, 8, 0, NULL);
+		if (!kmem_cache) {
+			free_percpu(pc);
+			return -ENOMEM;
+		}
+		memcg = get_mem_cgroup_from_mm(current->mm);
+		for_each_possible_cpu(cpu) {
+			c = per_cpu_ptr(pc, cpu);
+			c->kmem_cache = kmem_cache;
+			c->unit_size = size;
+			c->memcg = memcg;
+			prefill_mem_cache(c, cpu);
+		}
+		ma->cache = pc;
+		return 0;
+	}
+
+	pcc = __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL);
+	if (!pcc)
+		return -ENOMEM;
+	memcg = get_mem_cgroup_from_mm(current->mm);
+	for_each_possible_cpu(cpu) {
+		cc = per_cpu_ptr(pcc, cpu);
+		for (i = 0; i < NUM_CACHES; i++) {
+			c = &cc->cache[i];
+			c->unit_size = sizes[i];
+			c->memcg = memcg;
+			prefill_mem_cache(c, cpu);
+		}
+	}
+	ma->caches = pcc;
+	return 0;
+}
+
+static void drain_mem_cache(struct bpf_mem_cache *c)
+{
+	struct llist_node *llnode;
+
+	for (;;) {
+		llnode = llist_del_first(&c->free_llist_nmi);
+		if (!llnode)
+			break;
+		if (c->kmem_cache)
+			kmem_cache_free(c->kmem_cache, llnode);
+		else
+			kfree(llnode);
+	}
+	for (;;) {
+		llnode = __llist_del_first(&c->free_llist);
+		if (!llnode)
+			break;
+		if (c->kmem_cache)
+			kmem_cache_free(c->kmem_cache, llnode);
+		else
+			kfree(llnode);
+	}
+}
+
+void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
+{
+	struct bpf_mem_caches *cc;
+	struct bpf_mem_cache *c;
+	int cpu, i;
+
+	if (ma->cache) {
+		for_each_possible_cpu(cpu) {
+			c = per_cpu_ptr(ma->cache, cpu);
+			drain_mem_cache(c);
+		}
+		/* kmem_cache and memcg are the same across cpus */
+		kmem_cache_destroy(c->kmem_cache);
+		mem_cgroup_put(c->memcg);
+		free_percpu(ma->cache);
+		ma->cache = NULL;
+	}
+	if (ma->caches) {
+		for_each_possible_cpu(cpu) {
+			cc = per_cpu_ptr(ma->caches, cpu);
+			for (i = 0; i < NUM_CACHES; i++) {
+				c = &cc->cache[i];
+				drain_mem_cache(c);
+			}
+		}
+		mem_cgroup_put(c->memcg);
+		free_percpu(ma->caches);
+		ma->caches = NULL;
+	}
+}
+
+/* notrace is necessary here and in other functions to make sure
+ * bpf programs cannot attach to them and cause llist corruptions.
+ */
+static void notrace *unit_alloc(struct bpf_mem_cache *c)
+{
+	bool in_nmi = bpf_in_nmi();
+	struct llist_node *llnode;
+	unsigned long flags;
+	int cnt = 0;
+
+	if (unlikely(in_nmi)) {
+		llnode = llist_del_first(&c->free_llist_nmi);
+		if (llnode)
+			cnt = atomic_dec_return(&c->free_cnt_nmi);
+	} else {
+		/* Disable irqs to prevent the following race:
+		 * bpf_prog_A
+		 *   bpf_mem_alloc
+		 *      preemption or irq -> bpf_prog_B
+		 *        bpf_mem_alloc
+		 */
+		local_irq_save(flags);
+		llnode = __llist_del_first(&c->free_llist);
+		if (llnode)
+			cnt = --c->free_cnt;
+		local_irq_restore(flags);
+	}
+	WARN_ON(cnt < 0);
+
+	if (cnt < LOW_WATERMARK)
+		irq_work_raise(c, in_nmi);
+	return llnode;
+}
+
+/* Though 'ptr' object could have been allocated on a different cpu
+ * add it to the free_llist of the current cpu.
+ * Let kfree() logic deal with it when it's later called from irq_work.
+ */
+static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
+{
+	struct llist_node *llnode = ptr - 8;
+	bool in_nmi = bpf_in_nmi();
+	unsigned long flags;
+	int cnt;
+
+	BUILD_BUG_ON(sizeof(struct llist_node) > 8);
+
+	if (unlikely(in_nmi)) {
+		llist_add(llnode, &c->free_llist_nmi);
+		cnt = atomic_inc_return(&c->free_cnt_nmi);
+	} else {
+		local_irq_save(flags);
+		__llist_add(llnode, &c->free_llist);
+		cnt = ++c->free_cnt;
+		local_irq_restore(flags);
+	}
+	WARN_ON(cnt <= 0);
+
+	if (cnt > HIGH_WATERMARK)
+		/* free few objects from current cpu into global kmalloc pool */
+		irq_work_raise(c, in_nmi);
+}
+
+/* Called from BPF program or from sys_bpf syscall.
+ * In both cases migration is disabled.
+ */
+void notrace *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size)
+{
+	int idx;
+	void *ret;
+
+	if (!size)
+		return ZERO_SIZE_PTR;
+
+	idx = bpf_mem_cache_idx(size + 8);
+	if (idx < 0)
+		return NULL;
+
+	ret = unit_alloc(this_cpu_ptr(ma->caches)->cache + idx);
+	return !ret ? NULL : ret + 8;
+}
+
+void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
+{
+	int idx;
+
+	if (!ptr)
+		return;
+
+	idx = bpf_mem_cache_idx(__ksize(ptr - 8));
+	if (idx < 0)
+		return;
+
+	unit_free(this_cpu_ptr(ma->caches)->cache + idx, ptr);
+}
+
+void notrace *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma)
+{
+	void *ret;
+
+	ret = unit_alloc(this_cpu_ptr(ma->cache));
+	return !ret ? NULL : ret + 8;
+}
+
+void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
+{
+	if (!ptr)
+		return;
+
+	unit_free(this_cpu_ptr(ma->cache), ptr);
+}
-- 
2.30.2

