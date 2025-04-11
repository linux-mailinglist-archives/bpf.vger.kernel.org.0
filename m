Return-Path: <bpf+bounces-55700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD62A850C3
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 02:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B4F57B2A07
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 00:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B822F26F475;
	Fri, 11 Apr 2025 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtCnq414"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FAD26F44F;
	Fri, 11 Apr 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744332594; cv=none; b=dBHoyBvZARuTGp/qhnDYCN2x26YoT/bYup0WuQgE4i7y8+5sRkH15kXdbbr3GybbWOOLgz8iqKPItvtPHfoiSYLBUe8KXoxZeIAcQNvuOiCI2gRnzhTncGgvL3APCt8ygirDhIPthl6DCupZMdF31CW1HrGd+hF5GdfxI2/uhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744332594; c=relaxed/simple;
	bh=qxLkRPGGCz0k3o8LbxhXlIhdlTIWT3NdMzYjQvJrCIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nZFQfJKClDBKbbAvWyAK975zTleLoLcIy2HyVjTcHdew44tThe/THFc1m2zErtfepypewgIcrra5fT2mHnxi0ciAlUEjf9YQ35AaB1B7rv3ignHPcJfQn6dLIY25TFPL0iwFAkiHUnjtGZAHaAPxeaE8+PLnsPBF7HIimkZvsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtCnq414; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58DCC4CEDD;
	Fri, 11 Apr 2025 00:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744332593;
	bh=qxLkRPGGCz0k3o8LbxhXlIhdlTIWT3NdMzYjQvJrCIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RtCnq414HjjFly8X9uOWM5kZDpK85zUC9+8LSr06+agBwwfQs71eYNTa2yuchvS1q
	 yacbwWe6VyUEpSRO9+Ns6TZj6cJqjun8GHn8sxV9Rqsd8bh3OtIiH5ariR44pUUkXN
	 1M1//r3IHDiFOgzd23Ff2tajPL4jgP19kPYNypp1Yqfxe7aI8JxDKOsh7kFnXYo3A/
	 vy1OQSs2CZ2l+YfhmnLJITB9AkAWssAnokAewLAB3fSjxVFavHCqjQgjBVQh5vuyXA
	 zYHJnKnhKd2LM3POetOIAmxCxHxPecXldZ7xT52fRHNPYNwHv6ImNSE8mXSzwaYMf9
	 fFg2+9zpEenPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710E2380CEF4;
	Fri, 11 Apr 2025 00:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] af_unix: Remove unix_unhash()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174433263104.3877366.17329943918437576552.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 00:50:31 +0000
References: <20250409-cleanup-drop-unix-unhash-v1-1-1659e5b8ee84@rbox.co>
In-Reply-To: <20250409-cleanup-drop-unix-unhash-v1-1-1659e5b8ee84@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: kuniyu@amazon.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 09 Apr 2025 14:50:58 +0200 you wrote:
> Dummy unix_unhash() was introduced for sockmap in commit 94531cfcbe79
> ("af_unix: Add unix_stream_proto for sockmap"), but there's no need to
> implement it anymore.
> 
> ->unhash() is only called conditionally: in unix_shutdown() since commit
> d359902d5c35 ("af_unix: Fix NULL pointer bug in unix_shutdown"), and in BPF
> proto's sock_map_unhash() since commit 5b4a79ba65a1 ("bpf, sockmap: Don't
> let sock_map_{close,destroy,unhash} call itself").
> 
> [...]

Here is the summary with links:
  - [net-next] af_unix: Remove unix_unhash()
    https://git.kernel.org/netdev/net-next/c/709894c52c1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



