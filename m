Return-Path: <bpf+bounces-57298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C438AA7CA6
	for <lists+bpf@lfdr.de>; Sat,  3 May 2025 01:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5441F4E1052
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 23:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159012222C9;
	Fri,  2 May 2025 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLeo8bHI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDEDF9CB;
	Fri,  2 May 2025 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746227855; cv=none; b=A5kxOeAgh4CbL4+KCjJTGLo9joETwSOof42h6IRztGjdvjohWDH590LBagJJjnFmR5bW0j2UtobY5RgrHbHsveP4RgxavVwPD2KICGFkBc9CGx/K1ZaXIQNusHlbXy4AyLCTZeNTtR44M6bUUd8UmEcXRMA/MUfu3JgmC8sM8Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746227855; c=relaxed/simple;
	bh=MT4cQ2Kepl/3IHBa1rID9segMykEbKM11+oqHqJPznk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTg8xXzUgac2S8AQBKvYdWAktKPsCpX+3hlL8jIgZ5R6m+G55pm3cHZvt44zVHraVode5Uzkqt8/X+wm8+xu/45cyVgygJhUIiqeL/fC7qnkXMWdx0uZkmqcoBSHHGNFx0IzP5CqstLOhexnEbGKUwsq0AF28oR4861l8UAIz/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLeo8bHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00D3C4CEE4;
	Fri,  2 May 2025 23:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746227855;
	bh=MT4cQ2Kepl/3IHBa1rID9segMykEbKM11+oqHqJPznk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mLeo8bHISS/T3aqPSzmyjr7Z+FIwQcf95rtPjXxIvq2a3lRu1/WvUai8nhIiG8osU
	 wykTmzV9x9ylWV2aU3rYXgsOcyXMasS2HE4cjN8rH3wKhR3pK6yMVo/HH9zb1bZR0h
	 08xdHY1GTXy4USQ8YzRtbn87TP3zHiBaJkI44LjbmDl6oVsyX94Xc/YvfedYv+6Ftu
	 xKBWSJQHSSlDdjiXUHD9Ot1s1hK2mMiRtDu+Dhv53nJgkQYqICrD0aWiFxdgS3Segz
	 RAn5F7aNUFPmGnvD6EQZtxtITsyfE8UeyegIcBC6N3aq8N9Hf3bwwQtOlMEFdyCntv
	 2zNEQXowr9K+w==
Date: Fri, 2 May 2025 16:17:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@toke.dk>, kernel-team@cloudflare.com, mfleming@cloudflare.com
Subject: Re: [PATCH net-next V1] net: track pfmemalloc drops via
 SKB_DROP_REASON_PFMEMALLOC
Message-ID: <20250502161733.17fd0d60@kernel.org>
In-Reply-To: <174619899817.1075985.12078484570755125058.stgit@firesoul>
References: <174619899817.1075985.12078484570755125058.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 May 2025 17:16:38 +0200 Jesper Dangaard Brouer wrote:
> @@ -142,15 +144,20 @@ int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap)
>  	 */
>  	if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
>  		NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
> +		*reason = SKB_DROP_REASON_PFMEMALLOC;
>  		return -ENOMEM;
>  	}
>  	err = BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb);
> -	if (err)
> +	if (err) {
> +		*reason = SKB_DROP_REASON_SOCKET_FILTER;
>  		return err;
> +	}
>  
>  	err = security_sock_rcv_skb(sk, skb);
> -	if (err)
> +	if (err) {
> +		*reason = SKB_DROP_REASON_SECURITY_HOOK;
>  		return err;
> +	}
>  
>  	rcu_read_lock();
>  	filter = rcu_dereference(sk->sk_filter);

there is:

	err = pkt_len ? pskb_trim(skb, max(cap, pkt_len)) : -EPERM;

later on, which I think may return error without touching drop reason.
If caller didn't init it the reason will be undefined.
-- 
pw-bot: cr

