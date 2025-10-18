Return-Path: <bpf+bounces-71268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A43DBBEC332
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38B7E3548F0
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088297082D;
	Sat, 18 Oct 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le4CN7tm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797163C38;
	Sat, 18 Oct 2025 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760749230; cv=none; b=gonIjeCJ9W6bH/xe+4pSsAPWUYFCJggAmU+r/PMJnlOnZ7RrrKBiedW4k/iXBs+n4WTtvVQpKaovXv/OAenSuA4UaJSUR7MZNNn5CnoBv7H/XNVBDoDEyDA9XkvMCMiKarR9dlB0PWPpndOJVOuQaIyBT8Mwc0G9NQMpSkVTFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760749230; c=relaxed/simple;
	bh=Nxli6EbCMmDF/eXQaRvw6FrQifLvhVBDhZmL7Fm0QL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e6DHdIdC398QaNFQTL5cm9h7EZby+YOHdqejevHyLji86VspsA7Yfv9B4BDSQx75SZOH0ZjzLlfngQ7gw3CMJJFofgIr0w1DVAmy4e60bGlzNmzRCINY8bZcBP9fmEG/72pM7jbZ2pkPrzkYF/zdRV/rWWMO9lf0M0YQ+1S7REs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le4CN7tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39C3C4CEE7;
	Sat, 18 Oct 2025 01:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760749229;
	bh=Nxli6EbCMmDF/eXQaRvw6FrQifLvhVBDhZmL7Fm0QL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=le4CN7tmd+NWgHbejaYm2XSTPsONXUtdpYES1kyC/DYxYczs0aoaSNDM/R26gDvj2
	 xRCeaV9cbPKUeKtduwFiGHYq5pdBNTNnfz/xwto6dCVg/iR9s4MZcnfTQXn/mAQb3s
	 QEfzCwOn3MU1cRI/idelx3BF3+OM/D3XRj/47GRO8GdPlg1CQS8i456BNrLhmiAY4o
	 idH/j7VAKo+oFLXbSmIzpTEXP07w4ZERLCWh27zw8qieaxoHYGONXT1iZ0hpVO0P15
	 OIlqYRe5yHVJGTmATQgvDtMzUm9JdOlBizM54AgQWWruwFgOxLx5kv+UCwHYa57cVA
	 ANtxzegXiPZ2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAD39EFA60;
	Sat, 18 Oct 2025 01:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2025-10-16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176074921325.2843953.9798029355647006124.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 01:00:13 +0000
References: <20251016204539.773707-1-martin.lau@linux.dev>
In-Reply-To: <20251016204539.773707-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 13:45:39 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 6 non-merge commits during the last 1 day(s) which contain
> a total of 18 files changed, 577 insertions(+), 38 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2025-10-16
    https://git.kernel.org/netdev/net-next/c/e90576829ce4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



