Return-Path: <bpf+bounces-26888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232F8A636C
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 08:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7661F21B9E
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 06:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983973C099;
	Tue, 16 Apr 2024 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km9yKBDd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AAD3B78B;
	Tue, 16 Apr 2024 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247519; cv=none; b=jyUpMBLVMIVXLPhYufBsdNPf7oVDPL931gLlcjxdwoMNg6tbCqcLV21s6XQ/JTi7bnl4bLXM85Iz4ToZscpw8qFcq+53sfySKUudo6AIS6su5ITdKvQyLW0ka/T+DLCbe1zek8ltNC1KiCAbSNwhlLU4f7JITxEet6T3MLrQVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247519; c=relaxed/simple;
	bh=2va6TA07tPbZHQYfmfqamjpjSCAGwmqHo6c9sDHfueo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJlJfd+VbQk3A+jo+tIXp9jkjZC2MZ5y8JJKFXFbShPHYWJNm0tl0fpg05XkgLP4D2tYoMwQCyT4KuVmGkDTdskH42ddvQtGh6FMJcxJY7FJdS8rPvBdb+54tJJBg+DVjsa74BgYVf9+rgipLfU2PKwHXduJn+JIedsYFBEwOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km9yKBDd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51b008b3aeso482700766b.3;
        Mon, 15 Apr 2024 23:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713247516; x=1713852316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVeIu3iZuh5BeH0nO5+xgyxUTQzhqaD9DYOn+xF/D1k=;
        b=Km9yKBDdQ2M5VmUJrr3iUV0lgIfjL5s8Sbeb/MtlwU/6DKMYEHUgyt3yimKdZPw4nn
         jxne/3sag6s30TnZARK29FkAaUf0TJyg+txlwCzc5IBGtqc0jImG8xDs2l+7XIdJa28j
         7AoCaKBWfZLdu4vqgJEONnr/5Uqcx6OE6ZzPs7lgaqztMQ9/lt2IFwkoN1jY/BBa2ueC
         z2j/nAZUHgFw8KlZMvmRWs7eCwb5Rb4epoOXq/j2iHQAx1tcS1J5AAKeHKz5bRWp28/7
         /PHfWi3Pyb+IfeExVsdJS0OPypV/c1lAk8EXLGf4k8NxNU4VvFkYUE0j3vEuD6z2YYHL
         HF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713247516; x=1713852316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVeIu3iZuh5BeH0nO5+xgyxUTQzhqaD9DYOn+xF/D1k=;
        b=gBy8fgPb+zsgs2rlLKvmv8OQlwFzbn3o+PiHPmkEXyKgDbzqu9+1lmTOUW4+ZDmkZ+
         oOLEw3OClXwFhafHwrnYgvXJsvUYmWATHfS43utVGuHaSjr58Uoq9oM/tqURRf4VzrJU
         ai5flQtllJ7MiLWt8nKFp2oSIQRnNfQA3viMESaa3fld2Oxz3rgzK7GrfAEDPd+6cRr4
         3tZuty1VBGu2sUXTILvbdL+h31h5z/UWvqKDogOD85l0ZKIeLxEiE8HWeMVZ/O/GI5rR
         VfE0/es6BAICNeZEQX2aj0YYlX0UReajRXNlerJAji1GNF+QM1YKynNAoGnxX/BmTCWd
         aQfw==
X-Forwarded-Encrypted: i=1; AJvYcCX2UqSqdBhzWImK8ksF029eshcIngjMw01PY2Nm92+9OwyKUGp2ZVlGFRSdagMmfVxZqt6ypGi9qULIuemXDEHQCtGrc/ag3tp+KYs3T4MDElh3tLKNXAQDP3eAsTx0AdyQFRbbx9bdGzUSwqW/E3ZmlVhFOqF6gYhj
X-Gm-Message-State: AOJu0YzhZ+5wI0yrEqErDFX8ljp3D+9zp0WYPozdp+OTyGSkHUZhgkLC
	8oIcMpEgo5KfHv5rQp9PRPN3zw/aE3ezYs0O+KVUQ2pHQDfeRCsAdCEUqfsvNDH3xXQEBECGGiu
	1VDSnEJriNS/C2SHSy8DXqOoWtuM=
X-Google-Smtp-Source: AGHT+IFDDfSvhXKXykNEiYbNF09kT74gern125Ecb7UQX/J1w9LVvZmjMX30hv92cxPrzmNu9rlMSf+Z7OGR8N2wIM0=
X-Received: by 2002:a17:907:9496:b0:a52:30d3:41dd with SMTP id
 dm22-20020a170907949600b00a5230d341ddmr10199039ejc.41.1713247515527; Mon, 15
 Apr 2024 23:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413041035.7344-1-liangchen.linux@gmail.com> <01c82cfb-e215-4929-9540-484378275ec3@kernel.org>
In-Reply-To: <01c82cfb-e215-4929-9540-484378275ec3@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Tue, 16 Apr 2024 14:05:02 +0800
Message-ID: <CAKhg4t+AzkV3qNfg5CTB8dGy7wk_RfEfO799+P+yAqPncK2=mA@mail.gmail.com>
Subject: Re: [PATCH net-next v7] virtio_net: Support RX hash XDP hint
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, john.fastabend@gmail.com, daniel@iogearbox.net, 
	ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:36=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 13/04/2024 06.10, Liang Chen wrote:
> > The RSS hash report is a feature that's part of the virtio specificatio=
n.
> > Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhos=
t
> > (still a work in progress as per [1]) support this feature. While the
> > capability to obtain the RSS hash has been enabled in the normal path,
> > it's currently missing in the XDP path. Therefore, we are introducing
> > XDP hints through kfuncs to allow XDP programs to access the RSS hash.
> >
> > 1.
> > https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@dayni=
x.com/#r
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >    Changes from v6:
> > - fix a coding style issue
> >    Changes from v5:
> > - Preservation of the hash value has been dropped, following the conclu=
sion
> >    from discussions in V3 reviews. The virtio_net driver doesn't
> >    accessing/using the virtio_net_hdr after the XDP program execution, =
so
> >    nothing tragic should happen. As to the xdp program, if it smashes t=
he
> >    entry in virtio header, it is likely buggy anyways. Additionally, lo=
oking
> >    up the Intel IGC driver,  it also does not bother with this particul=
ar
> >    aspect.
> > ---
> >   drivers/net/virtio_net.c | 55 +++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 55 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c22d1118a133..2a1892b7b8d3 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4621,6 +4621,60 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >       }
> >   }
> >
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                            enum xdp_rss_hash_type *rss_type)
> > +{
> > +     const struct xdp_buff *xdp =3D (void *)_ctx;
> > +     struct virtio_net_hdr_v1_hash *hdr_hash;
> > +     struct virtnet_info *vi;
> > +
> > +     if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> > +             return -ENODATA;
> > +
> > +     vi =3D netdev_priv(xdp->rxq->dev);
> > +     hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hd=
r_len);
> > +
> > +     switch (__le16_to_cpu(hdr_hash->hash_report)) {
> > +     case VIRTIO_NET_HASH_REPORT_TCPv4:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV4_TCP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_UDPv4:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV4_UDP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_TCPv6:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_UDPv6:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_TCPv6_EX:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_UDPv6_EX:
> > +             *rss_type =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_IPv4:
> > +             *rss_type =3D XDP_RSS_TYPE_L3_IPV4;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_IPv6:
> > +             *rss_type =3D XDP_RSS_TYPE_L3_IPV6;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_IPv6_EX:
> > +             *rss_type =3D XDP_RSS_TYPE_L3_IPV6_EX;
> > +             break;
> > +     case VIRTIO_NET_HASH_REPORT_NONE:
> > +     default:
> > +             *rss_type =3D XDP_RSS_TYPE_NONE;
> > +     }
>
> Why is this not implemented as a table lookup?
>

Sure. Thanks for the suggestion!

> Like:
>
> https://elixir.bootlin.com/linux/v6.9-rc4/source/drivers/net/ethernet/int=
el/igc/igc_main.c#L6652
>   https://elixir.bootlin.com/linux/latest/A/ident/xdp_rss_hash_type
>
> --Jesper
>
> > +
> > +     *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> > +     return 0;
> > +}
> > +
> > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D {
> > +     .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > +};
> > +
> >   static int virtnet_probe(struct virtio_device *vdev)
> >   {
> >       int i, err =3D -ENOMEM;
> > @@ -4747,6 +4801,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >                                 VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> >
> >               dev->hw_features |=3D NETIF_F_RXHASH;
> > +             dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> >       }
> >
> >       if (vi->has_rss_hash_report)

