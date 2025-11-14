Return-Path: <bpf+bounces-74501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8590EC5CA71
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 833094E7273
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5AB31326D;
	Fri, 14 Nov 2025 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D34ygwUk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3114030E0D0;
	Fri, 14 Nov 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116601; cv=none; b=D2vW2SSwtPERM4vpo3a7b6ZJhl5Wp9g4SY/Mb/DwtIelDFd/iwvduuGDyn7naRXNwUwcGXc2xK/hBRIsX7PnoD9mpL2eq52r3n30ofWryTpvkVEN1eQnWZwE94tpSYNF+xoFxYgPAWBFi/pb7yZqLa08ijR8wkp4lKSULDxB+Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116601; c=relaxed/simple;
	bh=L2b6ovufuyOt5g32IaXTrP6gxb4p0lvhYk/QMzL7CJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLXZaCtk+/OLEGuVS0FWq8UASKyIjqeS29YbYQesvrhpngaweHimrt7Sl7tRGRyKUN9wYjQWqqjMGDu0FRXLxf8bbDIE50U7EMrv1WEEH5JoWCy4QVMtDqTXK0d6b/uy55icB01cyLZMZ2/0PF8LA38O8ME0xJQcFrdVGOMgra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D34ygwUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5859C16AAE;
	Fri, 14 Nov 2025 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763116600;
	bh=L2b6ovufuyOt5g32IaXTrP6gxb4p0lvhYk/QMzL7CJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D34ygwUkaO6WppRI8fXcJ3A6BLaqCr0fNnDObMD8fJrTRPxTM7uWoU8ibS7b48U6h
	 QoMwQvDWY8pG7VgK1eTSn6R/AjU54XduoGsAnBLwX11YIroehRNgdl3jNE1jZu+gzr
	 fkm35KnnUiLtpAH2DYW3mt1t5EQg6f8EJkjQy+wZHrhwbXYEremTOlk/YdJJWy7tAq
	 RoQLFjUwt3P2iGp5QLOKVwNsAPliSgfqaE015PrF1GD8ye19//iE/3DP4qom4JLWir
	 sXB1McFrxuaPiaHkEtWoXPHDtF6v6s4QLPJuinyg1qXN3XdzLE2n106PGDu3TUgEaf
	 qQluzMKzcqB6Q==
Date: Fri, 14 Nov 2025 10:36:33 +0000
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: namcao@linutronix.de, vadim.fedorenko@linux.dev,
	jacob.e.keller@intel.com, christian.koenig@amd.com,
	sumit.semwal@linaro.org, sdf@fomichev.me, john.fastabend@gmail.com,
	hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net-next v5 1/6] net: ti: icssg-prueth: Add functions to
 create and destroy Rx/Tx queues
Message-ID: <aRcGMTRzDFwe23NV@horms.kernel.org>
References: <20251111101523.3160680-1-m-malladi@ti.com>
 <20251111101523.3160680-2-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111101523.3160680-2-m-malladi@ti.com>

On Tue, Nov 11, 2025 at 03:45:18PM +0530, Meghana Malladi wrote:

...

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 57a7d1ceab08..b66ffbfb499c 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -735,6 +735,114 @@ static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
>  	return 0;
>  }
>  
> +static void prueth_destroy_txq(struct prueth_emac *emac)
> +{
> +	int ret, i;
> +
> +	atomic_set(&emac->tdown_cnt, emac->tx_ch_num);
> +	/* ensure new tdown_cnt value is visible */
> +	smp_mb__after_atomic();
> +	/* tear down and disable UDMA channels */
> +	reinit_completion(&emac->tdown_complete);
> +	for (i = 0; i < emac->tx_ch_num; i++)
> +		k3_udma_glue_tdown_tx_chn(emac->tx_chns[i].tx_chn, false);
> +
> +	ret = wait_for_completion_timeout(&emac->tdown_complete,
> +					  msecs_to_jiffies(1000));
> +	if (!ret)
> +		netdev_err(emac->ndev, "tx teardown timeout\n");
> +
> +	for (i = 0; i < emac->tx_ch_num; i++) {
> +		napi_disable(&emac->tx_chns[i].napi_tx);
> +		hrtimer_cancel(&emac->tx_chns[i].tx_hrtimer);
> +		k3_udma_glue_reset_tx_chn(emac->tx_chns[i].tx_chn,
> +					  &emac->tx_chns[i],
> +					  prueth_tx_cleanup);
> +		k3_udma_glue_disable_tx_chn(emac->tx_chns[i].tx_chn);
> +	}
> +}
> +
> +static void prueth_destroy_rxq(struct prueth_emac *emac)
> +{
> +	int i, ret;
> +
> +	/* tear down and disable UDMA channels */
> +	reinit_completion(&emac->tdown_complete);
> +	k3_udma_glue_tdown_rx_chn(emac->rx_chns.rx_chn, true);
> +
> +	/* When RX DMA Channel Teardown is initiated, it will result in an
> +	 * interrupt and a Teardown Completion Marker (TDCM) is queued into
> +	 * the RX Completion queue. Acknowledging the interrupt involves
> +	 * popping the TDCM descriptor from the RX Completion queue via the
> +	 * RX NAPI Handler. To avoid timing out when waiting for the TDCM to
> +	 * be popped, schedule the RX NAPI handler to run immediately.
> +	 */
> +	if (!napi_if_scheduled_mark_missed(&emac->napi_rx)) {
> +		if (napi_schedule_prep(&emac->napi_rx))
> +			__napi_schedule(&emac->napi_rx);
> +	}
> +
> +	ret = wait_for_completion_timeout(&emac->tdown_complete,
> +					  msecs_to_jiffies(1000));
> +	if (!ret)
> +		netdev_err(emac->ndev, "rx teardown timeout\n");
> +
> +	for (i = 0; i < PRUETH_MAX_RX_FLOWS; i++) {
> +		napi_disable(&emac->napi_rx);
> +		hrtimer_cancel(&emac->rx_hrtimer);

Hi Meghana,

Is it intentional that the napi_disable() and hrtimer_cancel()
are made once for each (possible) flow, rather than just once
as was the case before this patch?

Maybe the tx code, which does the same, was used as a template here
in error?

Flagged by Claude Code with https://github.com/masoncl/review-prompts/

> +		k3_udma_glue_reset_rx_chn(emac->rx_chns.rx_chn, i,
> +					  &emac->rx_chns,
> +					  prueth_rx_cleanup);
> +	}
> +
> +	prueth_destroy_xdp_rxqs(emac);
> +	k3_udma_glue_disable_rx_chn(emac->rx_chns.rx_chn);
> +}

...

> @@ -905,32 +988,8 @@ static int emac_ndo_stop(struct net_device *ndev)
>  	else
>  		__dev_mc_unsync(ndev, icssg_prueth_del_mcast);
>  
> -	atomic_set(&emac->tdown_cnt, emac->tx_ch_num);
> -	/* ensure new tdown_cnt value is visible */
> -	smp_mb__after_atomic();
> -	/* tear down and disable UDMA channels */
> -	reinit_completion(&emac->tdown_complete);
> -	for (i = 0; i < emac->tx_ch_num; i++)
> -		k3_udma_glue_tdown_tx_chn(emac->tx_chns[i].tx_chn, false);
> -
> -	ret = wait_for_completion_timeout(&emac->tdown_complete,
> -					  msecs_to_jiffies(1000));
> -	if (!ret)
> -		netdev_err(ndev, "tx teardown timeout\n");
> -
> -	prueth_reset_tx_chan(emac, emac->tx_ch_num, true);
> -	for (i = 0; i < emac->tx_ch_num; i++) {
> -		napi_disable(&emac->tx_chns[i].napi_tx);
> -		hrtimer_cancel(&emac->tx_chns[i].tx_hrtimer);
> -	}
> -
> -	max_rx_flows = PRUETH_MAX_RX_FLOWS;
> -	k3_udma_glue_tdown_rx_chn(emac->rx_chns.rx_chn, true);
> -
> -	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, true);
> -	prueth_destroy_xdp_rxqs(emac);
> -	napi_disable(&emac->napi_rx);
> -	hrtimer_cancel(&emac->rx_hrtimer);
> +	prueth_destroy_txq(emac);
> +	prueth_destroy_rxq(emac);
>  
>  	cancel_work_sync(&emac->rx_mode_work);
>  
> @@ -943,10 +1002,10 @@ static int emac_ndo_stop(struct net_device *ndev)
>  
>  	free_irq(emac->tx_ts_irq, emac);
>  
> -	free_irq(emac->rx_chns.irq[rx_flow], emac);
> +	free_irq(emac->rx_chns.irq[PRUETH_RX_FLOW_DATA], emac);
>  	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
>  
> -	prueth_cleanup_rx_chns(emac, &emac->rx_chns, max_rx_flows);
> +	prueth_cleanup_rx_chns(emac, &emac->rx_chns, PRUETH_MAX_RX_FLOWS);
>  	prueth_cleanup_tx_chns(emac);
>  
>  	prueth->emacs_initialized--;

...

