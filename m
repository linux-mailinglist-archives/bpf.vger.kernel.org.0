Return-Path: <bpf+bounces-60885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1A2ADE0EB
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 04:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9598A178371
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 02:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B56219D8A8;
	Wed, 18 Jun 2025 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toJJqPJr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118E2F5301;
	Wed, 18 Jun 2025 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750212045; cv=none; b=D1k83W1dDaGTKPGZNJhM1I5y4Ws4HLt99cFrE3aYiuzCai+3Wyj+I7BCSKNqiidqW9UpwclinlsOPMp5lHJlkxvsPRrXbjgiVWyGta1L/PgmObe4U1ZSTe4D11M/k849YYJVexeKgJ48x6U0+zhamLUKOgDFTHBuxQdPlTlbWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750212045; c=relaxed/simple;
	bh=3eIbg82hZsCMbvSQM4Q3g6js5iOiWQoK57j5EYRu1p8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NzewfYs2OIG/LN/PjJnt1A1ZFW5m84MLeXrQVd8nLOjH9T7QsFCyndYnA3+aKD3bY5tNe/ye3s0R1T4SxtnDkvKUXOXzmg3Kf1zxHZFu6/Y6W0y6QSJwH9kjlvado+WKS/zb6JP44uMNKn6pbQbM4Tep7rW1ALXdY/NzGSNItpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toJJqPJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35918C4CEE3;
	Wed, 18 Jun 2025 02:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750212045;
	bh=3eIbg82hZsCMbvSQM4Q3g6js5iOiWQoK57j5EYRu1p8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=toJJqPJrNMWn1ehndLmo4P32bkY00AdPeHhWQvqX1jSkGUMAaKabwTbqfE2ppTMur
	 ZCoW/wmb+xXuMKNbiUtn/As7LpFB612Uex+T1FlEgS+HOUrAVfmAPqiOxHS5fB0Bvr
	 b4feUDIvhR5rD1XuzBm31p5Rs/CCtsgqyGFnIeGje8OYwxG/uGjSAKYBVL7/j77dRB
	 DYzAVWcKTQXlJiUK5TgL7QCiR6BeXhnRuW+btcidbPHi5jEupEfCTX3Fq/IBpYdAqV
	 8bUbOYa8NibpaJf2+/27RynYJLecYbPW2vdjYued/hqrpLleNs6jRoRFtGr6WUMLhB
	 8momGBXk6/mkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEA538111DD;
	Wed, 18 Jun 2025 02:01:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 00/12] net/mlx5e: Add support for devmem and
 io_uring TCP zero-copy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175021207374.3767386.6339945754428621138.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 02:01:13 +0000
References: <20250616141441.1243044-1-mbloch@nvidia.com>
In-Reply-To: <20250616141441.1243044-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 leon@kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 17:14:29 +0300 you wrote:
> This series adds support for zerocopy rx TCP with devmem and io_uring
> for ConnectX7 NICs and above. For performance reasons and simplicity
> HW-GRO will also be turned on when header-data split mode is on.
> 
> Performance
> ===========
> 
> [...]

Here is the summary with links:
  - [net-next,v6,01/12] net: Allow const args for of page_to_netmem()
    https://git.kernel.org/netdev/net-next/c/c9e1225352d4
  - [net-next,v6,02/12] net: Add skb_can_coalesce for netmem
    https://git.kernel.org/netdev/net-next/c/1cbb49f85b40
  - [net-next,v6,03/12] page_pool: Add page_pool_dev_alloc_netmems helper
    https://git.kernel.org/netdev/net-next/c/a202f24b0858
  - [net-next,v6,04/12] net/mlx5e: SHAMPO: Reorganize mlx5_rq_shampo_alloc
    https://git.kernel.org/netdev/net-next/c/af4312c4c9c1
  - [net-next,v6,05/12] net/mlx5e: SHAMPO: Remove redundant params
    https://git.kernel.org/netdev/net-next/c/16142defd304
  - [net-next,v6,06/12] net/mlx5e: SHAMPO: Improve hw gro capability checking
    https://git.kernel.org/netdev/net-next/c/d2760abdedde
  - [net-next,v6,07/12] net/mlx5e: SHAMPO: Separate pool for headers
    https://git.kernel.org/netdev/net-next/c/e225d9bd93ed
  - [net-next,v6,08/12] net/mlx5e: Convert over to netmem
    https://git.kernel.org/netdev/net-next/c/d1668f119943
  - [net-next,v6,09/12] net/mlx5e: Add support for UNREADABLE netmem page pools
    https://git.kernel.org/netdev/net-next/c/db3010bb5a01
  - [net-next,v6,10/12] net/mlx5e: Implement queue mgmt ops and single channel swap
    https://git.kernel.org/netdev/net-next/c/b2588ea40ec9
  - [net-next,v6,11/12] net/mlx5e: Support ethtool tcp-data-split settings
    https://git.kernel.org/netdev/net-next/c/46bcce5dfd33
  - [net-next,v6,12/12] net/mlx5e: Add TX support for netmems
    https://git.kernel.org/netdev/net-next/c/5a842c288cfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



