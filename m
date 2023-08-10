Return-Path: <bpf+bounces-7425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31A5777095
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 08:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44361C2146D
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 06:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBE61C30;
	Thu, 10 Aug 2023 06:40:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41258EA3
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 06:40:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC48E4B
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 23:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691649642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mpAVHBguoEYSzp1zJv4UMPmI6nbgaJQrFx4hgJVwo4I=;
	b=SgpTqDpNfwFC7ATASlWq0PPnJKhL9gKrFs53ZPYqdjsl19HLErpOcwo0P6bI9AT3m+5icv
	8sVEFhePpikMvanSrrDshsyEONmnMypOsz5jT9hyNKp9pX3e3RW4lSShtr3XdgogcvUv9I
	dICa2NWB38gkN3ZyenowLW93w2Z3Gvo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-MxoY4j-mNdKqCrJtBXXheA-1; Thu, 10 Aug 2023 02:40:41 -0400
X-MC-Unique: MxoY4j-mNdKqCrJtBXXheA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso3261155e9.2
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 23:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691649640; x=1692254440;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpAVHBguoEYSzp1zJv4UMPmI6nbgaJQrFx4hgJVwo4I=;
        b=LEyIMsu/rzAJIpwKcnhwFg+zqHWRqAU7e4ICCH4ze/f/9vwR+TjZRPr72Y4drRa1EK
         do0HNLsPngvO6CFiA54vssKpJ64Dy5Aldp8p2dHL+xVnsBEIbP6hxmt2ZUKRdbuPNytn
         8NCPwm0R1NfsTXeaaSrwC79w1hFCuwqyuJRH/BPVmU3dSFtLb/dhljh2pX9Z4qXf0Vgf
         oa1oYDObWrLHyo3HsuAPkec1BBwPs+Skt0RY5RuOK0FS++rN3JEgLtRR5jFbRBhI/EU7
         iNHjRUOUjg2eNwdTQ55l6ENrmwHEu+m7ECmX9CPLMn2oCxuPCWJUJWiKlae8/EVjE2Ic
         vE8w==
X-Gm-Message-State: AOJu0YwoD3BMLi4ffQwHWE5Dsf2YO/iNaQxCtpDZEV6bT0RWhco7VcAk
	t7+Hq+n2ikbMVxb01H4jl8cAUR78MuFm2CEE/iiGdwZ9+CEnIHXyh7eW9zbWgm7rOXmsVrpQaWC
	TF80xISMTk8I5
X-Received: by 2002:a05:600c:450:b0:3fe:16c8:65fa with SMTP id s16-20020a05600c045000b003fe16c865famr1121041wmb.4.1691649639922;
        Wed, 09 Aug 2023 23:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCM6lkgAXBlz0LUqL1E+QXYUzuyeeUE3clBD4wLwypBgmV9fSOtf45rM0/vHayWl88OQHUtg==
X-Received: by 2002:a05:600c:450:b0:3fe:16c8:65fa with SMTP id s16-20020a05600c045000b003fe16c865famr1121034wmb.4.1691649639742;
        Wed, 09 Aug 2023 23:40:39 -0700 (PDT)
Received: from redhat.com ([2.52.137.93])
        by smtp.gmail.com with ESMTPSA id h18-20020a1ccc12000000b003fbd9e390e1sm4008587wmb.47.2023.08.09.23.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 23:40:39 -0700 (PDT)
Date: Thu, 10 Aug 2023 02:40:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Christoph Hellwig <hch@infradead.org>,
	virtualization@lists.linux-foundation.org,
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
Message-ID: <20230810024024-mutt-send-email-mst@kernel.org>
References: <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230801121543-mutt-send-email-mst@kernel.org>
 <1690940971.9409487-2-xuanzhuo@linux.alibaba.com>
 <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
 <1691632614.950658-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuBytsv3uZcEVMKU_JvSzfHxXU9Er3Yha7=DqjMMDxpng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuBytsv3uZcEVMKU_JvSzfHxXU9Er3Yha7=DqjMMDxpng@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 02:37:20PM +0800, Jason Wang wrote:
> On Thu, Aug 10, 2023 at 9:59 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> >
> > Ping!!
> >
> > Could we push this to the next linux version?
> 
> How about implementing the wrappers along with virtqueue_dma_dev() to
> see if Christoph is happy?
> 
> Thanks

That, too.

> >
> > Thanks.
> >


