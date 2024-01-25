Return-Path: <bpf+bounces-20309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E6E83BB25
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 09:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FCD1F2707C
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632481758E;
	Thu, 25 Jan 2024 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOfY2pXE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279F18EA1;
	Thu, 25 Jan 2024 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169633; cv=none; b=CZRuxOdrRSM3pDlSDY4VuypqwVZzgP8oJsCV2KSmuIbTrgjJadRfnIU6ax/AB2wYZCCKVLX8FiluShi//eId2LH6GDd6jca04qGi6/RfRU+DJmKEqQh6lfLmIlN2zC2ptUgrS7VG4kWAB7t0Amg+/mp1PuDuInl2U9ev19u2NRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169633; c=relaxed/simple;
	bh=Rw/CV6hnBTs6QlahCT/GlBU3pjLy0gvfjwid+kDuu2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dA03yrQ2Y6TqM06KIv2R5tEoWALxjO2Ki78Mxzn7nj39MCIfieA8m0b2LBUCaSsBdjUmX+NEZ8Py16vAXfdqRasFhAs1ytXIwEsLNt8nG0nkhiMNrOLTB3N9uQ+ct1pYjOS1avbnp7JNgHXryHus7vQT3t+P3byV0oPtxHe5nf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOfY2pXE; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-681928235d6so1990136d6.0;
        Thu, 25 Jan 2024 00:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706169630; x=1706774430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qKioZPq8Ys4mwzQb62lQj1glFylF4RuCOvnhfRyw0QI=;
        b=EOfY2pXEEG7G99tnyJ+DKWzoL+KLarafwQGqDpeROTSFVyRU283Y4618dN62DMZTWp
         ZSenT1VfBzj6V5r9RjAY/UhfoyUxYuBFR8iABuRlhVHgQ464cu+1uLj5B5rdzzixk4/Q
         HkQXigfmhF1Ig0nYKiP5GmOUj9bK6Z5ewt3AI8TWgv+31ku2EIOv7flXvV2GzXaTDzno
         NRingSBsnNyP3gZDQD5rn+G9GBjEboYplK53oEbOkt2SPUP9BppFnMk33mumidtdHVcG
         1GbxttWI+8AGDtQbBQR8iqOTi1aXkPFMhR65+0jKuCXwET8PVAJTBtocBk1w2lWADZjJ
         pasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169630; x=1706774430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKioZPq8Ys4mwzQb62lQj1glFylF4RuCOvnhfRyw0QI=;
        b=UBtcqC1cxsLfu8rMI8XLt3Qj//YFGUqoIui1gkpTTJfPl8HXjXaEK9vpaHrHexVqzb
         Gfo3QmFlKVKs2BGXuV83nuZlzU92RFro8hsXOCQnIzcz4J5Vg4eBCCgGSv5PVwrGq36W
         2z/vRYvkYv/mgDMI8LV3Lz71n/pI2+p+wiEHay3rRWa3hyw9Cm5QSsdD9J0HWWdl4t+y
         ggOASPP2iFTtLC8PfgBqmniev90sjsdnPHJ7FKKDacfmKPGxv604WKV8scOMuQTOEZqy
         ex/crKwFHoCfgpu8dhT5jsQ6RQG4w2TZihRxhQbS0Mhk/u90T/ib+q3CjqPOpUwHspfm
         rBVQ==
X-Gm-Message-State: AOJu0Yxl3SsMwQGx1NCao6ifRts6ByK7pOf3pgMx3WJYUE6Q7/+K39po
	kHzA0szkDwodMTML+yiGmHnLpZRA9u2z/yYQe1KCyuFyvHFYcI2F9k0nAXX9ZZPvfJx8K/H7dT5
	fIlHmMTfY4TyMiWSjzKPHJaPcKWM=
X-Google-Smtp-Source: AGHT+IEWx7CLxkV3M4IExWfi8elk94uDdw95SpRtOcn5E3BIBTO/5Wjff9+hfEFXkl8gfw11DNWXE9nS+yzVYvCjsQM=
X-Received: by 2002:a05:6214:d64:b0:686:acfe:bbc2 with SMTP id
 4-20020a0562140d6400b00686acfebbc2mr1004983qvs.4.1706169630050; Thu, 25 Jan
 2024 00:00:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124191602.566724-1-maciej.fijalkowski@intel.com> <20240124191602.566724-3-maciej.fijalkowski@intel.com>
In-Reply-To: <20240124191602.566724-3-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 25 Jan 2024 09:00:18 +0100
Message-ID: <CAJ8uoz062-xNhy4xQB-vz7OKL+Gk7Ey_Gii2ADGK23isTzMhCg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf 02/11] xsk: make xsk_buff_pool responsible for
 clearing xdp_buff::flags
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, echaudro@redhat.com, lorenzo@kernel.org, 
	martin.lau@linux.dev, tirthendu.sarkar@intel.com, john.fastabend@gmail.com, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 20:17, Maciej Fijalkowski
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
> To fix this, let us clear the mentioned flag on xsk_buff_pool side
> during xdp_buff initialization, which is what should have been done
> right from the start of XSK multi-buffer support.

Thanks!

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 1 -
>  drivers/net/ethernet/intel/ice/ice_xsk.c   | 1 -
>  include/net/xdp_sock_drv.h                 | 1 +
>  net/xdp/xsk_buff_pool.c                    | 1 +
>  4 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index af7d5fa6cdc1..82aca0d16a3e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -498,7 +498,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
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
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 526c1e7f505e..9819e2af0378 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -164,6 +164,7 @@ static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
>         xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
>         xdp->data_meta = xdp->data;
>         xdp->data_end = xdp->data + size;
> +       xdp->flags = 0;
>  }
>
>  static inline dma_addr_t xsk_buff_raw_get_dma(struct xsk_buff_pool *pool,
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 28711cc44ced..ce60ecd48a4d 100644
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
> --
> 2.34.1
>
>

