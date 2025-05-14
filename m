Return-Path: <bpf+bounces-58261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D3AB7920
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 00:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007453B3698
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 22:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F44A223DD2;
	Wed, 14 May 2025 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoqMG9pW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F81282E1;
	Wed, 14 May 2025 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747262395; cv=none; b=GL0dvZKs7s+vIXmAeXETJz8Btx3lwtOYTunELJxjrHepa4d3hfgJidYYl0NQ+Oy0NkdCzN3i/7ZHMVH/EIEfwRd1Rcw5fjGfYVnEAqJVxYoIM1+/XscEp1yBOATKZbKpWRlQibNTWBZ1JDqZzp29FItFIJReP7lN1PBt1XAJWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747262395; c=relaxed/simple;
	bh=Ra5qxq65oR2e3oclUNAR+dZR6VfUdIyw6lil2iX8efU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gaIPc3wG8e+Hxo6Ftv+1IF2XrZB2iOQVjWbZHxTy9QAer4JikQ/nBhDUoT+0Hea0ksWc3vnOb1eabm6nhb77GJfhn1CCqCii9esfu8zlMCfz926u5TTeUSzlG0YyqaesohNMoz+BgH5Ym91JqB7u+uLUOhDLvIIuTXuufwoBY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoqMG9pW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE7EC4CEE3;
	Wed, 14 May 2025 22:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747262394;
	bh=Ra5qxq65oR2e3oclUNAR+dZR6VfUdIyw6lil2iX8efU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PoqMG9pWvGyH73TQmC+ZhqD9eBU/PDL7D4Y5w2RVJebl9TA3wVmnuYqsPlpezTdax
	 4A1WbpAniMl2YckFXmMb8gSN5YgWsLUFTngmkKyu2xBEYL+qverQFAzRuVsmSTNrkz
	 h6IeS6U4Wi8OyjyUatPe/Dd3zPva54hmI0G91cT+9ciSuVX9QW/moK+p3vcPAIe7/w
	 5Yb9cGXxEx3Wx3EQE7XXgv4TL1PFp8z+G9OzfLOSojy8wJ+edWnb1upTXIsi/R0vW2
	 PcXCDZeApTjZ7O5+Jov6I2bVvXSCuAtU0MtPWvYUsAubD+rNIx+i5gGz74rn6Mtl2t
	 Rrld7ntXzhh6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5B5380AA66;
	Wed, 14 May 2025 22:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 bpf-next] selftest: bpf: Relax TCPOPT_WINDOW validation in
 test_tcp_custom_syncookie.c.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174726243176.2534141.9628048963449437170.git-patchwork-notify@kernel.org>
Date: Wed, 14 May 2025 22:40:31 +0000
References: <20250514214021.85187-1-kuniyu@amazon.com>
In-Reply-To: <20250514214021.85187-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 martin.lau@linux.dev, edumazet@google.com, kuba@kernel.org,
 kuni1840@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 14 May 2025 14:40:20 -0700 you wrote:
> The custom syncookie test expects TCPOPT_WINDOW to be 7 based on the
> kernel’s behaviour at the time, but the upcoming series [0] will bump
> it to 10.
> 
> Let's relax the test to allow any valid TCPOPT_WINDOW value in the
> range 1–14.
> 
> [...]

Here is the summary with links:
  - [v1,bpf-next] selftest: bpf: Relax TCPOPT_WINDOW validation in test_tcp_custom_syncookie.c.
    https://git.kernel.org/bpf/bpf-next/c/4dd372de3fde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



