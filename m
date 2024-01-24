Return-Path: <bpf+bounces-20200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E09BA83A402
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 09:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9F91F22CCC
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 08:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA061175AC;
	Wed, 24 Jan 2024 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUQ70xiG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91F12E63;
	Wed, 24 Jan 2024 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084441; cv=none; b=Y6j4jfUbjpPWAc0ztZG7lrT1NY02F11uNcoxkN504Kgm2y4hOznlqz8ozbwXVdCu53bF07fOUtET5Yak0dG2HNLs5Sq45Tkm8qYBBLIaS2WQ+fhgZRNIB8fGuEyhzcFSveabvdUrpCyik7u3+jG14VdFp9gp0ukF7sbyTUTh448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084441; c=relaxed/simple;
	bh=qRLbMvbeLhh8vf90PYBWWGQ0nf39VJNKUe323XDk3PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfUioeIzW0DrwD+mlxH0by/VK0WvOld3hnZ8v0ma1JxrzTGyPPxjXJBrVuHLYvETKUFxzRfRJ9jRn94/4MQqS88Fl4qinfegmgvOMvDm7DTOwjf3FAxzhyiIW36b7r9/SMqcA/wRXAtmZ0b5ucDevvEwRgqhbua0KnO3qsaU82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUQ70xiG; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-466efea9c10so427413137.1;
        Wed, 24 Jan 2024 00:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706084438; x=1706689238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DGilVobqlxg2nBrRelp49YAwWjGpbZmg4o5NPf2paFo=;
        b=nUQ70xiGj+mfPF33so+lLxVHG4lveii2pNHlBhlLouwf3TYHIre1ac6CjwCvjCxid4
         8mcCZMqMNKcUy9eMyPnj6YjDuWRX5V59Qz+IaMOpU1a2TBP6C3XW+Q1oXrLh/ArLgBRL
         k/qRd4g5SEJIsiTd+xu+Hbu+XY8JbIMkZkS3Sw88xbg+KMWphRH2xiceZEUpZwId5pN6
         jGIll2mHmOSLJBSe8sWnEedN9KwaWJsvjmGAEYSn/BJ6O4/95siJENXxzD+1wyeBPrQS
         jL6dUINGJ7g4wKxM7fRDl/1M85LDSI6O/wm0GvOqr8P1YuKGcUMRgCqbJXD1sSM2dzdj
         sdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706084438; x=1706689238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGilVobqlxg2nBrRelp49YAwWjGpbZmg4o5NPf2paFo=;
        b=j7GLFYicsknopkZV5DGwzp4yJ0iYopBBoiFc0aWVnMPE9raVV12haY82VAHDb+GvaJ
         hhP89QKHWx7Kx6kZujsX50kB/CoDm4b0S7oHvjgWYSKFpZRAdNz3J0DCwBT2SqGaRzcN
         Pd2myftM9gMnNENad+oyaZFFS1pe+qjP0A+sg8spxIoyiideU8yQowFFPXfLzXv8aB45
         C2j5qlcRzwK6ICacZUoML2zzIBLQlAcbDDvZ74yLNg1yCSulqjjFVnrc/7wzNqiDEfFp
         SH+ofDc4/86kK+jKOV5fluQxd1gpRj1BFlTz1xf5zqjKAgX/yaYm29UnzULlk0vx6Ejr
         /LKA==
X-Gm-Message-State: AOJu0YzChZItpS/4Z4KiIkuj9IiebyfH88OuFTDIJyCrSEbmHUyNKiZ7
	8gENRsUAmv7WWM+5fNGa4SfemY19buv5X8SAIcZJ1JMGGTecHFcOR91Hr2ttlXIpeRMVSnvdLfi
	c8QfvHZGXnC0iHOU+/mY6FApIWCA=
X-Google-Smtp-Source: AGHT+IEj23ogNF8aCFbWmRwaIp3+EYPhaxLwrfmkpU6zMs7WGaNaMrLqP5WYtLMt2BCshBwKebfiuDD4+ugd+LtzLxY=
X-Received: by 2002:a05:6122:3190:b0:4b7:3417:b5a4 with SMTP id
 ch16-20020a056122319000b004b73417b5a4mr1359565vkb.1.1706084438254; Wed, 24
 Jan 2024 00:20:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com> <20240122221610.556746-3-maciej.fijalkowski@intel.com>
In-Reply-To: <20240122221610.556746-3-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 24 Jan 2024 09:20:26 +0100
Message-ID: <CAJ8uoz2W6nqJ=vk6+RR7zEohkv7CTBO+2KsAQAfgp=gf_5-ycA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf 02/11] xsk: make xsk_buff_pool responsible for
 clearing xdp_buff::flags
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org, 
	martin.lau@linux.dev, tirthendu.sarkar@intel.com, john.fastabend@gmail.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 23:16, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> XDP multi-buffer support introduced XDP_FLAGS_HAS_FRAGS flag that is
> used by drivers to notify data path whether xdp_buff contains fragments
> or not. Data path looks up mentioned flag on first buffer that occupies
> the linear part of xdp_buff, so drivers only modify it there. This is
> sufficient for SKB and XDP_DRV modes as usually xdp_buff is allocated on
> stack or it resides within struct representing driver's queue and
> fragments are carried via skb_frag_t structs. IOW, we are dealing with
> only one xdp_buff.
>
> ZC mode though relies on list of xdp_buff structs that is carried via
> xsk_buff_pool::xskb_list, so ZC data path has to make sure that
> fragments do *not* have XDP_FLAGS_HAS_FRAGS set. Otherwise,
> xsk_buff_free() could misbehave if it would be executed against xdp_buff
> that carries a frag with XDP_FLAGS_HAS_FRAGS flag set. Such scenario can
> take place when within supplied XDP program bpf_xdp_adjust_tail() is
> used with negative offset that would in turn release the tail fragment
> from multi-buffer frame.
>
> Calling xsk_buff_free() on tail fragment with XDP_FLAGS_HAS_FRAGS would
> result in releasing all the nodes from xskb_list that were produced by
> driver before XDP program execution, which is not what is intended -
> only tail fragment should be deleted from xskb_list and then it should
> be put onto xsk_buff_pool::free_list. Such multi-buffer frame will never
> make it up to user space, so from AF_XDP application POV there would be
> no traffic running, however due to free_list getting constantly new
> nodes, driver will be able to feed HW Rx queue with recycled buffers.
> Bottom line is that instead of traffic being redirected to user space,
> it would be continuously dropped.
>
> To fix this, let us clear the mentioned flag on xsk_buff_pool side at
> allocation time, which is what should have been done right from the
> start of XSK multi-buffer support.
>
> Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 1 -
>  drivers/net/ethernet/intel/ice/ice_xsk.c   | 1 -
>  net/xdp/xsk_buff_pool.c                    | 3 +++
>  3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index e99fa854d17f..fede0bb3e047 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -499,7 +499,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>                 xdp_res = i40e_run_xdp_zc(rx_ring, first, xdp_prog);
>                 i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
>                                           &rx_bytes, xdp_res, &failure);
> -               first->flags = 0;
>                 next_to_clean = next_to_process;
>                 if (failure)
>                         break;
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 5d1ae8e4058a..d9073a618ad6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -895,7 +895,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
>
>                 if (!first) {
>                         first = xdp;
> -                       xdp_buff_clear_frags_flag(first);
>                 } else if (ice_add_xsk_frag(rx_ring, first, xdp, size)) {
>                         break;
>                 }
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 28711cc44ced..dc5659da6728 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -555,6 +555,7 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
>
>         xskb->xdp.data = xskb->xdp.data_hard_start + XDP_PACKET_HEADROOM;
>         xskb->xdp.data_meta = xskb->xdp.data;
> +       xskb->xdp.flags = 0;
>
>         if (pool->dma_need_sync) {
>                 dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
> @@ -601,6 +602,7 @@ static u32 xp_alloc_new_from_fq(struct xsk_buff_pool *pool, struct xdp_buff **xd
>                 }
>
>                 *xdp = &xskb->xdp;
> +               xskb->xdp.flags = 0;

Thanks for catching this. I am thinking we should have an if-statement
here and only do this when multi-buffer is enabled. The reason that we
have two different paths for aligned mode and unaligned mode here is
that we do not have to touch the xdp_buff at all at allocation time in
aligned mode, which provides a nice speed-up. So let us only do this
when necessary. What do you think? Same goes for the line in
xp_alloc_reused().

>                 xdp++;
>         }
>
> @@ -621,6 +623,7 @@ static u32 xp_alloc_reused(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u3
>                 list_del_init(&xskb->free_list_node);
>
>                 *xdp = &xskb->xdp;
> +               xskb->xdp.flags = 0;
>                 xdp++;
>         }
>         pool->free_list_cnt -= nb_entries;
> --
> 2.34.1
>
>

