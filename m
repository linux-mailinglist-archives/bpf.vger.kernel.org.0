Return-Path: <bpf+bounces-26759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C968A4A2A
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 10:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2DD284F38
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 08:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EBF376E5;
	Mon, 15 Apr 2024 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fqfiDL8H"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18005374C4;
	Mon, 15 Apr 2024 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168940; cv=none; b=c5NsQbjNcQdXKlypBtXSesjrfxLXSqKQbVpQfGL5a/tz8vS+E1TX8ADVhibK9BwK/UPqgoPTLJrCIfgl6VidWleDZhCSZz5l7vUA+hlg+j7wnshuOKRleLuozSp/ZSUqYwqacPflh7ZltVjb5Uy0hKmY7UygyeUgieikUswsJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168940; c=relaxed/simple;
	bh=U+N2A4fckifPuPMSuSPmX2UR+SvjTKUjxxethsXrXys=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=VdeQWyIwfiI5TgYhEqg0OnAFZNGWR5hI1BIuz6JEfCIoEZVXPu5ZYiTVjPgGYx+ewABsMWsU42wggBrjwuNBl7qexpx8gUyCQZxrf09UilzFlSopEcFI8pAyHadGSrDmlMxv1xd/nhWNO7EeBPV/cyVhU8YpffshZNWXHMt9DcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fqfiDL8H; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713168927; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=hRLr3M5wy1svG4vz4SFZ95X211Kr/428p7t6wCSr6vU=;
	b=fqfiDL8HdruLrjV1amJrM1oHzmxyhn2/cBX+l7bEY50e4QWRy1K8bGvjaxPDs7Oo/wbx6h3EKRRvIjXZU9J10LopI1/WeQd41L2fsyvnOKl+RmMtZuzgZTU265jYI/tb4kfPM3C0+j0gw6d8+I2n2GjsbOaBaYWnHr4IKFh0r+s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W4YQHTt_1713168925;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4YQHTt_1713168925)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 16:15:26 +0800
Message-ID: <1713168679.2714498-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 4/9] virtio_net: support device stats
Date: Mon, 15 Apr 2024 16:11:19 +0800
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
 <1712746366.8053942-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsvAUyk+h3e5SO5T4L8HuSGcViKj2WM2J33JOb7KTKjUw@mail.gmail.com>
 <1713148927.6675713-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvbLvQUppO6nnp0DCxACco7S=2QLgge4ZhARo9Ov_fJKQ@mail.gmail.com>
In-Reply-To: <CACGkMEvbLvQUppO6nnp0DCxACco7S=2QLgge4ZhARo9Ov_fJKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 15 Apr 2024 14:45:36 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Apr 15, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > On Thu, 11 Apr 2024 14:09:24 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Wed, Apr 10, 2024 at 6:55=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Wed, 10 Apr 2024 14:09:23 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f=
389989823039724f95bbbd243291ab0064f82
> > > > > >
> > > > > > make virtio-net support getting the stats from the device by et=
htool -S
> > > > > > <eth0>.
> > > > > >
> > > > > > Due to the numerous descriptors stats, an organization method is
> > > > > > required. For this purpose, I have introduced the "virtnet_stat=
s_map".
> > > > > > Utilizing this array simplifies coding tasks such as generating=
 field
> > > > > > names, calculating buffer sizes for requests and responses, and=
 parsing
> > > > > > replies from the device. By iterating over the "virtnet_stats_m=
ap,"
> > > > > > these operations become more streamlined and efficient.
> > > > > >
> > > > > > NIC statistics:
> > > > > >      rx0_packets: 582951
> > > > > >      rx0_bytes: 155307077
> > > > > >      rx0_drops: 0
> > > > > >      rx0_xdp_packets: 0
> > > > > >      rx0_xdp_tx: 0
> > > > > >      rx0_xdp_redirects: 0
> > > > > >      rx0_xdp_drops: 0
> > > > > >      rx0_kicks: 17007
> > > > > >      rx0_hw_packets: 2179409
> > > > > >      rx0_hw_bytes: 510015040
> > > > > >      rx0_hw_notifications: 0
> > > > > >      rx0_hw_interrupts: 0
> > > > > >      rx0_hw_drops: 12964
> > > > > >      rx0_hw_drop_overruns: 0
> > > > > >      rx0_hw_csum_valid: 2179409
> > > > > >      rx0_hw_csum_none: 0
> > > > > >      rx0_hw_csum_bad: 0
> > > > > >      rx0_hw_needs_csum: 2179409
> > > > > >      rx0_hw_ratelimit_packets: 0
> > > > > >      rx0_hw_ratelimit_bytes: 0
> > > > > >      tx0_packets: 15361
> > > > > >      tx0_bytes: 1918970
> > > > > >      tx0_xdp_tx: 0
> > > > > >      tx0_xdp_tx_drops: 0
> > > > > >      tx0_kicks: 15361
> > > > > >      tx0_timeouts: 0
> > > > > >      tx0_hw_packets: 32272
> > > > > >      tx0_hw_bytes: 4311698
> > > > > >      tx0_hw_notifications: 0
> > > > > >      tx0_hw_interrupts: 0
> > > > > >      tx0_hw_drops: 0
> > > > > >      tx0_hw_drop_malformed: 0
> > > > > >      tx0_hw_csum_none: 0
> > > > > >      tx0_hw_needs_csum: 32272
> > > > > >      tx0_hw_ratelimit_packets: 0
> > > > > >      tx0_hw_ratelimit_bytes: 0
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 401 +++++++++++++++++++++++++++++++=
+++++++-
> > > > > >  1 file changed, 397 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 8cb5bdd7ad91..70c1d4e850e0 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -128,6 +128,129 @@ static const struct virtnet_stat_desc vir=
tnet_rq_stats_desc[] =3D {
> > > > > >  #define VIRTNET_SQ_STATS_LEN   ARRAY_SIZE(virtnet_sq_stats_des=
c)
> > > > > >  #define VIRTNET_RQ_STATS_LEN   ARRAY_SIZE(virtnet_rq_stats_des=
c)
> > > > > >
> > > > > > +#define VIRTNET_STATS_DESC_CQ(name) \
> > > > > > +       {#name, offsetof(struct virtio_net_stats_cvq, name)}
> > > > > > +
> > > > > > +#define VIRTNET_STATS_DESC_RX(class, name) \
> > > > > > +       {#name, offsetof(struct virtio_net_stats_rx_ ## class, =
rx_ ## name)}
> > > > > > +
> > > > > > +#define VIRTNET_STATS_DESC_TX(class, name) \
> > > > > > +       {#name, offsetof(struct virtio_net_stats_tx_ ## class, =
tx_ ## name)}
> > > > > > +
> > > > > > +static const struct virtnet_stat_desc virtnet_stats_cvq_desc[]=
 =3D {
> > > > > > +       VIRTNET_STATS_DESC_CQ(command_num),
> > > > > > +       VIRTNET_STATS_DESC_CQ(ok_num),
> > > > > > +};
> > > > > > +
> > > > > > +static const struct virtnet_stat_desc virtnet_stats_rx_basic_d=
esc[] =3D {
> > > > > > +       VIRTNET_STATS_DESC_RX(basic, packets),
> > > > > > +       VIRTNET_STATS_DESC_RX(basic, bytes),
> > > > > > +
> > > > > > +       VIRTNET_STATS_DESC_RX(basic, notifications),
> > > > > > +       VIRTNET_STATS_DESC_RX(basic, interrupts),
> > > > > > +
> > > > > > +       VIRTNET_STATS_DESC_RX(basic, drops),
> > > > > > +       VIRTNET_STATS_DESC_RX(basic, drop_overruns),
> > > > > > +};
> > > > > > +
> > > > > > +static const struct virtnet_stat_desc virtnet_stats_tx_basic_d=
esc[] =3D {
> > > > > > +       VIRTNET_STATS_DESC_TX(basic, packets),
> > > > > > +       VIRTNET_STATS_DESC_TX(basic, bytes),
> > > > > > +
> > > > > > +       VIRTNET_STATS_DESC_TX(basic, notifications),
> > > > > > +       VIRTNET_STATS_DESC_TX(basic, interrupts),
> > > > > > +
> > > > > > +       VIRTNET_STATS_DESC_TX(basic, drops),
> > > > > > +       VIRTNET_STATS_DESC_TX(basic, drop_malformed),
> > > > > > +};
> > > > > > +
> > > > > > +static const struct virtnet_stat_desc virtnet_stats_rx_csum_de=
sc[] =3D {
> > > > > > +       VIRTNET_STATS_DESC_RX(csum, csum_valid),
> > > > > > +       VIRTNET_STATS_DESC_RX(csum, needs_csum),
> > > > > > +
> > > > > > +       VIRTNET_STATS_DESC_RX(csum, csum_none),
> > > > > > +       VIRTNET_STATS_DESC_RX(csum, csum_bad),
> > > > > > +};
> > > > > > +
> > > > > > +static const struct virtnet_stat_desc virtnet_stats_tx_csum_de=
sc[] =3D {
> > > > > > +       VIRTNET_STATS_DESC_TX(csum, needs_csum),
> > > > > > +       VIRTNET_STATS_DESC_TX(csum, csum_none),
> > > > > > +};
> > > > > > +
> > > > > > +static const struct virtnet_stat_desc virtnet_stats_rx_gso_des=
c[] =3D {
> > > > > > +       VIRTNET_STATS_DESC_RX(gso, gso_packets),
> > > > > > +       VIRTNET_STATS_DESC_RX(gso, gso_bytes),
> > > > > > +       VIRTNET_STATS_DESC_RX(gso, gso_packets_coalesced),
> > > > > > +       VIRTNET_STATS_DESC_RX(gso, gso_bytes_coalesced),
> > > > > > +};
> > > > > > +
> > > > > > +static const struct virtnet_stat_desc virtnet_stats_tx_gso_des=
c[] =3D {
> > > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_packets),
> > > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_bytes),
> > > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_segments),
> > > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_segments_bytes),
> > > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_packets_noseg),
> > > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_bytes_noseg),
> > > > > > +};
> > > > > > +
> > > > > > +static const struct virtnet_stat_desc virtnet_stats_rx_speed_d=
esc[] =3D {
> > > > > > +       VIRTNET_STATS_DESC_RX(speed, ratelimit_packets),
> > > > > > +       VIRTNET_STATS_DESC_RX(speed, ratelimit_bytes),
> > > > > > +};
> > > > > > +
> > > > > > +static const struct virtnet_stat_desc virtnet_stats_tx_speed_d=
esc[] =3D {
> > > > > > +       VIRTNET_STATS_DESC_TX(speed, ratelimit_packets),
> > > > > > +       VIRTNET_STATS_DESC_TX(speed, ratelimit_bytes),
> > > > > > +};
> > > > > > +
> > > > > > +#define VIRTNET_Q_TYPE_RX 0
> > > > > > +#define VIRTNET_Q_TYPE_TX 1
> > > > > > +#define VIRTNET_Q_TYPE_CQ 2
> > > > > > +
> > > > > > +struct virtnet_stats_map {
> > > > > > +       /* The stat type in bitmap. */
> > > > > > +       u64 stat_type;
> > > > > > +
> > > > > > +       /* The bytes of the response for the stat. */
> > > > > > +       u32 len;
> > > > > > +
> > > > > > +       /* The num of the response fields for the stat. */
> > > > > > +       u32 num;
> > > > > > +
> > > > > > +       /* The type of queue corresponding to the statistics. (=
cq, rq, sq) */
> > > > > > +       u32 queue_type;
> > > > > > +
> > > > > > +       /* The reply type of the stat. */
> > > > > > +       u8 reply_type;
> > > > > > +
> > > > > > +       /* Describe the name and the offset in the response. */
> > > > > > +       const struct virtnet_stat_desc *desc;
> > > > > > +};
> > > > > > +
> > > > > > +#define VIRTNET_DEVICE_STATS_MAP_ITEM(TYPE, type, queue_type) =
 \
> > > > > > +       {                                                      =
 \
> > > > > > +               VIRTIO_NET_STATS_TYPE_##TYPE,                  =
 \
> > > > > > +               sizeof(struct virtio_net_stats_ ## type),      =
 \
> > > > > > +               ARRAY_SIZE(virtnet_stats_ ## type ##_desc),    =
 \
> > > > > > +               VIRTNET_Q_TYPE_##queue_type,                   =
 \
> > > > > > +               VIRTIO_NET_STATS_TYPE_REPLY_##TYPE,            =
 \
> > > > > > +               &virtnet_stats_##type##_desc[0]                =
 \
> > > > > > +       }
> > > > > > +
> > > > > > +static struct virtnet_stats_map virtio_net_stats_map[] =3D {
> > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
> > > > > > +
> > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_BASIC, rx_basic, RX),
> > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_CSUM,  rx_csum,  RX),
> > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_GSO,   rx_gso,   RX),
> > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_SPEED, rx_speed, RX),
> > > > > > +
> > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_BASIC, tx_basic, TX),
> > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_CSUM,  tx_csum,  TX),
> > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_GSO,   tx_gso,   TX),
> > > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_SPEED, tx_speed, TX),
> > > > > > +};
> > > > >
> > > > > I think the reason you did this is to ease the future extensions =
but
> > > > > multiple levels of nested macros makes the code hard to review. A=
ny
> > > > > way to eliminate this?
> > > >
> > > >
> > > > NOT only for the future extensions.
> > > >
> > > > When we parse the reply from the device, we need to check the reply=
 stats
> > > > one by one, we need the stats info to help parse the stats.
> > >
> > > Yes, but I meant for example any reason why it can't be done by
> > > extending virtnet_stat_desc ?
> >
> >
> >
> > You know, virtio_net_stats_map is way to organize the descs.
> >
> > This is used to avoid the big if-else when parsing the replys from the =
device.
> >
> > If no this map, we will have a big if-else like:
> >
> >  if (reply.type =3D=3D rx_basic) {
> >          /* do the same something */
> >  }
> >  if (reply.type =3D=3D tx_basic) {
> >          /* do the same something */
> >  }
> >  if (reply.type =3D=3D rx_csum) {
> >          /* do the same something */
> >  }
> >  if (reply.type =3D=3D tx_csum) {
> >          /* do the same something */
> >  }
> >  if (reply.type =3D=3D rx_gso) {
> >          /* do the same something */
> >  }
> >  if (reply.type =3D=3D tx_gso) {
> >          /* do the same something */
> >  }
> >  if (reply.type =3D=3D rx_speed) {
> >          /* do the same something */
> >  }
> >  if (reply.type =3D=3D tx_speed) {
> >          /* do the same something */
> >  }
> >
> > I want to avoid this, so introducing this map.
>
> Could we have a function pointers array indexed by the type?

Then these functions will be similar and mass.

Maybe we can start with the if-else or the function.
That will be easy to review. We can optimize on that.

Thanks.



>
> Thanks
>
> >
> > YES. I noticed other comments, but I think we should
> > fix this problem firstly.
> >
> > Thanks.
> >
> >
> > >
> > > >
> > > >         static void virtnet_fill_stats(struct virtnet_info *vi, u32=
 qid,
> > > >                                       struct virtnet_stats_ctx *ctx,
> > > >                                       const u8 *base, u8 type)
> > > >         {
> > > >                u32 queue_type, num_rx, num_tx, num_cq;
> > > >                struct virtnet_stats_map *m;
> > > >                u64 offset, bitmap;
> > > >                const __le64 *v;
> > > >                int i, j;
> > > >
> > > >                num_rx =3D VIRTNET_RQ_STATS_LEN + ctx->desc_num[VIRT=
NET_Q_TYPE_RX];
> > > >                num_tx =3D VIRTNET_SQ_STATS_LEN + ctx->desc_num[VIRT=
NET_Q_TYPE_TX];
> > > >                num_cq =3D ctx->desc_num[VIRTNET_Q_TYPE_CQ];
> > > >
> > > >                queue_type =3D vq_type(vi, qid);
> > > >                bitmap =3D ctx->bitmap[queue_type];
> > > >                offset =3D 0;
> > > >
> > > >                if (queue_type =3D=3D VIRTNET_Q_TYPE_TX) {
> > > >                        offset =3D num_cq + num_rx * vi->curr_queue_=
pairs + num_tx * (qid / 2);
> > > >                        offset +=3D VIRTNET_SQ_STATS_LEN;
> > > >                } else if (queue_type =3D=3D VIRTNET_Q_TYPE_RX) {
> > > >                        offset =3D num_cq + num_rx * (qid / 2) + VIR=
TNET_RQ_STATS_LEN;
> > > >                }
> > > >
> > > >                for (i =3D 0; i < ARRAY_SIZE(virtio_net_stats_map); =
++i) {
> > > >                        m =3D &virtio_net_stats_map[i];
> > > >
> > > > ->                     if (m->stat_type & bitmap)
> > > >                                offset +=3D m->num;
> > > >
> > > > ->                     if (type !=3D m->reply_type)
> > > >                                continue;
> > > >
> > > >                        for (j =3D 0; j < m->num; ++j) {
> > > >                                v =3D (const __le64 *)(base + m->des=
c[j].offset);
> > > >                                ctx->data[offset + j] =3D le64_to_cp=
u(*v);
> > > >                        }
> > > >
> > > >                        break;
> > > >                }
> > > >         }
> > > >
> > > > Thanks.
> > >
> > > Btw, just a reminder, there are other comments for this patch.
> > >
> > > Thanks
> > >
> >
>

