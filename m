Return-Path: <bpf+bounces-30630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A418CF821
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 05:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EA128175E
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 03:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944197464;
	Mon, 27 May 2024 03:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuVaHwZ8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30420E6
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716781149; cv=none; b=K0GCepn4zm5cwyXbyB5otPZFcLKAK4qSHtE9DGjCCzB+LSBMsockMzMpHEbs2HsDzqkNAbFoEOwBppkvfWiyKOGWd5F8f8cfnTO8856rPiVE+t959uA1dCGINEeVM9yOzDn7PCLGBJv2i2ZkQE2BcpI1kNlUjxlLygery2NKOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716781149; c=relaxed/simple;
	bh=fdj7qcTBnfmjPivAlTmVXqQmhx2raXN5Bmy44kdZv6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onzbS2sH/WFaK8f6DlNEqSHVYYrK7ErXEUn4MV8lq7W77y3Vxejt+ML4igW5FcxxkCVsXJ3rUU4BTpkFxxvSEIMVVqoN0OKdbUu6jIVu19oeCiiFAp28oNO81ifpYQa3HuSPIf+PsvssUgQKeChRpu+NSJP7YDjs2cGkLy/oLGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuVaHwZ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716781146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JcK820oahZByDVbNCRHJXrV2NxV94VFprz1qwfAJfA=;
	b=iuVaHwZ8pVaAERQxfWUN1I2+lQsxDzIwKEpezU8Mqxg8egALLKCUnyTwtrHyOLBk9sC9DH
	qy6FGOfQrSintTmccI+6A2/4jQi5cnRJ33kZ15jEvZfaBe7ZK+pPelWH+gBigGiE+xpfS8
	7kuk8RZSXzslZtWY4UUXNmz7hEUkXnM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-MqspLKTrPEmBwl_7D71qXQ-1; Sun, 26 May 2024 23:39:03 -0400
X-MC-Unique: MqspLKTrPEmBwl_7D71qXQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1f48e6d7276so9329375ad.3
        for <bpf@vger.kernel.org>; Sun, 26 May 2024 20:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716781142; x=1717385942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JcK820oahZByDVbNCRHJXrV2NxV94VFprz1qwfAJfA=;
        b=Gs4pWdJJrLo4tZu7PJUaDIG8aQ/FRGhmuEqjaQ0v0PBbL+pScpfNKd2/kl/yXzB70C
         1Y/pBPQXiQV3HOh+OU1ExDlYW0MwqPR32PGwsomiYktfe52bAJV2J0bconH5q3riWuIx
         4gu1Zo8oD7ypy6fAy2YZ4jkrdLvakQG1bVLnLIFm1mUmfYbxepd1UFyVXzEACkkbwLzV
         eWs4WVPgtoXIISGg0o5ylWgpzzqIcKip7ygcL0EwfFy8zUiDyHrkHgfmOR1VVw1uy5nm
         ySL5Q91V6kzYIs9KaOPQ6F0SVopPt+LCRVQjd7NbbsOVO53cGgM6GzoxLAWp/Ykb4H5P
         LmxA==
X-Forwarded-Encrypted: i=1; AJvYcCVD776FokRxQS5jOPLCUlr6RbSga5YaxwAYVBpjvMiaXC+jTiiHEqk8kZ7NVk4in8J0cTpiDdiMYGp1rIJ3rOYJRa3L
X-Gm-Message-State: AOJu0YzB20HEpdXD0CdeG7y1tC/41U5rPPoTBhr9JSVc0zMQ14itd1Ty
	B6qwFZv8lGve4cyDdqBcMjlwuK1U5cMUIMeoin7j75UOUiCmNUTw/JmiHNyMpA8kW+JSS5+OkGq
	qZrIq4acWucDl1aqCj6yqtsX9I9M9lSK/b6yqqb6NXzFzisK3LErIh64NX9I6LamPf0VTJmDvRa
	nEZSdVmoiaktjPwLo8A9FAZp4n
X-Received: by 2002:a17:902:c404:b0:1f4:8faa:cd5e with SMTP id d9443c01a7336-1f48faad33bmr37000475ad.30.1716781142033;
        Sun, 26 May 2024 20:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGksnTdLTpRZS7DCpHp2eNh1LCkUpAnxjqyRVIr2Kuz/YTy9VuQVPjxTNnHPSFE1E1LPaoruVC43jLFjLONHes=
X-Received: by 2002:a17:902:c404:b0:1f4:8faa:cd5e with SMTP id
 d9443c01a7336-1f48faad33bmr37000265ad.30.1716781141626; Sun, 26 May 2024
 20:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com> <1716431200.2626963-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1716431200.2626963-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 May 2024 11:38:49 +0800
Message-ID: <CACGkMEsKgwgATiuiA4_DcrwtoGp4XT__GakKVYNJ=EcOOG9zew@mail.gmail.com>
Subject: Re: [PATCH net-next 0/7] virtnet_net: prepare for af-xdp
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 10:27=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Any comments for this.
>
> Thanks.

Will have a look.

Btw, does Michael happy with moving files into a dedicated directory?

Thanks

>
> On Wed,  8 May 2024 16:05:07 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote:
> > This patch set prepares for supporting af-xdp zerocopy.
> > There is no feature change in this patch set.
> > I just want to reduce the patch num of the final patch set,
> > so I split the patch set.
> >
> > #1-#3 add independent directory for virtio-net
> > #4-#7 do some refactor, the sub-functions will be used by the subsequen=
t commits
> >
> > Thanks.
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
> >  drivers/net/virtio/virtnet.h                  | 246 ++++++++
> >  .../{virtio_net.c =3D> virtio/virtnet_main.c}   | 534 ++++++----------=
--
> >  7 files changed, 452 insertions(+), 361 deletions(-)
> >  create mode 100644 drivers/net/virtio/Kconfig
> >  create mode 100644 drivers/net/virtio/Makefile
> >  create mode 100644 drivers/net/virtio/virtnet.h
> >  rename drivers/net/{virtio_net.c =3D> virtio/virtnet_main.c} (94%)
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
>


