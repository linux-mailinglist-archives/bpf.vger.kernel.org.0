Return-Path: <bpf+bounces-11281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4B77B6BE2
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 16:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5AB851C20A63
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12121339AA;
	Tue,  3 Oct 2023 14:40:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17526FD2;
	Tue,  3 Oct 2023 14:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 043BBC433CB;
	Tue,  3 Oct 2023 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696344031;
	bh=9r+JVAeQ4/nWHVdQJjEIceaFGUb7kkfWFmy9AcjP7Aw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DtlP7cRG40KsunfNudk3NQKGyzrljJJ/412z1/4yJj/dqFjlRwY4MygdLNRlZrEgK
	 9I79jS7aDfFjaSoJp9IeJ1O5xI+GTcdCEYEwugmkKkwlcA0awx0uid5uc5+ZcA589A
	 jZSKDkP02weFVwtABZQ5nupdibQ2Zd+C30aFs5TKardboPELnX3YCRrMi/VQeaTpu8
	 pSKz+2b3LYcgG5wLaNU+EcKynW4iE6hez3wvYO1OYqq9FZiK9zQJPE19RvAKCgybWY
	 0sST/FjEZwhk/i0D3Cbij7bCqEah5o6Rt8lapIY5xXEXdo6+Sl2IhWDE2plNuq4P9Q
	 87e7ThkbWh/iA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E228BE632D1;
	Tue,  3 Oct 2023 14:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] bpf: Remove xdp_do_flush_map().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169634403092.1390.11461161648199087522.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 14:40:30 +0000
References: <20230908143215.869913-1-bigeasy@linutronix.de>
In-Reply-To: <20230908143215.869913-1-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 ast@kernel.org, daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, pabeni@redhat.com,
 tglx@linutronix.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Sep 2023 16:32:13 +0200 you wrote:
> Hi,
> 
> #1 is a s/xdp_do_flush_map/xdp_do_flush/ on all drivers.
> #2 follows as the removal of xdp_do_flush_map from the API.
> 
> I had #1 split in several patches per vendor and then decided to merge
> it. I can repost it with one patch per vendor if this preferred.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: Tree wide: Replace xdp_do_flush_map() with xdp_do_flush().
    https://git.kernel.org/netdev/net-next/c/7f04bd109d4c
  - [net-next,2/2] bpf: Remove xdp_do_flush_map().
    https://git.kernel.org/netdev/net-next/c/75cec20345fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



