Return-Path: <bpf+bounces-20996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B2F846642
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 04:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677D828AEF7
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207D1F9C1;
	Fri,  2 Feb 2024 03:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jS19iiFx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB78F4E0
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843073; cv=none; b=SjuhcNhMT15xFCHc0BW39cupM7g9xQnYWtJGAELDvU0ju3l9bnmjKT3c/7dMKJyXypnkc9BXhvDrz6ixgZMb/Z94Q5UjZpN/aUMtwmNYIHJcOptzEWcaZ5tXNxBhOPSxsftCv9edP0Bs4XaOniijbEvAes54n7SUbKIewcdh/h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843073; c=relaxed/simple;
	bh=trs6Rn1H1ZkmWTtPKs3UKhXIV0cqDS1Xgqbtt37JbzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOnx2ANalmoma94WWBgXqSZS7TX91aKL3SW6GHMOJlf9/oJS0KE/p6KeaAtK8ccX2BotEaEldLr6mnHTLk9aC5NoSmMjwhVKWU6wwhHICHf6dAmk4JInLH++/2mv5nRkBQEm2jgqkxSsiVEbB/sGi5zo6CvYP42+LfLmEY1MziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jS19iiFx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706843071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jjk3jE8PhNNZNmWy+1f2O2oViFlMeQMdnMn/9Z9Ruw=;
	b=jS19iiFxFSeOumX1Ayfk4M2wmdrzniRl8Q71UA37UtvZPuGewQpvF2fIk/9fJuMRRQr8ti
	uxBJYZV/VhV7Vaz2JqOH0hAITcdKhqix4ifAMdrXf7EoH3+K4Nei+Hct/aDumCT0jK+X2v
	JUt6Kn9FAfrrblTiR5delaVdVRAnFNE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-VHU9cRECMMO-t2fRJNrxCw-1; Thu, 01 Feb 2024 22:04:29 -0500
X-MC-Unique: VHU9cRECMMO-t2fRJNrxCw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ddcf5f19b1so1613178b3a.3
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 19:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706843068; x=1707447868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jjk3jE8PhNNZNmWy+1f2O2oViFlMeQMdnMn/9Z9Ruw=;
        b=NtYnBTCkOSzDktY1LCbokOSRVCIbvpRQsI6GUeFq2IPB+H+aobzaGizTr9civdJt8h
         0ky54FbBUxoEv4snI7URwXckln9OnCZHsdf/MNpQ0uzS1u0kzjnYylfkMjzYdrzRugW2
         nHYSBoZDYKOL4z0BPOkvPBob5EvMaIj1ZMxJcnO+P200AKhHj0s/8GK3WlYqdZggPbEj
         IfzFWyZMTvS7dGhjRebuJomddglVc3Pbqh+URNyR2eyFPK8XZs89XX/PpUQZNLK5SmRO
         uxlnA0tMd6PnFavWvDVmtSNjitWKE9hK4WVTeUaUJpqJ8LSGWtu6UVFZbvhwjHj4GNJO
         DHMQ==
X-Gm-Message-State: AOJu0YyS9I0jBtb0rzQS6LLiunHxuec6vsLUD1gQnhpZdPrXgQABs0Ym
	xi22jT/yFtM/Oa0JPBEg/iEx9IpIGH1RnLJGIpt/pXCVkoqP0qxz9lRsadnZ/IufXdO/w80qkYd
	eS5X+cMIWTb6/SSnfL307+MxgLFojPmEIP019EwSg6mnhfbmvDCpGNG1G5rdhtIvGtCH5px8k8Y
	H/L/1kA4rpW2LdrPs4TfFBawb3
X-Received: by 2002:aa7:8a4f:0:b0:6d9:9613:cb9e with SMTP id n15-20020aa78a4f000000b006d99613cb9emr4121333pfa.29.1706843068411;
        Thu, 01 Feb 2024 19:04:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnfmCLPGlpseo2aKm7Vdc5x3EZtRZIzutRGAyaKH3V2ZuLamufaE9axFl8TAes1c8kVipviNI+/nVDsMZzFNU=
X-Received: by 2002:aa7:8a4f:0:b0:6d9:9613:cb9e with SMTP id
 n15-20020aa78a4f000000b006d99613cb9emr4121309pfa.29.1706843068115; Thu, 01
 Feb 2024 19:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-7-xuanzhuo@linux.alibaba.com> <CACGkMEtNCjvtDWySzeAqETGZtBSL0MR6=JySBBtm3=s19wB=1w@mail.gmail.com>
 <1706767497.2529867-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706767497.2529867-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 2 Feb 2024 11:04:17 +0800
Message-ID: <CACGkMEs80VRVUaWJX6SFcQAzBy3Yo2M=0zkDspt10FyyzR7FqQ@mail.gmail.com>
Subject: Re: [PATCH vhost 06/17] virtio_ring: no store dma info when unmap is
 not needed
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 2:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Wed, 31 Jan 2024 17:12:29 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > As discussed:
> > > http://lore.kernel.org/all/CACGkMEug-=3DC+VQhkMYSgUKMC=3D=3D04m7-uem_=
yC21bgGkKZh845w@mail.gmail.com
> > >
> > > When the vq is premapped mode, the driver manages the dma
> > > info is a good way.
> > >
> > > So this commit make the virtio core not to store the dma
> > > info and release the memory which is used to store the dma
> > > info.
> > >
> > > If the use_dma_api is false, the memory is also not allocated.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---

[...]

> > >
> > > @@ -1245,14 +1269,16 @@ static u16 packed_last_used(u16 last_used_idx=
)
> > >
> > >  /* caller must check vring_need_unmap_buffer() */
> > >  static void vring_unmap_extra_packed(const struct vring_virtqueue *v=
q,
> > > -                                    const struct vring_desc_extra *e=
xtra)
> > > +                                    unsigned int i)
> > >  {
> > > +       const struct vring_desc_extra *extra =3D &vq->packed.desc_ext=
ra[i];
> > > +       const struct vring_desc_dma *dma =3D &vq->packed.desc_dma[i];
> > >         u16 flags;
> > >
> > >         flags =3D extra->flags;
> >
> > I don't think this can be compiled.
>
> I do not find any error.
> Could you say more?

Sorry, I misread the code.

It should be fine.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
>


