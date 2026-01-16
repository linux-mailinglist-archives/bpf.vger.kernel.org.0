Return-Path: <bpf+bounces-79350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E6FD3897E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 23:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8384830A6AE6
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 22:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CA3315760;
	Fri, 16 Jan 2026 22:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGkLRokL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22136314D03;
	Fri, 16 Jan 2026 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768604018; cv=none; b=kt9gpg8n3kqyyfBq6i1eRL7XgQ3YYRIDLzwDnhl38sVVqFvFp3nhUphvWzeK0d6AOuMNgQYry/xzWlAV8g7OaDkqDlmxzTL9XM5klzzQvzMNe9ZKzSZ33mNS1QbinbUwxejApQ0VVvd2Tt08Vha4kIEVy8mYt49TxtRbBHSkjq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768604018; c=relaxed/simple;
	bh=GS7mxjxjkXJMbohs2toFBDo7wSZMU0YxLbLwwl4Nqdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uEnT3KLFh0yuFhDjxNjWvfgt/7EfTaQD9OVg8zyyD4lKcl0B/PLUn0nMBxhLWZA1M0X7VSZTy0fuu8XWA8LX3AL11ZysnOnbp/B0h+YD7bsc8NN4FlNb44hqYWQn2FYrPLKR2tcr8/MAYkJioNbrlBXZ5a2SC7L6wgVM0/9yN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGkLRokL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33ADC116C6;
	Fri, 16 Jan 2026 22:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768604017;
	bh=GS7mxjxjkXJMbohs2toFBDo7wSZMU0YxLbLwwl4Nqdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NGkLRokL/94tZEUWbYl/0KgzstyFnbx58ViTwm4XvmJyB6YHPoUb7GPAs8VLtMnRb
	 cKglNRLnBkIruNchFhH4Y3Tylt8AqPzD2IBP2wfDLcnuhSphTNxSAUBuC52OrBaC8D
	 tHH0H3X33urW87k3HHHGjkxwBuJRJ4IXwQkfoCxC5X5nNbJVJFUQGeraUGhp1L+sdF
	 9FoB31KEr9JGdl6SvKP1dbl9gxyqgnQYE3/FnRcLbqcL4MNJkb+UehGJqFs9C5qK4T
	 3074AAPwXmHwtJ9HTcpqTDxj01ucUbZRDC1BcByL5Uogrc3vDLR6aA3qRl2OiZsTvT
	 DuRGAzg4FHqcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789D2380CECB;
	Fri, 16 Jan 2026 22:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] kernel: bpf: Add SPDX license identifiers to a few files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176860380903.826620.14876814103190343010.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 22:50:09 +0000
References: <20260115013129.598705-1-tim.bird@sony.com>
In-Reply-To: <20260115013129.598705-1-tim.bird@sony.com>
To: Bird@codeaurora.org, Tim <Tim.Bird@sony.com>
Cc: kuba@kernel.org, andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 linux-spdx@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, tim.bird@sony.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 14 Jan 2026 18:31:29 -0700 you wrote:
> Add GPL-2.0 SPDX-License-Identifier lines to some files,
> and remove a reference to COPYING, and boilerplate warranty
> text, from offload.c.
> 
> Signed-off-by: Tim Bird <tim.bird@sony.com>
> ---
>  kernel/bpf/offload.c | 12 +-----------
>  kernel/bpf/ringbuf.c |  1 +
>  kernel/bpf/token.c   |  1 +
>  3 files changed, 3 insertions(+), 11 deletions(-)

Here is the summary with links:
  - kernel: bpf: Add SPDX license identifiers to a few files
    https://git.kernel.org/bpf/bpf-next/c/4787eaf7c171

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



