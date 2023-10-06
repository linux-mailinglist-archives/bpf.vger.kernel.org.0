Return-Path: <bpf+bounces-11512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14B27BB119
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 07:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147F21C209F2
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 05:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4CC3FF5;
	Fri,  6 Oct 2023 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9j0Hz8d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F423A7
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 05:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C02AC433C8;
	Fri,  6 Oct 2023 05:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696569029;
	bh=I1TyZZvDcgcqxnisZQ7MkHtizAiohWfWVBhg6535P2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R9j0Hz8dxp0UoBKcCCHrlyBqypyOIyST2TFUqF1rM4zwIfvCcPjZOvOv2ORtbu/Vw
	 0Guk1I8/oqJtEPBDJCPUK131pqJ/Y4JtuPmFSLUOPge3L3SrNulnc8toBuWeHy8/xJ
	 gd6UQ2K8/PegC8eaol0iRG50uwRtCZsMODs455D3TX0Ko5w0doozYeyuwMBWXVghPO
	 E1kpCNw70Cb2Gytl7shjI7VpjKypMyluG5ePXig7Y6r7tKShdLmjBQ97YK/WyV99tC
	 lRGMkokBaHiFqlytuZurSVQWkbBPY7Y07tORSIy4t5eVF2jMUzDms6LRhO+xf5/o0h
	 BGGMRrztguCuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EBBFE22AE3;
	Fri,  6 Oct 2023 05:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] cleanups for sockmap_listen
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169656902911.30880.9997812914153027889.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 05:10:29 +0000
References: <cover.1696490003.git.geliang.tang@suse.com>
In-Reply-To: <cover.1696490003.git.geliang.tang@suse.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: andrii@kernel.org, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  5 Oct 2023 15:21:50 +0800 you wrote:
> v2:
>  - rename c0/c1 to cli0/cli1, p0/p1 to peer0/perr1 as Daniel suggested.
> 
> Two cleanups for sockmap_listen selftests: enable a kconfig and add a
> new helper.
> 
> Geliang Tang (2):
>   selftests/bpf: Enable CONFIG_VSOCKETS in config
>   selftests/bpf: Add pairs_redir_to_connected helper
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: Enable CONFIG_VSOCKETS in config
    https://git.kernel.org/bpf/bpf-next/c/d549854bc58f
  - [bpf-next,v2,2/2] selftests/bpf: Add pairs_redir_to_connected helper
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



