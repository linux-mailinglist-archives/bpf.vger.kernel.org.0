Return-Path: <bpf+bounces-42291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5639A20B4
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 13:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344B0B21A1B
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7931DBB21;
	Thu, 17 Oct 2024 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyZZ8BRX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B627259C;
	Thu, 17 Oct 2024 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163424; cv=none; b=Z8lhMBi9yNodA+CcYLCpC8I0H5Rvzwcs/xnrMeNj+rzQCYiPbN71OodEVOt+mzQQBVC06zxGHDcP/J/CavQR5OzuCYzs/58BcAK4oxGBUk9JhAdNSq8Z5gmaGgKdvSilokSXnYJwYwNQzqa2Pt/ni8c4i6pG03thVUmFydmpS2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163424; c=relaxed/simple;
	bh=Si6MFxX2jn+dWiwkC5WpwNC76Ip6ddo9O69GxNZlU40=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iyHUUDXukRz1QrO/mEVCH6hj3tefrs8Gt4eW+VqvsTCSPZJZVr3Yx/CaKt1nrr6rXth7RUEr8L7TuUOJSYDx8cnb2dA0EhZixgylwpfRFDw2URiS1hWUNapCA2tsFD5xy2+C55WBcAB5IKR95/NqtBmhiOB8YpFjr0LnBgGVgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyZZ8BRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8066C4CEC3;
	Thu, 17 Oct 2024 11:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729163423;
	bh=Si6MFxX2jn+dWiwkC5WpwNC76Ip6ddo9O69GxNZlU40=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZyZZ8BRXx9i2Dko6CXOZzSZMIeDVpq58B8XEiKSFmX1KgnwUjqaKgGepmhePeLFp7
	 3oO6DSZYB3qYQZqoKvTT5O9bPtVI95z9IGB7waPUEjnonC6UT7pVsfawxQRdydtMOz
	 4U7RHqTr4afQhD0pXv3DmfihJ5iQevnwrBOLzlCTVM0vExs/dSe1yHzRk6PEitP62o
	 niDTZMOm/ZiomUGeg8+TTaTDfJvBTxlEbdeZPbPZrPftuCdYQmV5of2LpJPzUC8bn/
	 /D9MFRHT9cHWONu2xhUKMYkZpJakyYeGEaFXTMq7oOtxsWOtwt35ldQRtGaQbGi3/c
	 AcMSUAcQPjjWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BF83805CC0;
	Thu, 17 Oct 2024 11:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/4] bpf, vsock: Fixes related to sockmap/sockhash
 redirection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172916342925.2436315.7418332964701655166.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 11:10:29 +0000
References: <20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co>
In-Reply-To: <20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 mst@redhat.com, sgarzare@redhat.com, bobby.eshleman@bytedance.com,
 stefanha@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 13 Oct 2024 18:26:38 +0200 you wrote:
> Series consists of few fixes for issues uncovered while working on a BPF
> sockmap/sockhash redirection selftest.
> 
> The last patch is more of a RFC clean up attempt. Patch claims that there's
> no functional change, but effectively it removes (never touched?) reference
> to sock_map_unhash().
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/4] bpf, sockmap: SK_DROP on attempted redirects of unsupported af_vsock
    https://git.kernel.org/bpf/bpf/c/9c5bd93edf7b
  - [bpf,v2,2/4] vsock: Update rx_bytes on read_skb()
    https://git.kernel.org/bpf/bpf/c/3543152f2d33
  - [bpf,v2,3/4] vsock: Update msg_count on read_skb()
    https://git.kernel.org/bpf/bpf/c/6dafde852df8
  - [bpf,v2,4/4] bpf, vsock: Drop static vsock_bpf_prot initialization
    https://git.kernel.org/bpf/bpf/c/19039f279797

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



