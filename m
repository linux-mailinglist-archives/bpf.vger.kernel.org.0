Return-Path: <bpf+bounces-6742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ACF76D7A1
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A67B2814EE
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 19:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8660111A8;
	Wed,  2 Aug 2023 19:20:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491A10788;
	Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 228CEC433C7;
	Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691004023;
	bh=ibDuWDILDL/H7Cv0r23d9AHZfI9316sTspBQGcktu9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q4DrwnxdMea4qZm7uKwawVUMxHFF2q9ZikUHb0gmhhr1UJ+wPmdNBoklRm3AWCoJn
	 BiuanfOoSJcXjJlLWEcqMq7DcFmej2aq+zkL08ocpEw90Pu3yB5R+2yLP8WWqlDNDD
	 pOH7te8p8qmrZi50R8gUI7ycFrL7vEa3nEXcgI4RxpNYPe/cdZhov2dbgOwXiNMsYD
	 3Tv7ErJLBMjdtDdY8kASPNPBwkDjZZPwcqndWL2VNqwHWVyo/rUnwC9FtH3iMPjHOt
	 ChEKRE5hTv5jMpEQgCnGJvqSHs2vVRjdcF78exPhSWSTeE6JnktRSO3rqYIL6kLAtg
	 5V8irqsLHdooA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 067EAE96ABD;
	Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp: Remove unused function declaration
 udp_bpf_get_proto()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169100402302.28133.3444239799830952876.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 19:20:23 +0000
References: <20230801133902.3660-1-yuehaibing@huawei.com>
In-Reply-To: <20230801133902.3660-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Aug 2023 21:39:02 +0800 you wrote:
> commit 8a59f9d1e3d4 ("sock: Introduce sk->sk_prot->psock_update_sk_prot()")
> left behind this.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/udp.h | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] udp: Remove unused function declaration udp_bpf_get_proto()
    https://git.kernel.org/netdev/net-next/c/9e63a99c566f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



