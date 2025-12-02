Return-Path: <bpf+bounces-75885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ED8C9BCAC
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 15:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45144347289
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9791F238171;
	Tue,  2 Dec 2025 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzGRScc/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C19618BC3D;
	Tue,  2 Dec 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685990; cv=none; b=os9kUu04yxFY5HNcQB1ZkgMGMgmTzAFyH9wZoXoVtQe31J6/xi/wMe711nPEySCkZT6xGUnHOGq52l/yB8R8rHFiI38H6Lf59zEbCk/T5VGDcvmYtzyn2fXfYHwaWCgZLIqF6jo/L0imV+oXyBefZI5SafLNahYOawo4IdEpFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685990; c=relaxed/simple;
	bh=Ly/4cWuHRE5Ksuv+Yo/Z1qdg0Fg7JiBJoCRjb1P4hcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OTztHJCpxIfTSUFAmn/o6Q2Y5T2POAyE2zD/xKVCAExvZCasB1rUNZRbgGgnYv6I4vSMnBbuCgOyR2hILZYstjCZdPBTv7RJWF3FoyM8omSH/tUF3i3rWO4IYQjc0u9msjKfntWr0jHi7ZeaKkPIXUAioPXO5o1fcODRisl2q8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzGRScc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8046EC4CEF1;
	Tue,  2 Dec 2025 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764685989;
	bh=Ly/4cWuHRE5Ksuv+Yo/Z1qdg0Fg7JiBJoCRjb1P4hcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MzGRScc/IvXrcvO07PgdzuZMI416Qfgaa7Lm/majdXSijKvkGq6aQwnFdUrUXDAX9
	 lb3CNPW9+4V781IzXL+iQnOh0eUXggIp31aaCg75dbm8VI309F+/sCyqL5mSoh0Rid
	 ViVaYBiAyMjOiCpaIEwAjqk1JY90Glc9dQCCc+ulcAIjanFDr78aQB5aZUpEPrJz3b
	 DX/dDYB3JH60KzTOHOIdgxshShBrRAUg2F+PKUqTxdfkcZwgHR03iE0KsZKZJfDWkM
	 RUcefJPNN/nTnqoyF7h9olevuzwKbt70zVQM1vSzzrVKRktgrq5d69E+pc/ZT1gylt
	 DpNgK+E/8hrhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 32EA03A54A16;
	Tue,  2 Dec 2025 14:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/2] net/mlx5e: Disable egress xdp-redirect in
 default
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176468580905.3250289.13105138318084701594.git-patchwork-notify@kernel.org>
Date: Tue, 02 Dec 2025 14:30:09 +0000
References: <1764497617-1326331-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1764497617-1326331-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, gal@nvidia.com, moshe@nvidia.com, dtatulea@nvidia.com,
 witu@nvidia.com, toke@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 30 Nov 2025 12:13:35 +0200 you wrote:
> Hi,
> 
> This small series disables the egress xdp-redirect feature in default.
> It can still be enabled by loading a dummy XDP program.
> 
> Patches were previously submitted as part of [1].
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/2] net/mlx5e: Update XDP features in switch channels
    https://git.kernel.org/netdev/net-next/c/96a839506135
  - [net-next,V2,2/2] net/mlx5e: Support XDP target xmit with dummy program
    https://git.kernel.org/netdev/net-next/c/d4aa0cc9bd31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



