Return-Path: <bpf+bounces-34792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD4930D50
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 06:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0241C20805
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 04:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AD413A889;
	Mon, 15 Jul 2024 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU1bal1s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC463C8;
	Mon, 15 Jul 2024 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721018431; cv=none; b=jQZk5KN5OIcfGUHl+HuVZqhWHgsMH2uy25LTPvnuW+44BRMR6V3R809mT2LrJSbxkZq02Bg1Lcy6zumTugAWUTims0mlD37kfGiOL1Omw7RbMcYEa1gJOV8OVflwWC4WRtNzPgorV50mnSwrQ9qlA8mhJMLwFENuzaxdjVSFSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721018431; c=relaxed/simple;
	bh=TUt666jNRuCL7cIEX9ab4D0szEvanL2EC60lnXt/ApQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EUdm5msgIbbys0KhaahQDoaWgz7pZrDmwZUyeAKj7iiYsLrFD0krZZ46xZwMb86Me0yuqoh4cSQZ733iTJ+UGGdgY9QI18gmusfZVaHX7TZExqq81aC7DUs0bwIGYC/o3KvRPoZw28BXVl9uyu8FxMF5kKKH2T16+rHPFqEoMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU1bal1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B924C4AF0C;
	Mon, 15 Jul 2024 04:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721018430;
	bh=TUt666jNRuCL7cIEX9ab4D0szEvanL2EC60lnXt/ApQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MU1bal1sNwHamU79jkJ3s/pWcZzb5w7cA3oWeW35DKvxpoCWq8mICzfKo8/Ksq2dT
	 ViVQo9lIPzFQaj4rfl9RCbD20g+guqQzbnbE//dirKrJOS6AGqPcLo92zoIToTCMuG
	 uwBbHk5HRS+N4BGZ1tlYVnt3gkOT/cnEN3cNN7AlAH41W8EMfLc/gg/kVz0IXlIuzm
	 EY+dEWcby3tH3PvVfXksWiGJ/iqI7LtmCSHpqEnuAUhnj4PX/Tc0SvcoycSpRK+xPA
	 XouVHUtNE4a14NEhHVrnGGjmjDsYC2K2XepDNLT8FvElVvV6M8j8SISlp93/36oR2P
	 iNR8YPrX8V93w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57F7AC43331;
	Mon, 15 Jul 2024 04:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xdp: fix invalid wait context of page_pool_destroy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172101843035.2749.4308013490462754143.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 04:40:30 +0000
References: <20240712095116.3801586-1-ap420073@gmail.com>
In-Reply-To: <20240712095116.3801586-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ilias.apalodimas@linaro.org, jonathan.lemon@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jul 2024 09:51:16 +0000 you wrote:
> If the driver uses a page pool, it creates a page pool with
> page_pool_create().
> The reference count of page pool is 1 as default.
> A page pool will be destroyed only when a reference count reaches 0.
> page_pool_destroy() is used to destroy page pool, it decreases a
> reference count.
> When a page pool is destroyed, ->disconnect() is called, which is
> mem_allocator_disconnect().
> This function internally acquires mutex_lock().
> 
> [...]

Here is the summary with links:
  - [net] xdp: fix invalid wait context of page_pool_destroy()
    https://git.kernel.org/netdev/net/c/59a931c5b732

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



