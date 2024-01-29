Return-Path: <bpf+bounces-20538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C083FCA1
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 04:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2461C21C0D
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 03:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4CBFC1F;
	Mon, 29 Jan 2024 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drQEIGJo"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78EFC02
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706498101; cv=none; b=tAYyTzt3avpO40hqDpkoLcj9iw0k2DQq5Dc8f08G7xj2Xe+xydDod5N8C0yUynivXNo3UGIwWpEObdPVAmeGY/x4/Sll72YGDjynnqGDq/jeQACH3i/DutToVw9IgBNGya2tCQ7aJ6BquwqPhhg9tdDP/JZf3KObLppTOSCl2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706498101; c=relaxed/simple;
	bh=bb17DoxD7VHha3VtsAezjQt3SHPoEShU9FkB01PlFGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1FpxAVKjghjNNqQ+AUWeOL0g51FWmJA7OfAr3pg2usEM2MWwFK0/bF6C1Ohm3Od2uNUxKJ+KyMH7DWQG4UEUK25V39QdiMXdtOAxJnx6NCVTbr1WZ+Q3H2UC1nw3p9kZ7QVVDs70nsWtUq/eMWNeC3sR8OnqSj3UNXjI+yJqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drQEIGJo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706498098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EktyGpM+Jgvn6yaQn9Cm7fTQFqXRYieGtOLzHZxCzYM=;
	b=drQEIGJoOC5pyMPojwjsfZkp1Xztyw20Gq6vl9DNhHmeRjfQNE9bylRMGDroDCnnFRzfVb
	N/tQmVPuCrvlwTqUHh7idZ/oeC7HkD6XPOsb19jrc6rIo6l98hhlRovLvq8BncZ34mTHF6
	78/m5CTJDhzKHfScNz8KqWrBM9N4QQA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-77_sRxUZM6qQF_qwENKLgA-1; Sun, 28 Jan 2024 22:14:57 -0500
X-MC-Unique: 77_sRxUZM6qQF_qwENKLgA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d6fb108807so3210495a12.0
        for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 19:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706498095; x=1707102895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EktyGpM+Jgvn6yaQn9Cm7fTQFqXRYieGtOLzHZxCzYM=;
        b=oakRuQsIoQrOReO5OveoOhckMDk9fh+nQvFZgcRswmJJzD1vbW4YQN5v+f6nflN+uD
         YGfeTJnLXqdqvusquN3oDXThsBjYZjVA/NaVyhHzasZHYAxM9ClfH4iAEOwqoq3FMwS/
         Nuv1KtpTBpUD0G46JBq8BcrC6w8im/nmbRmlDQJtmHHTvSXbi3TUL3ZaO3oDukhz3R+c
         puic5aZgHOjLn4GU2NoITDnxfNiga0bhsdcmDSF7a/H9C1EZzZ1uR70b7T4Pyw+TUlEQ
         t5dDkVEGGunHBE/ZNFWit45RcF91uptoFNdGHli+T6nsnamAOOhgqNJZzHJoflOoasNS
         TjDA==
X-Gm-Message-State: AOJu0Yyb8ZS4XznBx/m70ZjV47N4/DOKdo/qkd9BankHAO2fezl9tHsL
	LYgZUcwkOhK+gehRxqJqOUSKXc7redmZ7wMUfZCccolTFZMUcWEp9cUzpZfvUgL21QH44WHpD/W
	0t2qrrm8G6MXcaoxe6stO2kTT4t8ySpNgXALOk9r+FNA2KRfy3HDOX19+2x3hrNm0+KFjU6FW2C
	znZXeF51yG++dTxu2bchJnJGpS
X-Received: by 2002:a05:6a20:2d24:b0:19c:9c08:d568 with SMTP id g36-20020a056a202d2400b0019c9c08d568mr4424357pzl.108.1706498095110;
        Sun, 28 Jan 2024 19:14:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVDb8VkjbedFm9a98ejQLb8nn8umlRFIv01dGDmt5sagjmqIxmrogJXorFDRJGpE7PU9DR995TPxiSx8QcMe8=
X-Received: by 2002:a05:6a20:2d24:b0:19c:9c08:d568 with SMTP id
 g36-20020a056a202d2400b0019c9c08d568mr4424343pzl.108.1706498094805; Sun, 28
 Jan 2024 19:14:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuvubWfg8Wc+=eNqg1rHR+PD6jsH7_QEJV6=S+DUVdThQ@mail.gmail.com>
 <1706161325.4430635-1-xuanzhuo@linux.alibaba.com> <1706161768.900584-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEug-=C+VQhkMYSgUKMC==04m7-uem_yC21bgGkKZh845w@mail.gmail.com> <1706163935.2439404-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706163935.2439404-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jan 2024 11:14:43 +0800
Message-ID: <CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 2:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 25 Jan 2024 14:14:58 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Jan 25, 2024 at 1:52=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 25 Jan 2024 13:42:05 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> > > > On Thu, 25 Jan 2024 11:39:28 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > This is the second part of virtio-net support AF_XDP zero copy.
> > > > > >
> > > > > > The whole patch set
> > > > > > http://lore.kernel.org/all/20231229073108.57778-1-xuanzhuo@linu=
x.alibaba.com
> > > > > >
> > > > > > ## About the branch
> > > > > >
> > > > > > This patch set is pushed to the net-next branch, but some patch=
es are about
> > > > > > virtio core. Because the entire patch set for virtio-net to sup=
port AF_XDP
> > > > > > should be pushed to net-next, I hope these patches will be merg=
ed into net-next
> > > > > > with the virtio core maintains's Acked-by.
> > > > > >
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > >
> > > > > > ## AF_XDP
> > > > > >
> > > > > > XDP socket(AF_XDP) is an excellent bypass kernel network framew=
ork. The zero
> > > > > > copy feature of xsk (XDP socket) needs to be supported by the d=
river. The
> > > > > > performance of zero copy is very good. mlx5 and intel ixgbe alr=
eady support
> > > > > > this feature, This patch set allows virtio-net to support xsk's=
 zerocopy xmit
> > > > > > feature.
> > > > > >
> > > > > > At present, we have completed some preparation:
> > > > > >
> > > > > > 1. vq-reset (virtio spec and kernel code)
> > > > > > 2. virtio-core premapped dma
> > > > > > 3. virtio-net xdp refactor
> > > > > >
> > > > > > So it is time for Virtio-Net to complete the support for the XD=
P Socket
> > > > > > Zerocopy.
> > > > > >
> > > > > > Virtio-net can not increase the queue num at will, so xsk share=
s the queue with
> > > > > > kernel.
> > > > > >
> > > > > > On the other hand, Virtio-Net does not support generate interru=
pt from driver
> > > > > > manually, so when we wakeup tx xmit, we used some tips. If the =
CPU run by TX
> > > > > > NAPI last time is other CPUs, use IPI to wake up NAPI on the re=
mote CPU. If it
> > > > > > is also the local CPU, then we wake up napi directly.
> > > > > >
> > > > > > This patch set includes some refactor to the virtio-net to let =
that to support
> > > > > > AF_XDP.
> > > > > >
> > > > > > ## performance
> > > > > >
> > > > > > ENV: Qemu with vhost-user(polling mode).
> > > > > > Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
> > > > > >
> > > > > > ### virtio PMD in guest with testpmd
> > > > > >
> > > > > > testpmd> show port stats all
> > > > > >
> > > > > >  ######################## NIC statistics for port 0 ###########=
#############
> > > > > >  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 10937411555=
84
> > > > > >  RX-errors: 0
> > > > > >  RX-nombuf: 0
> > > > > >  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664
> > > > > >
> > > > > >
> > > > > >  Throughput (since last show)
> > > > > >  Rx-pps:   8861574     Rx-bps:  3969985208
> > > > > >  Tx-pps:   8861493     Tx-bps:  3969962736
> > > > > >  ##############################################################=
##############
> > > > > >
> > > > > > ### AF_XDP PMD in guest with testpmd
> > > > > >
> > > > > > testpmd> show port stats all
> > > > > >
> > > > > >   ######################## NIC statistics for port 0  #########=
###############
> > > > > >   RX-packets: 68152727   RX-missed: 0          RX-bytes:  38165=
52712
> > > > > >   RX-errors: 0
> > > > > >   RX-nombuf:  0
> > > > > >   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  38144=
38152
> > > > > >
> > > > > >   Throughput (since last show)
> > > > > >   Rx-pps:      6333196          Rx-bps:   2837272088
> > > > > >   Tx-pps:      6333227          Tx-bps:   2837285936
> > > > > >   #############################################################=
###############
> > > > > >
> > > > > > But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
> > > > > >
> > > > > > ## maintain
> > > > > >
> > > > > > I am currently a reviewer for virtio-net. I commit to maintain =
AF_XDP support in
> > > > > > virtio-net.
> > > > > >
> > > > > > Please review.
> > > > > >
> > > > >
> > > > > Rethink of the whole design, I have one question:
> > > > >
> > > > > The reason we need to store DMA information is to harden the virt=
queue
> > > > > to make sure the DMA unmap is safe. This seems redundant when the
> > > > > buffer were premapped by the driver, for example:
> > > > >
> > > > > Receive queue maintains DMA information, so it doesn't need desc_=
extra to work.
> > > > >
> > > > > So can we simply
> > > > >
> > > > > 1) when premapping is enabled, store DMA information by driver it=
self
> > > >
> > > > YES. this is simpler. And this is more convenience.
> > > > But the driver must allocate memory to store the dma info.
> >
> > Right, and this looks like the common practice for most of the NIC driv=
ers.
> >
> > > >
> > > > > 2) don't store DMA information in desc_extra
> > > >
> > > > YES. But the desc_extra memory is wasted. The "next" item is used.
> > > > Do you think should we free the desc_extra when the vq is premapped=
 mode?
> > >
> > >
> > > struct vring_desc_extra {
> > >         dma_addr_t addr;                /* Descriptor DMA addr. */
> > >         u32 len;                        /* Descriptor length. */
> > >         u16 flags;                      /* Descriptor flags. */
> > >         u16 next;                       /* The next desc state in a l=
ist. */
> > > };
> > >
> > >
> > > The flags and the next are used whatever premapped or not.
> > >
> > > So I think we can add a new array to store the addr and len.
> >
> > Yes.
> >
> > > If the vq is premappd, the memory can be freed.
> >
> > Then we need to make sure the premapped is set before find_vqs() etc.
>
>
> Yes. We can start from the parameters of the find_vqs().
>
> But actually we can free the dma array when the driver sets premapped mod=
e.

Probably, but that's kind of odd.

init()
    alloc()

set_premapped()
    free()

>
> >
> > >
> > > struct vring_desc_extra {
> > >         u16 flags;                      /* Descriptor flags. */
> > >         u16 next;                       /* The next desc state in a l=
ist. */
> > > };
> > >
> > > struct vring_desc_dma {
> > >         dma_addr_t addr;                /* Descriptor DMA addr. */
> > >         u32 len;                        /* Descriptor length. */
> > > };
> > >
> > > Thanks.
>
> As we discussed, you may wait my next patch set of the new design.
>
> Could you review the first patch set of this serial.
> http://lore.kernel.org/all/20240116062842.67874-1-xuanzhuo@linux.alibaba.=
com
>
> I work on top of this.

Actually, I'm a little confused about the dependencies.

We have three:

1) move the virtio-net to a dedicated directory
2) premapped mode
3) AF_XDP

It looks to me the current series is posted in that dependency.

Then I have questions:

1) do we agree with moving to a directory (I don't have a preference)?
2) if 3) depends on 2), I'd suggest to make sure 2) is finalized
before posting 3), this is because we have gone through several rounds
of AF_XDP and most concerns were for the API that is introduced in 2)

Does this make sense?

>
> PS.
>
> There is another patch set "device stats". I hope that is in your list.
>
> http://lore.kernel.org/all/20231226073103.116153-1-xuanzhuo@linux.alibaba=
.com

Yes, it is. (If it doesn't depend on the moving of the source).

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > >
> > > > Thanks.
> > > >
> > > >
> > > > >
> > > > > Would this be simpler?
> > > > >
> > > > > Thanks
> > > > >
> > >
> >
>


