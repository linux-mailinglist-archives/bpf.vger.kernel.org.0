Return-Path: <bpf+bounces-69870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EB4BA529E
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 23:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1663A4055
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 21:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DEA286424;
	Fri, 26 Sep 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnYp7GlO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61578834;
	Fri, 26 Sep 2025 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921011; cv=none; b=LgtTBUqskmMr28mUc3LXhEs7YUd+g5eYWw7WP+K0B47S/Wq46bkU/YOxs7CGB0iU20XPRaGuDtFVIN/ZoQUYg4IBG3S30p9mgHQr9UKllSgAbqOjbQQ7ZN1MK+QCMmljfCiP++HbCwEzY/tc4PVRb9l/Oxff2d15anABMFWCkfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921011; c=relaxed/simple;
	bh=RZ9HdT/IrQyoxMK3r2oqrAQedDK6FkLdEup2Y9J5Pks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eC/XbE4xDgSa0+dEM1pHPQhXfYASEQiuBcNxVMNfyiyY/cSE8qTTfGM//5eUh6CaJ1g4Omc/FACknY4q/8cWKhhfs8yVAF55FLo5CoKIz3z6krq3y/3qByBgDcVioWd0O7Me+TfisiHA3eLt2+789G0Vr7arvwHwjSkA7retuJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnYp7GlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41461C4CEF4;
	Fri, 26 Sep 2025 21:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758921011;
	bh=RZ9HdT/IrQyoxMK3r2oqrAQedDK6FkLdEup2Y9J5Pks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HnYp7GlOdCehftOf+USsNpxP4OKt9On5CuqDc7vCK2F07emKeWvqty4TqOPA7URdU
	 TGce5HNwgwLR39joavBgM343nGRprYjuCatCd9pGvopX1+n3daHHCQvsSWPvcK/EK3
	 AWDFltNnZUtJuNKDuv4oWhbdU1sVMXsRwPYdkatZUidQ0HM3SCZh86HqGyAGvqtAMv
	 qO48lbGp04QKgxKfmFSf6ksb8pAdVySByvadUhf5btY8DzPgum67LtCMqruIDgYJ/l
	 HM8y8wX4Q9TakZ0TZ5PigfWp5myk3J5uHc4aLUapUtTsPW011yEfrSIui3nANrOH9f
	 HerN13wgopfDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC2939D0C3F;
	Fri, 26 Sep 2025 21:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/1] selftests: drv-net: Reload pkt pointer after
 calling filter_udphdr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892100651.59026.11406625421598531145.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 21:10:06 +0000
References: <20250925161452.1290694-1-ameryhung@gmail.com>
In-Reply-To: <20250925161452.1290694-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, stfomichev@gmail.com, kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 09:14:52 -0700 you wrote:
> Fix a verification failure. filter_udphdr() calls bpf_xdp_pull_data(),
> which will invalidate all pkt pointers. Therefore, all ctx->data loaded
> before filter_udphdr() cannot be used. Reload it to prevent verification
> errors.
> 
> The error may not appear on some compiler versions if they decide to
> load ctx->data after filter_udphdr() when it is first used.
> 
> [...]

Here is the summary with links:
  - [net-next,1/1] selftests: drv-net: Reload pkt pointer after calling filter_udphdr
    https://git.kernel.org/netdev/net-next/c/11ae737efea1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



