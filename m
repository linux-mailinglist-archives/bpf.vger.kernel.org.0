Return-Path: <bpf+bounces-20820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49722843F73
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 13:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06752B2C442
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 12:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651F379DD4;
	Wed, 31 Jan 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhYm0Y3j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EDB4205B;
	Wed, 31 Jan 2024 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704225; cv=none; b=Bk8f7BeGqSiz+nUKqRsgB79o9f/Y3w8jkxu+vNkZZZCo3BEQzAj3kLkQMKYnSEr/iEU1GDPHEVkuUYgwgvzlwMsjYHgEYP9WsavgR7Ytwlyl+uAn3PDdsZ1ZmplSE/j+rkoe7zRphNgt0SdfZ2hzsab3TFODs6HHcT8h5oJRFpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704225; c=relaxed/simple;
	bh=dQmcqZyGCVpAunYCRVp1AfKJ2llbhfxVUlSByVXTwik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DsUcEA//yIxu8rRXeUKDqn+q9EUxKobvSN8D7p7wBP5v+bmc2TzRfCnciOqRtfDgTokyaMTonfkJn0nSzMfOqA7Qa4HNQbNZhNLI8w4WRVQ8Mt8Y7kpfXnG/RL/KGEDpE6Z04YijRAFTWmREpPGMAecp8gk+CuVOLkzV/Cyagi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhYm0Y3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42649C433F1;
	Wed, 31 Jan 2024 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706704225;
	bh=dQmcqZyGCVpAunYCRVp1AfKJ2llbhfxVUlSByVXTwik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uhYm0Y3j9PWV/aB5FFde4SBDymNc0aJ4tykkrM2Uo+tDHBJ4HwxWwwlZS3pHvKaQ0
	 FPnyYFNVdrfdKAVxkABTPaLxjRwIbGpVsAYfR2OnW8o5qbXDSW9s5AzIG78zkEcPI1
	 T4OVzTCm6V/4edy1E4p40JwONH7u6r5hHapKmhCpk40ou7J7DnvmYf7lRBE90Dr8SL
	 arhAp1eOxb3PorXNQHsVNWQXC6Aiv7+ANEWldizh5ITwAM/Bofrdf2Mw/LcUIaUR+S
	 XWF/KlCLZWelHr7bM4LuEecbptwQUsE/FPEVTuoFYJLcxavv/1dRy1ZgfGKqMN511Y
	 +HJxDoHRd8mAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C054DC99E5;
	Wed, 31 Jan 2024 12:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: stmmac: EST conformance support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170670422511.21491.17051926451255201000.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 12:30:25 +0000
References: <20240127040443.24835-1-rohan.g.thomas@intel.com>
In-Reply-To: <20240127040443.24835-1-rohan.g.thomas@intel.com>
To: Rohan G Thomas <rohan.g.thomas@intel.com>
Cc: davem@davemloft.net, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, peppe.cavallaro@st.com, richardcochran@gmail.com,
 linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, fancer.lancer@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 27 Jan 2024 12:04:40 +0800 you wrote:
> Hi,
> 
> This patchset enables support for queueMaxSDU and transmission overrun
> counters which are required for Qbv conformance.
> 
> Rohan G Thomas (3):
>   net: stmmac: Offload queueMaxSDU from tc-taprio
>   net: stmmac: est: Per Tx-queue error count for HLBF
>   net: stmmac: Report taprio offload status
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: stmmac: Offload queueMaxSDU from tc-taprio
    https://git.kernel.org/netdev/net-next/c/c5c3e1bfc9e0
  - [net-next,2/3] net: stmmac: est: Per Tx-queue error count for HLBF
    https://git.kernel.org/netdev/net-next/c/fd5a6a71313e
  - [net-next,3/3] net: stmmac: Report taprio offload status
    https://git.kernel.org/netdev/net-next/c/5ca63ffdb94b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



