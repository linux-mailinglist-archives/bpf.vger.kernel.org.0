Return-Path: <bpf+bounces-57084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A3FAA539F
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 20:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DFE467D85
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53503264A6E;
	Wed, 30 Apr 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTn+/oCN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC7190676;
	Wed, 30 Apr 2025 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746037517; cv=none; b=DaQwifFsiH8UGcGNSLgSfEyexoYHdyqVw0hzTUR9HKjJG+MnBSskqQP/ltvtdijRQ/KXXyw5I+8x7EvIoRXxxsDcflglMkMxgkwgQfr284ute1HP3JFmeRxN3Ct1WkyL8WZlFq7Qyc+NWEb/WK/MhbZTC8nhZ2Et1Dz6z4I8XDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746037517; c=relaxed/simple;
	bh=dntHkSUODIQLMMzWfdC0ZCYDVYeurZEYNyJyydXvyRw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sl14xvP/oRxtbLJUmNlfehRO6MJuxkQmySD4v5k9SPm+aJfhj8TBM7gkgRUnbPmb46YVxwAzoRBCz8hiYhA2ZaiIxTb28QTf8Ixo661vPKQxH5XQZJ5d3pGzgTsfY9B5mI54c1IymoWObHzYu+FwagntLA668YRPRiNNzY+Y92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTn+/oCN; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c53b9d66fdso14620285a.3;
        Wed, 30 Apr 2025 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746037515; x=1746642315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuU9dJ/Di5OmDAwUgi7sluax8cJiERF6LgVjZOwJylI=;
        b=gTn+/oCNzjLr+nmBrguxMBuw6h7efJyEJ2deGl5IWBqGJJsAr8DpROa7XZn1ray+mG
         x7Uw9VCvbwm2bavdF95FXr+VXElejFG7j2YsYqjrV5v2t/rPD0jw/stA1ElfFA3NgK6l
         fPdyxpu67kt5XtNODVMTRu1jqownHqTbJOlTTsQ76NLsr26/ymg03mq5R7hLA+Am3fx5
         xMeS3HOTax9wOrxJxwZrGqorYlFhinEOG95qr9RRBHee3+1pPvDD+3HVKLX+2qcWeBm6
         zs6ze/AcTEruusdjTwiv9qepMDDZ/pZjwthpEIr751z0STS8bYsKC3KIH9aCl30Zo+Zp
         2isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746037515; x=1746642315;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PuU9dJ/Di5OmDAwUgi7sluax8cJiERF6LgVjZOwJylI=;
        b=NBkZw6/MyFXoZC9INkCDeBCvzQ8htfwia64+KyN40lbYUYNAzvTBmDayBoqc/9SJ7p
         bDpGP5HjM75adXAf75iyeb9f2X36NXgjGXPI4bbQ1CBcNCSD7SeXxd+z5j5nSh7Q/jc8
         RC1bRqSQSjGv1bLQYgHlaBkmKN8fTXCyuFd46lyWqgPwxH6LMDwqPhso7Wmz/SDeDorF
         warKLDp1cDNjCH62Uz28fv96zcHD8XgKCMWuVwHotBgc8Hkuyh5+8y97vWof7plI4x0a
         Mqr2Ro7fe8y9N8JEN0Y/HKPs0iwA6dO7WU83DCmgIRk9Hwy1Ydf59n3eUVY417YWOxG2
         YqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJJ6KocnC41WZLBZni2JTjKDBrSXilz7CaihIzWWyh5auwGuRin77PUuDeCjDuYLaXtXMVcyw6@vger.kernel.org, AJvYcCVT+AampspA74ie5TGk9xJiIly60u1iIbCEqRXbKEWustDm7GJWYUMn6fg0bRBDDqIfOjA=@vger.kernel.org, AJvYcCVus+kmXsSHIOp2rlFIM+7Za3DLYadnAUV/H/XCEV3EDP8FvjJ0EZTaxtg6n+d0YDCILPMcwxEn5HuWXax9@vger.kernel.org
X-Gm-Message-State: AOJu0YzMo+MAdHUeyUbYPcNYEpV6A1nZfTi5WpvB1RKEfQTBZs5Gf65L
	/X/oUhPMLBPz46+3BdAkgbtOzPFTJbRcHFxXrPcYtZYMgcrsYfjN
X-Gm-Gg: ASbGnctXVYX2sQWJuMF51OQzh047BNAI+DcfEsEmgHsQ7yViNmt3ghOXGjCyTWmLuPU
	g9O1eTo3qbQlGSE58D2sXQOpkLA02OU0ykgCbbogYRK5V2k5RK4Vw0NIYNPuyM4Z298mi4Gu0I5
	auMP8iIEIbADACcyC0+akkIBHO1esnZisyxFTzOyOKVunnyw8gbigm2knxpZo90IFUuo4TeBoDQ
	vTRxWH24FD/Xk8u3ZZ99qBAiWilAqKaEe0aWoCXobnKAM8TSq3jCwL49rMp0Ol0mqLjZxYo/nqR
	CWQ4aVluLxPtCPTgtUCYHeniqV0zEoTP+Oe801CAvCMrjEJciRcr/eAs2fIonfywpIY9nsLpRno
	zeX3QXXAeX5c54yw4pddLigt8hOdzkYA=
X-Google-Smtp-Source: AGHT+IEdeBQS0rsgRgLgNnw2i5fBYy2oC7eKu5y/CBRhlsW9hDSYvHIxDh4yZVpXcWMS8fpuh7OTog==
X-Received: by 2002:a05:620a:17a7:b0:7c5:57b1:1fd1 with SMTP id af79cd13be357-7cac7ea001dmr572603585a.47.1746037514950;
        Wed, 30 Apr 2025 11:25:14 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c958e7bdfesm887579985a.75.2025.04.30.11.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:25:14 -0700 (PDT)
Date: Wed, 30 Apr 2025 14:25:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Message-ID: <68126b09c77f7_3080df29453@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250430182921.1704021-1-jon@nutanix.com>
References: <20250430182921.1704021-1-jon@nutanix.com>
Subject: Re: [PATCH net-next] xdp: add xdp_skb_reserve_put helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jon Kohler wrote:
> Add helper for calling skb_{put|reserve} to reduce repetitive pattern
> across various drivers.
> 
> Plumb into tap and tun to start.
> 
> No functional change intended.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  drivers/net/tap.c | 3 +--
>  drivers/net/tun.c | 3 +--
>  include/net/xdp.h | 8 ++++++++
>  net/core/xdp.c    | 3 +--
>  4 files changed, 11 insertions(+), 6 deletions(-)

Subjective, but I prefer the existing code. I understand what
skb_reserve and skb_put do. While xdp_skb_reserve_put adds a layer of
indirection that I'd have to follow.

Sometimes deduplication makes sense, sometimes the indirection adds
more mental load than it's worth. In this case the code savings are
small. As said, subjective. Happy to hear other opinions.

> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index d4ece538f1b2..54ce492da5e9 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1062,8 +1062,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
>  		goto err;
>  	}
>  
> -	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> -	skb_put(skb, xdp->data_end - xdp->data);
> +	xdp_skb_reserve_put(xdp, skb);
>  
>  	skb_set_network_header(skb, ETH_HLEN);
>  	skb_reset_mac_header(skb);
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 7babd1e9a378..30701ad5c27d 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2415,8 +2415,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>  		goto out;
>  	}
>  
> -	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> -	skb_put(skb, xdp->data_end - xdp->data);
> +	xdp_skb_reserve_put(xdp, skb);
>  
>  	/* The externally provided xdp_buff may have no metadata support, which
>  	 * is marked by xdp->data_meta being xdp->data + 1. This will lead to a
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 48efacbaa35d..0e7414472464 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -345,6 +345,14 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>  					 struct net_device *dev);
>  struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
>  
> +static __always_inline
> +void xdp_skb_reserve_put(const struct xdp_buff *xdp,
> +			 struct sk_buff *skb)
> +{
> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> +	__skb_put(skb, xdp->data_end - xdp->data);
> +}
> +
>  static inline
>  void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
>  			       struct xdp_buff *xdp)
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index f86eedad586a..1fca2aa1d1fe 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -646,8 +646,7 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
>  	if (unlikely(!skb))
>  		return NULL;
>  
> -	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> -	__skb_put(skb, xdp->data_end - xdp->data);
> +	xdp_skb_reserve_put(xdp, skb);
>  
>  	metalen = xdp->data - xdp->data_meta;
>  	if (metalen > 0)
> -- 
> 2.43.0
> 



