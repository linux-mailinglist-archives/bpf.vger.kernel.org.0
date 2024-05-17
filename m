Return-Path: <bpf+bounces-29891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1E8C7F52
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 02:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DEB28202C
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 00:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46899801;
	Fri, 17 May 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYbloLGj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08DB38B;
	Fri, 17 May 2024 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715907031; cv=none; b=J9d2IaJbt/bI6TF+WDXNCaP0wV4HRfPMBbM71UBT+qeH9iph1lkpHnkVa8xkNRdVJTADknYaUoIYZZtbm6NUsPRSS0OOU42Ddx0f8wPFls2LsxXojll8jDOwffAjPGINML7VwzRRBUywy4L903XaIxHD1hmXbDyQyywjgDCL6N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715907031; c=relaxed/simple;
	bh=4gSze8bEy7oTQd7kCFcT+vRlxL45rl915V7m8GOk+ZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bjiWq6mZ7TYoscWlASXOcPLFNX/MPt8CpjNF3RH2WNR397GBJBZSpvNprZY2zAHtxJrfP9hdLTebPai7jVJYUsXXvk1gUqj5fcmW/7pvUGwb09eqYG3cbVBQ+p+WnXZ0MWHdQtF8OVi5eQjZiJVJVkwSvgFup6lOzl2Urw5hAvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYbloLGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94F28C32781;
	Fri, 17 May 2024 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715907030;
	bh=4gSze8bEy7oTQd7kCFcT+vRlxL45rl915V7m8GOk+ZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QYbloLGjkfl4Rg8OgwHn8JWhaM0/VmY9lZd5I2v3UxFuMpwhEo43dWyNM/zit2+NM
	 R1c7UE02YfR2lZvvQ2wpEAc4zFR9cO3IyP41nQrEj1uR4lKfW3HSFz25FS71Anpli2
	 DxkW07epUyOwQyL87+LvXcUybcvTSP1NkyDy5o3exEBv7+KwhMTJg1feiVgL5RyBAh
	 /npBqEDlkPCByOQWW9xkK9cjHSw4kTAi/LRbjYZqeSdnP1b1tdZM5DM8U0qvvVgR7/
	 OtGbecSpnVTqgj+p5300kYtWRwg01vm8MLR17OtHPnkBmJJeRVoi1pLlc+UuG8dWDF
	 /AmrouLNDXPhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83C24C41620;
	Fri, 17 May 2024 00:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-05-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171590703053.10832.13700978538836071473.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 00:50:30 +0000
References: <20240517001600.23703-1-daniel@iogearbox.net>
In-Reply-To: <20240517001600.23703-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 May 2024 02:16:00 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 7 non-merge commits during the last 2 day(s) which contain
> a total of 8 files changed, 20 insertions(+), 9 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-05-17
    https://git.kernel.org/netdev/net/c/52d94c180a9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



