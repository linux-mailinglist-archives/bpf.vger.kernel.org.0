Return-Path: <bpf+bounces-15393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54BF7F1CD3
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 19:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4AFC1C21837
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 18:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C3C31A87;
	Mon, 20 Nov 2023 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/7/UnYt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3330F94;
	Mon, 20 Nov 2023 18:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7C39C433C7;
	Mon, 20 Nov 2023 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700505626;
	bh=VsRE5W6uW4em/GgA7UkjI+XyVLcVjlRUHUVbH3pekBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X/7/UnYtE8kIT8r6KwVgDVLMvpiF+CbkVH35YAq3WtpmMgxY+8vFZD1iNdXLpibtU
	 95NzbEszBzKh/g9kDBnNCX7tTD9x9m4+oyXxpyKeqApOQSX2/jImWKsGj/BYtQNh1+
	 9DwtdcEahGWXwts7Ek0Tud+Em+EcLtq885g4v9HAZCKEgXFmv1tTr8Vwz6hOsRVY4X
	 9efwuJNeaQEj3JALkI3IMYvJ9Ldz86qAGqwTU1rdpKZ6duGWhbnRp5bOmqSgKf+8oD
	 0LMhEo9hi6dBxwMUKgtNNHPDNjAFceCFqCGtQp9DBi0mALh/zoRBpXv780hwzX75wZ
	 1MbYiQrqDx1ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2D65EAA957;
	Mon, 20 Nov 2023 18:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/8] bpf_redirect_peer fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170050562585.4532.1588179408610417971.git-patchwork-notify@kernel.org>
Date: Mon, 20 Nov 2023 18:40:25 +0000
References: <20231114004220.6495-1-daniel@iogearbox.net>
In-Reply-To: <20231114004220.6495-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@kernel.org, kuba@kernel.org, razor@blackwall.org,
 sdf@google.com, horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 14 Nov 2023 01:42:12 +0100 you wrote:
> This fixes bpf_redirect_peer stats accounting for veth and netkit,
> and adds tstats in the first place for the latter. Utilise indirect
> call wrapper for bpf_redirect_peer, and improve test coverage of the
> latter also for netkit devices. Details in the patches, thanks!
> 
> The series was targeted at bpf originally, and is done here as well,
> so it can trigger BPF CI. Jakub, if you think directly going via net
> is better since the majority of the diff touches net anyway, that is
> fine, too.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/8] net, vrf: Move dstats structure to core
    https://git.kernel.org/bpf/bpf/c/79e0c5be8c73
  - [bpf,v3,2/8] net: Move {l,t,d}stats allocation to core and convert veth & vrf
    https://git.kernel.org/bpf/bpf/c/34d21de99cea
  - [bpf,v3,3/8] netkit: Add tstats per-CPU traffic counters
    https://git.kernel.org/bpf/bpf/c/ae1658272c64
  - [bpf,v3,4/8] veth: Use tstats per-CPU traffic counters
    https://git.kernel.org/bpf/bpf/c/6f2684bf2b44
  - [bpf,v3,5/8] bpf: Fix dev's rx stats for bpf_redirect_peer traffic
    https://git.kernel.org/bpf/bpf/c/024ee930cb3c
  - [bpf,v3,6/8] bpf, netkit: Add indirect call wrapper for fetching peer dev
    https://git.kernel.org/bpf/bpf/c/2c2254257040
  - [bpf,v3,7/8] selftests/bpf: De-veth-ize the tc_redirect test case
    https://git.kernel.org/bpf/bpf/c/eee82da79f03
  - [bpf,v3,8/8] selftests/bpf: Add netkit to tc_redirect selftest
    https://git.kernel.org/bpf/bpf/c/adfeae2d243d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



