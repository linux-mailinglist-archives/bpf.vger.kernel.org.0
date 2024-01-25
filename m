Return-Path: <bpf+bounces-20310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 917DB83BB44
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 09:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DA628D241
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 08:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376351758E;
	Thu, 25 Jan 2024 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS9LzZeP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509AB1B7E3;
	Thu, 25 Jan 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169793; cv=none; b=jW5X6euoT6zqDVPmD38C+71skgQJxlx2wPTLSLfBeLX5eXVR8mt/FicorjQfxgktGFn/3r7IXwf+6XHLmkGOPY0Fw/GKSz1cpSgYPzdsNye8MVjbbf8WTeXPJ3KB2BCD6S1dqphMxWhTLtCPnDFnf8gUgXMhtFcB+Yms8GWHqb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169793; c=relaxed/simple;
	bh=Q+apXASFN9hAfeGyUzb9CbK0Nwnl5hmRD0eJMrpKgCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyOgonnOtJzoYDSgiXVdyNGPnl31/ceutYLKaMPHY1heSOn9x9bgtmIsBLlh0J68vQtpQJs2jksbZTAtF5EwSndfmiqpw+VgN74XYJ0I6sUcxR9PY89BH7eXhK032YxvwvbJLXd6xbqiPiOJzDu7Ip64H6+mEtQQ0H9yf55rMPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS9LzZeP; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783bd5ab16bso2179385a.1;
        Thu, 25 Jan 2024 00:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706169791; x=1706774591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T4/qnbYwOLKQwJh7Og4jBlxBc5i+e/lVSW01/xJVsmM=;
        b=fS9LzZePDQERC2lCVAACq9PQzUw7Xie2c0zzhKrDX14xpESnRJ+VxLX3yAYKJUozK/
         xWf292G3t+05rjeLR61FnWTBI9ZwieFawuakZcrc+BvNTHPs4ojEW+n1U9H874U8bEYP
         1KiCgHJAPqR3v1KO9OY/aUQyZ6xuUvARSlF9//nGNzm2wcgIKqWb5IEj3INTe52BNmt0
         lXfGT2UOSJ0Af1BQhcOqk9yceqjuIAvPHXhoncsQBPKDJHu5LrQtvm7bv408BhxPqDUs
         92t6S3ZZrsQfI76skCXjYwRyhk2gYLnCk9QdN1hWQlr7MsPB8y7qcSYop8RFjDvvF6PE
         bqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169791; x=1706774591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4/qnbYwOLKQwJh7Og4jBlxBc5i+e/lVSW01/xJVsmM=;
        b=T5cO1wgSAs8DXpqGvywK41/EgcE2V4kE2Yi9TeZbPOk2ongXz7PioC00+aKHPQTYah
         SM2eHgIZCF4eEJxke5JiS5gE8vLzvZSHmsV4kxAZ4lDfFCzIDfAjeBJ2LERuvsvC9vY5
         XwovEX2asGKcsBbE0F4QFoJiZveIMSNqbM2NGEzk/uoFXqVFNqSTxLKtJvRysllAmSCj
         YqeQlfr53NaoIm6i6RrIgRcctFKYDSPji0tO7l1aaoMf5kuRZWwnp/wCoVc8FkoCoZrB
         R6c41E7LkL91lh5y9AF11KH7l2cfcsNvfYfWoj/l1wdo8l9PfPvTE9Jk9LDAhC7tf+eN
         b+Vw==
X-Gm-Message-State: AOJu0Yxk333ATR+0R5z6X+6AzyQZsTc+h15lUiLu0SBQju6OnrujxHaN
	6PBgNaXvFDeTNUSTIF7JFLEf1Hp/JpwGOZ4bBlvGVcERhSyj2hjfAQMeRuJ8ZMj28JWPZE+JZaZ
	A7ou73COr2YBKJYNtBDlREnLe3fw=
X-Google-Smtp-Source: AGHT+IHQ04R8lQPfClb/chn2yyN0DiOmwlzEjWJ3uNy8pvLIIOmCXX2kyqb6BFLtxFDHfG8r0B7CjFlT//AEN5aZeuk=
X-Received: by 2002:a05:6214:5294:b0:686:9faf:6f10 with SMTP id
 kj20-20020a056214529400b006869faf6f10mr1139585qvb.0.1706169791014; Thu, 25
 Jan 2024 00:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124191602.566724-1-maciej.fijalkowski@intel.com> <20240124191602.566724-9-maciej.fijalkowski@intel.com>
In-Reply-To: <20240124191602.566724-9-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 25 Jan 2024 09:02:59 +0100
Message-ID: <CAJ8uoz13xSsc2tOyFv4i7=vXh_2=7t39HNeGC4dPufAbozDR6g@mail.gmail.com>
Subject: Re: [PATCH v6 bpf 08/11] ice: update xdp_rxq_info::frag_size for ZC
 enabled Rx queue
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org, 
	martin.lau@linux.dev, tirthendu.sarkar@intel.com, john.fastabend@gmail.com, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 20:27, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Now that ice driver correctly sets up frag_size in xdp_rxq_info, let us
> make it work for ZC multi-buffer as well. ice_rx_ring::rx_buf_len for ZC
> is being set via xsk_pool_get_rx_frame_size() and this needs to be
> propagated up to xdp_rxq_info.
>
> Use a bigger hammer and instead of unregistering only xdp_rxq_info's
> memory model, unregister it altogether and register it again and have
> xdp_rxq_info with correct frag_size value.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 37 ++++++++++++++---------
>  1 file changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index 533b923cae2d..7ac847718882 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -547,19 +547,27 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>         ring->rx_buf_len = ring->vsi->rx_buf_len;
>
>         if (ring->vsi->type == ICE_VSI_PF) {
> -               if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
> -                       /* coverity[check_return] */
> -                       __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
> -                                          ring->q_index,
> -                                          ring->q_vector->napi.napi_id,
> -                                          ring->vsi->rx_buf_len);
> +               if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
> +                       err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
> +                                                ring->q_index,
> +                                                ring->q_vector->napi.napi_id,
> +                                                ring->rx_buf_len);
> +                       if (err)
> +                               return err;
> +               }
>
>                 ring->xsk_pool = ice_xsk_pool(ring);
>                 if (ring->xsk_pool) {
> -                       xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
> +                       xdp_rxq_info_unreg(&ring->xdp_rxq);
>
>                         ring->rx_buf_len =
>                                 xsk_pool_get_rx_frame_size(ring->xsk_pool);
> +                       err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
> +                                                ring->q_index,
> +                                                ring->q_vector->napi.napi_id,
> +                                                ring->rx_buf_len);
> +                       if (err)
> +                               return err;
>                         err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
>                                                          MEM_TYPE_XSK_BUFF_POOL,
>                                                          NULL);
> @@ -571,13 +579,14 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>                         dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
>                                  ring->q_index);
>                 } else {
> -                       if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
> -                               /* coverity[check_return] */
> -                               __xdp_rxq_info_reg(&ring->xdp_rxq,
> -                                                  ring->netdev,
> -                                                  ring->q_index,
> -                                                  ring->q_vector->napi.napi_id,
> -                                                  ring->vsi->rx_buf_len);
> +                       if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
> +                               err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
> +                                                        ring->q_index,
> +                                                        ring->q_vector->napi.napi_id,
> +                                                        ring->rx_buf_len);
> +                               if (err)
> +                                       return err;
> +                       }
>
>                         err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
>                                                          MEM_TYPE_PAGE_SHARED,
> --
> 2.34.1
>
>

