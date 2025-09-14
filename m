Return-Path: <bpf+bounces-68344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE31EB56BF5
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 22:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E247A3C3D
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CE02E762E;
	Sun, 14 Sep 2025 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKNm594o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F62E62AD;
	Sun, 14 Sep 2025 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757880004; cv=none; b=uD/+lHqmbowq6jJq1K7wgq1WcnqHtdBlm2DLzaJSKbQkAbfJVsXB1dD8YPf72ffotIss18ktqfHdil1yRbtVRWRYIOP1RFghsDaTmMsZHn8FBHSu/QyUl/pj5u0/Zja+pzC3/VjM0pbDyLV9x/ZV8xJBGCDeO+CgJdGXp/p34Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757880004; c=relaxed/simple;
	bh=jvancRTO2b0olSjlSygRtEpWEd+u5L/gAsJ52RarkWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jMHDefzKOFQ4capLixDNae0bZLw0fCti545hDWFH6PjzDfPsR9mDOzQPBrsAMVDolbj+p5iRPq+Wc2sFADmDDzgUFdnouIXCizeai5KRtsBvOUGxoF2Hwc9lAIyeGokF9gvUqvh//b7JBq+Rf4NXw6is+xd8KkK2FJ+bBrPKeCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKNm594o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48115C4CEF0;
	Sun, 14 Sep 2025 20:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757880004;
	bh=jvancRTO2b0olSjlSygRtEpWEd+u5L/gAsJ52RarkWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dKNm594ozgR7Shew5WKmxksSV14TKMGUWEkMNiQ/hrBN5O2nHswDitu79B51GR5QN
	 NtFOz4Dpo84BjxTebApMaEjRhWJtKoRAOjO3TbItQ7dMHVIvpwuLOR3VE4yo53oa4H
	 xdDb7lQ4ZrI/wtK9PK4Jg7hYnj6Sc/3+RmeBcUEqDtxOeFUnzRYcXYE4G41ssUbtTf
	 XEYsyFFXXUUpRvHrKtFdeEBT3JukS9WN6zVDNzv8UzHfB/m4nr66U1/Jp1V/eH06Ad
	 rR3RXXzwLFztC8ESUMkN6pJ3HmQP6ENHxhHRt/At7zucah4sJ5F+dRuPG4kDE44+Ua
	 7ctH9eVVNsRHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DAE39B167D;
	Sun, 14 Sep 2025 20:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/tcp: Fix a NULL pointer dereference when using
 TCP-AO
 with TCP_REPAIR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175788000601.3538646.5304764225947950700.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 20:00:06 +0000
References: <20250911230743.2551-3-anderson@allelesecurity.com>
In-Reply-To: <20250911230743.2551-3-anderson@allelesecurity.com>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, 0x7f454c46@gmail.com, noureddine@arista.com,
 fruggeri@arista.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Sep 2025 20:07:44 -0300 you wrote:
> A NULL pointer dereference can occur in tcp_ao_finish_connect() during a
> connect() system call on a socket with a TCP-AO key added and TCP_REPAIR
> enabled.
> 
> The function is called with skb being NULL and attempts to dereference it
> on tcp_hdr(skb)->seq without a prior skb validation.
> 
> [...]

Here is the summary with links:
  - [v3] net/tcp: Fix a NULL pointer dereference when using TCP-AO with TCP_REPAIR
    https://git.kernel.org/netdev/net/c/2e7bba08923e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



