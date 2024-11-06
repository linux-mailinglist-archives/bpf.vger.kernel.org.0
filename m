Return-Path: <bpf+bounces-44091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2299BDB5F
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 02:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF50A283C59
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 01:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A4218C00E;
	Wed,  6 Nov 2024 01:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSkp69mW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5181DA23
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857497; cv=none; b=H7sI5lFfAUGj/TT1bJ4xRCVoF4GH2prFoMMu311VmjayBAjd5OmPT5XE4uFspkTLWu6jbF7CLAl5LQGt6mLL61uCNr1tuWZKFQvBdjAXC9jguQkaZbgzOEAgmrHMOAUnAvfNN5W9J2lQvYntUqXFyVVNqYriOqHCTeiGibtnwOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857497; c=relaxed/simple;
	bh=E1o8Ua9h3BFgcjzslon141C2gcQpUugr6Nu4DmF7QCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFsSKRZ9tADTrHP1uepUFLi+BCACJhwXViBVALGCCzRzisdonOI2vbqsLYZw72Rc53NyaryaNh2DCyATBToXcVvYLdlrK47CL6ADdUrvljYzdk+lpDzSfp578Re+W+h+4m1bf9CCL/4s/fXd5BZOlNBRErtniNdH2VOxX0mWQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSkp69mW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730857493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuqCDJK08xmNhQoK0ZzL1tfWzPkTjCgzVUL2jilp0ik=;
	b=PSkp69mWb/pYmxH/5sNqXKf2If+V1DLOHIDKfq84zPW410lWV454AC+oyiOvEjXRSF81hi
	lKeXo1bm/4TcgB/fBvNptyDowPHfljEyNp90tEspwCZa4kOa/fxR7+XaYsHQmEx35HDLpS
	35fPDX6q5RK8jjIDS3qAeQvo/WzrznE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-PQe1HBazNYS88spJDX_tWQ-1; Tue, 05 Nov 2024 20:44:52 -0500
X-MC-Unique: PQe1HBazNYS88spJDX_tWQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2dcea0f03so7217461a91.1
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 17:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730857491; x=1731462291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuqCDJK08xmNhQoK0ZzL1tfWzPkTjCgzVUL2jilp0ik=;
        b=NpWnj5jULkcR/VmPz2VwYpEHDydezX/g9jm516iRfG+J2tHQKeOwExzNIp0H7x3ch0
         beEpxpZwlfWj8xuWE2gVTid4mlgFXMEgM1tYKbAbick3MUyB4bwKyezQ4eYEByQhMgu9
         +sNFrzN3x1upBq2kB8UCCy4AcKjN/yqlTu3+2iNatIRulGvSkXWCDLivKETdfV+m9u79
         ahGN6G/TkMoXwf9Q9GvTw779kviLwcY/Wh+Ag123cT+djIbMCdf+KNbe8uarDXFye6zM
         PnaEnoNmGkLBUBV3I/kCMh1G02wf4ToWkoetCjyBiR5x9a7x6Kq2+1mbZJiy/L5YO9w3
         ikwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvXD6FO3wp1dQ2cMI3PkXBPoQCg6ZpdZgc/C3794um3tcWDhF9rXLvg9bSEVCHIbGyrBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlWpx9JDLAlBOO8wFNS95tl/zP2wqw3g976QeTqDl4anmh2dWZ
	pQ53d9j5IEyxs31zIqIihGlFgpkMLnLo44blqKLepvIWvPlG7wsKQ45qjI/NL1bD0GiLf5J3zC8
	WdkiQdNPQDFAe12ubawVUwvs9LlegH8ykakrMmWHZ88AG1J8zhDI5wZh49aOOEUT2MliP46j52C
	gPmRYpv7bekg0qwnpvugi4jghv
X-Received: by 2002:a17:90a:f0d6:b0:2e2:b8d7:4bd1 with SMTP id 98e67ed59e1d1-2e8f10a6f4fmr43513464a91.30.1730857491175;
        Tue, 05 Nov 2024 17:44:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFltoZqai1kHhior02L0euVIfli7uLwTGSJ/3R++Yo7PYyhfE0jArx6qWwJIob+A93gPHelnUhb05iNdklWF0w=
X-Received: by 2002:a17:90a:f0d6:b0:2e2:b8d7:4bd1 with SMTP id
 98e67ed59e1d1-2e8f10a6f4fmr43513434a91.30.1730857490766; Tue, 05 Nov 2024
 17:44:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
 <20241030082453.97310-3-xuanzhuo@linux.alibaba.com> <CACGkMEtP7tdxxLOtDArNCqO5b=A=a7X2NimK8be2aWuaKG6Xfw@mail.gmail.com>
 <1730789499.0809722-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1730789499.0809722-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Nov 2024 09:44:39 +0800
Message-ID: <CACGkMEt4HfEAyUGe8CL3eLJmbrcz9Uz1rhCo7_j4aShzLa4iEQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/13] virtio_ring: split: record extras for
 indirect buffers
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 2:53=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Tue, 5 Nov 2024 11:42:09 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > The subsequent commit needs to know whether every indirect buffer is
> > > premapped or not. So we need to introduce an extra struct for every
> > > indirect buffer to record this info.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 112 ++++++++++++++++-----------------=
--
> > >  1 file changed, 52 insertions(+), 60 deletions(-)
> >
> > Do we have a performance impact for this patch?
> >
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 97590c201aa2..dca093744fe1 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -69,7 +69,11 @@
> > >
> > >  struct vring_desc_state_split {
> > >         void *data;                     /* Data for callback. */
> > > -       struct vring_desc *indir_desc;  /* Indirect descriptor, if an=
y. */
> > > +
> > > +       /* Indirect extra table and desc table, if any. These two wil=
l be
> > > +        * allocated together. So we won't stress more to the memory =
allocator.
> > > +        */
> > > +       struct vring_desc *indir_desc;
> >
> > So it looks like we put a descriptor table after the extra table. Can
> > this lead to more crossing page mappings for the indirect descriptors?
> >
> > If yes, it seems expensive so we probably need to make the descriptor
> > table come first.
>
> No, the descriptors are before extra table.

Well, you need then tweak the above comment, it said

"Indirect extra table and desc table".

> So, there is not performance impact.
>
>
> >
> > >  };
> > >

[...]

> > >         while (vq->split.vring.desc[i].flags & nextflag) {
> > > -               vring_unmap_one_split(vq, i);
> > > +               vring_unmap_one_split(vq, &extra[i]);
> >
> > Not sure if I've asked this before. But this part seems to deserve an
> > independent fix for -stable.
>
> What fix?

I meant for hardening we need to check the flags stored in the extra
instead of the descriptor itself as it could be mangled by the device.

Thanks


