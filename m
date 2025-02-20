Return-Path: <bpf+bounces-52065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F965A3D439
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 10:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86796189AC90
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 09:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CE21EE7A8;
	Thu, 20 Feb 2025 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2GnKu5e"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218C1EE02A;
	Thu, 20 Feb 2025 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042606; cv=none; b=BDRvOFs79O6tLP1NM51xR7qsAVijW5+WMNSL8/MEkaw+FKhmwmM8bmPfFf1OCH7GC/oG9oD92aGg16odIjlSSuB5tR9Cyojw3pvJZmu6xIqGuXdpJhdfha7JB5+SfjoWWf65DrNg44uIEGlfLZ5S/dFTNUnlmEeAU3FBlift+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042606; c=relaxed/simple;
	bh=E1UXRj+rYj5wimRyBVLFjJd4blMvr+lEmcvsqaP+p3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EroVCXWkzQxTI2kYk87oa+LQai9NN9R3tYJtS+w1BvfCPrLqBari8WCUarWdiw1Mbe6QmYZCLBzWeqC+gLiHjRV4Y0rCyYjtznNmVHw8Kkh6Nn6i35nxOziyPqvj7spQrofqxJSHHVoLCIzX+hVJK6FxEltoTTQMgtjmtnmCGEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2GnKu5e; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740042605; x=1771578605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E1UXRj+rYj5wimRyBVLFjJd4blMvr+lEmcvsqaP+p3I=;
  b=g2GnKu5e1TOG95EkB8C0wTLrEkj+NGSSJQrQjWUiLU4tBTTynt651URv
   3CaJjFbuENJtHCH2dzuArXPVwdcBG5oTfim5Kk4Ueiyju4I8pILMp44MX
   CGJuvMHxiv2uN158oygexpZwnKHhjjW7M5SJiM1blymkIBDWzDZ3dhDmE
   E2kh2GIrPKxKAlEchUl3v9eEvmEMC1R3w+y4cqSsAwEmyfI0OXDopMRXm
   ZzvNOBCQFqTHuj8vBtttzPJ8zGTy/GR+tS3CAcT8B+5Rb81pN3XUDMkgH
   UM1wdk6L7LKLMlN+aTYS2x7hKH+m1g3cDJaAo+vKJaBdkXAekvRk2Jf9Z
   g==;
X-CSE-ConnectionGUID: +s+YmJ3ITtWpkYqQ99N3wA==
X-CSE-MsgGUID: vvGMl6q3Sd6KQ2+kvg+WeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40733477"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40733477"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:10:05 -0800
X-CSE-ConnectionGUID: GCbbDO9LSza61hfQ/ahtxw==
X-CSE-MsgGUID: sxgqp6rPQPCjV5Xio1a0bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="120084549"
Received: from brc05.iind.intel.com (HELO brc05..) ([10.190.162.156])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 01:10:01 -0800
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
	tushar.vyavahare@intel.com
Subject: [PATCH bpf-next 1/6] selftests/xsk: Add packet stream replacement functions
Date: Thu, 20 Feb 2025 08:41:42 +0000
Message-Id: <20250220084147.94494-2-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220084147.94494-1-tushar.vyavahare@intel.com>
References: <20250220084147.94494-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pkt_stream_replace function to replace the packet stream for a given
ifobject. Add pkt_stream_replace_both function to replace the packet
streams for both transmit and receive ifobject in test_spec. Enhance test
framework to handle packet stream replacements efficiently.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 29 +++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 11f047b8af75..1d9b03666ee6 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -757,14 +757,15 @@ static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream)
 	return pkt_stream_generate(pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
 }
 
-static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
+static void pkt_stream_replace(struct ifobject *ifobj, u32 nb_pkts, u32 pkt_len)
 {
-	struct pkt_stream *pkt_stream;
+	ifobj->xsk->pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
+}
 
-	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
-	test->ifobj_tx->xsk->pkt_stream = pkt_stream;
-	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
-	test->ifobj_rx->xsk->pkt_stream = pkt_stream;
+static void pkt_stream_replace_both(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
+{
+	pkt_stream_replace(test->ifobj_tx, nb_pkts, pkt_len);
+	pkt_stream_replace(test->ifobj_rx, nb_pkts, pkt_len);
 }
 
 static void __pkt_stream_replace_half(struct ifobject *ifobj, u32 pkt_len,
@@ -2052,7 +2053,8 @@ static int testapp_stats_tx_invalid_descs(struct test_spec *test)
 
 static int testapp_stats_rx_full(struct test_spec *test)
 {
-	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
+	pkt_stream_replace_both(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2,
+				MIN_PKT_SIZE);
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
 	test->ifobj_rx->xsk->rxqsize = DEFAULT_UMEM_BUFFERS;
@@ -2063,7 +2065,8 @@ static int testapp_stats_rx_full(struct test_spec *test)
 
 static int testapp_stats_fill_empty(struct test_spec *test)
 {
-	pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
+	pkt_stream_replace_both(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2,
+				MIN_PKT_SIZE);
 	test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
 
 	test->ifobj_rx->use_fill_ring = false;
@@ -2086,7 +2089,7 @@ static int testapp_send_receive_unaligned_mb(struct test_spec *test)
 	test->mtu = MAX_ETH_JUMBO_SIZE;
 	test->ifobj_tx->umem->unaligned_mode = true;
 	test->ifobj_rx->umem->unaligned_mode = true;
-	pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
+	pkt_stream_replace_both(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
 	return testapp_validate_traffic(test);
 }
 
@@ -2101,7 +2104,7 @@ static int testapp_single_pkt(struct test_spec *test)
 static int testapp_send_receive_mb(struct test_spec *test)
 {
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-	pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
+	pkt_stream_replace_both(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE);
 
 	return testapp_validate_traffic(test);
 }
@@ -2252,7 +2255,7 @@ static int testapp_poll_txq_tmout(struct test_spec *test)
 	test->ifobj_tx->use_poll = true;
 	/* create invalid frame by set umem frame_size and pkt length equal to 2048 */
 	test->ifobj_tx->umem->frame_size = 2048;
-	pkt_stream_replace(test, 2 * DEFAULT_PKT_CNT, 2048);
+	pkt_stream_replace_both(test, 2 * DEFAULT_PKT_CNT, 2048);
 	return testapp_validate_traffic_single_thread(test, test->ifobj_tx);
 }
 
@@ -2389,7 +2392,7 @@ static int testapp_send_receive_2k_frame(struct test_spec *test)
 {
 	test->ifobj_tx->umem->frame_size = 2048;
 	test->ifobj_rx->umem->frame_size = 2048;
-	pkt_stream_replace(test, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
+	pkt_stream_replace_both(test, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
 	return testapp_validate_traffic(test);
 }
 
@@ -2511,7 +2514,7 @@ static int testapp_hw_sw_max_ring_size(struct test_spec *test)
 	 */
 	test->ifobj_tx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
 	test->ifobj_rx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
-	pkt_stream_replace(test, max_descs, MIN_PKT_SIZE);
+	pkt_stream_replace_both(test, max_descs, MIN_PKT_SIZE);
 	return testapp_validate_traffic(test);
 }
 
-- 
2.34.1


