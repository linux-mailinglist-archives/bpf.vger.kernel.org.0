Return-Path: <bpf+bounces-8441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8507B786568
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 04:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DDF28144D
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 02:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D15669;
	Thu, 24 Aug 2023 02:30:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B9A941;
	Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 234E8C433C9;
	Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692844224;
	bh=j9Kq4dl/5gc0BMf02DLNfYW3rJC8KZrnvYrZOv6vb8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NfbCXITbNg19Kl/LbJM+qPkLVoZHd6EC12JJWuh7UUBkWGJA1Jtt9ErjNLjb0KnaS
	 zd+IP2O6+tfpbfe1oAjZ8G81YC3crF+Qu1921jTb5W71xzlEgfB+YF5UkyGRrU/aP1
	 bdVNimPoOcs+m+RXe6osstFoR7v6RQ25k7dGkBwRDvNxGTxvzNpI7Uaml4aSFJl4aQ
	 LQOkFQWs8nNr/hynpK9pBQCg7RRTH4vy5d0zpgLilGV26jC5+0Tqx9hwHg3Gmuk2rb
	 fDxcOPdI0v9XI3h1gB9kP1d3idqytVnNi8p6VDVhc8Hs6/PYtwQNNf3FxLb42QPBRd
	 kUSRuK1oXlqdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05F92E330A0;
	Thu, 24 Aug 2023 02:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fec: add exception tracing for XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169284422401.2546.2123988345748875298.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 02:30:24 +0000
References: <20230822065255.606739-1-wei.fang@nxp.com>
In-Reply-To: <20230822065255.606739-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-imx@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Aug 2023 14:52:55 +0800 you wrote:
> As we already added the exception tracing for XDP_TX, I think it is
> necessary to add the exception tracing for other XDP actions, such
> as XDP_REDIRECT, XDP_ABORTED and unknown error actions.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: fec: add exception tracing for XDP
    https://git.kernel.org/netdev/net-next/c/e83fabb797b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



