Return-Path: <bpf+bounces-44431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B929C2EF3
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 18:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057081C20E71
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 17:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ACC1A304A;
	Sat,  9 Nov 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPO5ihTT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2B1A2645;
	Sat,  9 Nov 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731174629; cv=none; b=eRzGiAWGdfWvS5VEVw0bYSAjaZ+v/KKeqzIXpm/lzYjKg2AvMAhOIfaYb8OYUewoOXzjatIyVoRuvzB7S5FEtHjnwLhkpd0Tx/uoBwVjdfhmkriq8GgrmedWxdFrpOIokzmqlyqllqKef98nfi4XbYZhaUXTT86EoWcbANJa/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731174629; c=relaxed/simple;
	bh=pImSLBhfvjg4E1kN7zcmSAiZ5SUogAvv/DhtGeB/ZMM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G1rZf5EVBq+2D3YvmMs11Uc5DZbLpOYk/pUVmjl9gmge+GgYTY1J88/0s6ySNrCQIFMg/l9GcBd81sCdFvI1pyFDpLnb4kJigjjZmRZbgFy0G1pqM5sZwRNlnSpjJHehlm5wp9n2e1DyUFBYAMdOJGvSBxq2hpkyZTXO9q7ReKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPO5ihTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64406C4CECE;
	Sat,  9 Nov 2024 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731174629;
	bh=pImSLBhfvjg4E1kN7zcmSAiZ5SUogAvv/DhtGeB/ZMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OPO5ihTT8JCKa+vEpNPLPbYQpeMnX4B1DXQgA524mLM3jOxya9zebIr7mn07PI0mn
	 mXXXGjDtNPkh8t6l3q/siubm2xX2rCP0oIG+M2PYc6l1uDkBB8XDAUWPXFOsa79wd4
	 F5NLnMg8kYaJeV/DXvSBgQPRmtYWu24PK5ueScxN/HBmtdE00Nx9um5+cEJvkfpE7R
	 738QuQAwtK/iCA/jMT9mAGgB7BA9iRti81rnEbpSNj09sak8ca03lrh3MIrEEPU5z0
	 Worqo4W1qB6eLF+vR7PulMja8HVa4KvtTxYT+eDAk4U6k8PzMSRhc9xjR/pZqzT6Yq
	 /IfJKewMUKV7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C983809A80;
	Sat,  9 Nov 2024 17:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] net: sfc: use ethtool string helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173117463900.2982634.15326215887669526386.git-patchwork-notify@kernel.org>
Date: Sat, 09 Nov 2024 17:50:39 +0000
References: <20241105231855.235894-1-rosenp@gmail.com>
In-Reply-To: <20241105231855.235894-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Nov 2024 15:18:55 -0800 you wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: cleaned up further with signature changes to make sure all
>  increments get propagated.
>  drivers/net/ethernet/sfc/ef10.c               |  2 +-
>  drivers/net/ethernet/sfc/ef100_nic.c          |  2 +-
>  drivers/net/ethernet/sfc/ethtool_common.c     | 46 ++++++++-----------
>  drivers/net/ethernet/sfc/falcon/ethtool.c     | 34 ++++++--------
>  drivers/net/ethernet/sfc/falcon/falcon.c      |  2 +-
>  drivers/net/ethernet/sfc/falcon/net_driver.h  |  2 +-
>  drivers/net/ethernet/sfc/falcon/nic.c         |  9 ++--
>  drivers/net/ethernet/sfc/falcon/nic.h         |  2 +-
>  drivers/net/ethernet/sfc/net_driver.h         |  2 +-
>  drivers/net/ethernet/sfc/nic.c                |  9 ++--
>  drivers/net/ethernet/sfc/nic_common.h         |  2 +-
>  drivers/net/ethernet/sfc/ptp.c                |  2 +-
>  drivers/net/ethernet/sfc/ptp.h                |  2 +-
>  .../net/ethernet/sfc/siena/ethtool_common.c   | 46 ++++++++-----------
>  drivers/net/ethernet/sfc/siena/net_driver.h   |  2 +-
>  drivers/net/ethernet/sfc/siena/nic.c          | 14 +++---
>  drivers/net/ethernet/sfc/siena/nic_common.h   |  5 +-
>  drivers/net/ethernet/sfc/siena/ptp.c          |  2 +-
>  drivers/net/ethernet/sfc/siena/ptp.h          |  2 +-
>  drivers/net/ethernet/sfc/siena/siena.c        |  2 +-
>  20 files changed, 83 insertions(+), 106 deletions(-)

Here is the summary with links:
  - [PATCHv2,net-next] net: sfc: use ethtool string helpers
    https://git.kernel.org/netdev/net-next/c/9dae59210556

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



