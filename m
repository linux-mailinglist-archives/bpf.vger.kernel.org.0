Return-Path: <bpf+bounces-21060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331B684748F
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366211C21D65
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BE41474B2;
	Fri,  2 Feb 2024 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CokDGYnF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9A145B07;
	Fri,  2 Feb 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890802; cv=none; b=M0fKKrk+0VlAZaxcdy/hTtxZFXn++n26hPJutAInDsfltMnpP1jDvWUo24PO9MuuCgruNbDgxOGJ/8qv0ifJ5Qsz8EXdC+bIfVElYB3HUgIn4rI3kz8gUUqKZRrQziu6QjlM+6uKgVOeqaXA/OKcPbFSPdVsjPl8tDkAM7/VEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890802; c=relaxed/simple;
	bh=09S8wVn66zHG3dl7N/0ch+SY16b9ZyM41FyxhbeQ7R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qm8x3WJpigQjp+O5rSVkGQmvsDooyJ6u9VV8w2rDHwABc/uewwdmUMPy+Sre4kb7wzy5ys5itJ2XTpZCy7DW8Xqr/QHZCVQUUF89HYtmoXSDuOahp0LiJ3vEqefYjpG1zVkQ4I7SBTGuEp1y3Lj/VRoeCwuHGh230dRKOEfb0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CokDGYnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAF5C433C7;
	Fri,  2 Feb 2024 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706890801;
	bh=09S8wVn66zHG3dl7N/0ch+SY16b9ZyM41FyxhbeQ7R0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CokDGYnFq/Z1i4dEL5f32q5+omtz1oW0U77EN0EaVqk3Pz1uctporEPG3h4xcM5lj
	 mvGglHzgrNwnzr81qzB7LAUREehxAwQLwIFc7o1Irvgm3/+A9f7WPkC6mC2qOmMMV6
	 lgBxQS/ZXjd1ko34KXV7VwNpwvf1fUoMKaX412ubTT8g6ZVyCuY3eocid+LE/ydRgA
	 0BeVlHlIzks1cZok8UolOlOc+qIkP5dsJqwljP/VHMBHjtsIsQQmEbldOiMt59taTq
	 q8q8OoZrmq9xVbIdYAUMNGXKpR3ZdP2fr3RcNWAWOQBkVmGosakgWD+2jiSoaVSjLn
	 dt5MTu+QSAQYw==
Message-ID: <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org>
Date: Fri, 2 Feb 2024 17:19:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
Content-Language: en-US
To: Liang Chen <liangchen.linux@gmail.com>, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
 daniel@iogearbox.net, ast@kernel.org
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240202121151.65710-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/02/2024 13.11, Liang Chen wrote:
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
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>    Changes from v4:
> - cc complete list of maintainers
> ---
>   drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++++-----
>   1 file changed, 86 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..7ce666c86ee0 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -349,6 +349,12 @@ struct virtio_net_common_hdr {
>   	};
>   };
>   
> +struct virtnet_xdp_buff {
> +	struct xdp_buff xdp;
> +	__le32 hash_value;
> +	__le16 hash_report;
> +};
> +
>   static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>   
>   static bool is_xdp_frame(void *ptr)
> @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>   	}
>   }
>   
> +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *virtnet_xdp,
> +				     struct net_device *dev,
> +				     struct virtio_net_hdr_v1_hash *hdr_hash)
> +{
> +	if (dev->features & NETIF_F_RXHASH) {
> +		virtnet_xdp->hash_value = hdr_hash->hash_value;
> +		virtnet_xdp->hash_report = hdr_hash->hash_report;
> +	}
> +}
> +

Would it be possible to store a pointer to hdr_hash in virtnet_xdp_buff,
with the purpose of delaying extracting this, until and only if XDP
bpf_prog calls the kfunc?



>   static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>   			       struct net_device *dev,
>   			       unsigned int *xdp_xmit,
> @@ -1199,9 +1215,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>   	unsigned int headroom = vi->hdr_len + header_offset;
>   	struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
>   	struct page *page = virt_to_head_page(buf);
> +	struct virtnet_xdp_buff virtnet_xdp;
>   	struct page *xdp_page;
> +	struct xdp_buff *xdp;
>   	unsigned int buflen;
> -	struct xdp_buff xdp;
>   	struct sk_buff *skb;
>   	unsigned int metasize = 0;
>   	u32 act;
> @@ -1233,17 +1250,20 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>   		page = xdp_page;
>   	}
>   
> -	xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
> -	xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
> +	xdp = &virtnet_xdp.xdp;
> +	xdp_init_buff(xdp, buflen, &rq->xdp_rxq);
> +	xdp_prepare_buff(xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
>   			 xdp_headroom, len, true);
>   
> -	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
> +	virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
> +
> +	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
>   
>   	switch (act) {
>   	case XDP_PASS:
>   		/* Recalculate length in case bpf program changed it */
> -		len = xdp.data_end - xdp.data;
> -		metasize = xdp.data - xdp.data_meta;
> +		len = xdp->data_end - xdp->data;
> +		metasize = xdp->data - xdp->data_meta;
>   		break;
>   
>   	case XDP_TX:
> @@ -1254,7 +1274,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>   		goto err_xdp;
>   	}
>   
> -	skb = virtnet_build_skb(buf, buflen, xdp.data - buf, len);
> +	skb = virtnet_build_skb(buf, buflen, xdp->data - buf, len);
>   	if (unlikely(!skb))
>   		goto err;
>   
> @@ -1591,10 +1611,11 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>   	int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>   	struct page *page = virt_to_head_page(buf);
>   	int offset = buf - page_address(page);
> +	struct virtnet_xdp_buff virtnet_xdp;
>   	unsigned int xdp_frags_truesz = 0;
>   	struct sk_buff *head_skb;
>   	unsigned int frame_sz;
> -	struct xdp_buff xdp;
> +	struct xdp_buff *xdp;
>   	void *data;
>   	u32 act;
>   	int err;
> @@ -1604,16 +1625,19 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>   	if (unlikely(!data))
>   		goto err_xdp;
>   
> -	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, frame_sz,
> +	xdp = &virtnet_xdp.xdp;
> +	err = virtnet_build_xdp_buff_mrg(dev, vi, rq, xdp, data, len, frame_sz,
>   					 &num_buf, &xdp_frags_truesz, stats);
>   	if (unlikely(err))
>   		goto err_xdp;
>   
> -	act = virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats);
> +	virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
> +
> +	act = virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
>   
>   	switch (act) {
>   	case XDP_PASS:
> -		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
> +		head_skb = build_skb_from_xdp_buff(dev, vi, xdp, xdp_frags_truesz);
>   		if (unlikely(!head_skb))
>   			break;
>   		return head_skb;
> @@ -1626,7 +1650,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>   		break;
>   	}
>   
> -	put_xdp_frags(&xdp);
> +	put_xdp_frags(xdp);
>   
>   err_xdp:
>   	put_page(page);
> @@ -4579,6 +4603,55 @@ static void virtnet_set_big_packets(struct virtnet_info *vi, const int mtu)
>   	}
>   }
>   
> +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> +			       enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct virtnet_xdp_buff *virtnet_xdp = (void *)_ctx;
> +
> +	if (!(virtnet_xdp->xdp.rxq->dev->features & NETIF_F_RXHASH))
> +		return -ENODATA;
> +
> +	switch (__le16_to_cpu(virtnet_xdp->hash_report)) {
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
> +
> +	*hash = __le32_to_cpu(virtnet_xdp->hash_value);
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
> @@ -4704,6 +4777,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>   				  VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
>   
>   		dev->hw_features |= NETIF_F_RXHASH;
> +		dev->xdp_metadata_ops = &virtnet_xdp_metadata_ops;
>   	}
>   
>   	if (vi->has_rss_hash_report)

