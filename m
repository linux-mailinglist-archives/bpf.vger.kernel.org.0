Return-Path: <bpf+bounces-29683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B122C8C4AB8
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 03:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B78AB226BA
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 01:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBB36FB6;
	Tue, 14 May 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB7lTTSI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB517C2;
	Tue, 14 May 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715648430; cv=none; b=oE2zm6wb1YwRWOyPeYrL5uV90ba4nUBk2KweO4JKFFhB0y+0DdYIaj93wIIRtRI7/rKjxt7VTubNBwhUer09BGu1Z9jm94+hyHWNSeIJ1mdV9hJ2PcO6tcjy0IkNAKAoDXQ76HoS264IyfyYd5ewOH4D1QbR6hGZBH4BX1b+xG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715648430; c=relaxed/simple;
	bh=YCEuYLrJKxHoiv+vyfkkPlmae5gq10l4H2KwzS4gVwA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MA3VIkW2viD9Sz+mGfBBqEm3Pmu/NUa5vyNV1W59gHSlxMR78TgscYdcGPgSyFFYQHlySTzeRG19XYzElnk3mnd/U6QcQHHhz0O8DR64XpoDCrTde5468/vyqOWYOW22T88ulEGovCBKTXisBFzqXNagfFJAhcpv/nnyB763+9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB7lTTSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B764DC4AF08;
	Tue, 14 May 2024 01:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715648429;
	bh=YCEuYLrJKxHoiv+vyfkkPlmae5gq10l4H2KwzS4gVwA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MB7lTTSIpXkdHCYkfrSuJYjBt/f3Of6XQAj/dtILG2vjewJoEjSOcPfS22y/nsxgs
	 Kn6iOkJDuMRyzpQh9fw3XHEjqTCpDsNpRQENhtJ19nENa1oHQ1DoMGJr5OIC1GUyA8
	 fCMYKIbwA/rEna+dybNC5A3e2g4WSoqTYdYru2LgUs6cGNTFt2QFq9xpe92obHHW+O
	 LXR8/ksodfRPR4qw3LsktTMTiKiO+YN0W5ugG1Sb2Mo5fXirB8r7LjS+nx+AvnlVk4
	 j/uhezQ8seBTtl3eCumL/kPqRZopkXtDnG1uVZCZwaSm3MV+dv86jXE/Mvtes/zkwx
	 7LctgwWe22/hA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A42DDC433F2;
	Tue, 14 May 2024 01:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mana: Enable MANA driver on ARM64 with 4K page
 size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564842966.4255.3881437468353003292.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 01:00:29 +0000
References: <1715632141-8089-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1715632141-8089-1-git-send-email-haiyangz@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, decui@microsoft.com,
 stephen@networkplumber.org, kys@microsoft.com, paulros@microsoft.com,
 olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net, wei.liu@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 May 2024 13:29:01 -0700 you wrote:
> Change the Kconfig dependency, so this driver can be built and run on ARM64
> with 4K page size.
> 16/64K page sizes are not supported yet.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: mana: Enable MANA driver on ARM64 with 4K page size
    https://git.kernel.org/netdev/net-next/c/40a1d11fc670

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



