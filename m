Return-Path: <bpf+bounces-39654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AD8975BC5
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 22:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA1B287D38
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 20:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD521BB684;
	Wed, 11 Sep 2024 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPTyhD/o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB76149C7D;
	Wed, 11 Sep 2024 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086634; cv=none; b=h7RDqqGq5u2ytlXAjKQJLdpadBtzhKqT5d/caKJWIj7iSeBu6lDXW9vMknsA0a5NmNXp/3AqzfKtgEKT+23FPUr+5dXn4yjl+vAnaC01r5NA3cWvQ10OOGZwOT+2ij2fw1ZuLSpw9eQcJl0J4Rrg44ciFBf7wLVbkWWnh2zRSKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086634; c=relaxed/simple;
	bh=cd9B3CJ7RITvKXV5XucMYw0PCZE9UfOa701bR2XG7Eo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H+4HfrjMxHUjIvOg1dJplZlr5/29LqFXUfKmmR/WwZbAte+hcKt8/mYnIIBuzZzXzibreU3gS7EsMmcdk3WuIUwRR7VjnuH6woO14KyTeFTfr3sExaWu0JDbtD7PKd88wkSrjW1AVqJOBOIpXvbcj78CM5isuYVb2FIjZkV7A/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPTyhD/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F90C4CEC0;
	Wed, 11 Sep 2024 20:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726086633;
	bh=cd9B3CJ7RITvKXV5XucMYw0PCZE9UfOa701bR2XG7Eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OPTyhD/oUJEePiOW04v7g+I0p4Hf187/bLse9970iBnE7ZIPJKraWvuVPhvPjXZtC
	 wKcjgAyFr1Hs1RK3/cJbTup/TU3Pme8QU0V2IWxlxmlAGfjchzfODnqouBBs9zGhZb
	 cVYZRarshBImviVhct6Pwe2XN4fRtpOOk2lo/qULhcUC+EgJzAEmq2i+zFBB4Gwy5A
	 gPoiO9IET4TRDdf6pvJKc7JjzQw6XavuwWYp7HqdC+rS6PtGC8Xe8VfwUfvwCxrgUq
	 9j95U3rvk30bcD/+jM2+SPJufzGyyr9zQ5Kni24yZP2xuA7zBW3u6PJXmeujaBdg9c
	 vZFKH3q3Lmb3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340983806656;
	Wed, 11 Sep 2024 20:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] sock_map: add a cond_resched() in sock_hash_free()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172608663475.1037972.14564220776253114097.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 20:30:34 +0000
References: <20240906154449.3742932-1-edumazet@google.com>
In-Reply-To: <20240906154449.3742932-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 daniel@iogearbox.net, ast@kernel.org, martin.lau@linux.dev,
 andrii@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 eric.dumazet@gmail.com, syzkaller@googlegroups.com, john.fastabend@gmail.com,
 jakub@cloudflare.com

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  6 Sep 2024 15:44:49 +0000 you wrote:
> Several syzbot soft lockup reports all have in common sock_hash_free()
> 
> If a map with a large number of buckets is destroyed, we need to yield
> the cpu when needed.
> 
> Fixes: 75e68e5bf2c7 ("bpf, sockhash: Synchronize delete from bucket list on map free")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> 
> [...]

Here is the summary with links:
  - [bpf] sock_map: add a cond_resched() in sock_hash_free()
    https://git.kernel.org/bpf/bpf-next/c/b1339be951ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



