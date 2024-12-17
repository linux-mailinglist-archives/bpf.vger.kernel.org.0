Return-Path: <bpf+bounces-47074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630839F3EC2
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 01:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7319B16C4AF
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 00:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D561C8F0;
	Tue, 17 Dec 2024 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwzibjX0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95195A933;
	Tue, 17 Dec 2024 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734394984; cv=none; b=GMBttk3PJSx1+MOY7Bf15fMmaV7ayDljGd7EWGRrgvc3pfCsaK1yIfp1gmZ7ZQjzt5UpLi/vNaoKLv4keHBzkz12GRypomG67X2S8k7VpSN8UPYOkJ7v5KpXHQmW3f/YG3Fc8U7+M57CZQLLwoJkRmQqkBgZMy8zMlvT9LJk58k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734394984; c=relaxed/simple;
	bh=uP/C8CJt4h8/uPVrpfNEFzLXs3+mC+2Ou1nN8g+/+dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg0ySUugzaMVr0HoG/X766QRpF1uRbj4Ycr4RtSR0nwo2dFcslqx8IQCN1dZtjIcsAH+6Wz8Rr9lLi2vRHfCC7H0L7zdv+iE0To4gBWtWD5WFc9E1pbsXysghu8CNU+Cqhv2fjiJOs3ylzWAj3UpnyXOP/IN8ingEaGwuLASNuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwzibjX0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436246b1f9bso6444615e9.1;
        Mon, 16 Dec 2024 16:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734394980; x=1734999780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PF8fpDpYHJ1tAiiZnJBSo2Zba1bGNpLLOnwBhXXEsQ4=;
        b=FwzibjX0v3SdTaEuXoQkHhgRkjRmKTotLhDQLWTtDaE0nT3sGXgT6lE+tuce4OGBBN
         QnPia4sh7+aQ265DFNvXa9NzOClDUNc0OdglBa5gn1MWaG+HZyuMpYKJ0tPFbDV/+ydt
         +kKZm+PwTBSCHVpUjNgYPJTu8EZdUZeEP8pac80Qko81yiP5JQgCDuxd4M+4a7lEcKPF
         0qFsc77K6Yr7dffQZXnMlWYB8LoyQKTiEnDr33RP6AEQFDXbdob2GMWGRItQI2svn04a
         IsTLpvvxESMHzGx9F8ly58FZwM+zRrTp2DDnKx5s67tgP9LQuja4H1KiI4hwQqk5IIeX
         10Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734394980; x=1734999780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PF8fpDpYHJ1tAiiZnJBSo2Zba1bGNpLLOnwBhXXEsQ4=;
        b=Ea0grhGFE8syqimZuiPCRLnUzjV91U3r+5MNwBOwO54F84UI9DpfxcrkruZQH6FvAb
         8GHZaXuwmnmNQIyAqmSZEW4l7oN6mG/s2nquTcRiCYtJUWoffQ5/8e6VLKV+dNbRB/sq
         8RpXBnVC/4cZS7xcTctQSR/5HLA3WvlmPHnVla++WzZHGmVP6ErGxsdPdPTW3eYSUvAZ
         QgXh9/Pm9yr0GnYA/DANzntzHcmoEvbuhLFjvBE/wZyUDq5jnYtlWfD2w+34iTcoNYqb
         hgvgZ2pmr7qIwX725aPV3EtrN7dPPMAFNZ7LvRihcc8q64ZMQL9K9hfRVI21y7wOgY26
         9KUw==
X-Forwarded-Encrypted: i=1; AJvYcCUHH6ABvh9MRyNihGu7VR7tIbHtnbYgCPTCHUxw9o5wjhva73NEHpko9i/qEOk8Et7LLB8=@vger.kernel.org, AJvYcCVEPKaMo0g7CUozXy3923NsqrA847orJf2WufCL09Q82vz2eXYAIXoNu0DM2MNNkFQhRc1loEEg4A4mqVsP@vger.kernel.org, AJvYcCWqUfZEpMu2Vlah9qa+PK/KwMMpV3CckDffcRgj7f+zw7eDuyF83lG6zJQfb0wSQtQYjqcfY3fq@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2mqGzqT3MUHpp2Zmu1ijeCy6uDDXWG0icnx+8eynWHPWBH2o
	CkK2Pk9tirarFVlal2fUs2I4zgFKfHqBM+0dFC7GlBbGD5yAy4lB
X-Gm-Gg: ASbGnctyO/LUWLLRRDYbrGnZ3yzGKTBLOokXTi0nlOJb1/9VHtPl4IghfDhM3Med87J
	zcoFVP6MlRAGFtmYqLb2GHEI16NGOkpD/mzI1s5so7qToQGZz3r374gxkD7t5cbuvIj/6CNsTYp
	U9ax46UuA9WjU3PSYmefFeWUhCAQlFa4H3Km5KAo94Q1V06nhZWLOO3fV1heoPE4N+ZwKNG4PIX
	OZDSqd47MBR8w0Z5DjBqTJAFgBwzUL5pxSifi88C8FG
X-Google-Smtp-Source: AGHT+IE7LcmCmyOQEXhJtdADd0laHqeLlOTMRfSID/cuEP1ksiCpasObaYg5ZOdfNNrD+wtwYpJUVQ==
X-Received: by 2002:a05:600c:3b0f:b0:431:5316:6752 with SMTP id 5b1f17b1804b1-4362aa26c65mr47270555e9.2.1734394979441;
        Mon, 16 Dec 2024 16:22:59 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706588sm158272225e9.29.2024.12.16.16.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 16:22:57 -0800 (PST)
Date: Tue, 17 Dec 2024 02:22:54 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Furong Xu <0x1207@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next 6/9] igc: Add support for frame preemption
 verification
Message-ID: <20241217002254.lyakuia32jbnva46@skbuf>
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-7-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-7-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3ur2fsgh7dc7e6gg"
Content-Disposition: inline
In-Reply-To: <20241216064720.931522-7-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-7-faizal.abdul.rahim@linux.intel.com>


--3ur2fsgh7dc7e6gg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2024 at 01:47:17AM -0500, Faizal Rahim wrote:
> The i226 hardware doesn't implement the process of verification
> internally, this is left to the driver.
> 
> Add a simple implementation of the state machine defined in IEEE
> 802.3-2018, Section 99.4.7. The state machine is started manually by
> user after "verify-enabled" command is enabled.
> 
> Implementation includes:
> 1. Send and receive verify frame
> 2. Verification state handling
> 3. Send and receive response frame
> 
> Tested by triggering verification handshake:
> $ sudo ethtool --set-mm enp1s0 pmac-enabled on
> $ sudo ethtool --set-mm enp1s0 tx-enabled on
> $ sudo ethtool --set-mm enp1s0 verify-enabled on
> 
> Note that Ethtool API requires enabling "pmac-enabled on" and
> "tx-enabled on" before "verify-enabled on" can be issued.
> 
> After the upcoming patch ("igc: Add support to get MAC Merge data via
> ethtool") is implemented, verification status can be checked using:
> $ ethtool --show-mm enp1s0
>   MAC Merge layer state for enp1s0:
>   pMAC enabled: on
>   TX enabled: on
>   TX active: on
>   TX minimum fragment size: 252
>   RX minimum fragment size: 252
>   Verify enabled: on
>   Verify time: 128
>   Max verify time: 128
>   Verification status: SUCCEEDED
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---

Am I missing something, or this does not handle link state changes,
where the verification should restart on each link up? (maybe the old
link partner didn't support FPE and the new one does, or vice versa)

Either I don't follow the link between igc_watchdog_task() and any
verification related task, or it doesn't exist.

Anyway, while browsing through this software implementation of a
verification process, I cannot help but think we'd be making a huge
mistake to allow each driver to reimplement it on its own. We just
recently got stmmac to do something fairly clean, with the help and
great perseverence of Furong Xu (now copied).

I spent a bit of time extracting stmmac's core logic and putting it in
ethtool. If Furong had such good will so as to regression-test the
attached patch, do you think you could use this as a starting place
instead, and implement some ops and call some library methods, instead
of writing the entire logic yourself?

>  drivers/net/ethernet/intel/igc/igc.h         |  16 ++
>  drivers/net/ethernet/intel/igc/igc_defines.h |   6 +
>  drivers/net/ethernet/intel/igc/igc_ethtool.c |   8 +-
>  drivers/net/ethernet/intel/igc/igc_main.c    |  15 +-
>  drivers/net/ethernet/intel/igc/igc_tsn.c     | 230 +++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_tsn.h     |   4 +
>  6 files changed, 277 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 5a14e9101723..56a426765be7 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -40,6 +40,15 @@ void igc_ethtool_set_ops(struct net_device *);
>  
>  #define IGC_MAX_TX_TSTAMP_REGS		4
>  
> +/* Verification state defined as per section 30.14.1.2 in 802.3br spec */
> +enum verify_state {
> +	VERIFY_FAIL,
> +	INIT_VERIFICATION,
> +	VERIFIED,
> +	SEND_VERIFY,
> +	WAIT_FOR_RESPONSE,
> +};
> +
>  /**
>   * @verify_time: see struct ethtool_mm_state
>   * @verify_enabled: see struct ethtool_mm_state
> @@ -52,6 +61,12 @@ void igc_ethtool_set_ops(struct net_device *);
>   * @tx_min_frag_size: see struct ethtool_mm_state
>   */
>  struct fpe_t {
> +	struct delayed_work verification_work;
> +	unsigned long verify_timeout;
> +	bool received_smd_v;
> +	bool received_smd_r;
> +	unsigned int verify_cnt;
> +	enum verify_state verify_state;

Should have updated the kernel-doc if you started a kernel-doc scheme.

>  	u32 verify_time;
>  	bool verify_enabled;
>  	bool tx_enabled;
> @@ -758,6 +773,7 @@ int igc_add_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
>  void igc_del_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
>  int igc_enable_empty_addr_recv(struct igc_adapter *adapter);
>  struct igc_ring *igc_get_tx_ring(struct igc_adapter *adapter, int cpu);
> +void igc_flush_tx_descriptors(struct igc_ring *ring);
>  void igc_ptp_init(struct igc_adapter *adapter);
>  void igc_ptp_reset(struct igc_adapter *adapter);
>  void igc_ptp_suspend(struct igc_adapter *adapter);
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 3088cdd08f35..ba96776d5854 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -308,6 +308,8 @@
>  #define IGC_TXD_DTYP_C		0x00000000 /* Context Descriptor */
>  #define IGC_TXD_POPTS_IXSM	0x01       /* Insert IP checksum */
>  #define IGC_TXD_POPTS_TXSM	0x02       /* Insert TCP/UDP checksum */
> +#define IGC_TXD_POPTS_SMD_V	0x10       /* Transmitted packet is a SMD-Verify */
> +#define IGC_TXD_POPTS_SMD_R	0x20       /* Transmitted packet is a SMD-Response */
>  #define IGC_TXD_CMD_EOP		0x01000000 /* End of Packet */
>  #define IGC_TXD_CMD_IC		0x04000000 /* Insert Checksum */
>  #define IGC_TXD_CMD_DEXT	0x20000000 /* Desc extension (0 = legacy) */
> @@ -370,9 +372,13 @@
>  #define IGC_RXD_STAT_VP		0x08	/* IEEE VLAN Packet */
>  
>  #define IGC_RXDEXT_STATERR_LB	0x00040000
> +#define IGC_RXD_STAT_SMD_V	0x2000  /* SMD-Verify packet */
> +#define IGC_RXD_STAT_SMD_R	0x4000  /* SMD-Response packet */
>  
>  /* Advanced Receive Descriptor bit definitions */
>  #define IGC_RXDADV_STAT_TSIP	0x08000 /* timestamp in packet */
> +#define IGC_RXDADV_STAT_SMD_TYPE_MASK	0x06000
> +#define IGC_RXDADV_STAT_SMD_TYPE_SHIFT	13
>  
>  #define IGC_RXDEXT_STATERR_L4E		0x20000000
>  #define IGC_RXDEXT_STATERR_IPE		0x40000000
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 1954561ec4aa..7cde0e5a7320 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -1788,6 +1788,7 @@ static int igc_ethtool_set_mm(struct net_device *netdev,
>  {
>  	struct igc_adapter *adapter = netdev_priv(netdev);
>  	struct fpe_t *fpe = &adapter->fpe;
> +	bool verify_enabled_changed;
>  
>  	if (cmd->tx_min_frag_size < IGC_TX_MIN_FRAG_SIZE ||
>  	    cmd->tx_min_frag_size > IGC_TX_MAX_FRAG_SIZE)
> @@ -1805,7 +1806,12 @@ static int igc_ethtool_set_mm(struct net_device *netdev,
>  
>  	fpe->tx_enabled = cmd->tx_enabled;
>  	fpe->pmac_enabled = cmd->pmac_enabled;
> -	fpe->verify_enabled = cmd->verify_enabled;
> +	verify_enabled_changed = (cmd->verify_enabled != fpe->verify_enabled);

I wonder if it's worth using an intermediary variable when the result is
only evaluated once. The intention is clear enough already, you call a
function named igc_fpe_verify_enabled_changed().

> +
> +	if (verify_enabled_changed) {
> +		fpe->verify_enabled = cmd->verify_enabled;
> +		igc_fpe_verify_enabled_changed(fpe);
> +	}
>  
>  	return igc_tsn_offload_apply(adapter);
>  }
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index b85eaf34d07b..e184959ef218 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2534,7 +2534,7 @@ static struct sk_buff *igc_xdp_run_prog(struct igc_adapter *adapter,
>  }
>  
>  /* This function assumes __netif_tx_lock is held by the caller. */
> -static void igc_flush_tx_descriptors(struct igc_ring *ring)
> +void igc_flush_tx_descriptors(struct igc_ring *ring)
>  {
>  	/* Once tail pointer is updated, hardware can fetch the descriptors
>  	 * any time so we issue a write membar here to ensure all memory
> @@ -2585,6 +2585,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  	struct sk_buff *skb = rx_ring->skb;
>  	u16 cleaned_count = igc_desc_unused(rx_ring);
>  	int xdp_status = 0, rx_buffer_pgcnt;
> +	int smd_type;
>  
>  	while (likely(total_packets < budget)) {
>  		struct igc_xdp_buff ctx = { .rx_ts = NULL };
> @@ -2622,6 +2623,18 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  			size -= IGC_TS_HDR_LEN;
>  		}
>  
> +		smd_type = igc_fpe_get_smd_type(rx_desc->wb.upper.status_error);
> +
> +		if (igc_fpe_is_verify_or_response(smd_type, size)) {
> +			igc_fpe_preprocess_verify_response(&adapter->fpe,
> +							   smd_type);
> +
> +			/* Advance the ring next-to-clean */
> +			igc_is_non_eop(rx_ring, rx_desc);
> +			cleaned_count++;
> +			continue;
> +		}
> +

Premature optimization is the root of all evil, I know, but in the
future it might be interesting to add a static key here that gets
incremented (enabled) based on pmac_enabled, such that the fast path
does not get to suffer a performance penalty when frame preemption is
supported in the kernel, regardless of whether it is enabled or not.

>  		if (!skb) {
>  			xdp_init_buff(&ctx.xdp, truesize, &rx_ring->xdp_rxq);
>  			xdp_prepare_buff(&ctx.xdp, pktbuf - igc_rx_offset(rx_ring),
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index b968c02f5fee..3d39be2219f3 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -1,22 +1,252 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c)  2019 Intel Corporation */
>  
> +#include <linux/kernel.h>
>  #include "igc.h"
> +#include "igc_base.h"
>  #include "igc_hw.h"
>  #include "igc_tsn.h"
>  
>  #define DEFAULT_VERIFY_TIME		10
> +
> +#define IGC_SMD_TYPE_SMD_V		0x1
> +#define IGC_SMD_TYPE_SMD_R		0x2
>  #define IGC_MIN_FOR_TX_MIN_FRAG		0
>  #define IGC_MAX_FOR_TX_MIN_FRAG		3
>  
> +#define MAX_VERIFY_CNT			3
> +#define SMD_FRAME_SIZE			60
> +#define VERIFY_RESPONSE_DELAY		10
> +
> +static int igc_fpe_init_smd_frame(struct igc_ring *ring,
> +				  struct igc_tx_buffer *buffer,
> +				  struct sk_buff *skb)
> +{
> +	unsigned int size = skb_headlen(skb);
> +	dma_addr_t dma;
> +
> +	dma = dma_map_single(ring->dev, skb->data, size, DMA_TO_DEVICE);
> +
> +	if (dma_mapping_error(ring->dev, dma)) {
> +		netdev_err_once(ring->netdev, "Failed to map DMA for TX\n");
> +		return -ENOMEM;
> +	}
> +
> +	buffer->skb = skb;
> +	buffer->protocol = 0;
> +	buffer->bytecount = skb->len;
> +	buffer->gso_segs = 1;
> +	buffer->time_stamp = jiffies;
> +	dma_unmap_len_set(buffer, len, skb->len);

Not an expert here, but I believe a common source of DMA API bugs is
using different expressions for the map and unmap length.

Here, IIUC, alloc_skb() always returns a linear packet, so there's no
paged memory and skb->len == skb_headlen(). But it would still look
cleaner to my non-expert eye to use the same expression for both mapping
and unmapping operations.

> +	dma_unmap_addr_set(buffer, dma, dma);
> +
> +	return 0;
> +}
> +
> +static int igc_fpe_init_tx_descriptor(struct igc_ring *ring,
> +				      struct sk_buff *skb, int type)
> +{
> +	struct igc_tx_buffer *buffer;
> +	union igc_adv_tx_desc *desc;
> +	u32 cmd_type, olinfo_status;
> +	int err;
> +
> +	if (!igc_desc_unused(ring))
> +		return -EBUSY;
> +
> +	if (type != IGC_SMD_TYPE_SMD_V && type != IGC_SMD_TYPE_SMD_R)
> +		return -EINVAL;
> +
> +	buffer = &ring->tx_buffer_info[ring->next_to_use];
> +	err = igc_fpe_init_smd_frame(ring, buffer, skb);
> +	if (err)
> +		return err;
> +
> +	cmd_type = IGC_ADVTXD_DTYP_DATA | IGC_ADVTXD_DCMD_DEXT |
> +		   IGC_ADVTXD_DCMD_IFCS | IGC_TXD_DCMD |
> +		   buffer->bytecount;
> +	olinfo_status = buffer->bytecount << IGC_ADVTXD_PAYLEN_SHIFT;
> +
> +	switch (type) {
> +	case IGC_SMD_TYPE_SMD_V:
> +		olinfo_status |= (IGC_TXD_POPTS_SMD_V << 8);
> +		break;
> +	case IGC_SMD_TYPE_SMD_R:
> +		olinfo_status |= (IGC_TXD_POPTS_SMD_R << 8);
> +		break;
> +	}
> +
> +	desc = IGC_TX_DESC(ring, ring->next_to_use);
> +	desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> +	desc->read.olinfo_status = cpu_to_le32(olinfo_status);
> +	desc->read.buffer_addr = cpu_to_le64(dma_unmap_addr(buffer, dma));
> +
> +	netdev_tx_sent_queue(txring_txq(ring), skb->len);
> +
> +	buffer->next_to_watch = desc;
> +	ring->next_to_use = (ring->next_to_use + 1) % ring->count;
> +
> +	return 0;
> +}
> +
> +static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter, int type)
> +{
> +	int cpu = smp_processor_id();
> +	struct netdev_queue *nq;
> +	struct igc_ring *ring;
> +	struct sk_buff *skb;
> +	void *data;
> +	int err;
> +
> +	if (!netif_running(adapter->netdev))
> +		return -ENOTCONN;
> +
> +	ring = igc_get_tx_ring(adapter, cpu);
> +	nq = txring_txq(ring);
> +
> +	skb = alloc_skb(SMD_FRAME_SIZE, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	data = skb_put(skb, SMD_FRAME_SIZE);
> +	memset(data, 0, SMD_FRAME_SIZE);
> +
> +	__netif_tx_lock(nq, cpu);
> +
> +	err = igc_fpe_init_tx_descriptor(ring, skb, type);
> +	igc_flush_tx_descriptors(ring);
> +
> +	__netif_tx_unlock(nq);
> +
> +	return err;
> +}
> +
> +static void igc_fpe_send_response(struct igc_adapter *adapter)
> +{
> +	int err = igc_fpe_xmit_smd_frame(adapter, IGC_SMD_TYPE_SMD_R);
> +
> +	if (err)
> +		netdev_err(adapter->netdev, "Error sending SMD-R frame\n");
> +}
> +
> +static void igc_fpe_handle_verify(struct igc_adapter *adapter)
> +{
> +	struct fpe_t *fpe = &adapter->fpe;
> +	unsigned long verify_time_jiffies;
> +	int err;
> +
> +	switch (fpe->verify_state) {
> +	case SEND_VERIFY:
> +		fpe->received_smd_r = false;
> +		err = igc_fpe_xmit_smd_frame(adapter, IGC_SMD_TYPE_SMD_V);
> +
> +		if (err)
> +			netdev_err(adapter->netdev, "Error sending SMD-V\n");
> +
> +		fpe->verify_state = WAIT_FOR_RESPONSE;
> +		verify_time_jiffies = msecs_to_jiffies(fpe->verify_time);
> +		fpe->verify_timeout = jiffies + verify_time_jiffies;
> +
> +		schedule_delayed_work(&fpe->verification_work,
> +				      verify_time_jiffies);
> +		break;
> +
> +	case WAIT_FOR_RESPONSE:
> +		if (fpe->received_smd_r) {
> +			fpe->verify_state = VERIFIED;
> +			fpe->received_smd_r = false;
> +		} else if (time_is_before_jiffies(fpe->verify_timeout)) {
> +			fpe->verify_cnt++;
> +			netdev_warn(adapter->netdev,
> +				    "Timeout waiting for SMD-R frame\n");
> +
> +			if (fpe->verify_cnt > MAX_VERIFY_CNT) {
> +				fpe->verify_state = VERIFY_FAIL;
> +				netdev_err(adapter->netdev,
> +					   "Exceeded attempts sending SMD-V\n");
> +			} else {
> +				fpe->verify_state = SEND_VERIFY;
> +				igc_fpe_handle_verify(adapter);
> +			}
> +		}
> +		break;
> +
> +	case VERIFY_FAIL:
> +	case VERIFIED:
> +	case INIT_VERIFICATION:
> +		break;
> +	}
> +}
> +
> +static void igc_fpe_verification(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct igc_adapter *adapter;
> +	struct fpe_t *fpe;
> +
> +	fpe = container_of(dwork, struct fpe_t, verification_work);
> +	adapter = container_of(fpe, struct igc_adapter, fpe);
> +
> +	if (fpe->received_smd_v) {
> +		igc_fpe_send_response(adapter);
> +		fpe->received_smd_v = false;
> +	}
> +
> +	if (fpe->verify_enabled)
> +		igc_fpe_handle_verify(adapter);
> +}
> +
>  void igc_fpe_init(struct fpe_t *fpe)
>  {
> +	INIT_DELAYED_WORK(&fpe->verification_work, igc_fpe_verification);
>  	fpe->verify_enabled = false;
> +	fpe->verify_state = INIT_VERIFICATION;
>  	fpe->verify_time = DEFAULT_VERIFY_TIME;
> +	fpe->received_smd_v = false;
> +	fpe->received_smd_r = false;
> +	fpe->verify_cnt = 0;
>  	fpe->pmac_enabled = false;
>  	fpe->tx_min_frag_size = IGC_TX_MIN_FRAG_SIZE;
>  }
>  
> +void igc_fpe_verify_enabled_changed(struct fpe_t *fpe)
> +{
> +	if (fpe->verify_enabled && fpe->tx_enabled) {
> +		fpe->verify_state = SEND_VERIFY;
> +		schedule_delayed_work(&fpe->verification_work,
> +				      msecs_to_jiffies(VERIFY_RESPONSE_DELAY));
> +	} else {
> +		fpe->verify_state = INIT_VERIFICATION;
> +		fpe->received_smd_v = false;
> +		fpe->received_smd_r = false;
> +		fpe->verify_cnt = 0;
> +	}
> +}
> +
> +int igc_fpe_get_smd_type(__le32 status_error)
> +{
> +	u32 status = le32_to_cpu(status_error);
> +
> +	return (status & IGC_RXDADV_STAT_SMD_TYPE_MASK)
> +		>> IGC_RXDADV_STAT_SMD_TYPE_SHIFT;
> +}
> +
> +bool igc_fpe_is_verify_or_response(int smd_type, unsigned int size)
> +{
> +	return ((smd_type == IGC_SMD_TYPE_SMD_V ||
> +		 smd_type == IGC_SMD_TYPE_SMD_R) && size == SMD_FRAME_SIZE);
> +}
> +
> +void igc_fpe_preprocess_verify_response(struct fpe_t *fpe, int smd_type)
> +{
> +	if (smd_type == IGC_SMD_TYPE_SMD_V)
> +		fpe->received_smd_v = true;
> +	else if (smd_type == IGC_SMD_TYPE_SMD_R)
> +		fpe->received_smd_r = true;
> +
> +	schedule_delayed_work(&fpe->verification_work, 0);
> +}
> +
>  static bool is_any_launchtime(struct igc_adapter *adapter)
>  {
>  	int i;
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
> index 08e7582f257e..f3d83fbbd1f4 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.h
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
> @@ -12,7 +12,11 @@
>  #define MIN_VERIFY_TIME			1
>  #define MAX_VERIFY_TIME			128
>  
> +int igc_fpe_get_smd_type(__le32 status_error);
>  void igc_fpe_init(struct fpe_t *fpe);
> +bool igc_fpe_is_verify_or_response(int smd_type, unsigned int size);
> +void igc_fpe_preprocess_verify_response(struct fpe_t *fpe, int smd_type);
> +void igc_fpe_verify_enabled_changed(struct fpe_t *fpe);
>  int igc_tsn_offload_apply(struct igc_adapter *adapter);
>  int igc_tsn_reset(struct igc_adapter *adapter);
>  void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter);
> -- 
> 2.25.1
> 
> 


--3ur2fsgh7dc7e6gg
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-ethtool-mm-extract-stmmac-verification-logic-int.patch"

From d36050935733c1ecd881af5c909a5af71a87207a Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 17 Dec 2024 02:02:53 +0200
Subject: [PATCH] net: ethtool: mm: extract stmmac verification logic into
 common library

It appears that stmmac is not the only hardware which requires a
software-driven verification state machine for the MAC Merge layer.

While on the one hand it's good to encourage hardware implementations,
on the other hand it's quite difficult to tolerate multiple drivers
implementing independently fairly non-trivial logic.

Extract the hardware-independent logic from stmmac into library code and
put it in ethtool. Name the state structure "mmsv" for MAC Merge
Software Verification. Let this expose an operations structure for
executing the hardware stuff: sync hardware with the tx_active boolean
(result of verification process), enable/disable the pMAC, send mPackets,
notify library of external events (reception of mPackets), as well as
link state changes.

Note that it is assumed that the external events are received in hardirq
context. If they are not, it is probably a good idea to disable hardirqs
when calling ethtool_mmsv_event_handle(), because the library does not
do so.

Also, the MM software verification process has no business with the
tx_min_frag_size, that is all the driver's to handle.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  16 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  40 +---
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 174 +++-----------
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |   5 -
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   8 +-
 include/linux/ethtool.h                       |  61 +++++
 net/ethtool/mm.c                              | 214 ++++++++++++++++++
 7 files changed, 319 insertions(+), 199 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 1d86439b8a14..7718df98f835 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -147,21 +147,9 @@ struct stmmac_channel {
 };
 
 struct stmmac_fpe_cfg {
-	/* Serialize access to MAC Merge state between ethtool requests
-	 * and link state updates.
-	 */
-	spinlock_t lock;
-
+	struct ethtool_mmsv mmsv;
 	const struct stmmac_fpe_reg *reg;
-	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
-
-	enum ethtool_mm_verify_status status;
-	struct timer_list verify_timer;
-	bool verify_enabled;
-	int verify_retries;
-	bool pmac_enabled;
-	u32 verify_time;
-	bool tx_enabled;
+	u32 fpe_csr;	/* MAC_FPE_CTRL_STS reg cache */
 };
 
 struct stmmac_tc_entry {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 1d77389ce953..d755b7fd3056 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1268,37 +1268,17 @@ static int stmmac_get_mm(struct net_device *ndev,
 			 struct ethtool_mm_state *state)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	unsigned long flags;
 	u32 frag_size;
 
 	if (!stmmac_fpe_supported(priv))
 		return -EOPNOTSUPP;
 
-	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
+	ethtool_mmsv_get_mm(&priv->fpe_cfg.mmsv, state);
 
-	state->max_verify_time = STMMAC_FPE_MM_MAX_VERIFY_TIME_MS;
-	state->verify_enabled = priv->fpe_cfg.verify_enabled;
-	state->pmac_enabled = priv->fpe_cfg.pmac_enabled;
-	state->verify_time = priv->fpe_cfg.verify_time;
-	state->tx_enabled = priv->fpe_cfg.tx_enabled;
-	state->verify_status = priv->fpe_cfg.status;
 	state->rx_min_frag_size = ETH_ZLEN;
-
-	/* FPE active if common tx_enabled and
-	 * (verification success or disabled(forced))
-	 */
-	if (state->tx_enabled &&
-	    (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
-	     state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED))
-		state->tx_active = true;
-	else
-		state->tx_active = false;
-
 	frag_size = stmmac_fpe_get_add_frag_size(priv);
 	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(frag_size);
 
-	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
-
 	return 0;
 }
 
@@ -1307,7 +1287,6 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	unsigned long flags;
 	u32 frag_size;
 	int err;
 
@@ -1316,23 +1295,8 @@ static int stmmac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 	if (err)
 		return err;
 
-	/* Wait for the verification that's currently in progress to finish */
-	timer_shutdown_sync(&fpe_cfg->verify_timer);
-
-	spin_lock_irqsave(&fpe_cfg->lock, flags);
-
-	fpe_cfg->verify_enabled = cfg->verify_enabled;
-	fpe_cfg->pmac_enabled = cfg->pmac_enabled;
-	fpe_cfg->verify_time = cfg->verify_time;
-	fpe_cfg->tx_enabled = cfg->tx_enabled;
-
-	if (!cfg->verify_enabled)
-		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
-
+	ethtool_mmsv_set_mm(&priv->fpe_cfg.mmsv, cfg);
 	stmmac_fpe_set_add_frag_size(priv, frag_size);
-	stmmac_fpe_apply(priv);
-
-	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index 3a4bee029c7f..75b470ee621a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -27,12 +27,6 @@
 #define STMMAC_MAC_FPE_CTRL_STS_SVER	BIT(1)
 #define STMMAC_MAC_FPE_CTRL_STS_EFPE	BIT(0)
 
-/* FPE link-partner hand-shaking mPacket type */
-enum stmmac_mpacket_type {
-	MPACKET_VERIFY = 0,
-	MPACKET_RESPONSE = 1,
-};
-
 struct stmmac_fpe_reg {
 	const u32 mac_fpe_reg;		/* offset of MAC_FPE_CTRL_STS */
 	const u32 mtl_fpe_reg;		/* offset of MTL_FPE_CTRL_STS */
@@ -48,10 +42,10 @@ bool stmmac_fpe_supported(struct stmmac_priv *priv)
 		priv->hw->mac->fpe_map_preemption_class;
 }
 
-static void stmmac_fpe_configure(struct stmmac_priv *priv, bool tx_enable,
-				 bool pmac_enable)
+static void stmmac_fpe_configure_tx(struct ethtool_mmsv *mmsv, bool tx_enable)
 {
-	struct stmmac_fpe_cfg *cfg = &priv->fpe_cfg;
+	struct stmmac_fpe_cfg *cfg = container_of(mmsv, struct stmmac_fpe_cfg, mmsv);
+	struct stmmac_priv *priv = container_of(cfg, struct stmmac_priv, fpe_cfg);
 	const struct stmmac_fpe_reg *reg = cfg->reg;
 	u32 num_rxq = priv->plat->rx_queues_to_use;
 	void __iomem *ioaddr = priv->ioaddr;
@@ -68,6 +62,15 @@ static void stmmac_fpe_configure(struct stmmac_priv *priv, bool tx_enable,
 		cfg->fpe_csr = 0;
 	}
 	writel(cfg->fpe_csr, ioaddr + reg->mac_fpe_reg);
+}
+
+static void stmmac_fpe_configure_pmac(struct ethtool_mmsv *mmsv, bool pmac_enable)
+{
+	struct stmmac_fpe_cfg *cfg = container_of(mmsv, struct stmmac_fpe_cfg, mmsv);
+	struct stmmac_priv *priv = container_of(cfg, struct stmmac_priv, fpe_cfg);
+	const struct stmmac_fpe_reg *reg = cfg->reg;
+	void __iomem *ioaddr = priv->ioaddr;
+	u32 value;
 
 	value = readl(ioaddr + reg->int_en_reg);
 
@@ -85,47 +88,45 @@ static void stmmac_fpe_configure(struct stmmac_priv *priv, bool tx_enable,
 	writel(value, ioaddr + reg->int_en_reg);
 }
 
-static void stmmac_fpe_send_mpacket(struct stmmac_priv *priv,
-				    enum stmmac_mpacket_type type)
+static void stmmac_fpe_send_mpacket(struct ethtool_mmsv *mmsv,
+				    enum ethtool_mpacket type)
 {
-	const struct stmmac_fpe_reg *reg = priv->fpe_cfg.reg;
+	struct stmmac_fpe_cfg *cfg = container_of(mmsv, struct stmmac_fpe_cfg, mmsv);
+	struct stmmac_priv *priv = container_of(cfg, struct stmmac_priv, fpe_cfg);
+	const struct stmmac_fpe_reg *reg = cfg->reg;
 	void __iomem *ioaddr = priv->ioaddr;
-	u32 value = priv->fpe_cfg.fpe_csr;
+	u32 value = cfg->fpe_csr;
 
-	if (type == MPACKET_VERIFY)
+	if (type == ETHTOOL_MPACKET_VERIFY)
 		value |= STMMAC_MAC_FPE_CTRL_STS_SVER;
-	else if (type == MPACKET_RESPONSE)
+	else if (type == ETHTOOL_MPACKET_RESPONSE)
 		value |= STMMAC_MAC_FPE_CTRL_STS_SRSP;
 
 	writel(value, ioaddr + reg->mac_fpe_reg);
 }
 
+static const struct ethtool_mmsv_ops stmmac_mmsv_ops = {
+	.configure_tx = stmmac_fpe_configure_tx,
+	.configure_pmac = stmmac_fpe_configure_pmac,
+	.send_mpacket = stmmac_fpe_send_mpacket,
+};
+
 static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
 {
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
+	struct ethtool_mmsv *mmsv = &fpe_cfg->mmsv;
 
-	/* This is interrupt context, just spin_lock() */
-	spin_lock(&fpe_cfg->lock);
-
-	if (!fpe_cfg->pmac_enabled || status == FPE_EVENT_UNKNOWN)
-		goto unlock_out;
+	if (status == FPE_EVENT_UNKNOWN)
+		return;
 
-	/* LP has sent verify mPacket */
 	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER)
-		stmmac_fpe_send_mpacket(priv, MPACKET_RESPONSE);
+		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET);
 
-	/* Local has sent verify mPacket */
-	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER &&
-	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED)
-		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
+	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER)
+		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LD_SENT_VERIFY_MPACKET);
 
-	/* LP has sent response mPacket */
-	if ((status & FPE_EVENT_RRSP) == FPE_EVENT_RRSP &&
-	    fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_VERIFYING)
-		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
-
-unlock_out:
-	spin_unlock(&fpe_cfg->lock);
+	if ((status & FPE_EVENT_RRSP) == FPE_EVENT_RRSP)
+		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET);
 }
 
 void stmmac_fpe_irq_status(struct stmmac_priv *priv)
@@ -164,119 +165,16 @@ void stmmac_fpe_irq_status(struct stmmac_priv *priv)
 	stmmac_fpe_event_status(priv, status);
 }
 
-/**
- * stmmac_fpe_verify_timer - Timer for MAC Merge verification
- * @t:  timer_list struct containing private info
- *
- * Verify the MAC Merge capability in the local TX direction, by
- * transmitting Verify mPackets up to 3 times. Wait until link
- * partner responds with a Response mPacket, otherwise fail.
- */
-static void stmmac_fpe_verify_timer(struct timer_list *t)
-{
-	struct stmmac_fpe_cfg *fpe_cfg = from_timer(fpe_cfg, t, verify_timer);
-	struct stmmac_priv *priv = container_of(fpe_cfg, struct stmmac_priv,
-						fpe_cfg);
-	unsigned long flags;
-	bool rearm = false;
-
-	spin_lock_irqsave(&fpe_cfg->lock, flags);
-
-	switch (fpe_cfg->status) {
-	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
-	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
-		if (fpe_cfg->verify_retries != 0) {
-			stmmac_fpe_send_mpacket(priv, MPACKET_VERIFY);
-			rearm = true;
-		} else {
-			fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
-		}
-
-		fpe_cfg->verify_retries--;
-		break;
-
-	case ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED:
-		stmmac_fpe_configure(priv, true, true);
-		break;
-
-	default:
-		break;
-	}
-
-	if (rearm) {
-		mod_timer(&fpe_cfg->verify_timer,
-			  jiffies + msecs_to_jiffies(fpe_cfg->verify_time));
-	}
-
-	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
-}
-
-static void stmmac_fpe_verify_timer_arm(struct stmmac_fpe_cfg *fpe_cfg)
-{
-	if (fpe_cfg->pmac_enabled && fpe_cfg->tx_enabled &&
-	    fpe_cfg->verify_enabled &&
-	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_FAILED &&
-	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
-		timer_setup(&fpe_cfg->verify_timer, stmmac_fpe_verify_timer, 0);
-		mod_timer(&fpe_cfg->verify_timer, jiffies);
-	}
-}
-
 void stmmac_fpe_init(struct stmmac_priv *priv)
 {
-	priv->fpe_cfg.verify_retries = STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
-	priv->fpe_cfg.verify_time = STMMAC_FPE_MM_MAX_VERIFY_TIME_MS;
-	priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
-	timer_setup(&priv->fpe_cfg.verify_timer, stmmac_fpe_verify_timer, 0);
-	spin_lock_init(&priv->fpe_cfg.lock);
+	ethtool_mmsv_init(&priv->fpe_cfg.mmsv, priv->dev,
+			  &stmmac_mmsv_ops);
 
 	if ((!priv->fpe_cfg.reg || !priv->hw->mac->fpe_map_preemption_class) &&
 	    priv->dma_cap.fpesel)
 		dev_info(priv->device, "FPE is not supported by driver.\n");
 }
 
-void stmmac_fpe_apply(struct stmmac_priv *priv)
-{
-	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-
-	/* If verification is disabled, configure FPE right away.
-	 * Otherwise let the timer code do it.
-	 */
-	if (!fpe_cfg->verify_enabled) {
-		stmmac_fpe_configure(priv, fpe_cfg->tx_enabled,
-				     fpe_cfg->pmac_enabled);
-	} else {
-		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
-		fpe_cfg->verify_retries = STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
-
-		if (netif_running(priv->dev))
-			stmmac_fpe_verify_timer_arm(fpe_cfg);
-	}
-}
-
-void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
-{
-	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	unsigned long flags;
-
-	timer_shutdown_sync(&fpe_cfg->verify_timer);
-
-	spin_lock_irqsave(&fpe_cfg->lock, flags);
-
-	if (is_up && fpe_cfg->pmac_enabled) {
-		/* VERIFY process requires pmac enabled when NIC comes up */
-		stmmac_fpe_configure(priv, false, true);
-
-		/* New link => maybe new partner => new verification process */
-		stmmac_fpe_apply(priv);
-	} else {
-		/* No link => turn off EFPE */
-		stmmac_fpe_configure(priv, false, false);
-	}
-
-	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
-}
-
 int stmmac_fpe_get_add_frag_size(struct stmmac_priv *priv)
 {
 	const struct stmmac_fpe_reg *reg = priv->fpe_cfg.reg;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
index b884eac7142d..3fc46acf7001 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -9,15 +9,10 @@
 #include <linux/types.h>
 #include <linux/netdevice.h>
 
-#define STMMAC_FPE_MM_MAX_VERIFY_RETRIES	3
-#define STMMAC_FPE_MM_MAX_VERIFY_TIME_MS	128
-
 struct stmmac_priv;
 
-void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up);
 bool stmmac_fpe_supported(struct stmmac_priv *priv);
 void stmmac_fpe_init(struct stmmac_priv *priv);
-void stmmac_fpe_apply(struct stmmac_priv *priv);
 void stmmac_fpe_irq_status(struct stmmac_priv *priv);
 int stmmac_fpe_get_add_frag_size(struct stmmac_priv *priv);
 void stmmac_fpe_set_add_frag_size(struct stmmac_priv *priv, u32 add_frag_size);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 16b8bcfa8b11..eba391568965 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -983,7 +983,7 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 	stmmac_set_eee_pls(priv, priv->hw, false);
 
 	if (stmmac_fpe_supported(priv))
-		stmmac_fpe_link_state_handle(priv, false);
+		ethtool_mmsv_link_state_handle(&priv->fpe_cfg.mmsv, false);
 }
 
 static void stmmac_mac_link_up(struct phylink_config *config,
@@ -1097,7 +1097,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 	}
 
 	if (stmmac_fpe_supported(priv))
-		stmmac_fpe_link_state_handle(priv, true);
+		ethtool_mmsv_link_state_handle(&priv->fpe_cfg.mmsv, true);
 
 	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
 		stmmac_hwtstamp_correct_latency(priv, priv);
@@ -4049,7 +4049,7 @@ static int stmmac_release(struct net_device *dev)
 	stmmac_release_ptp(priv);
 
 	if (stmmac_fpe_supported(priv))
-		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
+		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 
 	pm_runtime_put(priv->device);
 
@@ -7751,7 +7751,7 @@ int stmmac_suspend(struct device *dev)
 	rtnl_unlock();
 
 	if (stmmac_fpe_supported(priv))
-		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
+		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 
 	priv->speed = SPEED_UNKNOWN;
 	return 0;
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f711bfd75c4d..276e11d727cc 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -17,9 +17,13 @@
 #include <linux/compat.h>
 #include <linux/if_ether.h>
 #include <linux/netlink.h>
+#include <linux/timer_types.h>
 #include <uapi/linux/ethtool.h>
 #include <uapi/linux/net_tstamp.h>
 
+#define ETHTOOL_MM_MAX_VERIFY_TIME_MS		128
+#define ETHTOOL_MM_MAX_VERIFY_RETRIES		3
+
 struct compat_ethtool_rx_flow_spec {
 	u32		flow_type;
 	union ethtool_flow_union h_u;
@@ -673,6 +677,63 @@ struct ethtool_mm_stats {
 	u64 MACMergeHoldCount;
 };
 
+enum ethtool_mmsv_event {
+	ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET,
+	ETHTOOL_MMSV_LD_SENT_VERIFY_MPACKET,
+	ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET,
+};
+
+/* MAC Merge verification mPacket type */
+enum ethtool_mpacket {
+	ETHTOOL_MPACKET_VERIFY,
+	ETHTOOL_MPACKET_RESPONSE,
+};
+
+struct ethtool_mmsv;
+
+struct ethtool_mmsv_ops {
+	void (*configure_tx)(struct ethtool_mmsv *mmsv, bool tx_active);
+	void (*configure_pmac)(struct ethtool_mmsv *mmsv, bool pmac_enabled);
+	void (*send_mpacket)(struct ethtool_mmsv *mmsv, enum ethtool_mpacket mpacket);
+};
+
+/**
+ * struct ethtool_mmsv - MAC Merge Software Verification
+ * @ops: TODO
+ * @dev: TODO
+ * @lock: serialize access to MAC Merge state between
+ *	  ethtool requests and link state updates.
+ * @status: current verification FSM state
+ * @verify_timer: timer for verification in local TX direction
+ * @verify_enabled: TODO
+ * verify_retries: TODO
+ * pmac_enabled: TODO
+ * verify_time: TODO
+ * tx_enabled: TODO
+ */
+struct ethtool_mmsv {
+	const struct ethtool_mmsv_ops *ops;
+	struct net_device *dev;
+	spinlock_t lock;
+	enum ethtool_mm_verify_status status;
+	struct timer_list verify_timer;
+	bool verify_enabled;
+	int verify_retries;
+	bool pmac_enabled;
+	u32 verify_time;
+	bool tx_enabled;
+};
+
+void ethtool_mmsv_stop(struct ethtool_mmsv *mmsv);
+void ethtool_mmsv_link_state_handle(struct ethtool_mmsv *mmsv, bool up);
+void ethtool_mmsv_event_handle(struct ethtool_mmsv *mmsv,
+			       enum ethtool_mmsv_event event);
+void ethtool_mmsv_get_mm(struct ethtool_mmsv *mmsv,
+			 struct ethtool_mm_state *state);
+void ethtool_mmsv_set_mm(struct ethtool_mmsv *mmsv, struct ethtool_mm_cfg *cfg);
+void ethtool_mmsv_init(struct ethtool_mmsv *mmsv, struct net_device *dev,
+		       const struct ethtool_mmsv_ops *ops);
+
 /**
  * struct ethtool_rxfh_param - RXFH (RSS) parameters
  * @hfunc: Defines the current RSS hash function used by HW (or to be set to).
diff --git a/net/ethtool/mm.c b/net/ethtool/mm.c
index 2816bb23c3ad..3063fe00eef7 100644
--- a/net/ethtool/mm.c
+++ b/net/ethtool/mm.c
@@ -282,3 +282,217 @@ bool ethtool_dev_mm_supported(struct net_device *dev)
 	return supported;
 }
 EXPORT_SYMBOL_GPL(ethtool_dev_mm_supported);
+
+static void ethtool_mmsv_configure_tx(struct ethtool_mmsv *mmsv,
+				      bool tx_active)
+{
+	mmsv->ops->configure_tx(mmsv, tx_active);
+}
+
+static void ethtool_mmsv_configure_pmac(struct ethtool_mmsv *mmsv,
+					bool pmac_enabled)
+{
+	mmsv->ops->configure_tx(mmsv, pmac_enabled);
+}
+
+static void ethtool_mmsv_send_mpacket(struct ethtool_mmsv *mmsv,
+				      enum ethtool_mpacket mpacket)
+{
+	mmsv->ops->send_mpacket(mmsv, mpacket);
+}
+
+/**
+ * ethtool_mmsv_verify_timer - Timer for MAC Merge verification
+ * @t: timer_list struct containing private info
+ *
+ * Verify the MAC Merge capability in the local TX direction, by
+ * transmitting Verify mPackets up to 3 times. Wait until link
+ * partner responds with a Response mPacket, otherwise fail.
+ */
+static void ethtool_mmsv_verify_timer(struct timer_list *t)
+{
+	struct ethtool_mmsv *mmsv = from_timer(mmsv, t, verify_timer);
+	unsigned long flags;
+	bool rearm = false;
+
+	spin_lock_irqsave(&mmsv->lock, flags);
+
+	switch (mmsv->status) {
+	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
+	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
+		if (mmsv->verify_retries != 0) {
+			ethtool_mmsv_send_mpacket(mmsv, ETHTOOL_MPACKET_VERIFY);
+			rearm = true;
+		} else {
+			mmsv->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
+		}
+
+		mmsv->verify_retries--;
+		break;
+
+	case ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED:
+		ethtool_mmsv_configure_tx(mmsv, true);
+		break;
+
+	default:
+		break;
+	}
+
+	if (rearm) {
+		mod_timer(&mmsv->verify_timer,
+			  jiffies + msecs_to_jiffies(mmsv->verify_time));
+	}
+
+	spin_unlock_irqrestore(&mmsv->lock, flags);
+}
+
+static void ethtool_mmsv_verify_timer_arm(struct ethtool_mmsv *mmsv)
+{
+	if (mmsv->pmac_enabled && mmsv->tx_enabled && mmsv->verify_enabled &&
+	    mmsv->status != ETHTOOL_MM_VERIFY_STATUS_FAILED &&
+	    mmsv->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
+		timer_setup(&mmsv->verify_timer, ethtool_mmsv_verify_timer, 0);
+		mod_timer(&mmsv->verify_timer, jiffies);
+	}
+}
+
+static void ethtool_mmsv_apply(struct ethtool_mmsv *mmsv)
+{
+	/* If verification is disabled, configure FPE right away.
+	 * Otherwise let the timer code do it.
+	 */
+	if (!mmsv->verify_enabled) {
+		ethtool_mmsv_configure_tx(mmsv, mmsv->tx_enabled);
+	} else {
+		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
+		mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;
+
+		if (netif_running(mmsv->dev))
+			ethtool_mmsv_verify_timer_arm(mmsv);
+	}
+}
+
+void ethtool_mmsv_stop(struct ethtool_mmsv *mmsv)
+{
+	timer_shutdown_sync(&mmsv->verify_timer);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_stop);
+
+void ethtool_mmsv_link_state_handle(struct ethtool_mmsv *mmsv, bool up)
+{
+	unsigned long flags;
+
+	ethtool_mmsv_stop(mmsv);
+
+	spin_lock_irqsave(&mmsv->lock, flags);
+
+	if (up && mmsv->pmac_enabled) {
+		/* VERIFY process requires pMAC enabled when NIC comes up */
+		ethtool_mmsv_configure_pmac(mmsv, true);
+
+		/* New link => maybe new partner => new verification process */
+		ethtool_mmsv_apply(mmsv);
+	} else {
+		/* No link or pMAC not enabled */
+		ethtool_mmsv_configure_pmac(mmsv, false);
+		ethtool_mmsv_configure_tx(mmsv, false);
+	}
+
+	spin_unlock_irqrestore(&mmsv->lock, flags);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_link_state_handle);
+
+void ethtool_mmsv_event_handle(struct ethtool_mmsv *mmsv,
+			       enum ethtool_mmsv_event event)
+{
+	/* This is interrupt context, just spin_lock() */
+	spin_lock(&mmsv->lock);
+
+	if (!mmsv->pmac_enabled)
+		goto unlock;
+
+	switch (event) {
+	case ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET:
+		/* Link partner has sent verify mPacket */
+		ethtool_mmsv_send_mpacket(mmsv, ETHTOOL_MPACKET_RESPONSE);
+		break;
+	case ETHTOOL_MMSV_LD_SENT_VERIFY_MPACKET:
+		/* Local device has sent verify mPacket */
+		if (mmsv->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED)
+			mmsv->status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
+		break;
+	case ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET:
+		/* Link partner has sent response mPacket */
+		if (mmsv->status == ETHTOOL_MM_VERIFY_STATUS_VERIFYING)
+			mmsv->status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
+		break;
+	}
+
+unlock:
+	spin_unlock(&mmsv->lock);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_event_handle);
+
+void ethtool_mmsv_get_mm(struct ethtool_mmsv *mmsv,
+			 struct ethtool_mm_state *state)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mmsv->lock, flags);
+
+	state->max_verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
+	state->verify_enabled = mmsv->verify_enabled;
+	state->pmac_enabled = mmsv->pmac_enabled;
+	state->verify_time = mmsv->verify_time;
+	state->tx_enabled = mmsv->tx_enabled;
+	state->verify_status = mmsv->status;
+
+	/* TX is active if administratively enabled, and verification either
+	 * succeeded, or was administratively disabled.
+	 */
+	if (state->tx_enabled &&
+	    (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
+	     state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED))
+		state->tx_active = true;
+	else
+		state->tx_active = false;
+
+	spin_unlock_irqrestore(&mmsv->lock, flags);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_get_mm);
+
+void ethtool_mmsv_set_mm(struct ethtool_mmsv *mmsv, struct ethtool_mm_cfg *cfg)
+{
+	unsigned long flags;
+
+	/* Wait for the verification that's currently in progress to finish */
+	ethtool_mmsv_stop(mmsv);
+
+	spin_lock_irqsave(&mmsv->lock, flags);
+
+	mmsv->verify_enabled = cfg->verify_enabled;
+	mmsv->pmac_enabled = cfg->pmac_enabled;
+	mmsv->verify_time = cfg->verify_time;
+	mmsv->tx_enabled = cfg->tx_enabled;
+
+	if (!cfg->verify_enabled)
+		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+
+	ethtool_mmsv_apply(mmsv);
+
+	spin_unlock_irqrestore(&mmsv->lock, flags);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_set_mm);
+
+void ethtool_mmsv_init(struct ethtool_mmsv *mmsv, struct net_device *dev,
+		       const struct ethtool_mmsv_ops *ops)
+{
+	mmsv->ops = ops;
+	mmsv->dev = dev;
+	mmsv->verify_retries = ETHTOOL_MM_MAX_VERIFY_RETRIES;
+	mmsv->verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
+	mmsv->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+	timer_setup(&mmsv->verify_timer, ethtool_mmsv_verify_timer, 0);
+	spin_lock_init(&mmsv->lock);
+}
+EXPORT_SYMBOL_GPL(ethtool_mmsv_init);
-- 
2.43.0


--3ur2fsgh7dc7e6gg--

