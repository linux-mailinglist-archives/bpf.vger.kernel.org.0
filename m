Return-Path: <bpf+bounces-37792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3195A875
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987E0283401
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5040717DFE3;
	Wed, 21 Aug 2024 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2x69kS2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF915749E;
	Wed, 21 Aug 2024 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283800; cv=none; b=gAnyBwkEb+aKOrB+pdVFNFTmm++bPT5u+SX7/opYMrUc8uVTZfsYrjWpt18OdEO8wTbegurqYOXg67GIl/xLErcnxqCjmEtZbI65sNtTPZFXvW4e9XLWcTjfjyr1oMZkWmUi/x6qViMSZvMFgrKFjzN/e8JYBd/EPtxpU+hPsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283800; c=relaxed/simple;
	bh=m4sJakXKR7i34caDwdfXKtNpcT/9LPPf3xAs96SSFOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9DqbyfknDsj9IcSUT8oxsAeNo5Pcnr2sNtgCJTwK4UbLiidtB9I8xwb/1pkJgECYUMGL8p9eN7vB6a5yl0lKIg9HwAbU6EZdXQVwjKWs4dT0neVd2XHqbPZhh5Hx9807eCEzryemaYaRL7XIz2a1zhbrtHC4HOnKmv0dU1j0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2x69kS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEE0C32781;
	Wed, 21 Aug 2024 23:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724283800;
	bh=m4sJakXKR7i34caDwdfXKtNpcT/9LPPf3xAs96SSFOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u2x69kS2TS85WEU7ECNb7u54g1FrG/FXprwIBUHrRfXgFK7YRc7anptiotY3zuI8v
	 xg+ePWOUr95igHnV2dmDpWIVUfBZpPELo91QkAIfIF1hoZlF83y1bFyOrdKafvro+8
	 NLgjY8hdfUlaNB5W9+hdOsRl1bRh27UHxGDAdJDMdLG8aegEodwBm9YC8WszcjcJpx
	 5gDDWEOS2zdo5evmkhxEMXcfLwWxmF7IMK5GxLs2CbQ9rX1gjodqGgWT6F+VIecc5O
	 4jTB1a0xXMJNs+/lrD2PQRVeADM4bJlGsZjFQ2ilH3vNk/up281podDbgmjRVgxSo+
	 agKZuJ2kMOusA==
Date: Wed, 21 Aug 2024 16:43:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>, Hangbin Liu
 <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, bpf@vger.kernel.org, Jay Vosburgh
 <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, "=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=" <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net-next v21] net: refactor ->ndo_bpf calls into
 dev_xdp_propagate
Message-ID: <20240821164318.34503e64@kernel.org>
In-Reply-To: <20240821045629.2856641-1-almasrymina@google.com>
References: <20240821045629.2856641-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 04:56:29 +0000 Mina Almasry wrote:
> When net devices propagate xdp configurations to slave devices, or when
> core propagates xdp configuration to a device, we will need to perform
> a memory provider check to ensure we're not binding xdp to a device
> using unreadable netmem.
> 
> Currently ->ndo_bpf calls are all over the place. Adding checks to all
> these places would not be ideal.
> 
> Refactor all the ->ndo_bpf calls into one place where we can add this
> check in the future.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index f9633a6f8571..73f9416c6c1b 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2258,7 +2258,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  			goto err_sysfs_del;
>  		}
>  
> -		res = slave_dev->netdev_ops->ndo_bpf(slave_dev, &xdp);
> +		res = dev_xdp_propagate(slave_dev, &xdp);

I was hoping we can fold the "is there any program present already"
but I'm not sure if that check itself isn't buggy... so let's leave
that part to someone else.

Hangbin, would you be willing to take a look at testing (and fixing)
the XDP program propagation? I did a naive test of adding a bond
and veth under it, I attached an XDP prog to bond, and nothing happened
on the veth. Maybe I'm misreading but I expected the XDP prog to show
up on the veth.

> diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
> index 4a9522689fa4..e01c5997a551 100644
> --- a/drivers/net/hyperv/netvsc_bpf.c
> +++ b/drivers/net/hyperv/netvsc_bpf.c
> @@ -183,7 +183,7 @@ int netvsc_vf_setxdp(struct net_device *vf_netdev, struct bpf_prog *prog)
>  	xdp.command = XDP_SETUP_PROG;
>  	xdp.prog = prog;
>  
> -	ret = vf_netdev->netdev_ops->ndo_bpf(vf_netdev, &xdp);
> +	ret = dev_xdp_propagate(vf_netdev, &xdp);

Again, the driver itself appears rather questionable but we can leave
it be :)

> @@ -130,7 +130,7 @@ static int bpf_map_offload_ndo(struct bpf_offloaded_map *offmap,
>  	/* Caller must make sure netdev is valid */
>  	netdev = offmap->netdev;
>  
> -	return netdev->netdev_ops->ndo_bpf(netdev, &data);
> +	return dev_xdp_propagate(netdev, &data);

This is not propagation, it's an offload call, let's not convert it

> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index c0e0204b9630..f44d68c8d75d 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -149,7 +149,7 @@ static void xp_disable_drv_zc(struct xsk_buff_pool *pool)
>  		bpf.xsk.pool = NULL;
>  		bpf.xsk.queue_id = pool->queue_id;
>  
> -		err = pool->netdev->netdev_ops->ndo_bpf(pool->netdev, &bpf);
> +		err = dev_xdp_propagate(pool->netdev, &bpf);
>  
>  		if (err)
>  			WARN(1, "Failed to disable zero-copy!\n");
> @@ -215,7 +215,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  	bpf.xsk.pool = pool;
>  	bpf.xsk.queue_id = queue_id;
>  
> -	err = netdev->netdev_ops->ndo_bpf(netdev, &bpf);
> +	err = dev_xdp_propagate(netdev, &bpf);
>  	if (err)
>  		goto err_unreg_pool;
>  

That's also not xdp propagation. If you're not doing so already in your
series - you should look at queue state here directly and check if it
has MP installed. Conversely you should look at rxq->pool when binding
MP. But as I said, that's not part of the XDP refactor, just as part of
your series.

So in case my ramblings were confusing - code LG, but ditch the
net/xdp/xsk_buff_pool.c and kernel/bpf/offload.c changes.

