Return-Path: <bpf+bounces-3433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0756A73DEA3
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 14:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2779E1C208AF
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 12:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808198F4E;
	Mon, 26 Jun 2023 12:14:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E48C1D
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 12:14:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FE01987
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687781653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ajOPY7c86y/Eh/LHWm7DnjKqNr11/GAZcqbHvaOpUWU=;
	b=YNvhbzp3M8xzPgUfe+PlU79oKRdZ4Pr72O/aHmY70mMWoBNkuleeCuwZLm4Kb8f5XzOB+e
	/lHO6SfHJDnxwAbCcACUXLYhCNY1GT7IqWYcDyYOlk487u+58WJumUaP9M0+A6Vczz8NrE
	Mnb69r8jxXh/i67H2nBT8erM9FjqXGY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-P1hRtMR9O-S8pX_yBI7vNQ-1; Mon, 26 Jun 2023 08:14:10 -0400
X-MC-Unique: P1hRtMR9O-S8pX_yBI7vNQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31290e36b6aso1752582f8f.2
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 05:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687781649; x=1690373649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajOPY7c86y/Eh/LHWm7DnjKqNr11/GAZcqbHvaOpUWU=;
        b=ayST6mSLk0hhBL/MPnuB3mSs3XKM7m4qAjFDitGmHEBqbFfXebIsY84PeiF7QER4An
         1Ibin32rCW7/cOwWVj5/olDs10ZQ76MhrZoNlyVUywikuOfDuIq4pkcHXWaNSw/PVJNG
         MT62g63RQw5EjmKPsufFsPD1yinKrNjDdmzvIqmpTcyv+7Vq0qOH6jnHefw6j09fR2tG
         uMxxrdfsJJNhlS+TAhoJW06kxA5vb/wCjWSmzlH3mEhlY9oPX3ckID5/kXREQbob7PRf
         4u8c5MnJWtvMGbJcUHFtcBmGEfr2mt/Q78HyGjU4eYKBPkh6b+YnKatw08wSMMgmWq20
         SHPg==
X-Gm-Message-State: AC+VfDzHLS1tFcRxr+Ubcwz34wt1jiSh6f2YR4U4oBd/3S/Z5PfT0WHn
	0P5aIu8VgKVQGHyB816q1OcNumV1r4dNSZV5vmDBkyvkPuR/et+Hl5tNxfD/gADvwaVR5COWL9C
	JntiD1CGb1k25
X-Received: by 2002:a5d:6a0d:0:b0:313:e96e:98f7 with SMTP id m13-20020a5d6a0d000000b00313e96e98f7mr4026233wru.9.1687781648881;
        Mon, 26 Jun 2023 05:14:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ715wtiPIiCl3UkzhJBR8EpiHDoC12LKjv4MwwBQrUKa6bdkEf41dBbiYIXdRlMOelGwS70hA==
X-Received: by 2002:a5d:6a0d:0:b0:313:e96e:98f7 with SMTP id m13-20020a5d6a0d000000b00313e96e98f7mr4026211wru.9.1687781648528;
        Mon, 26 Jun 2023 05:14:08 -0700 (PDT)
Received: from redhat.com ([2.52.156.102])
        by smtp.gmail.com with ESMTPSA id s2-20020adff802000000b00313de682eb3sm7186905wrp.65.2023.06.26.05.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 05:14:08 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:14:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v3 1/2] virtio-net: support coexistence of XDP
 and GUEST_CSUM
Message-ID: <20230626080513-mutt-send-email-mst@kernel.org>
References: <20230626120301.380-1-hengqi@linux.alibaba.com>
 <20230626120301.380-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626120301.380-2-hengqi@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 08:03:00PM +0800, Heng Qi wrote:
> We are now re-probing the csum related fields and trying
> to have XDP and RX hw checksum capabilities coexist on the
> XDP path. For the benefit of:
> 1. RX hw checksum capability can be used if XDP is loaded.
> 2. Avoid packet loss when loading XDP in the vm-vm scenario.
> 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v2->v3:
>   - Use skb_checksum_setup() instead of virtnet_flow_dissect_udp_tcp().
>     Essentially equivalent.
> 
>  drivers/net/virtio_net.c | 86 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 73 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5a7f7a76b920..0a715e0fbc97 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1568,6 +1568,44 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
>  	skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
>  }
>  
> +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> +				      struct sk_buff *skb,
> +				      __u8 flags)
> +{
> +	int err = 0;
> +
> +	/* When XDP program is loaded, for example, the vm-vm scenario
> +	 * on the same host, packets marked as VIRTIO_NET_HDR_F_NEEDS_CSUM
> +	 * will travel. Although these packets are safe from the point of
> +	 * view of the vm, to avoid modification by XDP and successful
> +	 * forwarding in the upper layer,

why do you want tp avoid forwarding? did you mean
"and to allow forwarding"?

> we re-probe the necessary checksum
> +	 * related information: skb->csum_{start, offset}, pseudo-header csum
> +	 * using skb_chdcksum_setup().

typo

> +	 *
> +	 * This benefits us:

Drop "This benefits us:" - benefits compared to what?

> +	 * 1. XDP can be loaded when there's _F_GUEST_CSUM.
> +	 * 2. The device verifies the checksum of packets, especially
> +	 *    benefiting for large packets.
> +	 * 3. In the same-host vm-vm scenario, packets marked as
> +	 *    VIRTIO_NET_HDR_F_NEEDS_CSUM are no longer dropped after being
> +	 *    processed by XDP.

please rewrite so the text makes sense in the final C file,
not for someone reading the diff. In that cotext it does not
matter that we used to drop packets or that we used to
disable _F_GUEST_CSUM unless you explain
why they had to be dropped previously.


> +	 */
> +	if (flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> +		/* We don't parse SCTP because virtio-net currently doesn't
> +		 * support CRC checksum offloading for SCTP.

what does this refer to? where does it exclude SCTP?

> +		 */
> +		err = skb_checksum_setup(skb, true);
> +	} else if (flags & VIRTIO_NET_HDR_F_DATA_VALID) {
> +		/* We want to benefit from this: XDP guarantees that packets marked
> +		 * as VIRTIO_NET_HDR_F_DATA_VALID still have correct csum after they
> +		 * are processed.

drop "We want to benefit from this: "

> +		 */
> +		skb->ip_summed = CHECKSUM_UNNECESSARY;
> +	}
> +
> +	return err;
> +}
> +
>  static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  			void *buf, unsigned int len, void **ctx,
>  			unsigned int *xdp_xmit,
> @@ -1576,6 +1614,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	struct net_device *dev = vi->dev;
>  	struct sk_buff *skb;
>  	struct virtio_net_hdr_mrg_rxbuf *hdr;
> +	__u8 flags;
>  
>  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>  		pr_debug("%s: short packet %i\n", dev->name, len);
> @@ -1584,6 +1623,13 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  		return;
>  	}
>  
> +	/* Save the flags of the hdr before XDP processes the data.
> +	 * It is ok to use this for both mergeable and small modes.
> +	 * Because that's what we do now.

What does the last sentence mean?
Instead please explain why this is necessary. what can change the
header?

> +	 */
> +	if (unlikely(vi->xdp_enabled))
> +		flags = ((struct virtio_net_hdr_mrg_rxbuf *)buf)->hdr.flags;
> +
>  	if (vi->mergeable_rx_bufs)
>  		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>  					stats);
> @@ -1595,23 +1641,37 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
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
> +		/* Required to do this before re-probing and calculating
> +		 * the pseudo-header checksum.

What if checksum was disabled on device? No need for all the
elaborate hacks then, right?
What about disabling by ethtool?


> +		 */
> +		skb->protocol = eth_type_trans(skb, dev);
> +		skb_reset_network_header(skb);
> +		if (virtnet_set_csum_after_xdp(vi, skb, flags) < 0) {
> +			pr_debug("%s: errors occurred in setting partial csum",
> +				 dev->name);
> +			goto frame_err;
> +		}
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
>  
> -	if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> -				  virtio_is_little_endian(vi->vdev))) {
> -		net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
> -				     dev->name, hdr->hdr.gso_type,
> -				     hdr->hdr.gso_size);
> -		goto frame_err;
> +		skb->protocol = eth_type_trans(skb, dev);
>  	}
>  
>  	skb_record_rx_queue(skb, vq2rxq(rq->vq));
> -	skb->protocol = eth_type_trans(skb, dev);
>  	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
>  		 ntohs(skb->protocol), skb->len, skb->pkt_type);
>  
> -- 
> 2.19.1.6.gb485710b


