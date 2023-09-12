Return-Path: <bpf+bounces-9740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1AB79CE30
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 12:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576361C20A67
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE48D179A7;
	Tue, 12 Sep 2023 10:25:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F317993;
	Tue, 12 Sep 2023 10:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB74C433C8;
	Tue, 12 Sep 2023 10:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694514314;
	bh=l8TYq2vvs2AJoO+xBUEw8Ne1rI7EQ4kmhcp+8GQQDrI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=nUMSlsi4OAPPwuvoT19S1yJzgl1+ANn8ra7jcRDMrFD9ByMDQYx1x7cREZMMhQArQ
	 cMb0T8uaae3mn9zOjzWghgHyh/jR35YKePAbRcKjGeC7e+ug278z4VhJPAO3J1KLmX
	 YO/FIvbbySG06BMW5nWGSEIplu0GlxIOjqew7kaLrWYO9Zd5QNEjOIpH1dza+MNieP
	 TVPtES/pe5jh3wFnaOUrgSwMZp9y4SVmfnyHEMOf3ixYSjEHnVW/u9ifRNFMQN26KN
	 QGyweDDCb8ORAAWScx2yacHVwzRRrCegJTZ/eo9lZt0dkAtXqDrP6VBRW0Y7IiFG/B
	 3is++u95za89A==
Message-ID: <b5aab947-3066-dc3a-5ae7-a594fa96f72c@kernel.org>
Date: Tue, 12 Sep 2023 12:25:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: "David S. Miller" <davem@davemloft.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Arthur Kiyanovski <akiyano@amazon.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, David Arinzon
 <darinzon@amazon.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Felix Fietkau <nbd@nbd.name>, Grygorii Strashko <grygorii.strashko@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 John Crispin <john@phrozen.org>, Leon Romanovsky <leon@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Louis Peens
 <louis.peens@corigine.com>, Marcin Wojtas <mw@semihalf.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Martin Habets
 <habetsm.xilinx@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 NXP Linux Team <linux-imx@nxp.com>, Noam Dagan <ndagan@amazon.com>,
 Russell King <linux@armlinux.org.uk>, Saeed Bishara <saeedb@amazon.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Sean Wang <sean.wang@mediatek.com>,
 Shay Agroskin <shayagr@amazon.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next 1/2] net: Tree wide: Replace xdp_do_flush_map()
 with xdp_do_flush().
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230908143215.869913-1-bigeasy@linutronix.de>
 <20230908143215.869913-2-bigeasy@linutronix.de>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230908143215.869913-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/09/2023 16.32, Sebastian Andrzej Siewior wrote:
> xdp_do_flush_map() is deprecated and new code should use xdp_do_flush()
> instead.
> 
> Replace xdp_do_flush_map() with xdp_do_flush().
> 
[...]
> Signed-off-by: Sebastian Andrzej Siewior<bigeasy@linutronix.de>
> ---
>   drivers/net/ethernet/amazon/ena/ena_netdev.c     | 2 +-
>   drivers/net/ethernet/freescale/enetc/enetc.c     | 2 +-
>   drivers/net/ethernet/freescale/fec_main.c        | 2 +-
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c      | 2 +-
>   drivers/net/ethernet/intel/ice/ice_txrx_lib.c    | 2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c     | 2 +-
>   drivers/net/ethernet/marvell/mvneta.c            | 2 +-
>   drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c  | 2 +-
>   drivers/net/ethernet/mediatek/mtk_eth_soc.c      | 2 +-
>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 2 +-
>   drivers/net/ethernet/netronome/nfp/nfd3/xsk.c    | 2 +-
>   drivers/net/ethernet/sfc/efx_channels.c          | 2 +-
>   drivers/net/ethernet/sfc/siena/efx_channels.c    | 2 +-
>   drivers/net/ethernet/socionext/netsec.c          | 2 +-
>   drivers/net/ethernet/ti/cpsw_priv.c              | 2 +-
>   16 files changed, 16 insertions(+), 16 deletions(-)

Happy to see this cleanup across all drivers.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

