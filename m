Return-Path: <bpf+bounces-14718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C0A7E78FB
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E52FB20FBD
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075ED46A7;
	Fri, 10 Nov 2023 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLN9KXQO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17D93C36
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:11:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F2D4B
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699596696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C0FBlN0CWGiDM52kXk7prl9hTa/PXsYBXY2rSTMy4sg=;
	b=aLN9KXQOyQOccjwJJAW9bQToQqxC/fdkhxhRWakVzN40mT6MaZy3AKpdPogy2Z923jTQAQ
	OOrgIIxX36oOHxa/2QoFbCZR06gnBcRRo3/Dfzv/gBvp/KyzkZIL/Dt8tJMQsWzrRuZ2yK
	k8gdyXNy7iaamt56i5EHw9vlw2/gW3g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-lJ_MW8lwM5CjnSNRbk_HxQ-1; Fri, 10 Nov 2023 00:32:56 -0500
X-MC-Unique: lJ_MW8lwM5CjnSNRbk_HxQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9dd489c98e7so128329866b.2
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 21:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699594376; x=1700199176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0FBlN0CWGiDM52kXk7prl9hTa/PXsYBXY2rSTMy4sg=;
        b=DJd3sG42A4YcnYqQIIza5QHX9UXsDYI4LDRWcZuDpx3VCpBcK/+VSq/GEi76PPg8BA
         j8SP6eNjhEMuA5s/dZfUTXJfYNuhpx/DecMT7MyowDBnzabqd5Nf2x3mVuX5zhG+Cgb6
         XIKrZ4hJr238Ow2+Lf/4o3z4mTpxf5YMy2LNXXuaDdWNOfpM8hvZv7HdeoycStTTfKwi
         TQXJl8UhYvYS+9gkOTdK5iuU+YJ7i7VL1TASS7A91a/EERdcHgs5fXzrdw1O461yePxc
         hYHcQRssqm0sZ7bMuTMHtbhVkGbVXkz6O3xJhMC33YqxttCLskn0SCTKy7SojY8VbPbE
         UXwA==
X-Gm-Message-State: AOJu0YzzmyyVIZrqWkXQ/uCBnlBUk/jHyki4V1nlx0jooPUIWAhrvIPg
	e0ISJGWRJ0ZVkGe7siVqaFtalXF6GsGZppDekRsEfvlYyRigvmlnJvTwmzxof8Jsc82C7eqL9i4
	bp98DsD++yC7Z
X-Received: by 2002:a17:907:2ce1:b0:9a1:f81f:d0d5 with SMTP id hz1-20020a1709072ce100b009a1f81fd0d5mr5593465ejc.54.1699594375868;
        Thu, 09 Nov 2023 21:32:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQHgHsq1zGzHRPaMJsrJwpfnDPFYKTZAF6+/FP3fqYhqWEjlgdvAZs5yADDFKLMEEWVfwUyA==
X-Received: by 2002:a17:907:2ce1:b0:9a1:f81f:d0d5 with SMTP id hz1-20020a1709072ce100b009a1f81fd0d5mr5593450ejc.54.1699594375562;
        Thu, 09 Nov 2023 21:32:55 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id mj10-20020a170906af8a00b009ddcf5b07b8sm3461131ejb.148.2023.11.09.21.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:32:54 -0800 (PST)
Date: Fri, 10 Nov 2023 00:32:50 -0500
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
Message-ID: <20231110003159-mutt-send-email-mst@kernel.org>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-15-xuanzhuo@linux.alibaba.com>
 <20231109061056-mutt-send-email-mst@kernel.org>
 <1699528568.0674586-6-xuanzhuo@linux.alibaba.com>
 <20231109065912-mutt-send-email-mst@kernel.org>
 <1699580672.387567-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699580672.387567-1-xuanzhuo@linux.alibaba.com>

On Fri, Nov 10, 2023 at 09:44:32AM +0800, Xuan Zhuo wrote:
> On Thu, 9 Nov 2023 06:59:48 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Nov 09, 2023 at 07:16:08PM +0800, Xuan Zhuo wrote:
> > > On Thu, 9 Nov 2023 06:11:49 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Tue, Nov 07, 2023 at 11:12:20AM +0800, Xuan Zhuo wrote:
> > > > > virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
> > > > > buffer) by the last bits of the pointer.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio/virtio_net.h | 18 ++++++++++++++++--
> > > > >  drivers/net/virtio/xsk.h        |  5 +++++
> > > > >  2 files changed, 21 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
> > > > > index a431a2c1ee47..a13d6d301fdb 100644
> > > > > --- a/drivers/net/virtio/virtio_net.h
> > > > > +++ b/drivers/net/virtio/virtio_net.h
> > > > > @@ -225,6 +225,11 @@ struct virtnet_info {
> > > > >  	struct failover *failover;
> > > > >  };
> > > > >
> > > > > +static inline bool virtnet_is_skb_ptr(void *ptr)
> > > > > +{
> > > > > +	return !((unsigned long)ptr & VIRTIO_XMIT_DATA_MASK);
> > > > > +}
> > > > > +
> > > > >  static inline bool virtnet_is_xdp_frame(void *ptr)
> > > > >  {
> > > > >  	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> > > > > @@ -235,6 +240,8 @@ static inline struct xdp_frame *virtnet_ptr_to_xdp(void *ptr)
> > > > >  	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
> > > > >  }
> > > > >
> > > > > +static inline u32 virtnet_ptr_to_xsk(void *ptr);
> > > > > +
> > > >
> > > > I don't understand why you need this here.
> > >
> > > The below function virtnet_free_old_xmit needs this.
> > >
> > > Thanks.
> >
> > I don't understand why is virtnet_free_old_xmit inline, either.
> 
> That is in the header file.
> 

It does not belong there.


> >
> > > >
> > > >
> > > > >  static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
> > > > >  {
> > > > >  	struct virtnet_sq_dma *next, *head;
> > > > > @@ -261,11 +268,12 @@ static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
> > > > >  static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > > > >  					 u64 *bytes, u64 *packets)
> > > > >  {
> > > > > +	unsigned int xsknum = 0;
> > > > >  	unsigned int len;
> > > > >  	void *ptr;
> > > > >
> > > > >  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> > > > > -		if (!virtnet_is_xdp_frame(ptr)) {
> > > > > +		if (virtnet_is_skb_ptr(ptr)) {
> > > > >  			struct sk_buff *skb;
> > > > >
> > > > >  			if (sq->do_dma)
> > > > > @@ -277,7 +285,7 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > > > >
> > > > >  			*bytes += skb->len;
> > > > >  			napi_consume_skb(skb, in_napi);
> > > > > -		} else {
> > > > > +		} else if (virtnet_is_xdp_frame(ptr)) {
> > > > >  			struct xdp_frame *frame;
> > > > >
> > > > >  			if (sq->do_dma)
> > > > > @@ -287,9 +295,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > > > >
> > > > >  			*bytes += xdp_get_frame_len(frame);
> > > > >  			xdp_return_frame(frame);
> > > > > +		} else {
> > > > > +			*bytes += virtnet_ptr_to_xsk(ptr);
> > > > > +			++xsknum;
> > > > >  		}
> > > > >  		(*packets)++;
> > > > >  	}
> > > > > +
> > > > > +	if (xsknum)
> > > > > +		xsk_tx_completed(sq->xsk.pool, xsknum);
> > > > >  }
> > > > >
> > > > >  static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> > > > > diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> > > > > index 1bd19dcda649..7ebc9bda7aee 100644
> > > > > --- a/drivers/net/virtio/xsk.h
> > > > > +++ b/drivers/net/virtio/xsk.h
> > > > > @@ -14,6 +14,11 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
> > > > >  	return (void *)(p | VIRTIO_XSK_FLAG);
> > > > >  }
> > > > >
> > > > > +static inline u32 virtnet_ptr_to_xsk(void *ptr)
> > > > > +{
> > > > > +	return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
> > > > > +}
> > > > > +
> > > > >  int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
> > > > >  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> > > > >  		      int budget);
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > >
> > > >
> >


