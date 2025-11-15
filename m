Return-Path: <bpf+bounces-74606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2DC5FD07
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98F9435EB9A
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF181B4223;
	Sat, 15 Nov 2025 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gps4o2vR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA4A1A9F84
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763169038; cv=none; b=NuEvrWCrj3qPKXluT0y+vkZysOgr/rf3tFKxR7CiO5N4qzqWMxyWQpU94IsadbpKatp0iLCTkBMlg7GkcOLnNWqhJ9HC3aGJVBMsBEB2WdD8nsTr3Mq7QyT3FchFVtQKwgpgGHnIQTzxoJoe39XmCbVxmMVntpQ74FQXC0I8B1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763169038; c=relaxed/simple;
	bh=Q0QUUA6njgSTTIZ4DBnx+5VqoOIFfGMSjeEl/UxSYew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eLsAE7J35/NgsqONscjqHBM6VoJ6NYRSU6LzwD3hi4qylEE1yi+Rj2XzRA/VkpufrcwJtLkICmH+QfHnf7wTCDyLcXV8rQY36dF7WGFAJ7EuM70FBXNbMRxC55KjKgpbHasLFmln51l5x0zGee3AuN6rL3GcTAJc+UB8C2xaZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gps4o2vR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1935CC19422;
	Sat, 15 Nov 2025 01:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763169038;
	bh=Q0QUUA6njgSTTIZ4DBnx+5VqoOIFfGMSjeEl/UxSYew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gps4o2vRchgx5E7zQP0uVJKkpN+V60UYzpUG55fvTp6yPJ8X0QiK3bNAYYJRrCeje
	 efhZqYFc7ifyG4DxnSLQyRpLMen9m+LCk/l1JH3NLV0WJU+x8NW4Ro+0epryPX3Ebk
	 mT/Rq6KhdJK2eND9diJ4fUVwHLxxUIaNP0z7GHTggzLSwhh5NkD6QTk16/hr5HZcij
	 NNzltMLPsWwgZg8WkM0es50rUSoaa3asaeNrIKo1JywEwylbqoIudoUIjhZPuxKg4h
	 p4tC/VdLcRD2ahAqQfJSzbiwDpezwTs+xKKUaOmnuVelcums6+/XBazivOsS6SjCA6
	 vxnqMOXa9SrqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFDD3A78A61;
	Sat, 15 Nov 2025 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix failure paths in
 send_signal
 test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176316900652.1896293.2245514686647710621.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 01:10:06 +0000
References: <20251113171153.2583-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20251113171153.2583-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 13 Nov 2025 09:11:53 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> When test_send_signal_kern__open_and_load() fails parent closes the
> pipe which cases ASSERT_EQ(read(pipe_p2c...)) to fail, but child
> continues and enters infinite loop, while parent is stuck in wait(NULL).
> Other error paths have similar issue, so kill the child before waiting on it.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: Fix failure paths in send_signal test
    https://git.kernel.org/bpf/bpf-next/c/c13339039891

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



