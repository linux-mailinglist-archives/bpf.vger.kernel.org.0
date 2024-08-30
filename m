Return-Path: <bpf+bounces-38609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ED1966B19
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 23:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B749228153E
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 21:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA011C174F;
	Fri, 30 Aug 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZ/F41EG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1291BF7FD;
	Fri, 30 Aug 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051903; cv=none; b=IVvvcXwU0SKjrhMLtvavfo1dJxK9lB4oiAz64dI/KWdZa2ZuAEGb2tn3ohOYOOPXgoRXE2LZZAfDOA8jK0hHVVZdLZYFK6nVRI9apLzQjbzuSyucEg8jQ4KNyBehlobyGwbBSFaKmfFI14seZSgPFWYqKuMIAwVjUI1jQOzBOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051903; c=relaxed/simple;
	bh=4QKNxIJXLhyW7TCh8hyly0p/oWDPPtldet7OPIazz6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFrMBh1GyDpQ8+rNRFwEnY7CN6mRXX8wBIk7xMXUJ6FiCxd1vrnPYTLB3tDYdXRzfwAxN2m2Q94U3JfgqrFrqAhRSQqVAm6O7x3gBdf8gDfMUf5N+Zglzoobq15BSK9iT3zre/dF4q1mR4mHk1a4bkS1UX8PhFpasNvE7ueWgNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZ/F41EG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725051902; x=1756587902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4QKNxIJXLhyW7TCh8hyly0p/oWDPPtldet7OPIazz6A=;
  b=dZ/F41EG9CvF9gKNVh+qqnsvZtChP8KZHRPki2aOK0Us6VmDpVroXn16
   aMhTyrsqAGom+SgsvhgH4h3+KcLCmAx+djdpEVzmZ+CXvn5TN/Yl1c367
   wf8CilK0sMox+WQagQv6tr2KPvRs4mvqKzVQ10scI5xHfNSXnENrRCGbW
   O+zidpvRbpExI+JB+/rYIiGsxjggg/4edcqO1G7HKRB+yr0W0V8tCJHdc
   2lBJdW9NzvpDvpK2d6YeJmqw7OB0FJGdcgYySa70yG5lfSmrMwXJ845JA
   OJolYjqjgzoNP8G27Slhz+Z5BOoP61algQlcHX5IBOx87hp7WkT5zJJm8
   A==;
X-CSE-ConnectionGUID: Dlz0MCpXTwqFBFFI720Fwg==
X-CSE-MsgGUID: bQC9BfLUR9Wap0XSicEBOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="13304265"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="13304265"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 14:05:00 -0700
X-CSE-ConnectionGUID: 6xg0zqV+T/iRd36Zho1dKA==
X-CSE-MsgGUID: Q2/q+nMjREm82prqpiZGow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63625247"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 30 Aug 2024 14:04:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	bigeasy@linutronix.de,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 2/6] igc: Get rid of spurious interrupts
Date: Fri, 30 Aug 2024 14:04:44 -0700
Message-ID: <20240830210451.2375215-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
References: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kurt Kanzenbach <kurt@linutronix.de>

When running the igc with XDP/ZC in busy polling mode with deferral of hard
interrupts, interrupts still happen from time to time. That is caused by
the igc task watchdog which triggers Rx interrupts periodically.

That mechanism has been introduced to overcome skb/memory allocation
failures [1]. So the Rx clean functions stop processing the Rx ring in case
of such failure. The task watchdog triggers Rx interrupts periodically in
the hope that memory became available in the mean time.

The current behavior is undesirable for real time applications, because the
driver induced Rx interrupts trigger also the softirq processing. However,
all real time packets should be processed by the application which uses the
busy polling method.

Therefore, only trigger the Rx interrupts in case of real allocation
failures. Introduce a new flag for signaling that condition.

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=3be507547e6177e5c808544bd6a2efa2c7f1d436

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 30 ++++++++++++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 8642d67af6cc..eac0f966e0e4 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -687,6 +687,7 @@ enum igc_ring_flags_t {
 	IGC_RING_FLAG_TX_DETECT_HANG,
 	IGC_RING_FLAG_AF_XDP_ZC,
 	IGC_RING_FLAG_TX_HWTSTAMP,
+	IGC_RING_FLAG_RX_ALLOC_FAILED,
 };
 
 #define ring_uses_large_buffer(ring) \
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 96b2f2a37bc3..da322899e834 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2191,6 +2191,7 @@ static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
 	page = dev_alloc_pages(igc_rx_pg_order(rx_ring));
 	if (unlikely(!page)) {
 		rx_ring->rx_stats.alloc_failed++;
+		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
 		return false;
 	}
 
@@ -2207,6 +2208,7 @@ static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
 		__free_page(page);
 
 		rx_ring->rx_stats.alloc_failed++;
+		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
 		return false;
 	}
 
@@ -2658,6 +2660,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		if (!skb) {
 			rx_ring->rx_stats.alloc_failed++;
 			rx_buffer->pagecnt_bias++;
+			set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
 			break;
 		}
 
@@ -2738,6 +2741,7 @@ static void igc_dispatch_skb_zc(struct igc_q_vector *q_vector,
 	skb = igc_construct_skb_zc(ring, xdp);
 	if (!skb) {
 		ring->rx_stats.alloc_failed++;
+		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &ring->flags);
 		return;
 	}
 
@@ -5807,11 +5811,29 @@ static void igc_watchdog_task(struct work_struct *work)
 	if (adapter->flags & IGC_FLAG_HAS_MSIX) {
 		u32 eics = 0;
 
-		for (i = 0; i < adapter->num_q_vectors; i++)
-			eics |= adapter->q_vector[i]->eims_value;
-		wr32(IGC_EICS, eics);
+		for (i = 0; i < adapter->num_q_vectors; i++) {
+			struct igc_q_vector *q_vector = adapter->q_vector[i];
+			struct igc_ring *rx_ring;
+
+			if (!q_vector->rx.ring)
+				continue;
+
+			rx_ring = adapter->rx_ring[q_vector->rx.ring->queue_index];
+
+			if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
+				eics |= q_vector->eims_value;
+				clear_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
+			}
+		}
+		if (eics)
+			wr32(IGC_EICS, eics);
 	} else {
-		wr32(IGC_ICS, IGC_ICS_RXDMT0);
+		struct igc_ring *rx_ring = adapter->rx_ring[0];
+
+		if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
+			clear_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
+			wr32(IGC_ICS, IGC_ICS_RXDMT0);
+		}
 	}
 
 	igc_ptp_tx_hang(adapter);
-- 
2.42.0


