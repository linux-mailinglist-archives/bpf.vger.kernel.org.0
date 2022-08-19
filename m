Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7B559A7E8
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiHSVmm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiHSVml (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:42:41 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D454710DCD5
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:42:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso5996098pjh.5
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OQXqiUxNIBJPJkPe9vcnoPlbU6j/NURphb+zCMrcKUQ=;
        b=czlS2WS/uyJQoPDdAdGWM0CyRxPkm/xGFh/8e+CLsGdAvIcrJtwFA3bMbBfjc4gY24
         lBTZLLlSqabzkyUQ5ImV/a+7xR3rHSqIUKDpFrp05IPKh06lWhTSQ8U7VPaeJhua55BB
         DqyT44C5vumOrT+DXqg2jKWsHtv8gGwkqzDYs58EbhE4Rht+CQa2QXdbrtaEgTgBF66R
         17MIUXraC3UJqEzfZ8ihpULDS/szMCT8drs56ixUSDV3qxpLjtd2uQ09UwEZtut8qEJ/
         vRJ6Uixk50YDiC8Q8UdoB6Cx+mt7/IQYeTlDDOrhp9CAs6+S/3aVdjCYHTuUFMY3GMtt
         fEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OQXqiUxNIBJPJkPe9vcnoPlbU6j/NURphb+zCMrcKUQ=;
        b=ZuniJw3HId4mRrhFYmv9MKUsTvV4rJaSx21b/Wi2cq2Z9kGMHNZyIpVF1yNeK1N8tM
         KaLFFYI+6ONqQIVBNL24H/W4gpgcyplg2/c2pZuEJVqpEKt7JdA+rogDYq+10ZbJKpA/
         qe2vgXVJddtwhK/OPsHBbfUvW8p28CtM2Yyw5SZaqqoNIeNgbgCwvyTJnItNT0UqdZza
         MQQaHLUjCnukH8VdV5s0cOlrGjLPHY57pIZADNIccpT/OLTDI+9iBOp4frLzXQpCatwV
         u3ZWJjoHDsvGB6kBOK3WbNbCmCFR2SH+jwF3lXpwsQfg4ffwht8mnee5bzx/ehkPAeFW
         Elzg==
X-Gm-Message-State: ACgBeo10vOs4hkK79kO0CD2AaeqW73g13e4KLCZKUVElZ3FmrSxtgva+
        i+YDT5cOI6gHBmGb6qCbVuk=
X-Google-Smtp-Source: AA6agR7uoRHU61BYT/sgTXPA7dsJ2V9wEGH8GUVA2WMJHIXwumZxy/1mHl0EGJm9Q1qojwtaGT5+Tg==
X-Received: by 2002:a17:902:b186:b0:172:728a:3636 with SMTP id s6-20020a170902b18600b00172728a3636mr9443310plr.14.1660945359180;
        Fri, 19 Aug 2022 14:42:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id y14-20020aa79aee000000b00534bb955b36sm892810pfp.29.2022.08.19.14.42.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:42:38 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 01/15] bpf: Introduce any context BPF specific memory allocator.
Date:   Fri, 19 Aug 2022 14:42:18 -0700
Message-Id: <20220819214232.18784-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
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

Front-end kmalloc() with minimal per-cpu cache of free elements.
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

bpf_mem_alloc/bpf_mem_free are bpf specific 'wrappers' of kmalloc/kfree.
bpf_mem_cache_alloc/bpf_mem_cache_free are 'wrappers' of kmem_cache_alloc/kmem_cache_free.

The allocators are NMI-safe from bpf programs only. They are not NMI-safe in general.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_mem_alloc.h |  26 ++
 kernel/bpf/Makefile           |   2 +-
 kernel/bpf/memalloc.c         | 475 ++++++++++++++++++++++++++++++++++
 3 files changed, 502 insertions(+), 1 deletion(-)
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
index 000000000000..293380eaea41
--- /dev/null
+++ b/kernel/bpf/memalloc.c
@@ -0,0 +1,475 @@
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
+#define LLIST_NODE_SZ sizeof(struct llist_node)
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
+	if (!size || size > 4096)
+		return -1;
+
+	if (size <= 192)
+		return size_index[(size - 1) / 8] - 1;
+
+	return fls(size - 1) - 1;
+}
+
+#define NUM_CACHES 11
+
+struct bpf_mem_cache {
+	/* per-cpu list of free objects of size 'unit_size'.
+	 * All accesses are done with interrupts disabled and 'active' counter
+	 * protection with __llist_add() and __llist_del_first().
+	 */
+	struct llist_head free_llist;
+	local_t active;
+
+	/* Operations on the free_list from unit_alloc/unit_free/bpf_mem_refill
+	 * are sequenced by per-cpu 'active' counter. But unit_free() cannot
+	 * fail. When 'active' is busy the unit_free() will add an object to
+	 * free_llist_extra.
+	 */
+	struct llist_head free_llist_extra;
+
+	/* kmem_cache != NULL when bpf_mem_alloc was created for specific
+	 * element size.
+	 */
+	struct kmem_cache *kmem_cache;
+	struct irq_work refill_work;
+	struct obj_cgroup *objcg;
+	int unit_size;
+	/* count of objects in free_llist */
+	int free_cnt;
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
+static void *__alloc(struct bpf_mem_cache *c, int node)
+{
+	/* Allocate, but don't deplete atomic reserves that typical
+	 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
+	 * will allocate from the current numa node which is what we
+	 * want here.
+	 */
+	gfp_t flags = GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT;
+
+	if (c->kmem_cache)
+		return kmem_cache_alloc_node(c->kmem_cache, flags, node);
+
+	return kmalloc_node(c->unit_size, flags, node);
+}
+
+static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
+{
+#ifdef CONFIG_MEMCG_KMEM
+	if (c->objcg)
+		return get_mem_cgroup_from_objcg(c->objcg);
+#endif
+
+#ifdef CONFIG_MEMCG
+	return root_mem_cgroup;
+#else
+	return NULL;
+#endif
+}
+
+/* Mostly runs from irq_work except __init phase. */
+static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
+{
+	struct mem_cgroup *memcg = NULL, *old_memcg;
+	unsigned long flags;
+	void *obj;
+	int i;
+
+	memcg = get_memcg(c);
+	old_memcg = set_active_memcg(memcg);
+	for (i = 0; i < cnt; i++) {
+		obj = __alloc(c, node);
+		if (!obj)
+			break;
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			/* In RT irq_work runs in per-cpu kthread, so disable
+			 * interrupts to avoid preemption and interrupts and
+			 * reduce the chance of bpf prog executing on this cpu
+			 * when active counter is busy.
+			 */
+			local_irq_save(flags);
+		if (local_inc_return(&c->active) == 1) {
+			__llist_add(obj, &c->free_llist);
+			c->free_cnt++;
+		}
+		local_dec(&c->active);
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_restore(flags);
+	}
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+}
+
+static void free_one(struct bpf_mem_cache *c, void *obj)
+{
+	if (c->kmem_cache)
+		kmem_cache_free(c->kmem_cache, obj);
+	else
+		kfree(obj);
+}
+
+static void free_bulk(struct bpf_mem_cache *c)
+{
+	struct llist_node *llnode, *t;
+	unsigned long flags;
+	int cnt;
+
+	do {
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_save(flags);
+		if (local_inc_return(&c->active) == 1) {
+			llnode = __llist_del_first(&c->free_llist);
+			if (llnode)
+				cnt = --c->free_cnt;
+			else
+				cnt = 0;
+		}
+		local_dec(&c->active);
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_restore(flags);
+		free_one(c, llnode);
+	} while (cnt > (HIGH_WATERMARK + LOW_WATERMARK) / 2);
+
+	/* and drain free_llist_extra */
+	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
+		free_one(c, llnode);
+}
+
+static void bpf_mem_refill(struct irq_work *work)
+{
+	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work);
+	int cnt;
+
+	/* Racy access to free_cnt. It doesn't need to be 100% accurate */
+	cnt = c->free_cnt;
+	if (cnt < LOW_WATERMARK)
+		/* irq_work runs on this cpu and kmalloc will allocate
+		 * from the current numa node which is what we want here.
+		 */
+		alloc_bulk(c, BATCH, NUMA_NO_NODE);
+	else if (cnt > HIGH_WATERMARK)
+		free_bulk(c);
+}
+
+static void notrace irq_work_raise(struct bpf_mem_cache *c)
+{
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
+	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu));
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
+	struct obj_cgroup *objcg = NULL;
+	char buf[32];
+	int cpu, i;
+
+	if (size) {
+		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
+		if (!pc)
+			return -ENOMEM;
+		size += LLIST_NODE_SZ; /* room for llist_node */
+		snprintf(buf, sizeof(buf), "bpf-%u", size);
+		kmem_cache = kmem_cache_create(buf, size, 8, 0, NULL);
+		if (!kmem_cache) {
+			free_percpu(pc);
+			return -ENOMEM;
+		}
+#ifdef CONFIG_MEMCG_KMEM
+		objcg = get_obj_cgroup_from_current();
+#endif
+		for_each_possible_cpu(cpu) {
+			c = per_cpu_ptr(pc, cpu);
+			c->kmem_cache = kmem_cache;
+			c->unit_size = size;
+			c->objcg = objcg;
+			prefill_mem_cache(c, cpu);
+		}
+		ma->cache = pc;
+		return 0;
+	}
+
+	pcc = __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL);
+	if (!pcc)
+		return -ENOMEM;
+#ifdef CONFIG_MEMCG_KMEM
+	objcg = get_obj_cgroup_from_current();
+#endif
+	for_each_possible_cpu(cpu) {
+		cc = per_cpu_ptr(pcc, cpu);
+		for (i = 0; i < NUM_CACHES; i++) {
+			c = &cc->cache[i];
+			c->unit_size = sizes[i];
+			c->objcg = objcg;
+			prefill_mem_cache(c, cpu);
+		}
+	}
+	ma->caches = pcc;
+	return 0;
+}
+
+static void drain_mem_cache(struct bpf_mem_cache *c)
+{
+	struct llist_node *llnode, *t;
+
+	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist))
+		free_one(c, llnode);
+	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
+		free_one(c, llnode);
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
+		if (c->objcg)
+			obj_cgroup_put(c->objcg);
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
+		if (c->objcg)
+			obj_cgroup_put(c->objcg);
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
+	struct llist_node *llnode = NULL;
+	unsigned long flags;
+	int cnt = 0;
+
+	/* Disable irqs to prevent the following race for majority of prog types:
+	 * prog_A
+	 *   bpf_mem_alloc
+	 *      preemption or irq -> prog_B
+	 *        bpf_mem_alloc
+	 *
+	 * but prog_B could be a perf_event NMI prog.
+	 * Use per-cpu 'active' counter to order free_list access between
+	 * unit_alloc/unit_free/bpf_mem_refill.
+	 */
+	local_irq_save(flags);
+	if (local_inc_return(&c->active) == 1) {
+		llnode = __llist_del_first(&c->free_llist);
+		if (llnode)
+			cnt = --c->free_cnt;
+	}
+	local_dec(&c->active);
+	local_irq_restore(flags);
+
+	WARN_ON(cnt < 0);
+
+	if (cnt < LOW_WATERMARK)
+		irq_work_raise(c);
+	return llnode;
+}
+
+/* Though 'ptr' object could have been allocated on a different cpu
+ * add it to the free_llist of the current cpu.
+ * Let kfree() logic deal with it when it's later called from irq_work.
+ */
+static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
+{
+	struct llist_node *llnode = ptr - LLIST_NODE_SZ;
+	unsigned long flags;
+	int cnt = 0;
+
+	BUILD_BUG_ON(LLIST_NODE_SZ > 8);
+
+	local_irq_save(flags);
+	if (local_inc_return(&c->active) == 1) {
+		__llist_add(llnode, &c->free_llist);
+		cnt = ++c->free_cnt;
+	} else {
+		/* unit_free() cannot fail. Therefore add an object to atomic
+		 * llist. free_bulk() will drain it. Though free_llist_extra is
+		 * a per-cpu list we have to use atomic llist_add here, since
+		 * it also can be interrupted by bpf nmi prog that does another
+		 * unit_free() into the same free_llist_extra.
+		 */
+		llist_add(llnode, &c->free_llist_extra);
+	}
+	local_dec(&c->active);
+	local_irq_restore(flags);
+
+	if (cnt > HIGH_WATERMARK)
+		/* free few objects from current cpu into global kmalloc pool */
+		irq_work_raise(c);
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
+	idx = bpf_mem_cache_idx(size + LLIST_NODE_SZ);
+	if (idx < 0)
+		return NULL;
+
+	ret = unit_alloc(this_cpu_ptr(ma->caches)->cache + idx);
+	return !ret ? NULL : ret + LLIST_NODE_SZ;
+}
+
+void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
+{
+	int idx;
+
+	if (!ptr)
+		return;
+
+	idx = bpf_mem_cache_idx(__ksize(ptr - LLIST_NODE_SZ));
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
+	return !ret ? NULL : ret + LLIST_NODE_SZ;
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

