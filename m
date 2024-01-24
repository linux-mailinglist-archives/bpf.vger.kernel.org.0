Return-Path: <bpf+bounces-20204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AFC83A46C
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 09:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2EF1F214B0
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 08:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A471798E;
	Wed, 24 Jan 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwOQnVlK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5417BA0;
	Wed, 24 Jan 2024 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085857; cv=none; b=by8ZVKnhsMXTyc4TQLCff67ij6ZG+MbCmgXZj9RuoxvHO2dV+imiNSFFidTBj9/obVBjfKaxWo4ScjAqLwktMS/vntM9TGWStwLRJykGxY7FyvQyK1x2L85rlfS33L/A/H5Rncu2ohWYMEdNCsAZmC4PsHuwv1/8lCOldc/jSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085857; c=relaxed/simple;
	bh=zH/AGCd11EfZpyAouNbCSueLtkDNfOdj/1He100tYg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5I6Rt5ISZ9vFKda42arrocg0w+CicEC2KXyWkRh7MdCxXsofGwNdZM6GRxmx5CW1q0S4KF5CGto6T/DLvPOhDpNXltgVQcJqkNE5IdzqMpixqBR7BFydnJOOUqb1aDL+OnubvJ1qIqT1fF3OhTcL7E7YzHfwezUxbA46NC6vBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwOQnVlK; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783a83eea1fso23911185a.0;
        Wed, 24 Jan 2024 00:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706085855; x=1706690655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U7LcsGgcDNSXoHjkA7fsQw9C0HTeJSG/rQEJKB5bdTI=;
        b=GwOQnVlKdFES+fZhbhXh5pEqRRcg7AOXu2hONEjTzdabu718JI+nEtkI/b8GmWaCtO
         plZRaXcXR/xosR+IXfhG7m6nHMcQdculPTKs0VcXYRxO4n9sAi3G+UgO/wQlgUvG7xwf
         5Nvol/S6FuZYVw0hr/1WFHqe+4sqncdxmqHuc3/sl1DLyqq9rk84rs+p+oHCVMhnBu58
         VWyID5lSR8zKincm9rHZVo0fpIxi2L7ceUDFavkCdsagVU3DCgNcWHx1BD6WJWh/DF0m
         mzhpHkEOqfoIYrFhvK3xhqz3Wk6hcLjGP1masDGOFunNf4SXkj0e0LWzsoL+BB2o0Tiw
         T35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706085855; x=1706690655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7LcsGgcDNSXoHjkA7fsQw9C0HTeJSG/rQEJKB5bdTI=;
        b=kANUZWpDidVLrmi94XjavxiuXsC1gxOs9GeQS3ZzbSC+flKhlehBREYOTR3iuQrInO
         EQCoTWEJmWgi/ck8FJM7/r2gkaoRtbx85qJPUlsJU3rUHXl74xQW14KHVhmHNDVI7A5L
         BpK5G13r6G3ZucXvF7nMlB29j9OcVoyCKh2pjUeiYxlt4MarQ9XBj1qydVvNngoPo2yQ
         9urc+aVq1BN5fe/mCCKyImOuR762iO6qcQvofTEireLOtIRnOiU4nyxapNJro+yg257B
         iVsZgAD5Lyv8bo3CV2PgOFUKEm+KmzSwgb5GY/RO+Mw1tRVlQbBUrz62MXEFgXKFo1lK
         FGZw==
X-Gm-Message-State: AOJu0Yzdyb4BlAecck6nO6W+1wdoHgAHUdmdmDoK9VQHcfex0OL2PTt3
	npsdy9Yg9doaC926KOi29fvhBoliSeAenng7edGGPrkSLcHd0FBqqjsbbxS8mDzZP1N5qY8PSN1
	TQO3vsQZ4j5DesR16nD3I03p4acc=
X-Google-Smtp-Source: AGHT+IF95YiJYnqfMj0XtNWJo/z7IFh8AzM05tDP4k4NM93+GcFgNre+eLYUj4FA6UYSVeO8ElxEI/EbUzd6BvmMp3Y=
X-Received: by 2002:ad4:5b8f:0:b0:686:abed:73f7 with SMTP id
 15-20020ad45b8f000000b00686abed73f7mr2078017qvp.4.1706085854861; Wed, 24 Jan
 2024 00:44:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com> <20240122221610.556746-8-maciej.fijalkowski@intel.com>
In-Reply-To: <20240122221610.556746-8-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 24 Jan 2024 09:44:03 +0100
Message-ID: <CAJ8uoz2d-ybdO5P54jmjVgfzH-qODuSAPcToFGqJ+fQo4Sc5JQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf 07/11] intel: xsk: initialize skb_frag_t::bv_offset
 in ZC drivers
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
> Ice and i40e ZC drivers currently set offset of a frag within
> skb_shared_info to 0, wchih is incorrect. xdp_buffs that come from

Is "wchih" Polish? Just kidding with you ;-)!

> xsk_buff_pool always have 256 bytes of a headroom, so they need to be
> taken into account to retrieve xdp_buff::data via skb_frag_address().
> Otherwise, bpf_xdp_frags_increase_tail() would be starting its job from
> xdp_buff::data_hard_start which would result in overwriting existing
> payload.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 3 ++-
>  drivers/net/ethernet/intel/ice/ice_xsk.c   | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index fede0bb3e047..65f38a57b3df 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -414,7 +414,8 @@ i40e_add_xsk_frag(struct i40e_ring *rx_ring, struct xdp_buff *first,
>         }
>
>         __skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++,
> -                                  virt_to_page(xdp->data_hard_start), 0, size);
> +                                  virt_to_page(xdp->data_hard_start),
> +                                  XDP_PACKET_HEADROOM, size);
>         sinfo->xdp_frags_size += size;
>         xsk_buff_add_frag(xdp);
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index d9073a618ad6..8b81a1677045 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -825,7 +825,8 @@ ice_add_xsk_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *first,
>         }
>
>         __skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++,
> -                                  virt_to_page(xdp->data_hard_start), 0, size);
> +                                  virt_to_page(xdp->data_hard_start),
> +                                  XDP_PACKET_HEADROOM, size);
>         sinfo->xdp_frags_size += size;
>         xsk_buff_add_frag(xdp);
>
> --
> 2.34.1
>
>

