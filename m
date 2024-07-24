Return-Path: <bpf+bounces-35579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6127493B964
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 01:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624131C217F2
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8F613D28F;
	Wed, 24 Jul 2024 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otCocJyk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A52E639
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721862631; cv=none; b=HcQohifp/f5z/Pm/AMVW5Qy2Jy6QkrKIoRElxLFw+P/vDw1+XfidQuPT7V9UzqKZmUG1v158ei1HZyRnPh9+mNeUXo9y+VdUrtnWatpDI5mxEO1LWXpSB8OROOl5fPnFvdhJ+2YFqYAV6HG4V7RaAQSPPbibKm0ztl6wTQi5iio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721862631; c=relaxed/simple;
	bh=mRvLRiDoPoq3zKib1gVUZNEPhDkuTbZB52NWa111ecY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xz3fLkLsrDnsuyGKmm+3Wq+P/vsrv8YoOyr7Xaq+Xm7XzFuD/TX+1+i5WxbmaOf9XJKIHCF+kgIJLCSVGk8hcQWiqYwV2aPWMxanjnyHVA57fjnnbaB3+PXSUbeEaxPclyoJQrc0ytiKoPC8RkzrtDrhV8xcOb0cbb0TPIhuiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otCocJyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2036FC4AF0B;
	Wed, 24 Jul 2024 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721862631;
	bh=mRvLRiDoPoq3zKib1gVUZNEPhDkuTbZB52NWa111ecY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=otCocJyklhu67Safh3tXUIQtnJiJEqmJERyErH4alXQ8Cj5TgbkGMXSUz/cE1S/gO
	 g/OGGbbrJu/9CkJqCsELMDIEtcBs71DnzLd76PC+rCddsYV+ZA3a+HSKUWptyc6dkY
	 djafe9lC57g+YgtQIIAWWcpNoJ71em+aBTuuUrDoaQ57vYQ2GdJioupKw4bKQ5Ci8V
	 weNfq2fnjhPyvzjQ7GfuPIss/s1FFWEVfQgmiuhbTx1GRJZ4NtOYHiua00EaIA7HyH
	 L0D++eb/R/kiAUmr6XzcOBejLI349SSa/1emBWJEjCQLknSJFYWZmgbotIcoXQHuOt
	 FRQ1TTrcw3ahw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F941C43445;
	Wed, 24 Jul 2024 23:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: make %.test.d prerequisite order only
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172186263106.32720.15547320171443015281.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 23:10:31 +0000
References: <yyjJRl5LODbI4-FseU0wIP5e4ik0zAy7Sy-5eGwrzG_UanI8rwWlQPfXAFnn_27hoZFogoUHRSWxFsLk7hPr0b6P5TZ3cRrM30_ggnu555M=@pm.me>
In-Reply-To: <yyjJRl5LODbI4-FseU0wIP5e4ik0zAy7Sy-5eGwrzG_UanI8rwWlQPfXAFnn_27hoZFogoUHRSWxFsLk7hPr0b6P5TZ3cRrM30_ggnu555M=@pm.me>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, mykolal@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 23 Jul 2024 20:57:43 +0000 you wrote:
> %.test.o should depend on %.test.d order-only to avoid unnecessary
> recompilations due to compiler dumping .d and .o files in random
> order.
> 
> Link: https://lore.kernel.org/all/gSoCpn9qV5K0hRvrvYlrw2StRntsvZcrUuDfkZUh1Ang9E6yZ9XJGYDuIP9iCuM2YTVhSEzEXCteQ94_0uIUjx_mXwupFJt64NJaiMr99a0=@pm.me
> Link: https://lore.kernel.org/all/FnnOUuDMmf0SebqA1bb0fQIW4vguOZ-VcAlPnPMnmT2lJYxMMxFAhcgh77px8MsPS5Fr01I0YQxLJClEJTFWHdpaTBVSQhlmsVTcEsNQbV4=@pm.me
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: make %.test.d prerequisite order only
    https://git.kernel.org/bpf/bpf-next/c/f0b2ceb1f8b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



