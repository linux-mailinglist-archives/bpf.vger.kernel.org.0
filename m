Return-Path: <bpf+bounces-42699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610B19A930A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 00:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129DB1F22C1C
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 22:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A981FDFA3;
	Mon, 21 Oct 2024 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/XZHNCm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBD1E3DCB;
	Mon, 21 Oct 2024 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548625; cv=none; b=ED+yf7S2rSKmI9sqO+V6+cSJ/Zci0uo1VZ+iOaIZDY5f99YOQOqmCiZv+3fshkJOj7Q7eCpxjEq7SwjTy2QFoPAiwXE1UYG2jz1I36hbjOqFqtGltQESiftZGrXcQalcGmZcm6kjiiPBg8eEUpHc42ThFdaHpdPQt1etzYjK3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548625; c=relaxed/simple;
	bh=l6+nktX9SquPbNwgF/3Y+CsbSqozxpluEefMFET35BI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ME7YHKCcGL5VO4xkIhvLbj8brLylIc0q/wXOmOWK7KbILXqriS/GxtoyY9ibtNi9C/f5q42Sbz57c6qWrtjzABwI4VnWQjZszF7s/WZtTGD+f/e87Keq/W0L/q9wwojTGA1UMvp7gTE9r5VvzUWG5t6pYnkJ2U62Cw9cE4bY7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/XZHNCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEBDC4CEC3;
	Mon, 21 Oct 2024 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729548624;
	bh=l6+nktX9SquPbNwgF/3Y+CsbSqozxpluEefMFET35BI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K/XZHNCmHQd6iiwNIPHguPZ/mxpOSqtcso+adBKo8YFjWaWlo4D11ocTLx9Bp9e84
	 ONrRnx0KF5/BemvsMsqpMWOgEGCZVoJabDJ1DTb6utyYLG3nXoSDlobx/ATTVdA9Wg
	 K7p/xUQulqcWE1fLGOrgcWldSFCaIfwRx3006xCQ5tQvjRDY2A9dTkdnxM1XkBszeg
	 xoOdED58bIwg9oDoYFj6Y6AEUx6iAvCFITjZwbxUzsq2zjxGbGHX+/v7wXh5HLgYQO
	 8LoGU11cV9pzGH0NGV0LJNZ+r1mXjNX1bFQ8ppie8q6xodWrL7en1mqS8Qu5H84jB7
	 e+I61LVy7buqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FED3809A8A;
	Mon, 21 Oct 2024 22:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/2] Implement mechanism to signal other threads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172954863101.459649.18336368288073439741.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 22:10:31 +0000
References: <20241016084136.10305-1-puranjay@kernel.org>
In-Reply-To: <20241016084136.10305-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, puranjay12@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 16 Oct 2024 08:41:34 +0000 you wrote:
> This set implements a kfunc called bpf_send_signal_task() that is similar
> to sigqueue() as it can send a signal along with a cookie to a thread or
> thread group.
> 
> The send_signal selftest has been updated to also test this new kfunc under
> all contexts.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/2] bpf: implement bpf_send_signal_task() kfunc
    https://git.kernel.org/bpf/bpf-next/c/6280cf718db0
  - [bpf-next,v5,2/2] selftests/bpf: Augment send_signal test with remote signaling
    https://git.kernel.org/bpf/bpf-next/c/0e14189459f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



