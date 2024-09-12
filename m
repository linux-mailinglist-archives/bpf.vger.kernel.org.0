Return-Path: <bpf+bounces-39712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DF3976726
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 13:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D59A1F210F4
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225041A08C4;
	Thu, 12 Sep 2024 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izIfune2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8418BBBD;
	Thu, 12 Sep 2024 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139071; cv=none; b=t41kE2U5Lb1Bg+iZsMEwxzP4PSj2XpKJVU47vsLqJQGB6tXHZQB478dVtOH9K/OorH35Dk/uk07ehdfwaT9uNHdAjCo3GZbWubm/5e1nNZAag9bGZ9y1GY5i+jrDUMbms2tjXfSAlol64Ls8/7Yq5OOaNib4Y67WVNQLwpUpVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139071; c=relaxed/simple;
	bh=dah/t4pBaon0ZrPwTPNOlEGI+mng6bDX8DQZUHIMK3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EylwWXuDshS5mZyNh8ns2RtCPobqCSsuoaqaTkmd7YHbQWhGeCFYMYJcPEgYMWc2p6Y0LxDHSnfRbw/k0T39yY5LiAQUs/tCLfdlrtu8jIaa33OGtz9vhbvnGlkcdMI50e8UDs9w3NU6jVCuh64eH+YRzmthYQ3elV477o3pjq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izIfune2; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c353f2f954so6177386d6.3;
        Thu, 12 Sep 2024 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726139069; x=1726743869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x5Q3ipe6iraRB2cXHJCx3k9HqMaTXiX/VIcnXuYFAHM=;
        b=izIfune2WE+VhmhxaLu8XtI0iIifm1Zr82IdYvCl539QksH6YuqC4VmevU3UFlwkEe
         AG4vfgkJ9CYDsnw+gNkcaKSSz43pmei49kG4dmIyiCdQmSsDgjSV3P5REFhUnzOi+3cs
         Unntnp9RVubm8gtHSLnBDFx4QqbHltmvm4skFGhIoxpAvrs4tQB36rii63wDclj8fnSn
         Y1I1elxquBHOYIm6rCJIEVf/e4yAuZeL2Vx8rSTbiOv+gMD+e0/0P8eNskWfKI9+42On
         PzkqS0E3+8KMUxRD1DgXImD/Cf38lMEntKCbm7ukVrzEjadZYtLVjHqra+zV2Uz5oCwx
         Xe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726139069; x=1726743869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5Q3ipe6iraRB2cXHJCx3k9HqMaTXiX/VIcnXuYFAHM=;
        b=cLUDvatcl5lTkIMDO28JPST27EpGAQ3VST+V/FudezN6wcq+f04CKUSOjsjre91PkF
         Cs3XOY1TFBvPD/tWr1Vp3HObPOkuTov8alt+Rzx23clEGUo7kXRdEhPgf58axjTTYp6U
         NW2GoTr65aAgQdVS5IwkWhlY4Y2+RT4/YHzEb2GJhStrfgROSsQi3lK7tON/WQKO36va
         BAVtKIDE89hdn93e9Tr3zERZlyvXgXZ90ksO3e3YoVXVIeVA4XmwNANZu8/W9KJZHjoR
         wO2EscCvEXssJui2BN9hq9ZrqgobzyT+aifFthvC9jmXEqHLC+HPPJ1RkwJLsfwNBY0W
         Bk9w==
X-Forwarded-Encrypted: i=1; AJvYcCUTncXMoJSSWhKR3qZj/tzmYQCRCvwkO1wobz7RkRwrDyWaaGlazcutLiwehmHEyV8mq4/D9GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGhfuyxsqrumZcsxJj4yRi7M5DVqfgrdkffOvpE7ODTRSgCd8
	K34QxyUEdIGMbjOkNXkn3Z3IWOQ/LLnzCysgLzoRgvCIf8cl+UpqU6GCeTZZ0BGp2MrzqkZ902t
	4RXShqyGLrUv37vobPFuWZ30gzNqmraTnGSY=
X-Google-Smtp-Source: AGHT+IFWJQHE9ZDHEOlrcZGgiEsKN9SiJLa/euV5Y9zDdTVTjAGC14kH+VE61M+9u7wMIYSasMm6u76PuGR+hPKyZHQ=
X-Received: by 2002:a05:6214:5c05:b0:6c3:61bd:a10 with SMTP id
 6a1803df08f44-6c5735584efmr36590096d6.16.1726139068983; Thu, 12 Sep 2024
 04:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911191019.296480-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20240911191019.296480-1-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 12 Sep 2024 13:04:17 +0200
Message-ID: <CAJ8uoz2yjB7nj495x3CuiwHfuU+T0g3MXy4DScG2iT6gtkQsqg@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: fix batch alloc API on non-coherent systems
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, Dries De Winter <ddewinter@synamedia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Sept 2024 at 21:10, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> In cases when synchronizing DMA operations is necessary,
> xsk_buff_alloc_batch() returns a single buffer instead of the requested
> count. This puts the pressure on drivers that use batch API as they have
> to check for this corner case on their side and take care of allocations
> by themselves, which feels counter productive. Let us improve the core
> by looping over xp_alloc() @max times when slow path needs to be taken.
>
> Another issue with current interface, as spotted and fixed by Dries, was
> that when driver called xsk_buff_alloc_batch() with @max == 0, for slow
> path case it still allocated and returned a single buffer, which should
> not happen. By introducing the logic from first paragraph we kill two
> birds with one stone and address this problem as well.

Thanks Maciej and Dries for finding and fixing this.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Fixes: 47e4075df300 ("xsk: Batched buffer allocation for the pool")
> Reported-and-tested-by: Dries De Winter <ddewinter@synamedia.com>
> Co-developed-by: Dries De Winter <ddewinter@synamedia.com>
> Signed-off-by: Dries De Winter <ddewinter@synamedia.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  net/xdp/xsk_buff_pool.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 29afa880ffa0..5e2e03042ef3 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -623,20 +623,31 @@ static u32 xp_alloc_reused(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u3
>         return nb_entries;
>  }
>
> -u32 xp_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max)
> +static u32 xp_alloc_slow(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
> +                        u32 max)
>  {
> -       u32 nb_entries1 = 0, nb_entries2;
> +       int i;
>
> -       if (unlikely(pool->dev && dma_dev_need_sync(pool->dev))) {
> +       for (i = 0; i < max; i++) {
>                 struct xdp_buff *buff;
>
> -               /* Slow path */
>                 buff = xp_alloc(pool);
> -               if (buff)
> -                       *xdp = buff;
> -               return !!buff;
> +               if (unlikely(!buff))
> +                       return i;
> +               *xdp = buff;
> +               xdp++;
>         }
>
> +       return max;
> +}
> +
> +u32 xp_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max)
> +{
> +       u32 nb_entries1 = 0, nb_entries2;
> +
> +       if (unlikely(pool->dev && dma_dev_need_sync(pool->dev)))
> +               return xp_alloc_slow(pool, xdp, max);
> +
>         if (unlikely(pool->free_list_cnt)) {
>                 nb_entries1 = xp_alloc_reused(pool, xdp, max);
>                 if (nb_entries1 == max)
> --
> 2.34.1
>
>

