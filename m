Return-Path: <bpf+bounces-30990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EA58D587C
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 04:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BC7283D1E
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 02:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC2757F3;
	Fri, 31 May 2024 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZZjTlWT+"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1A5FBBA;
	Fri, 31 May 2024 02:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120936; cv=none; b=FuajlNiTkR2rjPtQM4z5zq+xA7baldcbHVBTXe0z+t7an2IoaP4j0V4+/87uEcE37jGGdQ0l4RMglYUjVTJnKsffjCvhEjqF/YJ5fp+aAqska4Zn5g8kfbhIXaaxab6JSA4USNbV2/ykX8GAL7fJ4qANT5XP1mZ7Ip9/zVO+z5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120936; c=relaxed/simple;
	bh=5Qd0+YkPbyEFtmhmhsPZSrhbDlVPAjQSs8XXnIwKSvM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=PXkCkCb3Kx53/wiL1DAgJgLPdR/wAJ/V37zjq5C3oEve6CZAaklVgvYUTnuzkvzShKThDvZRgNC4fX+s5UZ1Bou4fG3vW9Q6Tc2oATk4DGgM5Qh+ukK7h83oMbvdi9GVKt8T/y97xzFVhkRQKuZo7edIVWK7wag3ni+X1D+D9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZZjTlWT+; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717120929; h=Message-ID:Subject:Date:From:To;
	bh=5Qd0+YkPbyEFtmhmhsPZSrhbDlVPAjQSs8XXnIwKSvM=;
	b=ZZjTlWT+Nz8CDcPZ20xthn5GHGJlJ7S+q74BGPEjPQmPInWuWSM8G/R19AVSCaMQAD1AEaJ3/IMMMqQx3+x8vE32iL1NH/ibpTCHpxUmY9Kz3pLiyVPNQbsYjb2s3OlbCaJUdYrCsCQ1sDNrycB2/dVqBum+du5dw4pRKO+VMss=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7YFVXu_1717120928;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7YFVXu_1717120928)
          by smtp.aliyun-inc.com;
          Fri, 31 May 2024 10:02:08 +0800
Message-ID: <1717120653.9337146-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 00/12] virtnet_net: prepare for af-xdp
Date: Fri, 31 May 2024 09:57:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
 <20240530075003-mutt-send-email-mst@kernel.org>
 <1717070084.6955814-1-xuanzhuo@linux.alibaba.com>
 <1717119614.404968-1-xuanzhuo@linux.alibaba.com>
 <20240530185517.33ba5daa@kernel.org>
In-Reply-To: <20240530185517.33ba5daa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 30 May 2024 18:55:17 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri, 31 May 2024 09:40:14 +0800 Xuan Zhuo wrote:
> > On Thu, 30 May 2024 19:54:44 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > On Thu, 30 May 2024 07:53:17 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > It's great that you are working on this but
> > > > I'd like to see the actual use of this first.
> > >
> > >
> > > For me, that is easy. But how should we do, if we use one patch set,
> > > then the commit number maybe 26, that exceeds 15 (limit of the net next).
> >
> > Hi, Jakub
> >
> > There will be a huge patch set (about 25) to support AF-XDP for virtio-net.
> > Can I just post this huge patch set if the maintainers of virtio-net agree?
>
> First of all, I see you posted v2 within 4 hours of v1, without really
> waiting for Michael to reply.

Because I was checking the code, I found some commits need to be prepared also.

> So I guess that 15 patch rule is not the
> only one you intend to break?

Actually, that is the only one rule.

>
> On v1 Michael asked you to not do the rename, and start with AF_XDP
> support. Why don't you do that instead of asking me if you can break
> more rules?

Because if I don't rename the files, there will still be about 21 commits. For
me, I don't think this is the key. If I release everything in one patch set,
then I think Michael can understand why I want to rename the files.

Thanks.


> --
> pw-bot: cr

