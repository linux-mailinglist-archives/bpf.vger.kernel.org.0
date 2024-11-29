Return-Path: <bpf+bounces-45897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C379DED7F
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 00:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741E9163F54
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 23:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4A41A76AE;
	Fri, 29 Nov 2024 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRB8og5K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E8C15667B;
	Fri, 29 Nov 2024 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732921895; cv=none; b=TiEHiNn5K89Nb3eibl+glzvMk378bn9QifP3fbiX3c1qjNw2sYhs4NgozuUpxTVGvPH8USJ+6x6vbRpQsVR78muluu6u/Dn86Bseun036T1Tbs86TT9Z057RxVUUjSwvu8s/TASAbGyT5BIpk37rUmnbv9TIl0besBX+n58tWaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732921895; c=relaxed/simple;
	bh=L20h7E62CgEbW7RQsxNKHFFP3uRELCvfC8cFWBGyit4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nl2H5Xh1VQQk/rayNp9FFbShUVmOIFo23OStZ+So65ofL3EqQUnVd1SNKf1ULNmhTD/hiipn2D8LU0jW/agXVTb0+gyTV8dvDdeyGKriOGQdI9MmqbWgRM82iQH5DdeQQVXVj//Ko76uTZzRjGJ7ForQCH55BVeImseHBMAqxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRB8og5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46704C4CECF;
	Fri, 29 Nov 2024 23:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732921894;
	bh=L20h7E62CgEbW7RQsxNKHFFP3uRELCvfC8cFWBGyit4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eRB8og5Kx8LJVbaFNxXXvT3pAZWmxdcVUomPekcUeeCOrAFurU2pF64QsP0L+oRSP
	 8N0rO1gEiUFZWUfDxigVOot53d+Z2rMaGCgSWSZpzd1oCj5hHYfndaf9afN/co2BuD
	 bEdryct5AuHUWqsf9AinQKF9fJZI4pOVasI6l2/tmKXNWM4QpikUpPTOFy/EhYTfV1
	 AktFSf83Jqmp8y3VK8+20Zk7EWoL09T+yf5Oz/syywOY9G5E9G+r+x6WOUwSZlRQFp
	 tEcVXMVG43rVaGJrZT/TOKfN2KXFpiVXOqFCoV7QhSMneNpQw8+1SpB5GA7gtMf7Q/
	 jfZ1ruZZhg0bA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 30 Nov 2024 00:11:00 +0100
Subject: [PATCH bpf-next 3/3] bpf: cpumap: Add gro support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-cpumap-gro-v1-3-c1180b1b5758@kernel.org>
References: <20241130-cpumap-gro-v1-0-c1180b1b5758@kernel.org>
In-Reply-To: <20241130-cpumap-gro-v1-0-c1180b1b5758@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, aleksander.lobakin@intel.com, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce GRO support to cpumap codebase moving the cpu_map_entry
kthread to a NAPI-kthread pinned on the selected cpu.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 kernel/bpf/cpumap.c | 125 ++++++++++++++++++++++------------------------------
 1 file changed, 52 insertions(+), 73 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index a2f46785ac3b3c54a69b19641cc463055c2978d9..3ec6739aec5aeb545b417cb62e4cbcb82bfa6db4 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -62,9 +62,11 @@ struct bpf_cpu_map_entry {
 	/* XDP can run multiple RX-ring queues, need __percpu enqueue store */
 	struct xdp_bulk_queue __percpu *bulkq;
 
-	/* Queue with potential multi-producers, and single-consumer kthread */
+	/* Queue with potential multi-producers, and single-consumer
+	 * NAPI-kthread
+	 */
 	struct ptr_ring *queue;
-	struct task_struct *kthread;
+	struct napi_struct napi;
 
 	struct bpf_cpumap_val value;
 	struct bpf_prog *prog;
@@ -261,58 +263,42 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 	return nframes;
 }
 
-static int cpu_map_kthread_run(void *data)
+static int cpu_map_poll(struct napi_struct *napi, int budget)
 {
-	struct bpf_cpu_map_entry *rcpu = data;
-	unsigned long last_qs = jiffies;
+	struct xdp_cpumap_stats stats = {}; /* zero stats */
+	unsigned int kmem_alloc_drops = 0;
+	struct bpf_cpu_map_entry *rcpu;
+	int done = 0;
 
+	rcu_read_lock();
+	rcpu = container_of(napi, struct bpf_cpu_map_entry, napi);
 	complete(&rcpu->kthread_running);
-	set_current_state(TASK_INTERRUPTIBLE);
 
-	/* When kthread gives stop order, then rcpu have been disconnected
-	 * from map, thus no new packets can enter. Remaining in-flight
-	 * per CPU stored packets are flushed to this queue.  Wait honoring
-	 * kthread_stop signal until queue is empty.
-	 */
-	while (!kthread_should_stop() || !__ptr_ring_empty(rcpu->queue)) {
-		struct xdp_cpumap_stats stats = {}; /* zero stats */
-		unsigned int kmem_alloc_drops = 0, sched = 0;
+	while (done < budget) {
 		gfp_t gfp = __GFP_ZERO | GFP_ATOMIC;
-		int i, n, m, nframes, xdp_n;
+		int n, i, m, xdp_n = 0, nframes;
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
-
+		if (__ptr_ring_empty(rcpu->queue))
+			break;
 		/*
 		 * The bpf_cpu_map_entry is single consumer, with this
 		 * kthread CPU pinned. Lockless access to ptr_ring
 		 * consume side valid as no-resize allowed of queue.
 		 */
-		n = __ptr_ring_consume_batched(rcpu->queue, frames,
-					       CPUMAP_BATCH);
-		for (i = 0, xdp_n = 0; i < n; i++) {
+		n = min(budget -  done, CPUMAP_BATCH);
+		n = __ptr_ring_consume_batched(rcpu->queue, frames, n);
+		done += n;
+
+		for (i = 0; i < n; i++) {
 			void *f = frames[i];
 			struct page *page;
 
 			if (unlikely(__ptr_test_bit(0, &f))) {
-				struct sk_buff *skb = f;
-
+				skb = f;
 				__ptr_clear_bit(0, &skb);
 				list_add_tail(&skb->list, &list);
 				continue;
@@ -340,12 +326,10 @@ static int cpu_map_kthread_run(void *data)
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
@@ -355,18 +339,20 @@ static int cpu_map_kthread_run(void *data)
 			list_add_tail(&skb->list, &list);
 		}
 
-		/* Feedback loop via tracepoint.
-		 * NB: keep before recv to allow measuring enqueue/dequeue latency.
-		 */
-		trace_xdp_cpumap_kthread(rcpu->map_id, n, kmem_alloc_drops,
-					 sched, &stats);
-
-		netif_receive_skb_list(&list);
-		local_bh_enable(); /* resched point, may call do_softirq() */
+		list_for_each_entry_safe(skb, tmp, &list, list) {
+			skb_list_del_init(skb);
+			napi_gro_receive(napi, skb);
+		}
 	}
-	__set_current_state(TASK_RUNNING);
 
-	return 0;
+	rcu_read_unlock();
+	/* Feedback loop via tracepoint */
+	trace_xdp_cpumap_kthread(rcpu->map_id, done, kmem_alloc_drops, 0,
+				 &stats);
+	if (done < budget)
+		napi_complete(napi);
+
+	return done;
 }
 
 static int __cpu_map_load_bpf_program(struct bpf_cpu_map_entry *rcpu,
@@ -434,18 +420,19 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	if (fd > 0 && __cpu_map_load_bpf_program(rcpu, map, fd))
 		goto free_ptr_ring;
 
+	napi_init_for_gro(NULL, &rcpu->napi, cpu_map_poll,
+			  NAPI_POLL_WEIGHT);
+	set_bit(NAPI_STATE_THREADED, &rcpu->napi.state);
+
 	/* Setup kthread */
 	init_completion(&rcpu->kthread_running);
-	rcpu->kthread = kthread_create_on_node(cpu_map_kthread_run, rcpu, numa,
-					       "cpumap/%d/map:%d", cpu,
-					       map->id);
-	if (IS_ERR(rcpu->kthread))
+	rcpu->napi.thread = kthread_run_on_cpu(napi_threaded_poll,
+					       &rcpu->napi, cpu,
+					       "cpumap-napi/%d");
+	if (IS_ERR(rcpu->napi.thread))
 		goto free_prog;
 
-	/* Make sure kthread runs on a single CPU */
-	kthread_bind(rcpu->kthread, cpu);
-	wake_up_process(rcpu->kthread);
-
+	napi_schedule(&rcpu->napi);
 	/* Make sure kthread has been running, so kthread_stop() will not
 	 * stop the kthread prematurely and all pending frames or skbs
 	 * will be handled by the kthread before kthread_stop() returns.
@@ -479,12 +466,8 @@ static void __cpu_map_entry_free(struct work_struct *work)
 	 */
 	rcpu = container_of(to_rcu_work(work), struct bpf_cpu_map_entry, free_work);
 
-	/* kthread_stop will wake_up_process and wait for it to complete.
-	 * cpu_map_kthread_run() makes sure the pointer ring is empty
-	 * before exiting.
-	 */
-	kthread_stop(rcpu->kthread);
-
+	napi_disable(&rcpu->napi);
+	__netif_napi_del(&rcpu->napi);
 	if (rcpu->prog)
 		bpf_prog_put(rcpu->prog);
 	/* The queue should be empty at this point */
@@ -500,8 +483,8 @@ static void __cpu_map_entry_free(struct work_struct *work)
  * __cpu_map_entry_free() in a separate workqueue after waiting for an RCU grace
  * period. This means that (a) all pending enqueue and flush operations have
  * completed (because of the RCU callback), and (b) we are in a workqueue
- * context where we can stop the kthread and wait for it to exit before freeing
- * everything.
+ * context where we can stop the NAPI-kthread and wait for it to exit before
+ * freeing everything.
  */
 static void __cpu_map_entry_replace(struct bpf_cpu_map *cmap,
 				    u32 key_cpu, struct bpf_cpu_map_entry *rcpu)
@@ -581,9 +564,7 @@ static void cpu_map_free(struct bpf_map *map)
 	 */
 	synchronize_rcu();
 
-	/* The only possible user of bpf_cpu_map_entry is
-	 * cpu_map_kthread_run().
-	 */
+	/* The only possible user of bpf_cpu_map_entry is the NAPI-kthread. */
 	for (i = 0; i < cmap->map.max_entries; i++) {
 		struct bpf_cpu_map_entry *rcpu;
 
@@ -591,7 +572,7 @@ static void cpu_map_free(struct bpf_map *map)
 		if (!rcpu)
 			continue;
 
-		/* Stop kthread and cleanup entry directly */
+		/* Stop NAPI-kthread and cleanup entry directly */
 		__cpu_map_entry_free(&rcpu->free_work.work);
 	}
 	bpf_map_area_free(cmap->cpu_map);
@@ -755,7 +736,7 @@ int cpu_map_generic_redirect(struct bpf_cpu_map_entry *rcpu,
 	if (ret < 0)
 		goto trace;
 
-	wake_up_process(rcpu->kthread);
+	napi_schedule(&rcpu->napi);
 trace:
 	trace_xdp_cpumap_enqueue(rcpu->map_id, !ret, !!ret, rcpu->cpu);
 	return ret;
@@ -767,8 +748,6 @@ void __cpu_map_flush(struct list_head *flush_list)
 
 	list_for_each_entry_safe(bq, tmp, flush_list, flush_node) {
 		bq_flush_to_queue(bq);
-
-		/* If already running, costs spin_lock_irqsave + smb_mb */
-		wake_up_process(bq->obj->kthread);
+		napi_schedule(&bq->obj->napi);
 	}
 }

-- 
2.47.0


