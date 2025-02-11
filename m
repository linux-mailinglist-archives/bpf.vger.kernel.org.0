Return-Path: <bpf+bounces-51185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B034BA31813
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 22:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEACF1889770
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 21:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACADD268FC2;
	Tue, 11 Feb 2025 21:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QocOpalk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4F268C55;
	Tue, 11 Feb 2025 21:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310236; cv=none; b=phdZcX/CPtSsPA0SpY0gDI7+d2oVRAd4xShVbOtLagO34Woh7Tu9rp5++iR2upWhrOnXr187ET+SvlTsznrYdHGK2CYC9+Zb5uTbqMzwPNSj2sUU1j3dYiHrhEa5yf0uu21BfoHCKj9grvNF7p2tJwY6ZslV3uthgSqlVTfmLeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310236; c=relaxed/simple;
	bh=Y9JP1Z1HkgTXXFYGrxS4/bDS4hQxSsHx+Oa2jzlCRxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iA+E5kNyd0ZodV3jGYFuLlEMj+WVpIJKvdD5vJ8fNbk1vY1ZiZan9C+g5TTgWV/8lPEd8Qb/BWund0yP6d6RgJOvkS18nmmf8hW7Pa2bcYZa1oek7LbqwgBqVz8hSho9VtnLcEpgH8RzAFAvq7VCHzbPUj1Ia1tZMzU30R/HVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QocOpalk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739310234; x=1770846234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y9JP1Z1HkgTXXFYGrxS4/bDS4hQxSsHx+Oa2jzlCRxk=;
  b=QocOpalkjH5ogUbFvIdgzuCgwbTgeweB+ZZyEfo3NJ83ocZu8SEHQj7w
   Iwc5lfT/My8yRW49LholS0R+8G87PGF6KeVWA5znE3PoFHsbY8stQI0UF
   ranwFpYY+AGdMmxDls14XmGjDousIBt7cBZzVz1HZtF44geV85IVLD1L9
   mlH4tkaurEZfHvN0vxszFfOyGvAS/KZ5qO8xwqZ6Z2W1hLPoJkWHahP68
   cYA3ha82wUvB1yHyGAc5r6O4B2h5k+5vFZQcMLloU9b7t/v5Ol8KlJf9A
   W8pfk6X+11uKIkGOWPU64qupWcGWtnmwZ2f8rYx0Uw6r0sDT55tIktmNf
   g==;
X-CSE-ConnectionGUID: KmZZvbFXRyWAO6oS+jRYrQ==
X-CSE-MsgGUID: 3kEyvkhRQcGJ8qo9PxTvvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39185254"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39185254"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:43:49 -0800
X-CSE-ConnectionGUID: TYBtCpAPSYK51OGpi4j4Pg==
X-CSE-MsgGUID: qLovqWOzQSqRXjuaIN1rCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="143478681"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 11 Feb 2025 13:43:49 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Zdenek Bouska <zdenek.bouska@siemens.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 5/6] igc: Fix HW RX timestamp when passed by ZC XDP
Date: Tue, 11 Feb 2025 13:43:36 -0800
Message-ID: <20250211214343.4092496-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250211214343.4092496-1-anthony.l.nguyen@intel.com>
References: <20250211214343.4092496-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zdenek Bouska <zdenek.bouska@siemens.com>

Fixes HW RX timestamp in the following scenario:
- AF_PACKET socket with enabled HW RX timestamps is created
- AF_XDP socket with enabled zero copy is created
- frame is forwarded to the BPF program, where the timestamp should
  still be readable (extracted by igc_xdp_rx_timestamp(), kfunc
  behind bpf_xdp_metadata_rx_timestamp())
- the frame got XDP_PASS from BPF program, redirecting to the stack
- AF_PACKET socket receives the frame with HW RX timestamp

Moves the skb timestamp setting from igc_dispatch_skb_zc() to
igc_construct_skb_zc() so that igc_construct_skb_zc() is similar to
igc_construct_skb().

This issue can also be reproduced by running:
 # tools/testing/selftests/bpf/xdp_hw_metadata enp1s0
When a frame with the wrong port 9092 (instead of 9091) is used:
 # echo -n xdp | nc -u -q1 192.168.10.9 9092
then the RX timestamp is missing and xdp_hw_metadata prints:
 skb hwtstamp is not found!

With this fix or when copy mode is used:
 # tools/testing/selftests/bpf/xdp_hw_metadata -c enp1s0
then RX timestamp is found and xdp_hw_metadata prints:
 found skb hwtstamp = 1736509937.852786132

Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Reviewed-by: Song Yoong Siang <yoong.siang.song@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 56a35d58e7a6..21f318f12a8d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2701,8 +2701,9 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 }
 
 static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
-					    struct xdp_buff *xdp)
+					    struct igc_xdp_buff *ctx)
 {
+	struct xdp_buff *xdp = &ctx->xdp;
 	unsigned int totalsize = xdp->data_end - xdp->data_meta;
 	unsigned int metasize = xdp->data - xdp->data_meta;
 	struct sk_buff *skb;
@@ -2721,27 +2722,28 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
 		__skb_pull(skb, metasize);
 	}
 
+	if (ctx->rx_ts) {
+		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
+		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
+	}
+
 	return skb;
 }
 
 static void igc_dispatch_skb_zc(struct igc_q_vector *q_vector,
 				union igc_adv_rx_desc *desc,
-				struct xdp_buff *xdp,
-				ktime_t timestamp)
+				struct igc_xdp_buff *ctx)
 {
 	struct igc_ring *ring = q_vector->rx.ring;
 	struct sk_buff *skb;
 
-	skb = igc_construct_skb_zc(ring, xdp);
+	skb = igc_construct_skb_zc(ring, ctx);
 	if (!skb) {
 		ring->rx_stats.alloc_failed++;
 		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &ring->flags);
 		return;
 	}
 
-	if (timestamp)
-		skb_hwtstamps(skb)->hwtstamp = timestamp;
-
 	if (igc_cleanup_headers(ring, desc, skb))
 		return;
 
@@ -2777,7 +2779,6 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 		union igc_adv_rx_desc *desc;
 		struct igc_rx_buffer *bi;
 		struct igc_xdp_buff *ctx;
-		ktime_t timestamp = 0;
 		unsigned int size;
 		int res;
 
@@ -2807,6 +2808,8 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 			 */
 			bi->xdp->data_meta += IGC_TS_HDR_LEN;
 			size -= IGC_TS_HDR_LEN;
+		} else {
+			ctx->rx_ts = NULL;
 		}
 
 		bi->xdp->data_end = bi->xdp->data + size;
@@ -2815,7 +2818,7 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 		res = __igc_xdp_run_prog(adapter, prog, bi->xdp);
 		switch (res) {
 		case IGC_XDP_PASS:
-			igc_dispatch_skb_zc(q_vector, desc, bi->xdp, timestamp);
+			igc_dispatch_skb_zc(q_vector, desc, ctx);
 			fallthrough;
 		case IGC_XDP_CONSUMED:
 			xsk_buff_free(bi->xdp);
-- 
2.47.1


