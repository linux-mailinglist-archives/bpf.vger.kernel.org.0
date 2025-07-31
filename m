Return-Path: <bpf+bounces-64810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB86B17226
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 15:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BCD1C210F9
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 13:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAA52C3761;
	Thu, 31 Jul 2025 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9cu3POg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5652C08C5;
	Thu, 31 Jul 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968963; cv=none; b=WE4dxLp9ER6YKKurneIocbXEs6A9RvJimaC3ZnlAxIWUEWgX8gU8SfagredxFq+5s7ao+CrwwLTIJ44kiUt2pIuo7QeGtNdaJ9IDRbStR8TgYy336VoBNMoi1ioFMV7BIue5/kmxYCiKA70rlOFI28Lsz08GIo5BRL57xsbyUlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968963; c=relaxed/simple;
	bh=KyS0YK7eZU4aWlqqSlmnifoI1DVY+qASIuVMpm0Wk8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF5HA9YxFbU19V9mtbzqOG9NlqtfDq7SJxFF8WzGL+uZv63KcLpKbv4c1whgG3g7muQpMWUPi3r9qEqEKjZs1kVI8jOSYRRDeDMAmu3KiygrZne3/1fmVFySb8WOoagNBCJHS4AjHQzIRRp/NT13tDtxiWNsfY0YHIRNZHygew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9cu3POg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8990CC4CEF7;
	Thu, 31 Jul 2025 13:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753968962;
	bh=KyS0YK7eZU4aWlqqSlmnifoI1DVY+qASIuVMpm0Wk8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9cu3POghgzQfUtBUIplaBzrzNwhGOc6oVLq0yV0K73DS8+xpLh1WGipIheNSEisW
	 gtaZXhKmUx1YU/UAxlykG793eGPQ6+biMr8w3ElbP2um4WUO7y6muSOoXlPRcn8wfb
	 PI7fVO5IDluDRqPdQ/jlzm1w3KfxU3j9hn3VMJKjT0es0CxNOfPWUv+oVss251A/f7
	 vTbIuWvqZ0HtEX2T1K6KURzm9/r8ZG+Vj+4oU5X+92zc3DMJVV1sKsX7drkww4jNZP
	 /aVpVdG1J0jG9ETgKRb07YclTpS6VYcnBBD+Tl/UVaE8rmnLF3SkZ7INeLcmoJoz38
	 IbQmg5FEdwA8g==
Date: Thu, 31 Jul 2025 14:35:57 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	nxne.cnse.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 16/18] idpf: add support for XDP on Rx
Message-ID: <20250731133557.GB8494@horms.kernel.org>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
 <20250730160717.28976-17-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730160717.28976-17-aleksander.lobakin@intel.com>

On Wed, Jul 30, 2025 at 06:07:15PM +0200, Alexander Lobakin wrote:
> Use libeth XDP infra to support running XDP program on Rx polling.
> This includes all of the possible verdicts/actions.
> XDP Tx queues are cleaned only in "lazy" mode when there are less than
> 1/4 free descriptors left on the ring. libeth helper macros to define
> driver-specific XDP functions make sure the compiler could uninline
> them when needed.
> Use __LIBETH_WORD_ACCESS to parse descriptors more efficiently when
> applicable. It really gives some good boosts and code size reduction
> on x86_64.
> 
> Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c

...

> @@ -3127,14 +3125,12 @@ static bool idpf_rx_process_skb_fields(struct sk_buff *skb,
>  	return !__idpf_rx_process_skb_fields(rxq, skb, xdp->desc);
>  }
>  
> -static void
> -idpf_xdp_run_pass(struct libeth_xdp_buff *xdp, struct napi_struct *napi,
> -		  struct libeth_rq_napi_stats *ss,
> -		  const struct virtchnl2_rx_flex_desc_adv_nic_3 *desc)
> -{
> -	libeth_xdp_run_pass(xdp, NULL, napi, ss, desc, NULL,
> -			    idpf_rx_process_skb_fields);
> -}
> +LIBETH_XDP_DEFINE_START();
> +LIBETH_XDP_DEFINE_RUN(static idpf_xdp_run_pass, idpf_xdp_run_prog,
> +		      idpf_xdp_tx_flush_bulk, idpf_rx_process_skb_fields);
> +LIBETH_XDP_DEFINE_FINALIZE(static idpf_xdp_finalize_rx, idpf_xdp_tx_flush_bulk,
> +			   idpf_xdp_tx_finalize);
> +LIBETH_XDP_DEFINE_END();
>  
>  /**
>   * idpf_rx_hsplit_wa - handle header buffer overflows and split errors
> @@ -3222,7 +3218,10 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
>  	struct libeth_rq_napi_stats rs = { };
>  	u16 ntc = rxq->next_to_clean;
>  	LIBETH_XDP_ONSTACK_BUFF(xdp);
> +	LIBETH_XDP_ONSTACK_BULK(bq);
>  
> +	libeth_xdp_tx_init_bulk(&bq, rxq->xdp_prog, rxq->xdp_rxq.dev,
> +				rxq->xdpsqs, rxq->num_xdp_txq);
>  	libeth_xdp_init_buff(xdp, &rxq->xdp, &rxq->xdp_rxq);
>  
>  	/* Process Rx packets bounded by budget */
> @@ -3318,11 +3317,13 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
>  		if (!idpf_rx_splitq_is_eop(rx_desc) || unlikely(!xdp->data))
>  			continue;
>  
> -		idpf_xdp_run_pass(xdp, rxq->napi, &rs, rx_desc);
> +		idpf_xdp_run_pass(xdp, &bq, rxq->napi, &rs, rx_desc);
>  	}
>  
>  	rxq->next_to_clean = ntc;
> +
>  	libeth_xdp_save_buff(&rxq->xdp, xdp);
> +	idpf_xdp_finalize_rx(&bq);

This will call __libeth_xdp_finalize_rx(), which calls rcu_read_unlock().
But there doesn't seem to be a corresponding call to rcu_read_lock()

Flagged by Sparse.

>  
>  	u64_stats_update_begin(&rxq->stats_sync);
>  	u64_stats_add(&rxq->q_stats.packets, rs.packets);

...

