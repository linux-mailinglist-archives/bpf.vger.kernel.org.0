Return-Path: <bpf+bounces-46070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 736749E39D0
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 13:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C3AB32B2E
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 12:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095F51B5ED0;
	Wed,  4 Dec 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AekKqKbG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9805E19E979;
	Wed,  4 Dec 2024 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313782; cv=none; b=B3XAoIVD3Vv5Vu2KWj1Ju06mePbGwhOPfTKrcKJATEhe9u2GxOTQD/aur9YQBU3kHQtXYM3oEu00lj2iVEuyKqw7r81L5JZDFPH+H+ZZhkDWbS0EnKsJBqZlIkKgso4h7eN/uSmusoY1eOSgmxOWgAfT+9XC4bjqXQYSdyJ++j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313782; c=relaxed/simple;
	bh=dP22molM0C3gMBPOsLS2Nb47YqyQOf5PUwiKuRmgVG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNZMvwt38KynmPipXfW0hyaRXV8bFBdI7BRjEpbwsLfZThEi4acH/2zraIzqsmkLSRjv6DNdL+dvXwcwEGfxMDK9Bi6uY7+uxSwsxZVJmHauvDWvcus9rfqW7kthtetuoUy5FoEPPN73pH9Cx2rFqPp1gK7ZdRzhHGv+nLau0Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AekKqKbG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733313781; x=1764849781;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dP22molM0C3gMBPOsLS2Nb47YqyQOf5PUwiKuRmgVG8=;
  b=AekKqKbGu9Os8pddxBVaCmx2TvO9jygxkGZN8vCcAgaf4tbp1e+6yIr/
   jTP0aRS1YsqwQAkxlZzH1iey96xlj+WP+TK+Vl+8f2wTGhoMLMMgAzoaX
   GYVNytTJALXC4vpFdzqD1DvckkrnbEDEv0xnK0TkAnFTmOXVwlyPmy3Op
   25PQuPg4lKPE6c2b6samnj16uhvN+SZWiz5R3PUciFdzHs9d2IVojiTVh
   YikP5T9HXP8Y5ZMsXP9o44n1HlTCKgZ/MbINTxsImtq6kcOUexAJhXnjY
   euUFrmNF3rhL0mpwuqQE5+InP2+GgTSOqbGMBSb9ioVQJ2Zot9umioazE
   g==;
X-CSE-ConnectionGUID: wFfJrA2UQia2n2gDT0Oy5Q==
X-CSE-MsgGUID: dzs5dV/TRKCup6vQL/lqog==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32917597"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="32917597"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 04:03:00 -0800
X-CSE-ConnectionGUID: 90P/YrGBQ2+mJIvejfkefA==
X-CSE-MsgGUID: iiK1cf2tRxOC0rlvxBge2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="116993058"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by fmviesa002.fm.intel.com with ESMTP; 04 Dec 2024 04:02:56 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next 1/1] igc: Improve XDP_SETUP_PROG process
Date: Wed,  4 Dec 2024 20:02:33 +0800
Message-Id: <20241204120233.3148482-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve XDP_SETUP_PROG process by avoiding unnecessary link down/up event
and hardware device reset.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |   2 +
 drivers/net/ethernet/intel/igc/igc_main.c | 138 ++++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_xdp.c  |   4 +-
 3 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index eac0f966e0e4..b1e46fcaae1a 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -341,6 +341,8 @@ void igc_up(struct igc_adapter *adapter);
 void igc_down(struct igc_adapter *adapter);
 int igc_open(struct net_device *netdev);
 int igc_close(struct net_device *netdev);
+void igc_xdp_open(struct net_device *netdev);
+void igc_xdp_close(struct net_device *netdev);
 int igc_setup_tx_resources(struct igc_ring *ring);
 int igc_setup_rx_resources(struct igc_ring *ring);
 void igc_free_tx_resources(struct igc_ring *ring);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 27872bdea9bd..098529a80b88 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6145,6 +6145,144 @@ int igc_close(struct net_device *netdev)
 	return 0;
 }
 
+void igc_xdp_open(struct net_device *netdev)
+{
+	struct igc_adapter *adapter = netdev_priv(netdev);
+	struct pci_dev *pdev = adapter->pdev;
+	struct igc_hw *hw = &adapter->hw;
+	int err = 0;
+	int i = 0;
+
+	/* disallow open during test */
+	if (test_bit(__IGC_TESTING, &adapter->state))
+		return;
+
+	pm_runtime_get_sync(&pdev->dev);
+
+	igc_ptp_reset(adapter);
+
+	/* allocate transmit descriptors */
+	err = igc_setup_all_tx_resources(adapter);
+	if (err)
+		goto err_setup_tx;
+
+	/* allocate receive descriptors */
+	err = igc_setup_all_rx_resources(adapter);
+	if (err)
+		goto err_setup_rx;
+
+	igc_setup_tctl(adapter);
+	igc_setup_rctl(adapter);
+	igc_configure_tx(adapter);
+	igc_configure_rx(adapter);
+	igc_rx_fifo_flush_base(&adapter->hw);
+
+	/* call igc_desc_unused which always leaves
+	 * at least 1 descriptor unused to make sure
+	 * next_to_use != next_to_clean
+	 */
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		struct igc_ring *ring = adapter->rx_ring[i];
+
+		if (ring->xsk_pool)
+			igc_alloc_rx_buffers_zc(ring, igc_desc_unused(ring));
+		else
+			igc_alloc_rx_buffers(ring, igc_desc_unused(ring));
+	}
+
+	err = igc_request_irq(adapter);
+	if (err)
+		goto err_req_irq;
+
+	clear_bit(__IGC_DOWN, &adapter->state);
+
+	for (i = 0; i < adapter->num_q_vectors; i++)
+		napi_enable(&adapter->q_vector[i]->napi);
+
+	/* Clear any pending interrupts. */
+	rd32(IGC_ICR);
+	igc_irq_enable(adapter);
+
+	pm_runtime_put(&pdev->dev);
+
+	netif_tx_start_all_queues(netdev);
+	netif_carrier_on(netdev);
+
+	return;
+
+err_req_irq:
+	igc_release_hw_control(adapter);
+	igc_power_down_phy_copper_base(&adapter->hw);
+	igc_free_all_rx_resources(adapter);
+err_setup_rx:
+	igc_free_all_tx_resources(adapter);
+err_setup_tx:
+	igc_reset(adapter);
+	pm_runtime_put(&pdev->dev);
+}
+
+void igc_xdp_close(struct net_device *netdev)
+{
+	struct igc_adapter *adapter = netdev_priv(netdev);
+	struct pci_dev *pdev = adapter->pdev;
+	struct igc_hw *hw = &adapter->hw;
+	u32 tctl, rctl;
+	int i = 0;
+
+	WARN_ON(test_bit(__IGC_RESETTING, &adapter->state));
+
+	pm_runtime_get_sync(&pdev->dev);
+
+	set_bit(__IGC_DOWN, &adapter->state);
+
+	igc_ptp_suspend(adapter);
+
+	if (pci_device_is_present(pdev)) {
+		/* disable receives in the hardware */
+		rctl = rd32(IGC_RCTL);
+		wr32(IGC_RCTL, rctl & ~IGC_RCTL_EN);
+		/* flush and sleep below */
+	}
+	/* set trans_start so we don't get spurious watchdogs during reset */
+	netif_trans_update(netdev);
+
+	netif_carrier_off(netdev);
+	netif_tx_stop_all_queues(netdev);
+
+	if (pci_device_is_present(pdev)) {
+		/* disable transmits in the hardware */
+		tctl = rd32(IGC_TCTL);
+		tctl &= ~IGC_TCTL_EN;
+		wr32(IGC_TCTL, tctl);
+		/* flush both disables and wait for them to finish */
+		wrfl();
+		usleep_range(10000, 20000);
+
+		igc_irq_disable(adapter);
+	}
+
+	for (i = 0; i < adapter->num_q_vectors; i++) {
+		if (adapter->q_vector[i]) {
+			napi_synchronize(&adapter->q_vector[i]->napi);
+			napi_disable(&adapter->q_vector[i]->napi);
+		}
+	}
+
+	del_timer_sync(&adapter->watchdog_timer);
+	del_timer_sync(&adapter->phy_info_timer);
+
+	igc_disable_all_tx_rings_hw(adapter);
+	igc_clean_all_tx_rings(adapter);
+	igc_clean_all_rx_rings(adapter);
+
+	igc_free_irq(adapter);
+
+	igc_free_all_tx_resources(adapter);
+	igc_free_all_rx_resources(adapter);
+
+	pm_runtime_put_sync(&pdev->dev);
+}
+
 /**
  * igc_ioctl - Access the hwtstamp interface
  * @netdev: network interface device structure
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index 869815f48ac1..f1d6ab56ab54 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -25,7 +25,7 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 
 	need_update = !!adapter->xdp_prog != !!prog;
 	if (if_running && need_update)
-		igc_close(dev);
+		igc_xdp_close(dev);
 
 	old_prog = xchg(&adapter->xdp_prog, prog);
 	if (old_prog)
@@ -37,7 +37,7 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 		xdp_features_clear_redirect_target(dev);
 
 	if (if_running && need_update)
-		igc_open(dev);
+		igc_xdp_open(dev);
 
 	return 0;
 }
-- 
2.34.1


