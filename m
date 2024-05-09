Return-Path: <bpf+bounces-29157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0526D8C098E
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 04:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994701F2256C
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 02:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E66313CA9C;
	Thu,  9 May 2024 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x0fHOcq7"
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2252313CA84;
	Thu,  9 May 2024 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220082; cv=none; b=i6SDJnrqXrsLzsgpPiON35hRCEGjJW3EYlYNUz05/BmTp06CwARDYow0QgpdGQda7tMN9K8jHq0klQ9aMdVECddwlMMfcRb1h0sfuWbXGbW49KkOXFKSuG1dVYHHPweLGwv/RDT6P+TRXCHEPYVcw6HwEuoDKK1dGLwi+Y3Br1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220082; c=relaxed/simple;
	bh=Htat2MyTse7a++9pWJqbBAP7hMj1nNpg55KHQ5NcWBM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=o0lKW3vZ2q6hs5h6HMxJyQfeW+Wf3nRxu5ij5ABq16E4vtmYw/VnQsE3vz3fzEmUY+1nmnAsAfbt77hKdk76/LzTl288X13SxULu0Hqy3HoEN/rHgbXmwHepneWhRxWi5uPzt75OshYetpiQ2HRoelveWIFrUjz9//taaK7/QWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x0fHOcq7; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715220070; h=Message-ID:Subject:Date:From:To;
	bh=cQQB8y7lyMs6fyaeOrFr4e4tsBpA8NP9fB/55KyIbmA=;
	b=x0fHOcq7OuXr0jHj7EWurbzBYzPATTvLNjJvNR/5OQHIdyTD9HtT3t+rvUfQFuJ/4ZF95gL5nXhkW8rG4Eb1C/+qUDbFgMQQYhe7vz6aJXDDjMvfVHRIOpqL1w1gYavKhB0+XV+JEXCP7kRGzVS04AqnK7u/tveNNLJSOjOL/i4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W650tlQ_1715220068;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W650tlQ_1715220068)
          by smtp.aliyun-inc.com;
          Thu, 09 May 2024 10:01:09 +0800
Message-ID: <1715219893.9627535-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/7] virtnet_net: prepare for af-xdp
Date: Thu, 9 May 2024 09:58:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 "David S.  Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo  Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason  Wang <jasowang@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel  Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
 <20240508085308.GA1736038@kernel.org>
 <20240508082000.4938fb56@kernel.org>
In-Reply-To: <20240508082000.4938fb56@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 8 May 2024 08:20:00 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 8 May 2024 09:53:08 +0100 Simon Horman wrote:
> > On Wed, May 08, 2024 at 04:05:07PM +0800, Xuan Zhuo wrote:
> > > This patch set prepares for supporting af-xdp zerocopy.
> > > There is no feature change in this patch set.
> > > I just want to reduce the patch num of the final patch set,
> > > so I split the patch set.
> > >
> > > #1-#3 add independent directory for virtio-net
> > > #4-#7 do some refactor, the sub-functions will be used by the subsequent commits
> >
> > Hi Xuan Zhuo,
> >
> > This patch is targeted at net-next,
> > but unfortunately it does not apply to current net-next.
> > Please rebase and repost taking care to observe the 24h rule.
>
> Also - is this going to conflict with your premapped DMA work in the
> vhost tree? If it does - just wait, please, the merge window is in
> a week..

NO.

This is on the top of

	http://lore.kernel.org/all/20240508063718.69806-1-xuanzhuo@linux.alibaba.com

That is targeted to net-next.

I will wait until it is merged to repost.

Thanks.


