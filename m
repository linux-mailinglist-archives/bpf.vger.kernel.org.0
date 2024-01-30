Return-Path: <bpf+bounces-20652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A3784199C
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 03:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BBFF1F2540A
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 02:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C2C36B01;
	Tue, 30 Jan 2024 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/zRkqB2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F64364DA
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 02:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583114; cv=none; b=SWxay1laIRKFadbtFwIetMNf1dZBM1dgeIEniwVMFxQiLyTYLtjkR3EwhdYkXpWFR/2f+ysio6JzAXfgvoiKcyjiAyZwEDobYTAONUQFuomgO3oqLFp3pRH5Yk3ajnJcLX1JLxfjAZTxOSb2NtiwPwYoWRdyNDmqJvrs+DaDK6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583114; c=relaxed/simple;
	bh=vgq+Ttq5SHy3Cgg4sV/r4OhPHssGn0FpEv7dLES0sQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ReIq+TM+/SsOYzNecYmbtg35H28z510OP5lAg2Q62PO8pL2Gu/w9w4jXvkWBdut8N3FcjIFQh7RH8i4gJqbSgwTLUR78oSc7gEDDYY0AhAX/RPIUadGo4lmGZVDJ/SExv4ZyJah/zKYSjUqGo68wfdvGnQ+xU/n0qm05Gx0RQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/zRkqB2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706583112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mwsc7i1S3wArMkM1oy1GToKS0uxEPrds5sbdUzc2prc=;
	b=Q/zRkqB2OZwOBCf4PBkDCcYpbjaJsN7w3onkClajdJMZXMpk6vYsbJYnbTA+ODm5bWi1bP
	s7XXyv6nnjjCzxuYvKpi7nubQl0jCa+JQWG90NMX0uKTP8PVdQyd9nA5IkwXlWTdQxIqhY
	5P6YF+LioaQLCkd5Y1VAmd88vhnRQIE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8--h6ReNjQNP2AII0zCZEIUg-1; Mon, 29 Jan 2024 21:51:50 -0500
X-MC-Unique: -h6ReNjQNP2AII0zCZEIUg-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-59a2129fe88so2657917eaf.3
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 18:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706583109; x=1707187909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mwsc7i1S3wArMkM1oy1GToKS0uxEPrds5sbdUzc2prc=;
        b=nID3TUrYSerG9V7Fnw0v+dQPXdWJOT3J+K3QMsEzF6X0W+JWfTUeQDtnba3n/f4za1
         tsjJ308VmRHA1YrYD7J32iyXw03bEctNlQgKVuYKX4cD5VJtOTJxlGdWsVnHxIHroEs9
         n9K3LhsVqE7wNi/yWRjGP28Da5XOhR5o8wXHCgnpfehmmgDDzYMtWSMzcOTJjsayj29l
         +P4D9V6DjZxD9J+QffKMeviycvvuym6n6KNTdcnctp4wbjy7ZCjKON70nTu27AduTDtR
         lhBVIjNQDSsOa++n5KGTV0uOEllO2vxqPxEPz/J2x7kIDYbJR2WjgvJ6PWFqstQtmq8a
         wJUw==
X-Gm-Message-State: AOJu0Yzn4Pbt5r4wRw3NEUxDNVSBMj+e+DTmGQjeTifjMsbjID1M/ItR
	qS/6JWBGzJwPIBt4TWo7N0Q5iO2rkW6GqFXhiCOBIJV8PVO8UpQN7qyuFji6KFWFNQm3s8lm1xl
	lYRFVQL+tzh8mY8q0vce2g5tvmCqE/ASFCBX//EkrZ4GEu4pEnDsgIlqxI8TJ1W4u/nMSaGd3YH
	3dSh5K60vjYBXEcy7oIFMLe4kE
X-Received: by 2002:a05:6358:d59b:b0:176:4f31:75de with SMTP id ms27-20020a056358d59b00b001764f3175demr6243930rwb.6.1706583109243;
        Mon, 29 Jan 2024 18:51:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7AvjpjzDtmO20yYGtALv7t+1dPk9EFNC0UibJRoJbl208BySo70o9vW7SMSNg2pJTjN1TduhBYIT4BPhhBDk=
X-Received: by 2002:a05:6358:d59b:b0:176:4f31:75de with SMTP id
 ms27-20020a056358d59b00b001764f3175demr6243920rwb.6.1706583108916; Mon, 29
 Jan 2024 18:51:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuvubWfg8Wc+=eNqg1rHR+PD6jsH7_QEJV6=S+DUVdThQ@mail.gmail.com>
 <1706161325.4430635-1-xuanzhuo@linux.alibaba.com> <1706161768.900584-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEug-=C+VQhkMYSgUKMC==04m7-uem_yC21bgGkKZh845w@mail.gmail.com>
 <1706163935.2439404-5-xuanzhuo@linux.alibaba.com> <CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rHYqRZxYg@mail.gmail.com>
 <1706499476.9318902-3-xuanzhuo@linux.alibaba.com> <1706509439.850925-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706509439.850925-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jan 2024 10:51:37 +0800
Message-ID: <CACGkMEsSXeXEHAHjpK5VJQXCD4NRrtjAgSjTB4MJPC3PiEKFBw@mail.gmail.com>
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

On Mon, Jan 29, 2024 at 2:28=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 29 Jan 2024 11:37:56 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote:
> > On Mon, 29 Jan 2024 11:14:43 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Thu, Jan 25, 2024 at 2:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Thu, 25 Jan 2024 14:14:58 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Thu, Jan 25, 2024 at 1:52=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Thu, 25 Jan 2024 13:42:05 +0800, Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > > > > On Thu, 25 Jan 2024 11:39:28 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo=
@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > This is the second part of virtio-net support AF_XDP zero=
 copy.
> > > > > > > > >
> > > > > > > > > The whole patch set
> > > > > > > > > http://lore.kernel.org/all/20231229073108.57778-1-xuanzhu=
o@linux.alibaba.com
> > > > > > > > >
> > > > > > > > > ## About the branch
> > > > > > > > >
> > > > > > > > > This patch set is pushed to the net-next branch, but some=
 patches are about
> > > > > > > > > virtio core. Because the entire patch set for virtio-net =
to support AF_XDP
> > > > > > > > > should be pushed to net-next, I hope these patches will b=
e merged into net-next
> > > > > > > > > with the virtio core maintains's Acked-by.
> > > > > > > > >
> > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > >
> > > > > > > > > ## AF_XDP
> > > > > > > > >
> > > > > > > > > XDP socket(AF_XDP) is an excellent bypass kernel network =
framework. The zero
> > > > > > > > > copy feature of xsk (XDP socket) needs to be supported by=
 the driver. The
> > > > > > > > > performance of zero copy is very good. mlx5 and intel ixg=
be already support
> > > > > > > > > this feature, This patch set allows virtio-net to support=
 xsk's zerocopy xmit
> > > > > > > > > feature.
> > > > > > > > >
> > > > > > > > > At present, we have completed some preparation:
> > > > > > > > >
> > > > > > > > > 1. vq-reset (virtio spec and kernel code)
> > > > > > > > > 2. virtio-core premapped dma
> > > > > > > > > 3. virtio-net xdp refactor
> > > > > > > > >
> > > > > > > > > So it is time for Virtio-Net to complete the support for =
the XDP Socket
> > > > > > > > > Zerocopy.
> > > > > > > > >
> > > > > > > > > Virtio-net can not increase the queue num at will, so xsk=
 shares the queue with
> > > > > > > > > kernel.
> > > > > > > > >
> > > > > > > > > On the other hand, Virtio-Net does not support generate i=
nterrupt from driver
> > > > > > > > > manually, so when we wakeup tx xmit, we used some tips. I=
f the CPU run by TX
> > > > > > > > > NAPI last time is other CPUs, use IPI to wake up NAPI on =
the remote CPU. If it
> > > > > > > > > is also the local CPU, then we wake up napi directly.
> > > > > > > > >
> > > > > > > > > This patch set includes some refactor to the virtio-net t=
o let that to support
> > > > > > > > > AF_XDP.
> > > > > > > > >
> > > > > > > > > ## performance
> > > > > > > > >
> > > > > > > > > ENV: Qemu with vhost-user(polling mode).
> > > > > > > > > Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
> > > > > > > > >
> > > > > > > > > ### virtio PMD in guest with testpmd
> > > > > > > > >
> > > > > > > > > testpmd> show port stats all
> > > > > > > > >
> > > > > > > > >  ######################## NIC statistics for port 0 #####=
###################
> > > > > > > > >  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 10937=
41155584
> > > > > > > > >  RX-errors: 0
> > > > > > > > >  RX-nombuf: 0
> > > > > > > > >  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030=
645664
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >  Throughput (since last show)
> > > > > > > > >  Rx-pps:   8861574     Rx-bps:  3969985208
> > > > > > > > >  Tx-pps:   8861493     Tx-bps:  3969962736
> > > > > > > > >  ########################################################=
####################
> > > > > > > > >
> > > > > > > > > ### AF_XDP PMD in guest with testpmd
> > > > > > > > >
> > > > > > > > > testpmd> show port stats all
> > > > > > > > >
> > > > > > > > >   ######################## NIC statistics for port 0  ###=
#####################
> > > > > > > > >   RX-packets: 68152727   RX-missed: 0          RX-bytes: =
 3816552712
> > > > > > > > >   RX-errors: 0
> > > > > > > > >   RX-nombuf:  0
> > > > > > > > >   TX-packets: 68114967   TX-errors: 33216      TX-bytes: =
 3814438152
> > > > > > > > >
> > > > > > > > >   Throughput (since last show)
> > > > > > > > >   Rx-pps:      6333196          Rx-bps:   2837272088
> > > > > > > > >   Tx-pps:      6333227          Tx-bps:   2837285936
> > > > > > > > >   #######################################################=
#####################
> > > > > > > > >
> > > > > > > > > But AF_XDP consumes more CPU for tx and rx napi(100% and =
86%).
> > > > > > > > >
> > > > > > > > > ## maintain
> > > > > > > > >
> > > > > > > > > I am currently a reviewer for virtio-net. I commit to mai=
ntain AF_XDP support in
> > > > > > > > > virtio-net.
> > > > > > > > >
> > > > > > > > > Please review.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Rethink of the whole design, I have one question:
> > > > > > > >
> > > > > > > > The reason we need to store DMA information is to harden th=
e virtqueue
> > > > > > > > to make sure the DMA unmap is safe. This seems redundant wh=
en the
> > > > > > > > buffer were premapped by the driver, for example:
> > > > > > > >
> > > > > > > > Receive queue maintains DMA information, so it doesn't need=
 desc_extra to work.
> > > > > > > >
> > > > > > > > So can we simply
> > > > > > > >
> > > > > > > > 1) when premapping is enabled, store DMA information by dri=
ver itself
> > > > > > >
> > > > > > > YES. this is simpler. And this is more convenience.
> > > > > > > But the driver must allocate memory to store the dma info.
> > > > >
> > > > > Right, and this looks like the common practice for most of the NI=
C drivers.
> > > > >
> > > > > > >
> > > > > > > > 2) don't store DMA information in desc_extra
> > > > > > >
> > > > > > > YES. But the desc_extra memory is wasted. The "next" item is =
used.
> > > > > > > Do you think should we free the desc_extra when the vq is pre=
mapped mode?
> > > > > >
> > > > > >
> > > > > > struct vring_desc_extra {
> > > > > >         dma_addr_t addr;                /* Descriptor DMA addr.=
 */
> > > > > >         u32 len;                        /* Descriptor length. *=
/
> > > > > >         u16 flags;                      /* Descriptor flags. */
> > > > > >         u16 next;                       /* The next desc state =
in a list. */
> > > > > > };
> > > > > >
> > > > > >
> > > > > > The flags and the next are used whatever premapped or not.
> > > > > >
> > > > > > So I think we can add a new array to store the addr and len.
> > > > >
> > > > > Yes.
> > > > >
> > > > > > If the vq is premappd, the memory can be freed.
> > > > >
> > > > > Then we need to make sure the premapped is set before find_vqs() =
etc.
> > > >
> > > >
> > > > Yes. We can start from the parameters of the find_vqs().
> > > >
> > > > But actually we can free the dma array when the driver sets premapp=
ed mode.
> > >
> > > Probably, but that's kind of odd.
> > >
> > > init()
> > >     alloc()
> > >
> > > set_premapped()
> > >     free()
> >
> > If so, the premapped option will be a find_vqs parameter,
> > the api virtqueue_set_dma_premapped will be removed.
> > And we can put the buffer_is_premapped to the struct virtqueue,
> > The use can access it on the fly. (You asked on #4)
>
>
> I try to pass the option to find_vqs.
>
> You know, the find_vqs has too many parameters.
> And everytime we try to add new parameter is a difficult work.
> Many places need to be changed.
>
>
>         int (*find_vqs)(struct virtio_device *, unsigned nvqs,
>                         struct virtqueue *vqs[], vq_callback_t *callbacks=
[],
>                         const char * const names[], const bool *ctx,
>                         const bool *premapped,
>                         struct irq_affinity *desc);
>
> Do you have any preference if I try to refactor this to pass a struct?
>
> Thanks.

This should be fine.

Thanks


