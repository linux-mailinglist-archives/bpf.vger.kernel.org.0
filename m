Return-Path: <bpf+bounces-40544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882A2989BA8
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 09:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345CD1F2144B
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 07:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D8115C144;
	Mon, 30 Sep 2024 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Nn8leL/q"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD29721105;
	Mon, 30 Sep 2024 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681813; cv=none; b=Y89Eq+GJjjkfK09ei8ikw3ivkRj9zhlspt0IzJbRvkl8O81+Fei1FoLHKjvLr9qxpW6+LqBx8SC2yrHgCBjVqN+jM79GCmYx1hO23xk+dPPmyjhLaOopBagJ0RUjQXXacgOKxxxgZZwQZp6g2fDyYdKPtupCM7TItuTPouJTn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681813; c=relaxed/simple;
	bh=um1tO7yPe6lanquOSmonCyC+iddX9cPeHGSY6pn/DDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJqfbF2gnu2bR9HC2kOs241oq0AC69j1c/Mo0mE8aVvBug9YR3zzAARhHvvvCEyPNMWtkgE2FwjEeMlA4qDSdKp1Y9Eljax+9xBbbl4gNEBnhH05S2aDUWj1T6balL8tDDaLhjFn/I5PZawjjFZRqiJY4nGmiQocGaPHKZs9l5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Nn8leL/q; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=wDovo+tFomF7bMi/0L+PtEMdVXxkZUmvFiFypxxGh6E=; b=Nn8leL/qROiP5Yy9Mc7HxdvzRp
	LepsFPKOC2Yo/cOvBlM6R6rV5nceAx5b4yGz8xLxNcLO5t93vEDsaIa9REFX+zajFy/S1kuvTgtGJ
	wmpogi78VKaGI+DgQEnbqtl3qKZEKOY3+i78R/l17SQk9u4lUiQ3VqDcoBB217q0aQ/30p6Tj2zrT
	wgEgqNL5T6YF0Oex1QPhf8YqSf5fe1aD9IlqPDPucgYMjmfnoBcRI0M3LJIvw7+jzOxzk9VxVPFWf
	sZpeXovzdwrB7JnbLkduWBinK6j+czRoL62cCLkuU3v0yFIyQeQgZEBna55el/dgq86vv6NW/yyTN
	dhF3pIcQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1svAxT-000IFU-VQ; Mon, 30 Sep 2024 09:36:39 +0200
Received: from [178.197.249.44] (helo=[192.168.1.114])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1svAxS-0008Fm-2d;
	Mon, 30 Sep 2024 09:36:39 +0200
Message-ID: <cb613257-75c5-4bcf-9daa-c3f5d9a83186@iogearbox.net>
Date: Mon, 30 Sep 2024 09:36:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] bpf: Prevent infinite loops with bpf_redirect_peer
To: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>
References: <20240929170219.1881536-1-jrife@google.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20240929170219.1881536-1-jrife@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27412/Sun Sep 29 10:48:04 2024)

On 9/29/24 7:02 PM, Jordan Rife wrote:
> It is possible to create cycles using bpf_redirect_peer which lead to an
> an infinite loop inside __netif_receive_skb_core. The simplest way to
> illustrate this is by attaching a TC program to the ingress hook on both
> sides of a veth or netkit device pair which redirects to its own peer,
> although other cycles are possible. This patch places an upper limit on
> the number of iterations allowed inside __netif_receive_skb_core to
> prevent this.
>
> Signed-off-by: Jordan Rife <jrife@google.com>
> Fixes: 9aa1206e8f48 ("bpf: Add redirect_peer helper")
> Cc: stable@vger.kernel.org
> ---
>   net/core/dev.c                                | 11 +++-
>   net/core/dev.h                                |  1 +
>   .../selftests/bpf/prog_tests/tc_redirect.c    | 51 +++++++++++++++++++
>   .../selftests/bpf/progs/test_tc_peer.c        | 13 +++++
>   4 files changed, 75 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index cd479f5f22f6..753f8d27f47c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5455,6 +5455,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>   	struct net_device *orig_dev;
>   	bool deliver_exact = false;
>   	int ret = NET_RX_DROP;
> +	int loops = 0;
>   	__be16 type;
>   
>   	net_timestamp_check(!READ_ONCE(net_hotdata.tstamp_prequeue), skb);
> @@ -5521,8 +5522,16 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>   		nf_skip_egress(skb, true);
>   		skb = sch_handle_ingress(skb, &pt_prev, &ret, orig_dev,
>   					 &another);
> -		if (another)
> +		if (another) {
> +			loops++;
No, as you mentioned, there are plenty of other misconfiguration 
possibilities in and
outside bpf where something can loop in the stack (or where you can lock 
yourself
out e.g. drop-all).

