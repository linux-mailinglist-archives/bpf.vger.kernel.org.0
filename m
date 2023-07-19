Return-Path: <bpf+bounces-5208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE31758A27
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092312817E4
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F31415D1;
	Wed, 19 Jul 2023 00:40:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9932B17CF;
	Wed, 19 Jul 2023 00:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C301C433C9;
	Wed, 19 Jul 2023 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689727220;
	bh=tWSMgQ/gM0MSvSR6CF08U4kX6kE7RQUSC7xwIjPKAjM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LRt0uMwE94IYaNeeybciQXErmjJUFaZqicljAOsRrVatgyArfzK70NWJWxValQTUk
	 bI3lWf7cI8o0qzYRboq8xyqgdXaGZ8ybsJ7N8QusSpArG5bvIOH2l/8mgbWur8v5tN
	 Qmv1X9WWRC5+XSobGI+iCwUIvsA97DKAzVYCqBzL9nymY2njqnjTCLmts3416ZyAfD
	 uNGS+Oy24lAuSxCuJeKET3OdGp14vlIRa3+MvTa0dCK1+fzNaVYsJOYxoQa0eDSvnC
	 nPTEymHSz4xxXAaY0Iw+6QL0CMitt8G/i437kC+UnK+SN1nA2pHrwaICn7PU50BsYz
	 Fr8b8pEyBlyYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E52FEE22AE0;
	Wed, 19 Jul 2023 00:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Drop useless btf_vmlinux in bpf_tcp_ca
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168972721993.11490.15796244638471526818.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 00:40:19 +0000
References: <4d38da4eadaba476bd92ffcd7a5a03a5e28745c0.1689582557.git.geliang.tang@suse.com>
In-Reply-To: <4d38da4eadaba476bd92ffcd7a5a03a5e28745c0.1689582557.git.geliang.tang@suse.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 17 Jul 2023 16:32:52 +0800 you wrote:
> The code using btf_vmlinux in bpf_tcp_ca is removed by the commit
> '9f0265e921de ("bpf: Require only one of cong_avoid() and cong_control()
> from a TCP CC")', so drop this useless btf_vmlinux declaration.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/ipv4/bpf_tcp_ca.c | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf: Drop useless btf_vmlinux in bpf_tcp_ca
    https://git.kernel.org/bpf/bpf-next/c/8daf847714ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



