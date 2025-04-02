Return-Path: <bpf+bounces-55174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD7A793E7
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 19:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF803B4456
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 17:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903001C8629;
	Wed,  2 Apr 2025 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkmbTN6t"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569FF1A5BB7;
	Wed,  2 Apr 2025 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615553; cv=none; b=QPJPgn+lic9BgQQ2Ryi1a/BGriYlxmA0e5vbBnuXFawmGiogWk6JR8Xp/ouueDd5BBbMyXlUWIKRDg/j82hpnqWswGVdkBFsdrG9gwvHm9QP3sz7R9HqYAMxDy9hAJs6XIWmM3hNMb4ciOEhyP9liL6V98P732ZuQDXKsUyjew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615553; c=relaxed/simple;
	bh=poj5Uz7hN2nI/ThlVRjgp5nTeEJW9joe9UEDFKvNk3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enxBVTcH6adqSAXYMl/B9GvwIr4+HfIdiF6YZ4vBujsCLTCnEoBzuSpRdibkNDi5A7lOvqrtRHiaejST881CehwN/b0DcdvMx2F4nvr8PZOdd98IonoQqOaxC7y5klFbCe6/vC0S36qV863MHbXaWaTaLMB1sYkgwZn8pyenEhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkmbTN6t; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743615551; x=1775151551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=poj5Uz7hN2nI/ThlVRjgp5nTeEJW9joe9UEDFKvNk3Y=;
  b=jkmbTN6tXv9CVJwYoV4sAgIFT/KbYLvPNmhNdHguJvC5M2DZsbgGlPX+
   OveylZT/h7Ach7Ib8Nwq0kp1KK9/PyA9h1fecJRZYAc9pMzwJh+nyq8b3
   OHxy/AiccTi9sVjDpr4BAy6HbnBe5ruNqCDHwiVtcpxuXHZYiT4OLbass
   9ChlSt69K6rIAVhR88AalrspMaxUwEELJZQiNpVSpuv/q4E/3nG8WAtYH
   Mdr8GW8Jkus0nYTRdwAmFg+iSCYD1vzwqOSzoZgXozNGpAQeXPygsfUim
   GhyBrUH47kB6M7I4Spj7mzsGGXFyocZmsxvgd2aGq0SRalUYAnQ4ELfKO
   A==;
X-CSE-ConnectionGUID: ZjaaOjjBSiajkdvaFW63Yw==
X-CSE-MsgGUID: gYyB3UftSPq6zEHnbBjOLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44257258"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44257258"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 10:39:09 -0700
X-CSE-ConnectionGUID: W2aEGKaXQS+5hhlFnLu8FA==
X-CSE-MsgGUID: FVAVRICRTPKfyZRShgXojg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="149968772"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 02 Apr 2025 10:39:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 1/5] igc: Fix XSK queue NAPI ID mapping
Date: Wed,  2 Apr 2025 10:38:53 -0700
Message-ID: <20250402173900.1957261-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402173900.1957261-1-anthony.l.nguyen@intel.com>
References: <20250402173900.1957261-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe Damato <jdamato@fastly.com>

In commit b65969856d4f ("igc: Link queues to NAPI instances"), the XSK
queues were incorrectly unmapped from their NAPI instances. After
discussion on the mailing list and the introduction of a test to codify
the expected behavior, we can see that the unmapping causes the
check_xsk test to fail:

NETIF=enp86s0 ./tools/testing/selftests/drivers/net/queues.py

[...]
  # Check|     ksft_eq(q.get('xsk', None), {},
  # Check failed None != {} xsk attr on queue we configured
  not ok 4 queues.check_xsk

After this commit, the test passes:

  ok 4 queues.check_xsk

Note that the test itself is only in net-next, so I tested this change
by applying it to my local net-next tree, booting, and running the test.

Cc: stable@vger.kernel.org
Fixes: b65969856d4f ("igc: Link queues to NAPI instances")
Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 2 --
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 drivers/net/ethernet/intel/igc/igc_xdp.c  | 2 --
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index cd1d7b6c1782..c35cc5cb1185 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -337,8 +337,6 @@ struct igc_adapter {
 	struct igc_led_classdev *leds;
 };
 
-void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
-			struct napi_struct *napi);
 void igc_up(struct igc_adapter *adapter);
 void igc_down(struct igc_adapter *adapter);
 int igc_open(struct net_device *netdev);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 491d942cefca..27c99ff59ed4 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5022,8 +5022,8 @@ static int igc_sw_init(struct igc_adapter *adapter)
 	return 0;
 }
 
-void igc_set_queue_napi(struct igc_adapter *adapter, int vector,
-			struct napi_struct *napi)
+static void igc_set_queue_napi(struct igc_adapter *adapter, int vector,
+			       struct napi_struct *napi)
 {
 	struct igc_q_vector *q_vector = adapter->q_vector[vector];
 
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index c538e6b18aad..9eb47b4beb06 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -97,7 +97,6 @@ static int igc_xdp_enable_pool(struct igc_adapter *adapter,
 		napi_disable(napi);
 	}
 
-	igc_set_queue_napi(adapter, queue_id, NULL);
 	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
 	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
 
@@ -147,7 +146,6 @@ static int igc_xdp_disable_pool(struct igc_adapter *adapter, u16 queue_id)
 	xsk_pool_dma_unmap(pool, IGC_RX_DMA_ATTR);
 	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
 	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
-	igc_set_queue_napi(adapter, queue_id, napi);
 
 	if (needs_reset) {
 		napi_enable(napi);
-- 
2.47.1


