Return-Path: <bpf+bounces-5522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6442775B57F
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 19:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959041C214FE
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AC32FA50;
	Thu, 20 Jul 2023 17:21:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8B2FA4B
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 17:21:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4857B19AD
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 10:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689873675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wSM6GucX481b3eiLRGSzd0Yk4eXovV4UB3ZZIve6VjA=;
	b=F/KlzH0qVwEjL63HZZ5VMc9kSoQQoNx0wHlWxsDKoje4SyCfm12kGm2Oi5ZnF1Q+DvvAZv
	35wRs6aUKs2IFOCIlC1jPSw1i2pbS7ahExDQXrjXw/kmesTNlMsxOTJxVSJhcNrPIOZ21b
	kcv5sRikmOQ8uxvU5edMPmsBj/kIJBQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111--H0RDS74MvidFDPtsj45RQ-1; Thu, 20 Jul 2023 13:21:13 -0400
X-MC-Unique: -H0RDS74MvidFDPtsj45RQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-315af0252c2so624644f8f.0
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 10:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689873672; x=1690478472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSM6GucX481b3eiLRGSzd0Yk4eXovV4UB3ZZIve6VjA=;
        b=KpXTW7/aotPS/3g9o1c+9mNJuNodFTSwprB6U/dLuKICgVmoG5YkvxS7k2BmkRlJH6
         +4zMzGJ0Gcsu1Thdr4sfEMvtegfYJTO5XuBPhHYQFAnPb/jWyGJS5rYJ3kS7NxcVbvbN
         xJm0khfxlRxzqGyVqEoxUerMLrmaz/DkVRWTluDm4KK16uY5d5xhTsEDERHcMOoFhrWT
         e9qRAnqnsj/5J4BQiBf693p8vue5wHZubPNAIOSksQCMpq64dJuIO4KuBuuOAnfBIoaT
         6mpcIhWYEMNNjMe/C0UvL8Y4LDUUL/jkkCXuCBrVZoF51SrRBSgl2mKYomYoH8Kfc6Au
         fdyQ==
X-Gm-Message-State: ABy/qLaEczkgbI7efRAp5sxwbtZQ6q+cJsB+4SXtTkOj1zb8GnO5HdwF
	2gtkAB+Fv6yQrv/DHwb9a9DkxKHBRV5Np5LFiZQPkQtwoBsdbNUIVCOQV4FU37mtV8/E2rERMKn
	RI91G7W2Pz7gS
X-Received: by 2002:a5d:6649:0:b0:314:1224:dbb8 with SMTP id f9-20020a5d6649000000b003141224dbb8mr2499444wrw.21.1689873672595;
        Thu, 20 Jul 2023 10:21:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF007YE1yWjdVWFoof0oyKSncqv4aObnTbLud+fUTRyjhlewOkL5ydanAjocCMP5uLzKLoEew==
X-Received: by 2002:a5d:6649:0:b0:314:1224:dbb8 with SMTP id f9-20020a5d6649000000b003141224dbb8mr2499428wrw.21.1689873672296;
        Thu, 20 Jul 2023 10:21:12 -0700 (PDT)
Received: from redhat.com ([2.52.16.41])
        by smtp.gmail.com with ESMTPSA id a5-20020adfdd05000000b0031433d8af0dsm1873233wrm.18.2023.07.20.10.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 10:21:11 -0700 (PDT)
Date: Thu, 20 Jul 2023 13:21:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
Message-ID: <20230720131928-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLjSsmTfcpaL6H/I@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 11:22:42PM -0700, Christoph Hellwig wrote:
> On Thu, Jul 13, 2023 at 10:51:59AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 13, 2023 at 04:15:16AM -0700, Christoph Hellwig wrote:
> > > On Mon, Jul 10, 2023 at 11:42:32AM +0800, Xuan Zhuo wrote:
> > > > Added virtqueue_dma_dev() to get DMA device for virtio. Then the
> > > > caller can do dma operation in advance. The purpose is to keep memory
> > > > mapped across multiple add/get buf operations.
> > > 
> > > This is just poking holes into the abstraction..
> > 
> > More specifically?
> 
> Because now you expose a device that can't be used for the non-dma
> mapping case and shoud be hidden.


Ah, ok.
Well I think we can add wrappers like virtio_dma_sync and so on.
There are NOP for non-dma so passing the dma device is harmless.

-- 
MST


