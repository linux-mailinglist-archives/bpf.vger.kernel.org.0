Return-Path: <bpf+bounces-75011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DD1C6BF41
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 00:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 053242C2BE
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 23:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5D62DC79F;
	Tue, 18 Nov 2025 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atAQhMNB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45C1A0B15;
	Tue, 18 Nov 2025 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507442; cv=none; b=PQKCpXZH70Wmz0TBxPVqSvib9RM8/Q1BUlD7d73tQ/ou+/H7+pXLpWKxFVLnDvN9H1T2vKawxB0YQzvYTrnqpkDvt8bcRL1NV/qCzgR9rcFOepgaX+z+7hTog0oxQ9R6OfhtOHANh800SBW9ikfjHT81xMaL9rxXzdl1+5L0Bok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507442; c=relaxed/simple;
	bh=LKUMkLY9wh6mOUnIETlwyHZQ7VI7TGLDUCofqm2ji7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tjes0CttPU0gIiJJ23S5Q3aG8SvOOtb0OEmJVeTZrfNiHYUc12C8wHL7qe9M5LD5V75mE9hAvGbev1TZ5d/I9NEZlfPRnUOoFnd7L4iVCr/Kjn8CgWPhWKrGky1BvfSDRF1ecF38fVSIJrCkwV1+4etU+4SDV6QqR+WSNCPP8Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atAQhMNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F35C2BCB2;
	Tue, 18 Nov 2025 23:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763507441;
	bh=LKUMkLY9wh6mOUnIETlwyHZQ7VI7TGLDUCofqm2ji7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=atAQhMNBYaPUtUSsjXV7DWH77b/wxc12t1tFV4dUHxd+D2v+jwv7C0NSQsk+FQ2m8
	 BuWNG4iHjiBzdiBAPWJK/ZXd5rYDpfBj+AvhVLRRcwC2rexYdCdbi0abUyRAHZ0xuY
	 ALu2q2Ai2oMN95NZr17rx9TPz6+b8uxIgGG3cHLUjclL9Fi7Qflo7EeXZJmNKHehDT
	 ZQWGm3G3O+VB6opOfCwAU/j/jMVvCX6h8pe9Tye1L4l8w4SPa+5nm5xdrdBFUVzMPG
	 49IeHWy4IEO/dDkfj4V4T3qWvpnL08p5kGW00oWGR5bcIPsQm7hOLsjyyDroFFvqQj
	 Ho4jlzCJzHkJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E97380A94B;
	Tue, 18 Nov 2025 23:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next v1 0/5] selftests/bpf: networking test cleanups and
 build
 fix
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176350740725.137683.16243703644793290914.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 23:10:07 +0000
References: <20251115225550.1086693-1-hoyeon.lee@suse.com>
In-Reply-To: <20251115225550.1086693-1-hoyeon.lee@suse.com>
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: bpf@vger.kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, llvm@lists.linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sun, 16 Nov 2025 07:55:35 +0900 you wrote:
> This series refactors several networking-related BPF selftests and fixes
> a toolchain propagation issue in runqslower.
> 
> The first four patches simplify networking selftests by removing custom
> IPv4/IPv6 address wrappers, migrating to sockaddr_storage, dropping
> duplicated TCP helpers, and replacing open-coded congestion-control
> string checks with bpf_strncmp(). These changes reduce duplication and
> improve consistency without altering test behavior.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/5] selftests/bpf: use sockaddr_storage instead of addr_port in cls_redirect test
    (no matching commit)
  - [bpf-next,v1,2/5] selftests/bpf: use sockaddr_storage instead of sa46 in select_reuseport test
    (no matching commit)
  - [bpf-next,v1,3/5] selftests/bpf: move common TCP helpers into bpf_tracing_net.h
    https://git.kernel.org/bpf/bpf-next/c/f700b37314d9
  - [bpf-next,v1,4/5] selftests/bpf: replace TCP CC string comparisons with bpf_strncmp
    https://git.kernel.org/bpf/bpf-next/c/ec12ab2cda66
  - [bpf-next,v1,5/5] selftests/bpf: propagate LLVM toolchain to runqslower build
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



