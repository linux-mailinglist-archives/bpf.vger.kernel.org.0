Return-Path: <bpf+bounces-60886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B94ADE0EE
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 04:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B7176458
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 02:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87DB1A3167;
	Wed, 18 Jun 2025 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdxoZfv3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5111A23AC;
	Wed, 18 Jun 2025 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750212047; cv=none; b=OCosALTXsPK8pOxosJVLu8cduyONjPJl7aabfPE8J0nf4WU47o5dlF6iZSqd0kyMRBSWwsf4Iz2MEZzV0tDJoNllpCnHOmvqPQ/TB35XGq5pk4eTnuMvzuTRdipd8v/55Jbu/IlethVSwC0Rde4qKaSHtnBUSIPX9CfNYdcs0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750212047; c=relaxed/simple;
	bh=0w6RyZx0T8mnxgTBMgwaaR9B5HfyTLWhObeCSDyl46g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GdL4VEOr/rwts2S85AbD5rdRYTK/wzh+PicHgeJYJMbbfwJAejiym6FJCJWKcjdeL0veio8IMOa3/FTGDklKhpg2Dw8nJXN+qKrFwxMnmwIzBVCVNI4dkjIAosJqe3h8MsWj/WZq55MQK16ol7zZZ+8N3W0pWdsDilGelZjDzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdxoZfv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0129C4CEE7;
	Wed, 18 Jun 2025 02:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750212046;
	bh=0w6RyZx0T8mnxgTBMgwaaR9B5HfyTLWhObeCSDyl46g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jdxoZfv3Hu6DBXZE8ZRbQWQrNVkbI/Q5RcCndKPOg0eSGjrt37J/wXRtWa6+LvOZB
	 La/CR+dfgLrqqheCInSKrHM44ysg8zT5X7Z6nEaUUQv0m/adFtV0ZcB2m6NkKwa84W
	 2R9S3dggzfkfEyWpFaOy9v3g582BEXsDLPfNrGZVW7QdmsdBfPhRk+B0Xl4+UKvdBd
	 4potW4oyxdWJskRbtZeuS8MrnlJlLeRjMO5YM9hpGJYCBl4yW7QHjTPf5XsWrczK0k
	 atxqOGyrd1faKytIPHac+51fqqUDIkdJ5pRtUB1ayMmsekJ3UP3Ii/E7pLzogB++Ak
	 UcJPgZYX4BNCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BB338111DD;
	Wed, 18 Jun 2025 02:01:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/17][pull request] libeth: add libeth_xdp
 helper
 lib
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175021207499.3767386.18340217486667454630.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 02:01:14 +0000
References: <20250616201639.710420-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250616201639.710420-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 aleksander.lobakin@intel.com, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, michal.kubiak@intel.com,
 przemyslaw.kitszel@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 16 Jun 2025 13:16:21 -0700 you wrote:
> Alexander Lobakin says:
> 
> Time to add XDP helpers infra to libeth to greatly simplify adding
> XDP to idpf and iavf, as well as improve and extend XDP in ice and
> i40e. Any vendor is free to reuse helpers. If this happens, I'm fine
> with moving the folder of out intel/.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/17] libeth, libie: clean symbol exports up a little
    https://git.kernel.org/netdev/net-next/c/359bcf15ec1d
  - [net-next,v2,02/17] libeth: convert to netmem
    https://git.kernel.org/netdev/net-next/c/6ad5ff6e7282
  - [net-next,v2,03/17] libeth: support native XDP and register memory model
    https://git.kernel.org/netdev/net-next/c/35c64b6500ef
  - [net-next,v2,04/17] libeth: xdp: add XDP_TX buffers sending
    https://git.kernel.org/netdev/net-next/c/8591c3afe888
  - [net-next,v2,05/17] libeth: xdp: add .ndo_xdp_xmit() helpers
    https://git.kernel.org/netdev/net-next/c/084ceda7decd
  - [net-next,v2,06/17] libeth: xdp: add XDPSQE completion helpers
    https://git.kernel.org/netdev/net-next/c/26ce8eb0bb7d
  - [net-next,v2,07/17] libeth: xdp: add XDPSQ locking helpers
    https://git.kernel.org/netdev/net-next/c/c4ba6a9b9d46
  - [net-next,v2,08/17] libeth: xdp: add XDPSQ cleanup timers
    https://git.kernel.org/netdev/net-next/c/819bbaefeded
  - [net-next,v2,09/17] libeth: xdp: add helpers for preparing/processing &libeth_xdp_buff
    https://git.kernel.org/netdev/net-next/c/3ef2b0192e8b
  - [net-next,v2,10/17] libeth: xdp: add XDP prog run and verdict result handling
    https://git.kernel.org/netdev/net-next/c/4c805f7ae1ce
  - [net-next,v2,11/17] libeth: xdp: add templates for building driver-side callbacks
    https://git.kernel.org/netdev/net-next/c/1bb635d3748b
  - [net-next,v2,12/17] libeth: xdp: add RSS hash hint and XDP features setup helpers
    https://git.kernel.org/netdev/net-next/c/576cc5c13d9b
  - [net-next,v2,13/17] libeth: xsk: add XSk XDP_TX sending helpers
    https://git.kernel.org/netdev/net-next/c/b3ad8450b4dc
  - [net-next,v2,14/17] libeth: xsk: add XSk xmit functions
    https://git.kernel.org/netdev/net-next/c/40e846d122df
  - [net-next,v2,15/17] libeth: xsk: add XSk Rx processing support
    https://git.kernel.org/netdev/net-next/c/5495c58c65aa
  - [net-next,v2,16/17] libeth: xsk: add XSkFQ refill and XSk wakeup helpers
    https://git.kernel.org/netdev/net-next/c/3ced71a8b39e
  - [net-next,v2,17/17] libeth: xdp, xsk: access adjacent u32s as u64 where applicable
    https://git.kernel.org/netdev/net-next/c/80bae9df2108

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



