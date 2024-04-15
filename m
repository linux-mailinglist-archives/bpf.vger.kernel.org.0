Return-Path: <bpf+bounces-26752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3848A492B
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 09:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE801C20E11
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 07:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88662C1A0;
	Mon, 15 Apr 2024 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyRLmHiy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9928DA4;
	Mon, 15 Apr 2024 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166590; cv=none; b=eJN3Qt5iOgeDhPR0PUb49PI+BkaUw7seR+Mze4abKk7MMFponb1/qLc2kyopzU6DZnAeLkhw6WtsExSxlX+/Y36E4GrKh01YuNl11vdgpmjMCm2+lk9WrywlKpsPVXP9WEr1AVqGWswMcpMp/fuSlgxUbNSkPfkLXPgz1Z5YQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166590; c=relaxed/simple;
	bh=QEw7la3k+1B4uCDc5JgoVTPpyYgSenrHp3AkQ1ZVoJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSyCdcw0LAnGgSFuwhA5FBXrLBvQTRXIJYwAVi8hgpthfYuaeTyAkQuFzfsdSok8p48/taJVyPle90Eqjapww5cmyObmimlrasBBqOatlsZ1JtXhos0DnHuVZOaoZZWhZc0a36V+NuK1ZHBnR8VITt+V4zn53ujZxB4z+08woYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyRLmHiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFF7C113CC;
	Mon, 15 Apr 2024 07:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713166589;
	bh=QEw7la3k+1B4uCDc5JgoVTPpyYgSenrHp3AkQ1ZVoJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YyRLmHiyug+86g4mlvEV92WKvQWj+LlNyCyjYn5muAT8/zLjDAb59Hv0bmqyWxrS4
	 rV+0tP4dKrzcp6qN9fwibJ0+Ol/j+n8lSLPYtdKvjBvAoxm4gqX/5agtxIPm95FGhx
	 QQXBXMCKyVsJy5GF1jz6fLxB4af0/yZ2DRukpSd1JvHd2RhC0pK4ZKfvyuZ17mbfdf
	 XooX7dDXA7p/RONR4G6I1x/dQ6aDeUGFiNC6Ep3IZ9yuVRYjGpk7xzJ530pcsW3Yha
	 ZhNOT1v5UnD5NZOLhQBySfy4NPVr7HJ/Q/nadoj+zG03v+C69+zLxrBB3KVQ+asp2j
	 bRIvoNGTRXjrg==
Message-ID: <01c82cfb-e215-4929-9540-484378275ec3@kernel.org>
Date: Mon, 15 Apr 2024 09:36:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
 daniel@iogearbox.net, ast@kernel.org
References: <20240413041035.7344-1-liangchen.linux@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240413041035.7344-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/04/2024 06.10, Liang Chen wrote:
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing
> XDP hints through kfuncs to allow XDP programs to access the RSS hash.
> 
> 1.
> https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.com/#r
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>    Changes from v6:
> - fix a coding style issue
>    Changes from v5:
> - Preservation of the hash value has been dropped, following the conclusion
>    from discussions in V3 reviews. The virtio_net driver doesn't
>    accessing/using the virtio_net_hdr after the XDP program execution, so
>    nothing tragic should happen. As to the xdp program, if it smashes the
>    entry in virtio header, it is likely buggy anyways. Additionally, looking
>    up the Intel IGC driver,  it also does not bother with this particular
>    aspect.
> ---
>   drivers/net/virtio_net.c | 55 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..2a1892b7b8d3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4621,6 +4621,60 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
>   	}
>   }
>   
> +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> +			       enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct xdp_buff *xdp = (void *)_ctx;
> +	struct virtio_net_hdr_v1_hash *hdr_hash;
> +	struct virtnet_info *vi;
> +
> +	if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> +		return -ENODATA;
> +
> +	vi = netdev_priv(xdp->rxq->dev);
> +	hdr_hash = (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hdr_len);
> +
> +	switch (__le16_to_cpu(hdr_hash->hash_report)) {
> +	case VIRTIO_NET_HASH_REPORT_TCPv4:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV4_TCP;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_UDPv4:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV4_UDP;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_TCPv6:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_UDPv6:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> +		*rss_type = XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_IPv4:
> +		*rss_type = XDP_RSS_TYPE_L3_IPV4;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_IPv6:
> +		*rss_type = XDP_RSS_TYPE_L3_IPV6;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> +		*rss_type = XDP_RSS_TYPE_L3_IPV6_EX;
> +		break;
> +	case VIRTIO_NET_HASH_REPORT_NONE:
> +	default:
> +		*rss_type = XDP_RSS_TYPE_NONE;
> +	}

Why is this not implemented as a table lookup?

Like:
 
https://elixir.bootlin.com/linux/v6.9-rc4/source/drivers/net/ethernet/intel/igc/igc_main.c#L6652
  https://elixir.bootlin.com/linux/latest/A/ident/xdp_rss_hash_type

--Jesper

> +
> +	*hash = __le32_to_cpu(hdr_hash->hash_value);
> +	return 0;
> +}
> +
> +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
> +	.xmo_rx_hash			= virtnet_xdp_rx_hash,
> +};
> +
>   static int virtnet_probe(struct virtio_device *vdev)
>   {
>   	int i, err = -ENOMEM;
> @@ -4747,6 +4801,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>   				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
>   
>   		dev->hw_features |= NETIF_F_RXHASH;
> +		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
>   	}
>   
>   	if (vi->has_rss_hash_report)

