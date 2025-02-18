Return-Path: <bpf+bounces-51822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A213BA39989
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 11:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CCC163427
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F1F237707;
	Tue, 18 Feb 2025 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIxcbpYC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59913D51E;
	Tue, 18 Feb 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875807; cv=none; b=p3At9qfW3WdakmnV8mwGivYNDNKQ05cOdjMVtDzw4PcblsxKv2Gm+vnG9SLKp0ylm3I9cIJBvyZorAvTrMpQXFW+0M0WGokf+PBLvkb7o0BpPiINbcjMNWCM+7WCJQEIUvpxtgpyGbGmS5BiElALkJIVOH8Gt/WKuxKZvWpnA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875807; c=relaxed/simple;
	bh=0ta9iRqvOL/XyCbfOk5/m0s+WL02GRT3CgMUuEb8Y2A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EpQ3ylAsyzrPJwGpuknQvEDM1y8BOq/4wY62O0fOfjl/gN7xzxOhd+QtTk2hNALi0mN+bDJ9OiiRW8b2ZSpd66r3vLwJ7/1KBFmwaYl6TC37VLCiyri4Elry2MG1TJf86tBC1Zn9J04POOOT4pC6Zan8rBu9JsjmT0FQGJoACVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIxcbpYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FDFC4CEE2;
	Tue, 18 Feb 2025 10:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739875805;
	bh=0ta9iRqvOL/XyCbfOk5/m0s+WL02GRT3CgMUuEb8Y2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fIxcbpYCIDGn3q2a5S2PyQ2TbijgrIPq+T0vunKI52/8Xnl0DRBv1gAWtUGBUhz2A
	 D/qHkQ/1X6NlGIjkm3/zN1aa3RU9WpcKP9s8Z+uFuwg1RXbrkxOzh0AZ6b/TbdSkqk
	 nhHErV+inkIK9/lLX5O4LTnMLfLHpna6X5qHGy59QlquCQkCquvDeceJG2QUOqM5js
	 osgliYXLHRsAqnKI4XvO6pSVfDtwcP3na3CLOpIKwzKrpjqiQDQ4BT47b8c+LLS38J
	 x7kf5QoyFVSerSJBh30TQfO1rY13FjsajbGdT5jnpmbnCquHOO7p5ri3Uam7sx31bP
	 SN0b7i3GqS9+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714B8380AA7E;
	Tue, 18 Feb 2025 10:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v6 0/6] Add af_xdp support for cn10k
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173987583526.4038826.3171177356659390982.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 10:50:35 +0000
References: <20250213053141.2833254-1-sumang@marvell.com>
In-Reply-To: <20250213053141.2833254-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: horms@kernel.org, sgoutham@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lcherian@marvell.com,
 jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
 hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 bpf@vger.kernel.org, larysa.zaremba@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 13 Feb 2025 11:01:35 +0530 you wrote:
> This patchset includes changes to support AF_XDP for cn10k chipsets. Both
> non-zero copy and zero copy will be supported after these changes. Also,
> the RSS will be reconfigured once a particular receive queue is
> added/removed to/from AF_XDP support.
> 
> Patch #1: octeontx2-pf: use xdp_return_frame() to free xdp buffers
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/6] octeontx2-pf: use xdp_return_frame() to free xdp buffers
    https://git.kernel.org/netdev/net-next/c/94c80f748873
  - [net-next,v6,2/6] octeontx2-pf: Add AF_XDP non-zero copy support
    https://git.kernel.org/netdev/net-next/c/b4164de5041b
  - [net-next,v6,3/6] octeontx2-pf: AF_XDP zero copy receive support
    https://git.kernel.org/netdev/net-next/c/efabce290151
  - [net-next,v6,4/6] octeontx2-pf: Reconfigure RSS table after enabling AF_XDP zerocopy on rx queue
    https://git.kernel.org/netdev/net-next/c/25b07c1a8694
  - [net-next,v6,5/6] octeontx2-pf: Prepare for AF_XDP
    https://git.kernel.org/netdev/net-next/c/c5c2398eb88b
  - [net-next,v6,6/6] octeontx2-pf: AF_XDP zero copy transmit support
    https://git.kernel.org/netdev/net-next/c/53616af09b5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



