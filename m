Return-Path: <bpf+bounces-32272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA7E90A5E7
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 08:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FC71F22342
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 06:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71AC186299;
	Mon, 17 Jun 2024 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlO4Ihhj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37979D3
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605932; cv=none; b=du9rTyRpuKxhKUmm90Muep5Iq8GZDf1l1hdFzLtdG3K7yVKqVYWMg7miq9/kWfMsTALV5eBI8GyoP21OlZ40aAkigtFEnQu3mvyeShRf21mxaHEgXdiYywmfrE5oRtgHqUKd5XTa39/WCox1lF68uzSIMfwsimeTTSAOOAejA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605932; c=relaxed/simple;
	bh=+SnHGBT0dEbHmy6M7zBTRMqmh8abTUvjhC0ZSGnLMqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1VId7qKflk2dKdxEfDA58YU1bWiBP5WV26a0tQeVQqnV8u4anHPbvIxks4UscgsUurqDzbqOW2N2RUiyD29BLcCBO6xfRdJJKWchhgOAFXpr3GOXkTDVunVS5BLOkHM8ArlbKdWkkJ1UCFEtz3kNqko+uXsiYlYlslEh00CDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlO4Ihhj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718605929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdjqRPBQHAxoGBuZ2sA/XQpy9enBxGSufgOepPoFtj0=;
	b=NlO4IhhjVfl6FeZd/taKPqx2V1xaaG6GrMr8PWoC6pW8bqsLYP3/JdnU5SVYUpa4M+paCP
	u9JBH55EW5ozMSCoVZ9ZK2zpR4xV6IzKcH8g1U+tMCVPceWOGymrJuW1ijHKGYTCEr6fSK
	RtqNCvqYanaAk4OgMpW6gNe/+t/93r8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-wK5Gvb2KOp6hahin78YKUg-1; Mon, 17 Jun 2024 02:31:40 -0400
X-MC-Unique: wK5Gvb2KOp6hahin78YKUg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6e231ed9e5aso3578617a12.3
        for <bpf@vger.kernel.org>; Sun, 16 Jun 2024 23:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718605899; x=1719210699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdjqRPBQHAxoGBuZ2sA/XQpy9enBxGSufgOepPoFtj0=;
        b=lzBlToLemZcNmaNY47zXNPdTvmvoUVtVoDH7zFRA2VQME913leENRdfJpol4ygcMeL
         MfQarJDAxxaP9l1Lzc4juXB8tq6DQX69flJc+rUxWgas6SbhPssVJhlsTxAIyqZfHX5d
         ApoZe4J67Js42CoxuTF+c473jj0njItReurhFSfeJWz38XPgOydLu7mkbcOtQSiNvA0r
         GIXJYb4iu8CrjKaSeAF0trRq7SnEvORB7hw4nEnKh0lQnhyFmWxfGKuiKBWPXbbsNEQr
         +mzWNm5RtKTeqJf6D5G1Q1twoPFLr4Bs6PplrIeeDdwAF5Wk2rE45dCI2fgCA1VT1tK/
         kMaw==
X-Forwarded-Encrypted: i=1; AJvYcCWaoYFrxqCTpHUNf8cfRLW+FHm+IPu/1WEME4b7aYqoQuSs9hkLdKuQof3kmXY45nwgt2D5/KUV4q9HUhipONk9hJr1
X-Gm-Message-State: AOJu0YzZpzxHk/CbRWdL8w67u5DyuU5bFTSFuaYokDWDC6lf3+um6nCN
	eZOka7cqTJOvbg31hN0lnpEZ2tR/4bPFC73zzLCiBa/I6k+gpQtcGctInj0rDFV8hlrQjROuXCp
	3s4Tm2PS604RAHBlAEVqcvkuoXQmL0W5NIcrTZVIdvnFXSzGJnP5sG8bszBplOwHYMYxUDTnY5p
	15VO4QQybPdOlZmAx3xPcMFQOp
X-Received: by 2002:a17:90a:db55:b0:2c3:2592:110c with SMTP id 98e67ed59e1d1-2c4dbb43e62mr8278245a91.36.1718605899127;
        Sun, 16 Jun 2024 23:31:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7KefAopNA2i5sAqiaST2GA+tSESU8wWsjtyQlOa227A495/1OOwv6HQiwb6XHO33GM2MTivOGpNjHpfT4AXI=
X-Received: by 2002:a17:90a:db55:b0:2c3:2592:110c with SMTP id
 98e67ed59e1d1-2c4dbb43e62mr8278225a91.36.1718605898833; Sun, 16 Jun 2024
 23:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com> <20240614063933.108811-13-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240614063933.108811-13-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 14:31:25 +0800
Message-ID: <CACGkMEuk8rcSxt-+2AkPWixPoWcKXA+1swfMnzTFSyM=XazQKg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 12/15] virtio_net: xsk: tx: support wakeup
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 2:40=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> xsk wakeup is used to trigger the logic for xsk xmit by xsk framework or
> user.
>
> Virtio-net does not support to actively generate an interruption, so it
> tries to trigger tx NAPI on the local cpu.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e811f392768..9bfccef18e27 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1368,6 +1368,29 @@ static bool virtnet_xsk_xmit(struct send_queue *sq=
, struct xsk_buff_pool *pool,
>         return sent =3D=3D budget;
>  }
>
> +static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
> +{
> +       struct virtnet_info *vi =3D netdev_priv(dev);
> +       struct send_queue *sq;
> +
> +       if (!netif_running(dev))
> +               return -ENETDOWN;
> +
> +       if (qid >=3D vi->curr_queue_pairs)
> +               return -EINVAL;
> +
> +       sq =3D &vi->sq[qid];
> +
> +       if (napi_if_scheduled_mark_missed(&sq->napi))
> +               return 0;
> +
> +       local_bh_disable();
> +       virtqueue_napi_schedule(&sq->napi, sq->vq);
> +       local_bh_enable();
> +
> +       return 0;
> +}
> +
>  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>                                    struct send_queue *sq,
>                                    struct xdp_frame *xdpf)
> @@ -5706,6 +5729,7 @@ static const struct net_device_ops virtnet_netdev =
=3D {
>         .ndo_vlan_rx_kill_vid =3D virtnet_vlan_rx_kill_vid,
>         .ndo_bpf                =3D virtnet_xdp,
>         .ndo_xdp_xmit           =3D virtnet_xdp_xmit,
> +       .ndo_xsk_wakeup         =3D virtnet_xsk_wakeup,
>         .ndo_features_check     =3D passthru_features_check,
>         .ndo_get_phys_port_name =3D virtnet_get_phys_port_name,
>         .ndo_set_features       =3D virtnet_set_features,
> --
> 2.32.0.3.g01195cf9f
>


