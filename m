Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C1A659496
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 05:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiL3EML (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 23:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiL3EMJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 23:12:09 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B7418695;
        Thu, 29 Dec 2022 20:12:06 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NjsKD5F9Gz4f3nq1;
        Fri, 30 Dec 2022 12:12:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLMPZa5j3H4SAw--.35465S8;
        Fri, 30 Dec 2022 12:12:03 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC PATCH bpf-next 4/6] bpf: Introduce BPF_MA_NO_REUSE for bpf memory allocator
Date:   Fri, 30 Dec 2022 12:11:49 +0800
Message-Id: <20221230041151.1231169-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221230041151.1231169-1-houtao@huaweicloud.com>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLMPZa5j3H4SAw--.35465S8
X-Coremail-Antispam: 1UD129KBjvJXoWxKFW3Kw18JFyDGr1rAFWxXrb_yoW3CFy5pF
        ZxCry8Aw4kXF4IgFWaqw4vyr43Kr40gw17KrWj9ryrCr1fZryDtrn7Ary7AF15Crs7AFWI
        9rZ0kFyfAr4UXFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Currently the freed element in bpf memory allocator may be reused by new
allocation, the reuse may lead to two problems. One problem is that the
lookup procedure may get incorrect result if the found element is freed
and then reused. Another problem is that lookup procedure may still use
special fields in map value or allocated object and at the same time
these special fields are reinitialized by new allocation. The latter
problem can be mitigated by using ctor in bpf memory allocator, but it
only works for case in which all elements have the same type.

So introducing BPF_MA_NO_REUSE to disable immediate reuse of freed
elements. These freed elements will be moved into a global per-cpu free
list instead. After the number of freed elements reaches the threshold,
these free elements will be moved into a dymaically allocated object
and being freed by a global per-cpu worker through
call_rcu_tasks_trace().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_mem_alloc.h |   2 +
 kernel/bpf/memalloc.c         | 175 +++++++++++++++++++++++++++++++++-
 2 files changed, 173 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index b9f6b9155fa5..2a10b721832d 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -19,6 +19,8 @@ struct bpf_mem_alloc {
 /* flags for bpf_mem_alloc_init() */
 enum {
 	BPF_MA_PERCPU = 1,
+	/* Don't reuse freed elements during allocation */
+	BPF_MA_NO_REUSE = 2,
 };
 
 int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, unsigned int flags,
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 454c86596111..e5eaf765624b 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -35,6 +35,23 @@
  */
 #define LLIST_NODE_SZ sizeof(struct llist_node)
 
+#define BPF_MA_FREE_TYPE_NR 2
+
+struct bpf_ma_free_context {
+	raw_spinlock_t lock;
+	local_t active;
+	/* For both no per-cpu and per-cpu */
+	struct llist_head to_free[BPF_MA_FREE_TYPE_NR];
+	unsigned int to_free_cnt[BPF_MA_FREE_TYPE_NR];
+	struct llist_head to_free_extra[BPF_MA_FREE_TYPE_NR];
+	struct delayed_work dwork;
+};
+
+struct bpf_ma_free_batch {
+	struct rcu_head rcu;
+	struct llist_node *to_free[BPF_MA_FREE_TYPE_NR];
+};
+
 /* similar to kmalloc, but sizeof == 8 bucket is gone */
 static u8 size_index[24] __ro_after_init = {
 	3,	/* 8 */
@@ -63,6 +80,9 @@ static u8 size_index[24] __ro_after_init = {
 	2	/* 192 */
 };
 
+static DEFINE_PER_CPU(struct bpf_ma_free_context, percpu_free_ctx);
+static struct workqueue_struct *bpf_ma_free_wq;
+
 static int bpf_mem_cache_idx(size_t size)
 {
 	if (!size || size > 4096)
@@ -609,14 +629,11 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
  * add it to the free_llist of the current cpu.
  * Let kfree() logic deal with it when it's later called from irq_work.
  */
-static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
+static void notrace reuse_free(struct bpf_mem_cache *c, struct llist_node *llnode)
 {
-	struct llist_node *llnode = ptr - LLIST_NODE_SZ;
 	unsigned long flags;
 	int cnt = 0;
 
-	BUILD_BUG_ON(LLIST_NODE_SZ > 8);
-
 	local_irq_save(flags);
 	if (local_inc_return(&c->active) == 1) {
 		__llist_add(llnode, &c->free_llist);
@@ -638,6 +655,137 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 		irq_work_raise(c);
 }
 
+static void batch_free_rcu(struct rcu_head *rcu)
+{
+	struct bpf_ma_free_batch *batch = container_of(rcu, struct bpf_ma_free_batch, rcu);
+
+	free_llist(batch->to_free[0], false);
+	free_llist(batch->to_free[1], true);
+	kfree(batch);
+}
+
+static void batch_free_rcu_tasks_trace(struct rcu_head *rcu)
+{
+	if (rcu_trace_implies_rcu_gp())
+		batch_free_rcu(rcu);
+	else
+		call_rcu(rcu, batch_free_rcu);
+}
+
+static void bpf_ma_schedule_free_dwork(struct bpf_ma_free_context *ctx)
+{
+	long delay, left;
+	u64 to_free_cnt;
+
+	to_free_cnt = ctx->to_free_cnt[0] + ctx->to_free_cnt[1];
+	delay = to_free_cnt >= 256 ? 1 : HZ;
+	if (delayed_work_pending(&ctx->dwork)) {
+		left = ctx->dwork.timer.expires - jiffies;
+		if (delay < left)
+			mod_delayed_work(bpf_ma_free_wq, &ctx->dwork, delay);
+		return;
+	}
+	queue_delayed_work(bpf_ma_free_wq, &ctx->dwork, delay);
+}
+
+static void bpf_ma_splice_to_free_list(struct bpf_ma_free_context *ctx, struct llist_node **to_free)
+{
+	struct llist_node *tmp[BPF_MA_FREE_TYPE_NR];
+	unsigned long flags;
+	unsigned int i;
+
+	raw_spin_lock_irqsave(&ctx->lock, flags);
+	for (i = 0; i < ARRAY_SIZE(tmp); i++) {
+		tmp[i] = __llist_del_all(&ctx->to_free[i]);
+		ctx->to_free_cnt[i] = 0;
+	}
+	raw_spin_unlock_irqrestore(&ctx->lock, flags);
+
+	for (i = 0; i < ARRAY_SIZE(tmp); i++) {
+		struct llist_node *first, *last;
+
+		first = llist_del_all(&ctx->to_free_extra[i]);
+		if (!first) {
+			to_free[i] = tmp[i];
+			continue;
+		}
+		last = first;
+		while (last->next)
+			last = last->next;
+		to_free[i] = first;
+		last->next = tmp[i];
+	}
+}
+
+static inline bool bpf_ma_has_to_free(const struct bpf_ma_free_context *ctx)
+{
+	return !llist_empty(&ctx->to_free[0]) || !llist_empty(&ctx->to_free[1]) ||
+	       !llist_empty(&ctx->to_free_extra[0]) || !llist_empty(&ctx->to_free_extra[1]);
+}
+
+static void bpf_ma_free_dwork(struct work_struct *work)
+{
+	struct bpf_ma_free_context *ctx = container_of(to_delayed_work(work),
+						       struct bpf_ma_free_context, dwork);
+	struct llist_node *to_free[BPF_MA_FREE_TYPE_NR];
+	struct bpf_ma_free_batch *batch;
+	unsigned long flags;
+
+	bpf_ma_splice_to_free_list(ctx, to_free);
+
+	batch = kmalloc(sizeof(*batch), GFP_NOWAIT | __GFP_NOWARN);
+	if (!batch) {
+		/* TODO: handle ENOMEM case better ? */
+		rcu_barrier_tasks_trace();
+		rcu_barrier();
+		free_llist(to_free[0], false);
+		free_llist(to_free[1], true);
+		goto check;
+	}
+
+	batch->to_free[0] = to_free[0];
+	batch->to_free[1] = to_free[1];
+	call_rcu_tasks_trace(&batch->rcu, batch_free_rcu_tasks_trace);
+check:
+	raw_spin_lock_irqsave(&ctx->lock, flags);
+	if (bpf_ma_has_to_free(ctx))
+		bpf_ma_schedule_free_dwork(ctx);
+	raw_spin_unlock_irqrestore(&ctx->lock, flags);
+}
+
+static void notrace direct_free(struct bpf_mem_cache *c, struct llist_node *llnode)
+{
+	struct bpf_ma_free_context *ctx;
+	bool percpu = !!c->percpu_size;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ctx = this_cpu_ptr(&percpu_free_ctx);
+	if (local_inc_return(&ctx->active) == 1) {
+		raw_spin_lock(&ctx->lock);
+		__llist_add(llnode, &ctx->to_free[percpu]);
+		ctx->to_free_cnt[percpu] += 1;
+		bpf_ma_schedule_free_dwork(ctx);
+		raw_spin_unlock(&ctx->lock);
+	} else {
+		llist_add(llnode, &ctx->to_free_extra[percpu]);
+	}
+	local_dec(&ctx->active);
+	local_irq_restore(flags);
+}
+
+static inline void unit_free(struct bpf_mem_cache *c, void *ptr)
+{
+	struct llist_node *llnode = ptr - LLIST_NODE_SZ;
+
+	BUILD_BUG_ON(LLIST_NODE_SZ > 8);
+
+	if (c->ma->flags & BPF_MA_NO_REUSE)
+		direct_free(c, llnode);
+	else
+		reuse_free(c, llnode);
+}
+
 /* Called from BPF program or from sys_bpf syscall.
  * In both cases migration is disabled.
  */
@@ -686,3 +834,22 @@ void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
 
 	unit_free(this_cpu_ptr(ma->cache), ptr);
 }
+
+static int __init bpf_ma_init(void)
+{
+	int cpu;
+
+	bpf_ma_free_wq = alloc_workqueue("bpf_ma_free", WQ_MEM_RECLAIM, 0);
+	BUG_ON(!bpf_ma_free_wq);
+
+	for_each_possible_cpu(cpu) {
+		struct bpf_ma_free_context *ctx;
+
+		ctx = per_cpu_ptr(&percpu_free_ctx, cpu);
+		raw_spin_lock_init(&ctx->lock);
+		INIT_DELAYED_WORK(&ctx->dwork, bpf_ma_free_dwork);
+	}
+
+	return 0;
+}
+fs_initcall(bpf_ma_init);
-- 
2.29.2

