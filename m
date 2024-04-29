Return-Path: <bpf+bounces-28158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C8C8B63A5
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3F31F22F10
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC3815B56A;
	Mon, 29 Apr 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8Goz878"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C5C15B554;
	Mon, 29 Apr 2024 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422649; cv=none; b=qgN3Of1RPzBptQpQEoHBhE6vRvbl2J19yzw7qxp7mFT5UK/AwhjEIGe80DN6peNmTMOOFGeHMeAIwZRKK9qz2O/sRfUc7iJ2F/St9bqQVyxzG/LLWLvhzA51O8cZOhsQCX3CsxOS1J7cSYl/bTYfiwK952uqHf9TCG+tp1+5oNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422649; c=relaxed/simple;
	bh=kag104BP11vfVYxbgiRV05RB8WPzpUDEhpjQDbS2CaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NhQfdYQw7VptORbe+kU2mlaOzZGQRE0AWkD13jfbAhnypDnIzIZPcaQRq4qevMjrmD416Zy66GwWuoAXi5LytBwEmB0idnYN/lSUQQqC9Wc38ofmnmyJEbZANCZb8lDrxZc6PTptzati10o61lW05+3Jlb/4upC5m2z5Gr9q/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8Goz878; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEF9AC4AF14;
	Mon, 29 Apr 2024 20:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714422648;
	bh=kag104BP11vfVYxbgiRV05RB8WPzpUDEhpjQDbS2CaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r8Goz8785wSU/K+Iq6uZ7fOMRBz8y+Ivc9zzC/HfDA3scHV4n/lvFttsL0zJANgnF
	 rqYwiXghJmJSOyzr7fJfLDRVm80ahQhF7UEGnR5qWSG7SClf3rvVRyagjFa0Kq4OqT
	 UhUngpU6niOln+kWOfPLdGiplT3TemEJSMcUWtpJqWqu5VPwv3quZD0WYOH04zdzCd
	 fNNZy6h6OdUgEr9XyMPbOd4k2M+afMX3VSkO25eaiwK3CioLxE/P1KPtVKTWE5B5Yd
	 tC519/T2Nrp34BEx38wLDo6lp7cQUbtTFPcdTxqbGhomtYoHfO/LwXC5J/JDc7V0wu
	 rvKo9KWLPuzYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADA6DE2D48A;
	Mon, 29 Apr 2024 20:30:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-04-29
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171442264870.31719.17752032590444348089.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 20:30:48 +0000
References: <20240429131657.19423-1-daniel@iogearbox.net>
In-Reply-To: <20240429131657.19423-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Apr 2024 15:16:57 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 147 non-merge commits during the last 32 day(s) which contain
> a total of 158 files changed, 9400 insertions(+), 2213 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-04-29
    https://git.kernel.org/netdev/net-next/c/89de2db19317

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



