Return-Path: <bpf+bounces-56876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4762CA9FD6B
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 01:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE0C3AC368
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 23:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82146214A8A;
	Mon, 28 Apr 2025 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0lej+TJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8D52139A4;
	Mon, 28 Apr 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881217; cv=none; b=NVnhWMKt14nOyQlK8DpAcuHJIAJ1N/tcbT27GqxMG2VoM/rETE431wsSralhuoGVhE1Oe6PyC1VWMzOxabOQlx6K2ROOaRi3U75SyuXkVG+x8FAtvDK312VWeO3eOPEG+LaoCkOcVDYD8tSbclfsLeWAbB+zCS40x1sbT2pEnu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881217; c=relaxed/simple;
	bh=+2B8LzZZ1xBH8+FnZOQo4MpOVOaqegI8Rk5fQAZCrxU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=USMHQuzK35hGxgx0uz6cGqbfiuiI1uF2ska+WrMGRmgGp/yyuVE4k7q/XNthM350kcLU0LWWvoaNe5c75yPeGqhA8Mr+L9Rh01PDvwkA7At7vF25fB7qi02j3iGhmYssg1Re/z6MGK0PdcRBUY0t4OtvToZm4KeS8jZPdGM6iyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0lej+TJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C25C4CEE4;
	Mon, 28 Apr 2025 23:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745881215;
	bh=+2B8LzZZ1xBH8+FnZOQo4MpOVOaqegI8Rk5fQAZCrxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D0lej+TJ+TI0L8YjDNDqMVPSRzA16BdGc4qgjE5yZssUxJc8yOyWkPMSeXPlPUzqz
	 mxfkgZtrd/p9NVYjxTDEj7oZXNmCfKKzWoiAeB334dpsBUUnkJWc+LQO4KnZg/Ax+L
	 rUiqufgVb/dZcArftRSqTulSNHKCAUUZpy/Ro6KDYpCn/UXPwtCVA8B86qmoONjk1a
	 F25iGK19a55ivj2YHDnHE1ixV1BQjQP8BfLSP5RlfXMYfEwHjDw3K77IBfbV2Enj22
	 OKzFs+VD798I5BozYqHuyv7EVyBMr+55ykaPEEA4f/eJ6NpqUjb3pPXiHN38cvLPuu
	 1A+62pcvx1+2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D593822D43;
	Mon, 28 Apr 2025 23:00:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/4] virtio-net: disable delayed refill when pausing rx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174588125398.1071900.5897121305047846367.git-patchwork-notify@kernel.org>
Date: Mon, 28 Apr 2025 23:00:53 +0000
References: <20250425071018.36078-1-minhquangbui99@gmail.com>
In-Reply-To: <20250425071018.36078-1-minhquangbui99@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, eperezma@redhat.com,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 14:10:14 +0700 you wrote:
> Hi everyone,
> 
> This only includes the selftest for virtio-net deadlock bug. The fix
> commit has been applied already.
> 
> Link: https://lore.kernel.org/virtualization/174537302875.2111809.8543884098526067319.git-patchwork-notify@kernel.org/T/
> 
> [...]

Here is the summary with links:
  - [v6,1/4] selftests: net: move xdp_helper to net/lib
    https://git.kernel.org/netdev/net-next/c/59dd07db92c1
  - [v6,2/4] selftests: net: add flag to force zerocopy mode in xdp_helper
    https://git.kernel.org/netdev/net-next/c/5d346179e709
  - [v6,3/4] selftests: net: retry when bind returns EBUSY in xdp_helper
    https://git.kernel.org/netdev/net-next/c/b2b4555cf2a6
  - [v6,4/4] selftests: net: add a virtio_net deadlock selftest
    https://git.kernel.org/netdev/net-next/c/c347fb0ff844

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



