Return-Path: <bpf+bounces-17412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77FC80CF50
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 16:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4DB1C212B3
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2F04AF7B;
	Mon, 11 Dec 2023 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjQ2WhGV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECCB4A9B4;
	Mon, 11 Dec 2023 15:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39412C433C8;
	Mon, 11 Dec 2023 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702308024;
	bh=wpf+bASBdSApYA5KHuCKBINYKnKCNqiT7s48jGBlCBI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tjQ2WhGVdCCxv8ZJZXgtiYXjr6oBC1qm+TzUX6y/lUmMoUAf88o2Vx2Wa6zfAETfr
	 joVXzKsu+U8C5JvJktnynCmESQ1nWy0oYq+79ed+V8NpcEv31ndk17Qtr1sHLwpsL5
	 zX1059GmVO5HAgQatB+qWh30wvbMgDLa3pbWNUE83YHFjZzRSup2vTV9R7DYLa0BIM
	 PiCs8Ppqx1ZcAhwePOkO8rhQIEMjOAvNLVqH0L/2SQgC04rvxTO9Vs4Oiuq9xCAWvT
	 NalgHdv0unjLkky/+XPnR/3DqWA2Lzvjs53q9i9e9Z2xgYTw08Lh3bwC99ORIG9MQy
	 zgy52CliGdPDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23D67C04E32;
	Mon, 11 Dec 2023 15:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] Allow data_meta size > 32
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170230802414.23251.1943018178265573871.git-patchwork-notify@kernel.org>
Date: Mon, 11 Dec 2023 15:20:24 +0000
References: <20231206205919.404415-1-larysa.zaremba@intel.com>
In-Reply-To: <20231206205919.404415-1-larysa.zaremba@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 edumazet@google.com, magnus.karlsson@gmail.com,
 willemdebruijn.kernel@gmail.com, linyunsheng@huawei.com,
 maciej.fijalkowski@intel.com, john.fastabend@gmail.com,
 aleksander.lobakin@intel.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed,  6 Dec 2023 21:59:17 +0100 you wrote:
> Currently, there is no reason for data_meta to be limited to 32 bytes.
> Loosen this limitation and make maximum meta size 252 (max value of u8,
> aligned to 4). Details in the second patch.
> 
> Also, modify the selftest, so test_xdp_context_error does not complain
> about the unexpected success.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] selftests/bpf: increase invalid metadata size
    https://git.kernel.org/bpf/bpf-next/c/15c79c6507c0
  - [bpf-next,v4,2/2] net, xdp: allow metadata > 32
    https://git.kernel.org/bpf/bpf-next/c/2ebe81c81435

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



