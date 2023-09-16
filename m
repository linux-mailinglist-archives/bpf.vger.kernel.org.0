Return-Path: <bpf+bounces-10201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80877A3043
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 14:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEAC1C20BDF
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 12:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90CA13FE3;
	Sat, 16 Sep 2023 12:40:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CA013AC3;
	Sat, 16 Sep 2023 12:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DE7AC433C9;
	Sat, 16 Sep 2023 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694868025;
	bh=DS0CiDN0PcyhGgmTs8VuTLeTyqIdaNhkRE3CbjT46wM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cB21YVVVq47d36H2fNTmpMCkwEmACKVgM3aqrE86hU9GdheCahGsRQBJ1oFhLIsSp
	 DYQuI6BiBUVn4OEBry20BOCmwkgTm/vKA5YyrCryFVDaNvyewObD95T17NBhHB8xAk
	 HYuzm0x9LSAdcRrtvJN313+ymxRshWNsBFrhl9eb9P/9anXLhPKSESaTX7oSCqfs7z
	 s3Tr9ZYuRrgspbrj1SeUfMu99IgeuwddemJfYQ72C/lbpxUNlKkpfsmqaMEOxS7+jB
	 1bJvcC9bIdSPr3/8Cx+voOZ+QMCFY/szI4CPYHooam6WTPySLxKD/udM9QQiw/0Lnj
	 UMYBA6PVXXGtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09E7AE26881;
	Sat, 16 Sep 2023 12:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igc: Fix infinite initialization loop with early XDP
 redirect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169486802502.24089.4629058589745902790.git-patchwork-notify@kernel.org>
Date: Sat, 16 Sep 2023 12:40:25 +0000
References: <20230913180615.2116232-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230913180615.2116232-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, vinicius.gomes@intel.com,
 sasha.neftin@intel.com, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
 ferenc.fejes@ericsson.com, naamax.meir@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Sep 2023 11:06:15 -0700 you wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> When an XDP redirect happens before the link is ready, that
> transmission will not finish and will timeout, causing an adapter
> reset. If the redirects do not stop, the adapter will not stop
> resetting.
> 
> [...]

Here is the summary with links:
  - [net] igc: Fix infinite initialization loop with early XDP redirect
    https://git.kernel.org/netdev/net/c/cb47b1f679c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



