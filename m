Return-Path: <bpf+bounces-19160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD313825E16
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 04:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CD11C23BDB
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 03:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C90290C;
	Sat,  6 Jan 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEJNHvEc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219301FAA;
	Sat,  6 Jan 2024 03:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84A86C433CC;
	Sat,  6 Jan 2024 03:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704511832;
	bh=5XBExEJP4001NhSJnkiW9XbmuvN5s/G6qmnkrLtYD1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YEJNHvEcW5bErN8GG97M5O0Ppp0t+vP7u7rlw1kf+hDMPMC0nWVj9D4bd6BuKHI9a
	 JXqqFkxzH0v+QD6008wdV1MUL1Mccw93+/0ydAqed0PG6Edm7L2+xLHrhFBWbolsoD
	 mnjqdw/jAnNQA7RJng3pMi8eZIarlREOk7hWdaTigdFCc4TIjMDQ/DSWqdG91A4Gl5
	 2CFWi6O8q914gWSE0q5OdAQDQKWnX6mWHypCT0/HYZsjMnvsj5t6z2brBlDt6bj0qp
	 TFDcvp8dB7WZlV/O5cT7uh5t4jKtSo7EMSCcTOZ8qQT5xN+B0+5ZZgTuBpnbemZS6K
	 D8MSReLGZssww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B83DC4167E;
	Sat,  6 Jan 2024 03:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-01-05
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170451183243.21355.3142708861258708303.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jan 2024 03:30:32 +0000
References: <20240105170105.21070-1-daniel@iogearbox.net>
In-Reply-To: <20240105170105.21070-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Jan 2024 18:01:05 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 40 non-merge commits during the last 2 day(s) which contain
> a total of 73 files changed, 1526 insertions(+), 951 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-01-05
    https://git.kernel.org/netdev/net-next/c/8158a50f9058

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



