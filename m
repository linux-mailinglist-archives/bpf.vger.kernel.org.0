Return-Path: <bpf+bounces-8545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53FC7880A8
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 09:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E657E1C20F51
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 07:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689991C13;
	Fri, 25 Aug 2023 07:10:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6717EA;
	Fri, 25 Aug 2023 07:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17063C433C7;
	Fri, 25 Aug 2023 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692947423;
	bh=ANcqmrfmUqry2M3Okymt6F6zYJogSeActNc5bmci11c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VxSozqKDqQK9k7D2etb0QxFAhqX8y4rOgRbHSw2jh/OCZEgOIfnqB9+5Ogyy1REoo
	 M3dYZa29Ke3B0WhrcJtGhR6KyNP5R6eGnM0+pjP8l45IbTDoUowcEBlXFGhZSmhgvl
	 EJ8WAYlzJOFteru8E9G4i4UtcMYMpCm31LR/jIKttuPEi7qY6G1Xp9X0oUyCHyS7s0
	 7acV9c0MrJ8wrC8SIULlkdtmGw5fg+vqKTQquEZtdY9jRDCJoodgmF3+aF2M+VWtcR
	 88yMiY6ehNBd5uUeZCEPOBuNUqhLWau6Kv/iFYKRb1QbKuugafgstBVEOp7rnjQBGu
	 Hy3cpZC7kW8eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0AD1E33083;
	Fri, 25 Aug 2023 07:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169294742298.19723.4676181056392087198.git-patchwork-notify@kernel.org>
Date: Fri, 25 Aug 2023 07:10:22 +0000
References: <20230823134102.1848881-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20230823134102.1848881-1-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, daniel@iogearbox.net, ast@kernel.org,
 john.fastabend@gmail.com, gnault@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, stable@vger.kernel.org, siwar.zitouni@6wind.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 23 Aug 2023 15:41:02 +0200 you wrote:
> The goal is to support a bpf_redirect() from an ethernet device (ingress)
> to a ppp device (egress).
> The l2 header is added automatically by the ppp driver, thus the ethernet
> header should be removed.
> 
> CC: stable@vger.kernel.org
> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
    https://git.kernel.org/netdev/net/c/a4f39c9f14a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



