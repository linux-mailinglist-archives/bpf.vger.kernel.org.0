Return-Path: <bpf+bounces-5703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE3F75EAC8
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 07:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DB228150A
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 05:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624311109;
	Mon, 24 Jul 2023 05:18:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF127C;
	Mon, 24 Jul 2023 05:18:26 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD84FF;
	Sun, 23 Jul 2023 22:18:24 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vo0kKJZ_1690175900;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0Vo0kKJZ_1690175900)
          by smtp.aliyun-inc.com;
          Mon, 24 Jul 2023 13:18:21 +0800
Date: Mon, 24 Jul 2023 13:18:20 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Gavin Li <gavinl@nvidia.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, jiri@nvidia.com,
	dtatulea@nvidia.com, gavi@nvidia.com,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next V3 0/4] virtio_net: add per queue interrupt
 coalescing support
Message-ID: <20230724051820.GA53686@h68b04307.sqa.eu95>
References: <20230724034048.51482-1-gavinl@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724034048.51482-1-gavinl@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 06:40:44AM +0300, Gavin Li wrote:
> Currently, coalescing parameters are grouped for all transmit and receive
> virtqueues. This patch series add support to set or get the parameters for
> a specified virtqueue.
> 
> When the traffic between virtqueues is unbalanced, for example, one virtqueue
> is busy and another virtqueue is idle, then it will be very useful to
> control coalescing parameters at the virtqueue granularity.
> 

For series:

Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

After this set is merged, I will issue the netdim patchset on top of this.

Thanks.

> Example command:
> $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
> Would set max_packets=10 to VQ 1.
> $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
> Would set max_packets=10 to VQ 0.
> $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
>  Queue: 0
>  Adaptive RX: off  TX: off
>  stats-block-usecs: 0
>  sample-interval: 0
>  pkt-rate-low: 0
>  pkt-rate-high: 0
> 
>  rx-usecs: 222
>  rx-frames: 0
>  rx-usecs-irq: 0
>  rx-frames-irq: 256
> 
>  tx-usecs: 222
>  tx-frames: 0
>  tx-usecs-irq: 0
>  tx-frames-irq: 256
> 
>  rx-usecs-low: 0
>  rx-frame-low: 0
>  tx-usecs-low: 0
>  tx-frame-low: 0
> 
>  rx-usecs-high: 0
>  rx-frame-high: 0
>  tx-usecs-high: 0
>  tx-frame-high: 0
> 
> Gavin Li (4):
>   virtio_net: extract interrupt coalescing settings to a structure
>   virtio_net: extract get/set interrupt coalesce to a function
>   virtio_net: support per queue interrupt coalesce command
> ---
> changelog:
> v1->v2
> - Addressed the comment from Xuan Zhuo
> - Allocate memory from heap instead of using stack memory for control vq
> 	messages
> v2->v3
> - Addressed the comment from Heng Qi
> - Use control_buf for control vq messages
> ---
>   virtio_net: enable per queue interrupt coalesce feature
> 
>  drivers/net/virtio_net.c        | 172 ++++++++++++++++++++++++++------
>  include/uapi/linux/virtio_net.h |  14 +++
>  2 files changed, 157 insertions(+), 29 deletions(-)
> 
> -- 
> 2.39.1
> 

