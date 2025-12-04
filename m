Return-Path: <bpf+bounces-76088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D9CCA51CB
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 20:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 821DF3044696
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 19:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCF433A6F8;
	Thu,  4 Dec 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E064wMQF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C52777F3;
	Thu,  4 Dec 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764876188; cv=none; b=XYFzdi1xemNvpuW1wJV/Y0kfsR7JSK+dWZgkhlwW2K2LoCClAYcVCEXZgChtPwG7JSG/k/yV89tljBt1PUIg+DvN9XguWKlwskej+BTADgrcn/UFEhzjZ3M7Ru9dSJa07346J8kKbbyZxTM6Mrux5pcvNxmGHpdVnv+suGB0t+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764876188; c=relaxed/simple;
	bh=H+6vKkQlR+H9nBX7nMyb0WD8+vU1U+IUd1j9QYRXQ4g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FY6Tyb70uwWBugTB72OhxDu3MX82AshmlT6QygpjELxVmLknYn07IMvYRfYaYyGZJOxHSFqsiKUAWVipG0JMKnYFqYRyfqg2b2pzRXOJbljaHuKl8ehyQUHWfE6cjQEykUZv0wbB/siG6X5b9TFkd4qd1q3BuGFY+RLu47T8FhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E064wMQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214F8C4CEFB;
	Thu,  4 Dec 2025 19:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764876188;
	bh=H+6vKkQlR+H9nBX7nMyb0WD8+vU1U+IUd1j9QYRXQ4g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E064wMQFuS60Odu0hSm+JFYbkh9bsawGe0h/bNiczluRcr7ZTZt0Nk7dK4kLWhYiz
	 EC25x3lfUM3u97Cvqn29RMimXyPlWZ7mo7s9rXIvYExp07ylYwDIOp761SZUYwT3ih
	 oPS3C/ZYm1N6o5SAJuRN2VA8XGFZWZbVER2iaPRccYCqPWjlxUI/j6BDB3wbW6eO+E
	 COHdQG/nyHCBdd+OvKnafedyVTOoEI+1koKxAuT+rrkGSqGL753FWKCmqcqVrbklsn
	 TLpGXYadVspRtU02arDW4+MXFMHK2vsj6PM/EKgrTnSUq9iy9ATbJIFRLIcIj8Pp4U
	 1sUYZdQs2mNXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7892C380048B;
	Thu,  4 Dec 2025 19:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] bpf, net: Fix smc for CONFIG_BPF_JIT=n
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176487600628.940161.471761997237181377.git-patchwork-notify@kernel.org>
Date: Thu, 04 Dec 2025 19:20:06 +0000
References: <cover.1764843476.git.geert@linux-m68k.org>
In-Reply-To: <cover.1764843476.git.geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: thinker.li@gmail.com, martin.lau@linux.dev, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
 mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  4 Dec 2025 11:29:14 +0100 you wrote:
> Hi all,
> 
> If CONFIG_BPF_SYSCALL=y, but CONFIG_BPF_JIT=n (e.g. m68k/allmodconfig),
> net/smc/smc_hs_bpf.c fails to build.
> 
> This patch series fix the issue in two ways, by:
>   1. fixing the dummy variant of register_bpf_struct_ops(),
>   2. making SMC_HS_CTRL_BPF depend on BPF_JIT.
> 
> [...]

Here is the summary with links:
  - [1/2] bpf: Fix register_bpf_struct_ops() dummy
    (no matching commit)
  - [2/2] net: smc: SMC_HS_CTRL_BPF should depend on BPF_JIT
    https://git.kernel.org/bpf/bpf/c/861111b69896

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



