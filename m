Return-Path: <bpf+bounces-29680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C46D8C4A4F
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 02:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CC52852DD
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 00:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B1F39FE4;
	Tue, 14 May 2024 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7xymU9R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B81F934;
	Tue, 14 May 2024 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715644846; cv=none; b=JFKq9UapDLKOerlXMxyKWKwglyXs9k0sh52R1uD/oj4nfb161Y2jxsuCdFZTRhebekOnENUFLZR6g0Un5UDLmu1FxBTxdET/bAONa0sZ/Q1l3tywNnuuqkflsinpqGNU7aV2UHjdSxh1O8FGQAbH2S412cdwLARUnBbTH0v8sIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715644846; c=relaxed/simple;
	bh=g0j7B4mHgMgoOYzzJUY4ZcRxz2J1GzTCB3BDch9o1W4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F7rVY6SI4TtvMlv9s7HWqCqKV9Avk1pMSq38SytB5Uny4fZOOxteSrJapH9hFP0zDolOVs34y58H4EdKYyKEL9sISFLfN+JNF5BinBp+Kb8y9C7oeOaVPo8DvVXl0RsC9VGie3lmpMyWqnPN1UmewTPGrNT/jDQgNx7VgmNg0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7xymU9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33198C32782;
	Tue, 14 May 2024 00:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715644846;
	bh=g0j7B4mHgMgoOYzzJUY4ZcRxz2J1GzTCB3BDch9o1W4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G7xymU9RaV5lkaab/VgPz/xOp+S2qK0agn3LZ80bv4GWeTtxXDL8/p7chTvRKi7Ch
	 +Zk+bfiXtPVrP3Ou4Bxpn3HT+4cCGgqbjJdBiSBBOQCxtYHXjfNJJmhyU/phZ9/O1h
	 66hHML+iFofL9vr/GO0cEMwXRUY1pJhFjdXzUaqcsZMQXbfdBPik6OSUqXv1fiQ0Wa
	 oDFonu5azT2n/aoNjynyacuph0AXRCtjoVydOftSReqnI3H/BTf0iejU47Gv50O66z
	 ghKtjjJtVeCmijxey3KCE/vRbegyOV7ojJZYbi+4wgJJg3lf0HG++YBRknEMDsHcJX
	 NFAzXHdHh8ZXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BCAEC433E9;
	Tue, 14 May 2024 00:00:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-05-13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564484611.4532.2652099508151774396.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 00:00:46 +0000
References: <20240513134114.17575-1-daniel@iogearbox.net>
In-Reply-To: <20240513134114.17575-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 May 2024 15:41:14 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 119 non-merge commits during the last 14 day(s) which contain
> a total of 134 files changed, 9462 insertions(+), 4742 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-05-13
    https://git.kernel.org/netdev/net-next/c/6e62702feb6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



