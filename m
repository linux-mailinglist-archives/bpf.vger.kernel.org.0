Return-Path: <bpf+bounces-44610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7559C560F
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 12:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418601F2210D
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA89E21FD8D;
	Tue, 12 Nov 2024 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRouAyQD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4503821FD95;
	Tue, 12 Nov 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408622; cv=none; b=HrfXnxf2DEIKMddbkKmaOo4HKwdTeLUdXpVo+5RrEsO8MGsFLOnnkH8eUkMma0eL50oWmkqU/KhpWEJRaZVKse04OyCjcX87btTday3V3W9iMQtZ4g6I3iYZbz7svwDWeQ63bV6BNC/mcVGRluAj8ZnI+RhjYNVq/TVqeNWVqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408622; c=relaxed/simple;
	bh=KJ2F7sc2bf+xv1D/2D+hIJxzrNK6jbesAQAvmCnlx5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B9nRZdzVNo/D2NQPKOrepGYW72r2oLLk0a4tp1XUCdToke6L7v13kX0EcSEP8zGtVmdo3znXPMW8/bt8Fbn1lX4WbbYp4Ed1xJj2415MqaarC/wV3FTQ67QW4eMTICMLGKbjDy/EIEaDkElvM8+JA2R5vCbU8meQtFcYtVr9F4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRouAyQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDE4C4CECD;
	Tue, 12 Nov 2024 10:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731408621;
	bh=KJ2F7sc2bf+xv1D/2D+hIJxzrNK6jbesAQAvmCnlx5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oRouAyQDUPBGdu5xet77fXKCQrGNTYLitrbvb3S9EB8YGWSfVX2Y1zPewarNRQVcd
	 40OkvXMnkRyfBGS+SLsq/HQuaJaFLmjRCoen/ST58PNlV+EEIMv6+y49b8Nqqvd2GT
	 i2ecONHDXWVRwZBpCc66xPCt3/LJICE5+5AQpMAkLLCedezx9KWJnt4bf9Z+90gMHD
	 axbfQfTRI2G3ushpeQq+aOj6m49tpmxEVXliMd7sEpkeqZ1U8EkhLlJ2eiTlKkMMyW
	 SNimJ0v5/d2gevDQ6juWhEypqWvp4ZnGwjFRsiB8p9CdbELP8Ks0xwl/3HGBdNA78f
	 AJXjpuEFTRLYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DEC3809A80;
	Tue, 12 Nov 2024 10:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/9] net: ip: add drop reasons to input route
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173140863199.479628.7032457382507846655.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 10:50:31 +0000
References: <20241107125601.1076814-1-dongml2@chinatelecom.cn>
In-Reply-To: <20241107125601.1076814-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, dsahern@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org,
 gnault@redhat.com, bigeasy@linutronix.de, hawk@kernel.org, idosch@nvidia.com,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  7 Nov 2024 20:55:52 +0800 you wrote:
> In this series, we mainly add some skb drop reasons to the input path of
> ip routing, and we make the following functions return drop reasons:
> 
>   fib_validate_source()
>   ip_route_input_mc()
>   ip_mc_validate_source()
>   ip_route_input_slow()
>   ip_route_input_rcu()
>   ip_route_input_noref()
>   ip_route_input()
>   ip_mkroute_input()
>   __mkroute_input()
>   ip_route_use_hint()
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/9] net: ip: make fib_validate_source() support drop reasons
    https://git.kernel.org/netdev/net-next/c/37653a0b8a6f
  - [net-next,v5,2/9] net: ip: make ip_route_input_mc() return drop reason
    https://git.kernel.org/netdev/net-next/c/c6c670784b86
  - [net-next,v5,3/9] net: ip: make ip_mc_validate_source() return drop reason
    https://git.kernel.org/netdev/net-next/c/d46f827016d8
  - [net-next,v5,4/9] net: ip: make ip_route_input_slow() return drop reasons
    https://git.kernel.org/netdev/net-next/c/5b92112acd8e
  - [net-next,v5,5/9] net: ip: make ip_route_input_rcu() return drop reasons
    https://git.kernel.org/netdev/net-next/c/61b95c70f344
  - [net-next,v5,6/9] net: ip: make ip_route_input_noref() return drop reasons
    https://git.kernel.org/netdev/net-next/c/82d9983ebeb8
  - [net-next,v5,7/9] net: ip: make ip_route_input() return drop reasons
    https://git.kernel.org/netdev/net-next/c/50038bf38e65
  - [net-next,v5,8/9] net: ip: make ip_mkroute_input/__mkroute_input return drop reasons
    https://git.kernel.org/netdev/net-next/c/d9340d1e0277
  - [net-next,v5,9/9] net: ip: make ip_route_use_hint() return drop reasons
    https://git.kernel.org/netdev/net-next/c/479aed04e84a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



