Return-Path: <bpf+bounces-4083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84757748A72
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 19:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AD11C20B7D
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B57134C3;
	Wed,  5 Jul 2023 17:31:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CB19470
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 17:31:37 +0000 (UTC)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BC41BE2
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 10:31:05 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-26314c2bdb8so6879055a91.1
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688578258; x=1691170258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3/LAZvr0UP5J3UHYYhwEfc8xW0A3nIvJLVo9APvzt8=;
        b=pRFit9QJQLe1lIimcB8GFO/E7cene91cnurVg1RRGKojDlmUbJnosXt+UZsopKtYVC
         sPakpd5iP364qy4FRCvkJYL95YwNyyUtMxlyj4qQJifGakunvCa1QkQOzPh+f96Yb9eP
         E+Op0WNqkLJPIg2wjCvJpUR3EYMeEfzmTwlBACUpM6IqEw/zADR13yzFQ83qaYQmJCMl
         JKTFVcHZ9Ckpw5V9+FbaOZ0NxF/YqfkeDch/zIN9W/zapNSmStM1jF0VLtrlMK2/yZT7
         H8RzaK5rVsQ41msV8Hbsnd+lXysC2nhmD5Z1jiV8+9hOLtCBfnu6Lr/L/55b+CQYnRu8
         ewNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688578258; x=1691170258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3/LAZvr0UP5J3UHYYhwEfc8xW0A3nIvJLVo9APvzt8=;
        b=GNeU+X/+FUoEBXXGLiDCd0Cq2iJ9bu77KrKSlSpXs5/6PophTIWCjyF+sorlahP2Du
         hYcroV6xhqKYVqO78Fs7+PLQfjuzaMEVVGwbrzpcaNyeptnrRU406PWiv2+3oPdBdyW4
         XFFUjHgdlRyfxQdDPgmAVcwzyPByk8hXUmMfUWzdkZq33GOFtbFe1+/dcfZ0/whl23Gu
         3+lbO81QbExKvlwJNvWTTG9Bfj17pK0YRsUAbfy0klMi9AoXgB+YHbOLMewvZR0yva/N
         BEqz9/gcEa17FpSfYRdE8M4h9D/cbju+mWTUTe+VDzKYZF4idKtCzlsTJeuoNzRd+Vf+
         zdag==
X-Gm-Message-State: ABy/qLYpHd6Kvox+zmVOZLW66DFxT2vyZZrSChY+9kCPPZX6VKE2Cb7n
	lv1Q/8BslyG/9FKpoMIbdLYbzyM=
X-Google-Smtp-Source: APBJJlHDbI3TnMQawz+HxE4Zfg02tczSUStWMcPVjMhQSpVKuHXHQswSC3+jQ05SdtAHKsxGhdzRTUU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:bc97:b0:262:d9c1:dc02 with SMTP id
 x23-20020a17090abc9700b00262d9c1dc02mr11834868pjr.1.1688578257937; Wed, 05
 Jul 2023 10:30:57 -0700 (PDT)
Date: Wed, 5 Jul 2023 10:30:56 -0700
In-Reply-To: <20230703181226.19380-7-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230703181226.19380-1-larysa.zaremba@intel.com> <20230703181226.19380-7-larysa.zaremba@intel.com>
Message-ID: <ZKWo0BbpLfkZHbyE@google.com>
Subject: Re: [PATCH bpf-next v2 06/20] ice: Support HW timestamp hint
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/03, Larysa Zaremba wrote:
> Use previously refactored code and create a function
> that allows XDP code to read HW timestamp.
> 
> Also, move cached_phctime into packet context, this way this data still
> stays in the ring structure, just at the different address.
> 
> HW timestamp is the first supported hint in the driver,
> so also add xdp_metadata_ops.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  2 ++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  1 +
>  drivers/net/ethernet/intel/ice/ice_ptp.c      |  2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 24 +++++++++++++++++++
>  7 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 4ba3d99439a0..7a973a2229f1 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -943,4 +943,6 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
>  	set_bit(ICE_FLAG_UNPLUG_AUX_DEV, pf->flags);
>  	clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
>  }
> +
> +extern const struct xdp_metadata_ops ice_xdp_md_ops;
>  #endif /* _ICE_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index 8d5cbbd0b3d5..3c3b9cbfbcd3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -2837,7 +2837,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>  		/* clone ring and setup updated count */
>  		rx_rings[i] = *vsi->rx_rings[i];
>  		rx_rings[i].count = new_rx_cnt;
> -		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
> +		rx_rings[i].pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
>  		rx_rings[i].desc = NULL;
>  		rx_rings[i].rx_buf = NULL;
>  		/* this is to allow wr32 to have something to write to
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 00e3afd507a4..eb69b0ac7956 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1445,7 +1445,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
>  		ring->netdev = vsi->netdev;
>  		ring->dev = dev;
>  		ring->count = vsi->num_rx_desc;
> -		ring->cached_phctime = pf->ptp.cached_phc_time;
> +		ring->pkt_ctx.cached_phctime = pf->ptp.cached_phc_time;
>  		WRITE_ONCE(vsi->rx_rings[i], ring);
>  	}
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 93979ab18bc1..f21996b812ea 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3384,6 +3384,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
>  
>  	netdev->netdev_ops = &ice_netdev_ops;
>  	netdev->udp_tunnel_nic_info = &pf->hw.udp_tunnel_nic;
> +	netdev->xdp_metadata_ops = &ice_xdp_md_ops;
>  	ice_set_ethtool_ops(netdev);
>  
>  	if (vsi->type != ICE_VSI_PF)
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index a31333972c68..70697e4829dd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1038,7 +1038,7 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
>  		ice_for_each_rxq(vsi, j) {
>  			if (!vsi->rx_rings[j])
>  				continue;
> -			WRITE_ONCE(vsi->rx_rings[j]->cached_phctime, systime);
> +			WRITE_ONCE(vsi->rx_rings[j]->pkt_ctx.cached_phctime, systime);
>  		}
>  	}
>  	clear_bit(ICE_CFG_BUSY, pf->state);
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index d0ab2c4c0c91..4237702a58a9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -259,6 +259,7 @@ enum ice_rx_dtype {
>  
>  struct ice_pkt_ctx {
>  	const union ice_32b_rx_flex_desc *eop_desc;
> +	u64 cached_phctime;
>  };
>  
>  struct ice_xdp_buff {
> @@ -354,7 +355,6 @@ struct ice_rx_ring {
>  	struct ice_tx_ring *xdp_ring;
>  	struct xsk_buff_pool *xsk_pool;
>  	dma_addr_t dma;			/* physical address of ring */
> -	u64 cached_phctime;
>  	u16 rx_buf_len;
>  	u8 dcb_tc;			/* Traffic class of ring */
>  	u8 ptp_rx;
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index beb1c5bb392a..463d9e5cbe05 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -546,3 +546,27 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
>  			spin_unlock(&xdp_ring->tx_lock);
>  	}
>  }
> +
> +/**
> + * ice_xdp_rx_hw_ts - HW timestamp XDP hint handler
> + * @ctx: XDP buff pointer
> + * @ts_ns: destination address
> + *
> + * Copy HW timestamp (if available) to the destination address.
> + */
> +static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
> +{
> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> +	u64 cached_time;
> +
> +	cached_time = READ_ONCE(xdp_ext->pkt_ctx.cached_phctime);

I believe we have to have something like the following here:

if (!ts_ns)
	return -EINVAL;

IOW, I don't think verifier guarantees that those pointer args are
non-NULL. Same for the other ice kfunc you're adding and veth changes.

Can you also fix it for the existing veth kfuncs? (or lmk if you prefer me
to fix it).

