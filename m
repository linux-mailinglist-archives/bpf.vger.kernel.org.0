Return-Path: <bpf+bounces-12800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126577D08EF
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 08:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A7E1C20F3C
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 06:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234B5D2E2;
	Fri, 20 Oct 2023 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqMbBLDF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93DACA67
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 06:57:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963A998
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697785043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHQSIwEZHQWP+tSXUJE+jHEMURynrqRjJWGru8ceQos=;
	b=cqMbBLDFJj4w/WihtcVeL0sgR/I5+umpAtXpy/nM7dSY9W+TznjXpzzOBg/0zAHWGVQlhJ
	1L9GVBOMIZbW4Lw0enRMslhNTSBkATvYicC8KZxEUEW+9fTaMCeKFXLufz8jNvPeQ9KB11
	fkDU54h+iEWx4snJbYXYk+FXowiydw8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-6WY_MLnXMSSfaDQ78X1wEg-1; Fri, 20 Oct 2023 02:57:22 -0400
X-MC-Unique: 6WY_MLnXMSSfaDQ78X1wEg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5079f6c127cso421086e87.3
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697785041; x=1698389841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHQSIwEZHQWP+tSXUJE+jHEMURynrqRjJWGru8ceQos=;
        b=gUvnfA5DlL5xeu4C3T0yaiAsXUNIYJPAKF8rJce21sjEsUyhdCzeWKeYwz1v71JfM3
         zivapSGYz8GHw6dqHarQNslzWUw+eVuk3lpz6lY9uHU1ycKpXMeJi313DJcRWpcgWxrT
         OOX4Sc42Wl6GBSIPuctgKtJng0Paz8Z7bjPmepEWrQmyCn3kDKwmRKtAwKe/mnfU1/9e
         aJH/kEXK8rXCVkdJjrilncDB2WBNX0V5AvgMUqQ6nfWKwlbPVT4JjNm/J91wF7ACOYYc
         DzM/VukY/3RWw20zlJOdtaWNKIkRJMNF7k9631wm8Hd4jOODvECrRSGFbeLtFsorGAc+
         Os4A==
X-Gm-Message-State: AOJu0YwYhZ4A5eGgkYynPt57mAtZjAXYTIT2wG8sjHXtPSDcGVdCSIz+
	V7dV7yB37dkiqfHGWiZCSN7LQRALpQm0TlgoR3YD+R0pfG/1v9yxwXpluqde8TiTkhLUIS/A44f
	JJ0z23p9Gk885xTsWOy5oftij/Nj8
X-Received: by 2002:ac2:58ca:0:b0:507:9a32:fd89 with SMTP id u10-20020ac258ca000000b005079a32fd89mr578140lfo.44.1697785040997;
        Thu, 19 Oct 2023 23:57:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDIndMynMMz19N4vsFZpfGiNEUT/sYvsBfrXutsJMURgpn/F07AOz8Z/xOPZDI3cmdYmWj8ognG4ckObJf4HU=
X-Received: by 2002:ac2:58ca:0:b0:507:9a32:fd89 with SMTP id
 u10-20020ac258ca000000b005079a32fd89mr578128lfo.44.1697785040764; Thu, 19 Oct
 2023 23:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-19-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-19-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:57:10 +0800
Message-ID: <CACGkMEurBykMNNxf2XYe_dUpBLrUwuUupjzhJQL-b9di7moMGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 18/19] virtio_net: update tx timeout record
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> If send queue sent some packets, we update the tx timeout
> record to prevent the tx timeout.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>  drivers/net/virtio/xsk.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> index f1c64414fac9..5d3de505c56c 100644
> --- a/drivers/net/virtio/xsk.c
> +++ b/drivers/net/virtio/xsk.c
> @@ -274,6 +274,16 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct =
xsk_buff_pool *pool,
>
>         virtnet_xsk_check_queue(sq);
>
> +       if (stats.packets) {
> +               struct netdev_queue *txq;
> +               struct virtnet_info *vi;
> +
> +               vi =3D sq->vq->vdev->priv;
> +
> +               txq =3D netdev_get_tx_queue(vi->dev, sq - vi->sq);
> +               txq_trans_cond_update(txq);
> +       }
> +
>         u64_stats_update_begin(&sq->stats.syncp);
>         sq->stats.packets +=3D stats.packets;
>         sq->stats.bytes +=3D stats.bytes;
> --
> 2.32.0.3.g01195cf9f
>


