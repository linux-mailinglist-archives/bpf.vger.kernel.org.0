Return-Path: <bpf+bounces-34024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4577B929A79
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 03:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E379D1F211C4
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 01:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2C115A5;
	Mon,  8 Jul 2024 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rRU1pcaz"
X-Original-To: bpf@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF0B138C;
	Mon,  8 Jul 2024 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720401277; cv=none; b=bQM9fPZE2cHftCKZb1sKLBLN1cRb+WZXqCXVCBeG+zQs1w2flVqANBH1d5RURKeSQcv9nQxwoWXdU0a/D/ICw82+3ay68H0SZ7ChZ2/kCBk+yxCogKrGhYwvKA0/WvqjF0Aj/OW5Qq3872GZXdUAaRKUguP6cUqN9bFAf4L/FQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720401277; c=relaxed/simple;
	bh=EGmHsUM7ZsL9j5vb+SBvndZ+Ey2bRq7reIiZ1/jYTHc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=b8/xL38McswmwnGdJwNprl8ze27RhNBJw88meMYX3CwvqooX1/vBB51rZJILAS3k8w78UvqCrWgwXQZqXKmkoLBQFUCmSbPC0z9xVkOmWe6bOJxSFpkKTAyIBJmrnlIm1jsgZ8LzWwuTDbxtfs2jhEN4eIawwLQNQUEbCDcQ1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rRU1pcaz; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720401267; h=Message-ID:Subject:Date:From:To;
	bh=P4rq0mWeMYsjQWe1jWnuZ3Q9oiMae8YokG5kTWRSh4s=;
	b=rRU1pcaz0Q9vNgNsWIJntRm/9dKUlVpBr2PFPpV7iOMuBftjoA9dmlo83nEcEoaau49JpjUBHKn7+93Fg4zBINahhowCdNw7GZrdEMQqVrRho+/zKS3l4BYaTuXYUakfvFQriiHQYlSlkE5WjGB4Aw6ON2bms1mQQMCXXw7k1fc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0WA-WzDY_1720401265;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WA-WzDY_1720401265)
          by smtp.aliyun-inc.com;
          Mon, 08 Jul 2024 09:14:26 +0800
Message-ID: <1720401065.058343-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v7 00/10] virtio-net: support AF_XDP zero copy
Date: Mon, 8 Jul 2024 09:11:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: <netdev@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 <virtualization@lists.linux.dev>,
 <bpf@vger.kernel.org>
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com>
 <Zof/rP1Tn2bsWYBO@localhost.localdomain>
In-Reply-To: <Zof/rP1Tn2bsWYBO@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, 5 Jul 2024 16:14:04 +0200, Michal Kubiak <michal.kubiak@intel.com> wrote:
> On Fri, Jul 05, 2024 at 03:37:24PM +0800, Xuan Zhuo wrote:
> > v6:
> >     1. start from supporting the rx zerocopy
> >
> > v5:
> >     1. fix the comments of last version
> >         http://lore.kernel.org/all/20240611114147.31320-1-xuanzhuo@linux.alibaba.com
> > v4:
> >     1. remove the commits that introduce the independent directory
> >     2. remove the supporting for the rx merge mode (for limit 15
> >        commits of net-next). Let's start with the small mode.
> >     3. merge some commits and remove some not important commits
> >
> > ## AF_XDP
> >
> > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> > copy feature of xsk (XDP socket) needs to be supported by the driver. The
> > performance of zero copy is very good. mlx5 and intel ixgbe already support
> > this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> > feature.
> >
> > At present, we have completed some preparation:
> >
> > 1. vq-reset (virtio spec and kernel code)
> > 2. virtio-core premapped dma
> > 3. virtio-net xdp refactor
> >
> > So it is time for Virtio-Net to complete the support for the XDP Socket
> > Zerocopy.
> >
> >
>
> After taking a look at this series I haven't found adding
> NETDEV_XDP_ACT_XSK_ZEROCOPY flag to netdev->xdp_features.
> Is it intentional or just an oversight?


Because there are too many commits, the work of virtio net supporting af-xdp is
split to rx part and tx part. This patch set is for rx part. The flags will be
update after tx part.

Thanks.




>
> Thanks,
> Michal

