Return-Path: <bpf+bounces-48620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD0EA0A04C
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 03:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C0116B388
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 02:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC4F15098F;
	Sat, 11 Jan 2025 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkAuiUIz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09982940D;
	Sat, 11 Jan 2025 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736562019; cv=none; b=BEjMXIoyXlF/lHlqnFU17hqPEqruynr0FQVluwfETTVAhTlzQR3g0N9HQipuDknADF9FFxAYWCL7It5VcTUMCb2xXF6b/ETtpiaJBLe93OVv+kyULYkr7W1+STZgF5TBCjGwAE4ahWiYIgcFldVARLT8QEFGpY7jQkx7s4zNzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736562019; c=relaxed/simple;
	bh=H6ve1iXrLszFxC3wnybIX43/wolIv08Y06JZuNk0cwM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WzvYHa7HAfvBOR1rwRj6SZWL6lPpohsq4R/dHQiJYeOmlly6MfNFKiwpumGtU1JyQ2rLpAxGGoJMIQ4vS+QosAGPx3zTBRo3RY7TR7rhO8fU2oFxdZr7fBcx88/FJ5KfrBd8dWNFG0RKKUgpMGuqe0cRnrRLhQE33is8GcRhxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkAuiUIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F83C4CED6;
	Sat, 11 Jan 2025 02:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736562016;
	bh=H6ve1iXrLszFxC3wnybIX43/wolIv08Y06JZuNk0cwM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kkAuiUIzPdQZAHWmi4ZtcphSk2d+k2JOMPNG/HkBam69s2Z1JhFOnmn4qQBEI22i8
	 2VptarsVZHdAIJe/O3heet8kgkcyiLTJLroxClW4QhxaH/VHxzjKXc/krSl9hJElGu
	 NG2uGabR+qqfRvLdxWip6/wHgVfdTGn5l0rOIQqZSSoR5dbm8tDFnfAzcMhFJkX30q
	 n8BilV2AUdoSmSDAmOVux1wJ8dGewG03l68k1mdbPUHYEzL63cF11FSXJZNwI3Upxo
	 PDXb2AaP+TeTG0ECyD/jWa5e5tCxSf1wqqucSrsSjFK3MdwVy0lLELJL2ksOdVSb6R
	 tkmd90AqSd0lA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CFF380AA57;
	Sat, 11 Jan 2025 02:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xsk: Bring back busy polling support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173656203824.2269660.1465045234305425925.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jan 2025 02:20:38 +0000
References: <20250109003436.2829560-1-sdf@fomichev.me>
In-Reply-To: <20250109003436.2829560-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, jdamato@fastly.com, mkarsten@uwaterloo.ca

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Jan 2025 16:34:36 -0800 you wrote:
> Commit 86e25f40aa1e ("net: napi: Add napi_config") moved napi->napi_id
> assignment to a later point in time (napi_hash_add_with_id). This breaks
> __xdp_rxq_info_reg which copies napi_id at an earlier time and now
> stores 0 napi_id. It also makes sk_mark_napi_id_once_xdp and
> __sk_mark_napi_id_once useless because they now work against 0 napi_id.
> Since sk_busy_loop requires valid napi_id to busy-poll on, there is no way
> to busy-poll AF_XDP sockets anymore.
> 
> [...]

Here is the summary with links:
  - [net] xsk: Bring back busy polling support
    https://git.kernel.org/netdev/net/c/5ef44b3cb43b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



