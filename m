Return-Path: <bpf+bounces-57965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9421AB208F
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 02:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3BF4E101E
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 00:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9381D5150;
	Sat, 10 May 2025 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7+jNr0H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC51A2C11;
	Sat, 10 May 2025 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746837593; cv=none; b=WUzKP5MKxTM6OihldzT5pT6qPgv+SkuiWc++844Qz/yF+Jhf/DBOZ5rSzADuxkK+vU74pIT4GvVEWDXEEYtBPuWidqg2UQTVcuSl9XlveDPNeBCxgVEhfnq2baPOBXWAXnXsRXUOcYxN4BsUn5O+OzNTvF9af61SXksdSeAbzHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746837593; c=relaxed/simple;
	bh=hU5x5nV621PCXb98dd7QNAbrE73+PaQ5xx0FQ9+8knM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ux586yeg6S6YbWY2ZJnTytPj3UPHiDbjLhM3yjwjNdwOH2edihST2yigNbOp4Ajo/O/1mvxMR3UhikDNSrExPKeA8mCFIOMp9jk4OpKz8tQ5tOAbnUU4fuOOSA4hhNQjX4XQQ0FT8VY7SDEyLNYX4R9xCu0NlwIH10FQNNBoJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7+jNr0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEDBC4CEE4;
	Sat, 10 May 2025 00:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746837593;
	bh=hU5x5nV621PCXb98dd7QNAbrE73+PaQ5xx0FQ9+8knM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A7+jNr0HNwuo15U+Nm15rn6xSLrb4t7GyjtyBFUwopRjXp4IlcaNbkKMFtZvPG6nZ
	 NulpbIMpXB5V1uGCx1zvlZoHGIP/e9UQN+kKWQBLNNlZrypakkjxhLoR6hT8PTmudr
	 1rE/xK6DCE/gFicMObwo6gZp0L9fu+L3eI8JBgJbrXdYdk/IytKRFZOVgcm7oVN+ns
	 0jNCP0VrtQwAH1JngkV+jh4TJIWinoppC9jA0a6q7MilxMZHAYiGzIoJAZeCXTKTuc
	 rgAUzEk+kAOOsuvpvVo8RRfZVEfdkJKWQBGTzxbapLMe67LpwUUXhnJ9/KWaVwvnU2
	 5ipkrFFWiCnlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB4381091A;
	Sat, 10 May 2025 00:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] Refactoring designware VLAN code. 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683763150.3852829.17036982288908409763.git-patchwork-notify@kernel.org>
Date: Sat, 10 May 2025 00:40:31 +0000
References: <20250507063812.34000-1-boon.khai.ng@altera.com>
In-Reply-To: <20250507063812.34000-1-boon.khai.ng@altera.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, 0x1207@gmail.com, matthew.gerlach@altera.com,
 tien.sung.ang@altera.com, mun.yew.tham@altera.com, rohan.g.thomas@altera.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 May 2025 14:38:09 +0800 you wrote:
> Refactoring designware VLAN code and introducing support for
> hardware-accelerated VLAN stripping for dwxgmac2 IP,
> the current patch set consists of two key changes:
> 
> 1) Refactoring VLAN Functions:
> The first change involves moving common VLAN-related functions
> of the DesignWare Ethernet MAC into a dedicated file, stmmac_vlan.c.
> This refactoring aims to improve code organization and maintainability
> by centralizing VLAN handling logic.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] net: stmmac: Refactor VLAN implementation
    https://git.kernel.org/netdev/net-next/c/1d2c7a5fee31
  - [net-next,v5,2/3] net: stmmac: stmmac_vlan: rename VLAN functions and symbol to generic symbol.
    https://git.kernel.org/netdev/net-next/c/f3acaf7364a6
  - [net-next,v5,3/3] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN stripping
    https://git.kernel.org/netdev/net-next/c/534df0c1724b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



