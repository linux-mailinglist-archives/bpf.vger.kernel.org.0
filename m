Return-Path: <bpf+bounces-20546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2843A83FE50
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 07:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A051F22C43
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 06:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDF54C61D;
	Mon, 29 Jan 2024 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pDtG/Uh1"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0444C60C;
	Mon, 29 Jan 2024 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509720; cv=none; b=cniu2ih9ZBqiY0afDyietPj21y6zt/80fiodxbQ1jHPGkjkisH/w7T35G2BmOGcsW4sOH1BA5kBRZ2v8idRSlI8/6o4odKuTL6N8EXFFg9xaIDzf9FHTnHz3rj3iLZAIV12OPtHd8uPtarRCHZ4M4KxQNHfjHq5GRdzZw74ZsLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509720; c=relaxed/simple;
	bh=SV7fufg+aCJ8k+hCP96MGeqcBmHyzQuyce956n+q15Q=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=LiIjriKssC/fcB9rzkdBKt9d2C5ys7GX1RTeM6iVMDdQGToScSKx0IG3sdJ5PS7E+GeWAu1PYybuO6aTr6P6eW6kse/axXDhgsA4eEYcdW3z/eAyWulETwtHf3XD3d+p03U+H559WlWurdr/M6TxfMHZrjTC0FgYlMH7Dg1ENJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pDtG/Uh1; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706509714; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=vyaSgaa0SFOLYmzyrw6gXo9xIhbB550cRSClo4SXHCA=;
	b=pDtG/Uh11B+dhRHnxKxEOz394KFksKbsltLV/PnCXbxAx+MfhXxIhRj4QrHWCToPV8mPRJc6MW0Eepgfj78A7otWgg53x3mUdGJm1giE60RI4ZZUIaGGnJ1YVwjjtgET8+pO6E8ZXQmkyQV5dEF1xGOmf9na8U7QTefnyZ9hNXU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W.VqCu3_1706509713;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.VqCu3_1706509713)
          by smtp.aliyun-inc.com;
          Mon, 29 Jan 2024 14:28:34 +0800
Message-ID: <1706509439.850925-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: sq support premapped mode
Date: Mon, 29 Jan 2024 14:23:59 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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
 bpf@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuvubWfg8Wc+=eNqg1rHR+PD6jsH7_QEJV6=S+DUVdThQ@mail.gmail.com>
 <1706161325.4430635-1-xuanzhuo@linux.alibaba.com>
 <1706161768.900584-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEug-=C+VQhkMYSgUKMC==04m7-uem_yC21bgGkKZh845w@mail.gmail.com>
 <1706163935.2439404-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com>
 <1706499476.9318902-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706499476.9318902-3-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 29 Jan 2024 11:37:56 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> =
wrote:
> On Mon, 29 Jan 2024 11:14:43 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Jan 25, 2024 at 2:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 25 Jan 2024 14:14:58 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Thu, Jan 25, 2024 at 1:52=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Thu, 25 Jan 2024 13:42:05 +0800, Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > > > > On Thu, 25 Jan 2024 11:39:28 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > This is the second part of virtio-net support AF_XDP zero c=
opy.
> > > > > > > >
> > > > > > > > The whole patch set
> > > > > > > > http://lore.kernel.org/all/20231229073108.57778-1-xuanzhuo@=
linux.alibaba.com
> > > > > > > >
> > > > > > > > ## About the branch
> > > > > > > >
> > > > > > > > This patch set is pushed to the net-next branch, but some p=
atches are about
> > > > > > > > virtio core. Because the entire patch set for virtio-net to=
 support AF_XDP
> > > > > > > > should be pushed to net-next, I hope these patches will be =
merged into net-next
> > > > > > > > with the virtio core maintains's Acked-by.
> > > > > > > >
> > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > > > > >
> > > > > > > > ## AF_XDP
> > > > > > > >
> > > > > > > > XDP socket(AF_XDP) is an excellent bypass kernel network fr=
amework. The zero
> > > > > > > > copy feature of xsk (XDP socket) needs to be supported by t=
he driver. The
> > > > > > > > performance of zero copy is very good. mlx5 and intel ixgbe=
 already support
> > > > > > > > this feature, This patch set allows virtio-net to support x=
sk's zerocopy xmit
> > > > > > > > feature.
> > > > > > > >
> > > > > > > > At present, we have completed some preparation:
> > > > > > > >
> > > > > > > > 1. vq-reset (virtio spec and kernel code)
> > > > > > > > 2. virtio-core premapped dma
> > > > > > > > 3. virtio-net xdp refactor
> > > > > > > >
> > > > > > > > So it is time for Virtio-Net to complete the support for th=
e XDP Socket
> > > > > > > > Zerocopy.
> > > > > > > >
> > > > > > > > Virtio-net can not increase the queue num at will, so xsk s=
hares the queue with
> > > > > > > > kernel.
> > > > > > > >
> > > > > > > > On the other hand, Virtio-Net does not support generate int=
errupt from driver
> > > > > > > > manually, so when we wakeup tx xmit, we used some tips. If =
the CPU run by TX
> > > > > > > > NAPI last time is other CPUs, use IPI to wake up NAPI on th=
e remote CPU. If it
> > > > > > > > is also the local CPU, then we wake up napi directly.
> > > > > > > >
> > > > > > > > This patch set includes some refactor to the virtio-net to =
let that to support
> > > > > > > > AF_XDP.
> > > > > > > >
> > > > > > > > ## performance
> > > > > > > >
> > > > > > > > ENV: Qemu with vhost-user(polling mode).
> > > > > > > > Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
> > > > > > > >
> > > > > > > > ### virtio PMD in guest with testpmd
> > > > > > > >
> > > > > > > > testpmd> show port stats all
> > > > > > > >
> > > > > > > >  ######################## NIC statistics for port 0 #######=
#################
> > > > > > > >  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741=
155584
> > > > > > > >  RX-errors: 0
> > > > > > > >  RX-nombuf: 0
> > > > > > > >  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 37103064=
5664
> > > > > > > >
> > > > > > > >
> > > > > > > >  Throughput (since last show)
> > > > > > > >  Rx-pps:   8861574     Rx-bps:  3969985208
> > > > > > > >  Tx-pps:   8861493     Tx-bps:  3969962736
> > > > > > > >  ##########################################################=
##################
> > > > > > > >
> > > > > > > > ### AF_XDP PMD in guest with testpmd
> > > > > > > >
> > > > > > > > testpmd> show port stats all
> > > > > > > >
> > > > > > > >   ######################## NIC statistics for port 0  #####=
###################
> > > > > > > >   RX-packets: 68152727   RX-missed: 0          RX-bytes:  3=
816552712
> > > > > > > >   RX-errors: 0
> > > > > > > >   RX-nombuf:  0
> > > > > > > >   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3=
814438152
> > > > > > > >
> > > > > > > >   Throughput (since last show)
> > > > > > > >   Rx-pps:      6333196          Rx-bps:   2837272088
> > > > > > > >   Tx-pps:      6333227          Tx-bps:   2837285936
> > > > > > > >   #########################################################=
###################
> > > > > > > >
> > > > > > > > But AF_XDP consumes more CPU for tx and rx napi(100% and 86=
%).
> > > > > > > >
> > > > > > > > ## maintain
> > > > > > > >
> > > > > > > > I am currently a reviewer for virtio-net. I commit to maint=
ain AF_XDP support in
> > > > > > > > virtio-net.
> > > > > > > >
> > > > > > > > Please review.
> > > > > > > >
> > > > > > >
> > > > > > > Rethink of the whole design, I have one question:
> > > > > > >
> > > > > > > The reason we need to store DMA information is to harden the =
virtqueue
> > > > > > > to make sure the DMA unmap is safe. This seems redundant when=
 the
> > > > > > > buffer were premapped by the driver, for example:
> > > > > > >
> > > > > > > Receive queue maintains DMA information, so it doesn't need d=
esc_extra to work.
> > > > > > >
> > > > > > > So can we simply
> > > > > > >
> > > > > > > 1) when premapping is enabled, store DMA information by drive=
r itself
> > > > > >
> > > > > > YES. this is simpler. And this is more convenience.
> > > > > > But the driver must allocate memory to store the dma info.
> > > >
> > > > Right, and this looks like the common practice for most of the NIC =
drivers.
> > > >
> > > > > >
> > > > > > > 2) don't store DMA information in desc_extra
> > > > > >
> > > > > > YES. But the desc_extra memory is wasted. The "next" item is us=
ed.
> > > > > > Do you think should we free the desc_extra when the vq is prema=
pped mode?
> > > > >
> > > > >
> > > > > struct vring_desc_extra {
> > > > >         dma_addr_t addr;                /* Descriptor DMA addr. */
> > > > >         u32 len;                        /* Descriptor length. */
> > > > >         u16 flags;                      /* Descriptor flags. */
> > > > >         u16 next;                       /* The next desc state in=
 a list. */
> > > > > };
> > > > >
> > > > >
> > > > > The flags and the next are used whatever premapped or not.
> > > > >
> > > > > So I think we can add a new array to store the addr and len.
> > > >
> > > > Yes.
> > > >
> > > > > If the vq is premappd, the memory can be freed.
> > > >
> > > > Then we need to make sure the premapped is set before find_vqs() et=
c.
> > >
> > >
> > > Yes. We can start from the parameters of the find_vqs().
> > >
> > > But actually we can free the dma array when the driver sets premapped=
 mode.
> >
> > Probably, but that's kind of odd.
> >
> > init()
> >     alloc()
> >
> > set_premapped()
> >     free()
>
> If so, the premapped option will be a find_vqs parameter,
> the api virtqueue_set_dma_premapped will be removed.
> And we can put the buffer_is_premapped to the struct virtqueue,
> The use can access it on the fly. (You asked on #4)


I try to pass the option to find_vqs.

You know, the find_vqs has too many parameters.
And everytime we try to add new parameter is a difficult work.
Many places need to be changed.


	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
			struct virtqueue *vqs[], vq_callback_t *callbacks[],
			const char * const names[], const bool *ctx,
			const bool *premapped,
			struct irq_affinity *desc);

Do you have any preference if I try to refactor this to pass a struct?

Thanks.

>
>
> >
> > >
> > > >
> > > > >
> > > > > struct vring_desc_extra {
> > > > >         u16 flags;                      /* Descriptor flags. */
> > > > >         u16 next;                       /* The next desc state in=
 a list. */
> > > > > };
> > > > >
> > > > > struct vring_desc_dma {
> > > > >         dma_addr_t addr;                /* Descriptor DMA addr. */
> > > > >         u32 len;                        /* Descriptor length. */
> > > > > };
> > > > >
> > > > > Thanks.
> > >
> > > As we discussed, you may wait my next patch set of the new design.
> > >
> > > Could you review the first patch set of this serial.
> > > http://lore.kernel.org/all/20240116062842.67874-1-xuanzhuo@linux.alib=
aba.com
> > >
> > > I work on top of this.
> >
> > Actually, I'm a little confused about the dependencies.
> >
> > We have three:
> >
> > 1) move the virtio-net to a dedicated directory
> > 2) premapped mode
> > 3) AF_XDP
> >
> > It looks to me the current series is posted in that dependency.
> >
> > Then I have questions:
> >
> > 1) do we agree with moving to a directory (I don't have a preference)?
> > 2) if 3) depends on 2), I'd suggest to make sure 2) is finalized
> > before posting 3), this is because we have gone through several rounds
> > of AF_XDP and most concerns were for the API that is introduced in 2)
> >
> > Does this make sense?
>
> YES. this make sense.
>
> I do this because I can reduce the work of rebasing the code again.
>
> But you are right, this is the right order.
>
>
> >
> > >
> > > PS.
> > >
> > > There is another patch set "device stats". I hope that is in your lis=
t.
> > >
> > > http://lore.kernel.org/all/20231226073103.116153-1-xuanzhuo@linux.ali=
baba.com
> >
> > Yes, it is. (If it doesn't depend on the moving of the source).
>
> It does not depend on that.
>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Would this be simpler?
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > >
> > > >
> > >
> >
>

