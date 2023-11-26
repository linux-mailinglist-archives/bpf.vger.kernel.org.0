Return-Path: <bpf+bounces-15869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1419D7F935C
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 16:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312671C20CC4
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8454D52A;
	Sun, 26 Nov 2023 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRHx5dvY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10100D26A;
	Sun, 26 Nov 2023 15:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CCFEC433CC;
	Sun, 26 Nov 2023 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701012025;
	bh=92hW5enAmOBKxY4vzxSmi3alznCV1aHasRQ+6W1CiYY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JRHx5dvYZYCmlLQBdLmO9pAj+9FHLi0LhQumCYCtQE0zaQf5ywbN0e+L7Bvrfc8pP
	 18GMn/JBow8FqxcBgjjGFH44zd5RSoRym4eWJEOTRS0rWUzZ0V+XcqTgaBYQcGdnKc
	 ljmJ0y2jBBwQxGvJ9kYMzGn7G1RYleYwERj2ZjhlebAU7tFFKWCvCK4uVsIsYOxXxI
	 v6ELNP5sQzDkdHhUrVw4gU8Y8S3Ufm/xoNLGntLTCfg9zXnIOmeRnN+I9E7LTOPVy2
	 SZgASCFibiLOXSm+GqLMLvJCvCHVHSXBQcEzo/bjfDs3BfAEfc5qE5K6kasR2s0rTe
	 ephr8grqU4QfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A73EC39562;
	Sun, 26 Nov 2023 15:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mm/page_pool: catch page_pool memory leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170101202556.2351.9731751321598377957.git-patchwork-notify@kernel.org>
Date: Sun, 26 Nov 2023 15:20:25 +0000
References: <170082101266.1085481.12199867179160710331.stgit@firesoul>
In-Reply-To: <170082101266.1085481.12199867179160710331.stgit@firesoul>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, vbabka@suse.cz,
 bpf@vger.kernel.org, eric.dumazet@gmail.com, davem@davemloft.net,
 pabeni@redhat.com, linux-mm@kvack.org, akpm@linux-foundation.org,
 mgorman@techsingularity.net, willy@infradead.org, kernel-team@cloudflare.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 24 Nov 2023 11:16:52 +0100 you wrote:
> Pages belonging to a page_pool (PP) instance must be freed through the
> PP APIs in-order to correctly release any DMA mappings and release
> refcnt on the DMA device when freeing PP instance. When PP release a
> page (page_pool_release_page) the page->pp_magic value is cleared.
> 
> This patch detect a leaked PP page in free_page_is_bad() via
> unexpected state of page->pp_magic value being PP_SIGNATURE.
> 
> [...]

Here is the summary with links:
  - [net-next] mm/page_pool: catch page_pool memory leaks
    https://git.kernel.org/netdev/net-next/c/dba1b8a7ab68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



