Return-Path: <bpf+bounces-11855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF617C4829
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 05:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60281C204F5
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 03:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04750C15B;
	Wed, 11 Oct 2023 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGTWitNa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79E6106;
	Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B99FDC433C8;
	Wed, 11 Oct 2023 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696993825;
	bh=BIyIEeJ9vv8PIwoRJrT9d4kFVu9XIVO3GvL3xk3woHU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lGTWitNaOxaKja+W3z1jWO8TqZOLOdyVdjhMZ7qLTh3o9omtOXFFKtvpOaTVJJXYM
	 3jxC6e/q0t2RO4qAem0D6Y8xtmLlb3ej2NWGs+yfwTBm3oh6EFEoi9sm9KVojnn9DV
	 agbuJxtaD3CROrBz0S6odpyEPHosMEgyNjmD3hNUH0DeoOJWY4u+OT+y1ECFgfBry8
	 osjvNry1MMLoN7TVvrWf3hPitQzWrq2HZvGfNcbY5y7tcR0qPcWFCURf4Q+GzPSpuY
	 fUBx409h7rl3KKg/Dym0v8CdJZo8RGjspz3baqvaD63RKnizl0mp3bau5AcdKWBhBT
	 OJaru1Upgg/cQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CCCCC595C5;
	Wed, 11 Oct 2023 03:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-10-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169699382563.3301.16714027893385779188.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 03:10:25 +0000
References: <20231010223610.3984-1-daniel@iogearbox.net>
In-Reply-To: <20231010223610.3984-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 00:36:10 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 14 non-merge commits during the last 5 day(s) which contain
> a total of 12 files changed, 398 insertions(+), 104 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-10-11
    https://git.kernel.org/netdev/net/c/ad98426a88aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



