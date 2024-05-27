Return-Path: <bpf+bounces-30701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4128D8D1090
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 01:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2F528325D
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 23:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9892613BAC4;
	Mon, 27 May 2024 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snj5yicf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B38917E8F8;
	Mon, 27 May 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716853231; cv=none; b=uM2h6dBjrYGVpsSqcvdLbf/AQbp/a7v5cex3Kfx6B+LF930qglgkdahEjJF2QjkLuAuJxxx6Ike5RUJ5akaWVGtFMItEZp+O9HXHWcTTXsi9Viuw15PeirFaYkNWscqk1IhLaFGkHC5rXZBbIokwQCujxMVgKvYnB4PJYTReqU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716853231; c=relaxed/simple;
	bh=eVNrLMG28WOiOibWqhaJNSVh/c7sWLRah+D1WWSxeSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kFbPOtgrYtPMj4XKSRGohsMrHB7kDTVXm7Lpx120ZcIOg9KvcbdWABylhWZAANdVgnGmZwnbmvjxoGDo+A7gDa9erT25qN4OrPutb390WTetgUvujQ0mLqk0BD1+D+8K/TLPnJhR7BbWJyKd6hFZaYN4F3gkFDuPrSip3s3k2pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snj5yicf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 749C7C32786;
	Mon, 27 May 2024 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716853230;
	bh=eVNrLMG28WOiOibWqhaJNSVh/c7sWLRah+D1WWSxeSo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=snj5yicfOz5l/k3hSVwmzUv9D7pvsAUlcZBqS7TShCZjUdMxN4oRGzCZnxLeWF8Zx
	 I3tvgEVhIwO5WAFrleIcANZNBMxZq/81NrzUVSiTvOBcbYlLiFv1eSdJone/Bj5MWa
	 5GevvIGI0Ti+m0ob9DOB3RtTFxmo7/u4ZglR1p/fowiFWkspzZ6Z1Lwg0zfjcyETQ+
	 UPeNXeXBKK5g7ne2Q6AjRuWao/jhvwswf6YaB8Kr33gsAnIPygWWk9s4o95iKd/Pas
	 6khd5HTARaf0d2b055WETXT8DzSGvXd/Gx/hOx9zbRtO4XKjiW6M+KImny6f3zxh4Z
	 N2J08ct3QORfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56F49D40190;
	Mon, 27 May 2024 23:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-05-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171685323035.16232.14533245018227338013.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 23:40:30 +0000
References: <20240527203551.29712-1-daniel@iogearbox.net>
In-Reply-To: <20240527203551.29712-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 May 2024 22:35:51 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 15 non-merge commits during the last 7 day(s) which contain
> a total of 18 files changed, 583 insertions(+), 55 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-05-27
    https://git.kernel.org/netdev/net/c/2786ae339ef5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



