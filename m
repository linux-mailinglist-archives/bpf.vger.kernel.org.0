Return-Path: <bpf+bounces-17020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A152808F11
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B48B2807AF
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 17:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA424B154;
	Thu,  7 Dec 2023 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9ovUY7j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307A4B149;
	Thu,  7 Dec 2023 17:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7E75C433C8;
	Thu,  7 Dec 2023 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701971424;
	bh=PlFx3/L9wOfZvrpZoN82cdPv5l+7B9vC+XOgpqgk44s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W9ovUY7jj3hYWXWbWUlurqYRl9ThCS3ZdGCEBfMW+va5c1fUDtbeU+uCxdZIIVzz7
	 0ShFRGF2eBCySWVbgHVPglHGheMUL4ESQqykDHPUlqPLsAtTTARSQ+/EwUXyo6EZg5
	 gem0PNEZlSXe521SaDFPF7R6Gfefd0JWMAg65IT0l/rpGtN7Ujc2McNEe2NF43WXyx
	 EZHrEOIakQfjND7C9dIYsmrd2ZjwmJ4uC6Eq6mdCbjYvlIJhLnrUQSka7YJIAV4Lpy
	 ye973VlUA4ic7/hnFpKJV4GQfJ7qKj6gDYgwJcc32PAWhri5+dD97lBgl4eHnVEEs3
	 vcoh13V1TdG9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91025C40C5E;
	Thu,  7 Dec 2023 17:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-12-06
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170197142459.2220.3981238820660690454.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 17:50:24 +0000
References: <20231206220528.12093-1-daniel@iogearbox.net>
In-Reply-To: <20231206220528.12093-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 23:05:28 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 4 non-merge commits during the last 6 day(s) which contain
> a total of 7 files changed, 185 insertions(+), 55 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-12-06
    https://git.kernel.org/netdev/net/c/c85e5594b745

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



