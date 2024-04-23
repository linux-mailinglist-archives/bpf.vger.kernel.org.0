Return-Path: <bpf+bounces-27501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4108ADD43
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 07:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3652A282E71
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 05:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8C621A0B;
	Tue, 23 Apr 2024 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rKOHiYNA"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A12A18AED;
	Tue, 23 Apr 2024 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713851808; cv=none; b=MYYkiXDIWcP+4v8WtVJLz0mYqEtOANP2xWu1eunN0q3d/dOPVjbyVfTYcChjYh2WqGIcSiC8zxrvqB1GD+l+/tbNvH7C3HoHLDbXWyLTPQ9/vZaAdZuJL8I/8hW84gMToGC2IWMnua6fm4VaF1dufy58kj73k00x9kdfiwhpUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713851808; c=relaxed/simple;
	bh=FUtZ1xvClmdmTBUAURFroa1ipOw8c203HiCdSlH64dw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=L7HCoZeZQihdesiXfDfVMxS7X3WKDBH8hz5IOyF4vNkaZ8vcVuiPsFUAqyaTZZ/c8eqR7Xg9RRD4c302dnSS1JKaec0mYigJu7RxHMv4DTZ3kr95cbqCujKaf7DtMiRBuhyjnggXtXsV3CI8FcYWdcJDOY4dp+ofyXVZc1XLOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rKOHiYNA; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713851798; h=Message-ID:Subject:Date:From:To;
	bh=GHCysremovBWIsP3Dli5jXdc1mNQf4cWC+uRc/bjoJ0=;
	b=rKOHiYNAhdPe3I6hOURp9VOToaGqs9Gr0YsaXUfTs/Ec2PGqZfg/GcXewnYwHXXNuaoPFD3ynLpL60HGdSBNTMT0lw7cy59Yr7uKUd0yRodnLTP5+RTyNdEllRrWAS+6z7jROasQgJjJ7JICJ71ccN39iRa5Tq2uqfQrkPjaNgo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W57uPlJ_1713851795;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W57uPlJ_1713851795)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 13:56:36 +0800
Message-ID: <1713851675.6547418-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Date: Tue, 23 Apr 2024 13:54:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Amritha Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <20240422163231-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240422163231-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 22 Apr 2024 16:33:01 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Mar 18, 2024 at 07:05:53PM +0800, Xuan Zhuo wrote:
> > As the spec:
> >
> > https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> >
> > The virtio net supports to get device stats.
> >
> > Please review.
>
> series:
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> I think you can now repost for net-next.

Thanks for your ack.

I and Jason discussed  a way to remove the "maps".

I will post a new patch set with that.

Thanks.


>
>
> > Thanks.
> >
> > v5:
> >     1. Fix some small problems in last version
> >     2. Not report stats that will be reported by netlink
> >     3. remove "_queue" from  ethtool -S
> >
> > v4:
> >     1. Support per-queue statistics API
> >     2. Fix some small problems in last version
> >
> > v3:
> >     1. rebase net-next
> >
> > v2:
> >     1. fix the usage of the leXX_to_cpu()
> >     2. add comment to the structure virtnet_stats_map
> >
> > v1:
> >     1. fix some definitions of the marco and the struct
> >
> >
> >
> >
> >
> >
> > Xuan Zhuo (9):
> >   virtio_net: introduce device stats feature and structures
> >   virtio_net: virtnet_send_command supports command-specific-result
> >   virtio_net: remove "_queue" from ethtool -S
> >   virtio_net: support device stats
> >   virtio_net: stats map include driver stats
> >   virtio_net: add the total stats field
> >   virtio_net: rename stat tx_timeout to timeout
> >   netdev: add queue stats
> >   virtio-net: support queue stat
> >
> >  Documentation/netlink/specs/netdev.yaml | 104 ++++
> >  drivers/net/virtio_net.c                | 755 +++++++++++++++++++++---
> >  include/net/netdev_queues.h             |  27 +
> >  include/uapi/linux/netdev.h             |  19 +
> >  include/uapi/linux/virtio_net.h         | 143 +++++
> >  net/core/netdev-genl.c                  |  23 +-
> >  tools/include/uapi/linux/netdev.h       |  19 +
> >  7 files changed, 1013 insertions(+), 77 deletions(-)
> >
> > --
> > 2.32.0.3.g01195cf9f
>

