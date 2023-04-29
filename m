Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF9B6F23E4
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 11:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjD2Jld (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 Apr 2023 05:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjD2Jlb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 Apr 2023 05:41:31 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA121993;
        Sat, 29 Apr 2023 02:41:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q7kxx6mNSz4f3pG3;
        Sat, 29 Apr 2023 17:41:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBA5kxkK36NIQ--.13426S8;
        Sat, 29 Apr 2023 17:41:27 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC bpf-next v3 4/6] bpf: Introduce BPF_MA_FREE_AFTER_RCU_GP
Date:   Sat, 29 Apr 2023 18:12:13 +0800
Message-Id: <20230429101215.111262-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230429101215.111262-1-houtao@huaweicloud.com>
References: <20230429101215.111262-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBA5kxkK36NIQ--.13426S8
X-Coremail-Antispam: 1UD129KBjvJXoW3GF45ur45WF4UKry8Kw13CFg_yoWxAw1xpF
        WfCFyrAw4kXF4qgayaqan2yrnxKr40gw1UGFW7urySyr1furyqqrn7AFy7ZF45Crs7ArWS
        grs8KFyfAr48XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYOVAac2xI67A07wC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcDDG
        UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Beside REUSE_AFTER_RCU_GP, also introduce FREE_AFTER_RCU_GP to solve
the immediate reuse problem as well. Compared with REUSE_AFTER_RCU_GP,
the implementation of FREE_AFTER_RCU_GP is much simpler. It doesn't try
to reuse these freed elements after one RCU GP is passed, instead it
just directly frees these elements back to slab subsystem after one RCU
GP. The shortcoming of FREE_AFTER_RCU_GP is that sleep-able program must
access these elements by using bpf_rcu_read_{lock,unlock}, otherwise
there will be use-after-free problem.

To simplify the implementation, FREE_AFTER_RCU_GP uses a global per-cpu
free list to temporarily keep these freed elements and uses a per-cpu
kworker to dynamically allocate RCU callback to free these freed
elements when the number of freed elements is above the threshold.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_mem_alloc.h |   1 +
 kernel/bpf/memalloc.c         | 139 ++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index e7f68432713b..61e8556208a2 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -19,6 +19,7 @@ struct bpf_mem_alloc {
 enum {
 	BPF_MA_PERCPU = 1U << 0,
 	BPF_MA_REUSE_AFTER_RCU_GP = 1U << 1,
+	BPF_MA_FREE_AFTER_RCU_GP = 1U << 2,
 };
 
 /* 'size != 0' is for bpf_mem_alloc which manages fixed-size objects.
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 262100f89610..5f6a4f2cfd37 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -63,7 +63,26 @@ static u8 size_index[24] __ro_after_init = {
 	2	/* 192 */
 };
 
+#define BPF_MA_FREE_TYPE_NR 2
+
+struct bpf_ma_free_ctx {
+	raw_spinlock_t lock;
+	int cpu;
+	local_t active;
+	/* For both no per-cpu and per-cpu */
+	struct llist_head to_free[BPF_MA_FREE_TYPE_NR];
+	unsigned int to_free_cnt[BPF_MA_FREE_TYPE_NR];
+	struct llist_head to_free_extra[BPF_MA_FREE_TYPE_NR];
+	struct delayed_work dwork;
+};
+
+struct bpf_free_batch {
+	struct rcu_head rcu;
+	struct llist_node *to_free[BPF_MA_FREE_TYPE_NR];
+};
+
 static struct workqueue_struct *bpf_ma_wq;
+static DEFINE_PER_CPU(struct bpf_ma_free_ctx, percpu_free_ctx);
 
 static void bpf_ma_prepare_reuse_work(struct work_struct *work);
 
@@ -910,6 +929,112 @@ static void notrace immediate_reuse_free(struct bpf_mem_cache *c, struct llist_n
 		irq_work_raise(c);
 }
 
+static void bpf_ma_batch_free_cb(struct rcu_head *rcu)
+{
+	struct bpf_free_batch *batch = container_of(rcu, struct bpf_free_batch, rcu);
+
+	free_all(batch->to_free[0], false);
+	free_all(batch->to_free[1], true);
+	kfree(batch);
+}
+
+static void bpf_ma_schedule_free_dwork(struct bpf_ma_free_ctx *ctx)
+{
+	long delay, left;
+	u64 to_free_cnt;
+
+	/* TODO: More reasonable threshold ? */
+	to_free_cnt = ctx->to_free_cnt[0] + ctx->to_free_cnt[1];
+	delay = to_free_cnt >= 256 ? 0 : HZ;
+	if (delayed_work_pending(&ctx->dwork)) {
+		left = ctx->dwork.timer.expires - jiffies;
+		if (delay < left)
+			mod_delayed_work(bpf_ma_wq, &ctx->dwork, delay);
+		return;
+	}
+	queue_delayed_work(bpf_ma_wq, &ctx->dwork, delay);
+}
+
+static void splice_llist(struct llist_head *llist, struct llist_node **head)
+{
+	struct llist_node *first, *last;
+
+	first = llist_del_all(llist);
+	if (!first)
+		return;
+
+	last = first;
+	while (last->next)
+		last = last->next;
+	last->next = *head;
+	*head = first;
+}
+
+static void bpf_ma_splice_to_free_list(struct bpf_ma_free_ctx *ctx, struct llist_node **to_free)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	/* Might be interrupted by a NMI which invokes unit_free() */
+	if (ctx->cpu == smp_processor_id())
+		WARN_ON_ONCE(local_inc_return(&ctx->active) != 1);
+	raw_spin_lock(&ctx->lock);
+	to_free[0] = __llist_del_all(&ctx->to_free[0]);
+	to_free[1] = __llist_del_all(&ctx->to_free[1]);
+	ctx->to_free_cnt[0] = 0;
+	ctx->to_free_cnt[1] = 0;
+	raw_spin_unlock(&ctx->lock);
+	if (ctx->cpu == smp_processor_id())
+		local_dec(&ctx->active);
+	local_irq_restore(flags);
+
+	splice_llist(&ctx->to_free_extra[0], &to_free[0]);
+	splice_llist(&ctx->to_free_extra[1], &to_free[1]);
+}
+
+static void bpf_ma_free_dwork(struct work_struct *work)
+{
+	struct bpf_ma_free_ctx *ctx = container_of(to_delayed_work(work),
+						       struct bpf_ma_free_ctx, dwork);
+	struct llist_node *to_free[BPF_MA_FREE_TYPE_NR];
+	struct bpf_free_batch *batch;
+
+	bpf_ma_splice_to_free_list(ctx, to_free);
+
+	batch = kmalloc(sizeof(*batch), GFP_KERNEL);
+	if (!batch) {
+		synchronize_rcu_expedited();
+		free_all(to_free[0], false);
+		free_all(to_free[1], true);
+		return;
+	}
+
+	batch->to_free[0] = to_free[0];
+	batch->to_free[1] = to_free[1];
+	call_rcu(&batch->rcu, bpf_ma_batch_free_cb);
+}
+
+static void notrace wait_gp_direct_free(struct bpf_mem_cache *c, struct llist_node *llnode)
+{
+	bool percpu = !!c->percpu_size;
+	struct bpf_ma_free_ctx *ctx;
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
 static inline void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 {
 	struct llist_node *llnode = ptr - LLIST_NODE_SZ;
@@ -918,6 +1043,8 @@ static inline void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 
 	if (c->flags & BPF_MA_REUSE_AFTER_RCU_GP)
 		wait_gp_reuse_free(c, llnode);
+	else if (c->flags & BPF_MA_FREE_AFTER_RCU_GP)
+		wait_gp_direct_free(c, llnode);
 	else
 		immediate_reuse_free(c, llnode);
 }
@@ -1016,8 +1143,20 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
 
 static int __init bpf_ma_init(void)
 {
+	int cpu;
+
 	bpf_ma_wq = alloc_workqueue("bpf_ma", WQ_MEM_RECLAIM, 0);
 	BUG_ON(!bpf_ma_wq);
+
+	for_each_possible_cpu(cpu) {
+		struct bpf_ma_free_ctx *ctx;
+
+		ctx = per_cpu_ptr(&percpu_free_ctx, cpu);
+		raw_spin_lock_init(&ctx->lock);
+		ctx->cpu = cpu;
+		INIT_DELAYED_WORK(&ctx->dwork, bpf_ma_free_dwork);
+	}
+
 	return 0;
 }
 late_initcall(bpf_ma_init);
-- 
2.29.2

