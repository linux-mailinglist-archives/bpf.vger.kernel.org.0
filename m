Return-Path: <bpf+bounces-73214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C1BC2738C
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 00:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3E51B270D6
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 23:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521F532F76B;
	Fri, 31 Oct 2025 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRQsEKHw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA44C9D;
	Fri, 31 Oct 2025 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761954638; cv=none; b=lHQG/KstPjcXkih082BvK9jZt/mCclJNMr3On7uYT8RVy7F/abrC1r+WEXKZL083CW+h9IJCgMYM/4qpLXYIs6ZQIQJfSvozivXiCBAhCO0skYI835H74MOWEE04ZMRcWzXPuVTnctoEHA4/W+mzDuXwJZeUKNGi0rac3alNbMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761954638; c=relaxed/simple;
	bh=E4ANsDklI69G4GmDh97A+wqQnXZMth6S72LU97OyxkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oU7E7VowX4SU3VzDkpnimAPx+0fr5VOM3H1NcxvA+5OUm/CvAzfkJAclHFll0xP3vNbfV4WXvFAhBo8b0Fw4A1VhSzcZkb0GygewB3rqotclQE+v8L2VoyPejr9MCpXfE6c+pRyBFLDzxrHiEHgMoNYqiRATi8EgfBDG2rOOY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRQsEKHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F00C4CEE7;
	Fri, 31 Oct 2025 23:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761954638;
	bh=E4ANsDklI69G4GmDh97A+wqQnXZMth6S72LU97OyxkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sRQsEKHwz+POAiuE3NyG6rJZqm1Jp0koKMQdeC2EJtnFMLgxXAcSGixmbuYA7nvuh
	 SrO2cvGVpTjf4t2FzVz4ojYaODXddxoR8ZeACGPKeyf3m19JNAqYhrWh8AS/WFlNcb
	 gCiL/Y9HohyOsbq9NI0js2/tZZxmKC2um/H1wtnb6z+SVgb++u/NKCGnWCOG52qxow
	 VsQ9GKueyE2OF72lELRbVfiQKk41COCY/Lip2ZwbSLQjmFNYc5fUAY4Xa1w5t2Q4ID
	 m51ahJN5shdDSDNAfJ7+hjp0gTxwePtRxfjtTGcUG1yS8LYpem1+BKfZARST4ZQDkv
	 U9WVskT+E7D4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7153E3809A00;
	Fri, 31 Oct 2025 23:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] Convert mlx5e and IPoIB to
 ndo_hwtstamp_get/set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195461427.670867.6904790068647704613.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 23:50:14 +0000
References: <1761819910-1011051-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1761819910-1011051-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, jgg@ziepe.ca, mbloch@nvidia.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 richardcochran@gmail.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 gal@nvidia.com, cjubran@nvidia.com, cratiu@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Oct 2025 12:25:04 +0200 you wrote:
> Hi,
> 
> This series by Carolina migrates mlx5e and IPoIB to the
> ndo_hwtstamp_get/set interface and removes legacy hardware timestamp
> ioctl handling.  While doing so, it also cleans up naming and removes
> redundant code.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net/mlx5e: Remove redundant tstamp pointer from channel structures
    https://git.kernel.org/netdev/net-next/c/7ea4376b3972
  - [net-next,2/6] net/mlx5e: Remove unnecessary tstamp local variable in mlx5i_complete_rx_cqe
    https://git.kernel.org/netdev/net-next/c/bf791659743b
  - [net-next,3/6] net/mlx5e: Rename hwstamp functions to hwtstamp
    https://git.kernel.org/netdev/net-next/c/fee182371a59
  - [net-next,4/6] net/mlx5e: Rename timestamp fields to hwtstamp_config
    https://git.kernel.org/netdev/net-next/c/91baaf96f5d0
  - [net-next,5/6] IB/IPoIB: Add support for hwtstamp get/set ndos
    https://git.kernel.org/netdev/net-next/c/250da3c8fe81
  - [net-next,6/6] net/mlx5e: Convert to new hwtstamp_get/set interface
    https://git.kernel.org/netdev/net-next/c/1c7fe48a9015

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



