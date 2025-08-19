Return-Path: <bpf+bounces-66008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3C9B2C42A
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 14:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C331188D295
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A1933769C;
	Tue, 19 Aug 2025 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkU4T5V1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5951F8733;
	Tue, 19 Aug 2025 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607797; cv=none; b=u5KXRZFF/pcgi1FZbAir5tJIY6jmu8VsBPL9mnIuSb1z0a5lJ0gTPOpvyTXaSgjTD+b/BwLB1accFYr3OPDu3p0ijcmEhefhJxqpysrdBVb7xUDyWa2dig1mcANviDBvOCSAAYg3ylXY7maJELzT2KLizLcntZZJMMa/4t2cwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607797; c=relaxed/simple;
	bh=vUXGP2NL/Y3G2YwX7QJc8uDJtcmNgRO6rb0t3gzNG+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e1pNNeVAuTP4SLCrEvFQNZ2FDESkoKzv5OxI4CWFgo0DO/hKG6t6WjfkU4RCg//dt5psDtFOv40qh2yGlzcZmSBzVXtBOia/Ff0OClrSeMubbLsJMNfyn4Szj/Rz2+gwREpSs5tB+wVaJceFKDStc5UKpOD9OlCELHPg4sTK6eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkU4T5V1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281EEC4CEF1;
	Tue, 19 Aug 2025 12:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755607797;
	bh=vUXGP2NL/Y3G2YwX7QJc8uDJtcmNgRO6rb0t3gzNG+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MkU4T5V19318Tbg74Q6IbMuQ3SUH0D4VSVNpyLIntjNvCvABHOTUXccQ4NaP7AhDw
	 sIdACZGKjbI5+HeqCmn/OKzMC/f/aF8+5I+Lq8r3FbaVepanQQlWGBV2OE2NOCFekX
	 yOyy/QYBAxT5+VH2Mx9bql4glrw5RTPc405yOI0kpmo+L0mHebvS3ZrZR5k4xgstdO
	 HT2ajiLKwTQbyMqxPm6DEpTpGVlqqq9DcQ6TgBkobOuWBU847inSeP2avbmBBZzSCe
	 ez/GrNtB0rFgy2/ndpgsdMKVtpBegslvUhBIVVXAIsfS3KdtXX3qWKgKtDXB7SO4d2
	 BC1u1LPxFczFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E5D383BF58;
	Tue, 19 Aug 2025 12:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: mana: Use page pool fragments for RX
 buffers instead of full pages to improve memory efficiency.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175560780700.3536307.412662512500742256.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 12:50:07 +0000
References: 
 <20250814140410.GA22089@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: 
 <20250814140410.GA22089@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: horms@kernel.org, kuba@kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, longli@microsoft.com, kotaranov@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org,
 michal.kubiak@intel.com, ernis@linux.microsoft.com,
 shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
 rosenp@gmail.com, netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, ssengar@linux.microsoft.com,
 dipayanroy@microsoft.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 Aug 2025 07:04:10 -0700 you wrote:
> This patch enhances RX buffer handling in the mana driver by allocating
> pages from a page pool and slicing them into MTU-sized fragments, rather
> than dedicating a full page per packet. This approach is especially
> beneficial on systems with large base page sizes like 64KB.
> 
> Key improvements:
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: mana: Use page pool fragments for RX buffers instead of full pages to improve memory efficiency.
    https://git.kernel.org/netdev/net-next/c/730ff06d3f5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



