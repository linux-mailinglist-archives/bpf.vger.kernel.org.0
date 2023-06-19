Return-Path: <bpf+bounces-2842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912ED7355B0
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 13:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35221C20A33
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3972FD2FA;
	Mon, 19 Jun 2023 11:26:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07819BA32
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 11:26:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D800B1
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 04:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687174011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANOoH5K2yIBSZifveaFYOlFgrClQMi/FaHiAGPTEBE0=;
	b=S0JwAhZoAXYYmgkuZJZ2ccCQR5hWW9ujnrEWRpxC27svJYtzxAym7zgc5Jqc2z1DjdReWJ
	0unQFoqArNV3+Q4PcQrtq0oZYSaDgVXfrtRmXcZcm71nE/IeJP89y4Nr0kb/ofG4YJQv+o
	hQrhiRFuwFjGalQcxBJ668yRdH68swk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-7E1LdtxrOUOS2mA1J74ZZw-1; Mon, 19 Jun 2023 07:26:50 -0400
X-MC-Unique: 7E1LdtxrOUOS2mA1J74ZZw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30e5c497f90so1553056f8f.2
        for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 04:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687174009; x=1689766009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANOoH5K2yIBSZifveaFYOlFgrClQMi/FaHiAGPTEBE0=;
        b=EF8xdJGmaepc6NbS0qug82CdyPcyAbhP7jw8lQ4fr/Zf/But4tZvpzgMe4l9cBVpCg
         GYyNlG8MDh8TO8wkBsEhShybhYsYgscRvv+cJjnxrsiZKgsMEdn48vAlBMNPq+etZglT
         IKeasCMGkyde3cs2FN0QviNFNjDlOIyt8FMz4G6rdmte06vegou5v3wMY3nSD/7W0Zek
         CI6eAr7P9t5enhgoxwYbh531iw7Ojn1zBQFL9nI+2BbZAX6yjWHZ21kZADJod0Nwnndg
         fee99WI0jjouALozM5BorJA96O7S2N4LNnHT1YjwPQF/qPgLvfZOQ22j5UvHNQ01704D
         kthA==
X-Gm-Message-State: AC+VfDyssB7+arPpyqDzA81tjTkHcDXAHvvNk/4fYQj/tjam+kLEnEqT
	eC8zgtvJxXNEolzwJPMRX05Lb3drNRGyLGhNK/76R5XjqaRCozNaIU9pV4b4QztQbTNZ6+4ZRpU
	cj/q6evLLqXRF
X-Received: by 2002:a5d:453b:0:b0:311:1b8d:e565 with SMTP id j27-20020a5d453b000000b003111b8de565mr7132452wra.34.1687174008900;
        Mon, 19 Jun 2023 04:26:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7oN/RodE+feoIDYQlDH7reicVB5wWqTaEAyZFpkLn52W1J0AI/AhMIVukvSHIdUcaR1vZ/Sg==
X-Received: by 2002:a5d:453b:0:b0:311:1b8d:e565 with SMTP id j27-20020a5d453b000000b003111b8de565mr7132438wra.34.1687174008609;
        Mon, 19 Jun 2023 04:26:48 -0700 (PDT)
Received: from redhat.com ([2.52.15.156])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d4349000000b003079c402762sm31172202wrr.19.2023.06.19.04.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 04:26:48 -0700 (PDT)
Date: Mon, 19 Jun 2023 07:26:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next 3/4] virtio-net: support coexistence of XDP and
 _F_GUEST_CSUM
Message-ID: <20230619072320-mutt-send-email-mst@kernel.org>
References: <20230619105738.117733-1-hengqi@linux.alibaba.com>
 <20230619105738.117733-4-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619105738.117733-4-hengqi@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 06:57:37PM +0800, Heng Qi wrote:
> We are now re-probing the csum related fields and  trying
> to have XDP and RX hw checksum capabilities coexist on the
> XDP path. For the benefit of:
> 1. RX hw checksum capability can be used if XDP is loaded.
> 2. Avoid packet loss when loading XDP in the vm-vm scenario.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 07b4801d689c..25b486ab74db 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1709,6 +1709,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	struct net_device *dev = vi->dev;
>  	struct sk_buff *skb;
>  	struct virtio_net_hdr_mrg_rxbuf *hdr;
> +	__u8 flags;
>  
>  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>  		pr_debug("%s: short packet %i\n", dev->name, len);
> @@ -1717,6 +1718,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  		return;
>  	}
>  
> +	flags = ((struct virtio_net_hdr_mrg_rxbuf *)buf)->hdr.flags;
> +
>  	if (vi->mergeable_rx_bufs)
>  		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>  					stats);

what's going on here?

> @@ -1728,19 +1731,28 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	if (unlikely(!skb))
>  		return;
>  
> -	hdr = skb_vnet_hdr(skb);
> -	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> -		virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
> -
> -	if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> -		skb->ip_summed = CHECKSUM_UNNECESSARY;
> +	if (unlikely(vi->xdp_enabled)) {
> +		if (virtnet_set_csum_after_xdp(vi, skb, flags) < 0) {
> +			pr_debug("%s: errors occurred in flow dissector setting csum",
> +				 dev->name);
> +			goto frame_err;
> +		}
>  
> -	if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> -				  virtio_is_little_endian(vi->vdev))) {
> -		net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
> -				     dev->name, hdr->hdr.gso_type,
> -				     hdr->hdr.gso_size);
> -		goto frame_err;
> +	} else {
> +		hdr = skb_vnet_hdr(skb);
> +		if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> +			virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
> +
> +		if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> +			skb->ip_summed = CHECKSUM_UNNECESSARY;
> +
> +		if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> +					  virtio_is_little_endian(vi->vdev))) {
> +			net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
> +					     dev->name, hdr->hdr.gso_type,
> +					     hdr->hdr.gso_size);
> +			goto frame_err;
> +		}
>  	}
>  
>  	skb_record_rx_queue(skb, vq2rxq(rq->vq));
> -- 
> 2.19.1.6.gb485710b


