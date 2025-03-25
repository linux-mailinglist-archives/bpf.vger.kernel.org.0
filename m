Return-Path: <bpf+bounces-54688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D6EA704AB
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3A616F32D
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABB625BAD4;
	Tue, 25 Mar 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbHx+F7P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C301B85FD;
	Tue, 25 Mar 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915396; cv=none; b=nFwcYFAbt6fboOw8xvh77vqDptHXMuGXtxSv5Uo2J3cjo4qfY1bR82Nyxy7Jbsi9ckgEASU2KqJC3i/JEJrgIUmfXyoYY3PJhJsmArEjivbNfjSjwt9Y3KqBeu/e6HvMAVslMfTuSDDlaA/jw36WFVcaxoVodYk0Mia4pRGk8Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915396; c=relaxed/simple;
	bh=OOCHEZWOntHnEnJ4X5afRh3Il+X2cvef/e+co+E8A0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d3wMEcKHLeEV8uQGl5X2de2z5n858L5p5dJJ7tE4/lBJMpsskfApYKLClsmCBkBT6Gy9L3mXu9vmjh71t7F4GzY8+EePIvrA8RYTozoEHk8jYfYjW0SUNQUOVOG1/pe4KlSNieKzxgWe94uyHo1wuVPh5v22VmeKWvKEiAQ3cz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbHx+F7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4C1C4CEEA;
	Tue, 25 Mar 2025 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742915396;
	bh=OOCHEZWOntHnEnJ4X5afRh3Il+X2cvef/e+co+E8A0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WbHx+F7PWJwkgyWN+uBf7fx85bnmq67+avOvGZqIF+AC4NHzgiscZFT6BkMDmD/Ze
	 w+tAkB3D6oBr9rKOvQYFO0780VPtFN/cc7w6Yp8L3h/xX5KSB+hcqBeVGA090jamvq
	 QLH+FWB1Ng3QIuQbK1bAnq+dC8Gixkpf2wAsvUeH/98Kfni87HAXbE3Cms+RSkAlQU
	 hE1mtNMdCSxxj+RFu/rES/TXBxOVm3YItLZKxOaBG339bhLmH+V5DKYMLXlcFjb0cG
	 Uvk81Y8+ynoU9hr1DIaNfHZEin/p5m6KjhN27H+cKoCBpEStxIp52pQHjAQQ74slOL
	 HHkBENmD6RpWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF300380CFE7;
	Tue, 25 Mar 2025 15:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bonding: check xdp prog when set bond mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291543254.609648.7082589771393537826.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 15:10:32 +0000
References: <20250321044852.1086551-1-wangliang74@huawei.com>
In-Reply-To: <20250321044852.1086551-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, joamaki@gmail.com, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Mar 2025 12:48:52 +0800 you wrote:
> Following operations can trigger a warning[1]:
> 
>     ip netns add ns1
>     ip netns exec ns1 ip link add bond0 type bond mode balance-rr
>     ip netns exec ns1 ip link set dev bond0 xdp obj af_xdp_kern.o sec xdp
>     ip netns exec ns1 ip link set bond0 type bond mode broadcast
>     ip netns del ns1
> 
> [...]

Here is the summary with links:
  - [net,v2] bonding: check xdp prog when set bond mode
    https://git.kernel.org/netdev/net/c/094ee6017ea0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



