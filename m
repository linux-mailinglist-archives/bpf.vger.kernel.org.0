Return-Path: <bpf+bounces-9730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF2C79C933
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 10:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE0A1C20AA4
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69B31773E;
	Tue, 12 Sep 2023 08:03:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99215495;
	Tue, 12 Sep 2023 08:03:55 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE384233;
	Tue, 12 Sep 2023 01:03:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-403004a96eeso32658565e9.3;
        Tue, 12 Sep 2023 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694505833; x=1695110633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohrhB31lcouNPBWbsQGLt92x/wlj/9DWwrV8TcTP59k=;
        b=X1AZStXZ5d9CVOjyUp/7csHPzip7tfmPErQzDdX6Yh/UF8oYXuXi4klfXKbTEpvwx2
         Nd2RhcDClIzx7TOciaGya6s2np1g0kIYHvFgujfxPRcojUUREmZ+hbGn9h7cMdjBWPiS
         cGs745gCQS1NesG/8nN4sP2ft8ymBX/OXxk4xj5uM75xt9tVAUvV1dwnTdz4F1fSkdAf
         e0eL7yAYOKpo7ESClcXGdqbM+5WQMVBw+2Jj7IBoqg8R+E4TwXImYVSRqgixaQtDUXxT
         4ru6pXv4K3H3FIDhQecHq+iV5z2QD2HIozSukZrI8I6KPiSJ7109AxvOXlm46S9Oj/ZS
         c3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694505833; x=1695110633;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohrhB31lcouNPBWbsQGLt92x/wlj/9DWwrV8TcTP59k=;
        b=a4y/B5g7Z/WWNsg05KmmYJQkdSSBmJpjBoBGw0jo9VNUWynt6weto1Zm8HBBcp00rA
         gIqkGfL9rQ722Lu49lDH9SNyqXI3SZuW/HZRI/2O0hEMhBpD3Eyp4hmWZnp6JbdipLG7
         GtgPRQJzkCAbeyoEfx4KoisXk4I3rVR81DqBr8x+lmwKEcrKLTGJwtdqsJjTsdqFSg2Z
         ctpoBXrNHZLWT4q1eDMBShXuL0AwPy/9V9wX/fKZA80hVFH12yGQnDlGzfO/2SpZK1DT
         1yyfMYM3GhmDCVGmSTi69ckYMob9a2CFnts2VfhLNQMQ23RAtU/FcvfECglB2kPPKOCK
         60fw==
X-Gm-Message-State: AOJu0Yx86q3AhFPMIb9jRE+uQy/yQKcjk+P+GVuG59cyxU5zIw33Xx//
	2xX0QRoGtDDERPzw4BzEuS0=
X-Google-Smtp-Source: AGHT+IGp56ciJG4tM76LLF3DMfZ2J35G3pxesUPTwNs3LbxC0Fp5gcSKaeGk8wFkTR2052ujgdVT9Q==
X-Received: by 2002:a5d:6a03:0:b0:314:1e47:8bc2 with SMTP id m3-20020a5d6a03000000b003141e478bc2mr9459086wru.0.1694505832508;
        Tue, 12 Sep 2023 01:03:52 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id y18-20020adfd092000000b003179d5aee67sm12202301wrh.94.2023.09.12.01.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:03:52 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:03:51 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	David Arinzon <darinzon@amazon.com>,
	Edward Cree <ecree.xilinx@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	John Crispin <john@phrozen.org>, Leon Romanovsky <leon@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Louis Peens <louis.peens@corigine.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Noam Dagan <ndagan@amazon.com>,
	Russell King <linux@armlinux.org.uk>,
	Saeed Bishara <saeedb@amazon.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next 1/2] net: Tree wide: Replace xdp_do_flush_map()
 with xdp_do_flush().
Message-ID: <20230912080351.GA99658@gmail.com>
Mail-Followup-To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	David Arinzon <darinzon@amazon.com>,
	Edward Cree <ecree.xilinx@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	John Crispin <john@phrozen.org>, Leon Romanovsky <leon@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Louis Peens <louis.peens@corigine.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Noam Dagan <ndagan@amazon.com>,
	Russell King <linux@armlinux.org.uk>,
	Saeed Bishara <saeedb@amazon.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>
References: <20230908143215.869913-1-bigeasy@linutronix.de>
 <20230908143215.869913-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908143215.869913-2-bigeasy@linutronix.de>

On Fri, Sep 08, 2023 at 04:32:14PM +0200, Sebastian Andrzej Siewior wrote:
> xdp_do_flush_map() is deprecated and new code should use xdp_do_flush()
> instead.
> 
> Replace xdp_do_flush_map() with xdp_do_flush().
> 
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Arthur Kiyanovski <akiyano@amazon.com>
> Cc: Clark Wang <xiaoning.wang@nxp.com>
> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: David Arinzon <darinzon@amazon.com>
> Cc: Edward Cree <ecree.xilinx@gmail.com>
> Cc: Felix Fietkau <nbd@nbd.name>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: Louis Peens <louis.peens@corigine.com>
> Cc: Marcin Wojtas <mw@semihalf.com>
> Cc: Mark Lee <Mark-MC.Lee@mediatek.com>
> Cc: Martin Habets <habetsm.xilinx@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Noam Dagan <ndagan@amazon.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Saeed Bishara <saeedb@amazon.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: Shay Agroskin <shayagr@amazon.com>
> Cc: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

For sfc drivers:
Acked-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c     | 2 +-
>  drivers/net/ethernet/freescale/enetc/enetc.c     | 2 +-
>  drivers/net/ethernet/freescale/fec_main.c        | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c      | 2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c    | 2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c     | 2 +-
>  drivers/net/ethernet/marvell/mvneta.c            | 2 +-
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c  | 2 +-
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c      | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 2 +-
>  drivers/net/ethernet/netronome/nfp/nfd3/xsk.c    | 2 +-
>  drivers/net/ethernet/sfc/efx_channels.c          | 2 +-
>  drivers/net/ethernet/sfc/siena/efx_channels.c    | 2 +-
>  drivers/net/ethernet/socionext/netsec.c          | 2 +-
>  drivers/net/ethernet/ti/cpsw_priv.c              | 2 +-
>  16 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index ad32ca81f7ef4..69bc8dfa7d71b 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -1828,7 +1828,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
>  	}
>  
>  	if (xdp_flags & ENA_XDP_REDIRECT)
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  
>  	return work_done;
>  
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 35461165de0d2..30bec47bc665b 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1655,7 +1655,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
>  	rx_ring->stats.bytes += rx_byte_cnt;
>  
>  	if (xdp_redirect_frm_cnt)
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  
>  	if (xdp_tx_frm_cnt)
>  		enetc_update_tx_ring_tail(tx_ring);
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 77c8e9cfb4456..b833467088811 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1832,7 +1832,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
>  	rxq->bd.cur = bdp;
>  
>  	if (xdp_result & FEC_ENET_XDP_REDIR)
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  
>  	return pkt_received;
>  }
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 0b3a27f118fb9..d680df615ff95 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2405,7 +2405,7 @@ void i40e_update_rx_stats(struct i40e_ring *rx_ring,
>  void i40e_finalize_xdp_rx(struct i40e_ring *rx_ring, unsigned int xdp_res)
>  {
>  	if (xdp_res & I40E_XDP_REDIR)
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  
>  	if (xdp_res & I40E_XDP_TX) {
>  		struct i40e_ring *xdp_ring =
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index c8322fb6f2b37..7e06373e14d98 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -450,7 +450,7 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
>  	struct ice_tx_buf *tx_buf = &xdp_ring->tx_buf[first_idx];
>  
>  	if (xdp_res & ICE_XDP_REDIR)
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  
>  	if (xdp_res & ICE_XDP_TX) {
>  		if (static_branch_unlikely(&ice_xdp_locking_key))
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index dd03b017dfc51..94bde2cad0f47 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2421,7 +2421,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>  	}
>  
>  	if (xdp_xmit & IXGBE_XDP_REDIR)
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  
>  	if (xdp_xmit & IXGBE_XDP_TX) {
>  		struct ixgbe_ring *ring = ixgbe_determine_xdp_ring(adapter);
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index 1703c640a434d..59798bc33298f 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -351,7 +351,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
>  	}
>  
>  	if (xdp_xmit & IXGBE_XDP_REDIR)
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  
>  	if (xdp_xmit & IXGBE_XDP_TX) {
>  		struct ixgbe_ring *ring = ixgbe_determine_xdp_ring(adapter);
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index d483b8c00ec0e..7b2aa30de8222 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -2520,7 +2520,7 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
>  		mvneta_xdp_put_buff(pp, rxq, &xdp_buf, -1);
>  
>  	if (ps.xdp_redirect)
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  
>  	if (ps.rx_packets)
>  		mvneta_update_stats(pp, &ps);
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index eb74ccddb4409..60c53f66935a6 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -4027,7 +4027,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
>  	}
>  
>  	if (xdp_ret & MVPP2_XDP_REDIR)
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  
>  	if (ps.rx_packets) {
>  		struct mvpp2_pcpu_stats *stats = this_cpu_ptr(port->stats);
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 6ad42e3b488f7..0b8ee35d713d1 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -2209,7 +2209,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  	net_dim(&eth->rx_dim, dim_sample);
>  
>  	if (xdp_flush)
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  
>  	return done;
>  }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 12f56d0db0af2..cc3fcd24b36d6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -893,7 +893,7 @@ void mlx5e_xdp_rx_poll_complete(struct mlx5e_rq *rq)
>  	mlx5e_xmit_xdp_doorbell(xdpsq);
>  
>  	if (test_bit(MLX5E_RQ_FLAG_XDP_REDIRECT, rq->flags)) {
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  		__clear_bit(MLX5E_RQ_FLAG_XDP_REDIRECT, rq->flags);
>  	}
>  }
> diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c b/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c
> index 5d9db8c2a5b43..45be6954d5aae 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfd3/xsk.c
> @@ -256,7 +256,7 @@ nfp_nfd3_xsk_rx(struct nfp_net_rx_ring *rx_ring, int budget,
>  	nfp_net_xsk_rx_ring_fill_freelist(r_vec->rx_ring);
>  
>  	if (xdp_redir)
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  
>  	if (tx_ring->wr_ptr_add)
>  		nfp_net_tx_xmit_more_flush(tx_ring);
> diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
> index 8d2d7ea2ebefc..c9e17a8208a90 100644
> --- a/drivers/net/ethernet/sfc/efx_channels.c
> +++ b/drivers/net/ethernet/sfc/efx_channels.c
> @@ -1260,7 +1260,7 @@ static int efx_poll(struct napi_struct *napi, int budget)
>  
>  	spent = efx_process_channel(channel, budget);
>  
> -	xdp_do_flush_map();
> +	xdp_do_flush();
>  
>  	if (spent < budget) {
>  		if (efx_channel_has_rx_queue(channel) &&
> diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
> index 1776f7f8a7a90..a7346e965bfe7 100644
> --- a/drivers/net/ethernet/sfc/siena/efx_channels.c
> +++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
> @@ -1285,7 +1285,7 @@ static int efx_poll(struct napi_struct *napi, int budget)
>  
>  	spent = efx_process_channel(channel, budget);
>  
> -	xdp_do_flush_map();
> +	xdp_do_flush();
>  
>  	if (spent < budget) {
>  		if (efx_channel_has_rx_queue(channel) &&
> diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
> index f358ea0031936..b834b129639f0 100644
> --- a/drivers/net/ethernet/socionext/netsec.c
> +++ b/drivers/net/ethernet/socionext/netsec.c
> @@ -780,7 +780,7 @@ static void netsec_finalize_xdp_rx(struct netsec_priv *priv, u32 xdp_res,
>  				   u16 pkts)
>  {
>  	if (xdp_res & NETSEC_XDP_REDIR)
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  
>  	if (xdp_res & NETSEC_XDP_TX)
>  		netsec_xdp_ring_tx_db(priv, pkts);
> diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
> index 0ec85635dfd60..764ed298b5708 100644
> --- a/drivers/net/ethernet/ti/cpsw_priv.c
> +++ b/drivers/net/ethernet/ti/cpsw_priv.c
> @@ -1360,7 +1360,7 @@ int cpsw_run_xdp(struct cpsw_priv *priv, int ch, struct xdp_buff *xdp,
>  		 *  particular hardware is sharing a common queue, so the
>  		 *  incoming device might change per packet.
>  		 */
> -		xdp_do_flush_map();
> +		xdp_do_flush();
>  		break;
>  	default:
>  		bpf_warn_invalid_xdp_action(ndev, prog, act);
> -- 
> 2.40.1
> 

