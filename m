Return-Path: <bpf+bounces-27791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5F48B1BAF
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 09:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2811C22F7C
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 07:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A46BFBB;
	Thu, 25 Apr 2024 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bSrZgZUZ"
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF05A7AB;
	Thu, 25 Apr 2024 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029296; cv=none; b=XlbN/k12HmHTLxRLWDR0HeGqPKo7W9nMqoKcw89qHAXUx/6IPALavwF6IQhHuveXj3cGG0qXZ0V0XBiduzBrHqOK/O/mTLL6VZ4pd3tbW3YfOSWZzpsBLsdXqpv0jALB4nXJDwvDeRYiuwwXa9Igrme2RBOfHX87x6aLWP3V3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029296; c=relaxed/simple;
	bh=FbcAIXFHTd/izhlpV83BqQBvkx5ULx32o2W4s4yEuAg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=ZPBGpQISSZjQnhMLKtrcSuEKbeYNtujEnBdfx+r8ul3ahdpkRQaQKCadveT0+eya1pXIiAvt1GV0yWMZf7xr8qhTKBLK8aZluy7wXcEXD60Zpdw/QtvJHiCO8FTsxe+O4WZtPZwsVVX7B0UWqF/jMqwPlO7+Z7sSSsXDJa0bPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bSrZgZUZ; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714029290; h=Message-ID:Subject:Date:From:To;
	bh=shE6b0fVd04Boa5BpyRyRzFXzf9tW9katGzdX6PJz7E=;
	b=bSrZgZUZhF80ynHUG8RoR9cUJQEwvpIT8CSZ06Qe/jz4vtjyKGOrsdgnimDOR/TNZuQwp2ZB8lnS3zcZpe42ey1jfWUdKdxjQh8yd5G2i7SZAxrbKzJgGUi8hlS1mBxxSUcEAwRRk3WJJ86R4fIoIwA7pbrJg4is2+S6HReKDcQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W5Efo1Z_1714029287;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5Efo1Z_1714029287)
          by smtp.aliyun-inc.com;
          Thu, 25 Apr 2024 15:14:49 +0800
Message-ID: <1714029274.2610173-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 8/8] virtio-net: support queue stat
Date: Thu, 25 Apr 2024 15:14:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric  Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S.  Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei  Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Amritha  Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com>
 <20240423113141.1752-9-xuanzhuo@linux.alibaba.com>
 <20240424204422.71c20b3f@kernel.org>
In-Reply-To: <20240424204422.71c20b3f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 24 Apr 2024 20:44:22 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 23 Apr 2024 19:31:41 +0800 Xuan Zhuo wrote:
> > +static void virtnet_get_base_stats(struct net_device *dev,
> > +				   struct netdev_queue_stats_rx *rx,
> > +				   struct netdev_queue_stats_tx *tx)
> > +{
> > +	/* The queue stats of the virtio-net will not be reset. So here we
> > +	 * return 0.
> > +	 */
> > +	rx->bytes = 0;
> > +	rx->packets = 0;
> > +	rx->alloc_fail = 0;
> > +	rx->hw_drops = 0;
> > +	rx->hw_drop_overruns = 0;
> > +	rx->csum_unnecessary = 0;
> > +	rx->csum_none = 0;
> > +	rx->csum_bad = 0;
> > +	rx->hw_gro_packets = 0;
> > +	rx->hw_gro_bytes = 0;
> > +	rx->hw_gro_wire_packets = 0;
> > +	rx->hw_gro_wire_bytes = 0;
> > +	rx->hw_drop_ratelimits = 0;
> > +
> > +	tx->bytes = 0;
> > +	tx->packets = 0;
> > +	tx->hw_drops = 0;
> > +	tx->hw_drop_errors = 0;
> > +	tx->csum_none = 0;
> > +	tx->needs_csum = 0;
> > +	tx->hw_gso_packets = 0;
> > +	tx->hw_gso_bytes = 0;
> > +	tx->hw_gso_wire_packets = 0;
> > +	tx->hw_gso_wire_bytes = 0;
> > +	tx->hw_drop_ratelimits = 0;
>
> Doesn't this need to be conditional based on device capabilities?
> We should only assign the stats that the device is collecting
> (both in base stats and per-queue).


Will be fixed in next version.

Thanks.

