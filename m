Return-Path: <bpf+bounces-33602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FCA91EEDA
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 08:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721C51C20BD9
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 06:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462D012CD8B;
	Tue,  2 Jul 2024 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Id7400Wq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B8DDCB;
	Tue,  2 Jul 2024 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719901148; cv=none; b=WFfgp6pIT7yBVZ1Rwky+Y5pi+gphoyWck8K/9RGisfDVpycPv/dewZF41QAMn4uUr8wIlyMR8GCvY3fPJ38j9Cm+jrVTnJRSo/cjRba1p9vI4OXBDIt7mbL+NUeRCIZUUVJ+rEGsoHOkqiAMR7Br2F+PpXntOJcLwtpO2uWJNw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719901148; c=relaxed/simple;
	bh=oToZMuJR2/qo6Gyj3gAHTjZS4nXZfbm1dOZVp2xC6/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s9VhohoWZ+adAgMYbpsrBakEGBw6enmqQjAOhZNBgn7fPv7ojPd6ndm9wo1L0vnS3NT6WzLsVlojfLNXbM0HyEXlXQ0zrlNgt+Bk3pW+eliff3wrrwfXtSou3eGcUhNEdUXa1morPNy5AukN/KwMW6/+T/9zekE1SM70yyWb228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Id7400Wq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719901147; x=1751437147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oToZMuJR2/qo6Gyj3gAHTjZS4nXZfbm1dOZVp2xC6/8=;
  b=Id7400WquvhwO03o8uuH40YaX5wDQ8blJj54zDrEVagFwakww9dh9eRY
   tao66XPJq3OE9KJOcPHjItn5diE3XOMmjIaarf/x4+jLIvnkrA+yw56dw
   IYRsFjNi51FCNEcxuoueKr3t2cyIsKKeSbrgTVynmNeyY5E74BCROeHdK
   zwkMaXl4K1kmtg2n/Q5kFqSJmU7wB5+aCDyzoXUN2ZLvHMFLECuByfnsy
   ZWeMevVf5vTrbIJ3+x+eCJ6+ARd/I5Cql8wL4u8Tzxz++A4YHP1t7uIIj
   Wey8X+zsBTx1b5MEZFdAtT4YsidxvLozjTiP/5ivaidcLf6i0OL7enh0C
   g==;
X-CSE-ConnectionGUID: hS3XKiy1QVaAT3G5dCwLog==
X-CSE-MsgGUID: X6DA0DIeRdqWNVBKpxvJDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20866610"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20866610"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:19:07 -0700
X-CSE-ConnectionGUID: AWf/AEUhQdKOVQtzrdbCNA==
X-CSE-MsgGUID: BfAv4RIjQhGrrjtd2Qh9rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45919950"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:19:03 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next v3 2/2] selftests/xsk: Enhance batch size support with dynamic configurations
Date: Tue,  2 Jul 2024 05:59:16 +0000
Message-Id: <20240702055916.48071-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702055916.48071-1-tushar.vyavahare@intel.com>
References: <20240702055916.48071-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce dynamic adjustment capabilities for fill_size and comp_size
parameters to support larger batch sizes beyond the previous 2K limit.

Update HW_SW_MAX_RING_SIZE test cases to evaluate AF_XDP's robustness by
pushing hardware and software ring sizes to their limits. This test
ensures AF_XDP's reliability amidst potential producer/consumer throttling
due to maximum ring utilization.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 26 ++++++++++++++++++------
 tools/testing/selftests/bpf/xskxceiver.h |  2 ++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 088df53869e8..8144fd145237 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -196,6 +196,12 @@ static int xsk_configure_umem(struct ifobject *ifobj, struct xsk_umem_info *umem
 	};
 	int ret;
 
+	if (umem->fill_size)
+		cfg.fill_size = umem->fill_size;
+
+	if (umem->comp_size)
+		cfg.comp_size = umem->comp_size;
+
 	if (umem->unaligned_mode)
 		cfg.flags |= XDP_UMEM_UNALIGNED_CHUNK_FLAG;
 
@@ -265,6 +271,10 @@ static int __xsk_configure_socket(struct xsk_socket_info *xsk, struct xsk_umem_i
 		cfg.bind_flags |= XDP_SHARED_UMEM;
 	if (ifobject->mtu > MAX_ETH_PKT_SIZE)
 		cfg.bind_flags |= XDP_USE_SG;
+	if (umem->comp_size)
+		cfg.tx_size = umem->comp_size;
+	if (umem->fill_size)
+		cfg.rx_size = umem->fill_size;
 
 	txr = ifobject->tx_on ? &xsk->tx : NULL;
 	rxr = ifobject->rx_on ? &xsk->rx : NULL;
@@ -1616,7 +1626,7 @@ static void xsk_populate_fill_ring(struct xsk_umem_info *umem, struct pkt_stream
 	if (umem->num_frames < XSK_RING_PROD__DEFAULT_NUM_DESCS)
 		buffers_to_fill = umem->num_frames;
 	else
-		buffers_to_fill = XSK_RING_PROD__DEFAULT_NUM_DESCS;
+		buffers_to_fill = umem->fill_size;
 
 	ret = xsk_ring_prod__reserve(&umem->fq, buffers_to_fill, &idx);
 	if (ret != buffers_to_fill)
@@ -2445,7 +2455,7 @@ static int testapp_hw_sw_min_ring_size(struct test_spec *test)
 
 static int testapp_hw_sw_max_ring_size(struct test_spec *test)
 {
-	u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 2;
+	u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 4;
 	int ret;
 
 	test->set_ring = true;
@@ -2453,7 +2463,8 @@ static int testapp_hw_sw_max_ring_size(struct test_spec *test)
 	test->ifobj_tx->ring.tx_pending = test->ifobj_tx->ring.tx_max_pending;
 	test->ifobj_tx->ring.rx_pending  = test->ifobj_tx->ring.rx_max_pending;
 	test->ifobj_rx->umem->num_frames = max_descs;
-	test->ifobj_rx->xsk->rxqsize = max_descs;
+	test->ifobj_rx->umem->fill_size = max_descs;
+	test->ifobj_rx->umem->comp_size = max_descs;
 	test->ifobj_tx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
 	test->ifobj_rx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
 
@@ -2461,9 +2472,12 @@ static int testapp_hw_sw_max_ring_size(struct test_spec *test)
 	if (ret)
 		return ret;
 
-	/* Set batch_size to 4095 */
-	test->ifobj_tx->xsk->batch_size = max_descs - 1;
-	test->ifobj_rx->xsk->batch_size = max_descs - 1;
+	/* Set batch_size to 8152 for testing, as the ice HW ignores the 3 lowest bits when
+	 * updating the Rx HW tail register.
+	 */
+	test->ifobj_tx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
+	test->ifobj_rx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
+	pkt_stream_replace(test, max_descs, MIN_PKT_SIZE);
 	return testapp_validate_traffic(test);
 }
 
diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
index 906de5fab7a3..885c948c5d83 100644
--- a/tools/testing/selftests/bpf/xskxceiver.h
+++ b/tools/testing/selftests/bpf/xskxceiver.h
@@ -80,6 +80,8 @@ struct xsk_umem_info {
 	void *buffer;
 	u32 frame_size;
 	u32 base_addr;
+	u32 fill_size;
+	u32 comp_size;
 	bool unaligned_mode;
 };
 
-- 
2.34.1


