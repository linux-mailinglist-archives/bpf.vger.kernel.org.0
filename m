Return-Path: <bpf+bounces-54910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B071AA75D4D
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 01:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D077A367A
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 23:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0BC1B422A;
	Sun, 30 Mar 2025 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJBk8GE2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35A20E6;
	Sun, 30 Mar 2025 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743376798; cv=none; b=urUVUObh/cw4bHu88tawgNwvoAjFXEjsLodhbi12AZRv1jldwRwv8e6+bVYTOnvoETYExt5iyR+sah8jDiHmJKFU79kjtsoqZoakTLn9KE/nKzGXoN++OldjYoNHrwmmy7v9IXThu1mWOujBH/hZImIaWstU/3aXvE8xbqT2/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743376798; c=relaxed/simple;
	bh=BtYLq95+loFF2wAwBtrJXi2RCQy7Vj59Jd2Eh1mWJJo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sWgJOebqxR1wKdCwsOdcao27lno9NfSEBLItTslEueNi2QysYjvmzW2PFIHqIvK0RaB2ywg2bRTU1tf0O0ZPSNyA8L9WuMXkx+ujC68q7DQ+DgoUotJkkislEDsvYu4VyloGXb078aw6+sTv2zrWg3bY/eN/ofYiP/567OZmt8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJBk8GE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1842C4CEDD;
	Sun, 30 Mar 2025 23:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743376797;
	bh=BtYLq95+loFF2wAwBtrJXi2RCQy7Vj59Jd2Eh1mWJJo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KJBk8GE2+/BXwguvXiwN/v8lYfT2ywtP7S+D/rOy4oW4YmwqhwtwfoMPPqwbMeOHR
	 +3rhdec6+raiJLjO+jiLE+oI9YhtTRVF7XCDjMFVwnFP+XNQnlEN80l3hzklr3n1VY
	 ieLFExOUrQ0iZj6alEq+i4er5a2f+Xv2CSsq9m8Moey4HZUBxUn6b85oEhzOixm23B
	 WCLLsN17tNS0wqdYCcgnEbDSZZYETPsw/hqAV3woEYpkROhTircZ2gS4J8vhI1P/HN
	 U65j1smzvkah3I8P1jzJpVLhDk04l6/WuwmgbSv8Zd34fjUL4CHqdpW9hMlKUJJlJY
	 gi5KfHWumfPfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E26380AA7A;
	Sun, 30 Mar 2025 23:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix tests after change in struct file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174337683428.3617599.346257026297188434.git-patchwork-notify@kernel.org>
Date: Sun, 30 Mar 2025 23:20:34 +0000
References: <20250327185528.1740787-1-song@kernel.org>
In-Reply-To: <20250327185528.1740787-1-song@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, kernel-team@meta.com,
 kuba@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 27 Mar 2025 11:55:28 -0700 you wrote:
> Change in struct file [1] moves f_ref to the 3rd cache line. This makes
> deferencing file pointer as a 8-byte variable invalid, because
> btf_struct_walk() will walk into f_lock, which is 4-byte long.
> 
> Fix the selftests to deference the file pointer as a 4-byte variable.
> 
> [1] commit e249056c91a2 ("fs: place f_ref to 3rd cache line in struct
>                           file to resolve false sharing")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix tests after change in struct file
    https://git.kernel.org/bpf/bpf/c/bd06a13f44e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



