Return-Path: <bpf+bounces-20962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8210B845A6E
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 15:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E7C1F2AB61
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E05F47C;
	Thu,  1 Feb 2024 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NroHgZ7V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD05D460;
	Thu,  1 Feb 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798424; cv=none; b=p2H6yn5rAgVR9CRgwNi1iUwQ4tQKNE60rE+vl4FUlsVKiMzg9dOa4yr4o/ql2HQJa+Rd9heSCNcIX4eYGpD8zh1/eO0sGXZjrKV2oWUR24qjfPMtkdYzuuBTillrIOs5x45vJoDe9iearT89/JyOPx788RYc58fL8D63XVwflV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798424; c=relaxed/simple;
	bh=Yj8fLCzVxrKlfUwZ9PYZO5IpEUjwcbIyb99aJcaucxw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hHxe3Ob9XYfW9mDe/qpwN5gfYQEmbLCubpMKUc7Kxk1b6VpunkxoolNk/3T1ozjWR7wUb/tXsTpx2ISg9E4cG9BaHZUTrSZjbuHCQTIeuLFpi/HVBLPfsGDZEo0sfyYBHB7S+szRgCmGMex5mmADM44RS1tcb8AJ4fnS1tAQJLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NroHgZ7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E8A0C43394;
	Thu,  1 Feb 2024 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706798424;
	bh=Yj8fLCzVxrKlfUwZ9PYZO5IpEUjwcbIyb99aJcaucxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NroHgZ7Vd2K+OEDYl5LApLUPDFHrhoqu90KiR/NOeOsH8YWuoyDGsx+MSnBE9jynv
	 XsH2/oFo55g47OzEvb6DQqN0md+E1XzDCi5GpttpkFmE44EFg1FIGrPLg5FLsBhPdb
	 dhhvYZMjC4RtPlsaKHlYeGPGKE+YHNf9Sr2NpiCtbn7qUDKA3f6CUpJ5ReP1lOiDiH
	 lCuCrxxoGXJNEwuP/UFABN2VvzFqQe/IPQT3Kc8P3F4UvwYkA5TdTiKMyPsdgJK8CI
	 ABuhtMnsyequhdTNZSshOH098Q1pYsxK1aZnPUuRtCLsZx2dk2VD8Mu3dJX2KPCnsy
	 XXHvTGctUvJfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16102E3237E;
	Thu,  1 Feb 2024 14:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-pf: Remove xdp queues on program detach
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170679842408.23697.9243651845756419319.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 14:40:24 +0000
References: <20240130120610.16673-1-gakula@marvell.com>
In-Reply-To: <20240130120610.16673-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sgoutham@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jan 2024 17:36:10 +0530 you wrote:
> XDP queues are created/destroyed when a XDP program
> is attached/detached. In current driver xdp_queues are not
> getting destroyed on program exit due to incorrect xdp_queue
> and tot_tx_queue count values.
> 
> This patch fixes the issue by setting tot_tx_queue and xdp_queue
> count to correct values. It also fixes xdp.data_hard_start address.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Remove xdp queues on program detach
    https://git.kernel.org/netdev/net/c/04f647c8e456

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



