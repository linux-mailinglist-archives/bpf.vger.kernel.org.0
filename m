Return-Path: <bpf+bounces-27019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC748A7AFB
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 05:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721E028515E
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 03:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50918BFA;
	Wed, 17 Apr 2024 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4SdF73c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE60EACD;
	Wed, 17 Apr 2024 03:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323889; cv=none; b=a/gp7YEprrQxta0ub79IW6dmcoFCALeakd6TY7qqrigMB7BGAYZw+CHRzZSXC8oOoXqaMrCsiP82gFY1Pq6bHFgJM75oZqmmztHPxAxITFgHqPQVQKsvUM55+SXZ0pyTiCrnwfCoEPGZhZ3lPiTql5MLJ2I83UJELVP9tKaWEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323889; c=relaxed/simple;
	bh=DYdbJMQPWHNdCa/t4xKHn7Ep23nVCFUDURsn3OIzBkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNv/JUFFveNyUVsERuolwRwvNzzW5C3bev+IXYiImQtGhjBZr+LoBkPpqqZfV15h6djUuYb2rgdSRoee/8BtU+/1wfOrALpI6BMBNSehxJNuqLSakVYVLGLWWu3wlWgnBOJgH0HruhhZg6NPKDzYXIn6m7GMDjrdH5oc9KmGBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4SdF73c; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso6157853a12.3;
        Tue, 16 Apr 2024 20:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713323885; x=1713928685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVriCNTb+EDSZWCxPrVyKNj5dSkX49V39Dhl38sLFSg=;
        b=D4SdF73cmE8LRaVmkKPReuB0dUiVYSlE1TVH7OTq/EoakPhoAoXcakolP4YPtuzhUU
         QofgJrsxRKuHIwK0xDeU14Ld/tGOqc754z6HE9W1ipQv1DlWJUQeI646AV04Hp7lip7a
         ogdN8kiTqgjnqy0Soavv6gxQGjCqcSiZ7HBut7RVvg7+DfLrXdbQU7JArrJbon0ZBHFU
         BsK0/W/nLr2J0up82x1k9wSE86bzxGQ309+TQJNjm6WPgZNqNhd+Eu/t6NMGaV/ojbsd
         oyaMGStH7N0ffKCOmIQL6eHDYSJaYr+nIslkI3JING3examCjDLMl245lCmrLIanL4Fm
         wE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713323885; x=1713928685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVriCNTb+EDSZWCxPrVyKNj5dSkX49V39Dhl38sLFSg=;
        b=BqrMN/2CI6g4um/jb81UnMWB5nZR5HsDI6F8j2COCEa9cYDLw0JvmU6vg2DUZrRkQ0
         /MqaKHh3vh4xcingUsUW8rmu+m/P4Hel41oHsJlsYPcy1Fs2e8/CJ6Xs+LTW/6m4RH90
         aSQKmKIsZG/DrHL7xfEZ/qXX+jQ7CE4prfIe/ZsP24UUJj6s7Q71DShe2DiY72rSRNX/
         nqsZzvCI1lW7sAOwn5WlbN9FRS4/8OnEgO5wB+qlu48nmi3rwSF/oWnz/0351TePAteU
         NpFCEkYnUQQ+9/PtRpO7+NaXJVZEIcmWKi22cZpOo8VV6qb5A5eFnpLzAycR5l6frwnw
         8qxw==
X-Forwarded-Encrypted: i=1; AJvYcCXSU4DEJ+6oU0dmngo7Cc/QGM8y9UPQ3Eo90PMB+IAnYb+SyPc0dlRMaoXd00WNBV2foVFVLaeM18jT9gLAoX0Jnu9gbSie1HXv3egAS3QdRK4DiWkh99IfisSMxZbk2j8O
X-Gm-Message-State: AOJu0YzvcGegya8sFCjrHJXVGtiJ6DaiiSe/KnX+oklmzf1nXv8tx/Nv
	HgfdcY2ujQIGzJwodalJBNNvcH4wrqcY6ggJ/o7d31aQaOZXUms1KOaxSJzYNdzoCTaisjKRZwg
	W7mUS5iu5bqHZhBFobK2JrzKdVl0=
X-Google-Smtp-Source: AGHT+IHG+tfTL+nJaNRUJwWP+LAGchmm89LD6lkmQtWHddA8bSL6nbjLM+KQAVWxzh0DA73fYqGhDXzbvvTHz6c6F6k=
X-Received: by 2002:a50:d642:0:b0:56d:fdb3:bcc5 with SMTP id
 c2-20020a50d642000000b0056dfdb3bcc5mr9491339edj.12.1713323884627; Tue, 16 Apr
 2024 20:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416061943.407082-1-liangchen.linux@gmail.com> <04dcbbcd-7079-42d4-b77c-3bbf55cfc823@linux.alibaba.com>
In-Reply-To: <04dcbbcd-7079-42d4-b77c-3bbf55cfc823@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed, 17 Apr 2024 11:17:51 +0800
Message-ID: <CAKhg4tJwB+xQ3H7YZGF0VRR6cMdQMz3g_3kf5uqkT=j0uR8dnw@mail.gmail.com>
Subject: Re: [PATCH net-next v8] virtio_net: Support RX hash XDP hint
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	ast@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 3:35=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/4/16 =E4=B8=8B=E5=8D=882:19, Liang Chen =E5=86=99=E9=81=93=
:
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
> >    Changes from v7:
> > - use table lookup for rss hash type
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
> >   drivers/net/virtio_net.c        | 42 ++++++++++++++++++++++++++++++++=
+
> >   include/uapi/linux/virtio_net.h |  1 +
> >   2 files changed, 43 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c22d1118a133..1d750009f615 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -4621,6 +4621,47 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >       }
> >   }
> >
> > +static enum xdp_rss_hash_type
> > +virtnet_xdp_rss_type[VIRTIO_NET_HASH_REPORT_MAX_TABLE] =3D {
> > +     [VIRTIO_NET_HASH_REPORT_NONE] =3D XDP_RSS_TYPE_NONE,
> > +     [VIRTIO_NET_HASH_REPORT_IPv4] =3D XDP_RSS_TYPE_L3_IPV4,
> > +     [VIRTIO_NET_HASH_REPORT_TCPv4] =3D XDP_RSS_TYPE_L4_IPV4_TCP,
> > +     [VIRTIO_NET_HASH_REPORT_UDPv4] =3D XDP_RSS_TYPE_L4_IPV4_UDP,
> > +     [VIRTIO_NET_HASH_REPORT_IPv6] =3D XDP_RSS_TYPE_L3_IPV6,
> > +     [VIRTIO_NET_HASH_REPORT_TCPv6] =3D XDP_RSS_TYPE_L4_IPV6_TCP,
> > +     [VIRTIO_NET_HASH_REPORT_UDPv6] =3D XDP_RSS_TYPE_L4_IPV6_UDP,
> > +     [VIRTIO_NET_HASH_REPORT_IPv6_EX] =3D XDP_RSS_TYPE_L3_IPV6_EX,
> > +     [VIRTIO_NET_HASH_REPORT_TCPv6_EX] =3D XDP_RSS_TYPE_L4_IPV6_TCP_EX=
,
> > +     [VIRTIO_NET_HASH_REPORT_UDPv6_EX] =3D XDP_RSS_TYPE_L4_IPV6_UDP_EX
> > +};
> > +
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                            enum xdp_rss_hash_type *rss_type)
> > +{
> > +     const struct xdp_buff *xdp =3D (void *)_ctx;
> > +     struct virtio_net_hdr_v1_hash *hdr_hash;
> > +     struct virtnet_info *vi;
> > +     u16 hash_report;
> > +
> > +     if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> > +             return -ENODATA;
> > +
> > +     vi =3D netdev_priv(xdp->rxq->dev);
> > +     hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hd=
r_len);
> > +     hash_report =3D __le16_to_cpu(hdr_hash->hash_report);
> > +
> > +     if (hash_report >=3D VIRTIO_NET_HASH_REPORT_MAX_TABLE)
> > +             hash_report =3D VIRTIO_NET_HASH_REPORT_NONE;
>
> When this happens, it may mean an error or user modification of the
> header occurred.
> Should the following *hash* value be cleared to 0?
>

Referring to the igc and mlx5 drivers, the hash value is not cleared
to 0 in such cases either. This is because if the rss type is
XDP_RSS_TYPE_NONE, the hash value is considered to be not relevant.
Thanks!

> Thanks,
> Heng
>
> > +
> > +     *rss_type =3D virtnet_xdp_rss_type[hash_report];
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
> > @@ -4747,6 +4788,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >                                 VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> >
> >               dev->hw_features |=3D NETIF_F_RXHASH;
> > +             dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> >       }
> >
> >       if (vi->has_rss_hash_report)
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virti=
o_net.h
> > index cc65ef0f3c3e..3ee695450096 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -176,6 +176,7 @@ struct virtio_net_hdr_v1_hash {
> >   #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> >   #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> >   #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> > +#define VIRTIO_NET_HASH_REPORT_MAX_TABLE      10
> >       __le16 hash_report;
> >       __le16 padding;
> >   };
>

