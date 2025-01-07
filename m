Return-Path: <bpf+bounces-48130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EF5A04497
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 16:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CDB3A770C
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7619A1F4E22;
	Tue,  7 Jan 2025 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEx+J9g6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B51F4716;
	Tue,  7 Jan 2025 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263883; cv=none; b=d9yynrOi+5V9OlGnnXeWlU+3SIxtLpPp2Qm4u/VOBEF16j4V6H+3EhgW5Xs27PccAWVtzr1BnJRmgMFwifrA6PoViPd5GNJJexWEIy56ZzpYTfftOHmPcc+C21oC0DVcowgD8bhAvVC2pBqN6HkNVYa0ZbqVsKbWtaGJoNLZZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263883; c=relaxed/simple;
	bh=iKT+1pivEr22Eh8qiWxvoWeb/VdyHBFSvRs7hIm0Uc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNCbpmYWHwwFZhBvHSeHxbsR04mL8daW7PcX6GwYh37Acn7EOnZe68RrveyI8vw9e+L9uEA+yv7mSmI2Grd+54kXrAyDPW4O3w7G6IucG3yCjRZHVz9U0eo0kg/YAciKbMNPmZI2MM0U7NXvBstioelelJapfqrFkY0pXF1ZxdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEx+J9g6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736263880; x=1767799880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iKT+1pivEr22Eh8qiWxvoWeb/VdyHBFSvRs7hIm0Uc4=;
  b=hEx+J9g60Q7TDYlisXVcQNuJBvSNDlcyTqjh+1SG8iCpLPtuoEg42lia
   LKwahEcu2HXyfofE+5HcnKv2cNUYzALuv+LaSzXb0IQArBG9ja6qSPOCA
   da3NS3LTwyX/maWwXozXsKNYm+RbUsJVPVFGxaStONfsnklLjRDZn6MnO
   OgN0WQimZElkn080QilZ9+Dg6QxqEFIn0zs1dfDP2kr/+GwbKsyJthZm9
   C3iMOsN9n1m4dwk7MtI+WNxlbMiNyIGNSiANiwDFfD1rZPODYLU9aYetA
   /89f4zZHr2/DpfnNLaCp1b+Dpp8eO+/dVUtBJwxHrVjNCTC6k8wBEWS4n
   Q==;
X-CSE-ConnectionGUID: 0S1sbvS9Swyt3gjv/gBiIA==
X-CSE-MsgGUID: hULjuzbJQyCVWoe+rbHdYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="35685816"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="35685816"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 07:31:18 -0800
X-CSE-ConnectionGUID: qNyliSkcSL2gsVXfLNYGwA==
X-CSE-MsgGUID: GekxcnpuStKDzAEA2qWNGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103646951"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 07 Jan 2025 07:31:14 -0800
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
Subject: [PATCH net-next v2 3/8] bpf: cpumap: switch to GRO from netif_receive_skb_list()
Date: Tue,  7 Jan 2025 16:29:35 +0100
Message-ID: <20250107152940.26530-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107152940.26530-1-aleksander.lobakin@intel.com>
References: <20250107152940.26530-1-aleksander.lobakin@intel.com>
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
2.47.1


