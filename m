Return-Path: <bpf+bounces-28008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED8D8B4361
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 02:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603A4B212E1
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 00:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5732D03B;
	Sat, 27 Apr 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUQ4soM7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396125777;
	Sat, 27 Apr 2024 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714179031; cv=none; b=hOxeNFl269BRncjL2aTxdmQdBmbd9ICdJmAi9uS7pSqK9i8v9fCyUtIhXj8J8ycF0JvFGAWNHkGjmIWCxz3+vn2fo/ypbBmgim+P/8zUNE95Ld9JCjB4+/QWuIxxkH2e5LnZyeJW4UvnegYxQfhKhLpjaZsnqfXFbVKYbeg+K2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714179031; c=relaxed/simple;
	bh=P96LIyKxtIrsWgmiG6zRSg5cbZDa2HTn5zzVCWMvjOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aNXDxlWLQZJeP3v8NVVOo9LU+wJ74Xpn5FyqvMGvBPo4QqOGeU1OT8m31FAvjFuyNti9klE9SKV30GbvfmnYwC4Ftvdd5IskhTKZKsBNfDwsBjmj1YXCdBLpZcRQWzrb3ilt8EH2qy6F9+SUSYOHXgIDnFAC72u4CvO32YaAHWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUQ4soM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 777F9C2BD11;
	Sat, 27 Apr 2024 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714179030;
	bh=P96LIyKxtIrsWgmiG6zRSg5cbZDa2HTn5zzVCWMvjOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PUQ4soM7o1C1hzZ1XWJ8q2VVyNErFrVQ/cqyrrNkViI7Sg/dGqKmIlI/50iPu+hnJ
	 ffX/igqSOh1ZmeKgwU3ma/yabPwaELcBGSkww7tJMfIGOAAO8D187WVFxPi22YSWEU
	 0TYBfxHXaW4hfB3cWjINY9lFWeVD5BjMfNY/nx3TQAgfQIuN/RSHwv/a85JgOuS321
	 2UMnq+L1eZ6er6Bh2hY7awXJOmRjRjRJLg/A25R2CcfnPIlvKIDsCpjdGp5JCXGvuh
	 wiuVwhgGOg2brvZX2YSPurhVR01eaEDSAQTnSsbszT7gyQkl82y7EA2djtni5+s7g/
	 vA+HY/Nk5pj7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67666C32761;
	Sat, 27 Apr 2024 00:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-04-26
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171417903042.26055.11087226285223760685.git-patchwork-notify@kernel.org>
Date: Sat, 27 Apr 2024 00:50:30 +0000
References: <20240426224248.26197-1-daniel@iogearbox.net>
In-Reply-To: <20240426224248.26197-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 27 Apr 2024 00:42:48 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 12 non-merge commits during the last 22 day(s) which contain
> a total of 14 files changed, 168 insertions(+), 72 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-04-26
    https://git.kernel.org/netdev/net/c/b2ff42c6d3ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



