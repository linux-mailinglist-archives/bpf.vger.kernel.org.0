Return-Path: <bpf+bounces-48219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB93A05086
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 03:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB148161470
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 02:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4861156C71;
	Wed,  8 Jan 2025 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAi9fcAI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1B33062;
	Wed,  8 Jan 2025 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302811; cv=none; b=ChQ/2jBqzHivHTo+P102/GSpUbobnXhMeWdgE7/l4vlMEAFtfvyRmH495eNpRPwiYT9/pVdS7OPuDaxv+HBZPz2ESA7beDh+4my6hvYkfLJNmAKoWY6AcbvRxRt3RvDB4anKNvaEgrQ2LBEAqiZuO6HFCv0U6Ez/1oCDzWrp63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302811; c=relaxed/simple;
	bh=7vWeblV0T5F2kfYW7uZrdVeFzQ+Kmqm96eCpuv2K+6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qoEm4UnaD0bfUaXIpiC1AwQXy6a0Q4KJMNrj7mYYQUd1uFQ84pSdLd92alz2btpUJyoXwkwMMgMHE0Gb4OF/zYGAFE+JYlupCVVpyCrTLefgu5DoeEkbhCiY3OgV/kvKsDxZDQGbjC3VxCTqDZkupfQMH+sh9OaOUyF1AvtgNHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAi9fcAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E93C4CED6;
	Wed,  8 Jan 2025 02:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736302810;
	bh=7vWeblV0T5F2kfYW7uZrdVeFzQ+Kmqm96eCpuv2K+6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vAi9fcAIj8OFT1mC2CrkkGSezYr7zDqYepgIX4c/zwcUQ60Yu82GOeqog89ud2ESP
	 fB1x3Bdvw8lmPZjPWu4l/f2Riq0gzg/V/FsjUStQeMl5KclLDXQdplIU5CS3p4Gg9/
	 AeGBA4aIZGLGoc5/Jh6LYj4ChI5L1Q/f8/T0kC2I+qsEO9cTPIAyMsAA9i07prmE37
	 TbKm35zJ4q0K5bS7aAjK31z0cpp9eAXkK1MyVn1UhfW+v6n7uhZjCeawsehVLkE9Ye
	 y3/vBpRnUjKUOX5RIZWz8LaW1+SFcKGLUx7ttgDcT49M5Fc3k+Lnl/oZ6mtCAo3pTy
	 jdP8rN48s8SNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D49380A97E;
	Wed,  8 Jan 2025 02:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: gve: use appropriate helper to set xdp_features
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173630283174.168808.2268909446714972042.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 02:20:31 +0000
References: <20250106180210.1861784-1-kuba@kernel.org>
In-Reply-To: <20250106180210.1861784-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, hawk@kernel.org, john.fastabend@gmail.com,
 willemb@google.com, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Jan 2025 10:02:10 -0800 you wrote:
> Commit f85949f98206 ("xdp: add xdp_set_features_flag utility routine")
> added routines to inform the core about XDP flag changes.
> GVE support was added around the same time and missed using them.
> 
> GVE only changes the flags on error recover or resume.
> Presumably the flags may change during resume if VM migrated.
> User would not get the notification and upper devices would
> not get a chance to recalculate their flags.
> 
> [...]

Here is the summary with links:
  - [net] eth: gve: use appropriate helper to set xdp_features
    https://git.kernel.org/netdev/net/c/db78475ba0d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



