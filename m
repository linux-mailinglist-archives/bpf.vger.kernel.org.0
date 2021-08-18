Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB58D3F064F
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 16:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbhHRORs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 10:17:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:53820 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240034AbhHROPt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Aug 2021 10:15:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="238431131"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="238431131"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 07:14:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="531703496"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2021 07:14:32 -0700
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        anthony.l.nguyen@intel.com, kuba@kernel.org, bjorn@kernel.org,
        magnus.karlsson@intel.com, jesse.brandeburg@intel.com,
        alexandr.lobakin@intel.com, joamaki@gmail.com, toke@redhat.com,
        brett.creeley@intel.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v6 intel-next 1/9] ice: remove ring_active from ice_ring
Date:   Wed, 18 Aug 2021 15:59:08 +0200
Message-Id: <20210818135916.25007-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818135916.25007-1-maciej.fijalkowski@intel.com>
References: <20210818135916.25007-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This field is dead and driver is not making any use of it. Simply remove
it.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 2 --
 drivers/net/ethernet/intel/ice/ice_main.c | 1 -
 drivers/net/ethernet/intel/ice/ice_txrx.h | 2 --
 3 files changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 327b39d7cd71..860e41966b71 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1338,7 +1338,6 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 
 		ring->q_index = i;
 		ring->reg_idx = vsi->txq_map[i];
-		ring->ring_active = false;
 		ring->vsi = vsi;
 		ring->tx_tstamps = &pf->ptp.port.tx;
 		ring->dev = dev;
@@ -1357,7 +1356,6 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 
 		ring->q_index = i;
 		ring->reg_idx = vsi->rxq_map[i];
-		ring->ring_active = false;
 		ring->vsi = vsi;
 		ring->netdev = vsi->netdev;
 		ring->dev = dev;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 802a59345bfa..1fa9c3cdf087 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2441,7 +2441,6 @@ static int ice_xdp_alloc_setup_rings(struct ice_vsi *vsi)
 
 		xdp_ring->q_index = xdp_q_idx;
 		xdp_ring->reg_idx = vsi->txq_map[xdp_q_idx];
-		xdp_ring->ring_active = false;
 		xdp_ring->vsi = vsi;
 		xdp_ring->netdev = NULL;
 		xdp_ring->dev = dev;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index b0bbbec4e3a3..901f16f1d286 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -275,8 +275,6 @@ struct ice_ring {
 	u16 q_index;			/* Queue number of ring */
 	u16 q_handle;			/* Queue handle per TC */
 
-	u8 ring_active:1;		/* is ring online or not */
-
 	u16 count;			/* Number of descriptors */
 	u16 reg_idx;			/* HW register index of the ring */
 
-- 
2.20.1

