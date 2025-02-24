Return-Path: <bpf+bounces-52339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA3AA41FB7
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 13:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A37A189509C
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 12:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F273923BD0D;
	Mon, 24 Feb 2025 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElaJ2LDS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF15E23BCF0;
	Mon, 24 Feb 2025 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401755; cv=none; b=NkCj2yc2ustfN1HJKg7kRYixISDh5EB2886DOpK8pDeE/KydDjiHXPDfrTi/igTOE75odmhqk3rVNzZFAYDFle04bUauT3wnvzGz4uzaljQWcG0yJMkJsKgHVk6+aTl2mlHMIs0jd2VM0Pu6x8o8BvVkm/LB+8oAq8ZHyaCBgqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401755; c=relaxed/simple;
	bh=/+dAyFbe/EZV9gREohszPIrB1NCJkdIU9nLWKVgW5kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+0yddQyK+W+KmIanUcXpJeqNtuhpZf3F+l3s0h1ptLKggR7S2Kdxe4bqTfaz0vXTFauV4y6t2f4UJyT12oVeGZ5lhO1O1S8Dg7B4p8+vqFlNuyJogIWjVDQeMDzXvP2O/noUNg9DCjGGv5P/50qp468h+1JBsEGRS/EqCMHLHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElaJ2LDS; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dd1962a75bso34115376d6.3;
        Mon, 24 Feb 2025 04:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740401753; x=1741006553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hlCwVJRIkzYP82V74TPg/P0Ovf6zeJdXyQovpILIffQ=;
        b=ElaJ2LDSBA4HWfxDfaWowcvczwmdA/lsrImIQ1f6vyWPcV3zqDJCwmyh05c62Scjty
         1ZGP0/ffhTUFVfghzbxSWyJaUFxJQrrbLRaO9ZZXBFHoMrGXghBl0W8HNoeeNEKNJ2OX
         zykC3Ny6t3inkZwf73P6iFKU93vB5TTPID8PfWXvCI5HW/+2CM6B8WxxROHZ1TIVbeA+
         5LeMaq9GrYlG0G8QcdBd+1L4IbwGhTBbPyAJshhsz2zsqOIUoG45xjB2MXD4YUhKaCkO
         muEQdoyOxAlqEharzj3h6h/Mjp83lOgJczmS4DXECv4QxKDTAgsaXG1F86qEH9Hn6isS
         KTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740401753; x=1741006553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlCwVJRIkzYP82V74TPg/P0Ovf6zeJdXyQovpILIffQ=;
        b=fZb7jD4VUgjgQQ+mhwIwDRZxem6GzJSnc5wBicKlKz6bwBjo9HMS3y3c8AgBahq2zi
         Ay4Gkl+UelOhauDKfKsXoLT3QgHXVweIuha2DioBsKmc+KSz0YXZaHLFohMh6zVLvXda
         rX5/EzassFaAajvdGgQUnsZGaRgmElt3fHHv2qgA9wOHQyA097TmLYMt0ef48u6Z3H1W
         m92sPnDo5/0u79alWm83dApcN6L/mmCVnh0nI6tkWPJ27AxFHWNTCkOlB2OvEvGcEoJj
         0f9ZU4Aao+W+o0O+RkTmssRvXqdIflbIS7JTaTcrX+GNafiCuthTm7UgJKzLYspoj8SB
         Ywcg==
X-Forwarded-Encrypted: i=1; AJvYcCUtTRAVYZayR6j3U5UEOHH2CK/LhNavOhBYLj9xmYRWSeaFhFgNREi2ZzRYh+08TXSd28YJ743ZGN7BVs9n@vger.kernel.org, AJvYcCWorRfpgHeds0zEBfQMiAd9Yy+0AgJxHo9e/Ax1Mcipi5PKx7WawKPVjWDOrLRhAHYks4U=@vger.kernel.org, AJvYcCXwQNRRNXTrkfutALV5u6oEOvT/MT5SIQaBtVwHdOlAxOS4uGBMgf09WhwjlOKCBfASgyNEqUZ3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7edT+7XwzjP2yPrrCSkGJKG4ks/ZecQNlkp49SUGh4atwAEok
	d6FExBFybItyGa5SVuvAn7zeg4IGNLWHHVpyr5YiNXtGF+MrRdWWvcAdX91+SfcXbn27cO9JkfR
	VvpCxBKW09OuDTDBwwRNki/+znC1DqI3s
X-Gm-Gg: ASbGncvUllnMAmp7fsCXTIfOsZsV4RlD34Vy1V4JbRSmvq8UY6BVBIY9YMNi/CKvx2+
	4LzksOs8GF1bxCJkm2mc8Kot/QPcXmeglO3ylYcuKgyJT6lc2eJFEzPg8sCVBUqvcTLStf1FilX
	OC6UhWHTqu/g==
X-Google-Smtp-Source: AGHT+IFyWii/yvBJT6eTZb9Cpicq6Z7cyz4y67RfqGfGpbFd5HzqlUWgsNDmqvn2DGZC0WaSG4XorHDcqtm2ZoT8jko=
X-Received: by 2002:ad4:5766:0:b0:6d1:9f29:2e3b with SMTP id
 6a1803df08f44-6e6b0085d50mr152224426d6.13.1740401752800; Mon, 24 Feb 2025
 04:55:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222093007.3607691-1-wangliang74@huawei.com>
In-Reply-To: <20250222093007.3607691-1-wangliang74@huawei.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 24 Feb 2025 13:55:41 +0100
X-Gm-Features: AWEUYZmEuvp99OJ3DefogbEA6RgrIXcywUwi-Hle99k3LGA5Lc_uakDBRkTKIDA
Message-ID: <CAJ8uoz1fZ3zYVKergPn-QYRQEpPfC_jNgtY3wzoxxJWFF22LKA@mail.gmail.com>
Subject: Re: [PATCH net] xsk: fix __xsk_generic_xmit() error code when cq is full
To: Wang Liang <wangliang74@huawei.com>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Feb 2025 at 10:18, Wang Liang <wangliang74@huawei.com> wrote:
>
> When the cq reservation is failed, the error code is not set which is
> initialized to zero in __xsk_generic_xmit(). That means the packet is not
> send successfully but sendto() return ok.
>
> Set the error code and make xskq_prod_reserve_addr()/xskq_prod_reserve()
> return values more meaningful when the queue is full.

Hi Wang,

I agree that this would have been a really good idea if it was
implemented from day one, but now I do not dare to change this since
it would be changing the uapi. Let us say you have the following quite
common code snippet for sending a packet with AF_XDP in skb mode:

err = sendmsg();
if (err && err != -EAGAIN && err != -EBUSY)
    goto die_due_to_error;
continue with code

This code would with your change go and die suddenly when the
completion ring is full instead of working. Maybe there is a piece of
code that cleans the completion ring after these lines of code and
next time sendmsg() is called, the packet will get sent, so the
application used to work.

So I say: let us not do this. But if anyone has another opinion, please share.

Thanks for the report: Magnus

> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/xdp/xsk.c       | 3 ++-
>  net/xdp/xsk_queue.h | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 89d2bef96469..7d0d2f40ca57 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -802,7 +802,8 @@ static int __xsk_generic_xmit(struct sock *sk)
>                  * if there is space in it. This avoids having to implement
>                  * any buffering in the Tx path.
>                  */
> -               if (xsk_cq_reserve_addr_locked(xs->pool, desc.addr))
> +               err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> +               if (err)
>                         goto out;
>
>                 skb = xsk_build_skb(xs, &desc);
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 46d87e961ad6..ac90b7fcc027 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -371,7 +371,7 @@ static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt)
>  static inline int xskq_prod_reserve(struct xsk_queue *q)
>  {
>         if (xskq_prod_is_full(q))
> -               return -ENOSPC;
> +               return -ENOBUFS;
>
>         /* A, matches D */
>         q->cached_prod++;
> @@ -383,7 +383,7 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
>         struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
>
>         if (xskq_prod_is_full(q))
> -               return -ENOSPC;
> +               return -ENOBUFS;
>
>         /* A, matches D */
>         ring->desc[q->cached_prod++ & q->ring_mask] = addr;
> --
> 2.34.1
>
>

