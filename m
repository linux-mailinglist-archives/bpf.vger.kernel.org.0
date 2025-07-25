Return-Path: <bpf+bounces-64322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29B7B11590
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 03:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD58D585BC3
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 01:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D0219B5A7;
	Fri, 25 Jul 2025 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcjfKcOI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF32262BE;
	Fri, 25 Jul 2025 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753405791; cv=none; b=uekqMYc/eW7Zn3cR0BHLCDn//DFfMsISVJ6gfb1rVbIadcGr+gLoyb/yWpNnpPcQMwAAw/nNaX/1jSkRiGZqOvXQoZKXnVNDTqhLYnX9tpIsw6F/+oKipFbaxELxnpalqjDCDoBd2NuuHs4eIfzrlltVcnBwPVY7MkKfNFJS1dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753405791; c=relaxed/simple;
	bh=g1teY3OfGfSd9Dy/LeUyCyWEh6LgRb+x9SVuxEZ3tXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=We7as/8XjTQeA9T9lAfkS0R1QQMzSMHK6qJwxMgvIOo41qIhYQgmkKS5gGxHckT7tGJfISr7o2pVHDT+9XHjfqcMkX9NYDhv4MWJuOm+rFwc7jbde8J8u842ue1gJZWQHCaP0sFw45aI3gwocGosOQjYcfNf13QamEWHLk53SvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcjfKcOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB31C4CEED;
	Fri, 25 Jul 2025 01:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753405790;
	bh=g1teY3OfGfSd9Dy/LeUyCyWEh6LgRb+x9SVuxEZ3tXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rcjfKcOI0JNQFB3abNouWZSV3Dgyfakwqo7Ys2At9e8q5//KNK8A4irVHQ008iW5a
	 ubIaRQ34ZgV5i0M13CBnhXoR2qLAUidGg4ejhGp/hur6dvPJVcEMLnrg5wYk42JWIZ
	 FlxIPOfF5WUD8Fs1zlMjr9If9l3kmeBxBTQc+m/x+OBpKk03r7vbnY/6KdWhN7A72h
	 Jg27UTyp1ePNWFVwBmxr5+MUyf9q+/SAePUUf2HDGeq34LrwZeznHtkn4Rhd4fs4Fk
	 1dyQBhM0Q8hTxFEBMV06pCnbMHvxoHcoiFZWkUFZa49puCoITABQprwxe/AZktnHe1
	 bJdp6mwBiwxdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ADA383BF4E;
	Fri, 25 Jul 2025 01:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2025-07-24
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175340580825.2592891.347025051999771271.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 01:10:08 +0000
References: <20250724173306.3578483-1-martin.lau@linux.dev>
In-Reply-To: <20250724173306.3578483-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Jul 2025 10:33:06 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 3 non-merge commits during the last 3 day(s) which contain
> a total of 4 files changed, 40 insertions(+), 15 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2025-07-24
    https://git.kernel.org/netdev/net-next/c/a4f5759b6f0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



