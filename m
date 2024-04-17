Return-Path: <bpf+bounces-27027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A828A7D91
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 10:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586731F2285D
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 08:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347D56FE21;
	Wed, 17 Apr 2024 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SOWomeNd"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53933CC2;
	Wed, 17 Apr 2024 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340797; cv=none; b=djBEbelzy9+QsuUheIGeQ1Gm83Ym2aa7/SFTSwKptSLmgfVWg9VI+YuRzhu3DzY8Vkxjj1An+vel5T04zhvuuLRfqLdh8+e3W5QQsAOa4RvYOfse3O/XNsmySq6x/br97pMU4s48uycPuzceZy9zIfKMF7AybsljElNIOEmqBw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340797; c=relaxed/simple;
	bh=36MTnlcp33XwHHxLO/m8OsWJKQx4HmShuAbNDoPWRD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6Bz8Bb39dxonzJPH481vGIUvTl83S9Lkj5WjXiqhTBus1C7d4TlIGppjoYJ4QMOqPAmWpDPjhE9qKitR345J/RED3JESHFPfN/khSVraINJiFEEhCVSVjr84b5034UZGIJRISs+Vj31oIxtz5aaHFJ2iRYjZzSMBiebhVufukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SOWomeNd; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713340787; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=00eV10aYqBSEYTxuhgv4GNMQMHte1deFn+CrhZCt04s=;
	b=SOWomeNdq6rv0zkORBWlsPAY7d+p2MNfkmyFhpn5epQiCVr+Oe7NJBvOgU82+BdpRpNl6cMqv+jvGfhsqCoBhq3GUNHnJRL1M1kPVetAROOywJMnp1x0wjtUJHOnVvt6S0/gjA4U4JEYyBP966ycP2IluPTbPsr2OlTrAEqV4Wg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W4kiWz7_1713340784;
Received: from 30.221.148.177(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4kiWz7_1713340784)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 15:59:46 +0800
Message-ID: <ae00d109-403f-46f5-9b70-19fd7a94d3cf@linux.alibaba.com>
Date: Wed, 17 Apr 2024 15:59:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 ast@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
References: <20240417071822.27831-1-liangchen.linux@gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240417071822.27831-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/17 下午3:18, Liang Chen 写道:
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

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

Thanks.

> ---
>    Changes from v8:
> - move max table macro out of uAPI
>    Changes from v7:
> - use table lookup for rss hash type
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
>   drivers/net/virtio_net.c | 43 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..eb99bf6c555e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4621,6 +4621,48 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
>   	}
>   }
>   
> +#define VIRTIO_NET_HASH_REPORT_MAX_TABLE      10
> +static enum xdp_rss_hash_type
> +virtnet_xdp_rss_type[VIRTIO_NET_HASH_REPORT_MAX_TABLE] = {
> +	[VIRTIO_NET_HASH_REPORT_NONE] = XDP_RSS_TYPE_NONE,
> +	[VIRTIO_NET_HASH_REPORT_IPv4] = XDP_RSS_TYPE_L3_IPV4,
> +	[VIRTIO_NET_HASH_REPORT_TCPv4] = XDP_RSS_TYPE_L4_IPV4_TCP,
> +	[VIRTIO_NET_HASH_REPORT_UDPv4] = XDP_RSS_TYPE_L4_IPV4_UDP,
> +	[VIRTIO_NET_HASH_REPORT_IPv6] = XDP_RSS_TYPE_L3_IPV6,
> +	[VIRTIO_NET_HASH_REPORT_TCPv6] = XDP_RSS_TYPE_L4_IPV6_TCP,
> +	[VIRTIO_NET_HASH_REPORT_UDPv6] = XDP_RSS_TYPE_L4_IPV6_UDP,
> +	[VIRTIO_NET_HASH_REPORT_IPv6_EX] = XDP_RSS_TYPE_L3_IPV6_EX,
> +	[VIRTIO_NET_HASH_REPORT_TCPv6_EX] = XDP_RSS_TYPE_L4_IPV6_TCP_EX,
> +	[VIRTIO_NET_HASH_REPORT_UDPv6_EX] = XDP_RSS_TYPE_L4_IPV6_UDP_EX
> +};
> +
> +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> +			       enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct xdp_buff *xdp = (void *)_ctx;
> +	struct virtio_net_hdr_v1_hash *hdr_hash;
> +	struct virtnet_info *vi;
> +	u16 hash_report;
> +
> +	if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> +		return -ENODATA;
> +
> +	vi = netdev_priv(xdp->rxq->dev);
> +	hdr_hash = (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hdr_len);
> +	hash_report = __le16_to_cpu(hdr_hash->hash_report);
> +
> +	if (hash_report >= VIRTIO_NET_HASH_REPORT_MAX_TABLE)
> +		hash_report = VIRTIO_NET_HASH_REPORT_NONE;
> +
> +	*rss_type = virtnet_xdp_rss_type[hash_report];
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
> @@ -4747,6 +4789,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>   				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
>   
>   		dev->hw_features |= NETIF_F_RXHASH;
> +		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
>   	}
>   
>   	if (vi->has_rss_hash_report)


