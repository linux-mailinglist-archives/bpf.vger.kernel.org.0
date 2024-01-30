Return-Path: <bpf+bounces-20670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C2A841A45
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 04:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5CB2830A8
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 03:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA263717D;
	Tue, 30 Jan 2024 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y3kV+HQ6"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F21376EA;
	Tue, 30 Jan 2024 03:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584427; cv=none; b=cpNWNYcl5NOROFrptrz0f8nUo7JhY7tayXRRYRVsnbVXRTV2zovEWIxqk2Fe81SW7avDiSaXAezBCAXj0IsMzCrPIu+wVxYDrgncVsiDwoN0mSxIDIB31WHDXA26JHLYiAzbCdaeQHL+DFgnj96r/5LyN5iNMZklmo+O31HGPgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584427; c=relaxed/simple;
	bh=XmX9mJulJzELpFVodcI6AQ0qntLO/0f8EYfxnlb7cX4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=DyqbNj8kN6A63oy7+5p23LnaDGNoQxG3aqALSZqpSHXvgMqCq2LyR0oG43bayB7CLTKCqOJ4ABvgN2rRtgRSneNnQISYND5R6N6l/lq7+klz8bip/jA/7vJCrlzmCL4a9QUqNsvRyKRseSW+q6CYF/lXxPW7kz8TY7coRO+P03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y3kV+HQ6; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706584423; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=BEo1mwxBivZlSx57dUg6vzw+VO/WGGWZK3x1VccTXhI=;
	b=Y3kV+HQ6F1glJxYaZlnDSI8SsTnsL+H5T29TvrUT5sELS5zPuAJfVn4YuMBgN5/FdhzooIIOxFkv6vwoG0cM3PhFR+ChEyKk3VB4vsfMdRNVSW0mgfrjh6XVv785ZD8NYxnw9wEg4JTlrOKCpfvrFidX8HPXlMlVB58kocFUF58=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W.eabsQ_1706584421;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.eabsQ_1706584421)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 11:13:42 +0800
Message-ID: <1706584392.5143206-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: sq support premapped mode
Date: Tue, 30 Jan 2024 11:13:12 +0800
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
 <1706499476.9318902-3-xuanzhuo@linux.alibaba.com>
 <1706509439.850925-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsSXeXEHAHjpK5VJQXCD4NRrtjAgSjTB4MJPC3PiEKFBw@mail.gmail.com>
In-Reply-To: <CACGkMEsSXeXEHAHjpK5VJQXCD4NRrtjAgSjTB4MJPC3PiEKFBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 30 Jan 2024 10:51:37 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jan 29, 2024 at 2:28=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Mon, 29 Jan 2024 11:37:56 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
> > > On Mon, 29 Jan 2024 11:14:43 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Thu, Jan 25, 2024 at 2:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Thu, 25 Jan 2024 14:14:58 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Thu, Jan 25, 2024 at 1:52=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Thu, 25 Jan 2024 13:42:05 +0800, Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > > > > On Thu, 25 Jan 2024 11:39:28 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzh=
uo@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > This is the second part of virtio-net support AF_XDP ze=
ro copy.
> > > > > > > > > >
> > > > > > > > > > The whole patch set
> > > > > > > > > > http://lore.kernel.org/all/20231229073108.57778-1-xuanz=
huo@linux.alibaba.com
> > > > > > > > > >
> > > > > > > > > > ## About the branch
> > > > > > > > > >
> > > > > > > > > > This patch set is pushed to the net-next branch, but so=
me patches are about
> > > > > > > > > > virtio core. Because the entire patch set for virtio-ne=
t to support AF_XDP
> > > > > > > > > > should be pushed to net-next, I hope these patches will=
 be merged into net-next
> > > > > > > > > > with the virtio core maintains's Acked-by.
> > > > > > > > > >
> > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > >
> > > > > > > > > > ## AF_XDP
> > > > > > > > > >
> > > > > > > > > > XDP socket(AF_XDP) is an excellent bypass kernel networ=
k framework. The zero
> > > > > > > > > > copy feature of xsk (XDP socket) needs to be supported =
by the driver. The
> > > > > > > > > > performance of zero copy is very good. mlx5 and intel i=
xgbe already support
> > > > > > > > > > this feature, This patch set allows virtio-net to suppo=
rt xsk's zerocopy xmit
> > > > > > > > > > feature.
> > > > > > > > > >
> > > > > > > > > > At present, we have completed some preparation:
> > > > > > > > > >
> > > > > > > > > > 1. vq-reset (virtio spec and kernel code)
> > > > > > > > > > 2. virtio-core premapped dma
> > > > > > > > > > 3. virtio-net xdp refactor
> > > > > > > > > >
> > > > > > > > > > So it is time for Virtio-Net to complete the support fo=
r the XDP Socket
> > > > > > > > > > Zerocopy.
> > > > > > > > > >
> > > > > > > > > > Virtio-net can not increase the queue num at will, so x=
sk shares the queue with
> > > > > > > > > > kernel.
> > > > > > > > > >
> > > > > > > > > > On the other hand, Virtio-Net does not support generate=
 interrupt from driver
> > > > > > > > > > manually, so when we wakeup tx xmit, we used some tips.=
 If the CPU run by TX
> > > > > > > > > > NAPI last time is other CPUs, use IPI to wake up NAPI o=
n the remote CPU. If it
> > > > > > > > > > is also the local CPU, then we wake up napi directly.
> > > > > > > > > >
> > > > > > > > > > This patch set includes some refactor to the virtio-net=
 to let that to support
> > > > > > > > > > AF_XDP.
> > > > > > > > > >
> > > > > > > > > > ## performance
> > > > > > > > > >
> > > > > > > > > > ENV: Qemu with vhost-user(polling mode).
> > > > > > > > > > Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
> > > > > > > > > >
> > > > > > > > > > ### virtio PMD in guest with testpmd
> > > > > > > > > >
> > > > > > > > > > testpmd> show port stats all
> > > > > > > > > >
> > > > > > > > > >  ######################## NIC statistics for port 0 ###=
#####################
> > > > > > > > > >  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 109=
3741155584
> > > > > > > > > >  RX-errors: 0
> > > > > > > > > >  RX-nombuf: 0
> > > > > > > > > >  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 3710=
30645664
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >  Throughput (since last show)
> > > > > > > > > >  Rx-pps:   8861574     Rx-bps:  3969985208
> > > > > > > > > >  Tx-pps:   8861493     Tx-bps:  3969962736
> > > > > > > > > >  ######################################################=
######################
> > > > > > > > > >
> > > > > > > > > > ### AF_XDP PMD in guest with testpmd
> > > > > > > > > >
> > > > > > > > > > testpmd> show port stats all
> > > > > > > > > >
> > > > > > > > > >   ######################## NIC statistics for port 0  #=
#######################
> > > > > > > > > >   RX-packets: 68152727   RX-missed: 0          RX-bytes=
:  3816552712
> > > > > > > > > >   RX-errors: 0
> > > > > > > > > >   RX-nombuf:  0
> > > > > > > > > >   TX-packets: 68114967   TX-errors: 33216      TX-bytes=
:  3814438152
> > > > > > > > > >
> > > > > > > > > >   Throughput (since last show)
> > > > > > > > > >   Rx-pps:      6333196          Rx-bps:   2837272088
> > > > > > > > > >   Tx-pps:      6333227          Tx-bps:   2837285936
> > > > > > > > > >   #####################################################=
#######################
> > > > > > > > > >
> > > > > > > > > > But AF_XDP consumes more CPU for tx and rx napi(100% an=
d 86%).
> > > > > > > > > >
> > > > > > > > > > ## maintain
> > > > > > > > > >
> > > > > > > > > > I am currently a reviewer for virtio-net. I commit to m=
aintain AF_XDP support in
> > > > > > > > > > virtio-net.
> > > > > > > > > >
> > > > > > > > > > Please review.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Rethink of the whole design, I have one question:
> > > > > > > > >
> > > > > > > > > The reason we need to store DMA information is to harden =
the virtqueue
> > > > > > > > > to make sure the DMA unmap is safe. This seems redundant =
when the
> > > > > > > > > buffer were premapped by the driver, for example:
> > > > > > > > >
> > > > > > > > > Receive queue maintains DMA information, so it doesn't ne=
ed desc_extra to work.
> > > > > > > > >
> > > > > > > > > So can we simply
> > > > > > > > >
> > > > > > > > > 1) when premapping is enabled, store DMA information by d=
river itself
> > > > > > > >
> > > > > > > > YES. this is simpler. And this is more convenience.
> > > > > > > > But the driver must allocate memory to store the dma info.
> > > > > >
> > > > > > Right, and this looks like the common practice for most of the =
NIC drivers.
> > > > > >
> > > > > > > >
> > > > > > > > > 2) don't store DMA information in desc_extra
> > > > > > > >
> > > > > > > > YES. But the desc_extra memory is wasted. The "next" item i=
s used.
> > > > > > > > Do you think should we free the desc_extra when the vq is p=
remapped mode?
> > > > > > >
> > > > > > >
> > > > > > > struct vring_desc_extra {
> > > > > > >         dma_addr_t addr;                /* Descriptor DMA add=
r. */
> > > > > > >         u32 len;                        /* Descriptor length.=
 */
> > > > > > >         u16 flags;                      /* Descriptor flags. =
*/
> > > > > > >         u16 next;                       /* The next desc stat=
e in a list. */
> > > > > > > };
> > > > > > >
> > > > > > >
> > > > > > > The flags and the next are used whatever premapped or not.
> > > > > > >
> > > > > > > So I think we can add a new array to store the addr and len.
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > > If the vq is premappd, the memory can be freed.
> > > > > >
> > > > > > Then we need to make sure the premapped is set before find_vqs(=
) etc.
> > > > >
> > > > >
> > > > > Yes. We can start from the parameters of the find_vqs().
> > > > >
> > > > > But actually we can free the dma array when the driver sets prema=
pped mode.
> > > >
> > > > Probably, but that's kind of odd.
> > > >
> > > > init()
> > > >     alloc()
> > > >
> > > > set_premapped()
> > > >     free()
> > >
> > > If so, the premapped option will be a find_vqs parameter,
> > > the api virtqueue_set_dma_premapped will be removed.
> > > And we can put the buffer_is_premapped to the struct virtqueue,
> > > The use can access it on the fly. (You asked on #4)
> >
> >
> > I try to pass the option to find_vqs.
> >
> > You know, the find_vqs has too many parameters.
> > And everytime we try to add new parameter is a difficult work.
> > Many places need to be changed.
> >
> >
> >         int (*find_vqs)(struct virtio_device *, unsigned nvqs,
> >                         struct virtqueue *vqs[], vq_callback_t *callbac=
ks[],
> >                         const char * const names[], const bool *ctx,
> >                         const bool *premapped,
> >                         struct irq_affinity *desc);
> >
> > Do you have any preference if I try to refactor this to pass a struct?
> >
> > Thanks.
>
> This should be fine.

The patch set is sent. I will introduce that in next version.

Thanks.



>
> Thanks
>

