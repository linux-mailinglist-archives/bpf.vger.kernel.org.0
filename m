Return-Path: <bpf+bounces-27018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 764CE8A7ACC
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 04:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCB7282494
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 02:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD7B79C0;
	Wed, 17 Apr 2024 02:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGIFg4c5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92D1878;
	Wed, 17 Apr 2024 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713322542; cv=none; b=BYgWVBR7Jdho/jCoStNwZq63W0vlRWmAlTqzUeRY2ZHmS3voe21Ds+3+aQ5aBNggrrASNuK5XKXYbuJbV1qq/VGspTId9+wEplewG+cYPxZFMQl9GkD7qRnI/hwKCpBBGdM8kFhkhzpaqlqtQ6380BIDz1III0MwTaPEe+t0u6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713322542; c=relaxed/simple;
	bh=IAj14PITpzUBBfd0BdPRImzQrp8Sr8llvz7H0t6Se+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIztE5tlnGIxoYNVPXo5alU5XKeVkpI8iOYA45KzmFfhlC203odQWwuNEVBjNsyijGK0XM8S2f6Gjuwkwtc90ws3Nch272i3IwT35Wfm3AtaK/40pKUV2TpoTZvy70+kLNlHL63njpqPS/hVVSeM9J7M4H07Lj450zf0GBpRM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGIFg4c5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso8210622a12.3;
        Tue, 16 Apr 2024 19:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713322538; x=1713927338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YU8HGKFVgDu5PmPmQa9rQm9q2w67RmlvbR2fV4Fj4C8=;
        b=EGIFg4c5N26fOhESuplhAtqNPahD/0pwRniiZwIx+0YS82YXbPbwhSUnCMDQf09o+s
         mImhNF4cbG0p5Xc756HedHrWokn/as7xpL3ikayzFa1ZTm1Hc/I3sNr8DATmrLyFEjMD
         Umw8AnMFjKAy6tSvYOfbypa8m5+jN0nnj+XKjCCAi3f7JNEfXw42GX+0cdx6Z+l3Vwa9
         98NC4AIxuWUhPFgmcmyMTQRj3a4cAG7UhLKxdvDdfhfUQGDb7h48biQh1RsdhJBnZFer
         F6IGBVnEmGloAWi/TpKhSFDVME/M4OXNPp8X6bjeFBNCTofB2tSPREexLyBfCbOu100u
         9jwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713322538; x=1713927338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YU8HGKFVgDu5PmPmQa9rQm9q2w67RmlvbR2fV4Fj4C8=;
        b=d2jHND11EqcFnOTlAPCRN0OfKbHpaPCUUAskf3z0tWSKNOz4W2cleUXvV9vOQ53/cm
         nicqvznntsMjbWBjZTz29VgnI/rnaTjZX+dnZryc7qgnQtw8oSTaqscz1ED0Ogh7ehHU
         A62yWMbndqOLm+iLbtK7ZFgSa/GJvcuD0O1V9RUeyB1Kq0V8UxGPkqJCdd9jTHxtPwys
         NQIBwoj86+nz6lSJW0iDi36l37S02cWQH+Gue3GubqXtb5prM1oh/mgPLToRZyeo8Pyo
         goHUmi2bryaUiLrUS8h0mkqNDiAxF11sQPuATlIyw4kcYDs3JIethWNxVlYtONhg9A3l
         Y8ig==
X-Forwarded-Encrypted: i=1; AJvYcCXjW9sLvsIkPSgiJ8b7NVWouKvLYvg40lt2HRWj39/Xv8jgb5YjVqCJSXWaPTyyuuW805iNIQJGECZ9l1Xj22I1jYvSHxrpx3IC3T7x76LhVh0o66FCIMF2zIGLQGkDukoMzazN90FWRw/7jtQnq8oI/sRcVTXkguiY
X-Gm-Message-State: AOJu0YzXz+ay30TLCjW5owv2ZNIhOs3xdIQpbv8/Ly6mFai1+NvEG5Pi
	d/yA4CZ1TQ6/kRGcBFPd7vwb9rf9flAtVJqqqe2+v4ZId4ef81fcBdm2c64DJSs6R/mvDNITnX4
	aVMBrGlsN0UlvtUF8Im/HxHilJ8o=
X-Google-Smtp-Source: AGHT+IHnLcuxtZ/uwP32Uiu9SghWa6lLAfLw4GcSxchoRgTp88uEW8gkPF8hzIXEyKeaaD+Mj9NOczupbaoeOSmiIDI=
X-Received: by 2002:a50:c313:0:b0:568:c6a2:f427 with SMTP id
 a19-20020a50c313000000b00568c6a2f427mr9999014edb.27.1713322537712; Tue, 16
 Apr 2024 19:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416061943.407082-1-liangchen.linux@gmail.com> <CACGkMEuJBdsePgszsM51DZc1GvF0naorHDsMR+SGZ1SiA6jrZQ@mail.gmail.com>
In-Reply-To: <CACGkMEuJBdsePgszsM51DZc1GvF0naorHDsMR+SGZ1SiA6jrZQ@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 17 Apr 2024 10:55:19 +0800
Message-ID: <CAKhg4tLsjeJASbdvDumBrbhkddGs4xAV0y5QPv=nhrHcZdSM0g@mail.gmail.com>
Subject: Re: [PATCH net-next v8] virtio_net: Support RX hash XDP hint
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 3:20=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Apr 16, 2024 at 2:20=E2=80=AFPM Liang Chen <liangchen.linux@gmail=
.com> wrote:
> >
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
> >   Changes from v7:
> > - use table lookup for rss hash type
> >   Changes from v6:
> > - fix a coding style issue
> >   Changes from v5:
> > - Preservation of the hash value has been dropped, following the conclu=
sion
> >   from discussions in V3 reviews. The virtio_net driver doesn't
> >   accessing/using the virtio_net_hdr after the XDP program execution, s=
o
> >   nothing tragic should happen. As to the xdp program, if it smashes th=
e
> >   entry in virtio header, it is likely buggy anyways. Additionally, loo=
king
> >   up the Intel IGC driver,  it also does not bother with this particula=
r
> >   aspect.
> > ---
> >  drivers/net/virtio_net.c        | 42 +++++++++++++++++++++++++++++++++
> >  include/uapi/linux/virtio_net.h |  1 +
> >  2 files changed, 43 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c22d1118a133..1d750009f615 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4621,6 +4621,47 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >         }
> >  }
> >
> > +static enum xdp_rss_hash_type
> > +virtnet_xdp_rss_type[VIRTIO_NET_HASH_REPORT_MAX_TABLE] =3D {
> > +       [VIRTIO_NET_HASH_REPORT_NONE] =3D XDP_RSS_TYPE_NONE,
> > +       [VIRTIO_NET_HASH_REPORT_IPv4] =3D XDP_RSS_TYPE_L3_IPV4,
> > +       [VIRTIO_NET_HASH_REPORT_TCPv4] =3D XDP_RSS_TYPE_L4_IPV4_TCP,
> > +       [VIRTIO_NET_HASH_REPORT_UDPv4] =3D XDP_RSS_TYPE_L4_IPV4_UDP,
> > +       [VIRTIO_NET_HASH_REPORT_IPv6] =3D XDP_RSS_TYPE_L3_IPV6,
> > +       [VIRTIO_NET_HASH_REPORT_TCPv6] =3D XDP_RSS_TYPE_L4_IPV6_TCP,
> > +       [VIRTIO_NET_HASH_REPORT_UDPv6] =3D XDP_RSS_TYPE_L4_IPV6_UDP,
> > +       [VIRTIO_NET_HASH_REPORT_IPv6_EX] =3D XDP_RSS_TYPE_L3_IPV6_EX,
> > +       [VIRTIO_NET_HASH_REPORT_TCPv6_EX] =3D XDP_RSS_TYPE_L4_IPV6_TCP_=
EX,
> > +       [VIRTIO_NET_HASH_REPORT_UDPv6_EX] =3D XDP_RSS_TYPE_L4_IPV6_UDP_=
EX
> > +};
> > +
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                              enum xdp_rss_hash_type *rss_type)
> > +{
> > +       const struct xdp_buff *xdp =3D (void *)_ctx;
> > +       struct virtio_net_hdr_v1_hash *hdr_hash;
> > +       struct virtnet_info *vi;
> > +       u16 hash_report;
> > +
> > +       if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> > +               return -ENODATA;
> > +
> > +       vi =3D netdev_priv(xdp->rxq->dev);
> > +       hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->=
hdr_len);
> > +       hash_report =3D __le16_to_cpu(hdr_hash->hash_report);
> > +
> > +       if (hash_report >=3D VIRTIO_NET_HASH_REPORT_MAX_TABLE)
> > +               hash_report =3D VIRTIO_NET_HASH_REPORT_NONE;
> > +
> > +       *rss_type =3D virtnet_xdp_rss_type[hash_report];
> > +       *hash =3D __le32_to_cpu(hdr_hash->hash_value);
> > +       return 0;
> > +}
> > +
> > +static const struct xdp_metadata_ops virtnet_xdp_metadata_ops =3D {
> > +       .xmo_rx_hash                    =3D virtnet_xdp_rx_hash,
> > +};
> > +
> >  static int virtnet_probe(struct virtio_device *vdev)
> >  {
> >         int i, err =3D -ENOMEM;
> > @@ -4747,6 +4788,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >                                   VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> >
> >                 dev->hw_features |=3D NETIF_F_RXHASH;
> > +               dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> >         }
> >
> >         if (vi->has_rss_hash_report)
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virti=
o_net.h
> > index cc65ef0f3c3e..3ee695450096 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -176,6 +176,7 @@ struct virtio_net_hdr_v1_hash {
> >  #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> >  #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> >  #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> > +#define VIRTIO_NET_HASH_REPORT_MAX_TABLE      10
>
> This should not be part of uAPI. It may confuse the userspace.
>

Sure. I will just move it to virtio_net.c right above the table
definition. Thanks!

> Others look good.
>
> Thanks
>
> >         __le16 hash_report;
> >         __le16 padding;
> >  };
> > --
> > 2.40.1
> >
>

