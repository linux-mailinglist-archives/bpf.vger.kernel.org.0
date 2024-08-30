Return-Path: <bpf+bounces-38572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3249666C9
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CCB1F22636
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67C31BB6BB;
	Fri, 30 Aug 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGQLKToN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F41BB69D;
	Fri, 30 Aug 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035155; cv=none; b=acexqWopXcyG8iMv9F4/yX8wJH/a1vMwcWU8G/SOFqcvqEiVS3R35hX8UhDi4cn2J+uw3sxcUVgN801HElLZbRiGVRPAZEhspf9HEM8bH3mbaklZwCCHDU88Cd76f7O0hHLnybmn4s7ELdGSqQ6vsI3fxvnOir21qi3DcqIIy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035155; c=relaxed/simple;
	bh=a0UCboQUXUg/DyXfTNwZ+U8UqIT8QHC7+/9PZrB7usY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUkWLbGWSV6l6UI7Q65sfxpNbpBEpa/60NxQsOml77jLPwcnlGzqqXuVD7a7szPPhC4XLGWrCBdYPLLFcVuuOyOi4S5FXdHUT5i4KsQC5Dd5uxgGrfJUbBR+WyN7w7EGicRKJSxyvvkOvDToFGnx+/umb6bl0STCkqYhPgvq2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGQLKToN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725035154; x=1756571154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a0UCboQUXUg/DyXfTNwZ+U8UqIT8QHC7+/9PZrB7usY=;
  b=EGQLKToN/nBlZV0O6KMMxCBS6hJfOK0r1Aj0twLgE/PAcbPWzskhMGAy
   xeVuhX4pVeygLPL5XyzUdtUWlJ+vaTkEDLl1t1nDrxJU5eOVNew4HFjDU
   //sl92gr7nQ76idwM03GJW2I6tlf8XNuQAc/LRIU7Ifv6cDv6czXmFKXW
   mUR4H2v9f3Iyn6tpgsAyPwtbjD7AgbuXNRQmYLuhD0Gjx/s7xB8NaBc7H
   R58SrDioDuTU3hvRMdA/rvYe5+ZU2vFaq8OZxdPxHK1/NR36+INR4bn/E
   0r5d6+lMd1q4iF7h53wpT8XOLpjDXW4PXQiqYY4IUD9E6HuCN97qGae3A
   A==;
X-CSE-ConnectionGUID: HGJH3lWeTfGlGxLidKSnCA==
X-CSE-MsgGUID: w59K+8ILS6ueDHmS3jdFpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="49068924"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="49068924"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:25:54 -0700
X-CSE-ConnectionGUID: ymd8LKSdQ+6ayUMFVEOdZg==
X-CSE-MsgGUID: cBCpxEQgSPu4tUGMhlVZ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63996450"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 30 Aug 2024 09:25:49 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 4/9] bpf: cpumap: use CPU-pinned threaded NAPI w/GRO instead of kthread
Date: Fri, 30 Aug 2024 18:25:03 +0200
Message-ID: <20240830162508.1009458-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lorenzo Bianconi <lorenzo@kernel.org>

Currently, cpumap uses its own kthread which processes cpumap-redirected
frames by batches of 8, without any weighting (but with rescheduling
points). The resulting skbs get passed to the stack via
netif_receive_skb_list(), which means no GRO happens.
In order to enable GRO, remove all custom kthread logics from the cpumap
and use CPU-pinned threaded NAPIs with the default weight of 64. When a
cpumap is created, a new logical netdevice called "cpumap" is created to
run these NAPIs on it (one per map). Then, a percpu threaded NAPI context
is created for each cpumap entry, IOW for each specified CPU.
Instead of wake_up_process(), the NAPI is now scheduled and runs as
usually: with the budget of 64, napi_complete_done() is called if the
budget is not exhausted. Frames are still processed by batches of 8.
Instead of netif_receive_skb_list(), napi_gro_receive() is now used.

Alex' tests with an UDP trafficgen and small frame size:

                no GRO    GRO
baseline        2.7       N/A    Mpps
threaded GRO    2.3       4      Mpps
diff            -14       +48    %

Daniel's tests with neper's TCP RR tests shows +14% throughput
increase[0].

Currently, GRO on cpumap is limited to that the checksum status is not
known as &xdp_frame doesn't have such metadata. When we have a way to
pass it from the drivers, the boost will be much bigger.

Cc: Daniel Xu <dxu@dxuuu.xyz>
Link: https://lore.kernel.org/bpf/merfatcdvwpx2lj4j2pahhwp4vihstpidws3jwljwazhh76xkd@t5vsh4gvk4mh [0]
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 kernel/bpf/cpumap.c | 167 ++++++++++++++++++++------------------------
 1 file changed, 76 insertions(+), 91 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index fbdf5a1aabfe..d1cfa4111727 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -28,14 +28,10 @@
 
 #include <linux/sched.h>
 #include <linux/workqueue.h>
-#include <linux/kthread.h>
 #include <linux/completion.h>
 #include <trace/events/xdp.h>
 #include <linux/btf_ids.h>
 
-#include <linux/netdevice.h>   /* netif_receive_skb_list */
-#include <linux/etherdevice.h> /* eth_type_trans */
-
 /* General idea: XDP packets getting XDP redirected to another CPU,
  * will maximum be stored/queued for one driver ->poll() call.  It is
  * guaranteed that queueing the frame and the flush operation happen on
@@ -56,20 +52,22 @@ struct xdp_bulk_queue {
 
 /* Struct for every remote "destination" CPU in map */
 struct bpf_cpu_map_entry {
-	u32 cpu;    /* kthread CPU and map index */
+	u32 cpu;    /* NAPI thread CPU and map index */
 	int map_id; /* Back reference to map */
 
 	/* XDP can run multiple RX-ring queues, need __percpu enqueue store */
 	struct xdp_bulk_queue __percpu *bulkq;
 
-	/* Queue with potential multi-producers, and single-consumer kthread */
+	/*
+	 * Queue with potential multi-producers and single-consumer
+	 * NAPI thread
+	 */
 	struct ptr_ring *queue;
-	struct task_struct *kthread;
 
 	struct bpf_cpumap_val value;
 	struct bpf_prog *prog;
+	struct napi_struct napi;
 
-	struct completion kthread_running;
 	struct rcu_work free_work;
 };
 
@@ -77,12 +75,15 @@ struct bpf_cpu_map {
 	struct bpf_map map;
 	/* Below members specific for map type */
 	struct bpf_cpu_map_entry __rcu **cpu_map;
+	/* Dummy netdev to run threaded NAPI */
+	struct net_device *napi_dev;
 };
 
 static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 {
 	u32 value_size = attr->value_size;
 	struct bpf_cpu_map *cmap;
+	struct net_device *dev;
 
 	/* check sanity of attributes */
 	if (attr->max_entries == 0 || attr->key_size != 4 ||
@@ -105,19 +106,34 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 	cmap->cpu_map = bpf_map_area_alloc(cmap->map.max_entries *
 					   sizeof(struct bpf_cpu_map_entry *),
 					   cmap->map.numa_node);
-	if (!cmap->cpu_map) {
-		bpf_map_area_free(cmap);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!cmap->cpu_map)
+		goto free_cmap;
+
+	dev = bpf_map_area_alloc(struct_size(dev, priv, 0), NUMA_NO_NODE);
+	if (!dev)
+		goto free_cpu_map;
+
+	init_dummy_netdev(dev);
+	strscpy(dev->name, "cpumap");
+	dev->threaded = true;
+
+	cmap->napi_dev = dev;
 
 	return &cmap->map;
+
+free_cpu_map:
+	bpf_map_area_free(cmap->cpu_map);
+free_cmap:
+	bpf_map_area_free(cmap);
+
+	return ERR_PTR(-ENOMEM);
 }
 
 static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 {
 	/* The tear-down procedure should have made sure that queue is
 	 * empty.  See __cpu_map_entry_replace() and work-queue
-	 * invoked cpu_map_kthread_stop(). Catch any broken behaviour
+	 * invoked __cpu_map_entry_free(). Catch any broken behaviour
 	 * gracefully and warn once.
 	 */
 	void *ptr;
@@ -244,7 +260,6 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 	if (!rcpu->prog)
 		return xdp_n;
 
-	rcu_read_lock_bh();
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	nframes = cpu_map_bpf_prog_run_xdp(rcpu, frames, xdp_n, stats);
@@ -256,62 +271,45 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 		cpu_map_bpf_prog_run_skb(rcpu, list, stats);
 
 	bpf_net_ctx_clear(bpf_net_ctx);
-	rcu_read_unlock_bh(); /* resched point, may call do_softirq() */
 
 	return nframes;
 }
 
-static int cpu_map_kthread_run(void *data)
+static int cpu_map_napi_poll(struct napi_struct *napi, int budget)
 {
-	struct bpf_cpu_map_entry *rcpu = data;
-	unsigned long last_qs = jiffies;
+	struct xdp_cpumap_stats stats = {}; /* zero stats */
+	u32 done = 0, kmem_alloc_drops = 0;
+	struct bpf_cpu_map_entry *rcpu;
 
-	complete(&rcpu->kthread_running);
-	set_current_state(TASK_INTERRUPTIBLE);
+	rcu_read_lock();
+	rcpu = container_of(napi, typeof(*rcpu), napi);
 
-	/* When kthread gives stop order, then rcpu have been disconnected
-	 * from map, thus no new packets can enter. Remaining in-flight
-	 * per CPU stored packets are flushed to this queue.  Wait honoring
-	 * kthread_stop signal until queue is empty.
-	 */
-	while (!kthread_should_stop() || !__ptr_ring_empty(rcpu->queue)) {
-		struct xdp_cpumap_stats stats = {}; /* zero stats */
-		unsigned int kmem_alloc_drops = 0, sched = 0;
+	while (likely(done < budget)) {
 		gfp_t gfp = __GFP_ZERO | GFP_ATOMIC;
 		int i, n, m, nframes, xdp_n;
 		void *frames[CPUMAP_BATCH];
+		struct sk_buff *skb, *tmp;
 		void *skbs[CPUMAP_BATCH];
 		LIST_HEAD(list);
 
-		/* Release CPU reschedule checks */
-		if (__ptr_ring_empty(rcpu->queue)) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			/* Recheck to avoid lost wake-up */
-			if (__ptr_ring_empty(rcpu->queue)) {
-				schedule();
-				sched = 1;
-				last_qs = jiffies;
-			} else {
-				__set_current_state(TASK_RUNNING);
-			}
-		} else {
-			rcu_softirq_qs_periodic(last_qs);
-			sched = cond_resched();
-		}
+		if (__ptr_ring_empty(rcpu->queue))
+			break;
 
 		/*
 		 * The bpf_cpu_map_entry is single consumer, with this
-		 * kthread CPU pinned. Lockless access to ptr_ring
+		 * NAPI thread CPU pinned. Lockless access to ptr_ring
 		 * consume side valid as no-resize allowed of queue.
 		 */
-		n = __ptr_ring_consume_batched(rcpu->queue, frames,
-					       CPUMAP_BATCH);
+		n = min(budget - done, CPUMAP_BATCH);
+		n = __ptr_ring_consume_batched(rcpu->queue, frames, n);
+		done += n;
+
 		for (i = 0, xdp_n = 0; i < n; i++) {
 			void *f = frames[i];
 			struct page *page;
 
 			if (unlikely(__ptr_test_bit(0, &f))) {
-				struct sk_buff *skb = f;
+				skb = f;
 
 				__ptr_clear_bit(0, &skb);
 				list_add_tail(&skb->list, &list);
@@ -340,12 +338,10 @@ static int cpu_map_kthread_run(void *data)
 			}
 		}
 
-		local_bh_disable();
 		for (i = 0; i < nframes; i++) {
 			struct xdp_frame *xdpf = frames[i];
-			struct sk_buff *skb = skbs[i];
 
-			skb = __xdp_build_skb_from_frame(xdpf, skb,
+			skb = __xdp_build_skb_from_frame(xdpf, skbs[i],
 							 xdpf->dev_rx);
 			if (!skb) {
 				xdp_return_frame(xdpf);
@@ -354,17 +350,23 @@ static int cpu_map_kthread_run(void *data)
 
 			list_add_tail(&skb->list, &list);
 		}
-		netif_receive_skb_list(&list);
-
-		/* Feedback loop via tracepoint */
-		trace_xdp_cpumap_kthread(rcpu->map_id, n, kmem_alloc_drops,
-					 sched, &stats);
 
-		local_bh_enable(); /* resched point, may call do_softirq() */
+		list_for_each_entry_safe(skb, tmp, &list, list) {
+			skb_list_del_init(skb);
+			napi_gro_receive(napi, skb);
+		}
 	}
-	__set_current_state(TASK_RUNNING);
 
-	return 0;
+	rcu_read_unlock();
+
+	/* Feedback loop via tracepoint */
+	trace_xdp_cpumap_kthread(rcpu->map_id, done, kmem_alloc_drops, 0,
+				 &stats);
+
+	if (done < budget)
+		napi_complete_done(napi, done);
+
+	return done;
 }
 
 static int __cpu_map_load_bpf_program(struct bpf_cpu_map_entry *rcpu,
@@ -394,6 +396,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 {
 	int numa, err, i, fd = value->bpf_prog.fd;
 	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
+	const struct bpf_cpu_map *cmap;
 	struct bpf_cpu_map_entry *rcpu;
 	struct xdp_bulk_queue *bq;
 
@@ -432,29 +435,13 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	if (fd > 0 && __cpu_map_load_bpf_program(rcpu, map, fd))
 		goto free_ptr_ring;
 
-	/* Setup kthread */
-	init_completion(&rcpu->kthread_running);
-	rcpu->kthread = kthread_create_on_node(cpu_map_kthread_run, rcpu, numa,
-					       "cpumap/%d/map:%d", cpu,
-					       map->id);
-	if (IS_ERR(rcpu->kthread))
-		goto free_prog;
-
-	/* Make sure kthread runs on a single CPU */
-	kthread_bind(rcpu->kthread, cpu);
-	wake_up_process(rcpu->kthread);
-
-	/* Make sure kthread has been running, so kthread_stop() will not
-	 * stop the kthread prematurely and all pending frames or skbs
-	 * will be handled by the kthread before kthread_stop() returns.
-	 */
-	wait_for_completion(&rcpu->kthread_running);
+	cmap = container_of(map, typeof(*cmap), map);
+	netif_napi_add_percpu(cmap->napi_dev, &rcpu->napi, cpu_map_napi_poll,
+			      cpu);
+	napi_enable(&rcpu->napi);
 
 	return rcpu;
 
-free_prog:
-	if (rcpu->prog)
-		bpf_prog_put(rcpu->prog);
 free_ptr_ring:
 	ptr_ring_cleanup(rcpu->queue, NULL);
 free_queue:
@@ -477,11 +464,12 @@ static void __cpu_map_entry_free(struct work_struct *work)
 	 */
 	rcpu = container_of(to_rcu_work(work), struct bpf_cpu_map_entry, free_work);
 
-	/* kthread_stop will wake_up_process and wait for it to complete.
-	 * cpu_map_kthread_run() makes sure the pointer ring is empty
+	/* napi_disable() will wait for the NAPI poll to complete.
+	 * cpu_map_napi_poll() makes sure the pointer ring is empty
 	 * before exiting.
 	 */
-	kthread_stop(rcpu->kthread);
+	napi_disable(&rcpu->napi);
+	netif_napi_del(&rcpu->napi);
 
 	if (rcpu->prog)
 		bpf_prog_put(rcpu->prog);
@@ -498,8 +486,8 @@ static void __cpu_map_entry_free(struct work_struct *work)
  * __cpu_map_entry_free() in a separate workqueue after waiting for an RCU grace
  * period. This means that (a) all pending enqueue and flush operations have
  * completed (because of the RCU callback), and (b) we are in a workqueue
- * context where we can stop the kthread and wait for it to exit before freeing
- * everything.
+ * context where we can stop the NAPI thread and wait for it to exit before
+ * freeing everything.
  */
 static void __cpu_map_entry_replace(struct bpf_cpu_map *cmap,
 				    u32 key_cpu, struct bpf_cpu_map_entry *rcpu)
@@ -579,9 +567,7 @@ static void cpu_map_free(struct bpf_map *map)
 	 */
 	synchronize_rcu();
 
-	/* The only possible user of bpf_cpu_map_entry is
-	 * cpu_map_kthread_run().
-	 */
+	/* The only possible user of bpf_cpu_map_entry is cpu_map_napi_poll() */
 	for (i = 0; i < cmap->map.max_entries; i++) {
 		struct bpf_cpu_map_entry *rcpu;
 
@@ -589,9 +575,10 @@ static void cpu_map_free(struct bpf_map *map)
 		if (!rcpu)
 			continue;
 
-		/* Stop kthread and cleanup entry directly */
+		/* Stop NAPI thread and cleanup entry directly */
 		__cpu_map_entry_free(&rcpu->free_work.work);
 	}
+	bpf_map_area_free(cmap->napi_dev);
 	bpf_map_area_free(cmap->cpu_map);
 	bpf_map_area_free(cmap);
 }
@@ -753,7 +740,7 @@ int cpu_map_generic_redirect(struct bpf_cpu_map_entry *rcpu,
 	if (ret < 0)
 		goto trace;
 
-	wake_up_process(rcpu->kthread);
+	napi_schedule(&rcpu->napi);
 trace:
 	trace_xdp_cpumap_enqueue(rcpu->map_id, !ret, !!ret, rcpu->cpu);
 	return ret;
@@ -765,8 +752,6 @@ void __cpu_map_flush(struct list_head *flush_list)
 
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
 		bq_flush_to_queue(bq);
-
-		/* If already running, costs spin_lock_irqsave + smb_mb */
-		wake_up_process(bq->obj->kthread);
+		napi_schedule(&bq->obj->napi);
 	}
 }
-- 
2.46.0


