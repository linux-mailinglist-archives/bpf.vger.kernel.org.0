Return-Path: <bpf+bounces-32189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B572E908EC5
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 17:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B382C1C2104B
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AC315FA95;
	Fri, 14 Jun 2024 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYzqraBA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5AF9D9;
	Fri, 14 Jun 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379031; cv=none; b=Hu2zzPQAq0w3iohzJiwXNthk31TLRHNlV7qBvdZsrm5lmwOszNjgWg0XwAU8fSgcrAhti1IdCpO0jfvX12jpiqVDbo4w4t5JffxaHzZOVxoc/86uINqxj6tw9sT9t2SnCXhz5tJqkVIAObwDvF7Og7O/9VqZ3m8yvWC3R+wXWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379031; c=relaxed/simple;
	bh=pCfMTOS37syFgYU+24EBPb0CfjmBN9EKatbKg1iniSY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dYpk1iuuDWDMURedS6vhz7FXfDpUe01Ovi5pvDjrMTYiKHLPiHrtNH6CbQjbVooeFYp43Y4PyN0AUjvYOMg9NgLBrQ8wfFKY9n6JuNNRQRY0UAeLWfioo8Jyow1LHKEfxrMEgMKZ3tqdzE4tAHJFpybdcx0dzNxTiZ8alx87EWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYzqraBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1C83C32786;
	Fri, 14 Jun 2024 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718379030;
	bh=pCfMTOS37syFgYU+24EBPb0CfjmBN9EKatbKg1iniSY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dYzqraBAlNGIC79y5D0HmeMW1gnqnUvDuQsgdVpQ2hL3mHl10yegCEMb8LBKa0R8o
	 3QYw95Q5BM1O1q70n+lt5LXb7JlgUAAvYPwrtoAmw7NTNyFtux6apevYt2TG06LIVZ
	 oukyPxe/hPW37UCu4JgQ4u4g+h4kvbyRRjNplZIzuveIwDH3DYGR30aSAdTpjxfkAJ
	 ldeaABb3UOfUMHTRBxgzxqBx4DzxtrSKa5aW0ZWjg1VJNmHOohhL0g4rotz1cWYByY
	 ULRw38JTAC6NHZwYrIRPXyrZQvey4ufMm3DlKErc4muWyiW99e1i2XJxYwKGVqYAhh
	 V0DZQ3HhfJdCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93B12C43612;
	Fri, 14 Jun 2024 15:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: avoid splat in pskb_pull_reason
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171837903059.8969.17261138323063584002.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 15:30:30 +0000
References: <20240614101801.9496-1-fw@strlen.de>
In-Reply-To: <20240614101801.9496-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
 netdev@vger.kernel.org,
 syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com, edumazet@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 14 Jun 2024 12:17:33 +0200 you wrote:
> syzkaller builds (CONFIG_DEBUG_NET=y) frequently trigger a debug
> hint in pskb_may_pull.
> 
> We'd like to retain this debug check because it might hint at integer
> overflows and other issues (kernel code should pull headers, not huge
> value).
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: avoid splat in pskb_pull_reason
    https://git.kernel.org/bpf/bpf/c/2bbe3e5a2f4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



