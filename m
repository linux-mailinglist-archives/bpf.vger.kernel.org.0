Return-Path: <bpf+bounces-20632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAD084153D
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 22:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1741F248B9
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 21:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EC1158D98;
	Mon, 29 Jan 2024 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWT7YImm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68737153BC1;
	Mon, 29 Jan 2024 21:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565026; cv=none; b=aWAbToRpX0LRy3r28jnO7bwgdM4VR5uWhJdQ6Cfyp6gWIngdJ9kS5d2GL41xY+OeNbDRu1o4DaPdmtzc6k/NSmoMtcWc4s9Y9e7IOz/Ki64Gx8GkEUvCMD2en+awSZ0m0CMnKYQFgSmWCV9nusm8Ips3diNZc1UIWIDOpGRv/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565026; c=relaxed/simple;
	bh=GJWqx6iyAPggZbXpVK3nWybrI8cF4s14q20jKPbfdPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZS2kbBmtDP6qvWbFhUfVV3Jh+G+bnJoB5zzFsylwFpI4Q94b4vG2yTUPq/s8hDWd9wibE1HKoN62qMP8X9HYDhswCPe55LJsYigJN7mSs2HT0DBvVzrQjDl8hrTJ2TjTOQcGKDBu0horBepatFA1cRVb7sm4KVryxZcy4DUgvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWT7YImm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3CB2C433C7;
	Mon, 29 Jan 2024 21:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706565025;
	bh=GJWqx6iyAPggZbXpVK3nWybrI8cF4s14q20jKPbfdPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AWT7YImmOe0kZXdsMEIoW+ItO8EWUxVQ2IWqasHMHfISS+ryshZNa1pWpuedDEbF2
	 Hg+4EX3Uhcs6SfoQ7TjWFHEDOC9MgG+zWpyijSHReziHKXMBQcf7RHGKtOwjHHSy24
	 onlDfAJukQIRaiZUATnIbCuf2MsV1MnuQfz63oEPQrdIEqjTmM946lzFTAwCCje+68
	 ZK4YR+/LXFpdnwjUJjLlAFS2T8dp1xTM9O8JDvUvTQdopKW3JtYlatM1RfGQXNWFK7
	 bvI5hguItzw7nFl8jy24AUm6VfDSrUVU4ghNyXy/PEyo4+A3Vum1syWV1iFk49Y6ZX
	 +T1lIS1ZH2MqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A973CC00448;
	Mon, 29 Jan 2024 21:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] perf/bpf: Fix duplicate type check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170656502568.11476.930525064249371224.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 21:50:25 +0000
References: <20240120150920.3370-1-dev@der-flo.net>
In-Reply-To: <20240120150920.3370-1-dev@der-flo.net>
To: Florian Lehner <dev@der-flo.net>
Cc: bpf@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 20 Jan 2024 16:09:20 +0100 you wrote:
> Remove the duplicate check on type and unify result.
> 
> Signed-off-by: Florian Lehner <dev@der-flo.net>
> ---
>  kernel/events/core.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Here is the summary with links:
  - [bpf-next] perf/bpf: Fix duplicate type check
    https://git.kernel.org/bpf/bpf-next/c/aecaa3ed48c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



