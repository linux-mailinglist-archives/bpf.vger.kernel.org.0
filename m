Return-Path: <bpf+bounces-35875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C402793F233
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 12:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5AC1F20F4A
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4C414389B;
	Mon, 29 Jul 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNKLd716"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206B1411D7;
	Mon, 29 Jul 2024 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247686; cv=none; b=OGt51sAGSNiZv5e86Qv0x6jAj880nMLhHQ8IwNeTtGX2YHXqO5JbtYpIgg3brn06yCk2EtF4KUiHxp77tTdm+/8hFqyNNgMnik6H4MYNQbgnf9Yt7YImtgi/3dSmMy1CIRQIfUwrEQvnJrfQxSLJFImK1PnbT0PuyJySRhe3ZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247686; c=relaxed/simple;
	bh=NwNnus/JismVpXfcnsO4EqRlsnW5MSNZNOFXsN3ixcs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bASg+UFj+EZUXyIYfvn+EPPlw7GaC+CpNDB+ATbHONejnYO93ntvViOy/dbgGFdNSAAe1uvCaIeMGe4E6W/Zg59Xxg8tQgm2ec0L+1nusqjru2uarq+9JKUQexVlmaMUxeWPUD5fPl85vx9eUB1lFS5Jt0uSp31SmKXemENOUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNKLd716; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D2F1C4AF0B;
	Mon, 29 Jul 2024 10:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722247686;
	bh=NwNnus/JismVpXfcnsO4EqRlsnW5MSNZNOFXsN3ixcs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CNKLd716CCR+fgJfFbWhG5qVYNy1/ePP7jxemNYPRQgVJRC/khEo9qj3bXw6Devnm
	 +M1vDYDTiiX/eLobBVq47YO8+jRuftbge1Y5xe5DS6d27CWJqBPnh+YDEwj/QBUtSW
	 FhH8/wiLvblISdxcnaeIiPGPvlDTPzhqFwONuMS+ySFSWuWb6tguHnDQVvf5oryHDk
	 Vo5d9ISMkyb8BnQoAwZEjVyBnmt6y8Y8MdHpPuOWR8Snel7tWGdtIihVmddB41ouMQ
	 1Mdt1HNpBF8UrXpgBSsKnUzvXKfmIeRJC2Vbfrtky96lzBrxKTiCwrYxpWuiTbL+7f
	 cj0S1BieUDzfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BC6BC4332D;
	Mon, 29 Jul 2024 10:08:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172224768643.24246.3444703659256541517.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 10:08:06 +0000
References: <20240725214049.2439-1-aha310510@gmail.com>
In-Reply-To: <20240725214049.2439-1-aha310510@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, bigeasy@linutronix.de, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Jul 2024 06:40:49 +0900 you wrote:
> There are cases where do_xdp_generic returns bpf_net_context without
> clearing it. This causes various memory corruptions, so the missing
> bpf_net_ctx_clear must be added.
> 
> Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
> Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
    https://git.kernel.org/netdev/net/c/9da49aa80d68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



