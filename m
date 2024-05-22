Return-Path: <bpf+bounces-30341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E88CC8D3
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 00:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829B4280DED
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47252146A91;
	Wed, 22 May 2024 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODDZJX6f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB06980617;
	Wed, 22 May 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415829; cv=none; b=jwDaRyIRvbznDgYb9XdQAF0Y1IOzjOm1+jbjxpTxHMkpSAVLAmocZZwDML35uqlUat1iBQ/6/URilaOwGzGxXp1Cz/+xHSdf6hNPnNDDhuvLWYWyQUeonBimpJGdJYpX+hbtNh6lITjbETb6NaWwVhNRlkqzuZ6XkLhl2MaI6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415829; c=relaxed/simple;
	bh=oSFNzMpDKtK4eH1YetPIyVYw4X0A4rqOFX0DW5tdTNc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mD123gVt3PddbyPPfcaA2B7cMYr+2jMIJQBCFuerI5IZwC0F3lten2ekcf8x/3W7Zk8rdfi31Qi54SJU0eJENVFVLIp0x4VzQq9BAf6YEQ5XaIB3brSTvQ/eyFP3XV0ZCSrkcKInTCihY8fyM3un9UBUoUhYJ8AzGwdGlWlXN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODDZJX6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C33DC32781;
	Wed, 22 May 2024 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716415829;
	bh=oSFNzMpDKtK4eH1YetPIyVYw4X0A4rqOFX0DW5tdTNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ODDZJX6faefd3ZMlCma75vd8YuzK2IBEBbPsiJiErLHTIqhie1EY2gjtENuJKNO/w
	 AMOHu7huK5i/b6Oi8231Od5OxJaNiwVEdhjCNkn/aeo/brPfPda17gDL3nwRi0/XA7
	 spU8wPqzcFohQ5JtVHvjrc0eZrtkTTOxzgoCQrKJw5cwamIFEuWMUpze/rn/m2ggE3
	 MSkXnJV2MSOhn0JfcRhNK7hYbKQLaAm+7JS7w2j7/9Aw7nmzjV5kNyuzLQpV3Bnrxc
	 JTSwNhc/2cKbqGUyGVZekDUhkAZ6VTRat/Z+t9RqpKtYl9+wYz86QApKYO0aKpnc0J
	 FOZqgawrDYOPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F9BAC4361C;
	Wed, 22 May 2024 22:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] net: netfilter: Make ct zone opts
 configurable for bpf ct helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171641582938.6470.8952877618010663411.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 22:10:29 +0000
References: <20240522050712.732558-1-brad@faucet.nz>
In-Reply-To: <20240522050712.732558-1-brad@faucet.nz>
To: Brad Cowie <brad@faucet.nz>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, lorenzo@kernel.org,
 memxor@gmail.com, pablo@netfilter.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 song@kernel.org, john.fastabend@gmail.com, sdf@google.com, jolsa@kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 22 May 2024 17:07:11 +1200 you wrote:
> Add ct zone id and direction to bpf_ct_opts so that arbitrary ct zones
> can be used for xdp/tc bpf ct helper functions bpf_{xdp,skb}_ct_alloc
> and bpf_{xdp,skb}_ct_lookup.
> 
> Signed-off-by: Brad Cowie <brad@faucet.nz>
> ---
> v2 -> v3:
>   - Remove whitespace changes
>   - Add reserved padding options
>   - If ct_zone_id is set when opts size isn't 16, return -EINVAL
>   - Remove ct_zone_flags
>     (not used by nf_conntrack_alloc or nf_conntrack_find_get)
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] net: netfilter: Make ct zone opts configurable for bpf ct helpers
    https://git.kernel.org/bpf/bpf-next/c/ece4b2969041
  - [bpf-next,v4,2/2] selftests/bpf: Update tests for new ct zone opts for nf_conntrack kfuncs
    https://git.kernel.org/bpf/bpf-next/c/a87f34e742d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



