Return-Path: <bpf+bounces-48023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD90DA0329E
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834E53A190C
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350141E3DD8;
	Mon,  6 Jan 2025 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXjavCUW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E647C1E2848;
	Mon,  6 Jan 2025 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201986; cv=none; b=AqIBX2mxIGjBjFmeY3kKq5V/uwsQbasbcLs1oJRyYXQyD0q5jztCG1galDhJt/54qvKK49DIGnkdNaHaeGv3Ek5o3s0ODVYQX8ZXWY29sie/0jtIqizH0Ahvh7VF/2XVFKXr2LT3T43eTaowndm3J5/+3E1NbpBQvpqxU1gMC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201986; c=relaxed/simple;
	bh=fLGf8/6fPBYueu7mrxrPBg6Grmc9rOZTAA8GVu7hqQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJLIWgr2iuBFyqRNm8LR2XZK+GTUEI4jzgZDb2hXIA3km3M4DJ5Xm0qRl9jFLzRaqt36Scci9wJ1zxJXMJFCe4VLunGkkco2l07zvlkXXY6zKIz1lnZZe201arNwtpxM6B8QmLEMd+lYfmK1pUj6c6ymhdrrfh7VUIahNewuv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXjavCUW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201984; x=1767737984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fLGf8/6fPBYueu7mrxrPBg6Grmc9rOZTAA8GVu7hqQ4=;
  b=NXjavCUWdHramNG4LOr0+kisGRZtdY33Gv4MQoPaIUb4X+eWrB0VAHpu
   9fFBdy4mmPA3HTyPvU7cX1yvnIO8SGfsXIBMLf3U4ugus6OwT6ss6epUG
   Z2y5MJupNOb9hDXIBKQZINke7iDxo5iaGscn0yVAORAKtA+3fD42FjeT9
   Q1XvO9qmEcmC53VF4yTqW93NHpFC8gcAn8g4SgCuuOhhHcvIUUzwGhaT0
   9PKZwqTacMydragYNu2dB44/ySBsrSt3rTbhl3UsktOJfhyS4tiE2mRY2
   Z327sCasy7cydbB0dhP9TeYsC120Se+/LHNHa4ljmH7GrFf8BZEjGLnah
   w==;
X-CSE-ConnectionGUID: r+wmTz5eS4mvE4q9siaIuQ==
X-CSE-MsgGUID: bynyfv2fS3Ogm0z9ILcXYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46858750"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46858750"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:19:41 -0800
X-CSE-ConnectionGUID: uGP8ehouTF6HRYXquKwL8w==
X-CSE-MsgGUID: 5HfXrO1FQciwYVLfvM640Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102368482"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2025 14:19:40 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Yue Haibing <yuehaibing@huawei.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	horms@kernel.org,
	sven.auhagen@voleatech.de,
	Jacob Keller <jacob.e.keller@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net-next 11/15] ixgbevf: Fix passing 0 to ERR_PTR in ixgbevf_run_xdp()
Date: Mon,  6 Jan 2025 14:19:19 -0800
Message-ID: <20250106221929.956999-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
References: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yue Haibing <yuehaibing@huawei.com>

ixgbevf_run_xdp() converts customed xdp action to a negative error code
with the sk_buff pointer type which be checked with IS_ERR in
ixgbevf_clean_rx_irq(). Remove this error pointer handing instead use
plain int return value.

Fixes: c7aec59657b6 ("ixgbevf: Add XDP support for pass and drop actions")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 2829bac9af94..6442f115a262 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -737,10 +737,6 @@ static bool ixgbevf_cleanup_headers(struct ixgbevf_ring *rx_ring,
 				    union ixgbe_adv_rx_desc *rx_desc,
 				    struct sk_buff *skb)
 {
-	/* XDP packets use error pointer so abort at this point */
-	if (IS_ERR(skb))
-		return true;
-
 	/* verify that the packet does not have any known errors */
 	if (unlikely(ixgbevf_test_staterr(rx_desc,
 					  IXGBE_RXDADV_ERR_FRAME_ERR_MASK))) {
@@ -1049,9 +1045,9 @@ static int ixgbevf_xmit_xdp_ring(struct ixgbevf_ring *ring,
 	return IXGBEVF_XDP_TX;
 }
 
-static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
-				       struct ixgbevf_ring  *rx_ring,
-				       struct xdp_buff *xdp)
+static int ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
+			   struct ixgbevf_ring *rx_ring,
+			   struct xdp_buff *xdp)
 {
 	int result = IXGBEVF_XDP_PASS;
 	struct ixgbevf_ring *xdp_ring;
@@ -1085,7 +1081,7 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 		break;
 	}
 xdp_out:
-	return ERR_PTR(-result);
+	return result;
 }
 
 static unsigned int ixgbevf_rx_frame_truesize(struct ixgbevf_ring *rx_ring,
@@ -1127,6 +1123,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 	struct sk_buff *skb = rx_ring->skb;
 	bool xdp_xmit = false;
 	struct xdp_buff xdp;
+	int xdp_res = 0;
 
 	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
 #if (PAGE_SIZE < 8192)
@@ -1170,11 +1167,11 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 			/* At larger PAGE_SIZE, frame_sz depend on len size */
 			xdp.frame_sz = ixgbevf_rx_frame_truesize(rx_ring, size);
 #endif
-			skb = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
+			xdp_res = ixgbevf_run_xdp(adapter, rx_ring, &xdp);
 		}
 
-		if (IS_ERR(skb)) {
-			if (PTR_ERR(skb) == -IXGBEVF_XDP_TX) {
+		if (xdp_res) {
+			if (xdp_res == IXGBEVF_XDP_TX) {
 				xdp_xmit = true;
 				ixgbevf_rx_buffer_flip(rx_ring, rx_buffer,
 						       size);
@@ -1194,7 +1191,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		}
 
 		/* exit if we failed to retrieve a buffer */
-		if (!skb) {
+		if (!xdp_res && !skb) {
 			rx_ring->rx_stats.alloc_rx_buff_failed++;
 			rx_buffer->pagecnt_bias++;
 			break;
@@ -1208,7 +1205,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 			continue;
 
 		/* verify the packet layout is correct */
-		if (ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
+		if (xdp_res || ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
 			skb = NULL;
 			continue;
 		}
-- 
2.47.1


