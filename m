Return-Path: <bpf+bounces-4961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEE7752591
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 16:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A22E281BAB
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 14:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F118AE9;
	Thu, 13 Jul 2023 14:52:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA817754
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 14:52:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C542D47
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689259927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5E6F9ats4BLmlQpCisZt6wT8CnApvl7BR9/00bgFE+o=;
	b=LJaL6GD549bXVdn+u3oS8xk3v5iJMb7zUvHcy1iUowkCAFN01Ejp2Q5v1f8KtRSOJQtKgQ
	O+XdssDYyMXeWN3vNrLIfDcZts8hRs+Z5YC25qN0lwYLBQ9k5cla+Yggl1W5dHZ0+KRopw
	BD3f5YeEZ/7Pd5/2dc3lXTg5DnQl4kE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-bsR4Ibi4PdifpmPeKauIhg-1; Thu, 13 Jul 2023 10:52:05 -0400
X-MC-Unique: bsR4Ibi4PdifpmPeKauIhg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3142665f122so470884f8f.0
        for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 07:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689259924; x=1691851924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5E6F9ats4BLmlQpCisZt6wT8CnApvl7BR9/00bgFE+o=;
        b=cv1eIjKcOcU6AH/cSDqBzB968P7tkceVfQcR+c3C4RrE161b2G54dIHCXl0skd+NVX
         k5QjFyWYeUzzCXHJ6bUwv8N09zC5jsqoT7pJktBVSrpsY02j80mNE8c5gdP5GsERjXRF
         PcG5CoOTbc5gICnbmoNa2JZBqTxrlDpJiejI+pjux+58PIcGKbACq7PtYAvXvd2mG2pu
         SotJOcxwDAY077J5xBvGEMQn7RnMshN2C1WCovpnsLrhEq7EVV4zxiS5Qlisi2UgS0av
         uTs4NCytp/YZ2SltCX3eV4dLJNQlXJ/iyQqKnBiGlekh3jZLswkU0gvG+o9g0o38SbK5
         GW5Q==
X-Gm-Message-State: ABy/qLbYp+tk4Ax2YrnGV3UvTMvBsBeR0G4W1/x06/YdzBO3h+vsnD6B
	/F0VkKSsb9DICsYq9u+XWeLOI2mm2PN9xUeNq9MFpXAgjO4+fPc+BRYRcyw+TsyiMixg82al+BO
	mD28d/AHyMYLB
X-Received: by 2002:a5d:4e8d:0:b0:314:ca7:f30b with SMTP id e13-20020a5d4e8d000000b003140ca7f30bmr1958300wru.54.1689259924770;
        Thu, 13 Jul 2023 07:52:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFRuSHTNPf9qN+kahsoUR/nmIalfm3YfEdwlFil6U+7gTdTpuIDAdjWTT/+bCM2yDuYWb+3kQ==
X-Received: by 2002:a5d:4e8d:0:b0:314:ca7:f30b with SMTP id e13-20020a5d4e8d000000b003140ca7f30bmr1958277wru.54.1689259924514;
        Thu, 13 Jul 2023 07:52:04 -0700 (PDT)
Received: from redhat.com ([2.52.158.233])
        by smtp.gmail.com with ESMTPSA id s15-20020adff80f000000b00313f9a0c521sm8253520wrp.107.2023.07.13.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:52:04 -0700 (PDT)
Date: Thu, 13 Jul 2023 10:51:59 -0400
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
Message-ID: <20230713104805-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK/cxNHzI23I6efc@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 04:15:16AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 11:42:32AM +0800, Xuan Zhuo wrote:
> > Added virtqueue_dma_dev() to get DMA device for virtio. Then the
> > caller can do dma operation in advance. The purpose is to keep memory
> > mapped across multiple add/get buf operations.
> 
> This is just poking holes into the abstraction..

More specifically?

-- 
MST


