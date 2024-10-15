Return-Path: <bpf+bounces-41940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE6599DBE9
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BB02834AB
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 01:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9754158A1F;
	Tue, 15 Oct 2024 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="db+gF2aT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAFB17BD3;
	Tue, 15 Oct 2024 01:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957121; cv=none; b=DbrjS6GqTU//bT58Nw8sTQkd+HtcjjXNjJmJ/AYVOB3HCjTIm7p2SJe8iH+/A+9Ame0kfnPnmb7xiayKDfTXoE1On3eNMZu9OXHFusYv1ll9qkEGDyC5exooewNMDYW5J89B98QCyZh2QodzYp3tkSO+oM8jd1MXgzF3gMa++dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957121; c=relaxed/simple;
	bh=jRe3cvMMhFQXU5Qt3lmzcFa6sNreGfi9RKk2Rty5aS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LNYIP9k1G1VlzBKlg4jS2yAReTxZ3ZOWe4XPgXMLLjk/MJdSRMCDvkqpUWDz8sSBcqexHRNoN6QHKVvTPpwOfvrDa383EpmHTgPNYo9lI0t92uVK6QzVjA8yd7j+eh+QfsRjzWOnL4u49zHeNZut0h4pS+wGmYL9gE3Oec/ZSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=db+gF2aT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728957119; x=1760493119;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jRe3cvMMhFQXU5Qt3lmzcFa6sNreGfi9RKk2Rty5aS8=;
  b=db+gF2aT3Gxls+BQyb1VrUvk2XCXYZ+4LEz59f9gp103XFhsBcRjMFX6
   IDtH2VMB67PAcx/EmHCCq/pcDCrCp5F42/NwliwTXTu4wCwAXW6qxVRvJ
   t1ywB6QXTAEqxIbe+aquIloYjoYUe1wT4BPZ48snzc+la50UBckq/RQHv
   eQTGzmMjBeSLKg9vd1DnNsEg14ZEDSPN+xCk53uNI98gk3pGz9RiWTGDR
   AbTzLUS2RgW6A+zFLrGASnfmw02A72mqdsApof67A5EpjgWYBHZxV2mm+
   ea8zuyVRiRTmwrP8mBdavVHy+NZJSqDeqZNfJJQoCjT3XKl538rzBJ9lu
   g==;
X-CSE-ConnectionGUID: CJYEp07ZQVe+clPX5hID8g==
X-CSE-MsgGUID: y3aaeEvRRlSBDlYUeqkzYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="15948999"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="15948999"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 18:51:59 -0700
X-CSE-ConnectionGUID: Xtxza0obQPi2lh2TP1yC5g==
X-CSE-MsgGUID: pgSghFNdTh6Jrefj0IEGKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="78561331"
Received: from jdoman-desk1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.221.73])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 18:51:58 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: kurt@linutronix.de, Joe Damato <jdamato@fastly.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "moderated
 list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:XDP (eXpress Data Path)"
 <bpf@vger.kernel.org>
Subject: Re: [RFC net-next v2 2/2] igc: Link queues to NAPI instances
In-Reply-To: <20241014213012.187976-3-jdamato@fastly.com>
References: <20241014213012.187976-1-jdamato@fastly.com>
 <20241014213012.187976-3-jdamato@fastly.com>
Date: Mon, 14 Oct 2024 18:51:57 -0700
Message-ID: <87ldyqnneq.fsf@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Joe Damato <jdamato@fastly.com> writes:

> Link queues to NAPI instances via netdev-genl API so that users can
> query this information with netlink. Handle a few cases in the driver:
>   1. Link/unlink the NAPIs when XDP is enabled/disabled
>   2. Handle IGC_FLAG_QUEUE_PAIRS enabled and disabled
>
> Example output when IGC_FLAG_QUEUE_PAIRS is enabled:
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json='{"ifindex": 2}'
>
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
>
> Since IGC_FLAG_QUEUE_PAIRS is enabled, you'll note that the same NAPI ID
> is present for both rx and tx queues at the same index, for example
> index 0:
>
> {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
> {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
>
> To test IGC_FLAG_QUEUE_PAIRS disabled, a test system was booted using
> the grub command line option "maxcpus=2" to force
> igc_set_interrupt_capability to disable IGC_FLAG_QUEUE_PAIRS.
>
> Example output when IGC_FLAG_QUEUE_PAIRS is disabled:
>
> $ lscpu | grep "On-line CPU"
> On-line CPU(s) list:      0,2
>
> $ ethtool -l enp86s0  | tail -5
> Current hardware settings:
> RX:		n/a
> TX:		n/a
> Other:		1
> Combined:	2
>
> $ cat /proc/interrupts  | grep enp
>  144: [...] enp86s0
>  145: [...] enp86s0-rx-0
>  146: [...] enp86s0-rx-1
>  147: [...] enp86s0-tx-0
>  148: [...] enp86s0-tx-1
>
> 1 "other" IRQ, and 2 IRQs for each of RX and Tx, so we expect netlink to
> report 4 IRQs with unique NAPI IDs:
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump napi-get --json='{"ifindex": 2}'
> [{'id': 8196, 'ifindex': 2, 'irq': 148},
>  {'id': 8195, 'ifindex': 2, 'irq': 147},
>  {'id': 8194, 'ifindex': 2, 'irq': 146},
>  {'id': 8193, 'ifindex': 2, 'irq': 145}]
>
> Now we examine which queues these NAPIs are associated with, expecting
> that since IGC_FLAG_QUEUE_PAIRS is disabled each RX and TX queue will
> have its own NAPI instance:
>
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  v2:
>    - Update commit message to include tests for IGC_FLAG_QUEUE_PAIRS
>      disabled
>    - Refactored code to move napi queue mapping and unmapping to helper
>      functions igc_set_queue_napi and igc_unset_queue_napi
>    - Adjust the code to handle IGC_FLAG_QUEUE_PAIRS disabled
>    - Call helpers to map/unmap queues to NAPIs in igc_up, __igc_open,
>      igc_xdp_enable_pool, and igc_xdp_disable_pool
>
>  drivers/net/ethernet/intel/igc/igc.h      |  3 ++
>  drivers/net/ethernet/intel/igc/igc_main.c | 58 +++++++++++++++++++++--
>  drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 +
>  3 files changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index eac0f966e0e4..7b1c9ea60056 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -337,6 +337,9 @@ struct igc_adapter {
>  	struct igc_led_classdev *leds;
>  };
>  
> +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> +			struct napi_struct *napi);
> +void igc_unset_queue_napi(struct igc_adapter *adapter, int q_idx);
>  void igc_up(struct igc_adapter *adapter);
>  void igc_down(struct igc_adapter *adapter);
>  int igc_open(struct net_device *netdev);
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 7964bbedb16c..59c00acfa0ed 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -4948,6 +4948,47 @@ static int igc_sw_init(struct igc_adapter *adapter)
>  	return 0;
>  }
>  
> +void igc_set_queue_napi(struct igc_adapter *adapter, int q_idx,
> +			struct napi_struct *napi)
> +{
> +	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
> +		netif_queue_set_napi(adapter->netdev, q_idx,
> +				     NETDEV_QUEUE_TYPE_RX, napi);
> +		netif_queue_set_napi(adapter->netdev, q_idx,
> +				     NETDEV_QUEUE_TYPE_TX, napi);
> +	} else {
> +		if (q_idx < adapter->num_rx_queues) {
> +			netif_queue_set_napi(adapter->netdev, q_idx,
> +					     NETDEV_QUEUE_TYPE_RX, napi);
> +		} else {
> +			q_idx -= adapter->num_rx_queues;
> +			netif_queue_set_napi(adapter->netdev, q_idx,
> +					     NETDEV_QUEUE_TYPE_TX, napi);
> +		}
> +	}
> +}
> +
> +void igc_unset_queue_napi(struct igc_adapter *adapter, int q_idx)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +
> +	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
> +		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
> +				     NULL);
> +		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX,
> +				     NULL);
> +	} else {
> +		if (q_idx < adapter->num_rx_queues) {
> +			netif_queue_set_napi(adapter->netdev, q_idx,
> +					     NETDEV_QUEUE_TYPE_RX, NULL);
> +		} else {
> +			q_idx -= adapter->num_rx_queues;
> +			netif_queue_set_napi(adapter->netdev, q_idx,
> +					     NETDEV_QUEUE_TYPE_TX, NULL);
> +		}
> +	}
> +}

It seems that igc_unset_queue_napi() is igc_set_queue_napi(x, y, NULL),
so I would suggest either implementing "unset" in terms of "set", or
using igc_set_queue_napi(x, y, NULL) directly in the "unlink" case (I
have a slight preference for the second option).

> +
>  /**
>   * igc_up - Open the interface and prepare it to handle traffic
>   * @adapter: board private structure
> @@ -4955,6 +4996,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
>  void igc_up(struct igc_adapter *adapter)
>  {
>  	struct igc_hw *hw = &adapter->hw;
> +	struct napi_struct *napi;
>  	int i = 0;
>  
>  	/* hardware has been reset, we need to reload some things */
> @@ -4962,8 +5004,11 @@ void igc_up(struct igc_adapter *adapter)
>  
>  	clear_bit(__IGC_DOWN, &adapter->state);
>  
> -	for (i = 0; i < adapter->num_q_vectors; i++)
> -		napi_enable(&adapter->q_vector[i]->napi);
> +	for (i = 0; i < adapter->num_q_vectors; i++) {
> +		napi = &adapter->q_vector[i]->napi;
> +		napi_enable(napi);
> +		igc_set_queue_napi(adapter, i, napi);
> +	}
>  
>  	if (adapter->msix_entries)
>  		igc_configure_msix(adapter);
> @@ -5192,6 +5237,7 @@ void igc_down(struct igc_adapter *adapter)
>  	for (i = 0; i < adapter->num_q_vectors; i++) {
>  		if (adapter->q_vector[i]) {
>  			napi_synchronize(&adapter->q_vector[i]->napi);
> +			igc_unset_queue_napi(adapter, i);
>  			napi_disable(&adapter->q_vector[i]->napi);
>  		}
>  	}
> @@ -6021,6 +6067,7 @@ static int __igc_open(struct net_device *netdev, bool resuming)
>  	struct igc_adapter *adapter = netdev_priv(netdev);
>  	struct pci_dev *pdev = adapter->pdev;
>  	struct igc_hw *hw = &adapter->hw;
> +	struct napi_struct *napi;
>  	int err = 0;
>  	int i = 0;
>  
> @@ -6056,8 +6103,11 @@ static int __igc_open(struct net_device *netdev, bool resuming)
>  
>  	clear_bit(__IGC_DOWN, &adapter->state);
>  
> -	for (i = 0; i < adapter->num_q_vectors; i++)
> -		napi_enable(&adapter->q_vector[i]->napi);
> +	for (i = 0; i < adapter->num_q_vectors; i++) {
> +		napi = &adapter->q_vector[i]->napi;
> +		napi_enable(napi);
> +		igc_set_queue_napi(adapter, i, napi);
> +	}
>  
>  	/* Clear any pending interrupts. */
>  	rd32(IGC_ICR);
> diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
> index e27af72aada8..886f04b8c394 100644
> --- a/drivers/net/ethernet/intel/igc/igc_xdp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
> @@ -84,6 +84,7 @@ static int igc_xdp_enable_pool(struct igc_adapter *adapter,
>  		napi_disable(napi);
>  	}
>  
> +	igc_unset_queue_napi(adapter, queue_id);
>  	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
>  	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
>  
> @@ -133,6 +134,7 @@ static int igc_xdp_disable_pool(struct igc_adapter *adapter, u16 queue_id)
>  	xsk_pool_dma_unmap(pool, IGC_RX_DMA_ATTR);
>  	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
>  	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
> +	igc_set_queue_napi(adapter, queue_id, napi);
>  
>  	if (needs_reset) {
>  		napi_enable(napi);
> -- 
> 2.25.1
>


Cheers,
-- 
Vinicius

