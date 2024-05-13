Return-Path: <bpf+bounces-29613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD5F8C3995
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 02:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8BC1C20E6D
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 00:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26B215B3;
	Mon, 13 May 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjMaNkpt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869D17E;
	Mon, 13 May 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715559632; cv=none; b=KFgxSXGmIGI/EF7fS4e9gz1LRy0XMlJbSLnPrbLpn/cnr6bBdXvjbJfCrQ6QNvbj34UWAKAgOXm7yg5GP5zuNbssaVJtZIG6X4iBmZ8yZwmh4p7MrCnJ9gZ/ngZckCVEvnVDWQ6TwjEhjxlcmTnaxQs7rlruCs5spHGdfj0ieyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715559632; c=relaxed/simple;
	bh=kj/4PYLOVTBmauMmprd2H/etKpbijrodTuQAU8lxzLM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QNclMsrdXj0otP82GdeRFIzEFwhOlcoehflzV4YEMEtn42fCJdUzHLj/xmOWxbjiQjAf31b6aGchrY/tYyeM3bZxVT3KptZSboKfnQmPCePV5Vn0mSIzZnbEX4SDo/eM1/KvxjquJwDmGwCvibeY+ZMHqPT1YJWzxgko9bvDIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjMaNkpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3FB6C4AF09;
	Mon, 13 May 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715559631;
	bh=kj/4PYLOVTBmauMmprd2H/etKpbijrodTuQAU8lxzLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qjMaNkptHJGxNhVRxgzc8pmHEp/T+FU/MN4WajVXzYAj4luLvIz0aQTwujnq8U47A
	 naaaS93dB2IKa8R+5H0IUL10/V2G2+DMs1ViVLZQyAghioeoOWGChZ4SO1C1iIuO5F
	 8vBpxpwYWrfih8nKSsiB8pRuuNy0f4IaEpwlmToBT7xK9ILqk/oViMQF5wTvlDm4Ls
	 hOZEgOaUNZEO/QxQl6tP+nsdVq7jn39Hej+CwTzSxVmqWJ3GCTG5VzT9WgiNjxx1vF
	 rcocAlLGqqRq6X5/2VW7110kMrUeQXQk2ihMgnH07UlzhPBQCpiuvtOI/+nzqrgMW0
	 Z7UWu7koVTZ3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1598C43153;
	Mon, 13 May 2024 00:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] tools: remove redundant ethtool.h from tooling infra
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171555963172.28854.10245907823767156482.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 00:20:31 +0000
References: <20240508104123.434769-1-tushar.vyavahare@intel.com>
In-Reply-To: <20240508104123.434769-1-tushar.vyavahare@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, tirthendu.sarkar@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 May 2024 10:41:23 +0000 you wrote:
> Remove the redundant ethtool.h header file from tools/include/uapi/linux.
> The file is unnecessary as the system uses the kernel's
> include/uapi/linux/ethtool.h directly.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/include/uapi/linux/ethtool.h | 2271 ----------------------------
>  1 file changed, 2271 deletions(-)
>  delete mode 100644 tools/include/uapi/linux/ethtool.h

Here is the summary with links:
  - [bpf-next] tools: remove redundant ethtool.h from tooling infra
    https://git.kernel.org/bpf/bpf-next/c/bbe91a9f6889

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



