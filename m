Return-Path: <bpf+bounces-5787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80117760526
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 04:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFE7281729
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 02:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C251FAB;
	Tue, 25 Jul 2023 02:20:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E07C;
	Tue, 25 Jul 2023 02:20:39 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454FFE7E;
	Mon, 24 Jul 2023 19:20:37 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VoAy6vH_1690251632;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VoAy6vH_1690251632)
          by smtp.aliyun-inc.com;
          Tue, 25 Jul 2023 10:20:33 +0800
Message-ID: <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 25 Jul 2023 10:13:48 +0800
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
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
In-Reply-To: <ZL6qPvd6X1CgUD4S@infradead.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Jul 20, 2023 at 01:21:07PM -0400, Michael S. Tsirkin wrote:
> > Well I think we can add wrappers like virtio_dma_sync and so on.
> > There are NOP for non-dma so passing the dma device is harmless.
>
> Yes, please.


I am not sure I got this fully.

Are you mean this:
https://lore.kernel.org/all/20230214072704.126660-8-xuanzhuo@linux.alibaba.com/
https://lore.kernel.org/all/20230214072704.126660-9-xuanzhuo@linux.alibaba.com/

Then the driver must do dma operation(map and sync) by these virtio_dma_* APIs.
No care the device is non-dma device or dma device.

Then the AF_XDP must use these virtio_dma_* APIs for virtio device.

Thanks


