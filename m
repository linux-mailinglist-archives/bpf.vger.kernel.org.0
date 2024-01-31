Return-Path: <bpf+bounces-20850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F4E844622
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9AEB327F9
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39C012CD86;
	Wed, 31 Jan 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUHS2kxy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E882868
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721658; cv=none; b=e62VW5bWE+EX9pELREjFcxPtZTW+nbZx4RgtsN8Iv3oqNZujiEv5VpndIhr4lX6LrCsWWUSkFnmS9nBPjRmwYw0YS9dTsGVO5BKqvdd9AoKOni7xBUx9fVCet4Bnb7D4duiIbyC+z6WXQsHac512j3ZzPeEscuFD9cTtPrXvLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721658; c=relaxed/simple;
	bh=P6mPokena7rpJUjxgtc6u9gmV8r7KA8B1UKtbAHeQ7k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l56v770Nc4q8crxhMKF24LevPKkxFxLwbAhswyH6mrwOtChq/9acm1s62ezPcgmYvHqpwNC6rfOBFFjtk1HNYeAF3WfPVCjwB+wW8q3BIM0F+DBzUCIlSUpSs8Zn7VeMb7mcSZuuq6YJjnEf/BLIrdDtP0UPm3bJQZo5BWz8ihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUHS2kxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2FB4C43390;
	Wed, 31 Jan 2024 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706721657;
	bh=P6mPokena7rpJUjxgtc6u9gmV8r7KA8B1UKtbAHeQ7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KUHS2kxyrDregLnNLomGMAnLlZ99t+qYf0z1EXUXF5LHGoAPM9xr/jlg5bnNY4dD1
	 XkNKkj0g3q5ASXgjTJXWO9DzIZV7rjOvsKO4NPqJVBzWZh1TXJeE6pGA7guoNYGtK4
	 LEm+VmYa39Jvrb2Q7WMglQ2TeAdkHPo/4OFO6FFg+bE7quAbdIO1TYBPb4z0CUglbS
	 I+adUMdaGP9PC2YYWCTRGLwWOGkEpFPrL7S+Ll3ALRu/KEVXX488WEP1QtzuVA9tTy
	 nqpLzgG9sf53eMwr6Nm5gXVx3h281dJLYgnZ4m9/hE3tmwCk2HQJssIvL1DbsBaOnW
	 qFEwgLTmkSS+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7381E3237F;
	Wed, 31 Jan 2024 17:20:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next ] selftests/bpf: disable IPv6 for lwt_redirect test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170672165768.1687.6411276826226071550.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 17:20:57 +0000
References: <20240131053212.2247527-1-chantr4@gmail.com>
In-Reply-To: <20240131053212.2247527-1-chantr4@gmail.com>
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, martin.lau@linux.dev, song@kernel.org, eddyz87@gmail.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, yan@cloudflare.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 30 Jan 2024 21:32:12 -0800 you wrote:
> After a recent change in the vmtest runner, this test started failing
> sporadically.
> 
> Investigation showed that this test was subject to race condition which
> got exacerbated after the vm runner change. The symptoms being that the
> logic that waited for an ICMPv4 packet is naive and will break if 5 or
> more non-ICMPv4 packets make it to tap0.
> When ICMPv6 is enabled, the kernel will generate traffic such as ICMPv6
> router solicitation...
> On a system with good performance, the expected ICMPv4 packet would very
> likely make it to the network interface promptly, but on a system with
> poor performance, those "guarantees" do not hold true anymore.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: disable IPv6 for lwt_redirect test
    https://git.kernel.org/bpf/bpf-next/c/2ef61296d284

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



