Return-Path: <bpf+bounces-5805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976C4760BFE
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 09:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D03281736
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 07:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF71097E;
	Tue, 25 Jul 2023 07:35:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD559446
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 07:35:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1DF4209
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 00:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690270482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlVTXLyWcMpMPMMm7emcajIWT4tUJXS33YzR+iu8MUw=;
	b=WFzYSvc8fS4ekvBWJ645ATUf4YDeGDKUpK9E6iplByVi7LflHwtxgY/q8PpY1wxS/3sTsE
	13RbEKXQRnOEVG6X3eg0FYaxQ9/ErUCfP10ZVcJ7XIftcH0ncNH593Bf4bcwjdMbGf5N8v
	ymhypeXmp0U73t4VXwh2EbXzAzD+OTU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-kmHKAnyoN6iO2BjxELhwzA-1; Tue, 25 Jul 2023 03:34:40 -0400
X-MC-Unique: kmHKAnyoN6iO2BjxELhwzA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993d500699fso386232266b.1
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 00:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690270480; x=1690875280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlVTXLyWcMpMPMMm7emcajIWT4tUJXS33YzR+iu8MUw=;
        b=OPev4WIz3/0faRNErMypJ2TYCNq80m9t2G5BLGZKEhG4AcGb20CkWo3wVPShkXH1Ny
         YELvhUK9WBRC9YgNJ9sDOZbPoZp/nzP1SlLI50yGoB3yHi/du8wEkuU7WEPTuIg9NXlo
         HlULmUFIuz3nElefYb8LX2jMVQyWfJquyLm3+K5e9DyjhE2Yoo3T5TgcS1VAFnlWesdl
         Cd+QYV8QZPZJUchgOmFQRbyMbJIEDOenndiJfa7ayWjGgKt3ty6to5YReApc6QDlRRU5
         mIA1CqcvDl/SCzgD1+5A7wJMPzEwr9eL0ma0HlQykwzYBMynsuYHbwRl8zbijJ5uJiMX
         uYVA==
X-Gm-Message-State: ABy/qLZmJw45af3rti1H5IaFmuqnJid1oaCANMFtoXDfDxduvrsGKqwi
	C2k8lF+jI6hpjgAP2orM/NHZ2PUK7Q3Ic9VnsqzfDCYl+MJMXBepkMQb651wiorpCxvteZI5V7l
	rb9f/Z2zrPPT/
X-Received: by 2002:a17:906:3281:b0:99b:48d3:5488 with SMTP id 1-20020a170906328100b0099b48d35488mr12217607ejw.24.1690270479823;
        Tue, 25 Jul 2023 00:34:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHNg+hM1hzoNAK32i8hsz4doeAFqPyABedd7VMtD2jNuY0tQh5xK77D0UqFEO1XA6riO6GpBA==
X-Received: by 2002:a17:906:3281:b0:99b:48d3:5488 with SMTP id 1-20020a170906328100b0099b48d35488mr12217587ejw.24.1690270479464;
        Tue, 25 Jul 2023 00:34:39 -0700 (PDT)
Received: from redhat.com ([2.55.164.187])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709063fd000b009894b476310sm7790738ejj.163.2023.07.25.00.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:34:38 -0700 (PDT)
Date: Tue, 25 Jul 2023 03:34:34 -0400
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
Message-ID: <20230725033321-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 10:13:48AM +0800, Xuan Zhuo wrote:
> On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > On Thu, Jul 20, 2023 at 01:21:07PM -0400, Michael S. Tsirkin wrote:
> > > Well I think we can add wrappers like virtio_dma_sync and so on.
> > > There are NOP for non-dma so passing the dma device is harmless.
> >
> > Yes, please.
> 
> 
> I am not sure I got this fully.
> 
> Are you mean this:
> https://lore.kernel.org/all/20230214072704.126660-8-xuanzhuo@linux.alibaba.com/
> https://lore.kernel.org/all/20230214072704.126660-9-xuanzhuo@linux.alibaba.com/
> 
> Then the driver must do dma operation(map and sync) by these virtio_dma_* APIs.
> No care the device is non-dma device or dma device.

yes

> Then the AF_XDP must use these virtio_dma_* APIs for virtio device.

We'll worry about AF_XDP when the patch is posted.

-- 
MST


