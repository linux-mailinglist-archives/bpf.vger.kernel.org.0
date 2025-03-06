Return-Path: <bpf+bounces-53443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EB3A54099
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 03:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97931188F0E4
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 02:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE3618DF80;
	Thu,  6 Mar 2025 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPg25pOl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9909E42A99;
	Thu,  6 Mar 2025 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227679; cv=none; b=JrOEOhI8Mn5zFcGqde1sLIy8iBimb9jrIF3HpzDtGlWv5+sa/Y/ZZVERD2gtGooeN9LxYh3qfhKhVK7XqXp8wN46CtLAVnBpPUHjfmThF9/1n/nt6g93TaqYzUtO9nS3TS8sHZyoAbM28f6WNWs9CJbQ95c0Rw0AMKMIy6vcSYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227679; c=relaxed/simple;
	bh=oL2q1Xv5LVa537+GMtrEDFXc5//jOnkjbBYREa2L/bA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBs5zLnoGBYsYpnb2J1zeCvZomHVGxonFbiy6QPYwBOWtVpJF2AdUUSn6LHJToeT1vv7BAk98yD9UDfdB1NqKm+cw9Axkes7GiXtqj8Aw4a/giodUEyVk52ERkLW5CmDmkZru6BvbV792Rt2ekhoT0bujJmEr8V26dIkVyb6o8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPg25pOl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so278628a91.2;
        Wed, 05 Mar 2025 18:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741227677; x=1741832477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uf9XkZp6sUpoZuVO6jgJ6hPy2Z9ZctUdmgbqHKgrhA=;
        b=cPg25pOleW6U7WGtjRkkl7+7zCVOh3qBXk+7IRFukvvpEepiDn2Fl4vlRUgUX/mTu2
         Qbk5CNnClvs3QJ7N1HVy4Ntqj3F5wGMF/ZEJ83XMwJ/+XiiQIUxQEN5npIPcsueXE06w
         CvhYTxCn51r5NMCyo7So/wSEsLjFddQHvgY70Q7q4YIJr8hMdDO/ZyQsf/5YPL5jFr/m
         wpCd2iQG9PlfhdSIvKDejZBLitHCUWamCxtjbL4YV4LQoJb/9nw7woRAgDcmpNYo1vLf
         Ve+wHQit7bLO/kDPiNFVQuFcZkHfq+abCZVFXgFAJGAnPZXLaTTUlWamgqyaCw3cZuEb
         yXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741227677; x=1741832477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uf9XkZp6sUpoZuVO6jgJ6hPy2Z9ZctUdmgbqHKgrhA=;
        b=FtPIc6Ggm6CR778GNmAncYJ35oomvzM5njpzZ2Z9+/gOlQuFY4JlL1GIQzdgJqqx6s
         Hk7H+0bLcQRRtSj/ddEx4TdseyoYbBwSsR8nYuYAWcqfszx8ZajA9hRd/pGYndUnOV+8
         2Vy8uvWUH+YWeFtb1YTYLCv6bn0HwApAacWOzTQvgF7/MiV+biI5TIh40lEEUDas0j3n
         ikENIevdGs8pI9NdCXVXrjOGq1q5mR8UP/zeh1N67ufKgz2A/ONH1TDdd6HldTEPgGNz
         pUynqi3pzTO81nPLjWgPao/QA6HileUuSe/6lrxUyRDVSwUoA/XxBUsjWvARJpn93EE9
         Kx0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOVFOf4bVcBy4kHTM6mhlTlcEE/uq8Lqj5tjXMTQvjb2vaPTh7pv2FkXmwE3rH2TldJY3Ac75q@vger.kernel.org, AJvYcCWIKobG+xSYbMMOl/SBSn5aLE1lUy+1aTYOu18RTuh4m+DNsLAsbulKcmuDCTJmxqJzf6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHaqVlEBmmoyceleJr+6z0G04Em7mqrO98l4EFETXGSM5w16JJ
	G1jCRh2OVLVMTgTHcp2P6DeQBH1HOBIgA+r3iVZFym9kxW9s+J2O
X-Gm-Gg: ASbGncsuokw6sGgzmn4Ca/OHGoekQR8VKpuBYLvhPMuQ38/sC66qV7Qwvr64uUGHQ2C
	wPvUVNYhxPA0rVdRmbpAzULXUUNvYcRDeRQGvlduNtWkFe1i1SHrdKeNfne79h4r+hfPUYxhueH
	310+zhVzS4lO+NrJl3MrmtSvNUicW7jiTLOocb22tcjsA6t/mj3jcushVFk4fXbbR44+iz+bi0O
	A9n/1CEBNY0Sitd4CcFOs45GHrYrxHsOa3kqp2nDFv/flyT67Pks45grREKgjBfRt9f18QzeGFm
	bluXRP0h97O9JPykTHkbrF86lxa6FYAqbEAyyQ==
X-Google-Smtp-Source: AGHT+IHkMiSrpKwGbFAkWOhgsD087E6Gf2q0MWqWgQE8twjmH+Zp7KHIpHrJbDkVmH95oKOIZuwckQ==
X-Received: by 2002:a17:90b:5747:b0:2ef:114d:7bf8 with SMTP id 98e67ed59e1d1-2ff49717514mr8399175a91.6.1741227676668;
        Wed, 05 Mar 2025 18:21:16 -0800 (PST)
Received: from localhost ([144.24.43.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693527f9sm167239a91.11.2025.03.05.18.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 18:21:16 -0800 (PST)
Date: Thu, 6 Mar 2025 10:21:07 +0800
From: Furong Xu <0x1207@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: avoid shadowing global buf_sz
Message-ID: <20250306102107.00003c31@gmail.com>
In-Reply-To: <E1tpswi-005U6C-Py@rmk-PC.armlinux.org.uk>
References: <E1tpswi-005U6C-Py@rmk-PC.armlinux.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Mar 2025 17:54:16 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> stmmac_rx() declares a local variable named "buf_sz" but there is also
> a global variable for a module parameter which is called the same. To
> avoid confusion, rename the local variable.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 334d41b8fa70..cb5099caecd0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5475,10 +5475,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  	struct sk_buff *skb = NULL;
>  	struct stmmac_xdp_buff ctx;
>  	int xdp_status = 0;
> -	int buf_sz;
> +	int bufsz;
>  
>  	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
> -	buf_sz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
> +	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
>  	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
>  
>  	if (netif_msg_rx_status(priv)) {
> @@ -5591,7 +5591,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  			net_prefetch(page_address(buf->page) +
>  				     buf->page_offset);
>  
> -			xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
> +			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
>  			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
>  					 buf->page_offset, buf1_len, true);
>  

Reviewed-by: Furong Xu <0x1207@gmail.com>


