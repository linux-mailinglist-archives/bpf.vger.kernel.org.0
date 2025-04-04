Return-Path: <bpf+bounces-55332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4469DA7BF3F
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 16:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ABAD7A3BF0
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 14:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A771F416C;
	Fri,  4 Apr 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQy8WR9i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F961F0E36;
	Fri,  4 Apr 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777009; cv=none; b=WNbSi6m84hBQebEEEpuU975f6GyS+FuztVqd3AEdi+UH+xmgq/Qijgittg9Azj8Viv1PjvQ4GaIS7auBdCZ4wkNUQI/FaU3JCk5YzOHvJs6tPq0Tya3Cp9UiCJFxyaO+bRuOPQ6xYX9iWJBO4hdzqWyUj+91K5M/6iBsompuK1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777009; c=relaxed/simple;
	bh=/RiolJ1HzX5yqvyukJJnFdUT+5hRJg+Fx5YJ51dj/rE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RV+Gx+gO4O1lfs+7+vyneAwYRCf+aS4i/Kv5NwxuSaNp6RtYxL+TNqV5MXsY+2hze16b5gfBGEpLe6b7jIXHe+ruvPYPEsEarq2go9bTMi3tVPpP/YMUZS0K6vCl3FqLbJtoVwoNIVkHurhxFp/l6gTTZIsqkDlsz/G1Ha5gthk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQy8WR9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8DDC4CEEA;
	Fri,  4 Apr 2025 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743777008;
	bh=/RiolJ1HzX5yqvyukJJnFdUT+5hRJg+Fx5YJ51dj/rE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jQy8WR9iJmgt7msrSm/+lj9mnefB+c15X8a6CKXzl9wCZrT49sE4LsfjFww7g+jvV
	 gy0p7irmWIwp3Uqu/b32fl6a/VdVN25ywbiUHbm69/ksESU5L1pAz7rIhEVc0vb+RO
	 Q/IZtBW5kEQ3hnMaikrdknkhSkpPBPLY4ahmXA7Jz27U9+3U5cD7kKd3jKre7Rnreg
	 oNuh7FimTkte4VkGe/8LjmvCkwEn4imfP4H90/14Pw/yb+gfaqL7Y4zPfs1PIqb74Y
	 Y0gzbkOGrXceVkn4oz8fiagQY5WXKfSiSqzsiFuIMojA4tchKZth0teXqeWZVyfzGD
	 S1YSbMlm8lNDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADDA3822D28;
	Fri,  4 Apr 2025 14:30:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: octeontx2: Handle XDP_ABORTED and XDP invalid as
 XDP_DROP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174377704546.3279917.13889466734313681619.git-patchwork-notify@kernel.org>
Date: Fri, 04 Apr 2025 14:30:45 +0000
References: <20250401-octeontx2-xdp-abort-fix-v1-1-f0587c35a0b9@kernel.org>
In-Reply-To: <20250401-octeontx2-xdp-abort-fix-v1-1-f0587c35a0b9@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sgoutham@cavium.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 01 Apr 2025 11:02:12 +0200 you wrote:
> In the current implementation octeontx2 manages XDP_ABORTED and XDP
> invalid as XDP_PASS forwarding the skb to the networking stack.
> Align the behaviour to other XDP drivers handling XDP_ABORTED and XDP
> invalid as XDP_DROP.
> Please note this patch has just compile tested.
> 
> Fixes: 06059a1a9a4a5 ("octeontx2-pf: Add XDP support to netdev PF")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: octeontx2: Handle XDP_ABORTED and XDP invalid as XDP_DROP
    https://git.kernel.org/netdev/net/c/2a8377720a0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



