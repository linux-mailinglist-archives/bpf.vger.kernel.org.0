Return-Path: <bpf+bounces-59401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9ECAC98FD
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 05:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D295616A354
	for <lists+bpf@lfdr.de>; Sat, 31 May 2025 03:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E901448E0;
	Sat, 31 May 2025 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ljvns2tY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34FD1EB39;
	Sat, 31 May 2025 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748660997; cv=none; b=OAi17aS5QeBn7mLcJdGX7doR0mVOFx26qqLY87/QAaFAHuPN0kSZPfwUUSOq5sFkzuLFNdYgufmvbQKcz0MEt2OGDN2BD2e/ETFUYkg1y/A4LKbttmNrCgvhJ8hqGF/p47UB3DZg+HkwXp4ctKmu4cdPXX3ndfZ0+Fc5OHhFdzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748660997; c=relaxed/simple;
	bh=z8gZ+q37IvEpWDej+h76Rujah+rzvK1Yk/0ORMQ4eOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=We+3c6sGCboTRz0dV8/d3jy4wWBlWnQ+iqq0vLqJN7qUtOyynU79WwYcadJMimyT616b7MXQHbrsbBP4Q8rZP+P7DboCyJRKJ2r6o2xb+lmkQzqWGw03o06Zsg3Ohh+sLu9Uuek2/MqHpRt00NeCquFco2Uiq5bnwUo3xjjAfj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ljvns2tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEB3C4CEEB;
	Sat, 31 May 2025 03:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748660996;
	bh=z8gZ+q37IvEpWDej+h76Rujah+rzvK1Yk/0ORMQ4eOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ljvns2tYEp7FnoH02Ay/quaAkbUmtUORD8q6ntDbnCcVbxkuXij4gw9qL0zGbamsv
	 QiWkhB6B4o6lgQZ3G/gfpDB93wU7Rtm9uGC2RZC+CPWUU3Dr+bhjL3kVirw1ZGnruI
	 sa9vS29R97ogEWJfMtmbYExZx93Darp4ZA/M/UQIsbLiw35tq4j8PWMhfaIxtwEFDh
	 b5mZ4yUX/aWzsJe1v8/13iXZFP4wFBnAcj1Pwz6dOlth5izzEgZ0EJV8EX3lbaDoqd
	 ZiCznJW7AN+Oyry99ws/awerk1rTV9GSUACAAw4CxH2ryUS0hSWh1Yecahpmjtrp/A
	 FXIlhzfH3zJ5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0A239F1DF3;
	Sat, 31 May 2025 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v3] hv_netvsc: fix potential deadlock in
 netvsc_vf_setxdp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174866102976.15083.16967733452112171542.git-patchwork-notify@kernel.org>
Date: Sat, 31 May 2025 03:10:29 +0000
References: <1748513910-23963-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1748513910-23963-1-git-send-email-ssengar@linux.microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, kuniyu@amazon.com, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 ssengar@microsoft.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 May 2025 03:18:30 -0700 you wrote:
> The MANA driver's probe registers netdevice via the following call chain:
> 
> mana_probe()
>   register_netdev()
>     register_netdevice()
> 
> register_netdevice() calls notifier callback for netvsc driver,
> holding the netdev mutex via netdev_lock_ops().
> 
> [...]

Here is the summary with links:
  - [net,v3] hv_netvsc: fix potential deadlock in netvsc_vf_setxdp()
    https://git.kernel.org/netdev/net/c/3ec523304976

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



