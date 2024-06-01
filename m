Return-Path: <bpf+bounces-31080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBCB8D6D3A
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 03:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549A41F24C83
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 01:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149054C8C;
	Sat,  1 Jun 2024 01:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="du9P3Xko"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD32582;
	Sat,  1 Jun 2024 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717204531; cv=none; b=N9Ki9rAvRbq7cMjJL3HNS3m/n9ciQa/W3iJjZAdDZ3tVGv41NkUHPvbaoAOEwPF4Q/oOA3U5v/U//m2rNVEO4T+RdnAicCg/vuDogO7HnEHeGQIOYqW4VMv0SP16wdvkuxbGQrgkOcRjYX0FKzHNLvmCTPVR15Re8OPzbnpFxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717204531; c=relaxed/simple;
	bh=8njHc4+OQxH6Zvo0xJgYYXhAprYJryPWqzqHTO7+d1Y=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=QyhsVyaUi9noIYtSXYkxjQJlDLpRzcyAXuPTrxv/X0HBh7wAzA/pl7LFhviGBzorC/ZP5Jm/6QIFPurmI76e/CN4GfGFbZzkIVSQ5YyQILBoI41+fUembR6jNAH2lvKol6epEDpAjOmXPM3Zfb8bbMmLLI9nCE9YaqlNA5nOAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=du9P3Xko; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717204520; h=Message-ID:Subject:Date:From:To;
	bh=7c9v1vjRkw+eOQnY17pAKIlCydJpq+ODaejt+ncs1Os=;
	b=du9P3XkokTkzMZZ1ONDAopbWg66PL4JLiNeZ6EPAGwVoow1TCNIxOw6Yk/VFreSzIF4ekSrIHhSo/jVPeT+eGRTZXkiFwEWzeMR2BnQ+Zitva76sXqjTc7OsZ2wCFucCEfceDDam6+t9GJnw9sl25xJaGVtAHUOyCSsRmfuwVbA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7bCb3w_1717204518;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7bCb3w_1717204518)
          by smtp.aliyun-inc.com;
          Sat, 01 Jun 2024 09:15:19 +0800
Message-ID: <1717203689.8004525-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 00/12] virtnet_net: prepare for af-xdp
Date: Sat, 1 Jun 2024 09:01:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
 <20240530075003-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240530075003-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 30 May 2024 07:53:17 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, May 30, 2024 at 07:23:54PM +0800, Xuan Zhuo wrote:
> > This patch set prepares for supporting af-xdp zerocopy.
> > There is no feature change in this patch set.
> > I just want to reduce the patch num of the final patch set,
> > so I split the patch set.
> >
> > Thanks.
> >
> > v2:
> >     1. Add five commits. That provides some helper for sq to support premapped
> >        mode. And the last one refactors distinguishing xmit types.
> >
> > v1:
> >     1. resend for the new net-next merge window
> >
>
>
> It's great that you are working on this but
> I'd like to see the actual use of this first.

I want to finish this work quickly. I don't have a particular preference for
whether to use a separate directory; as an engineer, I think it makes sense. I
don't want to keep dwelling on this issue. I also hope that as a maintainer, you
can help me complete this work as soon as possible. You should know that I have
been working on this for about three years now.

I can completely follow your suggestion regarding splitting the directory.
However, there will still be many patches, so I hope that these patches in this
patch set can be merged first.

   virtio_net: separate virtnet_rx_resize()
   virtio_net: separate virtnet_tx_resize()
   virtio_net: separate receive_mergeable
   virtio_net: separate receive_buf
   virtio_net: refactor the xmit type

I will try to compress the subsequent patch sets, hoping to reduce them to about 15.

Thanks.


>
> >
> > Xuan Zhuo (12):
> >   virtio_net: independent directory
> >   virtio_net: move core structures to virtio_net.h
> >   virtio_net: add prefix virtnet to all struct inside virtio_net.h
> >   virtio_net: separate virtnet_rx_resize()
> >   virtio_net: separate virtnet_tx_resize()
> >   virtio_net: separate receive_mergeable
> >   virtio_net: separate receive_buf
> >   virtio_ring: introduce vring_need_unmap_buffer
> >   virtio_ring: introduce dma map api for page
> >   virtio_ring: introduce virtqueue_dma_map_sg_attrs
> >   virtio_ring: virtqueue_set_dma_premapped() support to disable
> >   virtio_net: refactor the xmit type
> >
> >  MAINTAINERS                                   |   2 +-
> >  drivers/net/Kconfig                           |   9 +-
> >  drivers/net/Makefile                          |   2 +-
> >  drivers/net/virtio/Kconfig                    |  12 +
> >  drivers/net/virtio/Makefile                   |   8 +
> >  drivers/net/virtio/virtnet.h                  | 248 ++++++++
> >  .../{virtio_net.c => virtio/virtnet_main.c}   | 596 +++++++-----------
> >  drivers/virtio/virtio_ring.c                  | 118 +++-
> >  include/linux/virtio.h                        |  12 +-
> >  9 files changed, 606 insertions(+), 401 deletions(-)
> >  create mode 100644 drivers/net/virtio/Kconfig
> >  create mode 100644 drivers/net/virtio/Makefile
> >  create mode 100644 drivers/net/virtio/virtnet.h
> >  rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (93%)
> >
> > --
> > 2.32.0.3.g01195cf9f
>

