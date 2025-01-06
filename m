Return-Path: <bpf+bounces-48014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A291A0328B
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 23:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE4118814C9
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 22:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C18F1D86F2;
	Mon,  6 Jan 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdbTjfnJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AE1D6DB7;
	Mon,  6 Jan 2025 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201979; cv=none; b=LPW8Jt/RCoAfIcaiz5vJwsdgQSXzmFL0YdEQZ9Veu9TM55BsWL1b41K7D0BOhVUHhzVmWPQ3JwpyPWJNFs0JQdU6L75cL4y48xgmNtyBYTB7g5oiHQv7GlLW/+JZBAGSrpkKKijw/l2wCbUYLb67NJB4hbh6m1P4tZLmn27deMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201979; c=relaxed/simple;
	bh=nGduUpUyZ5qCUeJ2mWKo1JndO4Q6qohYIXpWHWU4x98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuhJ64Z6bN4/4JzfWNt5idJJjfPsqqOPveDdzgXNLa+vde8Orua5V+K7Ci78Hp437Lci91yPAFT0CdKj5ajtd39cOn6QHTt3AruL6tBdvkA0HbvximYYXUw8E5CgoN3yDQPsM1FsjdetPDh4q8aVY243aQ74ooqotPARofXLEGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdbTjfnJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201978; x=1767737978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nGduUpUyZ5qCUeJ2mWKo1JndO4Q6qohYIXpWHWU4x98=;
  b=KdbTjfnJr/G+t/ygDeiWvjNhTJR9A+nUDHNTiel48m6yjHdK9ljrXx77
   M+Y35pvOu0tjWd7E3DGlC8o5Lc5IANqB6zeuk1mL2v1IouathtXvJcBso
   nIrPAT/W2YxuxLglYyw/W7L5gXmBpUXDyXTl8y+l0OID4guPEjrpvc4X9
   lyGTkbJHQP7JY1xhAAbi1ZwXdCs+eGdrC90VjvWgUXtcfTsk5Q2pptB/Q
   HcdTVKq3TH2ATLIKC6DzUYZHKlY4RoL5sEM3ualBhPC7Vwq3+4iEdo6S0
   CRrqlx/7oH5S9OqB9M5t17pCrCHNdmBFLzAsVaKkrhG1tV1wjlYNzX+0d
   A==;
X-CSE-ConnectionGUID: V3cck9DGRzWDqacaSDXoPA==
X-CSE-MsgGUID: TXu9V+pjT/eRv+BcTCbx7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46858654"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46858654"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:19:36 -0800
X-CSE-ConnectionGUID: iQy4LTW4TVCN6zvfKU4lew==
X-CSE-MsgGUID: rZ6VZvcFQsqXGPF4U6P/IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102368454"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2025 14:19:35 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	anthony.l.nguyen@intel.com,
	kurt@linutronix.de,
	richardcochran@gmail.com,
	benjamin.steinke@woks-audio.com,
	bigeasy@linutronix.de,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Subject: [PATCH net-next 02/15] igb: Introduce igb_xdp_is_enabled()
Date: Mon,  6 Jan 2025 14:19:10 -0800
Message-ID: <20250106221929.956999-3-anthony.l.nguyen@intel.com>
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

From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Introduce igb_xdp_is_enabled() to check if an XDP program is assigned to
the device. Use that wherever xdp_prog is read and evaluated.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
[Kurt: Split patches and use READ_ONCE()]
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      | 5 +++++
 drivers/net/ethernet/intel/igb/igb_main.c | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 1bfe703e73d9..6e2b61ecff68 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -826,6 +826,11 @@ static inline struct igb_ring *igb_xdp_tx_queue_mapping(struct igb_adapter *adap
 	return adapter->tx_ring[r_idx];
 }
 
+static inline bool igb_xdp_is_enabled(struct igb_adapter *adapter)
+{
+	return !!READ_ONCE(adapter->xdp_prog);
+}
+
 int igb_add_filter(struct igb_adapter *adapter,
 		   struct igb_nfc_filter *input);
 int igb_erase_filter(struct igb_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 77a6d1470f8b..fef58c55eb43 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2930,7 +2930,8 @@ int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
 	/* During program transitions its possible adapter->xdp_prog is assigned
 	 * but ring has not been configured yet. In this case simply abort xmit.
 	 */
-	tx_ring = adapter->xdp_prog ? igb_xdp_tx_queue_mapping(adapter) : NULL;
+	tx_ring = igb_xdp_is_enabled(adapter) ?
+		igb_xdp_tx_queue_mapping(adapter) : NULL;
 	if (unlikely(!tx_ring))
 		return IGB_XDP_CONSUMED;
 
@@ -2963,7 +2964,8 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
 	/* During program transitions its possible adapter->xdp_prog is assigned
 	 * but ring has not been configured yet. In this case simply abort xmit.
 	 */
-	tx_ring = adapter->xdp_prog ? igb_xdp_tx_queue_mapping(adapter) : NULL;
+	tx_ring = igb_xdp_is_enabled(adapter) ?
+		igb_xdp_tx_queue_mapping(adapter) : NULL;
 	if (unlikely(!tx_ring))
 		return -ENXIO;
 
@@ -6597,7 +6599,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int max_frame = new_mtu + IGB_ETH_PKT_HDR_PAD;
 
-	if (adapter->xdp_prog) {
+	if (igb_xdp_is_enabled(adapter)) {
 		int i;
 
 		for (i = 0; i < adapter->num_rx_queues; i++) {
-- 
2.47.1


