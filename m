Return-Path: <bpf+bounces-6474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AE776A24C
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 23:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B0A281415
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 21:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4FF1DDF4;
	Mon, 31 Jul 2023 21:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55C1DDD1
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 21:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C39E0C433C9;
	Mon, 31 Jul 2023 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690837223;
	bh=hM4O6rd3rl2nwdrbPLh8e5AU2fMHoSthFtiO7uEZj/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DPedMuDbMyQ1WoVFNvox8yvkEgD6C6Ml10kIE3g2XgLeIwwxeI6xs6Xg18nKVWayw
	 FqjjZkcP9a7aW5hpwGur4GWzysoL8jgGU+rC4l3VrAQB/HNWU7s4A0M0imuSci8gFx
	 fpA8pJ8nWC46FGGv/HmQlBKgbyzcdT+qhdhhiG0SzsIWAVHWAGccjawM2036gcdN4h
	 bcoWa7a7b/GEnN7b835EPcIfV+HJpsDWrMRMbe6X/YK8E/o72pRBpV23oVd9HFM6oM
	 CHdW48Ff5iysxrYSYy1iFy4e7QmK1XQd0sGE1gjMHhTBwOctkL1P1UZwQS/Un8EL2s
	 1nWD4oGKbL79w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E9BFC595C0;
	Mon, 31 Jul 2023 21:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] net: remove duplicate INDIRECT_CALLABLE_DECLARE
 of udp[6]_ehashfn
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169083722364.15571.7926775828310116758.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:00:23 +0000
References: <20230731-indir-call-v1-1-4cd0aeaee64f@isovalent.com>
In-Reply-To: <20230731-indir-call-v1-1-4cd0aeaee64f@isovalent.com>
To: Lorenz Bauer <lmb@isovalent.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 31 Jul 2023 11:42:53 +0200 you wrote:
> There are already INDIRECT_CALLABLE_DECLARE in the hashtable
> headers, no need to declare them again.
> 
> Fixes: 0f495f761722 ("net: remove duplicate reuseport_lookup functions")
> Suggested-by: Martin Lau <martin.lau@linux.dev>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] net: remove duplicate INDIRECT_CALLABLE_DECLARE of udp[6]_ehashfn
    https://git.kernel.org/bpf/bpf-next/c/74bdfab4fd7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



