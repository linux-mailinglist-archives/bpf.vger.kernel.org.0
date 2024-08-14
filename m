Return-Path: <bpf+bounces-37192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E4B952038
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 18:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6FC2818AE
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576191B9B3F;
	Wed, 14 Aug 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOmraxuF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D81B1405;
	Wed, 14 Aug 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653631; cv=none; b=kO3j2djYxFbQzXX1j4rT2DikdO3v/A8xNUgt+TueABPsaL9arZIm9IEnpxI0Rd3dkFJB3HRcQ+dsAvSpNlPq85fN6k9XhsL0NaGz8WCLfNuMZij/5NVHQkK4Syd7MHAO6zE38nyEdgqF/nJxJ8SsBgHfjJLwzP+tvr/BQ82Gtkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653631; c=relaxed/simple;
	bh=hqUXEwrR3pr5Rc77WjxBkxbUsFYvLz+uKFSnK2C4OH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HoFfEccFWdn2+lIa2SVHvZ2B+CQ2Kxyy5jjeOEiilTXeOzHlUtROhg4ilTAsHbgBtcm3p8U7HxfC6JmSkIEUqaG85Gyf6ZsywDMmS+K7W5IYfKgMUpvBESe3gkrOJMqs/Ya0Z9vyoqExnFxukG/9amZZPZF/BWS+1YEzKoYgMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOmraxuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6EFC4AF0D;
	Wed, 14 Aug 2024 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723653630;
	bh=hqUXEwrR3pr5Rc77WjxBkxbUsFYvLz+uKFSnK2C4OH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QOmraxuFNYLCUzuVyMf2uJI0D0kBZbOOmlGnTXKB+Uv8fYn5mHYPZ3B6i0UjFRNBg
	 n1S2P/1vS+sDnh7W4qrSVC8sieXbWLpsVbFNzOqhkZ2+GHLb52MKK5Y41suh0IDFE7
	 xcobAsEYv9Ss3ycXNxTXkb6gif+4ENkzbeaEiwx2EmIO9rsq5gsmKBzSW6Z5ENL7Gs
	 g8ohitDnasj+4KUl5n5YZs6zBo9drcsuHRyT/57U8VRG1S5jWJKXY5hf2NNs2Yhm2e
	 7SemeSinokILIJofYuwIqGeos8d5xyOh3Bz4g3n4T+VPXj+UH3ZV3u0vtuGKz9mXF0
	 4qryj1tsw9jcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE1E38232A8;
	Wed, 14 Aug 2024 16:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bpf for v6.11-rc4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172365362978.2323131.11837017631421132382.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 16:40:29 +0000
References: <20240813234307.82773-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240813234307.82773-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: torvalds@linux-foundation.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Tue, 13 Aug 2024 16:43:07 -0700 you wrote:
> Hi Linus,
> 
> The following changes since commit d74da846046aeec9333e802f5918bd3261fb5509:
> 
>   Merge tag 'platform-drivers-x86-v6.11-3' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 (2024-08-12 08:21:52 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bpf for v6.11-rc4
    https://git.kernel.org/bpf/bpf/c/02f8ca3d4905

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



