Return-Path: <bpf+bounces-60855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BD1ADDD3A
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 22:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78B4189FF5E
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE222EE976;
	Tue, 17 Jun 2025 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCo/2ZnG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F672ECE9E
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750192207; cv=none; b=gxGGZhpMMl28Ps2eHK+e+qoNav8MSPxlT2VvBjOHcTn8o+fPimIw2ygS0fgqeQVTOyJ2TTQ1UpbXQ+EaQiHl0x74Zulbv6oB/uSnPD6f+Ea9KDfBTHKAv2L3T0irzXxFfkAoXjx/gBrFmHfvZePHCk0GSNfc7nt9D6TJ/knhj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750192207; c=relaxed/simple;
	bh=mtCDOVymGT1vlKu9PoTeBEdlcrgzycsDV0+MYKdmSGw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A2ArpBBpzu9xwZK0Ers6rYvoCl+QyY+o8Drx+o1F3eyvr+XwsLUGOSWnErT9yutigj23cYTOpaQEYSYrQDDItqEl5oSfW0zPong7uERYL7ZApAo0wPXILlmw9ZAyJMqvr8qW+258N7Ff8SjDSSqyFK5wq8T8aXDfY10AVlpuuEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCo/2ZnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E147C4CEEE;
	Tue, 17 Jun 2025 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750192205;
	bh=mtCDOVymGT1vlKu9PoTeBEdlcrgzycsDV0+MYKdmSGw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hCo/2ZnGDdC3JSpdO7wWFTaBfHGvJ5cXENCBqVNwSFLx/2SPPUrx4BoeJlIBdBf9k
	 6N09TizmrGQeTWsi10gYtOEFIINUeldrj9w5USPVZNGmD9SBDxBPxzcADWoZBqMeQI
	 ceg7Vv82kaoKCB+S7mA9vOTuKKiFSoi4lCQ8Q0z0JQHxf4KY3kUtOJ1BWIW85FaaKx
	 i7B+lHqpYsO3PnGaI93DmEeKULy11fXESSf4guhnS8ZkNd3xL4uL2HkQNweef9xsZ8
	 5B0ESsR2EB4ttta6IGxJJN5mwJXRZn1s2psc02tPVPvcJavHFSs9S4KOzv7rKi2MrH
	 YRtI9ox6iOuEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DDA38111DD;
	Tue, 17 Jun 2025 20:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/1] selftests/bpf: more precise
 cpu_mitigations
 state detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175019223374.3686091.10779806899057253382.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 20:30:33 +0000
References: <20250617005710.1066165-1-eddyz87@gmail.com>
In-Reply-To: <20250617005710.1066165-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, laoar.shao@gmail.com, mykyta.yatsenko5@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 16 Jun 2025 17:57:09 -0700 you wrote:
> If kernel executing selftests is configured with spectre mitigations
> disabled, verification of unprivileged BPF won't emulate speculative
> branches.
> 
> A number of selftests relies on speculative branches being visited.
> In discussion [1] it was decided not to add additional tests
> classification, but to execute unprivileged tests only when
> mitigations are enabled.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/1] selftests/bpf: more precise cpu_mitigations state detection
    https://git.kernel.org/bpf/bpf-next/c/fc2915bb8bfc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



