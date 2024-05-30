Return-Path: <bpf+bounces-30979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B238D54DE
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 23:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3671C21827
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A1182D36;
	Thu, 30 May 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0dvOzbE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154821A0D;
	Thu, 30 May 2024 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717105831; cv=none; b=LifRyulqZ/X6MMwgXl0OY3/R5ja0RixbL93BpKAIxT98GbkOxoQGXJMcT7Jtq90H13+oRHD50FAjyxzetoCL9m+V5nxANtxUBz7IKt9pAKZZy2BoEywD8tQmFi5qALPrjvZDX8oj3mo81KfgLhonYFidrTZL8664YISJ3EXgKbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717105831; c=relaxed/simple;
	bh=ydaVVg3ZXwctgR/BUhqdRitYexmMnLX6azW+xezquiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HtLJ8iTuXge14HsE34NOaUxGh9PW5f+vpGZzjOEUUP6Auq0uE2ESHKr7GfMmf9ioRSCPMhfh4acQ+mdXYMk9UPU3K8bUwDgAeeOQAngu30f4rl5Ae7ysnEg22Cj/8wnoPUu6DoXBGVgeqkflnzH3B31FaInDAlbHenKvKgIAkGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0dvOzbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79E70C32789;
	Thu, 30 May 2024 21:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717105830;
	bh=ydaVVg3ZXwctgR/BUhqdRitYexmMnLX6azW+xezquiM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u0dvOzbEDjvznLlQ3EBLkmYmQs7zX/H+UIpOnylKwdZ66AT3w00ZG68/1/9Z9bA85
	 SmPdmR6GteA4d+h0TDtf+G4X7YYK5vTpR1eWeNTsH+jAznvxQxibOMFOBQquLGAF2r
	 wkduA2WOshY3c4c455rTYbWBFoCj78S6bsAV2ZDZ/StaXBzPVCKWxgawwvHCOjSPOn
	 Bn771UAtnsS+7AJEeQShD17RlLcKMSgcHxrUBnDOOk8W8OYpW6iEB5UIa/XKmMQNn2
	 Uss+sHS8zcB1zcdOo0LH3RN7ajtHwRTxQYqM1/FjL1xnsMMSS+siSdvMkCt6bCQA1P
	 6byIcG7CscQPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B553D84BCC;
	Thu, 30 May 2024 21:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: test_sockmap,
 use section names understood by libbpf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171710583043.29870.4088999546124812358.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 21:50:30 +0000
References: <20240522080936.2475833-1-jakub@cloudflare.com>
In-Reply-To: <20240522080936.2475833-1-jakub@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 22 May 2024 10:09:36 +0200 you wrote:
> libbpf can deduce program type and attach type from the ELF section name.
> We don't need to pass it out-of-band if we switch to libbpf convention [1].
> 
> [1] https://docs.kernel.org/bpf/libbpf/program_types.html
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: test_sockmap, use section names understood by libbpf
    https://git.kernel.org/bpf/bpf-next/c/46253c4ae961

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



