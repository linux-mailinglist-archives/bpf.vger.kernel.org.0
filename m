Return-Path: <bpf+bounces-30355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A5C8CCABA
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 04:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB671F220A2
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 02:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445386FA8;
	Thu, 23 May 2024 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SkAm4yGc"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF012567F;
	Thu, 23 May 2024 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716431239; cv=none; b=n9rvTVKN8bkDAmAmmRyoiitd8/ol/GAZp+f2LTQPBRjS6vH0DoI2VfkRrm/RZfIBbYaMgPbbGbTARMMZBruyPdlGqOepRYT+eKzeWBsm2Tvb2XURVQ6fyGFAPeoWZ9zMBbafwHFhhvXLtbDXLXbJXHszIdg6lxVGcc7DqkHIu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716431239; c=relaxed/simple;
	bh=c92CD0brkSJltp7H73QZo8C15p8obsM+Db9+oGP7FQE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=E1MjZ8ewRrKc0hyZmX2abgJNnrdtzf/j5UG1DyqnJNqBCB34IrAyOqbi9SMQYIweReb6vIMhH/rwN6VYEjZUd+15WzdYwkqxFEOF5EzPBpQzAUwy8lgIQCHKH1GmXNSGJMBMC/sm8IqUdboOeb59P4nvvJDRaBvXghcA+f9uRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SkAm4yGc; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716431234; h=Message-ID:Subject:Date:From:To;
	bh=7l4HsM0fJXj4gH6QAm5oEIfdcY7Awf4Ih9BDFuuNwCI=;
	b=SkAm4yGcV43S/G1mrE1csxOnPrgl7LAa5hczKdzgpmEstgunHiguH0s9RQ639gOR3AFuCNXwhN9peTCRlliCeASVwgXzv/gcztKgUpAjwOgKu8yl+WCxA8CeUy/NDHdKzJMgDtRx/mP4n3g/gRcH+s5aqcdJd9qY5RN9OSgt5BA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W711jQ9_1716431232;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W711jQ9_1716431232)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 10:27:13 +0800
Message-ID: <1716431200.2626963-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/7] virtnet_net: prepare for af-xdp
Date: Thu, 23 May 2024 10:26:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Any comments for this.

Thanks.

On Wed,  8 May 2024 16:05:07 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> This patch set prepares for supporting af-xdp zerocopy.
> There is no feature change in this patch set.
> I just want to reduce the patch num of the final patch set,
> so I split the patch set.
>
> #1-#3 add independent directory for virtio-net
> #4-#7 do some refactor, the sub-functions will be used by the subsequent commits
>
> Thanks.
>
> Xuan Zhuo (7):
>   virtio_net: independent directory
>   virtio_net: move core structures to virtio_net.h
>   virtio_net: add prefix virtnet to all struct inside virtio_net.h
>   virtio_net: separate virtnet_rx_resize()
>   virtio_net: separate virtnet_tx_resize()
>   virtio_net: separate receive_mergeable
>   virtio_net: separate receive_buf
>
>  MAINTAINERS                                   |   2 +-
>  drivers/net/Kconfig                           |   9 +-
>  drivers/net/Makefile                          |   2 +-
>  drivers/net/virtio/Kconfig                    |  12 +
>  drivers/net/virtio/Makefile                   |   8 +
>  drivers/net/virtio/virtnet.h                  | 246 ++++++++
>  .../{virtio_net.c => virtio/virtnet_main.c}   | 534 ++++++------------
>  7 files changed, 452 insertions(+), 361 deletions(-)
>  create mode 100644 drivers/net/virtio/Kconfig
>  create mode 100644 drivers/net/virtio/Makefile
>  create mode 100644 drivers/net/virtio/virtnet.h
>  rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (94%)
>
> --
> 2.32.0.3.g01195cf9f
>

