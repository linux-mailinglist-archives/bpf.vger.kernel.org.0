Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD51A2F9F9E
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 13:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391395AbhARM25 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 07:28:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391199AbhARM2x (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Jan 2021 07:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610972845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4t9hxLI3c27quDQ06hH0LqJQwL5pt6zZt+4PjybMLus=;
        b=YjlFi7iSvNuTxErrsQxAquvTdddUBpjfAKzC0Sk/yZ6CN0cVQgdCwnNiuQhdjF7vFEKhFH
        CZZQ9gZzQfC0kS8GnF/+UJtf+VFmhJAww+LG5Sw3mdjQhyTA2ricqVgpnTeQfK6Gn93pgj
        gWgDLR9FXRCMrpm4EHkMzCs0S3H0bXc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-mHdeiv9iM96Olr7gbd2syA-1; Mon, 18 Jan 2021 07:27:23 -0500
X-MC-Unique: mHdeiv9iM96Olr7gbd2syA-1
Received: by mail-wr1-f70.google.com with SMTP id n11so8203832wro.7
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 04:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4t9hxLI3c27quDQ06hH0LqJQwL5pt6zZt+4PjybMLus=;
        b=b6UXynldjelVWBgu0MS943uouv/z2KPnFopTqQmIACkyEfcUMkCh83H1UpzkwxTSbW
         JLzmZYnd7iC8JnuEd8TS6+6CtTbJoDa/WVUu5xYp/bRM1hs2PfT+Uk9rIv+M5LEtPJpl
         PjMPA9X76c+GOx3hii3Tzc/TxlMzQE3Mr2mx0qTnhU6D5+oJKPvho5/hsrewD9EviSf2
         S0/exgl/3VeoUUlOyAF++AlMxgvZ972WPh2TxYrrYTZf7ajBnQYYBrT2V+QSWP5sdW43
         0hp5FN/WU4Oiy+l1x8dxPKlC9CQpO7VPw5FkKezMivjm/zJGfhjYvUgUVkihf1PBVOHT
         fY5w==
X-Gm-Message-State: AOAM532ybGxIdXG5X3lT9b3uzcU9PDhpWTlCq+rzjA08lQsMSEx8a5Oa
        0mR6V1PxWe0jDwSUkqG9M2RWPL9gddGNaETwdHS+esCKJ6IGaqQNzovlhrRHSkHkV7GoECeE3W0
        OxzEJQjV0RUpV
X-Received: by 2002:adf:ec86:: with SMTP id z6mr25591932wrn.17.1610972842626;
        Mon, 18 Jan 2021 04:27:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrDwjLmyAp5ze/Z7CO1QoqA7XEqd1cdTgI2I5axRLmYtXljl1vRJEjffpSsd1Ieh81PfR2qA==
X-Received: by 2002:adf:ec86:: with SMTP id z6mr25591913wrn.17.1610972842429;
        Mon, 18 Jan 2021 04:27:22 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
        by smtp.gmail.com with ESMTPSA id j9sm29836629wrm.14.2021.01.18.04.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 04:27:21 -0800 (PST)
Date:   Mon, 18 Jan 2021 07:27:18 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/7] virtio-net, xsk: realize the function of
 xsk packet sending
Message-ID: <20210118065907-mutt-send-email-mst@kernel.org>
References: <cover.1609837120.git.xuanzhuo@linux.alibaba.com>
 <cover.1610765285.git.xuanzhuo@linux.alibaba.com>
 <9e1f5a4b633887ce1f66e39bc762b8497a379a43.1610765285.git.xuanzhuo@linux.alibaba.com>
 <20e27fa0-c7c3-0cc3-bd27-19d1fe9b7717@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20e27fa0-c7c3-0cc3-bd27-19d1fe9b7717@redhat.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 18, 2021 at 05:10:24PM +0800, Jason Wang wrote:
> 
> On 2021/1/16 上午10:59, Xuan Zhuo wrote:
> > virtnet_xsk_run will be called in the tx interrupt handling function
> > virtnet_poll_tx.
> > 
> > The sending process gets desc from the xsk tx queue, and assembles it to
> > send the data.
> > 
> > Compared with other drivers, a special place is that the page of the
> > data in xsk is used here instead of the dma address. Because the virtio
> > interface does not use the dma address.
> > 
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >   drivers/net/virtio_net.c | 200 ++++++++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 197 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index a62d456..42aa9ad 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -119,6 +119,8 @@ struct virtnet_xsk_hdr {
> >   	u32 len;
> >   };
> > +#define VIRTNET_STATE_XSK_WAKEUP 1
> > +
> >   #define VIRTNET_SQ_STAT(m)	offsetof(struct virtnet_sq_stats, m)
> >   #define VIRTNET_RQ_STAT(m)	offsetof(struct virtnet_rq_stats, m)
> > @@ -163,9 +165,12 @@ struct send_queue {
> >   		struct xsk_buff_pool   __rcu *pool;
> >   		struct virtnet_xsk_hdr __rcu *hdr;
> > +		unsigned long          state;
> >   		u64                    hdr_con;
> >   		u64                    hdr_pro;
> >   		u64                    hdr_n;
> > +		struct xdp_desc        last_desc;
> > +		bool                   wait_slot;
> >   	} xsk;
> >   };



Please add documentation about the new fields/defines, how are they
accessed, what locking/ordering is in place.

> > @@ -284,6 +289,8 @@ static void __free_old_xmit_ptr(struct send_queue *sq, bool in_napi,
> >   				bool xsk_wakeup,
> >   				unsigned int *_packets, unsigned int *_bytes);
> >   static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi);
> > +static int virtnet_xsk_run(struct send_queue *sq,
> > +			   struct xsk_buff_pool *pool, int budget);
> >   static bool is_xdp_frame(void *ptr)
> >   {
> > @@ -1590,6 +1597,8 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
> >   	struct virtnet_info *vi = sq->vq->vdev->priv;
> >   	unsigned int index = vq2txq(sq->vq);
> >   	struct netdev_queue *txq;
> > +	struct xsk_buff_pool *pool;
> > +	int work = 0;
> >   	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
> >   		/* We don't need to enable cb for XDP */
> > @@ -1599,15 +1608,26 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
> >   	txq = netdev_get_tx_queue(vi->dev, index);
> >   	__netif_tx_lock(txq, raw_smp_processor_id());
> > -	free_old_xmit_skbs(sq, true);
> > +
> > +	rcu_read_lock();
> > +	pool = rcu_dereference(sq->xsk.pool);
> > +	if (pool) {
> > +		work = virtnet_xsk_run(sq, pool, budget);
> > +		rcu_read_unlock();
> > +	} else {
> > +		rcu_read_unlock();
> > +		free_old_xmit_skbs(sq, true);
> > +	}
> > +
> >   	__netif_tx_unlock(txq);
> > -	virtqueue_napi_complete(napi, sq->vq, 0);
> > +	if (work < budget)
> > +		virtqueue_napi_complete(napi, sq->vq, 0);
> >   	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> >   		netif_tx_wake_queue(txq);
> > -	return 0;
> > +	return work;
> >   }
> >   static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
> > @@ -2647,6 +2667,180 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
> >   	}
> >   }
> > +static int virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
> > +			    struct xdp_desc *desc)
> > +{
> > +	struct virtnet_info *vi = sq->vq->vdev->priv;
> > +	void *data, *ptr;
> > +	struct page *page;
> > +	struct virtnet_xsk_hdr *xskhdr;
> > +	u32 idx, offset, n, i, copy, copied;
> > +	u64 addr;
> > +	int err, m;
> > +
> > +	addr = desc->addr;
> > +
> > +	data = xsk_buff_raw_get_data(pool, addr);
> > +	offset = offset_in_page(data);
> > +
> > +	/* one for hdr, one for the first page */
> > +	n = 2;
> > +	m = desc->len - (PAGE_SIZE - offset);
> > +	if (m > 0) {
> > +		n += m >> PAGE_SHIFT;
> > +		if (m & PAGE_MASK)
> > +			++n;
> > +
> > +		n = min_t(u32, n, ARRAY_SIZE(sq->sg));
> > +	}
> > +
> > +	idx = sq->xsk.hdr_con % sq->xsk.hdr_n;
> 
> 
> I don't understand the reason of the hdr array. It looks to me all of them
> are zero and read only from device.
> 
> Any reason for not reusing a single hdr for all xdp descriptors? Or maybe
> it's time to introduce VIRTIO_NET_F_NO_HDR.

I'm not sure it's worth it, since
- xdp can be enabled/disabled dynamically
- there's intent to add offload support to xdp

> 
> > +	xskhdr = &sq->xsk.hdr[idx];
> > +
> > +	/* xskhdr->hdr has been memset to zero, so not need to clear again */
> > +
> > +	sg_init_table(sq->sg, n);
> > +	sg_set_buf(sq->sg, &xskhdr->hdr, vi->hdr_len);
> > +
> > +	copied = 0;
> > +	for (i = 1; i < n; ++i) {
> > +		copy = min_t(int, desc->len - copied, PAGE_SIZE - offset);
> > +
> > +		page = xsk_buff_raw_get_page(pool, addr + copied);
> > +
> > +		sg_set_page(sq->sg + i, page, copy, offset);
> > +		copied += copy;
> > +		if (offset)
> > +			offset = 0;
> > +	}
> 
> 
> It looks to me we need to terminate the sg:
> 
> **
>  * virtqueue_add_outbuf - expose output buffers to other end
>  * @vq: the struct virtqueue we're talking about.
>  * @sg: scatterlist (must be well-formed and terminated!)
> 
> 
> > +
> > +	xskhdr->len = desc->len;
> > +	ptr = xdp_to_ptr(&xskhdr->type);
> > +
> > +	err = virtqueue_add_outbuf(sq->vq, sq->sg, n, ptr, GFP_ATOMIC);
> > +	if (unlikely(err))
> > +		sq->xsk.last_desc = *desc;
> > +	else
> > +		sq->xsk.hdr_con++;
> > +
> > +	return err;
> > +}
> > +
> > +static bool virtnet_xsk_dev_is_full(struct send_queue *sq)
> > +{
> > +	if (sq->vq->num_free < 2 + MAX_SKB_FRAGS)
> > +		return true;
> > +
> > +	if (sq->xsk.hdr_con == sq->xsk.hdr_pro)
> > +		return true;
> 
> 
> Can we really reach here?
> 
> 
> > +
> > +	return false;
> > +}
> > +
> > +static int virtnet_xsk_xmit_zc(struct send_queue *sq,
> > +			       struct xsk_buff_pool *pool, unsigned int budget)
> > +{
> > +	struct xdp_desc desc;
> > +	int err, packet = 0;
> > +	int ret = -EAGAIN;
> > +
> > +	if (sq->xsk.last_desc.addr) {
> > +		err = virtnet_xsk_xmit(sq, pool, &sq->xsk.last_desc);
> > +		if (unlikely(err))
> > +			return -EBUSY;
> > +
> > +		++packet;
> > +		sq->xsk.last_desc.addr = 0;
> > +	}
> > +
> > +	while (budget-- > 0) {
> > +		if (virtnet_xsk_dev_is_full(sq)) {
> > +			ret = -EBUSY;
> > +			break;
> > +		}
> 
> 
> It looks to me we will always hit this if userspace is fast. E.g we don't
> kick until the virtqueue is full ...
> 
> 
> > +
> > +		if (!xsk_tx_peek_desc(pool, &desc)) {
> > +			/* done */
> > +			ret = 0;
> > +			break;
> > +		}
> > +
> > +		err = virtnet_xsk_xmit(sq, pool, &desc);
> > +		if (unlikely(err)) {
> > +			ret = -EBUSY;
> > +			break;
> > +		}
> > +
> > +		++packet;
> > +	}
> > +
> > +	if (packet) {
> > +		xsk_tx_release(pool);
> > +
> > +		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
> > +			u64_stats_update_begin(&sq->stats.syncp);
> > +			sq->stats.kicks++;
> > +			u64_stats_update_end(&sq->stats.syncp);
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int virtnet_xsk_run(struct send_queue *sq,
> > +			   struct xsk_buff_pool *pool, int budget)
> > +{
> > +	int err, ret = 0;
> > +	unsigned int _packets = 0;
> > +	unsigned int _bytes = 0;
> > +
> > +	sq->xsk.wait_slot = false;
> > +
> > +	__free_old_xmit_ptr(sq, true, false, &_packets, &_bytes);
> > +
> > +	err = virtnet_xsk_xmit_zc(sq, pool, xsk_budget);
> > +	if (!err) {
> > +		struct xdp_desc desc;
> > +
> > +		clear_bit(VIRTNET_STATE_XSK_WAKEUP, &sq->xsk.state);
> > +		xsk_set_tx_need_wakeup(pool);
> > +
> > +		/* Race breaker. If new is coming after last xmit
> > +		 * but before flag change
> > +		 */
> > +
> > +		if (!xsk_tx_peek_desc(pool, &desc))
> > +			goto end;
> > +
> > +		set_bit(VIRTNET_STATE_XSK_WAKEUP, &sq->xsk.state);
> > +		xsk_clear_tx_need_wakeup(pool);
> 
> 
> How memory ordering is going to work here? Or we don't need to care about
> that?
> 
> 
> > +
> > +		sq->xsk.last_desc = desc;
> > +		ret = budget;
> > +		goto end;
> > +	}
> > +
> > +	xsk_clear_tx_need_wakeup(pool);
> > +
> > +	if (err == -EAGAIN) {
> > +		ret = budget;
> > +		goto end;
> > +	}
> > +
> > +	__free_old_xmit_ptr(sq, true, false, &_packets, &_bytes);
> > +
> > +	if (!virtnet_xsk_dev_is_full(sq)) {
> > +		ret = budget;
> > +		goto end;
> > +	}
> > +
> > +	sq->xsk.wait_slot = true;
> > +
> > +	virtnet_sq_stop_check(sq, true);
> > +end:
> > +	return ret;
> > +}
> > +
> >   static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
> >   				      size_t len)
> >   {

