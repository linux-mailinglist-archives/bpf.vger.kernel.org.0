Return-Path: <bpf+bounces-23262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392BD86F3BC
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 06:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF131C214B8
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 05:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A3A79E1;
	Sun,  3 Mar 2024 05:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/IYm6iJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE276FD0;
	Sun,  3 Mar 2024 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709443841; cv=none; b=dmMBMfqziiSlnmhxmNA+n/9cDI+fZVegOgkFegZxCDOEiKcVuxdKUTaRbWsvW6urDuT5gUIySW+NmjcJGrUoZ0Onqlm7A4UgYKcuqS2Lqir9qr3zOZONvPyLtF36B+C2LBEU5BqI9ixZu3LsbP275hoTfwZLdraYJ2G0dBrQkk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709443841; c=relaxed/simple;
	bh=00Q7Kzu5atxiBG6Za4Wq/Rml8/sI+Zq8FeRJiLHevVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q3oqzukaOBx3qp/M9oQhZaSC51wg1jF3T/FFiM13RE6pzsNOuG3TjZcLhQOPthQi/KJy5KNtTvIPWFAkE0h0YLTB5UrFSeP94zXVRofEswNdLsB1s6YZGBpSOcivUw7y09vgauQ3HVapTKTZYw5dOtLsyw2KXZO7czoBpICwtWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/IYm6iJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AB2FC43390;
	Sun,  3 Mar 2024 05:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709443841;
	bh=00Q7Kzu5atxiBG6Za4Wq/Rml8/sI+Zq8FeRJiLHevVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J/IYm6iJtyoOy47emxGb8xVKMFNNAs0csvrDM0MQKsBG1u2ABZ1nwx58E/vA6FXL3
	 4vUD+6JOJHhhmf7eEv7wvPKn/b7/H1QB5luEtXSuVCHzVGz/4YJIJrYxWJ0MRtUOZv
	 6c4/YcVVEXpXx34+bQWqTqxJ3O+DbEboo7kN7T+Q+DQV7rkrvTvGyVJWtMOKpm56fb
	 J42y1do4LCdiJ6MPhbrCPEBDj1C8t/wxEfrhno1oFzTMuatV862o2KvtgrOa2j7oqC
	 HYnLHQujvRdVpn5mOpSaplHqnX7Q3Xl0f1ZmDpST+jXN7LwWYjNyR7MmFAXIpkl9Hu
	 T4DIG0/vWE4KA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21347D8C9A2;
	Sun,  3 Mar 2024 05:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-02-29
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170944384113.12792.13367807354811123419.git-patchwork-notify@kernel.org>
Date: Sun, 03 Mar 2024 05:30:41 +0000
References: <20240301001625.8800-1-daniel@iogearbox.net>
In-Reply-To: <20240301001625.8800-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Mar 2024 01:16:25 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 119 non-merge commits during the last 32 day(s) which contain
> a total of 150 files changed, 3589 insertions(+), 995 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-02-29
    https://git.kernel.org/netdev/net-next/c/4b2765ae410a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



