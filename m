Return-Path: <bpf+bounces-68728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D219B82879
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 03:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A35F467746
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66A9237A4F;
	Thu, 18 Sep 2025 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLwy2+s8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF681922FD;
	Thu, 18 Sep 2025 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758159618; cv=none; b=j/lIBzgIDzMTljwKTzZYB7rwm0cTocU29kZAPWIz4MiT9OI4Rtf7DFq4sNJflhDbU/q3ZwzkKJ/ykz2VhvIgohZkRC5ZGVmv3JX+zlA6A+7vhMh4r7BEFOS3DvdqIEYEFd4g7wwK6viIH/7pR/DEmFD14EMlVI6dzU0chS4B44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758159618; c=relaxed/simple;
	bh=TrU7RfUYr9JD6ui4vjRDy4Ys0CVm0kceHpIIercU4QY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Os+IU2vPBlEGvYn74fRb1g9S5AEZrf0/o2RjwB6H5jSwcXopvY3V+Wl2e5WKQDmGMuDvA+Q8N+1pDnMkLM4lWJqZ0zvJvth3QeR/maSZ389TVYMklKq0oMSNE7pM2no4FDUnvmJAuRPVvyFbyLz03bc48cFA0m2E7xLeaQ7lH7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLwy2+s8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9BBC4CEE7;
	Thu, 18 Sep 2025 01:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758159617;
	bh=TrU7RfUYr9JD6ui4vjRDy4Ys0CVm0kceHpIIercU4QY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JLwy2+s82zqjN4ShMOXEvugvHpejzous9IQjb+0WKIR3iC+KkrKWR7wvJD4FaooJn
	 ln780t1Yt9GQIs5o+aAiR0aWbEz2b3lQ9c7Qe5BIQGIQ4h1BN85tBP6FHF5QLTaKPN
	 EMoMvp05r0U7Wsc7maXxfIvRlc1TdrlhIu3TTOezES394SBJo7guBUCmFbDbvR+i0N
	 OrIQCvsyqRrXol0dGu1HX5EVoNsj5IGsp9cT46zDIFnQNyOVXFOnNNMvTVa75Oz91Q
	 7lPCsA2TJReRu7K5l/pM0ooqPBq0ZbP6imD/jjuN2hzg7S79fOqFuHjaTPqKhyjoA/
	 0N7iN2Kv75XEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C5739D0C28;
	Thu, 18 Sep 2025 01:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 00/10] net/mlx5e: Use multiple doorbells
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175815961800.2217978.13039702853348998554.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 01:40:18 +0000
References: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1758031904-634231-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, jiri@resnulli.us, corbet@lwn.net,
 leon@kernel.org, jgg@ziepe.ca, saeedm@nvidia.com, mbloch@nvidia.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, gal@nvidia.com, cratiu@nvidia.com, dtatulea@nvidia.com,
 jiri@nvidia.com, jgg@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Sep 2025 17:11:34 +0300 you wrote:
> Hi,
> 
> This series by Cosmin adds multiple doorbells usage in mlx5e driver.
> See detailed description by Cosmin below [1].
> 
> Find V1 here:
> https://lore.kernel.org/all/1757499891-596641-1-git-send-email-tariqt@nvidia.com/
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/10] net/mlx5: Fix typo of MLX5_EQ_DOORBEL_OFFSET
    https://git.kernel.org/netdev/net-next/c/917449e7c3cd
  - [net-next,V2,02/10] net/mlx5: Remove unused 'offset' field from mlx5_sq_bfreg
    https://git.kernel.org/netdev/net-next/c/05dfe654b593
  - [net-next,V2,03/10] net/mlx5e: Remove unused 'xsk' param of mlx5e_build_xdpsq_param
    https://git.kernel.org/netdev/net-next/c/913d28f8a71c
  - [net-next,V2,04/10] net/mlx5: Store the global doorbell in mlx5_priv
    https://git.kernel.org/netdev/net-next/c/aa4595d0ada6
  - [net-next,V2,05/10] net/mlx5e: Prepare for using multiple TX doorbells
    https://git.kernel.org/netdev/net-next/c/673d7ab7563e
  - [net-next,V2,06/10] net/mlx5e: Prepare for using different CQ doorbells
    https://git.kernel.org/netdev/net-next/c/a315b723e87b
  - [net-next,V2,07/10] net/mlx5e: Use multiple TX doorbells
    https://git.kernel.org/netdev/net-next/c/71fb4832d50b
  - [net-next,V2,08/10] net/mlx5e: Use multiple CQ doorbells
    https://git.kernel.org/netdev/net-next/c/325db9c6f69b
  - [net-next,V2,09/10] devlink: Add a 'num_doorbells' driverinit param
    https://git.kernel.org/netdev/net-next/c/6bdcb735fec6
  - [net-next,V2,10/10] net/mlx5e: Use the 'num_doorbells' devlink param
    https://git.kernel.org/netdev/net-next/c/11bbcfb7668c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



