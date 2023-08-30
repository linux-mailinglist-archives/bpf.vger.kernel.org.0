Return-Path: <bpf+bounces-8968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5DC78D374
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 09:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BA9281396
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 07:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4571867;
	Wed, 30 Aug 2023 07:00:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A515CD;
	Wed, 30 Aug 2023 07:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00EFDC433CA;
	Wed, 30 Aug 2023 07:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693378823;
	bh=K+yHclkJRYVwL3Qor70OqtjoRDI+Hb6plXkkaJZMjE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qKUGOqJZjx29JUxFKWp+IDLYNGkz2V+DSfPU4G+fjvq42A0ZDsFyRd5PGAGaPql00
	 gx1Q4wjlNULyuYlmeRRDjfuk/5zq6tSgNpU3pRIApBJ+gkbAUVlwojxYeNwrEyspaa
	 pXY0pqcvs8PN5C49PVHeTxfxqtZuavk0JZn6VE58Q+RyTVfKmpNAgzN68UEA4ZCBYF
	 tdY6BK+j5D267LXyxmusPZW3G5PCpx15hjRHZrRkWR0Ow4UfYhy31K4WSxfE4Rl755
	 EgMPRXViQcyZ/hoZV1osieGcRusLDVMIAHsVyCSbneslehd+NH82gduZiFfYR+ZYnn
	 SrWCFRwimWFNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9174C595CB;
	Wed, 30 Aug 2023 07:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] xsk: fix xsk_build_skb() error: 'skb'
 dereferencing possible ERR_PTR()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169337882288.5288.1744884567177889910.git-patchwork-notify@kernel.org>
Date: Wed, 30 Aug 2023 07:00:22 +0000
References: <20230823144713.2231808-1-tirthendu.sarkar@intel.com>
In-Reply-To: <20230823144713.2231808-1-tirthendu.sarkar@intel.com>
To: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, dan.carpenter@linaro.org, sdf@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 23 Aug 2023 20:17:13 +0530 you wrote:
> Currently, xsk_build_skb() is a function that builds skb in two possible
> ways and then is ended with common error handling.
> 
> We can distinguish four possible error paths and handling in xsk_build_skb():
>  1. sock_alloc_send_skb fails: Retry (skb is NULL).
>  2. skb_store_bits fails : Free skb and retry.
>  3. MAX_SKB_FRAGS exceeded: Free skb, cleanup and drop packet.
>  4. alloc_page fails for frag: Retry page allocation w/o freeing skb
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] xsk: fix xsk_build_skb() error: 'skb' dereferencing possible ERR_PTR()
    https://git.kernel.org/bpf/bpf/c/9d0a67b9d42c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



