Return-Path: <bpf+bounces-67208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF37B40BF9
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 19:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6146E2084F3
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87694341ACA;
	Tue,  2 Sep 2025 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOeH0X/u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB9EADC;
	Tue,  2 Sep 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833972; cv=none; b=Q6XpoEZET/9+UH3ON/oUiD+xL08X1wODb1WxsafxUZ5h9Z1u6YgO39HCs8xiHou8rpvbKO68Kjv+SvdqscdPQsOvSQyidlETDdz7eZk7BHmjmoo6ZwvHUdBCcCFgomMHpxfiJmb6mDCz5K+7TIWQ2SWMpRKfYpFYCK7ryW3n1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833972; c=relaxed/simple;
	bh=/z/Dz1XaPvrkNw36gI59b8TNtvVJDPJtI5VaXutkiXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mff9Yy+NNWHDmRjvAFfX3O6EKa2EkRr5ULbZ1QuHzeEjGyWKd1a/qKCTJtMzCs6KOFhd8Vv1geT5Lqd9yt7QI9NFHDcBhxHeCFFLyobEGscnxzD+3TV3mZMm3mVMdmq5jwH3FXe+8iygRfh4EcMcPhcNaKa6N8fHA1Fu+BJ2A3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOeH0X/u; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-772627dd50aso120462b3a.1;
        Tue, 02 Sep 2025 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756833970; x=1757438770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AI0sibvMCgh5fbMVo8FbbdghaTtrNSnQf+2Uv67Hqb0=;
        b=NOeH0X/uyave7zSafdBKZ1jA3OB5abauOqB3k3ELpNvZVfNmce7fS0BE5llEUoTFG2
         09Ta7ToOBrr4pmWAWFBl35xxWvu9fugQJ/FIaLPwgBEDcSXOPjXnRMRX5IGVG9RgFW1K
         /bGG4Sp7dJ0ariaSkhR4/0F+SWewuhSBeImT2KlY0HNeW1qwFQHwMKK0VEsSJXMoTtkI
         TRdBPg4L4fYWO60otKro8itfKUcdVZ8YB1Mkvp+Ffpbbv+omePceGtEMhJvMZBKzsAv4
         eNYDbk18OrooP4CQOpQUHuW0c/Xm89U7ldpf/tfCgVMKLWqiYTZ3DgYT4Qvrj0/dEXZb
         g8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833970; x=1757438770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AI0sibvMCgh5fbMVo8FbbdghaTtrNSnQf+2Uv67Hqb0=;
        b=D3nvIVYGi8ljuivISsOs0+ZyqYpV6G4gQOw9nj67VVgPkd9iVqzPvP0+GKMxedT6I/
         VD/kyGg0gWTGytT3HYXUXfsZ0IfwBpzdw1aWqbbOPljwr0LU/pm9mJivUK/+tPdAM4aD
         fzTvhFK2/xXtxXU2cC/cmbT1rF2YGDnEX1NT+PCyV0WIslbIQ5h4k3mrT9Qb+OVhUipb
         xWLKPWN5HDr7mjF76l8mSgw/hAa5HJc1UkrqOy4GjCxVWSA6iov13NzfGpgfLgu0yc8p
         imhRDKhdxvRZgjLsXPoDucOXzoV6jzH/YpOGGgwQTiiLvKah91z2zQLOAxpAWI3+yOrx
         M7CA==
X-Forwarded-Encrypted: i=1; AJvYcCWv2FIJHg022eeOPz59PZVMy4/VFqPzSXbiPZpf7eDvy5ZKAuKZre2SL0x3zs9zUghyZQ5wUb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg48cya/VDTQaS5zfHdgP4o7Jly0idi5NwgOlCQZaQ/o/3Ucul
	9U3H/mAvlw36/iCz0kKXDJbrsVHcpoDNgCzNW3RAJsR8coq+43UY608=
X-Gm-Gg: ASbGnctqPK8pMsEZnGtmLR8b9SJg4lYxbjhasszcayujVaSZb8Dh+2TJJlT94JOitcF
	7T/9ZCUqBe6d0vSBXlGG9M71D+EN9Nq9+b4mCzwQ+2o+Q+CF+P6d1FXA3hD+xAOtTWZ3/5jvOox
	yveR/SzJ/hA28QkSrdzuhYeIzxkGMVUgRWHG1OUJVcMLORg/ZhB4/7dEmB+UCzzdMmQTkFAXptN
	4e7hkKRluW8lCUFu+migFGMi2cHzxkgmpzf+nI8+xHFhCOIEVuM8aEqkG3rqE7rfaiOE+/BxT4T
	mJDyWoPneSD9YE72e/YClwUQ384sxn7ReUo4WvboiVDv1PuxckeLW33bBaW7AmhcxeUcwdXiKXo
	z4zmVRDQi7O5lB71FpNTLvT7NqGu7k6DDZ9lQPA99Nng73sqJJik5+6OQenXmCqjCm02ds0Ctdb
	kI//4J6Uhczh7+AhwxljYV7Qb52O7Wszk3L/Fk35Tgw8Bhz/M6nLxrqGTDsP3xrk9nFC4qsQoFa
	sZg
X-Google-Smtp-Source: AGHT+IEUQPE00+kt4cC6c0CTbDY1QOeSG7yzCaxkvyUnPQojU0cKQ/XQPhhE6GNJK8H+7bjn0oI85Q==
X-Received: by 2002:a05:6a20:244c:b0:23f:ff4e:fcb0 with SMTP id adf61e73a8af0-243d505c677mr19170305637.2.1756833969523;
        Tue, 02 Sep 2025 10:26:09 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b4cd3670e5csm12353265a12.53.2025.09.02.10.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 10:26:09 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:26:08 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, kerneljasonxing@gmail.com,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v7 bpf] xsk: fix immature cq descriptor production
Message-ID: <aLcosKaalC8DYR5j@mini-arch>
References: <20250829180950.2305157-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829180950.2305157-1-maciej.fijalkowski@intel.com>

On 08/29, Maciej Fijalkowski wrote:
> Eryk reported an issue that I have put under Closes: tag, related to
> umem addrs being prematurely produced onto pool's completion queue.
> Let us make the skb's destructor responsible for producing all addrs
> that given skb used.
> 
> Commit from fixes tag introduced the buggy behavior, it was not broken
> from day 1, but rather when XSK multi-buffer got introduced.
> 
> In order to mitigate performance impact as much as possible, mimic the
> linear and frag parts within skb by storing the first address from XSK
> descriptor at sk_buff::destructor_arg. For fragments, store them at ::cb
> via list. The nodes that will go onto list will be allocated via
> kmem_cache. xsk_destruct_skb() will consume address stored at
> ::destructor_arg and optionally go through list from ::cb, if count of
> descriptors associated with this particular skb is bigger than 1.
> 
> Previous approach where whole array for storing UMEM addresses from XSK
> descriptors was pre-allocated during first fragment processing yielded
> too big performance regression for 64b traffic. In current approach
> impact is much reduced on my tests and for jumbo frames I observed
> traffic being slower by at most 9%.
> 
> Magnus suggested to have this way of processing special cased for
> XDP_SHARED_UMEM, so we would identify this during bind and set different
> hooks for 'backpressure mechanism' on CQ and for skb destructor, but
> given that results looked promising on my side I decided to have a
> single data path for XSK generic Tx. I suppose other auxiliary stuff
> such as helpers introduced in this patch would have to land as well in
> order to make it work, so we might have ended up with more noisy diff.
> 
> Fixes: b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path")
> Reported-by: Eryk Kubanski <e.kubanski@partner.samsung.com>
> Closes: https://lore.kernel.org/netdev/20250530103456.53564-1-e.kubanski@partner.samsung.com/
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> 
> Jason, please test this v7 on your setup, I would appreciate if you
> would report results from your testbed. Thanks!
> 
> v1:
> https://lore.kernel.org/bpf/20250702101648.1942562-1-maciej.fijalkowski@intel.com/
> v2:
> https://lore.kernel.org/bpf/20250705135512.1963216-1-maciej.fijalkowski@intel.com/
> v3:
> https://lore.kernel.org/bpf/20250806154127.2161434-1-maciej.fijalkowski@intel.com/
> v4:
> https://lore.kernel.org/bpf/20250813171210.2205259-1-maciej.fijalkowski@intel.com/
> v5:
> https://lore.kernel.org/bpf/aKXBHGPxjpBDKOHq@boxer/T/
> v6:
> https://lore.kernel.org/bpf/20250820154416.2248012-1-maciej.fijalkowski@intel.com/
> 
> v1->v2:
> * store addrs in array carried via destructor_arg instead having them
>   stored in skb headroom; cleaner and less hacky approach;
> v2->v3:
> * use kmem_cache for xsk_addrs allocation (Stan/Olek)
> * set err when xsk_addrs allocation fails (Dan)
> * change xsk_addrs layout to avoid holes
> * free xsk_addrs on error path
> * rebase
> v3->v4:
> * have kmem_cache as percpu vars
> * don't drop unnecessary braces (unrelated) (Stan)
> * use idx + i in xskq_prod_write_addr (Stan)
> * alloc kmem_cache on bind (Stan)
> * keep num_descs as first member in xsk_addrs (Magnus)
> * add ack from Magnus
> v4->v5:
> * have a single kmem_cache per xsk subsystem (Stan)
> v5->v6:
> * free skb in xsk_build_skb_zerocopy() when xsk_addrs allocation fails
>   (Stan)
> * unregister netdev notifier if creating kmem_cache fails (Stan)
> v6->v7:
> * don't include Acks from Magnus/Stan; let them review the new
>   approach:)
> * store first desc at sk_buff::destructor_arg and rest of frags in list
>   stored at sk_buff::cb

This is a nice way out :-)

> * keep the kmem_cache but don't use it for allocation of whole array at
>   one shot but rather alloc single nodes of list
> 
> ---
>  net/xdp/xsk.c       | 99 ++++++++++++++++++++++++++++++++++++++-------
>  net/xdp/xsk_queue.h | 12 ++++++
>  2 files changed, 97 insertions(+), 14 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 9c3acecc14b1..3d12d1fbda41 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -36,6 +36,20 @@
>  #define TX_BATCH_SIZE 32
>  #define MAX_PER_SOCKET_BUDGET 32
>  
> +struct xsk_addr_node {
> +	u64 addr;
> +	struct list_head addr_node;
> +};
> +
> +struct xsk_addr_head {
> +	u32 num_descs;
> +	struct list_head addrs_list;
> +};
> +
> +static struct kmem_cache *xsk_tx_generic_cache;
> +
> +#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))

Since you're gonna respin, maybe stick a build_bug_on here for
the sizeof xsk_addr_head vs sizeof skb cb? Who knows, maybe at some
point we'll stick more info into that struct..

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

