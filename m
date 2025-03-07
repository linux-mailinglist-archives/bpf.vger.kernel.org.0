Return-Path: <bpf+bounces-53519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE88A55C37
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 01:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611211712AE
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 00:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3957146588;
	Fri,  7 Mar 2025 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frIgPf6w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA0813A88A;
	Fri,  7 Mar 2025 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308607; cv=none; b=n0HA3A4tAzdKEi19vAH2qhhPxEXYOhqQka1C/UGubXFFrQ78eEZzQv2mABL5x5nsuWCCtFtt+eNx9upIvV3NZuG0cJpEr5XpfKOwFrAmIEOlf/gxakwia7hlUfd9IAaPS3MeVp2Vfvh3wrYNHfSu49+B+Peik7mCHjYSc3HCu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308607; c=relaxed/simple;
	bh=5E7QrRtVE031fm+0oQBlEfIWLHzTajXqxBcwX74S8Q4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Us0fXPq0vBdF9E345wvsWWXFoLbWgssf4eg0BjhIG1BQEPcs3VxdDQwgvGpArZt2BU3LpimdOMUJX8av0m5L2T0KEhIdqUAxIpuiEHq5j7lurS06i7Zd8kOYo5bHL6Xf1S5yWdJx+RjZRMMO4CyiFQbwqIfwYEZjaNIZd9Dqhn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frIgPf6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42C9C4CEE5;
	Fri,  7 Mar 2025 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741308606;
	bh=5E7QrRtVE031fm+0oQBlEfIWLHzTajXqxBcwX74S8Q4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=frIgPf6wI9fVxTERiWPafyss4uNcBrf+ieJqOGr/EklkxPj8AM+kQ+DlxgC4qnXxK
	 F32IvEiXGrSp7TH99vvRvJ83UoD2CQgUwoBld7Gs1nrNQS53jO+MBJhoir1dhh/XKT
	 6y7BHdLmtpl9X9y6rfM1T/f5uC3japAQ267W0fkIysS3yGBP0W4BsYQLB9ItFZN2RS
	 pzG/9Uzc3Urxk5Fo2wxHUJi33DxXsWRvtzLGZhrFkJOmGfzQ003C/Tv+6xBBze5dPG
	 xMRI3t3jSd4oAFITDWyqjdzrqBmO4zd0/J7pZo4NPKI9+iTsQPP3N/rdknhgpomLAi
	 3xOBZ8PEp+dZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BD1380CFF6;
	Fri,  7 Mar 2025 00:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: avoid shadowing global buf_sz
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130864025.1835493.2395705293072394933.git-patchwork-notify@kernel.org>
Date: Fri, 07 Mar 2025 00:50:40 +0000
References: <E1tpswi-005U6C-Py@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tpswi-005U6C-Py@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 ast@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 05 Mar 2025 17:54:16 +0000 you wrote:
> stmmac_rx() declares a local variable named "buf_sz" but there is also
> a global variable for a module parameter which is called the same. To
> avoid confusion, rename the local variable.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net: stmmac: avoid shadowing global buf_sz
    https://git.kernel.org/netdev/net-next/c/876cfb20e889

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



