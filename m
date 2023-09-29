Return-Path: <bpf+bounces-11114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2997B366A
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 17:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7419D2893C6
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3878E51B8C;
	Fri, 29 Sep 2023 15:10:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ECC516DD;
	Fri, 29 Sep 2023 15:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4556EC433C7;
	Fri, 29 Sep 2023 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696000225;
	bh=4s6pZNTu86n08B07OdcxvpvsjdhquUXjcR9cGw/6xp0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O4tEsghcEDUDzQQcHBHDqHeSNPZszCNyYzmrEKWap9cdr/cHIRam9V+DCkPi1VV68
	 xIlmAVH/eLNZIxtlsOAfthy7QzZSchcTMA67TsS4QOjAFVxfJYPMcv9ne4ozCsatOb
	 Zn82nc3xdXv2shb97o4eV1YIDCAZ1Og2bPZX3mf0dXeXzGhgNOWiYwEa5UIAPjD9ns
	 90Oc77LdwfjF8U10Ob/HAFDSSEsIGCxLLvYE2guz9C9v4oD9/N8XvkD5jYe2HNgoIG
	 Bf7H8H3Zjtf3zkul8boinqGzNaLiK3gae2IkW461y964nOsEn4on6DVqOMPUsZMfHq
	 bSkm89F1GuBHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A513C395C8;
	Fri, 29 Sep 2023 15:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/3] bpf, sockmap complete fixes for avail bytes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169600022516.19901.13842388039808496869.git-patchwork-notify@kernel.org>
Date: Fri, 29 Sep 2023 15:10:25 +0000
References: <20230926035300.135096-1-john.fastabend@gmail.com>
In-Reply-To: <20230926035300.135096-1-john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 jakub@cloudflare.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 edumazet@google.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 25 Sep 2023 20:52:57 -0700 you wrote:
> With e5c6de5fa0258 ("bpf, sockmap: Incorrectly handling copied_seq") we
> started fixing the available bytes accounting by moving copied_seq to
> where the user actually reads the bytes.
> 
> However we missed handling MSG_PEEK correctly and we need to ensure
> that we don't kfree_skb() a skb off the receive_queue when the
> copied_seq number is not incremented by user reads for some time.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/3] bpf: tcp_read_skb needs to pop skb regardless of seq
    https://git.kernel.org/bpf/bpf/c/9b7177b1df64
  - [bpf,v3,2/3] bpf: sockmap, do not inc copied_seq when PEEK flag set
    https://git.kernel.org/bpf/bpf/c/da9e915eaf5d
  - [bpf,v3,3/3] bpf: sockmap, add tests for MSG_F_PEEK
    https://git.kernel.org/bpf/bpf/c/5f405c0c0c46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



