Return-Path: <bpf+bounces-20541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0475283FCEF
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 04:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3BCB21641
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 03:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B476310A0C;
	Mon, 29 Jan 2024 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WJqNKW0c"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902541094E;
	Mon, 29 Jan 2024 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499869; cv=none; b=CWsWUinPflm7+EohKDfvVivoHyQiPU9Ugp24mYE1punISFsyUmQ0BQppKq68cc91nXYs031cMba3rXxmutrZArKG26ddww3vp5wIpJMDQWO5qtLG+XTXTZzQjf0/k3VGF7X32jK55W5aaDYr9egK8AdDgShV7jChgHXqsM/dLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499869; c=relaxed/simple;
	bh=bNJX0Hm67n4K/5GlU/yFHC2BfBUBngP3mYVySnrL4Ss=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=KwwZrLFpXHv1oLXEheiRnIf28xdRkenaOuAJh49N2UWkbpiNs262bmyXLVO+ISi5WcAisnRiNWyuB3tkBDZXndWWSyw3hdF9lO3vhMsFoUQ2mhB9mroomgKHp/t6dSqDmMQlQMSjpwR1l9CpeZVxkfm9YHh7zK+QbfkyOVXwoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WJqNKW0c; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706499863; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=qE9wUkRXnM9ZQyLFSNKanzp39ncOSpxic7WXd4Ss75c=;
	b=WJqNKW0c1IoGmMBsT25qovE1qmKlhitxgPm6fAMHfpsBmXWDgLpf74w9IEO/f+q64JHrAqMA4hhXL5Bs3y8TRgSmbZc52GgMYa7EThATLVwOf2co0fW9c59rbIhwV6mur4/5GrIoyDaBLOh0CSbVE47pksPZShZNsnCql5Y9Tmg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W.UK3YS_1706499862;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.UK3YS_1706499862)
          by smtp.aliyun-inc.com;
          Mon, 29 Jan 2024 11:44:23 +0800
Message-ID: <1706499476.9318902-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: sq support premapped mode
Date: Mon, 29 Jan 2024 11:37:56 +0800
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
 <1706161325.4430635-1-xuanzhuo@linux.alibaba.com>
 <1706161768.900584-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEug-=C+VQhkMYSgUKMC==04m7-uem_yC21bgGkKZh845w@mail.gmail.com>
 <1706163935.2439404-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com>
In-Reply-To: <CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 29 Jan 2024 11:14:43 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Jan 25, 2024 at 2:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Thu, 25 Jan 2024 14:14:58 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Thu, Jan 25, 2024 at 1:52=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Thu, 25 Jan 2024 13:42:05 +0800, Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > > > > On Thu, 25 Jan 2024 11:39:28 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > This is the second part of virtio-net support AF_XDP zero cop=
y.
> > > > > > >
> > > > > > > The whole patch set
> > > > > > > http://lore.kernel.org/all/20231229073108.57778-1-xuanzhuo@li=
nux.alibaba.com
> > > > > > >
> > > > > > > ## About the branch
> > > > > > >
> > > > > > > This patch set is pushed to the net-next branch, but some pat=
ches are about
> > > > > > > virtio core. Because the entire patch set for virtio-net to s=
upport AF_XDP
> > > > > > > should be pushed to net-next, I hope these patches will be me=
rged into net-next
> > > > > > > with the virtio core maintains's Acked-by.
> > > > > > >
> > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > > > >
> > > > > > > ## AF_XDP
> > > > > > >
> > > > > > > XDP socket(AF_XDP) is an excellent bypass kernel network fram=
ework. The zero
> > > > > > > copy feature of xsk (XDP socket) needs to be supported by the=
 driver. The
> > > > > > > performance of zero copy is very good. mlx5 and intel ixgbe a=
lready support
> > > > > > > this feature, This patch set allows virtio-net to support xsk=
's zerocopy xmit
> > > > > > > feature.
> > > > > > >
> > > > > > > At present, we have completed some preparation:
> > > > > > >
> > > > > > > 1. vq-reset (virtio spec and kernel code)
> > > > > > > 2. virtio-core premapped dma
> > > > > > > 3. virtio-net xdp refactor
> > > > > > >
> > > > > > > So it is time for Virtio-Net to complete the support for the =
XDP Socket
> > > > > > > Zerocopy.
> > > > > > >
> > > > > > > Virtio-net can not increase the queue num at will, so xsk sha=
res the queue with
> > > > > > > kernel.
> > > > > > >
> > > > > > > On the other hand, Virtio-Net does not support generate inter=
rupt from driver
> > > > > > > manually, so when we wakeup tx xmit, we used some tips. If th=
e CPU run by TX
> > > > > > > NAPI last time is other CPUs, use IPI to wake up NAPI on the =
remote CPU. If it
> > > > > > > is also the local CPU, then we wake up napi directly.
> > > > > > >
> > > > > > > This patch set includes some refactor to the virtio-net to le=
t that to support
> > > > > > > AF_XDP.
> > > > > > >
> > > > > > > ## performance
> > > > > > >
> > > > > > > ENV: Qemu with vhost-user(polling mode).
> > > > > > > Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
> > > > > > >
> > > > > > > ### virtio PMD in guest with testpmd
> > > > > > >
> > > > > > > testpmd> show port stats all
> > > > > > >
> > > > > > >  ######################## NIC statistics for port 0 #########=
###############
> > > > > > >  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 109374115=
5584
> > > > > > >  RX-errors: 0
> > > > > > >  RX-nombuf: 0
> > > > > > >  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 3710306456=
64
> > > > > > >
> > > > > > >
> > > > > > >  Throughput (since last show)
> > > > > > >  Rx-pps:   8861574     Rx-bps:  3969985208
> > > > > > >  Tx-pps:   8861493     Tx-bps:  3969962736
> > > > > > >  ############################################################=
################
> > > > > > >
> > > > > > > ### AF_XDP PMD in guest with testpmd
> > > > > > >
> > > > > > > testpmd> show port stats all
> > > > > > >
> > > > > > >   ######################## NIC statistics for port 0  #######=
#################
> > > > > > >   RX-packets: 68152727   RX-missed: 0          RX-bytes:  381=
6552712
> > > > > > >   RX-errors: 0
> > > > > > >   RX-nombuf:  0
> > > > > > >   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  381=
4438152
> > > > > > >
> > > > > > >   Throughput (since last show)
> > > > > > >   Rx-pps:      6333196          Rx-bps:   2837272088
> > > > > > >   Tx-pps:      6333227          Tx-bps:   2837285936
> > > > > > >   ###########################################################=
#################
> > > > > > >
> > > > > > > But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
> > > > > > >
> > > > > > > ## maintain
> > > > > > >
> > > > > > > I am currently a reviewer for virtio-net. I commit to maintai=
n AF_XDP support in
> > > > > > > virtio-net.
> > > > > > >
> > > > > > > Please review.
> > > > > > >
> > > > > >
> > > > > > Rethink of the whole design, I have one question:
> > > > > >
> > > > > > The reason we need to store DMA information is to harden the vi=
rtqueue
> > > > > > to make sure the DMA unmap is safe. This seems redundant when t=
he
> > > > > > buffer were premapped by the driver, for example:
> > > > > >
> > > > > > Receive queue maintains DMA information, so it doesn't need des=
c_extra to work.
> > > > > >
> > > > > > So can we simply
> > > > > >
> > > > > > 1) when premapping is enabled, store DMA information by driver =
itself
> > > > >
> > > > > YES. this is simpler. And this is more convenience.
> > > > > But the driver must allocate memory to store the dma info.
> > >
> > > Right, and this looks like the common practice for most of the NIC dr=
ivers.
> > >
> > > > >
> > > > > > 2) don't store DMA information in desc_extra
> > > > >
> > > > > YES. But the desc_extra memory is wasted. The "next" item is used.
> > > > > Do you think should we free the desc_extra when the vq is premapp=
ed mode?
> > > >
> > > >
> > > > struct vring_desc_extra {
> > > >         dma_addr_t addr;                /* Descriptor DMA addr. */
> > > >         u32 len;                        /* Descriptor length. */
> > > >         u16 flags;                      /* Descriptor flags. */
> > > >         u16 next;                       /* The next desc state in a=
 list. */
> > > > };
> > > >
> > > >
> > > > The flags and the next are used whatever premapped or not.
> > > >
> > > > So I think we can add a new array to store the addr and len.
> > >
> > > Yes.
> > >
> > > > If the vq is premappd, the memory can be freed.
> > >
> > > Then we need to make sure the premapped is set before find_vqs() etc.
> >
> >
> > Yes. We can start from the parameters of the find_vqs().
> >
> > But actually we can free the dma array when the driver sets premapped m=
ode.
>
> Probably, but that's kind of odd.
>
> init()
>     alloc()
>
> set_premapped()
>     free()

If so, the premapped option will be a find_vqs parameter,
the api virtqueue_set_dma_premapped will be removed.
And we can put the buffer_is_premapped to the struct virtqueue,
The use can access it on the fly. (You asked on #4)


>
> >
> > >
> > > >
> > > > struct vring_desc_extra {
> > > >         u16 flags;                      /* Descriptor flags. */
> > > >         u16 next;                       /* The next desc state in a=
 list. */
> > > > };
> > > >
> > > > struct vring_desc_dma {
> > > >         dma_addr_t addr;                /* Descriptor DMA addr. */
> > > >         u32 len;                        /* Descriptor length. */
> > > > };
> > > >
> > > > Thanks.
> >
> > As we discussed, you may wait my next patch set of the new design.
> >
> > Could you review the first patch set of this serial.
> > http://lore.kernel.org/all/20240116062842.67874-1-xuanzhuo@linux.alibab=
a.com
> >
> > I work on top of this.
>
> Actually, I'm a little confused about the dependencies.
>
> We have three:
>
> 1) move the virtio-net to a dedicated directory
> 2) premapped mode
> 3) AF_XDP
>
> It looks to me the current series is posted in that dependency.
>
> Then I have questions:
>
> 1) do we agree with moving to a directory (I don't have a preference)?
> 2) if 3) depends on 2), I'd suggest to make sure 2) is finalized
> before posting 3), this is because we have gone through several rounds
> of AF_XDP and most concerns were for the API that is introduced in 2)
>
> Does this make sense?

YES. this make sense.

I do this because I can reduce the work of rebasing the code again.

But you are right, this is the right order.


>
> >
> > PS.
> >
> > There is another patch set "device stats". I hope that is in your list.
> >
> > http://lore.kernel.org/all/20231226073103.116153-1-xuanzhuo@linux.aliba=
ba.com
>
> Yes, it is. (If it doesn't depend on the moving of the source).

It does not depend on that.

Thanks.


>
> Thanks
>
> >
> > Thanks.
> >
> >
> > >
> > > Thanks
> > >
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > > >
> > > > > > Would this be simpler?
> > > > > >
> > > > > > Thanks
> > > > > >
> > > >
> > >
> >
>

