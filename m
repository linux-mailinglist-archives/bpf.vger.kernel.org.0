Return-Path: <bpf+bounces-33224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB17E919E70
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 06:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2D31C22D4E
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 04:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6831C6BE;
	Thu, 27 Jun 2024 04:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNn5A4n+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD21C287;
	Thu, 27 Jun 2024 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719464121; cv=none; b=uO9yz7+HGPOBILZze50o+wmu6uzlY/pXQNjQ9y+YCV81/0WjwG+bgPcg6DBRix5rKf55Kjx00f1BNoadsU5WBcBwI5pHEDkVdaBxb5McjMU4be663xOlna5/x5fR6Nsvez1sBVssy1zHVsDIk5TFfDmqiHBY0mp/Pivlz2Q1Dh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719464121; c=relaxed/simple;
	bh=vaI0hJkS3RTtwDY5WYiVCCW6rAB64mqC0Qxcc/84o84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HbUS+dXXiTREWZ+aY5RqmD152fJbyU6204KzzKpqvb/Q2hWA121MyEj97DglWHG9hSwUTkNk/JUsKdcy8j7fEffW8YRDu0uBNIWjGILDzv6+PrL+WWWdXfEvHZTTgYvlyZf4fDP2AF8/+mhjV27Cj7DarP28O8RvN2IMid4Tzrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNn5A4n+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719464120; x=1751000120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vaI0hJkS3RTtwDY5WYiVCCW6rAB64mqC0Qxcc/84o84=;
  b=WNn5A4n+UoovyKzRhiMMaIYTzcNlvr9jtbXAzbdnXfP7EReECHT2eYeW
   A+fL1JpX8nK+ZUmaWFidSI/ZJPnShBlMfvoUElwFgx9S/pysjpXueV28M
   HjvQPMq1udbahq6s3vzazSC76Z/FBzyqiHK/+i4H8ta8/yyNWjnBLPAd4
   HPgBy3t8ywgzigZlEol+u/2h8jODlQ3L70+xn7HiEcRhFovpWhAAMmCEv
   4UByQmHHiG/A3oWlg++sTQtYIJSqwBZiwLzdfJLRcW4pwE2SyjUkM9dWX
   raNs7b3WzoWyWr9cAldU92L3YjY98JSVubmyTGq+zHQmtvxL790em1sGj
   w==;
X-CSE-ConnectionGUID: O1hhklP9SF+D20oGnZgXFw==
X-CSE-MsgGUID: 8WXVyz74SbuB3DydH93B6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27966819"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="27966819"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 21:55:16 -0700
X-CSE-ConnectionGUID: h4p/wfIUTgitj4csrRjpEQ==
X-CSE-MsgGUID: v2zhV3HIQdWl4KhndZMZ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="49210024"
Received: from intel.iind.intel.com (HELO brc5..) ([10.190.162.156])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 21:55:12 -0700
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
Subject: [PATCH bpf-next v2 2/2] selftests/xsk: Enhance batch size support with dynamic configurations
Date: Thu, 27 Jun 2024 04:35:48 +0000
Message-Id: <20240627043548.221724-3-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627043548.221724-1-tushar.vyavahare@intel.com>
References: <20240627043548.221724-1-tushar.vyavahare@intel.com>
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


