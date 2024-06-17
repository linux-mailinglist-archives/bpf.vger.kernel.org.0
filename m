Return-Path: <bpf+bounces-32270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F9E90A5BD
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 08:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26291C25C77
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 06:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94671862BD;
	Mon, 17 Jun 2024 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HS28IQfI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027FCDDAD
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605710; cv=none; b=jfMdMeGrAREflRFho4x3RTCBURKh/AlgiTh/WHac+bnEiiflwjNqBV4kMlksPO3ivectvm9OZ4CsuBPIfHhrWqU9jWNtv8X4GslLe9z+t5JGIeHLCJIT09/J4JIKGZtVKaQmgXwrutsP9DdRj0Pq/nebvkPddvwex89w3NYPPJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605710; c=relaxed/simple;
	bh=OSTkYO2YEbZIEWcvOK8gFKoY42oPBjRDD1sYUp4a7Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5vxrDqOUYe08HbbrVEAxk034JfN7pUmuSTs9iynGzSUtN+3tcUQ2oHJC2K90ClEMGhloUp2msOYzeWXdlxhPQHBGFQpo0mPfpk1m1lSCAEEIhBBfOpVkx279XnDN4A1q7JnqVc9PJtZX7fcwsed1ZORd45vhXOms6oxq7XcNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HS28IQfI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718605706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ps5JswGrFVlCCUIk9N0xG3axjAOsPQkWEjzfIjAMKY=;
	b=HS28IQfIYEOYZwiFeTlC1tW38benzwHbFD0J+/C8MX2nNt3db0yEoRpKDH8Vh2JtejoBfY
	Q63gL1qZgwtS9ZsVecS3PjgUuFQDqNHMB3YxnySyTOudg5y+r1Oyz/voWiann5NMlnJHyw
	ZXonD1IwKzNiJTMiervwSf5lCM1lG5U=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-rjgMXmlBMqaUKVwUWLg2TQ-1; Mon, 17 Jun 2024 02:28:20 -0400
X-MC-Unique: rjgMXmlBMqaUKVwUWLg2TQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7024261bb31so3862336b3a.1
        for <bpf@vger.kernel.org>; Sun, 16 Jun 2024 23:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718605698; x=1719210498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ps5JswGrFVlCCUIk9N0xG3axjAOsPQkWEjzfIjAMKY=;
        b=Zbs/FVkZyDqojKlNWhTX+nOj6T+tUInIF31AepAXQzRZYdnqJzZhm3GyRLCNLYOv9F
         u1aQbZIF4PwhDPl7F3P80VALK4F/owKupyAhVzLx2YsNF2bJapWGNO6Bfb+kAGPukSbq
         7v/5SFgMcfVLGBnLuiljactIElJD1xbYDgNcs2LrQBt4c4WUne+eKevifnDlj1ZHVEkT
         09vYWhtCRSSdBGHN/UNRedIK8zm1Lx+bIi4UdtC+0a2tBFHME8rS7tZFjfymlIvXfiLp
         hX0vVh6bdQrHS1XSZts4auIotYSg2/6fW2rtM26IIIV+KwzsENgJ6xw6DcsnY2gBCsJ2
         bq5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvXqz6ru57XFPxTps5D3TrpzEkHv2zOp4xLSM1eKenBnVvghOsYryjcJuJDcBgXWEW8Y2jWz5+dY6IOTdvA5UwJR+3
X-Gm-Message-State: AOJu0YwzaeVjnmvcx6SlElpvWX7c6jnFcYD3JNOXfBUKSHEtIlbk5Chl
	UHpmk5M9/rjKSGyj7/vtPR5mw/gc/z1652wizYtnUtC2Iscmoo7wLkJmXrCrqkeHanINhfE6378
	3wT+czJHIGpcXFsgAG8EifEAHDd2lRnXLUncdM7KaXhvL1ZITf7FTatCjc8lpY8ku438+81ztxS
	kePWkAnZ2ca/V1XJIiYlz8JZuD
X-Received: by 2002:a05:6a20:12c1:b0:1b8:7de9:6e3f with SMTP id adf61e73a8af0-1bae82b6515mr10689247637.53.1718605698621;
        Sun, 16 Jun 2024 23:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2baPcl2kCTFLwcSKILsceKj+PbJEWOMXTqE4MSXxS0p/rU+v6ZPazw+zzfETCZucrn8dwHiLbJUrZH9BYgxw=
X-Received: by 2002:a05:6a20:12c1:b0:1b8:7de9:6e3f with SMTP id
 adf61e73a8af0-1bae82b6515mr10689221637.53.1718605698270; Sun, 16 Jun 2024
 23:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-9-xuanzhuo@linux.alibaba.com> <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
In-Reply-To: <CACGkMEu49yaJ+ZBAqP_e1T7kw-9GV8rKMeT1=GtG08ty52XWMw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 14:28:05 +0800
Message-ID: <CACGkMEuxhaPcSyvNnZH3q1uvSUTbpRMr+YuK4r0x6zG_SKesbg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 08/15] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 1:00=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jun 14, 2024 at 2:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > If the xsk is enabling, the xsk tx will share the send queue.
> > But the xsk requires that the send queue use the premapped mode.
> > So the send queue must support premapped mode when it is bound to
> > af-xdp.
> >
> > * virtnet_sq_set_premapped(sq, true) is used to enable premapped mode.
> >
> >     In this mode, the driver will record the dma info when skb or xdp
> >     frame is sent.
> >
> >     Currently, the SQ premapped mode is operational only with af-xdp. I=
n
> >     this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
> >     the same SQ. Af-xdp independently manages its DMA. The kernel stack
> >     and xdp tx/redirect utilize this DMA metadata to manage the DMA
> >     info.
> >

Note that there's indeed a mode when we have exclusive XDP TX queue:

        /* XDP requires extra queues for XDP_TX */
        if (curr_qp + xdp_qp > vi->max_queue_pairs) {
                netdev_warn_once(dev, "XDP request %i queues but max
is %i. XDP_TX and XDP_REDIRECT will operate in a slower locked tx
mode.\n",
                                 curr_qp + xdp_qp, vi->max_queue_pairs);
                xdp_qp =3D 0;
        }

So we need to mention how the code works in this patch.

Thanks


