Return-Path: <bpf+bounces-75094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABC7C7042A
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 17:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 812383671A3
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA7A23EA84;
	Wed, 19 Nov 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKpEtYw8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D00350288;
	Wed, 19 Nov 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570446; cv=none; b=G7i2y5iRsfLeB60iV5QaudXThflcz3H1SlyhN8czaxFAhLu9s1enKR/f17BQf1/NlmY/d6/biLP+/COVDD9dll4eJhXzwQl8JhSx1SYu3KC5EBGf4F/YGu3VO0cnMU4Fzgeg28jSSpBEHO70qf41a6gK4c0M/HJiFRDuitE5g4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570446; c=relaxed/simple;
	bh=fdxXRZqA2QPN/W/iwYUC/9zToFGBrYm7yidpHfVZkhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aVLFwTXduCcrf3VnPvS2G6iQ7DL/4RBMKQysYzZbfBnnflXsOTzGIwT/DPkBrGASqBehYy/SVku1yh0yfXixbQZTZ4g47fpC2dqj70FlW5T5uy/mNJ0X2oC6mDPQrBpRRSmXw+iKmQRHJ/iUDpjIURO4XzWRje8ymTvKcUM6kJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKpEtYw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC62C4CEF5;
	Wed, 19 Nov 2025 16:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763570445;
	bh=fdxXRZqA2QPN/W/iwYUC/9zToFGBrYm7yidpHfVZkhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gKpEtYw8KOkIvyuu0VFrr8xOb4ZPSc2WhNnq1CuLIiBfYmHq5Y1gbjFZwO+5n3r3X
	 g57XiBKwLzYdNVA+U8+1eiEfnl6ETyJz/JZ6SqLIl6MvlcHWu8gBd68YEZA8FV/fiL
	 CHgDHWyB9V1NCSCee90Lxb2zXD8Ttoj21KFZRpRFhs/cB9D81nbfxw/ZTKGsUoCh3P
	 xELKAE38HteAneQhsTqaCusJomZTgYK1JyoKLMCEVg/2STnjdoHd2zaP8vIeExMr79
	 D8gvAPZNtoi+RDrghNa590rhFIF2CdVfOTyRuXCGyd3NXUupfS8cpLw2a+h3oQmRSI
	 ZHYcBt9Y0NRdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710B839D0C22;
	Wed, 19 Nov 2025 16:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: convert priv->sph* to boolean and
 rename
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176357041126.873046.11074623716236864582.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 16:40:11 +0000
References: <E1vLIDN-0000000Evur-2NLU@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vLIDN-0000000Evur-2NLU@rmk-PC.armlinux.org.uk>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 ast@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Nov 2025 09:41:33 +0000 you wrote:
> priv->sph* only have 'true' and 'false' used with them, yet they are an
> int. Change their type to a bool, and rename to make their usage more
> clear.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  4 +--
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 26 +++++++++----------
>  .../stmicro/stmmac/stmmac_selftests.c         |  2 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_xdp.c  |  2 +-
>  4 files changed, 17 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [net-next] net: stmmac: convert priv->sph* to boolean and rename
    https://git.kernel.org/netdev/net-next/c/7ac60a14d3fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



