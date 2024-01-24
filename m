Return-Path: <bpf+bounces-20206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2583A494
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 09:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77B91F25264
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 08:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE1C179B2;
	Wed, 24 Jan 2024 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kchyvg20"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C578179A8;
	Wed, 24 Jan 2024 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086364; cv=none; b=impU6b8ZtdB7JSrvDFjweSd7BDKkY7Hnp3hFIl7Vr2BHpr8zooZIT6q0weSqwBQ7my5pCtccn0lVv8IjT6IG0KOv6udf62wQRDSEHqvsforBTEByoeSeT7y5Rs/F28tYiWaXl2t35w54rrHZ6wpYkF+lBvY1hdSA2yCLpjzAsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086364; c=relaxed/simple;
	bh=SnAlArXMenv6/ZGxGogyDDvRrMjF9ReUGoyH+LeyUjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+QAVYS5sJTXM+SaIkuFcrIHz4PYJATCd8qR5V+KRQhQ1ypqpil1O2oxHgAtrrQoJlqPiX5qqIeeVlc/u0OfZ72lnqp24MexYZ76WjJgqV5QdQ56hzY50dT/OFB1EiiWm/Z+wxYVup35TTwUkCpRxb2FAG5ikpBk0t2hBAzPH+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kchyvg20; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-429d9a9e38bso11068571cf.0;
        Wed, 24 Jan 2024 00:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706086362; x=1706691162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6G5HRBXgPgaKCvL+TwUplcblL5VUAVBe0RUlShTL+7U=;
        b=Kchyvg20akJ+us/4/OGA8bBtMoX8HY9UJ9N6TuclyaCjlZvSA7Z40vyMIwgZILTORj
         8nTr0SxS36rcwFYN6kr4Dg5I5GVrS2mPricWAgY68fW+FarTxYJrw6rax4Tg1siRmHbp
         ng0Jnm0UcGBi9LagLmuY0eiKL57BZLJSwUyUWVrLXTKryhuCxuqxWlFa5b0xge1AGwud
         eiZDZgsHpaVb81kw0tfvs1ZzpWmyGmFvVIJYO1W4kjC3y8k6s7pbVx22IL7Aq322Xsgz
         5FaRvoU7eivyA/eLXotfMx4WVjLtkbnZeb6B8JE/QApGy9qlrhGlevyX0Tc+vIGqZNY5
         PGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086362; x=1706691162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6G5HRBXgPgaKCvL+TwUplcblL5VUAVBe0RUlShTL+7U=;
        b=rZzS2J72lLk3c05+CVJ1rJO7N/sPF9EAWLHkk10tAYpUXVMzv6QoG49/W4AJ/7IAEO
         2nFr/gTCzjfpLsfo9sFg2nQDcDZmV6nnuoHYfcLYloZ3147Bw3AtKR0M0IA2lu33HaZ7
         B5VDBx/pvfLKqWh4dCH9Ona+eqjAfY43fApEuu9LlrT9hlcFGEsGUainh8X/uVv9iwTC
         F+d3oBPR0uOPqjd+k8u2PnR/4hNOuJzsx4vz2dHN2KsYrBcnGQYWhDoIUCqdnC6NTf6Q
         0peDybBQeneUKJjAf6sxuaRE/Hbtu/k2n5qMycDgI7i9VnlWRgkMVCg/yIyVNPjSpooi
         Qdsg==
X-Gm-Message-State: AOJu0Yw+9QSzsjz/dlE4IamfX/VsDQxgBEl0s8AzP6X3cw7ghurP06cP
	c6UfSv1diMiDSZn1ayOKiaHS79LAPFC90HYFFCXisiJsUG0it/X5cogNiKC33sYw/RjX9jke1ck
	sdy9B6IkxnO3S91euqpmUXavSjZc=
X-Google-Smtp-Source: AGHT+IHIan+2Mpt6aGU+d5zwpUVUCbWd8+nXaoxJPTuGWQQksc9VhJMpb2oG7ICbqrF3EJe/zSBRyF/g0RzNuEBuqcs=
X-Received: by 2002:ad4:5805:0:b0:686:90f1:b177 with SMTP id
 dd5-20020ad45805000000b0068690f1b177mr8832995qvb.1.1706086362308; Wed, 24 Jan
 2024 00:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com> <20240122221610.556746-12-maciej.fijalkowski@intel.com>
In-Reply-To: <20240122221610.556746-12-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 24 Jan 2024 09:52:31 +0100
Message-ID: <CAJ8uoz0eaXqXyUmDXdCHfcCn3pNt4jK2FsY0rmvY-sda-y3zyw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf 11/11] i40e: update xdp_rxq_info::frag_size for ZC
 enabled Rx queue
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org, 
	martin.lau@linux.dev, tirthendu.sarkar@intel.com, john.fastabend@gmail.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 23:18, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Now that i40e driver correctly sets up frag_size in xdp_rxq_info, let us
> make it work for ZC multi-buffer as well. i40e_ring::rx_buf_len for ZC
> is being set via xsk_pool_get_rx_frame_size() and this needs to be
> propagated up to xdp_rxq_info.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index f8d513499607..7b091ce64cc7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3609,7 +3609,14 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>
>         ring->xsk_pool = i40e_xsk_pool(ring);
>         if (ring->xsk_pool) {
> +               xdp_rxq_info_unreg(&ring->xdp_rxq);
>                 ring->rx_buf_len = xsk_pool_get_rx_frame_size(ring->xsk_pool);
> +               err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
> +                                        ring->queue_index,
> +                                        ring->q_vector->napi.napi_id,
> +                                        ring->rx_buf_len);
> +               if (err)
> +                       return err;
>                 err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
>                                                  MEM_TYPE_XSK_BUFF_POOL,
>                                                  NULL);
> --
> 2.34.1
>
>

