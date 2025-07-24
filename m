Return-Path: <bpf+bounces-64230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84220B0FE94
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 04:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA52B58815D
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 02:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7259B1A5B84;
	Thu, 24 Jul 2025 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZpVLHS3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A518DB02;
	Thu, 24 Jul 2025 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753322423; cv=none; b=BDK8MMcQJsROla0tAso9qMoof9sOwmqLcs0C87Y6ARkKbYNvrXDBPXU2j0jlwh8yJmkeS0Ai8c/J7hSnlSuLL1k+BPEI/xjU8lNzyAeGhej8qBZmYo1MoyFeDmDp+iY7c1dsimkHkZJ+D7XNNmkiqNTgV016F6fKLfivpJA8DJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753322423; c=relaxed/simple;
	bh=BpiBxoeu56d35+/JzOYrXKdHXbJJT/hxC16C6lp6gcA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c8/wn9trpgTF+jGw3d0JfMdYKisQsq+YDEfk34uzE1+mnI8TFIkd1oeALKeqP6T8SQq32jWm9gTb4pBjG4v8ShoX4/tOTp43mDV0VQMFyaziOk2BhYWdBgQnv2QrzGYSv1nLQrnvhNYvh0KJyyPvff/DFEVJWtDVKFxujbrsowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZpVLHS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766C4C4CEEF;
	Thu, 24 Jul 2025 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753322423;
	bh=BpiBxoeu56d35+/JzOYrXKdHXbJJT/hxC16C6lp6gcA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FZpVLHS3icbEQYbRG1+helDdBFX+wQpCFSiakNNIv0ThNYsWN8+wKwU2x1N3sV8Gv
	 DXyX6qd9uvS9jbrnH0u1AgyvOaQft9DZtNjlPlsDXjoox7TvcPgZF/8wxi/eoD80UI
	 pIvFlEM4HcIYFB8rWvVJbTSH6/DXIoGZ9E25Df4gXS0SPlyC1AGBcuDyjGXIo4nkX8
	 X35iuPt2DKaZYuJFYaIKvTAJD2ICgAWE1rhevidTMwzKKjRKBODq2DoqE4ZEKRvMtb
	 TxPoHsoPDEoXYaEYxkkgSrElK9ZWMvipIX7CN8ER7eNLHuBZQez7JQAhtnpZdBVBWh
	 97HvXJttZJJ3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9E383BF4E;
	Thu, 24 Jul 2025 02:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 00/12] Split netmem from struct page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175332244124.1844642.1793292791852018522.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 02:00:41 +0000
References: <20250721021835.63939-1-byungchul@sk.com>
In-Reply-To: <20250721021835.63939-1-byungchul@sk.com>
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, akpm@linux-foundation.org,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com,
 david@redhat.com, Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, vishal.moola@gmail.com, hannes@cmpxchg.org,
 ziy@nvidia.com, jackmanb@google.com, wei.fang@nxp.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
 tariqt@nvidia.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, danishanwar@ti.com, rogerq@kernel.org,
 nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, aleksander.lobakin@intel.com,
 horms@kernel.org, m-malladi@ti.com, krzysztof.kozlowski@linaro.org,
 matthias.schiffer@ew.tq-group.com, robh@kernel.org, imx@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Jul 2025 11:18:23 +0900 you wrote:
> Hi all,
> 
> The MM subsystem is trying to reduce struct page to a single pointer.
> See the following link for your information:
> 
>    https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> 
> [...]

Here is the summary with links:
  - [net-next,v12,01/12] netmem: introduce struct netmem_desc mirroring struct page
    https://git.kernel.org/netdev/net-next/c/f3d85c9ee510
  - [net-next,v12,02/12] netmem: use netmem_desc instead of page to access ->pp in __netmem_get_pp()
    https://git.kernel.org/netdev/net-next/c/38a436d4e264
  - [net-next,v12,03/12] netmem, mlx4: access ->pp_ref_count through netmem_desc instead of page
    https://git.kernel.org/netdev/net-next/c/89ade7c73065
  - [net-next,v12,04/12] netdevsim: access ->pp through netmem_desc instead of page
    https://git.kernel.org/netdev/net-next/c/6fd824342a57
  - [net-next,v12,05/12] mt76: access ->pp through netmem_desc instead of page
    https://git.kernel.org/netdev/net-next/c/87dda483e63f
  - [net-next,v12,06/12] net: fec: access ->pp through netmem_desc instead of page
    https://git.kernel.org/netdev/net-next/c/65589e860a80
  - [net-next,v12,07/12] octeontx2-pf: access ->pp through netmem_desc instead of page
    https://git.kernel.org/netdev/net-next/c/58831a178551
  - [net-next,v12,08/12] iavf: access ->pp through netmem_desc instead of page
    https://git.kernel.org/netdev/net-next/c/c8d6830e32eb
  - [net-next,v12,09/12] idpf: access ->pp through netmem_desc instead of page
    https://git.kernel.org/netdev/net-next/c/fc16f6a5877d
  - [net-next,v12,10/12] mlx5: access ->pp through netmem_desc instead of page
    https://git.kernel.org/netdev/net-next/c/5445a5f71209
  - [net-next,v12,11/12] net: ti: icssg-prueth: access ->pp through netmem_desc instead of page
    https://git.kernel.org/netdev/net-next/c/c0bcfabd7752
  - [net-next,v12,12/12] libeth: xdp: access ->pp through netmem_desc instead of page
    https://git.kernel.org/netdev/net-next/c/9dfd871a3e2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



