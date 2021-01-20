Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67662FC93C
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 04:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbhATDkk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jan 2021 22:40:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731230AbhATDki (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 19 Jan 2021 22:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611113939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hMpWQVmHbHSK936z2VKQJXXK0kbpF2JqsYPVTU1V3I=;
        b=QyDpVaiAy5aO5h/U/6OscpLxlYbsD4Z8e/i4r0B9fiUSVYOxX49sHGPYT11EssuQVC7Nvf
        F20g4DKQxD+VOkS8qVRSmx4l4Na/37elqU+9TSUeIvLYcccoX7nxZFS8wdpuu9QHyM1jj/
        6PlSAlHzo8IsNVWJfu0Pn+/0K/DFBsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-XvZlYRYWPkCLGZelPgEOMw-1; Tue, 19 Jan 2021 22:38:55 -0500
X-MC-Unique: XvZlYRYWPkCLGZelPgEOMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC178107ACE4;
        Wed, 20 Jan 2021 03:38:52 +0000 (UTC)
Received: from [10.72.13.124] (ovpn-13-124.pek2.redhat.com [10.72.13.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC08A62953;
        Wed, 20 Jan 2021 03:38:43 +0000 (UTC)
Subject: Re: [PATCH net-next v2 5/7] virtio-net, xsk: realize the function of
 xsk packet sending
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
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
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <1610971432.9632509-2-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <79578085-61e0-0a5c-dbcf-7c06695c0c7f@redhat.com>
Date:   Wed, 20 Jan 2021 11:38:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610971432.9632509-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2021/1/18 下午8:03, Xuan Zhuo wrote:
> On Mon, 18 Jan 2021 17:10:24 +0800, Jason Wang <jasowang@redhat.com> wrote:
>> On 2021/1/16 上午10:59, Xuan Zhuo wrote:
>>> virtnet_xsk_run will be called in the tx interrupt handling function
>>> virtnet_poll_tx.
>>>
>>> The sending process gets desc from the xsk tx queue, and assembles it to
>>> send the data.
>>>
>>> Compared with other drivers, a special place is that the page of the
>>> data in xsk is used here instead of the dma address. Because the virtio
>>> interface does not use the dma address.
>>>
>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> ---
>>>    drivers/net/virtio_net.c | 200 ++++++++++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 197 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index a62d456..42aa9ad 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -119,6 +119,8 @@ struct virtnet_xsk_hdr {
>>>    	u32 len;
>>>    };
>>>
>>> +#define VIRTNET_STATE_XSK_WAKEUP 1
>>> +
>>>    #define VIRTNET_SQ_STAT(m)	offsetof(struct virtnet_sq_stats, m)
>>>    #define VIRTNET_RQ_STAT(m)	offsetof(struct virtnet_rq_stats, m)
>>>
>>> @@ -163,9 +165,12 @@ struct send_queue {
>>>    		struct xsk_buff_pool   __rcu *pool;
>>>    		struct virtnet_xsk_hdr __rcu *hdr;
>>>
>>> +		unsigned long          state;
>>>    		u64                    hdr_con;
>>>    		u64                    hdr_pro;
>>>    		u64                    hdr_n;
>>> +		struct xdp_desc        last_desc;
>>> +		bool                   wait_slot;
>>>    	} xsk;
>>>    };
>>>
>>> @@ -284,6 +289,8 @@ static void __free_old_xmit_ptr(struct send_queue *sq, bool in_napi,
>>>    				bool xsk_wakeup,
>>>    				unsigned int *_packets, unsigned int *_bytes);
>>>    static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi);
>>> +static int virtnet_xsk_run(struct send_queue *sq,
>>> +			   struct xsk_buff_pool *pool, int budget);
>>>
>>>    static bool is_xdp_frame(void *ptr)
>>>    {
>>> @@ -1590,6 +1597,8 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>>>    	struct virtnet_info *vi = sq->vq->vdev->priv;
>>>    	unsigned int index = vq2txq(sq->vq);
>>>    	struct netdev_queue *txq;
>>> +	struct xsk_buff_pool *pool;
>>> +	int work = 0;
>>>
>>>    	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
>>>    		/* We don't need to enable cb for XDP */
>>> @@ -1599,15 +1608,26 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>>>
>>>    	txq = netdev_get_tx_queue(vi->dev, index);
>>>    	__netif_tx_lock(txq, raw_smp_processor_id());
>>> -	free_old_xmit_skbs(sq, true);
>>> +
>>> +	rcu_read_lock();
>>> +	pool = rcu_dereference(sq->xsk.pool);
>>> +	if (pool) {
>>> +		work = virtnet_xsk_run(sq, pool, budget);
>>> +		rcu_read_unlock();
>>> +	} else {
>>> +		rcu_read_unlock();
>>> +		free_old_xmit_skbs(sq, true);
>>> +	}
>>> +
>>>    	__netif_tx_unlock(txq);
>>>
>>> -	virtqueue_napi_complete(napi, sq->vq, 0);
>>> +	if (work < budget)
>>> +		virtqueue_napi_complete(napi, sq->vq, 0);
>>>
>>>    	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>>>    		netif_tx_wake_queue(txq);
>>>
>>> -	return 0;
>>> +	return work;
>>>    }
>>>
>>>    static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>>> @@ -2647,6 +2667,180 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>>>    	}
>>>    }
>>>
>>> +static int virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>>> +			    struct xdp_desc *desc)
>>> +{
>>> +	struct virtnet_info *vi = sq->vq->vdev->priv;
>>> +	void *data, *ptr;
>>> +	struct page *page;
>>> +	struct virtnet_xsk_hdr *xskhdr;
>>> +	u32 idx, offset, n, i, copy, copied;
>>> +	u64 addr;
>>> +	int err, m;
>>> +
>>> +	addr = desc->addr;
>>> +
>>> +	data = xsk_buff_raw_get_data(pool, addr);
>>> +	offset = offset_in_page(data);
>>> +
>>> +	/* one for hdr, one for the first page */
>>> +	n = 2;
>>> +	m = desc->len - (PAGE_SIZE - offset);
>>> +	if (m > 0) {
>>> +		n += m >> PAGE_SHIFT;
>>> +		if (m & PAGE_MASK)
>>> +			++n;
>>> +
>>> +		n = min_t(u32, n, ARRAY_SIZE(sq->sg));
>>> +	}
>>> +
>>> +	idx = sq->xsk.hdr_con % sq->xsk.hdr_n;
>>
>> I don't understand the reason of the hdr array. It looks to me all of
>> them are zero and read only from device.
>>
>> Any reason for not reusing a single hdr for all xdp descriptors? Or
>> maybe it's time to introduce VIRTIO_NET_F_NO_HDR.
> Yes, You are right.
> Before supporting functions like csum, here it is indeed possible to achieve it
> with only one hdr.


So let's drop the array logic for now since it will give unnecessary 
stress on the cache.


>>
>>> +	xskhdr = &sq->xsk.hdr[idx];
>>> +
>>> +	/* xskhdr->hdr has been memset to zero, so not need to clear again */
>>> +
>>> +	sg_init_table(sq->sg, n);
>>> +	sg_set_buf(sq->sg, &xskhdr->hdr, vi->hdr_len);
>>> +
>>> +	copied = 0;
>>> +	for (i = 1; i < n; ++i) {
>>> +		copy = min_t(int, desc->len - copied, PAGE_SIZE - offset);
>>> +
>>> +		page = xsk_buff_raw_get_page(pool, addr + copied);
>>> +
>>> +		sg_set_page(sq->sg + i, page, copy, offset);
>>> +		copied += copy;
>>> +		if (offset)
>>> +			offset = 0;
>>> +	}
>>
>> It looks to me we need to terminate the sg:
>>
>> **
>>    * virtqueue_add_outbuf - expose output buffers to other end
>>    * @vq: the struct virtqueue we're talking about.
>>    * @sg: scatterlist (must be well-formed and terminated!)
>>
> sg_init_table will call sg_init_table -> sg_init_table to do that.


Oh right, I miss the sg_init_table().


>
>>> +
>>> +	xskhdr->len = desc->len;
>>> +	ptr = xdp_to_ptr(&xskhdr->type);
>>> +
>>> +	err = virtqueue_add_outbuf(sq->vq, sq->sg, n, ptr, GFP_ATOMIC);
>>> +	if (unlikely(err))
>>> +		sq->xsk.last_desc = *desc;
>>> +	else
>>> +		sq->xsk.hdr_con++;
>>> +
>>> +	return err;
>>> +}
>>> +
>>> +static bool virtnet_xsk_dev_is_full(struct send_queue *sq)
>>> +{
>>> +	if (sq->vq->num_free < 2 + MAX_SKB_FRAGS)
>>> +		return true;
>>> +
>>> +	if (sq->xsk.hdr_con == sq->xsk.hdr_pro)
>>> +		return true;
>>
>> Can we really reach here?
> If another program is sending a large number of packages, then num_free may be
> <= 0, and xsk has no chance to send packages.


I meant if num_free <= 2 + MAX_SKB_FRAGS we've already return ture in 
the first check. If num_free > MAX_SKB_FRAGS, hdr array should be 
avaialbe slots for the second check is unnecessary.

Btw, how num_free can be less than zero? The virtio_ring.c will decrease 
num_free only if we had sufficient descriptors:

     if (vq->vq.num_free < descs_used) {
         pr_debug("Can't add buf len %i - avail = %i\n",

>
>>
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +static int virtnet_xsk_xmit_zc(struct send_queue *sq,
>>> +			       struct xsk_buff_pool *pool, unsigned int budget)
>>> +{
>>> +	struct xdp_desc desc;
>>> +	int err, packet = 0;
>>> +	int ret = -EAGAIN;
>>> +
>>> +	if (sq->xsk.last_desc.addr) {
>>> +		err = virtnet_xsk_xmit(sq, pool, &sq->xsk.last_desc);
>>> +		if (unlikely(err))
>>> +			return -EBUSY;
>>> +
>>> +		++packet;
>>> +		sq->xsk.last_desc.addr = 0;
>>> +	}
>>> +
>>> +	while (budget-- > 0) {
>>> +		if (virtnet_xsk_dev_is_full(sq)) {
>>> +			ret = -EBUSY;
>>> +			break;
>>> +		}
>>
>> It looks to me we will always hit this if userspace is fast. E.g we
>> don't kick until the virtqueue is full ...
>>
> Yes, if the user is extremely fast. A kick will be called after the budget here
> is completed. I think this should be enough.


I think we need do some benchmark:

1) always kick (the kick might not happen actually since the device can 
disable notification)
2) kick for every several packets
3) kick for the last

I suspect 3 is not the best solution.

Thanks


>
>>> +
>>> +		if (!xsk_tx_peek_desc(pool, &desc)) {
>>> +			/* done */
>>> +			ret = 0;
>>> +			break;
>>> +		}
>>> +
>>> +		err = virtnet_xsk_xmit(sq, pool, &desc);
>>> +		if (unlikely(err)) {
>>> +			ret = -EBUSY;
>>> +			break;
>>> +		}
>>> +
>>> +		++packet;
>>> +	}
>>> +
>>> +	if (packet) {
>>> +		xsk_tx_release(pool);
>>> +
>>> +		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
>>> +			u64_stats_update_begin(&sq->stats.syncp);
>>> +			sq->stats.kicks++;
>>> +			u64_stats_update_end(&sq->stats.syncp);
>>> +		}
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int virtnet_xsk_run(struct send_queue *sq,
>>> +			   struct xsk_buff_pool *pool, int budget)
>>> +{
>>> +	int err, ret = 0;
>>> +	unsigned int _packets = 0;
>>> +	unsigned int _bytes = 0;
>>> +
>>> +	sq->xsk.wait_slot = false;
>>> +
>>> +	__free_old_xmit_ptr(sq, true, false, &_packets, &_bytes);
>>> +
>>> +	err = virtnet_xsk_xmit_zc(sq, pool, xsk_budget);
>>> +	if (!err) {
>>> +		struct xdp_desc desc;
>>> +
>>> +		clear_bit(VIRTNET_STATE_XSK_WAKEUP, &sq->xsk.state);
>>> +		xsk_set_tx_need_wakeup(pool);
>>> +
>>> +		/* Race breaker. If new is coming after last xmit
>>> +		 * but before flag change
>>> +		 */
>>> +
>>> +		if (!xsk_tx_peek_desc(pool, &desc))
>>> +			goto end;
>>> +
>>> +		set_bit(VIRTNET_STATE_XSK_WAKEUP, &sq->xsk.state);
>>> +		xsk_clear_tx_need_wakeup(pool);
>>
>> How memory ordering is going to work here? Or we don't need to care
>> about that?
>>
> It's my fault.
>
>>> +
>>> +		sq->xsk.last_desc = desc;
>>> +		ret = budget;
>>> +		goto end;
>>> +	}
>>> +
>>> +	xsk_clear_tx_need_wakeup(pool);
>>> +
>>> +	if (err == -EAGAIN) {
>>> +		ret = budget;
>>> +		goto end;
>>> +	}
>>> +
>>> +	__free_old_xmit_ptr(sq, true, false, &_packets, &_bytes);
>>> +
>>> +	if (!virtnet_xsk_dev_is_full(sq)) {
>>> +		ret = budget;
>>> +		goto end;
>>> +	}
>>> +
>>> +	sq->xsk.wait_slot = true;
>>> +
>>> +	virtnet_sq_stop_check(sq, true);
>>> +end:
>>> +	return ret;
>>> +}
>>> +
>>>    static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
>>>    				      size_t len)
>>>    {

