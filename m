Return-Path: <bpf+bounces-39359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACE99723DA
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521371C23761
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE6818C03E;
	Mon,  9 Sep 2024 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ki7jgxZU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683318B493;
	Mon,  9 Sep 2024 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914349; cv=none; b=cEtZYMi3WNXKYfZApqnc+Djlxtsm4uPXXnYSosg/HZ7ihlHV7OD6tFM6Adqaw5FqmClIBbE2cKHRnLS6JX6QyClsd3caI6aLr/V1sqVMHJauUvbcmZNNqNWvHm3kC+Q11Kd2mKL5GgzmtNNNOdTSJT5LCfeH/7TSyjdXs7T+UnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914349; c=relaxed/simple;
	bh=+J2ZDO7XXPFMPQ8okrUFarcI2IZ4bQuVJchMzMjP6Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ka9zk6D+cKJcov+xnD9zz7zkPunpHlmi8AmbDyiBB082qKm7tk9hDfrgiAVrVnQZ/cGnFWI8Tg5uaE8aCLc1h/KZbVvlJ4Z637kEm0nivA3SyyV2JLbqCsJXs+ZgW+ecmESUbiZ25S6n+FZBLYmWgfZK9HaW1epq9hzNdYokhNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ki7jgxZU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725914348; x=1757450348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+J2ZDO7XXPFMPQ8okrUFarcI2IZ4bQuVJchMzMjP6Cw=;
  b=ki7jgxZUQFrnlhY/szwASC7Gq6KgGWNAs3qgxvycHRPB/pjJx0DMm/cv
   YAMiuutxppD/0oimDwlJjAQoqPpZXp8eGJtUSjOnbpytsdVRbddLfQtfJ
   TPz+42iEDmrOQnhIn3J10m8s3FQWPSP5xOhdYIo/jtll4ytqFvTtZuU+q
   e6IOrPx17PoJTBkz4/AcUlt3l3GHm+jg723m3WR7/blsiMZ+Fa6NK3OEF
   0wbRCvmk8Eyz6tje4P5myCeiWaCBSquhIjddr/5veycXIELL3oJYD48Z3
   w3NZrxEi4krFi54FOiU7TGGcaB9wm838ebhg1M1iJBH+RxTleZjInF94T
   w==;
X-CSE-ConnectionGUID: S8OMR9KNS+Ko4VGpxwCU3g==
X-CSE-MsgGUID: E8lK/RBlSp2kwwXKuxYaUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24787125"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24787125"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 13:39:01 -0700
X-CSE-ConnectionGUID: E8ESHPY+T2GmMuSiR2rO8w==
X-CSE-MsgGUID: ZWSZ7nDJSIeLAGX8dAxg7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="67054826"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 09 Sep 2024 13:38:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	anthony.l.nguyen@intel.com,
	sven.auhagen@voleatech.de,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Kurt Kanzenbach <kurt@linutronix.de>,
	George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Subject: [PATCH net 5/5] igb: Always call igb_xdp_ring_update_tail() under Tx lock
Date: Mon,  9 Sep 2024 13:38:41 -0700
Message-ID: <20240909203842.3109822-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240909203842.3109822-1-anthony.l.nguyen@intel.com>
References: <20240909203842.3109822-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Always call igb_xdp_ring_update_tail() under __netif_tx_lock, add a comment
and lockdep assert to indicate that. This is needed to share the same TX
ring between XDP, XSK and slow paths. Furthermore, the current XDP
implementation is racy on tail updates.

Fixes: 9cbc948b5a20 ("igb: add XDP support")
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
[Kurt: Add lockdep assert and fixes tag]
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 9dc7c60838ed..1ef4cb871452 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -33,6 +33,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/pm_runtime.h>
 #include <linux/etherdevice.h>
+#include <linux/lockdep.h>
 #ifdef CONFIG_IGB_DCA
 #include <linux/dca.h>
 #endif
@@ -2914,8 +2915,11 @@ static int igb_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
+/* This function assumes __netif_tx_lock is held by the caller. */
 static void igb_xdp_ring_update_tail(struct igb_ring *ring)
 {
+	lockdep_assert_held(&txring_txq(ring)->_xmit_lock);
+
 	/* Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.
 	 */
@@ -3000,11 +3004,11 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
 		nxmit++;
 	}
 
-	__netif_tx_unlock(nq);
-
 	if (unlikely(flags & XDP_XMIT_FLUSH))
 		igb_xdp_ring_update_tail(tx_ring);
 
+	__netif_tx_unlock(nq);
+
 	return nxmit;
 }
 
@@ -8864,12 +8868,14 @@ static void igb_put_rx_buffer(struct igb_ring *rx_ring,
 
 static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 {
+	unsigned int total_bytes = 0, total_packets = 0;
 	struct igb_adapter *adapter = q_vector->adapter;
 	struct igb_ring *rx_ring = q_vector->rx.ring;
-	struct sk_buff *skb = rx_ring->skb;
-	unsigned int total_bytes = 0, total_packets = 0;
 	u16 cleaned_count = igb_desc_unused(rx_ring);
+	struct sk_buff *skb = rx_ring->skb;
+	int cpu = smp_processor_id();
 	unsigned int xdp_xmit = 0;
+	struct netdev_queue *nq;
 	struct xdp_buff xdp;
 	u32 frame_sz = 0;
 	int rx_buf_pgcnt;
@@ -8997,7 +9003,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 	if (xdp_xmit & IGB_XDP_TX) {
 		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
 
+		nq = txring_txq(tx_ring);
+		__netif_tx_lock(nq, cpu);
 		igb_xdp_ring_update_tail(tx_ring);
+		__netif_tx_unlock(nq);
 	}
 
 	u64_stats_update_begin(&rx_ring->rx_syncp);
-- 
2.42.0


