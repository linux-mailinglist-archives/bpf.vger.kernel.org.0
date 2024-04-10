Return-Path: <bpf+bounces-26364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 885E089EA67
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 08:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11A51F226BA
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563D32BAFA;
	Wed, 10 Apr 2024 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Imv+P+xX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D42A1D8
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729376; cv=none; b=B/H5GL7XfZWTiafdEqvp4pERJzCTEcfGqu+T1YD8TCtvsXevnrljd0hRjHmPUoBDmzBURUomMga61EVdFdTXumnDgwjLzcGs1UTic+sYfSAeoHQCsKt09x5cTMfN/rXamMlpe0w0vUlNWihhtSFZfghZTdIVwQ7bezXzYXraD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729376; c=relaxed/simple;
	bh=fN93S+O/a4r8919HDaOpaGLyUFbfFTR4Yqdw+94Pp/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIcD6hIqyyM9zb7XJKCgBI+QpXSveAM2Fty3YJZzuVNMgyo7yoqY7COEgpn16bh013WUnojolduIDtgFiusuL/dPe0P3FW7zkqL87cPQiP4nmtOVkGm4qkJ1xJF8ynN9cXDrc3Y8qPeTxF5LefHq+iP5yajq1aoUo4jFc+R2Y8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Imv+P+xX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712729374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6b5vs9vSUGn8ADK8g0iw0wXboKE+rPl/OAO5DzwLqrA=;
	b=Imv+P+xXEKusNE6CANfay3KP+9z8DS7KkRAJsXHcCY2cCIDtDj9YX7Gn0hq09zt3vDEx2B
	zrn9sBxT52HB+G71rR4p07/Px18CaDTCCxUcA9LjEBShZq821RhCcakCbm3VY+vyPUdQfU
	f6zDN+px9aMAXVcxWoj/144YHCpySQE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-zpl1a_MnPcWRSi1hSEsU0w-1; Wed, 10 Apr 2024 02:09:33 -0400
X-MC-Unique: zpl1a_MnPcWRSi1hSEsU0w-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a473ba0632so4502309a91.0
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 23:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712729372; x=1713334172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6b5vs9vSUGn8ADK8g0iw0wXboKE+rPl/OAO5DzwLqrA=;
        b=n62637xoKXdp99U4hJN5S82Ug0QH+x62Gjqb5+LWzgH4VIKhzykoJnapre9ojwiW5I
         4D1K4ip0VjzijUCVA0jt/g4Vjd7udGaYC4q+a/FS11xSxwnUJNgohs5MBJFzAoKDqTz8
         ZaytsvRxLEVhZI7sX2p2n5J0drDPbbPFjnHqOH4r67RJZslvtecWO+MAsgCqBc7jpf01
         Xjw6uqO8p+qS9Als3GfRzZK82V6SNK2XOSvCRZ22vhH5cmm7gyW+LDaF/NxytQahswYW
         A8EATvmkEneOOyxE4RbZGhu0La6DlCri/ldKwf57Lm1JBArSkDOZTyQKMiE4mBqeocVX
         lxLw==
X-Forwarded-Encrypted: i=1; AJvYcCVcyezgbktqhYAvQiZE2q+jJwc4I+hTEpNBl1PtyrwgENSBwefriKsn3ojiEW5DW0zW+473H4yFD01vYaEgzyDQmAtn
X-Gm-Message-State: AOJu0YzRGP0tUhYekSBGbHBlRfQr7FRQ/ZmEIJJdrsFEN3sH3LJs4Xg0
	UqfqL0ogdA7OeLK9NpgCzzIPY8yxdHW0erTe9Yf/+3CBVkRlpJWXFndb872ocGNp8r41N872yey
	zYEgKLMdpa1fzi0QwjUm6dc12bHIia/zHLmeDPkgXOXqyEbN36aRu28FSUAEhDaHZgJ5knskRmi
	ZVDcDNpEtKnDpCMswo6yuHuNd8
X-Received: by 2002:a17:90a:f011:b0:2a5:decc:47e5 with SMTP id bt17-20020a17090af01100b002a5decc47e5mr325836pjb.38.1712729372254;
        Tue, 09 Apr 2024 23:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4OypenlPPbiCIKXCbwYuLlk6d1UE613DACQ8FfIH/rLE/xnrB/ReP5oeXLI6ZF1tM/VeXhwAWDVRBi1ckH5s=
X-Received: by 2002:a17:90a:f011:b0:2a5:decc:47e5 with SMTP id
 bt17-20020a17090af01100b002a5decc47e5mr325822pjb.38.1712729371974; Tue, 09
 Apr 2024 23:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com> <20240318110602.37166-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240318110602.37166-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 14:09:20 +0800
Message-ID: <CACGkMEvd3cg_W64aMMvER03vNqkrxYM6VAMYTj7z3zAkfdaSVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 7/9] virtio_net: rename stat tx_timeout to timeout
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we have this:
>
>     tx_queue_0_tx_timeouts
>
> This is used to record the tx schedule timeout.
> But this has two "tx". I think the below is enough.
>
>     tx_queue_0_timeouts
>
> So I rename this field.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 12dc1d0d8d2b..a24cfde30d08 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -87,7 +87,7 @@ struct virtnet_sq_stats {
>         u64_stats_t xdp_tx;
>         u64_stats_t xdp_tx_drops;
>         u64_stats_t kicks;
> -       u64_stats_t tx_timeouts;
> +       u64_stats_t timeouts;
>  };
>
>  struct virtnet_rq_stats {
> @@ -111,7 +111,7 @@ static const struct virtnet_stat_desc virtnet_sq_stat=
s_desc[] =3D {
>         VIRTNET_SQ_STAT("xdp_tx",       xdp_tx),
>         VIRTNET_SQ_STAT("xdp_tx_drops", xdp_tx_drops),
>         VIRTNET_SQ_STAT("kicks",        kicks),
> -       VIRTNET_SQ_STAT("tx_timeouts",  tx_timeouts),

This is noticeable by userspace, not sure if it's too late.

Thanks


> +       VIRTNET_SQ_STAT("timeouts",     timeouts),
>  };
>
>  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] =3D {
> @@ -2780,7 +2780,7 @@ static void virtnet_stats(struct net_device *dev,
>                         start =3D u64_stats_fetch_begin(&sq->stats.syncp)=
;
>                         tpackets =3D u64_stats_read(&sq->stats.packets);
>                         tbytes   =3D u64_stats_read(&sq->stats.bytes);
> -                       terrors  =3D u64_stats_read(&sq->stats.tx_timeout=
s);
> +                       terrors  =3D u64_stats_read(&sq->stats.timeouts);
>                 } while (u64_stats_fetch_retry(&sq->stats.syncp, start));
>
>                 do {
> @@ -4568,7 +4568,7 @@ static void virtnet_tx_timeout(struct net_device *d=
ev, unsigned int txqueue)
>         struct netdev_queue *txq =3D netdev_get_tx_queue(dev, txqueue);
>
>         u64_stats_update_begin(&sq->stats.syncp);
> -       u64_stats_inc(&sq->stats.tx_timeouts);
> +       u64_stats_inc(&sq->stats.timeouts);
>         u64_stats_update_end(&sq->stats.syncp);
>
>         netdev_err(dev, "TX timeout on queue: %u, sq: %s, vq: 0x%x, name:=
 %s, %u usecs ago\n",
> --
> 2.32.0.3.g01195cf9f
>


