Return-Path: <bpf+bounces-52832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B3A48DF9
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 02:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED64518913E6
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 01:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFCE16A956;
	Fri, 28 Feb 2025 01:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGJ6Qoe8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4AC1581EE;
	Fri, 28 Feb 2025 01:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706124; cv=none; b=NDZbOYoJHIj2dXD3M7prt+vOYnxF+i3SBHzRET5PMMET0tPrGfFEkaIxQBjWDuilwZYXlFL5OwYLNHXEi8d6VDCyBe1JExZnlEJKK4NvL1YLZ5wK3R7f1ygOFSPYv9V3LvPjTm+4ZkFjlEZHPLsL//gMFwzYi9NKkACZplS3hao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706124; c=relaxed/simple;
	bh=7pJPCn7nwA7Ty90W4Z9A19TH1z7cUE8uI8jDQ0KSPo4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oHindwS4ss8XO/r2o2mNVPrro9lj3EUpGtBuvbDZ0xE1KGeDySr4nziu5YAY9BJJ/UrnLQHrtLyCAxuA7kxpbKSsZxz6sgtLPnbslgGyCkuLYtZptih5Qg7ku0Z0f8OYmEyZgcC+z3N54rLZ5sng4OgDdQjik0bRHKynhLuXQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGJ6Qoe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2545FC4CEDD;
	Fri, 28 Feb 2025 01:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740706124;
	bh=7pJPCn7nwA7Ty90W4Z9A19TH1z7cUE8uI8jDQ0KSPo4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qGJ6Qoe8LjbaDinsQPm/zDiq6JjZ9523Pw38SDCe5q8tEZrvsEsNW/nfTi+pZhLNU
	 RqMQdsVRuul30Pyx+0QSdP85VB1YV0NJC0nIAsghOvYyMTBhk86M6RMg73shGFgSK0
	 U0VEItMlEtavo5gqLa98vjO8xLfzHUNLsFs4zoDX2FCJ3KVER/lB2sBpO7Bs+McdlW
	 /tbmxvxZxQsNkFS5/8uInaeUdIwf0R4+kqbRS9233MWPEZi1ZDDPMi1f62URyu2Hr1
	 onJmCH46Q2rvIzbvhtSjO3ZzoGG/+cj/9JdRQh9LbO+62PGuNKthH85NUNHGPECQHx
	 xFbuSVe0FRQ1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F1A380AACB;
	Fri, 28 Feb 2025 01:29:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netkit: Remove double invocation to clear ipvs property
 flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174070615598.1621364.6191181530656543285.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 01:29:15 +0000
References: <20250225212927.69271-1-daniel@iogearbox.net>
In-Reply-To: <20250225212927.69271-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 lulie@linux.alibaba.com, razor@blackwall.org, martin.lau@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Feb 2025 22:29:27 +0100 you wrote:
> With ipvs_reset() now done unconditionally in skb_scrub_packet()
> we would then call the former twice netkit_prep_forward(). Thus
> remove the now unnecessary explicit call.
> 
> Fixes: de2c211868b9 ("ipvs: Always clear ipvs_property flag in skb_scrub_packet()")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Philo Lu <lulie@linux.alibaba.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] netkit: Remove double invocation to clear ipvs property flag
    https://git.kernel.org/netdev/net-next/c/047e059cf212

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



