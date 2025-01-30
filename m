Return-Path: <bpf+bounces-50177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF64DA237B6
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 00:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0F71642CC
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 23:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521D01F03DB;
	Thu, 30 Jan 2025 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5VVkaEC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3551AE01B;
	Thu, 30 Jan 2025 23:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738279018; cv=none; b=eka3HERzqDxb6hHXIl0fHcxSKWEeWgDcA7VgR8U31kjnQYAuPVIiCO8Kpm4sMdQeQcHSOXS+ckDuhL0rXhVdPzP9WGd9QjcEkowNI1a0UK0ff1hw5W0E5UfA+TaK4dz43SqW08LY9wQBl1L0j/CSY4p+7G15DrU4NPtpGKpcA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738279018; c=relaxed/simple;
	bh=wo+wStWFEQrrBjO1OBO/vWO6WU339RRuHvfA7tbjhlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPaH0lXLe5/1atNy9lKDVlAOe+3DpNAHVX/B43iflgGaQqvr1gC0/ERRp7QsIoO72j+O4k7bftq9a2ymy97PKSzP3H5XaZteTiVGvw28aOk4X47g0MTF4Dje6fo1cL6Irlh1va1br4QvEBBgdF0D6/xjA2BUAvXbrP+Yct7CG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5VVkaEC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166360285dso23421475ad.1;
        Thu, 30 Jan 2025 15:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738279017; x=1738883817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tbqava3jtlaDprzajGDs9SGnWXc8v9IpGNHGKUCgKIc=;
        b=F5VVkaECbA7pvOzbCFpwTSeGVTZ6/fWt11sGfCW+YvJLxjHJDMvN4MnzQ2HhF5TVij
         18qJ3okTM5tacy2k3ul0CvZKJYu0xwnSYmG2OGwOHWR6K911xWFKA2aWYNrSz3T12C6B
         4uIc+WyD8dViP+bQuqwFy8C9ifMX3ncq9XJ9KA8oLBB2aqU7ivpIB92rbpj7PHvhkm7A
         ATGCPqeBe8Rfymxojv75rCHldHApp809/JzD8vZfhfivk2yMq49uT53lpDaI+s7TYJJE
         JVsFZYKUf3TOzkwOP1vv7rkHxK5Z/d/Lfh4tLxsbN4jGpVUpOsvetuL/65yoLja8IoxU
         6mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738279017; x=1738883817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tbqava3jtlaDprzajGDs9SGnWXc8v9IpGNHGKUCgKIc=;
        b=sPaznHmHvqJEs9n54g3KknE/E35M0yLh0Vb1d9i8r6Gwq1JeluIcSkxOqZ1QEGZ/nD
         jRf9rDWF84N2SdHyuDAUEnoBW9mZrNxTZKq00s5IYlQl1oOBYV/OgVmFwsrW7fahFVUj
         x+BTldaG0aP2VTuXB6G+iiVatDxGomITdkrNxYo5V5B8kVDORljuUbDeNGANXZAyoiq7
         E2VgY8uPLJqL+3lxXAHo7OX5J/qzEHfrJ3tq1GZezJz6WvH54nBa3tRaGiypfOieyH5p
         PQ7+yOkMzpM1ZrUrc4OKayna+W+vrSA3AS+m7H/0Paulju8WdqOC+yWIPzidejr36OZj
         cx3w==
X-Forwarded-Encrypted: i=1; AJvYcCVmQqb+K8E+wdeO1vIKXCJEAZdTmr/xVXhS9mbGtjVw35XzBitjWDHnF5gxfuqmOyr1Iwo=@vger.kernel.org, AJvYcCW590mvGS21k8foh+qfk07pgPJvp0+hrsQdUh3UPgG8sR6k+BqzGZsjIcDeFg74frFBME6LChOsGQWYbwGz@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKXf7H320lzeYi+JCwGPAvx8716+G4FKLOPfLkAXLshKd3wft
	nNiPiZgQqoSaon00uraVmGg2T8qskU9eJF0qqvH+dtrzXIPcGrbHbyox
X-Gm-Gg: ASbGncs6K//hHnGUq9vwVL4ARvBeuRXL2F5It60JNE5x9M04DDM9M93M9unE6V3qYDp
	xjPBdaHMkYTiNJF37wHpfQ6wXXvv6Ka/yCqwnLCB2UFNv1Rry9IlCqT/cVhScWKT/eGIj2xmNNW
	He8iDRwzxhm8xk1q8FtunWN3Tb2eQRnB7h8q0b/oIuKU36lND6UFghi3QvsznL4uP8GA0cGHEdM
	saV/iVvKk8DVX8Vpau2x+9sD2v6p6YRPao8QtmsoRi8BPdnbK/JaFMO5vcWaFX8GlRZHcHrr1Gg
	Xt5XfScKAfVW2xU=
X-Google-Smtp-Source: AGHT+IE6hCBfx4/xoaxPyXHXQbecrCD/hL19H6rR5ZPSMy1Iv75zVThdZOL2MTyzyF8zrr40aso6SA==
X-Received: by 2002:a05:6a21:3388:b0:1e0:d1db:4d8a with SMTP id adf61e73a8af0-1ed7a5f6ea8mr12515356637.10.1738279016578;
        Thu, 30 Jan 2025 15:16:56 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe69ba38bsm2054920b3a.90.2025.01.30.15.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 15:16:56 -0800 (PST)
Date: Thu, 30 Jan 2025 15:16:55 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [PATCH 1/1] net: tun: add XDP metadata support
Message-ID: <Z5wIZ2LAjz0wTWg5@mini-arch>
References: <20250130171614.1657224-1-marcus.wichelmann@hetzner-cloud.de>
 <20250130171614.1657224-2-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250130171614.1657224-2-marcus.wichelmann@hetzner-cloud.de>

On 01/30, Marcus Wichelmann wrote:
> Enable the support for bpf_xdp_adjust_meta for XDP buffers initialized
> by the tun driver. This is useful to pass metadata from an XDP program
> that's attached to a tap device to following XDP/TC programs.
> 
> When used together with vhost_net, the batched XDP buffers were already
> initialized with metadata support by the vhost_net driver, but the
> metadata was not yet passed to the skb on XDP_PASS. So this also adds
> the required skb_metadata_set calls.

Can you expand more on what kind of metadata is present with vhost_net
and who fills it in? Is it virtio header stuff? I wonder how you
want to consume it..

Can you also add a selftest to use this new functionality?

> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> ---
>  drivers/net/tun.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index e816aaba8..d3cfea40a 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1600,7 +1600,8 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
>  
>  static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
>  				       struct page_frag *alloc_frag, char *buf,
> -				       int buflen, int len, int pad)
> +				       int buflen, int len, int pad,
> +				       int metasize)
>  {
>  	struct sk_buff *skb = build_skb(buf, buflen);
>  
> @@ -1609,6 +1610,8 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
>  
>  	skb_reserve(skb, pad);
>  	skb_put(skb, len);
> +	if (metasize)
> +		skb_metadata_set(skb, metasize);
>  	skb_set_owner_w(skb, tfile->socket.sk);
>  
>  	get_page(alloc_frag->page);
> @@ -1668,6 +1671,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  	char *buf;
>  	size_t copied;
>  	int pad = TUN_RX_PAD;
> +	int metasize = 0;
>  	int err = 0;
>  
>  	rcu_read_lock();
> @@ -1695,7 +1699,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  	if (hdr->gso_type || !xdp_prog) {
>  		*skb_xdp = 1;
>  		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
> -				       pad);
> +				       pad, metasize);
>  	}
>  
>  	*skb_xdp = 0;
> @@ -1709,7 +1713,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  		u32 act;
>  
>  		xdp_init_buff(&xdp, buflen, &tfile->xdp_rxq);
> -		xdp_prepare_buff(&xdp, buf, pad, len, false);
> +		xdp_prepare_buff(&xdp, buf, pad, len, true);
>  
>  		act = bpf_prog_run_xdp(xdp_prog, &xdp);
>  		if (act == XDP_REDIRECT || act == XDP_TX) {
> @@ -1730,12 +1734,16 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  
>  		pad = xdp.data - xdp.data_hard_start;
>  		len = xdp.data_end - xdp.data;
> +
> +		metasize = xdp.data - xdp.data_meta;

[..]

> +		metasize = metasize > 0 ? metasize : 0;

Why is this part needed?

