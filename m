Return-Path: <bpf+bounces-30693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4218E8D097C
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 19:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D1F1C21C2D
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 17:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480BC15EFA8;
	Mon, 27 May 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m452EQJj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE426AE7
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831629; cv=none; b=BYDrxpn8+CIGf+ujrG6bz/6HbVrLjdId1c5SoUk2Ih4jxhhyT3OuJybCqLx5hQhxsI5xheH77nqwplBkMd3u1UbT8Rde8uNNEAYzgZoS4RJeSe4L7tRyADmvvX6DC+erxRimeWgRxGtzLcOoTN04HS/mk5k7G5UFFWECP9pENSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831629; c=relaxed/simple;
	bh=w8k+EbrC/IoYe5lFJcQn6H8061FSPmi2dbOzPiYBN+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tFqaFEoYveuNov5eM/UgIap1BcQJv3Nyi/CSm87pxg5lgU1MyPOfTrGM1+EOo2WEXsh6RAWhXU3ARETYpL3mZoPA5Xa38kkP8CxaFoL+2B2eKkhe7zip0hCPxSN7auPY2gH0LsWq02rxUk5DqH8YidcnrTLchhw2ljfWYehTsi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m452EQJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59914C32789;
	Mon, 27 May 2024 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716831629;
	bh=w8k+EbrC/IoYe5lFJcQn6H8061FSPmi2dbOzPiYBN+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m452EQJjv0mrYiGSC1y3LQcaxUPavFg3XooBID7dZqSaX3nV3wYmWwaYdNIWNGMAm
	 L4wp2znEB//J6YTPFVEXcRtTZIJdK+ZQ83qggc1aTWd9znk+ArOpO3ve5q+W4impCy
	 jK2mEDEga+VYnEFJy3kfSuYgEGXtVU38BhHFEFoqaHGFgaRaAOtgo4MVuecrjSeYVy
	 w7XoVMhavgkR2g02moetyh8UQU9kLQ1bM7q4qZcQrAGxXanUrSdySInMGgpDyfPi2g
	 AJ3xPEwWD8s6/PRJfGg0a2vAQ7F1et+Z0RwXBSGN2Qn1D+D5O+1I/Wr4Q1NL0EM5Jj
	 wJpQsTwrcz0SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47D70D40196;
	Mon, 27 May 2024 17:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/3] Block deletes from sockmap for tracing programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171683162928.10914.15797940779296702902.git-patchwork-notify@kernel.org>
Date: Mon, 27 May 2024 17:40:29 +0000
References: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
In-Reply-To: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, hdanton@sina.com,
 penguin-kernel@i-love.sakura.ne.jp, kernel-team@cloudflare.com,
 syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 27 May 2024 13:20:06 +0200 you wrote:
> We have seen a few syzkaller reports of locking violations triggered by
> map_delete from sockmap/sockhash from an unexpected code path, for instance
> when irqs were disabled, or during a kfree inside a map_update.
> 
> The consensus is [1] to block map_delete op in the verifier for programs
> which are not allowed to update sockmap/sockhash already today, instead of
> trying to make sockmap deletes lock-safe in every possible context.
> 
> [...]

Here is the summary with links:
  - [bpf,1/3] bpf: Allow delete from sockmap/sockhash only if update is allowed
    https://git.kernel.org/bpf/bpf/c/98e948fb60d4
  - [bpf,2/3] Revert "bpf, sockmap: Prevent lock inversion deadlock in map delete elem"
    https://git.kernel.org/bpf/bpf/c/3b9ce0491a43
  - [bpf,3/3] selftests/bpf: Cover verifier checks for mutating sockmap/sockhash
    https://git.kernel.org/bpf/bpf/c/a63bf556160f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



