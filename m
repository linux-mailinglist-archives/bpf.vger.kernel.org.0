Return-Path: <bpf+bounces-21608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08AD84F575
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 13:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920611C21C6F
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF4376FD;
	Fri,  9 Feb 2024 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCLuVX9+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A11374E6
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483453; cv=none; b=q1d4z8NZci/sKs70OvMLpNnmNo9ZRSQcky9+yigz8urqMdNA9f0AcSFPnvbqjZ3No8qiI4w6f/X7iHtpRpGN1KorVVZ5Gp7/5zuaDM8PQ0Xa4+OXHNTGlvHRIYQEKUfjXjrJchLtwzlCGayd9Ap+dyNQd1xF9Tr70nTZaGBVSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483453; c=relaxed/simple;
	bh=kw30KAnxzMTS7QahoenLIh/ATo5v/rxGqhZo4U7lHpo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T+5RzTbJZpubv/xxGzXk58m8761kHpFBq9f1P1NuAHvE/2BbbhLlw4m7Tg6LThRjRRTORM2ATjOA5z0UbI61k3jlOXfRhaDe1gOh5B3XsLqF1N+Kstb5V14AIwnoqd1M3CogvroFVky7g6Bs/oFd7JOATeCBxkjX8frAMshylUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCLuVX9+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707483450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nIOUyXxSODcrgDjv47Zc1StfAXnOUNkL/xlSTZT0jao=;
	b=MCLuVX9+cK9qCQjjXQJd0T/zhJL+Nu/OvQgnhqSoeKP4WpPL+/Ip0ftGDRH4H9sBU1PM0n
	qEqHRH/y468IIOhntcb2Z4a3r0arg95SyBR8US0EyDm5E2lyuT4BV17/RBzUd5fMBWwe2M
	vGX854R1ildv8KgRCvY2/IxvaAdihOA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-3XsP0QrKMSSHoDXUw35NrQ-1; Fri, 09 Feb 2024 07:57:29 -0500
X-MC-Unique: 3XsP0QrKMSSHoDXUw35NrQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so2186735e9.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 04:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707483448; x=1708088248;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIOUyXxSODcrgDjv47Zc1StfAXnOUNkL/xlSTZT0jao=;
        b=KgJTUJB04XYizfk96kEZPFRU6v2qfy6YGnZ/sD3uY7WqIjQaPROTRMcwiCrByYGT/l
         D6vnooMzHVRPz/bnMjA9huTqQ5/uLiLlTTwlFGoWgaJ/Y/yG5utp1oyA8kdTrMW+U+Vs
         omHjuj5qbpLo/59y4FFzJiUcCUOllePPDqN6qATK6pwA3O1+L0DrxD8Gesx2pu6l2xVT
         6ccPqXcowYwT4YTs+k31MvxcjeM7azQUL0rSmw+cwXN7GtwW/2ZXUxekAcP/Tw6U6hlM
         fjjpYc2+wfCv75Zfad5HBFVn7dpgKlt+Sv+fcIkt3NTqwhHq9fG45HeuOiqitmvRHccZ
         c0sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB+6JXzDkvixLuN6ndLWi4cFwEcr707CLA6FKzpkY7PZp74yvTjIKupDWPUB1kTkoiZ0ESpVUWVqAxMqvuECThJY33
X-Gm-Message-State: AOJu0YxEBYj8nZLcORq6D48SzmlscplrBp0ea7uNnjAnBgM3Hzw43pkQ
	9UFd+Orri+UPS03Ubebe7cNIP0jlRrg6Wl2aLRvVqti/Lsc4gZdl8MlMFQXfcm7VCrPjjrvlAsC
	s9bLwuJ5mH3clLiMw+a7GtzyvjZp0tWpxcjC3/CArR6uudPKxUg==
X-Received: by 2002:a05:600c:4f8e:b0:40f:b8d6:7586 with SMTP id n14-20020a05600c4f8e00b0040fb8d67586mr1145867wmq.2.1707483447908;
        Fri, 09 Feb 2024 04:57:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJC3gROe4D9aMh2qYlAGe00wKHL14AEpyMapfVvYFA5O2qJq+KnLDGijY/xtwJgBQvp/0n3g==
X-Received: by 2002:a05:600c:4f8e:b0:40f:b8d6:7586 with SMTP id n14-20020a05600c4f8e00b0040fb8d67586mr1145850wmq.2.1707483447511;
        Fri, 09 Feb 2024 04:57:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2pWU7bUzAhibG/bBZ4JZy0qitjU5N//2KrLlhui0dTaAZtuov8dpW+LGj7pFUa/6s0uMYiBOgWUpExhLPjgA0ewCyoq7rSr6GG9kM6YxTCAqTQ7gJrYqZR6TfIB/8ckPGDSrBBAP6jWsiABN+uh12miXlV7s0OFJJCKzV7/OxWH3rMr1YPft5//RezXOsaaHIQXEbq257KtkD1XKEqZ5Ml2J/GOOuy2zVRyYsz+hNmG2NNICzXM7AExr9eG4saHjoAcC5+w5vEUzmYWwVCPtw6L4BeBOs+kd0kz3093FWTAnSUvm+nkrmBVsEu27kqNi1FRJVyB8AlNiQ+WNJ1qE6eNo5YZ9Ku01K8rKSyBWGq1PpX8bJ2nJHpscT3wCRQ883l3e5Z/sv6cdv36X0lnVvEVfF4ZoCcdSO2q+BDhSKTBTFaNOa77vP92Q6DwLlqRkJ+NyuMC2wRlN44CEa9YiKr3/3YnW0wL7+K116C92W
Received: from gerbillo.redhat.com (146-241-228-88.dyn.eolo.it. [146.241.228.88])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c219a00b004107ab91f96sm579578wme.8.2024.02.09.04.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 04:57:26 -0800 (PST)
Message-ID: <1b2d471a5d06ecadcb75e3d9155b6d566afb2767.camel@redhat.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
From: Paolo Abeni <pabeni@redhat.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, mst@redhat.com, 
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org,  virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
 john.fastabend@gmail.com, daniel@iogearbox.net,  ast@kernel.org
Date: Fri, 09 Feb 2024 13:57:25 +0100
In-Reply-To: <CAKhg4tJPjcShkw4-FHFkKOcgzHK27A5pMu9FP7OWj4qJUX1ApA@mail.gmail.com>
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
	 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org>
	 <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
	 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
	 <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
	 <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
	 <CAKhg4tJPjcShkw4-FHFkKOcgzHK27A5pMu9FP7OWj4qJUX1ApA@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-09 at 18:39 +0800, Liang Chen wrote:
> On Wed, Feb 7, 2024 at 10:27=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > On Wed, 2024-02-07 at 10:54 +0800, Liang Chen wrote:
> > > On Tue, Feb 6, 2024 at 6:44=E2=80=AFPM Paolo Abeni <pabeni@redhat.com=
> wrote:
> > > >=20
> > > > On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > > > > On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard Brouer <h=
awk@kernel.org> wrote:
> > > > > > On 02/02/2024 13.11, Liang Chen wrote:
> > > > [...]
> > > > > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_b=
uff *xdp)
> > > > > > >       }
> > > > > > >   }
> > > > > > >=20
> > > > > > > +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff=
 *virtnet_xdp,
> > > > > > > +                                  struct net_device *dev,
> > > > > > > +                                  struct virtio_net_hdr_v1_h=
ash *hdr_hash)
> > > > > > > +{
> > > > > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > > > > +             virtnet_xdp->hash_value =3D hdr_hash->hash_valu=
e;
> > > > > > > +             virtnet_xdp->hash_report =3D hdr_hash->hash_rep=
ort;
> > > > > > > +     }
> > > > > > > +}
> > > > > > > +
> > > > > >=20
> > > > > > Would it be possible to store a pointer to hdr_hash in virtnet_=
xdp_buff,
> > > > > > with the purpose of delaying extracting this, until and only if=
 XDP
> > > > > > bpf_prog calls the kfunc?
> > > > > >=20
> > > > >=20
> > > > > That seems to be the way v1 works,
> > > > > https://lore.kernel.org/all/20240122102256.261374-1-liangchen.lin=
ux@gmail.com/
> > > > > . But it was pointed out that the inline header may be overwritte=
n by
> > > > > the xdp prog, so the hash is copied out to maintain its integrity=
.
> > > >=20
> > > > Why? isn't XDP supposed to get write access only to the pkt
> > > > contents/buffer?
> > > >=20
> > >=20
> > > Normally, an XDP program accesses only the packet data. However,
> > > there's also an XDP RX Metadata area, referenced by the data_meta
> > > pointer. This pointer can be adjusted with bpf_xdp_adjust_meta to
> > > point somewhere ahead of the data buffer, thereby granting the XDP
> > > program access to the virtio header located immediately before the
> >=20
> > AFAICS bpf_xdp_adjust_meta() does not allow moving the meta_data before
> > xdp->data_hard_start:
> >=20
> > https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4210
> >=20
> > and virtio net set such field after the virtio_net_hdr:
> >=20
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_net.c=
#L1218
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_net.c=
#L1420
> >=20
> > I don't see how the virtio hdr could be touched? Possibly even more
> > important: if such thing is possible, I think is should be somewhat
> > denied (for the same reason an H/W nic should prevent XDP from
> > modifying its own buffer descriptor).
>=20
> Thank you for highlighting this concern. The header layout differs
> slightly between small and mergeable mode. Taking 'mergeable mode' as
> an example, after calling xdp_prepare_buff the layout of xdp_buff
> would be as depicted in the diagram below,
>=20
>                       buf
>                        |
>                        v
>         +--------------+--------------+-------------+
>         | xdp headroom | virtio header| packet      |
>         | (256 bytes)  | (20 bytes)   | content     |
>         +--------------+--------------+-------------+
>         ^                             ^
>         |                             |
>  data_hard_start                    data
>                                   data_meta
>=20
> If 'bpf_xdp_adjust_meta' repositions the 'data_meta' pointer a little
> towards 'data_hard_start', it would point to the inline header, thus
> potentially allowing the XDP program to access the inline header.

I see. That layout was completely unexpected to me.

AFAICS the virtio_net driver tries to avoid accessing/using the
virtio_net_hdr after the XDP program execution, so nothing tragic
should happen.

@Michael, @Jason, I guess the above is like that by design? Isn't it a
bit fragile?

Thanks!

Paolo


