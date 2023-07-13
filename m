Return-Path: <bpf+bounces-4959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7213975256E
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 16:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700CC1C213B0
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADFA18AE2;
	Thu, 13 Jul 2023 14:47:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA08182D1
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 14:47:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFD5212D
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689259658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iealZFgg2DniFqya6LNgQsH+iMMS+6L0OLnGn56hn70=;
	b=ioyyhIQdEDmfA4nj3+DfifYicrzumfTa/L2r2qQAQqEQxDgGJMzCeMDtEZN59vqrsjjPdP
	BlveEQ3XtrYgCupIQoKmstl2vYUQRBo7XtJDA3cyEjIp2Hgn3cSHlBIHfmu3QvHwZDY7r9
	IKwHhRfinbFPO+Ly4ZU9w/UqNOdcYR4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-b-K3pP0qPeGM59bedQEwQQ-1; Thu, 13 Jul 2023 10:47:29 -0400
X-MC-Unique: b-K3pP0qPeGM59bedQEwQQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2f2981b8364so465573f8f.1
        for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 07:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689259648; x=1691851648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iealZFgg2DniFqya6LNgQsH+iMMS+6L0OLnGn56hn70=;
        b=S6CZoGIVp+9AYpJPijLcdK6XtA57GAMqyYpD/xdMfkMmvO5SGJ3MY7Xuv55LxAh46N
         eUie3mq8xdEPCGgqdjiKLLizIBbzkDsvDmz/OtaL0GVWLpDlKNDBe3ZXPia6l2GzZXes
         bgZMFT5M8qtrwbLK+gpTPTDQKagLGZNRXXd4QXA94+X64pLFuhW8Jb8BZXUKIqo2xR49
         X2u41Z0g433pvx41ioQty1GQrNq0jJm9wrRcgDFYhmGPbLnHphTGLWikzSHPCEMc0qaQ
         3JV2G9XlaAWZgLWLWUedye/th3VtGdnM93pJg9LpJCPd2rHpSJUIw87cje8ZwvOpGHJi
         EaMA==
X-Gm-Message-State: ABy/qLa/TKOnYhyM90QbMLphK1HGUDqBddhUEcZTjG9Nd55UEZLDR0IK
	yyOLw4nSwpXRyFd8yvL+SyEwYHsqBpFnpIKumMhw9hgs/NERkOoX6CKwiWvyIeqRvFDYSj87fEL
	bP9orrNkZNl+J
X-Received: by 2002:a5d:4eca:0:b0:314:362d:6d7b with SMTP id s10-20020a5d4eca000000b00314362d6d7bmr2048949wrv.19.1689259648002;
        Thu, 13 Jul 2023 07:47:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG8e9y7hkjgQHjtW8y2oQn6ZCN15HI4NlGXFd+3he125O+mhw8erfUncBxCq24lPOgrWlvKHg==
X-Received: by 2002:a5d:4eca:0:b0:314:362d:6d7b with SMTP id s10-20020a5d4eca000000b00314362d6d7bmr2048922wrv.19.1689259647712;
        Thu, 13 Jul 2023 07:47:27 -0700 (PDT)
Received: from redhat.com ([2.52.158.233])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4e05000000b003143d80d11dsm8094529wrt.112.2023.07.13.07.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:47:27 -0700 (PDT)
Date: Thu, 13 Jul 2023 10:47:23 -0400
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
Subject: Re: [PATCH vhost v11 03/10] virtio_ring: introduce
 virtqueue_set_premapped()
Message-ID: <20230713104542-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-4-xuanzhuo@linux.alibaba.com>
 <ZK/cpSceLMovhmfR@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK/cpSceLMovhmfR@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 04:14:45AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 11:42:30AM +0800, Xuan Zhuo wrote:
> > This helper allows the driver change the dma mode to premapped mode.
> > Under the premapped mode, the virtio core do not do dma mapping
> > internally.
> > 
> > This just work when the use_dma_api is true. If the use_dma_api is false,
> > the dma options is not through the DMA APIs, that is not the standard
> > way of the linux kernel.
> 
> I have a hard time parsing this.
> 
> More importantly having two modes seems very error prone going down
> the route.  If the premapping is so important, why don't we do it
> always?

There are a gazillion virtio drivers and most of them just use the
virtio API, without bothering with these micro-optimizations.  virtio
already tracks addresses so mapping/unmapping them for DMA is easier
done in the core.  It's only networking and only with XDP where the
difference becomes measureable.

-- 
MST


