Return-Path: <bpf+bounces-6479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04C476A31E
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 23:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10261C20D1C
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 21:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F3B1E52F;
	Mon, 31 Jul 2023 21:40:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129B1E50B;
	Mon, 31 Jul 2023 21:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71CC6C433CC;
	Mon, 31 Jul 2023 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690839621;
	bh=kt5xjvwpq3sc0kobAAU7Du6fClhn8IZqhVSwmf8tcY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ki9RbAQAOWeQn9+qOt2JxoXvCj/l0zMd+OM+T7FW98v29dlBalWx0FPMtkFKyYOVb
	 XsVec6irJ75v6s/emCKyKjod6vWt8OZHi2O6vwMPglNrJGgi+I2ebM4inKOpT0PLoe
	 jsljutQ/cbyuXhTuOSkAZVnsIk2YcNwbJNG18b1K4P24BwZRQu+kMLCUKhTo3jhEtU
	 Ftue/WG5ACbShTjbJx1rHDUOEQ7tNdLdp1yDhm0gtizI65YsT/3Zdkbg/0hzyZQQ3R
	 2qjtnGJRqU6p4B5vw8uSK/Ki7VxKt1PoTP+e7ggfSk7UF/nwTsL6yRt1sFKzGDAUlm
	 afuakEeU8a1tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CDDEE96AC0;
	Mon, 31 Jul 2023 21:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169083962137.7301.4040424865826797881.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:40:21 +0000
References: <20230729122644.10648-1-yuehaibing@huawei.com>
In-Reply-To: <20230729122644.10648-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Jul 2023 20:26:44 +0800 you wrote:
> commit 8a59f9d1e3d4 ("sock: Introduce sk->sk_prot->psock_update_sk_prot()")
> left behind tcp_bpf_get_proto() declaration. And tcp_v4_tw_remember_stamp()
> function is remove in ccb7c410ddc0 ("timewait_sock: Create and use getpeer op.").
> Since commit 686989700cab ("tcp: simplify tcp_mark_skb_lost")
> tcp_skb_mark_lost_uncond_verify() declaration is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/68223f96997e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



