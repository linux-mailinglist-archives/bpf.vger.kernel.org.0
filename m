Return-Path: <bpf+bounces-51295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B6A32F81
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 20:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3C21660DE
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541252638B4;
	Wed, 12 Feb 2025 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCOUI7cR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0945262819;
	Wed, 12 Feb 2025 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388009; cv=none; b=kxjRm/1aK+O4xK8NEEUgIHALHvn4IM3O7wSXRvL4r9uybWCibeR4pGhSLuqLiDb7Zv3ebSOAsLUAoeQhLT3Wc31NcH17RfxVhMpwZvYMcWnbvD1NzEnUdkMocT3hR4vC6UYZWZEx0Njf8NdVyFCqGBTFEGyJM4FBuC5bWwXeBCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388009; c=relaxed/simple;
	bh=8oGQaUEp785Ksp9CMP5N4KASHqjUgTRlvpoOvmKilvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oXzuDQJSgh5bzVcacAw1gj3W9TZoHXLL34Ylz38J1cc2POocDTumGZyyuearzdF/sLOnc2hPLMW5Yb8D8F2FP7zfUJDkhPU83EbBGmWmh6nFn7EkVbHRDKKVUABYZFr0TtrWjJZRcr7P2Oi6vNMDfGSXPIA/XkBrjcVPmvl+vc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCOUI7cR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EC1C4CEE7;
	Wed, 12 Feb 2025 19:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739388009;
	bh=8oGQaUEp785Ksp9CMP5N4KASHqjUgTRlvpoOvmKilvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HCOUI7cRvY4NdRxik3/fbJopYtRnJ6Ydm/qe5WEWRSnDsU/QzvdRmCySS4ofMjSqN
	 62qN+9xacWZzon8rV9Qirpdwv14yK+TNGbcC8F4Uceli6NNhlBYJ4A/MN1hH6WIlTr
	 9uxkKSzEVUzhNVVCpZcBlpd+C2etPEewcuojGjFYmTZvj3eLzLVQUxLV4GBRZKF8e9
	 pllnVF3KBPCaK5UTKcygHGgNNlDNDAbLrNQX9Nb/GClNObngRgvsQWOzjYw5I+t6MW
	 7+bEOOKKkuEsEo9RnKfismpWsMYs/e5OU6FrVdQKdx9pBK7bhdrwxX6wWj2IqB6C6+
	 0YoWFYx+t+q5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72012380CED8;
	Wed, 12 Feb 2025 19:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] Rate management on traffic classes + misc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173938803799.632131.11441489448633366329.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 19:20:37 +0000
References: <20250209101716.112774-1-tariqt@nvidia.com>
In-Reply-To: <20250209101716.112774-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, horms@kernel.org,
 donald.hunter@gmail.com, jiri@resnulli.us, corbet@lwn.net, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 9 Feb 2025 12:17:01 +0200 you wrote:
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Hi,
> 
> This patchset consists of multiple features from the team to the mlx5
> core and Eth drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] devlink: Extend devlink rate API with traffic classes bandwidth management
    (no matching commit)
  - [net-next,02/15] net/mlx5: Add no-op implementation for setting tc-bw on rate objects
    (no matching commit)
  - [net-next,03/15] net/mlx5: Add support for setting tc-bw on nodes
    (no matching commit)
  - [net-next,04/15] net/mlx5: Add traffic class scheduling support for vport QoS
    (no matching commit)
  - [net-next,05/15] net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw
    (no matching commit)
  - [net-next,06/15] net/mlx5e: reduce the max log mpwrq sz for ECPF and reps
    https://git.kernel.org/netdev/net-next/c/e1d68ea58c7e
  - [net-next,07/15] net/mlx5e: reduce rep rxq depth to 256 for ECPF
    https://git.kernel.org/netdev/net-next/c/b9cc8f9d7008
  - [net-next,08/15] net/mlx5e: set the tx_queue_len for pfifo_fast
    https://git.kernel.org/netdev/net-next/c/a38cc5706fb9
  - [net-next,09/15] net/mlx5: Rename and move mlx5_esw_query_vport_vhca_id
    https://git.kernel.org/netdev/net-next/c/38b3d42e5afa
  - [net-next,10/15] net/mlx5: Expose ICM consumption per function
    https://git.kernel.org/netdev/net-next/c/b820864335c8
  - [net-next,11/15] net/mlx5e: Move RQs diagnose to a dedicated function
    https://git.kernel.org/netdev/net-next/c/913175b3f919
  - [net-next,12/15] net/mlx5e: Add direct TIRs to devlink rx reporter diagnose
    https://git.kernel.org/netdev/net-next/c/99c55284e85b
  - [net-next,13/15] net/mlx5e: Expose RSS via devlink rx reporter diagnose
    https://git.kernel.org/netdev/net-next/c/896c92aa7429
  - [net-next,14/15] net/mlx5: Extend Ethtool loopback selftest to support non-linear SKB
    https://git.kernel.org/netdev/net-next/c/95b9606b15bb
  - [net-next,15/15] net/mlx5: XDP, Enable TX side XDP multi-buffer support
    https://git.kernel.org/netdev/net-next/c/1a9304859b3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



