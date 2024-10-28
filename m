Return-Path: <bpf+bounces-43330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93769B3AD8
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 20:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8412283095
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7F51E04AF;
	Mon, 28 Oct 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XmC906Fm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148541DFE03
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145183; cv=none; b=HcXvzFavLoEobYScuKIX4DI57MKPztU7JaXnl1VvpajVbGVZKR9R+TnaEmI+9OF5driY4VV8+dzeGVlMjehLGEZ2IVfsojb25AAj8YTvBfczfmAzE92dETro1sKqCv6aj6iuHLk+VOqnO3IQuOJ5qPDnoLw6jEtjdZZSuNzzKEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145183; c=relaxed/simple;
	bh=P3Zlf4/ZkOB0CiOQ81j3XzQnHZeTuws8o1CZoIgKW4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFI64iITogpC4Q3N0KmvLVOVPY+AW4Vqb3PGnrJ0CMjp/QWS+yXvanlzZ8yWiXsq31C4+XhvxBuexMOLeB0VpK9TKoNcvtHq7HLNBdNN4LR6tihp665nJLjcSTj2UX+SuhkJOn1OWtIK2QJalaNS1Nqvbx42qgOWJyXnxlTS8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XmC906Fm; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2c6bc4840so3528824a91.2
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730145180; x=1730749980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJCsZlWl/zP5hsxo6MH91N223NF/8mWoFtpQR/ZTf4M=;
        b=XmC906Fm8oMrAmsG8HNsiWFljfPNbhbu9q7b0xXqTQCQv3TssjFZhpl6pddE+jlVrv
         edBdCFpW3ROe6opFWyr7arJ0Q36PvvRGaH4sJ4RwpLNUydk8CwIqHIX+oWvRBjVi9XjP
         JG1K6oX2t7m6+z+s2LCibsDjHw8m/hxcTjiY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730145180; x=1730749980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJCsZlWl/zP5hsxo6MH91N223NF/8mWoFtpQR/ZTf4M=;
        b=ud+M+uxt29LWo1jGp8JJu/Q2/h4mz/KiH6kCcZeSIvKDIKIkO+EXiQy5cdaHN86bgo
         zqHuiU13YFMoAvyc1JvrJEtgXwlnI0G7CXQr+iv1XUYZEnYJ4Cb48VJAe/RyjH3hPBsG
         yqUz9J6E2KK6Zm3VZA6WEcyrBhv5hEG49efR4JQYZG2drSbaGP1GDwnT8PDB461sWXAK
         tSz/ZP4Flgj9pvOD/FshXrA3QzoQsjXCTLAjUyXFi9sSZopREV4q/m4lV/tcWg6iSkL+
         rev5Px5uKtDmZ086ZVjLp02jFhoAK2P873RfNVLcf4kFEbZoRcQGRe1dMDGTjKZFNsa3
         GC5g==
X-Forwarded-Encrypted: i=1; AJvYcCVBUU7hqmqbuw3hcZgb8UvC4k1GGXmsA3wqDC5labujE05B06P2+n8zgQhCXHKBkhg8HQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0cbz3ypwKOJyr2AKEHGb2C6JjWJ75l4QZx6ab+PnyAc5NcWMq
	Lx2kFGCwxoc1LvsKcrtqH2QCzNUZflkZOOYs5XXu5NQop85NhFEBCMkPOuywZZY=
X-Google-Smtp-Source: AGHT+IFvEzf4JS0St4rHlwXdMbtNoD7xcpTKOJ5GTIWmtXw1xkkpSgq2hbrJdLvDs5Lqms7DFfnTLg==
X-Received: by 2002:a17:90a:a005:b0:2c8:65cf:e820 with SMTP id 98e67ed59e1d1-2e8f105490dmr10374948a91.2.1730145180392;
        Mon, 28 Oct 2024 12:53:00 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3771e64sm7695247a91.50.2024.10.28.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:52:59 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: vitaly.lifshits@intel.com,
	jacob.e.keller@intel.com,
	kurt@linutronix.de,
	vinicius.gomes@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [PATCH iwl-next v5 2/2] igc: Link queues to NAPI instances
Date: Mon, 28 Oct 2024 19:52:42 +0000
Message-Id: <20241028195243.52488-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241028195243.52488-1-jdamato@fastly.com>
References: <20241028195243.52488-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link queues to NAPI instances via netdev-genl API so that users can
query this information with netlink. Handle a few cases in the driver:
  1. Link/unlink the NAPIs when XDP is enabled/disabled
  2. Handle IGC_FLAG_QUEUE_PAIRS enabled and disabled

Example output when IGC_FLAG_QUEUE_PAIRS is enabled:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'

[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]

Since IGC_FLAG_QUEUE_PAIRS is enabled, you'll note that the same NAPI ID
is present for both rx and tx queues at the same index, for example
index 0:

{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},

To test IGC_FLAG_QUEUE_PAIRS disabled, a test system was booted using
the grub command line option "maxcpus=2" to force
igc_set_interrupt_capability to disable IGC_FLAG_QUEUE_PAIRS.

Example output when IGC_FLAG_QUEUE_PAIRS is disabled:

$ lscpu | grep "On-line CPU"
On-line CPU(s) list:      0,2

$ ethtool -l enp86s0  | tail -5
Current hardware settings:
RX:		n/a
TX:		n/a
Other:		1
Combined:	2

$ cat /proc/interrupts  | grep enp
 144: [...] enp86s0
 145: [...] enp86s0-rx-0
 146: [...] enp86s0-rx-1
 147: [...] enp86s0-tx-0
 148: [...] enp86s0-tx-1

1 "other" IRQ, and 2 IRQs for each of RX and Tx, so we expect netlink to
report 4 IRQs with unique NAPI IDs:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'
[{'id': 8196, 'ifindex': 2, 'irq': 148},
 {'id': 8195, 'ifindex': 2, 'irq': 147},
 {'id': 8194, 'ifindex': 2, 'irq': 146},
 {'id': 8193, 'ifindex': 2, 'irq': 145}]

Now we examine which queues these NAPIs are associated with, expecting
that since IGC_FLAG_QUEUE_PAIRS is disabled each RX and TX queue will
have its own NAPI instance:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v5:
   - Rename igc_resume to __igc_do_resume and pass in a boolean
     "need_rtnl" to signal whether or not rtnl should be held before
     caling __igc_open. Call this new function from igc_runtime_resume
     and igc_resume passing in false (for igc_runtime_resume) and true
     (igc_resume), respectively. This is done to avoid reintroducing a
     bug fixed in commit: 6f31d6b: "igc: Refactor runtime power
     management flow" where rtnl is held in runtime_resume causing a
     deadlock.

 v4:
   - Add rtnl_lock/rtnl_unlock in two paths: igc_resume and
     igc_io_error_detected. The code added to the latter is inspired by
     a similar implementation in ixgbe's ixgbe_io_error_detected.

 v3:
   - Replace igc_unset_queue_napi with igc_set_queue_napi(adapater, i,
     NULL), as suggested by Vinicius Costa Gomes
   - Simplify implemention of igc_set_queue_napi as suggested by Kurt
     Kanzenbach, with a tweak to use ring->queue_index

 v2:
   - Update commit message to include tests for IGC_FLAG_QUEUE_PAIRS
     disabled
   - Refactored code to move napi queue mapping and unmapping to helper
     functions igc_set_queue_napi and igc_unset_queue_napi
   - Adjust the code to handle IGC_FLAG_QUEUE_PAIRS disabled
   - Call helpers to map/unmap queues to NAPIs in igc_up, __igc_open,
     igc_xdp_enable_pool, and igc_xdp_disable_pool

 drivers/net/ethernet/intel/igc/igc.h      |  2 +
 drivers/net/ethernet/intel/igc/igc_main.c | 52 ++++++++++++++++++++---
 drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 +
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index eac0f966e0e4..b8111ad9a9a8 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -337,6 +337,8 @@ struct igc_adapter {
 	struct igc_led_classdev *leds;
 };
 
+void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
+			struct napi_struct *napi);
 void igc_up(struct igc_adapter *adapter);
 void igc_down(struct igc_adapter *adapter);
 int igc_open(struct net_device *netdev);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7964bbedb16c..051a0cdb1143 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4948,6 +4948,22 @@ static int igc_sw_init(struct igc_adapter *adapter)
 	return 0;
 }
 
+void igc_set_queue_napi(struct igc_adapter *adapter, int vector,
+			struct napi_struct *napi)
+{
+	struct igc_q_vector *q_vector = adapter->q_vector[vector];
+
+	if (q_vector->rx.ring)
+		netif_queue_set_napi(adapter->netdev,
+				     q_vector->rx.ring->queue_index,
+				     NETDEV_QUEUE_TYPE_RX, napi);
+
+	if (q_vector->tx.ring)
+		netif_queue_set_napi(adapter->netdev,
+				     q_vector->tx.ring->queue_index,
+				     NETDEV_QUEUE_TYPE_TX, napi);
+}
+
 /**
  * igc_up - Open the interface and prepare it to handle traffic
  * @adapter: board private structure
@@ -4955,6 +4971,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
 void igc_up(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
+	struct napi_struct *napi;
 	int i = 0;
 
 	/* hardware has been reset, we need to reload some things */
@@ -4962,8 +4979,11 @@ void igc_up(struct igc_adapter *adapter)
 
 	clear_bit(__IGC_DOWN, &adapter->state);
 
-	for (i = 0; i < adapter->num_q_vectors; i++)
-		napi_enable(&adapter->q_vector[i]->napi);
+	for (i = 0; i < adapter->num_q_vectors; i++) {
+		napi = &adapter->q_vector[i]->napi;
+		napi_enable(napi);
+		igc_set_queue_napi(adapter, i, napi);
+	}
 
 	if (adapter->msix_entries)
 		igc_configure_msix(adapter);
@@ -5192,6 +5212,7 @@ void igc_down(struct igc_adapter *adapter)
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
 			napi_synchronize(&adapter->q_vector[i]->napi);
+			igc_set_queue_napi(adapter, i, NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
 		}
 	}
@@ -6021,6 +6042,7 @@ static int __igc_open(struct net_device *netdev, bool resuming)
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct pci_dev *pdev = adapter->pdev;
 	struct igc_hw *hw = &adapter->hw;
+	struct napi_struct *napi;
 	int err = 0;
 	int i = 0;
 
@@ -6056,8 +6078,11 @@ static int __igc_open(struct net_device *netdev, bool resuming)
 
 	clear_bit(__IGC_DOWN, &adapter->state);
 
-	for (i = 0; i < adapter->num_q_vectors; i++)
-		napi_enable(&adapter->q_vector[i]->napi);
+	for (i = 0; i < adapter->num_q_vectors; i++) {
+		napi = &adapter->q_vector[i]->napi;
+		napi_enable(napi);
+		igc_set_queue_napi(adapter, i, napi);
+	}
 
 	/* Clear any pending interrupts. */
 	rd32(IGC_ICR);
@@ -7342,7 +7367,7 @@ static void igc_deliver_wake_packet(struct net_device *netdev)
 	netif_rx(skb);
 }
 
-static int igc_resume(struct device *dev)
+static int __igc_do_resume(struct device *dev, bool need_rtnl)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -7385,7 +7410,11 @@ static int igc_resume(struct device *dev)
 	wr32(IGC_WUS, ~0);
 
 	if (netif_running(netdev)) {
+		if (need_rtnl)
+			rtnl_lock();
 		err = __igc_open(netdev, true);
+		if (need_rtnl)
+			rtnl_unlock();
 		if (!err)
 			netif_device_attach(netdev);
 	}
@@ -7393,9 +7422,14 @@ static int igc_resume(struct device *dev)
 	return err;
 }
 
+static int igc_resume(struct device *dev)
+{
+	return __igc_do_resume(dev, true);
+}
+
 static int igc_runtime_resume(struct device *dev)
 {
-	return igc_resume(dev);
+	return __igc_do_resume(dev, false);
 }
 
 static int igc_suspend(struct device *dev)
@@ -7440,14 +7474,18 @@ static pci_ers_result_t igc_io_error_detected(struct pci_dev *pdev,
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igc_adapter *adapter = netdev_priv(netdev);
 
+	rtnl_lock();
 	netif_device_detach(netdev);
 
-	if (state == pci_channel_io_perm_failure)
+	if (state == pci_channel_io_perm_failure) {
+		rtnl_unlock();
 		return PCI_ERS_RESULT_DISCONNECT;
+	}
 
 	if (netif_running(netdev))
 		igc_down(adapter);
 	pci_disable_device(pdev);
+	rtnl_unlock();
 
 	/* Request a slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index e27af72aada8..4da633430b80 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -84,6 +84,7 @@ static int igc_xdp_enable_pool(struct igc_adapter *adapter,
 		napi_disable(napi);
 	}
 
+	igc_set_queue_napi(adapter, queue_id, NULL);
 	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
 	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
 
@@ -133,6 +134,7 @@ static int igc_xdp_disable_pool(struct igc_adapter *adapter, u16 queue_id)
 	xsk_pool_dma_unmap(pool, IGC_RX_DMA_ATTR);
 	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
 	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
+	igc_set_queue_napi(adapter, queue_id, napi);
 
 	if (needs_reset) {
 		napi_enable(napi);
-- 
2.25.1


