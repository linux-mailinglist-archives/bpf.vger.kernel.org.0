Return-Path: <bpf+bounces-20203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C7883A449
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 09:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62581F285EC
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B67817981;
	Wed, 24 Jan 2024 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B29uDAhA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDF179AE;
	Wed, 24 Jan 2024 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085563; cv=none; b=d3VnS+zh2SgNXzasmIwBIVuceABlg+HZj5vKLBWhi03NIltP8LJUbVc84WkH45O5Irq6teUgXnFW8Sa8e6QLu00/1on0QQydTYoqWvujo7LEYn4GPlzL8yFhVh+KLkPtUiS8lTDcQ4NcPz1RorZAnXz8ExKRsSkLY8hayxEH/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085563; c=relaxed/simple;
	bh=TheIARDPadS0e85KWthgYObgOqesHRSvFYgSVSnZgrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apzK0hpu+yyuvq1goK5Iz8dP1pcNtCVJIOf3qhNvU49xRTfzJeiI876Kf+yRnax8nkQ4VofQsKQqLsWJzquyReyaSXAcUfa137C3Xp6ynyA8l0i827BRGE+xnywBOOrrNtxS2rWeXxy3LdJqBIaruzw4ld118WAL/balD3oaMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B29uDAhA; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7cc2ffdda1cso645318241.1;
        Wed, 24 Jan 2024 00:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706085561; x=1706690361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FM/6+HnOh9Ox+KFrd26pJiFhqooyZe0HWDgKtNXA88M=;
        b=B29uDAhAQGwGhGRPIReLPMw+5sQvILsronFEk+vx7Fvolnf8dz8VKIw44b4zvUtGjb
         8PYRugMXHcNKGFGBcuT88fKh9b7RxbiQyvwDLcFtOqjd0ZPmo8YTt/4xLQzcgZCJtNmq
         /gfTXzvuBylVYeur653mhtZLHhHvoue9JdDQqGOP4Obhy9lsuBerDaxkoLOhroXAh+sU
         zwbRBDfEwsvNU25NnZ7j4kbSJx5KYu8AM7OKoelnBBRr8SogScjGNnMwtURKufKkZdur
         JBGEavU1feG3PrIZlcf5i5T88W8o9LgbkSzzvDU4wkBbiSjf/Hp2QpZy6ZvlyUcIIfgF
         Zeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706085561; x=1706690361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FM/6+HnOh9Ox+KFrd26pJiFhqooyZe0HWDgKtNXA88M=;
        b=YnBpo3NHp8uAljZioDHYrpaWBI8rHK1nY9EG7W/uFAKtri4BneqtLUqSNgTWQGjZxr
         oKMGSmpEJ2p6OxokCVOlRkzIF8ZLKTz3IS/HTG7x3odOSskUAlbpBfBFMZhasM/UdaYv
         4d+FclQmkbqDqlhXrET00WG8JAnjXegT+o4LVfeV+aMr6qhzDF6N1iVbtgLMy8XEjQkJ
         9A5Nv+gSGtyZyvOQK1XsdOw5oKE1MVyGhekzzFKwnnt/6LH0gvd2rDxkAATSHm42r4l6
         1Qz5s79eYklVQ+3iD9FScmptcMCzpvtFlUJtOJ0sgFmrV2fcyTdDut0EWuE+u2vwHpWJ
         t5Dg==
X-Gm-Message-State: AOJu0Ywonzf/48k7mfuF0gMknLJJFodAJqFyfBWKnK0KuwU15wYHMLI6
	foHZy40LCmvsDLwnFnytIhDeqGP2GRNm79y+wvm5QsLwvcYCCXj6Q1JBf4+obw8hUkAs4Kl1I5/
	aIwdQoSwhacLNh1VJDdBhRrU0oy0=
X-Google-Smtp-Source: AGHT+IHl23JgLlwsxANNSm7qAYBVvFsYIvuyQGK/m0Nalp8QFIuSGYSK3QkLt9Bcic/3z212ZO3n8C4flD22j1EGL5s=
X-Received: by 2002:a05:6102:21ca:b0:469:be7b:b000 with SMTP id
 r10-20020a05610221ca00b00469be7bb000mr1343657vsg.2.1706085561284; Wed, 24 Jan
 2024 00:39:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com> <20240122221610.556746-7-maciej.fijalkowski@intel.com>
In-Reply-To: <20240122221610.556746-7-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 24 Jan 2024 09:39:10 +0100
Message-ID: <CAJ8uoz3EQfvxqQNTmq2txz9SFv97b=8drbEB=TqmbMFqSe6y8g@mail.gmail.com>
Subject: Re: [PATCH v5 bpf 06/11] ice: remove redundant xdp_rxq_info registration
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org, 
	martin.lau@linux.dev, tirthendu.sarkar@intel.com, john.fastabend@gmail.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 23:17, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> xdp_rxq_info struct can be registered by drivers via two functions -
> xdp_rxq_info_reg() and __xdp_rxq_info_reg(). The latter one allows
> drivers that support XDP multi-buffer to set up xdp_rxq_info::frag_size
> which in turn will make it possible to grow the packet via
> bpf_xdp_adjust_tail() BPF helper.
>
> Currently, ice registers xdp_rxq_info in two spots:
> 1) ice_setup_rx_ring() // via xdp_rxq_info_reg(), BUG
> 2) ice_vsi_cfg_rxq()   // via __xdp_rxq_info_reg(), OK
>
> Cited commit under fixes tag took care of setting up frag_size and
> updated registration scheme in 2) but it did not help as
> 1) is called before 2) and as shown above it uses old registration
> function. This means that 2) sees that xdp_rxq_info is already
> registered and never calls __xdp_rxq_info_reg() which leaves us with
> xdp_rxq_info::frag_size being set to 0.
>
> To fix this misbehavior, simply remove xdp_rxq_info_reg() call from
> ice_setup_rx_ring().

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 1760e81379cc..765aea630a1f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -513,11 +513,6 @@ int ice_setup_rx_ring(struct ice_rx_ring *rx_ring)
>         if (ice_is_xdp_ena_vsi(rx_ring->vsi))
>                 WRITE_ONCE(rx_ring->xdp_prog, rx_ring->vsi->xdp_prog);
>
> -       if (rx_ring->vsi->type == ICE_VSI_PF &&
> -           !xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
> -               if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
> -                                    rx_ring->q_index, rx_ring->q_vector->napi.napi_id))
> -                       goto err;
>         return 0;
>
>  err:
> --
> 2.34.1
>
>

