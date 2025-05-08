Return-Path: <bpf+bounces-57720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24767AAF0AE
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 03:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C154C811D
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 01:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638851BD4F7;
	Thu,  8 May 2025 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBTeVlVG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82E34B1E6F;
	Thu,  8 May 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746668408; cv=none; b=Wmg+cmM+2JY6/yspEvU3WL3Sv7dfPEi1pYhF4wogyrD/u/wLht5nbVjvXFTP5hOXMLMvtzMiVE0eJ8KwPUddP3gplMHgaJZUeveGX9vh19dluLm7EcPDZnkIWcd3urX2JNj5be29cSsnnsiTvauLVQBEQc/g73RMkzALjhXWClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746668408; c=relaxed/simple;
	bh=SYSL3CqLFqQ5L+DAxnRJM/O+kSR8EiapwRLyicH6VJI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VY6kktHnqrJ61WE/vD/XEMkXRrnmwH9F6vlADUJwNHBNIXnNXcTzvixg2pT2h7psQ/6VYu0CeeQcfi9Y8zEwuY4aR6cKAIgli5FenmVv42ssIk8kXCyFygZO+eXd0eqVzHPexvqB7IPXe0bGyCelRaICzsANwyWtBagoQgVZGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBTeVlVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC805C4CEE2;
	Thu,  8 May 2025 01:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746668407;
	bh=SYSL3CqLFqQ5L+DAxnRJM/O+kSR8EiapwRLyicH6VJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZBTeVlVGdT9P1cL+mzAyNaKZAC5hHkaW0XkUsRMAZepSRIgKzAUIV/+sRpcmqfgfQ
	 kjbwLy8dDg7AunLxf2e19es2T/cZkmdMIbphdCiBjPYO4qZ5eJbT55dapzwyZ5tjs8
	 sQM7JWW4TDCvDN4BDJ4IKbVSGX5spb/U146lzc7yAk+nj7/L0VpnvCTXt/NiDXwCoo
	 JsPIIJB++5W2+mtgfzwc7k9QAJ/aYvnLX1jr1HnPj73ZOlN+qoLXjMgdAuQHUG8xyh
	 4juP/fa0VRfhc+akGXr5V2A4pviXNj7GRkPVRjsTD2zp9ZK46/Um7jcRXno65eoXGa
	 hrKldZYlQ0Nfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD9380AA70;
	Thu,  8 May 2025 01:40:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] Bug fixes from XDP patch series
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174666844624.2418694.14482147133138763410.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 01:40:46 +0000
References: <20250506110546.4065715-1-m-malladi@ti.com>
In-Reply-To: <20250506110546.4065715-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: namcao@linutronix.de, horms@kernel.org, john.fastabend@gmail.com,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 vigneshr@ti.com, rogerq@kernel.org, danishanwar@ti.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 6 May 2025 16:35:43 +0530 you wrote:
> This patch series fixes the bugs introduced while adding
> xdp support in the icssg driver, and were reproduced while
> running xdp-trafficgen to generate xdp traffic on icssg interfaces.
> 
> v1: https://lore.kernel.org/all/20250428120459.244525-1-m-malladi@ti.com/
> 
> Meghana Malladi (3):
>   net: ti: icssg-prueth: Set XDP feature flags for ndev
>   net: ti: icssg-prueth: Fix kernel panic during concurrent Tx queue
>     access
>   net: ti: icssg-prueth: Report BQL before sending XDP packets
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net: ti: icssg-prueth: Set XDP feature flags for ndev
    https://git.kernel.org/netdev/net/c/e5641daa0ea1
  - [net,v2,2/3] net: ti: icssg-prueth: Fix kernel panic during concurrent Tx queue access
    https://git.kernel.org/netdev/net/c/8b3fae3e2376
  - [net,v2,3/3] net: ti: icssg-prueth: Report BQL before sending XDP packets
    https://git.kernel.org/netdev/net/c/1884fc85ae6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



