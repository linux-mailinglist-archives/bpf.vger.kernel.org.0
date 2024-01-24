Return-Path: <bpf+bounces-20269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3383B216
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0689428B791
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C8D134732;
	Wed, 24 Jan 2024 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMDdqm/U"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5420132C32;
	Wed, 24 Jan 2024 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123803; cv=none; b=ckgXU8UycMunWU69SAgxpmoviTozMvkuPuw2PaJ75SJAJJq8Y4RASwgiXWS+U0cN+58QJAFUHThbYib//Muyt15X8nDJzhNNTvj0ASnpJ192Ye8NLGlQU7NZxvvNiSfuDy2mmP2OSmvBy8H4KhjgjKYdNIx8dVqcKOrsftsIXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123803; c=relaxed/simple;
	bh=8p1eIwkWTG9NiP+S2BTS2wiabMBnWGsStoBn0UoQyF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDmEJbTTg19wWCQhTxUBVgvjxmJhx0OgfarsXHWlDsRyikbUu07UlUa5w92mBd6Bt+04WRhoogwqEW+VvAmJu9oxYZ3v3cyKD8q0AnwjW1cl4HoTSLKXhARuxsGfqQIf/3W0q1sq13KQ069KXES5HsDW9gSAFiNq5J5o856iSMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMDdqm/U; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706123802; x=1737659802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8p1eIwkWTG9NiP+S2BTS2wiabMBnWGsStoBn0UoQyF8=;
  b=IMDdqm/UYjsX1sTM8MpNnKltLxPKvvj33WG9Bj3XViJRVsihuIzJ+JPe
   R9Vg4LkRZFCSQtjEbCjhJlL76xKyzLwgZkUL8qYNWoXep0WZDuGMt3EsV
   F/qkcZEulaFBZqmSVJ5kcdddkQOj8620nKQAIYVUOtvWDXRGoIP98yaBB
   aIuoeFDIVm/PtUmocfVz+KAKcgfN8BkAh6J/jDlAyXHiZC/yYYM7FR05F
   jQYiYkjMWrdA9AgtxU5dlh3FEWc3C0QhQ0xwWGhUnbqncawlT58ktomJh
   TkP34Zt4117vO2XAduENAYh32zcYvOAbrBCbSSPZbmS/hU5wok4MtJNC7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1823178"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1823178"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 11:16:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820553498"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820553498"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2024 11:16:37 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	echaudro@redhat.com,
	lorenzo@kernel.org,
	martin.lau@linux.dev,
	tirthendu.sarkar@intel.com,
	john.fastabend@gmail.com,
	horms@kernel.org,
	kuba@kernel.org
Subject: [PATCH v6 bpf 08/11] ice: update xdp_rxq_info::frag_size for ZC enabled Rx queue
Date: Wed, 24 Jan 2024 20:15:59 +0100
Message-Id: <20240124191602.566724-9-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
References: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that ice driver correctly sets up frag_size in xdp_rxq_info, let us
make it work for ZC multi-buffer as well. ice_rx_ring::rx_buf_len for ZC
is being set via xsk_pool_get_rx_frame_size() and this needs to be
propagated up to xdp_rxq_info.

Use a bigger hammer and instead of unregistering only xdp_rxq_info's
memory model, unregister it altogether and register it again and have
xdp_rxq_info with correct frag_size value.

Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 37 ++++++++++++++---------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 533b923cae2d..7ac847718882 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -547,19 +547,27 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	ring->rx_buf_len = ring->vsi->rx_buf_len;
 
 	if (ring->vsi->type == ICE_VSI_PF) {
-		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
-			/* coverity[check_return] */
-			__xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
-					   ring->q_index,
-					   ring->q_vector->napi.napi_id,
-					   ring->vsi->rx_buf_len);
+		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
+			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+						 ring->q_index,
+						 ring->q_vector->napi.napi_id,
+						 ring->rx_buf_len);
+			if (err)
+				return err;
+		}
 
 		ring->xsk_pool = ice_xsk_pool(ring);
 		if (ring->xsk_pool) {
-			xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
+			xdp_rxq_info_unreg(&ring->xdp_rxq);
 
 			ring->rx_buf_len =
 				xsk_pool_get_rx_frame_size(ring->xsk_pool);
+			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+						 ring->q_index,
+						 ring->q_vector->napi.napi_id,
+						 ring->rx_buf_len);
+			if (err)
+				return err;
 			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 							 MEM_TYPE_XSK_BUFF_POOL,
 							 NULL);
@@ -571,13 +579,14 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
 				 ring->q_index);
 		} else {
-			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
-				/* coverity[check_return] */
-				__xdp_rxq_info_reg(&ring->xdp_rxq,
-						   ring->netdev,
-						   ring->q_index,
-						   ring->q_vector->napi.napi_id,
-						   ring->vsi->rx_buf_len);
+			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
+				err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+							 ring->q_index,
+							 ring->q_vector->napi.napi_id,
+							 ring->rx_buf_len);
+				if (err)
+					return err;
+			}
 
 			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 							 MEM_TYPE_PAGE_SHARED,
-- 
2.34.1


