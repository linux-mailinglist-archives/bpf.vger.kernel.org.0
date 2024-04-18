Return-Path: <bpf+bounces-27129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814388A9726
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 12:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BA71F236BE
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FF515B980;
	Thu, 18 Apr 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8UOv85Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873A15AD8E;
	Thu, 18 Apr 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435629; cv=none; b=E128M3K/yoAWu4joftIVl+bk77H6D3G+X6MHyQEm5gwk8cuy+1w7vKVHXO+sIfI8VJN80LaJd6MmycmfC4/spCuTnBRFQ93yFGlkFn+EquOEcxuaNk6FzxKUQQJZmYD1aINfHHZO86K9+GqFunpI16BiMsUPsdsYSC+72bhMzYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435629; c=relaxed/simple;
	bh=xUjEsVCudpe2LaHWLgcMZtL/kcKx7Fu3GhGujrg6aU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dUfq2oxAfxgyVaNemgIG+Ztew2XakXZ3+j58jKWQE07jrg8Je5Wcu0P47YNxc/nsfiqaMIH+X5j5fh43f0VipQ8UGllBKqrBwoBG4Xfo2LjJIP4iTNiIbSIflp00P32mqPdH1Uh5YhFL2/P9UDY5+Xwt621TAW5w++4yV4loL4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8UOv85Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40B54C32781;
	Thu, 18 Apr 2024 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713435629;
	bh=xUjEsVCudpe2LaHWLgcMZtL/kcKx7Fu3GhGujrg6aU4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B8UOv85Z31M07gq26NTMFJwk3Uk9ggG7NpMSo0DNrcd9kseSHmkhNKC0uFCGRWn+V
	 Y0Ev/Bp1ljmmuItPFuW4aPflzaJRmYZYtdXwmoopaWYxEbY1DDSybhV0SnxzK/DYj9
	 cZ+m1Ea5jxnpkpXBG1HY0ppt+BD7SFRTQ+0sZW6HXmjI5heVo2B+bC4X4D6+F1aJjV
	 fbaXw9TW9DfSnXbbaCMI5A4FQ9rxYeyvjd6MukGqZpcxrfv4WOMetMuuyjlqNqPzlH
	 s6UB0mVEzNW2dPegi3DjI8qEt/KfcvZu8uVV2evr16tyQODEeTfyUgJ8THf/FuDsFM
	 A/B1MrLEWVuCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E6C1C4361C;
	Thu, 18 Apr 2024 10:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] neighbour: guarantee the localhost connections be established
 successfully even the ARP table is full
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171343562918.22936.12157821486480978406.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 10:20:29 +0000
References: <20240416095343.540-1-lizheng043@gmail.com>
In-Reply-To: <20240416095343.540-1-lizheng043@gmail.com>
To: Zheng Li <lizheng043@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 jmorris@namei.org, edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 James.Z.Li@Dell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 Apr 2024 17:53:43 +0800 you wrote:
> From: Zheng Li <James.Z.Li@Dell.com>
> 
> Inter-process communication on localhost should be established successfully
> even the ARP table is full, many processes on server machine use the
> localhost to communicate such as command-line interface (CLI),
> servers hope all CLI commands can be executed successfully even the arp
> table is full. Right now CLI commands got timeout when the arp table is
> full. Set the parameter of exempt_from_gc to be true for LOOPBACK net
> device to keep localhost neigh in arp table, not removed by gc.
> 
> [...]

Here is the summary with links:
  - neighbour: guarantee the localhost connections be established successfully even the ARP table is full
    https://git.kernel.org/netdev/net-next/c/eabf425bc6ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



