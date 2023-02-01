Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4862A686425
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 11:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjBAKZV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 05:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjBAKZR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 05:25:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA2F11146;
        Wed,  1 Feb 2023 02:25:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E08D3B81FDA;
        Wed,  1 Feb 2023 10:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA47AC433EF;
        Wed,  1 Feb 2023 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675247110;
        bh=y4+Lk3o+PpaD7H+gT+7NqJUKNUzYur/OFNhZhruH5ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pMxEVCc/m9bKbCN57g4S3B4NdhbPN+/fEP9viVxUEh5DYZ830PrMqOvTtlpyQ8qVe
         LinaWylB4V7uTx3LtoX5J6YHV7S3kzLM6m6ctmRJvvkbnH3UQAWcQigD8+DdHUKl94
         kcyW1+0TzG0ZuMCOpRYWtP5OudWDWMbtiz1qpDlVDuIi1RzVH33jSGLT4vWVfCZ56d
         icl5kITQH9PSVN2gBeFKR9djgqCQf3TP8iStpVancH9umAx68LwcxmETpHURiljkh2
         u5s7yFxI6CJ9CaQDsqte9/zt17QZFtRyaSMoAQIa4pEXC5jK/LQCq5XLZVqzF3n32v
         jOUtQBfCvjH1A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com, hawk@kernel.org,
        toke@redhat.com, memxor@gmail.com, alardam@gmail.com,
        saeedm@nvidia.com, anthony.l.nguyen@intel.com, gospo@broadcom.com,
        vladimir.oltean@nxp.com, nbd@nbd.name, john@phrozen.org,
        leon@kernel.org, simon.horman@corigine.com, aelior@marvell.com,
        christophe.jaillet@wanadoo.fr, ecree.xilinx@gmail.com,
        mst@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org,
        lorenzo.bianconi@redhat.com, martin.lau@linux.dev, sdf@google.com,
        gerhard@engleder-embedded.com
Subject: [PATCH v5 bpf-next 2/8] drivers: net: turn on XDP features
Date:   Wed,  1 Feb 2023 11:24:18 +0100
Message-Id: <3eca9fafb308462f7edb1f58e451d59209aa07eb.1675245258.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675245257.git.lorenzo@kernel.org>
References: <cover.1675245257.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Marek Majtyka <alardam@gmail.com>

A summary of the flags being set for various drivers is given below.
Note that XDP_F_REDIRECT_TARGET and XDP_F_FRAG_TARGET are features
that can be turned off and on at runtime. This means that these flags
may be set and unset under RTNL lock protection by the driver. Hence,
READ_ONCE must be used by code loading the flag value.

Also, these flags are not used for synchronization against the availability
of XDP resources on a device. It is merely a hint, and hence the read
may race with the actual teardown of XDP resources on the device. This
may change in the future, e.g. operations taking a reference on the XDP
resources of the driver, and in turn inhibiting turning off this flag.
However, for now, it can only be used as a hint to check whether device
supports becoming a redirection target.

Turn 'hw-offload' feature flag on for:
 - netronome (nfp)
 - netdevsim.

Turn 'native' and 'zerocopy' features flags on for:
 - intel (i40e, ice, ixgbe, igc)
 - mellanox (mlx5).
 - stmmac
 - netronome (nfp)

Turn 'native' features flags on for:
 - amazon (ena)
 - broadcom (bnxt)
 - freescale (dpaa, dpaa2, enetc)
 - funeth
 - intel (igb)
 - marvell (mvneta, mvpp2, octeontx2)
 - mellanox (mlx4)
 - mtk_eth_soc
 - qlogic (qede)
 - sfc
 - socionext (netsec)
 - ti (cpsw)
 - tap
 - tsnep
 - veth
 - xen
 - virtio_net.

Turn 'basic' (tx, pass, aborted and drop) features flags on for:
 - netronome (nfp)
 - cavium (thunder)
 - hyperv.

Turn 'redirect_target' feature flag on for:
 - amanzon (ena)
 - broadcom (bnxt)
 - freescale (dpaa, dpaa2)
 - intel (i40e, ice, igb, ixgbe)
 - ti (cpsw)
 - marvell (mvneta, mvpp2)
 - sfc
 - socionext (netsec)
 - qlogic (qede)
 - mellanox (mlx5)
 - tap
 - veth
 - virtio_net
 - xen

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Marek Majtyka <alardam@gmail.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c   |  4 ++++
 .../net/ethernet/aquantia/atlantic/aq_nic.c    |  5 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c      |  3 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c  |  2 ++
 .../net/ethernet/cavium/thunder/nicvf_main.c   |  2 ++
 drivers/net/ethernet/engleder/tsnep_main.c     |  4 ++++
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |  4 ++++
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  4 ++++
 .../net/ethernet/freescale/enetc/enetc_pf.c    |  3 +++
 .../net/ethernet/fungible/funeth/funeth_main.c |  6 ++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 10 ++++++++--
 drivers/net/ethernet/intel/ice/ice_main.c      |  5 +++++
 drivers/net/ethernet/intel/igb/igb_main.c      |  9 ++++++++-
 drivers/net/ethernet/intel/igc/igc_main.c      |  3 +++
 drivers/net/ethernet/intel/igc/igc_xdp.c       |  5 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  6 ++++++
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c  |  1 +
 drivers/net/ethernet/marvell/mvneta.c          |  3 +++
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c    |  4 ++++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c   |  8 ++++++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.c    |  6 ++++++
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c |  2 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c  | 11 +++++++++++
 drivers/net/ethernet/microsoft/mana/mana_en.c  |  2 ++
 .../ethernet/netronome/nfp/nfp_net_common.c    |  5 +++++
 drivers/net/ethernet/qlogic/qede/qede_main.c   |  3 +++
 drivers/net/ethernet/sfc/efx.c                 |  4 ++++
 drivers/net/ethernet/sfc/siena/efx.c           |  4 ++++
 drivers/net/ethernet/socionext/netsec.c        |  3 +++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  |  2 ++
 drivers/net/ethernet/ti/cpsw.c                 |  4 ++++
 drivers/net/ethernet/ti/cpsw_new.c             |  4 ++++
 drivers/net/hyperv/netvsc_drv.c                |  2 ++
 drivers/net/netdevsim/netdev.c                 |  1 +
 drivers/net/tun.c                              |  5 +++++
 drivers/net/veth.c                             |  4 ++++
 drivers/net/virtio_net.c                       |  4 ++++
 drivers/net/xen-netfront.c                     |  2 ++
 include/net/xdp.h                              | 12 ++++++++++++
 net/core/xdp.c                                 | 18 ++++++++++++++++++
 40 files changed, 184 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index e8ad5ea31aff..d3999db7c6a2 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -597,7 +597,9 @@ static int ena_xdp_set(struct net_device *netdev, struct netdev_bpf *bpf)
 				if (rc)
 					return rc;
 			}
+			xdp_features_set_redirect_target(netdev, false);
 		} else if (old_bpf_prog) {
+			xdp_features_clear_redirect_target(netdev);
 			rc = ena_destroy_and_free_all_xdp_queues(adapter);
 			if (rc)
 				return rc;
@@ -4103,6 +4105,8 @@ static void ena_set_conf_feat_params(struct ena_adapter *adapter,
 	/* Set offload features */
 	ena_set_dev_offloads(feat, netdev);
 
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
+
 	adapter->max_mtu = feat->dev_attr.max_mtu;
 	netdev->max_mtu = adapter->max_mtu;
 	netdev->min_mtu = ENA_MIN_MTU;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 06508eebb585..d6d6d5d37ff3 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -384,6 +384,11 @@ void aq_nic_ndev_init(struct aq_nic_s *self)
 	self->ndev->mtu = aq_nic_cfg->mtu - ETH_HLEN;
 	self->ndev->max_mtu = aq_hw_caps->mtu - ETH_FCS_LEN - ETH_HLEN;
 
+	self->ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				   NETDEV_XDP_ACT_REDIRECT |
+				   NETDEV_XDP_ACT_NDO_XMIT |
+				   NETDEV_XDP_ACT_RX_SG |
+				   NETDEV_XDP_ACT_NDO_XMIT_SG;
 }
 
 void aq_nic_set_tx_ring(struct aq_nic_s *self, unsigned int idx,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 240a7e8a7652..a1b4356dfb6c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13686,6 +13686,9 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
 
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			    NETDEV_XDP_ACT_RX_SG;
+
 #ifdef CONFIG_BNXT_SRIOV
 	init_waitqueue_head(&bp->sriov_cfg_wait);
 #endif
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 36d5202c0aee..5843c93b1711 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -422,9 +422,11 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 
 	if (prog) {
 		bnxt_set_rx_skb_mode(bp, true);
+		xdp_features_set_redirect_target(dev, true);
 	} else {
 		int rx, tx;
 
+		xdp_features_clear_redirect_target(dev);
 		bnxt_set_rx_skb_mode(bp, false);
 		bnxt_get_max_rings(bp, &rx, &tx, true);
 		if (rx > 1) {
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index f2f95493ec89..8b25313c7f6b 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -2218,6 +2218,8 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->netdev_ops = &nicvf_netdev_ops;
 	netdev->watchdog_timeo = NICVF_TX_TIMEOUT;
 
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC;
+
 	/* MTU range: 64 - 9200 */
 	netdev->min_mtu = NIC_HW_MIN_FRS;
 	netdev->max_mtu = NIC_HW_MAX_FRS;
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index c3cf427a9409..6982aaa928b5 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1926,6 +1926,10 @@ static int tsnep_probe(struct platform_device *pdev)
 	netdev->features = NETIF_F_SG;
 	netdev->hw_features = netdev->features | NETIF_F_LOOPBACK;
 
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_NDO_XMIT |
+			       NETDEV_XDP_ACT_NDO_XMIT_SG;
+
 	/* carrier off reporting is important to ethtool even BEFORE open */
 	netif_carrier_off(netdev);
 
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 027fff9f7db0..9318a2554056 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -244,6 +244,10 @@ static int dpaa_netdev_init(struct net_device *net_dev,
 	net_dev->features |= net_dev->hw_features;
 	net_dev->vlan_features = net_dev->features;
 
+	net_dev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				NETDEV_XDP_ACT_REDIRECT |
+				NETDEV_XDP_ACT_NDO_XMIT;
+
 	if (is_valid_ether_addr(mac_addr)) {
 		memcpy(net_dev->perm_addr, mac_addr, net_dev->addr_len);
 		eth_hw_addr_set(net_dev, mac_addr);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 2e79d18fc3c7..746ccfde7255 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4596,6 +4596,10 @@ static int dpaa2_eth_netdev_init(struct net_device *net_dev)
 			    NETIF_F_LLTX | NETIF_F_HW_TC | NETIF_F_TSO;
 	net_dev->gso_max_segs = DPAA2_ETH_ENQUEUE_MAX_FDS;
 	net_dev->hw_features = net_dev->features;
+	net_dev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				NETDEV_XDP_ACT_REDIRECT |
+				NETDEV_XDP_ACT_XSK_ZEROCOPY |
+				NETDEV_XDP_ACT_NDO_XMIT;
 
 	if (priv->dpni_attrs.vlan_filter_entries)
 		net_dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 7facc7d5261e..6b54071d4ecc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -807,6 +807,9 @@ static void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 		ndev->hw_features |= NETIF_F_RXHASH;
 
 	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
+			     NETDEV_XDP_ACT_NDO_XMIT_SG;
 
 	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
 		priv->active_offloads |= ENETC_F_QCI;
diff --git a/drivers/net/ethernet/fungible/funeth/funeth_main.c b/drivers/net/ethernet/fungible/funeth/funeth_main.c
index b4cce30e526a..df86770731ad 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_main.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_main.c
@@ -1160,6 +1160,11 @@ static int fun_xdp_setup(struct net_device *dev, struct netdev_bpf *xdp)
 			WRITE_ONCE(rxqs[i]->xdp_prog, prog);
 	}
 
+	if (prog)
+		xdp_features_set_redirect_target(dev, true);
+	else
+		xdp_features_clear_redirect_target(dev);
+
 	dev->max_mtu = prog ? XDP_MAX_MTU : FUN_MAX_MTU;
 	old_prog = xchg(&fp->xdp_prog, prog);
 	if (old_prog)
@@ -1765,6 +1770,7 @@ static int fun_create_netdev(struct fun_ethdev *ed, unsigned int portid)
 	netdev->vlan_features = netdev->features & VLAN_FEAT;
 	netdev->mpls_features = netdev->vlan_features;
 	netdev->hw_enc_features = netdev->hw_features;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
 
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = FUN_MAX_MTU;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 53d0083e35da..8a79cc18c428 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13339,9 +13339,11 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 	old_prog = xchg(&vsi->xdp_prog, prog);
 
 	if (need_reset) {
-		if (!prog)
+		if (!prog) {
+			xdp_features_clear_redirect_target(vsi->netdev);
 			/* Wait until ndo_xsk_wakeup completes. */
 			synchronize_rcu();
+		}
 		i40e_reset_and_rebuild(pf, true, true);
 	}
 
@@ -13362,11 +13364,13 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 	/* Kick start the NAPI context if there is an AF_XDP socket open
 	 * on that queue id. This so that receiving will start.
 	 */
-	if (need_reset && prog)
+	if (need_reset && prog) {
 		for (i = 0; i < vsi->num_queue_pairs; i++)
 			if (vsi->xdp_rings[i]->xsk_pool)
 				(void)i40e_xsk_wakeup(vsi->netdev, i,
 						      XDP_WAKEUP_RX);
+		xdp_features_set_redirect_target(vsi->netdev, true);
+	}
 
 	return 0;
 }
@@ -13783,6 +13787,8 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	netdev->hw_enc_features |= NETIF_F_TSO_MANGLEID;
 
 	netdev->features &= ~NETIF_F_HW_TC;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	if (vsi->type == I40E_VSI_MAIN) {
 		SET_NETDEV_DEV(netdev, &pf->pdev->dev);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index fce86e8ff834..26b09e4ed0c8 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -22,6 +22,7 @@
 #include "ice_eswitch.h"
 #include "ice_tc_lib.h"
 #include "ice_vsi_vlan_ops.h"
+#include <net/xdp_sock_drv.h>
 
 #define DRV_SUMMARY	"Intel(R) Ethernet Connection E800 Series Linux Driver"
 static const char ice_driver_string[] = DRV_SUMMARY;
@@ -2899,11 +2900,13 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 			if (xdp_ring_err)
 				NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Tx resources failed");
 		}
+		xdp_features_set_redirect_target(vsi->netdev, false);
 		/* reallocate Rx queues that are used for zero-copy */
 		xdp_ring_err = ice_realloc_zc_buf(vsi, true);
 		if (xdp_ring_err)
 			NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Rx resources failed");
 	} else if (ice_is_xdp_ena_vsi(vsi) && !prog) {
+		xdp_features_clear_redirect_target(vsi->netdev);
 		xdp_ring_err = ice_destroy_xdp_rings(vsi);
 		if (xdp_ring_err)
 			NL_SET_ERR_MSG_MOD(extack, "Freeing XDP Tx resources failed");
@@ -3446,6 +3449,8 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
 	np->vsi = vsi;
 
 	ice_set_netdev_features(netdev);
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	ice_set_ops(netdev);
 
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 3c0c35ecea10..0e11a082f7a1 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2871,8 +2871,14 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 		bpf_prog_put(old_prog);
 
 	/* bpf is just replaced, RXQ and MTU are already setup */
-	if (!need_reset)
+	if (!need_reset) {
 		return 0;
+	} else {
+		if (prog)
+			xdp_features_set_redirect_target(dev, true);
+		else
+			xdp_features_clear_redirect_target(dev);
+	}
 
 	if (running)
 		igb_open(dev);
@@ -3317,6 +3323,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
 
 	/* MTU range: 68 - 9216 */
 	netdev->min_mtu = ETH_MIN_MTU;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e86b15efaeb8..8b572cd2c350 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6533,6 +6533,9 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->mpls_features |= NETIF_F_HW_CSUM;
 	netdev->hw_enc_features |= netdev->vlan_features;
 
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
+
 	/* MTU range: 68 - 9216 */
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = MAX_STD_JUMBO_FRAME_SIZE;
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index aeeb34e64610..e27af72aada8 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -29,6 +29,11 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 	if (old_prog)
 		bpf_prog_put(old_prog);
 
+	if (prog)
+		xdp_features_set_redirect_target(dev, true);
+	else
+		xdp_features_clear_redirect_target(dev);
+
 	if (if_running)
 		igc_open(dev);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 43a44c1e1576..af4c12b6059f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10301,6 +10301,8 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 
 		if (err)
 			return -EINVAL;
+		if (!prog)
+			xdp_features_clear_redirect_target(dev);
 	} else {
 		for (i = 0; i < adapter->num_rx_queues; i++) {
 			WRITE_ONCE(adapter->rx_ring[i]->xdp_prog,
@@ -10321,6 +10323,7 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 			if (adapter->xdp_ring[i]->xsk_pool)
 				(void)ixgbe_xsk_wakeup(adapter->netdev, i,
 						       XDP_WAKEUP_RX);
+		xdp_features_set_redirect_target(dev, true);
 	}
 
 	return 0;
@@ -11018,6 +11021,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
+
 	/* MTU range: 68 - 9710 */
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = IXGBE_MAX_JUMBO_FRAME_SIZE - (ETH_HLEN + ETH_FCS_LEN);
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index ea0a230c1153..a44e4bd56142 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4634,6 +4634,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			    NETIF_F_HW_VLAN_CTAG_TX;
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC;
 
 	/* MTU range: 68 - 1504 or 9710 */
 	netdev->min_mtu = ETH_MIN_MTU;
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index f8925cac61e4..dc2989103a77 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5612,6 +5612,9 @@ static int mvneta_probe(struct platform_device *pdev)
 			NETIF_F_TSO | NETIF_F_RXCSUM;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			    NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
+			    NETDEV_XDP_ACT_NDO_XMIT_SG;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	netif_set_tso_max_segs(dev, MVNETA_MAX_TSO_SEGS);
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 4da45c5abba5..9b4ecbe4f36d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6866,6 +6866,10 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 
 	dev->vlan_features |= features;
 	netif_set_tso_max_segs(dev, MVPP2_MAX_TSO_SEGS);
+
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			    NETDEV_XDP_ACT_NDO_XMIT;
+
 	dev->priv_flags |= IFF_UNICAST_FLT;
 
 	/* MTU range: 68 - 9704 */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c1ea60bc2630..179433d0a54a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2512,10 +2512,13 @@ static int otx2_xdp_setup(struct otx2_nic *pf, struct bpf_prog *prog)
 	/* Network stack and XDP shared same rx queues.
 	 * Use separate tx queues for XDP and network stack.
 	 */
-	if (pf->xdp_prog)
+	if (pf->xdp_prog) {
 		pf->hw.xdp_queues = pf->hw.rx_queues;
-	else
+		xdp_features_set_redirect_target(dev, false);
+	} else {
 		pf->hw.xdp_queues = 0;
+		xdp_features_clear_redirect_target(dev);
+	}
 
 	pf->hw.tot_tx_queues += pf->hw.xdp_queues;
 
@@ -2878,6 +2881,7 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	netdev->watchdog_timeo = OTX2_TX_TIMEOUT;
 
 	netdev->netdev_ops = &otx2_netdev_ops;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
 
 	netdev->min_mtu = OTX2_MIN_MTU;
 	netdev->max_mtu = otx2_get_max_mtu(pf);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 801deac58bf7..ac54b6f2bb5c 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4447,6 +4447,12 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 		register_netdevice_notifier(&mac->device_notifier);
 	}
 
+	if (mtk_page_pool_enabled(eth))
+		eth->netdev[id]->xdp_features = NETDEV_XDP_ACT_BASIC |
+						NETDEV_XDP_ACT_REDIRECT |
+						NETDEV_XDP_ACT_NDO_XMIT |
+						NETDEV_XDP_ACT_NDO_XMIT_SG;
+
 	return 0;
 
 free_netdev:
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index af4c4858f397..e11bc0ac880e 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -3416,6 +3416,8 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 		priv->rss_hash_fn = ETH_RSS_HASH_TOP;
 	}
 
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
+
 	/* MTU range: 68 - hw-specific max */
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = priv->max_mtu;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 0e87432ec6f1..e4996ef04d86 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4780,6 +4780,13 @@ static int mlx5e_xdp_set(struct net_device *netdev, struct bpf_prog *prog)
 	if (old_prog)
 		bpf_prog_put(old_prog);
 
+	if (reset) {
+		if (prog)
+			xdp_features_set_redirect_target(netdev, true);
+		else
+			xdp_features_clear_redirect_target(netdev);
+	}
+
 	if (!test_bit(MLX5E_STATE_OPENED, &priv->state) || reset)
 		goto unlock;
 
@@ -5175,6 +5182,10 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	netdev->features         |= NETIF_F_HIGHDMA;
 	netdev->features         |= NETIF_F_HW_VLAN_STAG_FILTER;
 
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
+			       NETDEV_XDP_ACT_RX_SG;
+
 	netdev->priv_flags       |= IFF_UNICAST_FLT;
 
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 2f6a048dee90..6120f2b6684f 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2160,6 +2160,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	ndev->hw_features |= NETIF_F_RXHASH;
 	ndev->features = ndev->hw_features;
 	ndev->vlan_features = 0;
+	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_NDO_XMIT;
 
 	err = register_netdev(ndev);
 	if (err) {
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 18fc9971f1c8..e4825d885560 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2529,10 +2529,15 @@ static void nfp_net_netdev_init(struct nfp_net *nn)
 	netdev->features &= ~NETIF_F_HW_VLAN_STAG_RX;
 	nn->dp.ctrl &= ~NFP_NET_CFG_CTRL_RXQINQ;
 
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC;
+	if (nn->app && nn->app->type->id == NFP_APP_BPF_NIC)
+		netdev->xdp_features |= NETDEV_XDP_ACT_HW_OFFLOAD;
+
 	/* Finalise the netdev setup */
 	switch (nn->dp.ops->version) {
 	case NFP_NFD_VER_NFD3:
 		netdev->netdev_ops = &nfp_nfd3_netdev_ops;
+		netdev->xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
 		break;
 	case NFP_NFD_VER_NFDK:
 		netdev->netdev_ops = &nfp_nfdk_netdev_ops;
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 953f304b8588..b6d999927e86 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -892,6 +892,9 @@ static void qede_init_ndev(struct qede_dev *edev)
 
 	ndev->hw_features = hw_features;
 
+	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_NDO_XMIT;
+
 	/* MTU range: 46 - 9600 */
 	ndev->min_mtu = ETH_ZLEN - ETH_HLEN;
 	ndev->max_mtu = QEDE_MAX_JUMBO_PACKET_SIZE;
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 0556542d7a6b..18ff8d8cff42 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -1078,6 +1078,10 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 
 	pci_info(pci_dev, "Solarflare NIC detected\n");
 
+	efx->net_dev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				     NETDEV_XDP_ACT_REDIRECT |
+				     NETDEV_XDP_ACT_NDO_XMIT;
+
 	if (!efx->type->is_vf)
 		efx_probe_vpd_strings(efx);
 
diff --git a/drivers/net/ethernet/sfc/siena/efx.c b/drivers/net/ethernet/sfc/siena/efx.c
index 60e5b7c8ccf9..a6ef21845224 100644
--- a/drivers/net/ethernet/sfc/siena/efx.c
+++ b/drivers/net/ethernet/sfc/siena/efx.c
@@ -1048,6 +1048,10 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 
 	pci_info(pci_dev, "Solarflare NIC detected\n");
 
+	efx->net_dev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				     NETDEV_XDP_ACT_REDIRECT |
+				     NETDEV_XDP_ACT_NDO_XMIT;
+
 	if (!efx->type->is_vf)
 		efx_probe_vpd_strings(efx);
 
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 9b46579b5a10..2d7347b71c41 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -2104,6 +2104,9 @@ static int netsec_probe(struct platform_device *pdev)
 				NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 	ndev->hw_features = ndev->features;
 
+	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_NDO_XMIT;
+
 	priv->rx_cksum_offload_flag = true;
 
 	ret = netsec_register_mdio(priv, phy_addr);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b7e5af58ab75..734d84263fd2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7150,6 +7150,8 @@ int stmmac_dvr_probe(struct device *device,
 
 	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			    NETIF_F_RXCSUM;
+	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_NDO_XMIT;
 
 	ret = stmmac_tc_init(priv, priv);
 	if (!ret) {
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 13c9c2d6b79b..37f0b62ec5d6 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1458,6 +1458,8 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	priv_sl2->emac_port = 1;
 	cpsw->slaves[1].ndev = ndev;
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
+	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_NDO_XMIT;
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
@@ -1635,6 +1637,8 @@ static int cpsw_probe(struct platform_device *pdev)
 	cpsw->slaves[0].ndev = ndev;
 
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
+	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_NDO_XMIT;
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 83596ec0c7cb..35128dd45ffc 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1405,6 +1405,10 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
 				  NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_NETNS_LOCAL | NETIF_F_HW_TC;
 
+		ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				     NETDEV_XDP_ACT_REDIRECT |
+				     NETDEV_XDP_ACT_NDO_XMIT;
+
 		ndev->netdev_ops = &cpsw_netdev_ops;
 		ndev->ethtool_ops = &cpsw_ethtool_ops;
 		SET_NETDEV_DEV(ndev, dev);
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index f9b219e6cd58..a9b139bbdb2c 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2559,6 +2559,8 @@ static int netvsc_probe(struct hv_device *dev,
 
 	netdev_lockdep_set_classes(net);
 
+	net->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
+
 	/* MTU range: 68 - 1500 or 65521 */
 	net->min_mtu = NETVSC_MTU_MIN;
 	if (nvdev->nvsp_version >= NVSP_PROTOCOL_VERSION_2)
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 6db6a75ff9b9..35fa1ca98671 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -286,6 +286,7 @@ static void nsim_setup(struct net_device *dev)
 			 NETIF_F_TSO;
 	dev->hw_features |= NETIF_F_HW_TC;
 	dev->max_mtu = ETH_MAX_MTU;
+	dev->xdp_features = NETDEV_XDP_ACT_HW_OFFLOAD;
 }
 
 static int nsim_init_netdevsim(struct netdevsim *ns)
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a7d17c680f4a..36620afde373 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1401,6 +1401,11 @@ static void tun_net_initialize(struct net_device *dev)
 
 		eth_hw_addr_random(dev);
 
+		/* Currently tun does not support XDP, only tap does. */
+		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				    NETDEV_XDP_ACT_REDIRECT |
+				    NETDEV_XDP_ACT_NDO_XMIT;
+
 		break;
 	}
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index ba3e05832843..1bb54de7124d 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1686,6 +1686,10 @@ static void veth_setup(struct net_device *dev)
 	dev->hw_enc_features = VETH_FEATURES;
 	dev->mpls_features = NETIF_F_HW_CSUM | NETIF_F_GSO_SOFTWARE;
 	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			    NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
+			    NETDEV_XDP_ACT_NDO_XMIT_SG;
 }
 
 /*
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e1a98430190..692dff071782 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3280,7 +3280,10 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			if (i == 0 && !old_prog)
 				virtnet_clear_guest_offloads(vi);
 		}
+		if (!old_prog)
+			xdp_features_set_redirect_target(dev, false);
 	} else {
+		xdp_features_clear_redirect_target(dev);
 		vi->xdp_enabled = false;
 	}
 
@@ -3910,6 +3913,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 		dev->hw_features |= NETIF_F_GRO_HW;
 
 	dev->vlan_features = dev->features;
+	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
 
 	/* MTU range: 68 - 65535 */
 	dev->min_mtu = MIN_MTU;
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 12b074286df9..47d54d8ea59d 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1741,6 +1741,8 @@ static struct net_device *xennet_create_dev(struct xenbus_device *dev)
          * negotiate with the backend regarding supported features.
          */
 	netdev->features |= netdev->hw_features;
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_NDO_XMIT;
 
 	netdev->ethtool_ops = &xennet_ethtool_ops;
 	netdev->min_mtu = ETH_MIN_MTU;
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 8d1c86914f4c..d517bfac937b 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -428,9 +428,21 @@ MAX_XDP_METADATA_KFUNC,
 #ifdef CONFIG_NET
 u32 bpf_xdp_metadata_kfunc_id(int id);
 bool bpf_dev_bound_kfunc_id(u32 btf_id);
+void xdp_features_set_redirect_target(struct net_device *dev, bool support_sg);
+void xdp_features_clear_redirect_target(struct net_device *dev);
 #else
 static inline u32 bpf_xdp_metadata_kfunc_id(int id) { return 0; }
 static inline bool bpf_dev_bound_kfunc_id(u32 btf_id) { return false; }
+
+static inline void
+xdp_features_set_redirect_target(struct net_device *dev, bool support_sg)
+{
+}
+
+static inline void
+xdp_features_clear_redirect_target(struct net_device *dev)
+{
+}
 #endif
 
 #endif /* __LINUX_NET_XDP_H__ */
diff --git a/net/core/xdp.c b/net/core/xdp.c
index a5a7ecf6391c..82727b47259d 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -773,3 +773,21 @@ static int __init xdp_metadata_init(void)
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
 }
 late_initcall(xdp_metadata_init);
+
+void xdp_features_set_redirect_target(struct net_device *dev, bool support_sg)
+{
+	dev->xdp_features |= NETDEV_XDP_ACT_NDO_XMIT;
+	if (support_sg)
+		dev->xdp_features |= NETDEV_XDP_ACT_NDO_XMIT_SG;
+
+	call_netdevice_notifiers(NETDEV_XDP_FEAT_CHANGE, dev);
+}
+EXPORT_SYMBOL_GPL(xdp_features_set_redirect_target);
+
+void xdp_features_clear_redirect_target(struct net_device *dev)
+{
+	dev->xdp_features &= ~(NETDEV_XDP_ACT_NDO_XMIT |
+			       NETDEV_XDP_ACT_NDO_XMIT_SG);
+	call_netdevice_notifiers(NETDEV_XDP_FEAT_CHANGE, dev);
+}
+EXPORT_SYMBOL_GPL(xdp_features_clear_redirect_target);
-- 
2.39.1

