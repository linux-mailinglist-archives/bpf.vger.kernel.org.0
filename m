Return-Path: <bpf+bounces-19357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4D382A678
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 04:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09BC1C2330A
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 03:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C708C10E8;
	Thu, 11 Jan 2024 03:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLNsQabf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC6EBF
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704943656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUSAkkLrb0z3ZgTRvc5R86FhRwLBEg1Wd5G+5voljgI=;
	b=SLNsQabfFFQZ0zNm9Pt2wmm6Jk1wzjIYaPBDnOo64U8+CJMhfm2Fh0QpyvOdf7Y24ibPkI
	BOjQlxTaMeN6FvleaH6lkJeH7y9BOJMN4LvjLHHXzbh2DtX6ePeEy+zMPnVKAJucnfpX1Q
	jNwPy2Umx9rvyOk4PLXmLNH5IYsl/fQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-eDrPkY1iMQaJZIb7nk87Ug-1; Wed, 10 Jan 2024 22:27:35 -0500
X-MC-Unique: eDrPkY1iMQaJZIb7nk87Ug-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bbd0056a7eso6562477b6e.0
        for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 19:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704943652; x=1705548452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUSAkkLrb0z3ZgTRvc5R86FhRwLBEg1Wd5G+5voljgI=;
        b=UlQB3iCNDPnwUJXSVG8gColv8OfZMO0Rm5ioe33xncYEWMFMtcbTeUD5/geuC8X7qi
         mp04aVp2NECu4D25+kbi0dXFchPnQbgP5HrR1hpAIKCSP9JKSsJ17o/nVSHFjHK8ilw/
         S/kTrLtzf8XhKlooB3Yyd+o53h5fhZCIjxgtsjO//P/STUrjKwQ0torXk4e8Ow94mqrY
         gN8uyq4zz+biODFiWuD4G6qVbUVFTtDmIDm6xFLWVLxaMwcvaP9hSY4MUyZbDTfiGWw1
         HmvQFyxuyKYeqoHpYO40rQgURZ+Z7FVc7y+kLfoiUhfDnCl81p88iWJjc3+3XEflWyqF
         G1Eg==
X-Gm-Message-State: AOJu0YziSf+ZMkt8dmqNBesFdWivvLQXO7JZ0T9HGArkQtxflTY8n96X
	9YhNHX7Z85tpY3eebpgrKR9CAkiPKlGXyeXfz6Ec2Tq6mGbvOJjNoFxPUy5nWU4xkHm87kKysVq
	mJBbfkfDT8h8jiw9RKIYwhScksoFI2xgXPii3
X-Received: by 2002:a05:6808:2f10:b0:3bd:3ce8:2377 with SMTP id gu16-20020a0568082f1000b003bd3ce82377mr1008840oib.114.1704943652633;
        Wed, 10 Jan 2024 19:27:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs8BJSRABz8aEdKyp40req/7d+/7A982/3ciC8ZpjhwQIZZsbp4MHstORlvr74V2fg98eAbKEU0qT16NyDo70=
X-Received: by 2002:a05:6808:2f10:b0:3bd:3ce8:2377 with SMTP id
 gu16-20020a0568082f1000b003bd3ce82377mr1008825oib.114.1704943652388; Wed, 10
 Jan 2024 19:27:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 11:27:19 +0800
Message-ID: <CACGkMEsExWq6wn7rLxqbL6o4aTiu7fm8yDN36qdtd1K9aeyHVw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/27] virtio-net: support AF_XDP zero copy
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 3:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> ## AF_XDP
>
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The z=
ero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good. mlx5 and intel ixgbe already suppo=
rt
> this feature, This patch set allows virtio-net to support xsk's zerocopy =
xmit
> feature.
>
> At present, we have completed some preparation:
>
> 1. vq-reset (virtio spec and kernel code)
> 2. virtio-core premapped dma
> 3. virtio-net xdp refactor
>
> So it is time for Virtio-Net to complete the support for the XDP Socket
> Zerocopy.
>
> Virtio-net can not increase the queue num at will, so xsk shares the queu=
e with
> kernel.
>
> On the other hand, Virtio-Net does not support generate interrupt from dr=
iver
> manually, so when we wakeup tx xmit, we used some tips. If the CPU run by=
 TX
> NAPI last time is other CPUs, use IPI to wake up NAPI on the remote CPU. =
If it
> is also the local CPU, then we wake up napi directly.
>
> This patch set includes some refactor to the virtio-net to let that to su=
pport
> AF_XDP.
>
> ## performance
>
> ENV: Qemu with vhost-user(polling mode).
> Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
>
> ### virtio PMD in guest with testpmd
>
> testpmd> show port stats all
>
>  ######################## NIC statistics for port 0 #####################=
###
>  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
>  RX-errors: 0
>  RX-nombuf: 0
>  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664
>
>
>  Throughput (since last show)
>  Rx-pps:   8861574     Rx-bps:  3969985208
>  Tx-pps:   8861493     Tx-bps:  3969962736
>  ########################################################################=
####
>
> ### AF_XDP PMD in guest with testpmd
>
> testpmd> show port stats all
>
>   ######################## NIC statistics for port 0  ###################=
#####
>   RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152
>
>   Throughput (since last show)
>   Rx-pps:      6333196          Rx-bps:   2837272088
>   Tx-pps:      6333227          Tx-bps:   2837285936
>   #######################################################################=
#####
>
> But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
>
> ## maintain
>
> I am currently a reviewer for virtio-net. I commit to maintain AF_XDP sup=
port in
> virtio-net.
>
> Please review.
>
> Thanks.
>
> v3
>     1. virtio introduces helpers for virtio-net sq using premapped dma
>     2. xsk has more complete support for merge mode
>     3. fix some problems
>
> v2
>     1. wakeup uses the way of GVE. No send ipi to wakeup napi on remote c=
pu.
>     2. remove rcu. Because we synchronize all operat, so the rcu is not n=
eeded.
>     3. split the commit "move to virtio_net.h" in last patch set. Just mo=
ve the
>        struct/api to header when we use them.
>     4. add comments for some code
>
> v1:
>     1. remove two virtio commits. Push this patchset to net-next
>     2. squash "virtio_net: virtnet_poll_tx support rescheduled" to xsk: s=
upport tx
>     3. fix some warnings
>
>
>
> Xuan Zhuo (27):
>   virtio_net: rename free_old_xmit_skbs to free_old_xmit
>   virtio_net: unify the code for recycling the xmit ptr
>   virtio_net: independent directory
>   virtio_net: move core structures to virtio_net.h
>   virtio_net: add prefix virtnet to all struct inside virtio_net.h
>   virtio_ring: introduce virtqueue_get_buf_ctx_dma()
>   virtio_ring: virtqueue_disable_and_recycle let the callback detach
>     bufs
>   virtio_ring: introduce virtqueue_detach_unused_buf_dma()
>   virtio_ring: introduce virtqueue_get_dma_premapped()
>   virtio_net: sq support premapped mode
>   virtio_net: separate virtnet_rx_resize()
>   virtio_net: separate virtnet_tx_resize()
>   virtio_net: xsk: bind/unbind xsk
>   virtio_net: xsk: prevent disable tx napi
>   virtio_net: move some api to header
>   virtio_net: xsk: tx: support xmit xsk buffer
>   virtio_net: xsk: tx: support wakeup
>   virtio_net: xsk: tx: handle the transmitted xsk buffer
>   virtio_net: xsk: tx: free the unused xsk buffer
>   virtio_net: separate receive_mergeable
>   virtio_net: separate receive_buf
>   virtio_net: xsk: rx: support fill with xsk buffer
>   virtio_net: xsk: rx: support recv merge mode
>   virtio_net: xsk: rx: support recv small mode
>   virtio_net: xsk: rx: free the unused xsk buffer
>   virtio_net: update tx timeout record
>   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY

Hi Xuan:

This series seems too huge to be reviewed easily.

I'd suggest to split it to be multiple series (as suggested by
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr)

Thanks

>
>  MAINTAINERS                                 |   2 +-
>  drivers/net/Kconfig                         |   8 +-
>  drivers/net/Makefile                        |   2 +-
>  drivers/net/virtio/Kconfig                  |  13 +
>  drivers/net/virtio/Makefile                 |   8 +
>  drivers/net/{virtio_net.c =3D> virtio/main.c} | 806 +++++++++-----------
>  drivers/net/virtio/virtio_net.h             | 337 ++++++++
>  drivers/net/virtio/xsk.c                    | 626 +++++++++++++++
>  drivers/net/virtio/xsk.h                    |  32 +
>  drivers/virtio/virtio_ring.c                | 235 ++++--
>  include/linux/virtio.h                      |  22 +-
>  11 files changed, 1582 insertions(+), 509 deletions(-)
>  create mode 100644 drivers/net/virtio/Kconfig
>  create mode 100644 drivers/net/virtio/Makefile
>  rename drivers/net/{virtio_net.c =3D> virtio/main.c} (90%)
>  create mode 100644 drivers/net/virtio/virtio_net.h
>  create mode 100644 drivers/net/virtio/xsk.c
>  create mode 100644 drivers/net/virtio/xsk.h
>
> --
> 2.32.0.3.g01195cf9f
>


