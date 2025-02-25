Return-Path: <bpf+bounces-52548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4ABA44856
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D30E8828E6
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5BE1A01B9;
	Tue, 25 Feb 2025 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PT5IcNR/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D5C19922F;
	Tue, 25 Feb 2025 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504287; cv=none; b=MHSA3UWHm7Bf1d5VGtOVkSbLGgz9b641Ni7KT0lkR8zUT+jRxCOnnHnupA5kwremhwaTZQH87/tu2NO9tMSPMLVZNxZLPe1jPq+nM+sCIk63rGXH0WYFjn2GhQdmSV9eGNBBXOBEOF5XPs1u1cjjns1yrFxLCrf8qDNxmGWVtSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504287; c=relaxed/simple;
	bh=NHJVJjgmFUzTIgQmgstoUzfkHlS6ur0aEm7F2vGSbR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4VLNFD3x8LNvseoAsT60zuv8hWDvuKrSBqim8cacb3FRg/WMdsUt8xFgoEYW81gAhMDbnp7yVsbEIeUT+ts8HW0oHQlYOuH3irjTVTu9Ztpy7JFVXFXnNhL13c74FfjcZxpvEbWJzpujH0EDOLcRO82L6b4zNiWCMBSCE2iSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PT5IcNR/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740504286; x=1772040286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NHJVJjgmFUzTIgQmgstoUzfkHlS6ur0aEm7F2vGSbR8=;
  b=PT5IcNR/vb1K7W1jpCA6HME4+VySUUxe0HPCSdBThZ8fYya9MZrY8IQu
   PQS4YqfMUa41MkNeq+BPV0jSukVQWa520ROrSYx9o4tmI3hrCh9peI3E7
   y1LrBBRHfhaD+PZIGpQeStGa5uuXnCFbzH7xUsh4Ad73xddYuvLdh6VEt
   KZp/ljFWdDG0hjK4E2zU1k2vxwLAmNCFTZq3vhuu+ictA73FMX0DVg1wK
   A78i9xgGqo8WKRTrmOr/aKwqPQ0Pg/aZAAVzTKYZhlfTWq2zJvorwCIcP
   Ty8xpS7RLEsHqFUcdjb3lrlH3PP4+SNETAvFD/0jf6w6fJXqWGZ4D7TAD
   Q==;
X-CSE-ConnectionGUID: lNaTjVxMR1Sf3i3+MnAEZQ==
X-CSE-MsgGUID: vU5nJAzeSMuASo5PXmcWHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="44974121"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="44974121"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:24:46 -0800
X-CSE-ConnectionGUID: Ttd7JzE/SQCXsjAKzuCDeQ==
X-CSE-MsgGUID: UemGeVwTQBiI/+PMp0/8Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116256887"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa006.fm.intel.com with ESMTP; 25 Feb 2025 09:24:41 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v5 3/8] bpf: cpumap: switch to GRO from netif_receive_skb_list()
Date: Tue, 25 Feb 2025 18:17:45 +0100
Message-ID: <20250225171751.2268401-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225171751.2268401-1-aleksander.lobakin@intel.com>
References: <20250225171751.2268401-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cpumap has its own BH context based on kthread. It has a sane batch
size of 8 frames per one cycle.
GRO can be used here on its own. Adjust cpumap calls to the upper stack
to use GRO API instead of netif_receive_skb_list() which processes skbs
by batches, but doesn't involve GRO layer at all.
In plenty of tests, GRO performs better than listed receiving even
given that it has to calculate full frame checksums on the CPU.
As GRO passes the skbs to the upper stack in the batches of
@gro_normal_batch, i.e. 8 by default, and skb->dev points to the
device where the frame comes from, it is enough to disable GRO
netdev feature on it to completely restore the original behaviour:
untouched frames will be being bulked and passed to the upper stack
by 8, as it was with netif_receive_skb_list().

Tested-by: Daniel Xu <dxu@dxuuu.xyz>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 kernel/bpf/cpumap.c | 46 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 774accbd4a22..f0909736eaa5 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -33,8 +33,8 @@
 #include <trace/events/xdp.h>
 #include <linux/btf_ids.h>
 
-#include <linux/netdevice.h>   /* netif_receive_skb_list */
-#include <linux/etherdevice.h> /* eth_type_trans */
+#include <linux/netdevice.h>
+#include <net/gro.h>
 
 /* General idea: XDP packets getting XDP redirected to another CPU,
  * will maximum be stored/queued for one driver ->poll() call.  It is
@@ -68,6 +68,7 @@ struct bpf_cpu_map_entry {
 
 	struct bpf_cpumap_val value;
 	struct bpf_prog *prog;
+	struct gro_node gro;
 
 	struct completion kthread_running;
 	struct rcu_work free_work;
@@ -261,10 +262,36 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 	return nframes;
 }
 
+static void cpu_map_gro_receive(struct bpf_cpu_map_entry *rcpu,
+				struct list_head *list)
+{
+	struct sk_buff *skb, *tmp;
+
+	list_for_each_entry_safe(skb, tmp, list, list) {
+		skb_list_del_init(skb);
+		gro_receive_skb(&rcpu->gro, skb);
+	}
+}
+
+static void cpu_map_gro_flush(struct bpf_cpu_map_entry *rcpu, bool empty)
+{
+	/*
+	 * If the ring is not empty, there'll be a new iteration soon, and we
+	 * only need to do a full flush if a tick is long (> 1 ms).
+	 * If the ring is empty, to not hold GRO packets in the stack for too
+	 * long, do a full flush.
+	 * This is equivalent to how NAPI decides whether to perform a full
+	 * flush.
+	 */
+	gro_flush(&rcpu->gro, !empty && HZ >= 1000);
+	gro_normal_list(&rcpu->gro);
+}
+
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
 	unsigned long last_qs = jiffies;
+	u32 packets = 0;
 
 	complete(&rcpu->kthread_running);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -282,6 +309,7 @@ static int cpu_map_kthread_run(void *data)
 		void *frames[CPUMAP_BATCH];
 		void *skbs[CPUMAP_BATCH];
 		LIST_HEAD(list);
+		bool empty;
 
 		/* Release CPU reschedule checks */
 		if (__ptr_ring_empty(rcpu->queue)) {
@@ -361,7 +389,16 @@ static int cpu_map_kthread_run(void *data)
 		trace_xdp_cpumap_kthread(rcpu->map_id, n, kmem_alloc_drops,
 					 sched, &stats);
 
-		netif_receive_skb_list(&list);
+		cpu_map_gro_receive(rcpu, &list);
+
+		/* Flush either every 64 packets or in case of empty ring */
+		packets += n;
+		empty = __ptr_ring_empty(rcpu->queue);
+		if (packets >= NAPI_POLL_WEIGHT || empty) {
+			cpu_map_gro_flush(rcpu, empty);
+			packets = 0;
+		}
+
 		local_bh_enable(); /* resched point, may call do_softirq() */
 	}
 	__set_current_state(TASK_RUNNING);
@@ -430,6 +467,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	rcpu->cpu    = cpu;
 	rcpu->map_id = map->id;
 	rcpu->value.qsize  = value->qsize;
+	gro_init(&rcpu->gro);
 
 	if (fd > 0 && __cpu_map_load_bpf_program(rcpu, map, fd))
 		goto free_ptr_ring;
@@ -458,6 +496,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	if (rcpu->prog)
 		bpf_prog_put(rcpu->prog);
 free_ptr_ring:
+	gro_cleanup(&rcpu->gro);
 	ptr_ring_cleanup(rcpu->queue, NULL);
 free_queue:
 	kfree(rcpu->queue);
@@ -487,6 +526,7 @@ static void __cpu_map_entry_free(struct work_struct *work)
 
 	if (rcpu->prog)
 		bpf_prog_put(rcpu->prog);
+	gro_cleanup(&rcpu->gro);
 	/* The queue should be empty at this point */
 	__cpu_map_ring_cleanup(rcpu->queue);
 	ptr_ring_cleanup(rcpu->queue, NULL);
-- 
2.48.1


