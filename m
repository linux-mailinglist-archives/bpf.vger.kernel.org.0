Return-Path: <bpf+bounces-38008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8138C95DE5B
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 16:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17511C2114D
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 14:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4209A177992;
	Sat, 24 Aug 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxEL6Y+J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D4210FB;
	Sat, 24 Aug 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724509833; cv=none; b=e9WJReyu6rObxA6Fo6YvRZveAQGohPgEhPQfdoH1/xSiHz9Jp1kpropjru5StOoSfeRuTgI7YHbXMMlxNRC05PpMkaBwY4gkSZb9gdIVW0/fT3uJVfNETrRVvPYGGVhL9zCrMgIJ0jxGSXbNYmAoOG38tGjstgPl7YHhgTJ81ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724509833; c=relaxed/simple;
	bh=cwNK1QghZyRiXSy88f++TojKFP6BbpAE9nFehSteBXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xe38jWVnhxSgXCPbycz9hGpbmztu6TA7A3LVcp5QYR2vX2vFyEXb0JAgckedRP7io4a4WwBQgw63NyQu6Yp87jrK21yLFirDKdXSfpzPakO3el53Bq2M5D3rrZDS7a43GFUZGPlxue7V4tRhvDhOjFQ5+UALPMIg4r+H5Vmdh80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxEL6Y+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294ACC32781;
	Sat, 24 Aug 2024 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724509833;
	bh=cwNK1QghZyRiXSy88f++TojKFP6BbpAE9nFehSteBXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rxEL6Y+J7XNmwpz6v4PAA+BfFTCxRRZtIwc3LuOGot7j24+1qQug8YWZsQmtXM+3C
	 MAvUOJEq/kCjETMoaQnIMMCn3DZXn8Z06eSZHg55FPpxJMH55V1o6GxH8EHFkhBN4N
	 CkHybx67OZWTpn/GKgezAyFG7Daid4Mj+l6ATx+GjUzCsAWd1/BGbGu3h5VPKQUoCk
	 H/bm+gMDGbjRPsSasr6keRCCg8aCTLg/w6jYNhNjgLF+wUcKnzH5ps+HjbeI4bvnYl
	 7qXx7ym7BYyAVkt46UhZVKVxUehya7q0vSM/6veUXZjJgae/9eNYALkyHXMziYiIMQ
	 QtGZHbhD+KAfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE63823327;
	Sat, 24 Aug 2024 14:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: refactor ->ndo_bpf calls into
 dev_xdp_propagate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172450983301.3235196.2834576800924054534.git-patchwork-notify@kernel.org>
Date: Sat, 24 Aug 2024 14:30:33 +0000
References: <20240822055154.4176338-1-almasrymina@google.com>
In-Reply-To: <20240822055154.4176338-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, bpf@vger.kernel.org, jv@jvosburgh.net,
 andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 22 Aug 2024 05:51:54 +0000 you wrote:
> When net devices propagate xdp configurations to slave devices,
> we will need to perform a memory provider check to ensure we're
> not binding xdp to a device using unreadable netmem.
> 
> Currently the ->ndo_bpf calls in a few places. Adding checks to all
> these places would not be ideal.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: refactor ->ndo_bpf calls into dev_xdp_propagate
    https://git.kernel.org/netdev/net-next/c/7d3aed652d09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



