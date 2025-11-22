Return-Path: <bpf+bounces-75276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BE7C7C0C1
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A2074EC94D
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 00:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54911F09AD;
	Sat, 22 Nov 2025 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRpkRvJn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20530246BB9
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 00:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772826; cv=none; b=D4UXG5dgn7tZCHTnBFNh7xh9zPfoZeMPd07nkvimNZwjD/+hIaojB7yaHkvLAikVY+5fP9z6umXn+tTDukeWnq5Jo+rWhzC6PHkoOqVGAEECwjB3mkyJmTN7YnNmpmTOMY/nFtxY8mKaZbHscga0N7ykDD820mAxEmJrp9L8ouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772826; c=relaxed/simple;
	bh=5t9F7YnqOOizlRHkTwzjpcYr+T6L3YM+9vPmarwxGEw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mR/wyFDR1oGJVYZY0DFOLDmfw3CrP+9irc+7Q+oNpzbTBGBmGMFgDdd3eJ5eIF13f9EaRiBXA6ubcZu2P7BmyOqebIeXAFcO5JUXvqWAg0QLNmSaICuZGhTLgUcsG16a9DFlS8PC+iCVAKwRWE8MDZC+22oaxb5/bI3Vv9jDTT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRpkRvJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDF0C4CEF1;
	Sat, 22 Nov 2025 00:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763772825;
	bh=5t9F7YnqOOizlRHkTwzjpcYr+T6L3YM+9vPmarwxGEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DRpkRvJnCzF0fcMWcWn/ijQNqy/IbUwKmgWQ7BcTMvr8mO9xrkzD9dPAeLHw7CAQV
	 b9wKRidXYBHZCtK9BbE+dM8sU300NS8RCiZUNsHVFOI6uI5hYq16fbIUJcJIkjGGRT
	 7YfLVdP2Vdj78Gqpxl7GZWRIBwn4IdW+Xg2LN5MqbZ/WeIfGkxV/UJrQlMveA2IJSt
	 rztO5rqyEZ0BWuny6kiqIku5n6I6T0h0e3EjS+K0PHeg7Bdvn+OzzLCK0zf4h3Vp62
	 KRF50J/dHkQS5RW+m1SY9MMv4DPyoUGu1oTxUp1RdNDns9TwjSlMy11aJDby/K+VkY
	 /qCjGtZ2UCipw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C2B3A78AC8;
	Sat, 22 Nov 2025 00:53:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: improve reliability of
 test_perf_branches_no_hw()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176377279026.2637800.9325868192978852335.git-patchwork-notify@kernel.org>
Date: Sat, 22 Nov 2025 00:53:10 +0000
References: <20251119143540.2911424-1-mattbobrowski@google.com>
In-Reply-To: <20251119143540.2911424-1-mattbobrowski@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, dxu@dxuuu.xyz

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Nov 2025 14:35:40 +0000 you wrote:
> Currently, test_perf_branches_no_hw() relies on the busy loop within
> test_perf_branches_common() being slow enough to allow at least one
> perf event sample tick to occur before starting to tear down the
> backing perf event BPF program. With a relatively small fixed
> iteration count of 1,000,000, this is not guaranteed on modern fast
> CPUs, resulting in the test run to subsequently fail with the
> following:
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: improve reliability of test_perf_branches_no_hw()
    https://git.kernel.org/bpf/bpf-next/c/ae24fc8a16b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



