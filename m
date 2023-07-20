Return-Path: <bpf+bounces-5423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 101C075A6DE
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 08:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417E91C212F5
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 06:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B37215492;
	Thu, 20 Jul 2023 06:48:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5214298;
	Thu, 20 Jul 2023 06:48:07 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F72CC;
	Wed, 19 Jul 2023 23:48:05 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vnou-WY_1689835680;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vnou-WY_1689835680)
          by smtp.aliyun-inc.com;
          Thu, 20 Jul 2023 14:48:01 +0800
Message-ID: <1689835514.217712-8-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Thu, 20 Jul 2023 14:45:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
In-Reply-To: <ZLjSsmTfcpaL6H/I@infradead.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 19 Jul 2023 23:22:42 -0700, Christoph Hellwig <hch@infradead.org> wrote:
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

 Sorry I can not got.

 virtqueue_dma_dev() return the device that working with the DMA APIs.
 Then that can be used like other devices. So what is the problem.

 I always think the code path without the DMA APIs is the trouble for you.

 Thanks.


