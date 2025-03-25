Return-Path: <bpf+bounces-54633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3077A6F797
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 12:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8D93AEC88
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 11:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FD52566E8;
	Tue, 25 Mar 2025 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGJRZLy1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883031E5B91;
	Tue, 25 Mar 2025 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903399; cv=none; b=oADPqe4pX9MF7fZopanPJtisygDnPS7Gg16hJSystu0rOMKL3KOZsGF11njWVGMgKoNgCkIEgaObGVBUHKR58RPxHzUk1/gv4DBmRplhqdvfLyirtxmmI/GQv44s9Vcm7pT/4T7vpX/+d5N/fgRIXcqqPtSZX0oswlfnpJUiIFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903399; c=relaxed/simple;
	bh=ZZdZYmOj1ovGoh5945Z2dttRqyMKc3WTfbIx0vwUbGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f7m5Q0R9ZBGOQxBlSSbj+2WUaaoXU9yWvwTZibMqs38BBVDUKr46WG3fojAxDoXKvb31yW8Jk/OCfSwAIrmLzbKbcN+P08GPCBm0GGGkK0UktyNKw2A7+AiJZ8KwLq1mJ5GtqZeiki3BQCrW23kjxlYPFzXuIaWiPvElUfpEnLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGJRZLy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08523C4CEE4;
	Tue, 25 Mar 2025 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742903399;
	bh=ZZdZYmOj1ovGoh5945Z2dttRqyMKc3WTfbIx0vwUbGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gGJRZLy1WGT9Tlf+yIt17XTtbRhH1gW691Kv6DYWjKAY4BItY+DhyvHWMw5kkvaoL
	 KKsPEXE9qRjWO3l1qgg7swuhUQzYBPxB1XcIvus+PE/QNvk+bvElBA9WlxrowNC+3J
	 Y/E1Rxuk9kjweHN8UdkGlc5m2rSLwZIvT/4rpNOvPNwFhbJQndITX5eMQtV83H0FeO
	 S6YgvuRJjN/6+ry/NbXtK79Sr+qsVpn1E7JVmhX4DfDtQ5yTeMmIqsK6sizO53MYAZ
	 txFuebDaPwmCa22+MNq5Qg9wExdULRD/Zznoan+rsGvmEgpC921giO5iaFVjMikx8c
	 dcr43+rM0WDCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71530380CFE7;
	Tue, 25 Mar 2025 11:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] net: xdp: Add missing metadata support for
 some xdp drvs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174290343526.531918.1341302638467898392.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 11:50:35 +0000
References: <20250318-mvneta-xdp-meta-v2-0-b6075778f61f@kernel.org>
In-Reply-To: <20250318-mvneta-xdp-meta-v2-0-b6075778f61f@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 linux@armlinux.org.uk, ilias.apalodimas@linaro.org,
 kojima.masahisa@socionext.com, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com, nbd@nbd.name,
 sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 s-vadapalli@ti.com, rogerq@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-omap@vger.kernel.org, michal.kubiak@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Mar 2025 12:46:04 +0100 you wrote:
> Introduce missing metadata support for some xdp drivers setting metadata
> size building the skb from xdp_buff.
> Please note most of the drivers are just compile tested.
> 
> ---
> Changes in v2:
> - Improve commit logs for each patch specifying xdp headroom size for
>   each modified driver.
> - Link to v1: https://lore.kernel.org/r/20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] net: mvneta: Add metadata support for xdp mode
    https://git.kernel.org/netdev/net-next/c/07b2fbffaaea
  - [net-next,v2,2/7] net: mvpp2: Add metadata support for xdp mode
    https://git.kernel.org/netdev/net-next/c/9a45e193c88a
  - [net-next,v2,3/7] net: netsec: Add metadata support for xdp mode
    https://git.kernel.org/netdev/net-next/c/a5fec3c88142
  - [net-next,v2,4/7] net: octeontx2: Add metadata support for xdp mode
    https://git.kernel.org/netdev/net-next/c/33bfff8fc8ba
  - [net-next,v2,5/7] net: ethernet: mediatek: Add metadata support for xdp mode
    https://git.kernel.org/netdev/net-next/c/74fb1346bc77
  - [net-next,v2,6/7] net: mana: Add metadata support for xdp mode
    https://git.kernel.org/netdev/net-next/c/c313d35f60c1
  - [net-next,v2,7/7] net: ti: cpsw: Add metadata support for xdp mode
    https://git.kernel.org/netdev/net-next/c/b3a54be70ca6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



