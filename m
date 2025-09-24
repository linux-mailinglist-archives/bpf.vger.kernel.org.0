Return-Path: <bpf+bounces-69585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6F4B9B0EE
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 19:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B545019C2032
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E41314B89;
	Wed, 24 Sep 2025 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj/eIKrs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3AB17A5BE;
	Wed, 24 Sep 2025 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735023; cv=none; b=lHx4QnmP8apdD2u32u3krHBUbdwoJuStmd595PGsWby4MQnIUpup4grG/Hb8ZYR3ifE+l4D9gms3N2TG4K43rqf9W8xrSH2KWSusHrbuyTa1XE/g++4BJiknsoQ1SDbE0fOewmNqoT/sko+lz42xTa1OuwIDv8e4sPTR+nk+BaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735023; c=relaxed/simple;
	bh=HY6aYyX0NAqtzAtqM6P4uyLgcPmkBrTkG3DzJr/lFEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TIy1y8kl2Tp3OVKmCLtSOmGBgeupB3Lcv7i20AtCOAkv3xORdcHD4lv2opDCfeYuUylcVx5waK0ueo7SW+8r1M8xioUsEP6im0NFGfVrRMJIbm8yRTDWrBYUMoLmKv0yFLtc8nH9etMCMq43KQfirrPonD+kJh7LbzUHLnKpJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj/eIKrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE43C4CEE7;
	Wed, 24 Sep 2025 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758735023;
	bh=HY6aYyX0NAqtzAtqM6P4uyLgcPmkBrTkG3DzJr/lFEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qj/eIKrsC7AXnBx43A9hTPx7qy6+ZgFdtA2n7NnuVLgKogfT8wlxvwFn7wBsGLicE
	 52HblUkwHw80OIvCHmiPOkPcACOsGQxyVrsjyy1pRYMNT9/m5kB4gQJ7AAouPWw4cL
	 ulQHVOMBMAEPTANugEUM6kz/OFgp/YkAnWnJLWYbz71heFsiz3KMtIL16AvDuNjdTE
	 YV1OxU4hOwkbq/R+AXl+llM8kKUmLWDdx190q372McMfPppfZpdbOhUo0uGXXao3z1
	 CUL4aA1JpH1FneOHphQu4h5eg0nO5CVSGFx6wBCJDshw5fTyCteAOsoWC7l0Z6ttEj
	 uGbKrij1B3m/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE5A39D0C20;
	Wed, 24 Sep 2025 17:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2025-09-23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175873501975.2616331.7703288359479556344.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 17:30:19 +0000
References: <20250924050303.2466356-1-martin.lau@linux.dev>
In-Reply-To: <20250924050303.2466356-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Sep 2025 22:03:03 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 9 non-merge commits during the last 33 day(s) which contain
> a total of 10 files changed, 480 insertions(+), 53 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2025-09-23
    https://git.kernel.org/netdev/net-next/c/5e3fee34f626

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



