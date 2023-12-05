Return-Path: <bpf+bounces-16729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BE680552D
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 13:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BA31C20CD5
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 12:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DEE4E1C7;
	Tue,  5 Dec 2023 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4SvzZfU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D433D3BC;
	Tue,  5 Dec 2023 12:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1636EC433C7;
	Tue,  5 Dec 2023 12:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701780624;
	bh=c3K5tJw47+N/W1nF4uxZF7+ilrykgTTkPU8dcFu2UbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f4SvzZfULqqut3U6Jxms3i7pKTKrOt88dpqXigdH2cFkQ+S1e5KvSWxLOVHtu5IQy
	 JT4qSqDpvcjT7oRc7HI2T/lvuaM234v0WIJzys1ryGpTVHAOiulV6EP/A3rNXBZExv
	 s53hGnsVOUn37Qmk4MPoeobMtba3sDmaBUKweqZSFowMjt0Vv1dqAT7cEPaBQvJvIt
	 VHImXnOur9e/nmsh0LhDiRY2lmm47/NBrjNMoy/aQKcv+cfBV2MRRBXxFMRbmxhgz2
	 jim19dFINaI8eFR3kKAMIJ8DUA22zDkS7lEmH2WKbIH/ZK8gZkv5ohCHuu4ripKSfP
	 IT2xJVXDelGYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE122C43170;
	Tue,  5 Dec 2023 12:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] xsk: skip polling event check for unbound socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170178062397.423.16825004727771471084.git-patchwork-notify@kernel.org>
Date: Tue, 05 Dec 2023 12:50:23 +0000
References: <20231201061048.GA1510@libra05>
In-Reply-To: <20231201061048.GA1510@libra05>
To: Yewon Choi <woni9911@gmail.com>
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, threeearcat@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 1 Dec 2023 15:10:52 +0900 you wrote:
> In xsk_poll(), checking available events and setting mask bits should
> be executed only when a socket has been bound. Setting mask bits for
> unbound socket is meaningless.
> Currently, it checks events even when xsk_check_common() failed.
> To prevent this, we move goto location (skip_tx) after that checking.
> 
> Fixes: 1596dae2f17e ("xsk: check IFF_UP earlier in Tx path")
> Signed-off-by: Yewon Choi <woni9911@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf] xsk: skip polling event check for unbound socket
    https://git.kernel.org/bpf/bpf/c/e4d008d49a71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



