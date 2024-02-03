Return-Path: <bpf+bounces-21128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A00847FC2
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 04:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92AF1C20D5D
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 03:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7FA1119C;
	Sat,  3 Feb 2024 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UO3QIx4Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A98210A3E;
	Sat,  3 Feb 2024 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706928982; cv=none; b=Uv8DF8eJNvKix8RsQ0iVfUPputDiIYFgKtdy+Kk2tH3sZvuZYJo+Htv1squKrB1xMpcwaE1uAh1QgsSIJHliurWRvbeeP7VJgXFYw9NUQuMrlTgUXU6pITTKSZB4D3IxZV4yomc93yvce45yAIX8rzfivwBfe1dXT5wvDhm9bwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706928982; c=relaxed/simple;
	bh=55FhAuYF84hqwo4dqVC+1FD4hkba9VH9GTID9XtlrOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptHiO+1m9OmZWxQhdq6opWvtL1ZNLZhGmE8w35637G3z7vqdKbcVPwEqMmWcD/Zx8JZeGYB6POayjtoiIurAVz//0BdwV8wG6oMQjG71X7m7RB7PjHJD/6qxWGwO1o3Yi0wqxX01SYxWSR+FGAdGgNxP818QBaNAosKs11MmDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UO3QIx4Z; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511206d1c89so3795812e87.1;
        Fri, 02 Feb 2024 18:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706928978; x=1707533778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDhbaQT7AbrboBKvQTRQ2eOT05C62jwwQC0Ax9xuqDs=;
        b=UO3QIx4ZCHnQhgNVZdojldRM3T+zCTXTJQnl8IaMwARfby+zPQDMTynvh+jnxsKXPJ
         a7d1VuqN0YoL9t9tAsUq+G8uR0n8UhAlY74DOPxKyj3cyxQhimMIGHzK0iVXKq96Ohjx
         GyW2deGLxjfsT6emePdqYIKgQLL8QqueTqN0y5oVPvBHSsX2QdHRgMPmFNc1I3SBMvkg
         Q5TMtU2mHD3UeziemkIrRWH6cYoPuFCaqTbKguq6xB6p0F8eo8y+YJ34i+F1S3WyK+V9
         RfzO1Mb1ZVOSGG8Jj2Hcb/k+8+fo/KNhStks/UyByHEEUq863e+mc/cLOLRpvD86beoO
         Z5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706928978; x=1707533778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDhbaQT7AbrboBKvQTRQ2eOT05C62jwwQC0Ax9xuqDs=;
        b=uBWrnUAcjTwf3OTPKCShEB7nuoEBNZZzOyZydkLuGLJwQwq2h6t3gjuSubu35kfUmD
         mcOmCcy0CZ/+IdXaFpCUO8tkhkSF0R3wN0J1PFHOhPBlyH+gm7eCtr8TDRpHJoL22+/c
         kPAnTqS9Uxad7wUfZByWsU1RnpMJN76L6LdvH7hlx94ItiY0U20xyXoi3f7c+Fv6Rtd2
         LxHM0/CNJG+RlCJN17o2RbGQenIlk/PnT8zMWVnzgF8uRjLIvAtkGr0IRaH23cSZVUS/
         HS5GKpUxP9QMjh1V+3cnLTAVchxzl4DpT5IH1LLmZ+6N1p7H21ZslXnC7LfTmy/iWHfp
         TOfw==
X-Gm-Message-State: AOJu0YxVwZ13xeQXVyw+8g2e+C9JEJTZACh0bTtv0TOXhpV7XwI649DP
	oUNID8S9gIIU0HJb9Ry8tR/g3AUcoWTB+xKhqToiq28lG5cPSGHhK654ER0ryHTneR2Owx+dAf8
	JSXOnYkuXRg71cqf3nQOyFb2Cbfg=
X-Google-Smtp-Source: AGHT+IFrWRLYY9Z7WHWFkODa0efpGQNXSDEZSIjS6ySlP3tSX1ddctZT3Yy07J2mmWcfCp4I8ZcIcTVzTfGmAatZjYc=
X-Received: by 2002:a05:6512:2828:b0:511:31b4:ac16 with SMTP id
 cf40-20020a056512282800b0051131b4ac16mr2892366lfb.47.1706928977977; Fri, 02
 Feb 2024 18:56:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202121151.65710-1-liangchen.linux@gmail.com> <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org>
In-Reply-To: <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Sat, 3 Feb 2024 10:56:05 +0800
Message-ID: <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, john.fastabend@gmail.com, daniel@iogearbox.net, 
	ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 02/02/2024 13.11, Liang Chen wrote:
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
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> >    Changes from v4:
> > - cc complete list of maintainers
> > ---
> >   drivers/net/virtio_net.c | 98 +++++++++++++++++++++++++++++++++++----=
-
> >   1 file changed, 86 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index d7ce4a1011ea..7ce666c86ee0 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -349,6 +349,12 @@ struct virtio_net_common_hdr {
> >       };
> >   };
> >
> > +struct virtnet_xdp_buff {
> > +     struct xdp_buff xdp;
> > +     __le32 hash_value;
> > +     __le16 hash_report;
> > +};
> > +
> >   static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *bu=
f);
> >
> >   static bool is_xdp_frame(void *ptr)
> > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp_buff *xdp)
> >       }
> >   }
> >
> > +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_buff *virtnet_=
xdp,
> > +                                  struct net_device *dev,
> > +                                  struct virtio_net_hdr_v1_hash *hdr_h=
ash)
> > +{
> > +     if (dev->features & NETIF_F_RXHASH) {
> > +             virtnet_xdp->hash_value =3D hdr_hash->hash_value;
> > +             virtnet_xdp->hash_report =3D hdr_hash->hash_report;
> > +     }
> > +}
> > +
>
> Would it be possible to store a pointer to hdr_hash in virtnet_xdp_buff,
> with the purpose of delaying extracting this, until and only if XDP
> bpf_prog calls the kfunc?
>

That seems to be the way v1 works,
https://lore.kernel.org/all/20240122102256.261374-1-liangchen.linux@gmail.c=
om/
. But it was pointed out that the inline header may be overwritten by
the xdp prog, so the hash is copied out to maintain its integrity.


Thanks,
Liang

>
>
> >   static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_=
buff *xdp,
> >                              struct net_device *dev,
> >                              unsigned int *xdp_xmit,
> > @@ -1199,9 +1215,10 @@ static struct sk_buff *receive_small_xdp(struct =
net_device *dev,
> >       unsigned int headroom =3D vi->hdr_len + header_offset;
> >       struct virtio_net_hdr_mrg_rxbuf *hdr =3D buf + header_offset;
> >       struct page *page =3D virt_to_head_page(buf);
> > +     struct virtnet_xdp_buff virtnet_xdp;
> >       struct page *xdp_page;
> > +     struct xdp_buff *xdp;
> >       unsigned int buflen;
> > -     struct xdp_buff xdp;
> >       struct sk_buff *skb;
> >       unsigned int metasize =3D 0;
> >       u32 act;
> > @@ -1233,17 +1250,20 @@ static struct sk_buff *receive_small_xdp(struct=
 net_device *dev,
> >               page =3D xdp_page;
> >       }
> >
> > -     xdp_init_buff(&xdp, buflen, &rq->xdp_rxq);
> > -     xdp_prepare_buff(&xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
> > +     xdp =3D &virtnet_xdp.xdp;
> > +     xdp_init_buff(xdp, buflen, &rq->xdp_rxq);
> > +     xdp_prepare_buff(xdp, buf + VIRTNET_RX_PAD + vi->hdr_len,
> >                        xdp_headroom, len, true);
> >
> > -     act =3D virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats)=
;
> > +     virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
> > +
> > +     act =3D virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
> >
> >       switch (act) {
> >       case XDP_PASS:
> >               /* Recalculate length in case bpf program changed it */
> > -             len =3D xdp.data_end - xdp.data;
> > -             metasize =3D xdp.data - xdp.data_meta;
> > +             len =3D xdp->data_end - xdp->data;
> > +             metasize =3D xdp->data - xdp->data_meta;
> >               break;
> >
> >       case XDP_TX:
> > @@ -1254,7 +1274,7 @@ static struct sk_buff *receive_small_xdp(struct n=
et_device *dev,
> >               goto err_xdp;
> >       }
> >
> > -     skb =3D virtnet_build_skb(buf, buflen, xdp.data - buf, len);
> > +     skb =3D virtnet_build_skb(buf, buflen, xdp->data - buf, len);
> >       if (unlikely(!skb))
> >               goto err;
> >
> > @@ -1591,10 +1611,11 @@ static struct sk_buff *receive_mergeable_xdp(st=
ruct net_device *dev,
> >       int num_buf =3D virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> >       struct page *page =3D virt_to_head_page(buf);
> >       int offset =3D buf - page_address(page);
> > +     struct virtnet_xdp_buff virtnet_xdp;
> >       unsigned int xdp_frags_truesz =3D 0;
> >       struct sk_buff *head_skb;
> >       unsigned int frame_sz;
> > -     struct xdp_buff xdp;
> > +     struct xdp_buff *xdp;
> >       void *data;
> >       u32 act;
> >       int err;
> > @@ -1604,16 +1625,19 @@ static struct sk_buff *receive_mergeable_xdp(st=
ruct net_device *dev,
> >       if (unlikely(!data))
> >               goto err_xdp;
> >
> > -     err =3D virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, data, len, =
frame_sz,
> > +     xdp =3D &virtnet_xdp.xdp;
> > +     err =3D virtnet_build_xdp_buff_mrg(dev, vi, rq, xdp, data, len, f=
rame_sz,
> >                                        &num_buf, &xdp_frags_truesz, sta=
ts);
> >       if (unlikely(err))
> >               goto err_xdp;
> >
> > -     act =3D virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit, stats)=
;
> > +     virtnet_xdp_save_rx_hash(&virtnet_xdp, dev, (void *)hdr);
> > +
> > +     act =3D virtnet_xdp_handler(xdp_prog, xdp, dev, xdp_xmit, stats);
> >
> >       switch (act) {
> >       case XDP_PASS:
> > -             head_skb =3D build_skb_from_xdp_buff(dev, vi, &xdp, xdp_f=
rags_truesz);
> > +             head_skb =3D build_skb_from_xdp_buff(dev, vi, xdp, xdp_fr=
ags_truesz);
> >               if (unlikely(!head_skb))
> >                       break;
> >               return head_skb;
> > @@ -1626,7 +1650,7 @@ static struct sk_buff *receive_mergeable_xdp(stru=
ct net_device *dev,
> >               break;
> >       }
> >
> > -     put_xdp_frags(&xdp);
> > +     put_xdp_frags(xdp);
> >
> >   err_xdp:
> >       put_page(page);
> > @@ -4579,6 +4603,55 @@ static void virtnet_set_big_packets(struct virtn=
et_info *vi, const int mtu)
> >       }
> >   }
> >
> > +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> > +                            enum xdp_rss_hash_type *rss_type)
> > +{
> > +     const struct virtnet_xdp_buff *virtnet_xdp =3D (void *)_ctx;
> > +
> > +     if (!(virtnet_xdp->xdp.rxq->dev->features & NETIF_F_RXHASH))
> > +             return -ENODATA;
> > +
> > +     switch (__le16_to_cpu(virtnet_xdp->hash_report)) {
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
> > +
> > +     *hash =3D __le32_to_cpu(virtnet_xdp->hash_value);
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
> > @@ -4704,6 +4777,7 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >                                 VIRTIO_NET_RSS_HASH_TYPE_UDP_EX);
> >
> >               dev->hw_features |=3D NETIF_F_RXHASH;
> > +             dev->xdp_metadata_ops =3D &virtnet_xdp_metadata_ops;
> >       }
> >
> >       if (vi->has_rss_hash_report)

