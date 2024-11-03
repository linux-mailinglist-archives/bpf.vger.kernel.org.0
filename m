Return-Path: <bpf+bounces-43856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1309BA98D
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 00:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A839A1F21C7E
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 23:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8853B18CC02;
	Sun,  3 Nov 2024 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG12lY2M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F6433AB;
	Sun,  3 Nov 2024 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730676023; cv=none; b=njI/5U/8PSlFdpaW9Is0/SOsPokHAHV1xwywbjrZiPOWzwxhD9Dd75jU9ar96K7LCSVDn349c5rbrS4PJlf5KllIbFnEEDY0laUiK4vhOQ8FXz1IKdCnqMg3hG3SlryROUzinpCw7jG3N0nbD2tSrWLei7WUbH/Kh2ZRGKSUqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730676023; c=relaxed/simple;
	bh=JEJk00GMtoe8PdDehP0wcv8Jh9zt0Haptv/NS9kXBsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=faiBbKFROtSahiF5+WNLa+NVZQBK5HCOtgYCYkBNaabNPCPTGr2Ykt8GEGYRmnUlHNPrslkHiL6pN4PZ0uh54X2vYwPBmwNQAJK4J84dnNwq3C5TNpa1ERgoT4vQVLFxVMMlIY6XS9SzMjz+d97gjTeasRVpqTEl33uT37ZwL2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG12lY2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C747C4CECD;
	Sun,  3 Nov 2024 23:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730676022;
	bh=JEJk00GMtoe8PdDehP0wcv8Jh9zt0Haptv/NS9kXBsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XG12lY2MhWiFTYtGz3Bf2V/1d/iiJbehbjzEvTYQg7YbYmXEPo334AwexlybmWZp7
	 HxkhD5n1JABM+bmDJEgscLldQpK1agFHjp9r9wvwuNNaunU7nCiuepoEYFtlDdq/X0
	 nB49nsW8DpVgPaXZHHB8HqsFgcM7G8QX+8wDy9VL9Bc3B1iT0ufZOa7oWabVLjxko5
	 gc8w88qTO/6KRmCVotVWLd5PV6EYtrzmtOXUuCh/4mp8bQOtuDAenmHJ5VvIGaYCZ1
	 yNy3gQYXeVhGFAM/6CRvIQDn7GXwnuEGS641p092XGT8nCNPboj/rnt/n7PNNLxvOI
	 lcHsWh1c5p+mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340B438363C3;
	Sun,  3 Nov 2024 23:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-10-31
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173067603074.3276260.1832689639638882607.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 23:20:30 +0000
References: <20241031221543.108853-1-daniel@iogearbox.net>
In-Reply-To: <20241031221543.108853-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 31 Oct 2024 23:15:43 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 13 non-merge commits during the last 16 day(s) which contain
> a total of 16 files changed, 710 insertions(+), 668 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-10-31
    https://git.kernel.org/netdev/net-next/c/cbf49bed6a8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



