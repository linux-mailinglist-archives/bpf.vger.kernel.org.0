Return-Path: <bpf+bounces-2861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A264735906
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 16:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598211C20ABF
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A51B11CBE;
	Mon, 19 Jun 2023 14:00:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C033E11C8B
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 14:00:27 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6259110D;
	Mon, 19 Jun 2023 07:00:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QlBH74GhJz4f3pNR;
	Mon, 19 Jun 2023 22:00:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCH77JtX5BkiIFAMA--.58229S5;
	Mon, 19 Jun 2023 22:00:20 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org,
	houtao1@huawei.com
Subject: [RFC PATCH bpf-next v5 1/2] bpf: Only reuse after one RCU GP in bpf memory allocator
Date: Mon, 19 Jun 2023 22:32:30 +0800
Message-Id: <20230619143231.222536-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230619143231.222536-1-houtao@huaweicloud.com>
References: <20230619143231.222536-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH77JtX5BkiIFAMA--.58229S5
X-Coremail-Antispam: 1UD129KBjvAXoWfWw15tw1kWw45CF4xXF1rCrg_yoW8uryxJo
	Wfur43Wr10gF1xAayvkF1qkF4qvF1kW3s8Ars5GFZ0va4UXrWYqaySka13A3yfXFWrCr4D
	Za48tw4DCrWfXryfn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYJ7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	4l82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Currently the freed objects in bpf memory allocator may be reused
immediately by new allocation, it introduces use-after-bpf-ma-free
problem for non-preallocated hash map and makes lookup procedure
return incorrect result. The immediate reuse also makes introducing
new use case more difficult (e.g. qp-trie).

So implement reuse-after-RCU-GP to solve these problems. For
reuse-after-RCU-GP, these freed objects are reused only after one RCU
grace period and may be returned back to slab system after another
RCU-tasks-trace grace period. So for bpf programs which care about reuse
problem, these programs can use bpf_rcu_read_{lock,unlock}() to access
these freed objects safely and for those which doesn't care, there will
be safely use-after-bpf-ma-free because these objects have not been
freed by bpf memory allocator.

To make these freed elements being reusab quickly, allocate memory
dynamically to create inflight RCU callbacks to mark these freed objects
being reusab. These allocated memories will be freed when reuse_rcu
callbacks completes. When no memory is available, it will use per-cpu
rcu_head in bpf_mem_cache to mark these objects as being reusable. Part
of these reusable objects will be freed through RCU-tasks-trace grace
period to reduce the risk of OOM and these freeing objects will be also
available for reuse. To reduce the lock contention and keep numa-aware
attribute as much as possbile, per-cpu list is used for reusable objects
and freeing objects.

As shown in the following benchmark results, the memory usage increases
a lot and the performance of overwrite and batch_op case is also
degraded after applying the patch. The benchmark is conducted on a
KVM-VM with 8-CPUs and 16GB memory.

The command line for htab-mem-benchmark is:

  ./bench htab-mem --use-case $name -w 3 -d 10 -a -p 8

And the command line for map_perf_test benchmark is:

  ./map_perf_test 4 8 16384

htab-mem-benchmark (before):
overwrite           per-prod-op 115.90 ± 0.04k/s, avg mem  2.14 ± 0.12MiB, peak mem  2.73MiB
batch_add_batch_del per-prod-op 113.40 ± 0.35k/s, avg mem  2.32 ± 0.20MiB, peak mem  2.75MiB
add_del_on_diff_cpu per-prod-op  18.43 ± 0.08k/s, avg mem 18.17 ± 3.84MiB, peak mem 31.20MiB

map_perf_test (before):
0:hash_map_perf kmalloc 302508 events per sec
1:hash_map_perf kmalloc 161805 events per sec
2:hash_map_perf kmalloc 161138 events per sec
3:hash_map_perf kmalloc 161138 events per sec
4:hash_map_perf kmalloc 158535 events per sec
5:hash_map_perf kmalloc 161456 events per sec
6:hash_map_perf kmalloc 160277 events per sec
7:hash_map_perf kmalloc 159522 events per sec

htab-mem-benchmark (after):
overwrite           per-prod-op 49.11 ± 1.30k/s, avg mem 313.09 ± 80.36MiB, peak mem 509.09MiB
batch_add_batch_del per-prod-op 76.06 ± 2.38k/s, avg mem 287.97 ± 63.59MiB, peak mem 496.81MiB
add_del_on_diff_cpu per-prod-op 18.75 ± 0.09k/s, avg mem  27.71 ±  4.92MiB, peak mem  44.54MiB

map_perf_test (after)
2:hash_map_perf kmalloc 167714 events per sec
0:hash_map_perf kmalloc 118467 events per sec
4:hash_map_perf kmalloc 116437 events per sec
1:hash_map_perf kmalloc 115299 events per sec
5:hash_map_perf kmalloc 116043 events per sec
7:hash_map_perf kmalloc 115735 events per sec
6:hash_map_perf kmalloc 115219 events per sec
3:hash_map_perf kmalloc 113883 events per sec

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 333 ++++++++++++++++++++++++++----------------
 1 file changed, 208 insertions(+), 125 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 0668bcd7c926..9b31c53fd285 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -96,19 +96,33 @@ struct bpf_mem_cache {
 	int unit_size;
 	/* count of objects in free_llist */
 	int free_cnt;
-	int low_watermark, high_watermark, batch;
+	int prepare_reuse_cnt;
+	int watermark, batch;
 	int percpu_size;
+	bool direct_free;
+	raw_spinlock_t lock;
 
-	struct rcu_head rcu;
+	struct rcu_head reuse_rh;
+	struct rcu_head free_rh;
 	struct llist_head free_by_rcu;
 	struct llist_head waiting_for_gp;
-	atomic_t call_rcu_in_progress;
+	struct llist_head reuse_ready;
+	struct llist_head wait_for_free;
+	atomic_t reuse_rcu_in_progress;
+	atomic_t free_rcu_in_progress;
+	atomic_t dyn_reuse_rcu_cnt;
 };
 
 struct bpf_mem_caches {
 	struct bpf_mem_cache cache[NUM_CACHES];
 };
 
+struct bpf_reuse_batch {
+	struct bpf_mem_cache *c;
+	struct llist_node *head;
+	struct rcu_head rcu;
+};
+
 static struct llist_node notrace *__llist_del_first(struct llist_head *head)
 {
 	struct llist_node *entry, *next;
@@ -153,6 +167,46 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 #endif
 }
 
+static int bpf_ma_get_reusable_obj(struct bpf_mem_cache *c, int cnt)
+{
+	struct llist_node *head = NULL, *tail = NULL, *obj;
+	unsigned long flags;
+	int alloc = 0;
+
+	if (llist_empty(&c->reuse_ready) && llist_empty(&c->wait_for_free))
+		return 0;
+
+	raw_spin_lock_irqsave(&c->lock, flags);
+	while (alloc < cnt) {
+		obj = __llist_del_first(&c->reuse_ready);
+		if (!obj) {
+			obj = __llist_del_first(&c->wait_for_free);
+			if (!obj)
+				break;
+		}
+		if (!tail)
+			tail = obj;
+		obj->next = head;
+		head = obj;
+		alloc++;
+	}
+	raw_spin_unlock_irqrestore(&c->lock, flags);
+
+	if (!alloc)
+		goto out;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_save(flags);
+	WARN_ON_ONCE(local_inc_return(&c->active) != 1);
+	__llist_add_batch(head, tail, &c->free_llist);
+	c->free_cnt += alloc;
+	local_dec(&c->active);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_restore(flags);
+out:
+	return alloc;
+}
+
 /* Mostly runs from irq_work except __init phase. */
 static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 {
@@ -161,32 +215,21 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	void *obj;
 	int i;
 
+	i = bpf_ma_get_reusable_obj(c, cnt);
+	if (i >= cnt)
+		return;
+
 	memcg = get_memcg(c);
 	old_memcg = set_active_memcg(memcg);
-	for (i = 0; i < cnt; i++) {
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
+	for (; i < cnt; i++) {
+		/* Allocate, but don't deplete atomic reserves that typical
+		 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
+		 * will allocate from the current numa node which is what we
+		 * want here.
 		 */
-		obj = __llist_del_first(&c->free_by_rcu);
-		if (!obj) {
-			/* Allocate, but don't deplete atomic reserves that typical
-			 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
-			 * will allocate from the current numa node which is what we
-			 * want here.
-			 */
-			obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
-			if (!obj)
-				break;
-		}
+		obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
+		if (!obj)
+			break;
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			/* In RT irq_work runs in per-cpu kthread, so disable
 			 * interrupts to avoid preemption and interrupts and
@@ -230,100 +273,131 @@ static void free_all(struct llist_node *llnode, bool percpu)
 		free_one(pos, percpu);
 }
 
-static void __free_rcu(struct rcu_head *head)
+static void free_rcu(struct rcu_head *rcu)
 {
-	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+	struct bpf_mem_cache *c = container_of(rcu, struct bpf_mem_cache, free_rh);
+	struct llist_node *head;
+	unsigned long flags;
 
-	free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
-	atomic_set(&c->call_rcu_in_progress, 0);
-}
+	/* Draining or alloc_bulk() may be in progress */
+	raw_spin_lock_irqsave(&c->lock, flags);
+	head = __llist_del_all(&c->wait_for_free);
+	raw_spin_unlock_irqrestore(&c->lock, flags);
 
-static void __free_rcu_tasks_trace(struct rcu_head *head)
-{
-	/* If RCU Tasks Trace grace period implies RCU grace period,
-	 * there is no need to invoke call_rcu().
-	 */
-	if (rcu_trace_implies_rcu_gp())
-		__free_rcu(head);
-	else
-		call_rcu(head, __free_rcu);
+	free_all(head, !!c->percpu_size);
+	atomic_set(&c->free_rcu_in_progress, 0);
 }
 
-static void enque_to_free(struct bpf_mem_cache *c, void *obj)
+static void bpf_ma_add_to_reuse_ready_or_free(struct bpf_mem_cache *c, struct llist_node *head)
 {
-	struct llist_node *llnode = obj;
+	bool direct_free = false;
+	struct llist_node *tail;
+	unsigned long flags;
 
-	/* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
-	 * Nothing races to add to free_by_rcu list.
+	tail = head;
+	while (tail->next)
+		tail = tail->next;
+
+	raw_spin_lock_irqsave(&c->lock, flags);
+	/* Don't move these objects to reuse_ready list and free
+	 * these objects directly.
 	 */
-	__llist_add(llnode, &c->free_by_rcu);
+	if (c->direct_free) {
+		direct_free = true;
+		goto unlock;
+	}
+
+	__llist_add_batch(head, tail, &c->reuse_ready);
+
+	if (atomic_xchg(&c->free_rcu_in_progress, 1))
+		goto unlock;
+
+	WARN_ON_ONCE(!llist_empty(&c->wait_for_free));
+	c->wait_for_free.first = __llist_del_all(&c->reuse_ready);
+	raw_spin_unlock_irqrestore(&c->lock, flags);
+	call_rcu_tasks_trace(&c->free_rh, free_rcu);
+	return;
+
+unlock:
+	raw_spin_unlock_irqrestore(&c->lock, flags);
+	if (direct_free)
+		free_all(head, !!c->percpu_size);
+	return;
 }
 
-static void do_call_rcu(struct bpf_mem_cache *c)
+static void reuse_rcu(struct rcu_head *rcu)
 {
-	struct llist_node *llnode, *t;
+	struct bpf_mem_cache *c = container_of(rcu, struct bpf_mem_cache, reuse_rh);
+	struct llist_node *head;
+
+	head = llist_del_all(&c->waiting_for_gp);
+	/* Draining is in progress ? */
+	if (head)
+		bpf_ma_add_to_reuse_ready_or_free(c, head);
+	atomic_set(&c->reuse_rcu_in_progress, 0);
+}
 
-	if (atomic_xchg(&c->call_rcu_in_progress, 1))
-		return;
+static void dyn_reuse_rcu(struct rcu_head *rcu)
+{
+	struct bpf_reuse_batch *batch = container_of(rcu, struct bpf_reuse_batch, rcu);
+	struct bpf_mem_cache *c = batch->c;
 
-	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
-	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
-		/* There is no concurrent __llist_add(waiting_for_gp) access.
-		 * It doesn't race with llist_del_all either.
-		 * But there could be two concurrent llist_del_all(waiting_for_gp):
-		 * from __free_rcu() and from drain_mem_cache().
-		 */
-		__llist_add(llnode, &c->waiting_for_gp);
-	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
-	 * If RCU Tasks Trace grace period implies RCU grace period, free
-	 * these elements directly, else use call_rcu() to wait for normal
-	 * progs to finish and finally do free_one() on each element.
-	 */
-	call_rcu_tasks_trace(&c->rcu, __free_rcu_tasks_trace);
+	bpf_ma_add_to_reuse_ready_or_free(c, batch->head);
+	atomic_dec(&c->dyn_reuse_rcu_cnt);
+	kfree(batch);
 }
 
-static void free_bulk(struct bpf_mem_cache *c)
+static void reuse_bulk(struct bpf_mem_cache *c)
 {
-	struct llist_node *llnode, *t;
+	struct llist_node *head, *tail;
+	struct bpf_reuse_batch *batch;
 	unsigned long flags;
-	int cnt;
 
-	do {
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_save(flags);
-		WARN_ON_ONCE(local_inc_return(&c->active) != 1);
-		llnode = __llist_del_first(&c->free_llist);
-		if (llnode)
-			cnt = --c->free_cnt;
-		else
-			cnt = 0;
-		local_dec(&c->active);
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_restore(flags);
-		if (llnode)
-			enque_to_free(c, llnode);
-	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
+	head = llist_del_all(&c->free_llist_extra);
+	tail = head;
+	while (tail && tail->next)
+		tail = tail->next;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_save(flags);
+	WARN_ON_ONCE(local_inc_return(&c->active) != 1);
+	if (head)
+		__llist_add_batch(head, tail, &c->free_by_rcu);
+	c->prepare_reuse_cnt = 0;
+	local_dec(&c->active);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_restore(flags);
+
+	batch = kmalloc(sizeof(*batch), GFP_NOWAIT | __GFP_NOWARN);
+	if (batch) {
+		batch->c = c;
+		batch->head = __llist_del_all(&c->free_by_rcu);
+		atomic_inc(&c->dyn_reuse_rcu_cnt);
+		call_rcu(&batch->rcu, dyn_reuse_rcu);
+		return;
+	}
+
+	if (atomic_xchg(&c->reuse_rcu_in_progress, 1))
+		return;
 
-	/* and drain free_llist_extra */
-	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
-		enque_to_free(c, llnode);
-	do_call_rcu(c);
+	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
+	c->waiting_for_gp.first = __llist_del_all(&c->free_by_rcu);
+	call_rcu(&c->reuse_rh, reuse_rcu);
 }
 
 static void bpf_mem_refill(struct irq_work *work)
 {
 	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work);
-	int cnt;
 
 	/* Racy access to free_cnt. It doesn't need to be 100% accurate */
-	cnt = c->free_cnt;
-	if (cnt < c->low_watermark)
+	if (c->free_cnt <= c->watermark)
 		/* irq_work runs on this cpu and kmalloc will allocate
 		 * from the current numa node which is what we want here.
 		 */
 		alloc_bulk(c, c->batch, NUMA_NO_NODE);
-	else if (cnt > c->high_watermark)
-		free_bulk(c);
+
+	if (c->prepare_reuse_cnt >= c->watermark)
+		reuse_bulk(c);
 }
 
 static void notrace irq_work_raise(struct bpf_mem_cache *c)
@@ -335,7 +409,7 @@ static void notrace irq_work_raise(struct bpf_mem_cache *c)
  * the freelist cache will be elem_size * 64 (or less) on each cpu.
  *
  * For bpf programs that don't have statically known allocation sizes and
- * assuming (low_mark + high_mark) / 2 as an average number of elements per
+ * assuming watermark * 2 as an average number of elements per
  * bucket and all buckets are used the total amount of memory in freelists
  * on each cpu will be:
  * 64*16 + 64*32 + 64*64 + 64*96 + 64*128 + 64*196 + 64*256 + 32*512 + 16*1024 + 8*2048 + 4*4096
@@ -349,19 +423,15 @@ static void notrace irq_work_raise(struct bpf_mem_cache *c)
 static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 {
 	init_irq_work(&c->refill_work, bpf_mem_refill);
-	if (c->unit_size <= 256) {
-		c->low_watermark = 32;
-		c->high_watermark = 96;
-	} else {
-		/* When page_size == 4k, order-0 cache will have low_mark == 2
-		 * and high_mark == 6 with batch alloc of 3 individual pages at
-		 * a time.
-		 * 8k allocs and above low == 1, high == 3, batch == 1.
+	if (c->unit_size <= 256)
+		c->watermark = 32;
+	else
+		/* When page_size == 4k, order-0 cache will have mark == 2
+		 * with batch alloc of 2 individual pages at a time.
+		 * 8k allocs and above low == 1, batch == 1.
 		 */
-		c->low_watermark = max(32 * 256 / c->unit_size, 1);
-		c->high_watermark = max(96 * 256 / c->unit_size, 3);
-	}
-	c->batch = max((c->high_watermark - c->low_watermark) / 4 * 3, 1);
+		c->watermark = max(32 * 256 / c->unit_size, 1);
+	c->batch = c->watermark;
 
 	/* To avoid consuming memory assume that 1st run of bpf
 	 * prog won't be doing more than 4 map_update_elem from
@@ -406,6 +476,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->unit_size = unit_size;
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
+			raw_spin_lock_init(&c->lock);
 			prefill_mem_cache(c, cpu);
 		}
 		ma->cache = pc;
@@ -428,6 +499,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c = &cc->cache[i];
 			c->unit_size = sizes[i];
 			c->objcg = objcg;
+			raw_spin_lock_init(&c->lock);
 			prefill_mem_cache(c, cpu);
 		}
 	}
@@ -438,16 +510,28 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 static void drain_mem_cache(struct bpf_mem_cache *c)
 {
 	bool percpu = !!c->percpu_size;
+	struct llist_node *head[2];
+	unsigned long flags;
 
 	/* No progs are using this bpf_mem_cache, but htab_map_free() called
 	 * bpf_mem_cache_free() for all remaining elements and they can be in
 	 * free_by_rcu or in waiting_for_gp lists, so drain those lists now.
 	 *
-	 * Except for waiting_for_gp list, there are no concurrent operations
-	 * on these lists, so it is safe to use __llist_del_all().
+	 * Except for waiting_for_gp, reuse_ready and wait_for_free list,
+	 * there are no concurrent operations on these lists, so it is safe
+	 * to use __llist_del_all().
 	 */
 	free_all(__llist_del_all(&c->free_by_rcu), percpu);
 	free_all(llist_del_all(&c->waiting_for_gp), percpu);
+
+	raw_spin_lock_irqsave(&c->lock, flags);
+	c->direct_free = true;
+	head[0] = __llist_del_all(&c->reuse_ready);
+	head[1] = __llist_del_all(&c->wait_for_free);
+	raw_spin_unlock_irqrestore(&c->lock, flags);
+	free_all(head[0], percpu);
+	free_all(head[1], percpu);
+
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
 }
@@ -462,19 +546,13 @@ static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 
 static void free_mem_alloc(struct bpf_mem_alloc *ma)
 {
-	/* waiting_for_gp lists was drained, but __free_rcu might
-	 * still execute. Wait for it now before we freeing percpu caches.
-	 *
-	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
-	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
-	 * to wait for the pending __free_rcu_tasks_trace() and __free_rcu(),
-	 * so if call_rcu(head, __free_rcu) is skipped due to
-	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
-	 * using rcu_trace_implies_rcu_gp() as well.
+	/* Use rcu_barrier() to wait for the pending reuse_rcu() and use
+	 * rcu_barrier_tasks_trace() to wait for the pending free_rcu().
+	 * direct_free has already been set to prevent reuse_rcu() from
+	 * calling freee_rcu() again.
 	 */
+	rcu_barrier();
 	rcu_barrier_tasks_trace();
-	if (!rcu_trace_implies_rcu_gp())
-		rcu_barrier();
 	free_mem_alloc_no_barrier(ma);
 }
 
@@ -535,7 +613,9 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			 */
 			irq_work_sync(&c->refill_work);
 			drain_mem_cache(c);
-			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
+			rcu_in_progress += atomic_read(&c->reuse_rcu_in_progress);
+			rcu_in_progress += atomic_read(&c->free_rcu_in_progress);
+			rcu_in_progress += atomic_read(&c->dyn_reuse_rcu_cnt);
 		}
 		/* objcg is the same across cpus */
 		if (c->objcg)
@@ -550,7 +630,9 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				c = &cc->cache[i];
 				irq_work_sync(&c->refill_work);
 				drain_mem_cache(c);
-				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
+				rcu_in_progress += atomic_read(&c->reuse_rcu_in_progress);
+				rcu_in_progress += atomic_read(&c->free_rcu_in_progress);
+				rcu_in_progress += atomic_read(&c->dyn_reuse_rcu_cnt);
 			}
 		}
 		if (c->objcg)
@@ -589,14 +671,14 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 
 	WARN_ON(cnt < 0);
 
-	if (cnt < c->low_watermark)
+	if (cnt <= c->watermark)
 		irq_work_raise(c);
 	return llnode;
 }
 
 /* Though 'ptr' object could have been allocated on a different cpu
- * add it to the free_llist of the current cpu.
- * Let kfree() logic deal with it when it's later called from irq_work.
+ * add it to the free_by_rcu list of the current cpu.
+ * Let kfree() logic deal with it when it's later called from RCU cb.
  */
 static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 {
@@ -607,12 +689,13 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 	BUILD_BUG_ON(LLIST_NODE_SZ > 8);
 
 	local_irq_save(flags);
+	/* In case a NMI-context bpf program is also freeing object. */
 	if (local_inc_return(&c->active) == 1) {
-		__llist_add(llnode, &c->free_llist);
-		cnt = ++c->free_cnt;
+		__llist_add(llnode, &c->free_by_rcu);
+		cnt = ++c->prepare_reuse_cnt;
 	} else {
 		/* unit_free() cannot fail. Therefore add an object to atomic
-		 * llist. free_bulk() will drain it. Though free_llist_extra is
+		 * llist. reuse_bulk() will drain it. Though free_llist_extra is
 		 * a per-cpu list we have to use atomic llist_add here, since
 		 * it also can be interrupted by bpf nmi prog that does another
 		 * unit_free() into the same free_llist_extra.
@@ -622,7 +705,7 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 	local_dec(&c->active);
 	local_irq_restore(flags);
 
-	if (cnt > c->high_watermark)
+	if (cnt >= c->watermark)
 		/* free few objects from current cpu into global kmalloc pool */
 		irq_work_raise(c);
 }
-- 
2.29.2


