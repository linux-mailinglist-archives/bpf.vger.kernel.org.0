Return-Path: <bpf+bounces-27630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2183B8AFEF7
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 04:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0FAB22EFD
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B338384FAA;
	Wed, 24 Apr 2024 02:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TI6rsMDu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF651128368
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927480; cv=none; b=nJjjm5AvUOhqat2yslQbmGs5i99Bb+5abZ1YJBJfrzvpAVN2HHMfnQJrda9bhIb061epNPWcLw9zAqXAxu/rFkCfFXFEWV6+y3Opp1ezmzSP3NxfPIItep7RZfpaVp5OqpyzCt+2kiS3o0HxaXCuXnZCrN32EVWC+g9hvJ+3vWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927480; c=relaxed/simple;
	bh=nG/8XsrbJU5ZrunnyDYLZCtzG0SvqdDEfEQCGaAjevU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEAbHbrfKGhNGIRXHLLjlppfGgbA77eNBkEM30ibCIkWANAJnyfDzWDVvRVPodcbGa0J+pJ1P0020AaTOv/7uHe2NLp3z+CCdICY2A3O0RpJ/BcGvXMP3y2j4QZHzHvS71xrf6DvhbNqcEOJ9ERUW+vXAEm7h++KXNYfniabGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TI6rsMDu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713927477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ToM63U177k5eMsa5vnzH9AFTHjuwEN3IBZBwUNdG2+s=;
	b=TI6rsMDusQ5H+ot+UIuJM4zoosRNf6tSewpPMf+T3T/Z6+YSpSBymV+zrK3UIKUZl0HyzP
	akGFr0a6gNZ5t9PvjKlOfbOzyLyEaay5qrO5L+GJvvynoQZrJ8BHlo03/+t27kZC2UeDxE
	IqjPqypHmLee6rrpW+9KPYHMsi5TIPI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-jzIBxEe4MKuu6lcSOAnEQA-1; Tue, 23 Apr 2024 22:57:56 -0400
X-MC-Unique: jzIBxEe4MKuu6lcSOAnEQA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a5c5e69461so7922250a91.2
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 19:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713927475; x=1714532275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToM63U177k5eMsa5vnzH9AFTHjuwEN3IBZBwUNdG2+s=;
        b=SkqFM6gEO8FR3LyKxddOpcsEhtPjrjgbl9N0InZx3kX3Wmv1exRrnHhQsyS10se7RN
         /QcxFuToRfrgTdB27HXQVcHnYOa3DEbndD69srxUPAvqBKbd5H+LC52oAVWLQMQzyx9W
         guTLeLhVFQiQi960/DBn0cjE7ZFoLl1geG69Tplq02EGxN67zNfTclJdqkq1T7SCNfhX
         3BCrZs8IZx6559ekstQ3WPSvl8DoDzJDhSSWQxAr3iO+RKcvsGcQMQBjVbHLaBLK+qDC
         Xkp4HuTnHQKRZV35v27HSuu0T0O1cVmWgYsLJld/BVr/VPUcqsnWx4zcTpI5XqEMWaNm
         bo4A==
X-Forwarded-Encrypted: i=1; AJvYcCWexMzXsw/805hgaO5HFOpvxpaOjesthP8FOesBDYRM7mRwx/+lQ0vhiFPY0ey3DbDOnSB/9TskLCOVii6aYupfjTyv
X-Gm-Message-State: AOJu0YzXflp36z3LwerLEVuCS/Yy6OTXxrYIBWae8l71gnPt1NY9iyI0
	Das8z7COslG0v+XcD3rykYAsh8PCHZ6n+H7MqnVCtzs4OLJvLvbzRTZFmKWmn7E7fcBVjK+e33x
	xhA59FcK1zi+EvzH7XqyMR4UdfeC+ZREKi4v+36TNYWY0cboHNX1ykjgMSpLttrdk3/cu4RxXRK
	Qyd/Eg12qqlFJTOQyR3VAsN9Q0
X-Received: by 2002:a17:90b:1950:b0:2af:3d5d:80a6 with SMTP id nk16-20020a17090b195000b002af3d5d80a6mr639041pjb.23.1713927475170;
        Tue, 23 Apr 2024 19:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIQ2DbI9GeuEVIENZ3lCcoeWaSDcP+rUSBfudmpZEbbSvDrGJ6IgO8eFkoR0BEsRSEeMdAzbwg5+Qv+Antjqo=
X-Received: by 2002:a17:90b:1950:b0:2af:3d5d:80a6 with SMTP id
 nk16-20020a17090b195000b002af3d5d80a6mr639025pjb.23.1713927474836; Tue, 23
 Apr 2024 19:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com> <20240423113141.1752-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240423113141.1752-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 10:57:43 +0800
Message-ID: <CACGkMEtfKseEH0orxjfgt=nOTm+vbWyCaL_3TAh-ZD9rBEE9XQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/8] virtio_net: support device stats
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 7:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f3899898230=
39724f95bbbd243291ab0064f82
>
> make virtio-net support getting the stats from the device by ethtool -S
> <eth0>.
>
> NIC statistics:
>      rx0_packets: 582951
>      rx0_bytes: 155307077
>      rx0_drops: 0
>      rx0_xdp_packets: 0
>      rx0_xdp_tx: 0
>      rx0_xdp_redirects: 0
>      rx0_xdp_drops: 0
>      rx0_kicks: 17007
>      rx0_hw_packets: 2179409
>      rx0_hw_bytes: 510015040
>      rx0_hw_notifications: 0
>      rx0_hw_interrupts: 0
>      rx0_hw_needs_csum: 2179409
>      rx0_hw_ratelimit_bytes: 0
>      tx0_packets: 15361
>      tx0_bytes: 1918970
>      tx0_xdp_tx: 0
>      tx0_xdp_tx_drops: 0
>      tx0_kicks: 15361
>      tx0_timeouts: 0
>      tx0_hw_packets: 32272
>      tx0_hw_bytes: 4311698
>      tx0_hw_notifications: 0
>      tx0_hw_interrupts: 0
>      tx0_hw_ratelimit_bytes: 0
>
> The follow stats are hidden, there are exported by the queue stat API
> in the subsequent comment.
>
>     VIRTNET_STATS_DESC_RX(basic, drops)
>     VIRTNET_STATS_DESC_RX(basic, drop_overruns),
>     VIRTNET_STATS_DESC_TX(basic, drops),
>     VIRTNET_STATS_DESC_TX(basic, drop_malformed),
>     VIRTNET_STATS_DESC_RX(csum, csum_valid),
>     VIRTNET_STATS_DESC_RX(csum, csum_none),
>     VIRTNET_STATS_DESC_RX(csum, csum_bad),
>     VIRTNET_STATS_DESC_TX(csum, needs_csum),
>     VIRTNET_STATS_DESC_TX(csum, csum_none),
>     VIRTNET_STATS_DESC_RX(gso, gso_packets),
>     VIRTNET_STATS_DESC_RX(gso, gso_bytes),
>     VIRTNET_STATS_DESC_RX(gso, gso_packets_coalesced),
>     VIRTNET_STATS_DESC_RX(gso, gso_bytes_coalesced),
>     VIRTNET_STATS_DESC_TX(gso, gso_packets),
>     VIRTNET_STATS_DESC_TX(gso, gso_bytes),
>     VIRTNET_STATS_DESC_TX(gso, gso_segments),
>     VIRTNET_STATS_DESC_TX(gso, gso_segments_bytes),
>     VIRTNET_STATS_DESC_RX(speed, ratelimit_packets),
>     VIRTNET_STATS_DESC_TX(speed, ratelimit_packets),
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 476 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 472 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index bd90f9d3d9b7..acae0c310688 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -128,6 +128,57 @@ static const struct virtnet_stat_desc virtnet_rq_sta=
ts_desc[] =3D {
>  #define VIRTNET_SQ_STATS_LEN   ARRAY_SIZE(virtnet_sq_stats_desc)
>  #define VIRTNET_RQ_STATS_LEN   ARRAY_SIZE(virtnet_rq_stats_desc)
>
> +#define VIRTNET_STATS_DESC_CQ(name) \
> +       {#name, offsetof(struct virtio_net_stats_cvq, name)}
> +
> +#define VIRTNET_STATS_DESC_RX(class, name) \
> +       {#name, offsetof(struct virtio_net_stats_rx_ ## class, rx_ ## nam=
e)}
> +
> +#define VIRTNET_STATS_DESC_TX(class, name) \
> +       {#name, offsetof(struct virtio_net_stats_tx_ ## class, tx_ ## nam=
e)}
> +
> +static const struct virtnet_stat_desc virtnet_stats_cvq_desc[] =3D {
> +       VIRTNET_STATS_DESC_CQ(command_num),
> +       VIRTNET_STATS_DESC_CQ(ok_num),
> +};
> +
> +static const struct virtnet_stat_desc virtnet_stats_rx_basic_desc[] =3D =
{
> +       VIRTNET_STATS_DESC_RX(basic, packets),
> +       VIRTNET_STATS_DESC_RX(basic, bytes),
> +
> +       VIRTNET_STATS_DESC_RX(basic, notifications),
> +       VIRTNET_STATS_DESC_RX(basic, interrupts),
> +};
> +
> +static const struct virtnet_stat_desc virtnet_stats_tx_basic_desc[] =3D =
{
> +       VIRTNET_STATS_DESC_TX(basic, packets),
> +       VIRTNET_STATS_DESC_TX(basic, bytes),
> +
> +       VIRTNET_STATS_DESC_TX(basic, notifications),
> +       VIRTNET_STATS_DESC_TX(basic, interrupts),
> +};
> +
> +static const struct virtnet_stat_desc virtnet_stats_rx_csum_desc[] =3D {
> +       VIRTNET_STATS_DESC_RX(csum, needs_csum),
> +};
> +
> +static const struct virtnet_stat_desc virtnet_stats_tx_gso_desc[] =3D {
> +       VIRTNET_STATS_DESC_TX(gso, gso_packets_noseg),
> +       VIRTNET_STATS_DESC_TX(gso, gso_bytes_noseg),
> +};
> +
> +static const struct virtnet_stat_desc virtnet_stats_rx_speed_desc[] =3D =
{
> +       VIRTNET_STATS_DESC_RX(speed, ratelimit_bytes),
> +};
> +
> +static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] =3D =
{
> +       VIRTNET_STATS_DESC_TX(speed, ratelimit_bytes),
> +};
> +
> +#define VIRTNET_Q_TYPE_RX 0
> +#define VIRTNET_Q_TYPE_TX 1
> +#define VIRTNET_Q_TYPE_CQ 2
> +
>  struct virtnet_interrupt_coalesce {
>         u32 max_packets;
>         u32 max_usecs;
> @@ -244,6 +295,7 @@ struct control_buf {
>         struct virtio_net_ctrl_coal_tx coal_tx;
>         struct virtio_net_ctrl_coal_rx coal_rx;
>         struct virtio_net_ctrl_coal_vq coal_vq;
> +       struct virtio_net_stats_capabilities stats_cap;
>  };
>
>  struct virtnet_info {
> @@ -329,6 +381,8 @@ struct virtnet_info {
>
>         /* failover when STANDBY feature enabled */
>         struct failover *failover;
> +
> +       u64 device_stats_cap;
>  };
>
>  struct padded_vnet_hdr {
> @@ -389,6 +443,17 @@ static int rxq2vq(int rxq)
>         return rxq * 2;
>  }
>
> +static int vq_type(struct virtnet_info *vi, int qid)
> +{
> +       if (qid =3D=3D vi->max_queue_pairs * 2)
> +               return VIRTNET_Q_TYPE_CQ;
> +
> +       if (qid % 2)
> +               return VIRTNET_Q_TYPE_TX;
> +
> +       return VIRTNET_Q_TYPE_RX;
> +}
> +
>  static inline struct virtio_net_common_hdr *
>  skb_vnet_common_hdr(struct sk_buff *skb)
>  {
> @@ -3268,6 +3333,369 @@ static int virtnet_set_channels(struct net_device=
 *dev,
>         return err;
>  }
>
> +static void virtnet_stats_sprintf(u8 **p, const char *fmt, const char *n=
oq_fmt,
> +                                 int num, int qid, const struct virtnet_=
stat_desc *desc)
> +{
> +       int i;
> +
> +       if (qid < 0) {
> +               for (i =3D 0; i < num; ++i)
> +                       ethtool_sprintf(p, noq_fmt, desc[i].desc);
> +       } else {
> +               for (i =3D 0; i < num; ++i)
> +                       ethtool_sprintf(p, fmt, qid, desc[i].desc);
> +       }
> +}
> +
> +static void virtnet_get_hw_stats_string(struct virtnet_info *vi, int typ=
e, int qid, u8 **data)
> +{
> +       const struct virtnet_stat_desc *desc;
> +       const char *fmt, *noq_fmt;
> +       u8 *p =3D *data;
> +       u32 num =3D 0;
> +
> +       if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
> +               return;
> +
> +       if (type =3D=3D VIRTNET_Q_TYPE_CQ) {
> +               noq_fmt =3D "cq_hw_%s";
> +
> +               if (VIRTIO_NET_STATS_TYPE_CVQ & vi->device_stats_cap) {

Nit: I think we'd better to have a consistent style:

If we do

type =3D=3D VIRTNET_Q_TYPE_CQ

then we'd better use

vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ

Other than this,

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


