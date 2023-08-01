Return-Path: <bpf+bounces-6589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D6D76B98A
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 18:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AA92811F1
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3589214E5;
	Tue,  1 Aug 2023 16:17:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8545B1ADFB
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 16:17:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF37185
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690906675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5c5x2m4IYrem8PdNKSvmUfDJDtRMMxft9vUT5B0Fjk=;
	b=c/4sNp7XaCKMR2OwETuIHdCdtjnzmlVvFVWQlY9o7RIdCK5itzNaQVBe3Vl+hBmImmeME9
	fgSwkM/6OdR0P0RwAn4y2Z/JtaAAGjkwvReGL6U6aceaTqt55eY91NT4xOuBZ/fUwoXVJL
	tGDhxA4v6HoNch3QPHa5B5kIWj28i/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-9e9DPRHZOiGWd1IqUMByHg-1; Tue, 01 Aug 2023 12:17:53 -0400
X-MC-Unique: 9e9DPRHZOiGWd1IqUMByHg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so31324095e9.2
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 09:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690906672; x=1691511472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5c5x2m4IYrem8PdNKSvmUfDJDtRMMxft9vUT5B0Fjk=;
        b=E72iNISBmPOdhskLjN874+yyD1nk5YU9T0ZYwo0Fe3qdgTa4fwsN0Mm6jbQFh6t0nB
         VM6BTTqTA15Dht/w7Oz2xXkVG3o7bFjLWN2sNJI4jDmPLsxuOlNZt7lXJjajE7hJhx3f
         6GBmbF00Y02m6che27Rdmq5sGoQEHpZquyBre3S6q4xWWRUtblw0FwdpNVAqZ5LeMnRU
         A8VgH8jULyK4UDLxiFkUjAxznG3eDTWHi0qEtKzRT4tggQcu+NoI9Tkinsb+KoReTh47
         H1gyLzA4Xj62BMMbMtos93y9i5XNgAnPW0mat2PVumx/ox7V/Y1P5vYeQFKVB0AOSeGG
         bzsg==
X-Gm-Message-State: ABy/qLalpEDucs0NumjkIfdY5/nJj7cuGnR17opzuHgliNpIuO3e8hFx
	amptS8a3U3/6IxZOcxZcDPtktCv7nkqYnNCCXL5U27MrDw+tPqg09Wd+sdSGeiRnTnS0MKDJ47U
	w36ftT0PFZjAy
X-Received: by 2002:a1c:f719:0:b0:3fe:188c:b684 with SMTP id v25-20020a1cf719000000b003fe188cb684mr2874889wmh.7.1690906672680;
        Tue, 01 Aug 2023 09:17:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHzGaEDuesnxEFzI0n611DuR5a4DRd8NJaxHoq6B/0W1UuZ3GQSQuSUE+vdJPZJwfyXDPDA7Q==
X-Received: by 2002:a1c:f719:0:b0:3fe:188c:b684 with SMTP id v25-20020a1cf719000000b003fe188cb684mr2874878wmh.7.1690906672372;
        Tue, 01 Aug 2023 09:17:52 -0700 (PDT)
Received: from redhat.com ([2.52.21.81])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b003fe1b3e0852sm4530904wms.0.2023.08.01.09.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 09:17:51 -0700 (PDT)
Date: Tue, 1 Aug 2023 12:17:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	virtualization@lists.linux-foundation.org,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce
 virtqueue_dma_dev()
Message-ID: <20230801121543-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 02:02:33PM +0800, Xuan Zhuo wrote:
> On Tue, 25 Jul 2023 19:07:23 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > On Tue, 25 Jul 2023 03:34:34 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Tue, Jul 25, 2023 at 10:13:48AM +0800, Xuan Zhuo wrote:
> > > > On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > > > > On Thu, Jul 20, 2023 at 01:21:07PM -0400, Michael S. Tsirkin wrote:
> > > > > > Well I think we can add wrappers like virtio_dma_sync and so on.
> > > > > > There are NOP for non-dma so passing the dma device is harmless.
> > > > >
> > > > > Yes, please.
> > > >
> > > >
> > > > I am not sure I got this fully.
> > > >
> > > > Are you mean this:
> > > > https://lore.kernel.org/all/20230214072704.126660-8-xuanzhuo@linux.alibaba.com/
> > > > https://lore.kernel.org/all/20230214072704.126660-9-xuanzhuo@linux.alibaba.com/
> > > >
> > > > Then the driver must do dma operation(map and sync) by these virtio_dma_* APIs.
> > > > No care the device is non-dma device or dma device.
> > >
> > > yes
> > >
> > > > Then the AF_XDP must use these virtio_dma_* APIs for virtio device.
> > >
> > > We'll worry about AF_XDP when the patch is posted.
> >
> > YES.
> >
> > We discussed it. They voted 'no'.
> >
> > http://lore.kernel.org/all/20230424082856.15c1e593@kernel.org
> 
> 
> Hi guys, this topic is stuck again. How should I proceed with this work?
> 
> Let me briefly summarize:
> 1. The problem with adding virtio_dma_{map, sync} api is that, for AF_XDP and
> the driver layer, we need to support these APIs. The current conclusion of
> AF_XDP is no.
> 
> 2. Set dma_set_mask_and_coherent, then we can use DMA API uniformly inside
> driver. This idea seems to be inconsistent with the framework design of DMA. The
> conclusion is no.
> 
> 3. We noticed that if the virtio device supports VIRTIO_F_ACCESS_PLATFORM, it
> uses DMA API. And this type of device is the future direction, so we only
> support DMA premapped for this type of virtio device. The problem with this
> solution is that virtqueue_dma_dev() only returns dev in some cases, because
> VIRTIO_F_ACCESS_PLATFORM is supported in such cases. Otherwise NULL is returned.
> This option is currently NO.
> 
> So I'm wondering what should I do, from a DMA point of view, is there any
> solution in case of using DMA API?
> 
> Thank you


I think it's ok at this point, Christoph just asked you
to add wrappers for map/unmap for use in virtio code.
Seems like a cosmetic change, shouldn't be hard.
Otherwise I haven't seen significant comments.


Christoph do I summarize what you are saying correctly?
-- 
MST


