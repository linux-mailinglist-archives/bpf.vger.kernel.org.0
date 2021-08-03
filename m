Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070363DE3C8
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 03:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhHCBEC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 21:04:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:65282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233425AbhHCBEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 21:04:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="277327849"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="277327849"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; 
   d="scan'208";a="419480131"
Received: from ticela-or-032.amr.corp.intel.com (HELO localhost.localdomain) ([10.212.166.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 18:03:50 -0700
From:   Ederson de Souza <ederson.desouza@intel.com>
To:     xdp-hints@xdp-project.net
Cc:     bpf@vger.kernel.org
Subject: [[RFC xdp-hints] 10/16] igc: XDP packet RX timestamp
Date:   Mon,  2 Aug 2021 18:03:25 -0700
Message-Id: <20210803010331.39453-11-ederson.desouza@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803010331.39453-1-ederson.desouza@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using XDP hints, driver adds the PTP timestamp of when a packet was
received by the i225 NIC.

Signed-off-by: Ederson de Souza <ederson.desouza@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  4 +
 drivers/net/ethernet/intel/igc/igc_main.c | 40 ++++++++--
 drivers/net/ethernet/intel/igc/igc_xdp.c  | 93 +++++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_xdp.h  | 11 +++
 4 files changed, 143 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 6fd5901f07c7..84e5f3c97351 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -13,6 +13,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/timecounter.h>
 #include <linux/net_tstamp.h>
+#include <linux/if_xdp.h>
 
 #include "igc_hw.h"
 
@@ -252,6 +253,9 @@ struct igc_adapter {
 		struct timespec64 start;
 		struct timespec64 period;
 	} perout[IGC_N_PEROUT];
+
+	struct btf *btf;
+	u8 btf_enabled;
 };
 
 void igc_up(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index fe3619c25c05..82e9b493cad6 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -13,6 +13,7 @@
 #include <linux/bpf_trace.h>
 #include <net/xdp_sock_drv.h>
 #include <net/ipv6.h>
+#include <linux/btf.h>
 
 #include "igc.h"
 #include "igc_hw.h"
@@ -2374,8 +2375,20 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 
 		if (!skb) {
 			xdp_init_buff(&xdp, truesize, &rx_ring->xdp_rxq);
+
 			xdp_prepare_buff(&xdp, pktbuf - igc_rx_offset(rx_ring),
-					 igc_rx_offset(rx_ring) + pkt_offset, size, false);
+					 igc_rx_offset(rx_ring) + pkt_offset, size,
+					 adapter->btf_enabled);
+
+			if (adapter->btf_enabled) {
+				struct xdp_hints___igc *hints;
+
+				hints = xdp.data - sizeof(*hints);
+				xdp.data_meta = hints;
+				hints->rx_timestamp = timestamp;
+				hints->valid_map = XDP_GENERIC_HINTS_RX_TIMESTAMP;
+				hints->btf_id = btf_obj_id(adapter->btf);
+			}
 
 			skb = igc_xdp_run_prog(adapter, &xdp);
 		}
@@ -2539,12 +2552,18 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
 							bi->xdp->data);
 
 			bi->xdp->data += IGC_TS_HDR_LEN;
-
-			/* HW timestamp has been copied into local variable. Metadata
-			 * length when XDP program is called should be 0.
-			 */
 			bi->xdp->data_meta += IGC_TS_HDR_LEN;
 			size -= IGC_TS_HDR_LEN;
+
+			if (adapter->btf_enabled) {
+				struct xdp_hints___igc *hints;
+
+				hints = bi->xdp->data - sizeof(*hints);
+				bi->xdp->data_meta = hints;
+				hints->rx_timestamp = timestamp;
+				hints->valid_map = XDP_GENERIC_HINTS_RX_TIMESTAMP;
+				hints->btf_id = btf_obj_id(adapter->btf);
+			}
 		}
 
 		bi->xdp->data_end = bi->xdp->data + size;
@@ -5949,6 +5968,12 @@ static int igc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 	case XDP_SETUP_XSK_POOL:
 		return igc_xdp_setup_pool(adapter, bpf->xsk.pool,
 					  bpf->xsk.queue_id);
+	case XDP_SETUP_MD_BTF:
+		return igc_xdp_set_btf_md(dev, bpf->btf_enable);
+	case XDP_QUERY_MD_BTF:
+		bpf->btf_id = igc_xdp_query_btf(dev, &bpf->btf_enable);
+		return 0;
+
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -6436,6 +6461,11 @@ static void igc_remove(struct pci_dev *pdev)
 	cancel_work_sync(&adapter->reset_task);
 	cancel_work_sync(&adapter->watchdog_task);
 
+	if (adapter->btf) {
+		adapter->btf_enabled = 0;
+		btf_unregister(adapter->btf);
+	}
+
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant.
 	 */
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index a8cf5374be47..00d223703424 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -2,10 +2,103 @@
 /* Copyright (c) 2020, Intel Corporation. */
 
 #include <net/xdp_sock_drv.h>
+#include <linux/btf.h>
 
 #include "igc.h"
 #include "igc_xdp.h"
 
+#define IGC_XDP_HINTS_NUM_MMBRS 0
+static const char names_str[] = XDP_GENERIC_HINTS_NAMES "yet_another_timestamp\0";
+
+/**
+ * struct igc_xdp_hints {
+ *      { generic_xdp_hints }
+ * }
+ */
+
+static const u32 igc_xdp_hints_raw[] = {
+	XDP_GENERIC_HINTS_TYPES,
+	XDP_GENERIC_HINTS_STRUCT(IGC_XDP_HINTS_NUM_MMBRS, 0),
+	XDP_GENERIC_HINTS_MEMBERS(0),
+};
+
+static int igc_xdp_register_btf(struct igc_adapter *priv)
+{
+	unsigned int type_sec_sz, str_sec_sz;
+	char *types_sec, *str_sec;
+	struct btf_header *hdr;
+	unsigned int btf_size;
+	void *raw_btf = NULL;
+	int err = 0;
+
+	type_sec_sz = sizeof(igc_xdp_hints_raw);
+	str_sec_sz  = sizeof(names_str);
+
+	btf_size = sizeof(*hdr) + type_sec_sz + str_sec_sz;
+	raw_btf = kzalloc(btf_size, GFP_KERNEL);
+	if (!raw_btf)
+		return -ENOMEM;
+
+	hdr = raw_btf;
+	hdr->magic	= BTF_MAGIC;
+	hdr->version  = BTF_VERSION;
+	hdr->hdr_len  = sizeof(*hdr);
+	hdr->type_off = 0;
+	hdr->type_len = type_sec_sz;
+	hdr->str_off  = type_sec_sz;
+	hdr->str_len  = str_sec_sz;
+
+	types_sec = raw_btf   + sizeof(*hdr);
+	str_sec   = types_sec + type_sec_sz;
+	memcpy(types_sec, igc_xdp_hints_raw, type_sec_sz);
+	memcpy(str_sec, names_str, str_sec_sz);
+
+	priv->btf = btf_register(raw_btf, btf_size);
+	if (IS_ERR(priv->btf)) {
+		err = PTR_ERR(priv->btf);
+		priv->btf = NULL;
+		netdev_err(priv->netdev, "failed to register BTF MD, err (%d)\n", err);
+	}
+
+	kfree(raw_btf);
+	return err;
+}
+
+int igc_xdp_query_btf(struct net_device *dev, u8 *enabled)
+{
+	struct igc_adapter *priv = netdev_priv(dev);
+	u32 md_btf_id = 0;
+
+	if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
+		return md_btf_id;
+
+	if (!priv->btf)
+		igc_xdp_register_btf(priv);
+
+	*enabled = !!priv->btf_enabled;
+	md_btf_id = priv->btf ? btf_obj_id(priv->btf) : 0;
+
+	return md_btf_id;
+}
+
+int igc_xdp_set_btf_md(struct net_device *dev, u8 enable)
+{
+	struct igc_adapter *priv = netdev_priv(dev);
+	int err = 0;
+
+	if (enable && !priv->btf) {
+		igc_xdp_register_btf(priv);
+		if (!priv->btf) {
+			err = -EINVAL;
+			goto unlock;
+		}
+	}
+
+	priv->btf_enabled = enable;
+unlock:
+	return err;
+}
+
 int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 		     struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.h b/drivers/net/ethernet/intel/igc/igc_xdp.h
index a74e5487d199..2bf591f42cec 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.h
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.h
@@ -4,6 +4,8 @@
 #ifndef _IGC_XDP_H_
 #define _IGC_XDP_H_
 
+#include <linux/btf.h>
+
 int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 		     struct netlink_ext_ack *extack);
 int igc_xdp_setup_pool(struct igc_adapter *adapter, struct xsk_buff_pool *pool,
@@ -14,4 +16,13 @@ static inline bool igc_xdp_is_enabled(struct igc_adapter *adapter)
 	return !!adapter->xdp_prog;
 }
 
+int igc_xdp_query_btf(struct net_device *dev, u8 *enabled);
+int igc_xdp_set_btf_md(struct net_device *dev, u8 enable);
+
+struct xdp_hints___igc {
+	XDP_GENERIC_HINTS_STRUCT_MEMBERS;
+} __packed;
+
+#define IGC_XDP_HINT_DMA_TIMESTAMP BIT(XDP_GENERIC_HINTS_BIT_MAX + 1)
+
 #endif /* _IGC_XDP_H_ */
-- 
2.32.0

