Return-Path: <bpf+bounces-27668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC0A8B0814
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 13:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5DF41F227A0
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C710C15B10D;
	Wed, 24 Apr 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLRpz56F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD515ADBC;
	Wed, 24 Apr 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957032; cv=none; b=lLlyj+LRTh1Sc7cylkYC44DDysd1GAUcuO+vgqXJ0UgFP1gIs/8K6WfPKDArs+MVYiCwMnUJZMTitff4vj1/6stwVJMsWYDoj9zEHZs/h9E8Idf90gZatYsEsOylSv5rqeJcohjtXYcn93O+YLEm5v0+Zr0IxMBsOgxJXgxTK8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957032; c=relaxed/simple;
	bh=5gH5c9GDDi9WLsKl6Z7sGCJeqtsVrGwX2qo4yjbesBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dg6ghaoKeDVST+B9NflYTEASFoXyO8NnPfJFS03QhDLapRcS0BO8CdCMUngg0XC4fQEjPmDvAD/gjftxxiKmDECFNYJRSDl27UennCUjSkpvQY/2godHFtOPgObeIlbuAr6kpEncYMDiY/PinoRwHBj44eXADoUYdi+WBCZoau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLRpz56F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9438C4AF16;
	Wed, 24 Apr 2024 11:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713957031;
	bh=5gH5c9GDDi9WLsKl6Z7sGCJeqtsVrGwX2qo4yjbesBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lLRpz56F9j55d+6+qu39aNUTMLy7csK6asaF+R997D3H77neV+fKWIP1P0g9HC7MX
	 vGJzItw+ps3IDad3rYSXgqM1wQcZ92403W39GmvmGPSo4K3DqEchhOSBKmn3WmEzn8
	 uWggEcPmCuqGgl3/IfYvFqD7ygaPulhp64ijkE8vgY5UDpOSfTu8/rnaAs1sxvS4lz
	 D/qRuYL9JdEKYX8aSTSV4yd8zwI/wxWow/6s5PCtgnmOLYujO0BSP5opoGCyF/EjSZ
	 n+KSCP7uroT83MKzNEyHF9oin4czDsVB0TennMitDo/oVxQUBgSAB6N6LjfJZ7Yq07
	 0z+uVazcvXK+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BADCCCF21D8;
	Wed, 24 Apr 2024 11:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 00/10] allocate dummy device dynamically
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171395703175.12181.16297886360257972212.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 11:10:31 +0000
References: <20240422123921.854943-1-leitao@debian.org>
In-Reply-To: <20240422123921.854943-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: aleksander.lobakin@intel.com, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, elder@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, taras.chornyi@plvision.eu, ath11k@lists.infradead.org,
 ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 geomatsi@gmail.com, kvalo@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, quic_jjohnson@quicinc.com,
 leon@kernel.org, dennis.dalessandro@cornelisnetworks.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 idosch@idosch.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 22 Apr 2024 05:38:53 -0700 you wrote:
> struct net_device shouldn't be embedded into any structure, instead,
> the owner should use the private space to embed their state into
> net_device.
> 
> But, in some cases the net_device is embedded inside the private
> structure, which blocks the usage of zero-length arrays inside
> net_device.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,01/10] net: core: Fix documentation
    https://git.kernel.org/netdev/net-next/c/c6e7f276841d
  - [net-next,v7,02/10] net: free_netdev: exit earlier if dummy
    https://git.kernel.org/netdev/net-next/c/f8d05679fb3f
  - [net-next,v7,03/10] net: create a dummy net_device allocator
    https://git.kernel.org/netdev/net-next/c/c661050f93d3
  - [net-next,v7,04/10] net: marvell: prestera: allocate dummy net_device dynamically
    https://git.kernel.org/netdev/net-next/c/ec24c06eb312
  - [net-next,v7,05/10] net: mediatek: mtk_eth_sock: allocate dummy net_device dynamically
    https://git.kernel.org/netdev/net-next/c/b209bd6d0bff
  - [net-next,v7,06/10] net: ipa: allocate dummy net_device dynamically
    https://git.kernel.org/netdev/net-next/c/1bdab0ee635d
  - [net-next,v7,07/10] net: ibm/emac: allocate dummy net_device dynamically
    https://git.kernel.org/netdev/net-next/c/2eb5e25d8495
  - [net-next,v7,08/10] wifi: qtnfmac: Use netdev dummy allocator helper
    https://git.kernel.org/netdev/net-next/c/4a8b77eff7e5
  - [net-next,v7,09/10] wifi: ath10k: allocate dummy net_device dynamically
    https://git.kernel.org/netdev/net-next/c/57738dab12d9
  - [net-next,v7,10/10] wifi: ath11k: allocate dummy net_device dynamically
    https://git.kernel.org/netdev/net-next/c/bca592ead825

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



