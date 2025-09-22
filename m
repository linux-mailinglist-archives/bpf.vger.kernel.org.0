Return-Path: <bpf+bounces-69253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94404B9268E
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 19:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8950F7AE12B
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A537F313E23;
	Mon, 22 Sep 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdfgeFgq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6DB313D45
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561935; cv=none; b=SrnzWZvjqMRu0g7EpzLrOvhgR3p/ORbfa6Xu5EFN1V9Vt5VW1XhJ3My/y87ep9zn1rbhftibCZ3AyqyVIAwBGVJFXn/TWsVSag1AiaFa+iwKIZ9zG/qJXmjZPrHdEXKwS3rGy9KX4ki44/+LJynUZxQkyW4LyGe/QW2nJBpoSts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561935; c=relaxed/simple;
	bh=KAuXbOltxNgy8WInrPjwl+hbP8S2O9ZOc7MtIOcbUTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlK1OdxoLnIGVozmT99MqdOt9F5UEc6xhvTfQqQlUvVYn7XBY9zx9J/R1ywa5nr2bfr/Wbl9dW0xcPjIlKdl8TLl6hyGIIUkOHzbPeZX9UzKgP555L9HiSSNvL1tM4nDXkC58DHqcZNGUZ3ITzACqJu9SMa2P6Sr7XnXpfOmjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdfgeFgq; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77d94c6562fso4592739b3a.2
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758561933; x=1759166733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=83D95CBgRcD/U9iqxIg7crplJ8r4aQkclY9VPZZgyWQ=;
        b=GdfgeFgqOxVh2urQIERiJYDbexbhDKKS86F8lmwn9GDnzp6T8PNznoW+twB6zBw7yF
         282f8+lfpdMh/4DtbXZpWbxiMTZ8lK4N6xyClpjCQhxZYCkETC5UVP/T81e0kumc+KJN
         cSA3ugGwDR2ajBvObtrNJl452Mr+uO19KJYS7Dg02uikWDeYpnZfPPNAohCmyVA4rqqY
         hUoBfOol0bwi4jNDUHoiExz2xyFEwkLTUG0QU0p+uM1h0+7v/UvVqoVbtEMW1gHe8t1z
         SKAFMIuVgq28rKIcW+CTnGrNLDqU9S5O2E5BSezT6IYqLE2lfy4z4vkeRXtGcTKfCMz0
         XiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758561933; x=1759166733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83D95CBgRcD/U9iqxIg7crplJ8r4aQkclY9VPZZgyWQ=;
        b=iuTdSulDIK7MOGkDt4z09TTwBhRMPA0/5CGwnDAe5IQeEe7QCRQkrByDcqWg+I3oxD
         PlzVOuzugk1qUTw3sW5uwULQm4GCN+FL/J1Ici0MYmQA/TUdmIIeh4z8HlEmL97jcNpm
         Qp4cB7gSBiWuUq4FcgmzYgHx9DeaJCqbsB5XF6m1/8fTfdQ8MpwA4ur59FijRS6m8SlL
         sxypBTTVGiMKa1rjvA/MC+Vl1Ol0PWNWDgxpAbZ1qGQJaROgebP88m63Z32amRE/8CFm
         79tJ2/s6ooV+eQoxHfTU9tA9vIPoDRboKUMaII0c58mwIafUHXI3KufbrBc9ykgEU10C
         JeHQ==
X-Gm-Message-State: AOJu0YyLRX/VChS9jeIJZg1Ff1Sr+rg65IHl39GLggstMFQ9MXMSAAcW
	Gj6vMUI7CEFvlohUTsl6wt5XCZfcEtr6AkdgKOFXWDQYmAwtpHiXMHs=
X-Gm-Gg: ASbGnct/B5evrEx2MOOUgG+cLTa42A6AMSxdco2dyNtwgwSt3v0jtFsoxxVDvO/Vwwk
	KTGmBKj1vcEGz17gHf668rUdgcUiNysGjD+UfyhfeB9417NyX79QqzihnMk71CCPVvD1NXJG64z
	azivI4yHtpJeCQUSmfyLaBvvWLcP2+q1//cVtiSxIsjRr/X9CuKvNCrMpLzjlyjNDhurwEqbmb5
	eQj39Ocbf+OcfjSsmOZUJRkuXUu9y0MQIIlVpPS74Kdb3Zo9uz6qv3IYxu3+gJxVC50rZwPg1nw
	/bLfn//EWXVyjrJqO/YXNPgzRyQmUoDd2sLgRM4VL97+CKK5iV8KdVnFRAcdidPvBwCs7MKZEWN
	9AzTo+PCGVfzOUkHtRplZh7KSfPeohxuGuMT+nIPQ0HCI6NswB4gYhEoWD8KsUTScLAMRD04jE5
	o8xjQbV4Hnc6n/Z1oBsQLEi4v5AnISq+27skV6zO1689GESG6c3amAdQ8jQsFZbbhzjIRo0EgkC
	jD2ouJBSSn3QGo=
X-Google-Smtp-Source: AGHT+IE3N4rdtpdpacqN7GPlaTxmCFciYnc2RQAsf/slc5/UFJiPbgXgxGoXXCf5+yEOTyvFNLZkig==
X-Received: by 2002:a05:6a00:3c8f:b0:776:1de4:aee6 with SMTP id d2e1a72fcca58-77e4e5c5230mr13372885b3a.16.1758561933075;
        Mon, 22 Sep 2025 10:25:33 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77cfc2481d7sm13257873b3a.32.2025.09.22.10.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:25:32 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:25:32 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH bpf-next 1/3] xsk: avoid overwriting skb fields for
 multi-buffer traffic
Message-ID: <aNGGjMFT_bsByxcZ@mini-arch>
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
 <20250922152600.2455136-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922152600.2455136-2-maciej.fijalkowski@intel.com>

On 09/22, Maciej Fijalkowski wrote:
> We are unnecessarily setting a bunch of skb fields per each processed
> descriptor, which is redundant for fragmented frames.
> 
> Let us set these respective members for first fragment only.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  net/xdp/xsk.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 72e34bd2d925..72194f0a3fc0 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -758,6 +758,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  				goto free_err;
>  
>  			xsk_set_destructor_arg(skb, desc->addr);
> +			skb->dev = dev;
> +			skb->priority = READ_ONCE(xs->sk.sk_priority);
> +			skb->mark = READ_ONCE(xs->sk.sk_mark);
> +			skb->destructor = xsk_destruct_skb;
>  		} else {
>  			int nr_frags = skb_shinfo(skb)->nr_frags;
>  			struct xsk_addr_node *xsk_addr;
> @@ -826,14 +830,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  
>  			if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
>  				skb->skb_mstamp_ns = meta->request.launch_time;
> +			xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
>  		}
>  	}
>  
> -	skb->dev = dev;
> -	skb->priority = READ_ONCE(xs->sk.sk_priority);
> -	skb->mark = READ_ONCE(xs->sk.sk_mark);
> -	skb->destructor = xsk_destruct_skb;
> -	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
>  	xsk_inc_num_desc(skb);

What about IFF_TX_SKB_NO_LINEAR case? I'm not super familiar with
it, but I don't see priority/mark being set over there after this change.

