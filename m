Return-Path: <bpf+bounces-26406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD10C89F033
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 12:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D382830FB
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0971E159574;
	Wed, 10 Apr 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YKr6Awsv"
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2735D47A5C;
	Wed, 10 Apr 2024 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746556; cv=none; b=MLMD66b1TzmDqicGKq+OF6YuFv0Bd4SsHYyQi9ojlTu2WRoCUuhMd43NAJtcKPxjeLuUx+OQgk3Cqz2pxSeGu6OkIEaeCJAWAWR4w5QRou/FN1J5gh+o18jKs+0Qhsd2eRWFG6Un6jXqPHw1bOelysov+7mBsZtv4y61ogc/B7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746556; c=relaxed/simple;
	bh=H3SpMIfJiykodJWLcTJ5FkJTvnVXpklX4+4q0mBeyNM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=ANtiiPdZUmlc5UlBNsINx9mSJT4zK1SMCnJPSL+J9ki4qhlYVriV+DVmpNbEnfliajjSNe5KIBldNhV1TtjikJYget5rDDY6qUkwzfj1iFGVjGwXU9UcjSkvzgxE4oiPsJI1Eiacr1W1veNdD4iyZjGzCLO6InRPp1FX0dBxR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YKr6Awsv; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712746544; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=U4FtLtIN78kKTAtNEu91Pdgz7j3jUyLl6udaozHNmQE=;
	b=YKr6AwsvGDB6ptpNmnknrfPk6ZPN1w0Jb5/Tvfe2uaRCteZrdRgkKtfpb8OVLTF89JAyNNMd5vLZrpCKKTO3bQ9MnohATZy7pnDVCIucXc3R/to6+5rD/g/Fb0iB/GsZtkOuIyNMuZTgg0U7RO8YztMm+pSMbDCrq1KXOgfrKoQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W4HdIyh_1712746543;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4HdIyh_1712746543)
          by smtp.aliyun-inc.com;
          Wed, 10 Apr 2024 18:55:44 +0800
Message-ID: <1712746366.8053942-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 4/9] virtio_net: support device stats
Date: Wed, 10 Apr 2024 18:52:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Amritha Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <20240318110602.37166-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEujuYh+Ups9jx5jEwe7bydtgCyurG5bPLe3X8jpSJhqvA@mail.gmail.com>
In-Reply-To: <CACGkMEujuYh+Ups9jx5jEwe7bydtgCyurG5bPLe3X8jpSJhqvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 10 Apr 2024 14:09:23 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f38998982=
3039724f95bbbd243291ab0064f82
> >
> > make virtio-net support getting the stats from the device by ethtool -S
> > <eth0>.
> >
> > Due to the numerous descriptors stats, an organization method is
> > required. For this purpose, I have introduced the "virtnet_stats_map".
> > Utilizing this array simplifies coding tasks such as generating field
> > names, calculating buffer sizes for requests and responses, and parsing
> > replies from the device. By iterating over the "virtnet_stats_map,"
> > these operations become more streamlined and efficient.
> >
> > NIC statistics:
> >      rx0_packets: 582951
> >      rx0_bytes: 155307077
> >      rx0_drops: 0
> >      rx0_xdp_packets: 0
> >      rx0_xdp_tx: 0
> >      rx0_xdp_redirects: 0
> >      rx0_xdp_drops: 0
> >      rx0_kicks: 17007
> >      rx0_hw_packets: 2179409
> >      rx0_hw_bytes: 510015040
> >      rx0_hw_notifications: 0
> >      rx0_hw_interrupts: 0
> >      rx0_hw_drops: 12964
> >      rx0_hw_drop_overruns: 0
> >      rx0_hw_csum_valid: 2179409
> >      rx0_hw_csum_none: 0
> >      rx0_hw_csum_bad: 0
> >      rx0_hw_needs_csum: 2179409
> >      rx0_hw_ratelimit_packets: 0
> >      rx0_hw_ratelimit_bytes: 0
> >      tx0_packets: 15361
> >      tx0_bytes: 1918970
> >      tx0_xdp_tx: 0
> >      tx0_xdp_tx_drops: 0
> >      tx0_kicks: 15361
> >      tx0_timeouts: 0
> >      tx0_hw_packets: 32272
> >      tx0_hw_bytes: 4311698
> >      tx0_hw_notifications: 0
> >      tx0_hw_interrupts: 0
> >      tx0_hw_drops: 0
> >      tx0_hw_drop_malformed: 0
> >      tx0_hw_csum_none: 0
> >      tx0_hw_needs_csum: 32272
> >      tx0_hw_ratelimit_packets: 0
> >      tx0_hw_ratelimit_bytes: 0
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 401 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 397 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 8cb5bdd7ad91..70c1d4e850e0 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -128,6 +128,129 @@ static const struct virtnet_stat_desc virtnet_rq_=
stats_desc[] =3D {
> >  #define VIRTNET_SQ_STATS_LEN   ARRAY_SIZE(virtnet_sq_stats_desc)
> >  #define VIRTNET_RQ_STATS_LEN   ARRAY_SIZE(virtnet_rq_stats_desc)
> >
> > +#define VIRTNET_STATS_DESC_CQ(name) \
> > +       {#name, offsetof(struct virtio_net_stats_cvq, name)}
> > +
> > +#define VIRTNET_STATS_DESC_RX(class, name) \
> > +       {#name, offsetof(struct virtio_net_stats_rx_ ## class, rx_ ## n=
ame)}
> > +
> > +#define VIRTNET_STATS_DESC_TX(class, name) \
> > +       {#name, offsetof(struct virtio_net_stats_tx_ ## class, tx_ ## n=
ame)}
> > +
> > +static const struct virtnet_stat_desc virtnet_stats_cvq_desc[] =3D {
> > +       VIRTNET_STATS_DESC_CQ(command_num),
> > +       VIRTNET_STATS_DESC_CQ(ok_num),
> > +};
> > +
> > +static const struct virtnet_stat_desc virtnet_stats_rx_basic_desc[] =
=3D {
> > +       VIRTNET_STATS_DESC_RX(basic, packets),
> > +       VIRTNET_STATS_DESC_RX(basic, bytes),
> > +
> > +       VIRTNET_STATS_DESC_RX(basic, notifications),
> > +       VIRTNET_STATS_DESC_RX(basic, interrupts),
> > +
> > +       VIRTNET_STATS_DESC_RX(basic, drops),
> > +       VIRTNET_STATS_DESC_RX(basic, drop_overruns),
> > +};
> > +
> > +static const struct virtnet_stat_desc virtnet_stats_tx_basic_desc[] =
=3D {
> > +       VIRTNET_STATS_DESC_TX(basic, packets),
> > +       VIRTNET_STATS_DESC_TX(basic, bytes),
> > +
> > +       VIRTNET_STATS_DESC_TX(basic, notifications),
> > +       VIRTNET_STATS_DESC_TX(basic, interrupts),
> > +
> > +       VIRTNET_STATS_DESC_TX(basic, drops),
> > +       VIRTNET_STATS_DESC_TX(basic, drop_malformed),
> > +};
> > +
> > +static const struct virtnet_stat_desc virtnet_stats_rx_csum_desc[] =3D=
 {
> > +       VIRTNET_STATS_DESC_RX(csum, csum_valid),
> > +       VIRTNET_STATS_DESC_RX(csum, needs_csum),
> > +
> > +       VIRTNET_STATS_DESC_RX(csum, csum_none),
> > +       VIRTNET_STATS_DESC_RX(csum, csum_bad),
> > +};
> > +
> > +static const struct virtnet_stat_desc virtnet_stats_tx_csum_desc[] =3D=
 {
> > +       VIRTNET_STATS_DESC_TX(csum, needs_csum),
> > +       VIRTNET_STATS_DESC_TX(csum, csum_none),
> > +};
> > +
> > +static const struct virtnet_stat_desc virtnet_stats_rx_gso_desc[] =3D {
> > +       VIRTNET_STATS_DESC_RX(gso, gso_packets),
> > +       VIRTNET_STATS_DESC_RX(gso, gso_bytes),
> > +       VIRTNET_STATS_DESC_RX(gso, gso_packets_coalesced),
> > +       VIRTNET_STATS_DESC_RX(gso, gso_bytes_coalesced),
> > +};
> > +
> > +static const struct virtnet_stat_desc virtnet_stats_tx_gso_desc[] =3D {
> > +       VIRTNET_STATS_DESC_TX(gso, gso_packets),
> > +       VIRTNET_STATS_DESC_TX(gso, gso_bytes),
> > +       VIRTNET_STATS_DESC_TX(gso, gso_segments),
> > +       VIRTNET_STATS_DESC_TX(gso, gso_segments_bytes),
> > +       VIRTNET_STATS_DESC_TX(gso, gso_packets_noseg),
> > +       VIRTNET_STATS_DESC_TX(gso, gso_bytes_noseg),
> > +};
> > +
> > +static const struct virtnet_stat_desc virtnet_stats_rx_speed_desc[] =
=3D {
> > +       VIRTNET_STATS_DESC_RX(speed, ratelimit_packets),
> > +       VIRTNET_STATS_DESC_RX(speed, ratelimit_bytes),
> > +};
> > +
> > +static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] =
=3D {
> > +       VIRTNET_STATS_DESC_TX(speed, ratelimit_packets),
> > +       VIRTNET_STATS_DESC_TX(speed, ratelimit_bytes),
> > +};
> > +
> > +#define VIRTNET_Q_TYPE_RX 0
> > +#define VIRTNET_Q_TYPE_TX 1
> > +#define VIRTNET_Q_TYPE_CQ 2
> > +
> > +struct virtnet_stats_map {
> > +       /* The stat type in bitmap. */
> > +       u64 stat_type;
> > +
> > +       /* The bytes of the response for the stat. */
> > +       u32 len;
> > +
> > +       /* The num of the response fields for the stat. */
> > +       u32 num;
> > +
> > +       /* The type of queue corresponding to the statistics. (cq, rq, =
sq) */
> > +       u32 queue_type;
> > +
> > +       /* The reply type of the stat. */
> > +       u8 reply_type;
> > +
> > +       /* Describe the name and the offset in the response. */
> > +       const struct virtnet_stat_desc *desc;
> > +};
> > +
> > +#define VIRTNET_DEVICE_STATS_MAP_ITEM(TYPE, type, queue_type)  \
> > +       {                                                       \
> > +               VIRTIO_NET_STATS_TYPE_##TYPE,                   \
> > +               sizeof(struct virtio_net_stats_ ## type),       \
> > +               ARRAY_SIZE(virtnet_stats_ ## type ##_desc),     \
> > +               VIRTNET_Q_TYPE_##queue_type,                    \
> > +               VIRTIO_NET_STATS_TYPE_REPLY_##TYPE,             \
> > +               &virtnet_stats_##type##_desc[0]                 \
> > +       }
> > +
> > +static struct virtnet_stats_map virtio_net_stats_map[] =3D {
> > +       VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
> > +
> > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_BASIC, rx_basic, RX),
> > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_CSUM,  rx_csum,  RX),
> > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_GSO,   rx_gso,   RX),
> > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_SPEED, rx_speed, RX),
> > +
> > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_BASIC, tx_basic, TX),
> > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_CSUM,  tx_csum,  TX),
> > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_GSO,   tx_gso,   TX),
> > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_SPEED, tx_speed, TX),
> > +};
>
> I think the reason you did this is to ease the future extensions but
> multiple levels of nested macros makes the code hard to review. Any
> way to eliminate this?


NOT only for the future extensions.

When we parse the reply from the device, we need to check the reply stats
one by one, we need the stats info to help parse the stats.

	static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
	                              struct virtnet_stats_ctx *ctx,
	                              const u8 *base, u8 type)
	{
	       u32 queue_type, num_rx, num_tx, num_cq;
	       struct virtnet_stats_map *m;
	       u64 offset, bitmap;
	       const __le64 *v;
	       int i, j;

	       num_rx =3D VIRTNET_RQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_TYPE_RX];
	       num_tx =3D VIRTNET_SQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_TYPE_TX];
	       num_cq =3D ctx->desc_num[VIRTNET_Q_TYPE_CQ];

	       queue_type =3D vq_type(vi, qid);
	       bitmap =3D ctx->bitmap[queue_type];
	       offset =3D 0;

	       if (queue_type =3D=3D VIRTNET_Q_TYPE_TX) {
	               offset =3D num_cq + num_rx * vi->curr_queue_pairs + num_tx =
* (qid / 2);
	               offset +=3D VIRTNET_SQ_STATS_LEN;
	       } else if (queue_type =3D=3D VIRTNET_Q_TYPE_RX) {
	               offset =3D num_cq + num_rx * (qid / 2) + VIRTNET_RQ_STATS_L=
EN;
	       }

	       for (i =3D 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
	               m =3D &virtio_net_stats_map[i];

->	               if (m->stat_type & bitmap)
	                       offset +=3D m->num;

->	               if (type !=3D m->reply_type)
	                       continue;

	               for (j =3D 0; j < m->num; ++j) {
	                       v =3D (const __le64 *)(base + m->desc[j].offset);
	                       ctx->data[offset + j] =3D le64_to_cpu(*v);
	               }

	               break;
	       }
	}

Thanks.


>
> > +
> >  struct virtnet_interrupt_coalesce {
> >         u32 max_packets;
> >         u32 max_usecs;
> > @@ -244,6 +367,7 @@ struct control_buf {
> >         struct virtio_net_ctrl_coal_tx coal_tx;
> >         struct virtio_net_ctrl_coal_rx coal_rx;
> >         struct virtio_net_ctrl_coal_vq coal_vq;
> > +       struct virtio_net_stats_capabilities stats_cap;
> >  };
> >
> >  struct virtnet_info {
> > @@ -329,6 +453,8 @@ struct virtnet_info {
> >
> >         /* failover when STANDBY feature enabled */
> >         struct failover *failover;
> > +
> > +       u64 device_stats_cap;
> >  };
> >
> >  struct padded_vnet_hdr {
> > @@ -389,6 +515,17 @@ static int rxq2vq(int rxq)
> >         return rxq * 2;
> >  }
> >
> > +static int vq_type(struct virtnet_info *vi, int qid)
> > +{
> > +       if (qid =3D=3D vi->max_queue_pairs * 2)
> > +               return VIRTNET_Q_TYPE_CQ;
> > +
> > +       if (qid % 2)
> > +               return VIRTNET_Q_TYPE_TX;
> > +
> > +       return VIRTNET_Q_TYPE_RX;
> > +}
> > +
> >  static inline struct virtio_net_common_hdr *
> >  skb_vnet_common_hdr(struct sk_buff *skb)
> >  {
> > @@ -3263,6 +3400,223 @@ static int virtnet_set_channels(struct net_devi=
ce *dev,
> >         return err;
> >  }
> >
> > +static void virtnet_get_hw_stats_string(struct virtnet_info *vi, int t=
ype, int qid, u8 **data)
> > +{
> > +       struct virtnet_stats_map *m;
> > +       int i, j;
> > +       u8 *p =3D *data;
> > +
> > +       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
> > +               return;
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
> > +               m =3D &virtio_net_stats_map[i];
> > +
> > +               if (m->queue_type !=3D type)
> > +                       continue;
> > +
> > +               if (!(vi->device_stats_cap & m->stat_type))
> > +                       continue;
> > +
> > +               for (j =3D 0; j < m->num; ++j) {
> > +                       switch (type) {
> > +                       case VIRTNET_Q_TYPE_RX:
> > +                               ethtool_sprintf(&p, "rx_queue_hw_%u_%s"=
, qid, m->desc[j].desc);
> > +                               break;
> > +
> > +                       case VIRTNET_Q_TYPE_TX:
> > +                               ethtool_sprintf(&p, "tx_queue_hw_%u_%s"=
, qid, m->desc[j].desc);
> > +                               break;
> > +
> > +                       case VIRTNET_Q_TYPE_CQ:
> > +                               ethtool_sprintf(&p, "cq_hw_%s", m->desc=
[j].desc);
> > +                               break;
> > +                       }
> > +               }
> > +       }
> > +
> > +       *data =3D p;
> > +}
> > +
> > +struct virtnet_stats_ctx {
> > +       u32 desc_num[3];
> > +
> > +       u32 bitmap[3];
> > +
> > +       u32 size[3];
> > +
> > +       u64 *data;
> > +};
>
> Let's explain the meaning of each field here.
>
> > +
> > +static void virtnet_stats_ctx_init(struct virtnet_info *vi,
> > +                                  struct virtnet_stats_ctx *ctx,
> > +                                  u64 *data)
> > +{
> > +       struct virtnet_stats_map *m;
> > +       int i;
> > +
> > +       ctx->data =3D data;
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
> > +               m =3D &virtio_net_stats_map[i];
> > +
> > +               if (!(vi->device_stats_cap & m->stat_type))
> > +                       continue;
> > +
> > +               ctx->bitmap[m->queue_type]   |=3D m->stat_type;
> > +               ctx->desc_num[m->queue_type] +=3D m->num;
> > +               ctx->size[m->queue_type]     +=3D m->len;
> > +       }
> > +}
> > +
> > +/* virtnet_fill_stats - copy the stats to ethtool -S
> > + * The stats source is the device.
> > + *
> > + * @vi: virtio net info
> > + * @qid: the vq id
> > + * @ctx: stats ctx (initiated by virtnet_stats_ctx_init())
> > + * @base: pointer to the device reply.
> > + * @type: the type of the device reply
> > + */
> > +static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
> > +                              struct virtnet_stats_ctx *ctx,
> > +                              const u8 *base, u8 type)
> > +{
> > +       u32 queue_type, num_rx, num_tx, num_cq;
> > +       struct virtnet_stats_map *m;
> > +       u64 offset, bitmap;
> > +       const __le64 *v;
> > +       int i, j;
> > +
> > +       num_rx =3D VIRTNET_RQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_TYPE_=
RX];
> > +       num_tx =3D VIRTNET_SQ_STATS_LEN + ctx->desc_num[VIRTNET_Q_TYPE_=
TX];
> > +       num_cq =3D ctx->desc_num[VIRTNET_Q_TYPE_CQ];
> > +
> > +       queue_type =3D vq_type(vi, qid);
> > +       bitmap =3D ctx->bitmap[queue_type];
> > +       offset =3D 0;
> > +
> > +       if (queue_type =3D=3D VIRTNET_Q_TYPE_TX) {
> > +               offset =3D num_cq + num_rx * vi->curr_queue_pairs + num=
_tx * (qid / 2);
> > +               offset +=3D VIRTNET_SQ_STATS_LEN;
> > +       } else if (queue_type =3D=3D VIRTNET_Q_TYPE_RX) {
> > +               offset =3D num_cq + num_rx * (qid / 2) + VIRTNET_RQ_STA=
TS_LEN;
> > +       }
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
> > +               m =3D &virtio_net_stats_map[i];
> > +
> > +               if (m->stat_type & bitmap)
> > +                       offset +=3D m->num;
> > +
> > +               if (type !=3D m->reply_type)
> > +                       continue;
> > +
> > +               for (j =3D 0; j < m->num; ++j) {
> > +                       v =3D (const __le64 *)(base + m->desc[j].offset=
);
> > +                       ctx->data[offset + j] =3D le64_to_cpu(*v);
> > +               }
> > +
> > +               break;
> > +       }
> > +}
> > +
> > +static int __virtnet_get_hw_stats(struct virtnet_info *vi,
> > +                                 struct virtnet_stats_ctx *ctx,
> > +                                 struct virtio_net_ctrl_queue_stats *r=
eq,
> > +                                 int req_size, void *reply, int res_si=
ze)
> > +{
> > +       struct virtio_net_stats_reply_hdr *hdr;
> > +       struct scatterlist sgs_in, sgs_out;
> > +       void *p;
> > +       u32 qid;
> > +       int ok;
> > +
> > +       sg_init_one(&sgs_out, req, req_size);
> > +       sg_init_one(&sgs_in, reply, res_size);
> > +
> > +       ok =3D virtnet_send_command(vi, VIRTIO_NET_CTRL_STATS,
> > +                                 VIRTIO_NET_CTRL_STATS_GET,
> > +                                 &sgs_out, &sgs_in);
> > +       kfree(req);
>
> I'd suggest letting the caller free this for simplicity.
>
> > +
> > +       if (!ok) {
> > +               kfree(reply);
> > +               return ok;
> > +       }
> > +
> > +       for (p =3D reply; p - reply < res_size; p +=3D le16_to_cpu(hdr-=
>size)) {
>
> hdr->size is under the control of a device which might be malicious?
>
> Btw, I'd expect that type implies size but looks not, any reason for that?
>
> > +               hdr =3D p;
> > +               qid =3D le16_to_cpu(hdr->vq_index);
> > +               virtnet_fill_stats(vi, qid, ctx, p, hdr->type);
> > +       }
> > +
> > +       kfree(reply);
>
> As caller has the logic for err handling like:
>
>         reply =3D kmalloc(res_size, GFP_KERNEL);
>         if (!reply) {
>                 kfree(req);
>                 return -ENOMEM;
>         }
>
> So let's free it from the caller.
>
> > +       return 0;
> > +}
> > +
> > +static void virtnet_make_stat_req(struct virtnet_info *vi,
> > +                                 struct virtnet_stats_ctx *ctx,
> > +                                 struct virtio_net_ctrl_queue_stats *r=
eq,
> > +                                 int qid, int *idx)
> > +{
> > +       int qtype =3D vq_type(vi, qid);
> > +       u64 bitmap =3D ctx->bitmap[qtype];
> > +
> > +       if (!bitmap)
> > +               return;
> > +
> > +       req->stats[*idx].vq_index =3D cpu_to_le16(qid);
> > +       req->stats[*idx].types_bitmap[0] =3D cpu_to_le64(bitmap);
> > +       *idx +=3D 1;
> > +}
> > +
> > +static int virtnet_get_hw_stats(struct virtnet_info *vi,
> > +                               struct virtnet_stats_ctx *ctx)
> > +{
> > +       struct virtio_net_ctrl_queue_stats *req;
> > +       int qnum, i, j, res_size, qtype, last_vq;
> > +       void *reply;
> > +
> > +       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
> > +               return 0;
> > +
> > +       last_vq =3D vi->curr_queue_pairs * 2 - 1;
> > +
> > +       qnum =3D 0;
> > +       res_size =3D 0;
> > +       for (i =3D 0; i <=3D last_vq ; ++i) {
> > +               qtype =3D vq_type(vi, i);
> > +               if (ctx->bitmap[qtype]) {
> > +                       ++qnum;
> > +                       res_size +=3D ctx->size[qtype];
> > +               }
> > +       }
> > +
> > +       if (ctx->bitmap[VIRTNET_Q_TYPE_CQ]) {
> > +               res_size +=3D ctx->size[VIRTNET_Q_TYPE_CQ];
> > +               qnum +=3D 1;
> > +       }
> > +
> > +       req =3D kcalloc(qnum, sizeof(*req), GFP_KERNEL);
> > +       if (!req)
> > +               return -ENOMEM;
> > +
> > +       reply =3D kmalloc(res_size, GFP_KERNEL);
> > +       if (!reply) {
> > +               kfree(req);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       j =3D 0;
> > +       for (i =3D 0; i <=3D last_vq ; ++i)
> > +               virtnet_make_stat_req(vi, ctx, req, i, &j);
> > +
> > +       virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j=
);
>
> Instead of preparing those on the fly, could we prepare the request
> during the probe instead of here? As most of the field (except the
> data) won't be changed.
>
> > +
> > +       return __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, r=
eply, res_size);
> > +}
> > +
> >  static void virtnet_get_strings(struct net_device *dev, u32 stringset,=
 u8 *data)
> >  {
> >         struct virtnet_info *vi =3D netdev_priv(dev);
> > @@ -3271,16 +3625,22 @@ static void virtnet_get_strings(struct net_devi=
ce *dev, u32 stringset, u8 *data)
> >
> >         switch (stringset) {
> >         case ETH_SS_STATS:
> > +               virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_CQ, 0, &=
p);
> > +
> >                 for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> >                         for (j =3D 0; j < VIRTNET_RQ_STATS_LEN; j++)
> >                                 ethtool_sprintf(&p, "rx%u_%s", i,
> >                                                 virtnet_rq_stats_desc[j=
].desc);
> > +
> > +                       virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_=
RX, i, &p);
> >                 }
> >
> >                 for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> >                         for (j =3D 0; j < VIRTNET_SQ_STATS_LEN; j++)
> >                                 ethtool_sprintf(&p, "tx%u_%s", i,
> >                                                 virtnet_sq_stats_desc[j=
].desc);
> > +
> > +                       virtnet_get_hw_stats_string(vi, VIRTNET_Q_TYPE_=
TX, i, &p);
> >                 }
> >                 break;
> >         }
> > @@ -3289,11 +3649,35 @@ static void virtnet_get_strings(struct net_devi=
ce *dev, u32 stringset, u8 *data)
> >  static int virtnet_get_sset_count(struct net_device *dev, int sset)
> >  {
> >         struct virtnet_info *vi =3D netdev_priv(dev);
> > +       struct virtnet_stats_ctx ctx =3D {0};
> > +       u32 pair_count;
> >
> >         switch (sset) {
> >         case ETH_SS_STATS:
> > -               return vi->curr_queue_pairs * (VIRTNET_RQ_STATS_LEN +
> > -                                              VIRTNET_SQ_STATS_LEN);
> > +               if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_ST=
ATS) &&
> > +                   !vi->device_stats_cap) {
> > +                       struct scatterlist sg;
> > +
> > +                       sg_init_one(&sg, &vi->ctrl->stats_cap, sizeof(v=
i->ctrl->stats_cap));
> > +
> > +                       if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_S=
TATS,
> > +                                                 VIRTIO_NET_CTRL_STATS=
_QUERY,
> > +                                                 NULL, &sg)) {
> > +                               dev_warn(&dev->dev, "Fail to get stats =
capability\n");
>
> Should we fail here?
>
> > +                       } else {
> > +                               __le64 v;
> > +
> > +                               v =3D vi->ctrl->stats_cap.supported_sta=
ts_types[0];
> > +                               vi->device_stats_cap =3D le64_to_cpu(v);
> > +                       }
> > +               }
> > +
> > +               virtnet_stats_ctx_init(vi, &ctx, NULL);
> > +
> > +               pair_count =3D VIRTNET_RQ_STATS_LEN + VIRTNET_SQ_STATS_=
LEN;
> > +               pair_count +=3D ctx.desc_num[VIRTNET_Q_TYPE_RX] + ctx.d=
esc_num[VIRTNET_Q_TYPE_TX];
> > +
> > +               return ctx.desc_num[VIRTNET_Q_TYPE_CQ] + vi->curr_queue=
_pairs * pair_count;
>
> I wonder why we don't do this during the probe?
>
> >         default:
> >                 return -EOPNOTSUPP;
> >         }
> > @@ -3303,11 +3687,18 @@ static void virtnet_get_ethtool_stats(struct ne=
t_device *dev,
> >                                       struct ethtool_stats *stats, u64 =
*data)
> >  {
> >         struct virtnet_info *vi =3D netdev_priv(dev);
> > -       unsigned int idx =3D 0, start, i, j;
> > +       struct virtnet_stats_ctx ctx =3D {0};
> > +       unsigned int idx, start, i, j;
> >         const u8 *stats_base;
> >         const u64_stats_t *p;
> >         size_t offset;
> >
> > +       virtnet_stats_ctx_init(vi, &ctx, data);
> > +       if (virtnet_get_hw_stats(vi, &ctx))
> > +               dev_warn(&vi->dev->dev, "Failed to get hw stats.\n");
> > +
> > +       idx =3D ctx.desc_num[VIRTNET_Q_TYPE_CQ];
> > +
> >         for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> >                 struct receive_queue *rq =3D &vi->rq[i];
> >
> > @@ -3321,6 +3712,7 @@ static void virtnet_get_ethtool_stats(struct net_=
device *dev,
> >                         }
> >                 } while (u64_stats_fetch_retry(&rq->stats.syncp, start)=
);
> >                 idx +=3D VIRTNET_RQ_STATS_LEN;
> > +               idx +=3D ctx.desc_num[VIRTNET_Q_TYPE_RX];
> >         }
> >
> >         for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> > @@ -3336,6 +3728,7 @@ static void virtnet_get_ethtool_stats(struct net_=
device *dev,
> >                         }
> >                 } while (u64_stats_fetch_retry(&sq->stats.syncp, start)=
);
> >                 idx +=3D VIRTNET_SQ_STATS_LEN;
> > +               idx +=3D ctx.desc_num[VIRTNET_Q_TYPE_TX];
> >         }
> >  }
> >
> > @@ -4963,7 +5356,7 @@ static struct virtio_device_id id_table[] =3D {
> >         VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
> >         VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_C=
OAL, \
> >         VIRTIO_NET_F_VQ_NOTF_COAL, \
> > -       VIRTIO_NET_F_GUEST_HDRLEN
> > +       VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS
> >
> >  static unsigned int features[] =3D {
> >         VIRTNET_FEATURES,
> > --
> > 2.32.0.3.g01195cf9f
> >
>
> Thanks
>

