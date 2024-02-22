Return-Path: <bpf+bounces-22509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D928C85FE73
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 17:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E9EB2430B
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DF214C5AB;
	Thu, 22 Feb 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3BaERjt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10858C0B
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620628; cv=none; b=BKMEBNUQHmLMKQZLTxm42ocJZxfm1sWUh+QQuJMjWvxVwLjdZkxoMCNcvMIZnp0nDLPTpx1MySDUQSlQkF4kLGguq7vK/CWkZyEJVG2jJpXFjDHg40HLYQVSBi08CYcgPBbveey30m3jVGpphvAcgJHSCiPljyeuqHma528C47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620628; c=relaxed/simple;
	bh=oGh6NwgeWfBHaQ3f0i3MJISgdsB6XswmB7xiATyHJMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K0KNvLH0V6azdGDDFlWKKwrPg8oUmgWMB1m8U3KjYRgA42uXVG0Ye+nN40SdMtdHlIOVR7w8bi5u+1PsGVr2xXHOv2rLRr3v0IXS04Tnu0SL64VDVoa/B9aXispdc+jWbXFr1gEyOfttmxNsryYfnOut+rOf4pTCFP/rAWW0pnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3BaERjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41C97C43390;
	Thu, 22 Feb 2024 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708620628;
	bh=oGh6NwgeWfBHaQ3f0i3MJISgdsB6XswmB7xiATyHJMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B3BaERjtllAymkywoy8vRWbtKK5gp6fRNBgPgy2y8OQ/taNJ2BQukjWhlKpTZfdL2
	 X5yyBcuHWowepm3OFRW+Wrrqdwkw8YsR8jWmUb1/020p1hVbp5YFXRuV7Caa8vpzxv
	 F+Gngzm38XRYkPwQlH5B0mzwlxkvlBOHkGmjCa7PbGKEAXEOsWIrp1sr9x5eeAvFdP
	 qqufTj0G1ACUvuvYtQKIez/Kbjy8YZ8F5q/Lq9/wiEt7USBqJrAA11MT/uQZYptC+o
	 8OGze8zkVZ9F7kFfs+yWK2YMA3+ZDXgIcqvU3QFM54DoXGCdT6kZWoFqN8neeW1sO3
	 rq7J/LSWUsVAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27465C04E32;
	Thu, 22 Feb 2024 16:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/1] selftests/bpf: reduce tcp_custom_syncookie
 verification complexity
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170862062815.30322.2285512260477496828.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 16:50:28 +0000
References: <20240222150300.14909-1-eddyz87@gmail.com>
In-Reply-To: <20240222150300.14909-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, kuniyu@amazon.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 22 Feb 2024 17:02:59 +0200 you wrote:
> Thread [0] discusses a fix for bpf_loop() handling bug.
> That change makes tcp_custom_syncookie test too complex to verify.
> The fix discussed in [0] would be sent via 'bpf' tree,
> tcp_custom_syncookie test is not in 'bpf' tree yet.
> As agreed in [0] I'm sending syncookie test update separately.
> 
> [0] https://lore.kernel.org/bpf/20240216150334.31937-1-eddyz87@gmail.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/1] selftests/bpf: update tcp_custom_syncookie to use scalar packet offset
    https://git.kernel.org/bpf/bpf-next/c/b546b5752695

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



