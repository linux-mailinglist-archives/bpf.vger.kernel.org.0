Return-Path: <bpf+bounces-57192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD60AA6B6A
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 09:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B784A31FD
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 07:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4528E267721;
	Fri,  2 May 2025 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/semb5n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ADE266B5E;
	Fri,  2 May 2025 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746170091; cv=none; b=HVU2pvlH/8GuJJ+4skdmjQYJzmrgDAJnqT4E9KsTcGaQqRx4jE7vKcGT8v9XxBaFaIr5lQv2Z0AJ6+83dGNWR+tlvKrfaMuD6eE4qp4XMFgIYugh1CtiTbyLtlcPYlBoax7l8ni3+2ibBz8VdkDCXrsqA4pLFidDqtg+0NCogyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746170091; c=relaxed/simple;
	bh=WZMcB7IZq0pU+GD0KzLwmI2O89KEodLSHYG0SH/X1LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8Pvsibq7iwjUxcT2wThWUoWbSl2aKoAUz55i7Jodo2ICQ51MaYtbNRd3d/TfOEdRsHOAEiTlM2mTdsPBWpYyW0KinhiCX1Dpaii4ULNhh0PZV/jvUE63MRm5CoANdSnNelkF6ezObyOUj2Jdz/hFeVbUKAWn8Lop3OWm21JH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/semb5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBAEC4CEE4;
	Fri,  2 May 2025 07:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746170091;
	bh=WZMcB7IZq0pU+GD0KzLwmI2O89KEodLSHYG0SH/X1LM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j/semb5nvJ6TikEwk5ZY1owF/dZjIMrvygoezgB9u7bzZXekMwUoqoggKKOQgI/bu
	 DUVl5qePcZlEicoD9cB/dvNIjdCqyLVRemKoT1aBQcJNnUa4LoiQ2PXvJdkWWJU2zm
	 Pg5oL1EcR3IxkOBLXYcKNwA5kWjRByIrtZvc2R9XQBHHm5B+YO/IGncBcHQpGH0Mta
	 Ezz05Us9N3jjNpxOOS+WnNh/Xsd1K6Fft+DCCZpMQ5WZcfu053MYlSV0hUjjtL3ZMw
	 ZoAgIduZ/aHhadHxsl20vpetMgE9EpymkQBLwHBQEyj3lw35ZN4jfNdAxNU84E0z1T
	 92/L2POJBmvgg==
Message-ID: <074a9a19-9050-44dd-a0bf-536ae8318da2@kernel.org>
Date: Fri, 2 May 2025 09:14:43 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] net: ti: icssg-prueth: Fix kernel panic during
 concurrent Tx queue access
To: Meghana Malladi <m-malladi@ti.com>, dan.carpenter@linaro.org,
 john.fastabend@gmail.com, daniel@iogearbox.net, ast@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 danishanwar@ti.com
References: <20250428120459.244525-1-m-malladi@ti.com>
 <20250428120459.244525-5-m-malladi@ti.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250428120459.244525-5-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/04/2025 14.04, Meghana Malladi wrote:
> Add __netif_tx_lock() to ensure that only one packet is being
> transmitted at a time to avoid race conditions in the netif_txq
> struct and prevent packet data corruption. Failing to do so causes
> kernel panic with the following error:
> 
> [ 2184.746764] ------------[ cut here ]------------
> [ 2184.751412] kernel BUG at lib/dynamic_queue_limits.c:99!
> [ 2184.756728] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> 
> logs: https://gist.github.com/MeghanaMalladiTI/9c7aa5fc3b7fb03f87c74aad487956e9
> 
> The lock is acquired before calling emac_xmit_xdp_frame() and released after the
> call returns. This ensures that the TX queue is protected from concurrent access
> during the transmission of XDP frames.
> 
> Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
>   drivers/net/ethernet/ti/icssg/icssg_common.c | 7 ++++++-
>   drivers/net/ethernet/ti/icssg/icssg_prueth.c | 7 ++++++-
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index a120ff6fec8f..e509b6ff81e7 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -660,6 +660,8 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
>   			struct page *page, u32 *len)
>   {
>   	struct net_device *ndev = emac->ndev;
> +	struct netdev_queue *netif_txq;
> +	int cpu = smp_processor_id();
>   	struct bpf_prog *xdp_prog;
>   	struct xdp_frame *xdpf;
>   	u32 pkt_len = *len;
> @@ -679,8 +681,11 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
>   			goto drop;
>   		}
>   
> -		q_idx = smp_processor_id() % emac->tx_ch_num;
> +		q_idx = cpu % emac->tx_ch_num;
> +		netif_txq = netdev_get_tx_queue(ndev, q_idx);
> +		__netif_tx_lock(netif_txq, cpu);
>   		result = emac_xmit_xdp_frame(emac, xdpf, page, q_idx);
> +		__netif_tx_unlock(netif_txq);
>   		if (result == ICSSG_XDP_CONSUMED) {
>   			ndev->stats.tx_dropped++;
>   			goto drop;
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index ee35fecf61e7..b31060e7f698 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1075,20 +1075,25 @@ static int emac_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frame
>   {
>   	struct prueth_emac *emac = netdev_priv(dev);
>   	struct net_device *ndev = emac->ndev;
> +	struct netdev_queue *netif_txq;
> +	int cpu = smp_processor_id();
>   	struct xdp_frame *xdpf;
>   	unsigned int q_idx;
>   	int nxmit = 0;
>   	u32 err;
>   	int i;
>   
> -	q_idx = smp_processor_id() % emac->tx_ch_num;
> +	q_idx = cpu % emac->tx_ch_num;
> +	netif_txq = netdev_get_tx_queue(ndev, q_idx);
>   
>   	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>   		return -EINVAL;
>   
>   	for (i = 0; i < n; i++) {
>   		xdpf = frames[i];
> +		__netif_tx_lock(netif_txq, cpu);
>   		err = emac_xmit_xdp_frame(emac, xdpf, NULL, q_idx);
> +		__netif_tx_unlock(netif_txq);

Why are you taking and releasing this lock in a loop?

XDP gain performance by sending a batch of 'n' packets.
This approach looks like a performance killer.


>   		if (err != ICSSG_XDP_TX) {
>   			ndev->stats.tx_dropped++;
>   			break;



