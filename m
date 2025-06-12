Return-Path: <bpf+bounces-60444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74124AD6762
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 07:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2355317ABC1
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 05:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D11EFF9F;
	Thu, 12 Jun 2025 05:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3rxnklgl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F091A5BA4
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749706438; cv=none; b=sQ90pwufYD+10nlmNrSG4ApJX9o2b5fjkTZH1PcOxVWE4SYPYIKrTldJhKNUbKCt+hgASd1UJHQSfax71a/nDCZtMvIw2odlR3PN75frBYc3Y0D8LU7XGFJaMWf4iIOZxKVLM4lAGbC+RULyhfEbmYlJyN7NDGy905Q/vJntqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749706438; c=relaxed/simple;
	bh=Esu639NQ3h0pUolsE+L62kqRdItgxrjwHM5dB+O9x3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3YQ1NVP8cKzV80sZk6k5lT7xv/QbXIWiGyqYz/cg/e05m5HAlQlA+uHZD8c48OzbKadIjhysUUxhHoN1mk+nx0LajIpgAbHyrUEjAvlRyrF5B2NEYILM+nueSeFNK0KAzUl8ks1Rzd+p7NvpyG6cgeq5ML7agjfeiX+e5LWRjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3rxnklgl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2348ac8e0b4so82285ad.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 22:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749706434; x=1750311234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MG8DHTvq/qRGMg3QrUciQGDqEK1excvKUOp84PPj3c=;
        b=3rxnklgli8VZrJiIqyvzeFF3ekCi35NjXdlTzK5t1ap/H1dnt/DlbrtZQOeRgvUO/7
         dZRGUNIr7gNxeGWoe5y+aAt/EJVbDpz+/Q00y3/GGaHwPCgpXQUa9eWb7odGB4vzerZN
         zgzncDR/9mZ3o08dQX3U4eMUlZeaWiW/F0bEabvFRVebimCJYMGDte/qoY5J8mzb9EQR
         30a5xgTmjBQGOJGKj0Fyi637Qmw43GpalD98aDQFJy8RvTvkozeSmh1TFY4AUPTF55+7
         BBjvxqABbIyTFhRvvtJGCUE2rcnnpqQvncyompZwvLaWGZT5f5dCrp4VdOUa3SA6/alO
         eM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749706434; x=1750311234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MG8DHTvq/qRGMg3QrUciQGDqEK1excvKUOp84PPj3c=;
        b=B45R6wcOqdilzv4nHKIZdpCNn0955vTjYg0rHeKHPsMpTSsGQ16hwSv3UfpPE4XwUz
         CmFW+sfKYmOGfI8Yh3bZgbp3kzXdW3Uk9Dt1JT9AuiNKnQfJsY7mINUUahcjfe7+kQXq
         KvQkrKMiBJBMpESiDhEYc9KMc7XBHKumo+UZhVDsaDBPtUdeKRZQeoBIAV85YF4dbFCJ
         016MN4cNOh3WI7l+TOPCZ11cPYqGUOrRmcaCJ4yzc+9GWy+uXC0iBh1z09bcq3cLiCrl
         +J8e919aClZW68TPDIjYgkDm6ZGnHEPi1bDcUgpLxNcRddh6AFhgxofR17S+y1ycy640
         QS5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdyYRANM0rcIs78/NmnCSINIaXqiEmtAyDrFyHuVAjc00KDRvAyLFqvLfzMzhqMZyq8vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXfx+dK1QgKMrJSSWAaKo+bGssW/M4rKzCvM4QY3V5cFp0N0K3
	5E2MsLwVFKPC1WIl72rqRsiCP7iTGb9FbWEoucMPbETHhLJcoR1IkY0mVMbk9AYHkVz+wC+CKaI
	sVfkhATOEj3tC0ITgfddnrxG9A0dITjxBlKV0Itgl
X-Gm-Gg: ASbGncus9OO6mNUoDqouKUk3HlD9I964BBVZ2/eMDi9Hgmuk0HehGXrU9O3ZRElnTHF
	xOBVjWbs+XW1p/KFemcCQ+htXmFUT71WFfm1kx3LNu81mOV0rMefg7C+pY5iHXqNqZ076/fmcpW
	SX8J1ifYJ9Jp9OeCoiG2PyjHYe+TrbxxRobBvLO91lNYVk
X-Google-Smtp-Source: AGHT+IGXAg/B6LBkZbDCWSh7HnwG3gh9i4+QKa2dl2PrE4nN9ppued4dSt9P5QJ+xN+GLNCTbDB2L7Rfw46DFAwqD5E=
X-Received: by 2002:a17:902:e545:b0:22c:3cda:df11 with SMTP id
 d9443c01a7336-2364dd812f0mr1702785ad.10.1749706434224; Wed, 11 Jun 2025
 22:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609145833.990793-1-mbloch@nvidia.com> <20250609145833.990793-11-mbloch@nvidia.com>
In-Reply-To: <20250609145833.990793-11-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 22:33:41 -0700
X-Gm-Features: AX0GCFsYSgx73nrC-SXHzv68aZPiBHRhi1b3Qjgt6e6IXA1Ei-CkUqpGNyxM2ik
Message-ID: <CAHS8izOX8t-Xu+mseiRBvLDYmk6G+iH=tX6t4SWY2TKBau7r-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/12] net/mlx5e: Implement queue mgmt ops and
 single channel swap
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, gal@nvidia.com, 
	leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 8:08=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrote=
:
>
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> The bulk of the work is done in mlx5e_queue_mem_alloc, where we allocate
> and create the new channel resources, similar to
> mlx5e_safe_switch_params, but here we do it for a single channel using
> existing params, sort of a clone channel.
> To swap the old channel with the new one, we deactivate and close the
> old channel then replace it with the new one, since the swap procedure
> doesn't fail in mlx5, we do it all in one place (mlx5e_queue_start).
>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_main.c | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
> index a51e204bd364..90687392545c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5494,6 +5494,102 @@ static const struct netdev_stat_ops mlx5e_stat_op=
s =3D {
>         .get_base_stats      =3D mlx5e_get_base_stats,
>  };
>
> +struct mlx5_qmgmt_data {
> +       struct mlx5e_channel *c;
> +       struct mlx5e_channel_param cparam;
> +};
> +
> +static int mlx5e_queue_mem_alloc(struct net_device *dev, void *newq,
> +                                int queue_index)
> +{
> +       struct mlx5_qmgmt_data *new =3D (struct mlx5_qmgmt_data *)newq;
> +       struct mlx5e_priv *priv =3D netdev_priv(dev);
> +       struct mlx5e_channels *chs =3D &priv->channels;
> +       struct mlx5e_params params =3D chs->params;
> +       struct mlx5_core_dev *mdev;
> +       int err;
> +
> +       mutex_lock(&priv->state_lock);
> +       if (!test_bit(MLX5E_STATE_OPENED, &priv->state)) {
> +               err =3D -ENODEV;
> +               goto unlock;
> +       }
> +
> +       if (queue_index >=3D chs->num) {
> +               err =3D -ERANGE;
> +               goto unlock;
> +       }
> +
> +       if (MLX5E_GET_PFLAG(&chs->params, MLX5E_PFLAG_TX_PORT_TS) ||
> +           chs->params.ptp_rx   ||
> +           chs->params.xdp_prog ||
> +           priv->htb) {
> +               netdev_err(priv->netdev,
> +                          "Cloning channels with Port/rx PTP, XDP or HTB=
 is not supported\n");
> +               err =3D -EOPNOTSUPP;
> +               goto unlock;
> +       }
> +
> +       mdev =3D mlx5_sd_ch_ix_get_dev(priv->mdev, queue_index);
> +       err =3D mlx5e_build_channel_param(mdev, &params, &new->cparam);
> +       if (err) {
> +               return err;
> +               goto unlock;
> +       }
> +
> +       err =3D mlx5e_open_channel(priv, queue_index, &params, NULL, &new=
->c);
> +unlock:
> +       mutex_unlock(&priv->state_lock);
> +       return err;
> +}
> +
> +static void mlx5e_queue_mem_free(struct net_device *dev, void *mem)
> +{
> +       struct mlx5_qmgmt_data *data =3D (struct mlx5_qmgmt_data *)mem;
> +
> +       /* not supposed to happen since mlx5e_queue_start never fails
> +        * but this is how this should be implemented just in case
> +        */
> +       if (data->c)
> +               mlx5e_close_channel(data->c);
> +}
> +
> +static int mlx5e_queue_stop(struct net_device *dev, void *oldq, int queu=
e_index)
> +{
> +       /* mlx5e_queue_start does not fail, we stop the old queue there *=
/
> +       return 0;
> +}

Is this really better than maintaining uniformity of behavior between
the drivers that support the queue mgmt api and just doing the
mlx5e_deactivate_priv_channels and mlx5e_close_channel in the stop
like core sorta expects?

We currently use the ndos to restart a queue, but I'm imagining in the
future we can expand it to create queues on behalf of the queues. The
stop queue API may be reused in other contexts, like maybe to kill a
dynamically created devmem queue or something, and this specific
driver may stop working because stop actually doesn't do anything?

--=20
Thanks,
Mina

