Return-Path: <bpf+bounces-57096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE29AA568B
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 23:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C440D9A4030
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F480299506;
	Wed, 30 Apr 2025 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts8AtnpA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBAA347C7;
	Wed, 30 Apr 2025 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746047356; cv=none; b=JTkb2iQqyWTcDhL8LIWOh3j8tLxdPd32o5cqvImYSbZc2iAL4fCsB4+yEG6oKaR8fHrUhl6n4BnF5il3RAqpiZOr95aweCaLktHuk0UVqtEXgG//V4ADbBzasWNOTQibRGFc/1CRRk832zRe7LyLUrvATZ8iEK34WOwKChCPf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746047356; c=relaxed/simple;
	bh=OXlR22NeZujfiOd6a7VlXw5AasuYrIFa2Xex6TgyW/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyfEmpQ644y/58hjeMvZXu4TGJC7R7WDzfkUOzbxyFtDq1pbg/ixu5UExf5kyNYUDCyCz60cP04gaogLX2y7K6sJTtvIV7p1+JiIC1KkSwu+ByQ+7G00xsSrbP4PRWEqwL4K2Kd3EdB/ajSsvyN5gBweGdOKKYxQ9sKBe0sE5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts8AtnpA; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b061a06f127so201275a12.2;
        Wed, 30 Apr 2025 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746047354; x=1746652154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3HKRMSHrP9RGCuuggYrpkcFnv1xm24FX7npNpab07w=;
        b=Ts8AtnpA5Fy9y291NMDVmjzFxWMTEFvW2PfEmgVjz+m+R1EOqUrccQs1TW/MgFCLGs
         1OgsgjiOLj8bN5XtOejJMF8748leP3p9+ozgkQ4G/yMvI35WL/4ilzvCJcjTqNwfsSaj
         NxX6IZ+AdyklJSROQ7PNKL1RgUq3gY421570ftXF/C8eSxjbsQI7HWMsL7A6Yy+p0M5t
         SU3ic24qfnn/ondhsxqW5SocJ/oetAUMeT3rWe/mWQNs0s0DbT3MBFvs535xud3hQPA0
         NhtsFN96rgztFbFtAAJxV3ICJ9kSkD0/AegGLGyiAPXY4eudfnx8pgsq2KvV9wKTxq36
         uJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746047354; x=1746652154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3HKRMSHrP9RGCuuggYrpkcFnv1xm24FX7npNpab07w=;
        b=J0s2nr19w60a3To/GwbptzVf8NPfT7Gnwzt3V2coZgF3QfBsHZ92lTlfdmLNASSkFz
         RJkpih+wAp4MGKz35xilmZyWFGkcUsH6gngQd61zGSQb6uIeUAwtCEVproSaxUFkXFOE
         uLqL+JXhJvm9IxEEWrAPszQtxLY5hlXTrXnIONfTGHaPio14jtMk6/SDEQrM28zPD/rY
         wggf6DxsZ7JE8ArmT4pLMHK3uSJEeCF7NWkCVlk/WPtfHpeGuiZRdP54L2naURiGNQcJ
         5Qv0swbb9y13vpeOgEFWcwp1id9KOUxLf8zDJsIgZxnMkRGCtiy7yotWi+Q+HJQFCzz+
         MaNg==
X-Forwarded-Encrypted: i=1; AJvYcCUHz8i3KJ5TP6ykUlLas+eLxcGurY3CvB3sOfCVY/D2YqJdsONbh2uKT3QcCbhWgvVAIGLKP6qhGpdxzEmE@vger.kernel.org, AJvYcCVIft904eKO8y06iwbXDusJrRTWKDjoUiD8Kk+sxx8Y/fW7dOG9mrfCaLHmM/BidogTsSA=@vger.kernel.org, AJvYcCVlZxf6oZFv+5ZFKHSxRuMbz60sShJvw047KxvJ43JRHcS+HwUjSPVT2PmAlRlnk17+yRW6FZlB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/6N0/+D1mo9/ppUXt6L2zS3ZgmaCgTJkgs1pqLzuvSHrUzh1+
	rdVKRiUgFFGhRB/5nP+v9ctLdYF09DhzsKxARwJZqSzSdvsqqAc=
X-Gm-Gg: ASbGnctb+CihlvYRCqLNYbfJTEnDmF9RdPS7XSonD+sgspmMUNAlW9PmIXbZZQIOmNK
	yD7ebNeuaVpNY516kXKfL1QnH42zUl+i0j2vxC2ZS63FOGH17UhyA6A/pzNg/yoWT38nyqRwiY7
	b07klaalmirUxH84qmkWTC6aBKajmAy1k1yJft+11iGuF4SG1V6VUptMDzU96fS7irKUCNxmpjE
	su31I9yyNMpjZOG10s/RqQ2R3oZ2AC+OBxpp8ge3REDeHleEijiE6jGGUBTlSNdqCp+TWrxVoC1
	BaotLh76Lnep4/SrJDX1ephFORL3p/rZkH9e2QWIEG+Y0Czr3FOPUNg46lN3b5qItz5bJvs9rbg
	=
X-Google-Smtp-Source: AGHT+IFXQCXHicJFO1hNA94Emd+k12JQXrYMfIw1qxJUNTY3zVjzX+7mSkKMVuJEo5+CRvCD6UBoLw==
X-Received: by 2002:a17:90b:5826:b0:2ff:5a9d:9390 with SMTP id 98e67ed59e1d1-30a41d19e3emr331100a91.8.1746047353508;
        Wed, 30 Apr 2025 14:09:13 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30a34a00039sm2147830a91.19.2025.04.30.14.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:09:13 -0700 (PDT)
Date: Wed, 30 Apr 2025 14:09:12 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2] xdp: Add helpers for head length, headroom,
 and metadata length
Message-ID: <aBKReJUy2Z-JQwr4@mini-arch>
References: <20250430201120.1794658-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250430201120.1794658-1-jon@nutanix.com>

On 04/30, Jon Kohler wrote:
> Introduce new XDP helpers:
> - xdp_headlen: Similar to skb_headlen
> - xdp_headroom: Similar to skb_headroom
> - xdp_metadata_len: Similar to skb_metadata_len
> 
> Integrate these helpers into tap, tun, and XDP implementation to start.
> 
> No functional changes introduced.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
> v1->v2: Integrate feedback from Willem
> https://patchwork.kernel.org/project/netdevbpf/patch/20250430182921.1704021-1-jon@nutanix.com/
> 
>  drivers/net/tap.c |  6 +++---
>  drivers/net/tun.c | 12 +++++------
>  include/net/xdp.h | 54 +++++++++++++++++++++++++++++++++++++++++++----
>  net/core/xdp.c    | 12 +++++------
>  4 files changed, 65 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index d4ece538f1b2..a62fbca4b08f 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1048,7 +1048,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
>  	struct sk_buff *skb;
>  	int err, depth;
>  
> -	if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
> +	if (unlikely(xdp_headlen(xdp) < ETH_HLEN)) {
>  		err = -EINVAL;
>  		goto err;
>  	}
> @@ -1062,8 +1062,8 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
>  		goto err;
>  	}
>  
> -	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> -	skb_put(skb, xdp->data_end - xdp->data);
> +	skb_reserve(skb, xdp_headroom(xdp));
> +	skb_put(skb, xdp_headlen(xdp));
>  
>  	skb_set_network_header(skb, ETH_HLEN);
>  	skb_reset_mac_header(skb);
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 7babd1e9a378..4c47eed71986 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1567,7 +1567,7 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
>  			dev_core_stats_rx_dropped_inc(tun->dev);
>  			return err;
>  		}
> -		dev_sw_netstats_rx_add(tun->dev, xdp->data_end - xdp->data);
> +		dev_sw_netstats_rx_add(tun->dev, xdp_headlen(xdp));
>  		break;
>  	case XDP_TX:
>  		err = tun_xdp_tx(tun->dev, xdp);
> @@ -1575,7 +1575,7 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
>  			dev_core_stats_rx_dropped_inc(tun->dev);
>  			return err;
>  		}
> -		dev_sw_netstats_rx_add(tun->dev, xdp->data_end - xdp->data);
> +		dev_sw_netstats_rx_add(tun->dev, xdp_headlen(xdp));
>  		break;
>  	case XDP_PASS:
>  		break;
> @@ -2355,7 +2355,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>  		       struct xdp_buff *xdp, int *flush,
>  		       struct tun_page *tpage)
>  {
> -	unsigned int datasize = xdp->data_end - xdp->data;
> +	unsigned int datasize = xdp_headlen(xdp);
>  	struct tun_xdp_hdr *hdr = xdp->data_hard_start;
>  	struct virtio_net_hdr *gso = &hdr->gso;
>  	struct bpf_prog *xdp_prog;
> @@ -2415,14 +2415,14 @@ static int tun_xdp_one(struct tun_struct *tun,
>  		goto out;
>  	}
>  
> -	skb_reserve(skb, xdp->data - xdp->data_hard_start);
> -	skb_put(skb, xdp->data_end - xdp->data);
> +	skb_reserve(skb, xdp_headroom(xdp));
> +	skb_put(skb, xdp_headlen(xdp));
>  
>  	/* The externally provided xdp_buff may have no metadata support, which
>  	 * is marked by xdp->data_meta being xdp->data + 1. This will lead to a
>  	 * metasize of -1 and is the reason why the condition checks for > 0.
>  	 */
> -	metasize = xdp->data - xdp->data_meta;
> +	metasize = xdp_metadata_len(xdp);
>  	if (metasize > 0)
>  		skb_metadata_set(skb, metasize);
>  
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 48efacbaa35d..044345b18305 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -151,10 +151,56 @@ xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
>  	return (struct skb_shared_info *)xdp_data_hard_end(xdp);
>  }
>  
> +/**
> + * xdp_headlen - Calculate the length of the data in an XDP buffer
> + * @xdp: Pointer to the XDP buffer structure
> + *
> + * Compute the length of the data contained in the XDP buffer. Does not
> + * include frags, use xdp_get_buff_len() for that instead.
> + *
> + * Analogous to skb_headlen().
> + *
> + * Return: The length of the data in the XDP buffer in bytes.
> + */
> +static inline unsigned int xdp_headlen(const struct xdp_buff *xdp)
> +{
> +	return xdp->data_end - xdp->data;
> +}
> +
> +/**
> + * xdp_headroom - Calculate the headroom available in an XDP buffer
> + * @xdp: Pointer to the XDP buffer structure
> + *
> + * Compute the headroom in an XDP buffer.
> + *
> + * Analogous to the skb_headroom().
> + *
> + * Return: The size of the headroom in bytes.
> + */
> +static inline unsigned int xdp_headroom(const struct xdp_buff *xdp)
> +{
> +	return xdp->data - xdp->data_hard_start;
> +}
> +
> +/**
> + * xdp_metadata_len - Calculate the length of metadata in an XDP buffer
> + * @xdp: Pointer to the XDP buffer structure
> + *
> + * Compute the length of the metadata region in an XDP buffer.
> + *
> + * Analogous to skb_metadata_len().
> + *
> + * Return: The length of the metadata in bytes.
> + */
> +static inline unsigned int xdp_metadata_len(const struct xdp_buff *xdp)

I believe this has to return int, not unsigned int. There are places
where we do data_meta = data + 1, and the callers check whether
the result is signed or sunsigned.

> +{
> +	return xdp->data - xdp->data_meta;
> +}
> +
>  static __always_inline unsigned int
>  xdp_get_buff_len(const struct xdp_buff *xdp)
>  {
> -	unsigned int len = xdp->data_end - xdp->data;
> +	unsigned int len = xdp_headlen(xdp);
>  	const struct skb_shared_info *sinfo;
>  
>  	if (likely(!xdp_buff_has_frags(xdp)))
> @@ -364,8 +410,8 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
>  	int metasize, headroom;
>  
>  	/* Assure headroom is available for storing info */
> -	headroom = xdp->data - xdp->data_hard_start;
> -	metasize = xdp->data - xdp->data_meta;
> +	headroom = xdp_headroom(xdp);
> +	metasize = xdp_metadata_len(xdp);
>  	metasize = metasize > 0 ? metasize : 0;

^^ like here

