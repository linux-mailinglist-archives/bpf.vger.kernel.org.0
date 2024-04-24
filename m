Return-Path: <bpf+bounces-27652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EA48B0438
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 10:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B833D1C222C3
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BB8158A21;
	Wed, 24 Apr 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oSpe60xH"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F729CA;
	Wed, 24 Apr 2024 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946994; cv=none; b=Axs5q7D35Py2Suwc/zbbb0cW+ZarRBxApLyPBxBWnax2VtpBXZzyfUkiCiKxIiHsMhdURdmidcE5T2wWMWwqezTiVO338bRj2pD5ZnSNhJX7DPqI9JKRUIU/+Oh4x8gK2HjrHgLLDWqrtm4Cyj6nMGiXvcYVbwpcy9uxCIgxQxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946994; c=relaxed/simple;
	bh=AGOMqU/Jf6XXaLgLYmV4uwSGMAyyLtRjgespvDQj3y8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=X5H9puVrPBVBpQGBqUg5mLOhDbLgebeMi2UqwGTLosd5mq8z5XXjNHLURqkyRIMiaYE+RQtghxy69X/FpxQMXOKt2laBUvyM5AuIW5dZ16DXnbxk7k4xX+AL3cm74JiHKuq8V+xUBFh8oWg2TjlXb2eYza61PXDv2L/ssbrA5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oSpe60xH; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713946988; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=3zWketmsOUTP603tVlLTMXKjVURqd0S9c73ZgW29fVo=;
	b=oSpe60xHHZkJZCunlu8aZ5QyggSkqFyJY+rEvdzMYixcWPGCLHs7fngSbEVr2k/nVRDwo2uLlfOy3l+KbGhR1pdTd2KLHfQrhDKZxB5MR4YclG/Co3JeBRJiPkwoG5jIbXuio4K6vHoWWFx0jEjjEx/6OL05P6fZWoZkRYms+u4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W5BlwV6_1713946986;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5BlwV6_1713946986)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 16:23:07 +0800
Message-ID: <1713946914.719213-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 5/8] virtio_net: add the total stats field
Date: Wed, 24 Apr 2024 16:21:54 +0800
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
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com>
 <20240423113141.1752-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEvaJuujaXoJ3jnvMFYX1-CnXH7cUEz4KbXivgEmt=OUxA@mail.gmail.com>
In-Reply-To: <CACGkMEvaJuujaXoJ3jnvMFYX1-CnXH7cUEz4KbXivgEmt=OUxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 24 Apr 2024 11:52:12 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Apr 23, 2024 at 7:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Now, we just show the stats of every queue.
> >
> > But for the user, the total values of every stat may are valuable.
> >
> > NIC statistics:
> >      rx_packets: 373522
> >      rx_bytes: 85919736
> >      rx_drops: 0
> >      rx_xdp_packets: 0
> >      rx_xdp_tx: 0
> >      rx_xdp_redirects: 0
> >      rx_xdp_drops: 0
> >      rx_kicks: 11125
> >      rx_hw_notifications: 0
> >      rx_hw_packets: 1325870
> >      rx_hw_bytes: 263348963
> >      rx_hw_interrupts: 0
> >      rx_hw_drops: 1451
> >      rx_hw_drop_overruns: 0
> >      rx_hw_csum_valid: 1325870
> >      rx_hw_needs_csum: 1325870
> >      rx_hw_csum_none: 0
> >      rx_hw_csum_bad: 0
> >      rx_hw_ratelimit_packets: 0
> >      rx_hw_ratelimit_bytes: 0
> >      tx_packets: 10050
> >      tx_bytes: 1230176
> >      tx_xdp_tx: 0
> >      tx_xdp_tx_drops: 0
> >      tx_kicks: 10050
> >      tx_timeouts: 0
> >      tx_hw_notifications: 0
> >      tx_hw_packets: 32281
> >      tx_hw_bytes: 4315590
> >      tx_hw_interrupts: 0
> >      tx_hw_drops: 0
> >      tx_hw_drop_malformed: 0
> >      tx_hw_csum_none: 0
> >      tx_hw_needs_csum: 32281
> >      tx_hw_ratelimit_packets: 0
> >      tx_hw_ratelimit_bytes: 0
> >      rx0_packets: 373522
> >      rx0_bytes: 85919736
> >      rx0_drops: 0
> >      rx0_xdp_packets: 0
> >      rx0_xdp_tx: 0
> >      rx0_xdp_redirects: 0
> >      rx0_xdp_drops: 0
> >      rx0_kicks: 11125
> >      rx0_hw_notifications: 0
> >      rx0_hw_packets: 1325870
> >      rx0_hw_bytes: 263348963
> >      rx0_hw_interrupts: 0
> >      rx0_hw_drops: 1451
> >      rx0_hw_drop_overruns: 0
> >      rx0_hw_csum_valid: 1325870
> >      rx0_hw_needs_csum: 1325870
> >      rx0_hw_csum_none: 0
> >      rx0_hw_csum_bad: 0
> >      rx0_hw_ratelimit_packets: 0
> >      rx0_hw_ratelimit_bytes: 0
> >      tx0_packets: 10050
> >      tx0_bytes: 1230176
> >      tx0_xdp_tx: 0
> >      tx0_xdp_tx_drops: 0
> >      tx0_kicks: 10050
> >      tx0_timeouts: 0
> >      tx0_hw_notifications: 0
> >      tx0_hw_packets: 32281
> >      tx0_hw_bytes: 4315590
> >      tx0_hw_interrupts: 0
> >      tx0_hw_drops: 0
> >      tx0_hw_drop_malformed: 0
> >      tx0_hw_csum_none: 0
> >      tx0_hw_needs_csum: 32281
> >      tx0_hw_ratelimit_packets: 0
> >      tx0_hw_ratelimit_bytes: 0
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 81 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 69 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 6d24cd8fb15f..8a4d22f5f5b1 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3344,14 +3344,15 @@ static void virtnet_stats_sprintf(u8 **p, const=
 char *fmt, const char *noq_fmt,
> >         }
> >  }
> >
> > +/* qid =3D=3D -1: for rx/tx queue total field */
> >  static void virtnet_get_stats_string(struct virtnet_info *vi, int type=
, int qid, u8 **data)
>
> Nit: -1 for all seems to be a wired API, could we have the caller to
> iterate the possible qid?


Not for all, just the total fields:

      rx_packets: 373522
      rx_bytes: 85919736
      rx_drops: 0
      rx_xdp_packets: 0
      rx_xdp_tx: 0
      rx_xdp_redirects: 0
      rx_xdp_drops: 0
      rx_kicks: 11125
      rx_hw_notifications: 0
      rx_hw_packets: 1325870
      rx_hw_bytes: 263348963
      rx_hw_interrupts: 0
      rx_hw_drops: 1451
      rx_hw_drop_overruns: 0
      rx_hw_csum_valid: 1325870
      rx_hw_needs_csum: 1325870
      rx_hw_csum_none: 0
      rx_hw_csum_bad: 0
      rx_hw_ratelimit_packets: 0
      rx_hw_ratelimit_bytes: 0
      tx_packets: 10050
      tx_bytes: 1230176
      tx_xdp_tx: 0
      tx_xdp_tx_drops: 0
      tx_kicks: 10050
      tx_timeouts: 0
      tx_hw_notifications: 0
      tx_hw_packets: 32281
      tx_hw_bytes: 4315590
      tx_hw_interrupts: 0
      tx_hw_drops: 0
      tx_hw_drop_malformed: 0
      tx_hw_csum_none: 0
      tx_hw_needs_csum: 32281
      tx_hw_ratelimit_packets: 0
      tx_hw_ratelimit_bytes: 0

The field names do not include "qid".

Thanks.


>
> Other parts look good.
>
> Thanks
>

