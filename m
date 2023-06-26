Return-Path: <bpf+bounces-3450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F6873E286
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 16:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FC3280CC0
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C037EBA23;
	Mon, 26 Jun 2023 14:52:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A163C0;
	Mon, 26 Jun 2023 14:52:23 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8372BD3;
	Mon, 26 Jun 2023 07:52:19 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vm2DKAm_1687791134;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vm2DKAm_1687791134)
          by smtp.aliyun-inc.com;
          Mon, 26 Jun 2023 22:52:15 +0800
Date: Mon, 26 Jun 2023 22:52:14 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Message-ID: <20230626145214.GB102374@h68b04307.sqa.eu95>
References: <20230626120301.380-1-hengqi@linux.alibaba.com>
 <20230626120301.380-2-hengqi@linux.alibaba.com>
 <20230626080513-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626080513-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 08:14:04AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 26, 2023 at 08:03:00PM +0800, Heng Qi wrote:
> > We are now re-probing the csum related fields and trying
> > to have XDP and RX hw checksum capabilities coexist on the
> > XDP path. For the benefit of:
> > 1. RX hw checksum capability can be used if XDP is loaded.
> > 2. Avoid packet loss when loading XDP in the vm-vm scenario.
> > 
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> > v2->v3:
> >   - Use skb_checksum_setup() instead of virtnet_flow_dissect_udp_tcp().
> >     Essentially equivalent.
> > 
> >  drivers/net/virtio_net.c | 86 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 73 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 5a7f7a76b920..0a715e0fbc97 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1568,6 +1568,44 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
> >  	skb_set_hash(skb, __le32_to_cpu(hdr_hash->hash_value), rss_hash_type);
> >  }
> >  
> > +static int virtnet_set_csum_after_xdp(struct virtnet_info *vi,
> > +				      struct sk_buff *skb,
> > +				      __u8 flags)
> > +{
> > +	int err = 0;
> > +
> > +	/* When XDP program is loaded, for example, the vm-vm scenario
> > +	 * on the same host, packets marked as VIRTIO_NET_HDR_F_NEEDS_CSUM
> > +	 * will travel. Although these packets are safe from the point of
> > +	 * view of the vm, to avoid modification by XDP and successful
> > +	 * forwarding in the upper layer,
> 
> why do you want tp avoid forwarding? did you mean
> "and to allow forwarding"?
> 

Yes, I mean "to allow forwarding".

> > we re-probe the necessary checksum
> > +	 * related information: skb->csum_{start, offset}, pseudo-header csum
> > +	 * using skb_chdcksum_setup().
> 
> typo
> 

Will fix.

> > +	 *
> > +	 * This benefits us:
> 
> Drop "This benefits us:" - benefits compared to what?

Benefits compared to not having this patch.

> 
> > +	 * 1. XDP can be loaded when there's _F_GUEST_CSUM.
> > +	 * 2. The device verifies the checksum of packets, especially
> > +	 *    benefiting for large packets.
> > +	 * 3. In the same-host vm-vm scenario, packets marked as
> > +	 *    VIRTIO_NET_HDR_F_NEEDS_CSUM are no longer dropped after being
> > +	 *    processed by XDP.
> 
> please rewrite so the text makes sense in the final C file,
> not for someone reading the diff. In that cotext it does not
> matter that we used to drop packets or that we used to
> disable _F_GUEST_CSUM unless you explain
> why they had to be dropped previously.

Reasonable, will be rewritten from the reader's point of view.

> 
> 
> > +	 */
> > +	if (flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> > +		/* We don't parse SCTP because virtio-net currently doesn't
> > +		 * support CRC checksum offloading for SCTP.
> 
> what does this refer to?

It means that the SCTP packets received by the virtio-net rx side have
complete checksums instead of only partial checksums (pseudo-header
checksums). Because virtio-net does not provide the NETIF_F_SCTP_CRC feature.

> where does it exclude SCTP?

Please see:
--> skb_checksum_setup()
	--> skb_checksum_setup_ipv4()
        --> skb_checksum_setup_ip()
	        --> IPPROTO_TCP/IPPROTO_UDP

    --> skb_checksum_setup_ipv6()
        --> skb_checksum_setup_ip()
	        --> IPPROTO_TCP/IPPROTO_UDP

> 
> > +		 */
> > +		err = skb_checksum_setup(skb, true);
> > +	} else if (flags & VIRTIO_NET_HDR_F_DATA_VALID) {
> > +		/* We want to benefit from this: XDP guarantees that packets marked
> > +		 * as VIRTIO_NET_HDR_F_DATA_VALID still have correct csum after they
> > +		 * are processed.
> 
> drop "We want to benefit from this: "

Ok.

> 
> > +		 */
> > +		skb->ip_summed = CHECKSUM_UNNECESSARY;
> > +	}
> > +
> > +	return err;
> > +}
> > +
> >  static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >  			void *buf, unsigned int len, void **ctx,
> >  			unsigned int *xdp_xmit,
> > @@ -1576,6 +1614,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >  	struct net_device *dev = vi->dev;
> >  	struct sk_buff *skb;
> >  	struct virtio_net_hdr_mrg_rxbuf *hdr;
> > +	__u8 flags;
> >  
> >  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> >  		pr_debug("%s: short packet %i\n", dev->name, len);
> > @@ -1584,6 +1623,13 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >  		return;
> >  	}
> >  
> > +	/* Save the flags of the hdr before XDP processes the data.
> > +	 * It is ok to use this for both mergeable and small modes.
> > +	 * Because that's what we do now.
> 
> What does the last sentence mean?

It means that both mergeable and small modes can use the
virtio_net_hdr_mrg_rxbuf* structure to obtain the flags in it, to remind
readers that this sentence works. Because flags are located at the same
position in the virtio_net_hdr_mrg_rxbuf and virtio_net_hdr structures.

Example of existing code:
--> receive_small_xdp():
      struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;


> Instead please explain why this is necessary. what can change the
> header?

Loaded XDP may overwrite/modify headers.

> 
> > +	 */
> > +	if (unlikely(vi->xdp_enabled))
> > +		flags = ((struct virtio_net_hdr_mrg_rxbuf *)buf)->hdr.flags;
> > +
> >  	if (vi->mergeable_rx_bufs)
> >  		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
> >  					stats);
> > @@ -1595,23 +1641,37 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >  	if (unlikely(!skb))
> >  		return;
> >  
> > -	hdr = skb_vnet_hdr(skb);
> > -	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> > -		virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
> > -
> > -	if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > -		skb->ip_summed = CHECKSUM_UNNECESSARY;
> > +	if (unlikely(vi->xdp_enabled)) {
> > +		/* Required to do this before re-probing and calculating
> > +		 * the pseudo-header checksum.
> 
> What if checksum was disabled on device?

When XDP is loaded, it may modify or overwrite the packet information.
If the packet has a partial checksum, virtio-net needs to recalculate
the partial checksum, it doesn't matter if the device has F_GUEST_CSUM
or not.

If the packet has a complete checksum and the device does not have
F_GUEST_CSUM, virtio-net does nothing and it is up to the stack to
verify the checksum.

>No need for all the elaborate hacks then, right?

No, always required when xdp is loaded.

> What about disabling by ethtool?

No way. guest csum is a [fixed] feature.

Thanks.

> 
> 
> > +		 */
> > +		skb->protocol = eth_type_trans(skb, dev);
> > +		skb_reset_network_header(skb);
> > +		if (virtnet_set_csum_after_xdp(vi, skb, flags) < 0) {
> > +			pr_debug("%s: errors occurred in setting partial csum",
> > +				 dev->name);
> > +			goto frame_err;
> > +		}
> > +	} else {
> > +		hdr = skb_vnet_hdr(skb);
> > +		if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> > +			virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
> > +
> > +		if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > +			skb->ip_summed = CHECKSUM_UNNECESSARY;
> > +
> > +		if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > +					  virtio_is_little_endian(vi->vdev))) {
> > +			net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
> > +					     dev->name, hdr->hdr.gso_type,
> > +					     hdr->hdr.gso_size);
> > +			goto frame_err;
> > +		}
> >  
> > -	if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > -				  virtio_is_little_endian(vi->vdev))) {
> > -		net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
> > -				     dev->name, hdr->hdr.gso_type,
> > -				     hdr->hdr.gso_size);
> > -		goto frame_err;
> > +		skb->protocol = eth_type_trans(skb, dev);
> >  	}
> >  
> >  	skb_record_rx_queue(skb, vq2rxq(rq->vq));
> > -	skb->protocol = eth_type_trans(skb, dev);
> >  	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
> >  		 ntohs(skb->protocol), skb->len, skb->pkt_type);
> >  
> > -- 
> > 2.19.1.6.gb485710b

