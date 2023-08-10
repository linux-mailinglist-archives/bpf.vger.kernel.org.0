Return-Path: <bpf+bounces-7497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969EF7782C4
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 23:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59BD1C20D87
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 21:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A19023BFC;
	Thu, 10 Aug 2023 21:40:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C322F02;
	Thu, 10 Aug 2023 21:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2DCBC433C8;
	Thu, 10 Aug 2023 21:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691703651;
	bh=jt/NUvha+AYuETQysbUBUq/dMQaLn0OJNT63dU0S4O4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CRiK0Vu2oY6CBNly+YV8KfDusbwR8fqYoLyGRqLu2df24sdtBxlqLD28VxhQSUBpX
	 jsSKIEnimRCYbf48JL3/vydWN+hDMKWEltmuQ3vEyDvVJ2wTbfVsYlxvrYFLoefhGt
	 dS3GyeuAGCb3c7qme3d75n8IRNUYkjldAgupWvf8AGqwpnL+ZHF+dnsDP/1m1lLuZ4
	 IQsHgb4oQ7Am3tNbBY+hGKZZzv3uA0+ncQYZpg8AprGOBfieG/4PITNcDBnc8NMQMv
	 iP8UGDM3lEsMCPXy9aC/5Jls9c55d4fw7PTfVjzDO9FojZkBKHcrSEYZOvzI6rdCs7
	 d7arnJTGBBDhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E756C595D0;
	Thu, 10 Aug 2023 21:40:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2023-08-09
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169170365144.3628.7011774572938196429.git-patchwork-notify@kernel.org>
Date: Thu, 10 Aug 2023 21:40:51 +0000
References: <20230810055123.109578-1-martin.lau@linux.dev>
In-Reply-To: <20230810055123.109578-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Aug 2023 22:51:23 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 19 non-merge commits during the last 6 day(s) which contain
> a total of 25 files changed, 369 insertions(+), 141 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2023-08-09
    https://git.kernel.org/netdev/net-next/c/6a1ed1430daa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



