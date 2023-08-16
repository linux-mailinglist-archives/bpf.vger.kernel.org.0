Return-Path: <bpf+bounces-7874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F3D77D972
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 06:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C893281715
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 04:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD996C8C1;
	Wed, 16 Aug 2023 04:28:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852CC2D6;
	Wed, 16 Aug 2023 04:28:08 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BBF2112;
	Tue, 15 Aug 2023 21:28:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RQZqz2ThMz4f3lK4;
	Wed, 16 Aug 2023 12:27:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3hqlMUNxkOZhKAw--.35043S5;
	Wed, 16 Aug 2023 12:28:02 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	houtao1@huawei.com
Subject: [PATCH bpf-next 1/2] bpf, cpumap: Use queue_rcu_work() to remove unnecessary rcu_barrier()
Date: Wed, 16 Aug 2023 12:59:57 +0800
Message-Id: <20230816045959.358059-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230816045959.358059-1-houtao@huaweicloud.com>
References: <20230816045959.358059-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3hqlMUNxkOZhKAw--.35043S5
X-Coremail-Antispam: 1UD129KBjvJXoW3XryDuw4fJw47ZF1DCr45Jrb_yoW3Xr1kpF
	Wftw17Gr48Xw4v93y8Xw18Ar1Yvrs3Wa4UG340k34rA3ZxJrZxXFW0kFyIyFy5urWkur17
	CFsFqFWkGayDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn9N3UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

As for now __cpu_map_entry_replace() uses call_rcu() to wait for the
inflight xdp program to exit the RCU read critical section, and then
launch kworker cpu_map_kthread_stop() to call kthread_stop() to flush
all pending xdp frames or skbs.

But it is unnecessary to use rcu_barrier() in cpu_map_kthread_stop() to
wait for the completion of __cpu_map_entry_free(), because rcu_barrier()
will wait for all pending RCU callbacks and cpu_map_kthread_stop() only
needs to wait for the completion of a specific __cpu_map_entry_free().

So use queue_rcu_work() to replace call_rcu(), schedule_work() and
rcu_barrier(). queue_rcu_work() will queue a __cpu_map_entry_free()
kworker after a RCU grace period. Because __cpu_map_entry_free() is
running in a kworker context, so it is OK to do all of these freeing
procedures include kthread_stop() in it.

After the update, there is no need to do reference-counting for
bpf_cpu_map_entry, because bpf_cpu_map_entry is freed directly in
__cpu_map_entry_free(), so just remove it.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/cpumap.c | 96 +++++++++++++--------------------------------
 1 file changed, 27 insertions(+), 69 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index ef28c64f1eb1..93fbd3e5079e 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -68,11 +68,8 @@ struct bpf_cpu_map_entry {
 	struct bpf_cpumap_val value;
 	struct bpf_prog *prog;
 
-	atomic_t refcnt; /* Control when this struct can be free'ed */
-	struct rcu_head rcu;
-
-	struct work_struct kthread_stop_wq;
 	struct completion kthread_running;
+	struct rcu_work free_work;
 };
 
 struct bpf_cpu_map {
@@ -117,11 +114,6 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 	return &cmap->map;
 }
 
-static void get_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
-{
-	atomic_inc(&rcpu->refcnt);
-}
-
 static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 {
 	/* The tear-down procedure should have made sure that queue is
@@ -142,35 +134,6 @@ static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 	}
 }
 
-static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
-{
-	if (atomic_dec_and_test(&rcpu->refcnt)) {
-		if (rcpu->prog)
-			bpf_prog_put(rcpu->prog);
-		/* The queue should be empty at this point */
-		__cpu_map_ring_cleanup(rcpu->queue);
-		ptr_ring_cleanup(rcpu->queue, NULL);
-		kfree(rcpu->queue);
-		kfree(rcpu);
-	}
-}
-
-/* called from workqueue, to workaround syscall using preempt_disable */
-static void cpu_map_kthread_stop(struct work_struct *work)
-{
-	struct bpf_cpu_map_entry *rcpu;
-
-	rcpu = container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
-
-	/* Wait for flush in __cpu_map_entry_free(), via full RCU barrier,
-	 * as it waits until all in-flight call_rcu() callbacks complete.
-	 */
-	rcu_barrier();
-
-	/* kthread_stop will wake_up_process and wait for it to complete */
-	kthread_stop(rcpu->kthread);
-}
-
 static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
 				     struct list_head *listp,
 				     struct xdp_cpumap_stats *stats)
@@ -395,7 +358,6 @@ static int cpu_map_kthread_run(void *data)
 	}
 	__set_current_state(TASK_RUNNING);
 
-	put_cpu_map_entry(rcpu);
 	return 0;
 }
 
@@ -472,9 +434,6 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	if (IS_ERR(rcpu->kthread))
 		goto free_prog;
 
-	get_cpu_map_entry(rcpu); /* 1-refcnt for being in cmap->cpu_map[] */
-	get_cpu_map_entry(rcpu); /* 1-refcnt for kthread */
-
 	/* Make sure kthread runs on a single CPU */
 	kthread_bind(rcpu->kthread, cpu);
 	wake_up_process(rcpu->kthread);
@@ -501,40 +460,40 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	return NULL;
 }
 
-static void __cpu_map_entry_free(struct rcu_head *rcu)
+static void __cpu_map_entry_free(struct work_struct *work)
 {
 	struct bpf_cpu_map_entry *rcpu;
 
 	/* This cpu_map_entry have been disconnected from map and one
-	 * RCU grace-period have elapsed.  Thus, XDP cannot queue any
+	 * RCU grace-period have elapsed. Thus, XDP cannot queue any
 	 * new packets and cannot change/set flush_needed that can
 	 * find this entry.
 	 */
-	rcpu = container_of(rcu, struct bpf_cpu_map_entry, rcu);
+	rcpu = container_of(to_rcu_work(work), struct bpf_cpu_map_entry, free_work);
+
+	/* kthread_stop will wake_up_process and wait for it to complete.
+	 * cpu_map_kthread_run() makes sure the pointer ring is empty
+	 * before exiting.
+	 */
+	kthread_stop(rcpu->kthread);
 
+	if (rcpu->prog)
+		bpf_prog_put(rcpu->prog);
+	/* The queue should be empty at this point */
+	__cpu_map_ring_cleanup(rcpu->queue);
+	ptr_ring_cleanup(rcpu->queue, NULL);
+	kfree(rcpu->queue);
 	free_percpu(rcpu->bulkq);
-	/* Cannot kthread_stop() here, last put free rcpu resources */
-	put_cpu_map_entry(rcpu);
+	kfree(rcpu);
 }
 
-/* After xchg pointer to bpf_cpu_map_entry, use the call_rcu() to
- * ensure any driver rcu critical sections have completed, but this
- * does not guarantee a flush has happened yet. Because driver side
- * rcu_read_lock/unlock only protects the running XDP program.  The
- * atomic xchg and NULL-ptr check in __cpu_map_flush() makes sure a
- * pending flush op doesn't fail.
- *
- * The bpf_cpu_map_entry is still used by the kthread, and there can
- * still be pending packets (in queue and percpu bulkq).  A refcnt
- * makes sure to last user (kthread_stop vs. call_rcu) free memory
- * resources.
- *
- * The rcu callback __cpu_map_entry_free flush remaining packets in
- * percpu bulkq to queue.  Due to caller map_delete_elem() disable
- * preemption, cannot call kthread_stop() to make sure queue is empty.
- * Instead a work_queue is started for stopping kthread,
- * cpu_map_kthread_stop, which waits for an RCU grace period before
- * stopping kthread, emptying the queue.
+/* After the xchg of the bpf_cpu_map_entry pointer, we need to make sure the old
+ * entry is no longer in use before freeing. We use queue_rcu_work() to call
+ * __cpu_map_entry_free() in a separate workqueue after waiting for an RCU grace
+ * period. This means that (a) all pending enqueue and flush operations have
+ * completed (because of the RCU callback), and (b) we are in a workqueue
+ * context where we can stop the kthread and wait for it to exit before freeing
+ * everything.
  */
 static void __cpu_map_entry_replace(struct bpf_cpu_map *cmap,
 				    u32 key_cpu, struct bpf_cpu_map_entry *rcpu)
@@ -543,9 +502,8 @@ static void __cpu_map_entry_replace(struct bpf_cpu_map *cmap,
 
 	old_rcpu = unrcu_pointer(xchg(&cmap->cpu_map[key_cpu], RCU_INITIALIZER(rcpu)));
 	if (old_rcpu) {
-		call_rcu(&old_rcpu->rcu, __cpu_map_entry_free);
-		INIT_WORK(&old_rcpu->kthread_stop_wq, cpu_map_kthread_stop);
-		schedule_work(&old_rcpu->kthread_stop_wq);
+		INIT_RCU_WORK(&old_rcpu->free_work, __cpu_map_entry_free);
+		queue_rcu_work(system_wq, &old_rcpu->free_work);
 	}
 }
 
@@ -557,7 +515,7 @@ static long cpu_map_delete_elem(struct bpf_map *map, void *key)
 	if (key_cpu >= map->max_entries)
 		return -EINVAL;
 
-	/* notice caller map_delete_elem() use preempt_disable() */
+	/* notice caller map_delete_elem() uses rcu_read_lock() */
 	__cpu_map_entry_replace(cmap, key_cpu, NULL);
 	return 0;
 }
-- 
2.29.2


