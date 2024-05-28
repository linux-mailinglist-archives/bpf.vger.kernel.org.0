Return-Path: <bpf+bounces-30750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CACE88D1F08
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 16:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC411F23D45
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 14:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7A16FF37;
	Tue, 28 May 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4eB6nRn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3BA16F902;
	Tue, 28 May 2024 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907236; cv=none; b=CiJksW2VFGjnVWgaBDyhsXf++4v7BwtbRF+OX0glyeX+951FdehZ5XyhEALJ4Am6bRyfw4uGICsR58pePT6c6okEdpWCHORhSra8XzdI4x+U/BQfQMIwAk+dcxXlsDqYuKdgx11HeZQKQjS7ktTxVBRJf46Th+sK+gB031PeOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907236; c=relaxed/simple;
	bh=+sFVrjmefhI3Nu0wkEetVfIDfAAyQMPN6+WWCD5/59U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oauZEzJryJd00DYiT55sCvfx6zzBHqkEjcZfWvWpPXF9Rir1pd6HDWPR1tObqs+9qVBvmkG+8IAsPymIqq9oCU3VQMsAZJdjuo/7ZnQFu03px5O6Eobyj18psFd/hJVB8xc2hX3wuDs/lVylb2tFQ1in6r2uHLXyGX6yNJAaVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4eB6nRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71144C32786;
	Tue, 28 May 2024 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716907235;
	bh=+sFVrjmefhI3Nu0wkEetVfIDfAAyQMPN6+WWCD5/59U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h4eB6nRncWY6vILy7ptFFsNOUFeZc00YgFGUgxeyDDdlXcNbW+JgICPklsWam7osI
	 wea5qOkyJbWIpXNxahOQSDndm3fjEZmFZzh+RYlgJXCAS4KXgpyVlKGGjLqVZAhZHj
	 Oq0bN4HB845Ls+GxrFc7RNH3mnjTP7kKVgygiOkeUpSfC3X3cDQB4lhX4HE3IELLVO
	 FCjFbFS8RzgDohjkchd2mB2x+EjhWDzJuVoqIIoIdr2n+FW/B/64Bo31r3OzkxyOOB
	 O5pSwxw8J26z67mSpPoEXp1DuVAABCZY0sJ8GrlcyiZneBF14HIV/KpqkW1hTR+B0k
	 fi0BfedJXx7dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FFECCF21F0;
	Tue, 28 May 2024 14:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-05-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171690723538.1426.10094461043155530200.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 14:40:35 +0000
References: <20240528105924.30905-1-daniel@iogearbox.net>
In-Reply-To: <20240528105924.30905-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 12:59:24 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 23 non-merge commits during the last 11 day(s) which contain
> a total of 45 files changed, 696 insertions(+), 277 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-05-28
    https://git.kernel.org/netdev/net-next/c/4b3529edbb8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



