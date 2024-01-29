Return-Path: <bpf+bounces-20571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FA8840540
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7203B21A1E
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 12:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4724D612FC;
	Mon, 29 Jan 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eB9SiH5l"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54A612C1
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532312; cv=none; b=eLxBO28VS+z9qKxXGZOEoHoCSe+QsujfyiZKm0fuTtwHkXLblZ0pHGedVEJoZc0BlC+yEADVyxl5ycDi1tvPT515nUzx8SFJjp9o8U0MOXEDQXrMpWZsucT450YPCbG4rznitWw2haPUKsZCzVNipgILS6Pg0SbFmUudHb6rcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532312; c=relaxed/simple;
	bh=xt7U0pXOWeoRr1tS+yqHOjKUB1zGPQaEq9j9juQ83wg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a7iiLJaLTuX6b7Vc3wSPiUGkQ+dMkzPvX90vBeJ7hyV6dTreU4OhWMoP0lf9M7fp/ugR434mSqrKn08ZM4b48PTb7eSG/UZa4btO0s/cNRL1z6S822xoRjcqg9fBt7L79GYVpjTib2bTjqqOF5HsRDnUBwGc++q+BP1CFAU6JY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eB9SiH5l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706532310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zOHq5R6RS4aXuEAbxphuLTS1ANe6B3awYdbO/5rbdCc=;
	b=eB9SiH5lwjGbOgCvjvUoTtU4rn1uSj1Bdcd3WpI7IuT5jRqi/CgNA55ZAhksZOyc+IWVNJ
	OfsZHq777mjJ2QQR2ohbut0s7Baxqsd7Vvx8KmMuLRlo4vEShVToxcE8dt6oA0DMzc4oKS
	xiaUc8jH3kh/oLfxCiqrYufZ1G/6fEQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-bVPQXiTSMw61qtJqnbCphg-1; Mon, 29 Jan 2024 07:45:09 -0500
X-MC-Unique: bVPQXiTSMw61qtJqnbCphg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5101b9343easo1711509e87.3
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 04:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706532307; x=1707137107;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOHq5R6RS4aXuEAbxphuLTS1ANe6B3awYdbO/5rbdCc=;
        b=V9kkaUH94VlObrVOcOgIwd/GBG4H/bpt9Yc3pOWSxI0xezo1aZcLuOjsyJvgz1l0zf
         J+jf+IMsMu2eUmUiFSpATeOAKCCmlWOdVREVIMWuMsswhedF/XvoS72VcopUNigqbvsd
         brnzL9G233C4UifW0H91M+hDrZF7N3PM+BYAg8JO9TU2VOF0DEHjAzdoMDrL8JJJyqtI
         WN1wb2d49lpxTVEVM624USp69SDM53SJtlD2Dm2RyTA3ob7HkTNHnj6IfjuvYmbnItBg
         cjtprXw/4Eq2sIhp0qEaZwV87294Gqu53cSYdvo8rNCId5vmmwF8fj8SONXx9y0ZM7jD
         hOKA==
X-Gm-Message-State: AOJu0YyI1dQkKEUJ76AxDMLZQWDWKMwMVEl5q9RZpqKgimBmTekSZycx
	5QZiAXlb/Dq+vYCO2yhbBgPAcXpd/LmPCB7hnjNxp1ItvTTPT3oNZUoLw1D41gpTJQKOV40Z/XI
	nLiRN3FeR4c4zALSkMqL3ig6Wc4RB/ie8KhEA/4YhdqYNY+A1Iw==
X-Received: by 2002:ac2:5b9a:0:b0:50e:6878:a70b with SMTP id o26-20020ac25b9a000000b0050e6878a70bmr3644047lfn.54.1706532307601;
        Mon, 29 Jan 2024 04:45:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlRyML/Bn6KOOjb+UGIG8m2q4PMeg13vqJyOVWC4pRq2gvGLPhWpCR7POZDHx5VHoKK6YK0w==
X-Received: by 2002:ac2:5b9a:0:b0:50e:6878:a70b with SMTP id o26-20020ac25b9a000000b0050e6878a70bmr3644037lfn.54.1706532307273;
        Mon, 29 Jan 2024 04:45:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id cf12-20020a170906b2cc00b00a2c467ec72bsm3905386ejb.60.2024.01.29.04.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:45:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 70771108A01A; Mon, 29 Jan 2024 13:45:06 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 1/5] net: add generic per-cpu page_pool
 allocator
In-Reply-To: <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
References: <cover.1706451150.git.lorenzo@kernel.org>
 <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 29 Jan 2024 13:45:06 +0100
Message-ID: <87jzns1f71.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Introduce generic percpu page_pools allocator.
> Moreover add page_pool_create_percpu() and cpuid filed in page_pool struct
> in order to recycle the page in the page_pool "hot" cache if
> napi_pp_put_page() is running on the same cpu.
> This is a preliminary patch to add xdp multi-buff support for xdp running
> in generic mode.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/page_pool/types.h |  3 +++
>  net/core/dev.c                | 40 +++++++++++++++++++++++++++++++++++
>  net/core/page_pool.c          | 23 ++++++++++++++++----
>  net/core/skbuff.c             |  5 +++--
>  4 files changed, 65 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 76481c465375..3828396ae60c 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -128,6 +128,7 @@ struct page_pool_stats {
>  struct page_pool {
>  	struct page_pool_params_fast p;
>  
> +	int cpuid;
>  	bool has_init_callback;
>  
>  	long frag_users;
> @@ -203,6 +204,8 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
>  struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
>  				  unsigned int size, gfp_t gfp);
>  struct page_pool *page_pool_create(const struct page_pool_params *params);
> +struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
> +					  int cpuid);
>  
>  struct xdp_mem_info;
>  
> diff --git a/net/core/dev.c b/net/core/dev.c
> index cb2dab0feee0..bf9ec740b09a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -153,6 +153,8 @@
>  #include <linux/prandom.h>
>  #include <linux/once_lite.h>
>  #include <net/netdev_rx_queue.h>
> +#include <net/page_pool/types.h>
> +#include <net/page_pool/helpers.h>
>  
>  #include "dev.h"
>  #include "net-sysfs.h"
> @@ -442,6 +444,8 @@ static RAW_NOTIFIER_HEAD(netdev_chain);
>  DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
>  EXPORT_PER_CPU_SYMBOL(softnet_data);
>  
> +DEFINE_PER_CPU_ALIGNED(struct page_pool *, page_pool);

I think we should come up with a better name than just "page_pool" for
this global var. In the code below it looks like it's a local variable
that's being referenced. Maybe "global_page_pool" or "system_page_pool"
or something along those lines?

-Toke


