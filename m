Return-Path: <bpf+bounces-63682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4B7B0991B
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 03:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300745A02F3
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 01:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB99191484;
	Fri, 18 Jul 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E++s709+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC318A6AE;
	Fri, 18 Jul 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752801604; cv=none; b=EVZnzJAiRro/VhsMgFmE3iLHt5Fl8/00xNzWi9VgK8iO7tVCYpITBvTFd4iL4KYTdQ19yIhHvFcwhDnwpo9CjjUn5CMtB/+6J1HqVzjA1FPX7zYDDjzHh8W39mK46Cr34K/cWqu7rs+babOfqzPoKwbHgfJb7gOkNmfwJsNOjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752801604; c=relaxed/simple;
	bh=Vx7M8EqK5eGIsdHHbX/19ncyCIgXrhUB6q14WbGypgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=annsW1AvJ3M25lVsKRDIKA4F9kaHF53luW6j3IzXuuPkh5kENVEJ+mN2nQzPrVnLG3xFELKhZzKgOj8vbYAGm8xZr5IXFvx3Rt1lqp5iQVzeLlo0qAUYwYRn0RipvMyJcD/7hxDjxUr2E9KNzSoFPEMYpCmfXClsdQPoKHa7aCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E++s709+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EF7C4CEE3;
	Fri, 18 Jul 2025 01:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752801604;
	bh=Vx7M8EqK5eGIsdHHbX/19ncyCIgXrhUB6q14WbGypgs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E++s709+M0ymivk9UIoHKE8OrcycCr5pITsPEM40OKf8+SGzP1y915jPuE+Vhz9Xw
	 T7wI2FZ63sYCZrkE+ot0rWhKJybPCJJsPEUdvpoXO/bPTLgpqUqa5n0BNbqUo1aghw
	 mMi9/u6DNLvoKTT5H5MRRpCIqW6EhRAn9QN0yiu1PxB3CaRC3JhgZA3uI9yv7y+5tr
	 l1+brCtkqxEjZJne4sVXuVfmKNYf5/3MDv1Kn/h2lWLve7II35Uq2gvPj6U5eBSwB4
	 fJiNvy2sdVSOtddzeuwnxs4pf+hIyTazvNpg9F4l4G3tRzxpp9eEa441V9q+OCPKsH
	 jLOxVDdAFx6eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B76383BA3C;
	Fri, 18 Jul 2025 01:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2025-07-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175280162375.2132065.708017691035835832.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 01:20:23 +0000
References: <20250717191731.4142326-1-martin.lau@linux.dev>
In-Reply-To: <20250717191731.4142326-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 12:17:31 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 13 non-merge commits during the last 20 day(s) which contain
> a total of 4 files changed, 712 insertions(+), 84 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2025-07-17
    https://git.kernel.org/netdev/net-next/c/ffe5aedc439c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



