Return-Path: <bpf+bounces-20311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9663283BB46
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 09:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C6928D3AC
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 08:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E7317580;
	Thu, 25 Jan 2024 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPU8zeWE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED314F86;
	Thu, 25 Jan 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169849; cv=none; b=CrcuNGkgshm52uyV1CAy4vUQV0x73cT8F/3yeIBC5NNpGg+Swo+YxOdXLFshVr9QGafk9I2oj5z61SrLn1j/lgpPa+mRfXg0SDhaO9X2IWm0HS2GV+NSlip6sLocNUMDdn3n7Smi73bMIrHgyHXKaOZthCTVSV1OP2T3/Xw64LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169849; c=relaxed/simple;
	bh=hDxamplBsotWbvMDQTn7mEvPUtyfVp6Jc+qhdCx6Xbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIZHSukcrAeTpZzPQ8R/tcR/equ1X5AiQX4jMoomKAE3eXWC6BGMj7cv7iL22/BUJo97haPhhlREgMpXajJEASvBUXZm4O0eE6SYbAzFa7ciCi/jXDBwoQMSPLkC19e15rZC9RknPoLQqCCDuhTQpGQ1I2Ee25dSF5Sd5c0VLtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPU8zeWE; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d53ea8024dso53685241.1;
        Thu, 25 Jan 2024 00:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706169846; x=1706774646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sZT8/9PgZuTeh83+/QruKBnCl5NoqTcp1uIUCJ9u5aU=;
        b=lPU8zeWEiwfnZEn66qirYRtCF0OW3I0ZqM+PfLzsTCy/u2nA+HiQNK+6fak/2RlXt6
         5iM0PKjHCwTFnBq8cUWjXZbsH8hPSIW3wenwu24vAqY/EF93YSRlTRgc7JJrD0ISRXFI
         HERaONjLOgl+5mg9w0OGFHaIW6ErXTeTgsw5/2meCl22Fca5lnJI1h7nrumOso1JyOZd
         JPJYSXmA5azKF/D35a5WmtZ1G7oX376eFO9UQ+AB+U01/Uq64HQl/o4zL59Wdrrn0rXl
         zH0qvXzHaOaCyc5nGxHR8BFvIWXDBP4Uv4/FSlxU/uH7MYUMkplZpNb5tSfVVXowiYLl
         UY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169846; x=1706774646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZT8/9PgZuTeh83+/QruKBnCl5NoqTcp1uIUCJ9u5aU=;
        b=J9ug/wBYtaKbDZ9sbzwxuJtcxz/QwKOg8QxgjZDYzAzk3xKPL2kmdzJo2VcAsxTXfU
         bRrLGBOY5BnX9vgHKJ5JHklMLUZKkNAeUWTXhfuWyKzNz+S1qXYZoBis+qrcReoQtGS6
         qFHPcOCAQiJh2UJH2gl1sh14NE51V2C/AiWybaj9UnSENmsUb21iet0LqdPqyTOwZyFF
         +O99v1XDQdcAZTDcsnTYCWRGwVGnvGZSLq7BcxPMcyL4thPMf2WYRifXFLx6PxlwVcNn
         Qxpv0gZdU7kvfhCGUyAO65lBMOf06oLkmtBHYRruKmVYWKJ4/O8dLeRYxIMAHUN1j5qQ
         +aIw==
X-Gm-Message-State: AOJu0YxuRPD2PpKFvhmS5XgfSgPcI4lxnDHMAYP1vrYSzkzFzwq2XtgR
	MvxQrdXImHS49Te3Vb/PwduWTZEx8+r4Cg3Sdxjq+9AI9yp/GPaW4UBNo9/NKv7ndw65pcOJ5o9
	vXrwErXn1lrnrk/IVKcYsfwnX+cU=
X-Google-Smtp-Source: AGHT+IHDMdzd0L+gZ6HYMBNFVKRpe73Gf29LizjNJ6zEfGPhn2td090G9Il+wVVyBONa71BlB2aknf1MEFBlTnUpvpY=
X-Received: by 2002:a67:f90e:0:b0:469:ac04:5553 with SMTP id
 t14-20020a67f90e000000b00469ac045553mr922677vsq.3.1706169846143; Thu, 25 Jan
 2024 00:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124191602.566724-1-maciej.fijalkowski@intel.com> <20240124191602.566724-11-maciej.fijalkowski@intel.com>
In-Reply-To: <20240124191602.566724-11-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 25 Jan 2024 09:03:54 +0100
Message-ID: <CAJ8uoz0ATqhepbBQLv0u-NVrEJeL1EZ-w+xTkW5cUeZGxCT6NA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf 10/11] i40e: set xdp_rxq_info::frag_size
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org, 
	martin.lau@linux.dev, tirthendu.sarkar@intel.com, john.fastabend@gmail.com, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 20:29, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> i40e support XDP multi-buffer so it is supposed to use
> __xdp_rxq_info_reg() instead of xdp_rxq_info_reg() and set the
> frag_size. It can not be simply converted at existing callsite because
> rx_buf_len could be un-initialized, so let us register xdp_rxq_info
> within i40e_configure_rx_ring(), which happen to be called with already
> initialized rx_buf_len value.
>
> Commit 5180ff1364bc ("i40e: use int for i40e_status") converted 'err' to
> int, so two variables to deal with return codes are not needed within
> i40e_configure_rx_ring(). Remove 'ret' and use 'err' to handle status
> from xdp_rxq_info registration.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Fixes: e213ced19bef ("i40e: add support for XDP multi-buffer Rx")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 40 ++++++++++++---------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c |  9 -----
>  2 files changed, 24 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index ae8f9f135725..d3b00d8ed39a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3588,40 +3588,48 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>         struct i40e_hmc_obj_rxq rx_ctx;
>         int err = 0;
>         bool ok;
> -       int ret;
>
>         bitmap_zero(ring->state, __I40E_RING_STATE_NBITS);
>
>         /* clear the context structure first */
>         memset(&rx_ctx, 0, sizeof(rx_ctx));
>
> -       if (ring->vsi->type == I40E_VSI_MAIN)
> -               xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
> +       ring->rx_buf_len = vsi->rx_buf_len;
> +
> +       /* XDP RX-queue info only needed for RX rings exposed to XDP */
> +       if (ring->vsi->type != I40E_VSI_MAIN)
> +               goto skip;
> +
> +       if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
> +               err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
> +                                        ring->queue_index,
> +                                        ring->q_vector->napi.napi_id,
> +                                        ring->rx_buf_len);
> +               if (err)
> +                       return err;
> +       }
>
>         ring->xsk_pool = i40e_xsk_pool(ring);
>         if (ring->xsk_pool) {
> -               ring->rx_buf_len =
> -                 xsk_pool_get_rx_frame_size(ring->xsk_pool);
> -               ret = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> +               ring->rx_buf_len = xsk_pool_get_rx_frame_size(ring->xsk_pool);
> +               err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
>                                                  MEM_TYPE_XSK_BUFF_POOL,
>                                                  NULL);
> -               if (ret)
> -                       return ret;
> +               if (err)
> +                       return err;
>                 dev_info(&vsi->back->pdev->dev,
>                          "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
>                          ring->queue_index);
>
>         } else {
> -               ring->rx_buf_len = vsi->rx_buf_len;
> -               if (ring->vsi->type == I40E_VSI_MAIN) {
> -                       ret = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> -                                                        MEM_TYPE_PAGE_SHARED,
> -                                                        NULL);
> -                       if (ret)
> -                               return ret;
> -               }
> +               err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> +                                                MEM_TYPE_PAGE_SHARED,
> +                                                NULL);
> +               if (err)
> +                       return err;
>         }
>
> +skip:
>         xdp_init_buff(&ring->xdp, i40e_rx_pg_size(ring) / 2, &ring->xdp_rxq);
>
>         rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 1f0a0f13a334..0d7177083708 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -1548,7 +1548,6 @@ void i40e_free_rx_resources(struct i40e_ring *rx_ring)
>  int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
>  {
>         struct device *dev = rx_ring->dev;
> -       int err;
>
>         u64_stats_init(&rx_ring->syncp);
>
> @@ -1569,14 +1568,6 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
>         rx_ring->next_to_process = 0;
>         rx_ring->next_to_use = 0;
>
> -       /* XDP RX-queue info only needed for RX rings exposed to XDP */
> -       if (rx_ring->vsi->type == I40E_VSI_MAIN) {
> -               err = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
> -                                      rx_ring->queue_index, rx_ring->q_vector->napi.napi_id);
> -               if (err < 0)
> -                       return err;
> -       }
> -
>         rx_ring->xdp_prog = rx_ring->vsi->xdp_prog;
>
>         rx_ring->rx_bi =
> --
> 2.34.1
>
>

