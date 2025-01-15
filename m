Return-Path: <bpf+bounces-48939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E47A1272D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE4C1676B3
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAFA149C7A;
	Wed, 15 Jan 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NykRgtke"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DE115C158;
	Wed, 15 Jan 2025 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954394; cv=none; b=A1dCEGf6EkrQvIend1bsLAwSU6Saw2Ly25z/v8FG4HWH8hL7EBYri4Y/8OEggxREEmY4AqpXVCJIYLCGtNSfB7zY87LA52Y20yrKTjHnaMH7ehFf9EeZXClkPBPIwAMI1ttebdSyW1RSOEgFT3UjXPf10cb4vBM9xLe+JvexHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954394; c=relaxed/simple;
	bh=RXSJs+SYv1WQ5pctjH95Q+52NrXQPcteHToCrm0qK1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMZ16qXxwHDbFgVtw6Ng6RFa9xuwM2jcsXCS+YStXPqmcvXajC9kvQl7dg5vYBTz5riww2OQGkZX6RrWeBhS1WjwhaSxCnZYqDBute4VX3/6bfnYKh4oce1AZzmow5ZPwLAQy9fCpI6M/rRYJPUt071bgf/yklSLnW2H0E+DzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NykRgtke; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736954393; x=1768490393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RXSJs+SYv1WQ5pctjH95Q+52NrXQPcteHToCrm0qK1A=;
  b=NykRgtke77V+IkhVnLlcKIwImPPePEvHd2EK4EN15e6LRlcbynIcl2oj
   V4roG8aNjjABevR/EqirapdVGeWS+dw8+QTaIFJSFAQHZ7x4gmhKFlXq7
   Dgj9PTkPjE4SHl8oqTw97MebT1XDrKuO9eHVg+r7rSMfexnY2q4UON2qp
   PxhcrM51zWIdWc6qClJcq7umTyGmbDs5n5cjH5cb3RK+TENQMomkQrEH4
   a3kJGrNN+p67cuWaSFAeja+76p49tgtWXg9hkyYBt+anFwbRMTehsQ4m2
   odr2irEWvjcTx+bKmANUvEhfbtcAPT4FnloLmsu7iT97YXnhjS1G3GvqY
   A==;
X-CSE-ConnectionGUID: St9YWfFrTlKGWOPnPpTWCA==
X-CSE-MsgGUID: RcbiiFyaTQy7URSPH3GZVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37451792"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="37451792"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 07:19:53 -0800
X-CSE-ConnectionGUID: nJNbrTt4RrqbI4w2zg3dTQ==
X-CSE-MsgGUID: B06YXzbdRLu51nQQvYBGKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="105116660"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa007.fm.intel.com with ESMTP; 15 Jan 2025 07:19:49 -0800
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/8] bpf: cpumap: switch to GRO from netif_receive_skb_list()
Date: Wed, 15 Jan 2025 16:18:56 +0100
Message-ID: <20250115151901.2063909-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/cpumap.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 774accbd4a22..10d062dddb6f 100644
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
@@ -361,7 +389,15 @@ static int cpu_map_kthread_run(void *data)
 		trace_xdp_cpumap_kthread(rcpu->map_id, n, kmem_alloc_drops,
 					 sched, &stats);
 
-		netif_receive_skb_list(&list);
+		cpu_map_gro_receive(rcpu, &list);
+
+		/* Flush either every 64 packets or in case of empty ring */
+		empty = __ptr_ring_empty(rcpu->queue);
+		if (packets += n >= NAPI_POLL_WEIGHT || empty) {
+			cpu_map_gro_flush(rcpu, empty);
+			packets = 0;
+		}
+
 		local_bh_enable(); /* resched point, may call do_softirq() */
 	}
 	__set_current_state(TASK_RUNNING);
@@ -430,6 +466,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	rcpu->cpu    = cpu;
 	rcpu->map_id = map->id;
 	rcpu->value.qsize  = value->qsize;
+	gro_init(&rcpu->gro);
 
 	if (fd > 0 && __cpu_map_load_bpf_program(rcpu, map, fd))
 		goto free_ptr_ring;
@@ -458,6 +495,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	if (rcpu->prog)
 		bpf_prog_put(rcpu->prog);
 free_ptr_ring:
+	gro_cleanup(&rcpu->gro);
 	ptr_ring_cleanup(rcpu->queue, NULL);
 free_queue:
 	kfree(rcpu->queue);
@@ -487,6 +525,7 @@ static void __cpu_map_entry_free(struct work_struct *work)
 
 	if (rcpu->prog)
 		bpf_prog_put(rcpu->prog);
+	gro_cleanup(&rcpu->gro);
 	/* The queue should be empty at this point */
 	__cpu_map_ring_cleanup(rcpu->queue);
 	ptr_ring_cleanup(rcpu->queue, NULL);
-- 
2.48.0


