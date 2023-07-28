Return-Path: <bpf+bounces-6147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7559676618D
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB880282633
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DA63D76;
	Fri, 28 Jul 2023 01:58:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3CA3C05;
	Fri, 28 Jul 2023 01:58:31 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6084C273C;
	Thu, 27 Jul 2023 18:58:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RBrQ95Q5cz4f3q2t;
	Fri, 28 Jul 2023 09:58:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCX_7K_IMNkBXLmOw--.17170S5;
	Fri, 28 Jul 2023 09:58:26 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
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
Subject: [RFC PATCH bpf-next 1/2] bpf, cpumap: Use queue_rcu_work() to remove unnecessary rcu_barrier()
Date: Fri, 28 Jul 2023 10:30:29 +0800
Message-Id: <20230728023030.1906124-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230728023030.1906124-1-houtao@huaweicloud.com>
References: <20230728023030.1906124-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCX_7K_IMNkBXLmOw--.17170S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary5Zw1rZrW7JrWxtw1rCrg_yoWxuFWUpF
	Wft347Gr48Xw4v93y8Xw18Ar4Yqrs7W3WUJ340k34rAFnrJrZxXFW0kFyIyFy5urWkuw17
	ursFqFWkGayDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

As for now __cpu_map_entry_replace() uses call_rcu() to wait for the
inflight xdp program and NAPI poll to exit the RCU read critical
section, and then launch kworker cpu_map_kthread_stop() to call
kthread_stop() to handle all pending xdp frames or skbs.

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
---
 kernel/bpf/cpumap.c | 93 +++++++++++----------------------------------
 1 file changed, 23 insertions(+), 70 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 0a16e30b16ef..24f39c37526f 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -67,10 +67,7 @@ struct bpf_cpu_map_entry {
 	struct bpf_cpumap_val value;
 	struct bpf_prog *prog;
 
-	atomic_t refcnt; /* Control when this struct can be free'ed */
-	struct rcu_head rcu;
-
-	struct work_struct kthread_stop_wq;
+	struct rcu_work free_work;
 };
 
 struct bpf_cpu_map {
@@ -115,11 +112,6 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
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
@@ -134,43 +126,6 @@ static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 			xdp_return_frame(xdpf);
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
-	int err;
-
-	rcpu = container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
-
-	/* Wait for flush in __cpu_map_entry_free(), via full RCU barrier,
-	 * as it waits until all in-flight call_rcu() callbacks complete.
-	 */
-	rcu_barrier();
-
-	/* kthread_stop will wake_up_process and wait for it to complete */
-	err = kthread_stop(rcpu->kthread);
-	if (err) {
-		/* kthread_stop may be called before cpu_map_kthread_run
-		 * is executed, so we need to release the memory related
-		 * to rcpu.
-		 */
-		put_cpu_map_entry(rcpu);
-	}
-}
-
 static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
 				     struct list_head *listp,
 				     struct xdp_cpumap_stats *stats)
@@ -395,7 +350,6 @@ static int cpu_map_kthread_run(void *data)
 	}
 	__set_current_state(TASK_RUNNING);
 
-	put_cpu_map_entry(rcpu);
 	return 0;
 }
 
@@ -471,9 +425,6 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	if (IS_ERR(rcpu->kthread))
 		goto free_prog;
 
-	get_cpu_map_entry(rcpu); /* 1-refcnt for being in cmap->cpu_map[] */
-	get_cpu_map_entry(rcpu); /* 1-refcnt for kthread */
-
 	/* Make sure kthread runs on a single CPU */
 	kthread_bind(rcpu->kthread, cpu);
 	wake_up_process(rcpu->kthread);
@@ -494,7 +445,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	return NULL;
 }
 
-static void __cpu_map_entry_free(struct rcu_head *rcu)
+static void __cpu_map_entry_free(struct work_struct *work)
 {
 	struct bpf_cpu_map_entry *rcpu;
 
@@ -503,30 +454,33 @@ static void __cpu_map_entry_free(struct rcu_head *rcu)
 	 * new packets and cannot change/set flush_needed that can
 	 * find this entry.
 	 */
-	rcpu = container_of(rcu, struct bpf_cpu_map_entry, rcu);
+	rcpu = container_of(to_rcu_work(work), struct bpf_cpu_map_entry, free_work);
 
 	free_percpu(rcpu->bulkq);
-	/* Cannot kthread_stop() here, last put free rcpu resources */
-	put_cpu_map_entry(rcpu);
+
+	/* kthread_stop will wake_up_process and wait for it to complete */
+	kthread_stop(rcpu->kthread);
+
+	if (rcpu->prog)
+		bpf_prog_put(rcpu->prog);
+	/* The queue should be empty at this point */
+	__cpu_map_ring_cleanup(rcpu->queue);
+	ptr_ring_cleanup(rcpu->queue, NULL);
+	kfree(rcpu->queue);
+	kfree(rcpu);
 }
 
 /* After xchg pointer to bpf_cpu_map_entry, use the call_rcu() to
- * ensure any driver rcu critical sections have completed, but this
- * does not guarantee a flush has happened yet. Because driver side
- * rcu_read_lock/unlock only protects the running XDP program.  The
- * atomic xchg and NULL-ptr check in __cpu_map_flush() makes sure a
- * pending flush op doesn't fail.
+ * ensure both any driver rcu critical sections and xdp_do_flush()
+ * have completed.
  *
  * The bpf_cpu_map_entry is still used by the kthread, and there can
- * still be pending packets (in queue and percpu bulkq).  A refcnt
- * makes sure to last user (kthread_stop vs. call_rcu) free memory
- * resources.
+ * still be pending packets (in queue and percpu bulkq).
  *
- * The rcu callback __cpu_map_entry_free flush remaining packets in
- * percpu bulkq to queue.  Due to caller map_delete_elem() disable
- * preemption, cannot call kthread_stop() to make sure queue is empty.
- * Instead a work_queue is started for stopping kthread,
- * cpu_map_kthread_stop, which waits for an RCU grace period before
+ * Due to caller map_delete_elem() is in RCU read critical section,
+ * cannot call kthread_stop() to make sure queue is empty. Instead
+ * a work_struct is started for stopping kthread,
+ * __cpu_map_entry_free, which waits for a RCU grace period before
  * stopping kthread, emptying the queue.
  */
 static void __cpu_map_entry_replace(struct bpf_cpu_map *cmap,
@@ -536,9 +490,8 @@ static void __cpu_map_entry_replace(struct bpf_cpu_map *cmap,
 
 	old_rcpu = unrcu_pointer(xchg(&cmap->cpu_map[key_cpu], RCU_INITIALIZER(rcpu)));
 	if (old_rcpu) {
-		call_rcu(&old_rcpu->rcu, __cpu_map_entry_free);
-		INIT_WORK(&old_rcpu->kthread_stop_wq, cpu_map_kthread_stop);
-		schedule_work(&old_rcpu->kthread_stop_wq);
+		INIT_RCU_WORK(&old_rcpu->free_work, __cpu_map_entry_free);
+		queue_rcu_work(system_wq, &old_rcpu->free_work);
 	}
 }
 
-- 
2.29.2


