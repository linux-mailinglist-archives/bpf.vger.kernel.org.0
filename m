Return-Path: <bpf+bounces-61022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F9BADFB0D
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 03:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98AF3B79E9
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 01:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8533121C9E4;
	Thu, 19 Jun 2025 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY4Piz6+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D3137932;
	Thu, 19 Jun 2025 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750298379; cv=none; b=f97+IfJZWUvFat7hxkUKveBM5LBPnzO59VhjsE3YGBjeL2pwtHiRZbHzmSarAITYHZ3dvwc4OEVYX/d+BGoW1aUn7Pg+W0YfwKJSdUPKJBUCDeY91Vc6s6jIYLjQRmTO/b+lyDsDtIVrBS8Qh4GueICdSTs/E3pfEX3QrEaXRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750298379; c=relaxed/simple;
	bh=khrqJTYzLiyC8cYk0kH+2VMCEQnQ/rTVvh2Vw4TXnC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wgu8HYkISTdx78OyeYyYO1DvOV7dFwDwqICz+HdyOGSMsaSDR/s87ySr4DCKXTaQnnYWWZ/tSAmSSnpL0sNuvWbeqJaAWwiNgVQtCONLr94ZO6pNTIARD0zHXWu4lr7GaM4JKOGgblcx80yS1JNNeKp9HciovNCYRSYOwlaxQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY4Piz6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B4EC4CEE7;
	Thu, 19 Jun 2025 01:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750298378;
	bh=khrqJTYzLiyC8cYk0kH+2VMCEQnQ/rTVvh2Vw4TXnC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MY4Piz6+HC1N/Se0ZBfxQ8eaLBuV9NMuHW4UhNfHesUcGbGv/K4FmWtbbclNvC4Fh
	 JoV8Bj8cvdIgTpqp2DLMo7EUifSzAM2S6lufdqJbhfg1pKKCztPvSl7FBYMxM32eIG
	 LHVGm7/QhPklda6FtG5QiEbbfLvV19riJLTGdZNvdYUGQYx+YReYdUsQzQo+jFzCLf
	 Js2OVXYIVt3osjvclMt5euHyxvBT8suDbHjeST6JCckWsHoYxbIWxKMV0MxqE6vvbw
	 Yd3MRS9HApMVrfMRS+02Z0L80xnWaPqxLrnr/pYJV1iG1XAsdaGRjbCFQmlwrxrCBs
	 QoEpLm++OXDNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB00B3806649;
	Thu, 19 Jun 2025 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: lru: adjust free target to avoid global table
 starvation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175029840650.320658.8717699321491832494.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 02:00:06 +0000
References: <20250618215803.3587312-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250618215803.3587312-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev,
 stfomichev@gmail.com, a.s.protopopov@gmail.com, willemb@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Jun 2025 17:57:40 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> BPF_MAP_TYPE_LRU_HASH can recycle most recent elements well before the
> map is full, due to percpu reservations and force shrink before
> neighbor stealing. Once a CPU is unable to borrow from the global map,
> it will once steal one elem from a neighbor and after that each time
> flush this one element to the global list and immediately recycle it.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: lru: adjust free target to avoid global table starvation
    https://git.kernel.org/bpf/bpf/c/d4adf1c9ee77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



