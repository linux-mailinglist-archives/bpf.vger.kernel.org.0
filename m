Return-Path: <bpf+bounces-47285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CB49F7112
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 00:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038771890463
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 23:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B79F1FCFE2;
	Wed, 18 Dec 2024 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTmpocen"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011D11FAC55
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734565215; cv=none; b=ST4nFwBio1VlK0ZXpoGoD93K8CUbCwLunWuI79xCpORuKdGj7kfB2XxdX3XBw92P2GGtFLm1fVo+mqUkoxWsfhvyW67jVUQ8D8wr9MRQTZA7Gr1RhBr26dgb5MaLFT9I9idQoE1BeQBPKcJHIDlF5IxcJ5jQiuaJ64IBSyu0irA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734565215; c=relaxed/simple;
	bh=w64uaUiPWtO0fz+g2KFQWaUWtTUMmdqEJQJIqkYaxPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CpWY3dGjiDjgoN2dHogS0L341If49cPAmDxjqEPhaNbB2IoVmVJkOBRM3dqkfo/LNFhllVCg40e1kgpZDeWueYerUTO0NJ0hzH0N8l4OKOQP0BKNAXZTYVKFqs4igZ/8ye6Vxe+k3dWBsLET+Gicp7H48V/NyICB/9cKrrukYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTmpocen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB98C4CECD;
	Wed, 18 Dec 2024 23:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734565214;
	bh=w64uaUiPWtO0fz+g2KFQWaUWtTUMmdqEJQJIqkYaxPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MTmpocen9Gcic/IcW/iNUA8TklGZ8lg5KGOBtyREsksPoYnEBwhHSTiTjJi/OGUnq
	 DQiy1oUR8+ul47XEwAs/QUBvSXza8IK0TqaYIhuk2wOyUWNKlT4FL6gcwddiD8vCjX
	 gQUE+975wdkoXAn7MTkteQumakXwoeTRY+pyBETff3UCO3L9YXaIg8kap8087RO0/1
	 8jCNPbIX3951sbhr0ZXwMggt16koQlmXwrf6VEZ70Agw7JFWj1hAnenFMfZSUrlNE5
	 4gae0BMCn+pEai9/Css8RLbSBFDJMsA9lWfJ0bOumywmEUYUWcetewztVV05Ub4C3z
	 BPCRdZxWKaRLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BDE3805DB1;
	Wed, 18 Dec 2024 23:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: bpf_local_storage: Always use bpf_mem_alloc in
 PREEMPT_RT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173456523200.1761517.2036940592472471840.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 23:40:32 +0000
References: <20241218193000.2084281-1-martin.lau@linux.dev>
In-Reply-To: <20241218193000.2084281-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Dec 2024 11:30:00 -0800 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non preemptible
> context. bpf_mem_alloc must be used in PREEMPT_RT. This patch is
> to enforce bpf_mem_alloc in the bpf_local_storage when CONFIG_PREEMPT_RT
> is enabled.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: bpf_local_storage: Always use bpf_mem_alloc in PREEMPT_RT
    https://git.kernel.org/bpf/bpf-next/c/8eef6ac4d70e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



