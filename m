Return-Path: <bpf+bounces-15040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA1B7EA97E
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 05:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B502810BF
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 04:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1D3BA22;
	Tue, 14 Nov 2023 04:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPqFDXS/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B797BA26
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 04:27:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EFF1A7
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699936055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqzadG70JH4Sh39cERPLnN+o1n04W3gfURARvOks5hs=;
	b=DPqFDXS/Cjw/HmTuEOO5eIN7rcj97SuklnDGmzof4xYyDU1aDDvQJ693q+k/EtmV7koikX
	ZwwKspRpLp5dSZbCCNDpOV7xrTCCx0OIwNDA1I0WZDfpJ7ISj6m4AUSvwaNg81plz/rE5R
	2ZTKZ34S93J6WgSrZvicTp6S0xmjNxg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-CCYQo7I7N_mcFAR6p01K1g-1; Mon, 13 Nov 2023 23:27:33 -0500
X-MC-Unique: CCYQo7I7N_mcFAR6p01K1g-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507d208be33so5090506e87.3
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936052; x=1700540852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqzadG70JH4Sh39cERPLnN+o1n04W3gfURARvOks5hs=;
        b=E3QlpjF0Nf0Bjfc4kfmvK0UjFeSyXWFu+8Q0phx1tugoJELpTDvV9DEospfeTNBuEM
         BdnAuUBHvK+3TqFJ8VzNyU7OtKLrYw3f5spPswJMHuuJKpfh1WYBhOpBK139HjIqE03Q
         KbC8EBb4r/p10WvdtN56NZvRukl/l709RPzIVXldlzWRi4Dk36btlnbdrkhNM4nCvpdH
         D7rx3LKwxsO00yNQSM6bwbmJ3s6A1OgBj3ZVm4DtHdaKWHu2hQTacv73w4Rc7i2qCgJx
         rcoHzLcYzVTpoVT6uJr+HwXZJTYt40erTS3lYC2R1Sf5UCz5VP+1ZwdEpEk6C7bh0Jir
         7w1Q==
X-Gm-Message-State: AOJu0YwX7+QfDNvy4wLoSuAzLv/68vHW94i5UcL4CqSyXJYbTKg7rGeE
	aCKw8jR5ZzQ725I9EaZ1kDCCbdMuO9LDevyfo7+jDKBKO5L+L+BfLAYOzKzKHEhz716cqWhfV6n
	i8FDU97yXN28A8F9Ylc64S1Hfqs6r
X-Received: by 2002:a05:6512:533:b0:503:38f2:6e1 with SMTP id o19-20020a056512053300b0050338f206e1mr5369346lfc.5.1699936052166;
        Mon, 13 Nov 2023 20:27:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTQc75GuYH0OpfWK6f+j/4uCF3vj2Wn36+SpCeW73CuziG47fk3TyDtJKBHUcsdK5q5pFV/sxdIftw0vuJE/8=
X-Received: by 2002:a05:6512:533:b0:503:38f2:6e1 with SMTP id
 o19-20020a056512053300b0050338f206e1mr5369330lfc.5.1699936051768; Mon, 13 Nov
 2023 20:27:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-9-xuanzhuo@linux.alibaba.com> <CACGkMEtLee8ELzqFnV_zOu3p5tU6hivouKM=WjtNAq+2wQzAFQ@mail.gmail.com>
 <1699527528.5637772-2-xuanzhuo@linux.alibaba.com> <CACGkMEu4toAuAuJdrXF0AJqsHc-ovPg3vi8=My-+BxaMi+TBSw@mail.gmail.com>
 <1699932516.9040368-2-xuanzhuo@linux.alibaba.com> <CACGkMEv7-U4HNe8UOENx9A+5fj-GJ7wvO=aw8v+axoiG7yhqdA@mail.gmail.com>
 <1699934262.516097-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1699934262.516097-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2023 12:27:20 +0800
Message-ID: <CACGkMEuvdA1xWtLLsV49XCGwD8S+AXDkHeq2K3-AsqgWixZVXg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 08/21] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:59=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Tue, 14 Nov 2023 11:55:52 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Nov 14, 2023 at 11:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > On Tue, 14 Nov 2023 11:26:42 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Thu, Nov 9, 2023 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > > >
> > > > > On Thu, 9 Nov 2023 14:37:38 +0800, Jason Wang <jasowang@redhat.co=
m> wrote:
> > > > > > On Tue, Nov 7, 2023 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > If the xsk is enabling, the xsk tx will share the send queue.
> > > > > > > But the xsk requires that the send queue use the premapped mo=
de.
> > > > > > > So the send queue must support premapped mode.
> > > > > > >
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > ---
> > > > > > >  drivers/net/virtio/main.c       | 163 ++++++++++++++++++++++=
++++++----
> > > > > > >  drivers/net/virtio/virtio_net.h |  16 ++++
> > > > > > >  2 files changed, 163 insertions(+), 16 deletions(-)
> > > > > > >
> >
> > [...]
> >
> > > > > >
> > > > > > I think we need to seek a way to reuse what has been stored by =
virtio
> > > > > > core. It should be much more efficient.
> > > > >
> > > > >
> > > > > Yes.
> > > > >
> > > > > But that is for net-next branch.
> > > > >
> > > > > Can we do that as a fix after that is merged to 6.8?
> > > >
> > > > We still have time. I would like to do it from the start.
> > >
> > >
> > > I want to finish the job including new AF_XDP ZC feature.
> > > Because that this must wait the merge window.
> > > Base on that, the optimizing work can be done everytime.
> > >
> > > If we work from the new virtio prepare, that can be merged to 6.8.
> > > And the AF_XDP zc must wait 6.9. right?
> >
> > It can be part of this series. Or anything I missed?
> >
> > My understanding is that, since the information is handy, it just
> > requires new helpers. So I don't expect it needs a large series.
>
> Now, this is pushing to net-next.
>
> If we add an new virtio-core helper. That must be pushed to virtio branch=
.
> And this patch set must wait that.

I don't think so if it's just a matter of new helpers. The
acknowledgement from the virtio maintainer should be sufficient.

Let's just try and see?

THanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > Thanks
> > >
> >
>


