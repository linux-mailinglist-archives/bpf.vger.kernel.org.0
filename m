Return-Path: <bpf+bounces-49047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A3A139B9
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 13:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AB81628BC
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF30F1DB14C;
	Thu, 16 Jan 2025 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFtlBSnE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896E1DE3DC;
	Thu, 16 Jan 2025 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737029267; cv=none; b=EVaFef5pEupgz5yoxhO7XLxC4nzdlOgEJCh1cEbd+QieSSDp8ac5CECYC5jnYn0AzsJ+Cgf4vkrvaGViuBDZjN/VBneD/7lWeIam/DdMy8mUqpEO/V+cySJLxblLtyrKiypWz6t7nGPYAiAS742teJJj2DDyHxIuBTUT3X0yQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737029267; c=relaxed/simple;
	bh=u5l7iFN84eF5HNkN9uMFACXxde6ZmbV2yFMAJ0uLocc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6AfPWtbCHfWs9P8JcrOuLp0M9Bw7t0p+4YZqnQ4/9NK4GiJe/bHbqhY8iKVKqgAPBZoUVIvsZtd/UCSc+iJWX96ZyWRwLyYlw+Q0eQtlltlcbdQt3tqR/TwgQ+W8Hpf+ArVugKsB7FwEoZT1oZV4mgg/KRVw0Eg2Be+ZAni+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFtlBSnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B76AC4CED6;
	Thu, 16 Jan 2025 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737029266;
	bh=u5l7iFN84eF5HNkN9uMFACXxde6ZmbV2yFMAJ0uLocc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XFtlBSnEqaNyxOOIj8w60a11UTMi6cHZkYetmeXHr3BYN0T9QK6BUPhfFfeHVq1Me
	 Oe+9gMZGL7FbWdiEzo+f+0NRt24qd1b4aapGeh5+UJEkFauXTm1hiEdBAYLooAROP0
	 QVaJ/RWsrQb1p3EJVa1l4VS1lYinuGzsZYgj9c92KjLqyvzGP/0GRqc4mEi3j4mAeX
	 IiadCzNDdbuDpzHCS3n73HaRU0WDKSoR6qLH1UQytY6RhHmGuVCmGjEMtj2uEfFt1m
	 1dLLTka4jQkoCt2aFXbO5iMA2TRuvAPeXZyKULRhLWUmAKow5cKbuSIQh0loeLh3Hj
	 VKlp4lqHyS2Yw==
Message-ID: <c0a72a9a-3c1e-4bdf-9647-6cb9d962fad7@kernel.org>
Date: Thu, 16 Jan 2025 14:07:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net: ethernet: ti: am65-cpsw: streamline
 .probe() error handling
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com, danishanwar@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org>
 <20250115-am65-cpsw-streamline-v1-2-326975c36935@kernel.org>
 <Z4ga6N7brU1FrQzx@shell.armlinux.org.uk>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <Z4ga6N7brU1FrQzx@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/01/2025 22:30, Russell King (Oracle) wrote:
> On Wed, Jan 15, 2025 at 06:43:01PM +0200, Roger Quadros wrote:
>> Keep things simple by explicitly cleaning up on .probe() error
>> path or .remove(). Get rid of devm_add/remove_action() usage.
>>
>> Rename am65_cpsw_disable_serdes_phy() to
>> am65_cpsw_nuss_cleanup_slave_ports() and move it right before
>> am65_cpsw_nuss_init_slave_ports().
>>
>> Get rid of am65_cpsw_nuss_phylink_cleanup() and introduce
>> am65_cpsw_nuss_cleanup_ndevs() right before am65_cpsw_nuss_init_ndevs()
>>
>> Move channel initiailzation code out of am65_cpsw_nuss_register_ndevs()
>> into new function am65_cpsw_nuss_init_chns().
>> Add am65_cpsw_nuss_remove_chns() to do reverse of
>> am65_cpsw_nuss_init_chns().
>>
>> Add am65_cpsw_nuss_unregister_ndev() to do reverse of
>> am65_cpsw_nuss_register_ndevs().
>>
>> Use the introduced helpers in probe/remove.
> 
> Wow, so we're now saying that devm shouldn't be used? Given that patch 1

No. We're not getting rid of all devm_ users in the driver, just the case
for am65_cpsw_nuss_free_rx/tx_chns(). I'll explain below.

> is wrong, I'm not sure I'd trust this patch to be correct either as it
> goes against what I understand is preferred - to avoid explicit cleanups
> that can get in the wrong order or be missed.
> 

In this particular case, we had to repeatedly call devm_remove/add_action()
on am65_cpsw_nuss_free_rx/tx_chns() at multiple places as number of channel
can be changed at runtime.

I thought it would be easier to keep track of the cleanup than to keep track
of devm_remove/add_action().

Another motivation for doing so was this paragraph found in
Documentation/process/maintainer-netdev.rst:

|Netdev remains skeptical about promises of all "auto-cleanup" APIs,
|including even ``devm_`` helpers, historically. They are not the preferred
|style of implementation, merely an acceptable one.

-- 
cheers,
-roger


