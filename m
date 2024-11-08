Return-Path: <bpf+bounces-44395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D8B9C26D1
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 21:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C2C1C24756
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C0F1DE898;
	Fri,  8 Nov 2024 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0T1yVa8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788D1233D85;
	Fri,  8 Nov 2024 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731099022; cv=none; b=JH8OkX5SD3enpSstO5tr9/1CPCiLGnBG83yCkU1HZbPjE/vzzQlQBBNslBWsxQcNUHesjQmne3LAqYDcbHiRS1ezt/gSJwhDr9l01boHMOX7o6csAmbZJUP3dBZj6QIau/b17KX61pzPeCSf6Q8Xk2NMFNcJcYGxtGVuVOkyLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731099022; c=relaxed/simple;
	bh=N2HetQiEisLONG3BiHwYSKNAMk1svMQwTKdkH1wK5d8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MPSKWHo91eLt5pIng/NsS0ztcdO3vMzzCy0hceBv94to2XWbj5ACV41HIyAOXRBTJaZ3/ucsqgGVKlxjS//6BUllB7dwGJVcIRSO3hkj/5Z2nKhJhTHHpOXa4L1CEH7ZQJPnVcZ7qwwEKjiwjAJjnEh7uSwsTXD6PkXf7szg6Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0T1yVa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06423C4CECD;
	Fri,  8 Nov 2024 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731099022;
	bh=N2HetQiEisLONG3BiHwYSKNAMk1svMQwTKdkH1wK5d8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N0T1yVa81r9sMGHt3Qs9FASSoZ4Gtd1yPA0UOqs64TqvS25jcAO1h3OfaLT6q/fPB
	 Fsv/TImRddBVZn1GozaeFZV0iJKTPvKNAmiAxcbCyHJY+lTJgt1S1qH/7gYZBYKfxG
	 TUlICVKwpJqMZo2J3vxiWcOz4zNtDHlAl6gQsZBSkUP1khJAkgacVMDY8hyG3P6wvG
	 qxCyyWOtuQTwtta+Dk3Gxrq3R5LVhhcKJvEYpe9JIFyIbuHNrLxLegHIc7/JXTSb2p
	 A3TkntvN0LFd3Ci/7RFRNvzGtHb5bZ5gCEqpLGGPJpihuAd0uSufthXFtANhSTmpFe
	 DrXqdHmWMzuHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE15C3809A80;
	Fri,  8 Nov 2024 20:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Fix mismatched RCU unlock flavour in bpf_out_neigh_v6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173109903053.2761247.7607713213065389742.git-patchwork-notify@kernel.org>
Date: Fri, 08 Nov 2024 20:50:30 +0000
References: <tencent_CFD3D1C3D68B45EA9F52D8EC76D2C4134306@qq.com>
In-Reply-To: <tencent_CFD3D1C3D68B45EA9F52D8EC76D2C4134306@qq.com>
To: Jiawei Ye <jiawei.ye@foxmail.com>
Cc: martin.lau@linux.dev, daniel@iogearbox.net, edumazet@google.com,
 kuba@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  8 Nov 2024 08:18:52 +0000 you wrote:
> In the bpf_out_neigh_v6 function, rcu_read_lock() is used to begin an RCU
> read-side critical section. However, when unlocking, one branch
> incorrectly uses a different RCU unlock flavour rcu_read_unlock_bh()
> instead of rcu_read_unlock(). This mismatch in RCU locking flavours can
> lead to unexpected behavior and potential concurrency issues.
> 
> This possible bug was identified using a static analysis tool developed
> by myself, specifically designed to detect RCU-related issues.
> 
> [...]

Here is the summary with links:
  - bpf: Fix mismatched RCU unlock flavour in bpf_out_neigh_v6
    https://git.kernel.org/bpf/bpf/c/fb86c42a2a5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



