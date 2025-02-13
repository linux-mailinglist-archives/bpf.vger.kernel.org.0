Return-Path: <bpf+bounces-51353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E31A336CB
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 05:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9967E160B19
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 04:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3794D2063E1;
	Thu, 13 Feb 2025 04:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfjE/buZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C8205E06;
	Thu, 13 Feb 2025 04:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739420405; cv=none; b=O/WEPmQQvIXDHprC0JkXO16jgcUSAV6vYdcKUNa/4PBAtGhWiiCkPetOCDE3lIiwtwuwyvvU6YnUIEBDGANJ6lxCtpDuDuZLOWzmKXv5V561JzhHfMW9E3LjdF7AeSnGC72ntQyVVZeoq2TQ4oD/AdCBGd77GcXh5gGK6JKUbWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739420405; c=relaxed/simple;
	bh=bjSCGrmWNMilgXiQmIt3KRO4pWmHExhrjp6Mu3UMW4Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BkTcdiUh+KswZTU+jOjJy9KM2GTa99uENZRTsrj/ItgCPElzLu6fmB1CHgSQ3sZRPEpHPy3n9NztxdGhuMukCC1mFaUal7rZO52uYE1Ylt+bN3An1+P41b1j8t483mTXgl0zrwn9Wpa+NrNj+LqKEOFDxsL5+RZ3seg9RKEjG4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfjE/buZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634E2C4CEE4;
	Thu, 13 Feb 2025 04:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739420405;
	bh=bjSCGrmWNMilgXiQmIt3KRO4pWmHExhrjp6Mu3UMW4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jfjE/buZmVS6rstX4y1DQgau5bbi366OoFY1W4NtCzvsxUuPYoAP9OhNcGqPU0gm0
	 XVI2HHsV+rgt4J3k5nQdDCiowOR8PLr9k2gFMEY3P3lrHldgiNcnJ+f2zGZ4yJPBZI
	 us7BSN4Z9aisSMyGrWPR+IYLZTWcMh8dSby9TI2Z8+wsKIDlamorBP6QcfnpMW9gEY
	 TsenVtgmMekBXK10qks/Uz5uIjuF+8Fh7zOdDxj5fQR8aqpN3yyBW/lmwIbBHTslrG
	 Y1l3p3iflLh8RGqMPgDlaVn7s6y9H3nrzdsF+RpicodiItJXdbJsmAH0sPpE9WDSqL
	 AcvDvelbZeDaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1B0380CEDC;
	Thu, 13 Feb 2025 04:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] net: ethernet: ti: am65-cpsw: XDP fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173942043451.758662.5732108126085501729.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 04:20:34 +0000
References: <20250210-am65-cpsw-xdp-fixes-v1-0-ec6b1f7f1aca@kernel.org>
In-Reply-To: <20250210-am65-cpsw-xdp-fixes-v1-0-ec6b1f7f1aca@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, jpanis@baylibre.com,
 jacob.e.keller@intel.com, danishanwar@ti.com, s-vadapalli@ti.com, srk@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 16:52:14 +0200 you wrote:
> Hi,
> 
> This series fixes memleak and statistics for XDP cases.
> 
> cheers,
> -roger
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: ethernet: ti: am65-cpsw: fix memleak in certain XDP cases
    (no matching commit)
  - [net,2/3] net: ethernet: ti: am65-cpsw: fix RX & TX statistics for XDP_TX case
    https://git.kernel.org/netdev/net/c/8a9f82ff15da
  - [net,3/3] net: ethernet: ti: am65_cpsw: fix tx_cleanup for XDP case
    https://git.kernel.org/netdev/net/c/4542536f664f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



