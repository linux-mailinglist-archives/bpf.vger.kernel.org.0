Return-Path: <bpf+bounces-41888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617F299D908
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 23:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F08282A4F
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 21:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736A11D89E4;
	Mon, 14 Oct 2024 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MlfEzHfn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517FB1D4151
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941431; cv=none; b=tSQt8CGzzMFQrH9yJB11ItxaQEqlaRgR1NC5i6sGXuUUMDJ+6hLx9WYSoJ6z4PT+NoGFKQbKTSsO0+p3mJJBj5AeCVBaOunOU9a8c1nJaJr3htuofiNMBIpDhoKDfYg4GUmmHikR6MOEwLUwS/4Nm8dG040PJhoq7WM4Y9BY9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941431; c=relaxed/simple;
	bh=e5Yp+QbPMzhHXCKWYUPNBdsh5JuDtowt9EH9xiCoR7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=baBKXj5tY4yd3reo5uGN8Hy1sJwlr1ieTJv1Aczd1qlCPT6CwRxcoveGpAbz4rQIafZDiwFAK/RJ7lOYM4m/Q6QR709GI0oxX8h2s1IsAdZO0MZJ6JGI5LZ1Q3gwcA56mRvd2QKGf8aX9C2jLeEAdgExNPV60I7E03/2VV/hLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MlfEzHfn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c9978a221so40397135ad.1
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 14:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728941429; x=1729546229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxBNgDQSRaL2/P8dfGFD2/KEAzLTmWIcgHceYmhcd5M=;
        b=MlfEzHfnkgswL1dsqkqoG0ir4q/pWqvbSWbaiUDj6SICkymyfwr3u3erZRxXINdUA7
         1F57LNQ5rqNRjtVtwwQb+T6euLYuHyo1+2rx+Kv2Fg//z2AmLYfhElY5SUP67HbbU9Ez
         eTo6g7YKTHCyO7kEdbfitpjtduqjotwd5GUP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941429; x=1729546229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxBNgDQSRaL2/P8dfGFD2/KEAzLTmWIcgHceYmhcd5M=;
        b=V4m21wZKEp+bD1od1DfKlmNBcGWK9kRixF64crprW27Jdem/t+DgqVqrsnbvLZGMoZ
         u5l5ULOcPBBzssE4VCDgqC3HYeH+0MI5evZyMkuuRUIoGLbwK5UT2CsCRkxKmPmR8Zze
         U4W92/xdbA4kFeIvPQdHeHG9VkMyS0A4jmP7sVE9RtB/Da4MeebP5+WDfME0FgvSqtey
         jpV4Y3DoTcSVHII2GAOmBy1VSAHZiSGXxd2Mdxsijol2bnkARcsJqfX1wPdQdVbxwB++
         ekjcVFymxIAwAg54L8pNZyiTxyV6woA2c72iyvEeGiiJtNgjK/w0AJzudIcnZL4oOwBh
         IOHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJhW++eYHx+2uKpKY6Nftl050WsNvjumHIxqu9OxhrvqjOe3olUivOjU/EZ/GlBVBSu/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0gbXmdmnLMuPuQc1vTaydrLUdBhNdLK9HCU8+Yi5pgqbs6Em
	jotF+/2PyVsEPJu3sM1AVlyPFZNMz7p/1Xz6ln9x/9Xrv41/ZHxhgryeOfTbWWYWu1j7/EQcdBL
	Y
X-Google-Smtp-Source: AGHT+IEJ4EHb+6N4tM/cFT7ywxQyXS0Ymc9p28zp/vemtOEVMEZrWwOWyx9KSPAvB0H6a840B8DZ5w==
X-Received: by 2002:a17:902:da8e:b0:20c:d2e4:dc33 with SMTP id d9443c01a7336-20cd2e4ddc4mr129518515ad.14.1728941428656;
        Mon, 14 Oct 2024 14:30:28 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1a54esm70197495ad.73.2024.10.14.14.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:30:28 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kurt@linutronix.de,
	vinicius.gomes@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
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
Subject: [RFC net-next v2 2/2] igc: Link queues to NAPI instances
Date: Mon, 14 Oct 2024 21:30:11 +0000
Message-Id: <20241014213012.187976-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241014213012.187976-1-jdamato@fastly.com>
References: <20241014213012.187976-1-jdamato@fastly.com>
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
 v2:
   - Update commit message to include tests for IGC_FLAG_QUEUE_PAIRS
     disabled
   - Refactored code to move napi queue mapping and unmapping to helper
     functions igc_set_queue_napi and igc_unset_queue_napi
   - Adjust the code to handle IGC_FLAG_QUEUE_PAIRS disabled
   - Call helpers to map/unmap queues to NAPIs in igc_up, __igc_open,
     igc_xdp_enable_pool, and igc_xdp_disable_pool

 drivers/net/ethernet/intel/igc/igc.h      |  3 ++
 drivers/net/ethernet/intel/igc/igc_main.c | 58 +++++++++++++++++++++--
 drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 +
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index eac0f966e0e4..7b1c9ea60056 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -337,6 +337,9 @@ struct igc_adapter {
 	struct igc_led_classdev *leds;
 };
 
+void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
+			struct napi_struct *napi);
+void igc_unset_queue_napi(struct igc_adapter *adapter, int q_idx);
 void igc_up(struct igc_adapter *adapter);
 void igc_down(struct igc_adapter *adapter);
 int igc_open(struct net_device *netdev);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7964bbedb16c..59c00acfa0ed 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4948,6 +4948,47 @@ static int igc_sw_init(struct igc_adapter *adapter)
 	return 0;
 }
 
+void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
+			struct napi_struct *napi)
+{
+	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
+		netif_queue_set_napi(adapter->netdev, q_idx,
+				     NETDEV_QUEUE_TYPE_RX, napi);
+		netif_queue_set_napi(adapter->netdev, q_idx,
+				     NETDEV_QUEUE_TYPE_TX, napi);
+	} else {
+		if (q_idx < adapter->num_rx_queues) {
+			netif_queue_set_napi(adapter->netdev, q_idx,
+					     NETDEV_QUEUE_TYPE_RX, napi);
+		} else {
+			q_idx -= adapter->num_rx_queues;
+			netif_queue_set_napi(adapter->netdev, q_idx,
+					     NETDEV_QUEUE_TYPE_TX, napi);
+		}
+	}
+}
+
+void igc_unset_queue_napi(struct igc_adapter *adapter, int q_idx)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
+		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
+				     NULL);
+		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX,
+				     NULL);
+	} else {
+		if (q_idx < adapter->num_rx_queues) {
+			netif_queue_set_napi(adapter->netdev, q_idx,
+					     NETDEV_QUEUE_TYPE_RX, NULL);
+		} else {
+			q_idx -= adapter->num_rx_queues;
+			netif_queue_set_napi(adapter->netdev, q_idx,
+					     NETDEV_QUEUE_TYPE_TX, NULL);
+		}
+	}
+}
+
 /**
  * igc_up - Open the interface and prepare it to handle traffic
  * @adapter: board private structure
@@ -4955,6 +4996,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
 void igc_up(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
+	struct napi_struct *napi;
 	int i = 0;
 
 	/* hardware has been reset, we need to reload some things */
@@ -4962,8 +5004,11 @@ void igc_up(struct igc_adapter *adapter)
 
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
@@ -5192,6 +5237,7 @@ void igc_down(struct igc_adapter *adapter)
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
 			napi_synchronize(&adapter->q_vector[i]->napi);
+			igc_unset_queue_napi(adapter, i);
 			napi_disable(&adapter->q_vector[i]->napi);
 		}
 	}
@@ -6021,6 +6067,7 @@ static int __igc_open(struct net_device *netdev, bool resuming)
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct pci_dev *pdev = adapter->pdev;
 	struct igc_hw *hw = &adapter->hw;
+	struct napi_struct *napi;
 	int err = 0;
 	int i = 0;
 
@@ -6056,8 +6103,11 @@ static int __igc_open(struct net_device *netdev, bool resuming)
 
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
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index e27af72aada8..886f04b8c394 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -84,6 +84,7 @@ static int igc_xdp_enable_pool(struct igc_adapter *adapter,
 		napi_disable(napi);
 	}
 
+	igc_unset_queue_napi(adapter, queue_id);
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


