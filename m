Return-Path: <bpf+bounces-34965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A59F934395
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 23:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8848BB21614
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 21:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA2F2E3EE;
	Wed, 17 Jul 2024 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFYlYEh0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0112E7F;
	Wed, 17 Jul 2024 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250037; cv=none; b=PMLikBN+2ZOooMva1QEPr+qFR7yld0YciNHC75RY8Bi7iXEUgPHtw6P4ANLrsmPBlU3R7DOrBY3E/H0G//lFYApiFf3sXsH1i1TV3OgVQP5acJefhCwGqHXfepg2aZAHtOyts3xkn3HynbNk/L1Pwv0Rj78wsdUs74XBOzNduF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250037; c=relaxed/simple;
	bh=oVUiDNK6x2CJTRP8Yw9QN7dQwwZtrfApPWM9loebxKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tOaHkmYPTS7y0sZsLwFghX7O7Qgz7ShymDHVGNijxLfom5lPw4BODyXrguN8sgl+lBjFTLq/RPR0lcx+DsN7Zc7ZmlT6FekjLr/8w+8rxWEov/NzAe8gH8RTXlbhgWp4k/2UDdVdhCJd8h9Iw33yfsKedq78ot7g/uAcpzs2uwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFYlYEh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BA91C4AF09;
	Wed, 17 Jul 2024 21:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721250037;
	bh=oVUiDNK6x2CJTRP8Yw9QN7dQwwZtrfApPWM9loebxKQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WFYlYEh0wjLXNZg5oo16uMswkwYNi9XJZYwipe4QUd5Gl6ssFL5Rm4OGolXqUTwmF
	 rkrtDQM3wr4oLQc213MYmHhoBdmkyaEJPjzG2i9Q6C39O5RHpc7msLczQMTdtCg0mu
	 GY8FQUdEL4qdo3l0emIACUZV9A10M6k4yOvfiG5aKpQDfW0X1/D/G9y28x3rmnxOu4
	 ggG2FhQwV82WUVrOZIQGGExI+tebjxtEFTW2Ie0mS9TWRleIXi7Ra4KbL1t8glHkae
	 BqlOYCQC+gju7sN7tzA7qqmCQg32pjzHlE4SV34bW/mQS/5QUL54N0eKJs8XHWec2u
	 Y5XVrAjYwSUnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A40FC4333D;
	Wed, 17 Jul 2024 21:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/4] af_unix: MSG_OOB handling fix & selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172125003723.5337.495884946556946756.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jul 2024 21:00:37 +0000
References: <20240713200218.2140950-1-mhal@rbox.co>
In-Reply-To: <20240713200218.2140950-1-mhal@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, kuniyu@amazon.com,
 Rao.Shoaib@oracle.com, cong.wang@bytedance.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 13 Jul 2024 21:41:37 +0200 you wrote:
> PATCH 1/4 tells BPF redirect to silently drop AF_UNIX's MSG_OOB. The rest
> is selftest-related.
> 
> Michal Luczaj (4):
>   af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
>   selftest/bpf: Support SOCK_STREAM in unix_inet_redir_to_connected()
>   selftest/bpf: Parametrize AF_UNIX redir functions to accept send()
>     flags
>   selftest/bpf: Test sockmap redirect for AF_UNIX MSG_OOB
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/4] af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
    https://git.kernel.org/bpf/bpf/c/638f32604385
  - [bpf,v4,2/4] selftest/bpf: Support SOCK_STREAM in unix_inet_redir_to_connected()
    https://git.kernel.org/bpf/bpf/c/1b0ad43177c0
  - [bpf,v4,3/4] selftest/bpf: Parametrize AF_UNIX redir functions to accept send() flags
    https://git.kernel.org/bpf/bpf/c/0befb349c4cd
  - [bpf,v4,4/4] selftest/bpf: Test sockmap redirect for AF_UNIX MSG_OOB
    https://git.kernel.org/bpf/bpf/c/6caf9efaa169

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



