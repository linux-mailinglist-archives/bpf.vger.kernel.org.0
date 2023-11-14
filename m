Return-Path: <bpf+bounces-15036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5B37EA93D
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 04:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A530B20A5F
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 03:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B298F70;
	Tue, 14 Nov 2023 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCPJOtVW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064F8F4B
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 03:56:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8C9D42
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 19:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699934167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Wu1omyNFDVtFU1Hlcc2IaJQt9sbEgmhL34rN70HKs0=;
	b=GCPJOtVWmjyUptLnhOuB3vj3JtP7o3ucM9iHV4ha4Oo8j/ji4SnDBEuWp5B/wp2xwVK/PI
	pkTnuvpTorsqZbYY27pCX68C2LtMbv8kYjZ21mStthcShXLgBokSQl06INk5BG6UspYZ5A
	6VBRlduR6cwyeO87vsgHmqhqylruMic=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-HDdaFa1xOt28HcmTqbASVQ-1; Mon, 13 Nov 2023 22:56:05 -0500
X-MC-Unique: HDdaFa1xOt28HcmTqbASVQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50798a25ebaso2929785e87.0
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 19:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699934164; x=1700538964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Wu1omyNFDVtFU1Hlcc2IaJQt9sbEgmhL34rN70HKs0=;
        b=HSEMAeMUxMw2tDO2YBbHdomX8E4VwYsxR7OdrbU0YyzTN3diABYOWWlt69SiIUSSLL
         SBXLe8IdOnsVhOQQYBRs9lFUi9feJil4g7+uTYs0fToFTTYT0LH23u3OtTP4K0FyWMwH
         OQalif9knTouWfzDSVTURgn3rT2W7m5rS8K7VRTBzDIkmjdjo0y6g+c/ShBlDIq/ITSz
         uZV98upKA9YCxf848I8otizCWdul0rFClvhtoCJ/TE92cIefRaIOw7u+JiI1SRQJ3bwa
         CPtAGKJ1MRht62nrU7/ePD9bonBZT4t++YBuvsNrbFEFF5mZlwDD04to+skPozASXlSY
         llHw==
X-Gm-Message-State: AOJu0YwqYDXxPMsvGb7xugp7cXqJRdqbySZN1z9n02wXPqlYdu+Hv3yn
	4EcEyKOEXCcEN2a5A9PLE8nJ8Am/WQjNjKDJEbuEYpq5Ev15CvGAPu0w4dqMXVV6V43S6JI87RC
	wbRqVFoYFwgZ2Ko/KWlPUuMunMRCI
X-Received: by 2002:a05:6512:15a6:b0:50a:6fb8:a0c0 with SMTP id bp38-20020a05651215a600b0050a6fb8a0c0mr484423lfb.19.1699934163781;
        Mon, 13 Nov 2023 19:56:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS1MSbGPt3y7yEXZl8rECF+p48KM5DSsexq7zLBD9jB7CB91nepWM3PaNvdV3NxtMMyRByMxBbujQPLEqLfM0=
X-Received: by 2002:a05:6512:15a6:b0:50a:6fb8:a0c0 with SMTP id
 bp38-20020a05651215a600b0050a6fb8a0c0mr484409lfb.19.1699934163493; Mon, 13
 Nov 2023 19:56:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-9-xuanzhuo@linux.alibaba.com> <CACGkMEtLee8ELzqFnV_zOu3p5tU6hivouKM=WjtNAq+2wQzAFQ@mail.gmail.com>
 <1699527528.5637772-2-xuanzhuo@linux.alibaba.com> <CACGkMEu4toAuAuJdrXF0AJqsHc-ovPg3vi8=My-+BxaMi+TBSw@mail.gmail.com>
 <1699932516.9040368-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1699932516.9040368-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2023 11:55:52 +0800
Message-ID: <CACGkMEv7-U4HNe8UOENx9A+5fj-GJ7wvO=aw8v+axoiG7yhqdA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 08/21] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Tue, 14 Nov 2023 11:26:42 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Nov 9, 2023 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> > >
> > > On Thu, 9 Nov 2023 14:37:38 +0800, Jason Wang <jasowang@redhat.com> w=
rote:
> > > > On Tue, Nov 7, 2023 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > If the xsk is enabling, the xsk tx will share the send queue.
> > > > > But the xsk requires that the send queue use the premapped mode.
> > > > > So the send queue must support premapped mode.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio/main.c       | 163 ++++++++++++++++++++++++++=
++----
> > > > >  drivers/net/virtio/virtio_net.h |  16 ++++
> > > > >  2 files changed, 163 insertions(+), 16 deletions(-)
> > > > >

[...]

> > > >
> > > > I think we need to seek a way to reuse what has been stored by virt=
io
> > > > core. It should be much more efficient.
> > >
> > >
> > > Yes.
> > >
> > > But that is for net-next branch.
> > >
> > > Can we do that as a fix after that is merged to 6.8?
> >
> > We still have time. I would like to do it from the start.
>
>
> I want to finish the job including new AF_XDP ZC feature.
> Because that this must wait the merge window.
> Base on that, the optimizing work can be done everytime.
>
> If we work from the new virtio prepare, that can be merged to 6.8.
> And the AF_XDP zc must wait 6.9. right?

It can be part of this series. Or anything I missed?

My understanding is that, since the information is handy, it just
requires new helpers. So I don't expect it needs a large series.

Thanks

>
> Thanks
>


