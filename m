Return-Path: <bpf+bounces-12377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEE47CB9CD
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 06:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9FA1C20B63
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 04:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1233B53BD;
	Tue, 17 Oct 2023 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2J+Y/xx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907515B1;
	Tue, 17 Oct 2023 04:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC1CCC433C9;
	Tue, 17 Oct 2023 04:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697517632;
	bh=RMpFuiQqUigKtsA/1C9XhG1y0T7dIWfn0T8OZqs9RqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u2J+Y/xxhaPt86x0L3CLo8q/evmw26vreJ0HFmqVwS4umr9A2WLq8ciutmIYgKplz
	 gP/BXBa7IDF7Mkjc3WCdnVlTiGsOBxrkLnCrDQC+Jf0bEE/xjPnGuJzlNCH8JHM1Wb
	 V9fFqKgqhJdkpD647XDXtpx+/bgFqZxh44FDbhNeecMTVdTps76r50dsQI5JnQplyr
	 CWIIEqcTQ7+UXPgcmjPByMm9sMJRas4WlbQ+l3CZblmzqpe6z0J2+fndYQPpQvcMjX
	 yiIWwq13TH0rZSYnBO/fKY6e2RVBJIAUSYf8APzzf4yp2PgcZbQhFavjgBghW0UQvR
	 wFBIbPWtc4MLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4031C73FE1;
	Tue, 17 Oct 2023 04:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2023-10-16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169751763273.32600.1346660013778465535.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 04:40:32 +0000
References: <20231016204803.30153-1-daniel@iogearbox.net>
In-Reply-To: <20231016204803.30153-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Oct 2023 22:48:03 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 90 non-merge commits during the last 25 day(s) which contain
> a total of 120 files changed, 3519 insertions(+), 895 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2023-10-16
    https://git.kernel.org/netdev/net-next/c/a3c2dd96487f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



