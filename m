Return-Path: <bpf+bounces-20300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D183B91D
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 06:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAF71F2478B
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 05:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B8D101D4;
	Thu, 25 Jan 2024 05:46:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD3BC8FF;
	Thu, 25 Jan 2024 05:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706161577; cv=none; b=PaPCSCSvE4ysDHlkh2XfNOl1twd3q3Zy8zF/VfOqis20qixloxFseCRNS9fM58tL/enUxfWKZvez/xXA9VOHw5xWyHNWb7EIIqpEdJ5ETo4LFQYYdkSYWI1JUoBPYZXhLrQ5YkomI5F0hU4BKfIlWV3Qjp4+iK34wvdIh7Z6Hwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706161577; c=relaxed/simple;
	bh=a/by2I9ZtKR2WvZu6Xu3eyMFUJ7jcqhnrp/dNPg3Um0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=gJCP+3DAvJ2WkhzUxZkNF7A5cBE8+Wg954G1hFxw56TK25qhbosIL/Aq3u/K/eXGA78VVF+WrEpEUfk+VXysM82NDfdwVbNrAnjLz96F+RQ+fJzGzxxE0h61nDh6igqqcScRSJ+/mzacXT7AhzZIR7YiUjgi2LdA0ElERmSVchg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W.JIs4d_1706161566;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.JIs4d_1706161566)
          by smtp.aliyun-inc.com;
          Thu, 25 Jan 2024 13:46:06 +0800
Message-ID: <1706161325.4430635-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: sq support premapped mode
Date: Thu, 25 Jan 2024 13:42:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuvubWfg8Wc+=eNqg1rHR+PD6jsH7_QEJV6=S+DUVdThQ@mail.gmail.com>
In-Reply-To: <CACGkMEuvubWfg8Wc+=eNqg1rHR+PD6jsH7_QEJV6=S+DUVdThQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 25 Jan 2024 11:39:28 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > This is the second part of virtio-net support AF_XDP zero copy.
> >
> > The whole patch set
> > http://lore.kernel.org/all/20231229073108.57778-1-xuanzhuo@linux.alibab=
a.com
> >
> > ## About the branch
> >
> > This patch set is pushed to the net-next branch, but some patches are a=
bout
> > virtio core. Because the entire patch set for virtio-net to support AF_=
XDP
> > should be pushed to net-next, I hope these patches will be merged into =
net-next
> > with the virtio core maintains's Acked-by.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >
> > ## AF_XDP
> >
> > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The=
 zero
> > copy feature of xsk (XDP socket) needs to be supported by the driver. T=
he
> > performance of zero copy is very good. mlx5 and intel ixgbe already sup=
port
> > this feature, This patch set allows virtio-net to support xsk's zerocop=
y xmit
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
> > Virtio-net can not increase the queue num at will, so xsk shares the qu=
eue with
> > kernel.
> >
> > On the other hand, Virtio-Net does not support generate interrupt from =
driver
> > manually, so when we wakeup tx xmit, we used some tips. If the CPU run =
by TX
> > NAPI last time is other CPUs, use IPI to wake up NAPI on the remote CPU=
. If it
> > is also the local CPU, then we wake up napi directly.
> >
> > This patch set includes some refactor to the virtio-net to let that to =
support
> > AF_XDP.
> >
> > ## performance
> >
> > ENV: Qemu with vhost-user(polling mode).
> > Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
> >
> > ### virtio PMD in guest with testpmd
> >
> > testpmd> show port stats all
> >
> >  ######################## NIC statistics for port 0 ###################=
#####
> >  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
> >  RX-errors: 0
> >  RX-nombuf: 0
> >  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664
> >
> >
> >  Throughput (since last show)
> >  Rx-pps:   8861574     Rx-bps:  3969985208
> >  Tx-pps:   8861493     Tx-bps:  3969962736
> >  ######################################################################=
######
> >
> > ### AF_XDP PMD in guest with testpmd
> >
> > testpmd> show port stats all
> >
> >   ######################## NIC statistics for port 0  #################=
#######
> >   RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
> >   RX-errors: 0
> >   RX-nombuf:  0
> >   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152
> >
> >   Throughput (since last show)
> >   Rx-pps:      6333196          Rx-bps:   2837272088
> >   Tx-pps:      6333227          Tx-bps:   2837285936
> >   #####################################################################=
#######
> >
> > But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
> >
> > ## maintain
> >
> > I am currently a reviewer for virtio-net. I commit to maintain AF_XDP s=
upport in
> > virtio-net.
> >
> > Please review.
> >
>
> Rethink of the whole design, I have one question:
>
> The reason we need to store DMA information is to harden the virtqueue
> to make sure the DMA unmap is safe. This seems redundant when the
> buffer were premapped by the driver, for example:
>
> Receive queue maintains DMA information, so it doesn't need desc_extra to=
 work.
>
> So can we simply
>
> 1) when premapping is enabled, store DMA information by driver itself

YES. this is simpler. And this is more convenience.
But the driver must allocate memory to store the dma info.

> 2) don't store DMA information in desc_extra

YES. But the desc_extra memory is wasted. The "next" item is used.
Do you think should we free the desc_extra when the vq is premapped mode?

Thanks.


>
> Would this be simpler?
>
> Thanks
>

