Return-Path: <bpf+bounces-15325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90837F0443
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 04:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269381C2098B
	for <lists+bpf@lfdr.de>; Sun, 19 Nov 2023 03:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4654A3B;
	Sun, 19 Nov 2023 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6pPodgU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B504A21;
	Sun, 19 Nov 2023 03:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF603C433C8;
	Sun, 19 Nov 2023 03:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700365827;
	bh=DB7GudK43KJSm5A1OTfnCSC33RMCcjkf244A2IUEqNk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K6pPodgUM0jeiKLFxvlGgr8i3iTlsjZ/U6GRbkb6GgGfkVVECx3aYoB5xSbbxm7vu
	 tMYPnWFHMneRtGkUO2G1udQ5o5KqXV4C5U6gx3kerUr/pr+ging+MvAWHt57vYoNXK
	 dZmC/vaRD9pvfc4qedvEJArwYey7O3nMSYcc1oBFQnnaBwxo95W6B7NRszraSLc08k
	 AwR2mp+SxpDAb+HU9eWphHWgxvWB83UijKHnNKoSbsCGp3h+4KA17qJRkQfGEX/umY
	 PreE92nx9wqjCPdzHrCMUJqggQHg6hwgGbiP9W6fiQCOmHmyqMMVHFf2Zu9IEQagXG
	 2XmfJKYOu68mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2E17C3274D;
	Sun, 19 Nov 2023 03:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2][pull request] igc: Add support for physical +
 free-running timers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170036582685.8585.5607944968495319373.git-patchwork-notify@kernel.org>
Date: Sun, 19 Nov 2023 03:50:26 +0000
References: <20231114183640.1303163-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231114183640.1303163-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, vinicius.gomes@intel.com,
 sasha.neftin@intel.com, richardcochran@gmail.com,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 14 Nov 2023 10:36:36 -0800 you wrote:
> Vinicius Costa Gomes says:
> 
> The objective is to allow having functionality that depends on the
> physical timer (taprio and ETF offloads, for example) and vclocks
> operating together.
> 
> The "big" missing piece is the implementation of the .getcyclesx64()
> function in igc, as i225/i226 have multiple timers, we use one of
> those timers (timer 1) as a free-running (non adjustable) timer.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] igc: Simplify setting flags in the TX data descriptor
    https://git.kernel.org/netdev/net-next/c/fbe567785968
  - [net-next,2/2] igc: Add support for PTP .getcyclesx64()
    https://git.kernel.org/netdev/net-next/c/069b142f5819

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



