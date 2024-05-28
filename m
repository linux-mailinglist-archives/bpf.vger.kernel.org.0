Return-Path: <bpf+bounces-30702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3A48D11A2
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 04:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEA42846C6
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 02:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE5ED53B;
	Tue, 28 May 2024 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hiHQCh2E"
X-Original-To: bpf@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CDB168BE;
	Tue, 28 May 2024 02:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862090; cv=none; b=QHwghbwF4k7JfIJ81Ek20dE8ItitJbfLbufxjJFTlYzTLS2fULSyZU38G1AMQacaAYu4BwCawghN57MliUOGfzlAQHzK8uwIbvqjb7n25cqG9aEBbU2nQvaLY8Du8yi2ozpqsQXsMPc+bQhKxONJg84SGaUDZRE0GjJ12AJ5RV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862090; c=relaxed/simple;
	bh=bGdpMC8w5NDXkvYx9bP9RlgD8bYpxSq37c5brwI9jHk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=tHGnF5NL3ljcGXVxx/Swfsz5Ma5ukM4usMrtSPuwK7Ep6VBXNAz9k7TcwoO8k7ZPVYtX9se0LpcJCwkSBP9Bxm1NWDmSfsNKD3iTNfIODOxmsL6lQdFUyXHt6CtFiNwl70nfKMsLx5ng8tlWWPVUX0hcs4v/M0bt3RvcB9f1tpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hiHQCh2E; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716862079; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=kbM3v+okdOZwQr8Ru327hBw//y8G7Jb+NPx7ac9Ui1A=;
	b=hiHQCh2EOaXep7DzxM9iw41NrEGVGjrNbEcNRRoxG03wXgU0MCfN7xmWLeO+e9+l8kjWyN0uNUBzBQjWYmFesEwbjevo5RWLBo0V/HT8Cg/vLZx2UkvmDPry3gNQHSAoWjc5PQ9hUW+yVw3AoQq8CSj2jPvwPfZFXlwub42AaiY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7O67O4_1716862077;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7O67O4_1716862077)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 10:07:58 +0800
Message-ID: <1716862000.5541763-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/7] virtnet_net: prepare for af-xdp
Date: Tue, 28 May 2024 10:06:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
 <1716431200.2626963-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsKgwgATiuiA4_DcrwtoGp4XT__GakKVYNJ=EcOOG9zew@mail.gmail.com>
In-Reply-To: <CACGkMEsKgwgATiuiA4_DcrwtoGp4XT__GakKVYNJ=EcOOG9zew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 27 May 2024 11:38:49 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, May 23, 2024 at 10:27=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > Any comments for this.
> >
> > Thanks.
>
> Will have a look.
>
> Btw, does Michael happy with moving files into a dedicated directory?


Based on our previous discussions, I believe that he is okay.

Thanks


>
> Thanks
>
> >
> > On Wed,  8 May 2024 16:05:07 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
> > > This patch set prepares for supporting af-xdp zerocopy.
> > > There is no feature change in this patch set.
> > > I just want to reduce the patch num of the final patch set,
> > > so I split the patch set.
> > >
> > > #1-#3 add independent directory for virtio-net
> > > #4-#7 do some refactor, the sub-functions will be used by the subsequ=
ent commits
> > >
> > > Thanks.
> > >
> > > Xuan Zhuo (7):
> > >   virtio_net: independent directory
> > >   virtio_net: move core structures to virtio_net.h
> > >   virtio_net: add prefix virtnet to all struct inside virtio_net.h
> > >   virtio_net: separate virtnet_rx_resize()
> > >   virtio_net: separate virtnet_tx_resize()
> > >   virtio_net: separate receive_mergeable
> > >   virtio_net: separate receive_buf
> > >
> > >  MAINTAINERS                                   |   2 +-
> > >  drivers/net/Kconfig                           |   9 +-
> > >  drivers/net/Makefile                          |   2 +-
> > >  drivers/net/virtio/Kconfig                    |  12 +
> > >  drivers/net/virtio/Makefile                   |   8 +
> > >  drivers/net/virtio/virtnet.h                  | 246 ++++++++
> > >  .../{virtio_net.c =3D> virtio/virtnet_main.c}   | 534 ++++++--------=
----
> > >  7 files changed, 452 insertions(+), 361 deletions(-)
> > >  create mode 100644 drivers/net/virtio/Kconfig
> > >  create mode 100644 drivers/net/virtio/Makefile
> > >  create mode 100644 drivers/net/virtio/virtnet.h
> > >  rename drivers/net/{virtio_net.c =3D> virtio/virtnet_main.c} (94%)
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>

