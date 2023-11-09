Return-Path: <bpf+bounces-14585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940577E6A30
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 13:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4979B2816B2
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645C1CFB9;
	Thu,  9 Nov 2023 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P19/4jUT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0961A1CAA4
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 11:59:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6013851
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 03:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699531195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XBwh9BfcsGwN4p/3iVkVIw7CCYFfvzovBsgfhDaKJj0=;
	b=P19/4jUTFgu/MKmnhwbrVY8YIluj+2UDWupAWIi5/vSopmGuwEeYHYStAoHZ6YU5oll3Je
	e3z7ZTI/JRPjMTgiB7PB+zFCn1eMdHAQD6sVVjyzC6Dc2GANV7BIQrSGHuuzieixvjKpDA
	Z8YF93s1kDLNtI2lmoIyVPmG384/bVc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-X4AUH4L6NPKxY_F3J9r8Eg-1; Thu, 09 Nov 2023 06:59:54 -0500
X-MC-Unique: X4AUH4L6NPKxY_F3J9r8Eg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9d30a6a67abso60463166b.2
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 03:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699531193; x=1700135993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBwh9BfcsGwN4p/3iVkVIw7CCYFfvzovBsgfhDaKJj0=;
        b=j2U+f4GQfAo9GrTv86fdhHYQPwk3XEo5bU4dyvM6Ju92qvGXd6XJF0GKhkB6zYncpY
         barD9dEQLPV6pCRa6IDCjVQ6YFFizYymRgkWmSnEBmEgS/vjqQrI35XcXZDkOooxPSYl
         yPVLr2yod1XC+bF6MQM7cgafHODMvgteY1SNE6UEZ4APm9paS8+MxSHzai06pkjLtebF
         wz1WIGFlWuuSgDkcyalj+isqF0xf+ybmHnMlwNuV14AOhXOx1wqf3vug2la+QVrdOgnu
         6regcv17pKc11NhSkRVpgmXsxMJFgWaS7y9IHzvqC34l50HWfhKLo/DfhD3ZrKSjKh4n
         DgqQ==
X-Gm-Message-State: AOJu0YxXnVUtYG/ZOfo+8R/1jGLvt3bKHGdR3KYzHQKF4dMymurm3k2P
	q3S3xbTVctdUhvPhIQSnnI9360V4KvbHJ3FOMuuhZ0/VrC60t5Ko6hnVuMLk9WUqvl0m10IVjTS
	QjoKNvMKHIBe3
X-Received: by 2002:a17:907:744:b0:9de:32bb:faab with SMTP id xc4-20020a170907074400b009de32bbfaabmr3907939ejb.32.1699531193537;
        Thu, 09 Nov 2023 03:59:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMY+vJ5AkmDkv/+cqz1oiQHT3s2m2UmdbF1nYIjYe0sBg3Jp/+950PgPxklsw5ykh2i/4Kyw==
X-Received: by 2002:a17:907:744:b0:9de:32bb:faab with SMTP id xc4-20020a170907074400b009de32bbfaabmr3907913ejb.32.1699531193110;
        Thu, 09 Nov 2023 03:59:53 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id ss24-20020a170907039800b009de3fd8cbfasm2450555ejb.0.2023.11.09.03.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:59:52 -0800 (PST)
Date: Thu, 9 Nov 2023 06:59:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 14/21] virtio_net: xsk: tx:
 virtnet_free_old_xmit() distinguishes xsk buffer
Message-ID: <20231109065912-mutt-send-email-mst@kernel.org>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-15-xuanzhuo@linux.alibaba.com>
 <20231109061056-mutt-send-email-mst@kernel.org>
 <1699528568.0674586-6-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699528568.0674586-6-xuanzhuo@linux.alibaba.com>

On Thu, Nov 09, 2023 at 07:16:08PM +0800, Xuan Zhuo wrote:
> On Thu, 9 Nov 2023 06:11:49 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Nov 07, 2023 at 11:12:20AM +0800, Xuan Zhuo wrote:
> > > virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
> > > buffer) by the last bits of the pointer.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio/virtio_net.h | 18 ++++++++++++++++--
> > >  drivers/net/virtio/xsk.h        |  5 +++++
> > >  2 files changed, 21 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > > index a431a2c1ee47..a13d6d301fdb 100644
> > > --- a/drivers/net/virtio/virtio_net.h
> > > +++ b/drivers/net/virtio/virtio_net.h
> > > @@ -225,6 +225,11 @@ struct virtnet_info {
> > >  	struct failover *failover;
> > >  };
> > >
> > > +static inline bool virtnet_is_skb_ptr(void *ptr)
> > > +{
> > > +	return !((unsigned long)ptr & VIRTIO_XMIT_DATA_MASK);
> > > +}
> > > +
> > >  static inline bool virtnet_is_xdp_frame(void *ptr)
> > >  {
> > >  	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> > > @@ -235,6 +240,8 @@ static inline struct xdp_frame *virtnet_ptr_to_xdp(void *ptr)
> > >  	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
> > >  }
> > >
> > > +static inline u32 virtnet_ptr_to_xsk(void *ptr);
> > > +
> >
> > I don't understand why you need this here.
> 
> The below function virtnet_free_old_xmit needs this.
> 
> Thanks.

I don't understand why is virtnet_free_old_xmit inline, either.

> >
> >
> > >  static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
> > >  {
> > >  	struct virtnet_sq_dma *next, *head;
> > > @@ -261,11 +268,12 @@ static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
> > >  static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > >  					 u64 *bytes, u64 *packets)
> > >  {
> > > +	unsigned int xsknum = 0;
> > >  	unsigned int len;
> > >  	void *ptr;
> > >
> > >  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> > > -		if (!virtnet_is_xdp_frame(ptr)) {
> > > +		if (virtnet_is_skb_ptr(ptr)) {
> > >  			struct sk_buff *skb;
> > >
> > >  			if (sq->do_dma)
> > > @@ -277,7 +285,7 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > >
> > >  			*bytes += skb->len;
> > >  			napi_consume_skb(skb, in_napi);
> > > -		} else {
> > > +		} else if (virtnet_is_xdp_frame(ptr)) {
> > >  			struct xdp_frame *frame;
> > >
> > >  			if (sq->do_dma)
> > > @@ -287,9 +295,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > >
> > >  			*bytes += xdp_get_frame_len(frame);
> > >  			xdp_return_frame(frame);
> > > +		} else {
> > > +			*bytes += virtnet_ptr_to_xsk(ptr);
> > > +			++xsknum;
> > >  		}
> > >  		(*packets)++;
> > >  	}
> > > +
> > > +	if (xsknum)
> > > +		xsk_tx_completed(sq->xsk.pool, xsknum);
> > >  }
> > >
> > >  static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> > > diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> > > index 1bd19dcda649..7ebc9bda7aee 100644
> > > --- a/drivers/net/virtio/xsk.h
> > > +++ b/drivers/net/virtio/xsk.h
> > > @@ -14,6 +14,11 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
> > >  	return (void *)(p | VIRTIO_XSK_FLAG);
> > >  }
> > >
> > > +static inline u32 virtnet_ptr_to_xsk(void *ptr)
> > > +{
> > > +	return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
> > > +}
> > > +
> > >  int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
> > >  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> > >  		      int budget);
> > > --
> > > 2.32.0.3.g01195cf9f
> >
> >


