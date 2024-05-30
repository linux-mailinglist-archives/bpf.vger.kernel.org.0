Return-Path: <bpf+bounces-30922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DDD8D46C3
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 10:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA71286E95
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 08:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719D147C71;
	Thu, 30 May 2024 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="COWzOnr6"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC855898;
	Thu, 30 May 2024 08:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056640; cv=none; b=ld7l0fUJoQSK8fJ+88HRCiYQ7OWOgJ1v2G5YTo7FbIsgNNHehk+L9gg+BrBmZJJHu3Lr/+RQ3yT3DQLFZ9xiJ7cHmq1MNLsxqDZibuQaTvPggrmBrG3JH0DQZjxqMQA397F5wansUG/B/AJC0CC9cjZYaYRQExc8zsN4G6MtC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056640; c=relaxed/simple;
	bh=GLzxHdzRl2iItoZp0xM8DrqAyA8JpFmL8jvdJEihmBI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=AHQ904Rome0ZlDyX2eyjLkQWPadjq07gTozh1kIHl26SkV6W1GGt1nlcAvWUleuyBF2DsTbmN7esTI2qFal36WJClGROwBc9P9/Nw6aB5sYule8VO83zyGYJYDBHsj/cz4/FV8tBgAzQVn6fCJVirmCmalzbtYpDt/YbRrzPY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=COWzOnr6; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717056634; h=Message-ID:Subject:Date:From:To;
	bh=p7v6dFet5uex4RBTfnO23XVSl7MKtg20v2AYV+GGHaI=;
	b=COWzOnr6dEmqueDm7bxWsXimTmzKq4vvXba9tomgDVSy90GHK1HVcHCpf1O08UCBthnZ3bCmU2WlQFXnBsFGIpzGTrAvdlb56OFsd7BfPk1tnqX4O5iQgyZoEufEKfQz9taL2jYikj1Phe2ZNPcTQTZx7D+ycESiH8QSlLMdMSY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7WF7gX_1717056633;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7WF7gX_1717056633)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 16:10:33 +0800
Message-ID: <1717056010.897231-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 0/7] virtnet_net: prepare for af-xdp
Date: Thu, 30 May 2024 16:00:10 +0800
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
References: <20240530072649.102437-1-xuanzhuo@linux.alibaba.com>
 <20240530034921-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240530034921-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 30 May 2024 03:55:35 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, May 30, 2024 at 03:26:42PM +0800, Xuan Zhuo wrote:
> > This patch set prepares for supporting af-xdp zerocopy.
> > There is no feature change in this patch set.
> > I just want to reduce the patch num of the final patch set,
> > so I split the patch set.
> >
> > #1-#3 add independent directory for virtio-net
> > #4-#7 do some refactor, the sub-functions will be used by the subsequent commits
> >
> > Thanks.
> >
> > v1:
> >     1. resend for the new net-next merge window
>
> What I said at the time is
>
> 	I am fine adding xsk in a new file or just adding in same file working on a split later.
>
> Given this was a year ago and all we keep seing is "prepare" patches,
> I am inclined to say do it in the reverse order: add
> af-xdp first then do the split when it's clear there is not
> a lot of code sharing going on.

If all is done in one patch set, maybe is ok. But we have about 14 commits for
af-xdp. If that patch set includes these commits, then we will exceed 15
(net-next limits the commit number of one patch set).

I separated these patches from the final patch set because I think these commits
can exist independently even without af-xdp.

Whether the final xsk should use a separate file, we can look at it in future
patches. If you think we can merge it into one file, I am also OK with it.
Although other drivers currently use separate files.

So if you think this patch set itself is fine, then I hope we can merge this
first.

Thanks.

>
>
> >
> > Xuan Zhuo (7):
> >   virtio_net: independent directory
> >   virtio_net: move core structures to virtio_net.h
> >   virtio_net: add prefix virtnet to all struct inside virtio_net.h
> >   virtio_net: separate virtnet_rx_resize()
> >   virtio_net: separate virtnet_tx_resize()
> >   virtio_net: separate receive_mergeable
> >   virtio_net: separate receive_buf
> >
> >  MAINTAINERS                                   |   2 +-
> >  drivers/net/Kconfig                           |   9 +-
> >  drivers/net/Makefile                          |   2 +-
> >  drivers/net/virtio/Kconfig                    |  12 +
> >  drivers/net/virtio/Makefile                   |   8 +
> >  drivers/net/virtio/virtnet.h                  | 248 ++++++++
> >  .../{virtio_net.c => virtio/virtnet_main.c}   | 536 ++++++------------
> >  7 files changed, 454 insertions(+), 363 deletions(-)
> >  create mode 100644 drivers/net/virtio/Kconfig
> >  create mode 100644 drivers/net/virtio/Makefile
> >  create mode 100644 drivers/net/virtio/virtnet.h
> >  rename drivers/net/{virtio_net.c => virtio/virtnet_main.c} (94%)
> >
> > --
> > 2.32.0.3.g01195cf9f
>

