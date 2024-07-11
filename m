Return-Path: <bpf+bounces-34526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBAC92E555
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A3C1F22AA7
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0BC15A4B3;
	Thu, 11 Jul 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiYzJANu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048715990C;
	Thu, 11 Jul 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695633; cv=none; b=Cgj4TG+ct2djKlfClDqGx92NxawTz1JgIMJwKx3BHIa1tAAGH1jvFTYQL9Daz2Cv8ZtPh6mkV5YiDEcybl8/ZNSpAQTXon7k6uW/xSf/5ZelcymDVUhPBwpebLQCbhkQzFdAyaRkVBoIyb9c0jl9PP1E1N332EyvQOjJr/mzT6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695633; c=relaxed/simple;
	bh=RlHTcxGd5rW8WE6M958jTC0e6O1Ik2Mwo+BJCnyqjUI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cfTuvDZQ/W3c0DiuHKtyBLqmnLRFFjL6aqYvfv+f29K7gfJn+JmYylsyOWqLgeFAGo7P98PwymUf2A91OLSaQ1x1CtOFwoUsEmnggUzjf3eRyQDLZAO/2aQ4fqVnmOVSZaUeP4W3MXBsOeenWbAeudsCOPrys8SmT/GfBw1UWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiYzJANu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95C54C4AF0D;
	Thu, 11 Jul 2024 11:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720695632;
	bh=RlHTcxGd5rW8WE6M958jTC0e6O1Ik2Mwo+BJCnyqjUI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eiYzJANuSV3Y+98k7XI4lH+zGQuZTcyFog9RpctDXoj8mOJ9F5qkQUkfU+5MVJdyD
	 DsfUF+XUrmgXOfBvarkWu08neXXGDRb2N1V1U7CEbyfeF7ZOMSbmpmGQ5tX9uymwQ2
	 I6uL4CtOFb/fKh8bxlkYFV1O7V0qFHIG8pdt1Sd2vIhrL6DWs8+atiq45TJYUxlbc5
	 K0lZTGiPljKXYbmBmqfhQFcizieEOjkGaIMeqnlTx/Y682AhTcDZ+r/tF/Whc3XK05
	 nl3EFg7By2TWNweG0DDQWqydLGWC6/laIhtuYbEhb9Zeb+0l0In6svu64e3SE4bPEf
	 43rsh296dqOew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C25ADAE95C;
	Thu, 11 Jul 2024 11:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2024-07-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172069563250.3305.13137128961553013824.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 11:00:32 +0000
References: <20240711084016.25757-1-daniel@iogearbox.net>
In-Reply-To: <20240711084016.25757-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 11 Jul 2024 10:40:16 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 4 non-merge commits during the last 2 day(s) which contain
> a total of 4 files changed, 262 insertions(+), 19 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2024-07-11
    https://git.kernel.org/netdev/net/c/a819ff0cf9fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



