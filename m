Return-Path: <bpf+bounces-29766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2D08C68D4
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2C91F215FA
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5525E155743;
	Wed, 15 May 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZpLk0vF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794315572E;
	Wed, 15 May 2024 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783682; cv=none; b=t1896TA9WDXY3wQB2Nd+Tz6nlRVsPx3HkVF7Vicai/NEVYjwZvAA9a1Dzngwx+0auzFIzAUP/n3us+e7DkZZHDHj4+FUUNQKTr6ERjv3YuwIaBmra6DniLA6KywhUB/268mAuKlUpyK2Wph0AT8MR8haVB2qpzArv1ZZ596Au2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783682; c=relaxed/simple;
	bh=3kDYWvufU5LSKxYoN0RemwT7hW2iNiWwqCnq6/jg+iY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JODMHRLD6R+qUloxmdJTgWzTCWsxAXwYmrFMdfUv+UCRmzCoiehwi//DgYy/D6w2gqWjhKOBji38KOluk/h4LUQuGetTHFohT6ZpvhVncEArQWepUiJ0CvaVwAWvfzoW2h2QNsygcSe/ZI3/70APMYafLY26YCrxCBmaHr+ETqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZpLk0vF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C21EC4AF13;
	Wed, 15 May 2024 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715783682;
	bh=3kDYWvufU5LSKxYoN0RemwT7hW2iNiWwqCnq6/jg+iY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nZpLk0vF/ClttMbxwv9CrSiDaylO0t36xCpk+66TdR9pxAwPUdShPj2lmimAqzpVq
	 9xitz36byVxZS0vcIwP3rFLnk7CcYAZAsTiyyKPflYwoui67V2kxGkF4ieYwoNOXWe
	 y2dD+CZvGE94yxgF6w8Za4O60KipTIbULjUzewhE8f43iExlbSnhLCZ47djTKefFAq
	 N9F+r+FOybSDisIxFsKE5BgYlrhUnL7+WTSidI+sO5yuj7obi6tmd4t26ezuTsol+P
	 VozlZ4D3EbHF4sXEGlCEHYASoc9L+5nVFz0NblpFy3YTScA3fsU8C2Taus8rKKjKwF
	 3mn32ndyD6pgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B406C54BB7;
	Wed, 15 May 2024 14:34:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171578368250.11862.10400880543348690872.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 14:34:42 +0000
References: <20240514231155.1004295-1-kuba@kernel.org>
In-Reply-To: <20240514231155.1004295-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Tue, 14 May 2024 16:11:55 -0700 you wrote:
> Hi Linus!
> 
> Full disclosure I hit a KASAN OOB read warning in BPF when testing
> on Meta's production servers (which load a lot of BPF).
> BPF folks aren't super alarmed by it, and also they are partying at
> LSFMM so I don't think it's worth waiting for the fix.
> But you may feel differently...  https://pastebin.com/0fzqy3cW
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.10
    https://git.kernel.org/netdev/net-next/c/1b294a1f3561

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



