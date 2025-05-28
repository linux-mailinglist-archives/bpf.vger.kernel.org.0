Return-Path: <bpf+bounces-59047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5522AC5EB0
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 291957AE8A7
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 01:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4896F19F40A;
	Wed, 28 May 2025 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuvJE8cg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BEC7FD;
	Wed, 28 May 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395209; cv=none; b=R48MKzr/3MnUiNFQkGVULOKLgu/NS04YCQdAJuErQQ35uwuHcuAwJb+6WGk2sp7rqAQmlrchS3WV24H31C8+j+sMwd1flFvSr57Am7LKU1a7VCaoKRJjYEqRzJn2ld+q1bKDiOdqCLlxxzpI9p8eFjAqOwIJ5VJ/WycJw8gCHPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395209; c=relaxed/simple;
	bh=yc8Llua673bI0rhnunlq6rge6KO86YUAfTYW39ONZjs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BDFLZqUz8q+dMYhzRpd5OoGX+66py1hcBv3vnRkN8ZiqhcXaTw5rDwEEp+4a6Ls/Lv3X1fNWZa8i3k/u3XE3NLQ3YEaCfWAYmXtfwh8PMd7s+Jf3hdVVRJjOKTsRByP9/DIOqYU0Wh0MGuCoGaKYZ5oD6yx09Hy9uUdetXsEVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuvJE8cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFCDC4CEED;
	Wed, 28 May 2025 01:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748395209;
	bh=yc8Llua673bI0rhnunlq6rge6KO86YUAfTYW39ONZjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OuvJE8cg2cxK88Lwb6TOjm14Phr6y+9K8waG/MZvr+tzf4vTOsTRALDAQ7kg0y2D3
	 SdpDyB84SEbIgn+LDK0aPQdFV0fvE8O9Si4BowsK7KkH0+CpUeoNixcM9vzPtVyZmk
	 xxj3Eoq18bErexixMJ8lsSVFHHbLsJEjYvfKxBAK341twB9ATK87Bm5iEqLYUDcARX
	 lloo7FB2bD1X2qA7s8vQX7yhxG9CrmRmqIUkij/TwvAaE+X7aS9i0wBX4TpWeXzvYY
	 VcYqffxTX+qeejw3dWgaQeHjK92yiYm8WYPCIvDkuhqeidde0x1vXh4KGHfnna4Obb
	 AvdQVfKQVVhgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA2380AAE2;
	Wed, 28 May 2025 01:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 00/11] net/mlx5e: Add support for devmem and
 io_uring TCP zero-copy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839524325.1849945.2813758587760916594.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 01:20:43 +0000
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 leon@kernel.org, richardcochran@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, moshe@nvidia.com,
 mbloch@nvidia.com, gal@nvidia.com, cratiu@nvidia.com, dtatulea@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 May 2025 00:41:15 +0300 you wrote:
> This series from the team adds support for zerocopy rx TCP with devmem
> and io_uring for ConnectX7 NICs and above. For performance reasons and
> simplicity HW-GRO will also be turned on when header-data split mode is
> on.
> 
> Find more details below.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,01/11] net: Kconfig NET_DEVMEM selects GENERIC_ALLOCATOR
    https://git.kernel.org/netdev/net-next/c/cb575e5e9fd1
  - [net-next,V2,02/11] net: Add skb_can_coalesce for netmem
    (no matching commit)
  - [net-next,V2,03/11] net/mlx5e: SHAMPO: Reorganize mlx5_rq_shampo_alloc
    (no matching commit)
  - [net-next,V2,04/11] net/mlx5e: SHAMPO: Remove redundant params
    (no matching commit)
  - [net-next,V2,05/11] net/mlx5e: SHAMPO: Improve hw gro capability checking
    (no matching commit)
  - [net-next,V2,06/11] net/mlx5e: SHAMPO: Separate pool for headers
    (no matching commit)
  - [net-next,V2,07/11] net/mlx5e: SHAMPO: Headers page pool stats
    (no matching commit)
  - [net-next,V2,08/11] net/mlx5e: Convert over to netmem
    (no matching commit)
  - [net-next,V2,09/11] net/mlx5e: Add support for UNREADABLE netmem page pools
    (no matching commit)
  - [net-next,V2,10/11] net/mlx5e: Implement queue mgmt ops and single channel swap
    (no matching commit)
  - [net-next,V2,11/11] net/mlx5e: Support ethtool tcp-data-split settings
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



