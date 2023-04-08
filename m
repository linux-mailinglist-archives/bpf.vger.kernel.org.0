Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF206DBB3D
	for <lists+bpf@lfdr.de>; Sat,  8 Apr 2023 15:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjDHNr5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Apr 2023 09:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDHNrz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Apr 2023 09:47:55 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD585D524;
        Sat,  8 Apr 2023 06:47:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PtxPw38SYz4f3v7b;
        Sat,  8 Apr 2023 21:47:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCH77J_cDFk6gboGw--.47910S8;
        Sat, 08 Apr 2023 21:47:50 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC bpf-next v2 4/4] bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
Date:   Sat,  8 Apr 2023 22:18:46 +0800
Message-Id: <20230408141846.1878768-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230408141846.1878768-1-houtao@huaweicloud.com>
References: <20230408141846.1878768-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77J_cDFk6gboGw--.47910S8
X-Coremail-Antispam: 1UD129KBjvAXoWfWryUWF4fKr13Cw1DKr4fuFg_yoW8Zw1UAo
        Wfuw43Wr18KFyIyayvqa4jkFnF9r1kW3sxAw4fGFZ0vayUZrW5ta9aka13Aa4fXF4rKF4k
        Za4Iqw4DGF1fWryfn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYC7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
        67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Currently the freed objects in bpf memory allocator may be reused
immediately by new allocation, it introduces use-after-bpf-ma-free
problem for non-preallocated hash map and makes lookup procedure
return incorrect result. The immediate reuse also makes introducing
new use case more difficult (e.g. qp-trie).

So introduce BPF_MA_REUSE_AFTER_RCU_GP to solve these problems. For
BPF_MA_REUSE_AFTER_GP, the freed objects are reused only after one RCU
grace period and may be returned back to slab system after another
RCU-tasks-trace grace period. So for bpf programs which care about reuse
problem, these programs can use bpf_rcu_read_{lock,unlock}() to access
these freed objects safely and for those which doesn't care, there will
be safely use-after-bpf-ma-free because these objects have not been
freed by bpf memory allocator.

To make these freed elements being reusab quickly, BPF_MA_REUSE_AFTER_GP
dynamically allocates memory to create many inflight RCU callbacks to
mark these freed element being reusable. These memories used for
bpf_reuse_batch will be freed when these RCU callbacks complete. When no
memory is available, synchronize_rcu_expedited() will be used to make
these freed element reusable. In order to reduce the risk of OOM, part
of these reusable memory will be freed through RCU-tasks-trace grace
period. Before these freeing memories are freed, these memories are also
available for reuse.

The following are the benchmark results when comparing between different
flavors of bpf memory allocator. These results show:
* The performance of reuse-after-rcu-gp bpf ma is good than no bpf ma.
  Its memory usage is also good than no bpf ma except for
  add_del_on_diff_cpu case.
* The memory usage of reuse-after-rcu-gp bpf ma increases a lot compared
  with normal bpf ma.
* The memory usage of free-after-rcu-gp bpf ma is better than
  reuse-after-rcu-gp bpf ma, but its performance is bad than
  reuse-after-ruc-gp because it doesn't do reuse.

(1) no bpf memory allocator (v6.0.19)
| name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
| --                  | --         | --                   | --                |
| no_op               | 1187       | 1.05                 | 1.05              |
| overwrite           | 3.74       | 32.52                | 84.18             |
| batch_add_batch_del | 2.23       | 26.38                | 48.75             |
| add_del_on_diff_cpu | 3.92       | 33.72                | 48.96             |

(2) normal bpf memory allocator
| name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
| --                  | --         | --                   | --                |
| no_op               | 1187       | 0.96                 | 1.00              |
| overwrite           | 27.12      | 2.5                  | 2.99              |
| batch_add_batch_del | 8.9        | 2.77                 | 3.24              |
| add_del_on_diff_cpu | 11.30      | 218.54               | 440.37            |

(3) reuse-after-rcu-gp bpf memory allocator
| name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
| --                  | --         | --                   | --                |
| no_op               | 1276       | 0.96                 | 1.00              |
| overwrite           | 15.66      | 25.00                | 33.07             |
| batch_add_batch_del | 10.32      | 18.84                | 22.64             |
| add_del_on_diff_cpu | 13.00      | 550.50               | 748.74            |

(4) free-after-rcu-gp bpf memory allocator (free directly through call_rcu)

| name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
| --                  | --         | --                   | --                |
| no_op               | 1263       | 0.96                 | 1.00              |
| overwrite           | 10.73      | 12.33                | 20.32             |
| batch_add_batch_del | 7.02       | 9.45                 | 14.07             |
| add_del_on_diff_cpu | 8.99       | 131.64               | 204.42            |

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_mem_alloc.h |   1 +
 kernel/bpf/memalloc.c         | 353 +++++++++++++++++++++++++++++++---
 2 files changed, 326 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 148347950e16..e7f68432713b 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -18,6 +18,7 @@ struct bpf_mem_alloc {
 /* flags for bpf_mem_alloc_init() */
 enum {
 	BPF_MA_PERCPU = 1U << 0,
+	BPF_MA_REUSE_AFTER_RCU_GP = 1U << 1,
 };
 
 /* 'size != 0' is for bpf_mem_alloc which manages fixed-size objects.
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 072102476019..262100f89610 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -63,6 +63,10 @@ static u8 size_index[24] __ro_after_init = {
 	2	/* 192 */
 };
 
+static struct workqueue_struct *bpf_ma_wq;
+
+static void bpf_ma_prepare_reuse_work(struct work_struct *work);
+
 static int bpf_mem_cache_idx(size_t size)
 {
 	if (!size || size > 4096)
@@ -98,18 +102,36 @@ struct bpf_mem_cache {
 	int free_cnt;
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
+	int cpu;
 	unsigned int flags;
 
+	raw_spinlock_t reuse_lock;
+	bool abort_reuse;
+	struct llist_head reuse_ready_head;
+	struct llist_node *reuse_ready_tail;
+	struct llist_head wait_for_free;
+	struct llist_head prepare_reuse_head;
+	struct llist_node *prepare_reuse_tail;
+	unsigned int prepare_reuse_cnt;
+	atomic_t reuse_cb_in_progress;
+	struct work_struct reuse_work;
+
 	struct rcu_head rcu;
 	struct llist_head free_by_rcu;
 	struct llist_head waiting_for_gp;
-	atomic_t call_rcu_in_progress;
+	atomic_t free_cb_in_progress;
 };
 
 struct bpf_mem_caches {
 	struct bpf_mem_cache cache[NUM_CACHES];
 };
 
+struct bpf_reuse_batch {
+	struct bpf_mem_cache *c;
+	struct llist_node *head, *tail;
+	struct rcu_head rcu;
+};
+
 static struct llist_node notrace *__llist_del_first(struct llist_head *head)
 {
 	struct llist_node *entry, *next;
@@ -154,6 +176,45 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 #endif
 }
 
+static void *bpf_ma_get_reusable_obj(struct bpf_mem_cache *c)
+{
+	if (c->flags & BPF_MA_REUSE_AFTER_RCU_GP) {
+		unsigned long flags;
+		void *obj;
+
+		if (llist_empty(&c->reuse_ready_head) && llist_empty(&c->wait_for_free))
+			return NULL;
+
+		/* reuse_ready_head and wait_for_free may be manipulated by
+		 * kworker and RCU callbacks.
+		 */
+		raw_spin_lock_irqsave(&c->reuse_lock, flags);
+		obj = __llist_del_first(&c->reuse_ready_head);
+		if (obj) {
+			if (llist_empty(&c->reuse_ready_head))
+				c->reuse_ready_tail = NULL;
+		} else {
+			obj = __llist_del_first(&c->wait_for_free);
+		}
+		raw_spin_unlock_irqrestore(&c->reuse_lock, flags);
+		return obj;
+	}
+
+	/*
+	 * free_by_rcu is only manipulated by irq work refill_work().
+	 * IRQ works on the same CPU are called sequentially, so it is
+	 * safe to use __llist_del_first() here. If alloc_bulk() is
+	 * invoked by the initial prefill, there will be no running
+	 * refill_work(), so __llist_del_first() is fine as well.
+	 *
+	 * In most cases, objects on free_by_rcu are from the same CPU.
+	 * If some objects come from other CPUs, it doesn't incur any
+	 * harm because NUMA_NO_NODE means the preference for current
+	 * numa node and it is not a guarantee.
+	 */
+	return __llist_del_first(&c->free_by_rcu);
+}
+
 /* Mostly runs from irq_work except __init phase. */
 static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 {
@@ -165,19 +226,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	memcg = get_memcg(c);
 	old_memcg = set_active_memcg(memcg);
 	for (i = 0; i < cnt; i++) {
-		/*
-		 * free_by_rcu is only manipulated by irq work refill_work().
-		 * IRQ works on the same CPU are called sequentially, so it is
-		 * safe to use __llist_del_first() here. If alloc_bulk() is
-		 * invoked by the initial prefill, there will be no running
-		 * refill_work(), so __llist_del_first() is fine as well.
-		 *
-		 * In most cases, objects on free_by_rcu are from the same CPU.
-		 * If some objects come from other CPUs, it doesn't incur any
-		 * harm because NUMA_NO_NODE means the preference for current
-		 * numa node and it is not a guarantee.
-		 */
-		obj = __llist_del_first(&c->free_by_rcu);
+		obj = bpf_ma_get_reusable_obj(c);
 		if (!obj) {
 			/* Allocate, but don't deplete atomic reserves that typical
 			 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
@@ -236,7 +285,7 @@ static void __free_rcu(struct rcu_head *head)
 	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
 
 	free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
-	atomic_set(&c->call_rcu_in_progress, 0);
+	atomic_set(&c->free_cb_in_progress, 0);
 }
 
 static void __free_rcu_tasks_trace(struct rcu_head *head)
@@ -264,7 +313,7 @@ static void do_call_rcu(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode, *t;
 
-	if (atomic_xchg(&c->call_rcu_in_progress, 1))
+	if (atomic_xchg(&c->free_cb_in_progress, 1))
 		return;
 
 	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
@@ -409,6 +458,8 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, unsigned int flags)
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
 			c->flags = flags;
+			c->cpu = cpu;
+			INIT_WORK(&c->reuse_work, bpf_ma_prepare_reuse_work);
 			prefill_mem_cache(c, cpu);
 		}
 		ma->cache = pc;
@@ -433,6 +484,8 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, unsigned int flags)
 			c->unit_size = sizes[i];
 			c->objcg = objcg;
 			c->flags = flags;
+			c->cpu = cpu;
+			INIT_WORK(&c->reuse_work, bpf_ma_prepare_reuse_work);
 			prefill_mem_cache(c, cpu);
 		}
 	}
@@ -444,18 +497,40 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, unsigned int flags)
 static void drain_mem_cache(struct bpf_mem_cache *c)
 {
 	bool percpu = !!c->percpu_size;
+	struct llist_node *head[3];
+	unsigned long flags;
 
 	/* No progs are using this bpf_mem_cache, but htab_map_free() called
 	 * bpf_mem_cache_free() for all remaining elements and they can be in
 	 * free_by_rcu or in waiting_for_gp lists, so drain those lists now.
 	 *
-	 * Except for waiting_for_gp list, there are no concurrent operations
-	 * on these lists, so it is safe to use __llist_del_all().
+	 * Except for waiting_for_gp and free_llist_extra list, there are no
+	 * concurrent operations on these lists, so it is safe to use
+	 * __llist_del_all().
 	 */
 	free_all(__llist_del_all(&c->free_by_rcu), percpu);
 	free_all(llist_del_all(&c->waiting_for_gp), percpu);
 	free_all(__llist_del_all(&c->free_llist), percpu);
-	free_all(__llist_del_all(&c->free_llist_extra), percpu);
+	free_all(llist_del_all(&c->free_llist_extra), percpu);
+
+	if (!(c->flags & BPF_MA_REUSE_AFTER_RCU_GP))
+		return;
+
+	raw_spin_lock_irqsave(&c->reuse_lock, flags);
+	/* Indicate kworker and RCU callback to free elements directly
+	 * instead of adding new elements into these lists.
+	 */
+	c->abort_reuse = true;
+	head[0] = __llist_del_all(&c->prepare_reuse_head);
+	c->prepare_reuse_tail = NULL;
+	head[1] = __llist_del_all(&c->reuse_ready_head);
+	c->reuse_ready_tail = NULL;
+	head[2] = __llist_del_all(&c->wait_for_free);
+	raw_spin_unlock_irqrestore(&c->reuse_lock, flags);
+
+	free_all(head[0], percpu);
+	free_all(head[1], percpu);
+	free_all(head[2], percpu);
 }
 
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
@@ -466,10 +541,39 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 	ma->caches = NULL;
 }
 
+static void bpf_ma_cancel_reuse_work(struct bpf_mem_alloc *ma)
+{
+	struct bpf_mem_caches *cc;
+	struct bpf_mem_cache *c;
+	int cpu, i;
+
+	if (ma->cache) {
+		for_each_possible_cpu(cpu) {
+			c = per_cpu_ptr(ma->cache, cpu);
+			cancel_work_sync(&c->reuse_work);
+		}
+	}
+	if (ma->caches) {
+		for_each_possible_cpu(cpu) {
+			cc = per_cpu_ptr(ma->caches, cpu);
+			for (i = 0; i < NUM_CACHES; i++) {
+				c = &cc->cache[i];
+				cancel_work_sync(&c->reuse_work);
+			}
+		}
+	}
+}
+
 static void free_mem_alloc(struct bpf_mem_alloc *ma)
 {
-	/* waiting_for_gp lists was drained, but __free_rcu might
-	 * still execute. Wait for it now before we freeing percpu caches.
+	bool reuse_after_rcu_gp = ma->flags & BPF_MA_REUSE_AFTER_RCU_GP;
+
+	/* Cancel the inflight kworkers */
+	if (reuse_after_rcu_gp)
+		bpf_ma_cancel_reuse_work(ma);
+
+	/* For normal bpf ma, waiting_for_gp lists was drained, but __free_rcu
+	 * might still execute. Wait for it now before we freeing percpu caches.
 	 *
 	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
 	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
@@ -477,9 +581,13 @@ static void free_mem_alloc(struct bpf_mem_alloc *ma)
 	 * so if call_rcu(head, __free_rcu) is skipped due to
 	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
 	 * using rcu_trace_implies_rcu_gp() as well.
+	 *
+	 * For reuse-after-rcu-gp bpf ma, use rcu_barrier_tasks_trace() to
+	 * wait for the pending bpf_ma_free_reusable_cb() and use rcu_barrier()
+	 * to wait for the pending bpf_ma_reuse_cb().
 	 */
 	rcu_barrier_tasks_trace();
-	if (!rcu_trace_implies_rcu_gp())
+	if (reuse_after_rcu_gp || !rcu_trace_implies_rcu_gp())
 		rcu_barrier();
 	free_mem_alloc_no_barrier(ma);
 }
@@ -512,6 +620,7 @@ static void destroy_mem_alloc(struct bpf_mem_alloc *ma, int rcu_in_progress)
 	}
 
 	/* Defer barriers into worker to let the rest of map memory to be freed */
+	copy->flags = ma->flags;
 	copy->cache = ma->cache;
 	ma->cache = NULL;
 	copy->caches = ma->caches;
@@ -541,7 +650,9 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			 */
 			irq_work_sync(&c->refill_work);
 			drain_mem_cache(c);
-			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
+			rcu_in_progress += atomic_read(&c->free_cb_in_progress);
+			/* Pending kworkers or RCU callbacks */
+			rcu_in_progress += atomic_read(&c->reuse_cb_in_progress);
 		}
 		/* objcg is the same across cpus */
 		if (c->objcg)
@@ -556,7 +667,8 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				c = &cc->cache[i];
 				irq_work_sync(&c->refill_work);
 				drain_mem_cache(c);
-				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
+				rcu_in_progress += atomic_read(&c->free_cb_in_progress);
+				rcu_in_progress += atomic_read(&c->reuse_cb_in_progress);
 			}
 		}
 		if (c->objcg)
@@ -600,18 +712,183 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 	return llnode;
 }
 
+static void bpf_ma_add_to_reuse_ready_or_free(struct bpf_mem_cache *c, struct llist_node *head,
+					      struct llist_node *tail)
+{
+	unsigned long flags;
+	bool abort;
+
+	raw_spin_lock_irqsave(&c->reuse_lock, flags);
+	abort = c->abort_reuse;
+	if (!abort) {
+		if (llist_empty(&c->reuse_ready_head))
+			c->reuse_ready_tail = tail;
+		__llist_add_batch(head, tail, &c->reuse_ready_head);
+	}
+	raw_spin_unlock_irqrestore(&c->reuse_lock, flags);
+
+	/* Don't move these objects to reuse_ready list and free
+	 * these objects directly.
+	 */
+	if (abort)
+		free_all(head, !!c->percpu_size);
+}
+
+static void bpf_ma_reuse_cb(struct rcu_head *rcu)
+{
+	struct bpf_reuse_batch *batch = container_of(rcu, struct bpf_reuse_batch, rcu);
+	struct bpf_mem_cache *c = batch->c;
+
+	bpf_ma_add_to_reuse_ready_or_free(c, batch->head, batch->tail);
+	atomic_dec(&c->reuse_cb_in_progress);
+	kfree(batch);
+}
+
+static bool bpf_ma_try_free_reuse_objs(struct bpf_mem_cache *c)
+{
+	struct llist_node *head, *tail;
+	bool do_free;
+
+	if (llist_empty(&c->reuse_ready_head))
+		return false;
+
+	do_free = !atomic_xchg(&c->free_cb_in_progress, 1);
+	if (!do_free)
+		return false;
+
+	head = __llist_del_all(&c->reuse_ready_head);
+	tail = c->reuse_ready_tail;
+	c->reuse_ready_tail = NULL;
+
+	__llist_add_batch(head, tail, &c->wait_for_free);
+
+	return true;
+}
+
+static void bpf_ma_free_reusable_cb(struct rcu_head *rcu)
+{
+	struct bpf_mem_cache *c = container_of(rcu, struct bpf_mem_cache, rcu);
+	struct llist_node *head;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&c->reuse_lock, flags);
+	head = __llist_del_all(&c->wait_for_free);
+	raw_spin_unlock_irqrestore(&c->reuse_lock, flags);
+
+	free_all(head, !!c->percpu_size);
+	atomic_set(&c->free_cb_in_progress, 0);
+}
+
+static void bpf_ma_prepare_reuse_work(struct work_struct *work)
+{
+	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, reuse_work);
+	struct llist_node *head, *tail, *llnode, *tmp;
+	struct bpf_reuse_batch *batch;
+	unsigned long flags;
+	bool do_free;
+
+	local_irq_save(flags);
+	/* When CPU is offline, the running CPU may be different with
+	 * the CPU which submitted the work. When these two CPUs are the same,
+	 * kworker may be interrupted by NMI, so increase active to protect
+	 * again such concurrency.
+	 */
+	if (c->cpu == smp_processor_id())
+		WARN_ON_ONCE(local_inc_return(&c->active) != 1);
+	raw_spin_lock(&c->reuse_lock);
+	head = __llist_del_all(&c->prepare_reuse_head);
+	tail = c->prepare_reuse_tail;
+	c->prepare_reuse_tail = NULL;
+	c->prepare_reuse_cnt = 0;
+	if (c->cpu == smp_processor_id())
+		local_dec(&c->active);
+
+	/* Try to free elements in reusable list. Before these elements are
+	 * freed in RCU cb, these element will still be available for reuse.
+	 */
+	do_free = bpf_ma_try_free_reuse_objs(c);
+	raw_spin_unlock(&c->reuse_lock);
+	local_irq_restore(flags);
+
+	if (do_free)
+		call_rcu_tasks_trace(&c->rcu, bpf_ma_free_reusable_cb);
+
+	llist_for_each_safe(llnode, tmp, llist_del_all(&c->free_llist_extra)) {
+		if (!head)
+			tail = llnode;
+		llnode->next = head;
+		head = llnode->next;
+	}
+	/* Draining is in progress ? */
+	if (!head) {
+		/* kworker completes and no RCU callback */
+		atomic_dec(&c->reuse_cb_in_progress);
+		return;
+	}
+
+	batch = kmalloc(sizeof(*batch), GFP_KERNEL);
+	if (!batch) {
+		synchronize_rcu_expedited();
+		bpf_ma_add_to_reuse_ready_or_free(c, head, tail);
+		/* kworker completes and no RCU callback */
+		atomic_dec(&c->reuse_cb_in_progress);
+		return;
+	}
+
+	batch->c = c;
+	batch->head = head;
+	batch->tail = tail;
+	call_rcu(&batch->rcu, bpf_ma_reuse_cb);
+}
+
+static void notrace wait_gp_reuse_free(struct bpf_mem_cache *c, struct llist_node *llnode)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	/* In case a NMI-context bpf program is also freeing object. */
+	if (local_inc_return(&c->active) == 1) {
+		bool try_queue_work = false;
+
+		/* kworker may remove elements from prepare_reuse_head */
+		raw_spin_lock(&c->reuse_lock);
+		if (llist_empty(&c->prepare_reuse_head))
+			c->prepare_reuse_tail = llnode;
+		__llist_add(llnode, &c->prepare_reuse_head);
+		if (++c->prepare_reuse_cnt > c->high_watermark) {
+			/* Zero out prepare_reuse_cnt early to prevent
+			 * unnecessary queue_work().
+			 */
+			c->prepare_reuse_cnt = 0;
+			try_queue_work = true;
+		}
+		raw_spin_unlock(&c->reuse_lock);
+
+		if (try_queue_work && !work_pending(&c->reuse_work)) {
+			/* Use reuse_cb_in_progress to indicate there is
+			 * inflight reuse kworker or reuse RCU callback.
+			 */
+			atomic_inc(&c->reuse_cb_in_progress);
+			/* Already queued */
+			if (!queue_work(bpf_ma_wq, &c->reuse_work))
+				atomic_dec(&c->reuse_cb_in_progress);
+		}
+	} else {
+		llist_add(llnode, &c->free_llist_extra);
+	}
+	local_dec(&c->active);
+	local_irq_restore(flags);
+}
+
 /* Though 'ptr' object could have been allocated on a different cpu
  * add it to the free_llist of the current cpu.
  * Let kfree() logic deal with it when it's later called from irq_work.
  */
-static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
+static void notrace immediate_reuse_free(struct bpf_mem_cache *c, struct llist_node *llnode)
 {
-	struct llist_node *llnode = ptr - LLIST_NODE_SZ;
 	unsigned long flags;
 	int cnt = 0;
 
-	BUILD_BUG_ON(LLIST_NODE_SZ > 8);
-
 	local_irq_save(flags);
 	if (local_inc_return(&c->active) == 1) {
 		__llist_add(llnode, &c->free_llist);
@@ -633,6 +910,18 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 		irq_work_raise(c);
 }
 
+static inline void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
+{
+	struct llist_node *llnode = ptr - LLIST_NODE_SZ;
+
+	BUILD_BUG_ON(LLIST_NODE_SZ > 8);
+
+	if (c->flags & BPF_MA_REUSE_AFTER_RCU_GP)
+		wait_gp_reuse_free(c, llnode);
+	else
+		immediate_reuse_free(c, llnode);
+}
+
 /* Called from BPF program or from sys_bpf syscall.
  * In both cases migration is disabled.
  */
@@ -724,3 +1013,11 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
 
 	return !ret ? NULL : ret + LLIST_NODE_SZ;
 }
+
+static int __init bpf_ma_init(void)
+{
+	bpf_ma_wq = alloc_workqueue("bpf_ma", WQ_MEM_RECLAIM, 0);
+	BUG_ON(!bpf_ma_wq);
+	return 0;
+}
+late_initcall(bpf_ma_init);
-- 
2.29.2

