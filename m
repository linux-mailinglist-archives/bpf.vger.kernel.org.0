Return-Path: <bpf+bounces-21947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40618541E0
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 04:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA7B289BFB
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 03:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94878BA26;
	Wed, 14 Feb 2024 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng2YAI9G"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1828FB654;
	Wed, 14 Feb 2024 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707882628; cv=none; b=VYXknBzt7pc5YjzB2b/aTSl5XUH7IIDkzO8Rujjl/PYmbVQVrNFAr4Z3O924xMwoCL/6V2MyUkKJOe+auOFqt+thM8UcBo2mTz1BbpS2ee/tDELQsL0EwGu4lHrwjxQh1S3DkEJYKDpx9TodloBVoF5ZKy3G98mcF+JViogjTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707882628; c=relaxed/simple;
	bh=dShcAkyRVJAPOldc7NoYbsAxM3ELOfgVFcnlSWLHLj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QLRfeuXbVyrEguW8b7SsMep83JO47M1YuBgmBOp4S8r/Rn9DpyKZdy3RKD11xtmJHDr59yq/gHEHYCAt8R8+k0zjyGrZfpFd8hhPjvN5DiZRwQLtXGF/sEtUW90Luzq85uyKs8D2T7h5u/GEAOzgHyCr9mD1q6EEhDj5b4z7DSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng2YAI9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 923FEC433C7;
	Wed, 14 Feb 2024 03:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707882627;
	bh=dShcAkyRVJAPOldc7NoYbsAxM3ELOfgVFcnlSWLHLj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ng2YAI9G54Xa67OQFibOPlJZyDDBGv8clL2psWX+vOQnhzeqbxVGcLI4ibVblt9Kh
	 Gx7REWYoDzTWAMfF0HE78K+iaienNY5JgK33s9r5Pr+r0+pR48cSbhAhEdukRIgFdv
	 9UIHybbXktBqfKWhaaBqxXkXwzhBSoXW73hvB6F8MAyWeRPzm1lcZt9Mptp/sqF2i8
	 Q0jZwsPQbsj5eamqq7f8WEi2vVgT6dyPNvUNtPSwgj7frcfARY/lJjipzdjRpr07mk
	 GmP4EFLIchBQp+84QQaIl39ZnuPKbyNob7VXITHFvWRO57uKImPCApA98YG+zJskPp
	 ANjceqSBMQvFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FC13C1614E;
	Wed, 14 Feb 2024 03:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 net-next 0/4] add multi-buff support for xdp running in
 generic mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170788262745.8040.11014790879763192911.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 03:50:27 +0000
References: <cover.1707729884.git.lorenzo@kernel.org>
In-Reply-To: <cover.1707729884.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bpf@vger.kernel.org, toke@redhat.com, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, sdf@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, linyunsheng@huawei.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Feb 2024 10:50:53 +0100 you wrote:
> Introduce multi-buffer support for xdp running in generic mode not always
> linearizing the skb in netif_receive_generic_xdp routine.
> Introduce generic percpu page_pools allocator.
> 
> Changes since v8:
> - fix veth regression introduce in veth.sh selftest
> Changes since v7:
> - fix sparse warnings
> Changes since v6:
> - remove patch 4/5 'net: page_pool: make stats available just for global pools'
> - rename netif_skb_segment_for_xdp() in
>   skb_cow_data_for_xdp()/skb_pp_cow_data()
> - rename net_page_pool_alloc() in net_page_pool_create()
> - rename page_pool percpu pointer in system_page_pool
> - set percpu page_pool memory size
> Changes since v5:
> - move percpu page_pool pointer out of softnet_data in a dedicated variable
> - make page_pool stats available just for global pools
> - rely on netif_skb_segment_for_xdp utility routine in veth driver
> Changes since v4:
> - fix compilation error if page_pools are not enabled
> Changes since v3:
> - introduce page_pool in softnet_data structure
> - rely on page_pools for xdp_generic code
> Changes since v2:
> - rely on napi_alloc_frag() and napi_build_skb() to build the new skb
> Changes since v1:
> - explicitly keep the skb segmented in netif_skb_check_for_generic_xdp() and
>   do not rely on pskb_expand_head()
> 
> [...]

Here is the summary with links:
  - [v9,net-next,1/4] net: add generic percpu page_pool allocator
    https://git.kernel.org/netdev/net-next/c/2b0cfa6e4956
  - [v9,net-next,2/4] xdp: rely on skb pointer reference in do_xdp_generic and netif_receive_generic_xdp
    https://git.kernel.org/netdev/net-next/c/4d2bb0bfe874
  - [v9,net-next,3/4] xdp: add multi-buff support for xdp running in generic mode
    https://git.kernel.org/netdev/net-next/c/e6d5dbdd20aa
  - [v9,net-next,4/4] veth: rely on skb_pp_cow_data utility routine
    https://git.kernel.org/netdev/net-next/c/27accb3cc08a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



