Return-Path: <bpf+bounces-20299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6823283B86B
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 04:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186F3286BD3
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 03:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277BD79E1;
	Thu, 25 Jan 2024 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJXZg7bi"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390F6FAE
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706153986; cv=none; b=fC3jp9BM0vzIr41atuMgOse7eMG2DrCaHAKu+QPK4EdkP5KlnhfLRXxAdqFTEwHjTvrRjhilLSYwqddQIlTZPNEEkaeC6NuQ+MyPeYW1nlFWfBNnz/AxRYlHJAsEIYd/5CsRmRdrulUH7+vP4wd5U6B6L+XSCL6bkLFS80gvg4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706153986; c=relaxed/simple;
	bh=bzfgSrTXZv75Mm6hevdNUUdlfQUg3HZgZpDtc3gLtjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMysi8mOgRE7EI9JyWlYelG0Hzb+8qnl8vzXGePfID1KInNt56eI7r5BIOHwx5ZQgX69YqFJukUxlswq45aHMMDvxOkAKseIrWCFc65xrLVGicIRvmi049di3LrBUl50oN5BlUkxvQSD2gzDemq7gldpYw8TQ4j3nuGiVOiCo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJXZg7bi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706153984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhIcirBtLyJR8yn+TaM7AmyOi7FPWH074qlYOHeT1Pg=;
	b=DJXZg7biWznU00Z7ZSBt9gDnVbABCoQtH2BN1BnKLDTlDwAijsL82Ull8OF/uwmutsWjQz
	gX6pg7NGOD/CaPziGkNBhxCvW5tRiBB2gsCL+ev3zPefZahx8CA5LTfOBys7JYBqDNgg6L
	0zAxCx4lcAkQsw8rC40C3aSwCaWJC7A=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-uM50eyFAMaO3ERpzUMukCg-1; Wed, 24 Jan 2024 22:39:42 -0500
X-MC-Unique: uM50eyFAMaO3ERpzUMukCg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6d9b082bb80so9650202b3a.0
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 19:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706153980; x=1706758780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhIcirBtLyJR8yn+TaM7AmyOi7FPWH074qlYOHeT1Pg=;
        b=bLTlqdLGFoaoq6I/LDq5VA/3Ewk8lOWcexN9b9WXkqgW26rwFcU1LtG4OF+9DUawx3
         WI8v87X42SbR/GK/7BlOmHjg4Gyj3dUf1RpS8bmws6YokZAWbnR7PXQ4BTLYsd1pxObj
         tHTduPSSSIJDJpl6r8VedX26J+KipZlBy4mGQCUqxZ+8WdkyRjFUOtdgBTjG1qE2ASEc
         IE0XavsNTXi1XWtW9xqd1Nzza97J/i2pRqFGT0tYy9C4Shd8/6xvH5aoSzxXl/et6yw0
         bAw6hH/soo9E+JHY5fWFK++ikrO9qwJ2ZVPyuPX5Etox3L0y7f0aqT1Z+u/+3tSUzmYk
         PQ8Q==
X-Gm-Message-State: AOJu0YxaceQBF53vFf6soCOcOFjYSl/j4x8ZbtW1ssXJwvTHi+J6dWoj
	V+lSFZUaOMalNY5qd2NgQIPP4nbTiUckRrf4Pa3ce9TaY53UR13BZX8MrjhAvRkqH46kLgUI8v1
	IWUaVl8Eca8ZZq3y77To5+VGyw1RkwM5PvL2lb6Wii6UEpYuJXWORMRp4jfuWaCWwCJ6tczXUn4
	DFe6VE4pKN3MaSHBmmKDqUnQT5
X-Received: by 2002:a05:6a00:27a3:b0:6d9:b66f:3d16 with SMTP id bd35-20020a056a0027a300b006d9b66f3d16mr291084pfb.50.1706153980666;
        Wed, 24 Jan 2024 19:39:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaSzOq8OPaBB6Tm8EEh0l52HE0p4Uu3X2xESlPVUQ9JKv5URCEQPGZtpr7WpXJp0bAO33LkGRhVaAqIrGA+vI=
X-Received: by 2002:a05:6a00:27a3:b0:6d9:b66f:3d16 with SMTP id
 bd35-20020a056a0027a300b006d9b66f3d16mr291071pfb.50.1706153980378; Wed, 24
 Jan 2024 19:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Jan 2024 11:39:28 +0800
Message-ID: <CACGkMEuvubWfg8Wc+=eNqg1rHR+PD6jsH7_QEJV6=S+DUVdThQ@mail.gmail.com>
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

On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This is the second part of virtio-net support AF_XDP zero copy.
>
> The whole patch set
> http://lore.kernel.org/all/20231229073108.57778-1-xuanzhuo@linux.alibaba.=
com
>
> ## About the branch
>
> This patch set is pushed to the net-next branch, but some patches are abo=
ut
> virtio core. Because the entire patch set for virtio-net to support AF_XD=
P
> should be pushed to net-next, I hope these patches will be merged into ne=
t-next
> with the virtio core maintains's Acked-by.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
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

Rethink of the whole design, I have one question:

The reason we need to store DMA information is to harden the virtqueue
to make sure the DMA unmap is safe. This seems redundant when the
buffer were premapped by the driver, for example:

Receive queue maintains DMA information, so it doesn't need desc_extra to w=
ork.

So can we simply

1) when premapping is enabled, store DMA information by driver itself
2) don't store DMA information in desc_extra

Would this be simpler?

Thanks


