Return-Path: <bpf+bounces-65935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E4B2B5AB
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C461B27978
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB281EC006;
	Tue, 19 Aug 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyhjr72A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA5B1E376C;
	Tue, 19 Aug 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565211; cv=none; b=rhs7NbT2O+NNha1bxzSPrE2gCIZ4/VKZoBiT/lTSkizimMiK9FKiMJCx/Fz8bJLzwt7YD4IeQwI6K9zwDpry91yqd0Six6AIVdZUEOfsdaRbJVLmU5I8JTxPUzBNL4FOV8TdZ42zkvV6PRdniVCypTHkLDFS82aZnwlC6lGxvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565211; c=relaxed/simple;
	bh=3/EqCP9BMz1mop7oC6jXP4NN8+Nr+7g8yHxkv925huE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eZmykdB4lBJeqIDsh1DvUz+FG/3utToQBTiIuzvjgZcc5NeHZkZoWCLR6PGOPeJEiCBM+JIVmv/SXgB60WePSpWT4eALzuQrLXy/tvlUQ4m3zqtjzQn//O2bWfRTyKFz5WTevRp3I6YAmXZwW3lsjogx0QCCaL/RKc9xFYh56Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyhjr72A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CB7C4CEEB;
	Tue, 19 Aug 2025 01:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755565210;
	bh=3/EqCP9BMz1mop7oC6jXP4NN8+Nr+7g8yHxkv925huE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uyhjr72A1AjxlODW8N2te3G29SBWvFomyEE/XD9uPJom5bfLfUQRtlr1XDrycvVLW
	 2NwHGHx3NhXOFl5e4xEIFwmwJp/SdC3dJZ8Ezt5YpLZpk8K2POVE25nEPRwALyn7gS
	 I8DzXuCeJVsboZr0iS0R9PeOJyedBrBfMC2OFM3Gir0RT+TrYWuqXB9X/WiWIzxxlY
	 Wk7snQe+Ft4QbT2X43utTGGjsOC85SWm2PikIFU3jaRCqR7foEdYS6nNIVlQaPyyRP
	 9MH8CAdTNbg8elBfStILQff9r3MRqWnUno67acML7/guY6ZyGrRfdl4ePN1U1gw8u3
	 3uMDrVxjSA0Xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFE6383BF4E;
	Tue, 19 Aug 2025 01:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] net: use vmalloc_array() to simplify code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175556522029.2966773.8890220490164839233.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 01:00:20 +0000
References: <20250816090659.117699-1-rongqianfeng@vivo.com>
In-Reply-To: <20250816090659.117699-1-rongqianfeng@vivo.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oss-drivers@corigine.com, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 16 Aug 2025 17:06:51 +0800 you wrote:
> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
> simplify the code and maintain consistency with existing kmalloc_array()
> usage.
> 
> vmalloc_array() is also optimized better, resulting in less instructions
> being used [1].
> 
> [...]

Here is the summary with links:
  - [v3,1/3] eth: intel: use vmalloc_array() to simplify code
    https://git.kernel.org/netdev/net-next/c/4490d075c2d9
  - [v3,2/3] nfp: flower: use vmalloc_array() to simplify code
    https://git.kernel.org/netdev/net-next/c/fce214586f99
  - [v3,3/3] ppp: use vmalloc_array() to simplify code
    https://git.kernel.org/netdev/net-next/c/dad3280591ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



