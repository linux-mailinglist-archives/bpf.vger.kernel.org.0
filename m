Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C4E495F22
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 13:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380409AbiAUMmE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 07:42:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:14452 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380407AbiAUMmD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 07:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642768923; x=1674304923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0pHaptX7sukMXkuf0kup1K23C3PktzMClmX1Epq3WNM=;
  b=f7TWubH9Xtt1mXWdtUgjPADxvne6/RxG8AYVlp5oWnIE3CCB9UfWS8wm
   he56TPl2wX+UQmTMUYVzIRNRZ/V3SWOw9ZprmY/RvSe6KQRFGkq/pa2T5
   VNtfLdctXska04l3VgAk0aLqql+5uZhWKJcRGrOwKIGgr1Bped9Dq86J+
   D3RuN9l9MT/bMS5Mbl3blh0t04t8RFTU4+f0TGCEXTTafXld+ra/Nu70v
   Bnc2JGuBQ/yrgC/h3GJx05V9UgyFvi9C2aNzn1fzyK+fmmZusqDDaqFUx
   OdEkZWZeHFZGwSuTk18Fp5Kxm3q2W2TKaPj+/AE0P/P+zOP4DZWHFBxkw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="245592695"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="245592695"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 04:42:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="694625233"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2022 04:42:01 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 20LCg0q6029349;
        Fri, 21 Jan 2022 12:42:00 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, magnus.karlsson@intel.com
Subject: Rx: [PATCH bpf-next v3 3/7] ice: make Tx threshold dependent on ring length
Date:   Fri, 21 Jan 2022 13:40:29 +0100
Message-Id: <20220121124029.23856-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121120011.49316-4-maciej.fijalkowski@intel.com>
References: <20220121120011.49316-1-maciej.fijalkowski@intel.com> <20220121120011.49316-4-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 21 Jan 2022 13:00:07 +0100

> XDP_TX workloads use a concept of Tx threshold that indicates the
> interval of setting RS bit on descriptors which in turn tells the HW to
> generate an interrupt to signal the completion of Tx on HW side. It is
> currently based on a constant value of 32 which might not work out well
> for various sizes of ring combined with for example batch size that can
> be set via SO_BUSY_POLL_BUDGET.
> 
> Internal tests based on AF_XDP showed that most convenient setup of
> mentioned threshold is when it is equal to quarter of a ring length.
> 
> Introduce @tx_thresh field in ice_tx_ring struct that will store the
> value of threshold and use it in favor of ICE_TX_THRESH.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  3 +++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  5 +++--
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  7 ++++++-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 14 ++++++++------
>  4 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index e2e3ef7fba7f..bfa5e5d167ab 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -2803,6 +2803,9 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>  		/* clone ring and setup updated count */
>  		xdp_rings[i] = *vsi->xdp_rings[i];
>  		xdp_rings[i].count = new_tx_cnt;
> +		xdp_rings[i].tx_thresh = ice_get_tx_threshold(&xdp_rings[i]);
> +		xdp_rings[i].next_dd = xdp_rings[i].tx_thresh - 1;
> +		xdp_rings[i].next_rs = xdp_rings[i].tx_thresh - 1;
>  		xdp_rings[i].desc = NULL;
>  		xdp_rings[i].tx_buf = NULL;
>  		err = ice_setup_tx_ring(&xdp_rings[i]);
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 30814435f779..0fd12a7f6d22 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -2495,10 +2495,11 @@ static int ice_xdp_alloc_setup_rings(struct ice_vsi *vsi)
>  		xdp_ring->reg_idx = vsi->txq_map[xdp_q_idx];
>  		xdp_ring->vsi = vsi;
>  		xdp_ring->netdev = NULL;
> -		xdp_ring->next_dd = ICE_TX_THRESH - 1;
> -		xdp_ring->next_rs = ICE_TX_THRESH - 1;
>  		xdp_ring->dev = dev;
>  		xdp_ring->count = vsi->num_tx_desc;
> +		xdp_ring->tx_thresh = ice_get_tx_threshold(xdp_ring);
> +		xdp_ring->next_dd = xdp_ring->tx_thresh - 1;
> +		xdp_ring->next_rs = xdp_ring->tx_thresh - 1;
>  		WRITE_ONCE(vsi->xdp_rings[i], xdp_ring);
>  		if (ice_setup_tx_ring(xdp_ring))
>  			goto free_xdp_rings;
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index 94a46e0e5ed0..09c8ad2f7403 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -13,7 +13,6 @@
>  #define ICE_MAX_CHAINED_RX_BUFS	5
>  #define ICE_MAX_BUF_TXD		8
>  #define ICE_MIN_TX_LEN		17
> -#define ICE_TX_THRESH		32
>  
>  /* The size limit for a transmit buffer in a descriptor is (16K - 1).
>   * In order to align with the read requests we will align the value to
> @@ -333,6 +332,7 @@ struct ice_tx_ring {
>  	struct ice_channel *ch;
>  	struct ice_ptp_tx *tx_tstamps;
>  	spinlock_t tx_lock;
> +	u16 tx_thresh;

Creating 2-byte hole here, but it's likely ok since I don't see a
place to pack it nicely. u8 at the end is not an option obviously.

(unless you want to store the order rather than the threshold
itself -- would require an additional macro, but at the same time
align nicely with the fact that we need the threshold to be of
power of two)

>  	u32 txq_teid;			/* Added Tx queue TEID */
>  #define ICE_TX_FLAGS_RING_XDP		BIT(0)
>  	u8 flags;
> @@ -355,6 +355,11 @@ static inline void ice_clear_ring_build_skb_ena(struct ice_rx_ring *ring)
>  	ring->flags &= ~ICE_RX_FLAGS_RING_BUILD_SKB;
>  }
>  
> +static inline u16 ice_get_tx_threshold(struct ice_tx_ring *tx_ring)
> +{
> +	return ICE_RING_QUARTER(tx_ring);
> +}
> +
>  static inline bool ice_ring_ch_enabled(struct ice_tx_ring *ring)
>  {
>  	return !!ring->ch;
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index 0e87b98e0966..5706b5405373 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -222,6 +222,7 @@ ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag)
>  static void ice_clean_xdp_irq(struct ice_tx_ring *xdp_ring)
>  {
>  	unsigned int total_bytes = 0, total_pkts = 0;
> +	u16 tx_thresh = xdp_ring->tx_thresh;
>  	u16 ntc = xdp_ring->next_to_clean;
>  	struct ice_tx_desc *next_dd_desc;
>  	u16 next_dd = xdp_ring->next_dd;
> @@ -233,7 +234,7 @@ static void ice_clean_xdp_irq(struct ice_tx_ring *xdp_ring)
>  	    cpu_to_le64(ICE_TX_DESC_DTYPE_DESC_DONE)))
>  		return;
>  
> -	for (i = 0; i < ICE_TX_THRESH; i++) {
> +	for (i = 0; i < tx_thresh; i++) {
>  		tx_buf = &xdp_ring->tx_buf[ntc];
>  
>  		total_bytes += tx_buf->bytecount;
> @@ -254,9 +255,9 @@ static void ice_clean_xdp_irq(struct ice_tx_ring *xdp_ring)
>  	}
>  
>  	next_dd_desc->cmd_type_offset_bsz = 0;
> -	xdp_ring->next_dd = xdp_ring->next_dd + ICE_TX_THRESH;
> +	xdp_ring->next_dd = xdp_ring->next_dd + tx_thresh;
>  	if (xdp_ring->next_dd > xdp_ring->count)
> -		xdp_ring->next_dd = ICE_TX_THRESH - 1;
> +		xdp_ring->next_dd = tx_thresh - 1;
>  	xdp_ring->next_to_clean = ntc;
>  	ice_update_tx_ring_stats(xdp_ring, total_pkts, total_bytes);
>  }
> @@ -269,12 +270,13 @@ static void ice_clean_xdp_irq(struct ice_tx_ring *xdp_ring)
>   */
>  int ice_xmit_xdp_ring(void *data, u16 size, struct ice_tx_ring *xdp_ring)
>  {
> +	u16 tx_thresh = xdp_ring->tx_thresh;
>  	u16 i = xdp_ring->next_to_use;
>  	struct ice_tx_desc *tx_desc;
>  	struct ice_tx_buf *tx_buf;
>  	dma_addr_t dma;
>  
> -	if (ICE_DESC_UNUSED(xdp_ring) < ICE_TX_THRESH)
> +	if (ICE_DESC_UNUSED(xdp_ring) < tx_thresh)
>  		ice_clean_xdp_irq(xdp_ring);
>  
>  	if (!unlikely(ICE_DESC_UNUSED(xdp_ring))) {
> @@ -306,7 +308,7 @@ int ice_xmit_xdp_ring(void *data, u16 size, struct ice_tx_ring *xdp_ring)
>  		tx_desc = ICE_TX_DESC(xdp_ring, xdp_ring->next_rs);
>  		tx_desc->cmd_type_offset_bsz |=
>  			cpu_to_le64(ICE_TX_DESC_CMD_RS << ICE_TXD_QW1_CMD_S);
> -		xdp_ring->next_rs = ICE_TX_THRESH - 1;
> +		xdp_ring->next_rs = tx_thresh - 1;
>  	}
>  	xdp_ring->next_to_use = i;
>  
> @@ -314,7 +316,7 @@ int ice_xmit_xdp_ring(void *data, u16 size, struct ice_tx_ring *xdp_ring)
>  		tx_desc = ICE_TX_DESC(xdp_ring, xdp_ring->next_rs);
>  		tx_desc->cmd_type_offset_bsz |=
>  			cpu_to_le64(ICE_TX_DESC_CMD_RS << ICE_TXD_QW1_CMD_S);
> -		xdp_ring->next_rs += ICE_TX_THRESH;
> +		xdp_ring->next_rs += tx_thresh;
>  	}
>  
>  	return ICE_XDP_TX;
> -- 
> 2.33.1

Thanks,
Al
