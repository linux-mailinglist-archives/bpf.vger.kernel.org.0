Return-Path: <bpf+bounces-17763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4048124A6
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA30CB2118A
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4C9802;
	Thu, 14 Dec 2023 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw3ATMqC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378563D;
	Thu, 14 Dec 2023 01:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E170C433C9;
	Thu, 14 Dec 2023 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702518025;
	bh=Rpw99G+Bd16Fbf4PTlRaG5ns6MLevepNoS8vLtGnQMg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bw3ATMqCzEIccVPAcn8dAhMbY6yI4i9uSj4UDx0PuiTjuw15u8KDPqMn27vdqsRM5
	 rTe/2HeVHyR0oh62kMfjrMfyM7uLGwjIyxvcFZTUVsKz3Rk6chQkC3B/9GSGRpOnsq
	 sOiM32kbnPRibisw+W0UZ47IXiDqbda47OxyusrH2bBQJV7t+X0uWiBXeI6PfPd8Vz
	 LzuHyu9Ynd7jTu1oRKzUc/fEF3MDWvOJYEnlJWOErQOP5r9fRVThmCjjxy+lcfNcaz
	 VunhgjqbhXuKxTfVaZjaU6+lw2YUQqx8TsX2i5t2R9VunEucYkAw/fiiyY4PQg3toT
	 4AG0osduzto6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43CB2DD4EF0;
	Thu, 14 Dec 2023 01:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2]  bpf fix for unconnect af_unix socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170251802527.4404.9577873656919386450.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 01:40:25 +0000
References: <20231201180139.328529-1-john.fastabend@gmail.com>
In-Reply-To: <20231201180139.328529-1-john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: martin.lau@kernel.org, edumazet@google.com, jakub@cloudflare.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri,  1 Dec 2023 10:01:37 -0800 you wrote:
> Eric reported a syzbot splat from a null ptr deref from recent fix to
> resolve a use-after-free with af-unix stream sockets and BPF sockmap
> usage.
> 
> The issue is I missed is we allow unconnected af_unix STREAM sockets to
> be added to the sockmap. Fix this by blocking unconnected sockets.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: syzkaller found null ptr deref in unix_bpf proto add
    https://git.kernel.org/bpf/bpf/c/8d6650646ce4
  - [bpf,v2,2/2] bpf: sockmap, test for unconnected af_unix sock
    https://git.kernel.org/bpf/bpf/c/50d96f05af67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



