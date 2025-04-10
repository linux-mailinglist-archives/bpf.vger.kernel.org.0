Return-Path: <bpf+bounces-55619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA6BA8370D
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 05:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDC244218C
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 03:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EEE1EEA5C;
	Thu, 10 Apr 2025 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNV8swzs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C881EE010;
	Thu, 10 Apr 2025 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744254596; cv=none; b=kng+pGu980afkci5h5K7UVK2XF5pBU/HExJjLgi0d/j/iMjyudnbL7i3OvgdsLNBgKFYfoDTpzP4he2/CPbpJkNsQl0TltoJPS/LiTG3KHL9UKN0PLLcIrZ3n6VxTy/3Jn0dMKNExEAaX8Tg+Tb7zTlDWlR837g4IcwvLhBaWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744254596; c=relaxed/simple;
	bh=/LD/fAm9gZWJoP6cNnx9bPm68Q7vnuelNABMf3jJJTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IzvpXrNqp5nsnZpjvMzsFaez2g2yEPteCJCPpFQEd2iU3Sut56SYrQZD7X9ycxL4vTJ7VUxn+i6X9IHRbU/TkHp863ecV6Y801mvcDe04fXOAOjIbOkEZTtpGRo1vEaYGEaFPVDwwOQvVSAb6W35ByFT4Op6phbQdyLsOU7tXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNV8swzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC06C4CEE2;
	Thu, 10 Apr 2025 03:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744254596;
	bh=/LD/fAm9gZWJoP6cNnx9bPm68Q7vnuelNABMf3jJJTc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lNV8swzsXGByNGHtW/xduXYX1oAnfuuJvlcj9ZLcbDojQGK8fDKHHYKD45MI2L2Ma
	 MP2+TvLWtD2KoOt5Myg9LpGXFbvQGvBkxaZLXhPpIaHnRZxzCTIWx4X8T9mEoEUvNT
	 wSRrPDQPaWciNvJpUqHWLRPpaYI5gWNjX4JS+S2C56TjvYaAdDrpLysarI5tcfDPPL
	 dscdDGW8MputrUYCcH7T0UBaAXWlBZfvv4nM+wYTv0dAfBHZDuGQ1HEbimsBsZfJdH
	 mOyhjuvC72aLyGMT+Xlgis2ASVgtb3R0PmSZLAIwLeESLY7Gd6nD8VIvQFflRtmnB8
	 PLEiKjjLH2oTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0D2380CEF9;
	Thu, 10 Apr 2025 03:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] support SKF_NET_OFF and SKF_LL_OFF on skb frags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174425463347.3131897.8400985882476107728.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 03:10:33 +0000
References: <20250408132833.195491-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250408132833.195491-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 willemb@google.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  8 Apr 2025 09:27:47 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Address a longstanding issue that may lead to missed packets
> depending on system configuration.
> 
> Ensure that reading from packet contents works regardless of skb
> geometry, also when using the special SKF_.. negative offsets to
> offset from L2 or L3 header.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags
    https://git.kernel.org/bpf/bpf/c/d4bac0288a2b
  - [bpf,v3,2/2] selftests/net: test sk_filter support for SKF_NET_OFF on frags
    https://git.kernel.org/bpf/bpf/c/fcd7132cb1f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



