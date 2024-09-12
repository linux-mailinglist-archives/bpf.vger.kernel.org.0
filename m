Return-Path: <bpf+bounces-39722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3865E976B2C
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 15:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F133F282911
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 13:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0A41AD276;
	Thu, 12 Sep 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ix72SX3A"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53651A4E89;
	Thu, 12 Sep 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149033; cv=none; b=oIIejGeGWJEatQ4dHaV1Geqvp9JpjBH2uQtOIzUcGtumX664VbpDPiSudZEe/Skm5JQFSQSX1Hp8KZrN7k3hQJP2HIgNVfueknmALjM+giqAkxMvwdjQxDQmLkIcY/S5t8J2Wi46y8nzxh8G2wlXPNCKrmbV/skho8Vas4lKxzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149033; c=relaxed/simple;
	bh=GbVxCpbItfv5RKig6nCXjTfDmTD0G9RZJB5PwbQiktA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pnLroVX8mW5l/xkTHNIA3QD3cSFCUOF3GGS+ah7Z2e/wbK5bCGU+uVrmmei9MeK1NATKxu1sA86gjlSQSKRSYql/Zs2ni6vFLx8GcTa9Uz+WhCu7+Q/kKAYPZ7l/tlPMHJVZAVkQnrIKQuiw59YnbGq3Zlkk78EQQbouX+DS0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ix72SX3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BD8C4CEC4;
	Thu, 12 Sep 2024 13:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726149032;
	bh=GbVxCpbItfv5RKig6nCXjTfDmTD0G9RZJB5PwbQiktA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ix72SX3AzaymkHMoXyajEOhuBrwkBW93Eq1wXSk7jMZXfPs/2CeBFlReOKs5umg1S
	 ayMJCudXJHbKqu++liHqc9jj8P0DeeOYs7M1wIe4FOd2MMZ+5C4Z9QxIe3L7OPaMSS
	 tZPoySPAbh97PxqUPhZH+wzrygKqWmCK3w+Y/eivJx9wkSfOtGanCCd/jORyAdPzzW
	 Ine7EGJ8bbjuFsf5QoCvORGnFcogYqh/QDS6HFrS5ZHGXo5P/3/qK47uo6BVABYxAe
	 KiXCJfHGcS4v1WE2bQogsXMLAUu2cRVxxSPXmgpXLso6FY1bkMc1UqK6pek/IthsqO
	 53aAJp2CCplMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFD93822D1B;
	Thu, 12 Sep 2024 13:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: netfilter: move nf flowtable bpf initialization
 in nf_flow_table_module_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172614903350.1599668.9030316910275563985.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 13:50:33 +0000
References: <20240911-nf-flowtable-bpf-modprob-fix-v1-1-f9fc075aafc3@kernel.org>
In-Reply-To: <20240911-nf-flowtable-bpf-modprob-fix-v1-1-f9fc075aafc3@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, fw@strlen.de,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 11 Sep 2024 17:37:30 +0200 you wrote:
> Move nf flowtable bpf initialization in nf_flow_table module load
> routine since nf_flow_table_bpf is part of nf_flow_table module and not
> nf_flow_table_inet one. This patch allows to avoid the following kernel
> warning running the reproducer below:
> 
> $modprobe nf_flow_table_inet
> $rmmod nf_flow_table_inet
> $modprobe nf_flow_table_inet
> modprobe: ERROR: could not insert 'nf_flow_table_inet': Invalid argument
> 
> [...]

Here is the summary with links:
  - [net] net: netfilter: move nf flowtable bpf initialization in nf_flow_table_module_init()
    https://git.kernel.org/netdev/net/c/3e705251d998

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



