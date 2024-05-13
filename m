Return-Path: <bpf+bounces-29664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5698C481D
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 22:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0074C1C222C6
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD6F7E578;
	Mon, 13 May 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVcp0GZN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E3B76056;
	Mon, 13 May 2024 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631630; cv=none; b=eNaZNY605R8PrHkr3fb3t7yf4j4LNOztc6YWVbQ+WkTVcuvsEYfCq2YymB7CyV8jrjpaXtKY4WCHto9+X5kzUwJd5GzTVYVpgh41TaUlfnioSFIcpr2yxelEJWqi93iawwl91Zsr6QpiE2QzIhmMW3KUl2Y8fNzfkc3t3AvK1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631630; c=relaxed/simple;
	bh=uLZg/VXmHHiqkXQDPmJqHEN4hVWn3nhTgaSaXct+gVs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gLODLJTj9aY8/lpsHl9X4MaFvJ/4QAIQSz7ql0J40YZegD/zpLs+df/eH3IY+n4lpvw4UNzIExBTMLKvvxlQS3HbNr9rXVO+566t2YfRezS0r0+PChRyUXer5QFOVR0fmgX7L0f1EzuTNWxGWhp88irQkuJT/BhH7s3O13j7WWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVcp0GZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3718C113CC;
	Mon, 13 May 2024 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715631630;
	bh=uLZg/VXmHHiqkXQDPmJqHEN4hVWn3nhTgaSaXct+gVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DVcp0GZNluc0r2sPIT07pb62dz4+dzvWS/+8k6T1MTpMOqBaDlNHiJKkfEUJFrcAA
	 ov4uY6KzmsG8LSXvyJu+apLncdKW0gusX5iSqIJNvaR0xKtmOdpTKnNtXQh9X9W6AT
	 Ns0q6yVKWEzUVqe2AJj2iOf45xfV+0chpJibzh/X/9ethxE7VsPOn3xRNmSpQFJ6AQ
	 VuGLcNgASKObj47mU+mmP5dWJD3HgY4vtyv4LdeELMEhB+/6uMlb0D0zcLWIL6hE/b
	 1vzZbC5RH+LcvjEgKkiM+5FzRD4WNvNvLcfkyMxQKbQgx4wCKAPcFvlGtcEu+2QgXk
	 qTqS3VQFgXE0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE3EBC43443;
	Mon, 13 May 2024 20:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-05-13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171563162990.3504.17279054249056404557.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 20:20:29 +0000
References: <20240513041845.31040-1-daniel@iogearbox.net>
In-Reply-To: <20240513041845.31040-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 May 2024 06:18:45 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 3 non-merge commits during the last 2 day(s) which contain
> a total of 2 files changed, 62 insertions(+), 8 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-05-13
    https://git.kernel.org/netdev/net/c/c9f9df3f6347

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



