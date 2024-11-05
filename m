Return-Path: <bpf+bounces-44049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBA89BD020
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 16:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFE91F237F9
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D5F1D9A7F;
	Tue,  5 Nov 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drmVIaMt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A455E1D5CCC;
	Tue,  5 Nov 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819422; cv=none; b=fm+wRqGMo3eq5o/9cTOLuDKavUaazpK0BgE2AHgtdh5Mxd0mS7bbtNpoipK2GtfBuCpOQtJy/2CtspYbxHIoS/tsDfVHEnCG+E2MnD81ieNoIFF/RHmwzojeZ42YPuWT0Ofa8Ka9JtkzCOtD6xXl58gSevlfXjMdf2f1X+Apet0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819422; c=relaxed/simple;
	bh=o99dfV4SMS3XtqCdnRdfpVyfvsH8r6+Drt0G7+D2AOo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ALKc6JMiVxFTU76WSohP99FEtPGuPsR/0741eXflOOmV172OWPAR2+byFXHjZ9vpXTBQyo+mntJRz7jT1taJNqJ21FG35rzEVNnZaoC0ySIed+SismY8An8j/mjjzfhRiMtEakf1TtSv/NaLJ/Nq/ft9uPTR+KJj4iL2iya5fRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drmVIaMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FFDC4CECF;
	Tue,  5 Nov 2024 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730819422;
	bh=o99dfV4SMS3XtqCdnRdfpVyfvsH8r6+Drt0G7+D2AOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=drmVIaMtr4fU7FK8ZHZ6Q9CLlAOl+AHwp63zRSfw2XBzXp/zVkrmljBzJVyPcqLRa
	 5POMJLoKiwoc6qSkLZRtQdN2hQrLiUfhN8r72IeVVFKO17eMx0XDsPPCfdDtrdzDd1
	 qsS0QmmT2ECPcqhkEGE6Yl2rAQceCYcY9yzsqn7VmW8VP1I/AA1pN6Q4xaiWR92dkt
	 DpUKK9OX7wiiH68kd7gX4amc8nb+FbqY9WVEVUwrumabi9uKYzSkT8BQr+ob3ertBe
	 FVidrrFldjaxnzrMH+CuyxqcL728W0S4M0fRE0+UksaHu6IAtGGKz1ihil6mqzNoHi
	 e5MGBuYnUDa+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC03809A80;
	Tue,  5 Nov 2024 15:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: ethernet: ti: am65-cpsw: Fixes to multi
 queue RX feature
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173081943101.587715.9518854111392182116.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 15:10:31 +0000
References: <20241101-am65-cpsw-multi-rx-j7-fix-v3-0-338fdd6a55da@kernel.org>
In-Reply-To: <20241101-am65-cpsw-multi-rx-j7-fix-v3-0-338fdd6a55da@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, vigneshr@ti.com,
 maxime.chevallier@bootlin.com, s-vadapalli@ti.com, danishanwar@ti.com,
 srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 01 Nov 2024 12:18:49 +0200 you wrote:
> On J7 platforms, setting up multiple RX flows was failing
> as the RX free descriptor ring 0 is shared among all flows
> and we did not allocate enough elements in the RX free descriptor
> ring 0 to accommodate for all RX flows. Patch 1 fixes this.
> 
> The second patch fixes a warning if there was any error in
> am65_cpsw_nuss_init_rx_chns() and am65_cpsw_nuss_cleanup_rx_chns()
> was called after that.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: ethernet: ti: am65-cpsw: Fix multi queue Rx on J7
    https://git.kernel.org/netdev/net/c/de794169cf17
  - [net,v3,2/2] net: ethernet: ti: am65-cpsw: fix warning in am65_cpsw_nuss_remove_rx_chns()
    https://git.kernel.org/netdev/net/c/ba3b7ac4f714

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



