Return-Path: <bpf+bounces-23282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC986FA52
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 07:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970892811BB
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 06:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5980A11CBF;
	Mon,  4 Mar 2024 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/ORWkey"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B380E1173A
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535370; cv=none; b=E12upREIA01dwb2Bu0+kAo4IylT+vBLpuv/pZbN+cJGp27gHk3A3keMtl6NfMdMpoEnb0jeEiD48gWCWNnriYZ/DvZrjGKiit095qXsP/QWCPV4mIgL8VXicvADMVUl7LIZHw1MQItbtrNM0i/e6lVz8blnoGyJyzG0nJmeFlP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535370; c=relaxed/simple;
	bh=ANv7CPYWbCbdTFbaMYIWnQE0qElMaJYeiOgmdNn1AmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k54NGZw0JYq5x/xROX/w698EWEs/sBLSwVdOPP6KgHcPyukX8yKpJv0PK3AAEsQEFuV57/eInz1tKkR9Rgd4QAA6rGbSUq3RH0TxWNZqaA2YWfoRa+SVH4J3j92xPOZuflw2ImTyd9Y3Pc1vwnI1u6dIRsVkz7c/+Jjvq66hoKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/ORWkey; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709535367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnnMKJuI5h57AkdTs6wUac/zEo+KD+16W2yUuRvyBNA=;
	b=H/ORWkeyunEmu0l+KateJcG2a5pOh5ZGKPE5y4ceJUktOEIFJEfF5zIHy7crr5YvKvFJz1
	mBizlZ9ZgJffwdKIFRkp5CHYQwWhqYp/qbpipaDPCzAFe65Pg5WmZVFBl7LDQe0Zv+upHj
	Pvl44SxCzWOVNaxp8v+/Z82x7GS/Qng=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-WMwsHVMjOSygFR2iDnzVTw-1; Mon, 04 Mar 2024 01:56:05 -0500
X-MC-Unique: WMwsHVMjOSygFR2iDnzVTw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5dc992f8c8aso3920992a12.3
        for <bpf@vger.kernel.org>; Sun, 03 Mar 2024 22:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535364; x=1710140164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnnMKJuI5h57AkdTs6wUac/zEo+KD+16W2yUuRvyBNA=;
        b=dKIrUzL5P8KGTOxF5czO7pw+YfY+YcZaqFIM2s0PlH6Oz8RuFNyZMLnWplcMibTFoA
         Esy+I9+aBBJyFAziWZfNySVKx1+Kf7MkqO53qvepHh45lTGrJ65Y/Kh9erAPzYD8Zgdm
         /wQbSpELrJv/TTn0JQmRrTYuuyAvNizaU/GqrZY/y/Gwa1oT+ZSiouSYhj9OiJAA0UmN
         ZxRewvejr9DhMkIrSz2dlMUzAsLNpkX6ZdNXa4fHJpu4gaG6TXGEaKq3nELQbO5Z8i2F
         xOaImFcRsg4yhpoZ782IKOr5yshtpIuJW1y17TwwJIIRfam7Pjstl7vUdvJJkS+owGmD
         a4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQzGBxq+Wi1voLiaJhX02+SddhoEpACStdAgXxdJJFzk5er7axeW41wR0VfSJPCTBFLdqVCnP12XPL2IHEjiMlRBPt
X-Gm-Message-State: AOJu0YygSyZc65GgUwwBNhxOl6KhIXmsreFJE2LOXCBC/1UN3uXceT3M
	7uqJOZPArnC5TrTqaetj2DizJG/PaFNLzeXatJL6jKQsQ6d4klnIuZHlOxdhhTNHovRVGR9o0Bg
	o4pZKCrhyFDdmdSEz7bxUPd7GemO6r8wDWCo33vY/AQ4Cq4eLIVgSa8XFrgnjV5LVLt8re8+fw0
	CgnE0UZsGHqm8J5NiVCvB+4UASPSFq0U0Gi8s=
X-Received: by 2002:a05:6a20:9586:b0:1a1:4ed3:c088 with SMTP id iu6-20020a056a20958600b001a14ed3c088mr1655528pzb.42.1709535364709;
        Sun, 03 Mar 2024 22:56:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG17yX5NcCXqq0LBQnyxMhRX1MIou6zDKDeBeLtv08Lc0fZrfsKtXRWSCIZhWjat1jdDt4spuow+7XOuBi/ai0=
X-Received: by 2002:a05:6a20:9586:b0:1a1:4ed3:c088 with SMTP id
 iu6-20020a056a20958600b001a14ed3c088mr1655512pzb.42.1709535364439; Sun, 03
 Mar 2024 22:56:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709118356-133960-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1709118356-133960-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 4 Mar 2024 14:55:53 +0800
Message-ID: <CACGkMEv+=k+RvbN2kWp85f9NWPYOPQtqkThdjvOrf5mWonBqvw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: mst@redhat.com, willemdebruijn.kernel@gmail.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, xudingke@huawei.com, liwei395@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:06=E2=80=AFPM Yunjian Wang <wangyunjian@huawei.co=
m> wrote:
>
> This patch set allows TUN to support the AF_XDP Tx zero-copy feature,
> which can significantly reduce CPU utilization for XDP programs.
>
> Since commit fc72d1d54dd9 ("tuntap: XDP transmission"), the pointer
> ring has been utilized to queue different types of pointers by encoding
> the type into the lower bits. Therefore, we introduce a new flag,
> TUN_XDP_DESC_FLAG(0x2UL), which allows us to enqueue XDP descriptors
> and differentiate them from XDP buffers and sk_buffs. Additionally, a
> spin lock is added for enabling and disabling operations on the xsk pool.
>
> The performance testing was performed on a Intel E5-2620 2.40GHz machine.
> Traffic were generated/send through TUN(testpmd txonly with AF_XDP)
> to VM (testpmd rxonly in guest).
>
> +------+---------+---------+---------+
> |      |   copy  |zero-copy| speedup |
> +------+---------+---------+---------+
> | UDP  |   Mpps  |   Mpps  |    %    |
> | 64   |   2.5   |   4.0   |   60%   |
> | 512  |   2.1   |   3.6   |   71%   |
> | 1024 |   1.9   |   3.3   |   73%   |
> +------+---------+---------+---------+
>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  drivers/net/tun.c      | 177 +++++++++++++++++++++++++++++++++++++++--
>  drivers/vhost/net.c    |   4 +
>  include/linux/if_tun.h |  32 ++++++++
>  3 files changed, 208 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index bc80fc1d576e..7f4ff50b532c 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -63,6 +63,7 @@
>  #include <net/rtnetlink.h>
>  #include <net/sock.h>
>  #include <net/xdp.h>
> +#include <net/xdp_sock_drv.h>
>  #include <net/ip_tunnels.h>
>  #include <linux/seq_file.h>
>  #include <linux/uio.h>
> @@ -86,6 +87,7 @@ static void tun_default_link_ksettings(struct net_devic=
e *dev,
>                                        struct ethtool_link_ksettings *cmd=
);
>
>  #define TUN_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
> +#define TUN_XDP_BATCH 64
>
>  /* TUN device flags */
>
> @@ -146,6 +148,9 @@ struct tun_file {
>         struct tun_struct *detached;
>         struct ptr_ring tx_ring;
>         struct xdp_rxq_info xdp_rxq;
> +       struct xsk_buff_pool *xsk_pool;
> +       spinlock_t pool_lock;   /* Protects xsk pool enable/disable */
> +       u32 nb_descs;
>  };
>
>  struct tun_page {
> @@ -614,6 +619,8 @@ void tun_ptr_free(void *ptr)
>                 struct xdp_frame *xdpf =3D tun_ptr_to_xdp(ptr);
>
>                 xdp_return_frame(xdpf);
> +       } else if (tun_is_xdp_desc_frame(ptr)) {
> +               return;
>         } else {
>                 __skb_array_destroy_skb(ptr);
>         }
> @@ -631,6 +638,37 @@ static void tun_queue_purge(struct tun_file *tfile)
>         skb_queue_purge(&tfile->sk.sk_error_queue);
>  }
>
> +static void tun_set_xsk_pool(struct tun_file *tfile, struct xsk_buff_poo=
l *pool)
> +{
> +       if (!pool)
> +               return;
> +
> +       spin_lock(&tfile->pool_lock);
> +       xsk_pool_set_rxq_info(pool, &tfile->xdp_rxq);
> +       tfile->xsk_pool =3D pool;
> +       spin_unlock(&tfile->pool_lock);
> +}
> +
> +static void tun_clean_xsk_pool(struct tun_file *tfile)
> +{
> +       spin_lock(&tfile->pool_lock);
> +       if (tfile->xsk_pool) {
> +               void *ptr;
> +
> +               while ((ptr =3D ptr_ring_consume(&tfile->tx_ring)) !=3D N=
ULL)
> +                       tun_ptr_free(ptr);
> +
> +               if (tfile->nb_descs) {
> +                       xsk_tx_completed(tfile->xsk_pool, tfile->nb_descs=
);
> +                       if (xsk_uses_need_wakeup(tfile->xsk_pool))
> +                               xsk_set_tx_need_wakeup(tfile->xsk_pool);
> +                       tfile->nb_descs =3D 0;
> +               }
> +               tfile->xsk_pool =3D NULL;
> +       }
> +       spin_unlock(&tfile->pool_lock);
> +}
> +
>  static void __tun_detach(struct tun_file *tfile, bool clean)
>  {
>         struct tun_file *ntfile;
> @@ -648,6 +686,11 @@ static void __tun_detach(struct tun_file *tfile, boo=
l clean)
>                 u16 index =3D tfile->queue_index;
>                 BUG_ON(index >=3D tun->numqueues);
>
> +               ntfile =3D rtnl_dereference(tun->tfiles[tun->numqueues - =
1]);
> +               /* Stop xsk zc xmit */
> +               tun_clean_xsk_pool(tfile);
> +               tun_clean_xsk_pool(ntfile);
> +
>                 rcu_assign_pointer(tun->tfiles[index],
>                                    tun->tfiles[tun->numqueues - 1]);
>                 ntfile =3D rtnl_dereference(tun->tfiles[index]);
> @@ -668,6 +711,7 @@ static void __tun_detach(struct tun_file *tfile, bool=
 clean)
>                 tun_flow_delete_by_queue(tun, tun->numqueues + 1);
>                 /* Drop read queue */
>                 tun_queue_purge(tfile);
> +               tun_set_xsk_pool(ntfile, xsk_get_pool_from_qid(tun->dev, =
index));
>                 tun_set_real_num_queues(tun);
>         } else if (tfile->detached && clean) {
>                 tun =3D tun_enable_queue(tfile);
> @@ -801,6 +845,7 @@ static int tun_attach(struct tun_struct *tun, struct =
file *file,
>
>                 if (tfile->xdp_rxq.queue_index    !=3D tfile->queue_index=
)
>                         tfile->xdp_rxq.queue_index =3D tfile->queue_index=
;
> +               tun_set_xsk_pool(tfile, xsk_get_pool_from_qid(dev, tfile-=
>queue_index));
>         } else {
>                 /* Setup XDP RX-queue info, for new tfile getting attache=
d */
>                 err =3D xdp_rxq_info_reg(&tfile->xdp_rxq,
> @@ -1221,11 +1266,50 @@ static int tun_xdp_set(struct net_device *dev, st=
ruct bpf_prog *prog,
>         return 0;
>  }
>
> +static int tun_xsk_pool_enable(struct net_device *netdev,
> +                              struct xsk_buff_pool *pool,
> +                              u16 qid)
> +{
> +       struct tun_struct *tun =3D netdev_priv(netdev);
> +       struct tun_file *tfile;
> +
> +       if (qid >=3D tun->numqueues)
> +               return -EINVAL;
> +
> +       tfile =3D rtnl_dereference(tun->tfiles[qid]);
> +       tun_set_xsk_pool(tfile, pool);
> +
> +       return 0;
> +}
> +
> +static int tun_xsk_pool_disable(struct net_device *netdev, u16 qid)
> +{
> +       struct tun_struct *tun =3D netdev_priv(netdev);
> +       struct tun_file *tfile;
> +
> +       if (qid >=3D MAX_TAP_QUEUES)
> +               return -EINVAL;
> +
> +       tfile =3D rtnl_dereference(tun->tfiles[qid]);
> +       if (tfile)
> +               tun_clean_xsk_pool(tfile);
> +       return 0;
> +}
> +
> +static int tun_xsk_pool_setup(struct net_device *dev, struct xsk_buff_po=
ol *pool,
> +                             u16 qid)
> +{
> +       return pool ? tun_xsk_pool_enable(dev, pool, qid) :
> +               tun_xsk_pool_disable(dev, qid);
> +}
> +
>  static int tun_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  {
>         switch (xdp->command) {
>         case XDP_SETUP_PROG:
>                 return tun_xdp_set(dev, xdp->prog, xdp->extack);
> +       case XDP_SETUP_XSK_POOL:
> +               return tun_xsk_pool_setup(dev, xdp->xsk.pool, xdp->xsk.qu=
eue_id);
>         default:
>                 return -EINVAL;
>         }
> @@ -1330,6 +1414,19 @@ static int tun_xdp_tx(struct net_device *dev, stru=
ct xdp_buff *xdp)
>         return nxmit;
>  }
>
> +static int tun_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
> +{
> +       struct tun_struct *tun =3D netdev_priv(dev);
> +       struct tun_file *tfile;
> +
> +       rcu_read_lock();
> +       tfile =3D rcu_dereference(tun->tfiles[qid]);
> +       if (tfile)
> +               __tun_xdp_flush_tfile(tfile);
> +       rcu_read_unlock();
> +       return 0;
> +}

I may miss something but why not simply queue xdp frames into ptr ring
then we don't need tricks for peek?

Thanks


