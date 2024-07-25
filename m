Return-Path: <bpf+bounces-35648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C6493C55F
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5F51F25CD8
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5C419D091;
	Thu, 25 Jul 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/TVp7Nz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A261E895;
	Thu, 25 Jul 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919034; cv=none; b=NzyMvUjMwFpqA/nMgOOW9sm5ndjHK8+qoxYxPnDczBTKpSMBeYjBbzjWWQ85dvDr7/F5TYvxyEs4pamXQpT/ohLyjsvhPs/kGmmSY24oy5bFLQhIjEpYAVAU9Lsx7+li4Z2LIictH4qE8jVQMUZkh8I0wulQUmnd7L0tdWDjM8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919034; c=relaxed/simple;
	bh=cumSC9cNmw/VWuz19u05QQhciFybrAYBeZp2cynmQUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jFB66pJQTn/yk0JmJofqsLYU3rKM1fbJ5OawXtJM06uXu3mJRlXXB9MR1wfrAlZNH85YEtTQOwk32WRnULUFCtritboJiRFucP5fBz36VnZ0K4HfUzGGY/hADFqFTaQHfGjJTwqXhFZMFZV5IRwrHGppevAlrmFAG/7f6W6+tpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/TVp7Nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5596AC4AF10;
	Thu, 25 Jul 2024 14:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721919034;
	bh=cumSC9cNmw/VWuz19u05QQhciFybrAYBeZp2cynmQUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q/TVp7Nzm/5vv4uehWhU5Ib9VDJCA7SGqsik4wP4Da3KDa7qxKkY4QGculCZb9I9C
	 OYfq/OGqp0X7yU2sbg2oyjphGcj0iMFRTJ76lUxxWnX7djVRrFqKKVtDZZ9chvdIA8
	 IRCPwbCYxwa6v9mhPOAo4u6bvblXGcM7RW1qYBNE7X7eVYOBkO4nYpO4WxOheMeReL
	 hPls3k3EeYD83wTXETlW40G9aGfyZBiCKUPWZ9MCWH7Gp3Ac3UtmbvQnXFT2tL/6uL
	 0aGTTAd6uVfo+Xbv9hiAEK8NdNFsfoCPelzVblOuuMY8CRsPWfCdB34qihtOgdoDlS
	 8dIPRQeSj7xRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D0C8C4332C;
	Thu, 25 Jul 2024 14:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-07-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172191903424.31720.13837669286654307002.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 14:50:34 +0000
References: <20240725114312.32197-1-daniel@iogearbox.net>
In-Reply-To: <20240725114312.32197-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jul 2024 13:43:12 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 14 non-merge commits during the last 8 day(s) which contain
> a total of 19 files changed, 177 insertions(+), 70 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-07-25
    https://git.kernel.org/netdev/net/c/f7578df91304

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



