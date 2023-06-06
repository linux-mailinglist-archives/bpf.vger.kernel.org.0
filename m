Return-Path: <bpf+bounces-1912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 190A57235B7
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 05:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749F41C20E3D
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 03:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EF1A3C;
	Tue,  6 Jun 2023 03:21:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598B880A
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 03:21:02 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE36E45;
	Mon,  5 Jun 2023 20:20:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QZwjK2nF4z4f3wRB;
	Tue,  6 Jun 2023 11:20:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBn0LMRpn5kcOYrLA--.7742S7;
	Tue, 06 Jun 2023 11:20:54 +0800 (CST)
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
Subject: [RFC PATCH bpf-next v4 3/3] bpf: Only reuse after one RCU GP in bpf memory allocator
Date: Tue,  6 Jun 2023 11:53:10 +0800
Message-Id: <20230606035310.4026145-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230606035310.4026145-1-houtao@huaweicloud.com>
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn0LMRpn5kcOYrLA--.7742S7
X-Coremail-Antispam: 1UD129KBjvAXoWftFWxWr4kGrW3KryUZw4ruFg_yoW8tFW7Jo
	Wfur45Gr18KFyIyFWv9a4qkFsI9wn0g34DArZ5XFZ8Za4UXrW5t3ZakF43Aa4aqFWrCF4k
	Zw1UKw4DCr4fGry3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYX7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	Wl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Currently the freed objects in bpf memory allocator may be reused
immediately by new allocation, it introduces use-after-bpf-ma-free
problem for non-preallocated hash map and makes lookup procedure
return incorrect result. The immediate reuse also makes introducing
new use case more difficult (e.g. qp-trie).

So implement reuse-after-RCU-GP to solve these problems. For
reuse-after-RCU-GP, the freed objects are reused only after one RCU
grace period and may be returned back to slab system after another
RCU-tasks-trace grace period. So for bpf programs which care about reuse
problem, these programs can use bpf_rcu_read_{lock,unlock}() to access
these freed objects safely and for those which doesn't care, there will
be safely use-after-bpf-ma-free because these objects have not been
freed by bpf memory allocator.

To handle the use case which does allocation and free on different CPUs,
a per-bpf-mem-alloc list is introduced to keep these reusable objects.
In order to reduce the risk of OOM, part of these reusable objects will
be freed and returned back to slab through RCU-tasks-trace call-back.
Before these freeing objects are freed, these objects are also available
for reuse.

As shown in the following benchmark results, the memory usage increases
a lot and the performance of overwrite and batch_op case is also
degraded. The benchmark is conducted on a KVM-VM with 8-CPUs and 16GB
memory. The command line for htab-mem-benchmark is:

  ./bench htab-mem --use-case $name --max-entries 16384 \
		          --full 50 -d 10 --producers=8
			  --prod-affinity=0-7

And the command line for map_perf_test benchmark is:
  ./map_perf_test 4 8 16384

htab-mem-benchmark (before):
| name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
| --                 | --        | --                  | --               |
| no_op              | 1160.66   | 0.99                | 1.00             |
| overwrite          | 28.52     | 2.46                | 2.73             |
| batch_add_batch_del| 11.50     | 2.69                | 2.95             |
| add_del_on_diff_cpu| 3.75      | 15.85               | 24.24            |

map_perf_test (before)
2:hash_map_perf kmalloc 384527 events per sec
7:hash_map_perf kmalloc 359707 events per sec
6:hash_map_perf kmalloc 314229 events per sec
0:hash_map_perf kmalloc 306743 events per sec
3:hash_map_perf kmalloc 309987 events per sec
4:hash_map_perf kmalloc 309012 events per sec
1:hash_map_perf kmalloc 295757 events per sec
5:hash_map_perf kmalloc 292229 events per sec

htab-mem-benchmark (after):
| name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
| --                 | --        | --                  | --               |
| no_op              | 1159.18   | 0.99                | 0.99             |
| overwrite          | 11.00     | 2288                | 4109             |
| batch_add_batch_del| 8.86      | 1558                | 2763             |
| add_del_on_diff_cpu| 4.74      | 11.39               | 14.77            |

map_perf_test (after)
0:hash_map_perf kmalloc 194677 events per sec
4:hash_map_perf kmalloc 194177 events per sec
1:hash_map_perf kmalloc 180662 events per sec
6:hash_map_perf kmalloc 181310 events per sec
5:hash_map_perf kmalloc 177213 events per sec
2:hash_map_perf kmalloc 173069 events per sec
3:hash_map_perf kmalloc 166792 events per sec
7:hash_map_perf kmalloc 165253 events per sec

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_mem_alloc.h |   4 +
 kernel/bpf/memalloc.c         | 366 ++++++++++++++++++++++++----------
 2 files changed, 263 insertions(+), 107 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 3929be5743f4..69f84a21520b 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -7,10 +7,14 @@
 
 struct bpf_mem_cache;
 struct bpf_mem_caches;
+struct bpf_mem_shared_cache;
+struct bpf_mem_shared_caches;
 
 struct bpf_mem_alloc {
 	struct bpf_mem_caches __percpu *caches;
 	struct bpf_mem_cache __percpu *cache;
+	struct bpf_mem_shared_cache *s_cache;
+	struct bpf_mem_shared_caches *s_caches;
 	struct work_struct work;
 };
 
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 0668bcd7c926..fea1cb0c78bb 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -74,6 +74,17 @@ static int bpf_mem_cache_idx(size_t size)
 	return fls(size - 1) - 2;
 }
 
+struct bpf_mem_shared_cache {
+	raw_spinlock_t reuse_lock;
+	bool percpu;
+	bool direct_free;
+	struct llist_head reuse_ready_head;
+	struct llist_node *reuse_ready_tail;
+	struct llist_head wait_for_free;
+	atomic_t call_rcu_in_progress;
+	struct rcu_head rcu;
+};
+
 #define NUM_CACHES 11
 
 struct bpf_mem_cache {
@@ -98,10 +109,17 @@ struct bpf_mem_cache {
 	int free_cnt;
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
+	struct llist_head prepare_reuse_head;
+	struct llist_node *prepare_reuse_tail;
+	unsigned int prepare_reuse_cnt;
+	raw_spinlock_t lock;
 
+	struct bpf_mem_shared_cache *sc;
 	struct rcu_head rcu;
 	struct llist_head free_by_rcu;
+	struct llist_node *free_by_rcu_tail;
 	struct llist_head waiting_for_gp;
+	struct llist_node *waiting_for_gp_tail;
 	atomic_t call_rcu_in_progress;
 };
 
@@ -109,6 +127,10 @@ struct bpf_mem_caches {
 	struct bpf_mem_cache cache[NUM_CACHES];
 };
 
+struct bpf_mem_shared_caches {
+	struct bpf_mem_shared_cache cache[NUM_CACHES];
+};
+
 static struct llist_node notrace *__llist_del_first(struct llist_head *head)
 {
 	struct llist_node *entry, *next;
@@ -153,6 +175,52 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 #endif
 }
 
+static int bpf_ma_get_reusable_obj(struct bpf_mem_cache *c, int cnt)
+{
+	struct bpf_mem_shared_cache *sc = c->sc;
+	struct llist_node *head, *tail, *obj;
+	unsigned long flags;
+	int alloc;
+
+	if (llist_empty(&sc->reuse_ready_head) && llist_empty(&sc->wait_for_free))
+		return 0;
+
+	alloc = 0;
+	head = NULL;
+	tail = NULL;
+	raw_spin_lock_irqsave(&sc->reuse_lock, flags);
+	while (alloc < cnt) {
+		obj = __llist_del_first(&sc->reuse_ready_head);
+		if (obj) {
+			if (llist_empty(&sc->reuse_ready_head))
+				sc->reuse_ready_tail = NULL;
+		} else {
+			obj = __llist_del_first(&sc->wait_for_free);
+			if (!obj)
+				break;
+		}
+		if (!tail)
+			tail = obj;
+		obj->next = head;
+		head = obj;
+		alloc++;
+	}
+	raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
+
+	if (alloc) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_save(flags);
+		WARN_ON_ONCE(local_inc_return(&c->active) != 1);
+		__llist_add_batch(head, tail, &c->free_llist);
+		c->free_cnt += alloc;
+		local_dec(&c->active);
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_restore(flags);
+	}
+
+	return alloc;
+}
+
 /* Mostly runs from irq_work except __init phase. */
 static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 {
@@ -161,32 +229,19 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 	void *obj;
 	int i;
 
+	i = bpf_ma_get_reusable_obj(c, cnt);
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
@@ -230,100 +285,125 @@ static void free_all(struct llist_node *llnode, bool percpu)
 		free_one(pos, percpu);
 }
 
-static void __free_rcu(struct rcu_head *head)
+static void free_rcu(struct rcu_head *rcu)
 {
-	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+	struct bpf_mem_shared_cache *sc = container_of(rcu, struct bpf_mem_shared_cache, rcu);
+	struct llist_node *head;
+	unsigned long flags;
 
-	free_all(llist_del_all(&c->waiting_for_gp), !!c->percpu_size);
-	atomic_set(&c->call_rcu_in_progress, 0);
+	raw_spin_lock_irqsave(&sc->reuse_lock, flags);
+	head = __llist_del_all(&sc->wait_for_free);
+	raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
+	free_all(head, sc->percpu);
+	atomic_set(&sc->call_rcu_in_progress, 0);
 }
 
-static void __free_rcu_tasks_trace(struct rcu_head *head)
+static void bpf_ma_add_to_reuse_ready_or_free(struct bpf_mem_cache *c)
 {
-	/* If RCU Tasks Trace grace period implies RCU grace period,
-	 * there is no need to invoke call_rcu().
-	 */
-	if (rcu_trace_implies_rcu_gp())
-		__free_rcu(head);
-	else
-		call_rcu(head, __free_rcu);
-}
+	struct bpf_mem_shared_cache *sc = c->sc;
+	struct llist_node *head, *tail;
+	unsigned long flags;
 
-static void enque_to_free(struct bpf_mem_cache *c, void *obj)
-{
-	struct llist_node *llnode = obj;
+	/* Draining could be running concurrently with reuse_rcu() */
+	raw_spin_lock_irqsave(&c->lock, flags);
+	head = __llist_del_all(&c->waiting_for_gp);
+	tail = c->waiting_for_gp_tail;
+	c->waiting_for_gp_tail = NULL;
+	raw_spin_unlock_irqrestore(&c->lock, flags);
+	/* Draining is in progress ? */
+	if (!head)
+		return;
 
-	/* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
-	 * Nothing races to add to free_by_rcu list.
+	raw_spin_lock_irqsave(&sc->reuse_lock, flags);
+	/* Don't move these objects to reuse_ready list and free
+	 * these objects directly.
 	 */
-	__llist_add(llnode, &c->free_by_rcu);
+	if (sc->direct_free) {
+		raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
+		free_all(head, sc->percpu);
+		return;
+	}
+
+	if (llist_empty(&sc->reuse_ready_head))
+		sc->reuse_ready_tail = tail;
+	__llist_add_batch(head, tail, &sc->reuse_ready_head);
+
+	if (!atomic_xchg(&sc->call_rcu_in_progress, 1)) {
+		head = __llist_del_all(&sc->reuse_ready_head);
+		tail = sc->reuse_ready_tail;
+		sc->reuse_ready_tail = NULL;
+		WARN_ON_ONCE(!llist_empty(&sc->wait_for_free));
+		__llist_add_batch(head, tail, &sc->wait_for_free);
+		call_rcu_tasks_trace(&sc->rcu, free_rcu);
+	}
+	raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
 }
 
-static void do_call_rcu(struct bpf_mem_cache *c)
+static void reuse_rcu(struct rcu_head *rcu)
 {
-	struct llist_node *llnode, *t;
-
-	if (atomic_xchg(&c->call_rcu_in_progress, 1))
-		return;
+	struct bpf_mem_cache *c = container_of(rcu, struct bpf_mem_cache, rcu);
 
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
+	bpf_ma_add_to_reuse_ready_or_free(c);
+	atomic_set(&c->call_rcu_in_progress, 0);
 }
 
-static void free_bulk(struct bpf_mem_cache *c)
+static void reuse_bulk(struct bpf_mem_cache *c)
 {
-	struct llist_node *llnode, *t;
+	struct llist_node *head, *tail, *llnode, *tmp;
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
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_save(flags);
+	WARN_ON_ONCE(local_inc_return(&c->active) != 1);
+	head = __llist_del_all(&c->prepare_reuse_head);
+	tail = c->prepare_reuse_tail;
+	c->prepare_reuse_tail = NULL;
+	c->prepare_reuse_cnt = 0;
+	local_dec(&c->active);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_restore(flags);
+
+	llist_for_each_safe(llnode, tmp, llist_del_all(&c->free_llist_extra)) {
+		if (!head)
+			tail = llnode;
+		llnode->next = head;
+		head = llnode->next;
+	}
+	WARN_ON_ONCE(!head);
+
+	/* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
+	 * Nothing races to add to free_by_rcu list.
+	 */
+	if (llist_empty(&c->free_by_rcu))
+		c->free_by_rcu_tail = tail;
+	__llist_add_batch(head, tail, &c->free_by_rcu);
+
+	if (atomic_xchg(&c->call_rcu_in_progress, 1))
+		return;
 
-	/* and drain free_llist_extra */
-	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
-		enque_to_free(c, llnode);
-	do_call_rcu(c);
+	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
+	head = __llist_del_all(&c->free_by_rcu);
+	tail = c->free_by_rcu_tail;
+	c->free_by_rcu_tail = NULL;
+	if (llist_empty(&c->waiting_for_gp))
+		c->waiting_for_gp_tail = tail;
+	__llist_add_batch(head, tail, &c->waiting_for_gp);
+	call_rcu(&c->rcu, reuse_rcu);
 }
 
 static void bpf_mem_refill(struct irq_work *work)
 {
 	struct bpf_mem_cache *c = container_of(work, struct bpf_mem_cache, refill_work);
-	int cnt;
 
 	/* Racy access to free_cnt. It doesn't need to be 100% accurate */
-	cnt = c->free_cnt;
-	if (cnt < c->low_watermark)
+	if (c->free_cnt < c->low_watermark)
 		/* irq_work runs on this cpu and kmalloc will allocate
 		 * from the current numa node which is what we want here.
 		 */
 		alloc_bulk(c, c->batch, NUMA_NO_NODE);
-	else if (cnt > c->high_watermark)
-		free_bulk(c);
+
+	if (c->prepare_reuse_cnt > c->high_watermark)
+		reuse_bulk(c);
 }
 
 static void notrace irq_work_raise(struct bpf_mem_cache *c)
@@ -370,6 +450,12 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu));
 }
 
+static inline void shared_cache_init(struct bpf_mem_shared_cache *cache, bool percpu)
+{
+	cache->percpu = percpu;
+	raw_spin_lock_init(&cache->reuse_lock);
+}
+
 /* When size != 0 bpf_mem_cache for each cpu.
  * This is typical bpf hash map use case when all elements have equal size.
  *
@@ -382,13 +468,22 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
 	struct bpf_mem_caches *cc, __percpu *pcc;
 	struct bpf_mem_cache *c, __percpu *pc;
+	struct bpf_mem_shared_caches *scc;
+	struct bpf_mem_shared_cache *sc;
 	struct obj_cgroup *objcg = NULL;
 	int cpu, i, unit_size, percpu_size = 0;
 
 	if (size) {
+		sc = kzalloc(sizeof(*sc), GFP_KERNEL);
+		if (!sc)
+			return -ENOMEM;
+		shared_cache_init(sc, percpu);
+
 		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
-		if (!pc)
+		if (!pc) {
+			kfree(sc);
 			return -ENOMEM;
+		}
 
 		if (percpu)
 			/* room for llist_node and per-cpu pointer */
@@ -406,9 +501,12 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->unit_size = unit_size;
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
+			raw_spin_lock_init(&c->lock);
+			c->sc = sc;
 			prefill_mem_cache(c, cpu);
 		}
 		ma->cache = pc;
+		ma->s_cache = sc;
 		return 0;
 	}
 
@@ -416,28 +514,56 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 	if (WARN_ON_ONCE(percpu))
 		return -EINVAL;
 
+	scc = kzalloc(sizeof(*scc), GFP_KERNEL);
+	if (!scc)
+		return -ENOMEM;
 	pcc = __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL);
-	if (!pcc)
+	if (!pcc) {
+		kfree(scc);
 		return -ENOMEM;
+	}
 #ifdef CONFIG_MEMCG_KMEM
 	objcg = get_obj_cgroup_from_current();
 #endif
+	for (i = 0; i < NUM_CACHES; i++)
+		shared_cache_init(&scc->cache[i], 0);
 	for_each_possible_cpu(cpu) {
 		cc = per_cpu_ptr(pcc, cpu);
 		for (i = 0; i < NUM_CACHES; i++) {
 			c = &cc->cache[i];
 			c->unit_size = sizes[i];
 			c->objcg = objcg;
+			raw_spin_lock_init(&c->lock);
+			c->sc = &scc->cache[i];
 			prefill_mem_cache(c, cpu);
 		}
 	}
 	ma->caches = pcc;
+	ma->s_caches = scc;
 	return 0;
 }
 
+static void drain_shared_mem_cache(struct bpf_mem_shared_cache *sc)
+{
+	struct llist_node *head[2];
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&sc->reuse_lock, flags);
+	sc->direct_free = true;
+	head[0] = __llist_del_all(&sc->reuse_ready_head);
+	sc->reuse_ready_tail = NULL;
+	head[1] = __llist_del_all(&sc->wait_for_free);
+	raw_spin_unlock_irqrestore(&sc->reuse_lock, flags);
+
+	free_all(head[0], sc->percpu);
+	free_all(head[1], sc->percpu);
+}
+
 static void drain_mem_cache(struct bpf_mem_cache *c)
 {
 	bool percpu = !!c->percpu_size;
+	struct llist_node *head;
+	unsigned long flags;
 
 	/* No progs are using this bpf_mem_cache, but htab_map_free() called
 	 * bpf_mem_cache_free() for all remaining elements and they can be in
@@ -447,34 +573,44 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	 * on these lists, so it is safe to use __llist_del_all().
 	 */
 	free_all(__llist_del_all(&c->free_by_rcu), percpu);
-	free_all(llist_del_all(&c->waiting_for_gp), percpu);
+	c->free_by_rcu_tail = NULL;
+
+	/* Use lock to update head and tail atomically */
+	raw_spin_lock_irqsave(&c->lock, flags);
+	head = __llist_del_all(&c->waiting_for_gp);
+	c->waiting_for_gp_tail = NULL;
+	raw_spin_unlock_irqrestore(&c->lock, flags);
+	free_all(head, percpu);
+
 	free_all(__llist_del_all(&c->free_llist), percpu);
 	free_all(__llist_del_all(&c->free_llist_extra), percpu);
+
+	head = __llist_del_all(&c->prepare_reuse_head);
+	c->prepare_reuse_tail = NULL;
+	free_all(head, percpu);
 }
 
 static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
 {
 	free_percpu(ma->cache);
 	free_percpu(ma->caches);
+	kfree(ma->s_cache);
+	kfree(ma->s_caches);
 	ma->cache = NULL;
 	ma->caches = NULL;
+	ma->s_cache = NULL;
+	ma->s_caches = NULL;
 }
 
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
 
@@ -507,15 +643,20 @@ static void destroy_mem_alloc(struct bpf_mem_alloc *ma, int rcu_in_progress)
 
 	/* Defer barriers into worker to let the rest of map memory to be freed */
 	copy->cache = ma->cache;
+	copy->s_cache = ma->s_cache;
 	ma->cache = NULL;
+	ma->s_cache = NULL;
 	copy->caches = ma->caches;
+	copy->s_caches = ma->s_caches;
 	ma->caches = NULL;
+	ma->s_caches = NULL;
 	INIT_WORK(&copy->work, free_mem_alloc_deferred);
 	queue_work(system_unbound_wq, &copy->work);
 }
 
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 {
+	struct bpf_mem_shared_cache *sc;
 	struct bpf_mem_caches *cc;
 	struct bpf_mem_cache *c;
 	int cpu, i, rcu_in_progress;
@@ -537,6 +678,9 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			drain_mem_cache(c);
 			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 		}
+		sc = ma->s_cache;
+		drain_shared_mem_cache(sc);
+		rcu_in_progress += atomic_read(&sc->call_rcu_in_progress);
 		/* objcg is the same across cpus */
 		if (c->objcg)
 			obj_cgroup_put(c->objcg);
@@ -553,6 +697,11 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 			}
 		}
+		for (i = 0; i < NUM_CACHES; i++) {
+			sc = &ma->s_caches->cache[i];
+			drain_shared_mem_cache(sc);
+			rcu_in_progress += atomic_read(&sc->call_rcu_in_progress);
+		}
 		if (c->objcg)
 			obj_cgroup_put(c->objcg);
 		destroy_mem_alloc(ma, rcu_in_progress);
@@ -595,8 +744,8 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 }
 
 /* Though 'ptr' object could have been allocated on a different cpu
- * add it to the free_llist of the current cpu.
- * Let kfree() logic deal with it when it's later called from irq_work.
+ * add it to the prepare_reuse list of the current cpu.
+ * Let kfree() logic deal with it when it's later called from RCU cb.
  */
 static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 {
@@ -607,12 +756,15 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 	BUILD_BUG_ON(LLIST_NODE_SZ > 8);
 
 	local_irq_save(flags);
+	/* In case a NMI-context bpf program is also freeing object. */
 	if (local_inc_return(&c->active) == 1) {
-		__llist_add(llnode, &c->free_llist);
-		cnt = ++c->free_cnt;
+		if (llist_empty(&c->prepare_reuse_head))
+			c->prepare_reuse_tail = llnode;
+		__llist_add(llnode, &c->prepare_reuse_head);
+		cnt = ++c->prepare_reuse_cnt;
 	} else {
 		/* unit_free() cannot fail. Therefore add an object to atomic
-		 * llist. free_bulk() will drain it. Though free_llist_extra is
+		 * llist. reuse_bulk() will drain it. Though free_llist_extra is
 		 * a per-cpu list we have to use atomic llist_add here, since
 		 * it also can be interrupted by bpf nmi prog that does another
 		 * unit_free() into the same free_llist_extra.
-- 
2.29.2


