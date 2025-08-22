Return-Path: <bpf+bounces-66289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E49DB32067
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 18:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85A01C2734A
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949B27587C;
	Fri, 22 Aug 2025 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcItSYTd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD1265623;
	Fri, 22 Aug 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755879601; cv=none; b=CLDlB3hos8KfEgvMZXBwysBZWVPyylhGXC5s10zxPGbHbeNCIMCouYpNp4uHRQ+tRd3mApRB0Ln7Zgi9hky/rEKtC1zl4EYi7aww58AG9EVCl9ZmMqj1Y+Pq1ym/BCpnrMIs8dBQVmZSDQCRreUvlxzxw1oK+u7PsEYuUeohAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755879601; c=relaxed/simple;
	bh=R0G3P8CW8myDEOBRhUDKwUQqPKYaMfY8M6jEwas7bRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=paaa23nIgwRwBoUY2FGLlO7ep6nFMozQ65r3+3Xnx29Ad+G4VURNHet0qiQr4fkv1q2upaWmqFk/2D52yYD/4qkO6CuEXjBfSOus9N0pVV8oZxliFFFQEqsg6nhBMpeXPxk251oawlhSsda8PekJw8Poy1X3E/obKSNt6VG+chM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcItSYTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84931C4CEED;
	Fri, 22 Aug 2025 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755879600;
	bh=R0G3P8CW8myDEOBRhUDKwUQqPKYaMfY8M6jEwas7bRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kcItSYTd3qHGz9XwR7Tx0edKCFODSlia8zVscyJoSOGX3i7QtcAgU/j1hijh84GDH
	 7/c+Bx8LqAvp5ba37DDwo78QtevMpccBkHWVG7mjFYF4cfHU6x7pJ7NQL6TMsC0CWL
	 o00JllDHUxuxxm/QpvF63MD8XdyIJTf28o+8I4bIbLS65nEyiCr5XOtTKNCG0ZRRzu
	 nRH2N/JVwlA3L/p1FbFpZhjAA2N5YRb9xQqYk7G8QZ1F1T+S3/fPm9txqcXl0lK3sj
	 6hvkUlfwuLNb8B3jHaiYShJ4Gr+4OnqpR3k+03jc592xqDUIR5y4qqmqNtUOGl9gaN
	 1wpCd7z3r/icQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EF0383BF69;
	Fri, 22 Aug 2025 16:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 bpf] xsk: fix immature cq descriptor production
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175587960927.1895682.3818186077028275399.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 16:20:09 +0000
References: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, aleksander.lobakin@intel.com,
 e.kubanski@partner.samsung.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 20 Aug 2025 17:44:16 +0200 you wrote:
> Eryk reported an issue that I have put under Closes: tag, related to
> umem addrs being prematurely produced onto pool's completion queue.
> Let us make the skb's destructor responsible for producing all addrs
> that given skb used.
> 
> Introduce struct xsk_addrs which will carry descriptor count with array
> of addresses taken from processed descriptors that will be carried via
> skb_shared_info::destructor_arg. This way we can refer to it within
> xsk_destruct_skb(). In order to mitigate the overhead that will be
> coming from memory allocations, let us introduce kmem_cache of
> xsk_addrs. There will be a single kmem_cache for xsk generic xmit on the
> system.
> 
> [...]

Here is the summary with links:
  - [v6,bpf] xsk: fix immature cq descriptor production
    https://git.kernel.org/bpf/bpf/c/dd9de524183a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



