Return-Path: <bpf+bounces-36666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2891594B582
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 05:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5BF1C2143D
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 03:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3127213F435;
	Thu,  8 Aug 2024 03:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNSSnw9u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CC34F606;
	Thu,  8 Aug 2024 03:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087842; cv=none; b=Ui55ERk8Yw3HVq9SsQxups+FtbMEqs2iTt40J7/XM7jJ4wvrv09S+4cDgmTL1K2DBudThghZFpIvpvqH9i5UWnZH/j4iMs8n3QKByFSmwOu5qaRF0m1UTH8XUP0BKRaeLzAbT3MOnUQGjCkH0ZPPVwj5wTsyHG29UL9kuIyS6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087842; c=relaxed/simple;
	bh=SGePvoLxO1bPwPwMJaG4AV2RKkwBImKHT5bqFjljxqo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bLNfbW2i8qkv1B1a0TY7OKhgW4Sc9EmJDY5IsDs5O+75uqWMh525jBjCVbpJKaWup7D8SU3tvuJMbZ4wp94XP0RqWzxaUQ2M7IlIQXvKsVwwsKFubN6ZuwGA0BYW3e7+TT5uz2iV6vV437OdZb0epEvuPA4h7FA7qQOrZYhJJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNSSnw9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228CDC4AF0E;
	Thu,  8 Aug 2024 03:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723087842;
	bh=SGePvoLxO1bPwPwMJaG4AV2RKkwBImKHT5bqFjljxqo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dNSSnw9uvsl3bkqpTqYgeNTKLa2GbHDdeMgB/NrO80s0jbN6oiMt5KBa556m+2chl
	 q7vcYAgLLRLjwyI1yjmD5PTX/stj9xHOXGBRQyZs7f6XdRtDiGGmJyHAkKPbhlkNSR
	 B0Koqj7QWfmx3bRlSI2sZAyMnQxbWUYn5bcFXXDKSretv+SD675VLjkjPi4nC8zyEX
	 BVwQyUj6ucab6IUo270hSQxl97BUcXXG3W9T3NAitaHZqpC5jv9t8d01f0pSUuAlzJ
	 akDP+yMRibsDN5xNjC9Z/ZFOh6UWFtWKkNq1oJD063yRYjGlJyLZTTKnMoZyBhoY+I
	 cY4U9llr62LPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EB83822D3B;
	Thu,  8 Aug 2024 03:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] doc/netlink/specs: add netkit support to
 rt_link.yaml
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172308784075.2759733.11539577237999951622.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 03:30:40 +0000
References: <20240806104531.3296718-1-razor@blackwall.org>
In-Reply-To: <20240806104531.3296718-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, daniel@iogearbox.net, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Aug 2024 13:45:31 +0300 you wrote:
> Add netkit support to rt_link.yaml. Only forward(PASS) and
> blackhole(DROP) policies are allowed to be set by user-space so I've
> added only them to the yaml to avoid confusion.
> 
> Example:
>   $ ./tools/net/ynl/cli.py \
>      --spec Documentation/netlink/specs/rt_link.yaml \
>      --do getlink --json '{"ifname": "netkit0"}' --output-json | jq
>   ...
>   "linkinfo": {
>     "kind": "netkit",
>     "data": {
>       "primary": 1,
>       "policy": "blackhole",
>       "mode": "l2",
>       "peer-policy": "forward"
>     }
>   },
>   ...
> 
> [...]

Here is the summary with links:
  - [net-next] doc/netlink/specs: add netkit support to rt_link.yaml
    https://git.kernel.org/netdev/net-next/c/7d70ed9f9c6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



