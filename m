Return-Path: <bpf+bounces-47020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586909F2A6B
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 07:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321A1188886D
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 06:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242921D5ADB;
	Mon, 16 Dec 2024 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJmVLHMk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4FF1CEAB4;
	Mon, 16 Dec 2024 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331750; cv=none; b=r8yq+siUsMXq0fxO0wW4INW+YDGSvhzkfl1B1SkxxJBlR5+vh0DSfMj+MUwvmxgoiBPHNoDGJ9VPZELYHjAZb9T5qaFOlQLId8Yk9GQS75C4/ZDh0l3iPLuOdkT0RQmp/AoVwuU+EXMu78P0N5ZQMyePx7K8qrSRnE6t/t2UAn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331750; c=relaxed/simple;
	bh=nrG2omUaIPCf7wfzQb2IADiYYADvTAKyDD772FrjHF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIKwBvgVFtgEIUrPTuWRGErVTupc+oWBlSc7WyV7jbU+A74nS5RKpCK9EHos63mPbN/vWSOT/QrD2EL1kVBSiCkGwWShskhvx+D8WG4WLyOzquWrTSXawNPQUBQgdRvkQEDIlu/n2DSApwRnDFnvTXfcGC43jRAZrBBTDG4Cq98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJmVLHMk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734331749; x=1765867749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nrG2omUaIPCf7wfzQb2IADiYYADvTAKyDD772FrjHF4=;
  b=kJmVLHMkGBEQE9GwAF6Qvfg1kvNPlJu1z8x49iibKlzhfc6Q03HY/IiH
   +Go/vZ/PhpUClwpDxpwDzir15vxT3oegyUqlXaDVtPBGJC+w6OU6h1v/s
   EcTYeFCe2yvhiNjqeJd8hCj9AMpyksZAQmIqELQd+6F/jAtu1+y9VSliD
   9TvFCW0fZTG2zsurAXdn7BxZRVrXkHaUUEoaNWz5/T/oKMw7R3EryxdEJ
   6F/YXDRzDQD+1fhVeK1vFohLvTUI1JXF8gwCahd+MT2qQ2v8lx1ZHewzh
   gR7Bk7jGJhXnIND331A3b5MghjDVLPsgwtwCpTC6NOLvmBjYGHn+nvYLP
   A==;
X-CSE-ConnectionGUID: gNBtBLaoTs2lrF3xXyWNgA==
X-CSE-MsgGUID: KgV5CtnBQue4ZyDKUHUFzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34848242"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34848242"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 22:49:09 -0800
X-CSE-ConnectionGUID: ukqEOwq2TTatz9lHRy9qKA==
X-CSE-MsgGUID: jKz0Mzs/RX25IBaFXeDiWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128101886"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa001.fm.intel.com with ESMTP; 15 Dec 2024 22:49:04 -0800
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next 6/9] igc: Add support for frame preemption verification
Date: Mon, 16 Dec 2024 01:47:17 -0500
Message-Id: <20241216064720.931522-7-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i226 hardware doesn't implement the process of verification
internally, this is left to the driver.

Add a simple implementation of the state machine defined in IEEE
802.3-2018, Section 99.4.7. The state machine is started manually by
user after "verify-enabled" command is enabled.

Implementation includes:
1. Send and receive verify frame
2. Verification state handling
3. Send and receive response frame

Tested by triggering verification handshake:
$ sudo ethtool --set-mm enp1s0 pmac-enabled on
$ sudo ethtool --set-mm enp1s0 tx-enabled on
$ sudo ethtool --set-mm enp1s0 verify-enabled on

Note that Ethtool API requires enabling "pmac-enabled on" and
"tx-enabled on" before "verify-enabled on" can be issued.

After the upcoming patch ("igc: Add support to get MAC Merge data via
ethtool") is implemented, verification status can be checked using:
$ ethtool --show-mm enp1s0
  MAC Merge layer state for enp1s0:
  pMAC enabled: on
  TX enabled: on
  TX active: on
  TX minimum fragment size: 252
  RX minimum fragment size: 252
  Verify enabled: on
  Verify time: 128
  Max verify time: 128
  Verification status: SUCCEEDED

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  16 ++
 drivers/net/ethernet/intel/igc/igc_defines.h |   6 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c |   8 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |  15 +-
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 230 +++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_tsn.h     |   4 +
 6 files changed, 277 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 5a14e9101723..56a426765be7 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -40,6 +40,15 @@ void igc_ethtool_set_ops(struct net_device *);
 
 #define IGC_MAX_TX_TSTAMP_REGS		4
 
+/* Verification state defined as per section 30.14.1.2 in 802.3br spec */
+enum verify_state {
+	VERIFY_FAIL,
+	INIT_VERIFICATION,
+	VERIFIED,
+	SEND_VERIFY,
+	WAIT_FOR_RESPONSE,
+};
+
 /**
  * @verify_time: see struct ethtool_mm_state
  * @verify_enabled: see struct ethtool_mm_state
@@ -52,6 +61,12 @@ void igc_ethtool_set_ops(struct net_device *);
  * @tx_min_frag_size: see struct ethtool_mm_state
  */
 struct fpe_t {
+	struct delayed_work verification_work;
+	unsigned long verify_timeout;
+	bool received_smd_v;
+	bool received_smd_r;
+	unsigned int verify_cnt;
+	enum verify_state verify_state;
 	u32 verify_time;
 	bool verify_enabled;
 	bool tx_enabled;
@@ -758,6 +773,7 @@ int igc_add_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
 void igc_del_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
 int igc_enable_empty_addr_recv(struct igc_adapter *adapter);
 struct igc_ring *igc_get_tx_ring(struct igc_adapter *adapter, int cpu);
+void igc_flush_tx_descriptors(struct igc_ring *ring);
 void igc_ptp_init(struct igc_adapter *adapter);
 void igc_ptp_reset(struct igc_adapter *adapter);
 void igc_ptp_suspend(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 3088cdd08f35..ba96776d5854 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -308,6 +308,8 @@
 #define IGC_TXD_DTYP_C		0x00000000 /* Context Descriptor */
 #define IGC_TXD_POPTS_IXSM	0x01       /* Insert IP checksum */
 #define IGC_TXD_POPTS_TXSM	0x02       /* Insert TCP/UDP checksum */
+#define IGC_TXD_POPTS_SMD_V	0x10       /* Transmitted packet is a SMD-Verify */
+#define IGC_TXD_POPTS_SMD_R	0x20       /* Transmitted packet is a SMD-Response */
 #define IGC_TXD_CMD_EOP		0x01000000 /* End of Packet */
 #define IGC_TXD_CMD_IC		0x04000000 /* Insert Checksum */
 #define IGC_TXD_CMD_DEXT	0x20000000 /* Desc extension (0 = legacy) */
@@ -370,9 +372,13 @@
 #define IGC_RXD_STAT_VP		0x08	/* IEEE VLAN Packet */
 
 #define IGC_RXDEXT_STATERR_LB	0x00040000
+#define IGC_RXD_STAT_SMD_V	0x2000  /* SMD-Verify packet */
+#define IGC_RXD_STAT_SMD_R	0x4000  /* SMD-Response packet */
 
 /* Advanced Receive Descriptor bit definitions */
 #define IGC_RXDADV_STAT_TSIP	0x08000 /* timestamp in packet */
+#define IGC_RXDADV_STAT_SMD_TYPE_MASK	0x06000
+#define IGC_RXDADV_STAT_SMD_TYPE_SHIFT	13
 
 #define IGC_RXDEXT_STATERR_L4E		0x20000000
 #define IGC_RXDEXT_STATERR_IPE		0x40000000
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 1954561ec4aa..7cde0e5a7320 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1788,6 +1788,7 @@ static int igc_ethtool_set_mm(struct net_device *netdev,
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct fpe_t *fpe = &adapter->fpe;
+	bool verify_enabled_changed;
 
 	if (cmd->tx_min_frag_size < IGC_TX_MIN_FRAG_SIZE ||
 	    cmd->tx_min_frag_size > IGC_TX_MAX_FRAG_SIZE)
@@ -1805,7 +1806,12 @@ static int igc_ethtool_set_mm(struct net_device *netdev,
 
 	fpe->tx_enabled = cmd->tx_enabled;
 	fpe->pmac_enabled = cmd->pmac_enabled;
-	fpe->verify_enabled = cmd->verify_enabled;
+	verify_enabled_changed = (cmd->verify_enabled != fpe->verify_enabled);
+
+	if (verify_enabled_changed) {
+		fpe->verify_enabled = cmd->verify_enabled;
+		igc_fpe_verify_enabled_changed(fpe);
+	}
 
 	return igc_tsn_offload_apply(adapter);
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index b85eaf34d07b..e184959ef218 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2534,7 +2534,7 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
 }
 
 /* This function assumes __netif_tx_lock is held by the caller. */
-static void igc_flush_tx_descriptors(struct igc_ring *ring)
+void igc_flush_tx_descriptors(struct igc_ring *ring)
 {
 	/* Once tail pointer is updated, hardware can fetch the descriptors
 	 * any time so we issue a write membar here to ensure all memory
@@ -2585,6 +2585,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 	struct sk_buff *skb = rx_ring->skb;
 	u16 cleaned_count = igc_desc_unused(rx_ring);
 	int xdp_status = 0, rx_buffer_pgcnt;
+	int smd_type;
 
 	while (likely(total_packets < budget)) {
 		struct igc_xdp_buff ctx = { .rx_ts = NULL };
@@ -2622,6 +2623,18 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 			size -= IGC_TS_HDR_LEN;
 		}
 
+		smd_type = igc_fpe_get_smd_type(rx_desc->wb.upper.status_error);
+
+		if (igc_fpe_is_verify_or_response(smd_type, size)) {
+			igc_fpe_preprocess_verify_response(&adapter->fpe,
+							   smd_type);
+
+			/* Advance the ring next-to-clean */
+			igc_is_non_eop(rx_ring, rx_desc);
+			cleaned_count++;
+			continue;
+		}
+
 		if (!skb) {
 			xdp_init_buff(&ctx.xdp, truesize, &rx_ring->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, pktbuf - igc_rx_offset(rx_ring),
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index b968c02f5fee..3d39be2219f3 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -1,22 +1,252 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c)  2019 Intel Corporation */
 
+#include <linux/kernel.h>
 #include "igc.h"
+#include "igc_base.h"
 #include "igc_hw.h"
 #include "igc_tsn.h"
 
 #define DEFAULT_VERIFY_TIME		10
+
+#define IGC_SMD_TYPE_SMD_V		0x1
+#define IGC_SMD_TYPE_SMD_R		0x2
 #define IGC_MIN_FOR_TX_MIN_FRAG		0
 #define IGC_MAX_FOR_TX_MIN_FRAG		3
 
+#define MAX_VERIFY_CNT			3
+#define SMD_FRAME_SIZE			60
+#define VERIFY_RESPONSE_DELAY		10
+
+static int igc_fpe_init_smd_frame(struct igc_ring *ring,
+				  struct igc_tx_buffer *buffer,
+				  struct sk_buff *skb)
+{
+	unsigned int size = skb_headlen(skb);
+	dma_addr_t dma;
+
+	dma = dma_map_single(ring->dev, skb->data, size, DMA_TO_DEVICE);
+
+	if (dma_mapping_error(ring->dev, dma)) {
+		netdev_err_once(ring->netdev, "Failed to map DMA for TX\n");
+		return -ENOMEM;
+	}
+
+	buffer->skb = skb;
+	buffer->protocol = 0;
+	buffer->bytecount = skb->len;
+	buffer->gso_segs = 1;
+	buffer->time_stamp = jiffies;
+	dma_unmap_len_set(buffer, len, skb->len);
+	dma_unmap_addr_set(buffer, dma, dma);
+
+	return 0;
+}
+
+static int igc_fpe_init_tx_descriptor(struct igc_ring *ring,
+				      struct sk_buff *skb, int type)
+{
+	struct igc_tx_buffer *buffer;
+	union igc_adv_tx_desc *desc;
+	u32 cmd_type, olinfo_status;
+	int err;
+
+	if (!igc_desc_unused(ring))
+		return -EBUSY;
+
+	if (type != IGC_SMD_TYPE_SMD_V && type != IGC_SMD_TYPE_SMD_R)
+		return -EINVAL;
+
+	buffer = &ring->tx_buffer_info[ring->next_to_use];
+	err = igc_fpe_init_smd_frame(ring, buffer, skb);
+	if (err)
+		return err;
+
+	cmd_type = IGC_ADVTXD_DTYP_DATA | IGC_ADVTXD_DCMD_DEXT |
+		   IGC_ADVTXD_DCMD_IFCS | IGC_TXD_DCMD |
+		   buffer->bytecount;
+	olinfo_status = buffer->bytecount << IGC_ADVTXD_PAYLEN_SHIFT;
+
+	switch (type) {
+	case IGC_SMD_TYPE_SMD_V:
+		olinfo_status |= (IGC_TXD_POPTS_SMD_V << 8);
+		break;
+	case IGC_SMD_TYPE_SMD_R:
+		olinfo_status |= (IGC_TXD_POPTS_SMD_R << 8);
+		break;
+	}
+
+	desc = IGC_TX_DESC(ring, ring->next_to_use);
+	desc->read.cmd_type_len = cpu_to_le32(cmd_type);
+	desc->read.olinfo_status = cpu_to_le32(olinfo_status);
+	desc->read.buffer_addr = cpu_to_le64(dma_unmap_addr(buffer, dma));
+
+	netdev_tx_sent_queue(txring_txq(ring), skb->len);
+
+	buffer->next_to_watch = desc;
+	ring->next_to_use = (ring->next_to_use + 1) % ring->count;
+
+	return 0;
+}
+
+static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter, int type)
+{
+	int cpu = smp_processor_id();
+	struct netdev_queue *nq;
+	struct igc_ring *ring;
+	struct sk_buff *skb;
+	void *data;
+	int err;
+
+	if (!netif_running(adapter->netdev))
+		return -ENOTCONN;
+
+	ring = igc_get_tx_ring(adapter, cpu);
+	nq = txring_txq(ring);
+
+	skb = alloc_skb(SMD_FRAME_SIZE, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	data = skb_put(skb, SMD_FRAME_SIZE);
+	memset(data, 0, SMD_FRAME_SIZE);
+
+	__netif_tx_lock(nq, cpu);
+
+	err = igc_fpe_init_tx_descriptor(ring, skb, type);
+	igc_flush_tx_descriptors(ring);
+
+	__netif_tx_unlock(nq);
+
+	return err;
+}
+
+static void igc_fpe_send_response(struct igc_adapter *adapter)
+{
+	int err = igc_fpe_xmit_smd_frame(adapter, IGC_SMD_TYPE_SMD_R);
+
+	if (err)
+		netdev_err(adapter->netdev, "Error sending SMD-R frame\n");
+}
+
+static void igc_fpe_handle_verify(struct igc_adapter *adapter)
+{
+	struct fpe_t *fpe = &adapter->fpe;
+	unsigned long verify_time_jiffies;
+	int err;
+
+	switch (fpe->verify_state) {
+	case SEND_VERIFY:
+		fpe->received_smd_r = false;
+		err = igc_fpe_xmit_smd_frame(adapter, IGC_SMD_TYPE_SMD_V);
+
+		if (err)
+			netdev_err(adapter->netdev, "Error sending SMD-V\n");
+
+		fpe->verify_state = WAIT_FOR_RESPONSE;
+		verify_time_jiffies = msecs_to_jiffies(fpe->verify_time);
+		fpe->verify_timeout = jiffies + verify_time_jiffies;
+
+		schedule_delayed_work(&fpe->verification_work,
+				      verify_time_jiffies);
+		break;
+
+	case WAIT_FOR_RESPONSE:
+		if (fpe->received_smd_r) {
+			fpe->verify_state = VERIFIED;
+			fpe->received_smd_r = false;
+		} else if (time_is_before_jiffies(fpe->verify_timeout)) {
+			fpe->verify_cnt++;
+			netdev_warn(adapter->netdev,
+				    "Timeout waiting for SMD-R frame\n");
+
+			if (fpe->verify_cnt > MAX_VERIFY_CNT) {
+				fpe->verify_state = VERIFY_FAIL;
+				netdev_err(adapter->netdev,
+					   "Exceeded attempts sending SMD-V\n");
+			} else {
+				fpe->verify_state = SEND_VERIFY;
+				igc_fpe_handle_verify(adapter);
+			}
+		}
+		break;
+
+	case VERIFY_FAIL:
+	case VERIFIED:
+	case INIT_VERIFICATION:
+		break;
+	}
+}
+
+static void igc_fpe_verification(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct igc_adapter *adapter;
+	struct fpe_t *fpe;
+
+	fpe = container_of(dwork, struct fpe_t, verification_work);
+	adapter = container_of(fpe, struct igc_adapter, fpe);
+
+	if (fpe->received_smd_v) {
+		igc_fpe_send_response(adapter);
+		fpe->received_smd_v = false;
+	}
+
+	if (fpe->verify_enabled)
+		igc_fpe_handle_verify(adapter);
+}
+
 void igc_fpe_init(struct fpe_t *fpe)
 {
+	INIT_DELAYED_WORK(&fpe->verification_work, igc_fpe_verification);
 	fpe->verify_enabled = false;
+	fpe->verify_state = INIT_VERIFICATION;
 	fpe->verify_time = DEFAULT_VERIFY_TIME;
+	fpe->received_smd_v = false;
+	fpe->received_smd_r = false;
+	fpe->verify_cnt = 0;
 	fpe->pmac_enabled = false;
 	fpe->tx_min_frag_size = IGC_TX_MIN_FRAG_SIZE;
 }
 
+void igc_fpe_verify_enabled_changed(struct fpe_t *fpe)
+{
+	if (fpe->verify_enabled && fpe->tx_enabled) {
+		fpe->verify_state = SEND_VERIFY;
+		schedule_delayed_work(&fpe->verification_work,
+				      msecs_to_jiffies(VERIFY_RESPONSE_DELAY));
+	} else {
+		fpe->verify_state = INIT_VERIFICATION;
+		fpe->received_smd_v = false;
+		fpe->received_smd_r = false;
+		fpe->verify_cnt = 0;
+	}
+}
+
+int igc_fpe_get_smd_type(__le32 status_error)
+{
+	u32 status = le32_to_cpu(status_error);
+
+	return (status & IGC_RXDADV_STAT_SMD_TYPE_MASK)
+		>> IGC_RXDADV_STAT_SMD_TYPE_SHIFT;
+}
+
+bool igc_fpe_is_verify_or_response(int smd_type, unsigned int size)
+{
+	return ((smd_type == IGC_SMD_TYPE_SMD_V ||
+		 smd_type == IGC_SMD_TYPE_SMD_R) && size == SMD_FRAME_SIZE);
+}
+
+void igc_fpe_preprocess_verify_response(struct fpe_t *fpe, int smd_type)
+{
+	if (smd_type == IGC_SMD_TYPE_SMD_V)
+		fpe->received_smd_v = true;
+	else if (smd_type == IGC_SMD_TYPE_SMD_R)
+		fpe->received_smd_r = true;
+
+	schedule_delayed_work(&fpe->verification_work, 0);
+}
+
 static bool is_any_launchtime(struct igc_adapter *adapter)
 {
 	int i;
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
index 08e7582f257e..f3d83fbbd1f4 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -12,7 +12,11 @@
 #define MIN_VERIFY_TIME			1
 #define MAX_VERIFY_TIME			128
 
+int igc_fpe_get_smd_type(__le32 status_error);
 void igc_fpe_init(struct fpe_t *fpe);
+bool igc_fpe_is_verify_or_response(int smd_type, unsigned int size);
+void igc_fpe_preprocess_verify_response(struct fpe_t *fpe, int smd_type);
+void igc_fpe_verify_enabled_changed(struct fpe_t *fpe);
 int igc_tsn_offload_apply(struct igc_adapter *adapter);
 int igc_tsn_reset(struct igc_adapter *adapter);
 void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter);
-- 
2.25.1


