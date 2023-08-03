Return-Path: <bpf+bounces-6900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5B976F57D
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 00:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B352823BF
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 22:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC3F263D9;
	Thu,  3 Aug 2023 22:11:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65962419F;
	Thu,  3 Aug 2023 22:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38FC4C433C7;
	Thu,  3 Aug 2023 22:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691100677;
	bh=n2URLA4Ni8Z5c/YqoMbcmv5VulAXjOk/X7VAyog0Bn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VEBAT2NIoAmM+Fplmbv1z8kzmS7qtZ/O3jqEbr3BPwKH6lIi6bU5vU+bekZrY/11n
	 eaqMUS/e2WlIN0odsjF7zyNG83Kz7cHdj4S4/CIodBUL3bqwtKIeMdp9JLJ8jzRjmj
	 4VD4GNOAN0B4VZnAW3uQ8YBbO0ccxVylv0x/L7+JaUO9WBU065RB6Iii5PxbkW19Mt
	 cRRaZoEmNXBZmS8iIwz2GkT5eu153vym/WrJcCRhANUMObS4aoFkipkcapo6KLOi4n
	 +ujtV4c/x9FLJN3FLcPuWr0tahpVx7/S8GCg5IPHwksoILPKi8jY4yEUXPM5O9hBI3
	 uTt5nlOXaN7pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 160B6C595C1;
	Thu,  3 Aug 2023 22:11:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2023-08-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169110067708.23892.8089279926204443369.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 22:11:17 +0000
References: <20230803181429.994607-1-martin.lau@linux.dev>
In-Reply-To: <20230803181429.994607-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to bpf/bpf.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 11:14:29 -0700 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 5 non-merge commits during the last 7 day(s) which contain
> a total of 3 files changed, 37 insertions(+), 20 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2023-08-03
    https://git.kernel.org/bpf/bpf/c/3932f2272313

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



